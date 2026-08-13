class = var_0_10000

local var_0_0 = var_0_10000("CommonCalcHelper")

function var_0_0.CalcDungeonHp(arg_1_0, arg_1_1)
	local var_1_0 = 0
	local var_1_1 = {}

	ys = var_1_10004

	local var_1_2 = var_1_10004.Battle.BattleDataFunction.GetDungeonTmpDataByID(arg_1_0)

	ipairs = var_5

	for iter_1_0, iter_1_1 in var_5(var_1_2.stages) do
		ipairs = var_1_10010

		for iter_1_2, iter_1_3 in var_1_10010(iter_1_1.waves) do
			local var_1_3 = iter_1_3.triggerType

			ys = var_1_10016

			if var_1_3 == var_1_10016.Battle.BattleConst.WaveTriggerType.NORMAL then
				ipairs = var_1_3

				for iter_1_4, iter_1_5 in var_1_3(iter_1_3.spawn) do
					local var_1_4 = iter_1_5.monsterTemplateID

					var_1_1[#var_1_1 + 1] = var_1_4
				end

				if iter_1_3.reinforcement then
					ipairs = var_15

					for iter_1_6, iter_1_7 in var_15(iter_1_3.reinforcement) do
						local var_1_5 = iter_1_7.monsterTemplateID

						var_1_1[#var_1_1 + 1] = var_1_5
					end
				end
			end
		end
	end

	ipairs = var_5

	for iter_1_8, iter_1_9 in var_5(var_1_1) do
		ys = var_1_10010
		var_1_0 = var_1_0 + (var_1_10010.Battle.BattleDataFunction.GetMonsterTmpDataFromID(iter_1_9).durability + var_1_10010.durability_growth * ((arg_1_1 - 1) / 1000))
	end

	return var_1_0
end

return var_0_0
