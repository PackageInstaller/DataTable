local base = UIBaseWindow
local UIShare = class("UIShare", base)
local UINShareCapture = require("Game.Share.UI.Main.Capture.UINShareCapture")
local UINShare = require("Game.Share.UI.Main.Share.UINShare")
local util = require("XLua.Common.xlua_util")
local eShare = require("Game.Share.eShare")
local cs_ResLoader = CS.ResLoader
local cs_WaitForEndOfFrame = CS.UnityEngine.WaitForEndOfFrame
local cs_MessageCommon = CS.MessageCommon
local cs_FilePathHelper = CS.FilePathHelper.Instance
local cs_ImageConversion = CS.UnityEngine.ImageConversion

function UIShare:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.CloseShareWin)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):PushTopStatusDataToBackStack()
  self._resLoader = cs_ResLoader.Create()
  self.shareNode = UINShare.New(self)
  self.shareNode:Init(self.ui.shareNode)
  self.srCaptureNode = UINShareCapture.New()
  self.srCaptureNode:Init(self.ui.captureNode)
end

function UIShare:SetShareBeforeCaptureFunc(beforeCaptureFunc)
  self._beforeCaptureFunc = beforeCaptureFunc
  return self
end

function UIShare:SetShareAfterCaptureFunc(afterCaptureFunc)
  self._afterCaptureFunc = afterCaptureFunc
  return self
end

function UIShare:SetShareCloseFunc(closeFunc)
  self._closeFunc = closeFunc
  return self
end

function UIShare:SetShareEndFunc(shareEndFunc)
  self._shareEndFunc = shareEndFunc
  return self
end

function UIShare:SetShareGetRewardFunc(getRewardFunc)
  self._getRewardFunc = getRewardFunc
  return self
end

function UIShare:InitShare(shareId)
  self._shareId = shareId
  self.srCaptureNode:InitShareCapture(self._resLoader)
  self.__shareCoroutine = GR.StartCoroutine(util.cs_generator(BindCallback(self, self._CaptureImgCo)))
end

function UIShare:_ClearTextureTemp()
  if self._textureTemp ~= nil then
    DestroyUnityObject(self._textureTemp)
    self._textureTemp = nil
  end
end

function UIShare:_CaptureImgCo()
  if self._beforeCaptureFunc ~= nil then
    self._beforeCaptureFunc()
  end
  UIManager:HideClickEffect(true)
  NoticeManager:PuaseShowNotice("UIShare")
  self.shareNode:Hide()
  self.srCaptureNode:Show()
  local ingameDebugConsoleGo
  if isGameDev then
    ingameDebugConsoleGo = CS.UnityEngine.GameObject.Find("IngameDebugConsole")
    if not IsNull(ingameDebugConsoleGo) then
      ingameDebugConsoleGo:SetActive(false)
    end
  end
  local waitForEndOfFrame = cs_WaitForEndOfFrame()
  coroutine.yield(waitForEndOfFrame)
  self:_ClearTextureTemp()
  self._textureTemp = GR.CaptureScreenshotAsTexture()
  UIManager:HideClickEffect(false)
  NoticeManager:ContinueShowNotice("UIShare")
  if not IsNull(ingameDebugConsoleGo) then
    ingameDebugConsoleGo:SetActive(true)
  end
  if self._afterCaptureFunc ~= nil then
    self._afterCaptureFunc()
  end
  self.srCaptureNode:Hide()
  self.shareNode:Show()
  self.shareNode:InitShareNode(self._textureTemp)
end

function UIShare:ShareImgChannel(shareChannelId)
  local bytes = cs_ImageConversion.EncodeToPNG(self._textureTemp)
  local ok = cs_FilePathHelper:WriteBytesToFile(PathConsts.PersistentShareImgPath, bytes)
  if not ok then
    error("Save share image falied")
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(14028))
    return
  end
  local shareCtrl = ControllerManager:GetController(ControllerTypeId.Share, true)
  shareCtrl:SetShareGetRewardCallback(self._getRewardFunc)
  shareCtrl:ShareImg(self._shareId, shareChannelId, self._shareEndFunc)
  self:CloseShareWin()
end

function UIShare:_BackAction()
  if self._closeFunc ~= nil then
    self._closeFunc()
  end
  self:Delete()
end

function UIShare:CloseShareWin()
  UIUtil.OnClickBackByUiTab(self)
end

function UIShare:OnDelete()
  self.srCaptureNode:Delete()
  self.shareNode:Delete()
  self._resLoader:Put2Pool()
  self._resLoader = nil
  if self.__shareCoroutine ~= nil then
    GR.StopCoroutine(self.__shareCoroutine)
    self.__shareCoroutine = nil
  end
  self:_ClearTextureTemp()
  base.OnDelete(self)
end

return UIShare
