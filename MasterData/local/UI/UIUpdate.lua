local TMP_Text = CS.TMPro.TMP_Text
local Text = CS.UnityEngine.UI.Text
local Slider = CS.UnityEngine.UI.Slider
local GameObject = CS.UnityEngine.GameObject
local Z1Button = CS.Z1Client.Z1Button
local LoadAgent = CS.ResourceManager.LoadAgent
local Languange = require("Lang.Language")
local UpdateUtils = require("UpdateUtils")
local DOWNLOAD_PRECENT = 100
local UIUpdate = {}

function UIUpdate:Create(repaireCallback)
  self.currentProgress = 0
  self.processSpeed = 0.006
  self.targetProcess = 0
  self.progressText = ""
  self:InitUpdateUI()
  print("UIUpdate:Create")
  if not self:IsResCompatible() then
    return
  end
  local rootTrans = self.rootNode.transform
  self.Text_Status = rootTrans:Find("Text_Status"):GetComponent(typeof(Text))
  self.Text_Tips = rootTrans:Find("Text_Tips"):GetComponent(typeof(Text))
  self.Text_Repair = rootTrans:Find("Btn_Repair/Text_Repair"):GetComponent(typeof(Text))
  self.Slider_Patch = rootTrans:Find("Slider_Patch"):GetComponent(typeof(Slider))
  self.Slider_Text = rootTrans:Find("Slider_Patch/Text_Precent"):GetComponent(typeof(Text))
  self.Text_Uid = rootTrans:Find("Text_Uid"):GetComponent(typeof(Text))
  self.Btn_Repair = rootTrans:Find("Btn_Repair"):GetComponent(typeof(Z1Button))
  self.Btn_Repair.onClick:AddListener(repaireCallback)
  self.bgNode = rootTrans:Find("bg").gameObject
  local UpdateManager = require("UpdateManager")
  local branchName, resVersion = UpdateManager.GetLocalResVersion()
  print("UIUpdate Versioninfo: ", branchName, resVersion)
  self._CurrentVersion = resVersion
  self:SetStatusMsg("正在检查资源更新")
  self.Slider_Patch.value = 0
  self.Slider_Text.text = ""
  self.Text_Repair.text = Languange.Text("修复")
  self.Text_Tips.text = ""
  print("UIUpdate:Create end")
  self:_UpdateLangFonts()
end

function UIUpdate:_UpdateLangFonts()
  if not self.Text_Tips then
    return
  end
  local cur_lang = Languange.cur_lang
  local font = UpdateUtils.GetLangFont(cur_lang)
  self.Slider_Text.font = font
  self.Text_Status.font = font
  self.Text_Tips.font = font
  self.Text_Repair.font = font
  self.Text_Uid.font = font
end

function UIUpdate:Dispose()
  if self.uiVideo then
    pcall(self.uiVideo.Dispose, self.uiVideo)
  end
  if self.Btn_Repair then
    self.Btn_Repair.onClick:RemoveAllListeners()
  end
end

function UIUpdate:InitUpdateUI()
  self.rootNode = GameObject.Find("UIRoot/SafeArea/FixedRoot/Panel_Loading")
  if not self.rootNode then
    self.loadAgent = LoadAgent()
    local mainAsset = self.loadAgent:LoadAsset("GameUpdate/Res/Panel_Loading.prefab", typeof(GameObject))
    self.rootNode = GameObject.Instantiate(mainAsset)
    local parentNode = GameObject.Find("UIRoot/SafeArea/FixedRoot")
    self.rootNode.transform:SetParent(parentNode.transform, false)
    self.rootNode.name = "Panel_Loading"
    print("UIUpdate:InitUpdateUI createUI")
  end
end

function UIUpdate:SetUidOrUtdid()
  local data = UpdateUtils.ReadJsonCache("z1_use.cfg")
  if data and data.playerUid then
    self.Text_Uid.text = data.playerUid
  else
    local E = require("ejoysdk_lua.ejoysdk")
    if E and E.get_pkg_info() and E.get_pkg_info().utdid then
      local utdid = E.get_pkg_info().utdid
      local utdidEncode = _ejoysdk_crypt.base64encode(tostring(utdid))
      self.Text_Uid.text = utdidEncode
    end
  end
end

function UIUpdate:PlayVideo()
  local rootTrans = self.rootNode.transform
  local videoNode = rootTrans:Find("VideoPlayer")
  local mediaNode = rootTrans:Find("MediaPlayer")
  if videoNode and mediaNode then
    self.bgNode:SetActive(false)
    self.uiVideo = require("UI.UIVideo")
    self.uiVideo:Create(mediaNode.gameObject, videoNode.gameObject)
  end
end

function UIUpdate:OnUIUpdate()
  if not self:IsResCompatible() then
    return
  end
  if self.currentProgress and self.targetProcess and self.currentProgress < self.targetProcess then
    self.currentProgress = math.min(100, self.currentProgress + self.processSpeed * self.targetProcess)
    self.Slider_Patch.value = self.currentProgress
    if self.progressText and self.progressText ~= "" then
      self.Slider_Text.text = string.format("%d%%", math.ceil(self.currentProgress))
    end
  end
  if self.uiVideo then
    pcall(self.uiVideo.Update, self.uiVideo)
  end
end

function UIUpdate:ClearProgressText()
  self.progressText = ""
  self.Slider_Text.text = ""
end

function UIUpdate:SetStatusMsg(msg)
  if not self:IsResCompatible() then
    return
  end
  self.Text_Status.text = Languange.Text(msg) .. self.progressText
end

function UIUpdate:OnReceiveResUpdate(has_udpate, new_version, total_size)
  print("UpdateManager UIUpdate:OnReceiveResUpdate", has_udpate, new_version, total_size)
  if self:IsResCompatible() and has_udpate then
    self.target_total_size = total_size
  end
end

function UIUpdate:OnUpdateComplete(precnet)
  if not precnet or precnet < DOWNLOAD_PRECENT then
    precnet = DOWNLOAD_PRECENT
  end
  self:OnUpdateProgress(precnet)
end

function UIUpdate:SetCaptureFlagImg(state)
  local rootTrans = self.rootNode and self.rootNode.transform
  if rootTrans then
    local redGo = rootTrans:Find("Btn_Repair/Group_RedDot")
    if redGo then
      redGo.gameObject:SetActive(state)
    end
  end
end

function UIUpdate:CaptureScreen()
  if CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsEditor then
    return
  end
  if not self.empty then
    local function back(screenTexture)
      self.empty = GameObject()
      
      self.empty.name = "captureScreenImg"
      local empty = self.empty
      local TypeRawImage = typeof(CS.UnityEngine.UI.RawImage)
      local rootTrans = self.rootNode.transform.parent.parent.parent
      local ImgCom = empty:AddComponent(TypeRawImage)
      local TypeRectTransform = typeof(CS.UnityEngine.RectTransform)
      local rectTrans = empty:GetComponent(TypeRectTransform)
      empty.transform:SetParent(rootTrans, false)
      empty.gameObject.layer = CS.UnityEngine.LayerMask.NameToLayer("UI")
      local TypeCanvas = typeof(CS.UnityEngine.Canvas)
      local canvasCom = empty:AddComponent(TypeCanvas)
      canvasCom.overrideSorting = true
      canvasCom.sortingOrder = 3000
      local Vector2_Zero = CS.UnityEngine.Vector2(0, 0)
      local Vector3_Zero = CS.UnityEngine.Vector3(0, 0)
      local Vector2_One = CS.UnityEngine.Vector2(1, 1)
      local Vector2_Zero = CS.UnityEngine.Vector2(0, 0)
      local ColorZero = CS.UnityEngine.Color(0, 0, 0, 0)
      rectTrans.anchorMax = Vector2_One
      rectTrans.anchorMin = Vector2_Zero
      rectTrans.offsetMin = Vector2_Zero
      rectTrans.offsetMax = Vector2_Zero
      if screenTexture then
        empty:SetActive(false)
        ImgCom.texture = screenTexture
        empty:SetActive(true)
      end
      self:SetCaptureFlagImg(false)
    end
    
    local LuaCSharpUtil = CS.Z1Client.LuaCSharpUtil
    local GameUpdater = CS.Z1ClientUpdater.GameUpdater
    LuaCSharpUtil.CaptureScreenByMono(GameUpdater.Instance, back)
  end
end

function UIUpdate:OnUpdateProgress(percent, download_size, total_size)
  if not self:IsResCompatible() then
    return
  end
  percent = percent and tonumber(percent) or 100
  if download_size and total_size then
    local modify_percent = DOWNLOAD_PRECENT / 100
    self.targetProcess = percent * modify_percent
    total_size = math.max(total_size, download_size)
    self.progressText = string.format("(%s/%s)", UIUpdate.GetSizeFmt(download_size), UIUpdate.GetSizeFmt(total_size))
    self:SetStatusMsg("下载中")
    if math.abs(self.targetProcess - self.currentProgress) > 5 then
      self.currentProgress = self.targetProcess - self.processSpeed
    end
  else
    self.targetProcess = percent
    self.progressText = ""
    if 100 == self.targetProcess then
      self.currentProgress = self.targetProcess - self.processSpeed
    end
  end
  self:OnUIUpdate()
end

function UIUpdate:IsResCompatible()
  if self._compatible ~= nil then
    return self._compatible
  end
  self._compatible = false
  local rootTrans = self.rootNode and self.rootNode.transform
  if rootTrans then
    local btnGo = rootTrans:Find("Btn_Repair")
    self._compatible = btnGo and nil ~= btnGo:GetComponent(typeof(Z1Button))
  end
  return self._compatible
end

local SizeUnit = {
  KB = 1024,
  MB = 1048576,
  GB = 1073741824,
  TB = 1099511627776
}

function UIUpdate.GetSizeFmt(size)
  local ret
  if size >= SizeUnit.TB then
    ret = string.format("%.2f %s", size / SizeUnit.TB, "TB")
  elseif size >= SizeUnit.GB then
    ret = string.format("%.2f %s", size / SizeUnit.GB, "GB")
  elseif size >= SizeUnit.MB then
    ret = string.format("%.2f %s", size / SizeUnit.MB, "MB")
  elseif size >= SizeUnit.KB then
    ret = string.format("%.2f %s", size / SizeUnit.KB, "KB")
  else
    ret = string.format("%.2f %s", size, "B")
  end
  return ret
end

return UIUpdate
