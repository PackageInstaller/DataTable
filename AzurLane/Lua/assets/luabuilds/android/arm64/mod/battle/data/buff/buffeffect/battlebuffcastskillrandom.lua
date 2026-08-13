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

		pairs = var_7

		for iter_2_2, iter_2_3 in var_7(var_2_0) do
			var_1_10012 = iter_2_3[1]

			local var_2_3 = iter_2_3[2]

			if var_1_10012 <= var_2_2 and var_2_2 < var_2_3 then
				var_1_10014 = arg_2_0._skillList

				local var_2_4

				if not arg_2_0._skillList[iter_2_2] then
					var_2_4 = var_0.Battle.BattleSkillUnit.GenerateSpell

					local var_2_5 = iter_2_2
					local var_2_6 = arg_2_0._level
					local var_2_7 = arg_2_1

					attData = var_1_10020
					var_2_4 = var_2_4(var_2_5, var_2_6, var_2_7, var_1_10020)
				end

				var_1_10014[iter_2_2] = var_2_4
				var_1_10014 = arg_2_0._skillList[iter_2_2]

				if arg_2_2 and arg_2_2.target then
					var_1_10014:SetTarget({
						arg_2_2.target
					})
				end

				var_1_10014:Cast(arg_2_1, arg_2_0._commander)
			end
		end
	elseif var_3.random_skill_tag then
		local var_2_8 = var_3.random_skill_tag
		local var_2_9 = arg_2_1
		local var_2_10 = arg_2_1.GetLabelTag(var_2_9)
		local var_2_11 = {}

		ipairs = var_2_9

		for iter_2_4, iter_2_5 in var_2_9(var_2_10) do
			string = var_1_10012

			local var_2_12

			var_1_10012, var_2_12 = var_1_10012.find(iter_2_5, var_2_8)

			if var_1_10012 then
				tonumber = var_1_10014
				string = var_1_10016
				var_1_10014 = var_1_10014(var_1_10016.sub(iter_2_5, var_2_12 + 1, #iter_2_5))
				table = var_15

				if not var_15.contains(var_2_11, var_1_10014) then
					table = var_15

					var_15.insert(var_2_11, var_1_10014)
				end
			end
		end

		if #var_2_11 > 0 then
			math = var_7

			local var_2_13 = var_2_11[var_7.random(#var_2_11)]
			local var_2_14 = arg_2_0._skillList
			local var_2_15

			if not arg_2_0._skillList[var_2_13] then
				var_2_15 = var_0.Battle.BattleSkillUnit.GenerateSpell

				local var_2_16 = var_2_13
				local var_2_17 = arg_2_0._level
				local var_2_18 = arg_2_1

				attData = var_1_10014
				var_2_15 = var_2_15(var_2_16, var_2_17, var_2_18, var_1_10014)
			end

			var_2_14[var_2_13] = var_2_15

			local var_2_19 = arg_2_0._skillList[var_2_13]

			if arg_2_2 and arg_2_2.target then
				var_2_19:SetTarget({
					arg_2_2.target
				})
			end

			var_2_19:Cast(arg_2_1, arg_2_0._commander)
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
