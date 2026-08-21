local var_0_0 = class("CanteenGainItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)

	SetActive(arg_1_0.gameObject_, true)

	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1)
	local var_3_0

	if arg_3_1.skillType == CanteenConst.HeroSkillType.FoodCostQucik or arg_3_1.skillType == CanteenConst.HeroSkillType.FoodCostRise then
		local var_3_1 = arg_3_1.foodType
		local var_3_2 = DormSkillData:GetSkillEffect(arg_3_1.skillType, nil, nil, var_3_1)
		local var_3_3 = CanteenTools:GetFootTypeName(var_3_1)

		var_3_0 = string.format(GetI18NText(BackHomeHeroSkillDescCfg[arg_3_1.skillType].desc), tostring(var_3_3))

		local var_3_4

		if var_3_2 > 0 then
			var_3_4 = string.format(GetI18NText(BackHomeHeroSkillDescCfg[arg_3_1.skillType].pos_desc), string.format("<color=#e48a00>" .. var_3_2 .. "</color>"))
		else
			local var_3_5 = -var_3_2

			var_3_4 = string.format(GetI18NText(BackHomeHeroSkillDescCfg[arg_3_1.skillType].neg_desc), string.format("<color=#e48a00>" .. var_3_5 .. "</color>"))
		end

		var_3_0 = var_3_0 .. var_3_4
	elseif arg_3_1.skillType == CanteenConst.HeroSkillType.PopularRise then
		local var_3_6 = DormSkillData:GetSkillEffect(arg_3_1.skillType)

		var_3_0 = GetI18NText(BackHomeHeroSkillDescCfg[arg_3_1.skillType].desc)

		local var_3_7

		if var_3_6 > 0 then
			var_3_7 = string.format(GetI18NText(BackHomeHeroSkillDescCfg[arg_3_1.skillType].pos_desc), string.format("<color=#e48a00>" .. var_3_6 .. "</color>"))
		else
			local var_3_8 = -var_3_6

			var_3_7 = string.format(GetI18NText(BackHomeHeroSkillDescCfg[arg_3_1.skillType].neg_desc), string.format("<color=#e48a00>" .. var_3_8 .. "</color>"))
		end

		var_3_0 = var_3_0 .. var_3_7
	end

	arg_3_0.desc.text = var_3_0
end

function var_0_0.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
