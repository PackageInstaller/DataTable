local AdvanceTestSelectHeroProxy = class("AdvanceTestSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function AdvanceTestSelectHeroProxy:InitCustomParams(arg_1_1)
	self.dest = arg_1_1.dest
	self.stageDifficult = arg_1_1.stageDifficult
	self.heroDataType_ = HeroConst.HERO_DATA_TYPE.ADVANCETEST

	self:SetHeroDataType(self.heroDataType_)
end

function AdvanceTestSelectHeroProxy:GetStageData()
	return (BattleStageFactory.Produce(self.stageType, self.stageID, {
		dest = self.dest,
		activityID = self.activityID
	}))
end

function AdvanceTestSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/advanceTestTeamInfo"
end

function AdvanceTestSelectHeroProxy:GetCustomeTeamInfoParams(arg_4_1)
	return {
		stageDifficult = self.stageDifficult
	}
end

function AdvanceTestSelectHeroProxy:IsCharChipBaseUnlock(arg_5_1)
	local var_5_0

	if AdvanceTestCfg[self.dest] then
		var_5_0 = AdvanceTestCfg[self.dest].admin_chip_level or -1

		if var_5_0 == -1 then
			return ChipTools.IsCharChipBaseUnlock(arg_5_1)
		end
	end

	return var_5_0 ~= 0
end

function AdvanceTestSelectHeroProxy:GetCharChipExtraIDListUnlock(arg_6_1)
	local var_6_0

	if AdvanceTestCfg[self.dest] then
		var_6_0 = AdvanceTestCfg[self.dest].admin_chip_level or -1

		if var_6_0 == -1 then
			return ChipTools.GetCharChipExtraIDListUnlock(arg_6_1)
		end

		if var_6_0 <= 0 then
			return {}
		end
	end

	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(ChipTools.GetCharChipExtraIDList(arg_6_1)) do
		if iter_6_0 <= var_6_0 - 1 then
			table.insert(var_6_1, iter_6_1)
		end
	end

	return var_6_1
end

function AdvanceTestSelectHeroProxy:IsCharChipBaseCanUnlock(arg_7_1)
	if AdvanceTestCfg[self.dest] then
		if (AdvanceTestCfg[self.dest].admin_chip_level or -1) == -1 then
			return ChipTools.IsCharChipBaseCanUnlock(arg_7_1)
		end
	end

	return false
end

function AdvanceTestSelectHeroProxy:IsCharChipExtraCanUnlock(arg_8_1)
	if AdvanceTestCfg[self.dest] then
		if (AdvanceTestCfg[self.dest].admin_chip_level or -1) == -1 then
			return ChipTools.IsCharChipExtraCanUnlock(arg_8_1)
		end
	end

	return false
end

function AdvanceTestSelectHeroProxy:IsCharChipExtraUnlock(arg_9_1)
	local var_9_0

	if AdvanceTestCfg[self.dest] then
		var_9_0 = AdvanceTestCfg[self.dest].admin_chip_level or -1

		if var_9_0 == -1 then
			return ChipTools.IsCharChipExtraUnlock(arg_9_1)
		end

		if var_9_0 <= 0 then
			return false
		end
	end

	local var_9_1 = ChipCfg[arg_9_1]

	if ChipCfg[arg_9_1].role_type_id == 5 then
		return var_9_0 > 0
	elseif ChipCfg[arg_9_1].role_type_id == 6 then
		return table.indexof(ChipTools.GetCharChipExtraIDList(var_9_1.spec_char), arg_9_1) <= var_9_0 - 1
	end

	return false
end

function AdvanceTestSelectHeroProxy:IsCharChipCanOperate(arg_10_1)
	if AdvanceTestCfg[self.dest] then
		if (AdvanceTestCfg[self.dest].admin_chip_level or -1) == -1 then
			return true
		end
	end

	return false
end

return AdvanceTestSelectHeroProxy
