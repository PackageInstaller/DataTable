_class("UIXiaoLinJiaIntroController", UIController)
UIXiaoLinJiaIntroController = UIXiaoLinJiaIntroController

function UIXiaoLinJiaIntroController:OnShow(uiParams)
  self.anim = self:GetUIComponent("Animation", "anim")
end

function UIXiaoLinJiaIntroController:CloseBtnOnClick()
  self:Lock("UIXiaoLinJiaIntroController_Close")
  self.anim:Play("uieffanim_UIXiaoLinJiaIntroController_out")
  self:StartTask(function(TT)
    YIELD(TT, 500)
    self:CloseDialog()
    self:UnLock("UIXiaoLinJiaIntroController_Close")
  end)
end
