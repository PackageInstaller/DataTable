local var_0_0 = import("game.views.chip.info.ChipInfoView")
local var_0_1 = class("BattleChipInfoView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	arg_1_0.chipManagerDataTemplate_ = arg_1_0.params_.chipDataTemplate
	arg_1_0.sectionProxy_ = arg_1_0.chipManagerDataTemplate_.sectionProxy_

	arg_1_0.super.OnEnter(arg_1_0)
end

function var_0_1.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.useBtn_, nil, function()
		arg_2_0.chipManagerDataTemplate_:SetUseChipId(arg_2_0.defaultSelectID_)
		manager.notify:Invoke(ENABLED_CHIP, arg_2_0.defaultSelectID)
		arg_2_0.sectionProxy_:InsertMimirChip(arg_2_0.defaultSelectID_)
	end)
	arg_2_0:AddBtnListener(arg_2_0.unlockBtn_, nil, function()
		ChipAction.UnlockChip(arg_2_0.defaultSelectID_)
	end)
	arg_2_0:AddBtnListener(arg_2_0.unloadBtn_, nil, function()
		arg_2_0.chipManagerDataTemplate_:SetNoUseChipId(arg_2_0.defaultSelectID_, arg_2_0.params_.selectChipIndex)
		manager.notify:CallUpdateFunc(UNUSE_BATTLECHIP, arg_2_0.defaultSelectID_)
		arg_2_0.sectionProxy_:RemoveMimirChip(arg_2_0.defaultSelectID_)
	end)
end

function var_0_1.OnEnabledChip(arg_6_0)
	arg_6_0.currentChipList_ = arg_6_0:GetChipData()

	arg_6_0:RefreshUI()
	arg_6_0.chipUIList_:Refresh()
end

function var_0_1.GetChipData(arg_7_0)
	return (arg_7_0.sectionProxy_:GetMimirChipList())
end

function var_0_1.SortChip(arg_8_0)
	local var_8_0 = arg_8_0:GetChipTypeCntList() or {}

	return ChipTools.SortChip(var_8_0[-1], arg_8_0.params_.chipManagerID)
end

return var_0_1
