ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleAttr
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleBuffCastSkillRandom = var_0_10003("BattleBuffCastSkillRandom", var_0.Battle.BattleBuffCastSkill)
var_0.Battle.BattleBuffCastSkillRandom.__name = "BattleBuffCastSkillRandom"

local var_0_3 = var_0.Battle.BattleBuffCastSkillRandom

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._skillList = {}

	return
end

function var_0_3.spell(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._tempData.arg_list.skill_id_list then
		local var_2_0 = {}
		local var_2_1 = var_3.range

		ipairs = var_1_10006

		for iter_2_0, iter_2_1 in var_1_10006(var_3.skill_id_list) do
			var_2_0[iter_2_1] = var_2_1[iter_2_0]
		end

		math = var_6

		local var_2_2 = var_6.random()

		pairs = var_1_10007

		for iter_2_2, iter_2_3 in var_1_10007(var_2_0) do
			var_1_10012 = iter_2_3[1]
			var_1_10013 = iter_2_3[2]

			if var_1_10012 <= var_2_2 and var_2_2 < var_1_10013 then
				local var_2_3 = arg_2_0._skillList

				if not arg_2_0._skillList[iter_2_2] then
					var_1_10015 = var_0.Battle.BattleSkillUnit.GenerateSpell

					local var_2_4 = iter_2_2
					local var_2_5 = arg_2_0._level
					local var_2_6 = arg_2_1

					attData = var_1_10019
					var_1_10015 = var_1_10015(var_2_4, var_2_5, var_2_6, var_1_10019)
				end

				var_2_3[iter_2_2] = var_1_10015

				local var_2_7 = arg_2_0._skillList[iter_2_2]

				if arg_2_2 and arg_2_2.target then
					var_2_7:SetTarget({
						arg_2_2.target
					})
				end

				var_2_7:Cast(arg_2_1, arg_2_0._commander)
			end
		end
	elseif var_3.random_skill_tag then
		local var_2_8 = var_3.random_skill_tag
		local var_2_9 = arg_2_1:GetLabelTag()
		local var_2_10 = {}

		ipairs = var_1_10007

		for iter_2_4, iter_2_5 in var_1_10007(var_2_9) do
			string = var_1_10012
			var_1_10012, var_1_10013 = var_1_10012.find(iter_2_5, var_2_8)

			if var_1_10012 then
				tonumber = var_14
				string = var_1_10015

				local var_2_11 = var_14(var_1_10015.sub(iter_2_5, var_1_10013 + 1, #iter_2_5))

				table = var_1_10015

				if not var_1_10015.contains(var_2_10, var_2_11) then
					table = var_1_10015

					var_1_10015.insert(var_2_10, var_2_11)
				end
			end
		end

		if #var_2_10 > 0 then
			math = var_7

			local var_2_12 = var_2_10[var_7.random(#var_2_10)]
			local var_2_13 = arg_2_0._skillList
			local var_2_14

			if not arg_2_0._skillList[var_2_12] then
				var_2_14 = var_0.Battle.BattleSkillUnit.GenerateSpell

				local var_2_15 = var_2_12
				local var_2_16 = arg_2_0._level
				local var_2_17 = arg_2_1

				attData = var_1_10013
				var_2_14 = var_2_14(var_2_15, var_2_16, var_2_17, var_1_10013)
			end

			var_2_13[var_2_12] = var_2_14

			local var_2_18 = arg_2_0._skillList[var_2_12]

			if arg_2_2 and arg_2_2.target then
				var_2_18:SetTarget({
					arg_2_2.target
				})
			end

			var_2_18:Cast(arg_2_1, arg_2_0._commander)
		end
	end

	return
end

function var_0_3.Clear(arg_3_0)
	var_0_3.super.Clear(arg_3_0)

	pairs = var_1

	for iter_3_0, iter_3_1 in var_1(arg_3_0._skillList) do
		iter_3_1:Clear()
	end

	return
end

return
