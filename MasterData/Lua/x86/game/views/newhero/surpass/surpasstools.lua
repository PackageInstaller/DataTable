return {
	GetSmallStageShow = function(arg_1_0)
		local var_1_0 = table.indexof(HeroStarCfg.get_id_list_by_star[HeroStarCfg[arg_1_0].star], arg_1_0) - 1

		if var_1_0 == 1 then
			return "I"
		elseif var_1_0 == 2 then
			return "Ⅱ"
		elseif var_1_0 == 3 then
			return "Ⅲ"
		elseif var_1_0 == 4 then
			return "Ⅳ"
		end

		return ""
	end,
	UpdateSliImageFill = function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = 0

		for iter_2_0, iter_2_1 in pairs(HeroStarCfg.get_id_list_by_star[arg_2_1]) do
			if HeroStarCfg[iter_2_1].phase > 0 and iter_2_1 <= arg_2_2 then
				var_2_0 = var_2_0 + 1
			end
		end

		arg_2_0.fillAmount = var_2_0 / 4
	end,
	GetNextSurpassStarID = function(arg_3_0)
		return HeroStarCfg.all[table.indexof(HeroStarCfg.all, arg_3_0) + 1] or arg_3_0 + 1
	end,
	ChangeIconStarSpirte = function(arg_4_0, arg_4_1)
		arg_4_0.sprite = getSprite("Atlas/Common", "star_" .. arg_4_1)
	end,
	GetStarUpAttrShowDesc = function(self, arg_5_1, arg_5_2)
		local var_5_0 = {}

		for iter_5_0, iter_5_1 in ipairs(HeroStarUpTemplateCfg.get_id_list_by_template[self.star_up_skill_template]) do
			if HeroStarUpTemplateCfg[iter_5_1].stage == arg_5_1 then
				var_5_0 = HeroStarSkillCfg[HeroStarUpTemplateCfg[iter_5_1].skill_id]

				break
			end
		end

		local var_5_1 = {}
		local var_5_2 = {}
		local var_5_3 = ""

		if var_5_0.type == HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP then
			for iter_5_2, iter_5_3 in pairs(var_5_0.params) do
				local var_5_4 = iter_5_3[1]
				local var_5_5 = PublicAttrCfg[iter_5_3[1]]
				local var_5_6 = PublicAttrCfg[iter_5_3[1]].percent == 1 and string.format("+%.2f", iter_5_3[2] / 10) .. "%" or string.format("+%.0f", iter_5_3[2])

				if not arg_5_2 then
					desc = string.format("%s%s", GetI18NText(var_5_5.name), var_5_6)

					table.insert(var_5_2, desc)
				end

				table.insert(var_5_1, {
					attrId = var_5_4,
					value = var_5_6
				})
			end
		elseif var_5_0.type == HeroConst.HERO_STAR_SKILL_TYPE.SKILL_UP then
			if var_5_0.params[1] then
				table.insert(var_5_2, (string.format(GetI18NText(var_5_0.desc), GetI18NText(self.skill_subhead[var_5_0.params[1][1]]), string.format("<color=#297de0>%s</color>", GetI18NText(HeroSkillCfg[self.skills[var_5_0.params[1][1]]].name)), var_5_0.params[1][2])))
			else
				var_5_3 = GetI18NText(var_5_0.desc)

				table.insert(var_5_2, GetI18NText(var_5_0.desc))
			end
		else
			var_5_3 = var_5_0 and GetI18NText(var_5_0.desc) or ""
		end

		return var_5_2, var_5_3, var_5_0, var_5_1
	end
}
