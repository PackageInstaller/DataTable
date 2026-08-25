local AvgActionFadeIn = System.NewClass("AvgActionFadeIn", AvgActionBase)

function AvgActionFadeIn:DoAction(_, actionData)
  if not self.avgModel.video and not self.avgModel:HasBgIdVideo() then
    self.avgPanel:PlayDialogAudio(self.avgModel:GetDialogInfo())
  end
  if actionData.isFadeIn then
    self.avgPanel.isNeedReset = false
    local fadeInAnim = self.avgModel.captionBeginAnim or "UI_jianbian_yty_vx_02_open"
    self.avgPanel.textComp:ClearDialogText()
    self.avgPanel.uiAnimController:PlayState(fadeInAnim, function()
      self:FinishAction()
    end)
  else
    if self.avgPanel.isNeedReset then
      self.avgPanel.isNeedReset = false
      self.avgPanel:ResetPanelAnim()
    end
    self:FinishAction()
  end
end

return AvgActionFadeIn
