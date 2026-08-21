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

function ys.Battle.BattleBuffCastSkillRandom.spell(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._tempData.arg_list.skill_id_list then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0._tempData.arg_list.skill_id_list) do
			({})[iter_2_1] = arg_2_0._tempData.arg_list.range[iter_2_0]
		end

		local var_2_0 = math.random()

		for iter_2_2, iter_2_3 in pairs({}) do
			if iter_2_3[1] <= var_2_0 and var_2_0 < iter_2_3[2] then
				arg_2_0._skillList[iter_2_2] = arg_2_0._skillList[iter_2_2] or var_0_0.Battle.BattleSkillUnit.GenerateSpell(iter_2_2, arg_2_0._level, arg_2_1, attData)

				if arg_2_2 and arg_2_2.target then
					arg_2_0._skillList[iter_2_2]:SetTarget({
						arg_2_2.target
					})
				end

				arg_2_0._skillList[iter_2_2]:Cast(arg_2_1, arg_2_0._commander)
			end
		end
	elseif arg_2_0._tempData.arg_list.random_skill_tag then
		for iter_2_4, iter_2_5 in ipairs((arg_2_1:GetLabelTag())) do
			local var_2_1, var_2_2 = string.find(iter_2_5, arg_2_0._tempData.arg_list.random_skill_tag)

			if var_2_1 then
				local var_2_3 = tonumber(string.sub(iter_2_5, var_2_2 + 1, #iter_2_5))

				if not table.contains({}, var_2_3) then
					table.insert({}, var_2_3)
				end
			end
		end

		if #{} > 0 then
			local var_2_4 = ({})[math.random(#{})]

			arg_2_0._skillList[var_2_4] = arg_2_0._skillList[var_2_4] or var_0_0.Battle.BattleSkillUnit.GenerateSpell(var_2_4, arg_2_0._level, arg_2_1, attData)

			if arg_2_2 and arg_2_2.target then
				arg_2_0._skillList[var_2_4]:SetTarget({
					arg_2_2.target
				})
			end

			arg_2_0._skillList[var_2_4]:Cast(arg_2_1, arg_2_0._commander)
		end
	end

	return
end

function ys.Battle.BattleBuffCastSkillRandom.Clear(arg_3_0)
	var_0_2.super.Clear(arg_3_0)

	for iter_3_0, iter_3_1 in pairs(arg_3_0._skillList) do
		iter_3_1:Clear()
	end

	return
end

return
