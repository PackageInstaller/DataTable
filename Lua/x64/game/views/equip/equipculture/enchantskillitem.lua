local var_0_0 = class("EnchantSkillItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectController_ = arg_2_0.transCon_:GetController("select")
	arg_2_0.lockController_ = arg_2_0.transCon_:GetController("lock")
	arg_2_0.nullController_ = arg_2_0.transCon_:GetController("null")
	arg_2_0.popController_ = arg_2_0.transCon_:GetController("pop")
	arg_2_0.downLvController_ = arg_2_0.transCon_:GetController("level1")
	arg_2_0.leftLvController_ = arg_2_0.transCon_:GetController("level2")

	arg_2_0:AddBtnListener(nil, nil, "OnClick")
end

function var_0_0.RefreshData(arg_3_0, arg_3_1)
	arg_3_0.info_ = arg_3_1

	arg_3_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_4_0)
	if arg_4_0.info_ then
		local var_4_0 = EquipSkillCfg[arg_4_0.info_.id]

		arg_4_0.nullController_:SetSelectedState("skill")

		if arg_4_0.info_.preview then
			arg_4_0.lockController_:SetSelectedState("unlock")
			arg_4_0.popController_:SetSelectedState("pop")
			arg_4_0.downLvController_:SetSelectedState("off")
			arg_4_0.leftLvController_:SetSelectedState("showMax")

			arg_4_0.lvMax_.text = var_4_0.lvmax
		elseif arg_4_0.info_.total then
			arg_4_0.lockController_:SetSelectedState("unlock")
			arg_4_0.popController_:SetSelectedState("pop")
			arg_4_0.downLvController_:SetSelectedState("off")
			arg_4_0.leftLvController_:SetSelectedState("showNum")

			arg_4_0.lvMax_ = var_4_0.lvmax
		elseif arg_4_0.info_.unlockLevel and arg_4_0.info_.equipLevel < arg_4_0.info_.unlockLevel then
			arg_4_0.lockController_:SetSelectedState("lock")

			arg_4_0.lockDesc_.text = string.format(GetTips("EQUIP_SKILL_LOCK_LEVEL"), arg_4_0.info_.unlockLevel)
		else
			arg_4_0.lockController_:SetSelectedState("unlock")
		end

		arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. var_4_0.icon)
		arg_4_0.name_.text = GetI18NText(var_4_0.name)

		local var_4_1 = arg_4_0.info_.num > var_4_0.lvmax and string.format("<color=#FF000B>%s</color>", arg_4_0.info_.num) or arg_4_0.info_.num

		arg_4_0.lv1_.text = string.format("%s/%s", var_4_1, var_4_0.lvmax)

		if arg_4_0.lv2_ then
			arg_4_0.lv2_.text = string.format("%s/%s", var_4_1, var_4_0.lvmax)
		end

		local var_4_2 = arg_4_0.info_.num > var_4_0.lvmax and var_4_0.lvmax or arg_4_0.info_.num
		local var_4_3 = var_4_0.upgrade / var_4_0.percent * var_4_2
		local var_4_4 = GetCfgDescriptionWithValue(var_4_0.desc[1], tostring(var_4_3))

		if var_4_0.desc_spec_value ~= nil and var_4_0.desc_spec_value ~= "" then
			var_4_4 = string.gsub(var_4_4, tostring(var_4_3), var_4_0.desc_spec_value[arg_4_0.info_.num])
		end

		arg_4_0.desc_.text = GetI18NText(var_4_4)
	else
		arg_4_0.nullController_:SetSelectedState("null")
	end
end

function var_0_0.ShowSelect(arg_5_0, arg_5_1)
	arg_5_0.selectController_:SetSelectedState(arg_5_1 and "select" or "unselect")
end

function var_0_0.OnClick(arg_6_0)
	if arg_6_0.info_ and arg_6_0.clickFunc then
		arg_6_0.clickFunc(arg_6_0, arg_6_0.info_)
	end
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickFunc = arg_7_1
end

function var_0_0.GetItemInfo(arg_8_0)
	return arg_8_0.info_
end

function var_0_0.Show(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.clickFunc = nil

	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
