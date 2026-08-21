local var_0_0 = class("MimirChipInfoView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.pCtrl = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.btnState = arg_1_0.btnControllerexcollection_:GetController("btn")
	arg_1_0.conditionControl = arg_1_0.conditionControllerexcollection_:GetController("clear")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0.clickItemHandler_ = handler(arg_2_0, arg_2_0.OnClickItem)

	manager.notify:RegistListener(ON_CLICK_CHIP_ITEM, arg_2_0.clickItemHandler_)
	arg_2_0:AddBtnListener(arg_2_0.btn_unlock1Btn_, nil, function()
		ShowTips("CHIP_HERO_UNLOCK_FAILED")
	end)
	arg_2_0:AddBtnListener(arg_2_0.btn_unlock2Btn_, nil, function()
		ChipAction.UnlockChip(arg_2_0.chipID)
	end)
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.OnClickItem(arg_6_0, arg_6_1)
	arg_6_0:RefreshData(arg_6_1)
end

function var_0_0.RefreshData(arg_7_0, arg_7_1)
	if not ChipCfg[arg_7_1] then
		return
	end

	arg_7_0.chipID = arg_7_1

	local var_7_0 = ChipCfg[arg_7_1]

	arg_7_0.iconchipImg_.sprite = getSpriteViaConfig("ChipSkillIcon", var_7_0.picture_id)
	arg_7_0.txt_dyn_nameText_.text = GetI18NText(var_7_0.suit_name)
	arg_7_0.textText_.text = GetI18NText(var_7_0.desc)

	local var_7_1, var_7_2, var_7_3 = IsConditionAchieved(var_7_0.new_condition)

	arg_7_0.conditiondescireText_.text = GetI18NText(ConditionCfg[var_7_0.new_condition].desc)

	local var_7_4 = arg_7_0.chipManagerDataTemplate_:GetIsUnlockChip(arg_7_1)

	if var_7_4 == false then
		if var_7_1 then
			arg_7_0.btnState:SetSelectedState("unLock2")
			arg_7_0.conditionControl:SetSelectedState("clear")
		else
			arg_7_0.btnState:SetSelectedState("unLock1")
			arg_7_0.conditionControl:SetSelectedState("notClear")
		end
	else
		arg_7_0.btnState:SetSelectedState("unlocked")
	end

	SetActive(arg_7_0.conditionGo_, not var_7_4)
end

function var_0_0.OnExit(arg_8_0)
	manager.notify:RemoveListener(ON_CLICK_CHIP_ITEM, arg_8_0.clickItemHandler_)

	arg_8_0.clickItemHandler_ = nil
end

function var_0_0.SetChipManagerID(arg_9_0, arg_9_1)
	arg_9_0.chipManagerID = arg_9_1
end

function var_0_0.SetTemplateData(arg_10_0, arg_10_1)
	arg_10_0.chipManagerDataTemplate_ = arg_10_1
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
	manager.notify:RemoveListener(ON_CLICK_CHIP_ITEM, arg_11_0.clickItemHandler_)

	arg_11_0.clickItemHandler_ = nil
	arg_11_0.pCtrl = nil
end

return var_0_0
