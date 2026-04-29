_class("UIBouncePause", UICustomWidget)
UIBouncePause = UIBouncePause

function UIBouncePause:OnShow(uiParams)
  self:InitWidget()
end

function UIBouncePause:InitWidget()
end

function UIBouncePause:Init(exitCall, continueCall)
  self.exitCall = exitCall
  self.continueCall = continueCall
end

function UIBouncePause:Start()
end

function UIBouncePause:ExitBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneInfo)
  if self.continueCall then
    self.continueCall()
  end
end

function UIBouncePause:ContinueOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneInfo)
  if self.exitCall then
    self.exitCall()
  end
end
