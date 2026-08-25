local AvgActionShakeDialog = System.NewClass("AvgActionShakeDialog", AvgActionBase)

function AvgActionShakeDialog:DoAction(_, _, finishCb)
  self.avgPanel.uiAnimController:PlayState("UI_Story_Panel_Group_Dialog_doudong_vx", function()
    finishCb()
  end)
end

return AvgActionShakeDialog
