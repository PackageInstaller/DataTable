local NewGuildResultGradePage = class("NewGuildResultGradePage", import("..NewBattleResultGradePage"))

function NewGuildResultGradePage:LoadBG(arg_1_1)
	LoadAnyAsync("BattleResultItems/" .. "Victory", "", nil, function(arg_2_0)
		if self.exited or IsNil(arg_2_0) then
			if arg_1_1 then
				arg_1_1()
			end

			return
		end

		Object.Instantiate(arg_2_0, self.bgTr).transform:SetAsFirstSibling()

		if arg_1_1 then
			arg_1_1()
		end

		return
	end)

	return
end

function NewGuildResultGradePage:LoadGrade(arg_3_1)
	LoadImageSpriteAsync("battlescore/grade_label_clear", self.gradeTxt, true)

	if arg_3_1 then
		arg_3_1()
	end

	return
end

function NewGuildResultGradePage:GetContributionPoint()
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(self.contextData.drops) do
		if iter_4_1.configId == pg.guildset.guild_damage_resource.key_value then
			var_4_0 = iter_4_1.count
		end
	end

	return var_4_0
end

function NewGuildResultGradePage:GetGetObjectives()
	local var_5_0 = {}

	table.insert(var_5_0, {
		text = setColorStr(i18n("battle_result_total_damage"), "#FFFFFFFF"),
		value = setColorStr(self.contextData.statistics.specificDamage, COLOR_BLUE)
	})
	table.insert(var_5_0, {
		text = setColorStr(i18n("battle_result_contribution"), "#FFFFFFFF"),
		value = setColorStr(self:GetContributionPoint(), COLOR_YELLOW)
	})

	return var_5_0
end

return NewGuildResultGradePage
