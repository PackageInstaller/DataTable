local AvgActionHideDialogAnim = System.NewClass("AvgActionHideDialogAnim", AvgActionBase)

function AvgActionHideDialogAnim:DoAction(_, _, finishCb)
  if self.avgModel:IsCaption() then
    finishCb()
    return
  end
  self.avgPanel.uiAnimController:PlayState("UI_Story_Panel_Group_Dialog_danchu_vx", function()
    finishCb()
  end)
end

return AvgActionHideDialogAnim
