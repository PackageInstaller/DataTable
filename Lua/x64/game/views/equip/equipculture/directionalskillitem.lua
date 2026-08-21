local var_0_0 = class("DirectionalSkillItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.recommendController_ = arg_2_0.transCon_:GetController("recommend")
	arg_2_0.selectController_ = arg_2_0.transCon_:GetController("select")

	arg_2_0:AddBtnListener(nil, nil, "OnClick")
	arg_2_0:RegistEventListener(DIRECTIONAL_ENCHANT_SLOT_CHANGE, handler(arg_2_0, arg_2_0.OnSlotChange))
end

function var_0_0.RefreshData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.info_ = arg_3_1
	arg_3_0.heroId_ = arg_3_2

	arg_3_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_4_0)
	if arg_4_0.info_ then
		local var_4_0 = EquipSkillCfg[arg_4_0.info_.id]

		arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. var_4_0.icon)
		arg_4_0.nameText_.text = GetI18NText(var_4_0.name)

		local var_4_1 = arg_4_0.info_.num > var_4_0.lvmax and string.format("<color=#FF000B>%s</color>", arg_4_0.info_.num) or arg_4_0.info_.num

		arg_4_0.levelText_.text = string.format("%s/%s", var_4_1, var_4_0.lvmax)

		local var_4_2 = arg_4_0.info_.num > var_4_0.lvmax and var_4_0.lvmax or arg_4_0.info_.num
		local var_4_3 = var_4_0.upgrade / var_4_0.percent * var_4_2
		local var_4_4 = GetCfgDescriptionWithValue(var_4_0.desc[1], tostring(var_4_3))

		if var_4_0.desc_spec_value ~= nil and var_4_0.desc_spec_value ~= "" then
			var_4_4 = string.gsub(var_4_4, tostring(var_4_3), var_4_0.desc_spec_value[arg_4_0.info_.num])
		end

		arg_4_0.descText_.text = GetI18NText(var_4_4)

		arg_4_0.recommendController_:SetSelectedState(arg_4_0.info_.recommendLevel)
	end
end

function var_0_0.ShowSelect(arg_5_0, arg_5_1)
	arg_5_0.selectController_:SetSelectedState(arg_5_1 and "select" or "unselect")
end

function var_0_0.OnClick(arg_6_0)
	if arg_6_0.info_ and arg_6_0.clickFunc then
		arg_6_0.clickFunc(arg_6_0, arg_6_0.info_.id)
	end
end

function var_0_0.OnSlotChange(arg_7_0)
	arg_7_0.animator_:Play("Fx_Common_alpha_cx 1", -1, 0)
end

function var_0_0.RegisterClickFunc(arg_8_0, arg_8_1)
	arg_8_0.clickFunc = arg_8_1
end

function var_0_0.GetItemInfo(arg_9_0)
	return arg_9_0.info_
end

function var_0_0.Show(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.clickFunc = nil

	arg_11_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
