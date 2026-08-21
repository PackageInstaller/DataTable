local var_0_0 = class("CharChipDetailView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Administrators/AdministratorsChipUpqradeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.lineController_ = arg_3_0.doneConEx_:GetController("line")
	arg_3_0.btnController_ = arg_3_0.btnConEx_:GetController("btn")
	arg_3_0.affixItems_ = {}
	arg_3_0.condItems_ = {}

	SetActive(arg_3_0.affixItem_, false)
	SetActive(arg_3_0.condItem_, false)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.activateBtn_, nil, function()
		ChipAction.ActivateCharChipExtra(arg_4_0.nextExtraIDToUnlock_)
	end)
end

function var_0_0.OnEnter(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_6_0.baseID_ = arg_6_0.params_.baseID
	arg_6_0.affixList_ = ChipTools.GetCharChipExtraIDList(arg_6_0.baseID_)

	arg_6_0:UpdateNextID()
	arg_6_0:RefreshUI()
end

function var_0_0.UpdateNextID(arg_7_0)
	arg_7_0.nextExtraIDToUnlock_ = ChipTools.GetNextCharChipExtraIDToUnlock(arg_7_0.baseID_)
	arg_7_0.affixUnlockList_ = ChipTools.GetCharChipExtraIDListUnlock(arg_7_0.baseID_)

	if arg_7_0.nextExtraIDToUnlock_ == 0 then
		arg_7_0.nextExtraIDToUnlock_ = arg_7_0.affixUnlockList_[#arg_7_0.affixUnlockList_]
	end

	arg_7_0.condList_ = ChipCfg[arg_7_0.nextExtraIDToUnlock_].module_condition
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.IndexItemAffix(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_0.affixList_[arg_9_1], arg_9_0.nextExtraIDToUnlock_)
end

function var_0_0.IndexItemCond(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_0.condList_[arg_10_1])
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = ChipCfg[arg_11_0.baseID_]

	arg_11_0.charImg_.spriteSync = ChipTools.GetCharChipIcon(arg_11_0.baseID_)

	local var_11_1 = ChipTools.IsCharChipExtraCanUnlock(arg_11_0.nextExtraIDToUnlock_)

	arg_11_0.btnController_:SetSelectedState(var_11_1 and "unLock2" or "unLock1")
	arg_11_0.lineController_:SetSelectedState(tostring(math.min(2, #arg_11_0.affixUnlockList_)))
	arg_11_0:RefreshAffixList()
	arg_11_0:RefreshCondList()
end

function var_0_0.RefreshAffixList(arg_12_0)
	local var_12_0 = #arg_12_0.affixList_

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.affixItems_) do
		SetActive(iter_12_1.gameObject_, iter_12_0 <= var_12_0)
	end

	for iter_12_2 = 1, var_12_0 do
		local var_12_1 = arg_12_0.affixItems_[iter_12_2]

		if not var_12_1 then
			local var_12_2 = Object.Instantiate(arg_12_0.affixItem_, arg_12_0.affixListTrans_)

			SetActive(var_12_2, true)

			var_12_1 = CharChipExtraItem.New(var_12_2)
			arg_12_0.affixItems_[iter_12_2] = var_12_1
		end

		arg_12_0:IndexItemAffix(iter_12_2, var_12_1)
	end
end

function var_0_0.RefreshCondList(arg_13_0)
	local var_13_0 = #arg_13_0.condList_

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.condItems_) do
		SetActive(iter_13_1.gameObject_, iter_13_0 <= var_13_0)
	end

	for iter_13_2 = 1, var_13_0 do
		local var_13_1 = arg_13_0.condItems_[iter_13_2]

		if not var_13_1 then
			local var_13_2 = Object.Instantiate(arg_13_0.condItem_, arg_13_0.condListTrans_)

			SetActive(var_13_2, true)

			var_13_1 = CharChipCondItem.New(var_13_2)
			arg_13_0.condItems_[iter_13_2] = var_13_1
		end

		arg_13_0:IndexItemCond(iter_13_2, var_13_1)
	end
end

function var_0_0.OnActivateCharChip(arg_14_0)
	arg_14_0:UpdateNextID()
	arg_14_0:RefreshUI()
	JumpTools.OpenPageByJump("charChipPowerup", {
		baseID = arg_14_0.baseID_
	})
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.affixItems_) do
		iter_15_1:Dispose()
	end

	for iter_15_2, iter_15_3 in ipairs(arg_15_0.condItems_) do
		iter_15_3:Dispose()
	end
end

return var_0_0
