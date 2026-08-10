local var_0_0 = import("game.views.chip.manager.ChipManagerView")
local var_0_1 = class("BattleChipManagerView", var_0_0)

function var_0_1.SetViewParam(arg_1_0)
	local var_1_0

	if arg_1_0.params_.sectionProxy then
		var_1_0 = arg_1_0.params_.sectionProxy
	else
		local var_1_1 = arg_1_0.params_.reserveParams or ReserveTools.GetReserveParams(arg_1_0.params_.stageType, arg_1_0.params_.stageID)

		var_1_0 = SectionSelectHeroTools.GetProxyClass(arg_1_0.params_.stageType).New({
			section = arg_1_0.params_.stageID,
			sectionType = arg_1_0.params_.stageType
		}, var_1_1)
	end

	arg_1_0.chipManagerDataTemplate_:SetTeamInfo(arg_1_0.params_.stageType, arg_1_0.params_.stageID, var_1_0)
end

function var_0_1.OnUpdate(arg_2_0)
	arg_2_0.defaultSelectID_ = arg_2_0.params_.chipManagerID or arg_2_0.chipManagerList_[1]

	arg_2_0:RefreshUI()
end

function var_0_1.RefreshUI(arg_3_0)
	var_0_1.super.RefreshUI(arg_3_0)
	arg_3_0:RefreshList()
end

function var_0_1.RefreshList(arg_4_0)
	arg_4_0.chipManagerUIList_:Refresh()
end

function var_0_1.GetChipManagerItem(arg_5_0)
	return BattleChipManagerItem
end

function var_0_1.GetChipManagerList(arg_6_0)
	local var_6_0 = arg_6_0.chipManagerDataTemplate_.sectionProxy_:GetMimirID()

	return ChipTools.SortChipManager(var_6_0)
end

function var_0_1.GetChipDataTemplate(arg_7_0)
	local var_7_0 = ChipManagerDataTemplate.New({
		id = arg_7_0.defaultSelectID_,
		unlockChipManagerIDList_ = arg_7_0:GetUnlockChipManagerList(),
		unlockChipIDList_ = arg_7_0:GetUnlockChipList()
	})

	var_7_0:SetChipInfoViewPath("/battleChipInfo")

	return var_7_0
end

function var_0_1.OnSchemeBtn(arg_8_0)
	JumpTools.OpenPageByJump("battleChipScheme", {
		chipManagerID = arg_8_0.chipManagerID_,
		template = arg_8_0.chipManagerDataTemplate_
	})
end

function var_0_1.EnableChipManagerIDFunc(arg_9_0, arg_9_1)
	arg_9_0.chipManagerDataTemplate_.sectionProxy_:SetMimirID(arg_9_1)
	arg_9_0:RefreshUI()
	arg_9_0.chipManagerUIList_:Refresh()
end

return var_0_1
