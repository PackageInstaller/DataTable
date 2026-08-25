local AvgActionFadeOut = System.NewClass("AvgActionFadeOut", AvgActionBase)

function AvgActionFadeOut:DoAction(_, _)
  local fadeOutAnim = self.avgModel.captionEndAnim or "UI_jianbian_yty_vx_02_close"
  self.avgPanel.uiAnimController:PlayState(fadeOutAnim, function()
    self.avgPanel.isNeedReset = true
    self:FinishAction()
  end)
end

return AvgActionFadeOut
