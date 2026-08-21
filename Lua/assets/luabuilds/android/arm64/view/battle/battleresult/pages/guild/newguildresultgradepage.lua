local var_0_0 = class("NewGuildResultGradePage", import("..NewBattleResultGradePage"))

function var_0_0.LoadBG(arg_1_0, arg_1_1)
	LoadAnyAsync("BattleResultItems/" .. "Victory", "", nil, function(arg_2_0)
		if arg_1_0.exited or IsNil(arg_2_0) then
			if arg_1_1 then
				arg_1_1()
			end

			return
		end

		Object.Instantiate(arg_2_0, arg_1_0.bgTr).transform:SetAsFirstSibling()

		if arg_1_1 then
			arg_1_1()
		end

		return
	end)

	return
end

function var_0_0.LoadGrade(arg_3_0, arg_3_1)
	LoadImageSpriteAsync("battlescore/grade_label_clear", arg_3_0.gradeTxt, true)

	if arg_3_1 then
		arg_3_1()
	end

	return
end

function var_0_0.GetContributionPoint(arg_4_0)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.contextData.drops) do
		if iter_4_1.configId == pg.guildset.guild_damage_resource.key_value then
			var_4_0 = iter_4_1.count
		end
	end

	return var_4_0
end

function var_0_0.GetGetObjectives(arg_5_0)
	table.insert({}, {
		text = setColorStr(i18n("battle_result_total_damage"), "#FFFFFFFF"),
		value = setColorStr(arg_5_0.contextData.statistics.specificDamage, COLOR_BLUE)
	})
	table.insert({}, {
		text = setColorStr(i18n("battle_result_contribution"), "#FFFFFFFF"),
		value = setColorStr(arg_5_0:GetContributionPoint(), COLOR_YELLOW)
	})

	return {}
end

return var_0_0
