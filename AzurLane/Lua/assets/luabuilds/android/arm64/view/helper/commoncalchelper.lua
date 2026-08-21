local var_0_0 = class("CommonCalcHelper")

function var_0_0.CalcDungeonHp(arg_1_0, arg_1_1)
	local var_1_0 = 0

	for iter_1_0, iter_1_1 in ipairs(ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(arg_1_0).stages) do
		for iter_1_2, iter_1_3 in ipairs(iter_1_1.waves) do
			if iter_1_3.triggerType == ys.Battle.BattleConst.WaveTriggerType.NORMAL then
				for iter_1_4, iter_1_5 in ipairs(iter_1_3.spawn) do
					({})[#{} + 1] = iter_1_5.monsterTemplateID
				end

				if iter_1_3.reinforcement then
					for iter_1_6, iter_1_7 in ipairs(iter_1_3.reinforcement) do
						({})[#{} + 1] = iter_1_7.monsterTemplateID
					end
				end
			end
		end
	end

	for iter_1_8, iter_1_9 in ipairs({}) do
		local var_1_1 = ys.Battle.BattleDataFunction.GetMonsterTmpDataFromID(iter_1_9)

		var_1_0 = var_1_0 + (var_1_1.durability + var_1_1.durability_growth * ((arg_1_1 - 1) / 1000))
	end

	return var_1_0
end

return var_0_0
