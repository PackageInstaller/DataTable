local NewHpShareActBossResultGradePage = class("NewHpShareActBossResultGradePage", import("..activityBoss.NewActivityBossResultGradePage"))

function NewHpShareActBossResultGradePage:LoadGrade(arg_1_1)
	LoadImageSpriteAsync("battlescore/grade_label_clear", self.gradeTxt, true)

	if arg_1_1 then
		arg_1_1()
	end

	return
end

function NewHpShareActBossResultGradePage:GetContributionPoint()
	local var_2_0 = 0

	for iter_2_0, iter_2_1 in ipairs(self.contextData.drops) do
		if iter_2_1.configId == pg.activity_event_worldboss[pg.activity_template[self.contextData.actId].config_id].damage_resource then
			var_2_0 = iter_2_1.count
		end
	end

	return var_2_0
end

function NewHpShareActBossResultGradePage:GetGetObjectives()
	local var_3_0 = {}

	table.insert(var_3_0, {
		text = setColorStr(i18n("battle_result_total_damage"), "#FFFFFFFF"),
		value = setColorStr(self.contextData.statistics.specificDamage, COLOR_BLUE)
	})
	table.insert(var_3_0, {
		text = setColorStr(i18n("battle_result_contribution"), "#FFFFFFFF"),
		value = setColorStr(self:GetContributionPoint(), COLOR_YELLOW)
	})

	return var_3_0
end

return NewHpShareActBossResultGradePage
