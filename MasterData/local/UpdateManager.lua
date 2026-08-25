local UIUpdate = require("UI.UIUpdate")
local UIMsgPopup = require("UI.UIMsgPopup")
local GameUpdateConstant = require("Constant.GameUpdateConstant")
local Language = require("Lang.Language")
local UpdateUtils = require("UpdateUtils")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local ApusUpdateComp = require("ApusUpdateComp")
local Apus_Event_Name = "[enter_game_step][update] {step}"
local UnityTime = CS.UnityEngine.Time
local AutoRetryTime = 2
local NotReachable = CS.UnityEngine.NetworkReachability.NotReachable
local ReachableViaCarrierDataNetwork = CS.UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork
local DownLoadSizeKey = "z1j_DownloadSize_%s"
local DownloadHelper = CS.ResourceManager.DownloadHelper
local DivPackageType = CS.ResourceManager.DivPackageType
local Input = CS.UnityEngine.Input
local KC_Escape = CS.UnityEngine.KeyCode.Escape
local Application = CS.UnityEngine.Application
local RP_Android = CS.UnityEngine.RuntimePlatform.Android
local RP_WindowsEditor = CS.UnityEngine.RuntimePlatform.WindowsEditor
local RP_WindowsPlayer = CS.UnityEngine.RuntimePlatform.WindowsPlayer
local E, EF, RTM, WLU
local VersionTools = CS.ResourceManager.VersionTools
local GameUpdater = CS.Z1ClientUpdater.GameUpdater
local CSScreen = CS.UnityEngine.Screen
local Timeout = 5
local FRAMETICK = 20
local TAG = "UpdateManager"
local MyPrintSwitch = CS.FrameWork.Z1Const.IsDebugMode() or UpdateUtils.__GetIsDebugModeFromDebugFile()

function MyPrint(...)
  if MyPrintSwitch then
    print(TAG, " == ", ...)
  end
end

local UpdateManager = {}
UpdateManager.MyPrint = MyPrint
UpdateManager.Apus_Event_Name = Apus_Event_Name
UpdateManager.HotUpdateStepName = HotUpdateStepName

function UpdateManager:OnInit()
  MyPrint("OnInit")
  CS.UnityEngine.Application.runInBackground = true
  CS.UnityEngine.Application.targetFrameRate = 24
  CS.UnityEngine.QualitySettings.vSyncCount = 0
  self._curScreenWidth = CSScreen.width
  self._curScreenHeight = CSScreen.height
  self._isFullScreen = CSScreen.fullScreen
  self.updateUI = UIUpdate
  CS.TMPSpriteAssetsMgr.Init("UI/SpriteAssets/")
  CS.TMPFontAssetsMgr.Init("UI/UI_Font/", "UX_Text_FZBeiWeiKaiShu")
  pcall(self.updateUI.Create, self.updateUI, self.OnRepairBtnClick)
  self._retryTimes = 0
  self.triggerEnterGame = nil
  self.enterGameFlag = nil
  self._lastReqUpdateTime = UnityTime.realtimeSinceStartup
  self.EjoySdk = nil
  MyPrint("skipUpdate", self:skipUpdate())
  if self:skipUpdate() then
    self.triggerEnterGame = FRAMETICK
    UpdateManager.updateUI:SetCaptureFlagImg(true)
    self.hasInit = true
  else
    self.hasInit = false
  end
  local ret, pcode = pcall(UpdateManager.GetProductCode)
  self.productCode = ret and pcode or ""
  if not string.find(self.productCode, "^[P|p]") then
    local isDebugMode = CS.FrameWork.Z1Const.IsDebugMode() or UpdateUtils.__GetIsDebugModeFromDebugFile()
    local publishRegion = CS.FrameWork.Z1Const.GetPublishRegion()
    local modeAffix = isDebugMode and "debug" or "release"
    local key = string.format("QzPlatformCode_%s_%s", publishRegion, modeAffix)
    local code = GameUpdateConstant[key]
    MyPrint("isDebugMode:", isDebugMode, "publishRegion:", publishRegion, "modeAffix:", modeAffix, "key:", key, "code:", code)
    self.productCode = code
    MyPrint("self.productCode:", self.productCode)
  end
end

function UpdateManager.GetProductCode()
  if Application.platform == RP_WindowsEditor then
    local editorCode = CS.FrameWork.Z1Const.GetEditorQzPlatformCode and CS.FrameWork.Z1Const.GetEditorQzPlatformCode() or nil
    if editorCode and #editorCode > 0 then
      return editorCode
    end
  end
  local productCode = CS.FrameWork.Z1Const.GetQzPlatformCode and CS.FrameWork.Z1Const.GetQzPlatformCode()
  local debugQzPlatformCode = UpdateUtils.__GetQzPlatformCodeFromDebugFile()
  print("[test] debugQzPlatformCode :", debugQzPlatformCode)
  if debugQzPlatformCode and "" ~= debugQzPlatformCode then
    productCode = debugQzPlatformCode
  end
  return productCode
end

function UpdateManager:skipUpdate()
  return not CS.Framework.AssetLoadUtil.HasABManifest() or CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsEditor
end

function UpdateManager:SetupSDK()
  MyPrint("SetupSDK")
  E = require("ejoysdk_lua.ejoysdk")
  EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
  RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
  local ejoysdk_init = require("ejoysdk_lua.ejoysdk_init")
  ejoysdk_init.config(self.productCode)
  local isDebugMode = CS.FrameWork.Z1Const.IsDebugMode() or UpdateUtils.__GetIsDebugModeFromDebugFile()
  E.open_log(isDebugMode)
  self.EjoySdk = E
  UIUpdate:SetUidOrUtdid()
  local cutout = E.Sysinfo.cutout()
  UpdateUtils.ResolutionAdaption(cutout)
  local using_build_type, using_res_version, package_newer_version, app_res_version = UpdateManager.GetLocalResVersion()
  self.old_version = using_res_version
  self.inapp_version = app_res_version
  self.package_newer_version = package_newer_version
  local init_params = {
    product_code = self.productCode,
    local_res_key = using_build_type,
    app_res_ver = self.old_version,
    patch_res_ver = self.package_newer_version
  }
  ApusUpdateComp.Init(init_params)
  self:UploadApusInfo("Init apus", 1)
  if self:CheckClearResTag() then
    UpdateManager.ClearDownloadRes(false)
    self:UploadApusInfo("Check clear res tag", 2)
  end
  MyPrint(TAG, "local_res_key:" .. using_build_type, "old_version:" .. self.old_version, "inapp_version:" .. self.inapp_version, "package_newer_version:" .. self.package_newer_version)
  local _version = self.old_version
  local pkg_res_version = self.inapp_version
  local pkgDivType = CS.FrameWork.Z1Const.GetPackageDivType()
  self:UploadApusInfo("Prepare req params", 3, {
    req_version = _version,
    pkg_res_version = pkg_res_version,
    qz_pcode = self.productCode,
    res_key = using_build_type,
    pkgDivType = pkgDivType
  })
  UpdateManager.local_res_key = using_build_type
  print("[UpdateManager] pkgDivType=", pkgDivType)
  local DownloadStartupGroup = require("Group.DownloadStartupGroup")
  local DownloadGroup = require("Group.DownloadGroup")
  self._updateGroups = {}
  table.insert(self._updateGroups, DownloadStartupGroup())
  local groupDownloadName = "Download"
  if pkgDivType == DivPackageType.AAB or pkgDivType == DivPackageType.Normal or pkgDivType == DivPackageType.Predownload then
    table.insert(self._updateGroups, DownloadGroup(groupDownloadName, true, 1, 1))
  elseif pkgDivType == DivPackageType.InGameDownLoad and UpdateManager.IsGroupDownload(groupDownloadName) then
    print("[BootstrapUpdateMgr] InGameDownLoad groupName=", groupDownloadName)
    table.insert(self._updateGroups, DownloadGroup(groupDownloadName, true, 1, 2))
  end
  table.insert(self._updateGroups, DownloadGroup("Scripts", true, 1, 3))
  local Languange = require("Lang.Language")
  local cur_lang = Languange.cur_lang
  if "CN" ~= cur_lang then
    table.insert(self._updateGroups, DownloadGroup("Lang_Text_" .. cur_lang, true, 1, 4))
  end
  if CS.FrameWork.Z1Const.IsDebugMode() or CS.FrameWork.Z1Const.IsOpenGm() then
    table.insert(self._updateGroups, DownloadGroup("Debug", true, 1, 5))
  end
  local groups
  for i = 1, #self._updateGroups do
    if groups then
      groups = groups .. "#" .. self._updateGroups[i]:GetGroupName()
    else
      groups = self._updateGroups[i]:GetGroupName()
    end
  end
  self:UploadApusInfo("Prepare download group", 4, {groups = groups})
  self:RequestDownLoadGroups()
end

function UpdateManager:TriggerCheckTimeout(needCheckTimeout)
  self._lastReqUpdateTime = UnityTime.realtimeSinceStartup
  self._needCheckTimeout = needCheckTimeout
end

function UpdateManager:RequestDownLoadGroups()
  self.totalSuccess = true
  self._waitingNetReachable = false
  self._autoRetryHotUpdate = false
  self._autoRetryTimeCount = 0
  self._redownloadGroups = nil
  self._retryTimes = 0
  self._curReqGroupIndex = 1
  self._curConfirmGroupIndex = 1
  self._isComfirmUpdated = false
  self:TriggerCheckTimeout(true)
  if self:IsNetReachable() then
    self._updateGroups[1]:RequestDownLoadGroup()
  else
    self:UploadApusInfo("Waiting Network", 5)
    self._waitingNetReachable = true
  end
end

function UpdateManager.IsGroupDownload(group)
  local groupFiles = "DownloadGroup_" .. group
  local path = DownloadHelper.GetDownloadPathDefault() .. "/" .. groupFiles
  do return CS.Framework.AssetLoadUtil.IsFileExist end
  return CS.Framework.AssetLoadUtil.IsFileExist, path
end

function UpdateManager.SetGroupDownload(group)
  local groupFiles = "DownloadGroup_" .. group
  local path = DownloadHelper.GetDownloadPathDefault() .. "/" .. groupFiles
  CS.Framework.AssetLoadUtil.WriteFile("1", path)
end

function UpdateManager:SaveDownLoadSize(groupName, size)
  local key = string.format(DownLoadSizeKey, groupName)
  CS.UnityEngine.PlayerPrefs.SetString(key, tostring(size or 0))
  CS.UnityEngine.PlayerPrefs.Save()
end

function UpdateManager:LoadDownLoadSize(groupName)
  local key = string.format(DownLoadSizeKey, groupName)
  local sizeStr = CS.UnityEngine.PlayerPrefs.GetString(key, "0")
  return tonumber(sizeStr) or 0
end

function UpdateManager:OnUpdate()
  if not self.hasInit then
    GameUpdater.InitSdk()
    self:SetupSDK()
    self.hasInit = true
  elseif self.EjoySdk then
    self.EjoySdk.tick()
  end
  if self._waitingNetReachable and self:IsNetReachable() then
    self._waitingNetReachable = false
    self:RequestDownLoadGroups()
  end
  if self._updateGroups then
    for i = 1, #self._updateGroups do
      self._updateGroups[i]:Update()
    end
  end
  self:_TryAutoRetryDownload()
  if self.triggerEnterGame then
    if self.triggerEnterGame == FRAMETICK / 2 then
      UpdateManager.updateUI:CaptureScreen()
    end
    if self.triggerEnterGame > 0 then
      self.triggerEnterGame = self.triggerEnterGame - 1
    end
    if self.triggerEnterGame <= 0 then
      self.triggerEnterGame = nil
      print("aaa EnterGameMain   ")
      self:UploadApusInfo("Ready to enter game", 30)
      UpdateManager:EnterGameMain()
    end
  end
  if self.enterGameFlag then
    if self.enterGameFlag > 0 then
      self.enterGameFlag = self.enterGameFlag - 1
    end
    if self.enterGameFlag <= 0 and not CS.WwiseManager.WwiseManager.Exists then
      self.enterGameFlag = nil
      local Languange = require("Lang.Language")
      CS.Z1Client.LuaBehaviour.CurLang = Languange.cur_lang
      GameUpdater.EnterGame(self:HasPatchDownload())
    end
  end
  if self.updateUI then
    pcall(self.updateUI.OnUIUpdate, self.updateUI)
  end
  if UIMsgPopup and UIMsgPopup:HasShown() then
    pcall(UIMsgPopup.OnUpdate, UIMsgPopup)
  else
    local supportGoBack = Application.platform == RP_Android or Application.platform == RP_WindowsEditor
    if supportGoBack and Input.GetKeyDown(KC_Escape) then
      UIMsgPopup:Show("ExitGameTips", nil, UpdateUtils.ExitGame, "确认", function()
        UIMsgPopup:Hide()
      end, "取消")
      return
    end
  end
  self:CheckResolutionChanged()
  self:_CheckRequestTimeout()
end

function UpdateManager:_CheckRequestTimeout()
  if not self._needCheckTimeout then
    return
  end
  if UnityTime.realtimeSinceStartup - self._lastReqUpdateTime >= Timeout then
    self._needCheckTimeout = false
    UIMsgPopup:Show("网络繁忙，请稍后重试", nil, function()
      if not self._isComfirmUpdated then
        self:RequestDownLoadGroups()
      end
    end, "重试")
  end
end

function UpdateManager:OnDestroy()
end

function UpdateManager.OnRepairBtnClick(msg)
  MyPrint("UpdateManager.OnRepairBtnClick")
  msg = msg or "是否尝试修复游戏客户端"
  UIMsgPopup:Show(msg, nil, UpdateManager.ClearDownloadRes, "确认", function()
    UIMsgPopup:Hide()
  end, "取消")
end

function UpdateManager.CheckClearResTag()
  local data = UpdateUtils.ReadJsonCache("GameTags")
  return data and data.clearResTag
end

function UpdateManager.SetClearResTag(needClearRes)
  if nil == needClearRes then
    needClearRes = false
  end
  local data = UpdateUtils.ReadJsonCache("GameTags")
  local cache = data and data.clearResTag == true
  if cache == needClearRes then
    return
  end
  data = data or {}
  data.clearResTag = needClearRes
  local cacheText = JSON.encode(data)
  UpdateUtils.WriteCache("GameTags", cacheText)
end

function UpdateManager.ClearDownloadRes(needRestart)
  if nil == needRestart then
    needRestart = true
  end
  UpdateManager:_ClearDownloadSize()
  UpdateManager:UploadApusInfo("Starup clear download res", 50, {need_restart = needRestart})
  UpdateManager.SetClearResTag(true)
  if EF then
    EF.repair(UpdateManager.local_res_key)
  end
  CS.ResourceManager.Runtime.ResourceUpdateHelper.ClearDownloadingDir()
  MyPrint("UpdateManager.ClearDownloadRes, repair")
  UpdateManager.SetClearResTag(false)
  UpdateManager:UploadApusInfo("Finish clear download res", 51, {need_restart = needRestart})
  if needRestart then
    CS.Z1Client.LuaCSharpUtil.QuitApplication()
  end
end

function UpdateManager:_ClearDownloadSize()
  if UpdateManager.IsGroupDownload("default") then
    UpdateManager:SaveDownLoadSize("default", 0)
  end
  if UpdateManager.IsGroupDownload("Download") then
    UpdateManager:SaveDownLoadSize("Download", 0)
  end
  if UpdateManager.IsGroupDownload("Scripts") then
    UpdateManager:SaveDownLoadSize("Scripts", 0)
  end
  for i = 1, #UpdateUtils.LangList do
    local groupName = "Lang_Text_" .. UpdateUtils.LangList[i]
    if UpdateManager.IsGroupDownload(groupName) then
      UpdateManager:SaveDownLoadSize(groupName, 0)
    end
  end
end

function UpdateManager:EnterGameMain()
  MyPrint("EnterGameMain")
  self.updateUI:ClearProgressText()
  self.updateUI:SetStatusMsg("正在进入游戏")
  self.updateUI:OnUpdateComplete(100)
  self.enterGameFlag = FRAMETICK
  self.updateUI:Dispose()
  UIMsgPopup:Destroy()
end

function UpdateManager:Reload()
  self:RequestUpdate()
  self.updateUI:Create(self.OnRepairBtnClick)
  MyPrint("UpdateManager:Reload()")
end

function UpdateManager:OnReceiveResUpdateConfirmed(group)
  self._curReqGroupIndex = self._curReqGroupIndex + 1
  if self._curReqGroupIndex <= #self._updateGroups then
    self:TriggerCheckTimeout(true)
    self._updateGroups[self._curReqGroupIndex]:RequestDownLoadGroup()
    return
  end
  if self:HasAllGroupsReceiveResUpdateConfirmed() then
    self:TriggerCheckTimeout(false)
    self._isComfirmUpdated = true
    local hasResUpdate = self:HasPatchDownload()
    local downloadVer = self:GetPatchDownloadVersion()
    local downloadTotalSize = self:GetDownloadTotalSize()
    local remainSize = self:GetDownloadSaveSize()
    local downloadSize = downloadTotalSize
    if remainSize < downloadSize then
      downloadSize = downloadSize - remainSize
    end
    local free_size = self:_GetDiskFreeSize()
    self:UploadApusInfo("On All Groups Update confirm", 5, {
      new_ver = downloadVer,
      has_new_update = hasResUpdate,
      total_size = downloadSize,
      disk_size = free_size or 0
    })
    UpdateManager.updateUI:OnReceiveResUpdate(hasResUpdate, downloadVer, downloadSize)
    if hasResUpdate and downloadTotalSize > 0 then
      for i = 1, #self._updateGroups do
        if self._updateGroups[i]:HasPatchDownload() then
          local size = self._updateGroups[i]:GetDownloadTotalSize()
          if size > 0 then
            self._updateGroups[i]:SetProgressRange(size / downloadTotalSize)
          end
        end
      end
    end
    self:_TryConfirmUpdate(hasResUpdate, downloadSize)
  end
end

function UpdateManager:_TryConfirmUpdate(has_new_update, total_size)
  if has_new_update then
    pcall(self.updateUI.PlayVideo, self.updateUI)
    local publishRegion = CS.FrameWork.Z1Const.GetPublishRegion()
    if "JP" == publishRegion then
      local function confirm_updateFunc(isConfirm)
        if not isConfirm then
          self:ComfirmUpdate(false)
          
          return
        end
        self:_TryWifiNetworkConfirm(total_size)
      end
      
      self:_OnUpdateConfirmDialog(total_size, confirm_updateFunc)
    else
      self:_TryWifiNetworkConfirm(total_size)
    end
  else
    self:ComfirmUpdate(true)
  end
end

function UpdateManager:_GetDiskFreeSize()
  local GetAvailableDiskSpace = CS.Z1Client.LuaCSharpUtil.GetAvailableDiskSpace
  local free_size = GetAvailableDiskSpace and GetAvailableDiskSpace() or -1
  if -1 == free_size then
    local E = require("ejoysdk_lua.ejoysdk")
    local storage_data = E and E.Sysinfo and E.Sysinfo.get_storage_info() or nil
    free_size = storage_data and storage_data.internal_available_storage_size or 0
  end
  return free_size
end

function UpdateManager:_CheckIsDiskFull(total_size)
  local free_size = self:_GetDiskFreeSize()
  local needSize = total_size * 2.2
  if free_size and free_size > 0 and free_size < needSize then
    self:UploadApusInfo("On Disk Full", 6, {
      free_size = free_size or 0,
      need_size = needSize
    })
    local tipsText = Language.Textf("StorageSpaceTips", UpdateManager.updateUI.GetSizeFmt(needSize))
    UIMsgPopup:Show(tipsText, nil, function()
      self:UploadApusInfo("On Disk Full Continue", 7)
      self:ComfirmUpdate(true)
    end, "确认", function()
      self:ComfirmUpdate(false)
      self:UploadApusInfo("On Disk Full Exit", 8)
      UpdateUtils.ExitGame()
    end, "取消", "DownloadTipsTitle")
  else
    self:ComfirmUpdate(true)
  end
end

function UpdateManager:_TryWifiNetworkConfirm(total_size)
  if self:IsNetCarrierData() and total_size >= 209715200 then
    local function confirm_updateFunc(isConfirm)
      if isConfirm then
        self:_CheckIsDiskFull(total_size)
      else
        self:ComfirmUpdate(false)
      end
    end
    
    self:_OnNetCarrierData(confirm_updateFunc)
  else
    self:UploadApusInfo("On Net CarrierData Auto Download", 12)
    self:ComfirmUpdate(true)
  end
end

function UpdateManager:OnResDownloadProgressChanged(group)
  self:_UpdateProgrssValue()
end

function UpdateManager:ComfirmUpdate(confirm)
  if not confirm then
    for i = 1, #self._updateGroups do
      self._updateGroups[i]:ConfirmUpdate(false)
    end
    return
  end
  self._isComfirmUpdated = true
  self._curConfirmGroupIndex = 1
  self._updateGroups[self._curConfirmGroupIndex]:ConfirmUpdate(confirm)
end

function UpdateManager:ComfirmNextGroup()
  self._curConfirmGroupIndex = self._curConfirmGroupIndex + 1
  if self._curConfirmGroupIndex <= #self._updateGroups then
    self._updateGroups[self._curConfirmGroupIndex]:ConfirmUpdate(true)
  end
end

function UpdateManager:HasAllGroupsReceiveResUpdateConfirmed()
  for i = 1, #self._updateGroups do
    if not self._updateGroups[i]:HasReceiveResUpdateConfirmed() then
      return false
    end
  end
  return true
end

function UpdateManager:GetPatchDownloadVersion()
  do return self._updateGroups[1].GetPatchDownloadVersion end
  return self._updateGroups[1].GetPatchDownloadVersion, self._updateGroups[1]
end

function UpdateManager:HasPatchDownload()
  if not self._updateGroups then
    return false
  end
  for i = 1, #self._updateGroups do
    if self._updateGroups[i]:HasPatchDownload() then
      return true
    end
  end
  return false
end

function UpdateManager:GetDownloadSize()
  if not self._updateGroups then
    return 0
  end
  local size = 0
  for i = 1, #self._updateGroups do
    if self._updateGroups[i]:HasPatchDownload() then
      size = size + self._updateGroups[i]:GetDownloadSize()
    end
  end
  return size
end

function UpdateManager:GetDownloadTotalSize()
  if not self._updateGroups then
    return 0
  end
  local size = 0
  for i = 1, #self._updateGroups do
    if self._updateGroups[i]:HasPatchDownload() then
      size = size + self._updateGroups[i]:GetDownloadTotalSize()
    end
  end
  return size
end

function UpdateManager:GetDownloadSaveSize()
  if not self._updateGroups then
    return 0
  end
  local size = 0
  for i = 1, #self._updateGroups do
    if self._updateGroups[i]:HasPatchDownload() then
      size = size + self:LoadDownLoadSize(self._updateGroups[i]:GetGroupName())
    end
  end
  return size
end

function UpdateManager:IsHotUpdateCompleted()
  if not self._updateGroups then
    return true
  end
  for i = 1, #self._updateGroups do
    if not self._updateGroups[i]:IsHotUpdateCompleted() then
      return false
    end
  end
  return true
end

function UpdateManager:IsAllGroupDownloadSuccess()
  if not self._updateGroups then
    return true
  end
  for i = 1, #self._updateGroups do
    if not self._updateGroups[i]:IsDownloadSuccess() then
      return false
    end
  end
  return true
end

function UpdateManager:OnGroupHotUpdateFinished(group, ...)
  local groupName = group:GetGroupName()
  MyPrint("[UpdateGroupBase] OnGroupHotUpdateFinished", groupName)
  if "Download" == groupName then
    local groupFiles = "DownloadGroup_Ver_Download"
    local path = DownloadHelper.GetDownloadPathDefault() .. "/" .. groupFiles
    CS.Framework.AssetLoadUtil.WriteFile("0", path)
  end
  self:ComfirmNextGroup()
  if not self:IsHotUpdateCompleted() then
    MyPrint("[UpdateGroupBase] not IsHotUpdateCompleted")
    return
  end
  local totalSuccess = self:IsAllGroupDownloadSuccess()
  if totalSuccess then
    self:TriggerCheckTimeout(false)
    self._autoRetryHotUpdate = false
    MyPrint("[UpdateGroupBase] Hot Update _OnDownloadGroupSuccess")
    self.updateUI:ClearProgressText()
    self.updateUI:SetStatusMsg("正在进入游戏")
    UpdateManager.updateUI:OnUpdateComplete(100)
    UpdateManager.updateUI:SetCaptureFlagImg(true)
    UpdateManager.triggerEnterGame = FRAMETICK
  else
    self:TriggerCheckTimeout(false)
    local err_code, err_msg = ...
    MyPrint("[UpdateGroupBase] Hot Update _OnDownloadGroupFailed", err_code, err_msg)
    self:_OnDownloadGroupFailed(err_code, err_msg)
  end
end

function UpdateManager:_OnDownloadGroupFailed(err_code, err_msg)
  if self._retryTimes < 3 then
    self._retryTimes = self._retryTimes + 1
    MyPrint("[BootstrapDownloadGroup] Hot Update Failed Continue Auto")
    self._autoRetryHotUpdate = true
    self._autoRetryTimeCount = 0
    return
  end
  UIMsgPopup:Show(err_msg, err_code, function()
    self._retryTimes = 0
    self:RequestDownLoadGroups()
  end, "重试", UpdateUtils.ExitGame)
end

function UpdateManager:_TryAutoRetryDownload()
  if self._autoRetryHotUpdate then
    self._autoRetryTimeCount = self._autoRetryTimeCount + UnityTime.deltaTime
    if self._autoRetryTimeCount >= AutoRetryTime and UpdateManager:IsNetReachable() then
      self._autoRetryTimeCount = 0
      self._autoRetryHotUpdate = false
      self:UploadApusInfo("On Auto Retry Download", 20)
      MyPrint("[UpdateGroupBase] Hot Update Failed, Auto Retry！", self._groupName)
      self:RequestDownLoadGroups()
    end
  end
end

function UpdateManager:GetProgrssValue()
  local pbVal = 0
  for i = 1, #self._updateGroups do
    pbVal = pbVal + self._updateGroups[i]:GetProgress()
  end
  do return math.floor end
  return math.floor, pbVal * 100, 1, nil, self._updateGroups[i]:GetProgress(), self._updateGroups[i]
end

function UpdateManager:_UpdateProgrssValue()
  local downloading_size = self:GetDownloadSize()
  local total_size = self:GetDownloadTotalSize()
  local percent = self:GetProgrssValue()
  UpdateManager.updateUI:OnUpdateProgress(percent, downloading_size, total_size)
end

function UpdateManager:OnResApplyStart(group)
  self:_UpdateProgrssValue()
end

function UpdateManager:OnApplyResComplete(group)
  self:_UpdateProgrssValue()
end

function UpdateManager:OnResApplyProgressChanged(group)
  self:_UpdateProgrssValue()
end

function UpdateManager:OnReloadLoadRes(group)
  self:_UpdateProgrssValue()
end

function UpdateManager:OnResApplyProgressFailed(group)
  UpdateManager.updateUI:SetStatusMsg("更新失败")
end

function UpdateManager:_OnUpdateConfirmDialog(size, confirm_update_cb)
  self:UploadApusInfo("On Update ConfirmDialog", 9)
  local tipsText = Language.Textf("HotUpdateConfirmTips", UpdateManager.updateUI.GetSizeFmt(size))
  UIMsgPopup:Show(tipsText, nil, function()
    self:UploadApusInfo("On Update ConfirmDialog Download", 10)
    confirm_update_cb(true)
  end, "确认", function()
    confirm_update_cb(false)
    self:UploadApusInfo("On Update ConfirmDialog Exit", 11)
    CS.Z1Client.LuaCSharpUtil.RestartGame()
  end, "取消", "DownloadTipsTitle")
end

function UpdateManager:_OnNetCarrierData(confirm_update_cb)
  self:UploadApusInfo("On Net CarrierData", 9)
  UIMsgPopup:Show("UsingCarrierDataNetworkTips", nil, function()
    self:UploadApusInfo("On Net CarrierData Download", 10)
    confirm_update_cb(true)
  end, "确认", function()
    confirm_update_cb(false)
    self:UploadApusInfo("On Net CarrierData Exit", 11)
    CS.Z1Client.LuaCSharpUtil.RestartGame()
  end, "取消", "DownloadTipsTitle")
end

function UpdateManager:IsNetReachable()
  return Application.internetReachability ~= NotReachable
end

function UpdateManager:IsNetCarrierData()
  return Application.internetReachability == ReachableViaCarrierDataNetwork
end

function UpdateManager:UploadApusInfo(key, index, msgData)
  msgData = msgData or {}
  msgData.index = index
  ApusUpdateComp.UploadApusInfo(Apus_Event_Name, key, msgData)
end

function UpdateManager:CheckResolutionChanged()
  if Application.platform ~= RP_WindowsPlayer then
    return
  end
  if self._curScreenWidth == CSScreen.width and self._curScreenHeight == CSScreen.height and self._isFullScreen == CSScreen.fullScreen then
    return
  end
  self._curScreenWidth = CSScreen.width
  self._curScreenHeight = CSScreen.height
  self._isFullScreen = CSScreen.fullScreen
  self:SaveResolution(self._curScreenWidth, self._curScreenHeight, self._isFullScreen)
end

function UpdateManager:SaveResolution(width, height, fullScreen)
  local isFullScreen = fullScreen and 0 or 1
  local PersisSaveTxtFileName = "PlayerPrefs.txt"
  CS.Framework.AssetLoadUtil.OnWriteGameFile(PersisSaveTxtFileName, tostring(width) .. "," .. tostring(height) .. "," .. tostring(isFullScreen))
end

function UpdateManager.GetLocalResVersion()
  local pkgDivType = CS.FrameWork.Z1Const.GetPackageDivType()
  if pkgDivType == DivPackageType.InGameDownLoad then
    local isUpdatedNewPatch, branchName, resVersion = VersionTools.GetVersionInfoInPatch(nil, nil, nil)
    if isUpdatedNewPatch then
      local resVersionStr = VersionTools.GetVersionStr(resVersion)
      return branchName, resVersionStr, resVersionStr, resVersionStr
    end
  end
  local using_build_type, using_res_version = VersionTools.GetUsingVersionInfo(nil, nil, nil)
  local patch_version = VersionTools.GetVersionStr(using_res_version)
  local newerBranchName, newer_res_version = VersionTools.GetNewerVersionInfoInDownloadOrApp(nil, nil, nil)
  local newest_version = VersionTools.GetVersionStr(newer_res_version)
  local _, appBranchName, app_res_version = VersionTools.GetVersionInfoInApp(nil, nil, nil)
  local inapp_version = VersionTools.GetVersionStr(app_res_version)
  return using_build_type, patch_version, newest_version, inapp_version
end

return UpdateManager
