ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffCastSkillRandom = class("BattleBuffCastSkillRandom", ys.Battle.BattleBuffCastSkill)
ys.Battle.BattleBuffCastSkillRandom.__name = "BattleBuffCastSkillRandom"

local var_0_2 = ys.Battle.BattleBuffCastSkillRandom

function ys.Battle.BattleBuffCastSkillRandom.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._skillList = {}

	return
end

function ys.Battle.BattleBuffCastSkillRandom:spell(arg_2_1, arg_2_2)
	if self._tempData.arg_list.skill_id_list then
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(self._tempData.arg_list.skill_id_list) do
			var_2_0[iter_2_1] = self._tempData.arg_list.range[iter_2_0]
		end

		local var_2_1 = math.random()

		for iter_2_2, iter_2_3 in pairs(var_2_0) do
			if iter_2_3[1] <= var_2_1 and var_2_1 < iter_2_3[2] then
				self._skillList[iter_2_2] = self._skillList[iter_2_2] or var_0_0.Battle.BattleSkillUnit.GenerateSpell(iter_2_2, self._level, arg_2_1, attData)

				if arg_2_2 and arg_2_2.target then
					self._skillList[iter_2_2]:SetTarget({
						arg_2_2.target
					})
				end

				self._skillList[iter_2_2]:Cast(arg_2_1, self._commander)
			end
		end
	elseif self._tempData.arg_list.random_skill_tag then
		local var_2_2 = {}

		for iter_2_4, iter_2_5 in ipairs((arg_2_1:GetLabelTag())) do
			local var_2_3, var_2_4 = string.find(iter_2_5, self._tempData.arg_list.random_skill_tag)

			if var_2_3 then
				local var_2_5 = tonumber(string.sub(iter_2_5, var_2_4 + 1, #iter_2_5))

				if not table.contains(var_2_2, var_2_5) then
					table.insert(var_2_2, var_2_5)
				end
			end
		end

		if #var_2_2 > 0 then
			local var_2_6 = var_2_2[math.random(#var_2_2)]

			self._skillList[var_2_6] = self._skillList[var_2_6] or var_0_0.Battle.BattleSkillUnit.GenerateSpell(var_2_6, self._level, arg_2_1, attData)

			if arg_2_2 and arg_2_2.target then
				self._skillList[var_2_6]:SetTarget({
					arg_2_2.target
				})
			end

			self._skillList[var_2_6]:Cast(arg_2_1, self._commander)
		end
	end

	return
end

function ys.Battle.BattleBuffCastSkillRandom:Clear()
	var_0_2.super.Clear(self)

	for iter_3_0, iter_3_1 in pairs(self._skillList) do
		iter_3_1:Clear()
	end

	return
end

return
