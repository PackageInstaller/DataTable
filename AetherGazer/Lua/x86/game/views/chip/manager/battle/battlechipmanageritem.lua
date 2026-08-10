local var_0_0 = import("game.views.chip.manager.ChipManagerItem")
local var_0_1 = class("BattleChipManagerItem", var_0_0)

function var_0_1.AddListeners(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.btn_, nil, function()
		arg_1_0:Go("/battleChipManager", {
			chipManagerID = arg_1_0.chipManagerID_,
			stageID = arg_1_0.chipManagerDataTemplate_.stageID_,
			stageType = arg_1_0.chipManagerDataTemplate_.stageType_,
			sectionProxy = arg_1_0.chipManagerDataTemplate_.sectionProxy_
		})
	end)
end

function var_0_1.SetTemplateData(arg_3_0, arg_3_1)
	arg_3_0.chipManagerDataTemplate_ = arg_3_1
end

return var_0_1
