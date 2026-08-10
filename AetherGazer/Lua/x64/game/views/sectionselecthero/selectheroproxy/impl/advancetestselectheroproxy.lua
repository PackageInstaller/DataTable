local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("AdvanceTestSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.dest = arg_1_1.dest
	arg_1_0.stageDifficult = arg_1_1.stageDifficult
	arg_1_0.heroDataType_ = HeroConst.HERO_DATA_TYPE.ADVANCETEST

	arg_1_0:SetHeroDataType(arg_1_0.heroDataType_)
end

function var_0_1.GetStageData(arg_2_0)
	return (BattleStageFactory.Produce(arg_2_0.stageType, arg_2_0.stageID, {
		dest = arg_2_0.dest,
		activityID = arg_2_0.activityID
	}))
end

function var_0_1.GetHeroTeamInfoRoute(arg_3_0)
	return "/advanceTestTeamInfo"
end

function var_0_1.GetCustomeTeamInfoParams(arg_4_0, arg_4_1)
	return {
		stageDifficult = arg_4_0.stageDifficult
	}
end

function var_0_1.IsCharChipBaseUnlock(arg_5_0, arg_5_1)
	local var_5_0 = AdvanceTestCfg[arg_5_0.dest]
	local var_5_1 = var_5_0 and var_5_0.admin_chip_level or -1

	if var_5_1 == -1 then
		return ChipTools.IsCharChipBaseUnlock(arg_5_1)
	end

	return var_5_1 ~= 0
end

function var_0_1.GetCharChipExtraIDListUnlock(arg_6_0, arg_6_1)
	local var_6_0 = AdvanceTestCfg[arg_6_0.dest]
	local var_6_1 = var_6_0 and var_6_0.admin_chip_level or -1

	if var_6_1 == -1 then
		return ChipTools.GetCharChipExtraIDListUnlock(arg_6_1)
	end

	if var_6_1 <= 0 then
		return {}
	end

	local var_6_2 = {}

	for iter_6_0, iter_6_1 in ipairs(ChipTools.GetCharChipExtraIDList(arg_6_1)) do
		if iter_6_0 <= var_6_1 - 1 then
			table.insert(var_6_2, iter_6_1)
		end
	end

	return var_6_2
end

function var_0_1.IsCharChipBaseCanUnlock(arg_7_0, arg_7_1)
	local var_7_0 = AdvanceTestCfg[arg_7_0.dest]

	if (var_7_0 and var_7_0.admin_chip_level or -1) == -1 then
		return ChipTools.IsCharChipBaseCanUnlock(arg_7_1)
	end

	return false
end

function var_0_1.IsCharChipExtraCanUnlock(arg_8_0, arg_8_1)
	local var_8_0 = AdvanceTestCfg[arg_8_0.dest]

	if (var_8_0 and var_8_0.admin_chip_level or -1) == -1 then
		return ChipTools.IsCharChipExtraCanUnlock(arg_8_1)
	end

	return false
end

function var_0_1.IsCharChipExtraUnlock(arg_9_0, arg_9_1)
	local var_9_0 = AdvanceTestCfg[arg_9_0.dest]
	local var_9_1 = var_9_0 and var_9_0.admin_chip_level or -1

	if var_9_1 == -1 then
		return ChipTools.IsCharChipExtraUnlock(arg_9_1)
	end

	if var_9_1 <= 0 then
		return false
	end

	local var_9_2 = ChipCfg[arg_9_1]
	local var_9_3 = var_9_2.role_type_id

	if var_9_3 == 5 then
		return var_9_1 > 0
	elseif var_9_3 == 6 then
		local var_9_4 = var_9_2.spec_char
		local var_9_5 = ChipTools.GetCharChipExtraIDList(var_9_4)

		return table.indexof(var_9_5, arg_9_1) <= var_9_1 - 1
	end

	return false
end

function var_0_1.IsCharChipCanOperate(arg_10_0, arg_10_1)
	local var_10_0 = AdvanceTestCfg[arg_10_0.dest]

	if (var_10_0 and var_10_0.admin_chip_level or -1) == -1 then
		return true
	end

	return false
end

return var_0_1
