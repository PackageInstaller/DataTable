local JSON = require("ejoysdk_lua.libs.lunajson")
local GroupDownloadMgr, Super = System.NewClass("GroupDownloadMgr", Manager, IUpdater)
local DivPackageType = CS.ResourceManager.DivPackageType
local DownloadHelper = CS.ResourceManager.DownloadHelper
local AssetLoadUtil = CS.Framework.AssetLoadUtil
local DownLoadSizeKey = "z1j_DownloadSize_Download"
local PkgDivType = CS.FrameWork.Z1Const.GetPackageDivType()
local MaxBandWidth = 3072

function GroupDownloadMgr:ctor()
  Super.ctor(self)
  self._inGameDownloadGroup = nil
  self._isPlayerCancelDownload = true
  self._downloadGroups = {}
end

function GroupDownloadMgr:Awake()
  Super.Awake(self)
  local groupName = self:GetInGameDownloadGroupName()
  self._downloadGroups[groupName] = self:IsGroupDownload(groupName) or false
end

function GroupDownloadMgr:CheckGroupDownloadable(groupName, cb)
  if not self:IsGroupDownload(groupName) then
    cb(true, false)
    return
  end
  local EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
  if nil ~= EF then
    local opts = {foreground_notification_enabled = true}
    local listeners = {
      on_confirm_res_update = function(update_info, confirm_update_cb)
        confirm_update_cb(false)
        cb(true, update_info.has_new_update)
      end,
      on_group_res_update_complete = function(update_result, ...)
      end
    }
    EF.group_res_update(groupName, nil, opts, listeners)
  end
end

function GroupDownloadMgr:Update()
  if self._inGameDownloadGroup then
    self._inGameDownloadGroup:Update()
  end
end

function GroupDownloadMgr:GetInGameDownloadGroupName()
  return "Download"
end

function GroupDownloadMgr:SetGroupDownload(group)
  self._downloadGroups = self._downloadGroups or {}
  self._downloadGroups[group] = true
  local groupFiles = "DownloadGroup_" .. group
  local path = DownloadHelper.GetDownloadPathDefault() .. "/" .. groupFiles
  ApplicationUtils.WriteFile("1", path)
end

function GroupDownloadMgr:IsGroupDownload(group)
  if self._downloadGroups and self._downloadGroups[group] ~= nil then
    return self._downloadGroups[group]
  end
  local groupFiles = "DownloadGroup_" .. group
  local path = DownloadHelper.GetDownloadPathDefault() .. "/" .. groupFiles
  do return AssetLoadUtil.IsFileExist end
  return AssetLoadUtil.IsFileExist, path
end

function GroupDownloadMgr:LoadDownloadingVersion()
  local groupFiles = "DownloadGroup_Ver_Download"
  local path = DownloadHelper.GetDownloadPathDefault() .. "/" .. groupFiles
  if AssetLoadUtil.ReadFile ~= nil and AssetLoadUtil.IsFileExist(path) then
    do return AssetLoadUtil.ReadFile end
    return AssetLoadUtil.ReadFile, path
  end
end

function GroupDownloadMgr:SaveDownloadingVersion(ver)
  local groupFiles = "DownloadGroup_Ver_Download"
  local path = DownloadHelper.GetDownloadPathDefault() .. "/" .. groupFiles
  ApplicationUtils.WriteFile(ver, path)
end

function GroupDownloadMgr:SetDownloadMaxBandWidth(max_band_width)
  if Main.isAppDestroyed then
    return
  end
  local EMM = require("ejoysdk_lua.res.ejoy_res_model_factory")
  local model_instance = EMM.get_http_res_multi_model("z1_multi_model")
  model_instance:update_download_config({max_band_width_kbytes_per_sec = max_band_width})
end

function GroupDownloadMgr:EnableDownloadMaxBandWidth()
  print("==GroupDownloadMgr======EnableDownloadMaxBandWidth===")
  self:SetDownloadMaxBandWidth(MaxBandWidth)
end

function GroupDownloadMgr:CancelDownloadMaxBandWidth()
  print("==GroupDownloadMgr======CancelDownloadMaxBandWidth===")
  self:SetDownloadMaxBandWidth(-1)
end

function GroupDownloadMgr:TryInGameDownload()
  if not IntroductionDataUtils.IsFinish() then
    return false
  end
  print("[GroupDownloadMgr] TryInGameDownload pkgDivType", PkgDivType)
  if DivPackageType.InGameDownLoad ~= PkgDivType then
    print("[GroupDownloadMgr] TryInGameDownload pkgDivType is not InGameDownLoad")
    return false
  end
  local groupName = self:GetInGameDownloadGroupName()
  if not self:IsGroupDownload(groupName) then
    print("[GroupDownloadMgr] TryInGameDownload Group Not Download", groupName)
    RpcMgr.Instance:Disconnect()
    SceneMgr.Instance:EnterLogin()
    self:DownloadIngameGroup(true)
    self:CancelDownloadMaxBandWidth()
    return true
  end
  print("[GroupDownloadMgr] TryInGameDownload Group Has Download", groupName)
  return false
end

function GroupDownloadMgr:CheckDownloadIngameGroup()
  if DivPackageType.InGameDownLoad ~= PkgDivType then
    return
  end
  local inGameGroup = self:GetInGameDownloadGroupName()
  if self:IsGroupDownload(inGameGroup) then
    return
  end
  if self._inGameDownloadGroup then
    return
  end
  self:DownloadIngameGroup()
end

function GroupDownloadMgr:IsUseDownloadDelegate()
  return self._useDelegate
end

function GroupDownloadMgr:SetUseDownloadDelegate(useDelegate)
  self._useDelegate = useDelegate
  if useDelegate then
    self:CancelDownloadMaxBandWidth()
  else
    self:EnableDownloadMaxBandWidth()
  end
end

function GroupDownloadMgr:CheckInterruptDownload()
  if AssetLoadUtil.RenameDirectory == nil then
    return
  end
  local curVersion = Utils.GetQZCurResVersion()
  local downloadingVer = self:LoadDownloadingVersion()
  if not downloadingVer or "0" == downloadingVer or downloadingVer == curVersion then
    return
  end
  local resKey = Utils.GetArchiveName()
  local qz_patchPath = Utils.GetApplicationPersistenDataPath() .. "/ejoysdk_res/qz_patch/qz_res_group-" .. resKey .. "-Download" .. "/"
  local oldPath = qz_patchPath .. downloadingVer
  local newPath = qz_patchPath .. curVersion
  AssetLoadUtil.RenameDirectory(oldPath, newPath)
  local dlCfgPath = self:_GetDLConfigPath(resKey)
  if not dlCfgPath then
    return
  end
  local fileInfo = CS.System.IO.FileInfo(dlCfgPath)
  if fileInfo.Exists then
    local fileCtx = AssetLoadUtil.ReadFile(dlCfgPath)
    local dlConfig = JSON.decode(fileCtx)
    dlConfig.downloading_info.version = curVersion
    ApplicationUtils.WriteFile(JSON.encode(dlConfig), dlCfgPath)
  end
end

function GroupDownloadMgr:_GetDLConfigPath(resKey)
  if ApplicationUtils.IsAndroid() then
    local pkgName = CS.UnityEngine.Application.identifier
    return "/data/data/" .. pkgName .. "/files/ejoysdk_res/qz_patch/qz_res_group-" .. resKey .. "-Download" .. "/dl_config"
  end
  if ApplicationUtils.IsIOS() then
    local persistenDataPath = Utils.GetApplicationPersistenDataPath()
    return persistenDataPath .. "/ejoysdk_res/qz_patch/qz_res_group-" .. resKey .. "-Download" .. "/dl_config"
  end
end

function GroupDownloadMgr:SetPlayerCancelDownload(cancel)
  self._isPlayerCancelDownload = cancel
end

function GroupDownloadMgr:DownLoadDebugGroup(cb)
  local downloadGroup = DownLoadGroup("Debug", true, 3)
  local delegate = {}
  
  function delegate.OnDownloadGroupSuccess()
    if cb then
      cb(true)
    end
  end
  
  function delegate.OnDownloadGroupFailed()
    if cb then
      cb(false)
    end
  end
  
  downloadGroup:SetDelegate(delegate)
  downloadGroup:RequestDownLoadGroup()
end

function GroupDownloadMgr:DownloadIngameGroup(useDelegate)
  if DivPackageType.InGameDownLoad ~= PkgDivType then
    return
  end
  local inGameGroup = self:GetInGameDownloadGroupName()
  if self:IsGroupDownload(inGameGroup) then
    return
  end
  self:SetUseDownloadDelegate(useDelegate)
  if not self._inGameDownloadGroup then
    print("[GroupDownloadMgr] DownloadIngameGroup")
    self._inGameDownloadGroup = DownLoadGroup(inGameGroup, true, 3)
    if self._useDelegate then
      local loginPanel = UIManager.Instance:GetWindow(Urls.LoginPanel)
      if loginPanel then
        self._inGameDownloadGroup:SetDelegate(loginPanel)
      end
    end
    self._inGameDownloadGroup:RequestDownLoadGroup()
  else
    if self._useDelegate then
      local loginPanel = UIManager.Instance:GetWindow(Urls.LoginPanel)
      if loginPanel then
        self._inGameDownloadGroup:SetDelegate(loginPanel)
      end
    end
    local status = self._inGameDownloadGroup:GetDownLoadStatus()
    if status == GroupDownStatus.Failed or status == GroupDownStatus.WaitingWifi or status == GroupDownStatus.Cancel or status == GroupDownStatus.UnzipFailed or status == GroupDownStatus.DiskFull then
      self._inGameDownloadGroup:RequestDownLoadGroup()
    end
  end
  return self._inGameDownloadGroup
end

function GroupDownloadMgr:GetInGameDownloadGroup()
  return self._inGameDownloadGroup
end

function GroupDownloadMgr:ClearInGameDownloadGroup()
  self._inGameDownloadGroup = nil
  self._useDelegate = nil
end

function GroupDownloadMgr:StopDownloadAllGroups()
  self._inGameDownloadGroup = nil
  self._useDelegate = nil
end

function GroupDownloadMgr:SaveDownLoadSize(size)
  CS.UnityEngine.PlayerPrefs.SetString(DownLoadSizeKey, tostring(size or 0))
  if self._useDelegate then
    CS.UnityEngine.PlayerPrefs.Save()
  end
end

function GroupDownloadMgr:LoadDownLoadSize()
  local sizeStr = CS.UnityEngine.PlayerPrefs.GetString(DownLoadSizeKey, "0")
  return tonumber(sizeStr) or 0
end

function GroupDownloadMgr:OnDestroy()
  self._inGameDownloadGroup = nil
  self._useDelegate = nil
end

return GroupDownloadMgr
