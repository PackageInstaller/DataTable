local ReserveAreaBattleTemplate = class("ReserveAreaBattleTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveAreaBattleTemplate:GetHeroList(arg_1_1)
	local var_1_0, var_1_1, var_1_2, var_1_3 = ReserveAreaBattleTemplate.super.GetHeroList(self, arg_1_1)
	local var_1_4 = {}

	if arg_1_1.customData.data.difficultList[arg_1_1.customData.difficult] and arg_1_1.customData.data.difficultList[arg_1_1.customData.difficult][arg_1_1.stageID] and arg_1_1.customData.data.difficultList[arg_1_1.customData.difficult][arg_1_1.stageID].usedHeroList[1] and self:IsSameTeam(var_1_0, arg_1_1.customData.data.difficultList[arg_1_1.customData.difficult][arg_1_1.stageID].usedHeroList, var_1_3) == false then
		for iter_1_0 = 1, 3 do
			var_1_0[iter_1_0] = (arg_1_1.customData.data.difficultList[arg_1_1.customData.difficult][arg_1_1.stageID].usedHeroList[iter_1_0] or 0) % 10000

			if (arg_1_1.customData.data.difficultList[arg_1_1.customData.difficult][arg_1_1.stageID].usedHeroList[iter_1_0] or 0) > 10000 then
				var_1_4[arg_1_1.customData.data.difficultList[arg_1_1.customData.difficult][arg_1_1.stageID].usedHeroList[iter_1_0] % 10000] = arg_1_1.customData.data.difficultList[arg_1_1.customData.difficult][arg_1_1.stageID].usedHeroList[iter_1_0]
			end
		end

		for iter_1_1 = 1, 3 do
			var_1_3[iter_1_1] = (var_1_4[var_1_0[iter_1_1]] or 0 > 10000) and var_1_4[var_1_0[iter_1_1]] or 0
		end
	end

	for iter_1_2, iter_1_3 in pairs(arg_1_1.customData.data.difficultList[arg_1_1.customData.difficult] or {}) do
		if arg_1_1.stageID ~= iter_1_2 then
			for iter_1_4, iter_1_5 in ipairs(iter_1_3.usedHeroList or {}) do
				if HeroStandardSystemCfg[iter_1_5] then
					table.insert(var_1_2, HeroStandardSystemCfg[iter_1_5].hero_id)
				end

				table.insert(var_1_2, iter_1_5)
			end
		end
	end

	for iter_1_6, iter_1_7 in pairs(var_1_0) do
		for iter_1_8, iter_1_9 in pairs(var_1_2) do
			if iter_1_7 == iter_1_9 % 10000 then
				var_1_0[iter_1_6] = 0
			end
		end
	end

	SectionSelectHeroTools.ReorderHeroTeam(var_1_0, var_1_3)

	return var_1_0, var_1_1, var_1_2, var_1_3
end

function ReserveAreaBattleTemplate:GetLockHero(arg_2_1, arg_2_2)
	if arg_2_1.customData.data.difficultList[arg_2_1.customData.difficult] and arg_2_1.customData.data.difficultList[arg_2_1.customData.difficult][arg_2_1.customData.stageID] then
		-- block empty
	else
		for iter_2_0, iter_2_1 in pairs((not arg_2_1.customData.data.difficultList[arg_2_1.customData.difficult] or nil) and {}) do
			if iter_2_1.stageID ~= arg_2_1.customData.stageID then
				for iter_2_2, iter_2_3 in ipairs(iter_2_1.usedHeroList) do
					table.insert(arg_2_2.lockHeroList, iter_2_3)

					if iter_2_3 > 10000 then
						table.insert(arg_2_2.lockHeroList, iter_2_3 % 10000)
					end
				end
			end
		end
	end
end

function ReserveAreaBattleTemplate:IsSameTeam(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		for iter_3_2, iter_3_3 in ipairs(arg_3_2) do
			if iter_3_1 == iter_3_3 then
				var_3_0 = var_3_0 + 1
			end
		end
	end

	for iter_3_4, iter_3_5 in pairs(arg_3_3) do
		for iter_3_6, iter_3_7 in ipairs(arg_3_2) do
			if iter_3_5 == iter_3_7 then
				var_3_0 = var_3_0 + 1
			end
		end
	end

	return var_3_0 == #arg_3_2
end

return ReserveAreaBattleTemplate
