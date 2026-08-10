local var_0_0 = class("ChipItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.lockControl = arg_1_0.mimirchipControllerexcollection_:GetController("lock")
	arg_1_0.selectControl = arg_1_0.mimirchipControllerexcollection_:GetController("select")
	arg_1_0.equipControl = arg_1_0.mimirchipControllerexcollection_:GetController("equip")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		manager.notify:Invoke(ON_CLICK_CHIP_ITEM, arg_2_0.chipID_)
	end)
end

function var_0_0.SetChipID(arg_4_0, arg_4_1)
	arg_4_0.chipID_ = arg_4_1
end

function var_0_0.SetTemplateData(arg_5_0, arg_5_1)
	arg_5_0.chipManagerDataTemplate_ = arg_5_1
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.gameObject_.name = arg_6_0.chipID_

	local var_6_0 = ChipCfg[arg_6_0.chipID_]

	arg_6_0.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", var_6_0.picture_id)
	arg_6_0.name_.text = GetI18NText(var_6_0.suit_name)

	local var_6_1 = arg_6_0:GetUnlockChipIDList()

	if arg_6_0.chipID_ == arg_6_1 then
		arg_6_0.selectControl:SetSelectedState("yes")
	else
		arg_6_0.selectControl:SetSelectedState("no")
	end

	if arg_6_0.chipManagerDataTemplate_:GetIsUnlockChip(arg_6_0.chipID_) then
		arg_6_0.lockControl:SetSelectedState("no")
	else
		arg_6_0.lockControl:SetSelectedState("yes")
	end

	if arg_6_0.chipManagerDataTemplate_:GetIsUesChipID(arg_6_0.chipID_) then
		arg_6_0.equipControl:SetSelectedState("yes")
	else
		arg_6_0.equipControl:SetSelectedState("no")
	end

	if arg_6_0.chipManagerDataTemplate_ and not arg_6_0.chipManagerDataTemplate_.isNoRed then
		arg_6_0:BindRedPoint()
	end
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:UnbindRedPoint()
	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.GetUnlockChipIDList(arg_8_0)
	return ChipData:GetUnlockChipIDList()
end

function var_0_0.BindRedPoint(arg_9_0)
	manager.redPoint:bindUIandKey(arg_9_0.notice_, string.format("%s_%s", RedPointConst.CHIP_CHIP, arg_9_0.chipID_), {
		x = 0,
		y = 0
	})
end

function var_0_0.UnbindRedPoint(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.notice_)
end

return var_0_0
