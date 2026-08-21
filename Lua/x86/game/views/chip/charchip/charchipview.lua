local var_0_0 = class("CharChipView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Administrators/AdministratorsChipUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.lockController_ = arg_3_0.conEx_:GetController("Unlock")
	arg_3_0.starController_ = arg_3_0.chipConEx_:GetController("light")
	arg_3_0.unlockBtnController_ = arg_3_0.unlockBtnConEx_:GetController("btn")
	arg_3_0.activateBtnController_ = arg_3_0.activateBtnConEx_:GetController("btn")
	arg_3_0.affixController_ = arg_3_0.listConEx_:GetController("activate")
	arg_3_0.affixItems_ = {}
	arg_3_0.condItems_ = {}

	SetActive(arg_3_0.affixItem_, false)
	SetActive(arg_3_0.condItem_, false)

	arg_3_0.skillItems_ = {}

	for iter_3_0 = 1, 3 do
		local var_3_0 = arg_3_0["skillGo" .. iter_3_0 .. "_"]

		if var_3_0 then
			arg_3_0.skillItems_[iter_3_0] = CharChipExtraItem.New(var_3_0.gameObject)
		end
	end
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.unlockBtn_, nil, function()
		if ChipTools.IsCharChipBaseUnlock(arg_4_0.baseID_) then
			ChipAction.ActivateCharChipExtra(arg_4_0.nextIDToUnlock_)
		else
			ChipAction.ActivateCharChipBase(arg_4_0.baseID_)
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_6_0.baseID_ = arg_6_0.params_.baseID
	arg_6_0.affixList_ = ChipTools.GetCharChipExtraIDList(arg_6_0.baseID_)
	arg_6_0.sectionProxy_ = arg_6_0.params_.sectionProxy

	arg_6_0:UpdateNextID()
	arg_6_0:RefreshUI()
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()
	arg_7_0:UnbindRedPoint()
end

function var_0_0.IndexItemAffix(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetData(arg_8_0.affixList_[arg_8_1])
end

function var_0_0.IndexItemCond(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_0.condList_[arg_9_1])
end

function var_0_0.UpdateNextID(arg_10_0)
	arg_10_0.nextIDToUnlock_ = ChipTools.GetNextCharChipIDToUnlock(arg_10_0.baseID_)
	arg_10_0.affixUnlockList_ = ChipTools.GetCharChipExtraIDListUnlock(arg_10_0.baseID_)

	if arg_10_0.nextIDToUnlock_ == 0 then
		arg_10_0.nextIDToUnlock_ = arg_10_0.affixUnlockList_[#arg_10_0.affixUnlockList_]
	end

	arg_10_0.condList_ = ChipCfg[arg_10_0.nextIDToUnlock_].module_condition
end

function var_0_0.OnActivateCharChip(arg_11_0)
	arg_11_0:UpdateNextID()
	arg_11_0:RefreshUI()
	JumpTools.OpenPageByJump("charChipPowerup", {
		baseID = arg_11_0.baseID_
	})
end

function var_0_0.RefreshUI(arg_12_0)
	local var_12_0 = ChipCfg[arg_12_0.baseID_]

	arg_12_0.charImg_.spriteSync = ChipTools.GetCharChipIcon(arg_12_0.baseID_)
	arg_12_0.charName_.text = var_12_0.suit_name
	arg_12_0.charDesc_.text = var_12_0.desc

	if arg_12_0:IsCharChipBaseUnlock(arg_12_0.baseID_) then
		local var_12_1 = #arg_12_0.affixUnlockList_

		arg_12_0.starController_:SetSelectedState(tostring(var_12_1 + 1))
		arg_12_0.lockController_:SetSelectedState("unlock")

		if #arg_12_0.affixList_ == var_12_1 then
			arg_12_0.activateBtnController_:SetSelectedState("hide")
		else
			arg_12_0.activateBtnController_:SetSelectedState(ChipTools.IsCharChipExtraCanUnlock(arg_12_0.nextIDToUnlock_) and "unLock2" or "unLock1")
		end
	else
		arg_12_0.starController_:SetSelectedState("0")
		arg_12_0.lockController_:SetSelectedState("lock")

		local var_12_2 = ChipTools.IsCharChipBaseCanUnlock(arg_12_0.baseID_)

		arg_12_0.activateBtnController_:SetSelectedState(var_12_2 and "unLock2" or "unLock1")
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.skillItems_) do
		if iter_12_0 == 1 then
			iter_12_1:SetData(arg_12_0.baseID_, arg_12_0.nextIDToUnlock_, arg_12_0.sectionProxy_)
		else
			iter_12_1:SetData(arg_12_0.affixList_[iter_12_0 - 1], arg_12_0.nextIDToUnlock_, arg_12_0.sectionProxy_)
		end
	end

	if arg_12_0.sectionProxy_ and arg_12_0.sectionProxy_:IsCharChipCanOperate() then
		-- block empty
	else
		arg_12_0:UnbindRedPoint()
	end

	if arg_12_0.sectionProxy_ ~= nil then
		if arg_12_0.sectionProxy_:IsCharChipCanOperate() then
			arg_12_0:BindRedPoint()
		else
			arg_12_0.activateBtnController_:SetSelectedState("hide")
			arg_12_0:UnbindRedPoint()
		end
	else
		arg_12_0:BindRedPoint()
	end
end

function var_0_0.IsCharChipBaseUnlock(arg_13_0, arg_13_1)
	if arg_13_0.sectionProxy_ ~= nil then
		return arg_13_0.sectionProxy_:IsCharChipBaseUnlock(arg_13_1)
	else
		return ChipTools.IsCharChipBaseUnlock(arg_13_1)
	end
end

function var_0_0.RefreshAffixList(arg_14_0)
	return
end

function var_0_0.RefreshCondList(arg_15_0)
	local var_15_0 = #arg_15_0.condList_

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.condItems_) do
		SetActive(iter_15_1.gameObject_, iter_15_0 <= var_15_0)
	end

	for iter_15_2 = 1, var_15_0 do
		local var_15_1 = arg_15_0.condItems_[iter_15_2]

		if not var_15_1 then
			local var_15_2 = Object.Instantiate(arg_15_0.condItem_, arg_15_0.condListTrans_)

			SetActive(var_15_2, true)

			var_15_1 = CharChipCondItem.New(var_15_2)
			arg_15_0.condItems_[iter_15_2] = var_15_1
		end

		arg_15_0:IndexItemCond(iter_15_2, var_15_1)
	end
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.skillItems_) do
		iter_16_1:Dispose()
	end
end

function var_0_0.BindRedPoint(arg_17_0)
	manager.redPoint:bindUIandKey(arg_17_0.unlockBtn_.transform, string.format("%s_%s", RedPointConst.CHIP_CHAR_CHIP, arg_17_0.baseID_))
end

function var_0_0.UnbindRedPoint(arg_18_0)
	manager.redPoint:unbindUIandKey(arg_18_0.unlockBtn_.transform)
end

return var_0_0
