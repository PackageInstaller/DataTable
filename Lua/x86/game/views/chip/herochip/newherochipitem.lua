local var_0_0 = class("NewHeroChipItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.selectController_ = arg_1_0.transform_:GetComponent("ControllerExCollection"):GetController("select")
	arg_1_0.lockController_ = arg_1_0.transform_:GetComponent("ControllerExCollection"):GetController("lock")
	arg_1_0.equipController_ = arg_1_0.transform_:GetComponent("ControllerExCollection"):GetController("equip")

	arg_1_0:AddListeners()
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if arg_2_0.clickFunc_ then
			arg_2_0.clickFunc_(arg_2_0.chipID_)
		end
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.chipID_ = arg_4_1
	arg_4_0.curChipID_ = arg_4_2

	arg_4_0:RefreshUI()
end

function var_0_0.SetCallBack(arg_5_0, arg_5_1)
	arg_5_0.clickFunc_ = arg_5_1
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = ChipCfg[arg_6_0.chipID_]

	arg_6_0.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", var_6_0.picture_id)
	arg_6_0.name_.text = var_6_0.suit_name

	arg_6_0:RefreshStatus()
	arg_6_0:BindRedPoint()
end

function var_0_0.RefreshStatus(arg_7_0)
	if ChipData:GetIsUnlockHeroChip(arg_7_0.chipID_) then
		arg_7_0.lockController_:SetSelectedState("no")
	else
		arg_7_0.lockController_:SetSelectedState("yes")
	end

	local var_7_0, var_7_1 = ChipData:GetHeroChipIsEnableByChipId(arg_7_0.chipID_)

	if var_7_0 then
		arg_7_0.equipController_:SetSelectedState("yes")
	else
		arg_7_0.equipController_:SetSelectedState("no")
	end

	if arg_7_0.chipID_ == arg_7_0.curChipID_ then
		arg_7_0.selectController_:SetSelectedState("yes")
	else
		arg_7_0.selectController_:SetSelectedState("no")
	end
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:UnbindRedPoint()
	var_0_0.super.Dispose(arg_8_0)

	arg_8_0.clickFunc_ = nil
end

function var_0_0.BindRedPoint(arg_9_0)
	local var_9_0 = ChipCfg[arg_9_0.chipID_]
	local var_9_1

	if ChipCfg[arg_9_0.chipID_].cost_condition ~= "" then
		var_9_1 = RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. var_9_0.spec_char .. "_" .. var_9_0.role_type_id .. "_" .. arg_9_0.chipID_
	else
		var_9_1 = RedPointConst.CHIP_HERO_CHIP .. "_" .. var_9_0.spec_char .. "_" .. var_9_0.role_type_id .. "_" .. arg_9_0.chipID_
	end

	manager.redPoint:bindUIandKey(arg_9_0.redPoint_, var_9_1)
end

function var_0_0.UnbindRedPoint(arg_10_0)
	local var_10_0 = ChipCfg[arg_10_0.chipID_]
	local var_10_1

	if ChipCfg[arg_10_0.chipID_].cost_condition ~= "" then
		var_10_1 = RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. var_10_0.spec_char .. "_" .. var_10_0.role_type_id .. "_" .. arg_10_0.chipID_
	else
		var_10_1 = RedPointConst.CHIP_HERO_CHIP .. "_" .. var_10_0.spec_char .. "_" .. var_10_0.role_type_id .. "_" .. arg_10_0.chipID_
	end

	manager.redPoint:unbindUIandKey(arg_10_0.redPoint_, var_10_1)
end

return var_0_0
