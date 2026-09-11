return {
	GetBattlePower = function(self, arg_1_1)
		local var_1_0 = self:GetHeroData(arg_1_1)
		local var_1_1 = self:GetEquipDataList(arg_1_1)
		local var_1_4 = 0

		if self.tempHeroList then
			var_1_4 = var_1_0.tempID
		end

		return calcBattlePower(var_1_0, self:GetHeroServantInfo(arg_1_1), var_1_1, var_1_0.tempID, self:GetViewDataType() == HeroConst.HERO_DATA_TYPE.POLYHEDRON and GetPolyhedronHeroPracticalAttr(PolyhedronData:GetPolyhedronInfo(), var_1_0, var_1_1, var_1_4) or self:GetViewDataType() == HeroConst.HERO_DATA_TYPE.STRATEGYMATRIX and GetMatrixtHeroPracticalAttr(var_1_0, var_1_1, var_1_4, StrategyMatrixData:GetActivityId(), StrategyMatrixData:GetHeroDataNew(arg_1_1)) or (self:GetViewDataType() == HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM or self.isChallengeRogue) and ChallengeRogueTeamData:GetHeroFinalAttr(var_1_0, var_1_0:GetServantInfo(), var_1_1, var_1_4, false) or self:GetViewDataType() == HeroConst.HERO_DATA_TYPE.OSIRISPLAYGAME and OsirisPlayGameTempHeroData:GetHeroFinalAttr(var_1_0, var_1_0:GetServantInfo(), var_1_1, var_1_4, true) or self:GetViewDataType() == HeroConst.HERO_DATA_TYPE.HODURGAME and HodurGameTempHeroData:GetHeroFinalAttr(var_1_0, var_1_0:GetServantInfo(), var_1_1, var_1_4, true) or GetHeroFinalAttr(var_1_0, var_1_0:GetServantInfo(), var_1_1, var_1_4, true))
	end,
	GetHeroAllAttribute = function(self, arg_2_1, arg_2_2)
		local var_2_0 = 0
		local var_2_1 = not arg_2_2 and self:GetHeroData(arg_2_1) or arg_2_2
		local var_2_2 = self:GetEquipDataList(arg_2_1)

		if self.tempHeroList then
			var_2_0 = var_2_1.tempID
		end

		local var_2_3 = self:GetViewDataType() == HeroConst.HERO_DATA_TYPE.POLYHEDRON and GetPolyhedronHeroPracticalAttr(PolyhedronData:GetPolyhedronInfo(), var_2_1, var_2_2, var_2_0) or self:GetViewDataType() == HeroConst.HERO_DATA_TYPE.STRATEGYMATRIX and GetMatrixtHeroPracticalAttr(var_2_1, var_2_2, var_2_0, StrategyMatrixData:GetActivityId(), StrategyMatrixData:GetHeroDataNew(arg_2_1)) or (self:GetViewDataType() == HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM or self.isChallengeRogue) and ChallengeRogueTeamData:GetHeroFinalAttr(var_2_1, var_2_1:GetServantInfo(), var_2_2, var_2_0, false) or self:GetViewDataType() == HeroConst.HERO_DATA_TYPE.OSIRISPLAYGAME and OsirisPlayGameTempHeroData:GetHeroFinalAttr(var_2_1, var_2_1:GetServantInfo(), var_2_2, var_2_0, false) or self:GetViewDataType() == HeroConst.HERO_DATA_TYPE.HODURGAME and HodurGameTempHeroData:GetHeroFinalAttr(var_2_1, var_2_1:GetServantInfo(), var_2_2, var_2_0, false) or GetHeroFinalAttr(var_2_1, var_2_1:GetServantInfo(), var_2_2, var_2_0, false)

		var_2_3[HeroConst.HERO_ATTRIBUTE.ATK] = (var_2_3[HeroConst.HERO_ATTRIBUTE.ATK] or 0) * (1 + (var_2_3[11] or 0) / 1000 + (var_2_3[13] or 0) / 1000) + (var_2_3[12] or 0)
		var_2_3[HeroConst.HERO_ATTRIBUTE.ARM] = (var_2_3[HeroConst.HERO_ATTRIBUTE.ARM] or 0) * (1 + (var_2_3[21] or 0) / 1000) + (var_2_3[22] or 0)
		var_2_3[HeroConst.HERO_ATTRIBUTE.STA] = (var_2_3[HeroConst.HERO_ATTRIBUTE.STA] or 0) * (1 + (var_2_3[31] or 0) / 1000) + (var_2_3[32] or 0)

		return var_2_3
	end
}
