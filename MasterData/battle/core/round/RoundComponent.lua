local var_0_0 = load("core.rule.BuffRule")
local var_0_1 = load("core.rule.SkillSpecialRule")

return {
	roundStart = function(self)
		local var_1_0 = {
			comboValue = {}
		}

		for iter_1_0 = 1, 2 do
			var_1_0.comboValue[iter_1_0] = self:updateComboValue(self:getComboInfo(iter_1_0).baseInfo.COMBO_RECOVER_ROUND, iter_1_0)
		end

		var_1_0.cdList = self:updateComboSkills()

		self:setRoundFinish(false)

		var_1_0.succubaCdList = self:updateSuccubaSkills()
		var_1_0.sceneRemoveList = self:doSceneRound()

		local var_1_1 = {}

		for iter_1_1, iter_1_2 in ipairs((self:getKnightList(nil, true))) do
			for iter_1_3, iter_1_4 in ipairs((iter_1_2:doBuffRound(var_0_0.ROUND.ROUND_START))) do
				table.insert(var_1_1, iter_1_4)
			end

			iter_1_2.actionWarBand = true
			iter_1_2.actionFailWarBand = true
			iter_1_2.hitWarBand = true
		end

		if #var_1_1 > 0 then
			self:executeSpRule(var_0_1.TYPE.BUFF_REMOVE, var_1_1)
			self:executeKnightSpRule(var_0_1.TYPE.BUFF_REMOVE, var_1_1)
		end

		var_1_0.removeList = var_1_1

		return var_1_0
	end
}
