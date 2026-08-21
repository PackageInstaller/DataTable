return {
	GetSmallStageShow = function(arg_1_0)
		local var_1_0 = HeroStarCfg[arg_1_0].star
		local var_1_1 = table.indexof(HeroStarCfg.get_id_list_by_star[var_1_0], arg_1_0) - 1

		if var_1_1 == 1 then
			return "I"
		elseif var_1_1 == 2 then
			return "Ⅱ"
		elseif var_1_1 == 3 then
			return "Ⅲ"
		elseif var_1_1 == 4 then
			return "Ⅳ"
		end

		return ""
	end,
	UpdateSliImageFill = function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = HeroStarCfg.get_id_list_by_star[arg_2_1]
		local var_2_1 = 0

		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if HeroStarCfg[iter_2_1].phase > 0 and iter_2_1 <= arg_2_2 then
				var_2_1 = var_2_1 + 1
			end
		end

		arg_2_0.fillAmount = var_2_1 / 4
	end,
	GetNextSurpassStarID = function(arg_3_0)
		local var_3_0 = table.indexof(HeroStarCfg.all, arg_3_0) + 1

		return HeroStarCfg.all[var_3_0] or arg_3_0 + 1
	end,
	ChangeIconStarSpirte = function(arg_4_0, arg_4_1)
		arg_4_0.sprite = getSprite("Atlas/Common", "star_" .. arg_4_1)
	end,
	GetStarUpAttrShowDesc = function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_5_0.star_up_skill_template
		local var_5_1 = HeroStarUpTemplateCfg.get_id_list_by_template[var_5_0]
		local var_5_2 = {}

		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			local var_5_3 = HeroStarUpTemplateCfg[iter_5_1]

			if var_5_3.stage == arg_5_1 then
				local var_5_4 = var_5_3.skill_id

				var_5_2 = HeroStarSkillCfg[var_5_4]

				break
			end
		end

		local var_5_5 = {}
		local var_5_6 = {}
		local var_5_7 = ""

		if var_5_2.type == HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP then
			local var_5_8 = var_5_2.params

			for iter_5_2, iter_5_3 in pairs(var_5_8) do
				local var_5_9 = iter_5_3[1]
				local var_5_10 = iter_5_3[2]
				local var_5_11 = PublicAttrCfg[var_5_9]
				local var_5_12 = var_5_11.percent == 1 and string.format("+%.2f", var_5_10 / 10) .. "%" or string.format("+%.0f", var_5_10)

				if not arg_5_2 then
					desc = string.format("%s%s", GetI18NText(var_5_11.name), var_5_12)

					table.insert(var_5_6, desc)
				end

				table.insert(var_5_5, {
					attrId = var_5_9,
					value = var_5_12
				})
			end
		elseif var_5_2.type == HeroConst.HERO_STAR_SKILL_TYPE.SKILL_UP then
			if var_5_2.params[1] then
				local var_5_13 = var_5_2.params[1]
				local var_5_14 = arg_5_0.skill_subhead[var_5_13[1]]
				local var_5_15 = arg_5_0.skills[var_5_13[1]]
				local var_5_16 = HeroSkillCfg[var_5_15].name
				local var_5_17 = string.format("<color=#297de0>%s</color>", GetI18NText(var_5_16))
				local var_5_18 = string.format(GetI18NText(var_5_2.desc), GetI18NText(var_5_14), var_5_17, var_5_13[2])

				table.insert(var_5_6, var_5_18)
			else
				var_5_7 = GetI18NText(var_5_2.desc)

				table.insert(var_5_6, GetI18NText(var_5_2.desc))
			end
		else
			var_5_7 = var_5_2 and GetI18NText(var_5_2.desc) or ""
		end

		return var_5_6, var_5_7, var_5_2, var_5_5
	end
}
