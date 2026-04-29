_class("UIGuideMessageBox", UIMessageBox)
UIGuideMessageBox = UIGuideMessageBox

function UIGuideMessageBox:Constructor()
  self.closeCallback = nil
  self.isShow = nil
end

function UIGuideMessageBox:OnShow()
  local pool = self:GetUIComponent("UISelectObjectPath", "GuideLoader")
  local guideScript = pool:SpawnObject("UIGuide")
  self.guideScript = guideScript
end

function UIGuideMessageBox:Alert(popup, params)
  Log.debug("UIGuideMessageBox:Alert")
  if self.isShow then
    GuideHelper.GuideLoadLock(false, "Button")
    return
  end
  self.isShow = true
  self.guideScript:Init(params[1])
  self.closeCallback = self:GetCallBack(popup)
end

function UIGuideMessageBox:ClearCallback()
  if self.isShow then
    self.isShow = false
    if self.closeCallback then
      self.closeCallback()
      self.closeCallback = nil
    end
    self.guideScript:RemoveClick()
  end
end

function UIGuideMessageBox:CloseGuid()
  if self.closeCallback then
    self.closeCallback()
  end
end

function UIGuideMessageBox:GetCallBack(popup, btnCallback, param)
  return function()
    if btnCallback then
      btnCallback(param)
    end
    self:SetShow(false)
    Log.debug("[UIPopup] UIMessageBox:GetCallBack request ClosePopup")
    GameGlobal.GuideMessageBoxMng():ClosePopup(popup)
  end
end
