return {
	GetBattlePower = function(arg_1_0, arg_1_1)
		local var_1_0 = arg_1_0:GetHeroData(arg_1_1)
		local var_1_1 = arg_1_0:GetEquipDataList(arg_1_1)
		local var_1_2 = arg_1_0:GetHeroServantInfo(arg_1_1)
		local var_1_3
		local var_1_4 = 0

		if arg_1_0.tempHeroList then
			var_1_4 = var_1_0.tempID
		end

		if arg_1_0:GetViewDataType() == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			var_1_3 = GetPolyhedronHeroPracticalAttr(PolyhedronData:GetPolyhedronInfo(), var_1_0, var_1_1, var_1_4)
		elseif arg_1_0:GetViewDataType() == HeroConst.HERO_DATA_TYPE.STRATEGYMATRIX then
			local var_1_5 = StrategyMatrixData:GetActivityId()

			var_1_3 = GetMatrixtHeroPracticalAttr(var_1_0, var_1_1, var_1_4, var_1_5, StrategyMatrixData:GetHeroDataNew(arg_1_1))
		elseif arg_1_0:GetViewDataType() == HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM or arg_1_0.isChallengeRogue then
			var_1_3 = ChallengeRogueTeamData:GetHeroFinalAttr(var_1_0, var_1_0:GetServantInfo(), var_1_1, var_1_4, false)
		elseif arg_1_0:GetViewDataType() == HeroConst.HERO_DATA_TYPE.OSIRISPLAYGAME then
			var_1_3 = OsirisPlayGameTempHeroData:GetHeroFinalAttr(var_1_0, var_1_0:GetServantInfo(), var_1_1, var_1_4, true)
		elseif arg_1_0:GetViewDataType() == HeroConst.HERO_DATA_TYPE.HODURGAME then
			var_1_3 = HodurGameTempHeroData:GetHeroFinalAttr(var_1_0, var_1_0:GetServantInfo(), var_1_1, var_1_4, true)
		else
			var_1_3 = GetHeroFinalAttr(var_1_0, var_1_0:GetServantInfo(), var_1_1, var_1_4, true)
		end

		return calcBattlePower(var_1_0, var_1_2, var_1_1, var_1_0.tempID, var_1_3)
	end,
	GetHeroAllAttribute = function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = 0
		local var_2_1

		if not arg_2_2 then
			var_2_1 = arg_2_0:GetHeroData(arg_2_1)
		else
			var_2_1 = arg_2_2
		end

		local var_2_2 = arg_2_0:GetEquipDataList(arg_2_1)

		if arg_2_0.tempHeroList then
			var_2_0 = var_2_1.tempID
		end

		local var_2_3

		if arg_2_0:GetViewDataType() == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			var_2_3 = GetPolyhedronHeroPracticalAttr(PolyhedronData:GetPolyhedronInfo(), var_2_1, var_2_2, var_2_0)
		elseif arg_2_0:GetViewDataType() == HeroConst.HERO_DATA_TYPE.STRATEGYMATRIX then
			local var_2_4 = StrategyMatrixData:GetActivityId()

			var_2_3 = GetMatrixtHeroPracticalAttr(var_2_1, var_2_2, var_2_0, var_2_4, StrategyMatrixData:GetHeroDataNew(arg_2_1))
		elseif arg_2_0:GetViewDataType() == HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM or arg_2_0.isChallengeRogue then
			var_2_3 = ChallengeRogueTeamData:GetHeroFinalAttr(var_2_1, var_2_1:GetServantInfo(), var_2_2, var_2_0, false)
		elseif arg_2_0:GetViewDataType() == HeroConst.HERO_DATA_TYPE.OSIRISPLAYGAME then
			var_2_3 = OsirisPlayGameTempHeroData:GetHeroFinalAttr(var_2_1, var_2_1:GetServantInfo(), var_2_2, var_2_0, false)
		elseif arg_2_0:GetViewDataType() == HeroConst.HERO_DATA_TYPE.HODURGAME then
			var_2_3 = HodurGameTempHeroData:GetHeroFinalAttr(var_2_1, var_2_1:GetServantInfo(), var_2_2, var_2_0, false)
		else
			var_2_3 = GetHeroFinalAttr(var_2_1, var_2_1:GetServantInfo(), var_2_2, var_2_0, false)
		end

		local var_2_5 = var_2_3[HeroConst.HERO_ATTRIBUTE.ATK] or 0
		local var_2_6 = var_2_3[HeroConst.HERO_ATTRIBUTE.ARM] or 0
		local var_2_7 = var_2_3[HeroConst.HERO_ATTRIBUTE.STA] or 0
		local var_2_8 = var_2_3[11] or 0
		local var_2_9 = var_2_3[12] or 0
		local var_2_10 = var_2_3[13] or 0
		local var_2_11 = var_2_3[21] or 0
		local var_2_12 = var_2_3[22] or 0
		local var_2_13 = var_2_3[31] or 0
		local var_2_14 = var_2_3[32] or 0

		var_2_3[HeroConst.HERO_ATTRIBUTE.ATK] = var_2_5 * (1 + var_2_8 / 1000 + var_2_10 / 1000) + var_2_9
		var_2_3[HeroConst.HERO_ATTRIBUTE.ARM] = var_2_6 * (1 + var_2_11 / 1000) + var_2_12
		var_2_3[HeroConst.HERO_ATTRIBUTE.STA] = var_2_7 * (1 + var_2_13 / 1000) + var_2_14

		return var_2_3
	end
}
