_class("UIActivityReturnSystemIntro", UIController)
UIActivityReturnSystemIntro = UIActivityReturnSystemIntro

function UIActivityReturnSystemIntro:OnShow(uiParams)
end

function UIActivityReturnSystemIntro:OnHide()
end

function UIActivityReturnSystemIntro:bgOnClick(go)
  self:_PlayAnimOut()
end

function UIActivityReturnSystemIntro:imgCloseOnClick(go)
  self:_PlayAnimOut()
end

function UIActivityReturnSystemIntro:_PlayAnimOut()
  self.anim = self:GetUIComponent("Animation", "animation")
  self:StartTask(function(TT)
    self:Lock("UIActivityReturnSystemIntro_PlayAnimOut")
    self.anim:Play("uieff_Return_Intro_Fade")
    YIELD(TT, 133)
    self:UnLock("UIActivityReturnSystemIntro_PlayAnimOut")
    self:CloseDialog()
  end, self)
end
