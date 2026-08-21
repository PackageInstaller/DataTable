local var_0_0 = class("AdminMimirChipItem", AdminChipBaseItem)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.lockControl_ = arg_1_0.conEx_:GetController("lock")
	arg_1_0.selectControl_ = arg_1_0.conEx_:GetController("Select")
	arg_1_0.useControl_ = arg_1_0.conEx_:GetController("subscript")
	arg_1_0.posControl_ = arg_1_0.conEx_:GetController("role")
	arg_1_0.selected_ = false
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.selectBtn_, nil, function()
		manager.notify:CallUpdateFunc("OnClickMimirItem", arg_2_0, arg_2_0.chipManagerID_)
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0.chipManagerID_ = arg_4_1
	arg_4_0.index_ = arg_4_2
	arg_4_0.animInfo_ = arg_4_4

	arg_4_0:Show(true)
	arg_4_0:RefreshUI(arg_4_3)
end

function var_0_0.GetItemHeight(arg_5_0)
	if arg_5_0.selected_ then
		return arg_5_0.posTrs_.sizeDelta.x + arg_5_0.descTrs_.sizeDelta.x
	else
		return arg_5_0.posTrs_.sizeDelta.x
	end
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	arg_6_0.gameObject_.name = arg_6_0.chipManagerID_

	local var_6_0 = ChipCfg[arg_6_0.chipManagerID_]

	arg_6_0.nameText_.text = var_6_0.suit_name
	arg_6_0.descText_.text = var_6_0.desc
	arg_6_0.mimirImg_.spriteSync = ChipTools.GetChipManagerIconPath(arg_6_0.chipManagerID_)

	if arg_6_0.posControl_ then
		arg_6_0.posControl_:SetSelectedState(tostring(arg_6_0.chipManagerID_))
	end

	local var_6_1 = arg_6_0:GetUnlockChipManagerList()
	local var_6_2 = table.keyof(var_6_1, arg_6_0.chipManagerID_) == nil
	local var_6_3 = arg_6_0.chipManagerDataTemplate_:GetISUseChipmanager(arg_6_0.chipManagerID_)

	arg_6_0.selectControl_:SetSelectedState(arg_6_1 and "selected" or "unselected")

	if var_6_2 then
		if IsConditionAchieved(var_6_0.new_condition) then
			arg_6_0.lockControl_:SetSelectedState("Mewlock")
		else
			arg_6_0.lockControl_:SetSelectedState("locked")
		end
	else
		arg_6_0.lockControl_:SetSelectedState("unlock")
	end

	arg_6_0.useControl_:SetSelectedState(var_6_3 and "equiped" or "unequiped")

	if arg_6_0.chipManagerDataTemplate_ and not arg_6_0.chipManagerDataTemplate_.isNoRed then
		arg_6_0:BindRedPoint()
	end

	local var_6_4 = arg_6_1 and "MewItem_expand" or "MewItem_fold"

	arg_6_0:UpdateAnim(arg_6_1, var_6_4)

	arg_6_0.selected_ = arg_6_1
end

function var_0_0.SetTemplateData(arg_7_0, arg_7_1)
	arg_7_0.chipManagerDataTemplate_ = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:UnbindRedPoint()
	var_0_0.super.Dispose(arg_8_0)
	manager.notify:RemoveListener(ENABLED_CHIP_MANAGER, arg_8_0.handler_)

	arg_8_0.handler_ = nil

	Object.Destroy(arg_8_0.gameObject_)

	arg_8_0.gameObject_ = nil
	arg_8_0.transform_ = nil
end

function var_0_0.GetUnlockChipManagerList(arg_9_0)
	return arg_9_0.chipManagerDataTemplate_.unlockChipManagerIDList_
end

function var_0_0.GetEnabledChipManagerID(arg_10_0)
	return ChipData:GetEnabledChipManagerID()
end

function var_0_0.BindRedPoint(arg_11_0)
	manager.redPoint:bindUIandKey(arg_11_0.notice_, string.format("%s_%s", RedPointConst.CHIP_MANAGER, arg_11_0.chipManagerID_))
end

function var_0_0.UnbindRedPoint(arg_12_0)
	manager.redPoint:unbindUIandKey(arg_12_0.notice_)
end

return var_0_0
