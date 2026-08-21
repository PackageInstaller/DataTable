local var_0_0 = class("NewHpShareActBossResultGradePage", import("..activityBoss.NewActivityBossResultGradePage"))

function var_0_0.LoadGrade(arg_1_0, arg_1_1)
	LoadImageSpriteAsync("battlescore/grade_label_clear", arg_1_0.gradeTxt, true)

	if arg_1_1 then
		arg_1_1()
	end

	return
end

function var_0_0.GetContributionPoint(arg_2_0)
	local var_2_0 = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.contextData.drops) do
		if iter_2_1.configId == pg.activity_event_worldboss[pg.activity_template[arg_2_0.contextData.actId].config_id].damage_resource then
			var_2_0 = iter_2_1.count
		end
	end

	return var_2_0
end

function var_0_0.GetGetObjectives(arg_3_0)
	table.insert({}, {
		text = setColorStr(i18n("battle_result_total_damage"), "#FFFFFFFF"),
		value = setColorStr(arg_3_0.contextData.statistics.specificDamage, COLOR_BLUE)
	})
	table.insert({}, {
		text = setColorStr(i18n("battle_result_contribution"), "#FFFFFFFF"),
		value = setColorStr(arg_3_0:GetContributionPoint(), COLOR_YELLOW)
	})

	return {}
end

return var_0_0
