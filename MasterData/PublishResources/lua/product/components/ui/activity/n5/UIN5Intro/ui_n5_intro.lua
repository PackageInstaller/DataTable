_class("UIN5Intro", UIController)
UIN5Intro = UIN5Intro

function UIN5Intro:OnShow(uiParams)
  self:InitWidget()
  self:Flush()
  self:PlayAnim(true)
end

function UIN5Intro:InitWidget()
  self.content = self:GetUIComponent("UIRichText", "Content")
  self.scroll = self:GetUIComponent("ScrollRect", "ScrollView")
  self.anim = self:GetGameObject():GetComponent("Animation")
end

function UIN5Intro:btnCloseOnClick(go)
  self:PlayAnim(false, function()
    self:CloseDialog()
  end)
end

function UIN5Intro:Flush()
  self.scroll.verticalNormalizedPosition = 1
end

function UIN5Intro:PlayAnim(isIn, callback)
  self:StartTask(function(TT)
    self:Lock("UISummer1IntroPlayAnim")
    if isIn then
      self.anim:Play("uieff_Activity_UISummer1Intro_In")
      YIELD(TT, 500)
    else
      self.anim:Play("uieff_Activity_UISummer1Intro_Out")
      YIELD(TT, 500)
    end
    self:UnLock("UISummer1IntroPlayAnim")
    if callback then
      callback()
    end
  end, self)
end
