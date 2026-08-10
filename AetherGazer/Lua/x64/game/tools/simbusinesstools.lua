local var_0_0 = {
	State = {
		CAN_UPGRADE = 3,
		LOCK_BY_COST = 2,
		LOCK_BY_LEVEL = 1,
		MAX_LEVEL = 4
	},
	GetLocalDataKey = function(arg_1_0)
		return arg_1_0 .. (SimBusinessData.activityID or "")
	end
}

function var_0_0.GetShelfCanLevelUp(arg_2_0)
	local var_2_0 = SimBusinessData:GetShelfLevel(arg_2_0) or 1
	local var_2_1 = SimBusinessShelfCfg[arg_2_0]

	if var_2_1 then
		if var_2_0 - 1 == #var_2_1.up_cost then
			return false, var_0_0.State.MAX_LEVEL
		end

		local var_2_2 = var_2_1.up_cost[var_2_0]

		if var_2_2 then
			return var_2_2 <= (SimBusinessData:GetSimBusinessFund() or 0), var_0_0.State.CAN_UPGRADE
		end

		return false, var_0_0.State.MAX_LEVEL
	end
end

function var_0_0.GetShelfUpgradeCostFund(arg_3_0)
	local var_3_0 = SimBusinessData:GetShelfLevel(arg_3_0) or 1

	return nullable(SimBusinessShelfCfg, arg_3_0, "up_cost", var_3_0) or 0
end

function var_0_0.GetShelfUnlockLevel(arg_4_0)
	local var_4_0 = SimBusinessPlayerLevelCfg.get_id_list_by_unlock_shelf_list[arg_4_0]

	if var_4_0 == nil or next(var_4_0) == nil then
		return nil
	else
		local var_4_1 = {}

		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			table.insert(var_4_1, SimBusinessPlayerLevelCfg[iter_4_1].level)
		end

		return math.min(unpack(var_4_1))
	end
end

function var_0_0.GetShelfUnlocked(arg_5_0)
	if SimBusinessShelfCfg[arg_5_0] then
		local var_5_0 = var_0_0.GetShelfUnlockLevel(arg_5_0)
		local var_5_1 = SimBusinessData:GetSimBusinessLevel()

		if var_5_0 == nil then
			return false
		elseif var_5_1 < var_5_0 then
			return false, var_5_0
		else
			return true
		end
	end
end

function var_0_0.IsChallengeLevel(arg_6_0)
	return nullable(SimBusinessStageCfg, arg_6_0, "type") == SimBusinessConst.LevelType.CHALLENGE
end

function var_0_0.IsDailyLevel(arg_7_0)
	return nullable(SimBusinessStageCfg, arg_7_0, "type") == SimBusinessConst.LevelType.DAILY
end

function var_0_0.GetCurEditStage()
	local var_8_0 = SimBusinessGame.GetInstance().stage

	if var_0_0.IsChallengeLevel(var_8_0) then
		return var_8_0
	end

	return nil
end

function var_0_0.GetGoodsUnlockLevel(arg_9_0)
	local var_9_0 = SimBusinessPlayerLevelCfg.get_id_list_by_unlock_goods_list[arg_9_0]

	if var_9_0 == nil or next(var_9_0) == nil then
		return nil
	else
		local var_9_1 = {}

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			table.insert(var_9_1, SimBusinessPlayerLevelCfg[iter_9_1].level)
		end

		return math.min(unpack(var_9_1))
	end
end

function var_0_0.GetGoodLockState(arg_10_0)
	if SimBusinessData.unlockGoods[arg_10_0] then
		return false
	end

	local var_10_0 = var_0_0.GetGoodsUnlockLevel(arg_10_0)

	if var_10_0 == nil then
		return true, var_0_0.State.LOCK_BY_LEVEL
	else
		if var_10_0 > SimBusinessData:GetSimBusinessLevel() then
			return true, var_0_0.State.LOCK_BY_LEVEL, var_10_0
		end

		local var_10_1 = SimBusinessData:GetSimBusinessFund()
		local var_10_2 = SimBusinessGoodsCfg[arg_10_0].unlock_cost

		if var_10_2 <= var_10_1 then
			return true, var_0_0.State.LOCK_BY_COST
		else
			return true, var_0_0.State.LOCK_BY_COST, var_10_2
		end
	end
end

function var_0_0.GetGoodsReadyToUnlock(arg_11_0)
	local var_11_0, var_11_1, var_11_2 = var_0_0.GetGoodLockState(arg_11_0)

	return var_11_0 and var_11_1 ~= var_0_0.State.LOCK_BY_LEVEL and var_11_2 == nil
end

function var_0_0.AskUnlockGoods(arg_12_0)
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("SIM_BUSINESS_ASK_UNLOCK_GOODS"),
		OkCallback = function()
			SimBusinessAction.UnlockGoods({
				arg_12_0
			})
		end
	})
end

function var_0_0.GetClientIcon(arg_14_0)
	if SimBusinessGuestCfg[arg_14_0] then
		local var_14_0 = SimBusinessGuestCfg[arg_14_0].icon

		return getSpriteViaConfig("SimBusinessGuest", var_14_0)
	end
end

function var_0_0.GetGoodsIcon(arg_15_0)
	local var_15_0 = SimBusinessGoodsCfg[arg_15_0]

	return getSpriteViaConfig("SimBusinessGoods", var_15_0.icon)
end

function var_0_0.GetShelfIcon(arg_16_0)
	local var_16_0 = SimBusinessShelfCfg[arg_16_0]

	return getSpriteViaConfig("SimBusinessShelf", var_16_0.icon)
end

function var_0_0.GetStageIcon(arg_17_0)
	local var_17_0 = SimBusinessStageCfg[arg_17_0]

	return getSpriteViaConfig("SimBusinessStage", var_17_0.stage_icon)
end

function var_0_0.GetCoinIcon()
	return ItemTools.getItemSprite(SimBusinessData:GetSimBusinessFundItemID())
end

function var_0_0.GetStageState(arg_19_0)
	if SimBusinessStageCfg[arg_19_0] then
		local var_19_0
		local var_19_1
		local var_19_2, var_19_3 = var_0_0.CheckLevelUnlock(arg_19_0)

		if var_19_2 then
			var_19_0 = "clear"
			var_19_1 = SimBusinessData:GetLevelMinCostRecord(arg_19_0)
		else
			var_19_0 = "lock"
			var_19_1 = var_19_3
		end

		return var_19_0, var_19_1
	end
end

function var_0_0.CheckDeployNewShelfCostOver(arg_20_0)
	local var_20_0 = SimBusinessShelfCfg[arg_20_0].cost

	return var_0_0.NotEnoughFund(var_20_0)
end

function var_0_0.GetFundLimit(arg_21_0)
	local var_21_0 = arg_21_0 or SimBusinessGame.GetInstance().stage
	local var_21_1 = nullable(SimBusinessStageCfg, var_21_0)

	if var_0_0.IsDailyLevel(var_21_0) then
		return SimBusinessData:CalcTotalFund()
	else
		return nullable(var_21_1, "cost_limit") or 0
	end
end

function var_0_0.GetAvailableFund(arg_22_0)
	return var_0_0.GetFundLimit(arg_22_0) - SimBusinessTools.CalcRealtimeShelfTotalCostFund()
end

function var_0_0.NotEnoughFund(arg_23_0, arg_23_1)
	return arg_23_0 > var_0_0.GetAvailableFund(arg_23_1)
end

function var_0_0.GetDefaultEnterDailyLevel()
	local var_24_0 = SimBusinessStageCfg.get_id_list_by_type[SimBusinessConst.LevelType.DAILY]
	local var_24_1, var_24_2 = var_0_0.CheckLevelUnlock(var_24_0[1])

	if not var_24_1 then
		if var_24_2 then
			ShowTips(var_24_2)
		end

		return nil
	end

	local var_24_3

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if var_0_0.CheckLevelUnlock(iter_24_1) then
			var_24_3 = iter_24_1
		end
	end

	return var_24_3
end

function var_0_0.CheckPreLevelClear(arg_25_0)
	local var_25_0 = SimBusinessStageCfg[arg_25_0]

	if var_25_0.pre and SimBusinessStageCfg[var_25_0.pre] and not SimBusinessData.level[var_25_0.pre].clear then
		return false, var_25_0.pre
	end

	return true
end

function var_0_0.CheckLevelActivityOpen(arg_26_0)
	local var_26_0 = SimBusinessStageCfg[arg_26_0].activity_id
	local var_26_1, var_26_2 = ActivityTools.GetActivityStatusWithTips(var_26_0)

	return var_26_1 == 1, var_26_2
end

function var_0_0.CheckLevelUnlock(arg_27_0)
	local var_27_0, var_27_1 = var_0_0.CheckPreLevelClear(arg_27_0)

	if not var_27_0 then
		return false, GetTipsF("SIM_BUSINESS_PRE_STAGE_NOT_CLEAR", SimBusinessStageCfg[var_27_1].name)
	end

	local var_27_2, var_27_3 = var_0_0.CheckLevelActivityOpen(arg_27_0)

	if not var_27_2 then
		return false, var_27_3
	end

	local var_27_4 = SimBusinessStageCfg[arg_27_0]

	if SimBusinessData:GetSimBusinessLevel() < var_27_4.level_limit then
		return false, GetTipsF("SIM_BUSINESS_LEVEL_LIMIT", var_27_4.level_limit)
	end

	return true
end

function var_0_0.GetMainUIName(arg_28_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_SimBusinessEntranceUI"
end

function var_0_0.OpenGameTips()
	local var_29_0 = "SIM_BUSINESS_DESC_TIPS"

	JumpTools.OpenPageByJump("gameHelp", {
		content = GetTips(var_29_0),
		key = var_29_0
	})
end

function var_0_0.GetSpStageRedPoint(arg_30_0)
	return string.format("%s_%s", RedPointConst.ACTIVITY_SIM_BUSINESS_SPECIAL_STAGE, arg_30_0)
end

function var_0_0.UpdataNotPassNormalStageRedPoint()
	local var_31_0 = SimBusinessData.level

	for iter_31_0, iter_31_1 in pairs(var_31_0) do
		local var_31_1 = var_0_0.GetStageState(iter_31_0)

		if SimBusinessTools.IsDailyLevel(iter_31_0) and var_31_1 ~= "lock" and not iter_31_1.clear then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_SIM_BUSINESS_NORMAL_STAGE, 1)

			return
		end
	end
end

function var_0_0.UpdataNotPassSpecialStageRedPoint()
	local var_32_0 = SimBusinessStageCfg.get_id_list_by_type[1]

	for iter_32_0, iter_32_1 in pairs(var_32_0) do
		local var_32_1 = SimBusinessData.level[iter_32_1]
		local var_32_2 = var_0_0.GetStageState(iter_32_1)

		if var_0_0.IsChallengeLevel(iter_32_1) then
			local var_32_3 = var_32_2 ~= "lock" and not nullable(var_32_1, "clear")

			if var_32_3 then
				local var_32_4 = var_0_0.GetLocalDataKey("simBusinessSpecialStage")
				local var_32_5 = getData(var_32_4, tostring(iter_32_1))

				if var_32_5 and var_32_5 ~= 0 then
					var_32_3 = false
				end
			end

			local var_32_6 = var_0_0.GetSpStageRedPoint(iter_32_1)

			manager.redPoint:setTip(var_32_6, var_32_3 and 1 or 0)
		end
	end
end

function var_0_0.MarkSpecialStageRedPointNeverShowAgain(arg_33_0)
	if var_0_0.IsChallengeLevel(arg_33_0) then
		local var_33_0 = var_0_0.GetLocalDataKey("simBusinessSpecialStage")

		saveData(var_33_0, tostring(arg_33_0), 1)
	end
end

function var_0_0.SetStageRedPoint(arg_34_0, arg_34_1)
	local var_34_0

	if SimBusinessTools.IsDailyLevel(arg_34_0) then
		var_34_0 = RedPointConst.ACTIVITY_SIM_BUSINESS_NORMAL_STAGE
	else
		var_34_0 = var_0_0.GetSpStageRedPoint(arg_34_0)
	end

	if arg_34_1 then
		local var_34_1 = var_0_0.GetLocalDataKey("simBusinessSpecialStage")
		local var_34_2 = getData(var_34_1, tostring(arg_34_0))

		if var_34_2 and var_34_2 ~= 0 then
			arg_34_1 = false
		end
	end

	manager.redPoint:setTip(var_34_0, arg_34_1 and 1 or 0)
end

function var_0_0.UpdateStageRedPointAfterStageClear(arg_35_0)
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(SimBusinessStageCfg.all) do
		if SimBusinessStageCfg[iter_35_1].pre == arg_35_0 then
			table.insert(var_35_0, iter_35_1)
		end
	end

	for iter_35_2, iter_35_3 in ipairs(var_35_0) do
		if var_0_0.CheckLevelUnlock(iter_35_3) then
			var_0_0.SetStageRedPoint(iter_35_3, true)
		end
	end

	if var_0_0.IsChallengeLevel(arg_35_0) then
		local var_35_1 = var_0_0.GetSpStageRedPoint(arg_35_0)

		manager.redPoint:setTip(var_35_1, 0)
	end
end

function var_0_0.UpdataCanUnlockGoodRedPoint()
	local var_36_0 = SimBusinessGoodsCfg.all

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		if var_0_0.GetGoodsReadyToUnlock(iter_36_1) then
			var_0_0.SetShowGoodsRedPoint(iter_36_1, true)
		end
	end
end

function var_0_0.SetShowGoodsRedPoint(arg_37_0, arg_37_1)
	local var_37_0 = var_0_0.GetLocalDataKey("simBusinessGoodsUnlock")

	if arg_37_1 then
		local var_37_1 = getData(var_37_0, tostring(arg_37_0))

		if var_37_1 and var_37_1 ~= 0 then
			arg_37_1 = false
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SIM_BUSINESS_UNLOCK_GOOD, arg_37_0), arg_37_1 and 1 or 0)
end

function var_0_0.MarkGoodsRedPointNeverShowAgain(arg_38_0)
	local var_38_0 = var_0_0.GetLocalDataKey("simBusinessGoodsUnlock")

	saveData(var_38_0, tostring(arg_38_0), 1)
	var_0_0.SetShowGoodsRedPoint(arg_38_0, false)
end

function var_0_0.UpdataCanLevelUpShelfRedPoint()
	local var_39_0 = SimBusinessShelfCfg.all

	for iter_39_0, iter_39_1 in ipairs(var_39_0) do
		local var_39_1 = var_0_0.GetShelfCanLevelUp(iter_39_1)

		if var_0_0.GetShelfUnlocked() and var_39_1 then
			var_0_0.SetShowShelfRedPoint(iter_39_1, true)
		end
	end
end

function var_0_0.SetShowShelfRedPoint(arg_40_0, arg_40_1)
	local var_40_0 = var_0_0.GetLocalDataKey("simBusinessShelfUpgrade")

	if arg_40_1 then
		local var_40_1 = getData(var_40_0, tostring(arg_40_0))

		if var_40_1 and var_40_1 ~= 0 then
			arg_40_1 = false
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SIM_BUSINESS_SHELF_LEVEL_UP, arg_40_0), arg_40_1 and 1 or 0)
end

function var_0_0.MarkShelfRedPointNeverShowAgain(arg_41_0)
	local var_41_0 = var_0_0.GetLocalDataKey("simBusinessShelfUpgrade")

	saveData(var_41_0, tostring(arg_41_0), 1)
	var_0_0.SetShowShelfRedPoint(arg_41_0, false)
end

function var_0_0.IsInChallengeStage(arg_42_0)
	local var_42_0 = arg_42_0 or SimBusinessGame.GetInstance().stage
	local var_42_1 = nullable(SimBusinessStageCfg, var_42_0)

	return (nullable(var_42_1, "type") or SimBusinessConst.LevelType.DAILY) ~= SimBusinessConst.LevelType.DAILY
end

local var_0_1 = SimBusinessFundBar.New()
local var_0_2 = SimBusinessDailyStageFundBar.New()

function var_0_0.SwitchBarWithFund(arg_43_0, arg_43_1)
	table.insert(arg_43_0, arg_43_1 and var_0_2 or var_0_1)
	manager.windowBar:SwitchBar(arg_43_0, true)
end

function var_0_0.CalcEditCacheShelfCostFund()
	local var_44_0 = 0
	local var_44_1 = SimBusinessData.cacheEditShelfInfo

	if var_44_1 then
		for iter_44_0, iter_44_1 in pairs(var_44_1) do
			local var_44_2 = iter_44_1.cfgID

			var_44_0 = var_44_0 + SimBusinessShelfCfg[var_44_2].cost
		end
	end

	return var_44_0
end

function var_0_0.CalcRealtimeShelfTotalCostFund()
	return SimBusinessData:GetShelfUseFund()
end

function var_0_0.GetFilteredGoodsList(arg_46_0)
	local var_46_0 = {}

	for iter_46_0, iter_46_1 in ipairs(SimBusinessGoodsCfg.all) do
		if arg_46_0(iter_46_1) then
			table.insert(var_46_0, iter_46_1)
		end
	end

	return var_46_0
end

function var_0_0.SetFlag(arg_47_0, arg_47_1)
	Dorm.storage:RecordData("sim.flags", arg_47_0, arg_47_1)
end

function var_0_0.GetFlag(arg_48_0)
	return Dorm.storage:GetData("sim.flags", arg_48_0)
end

function var_0_0.SelectAvailableGoodsList(arg_49_0, arg_49_1)
	local var_49_0 = SimBusinessGoodsCfg.get_id_list_by_type[arg_49_0]
	local var_49_1 = {}

	if var_49_0 then
		for iter_49_0, iter_49_1 in ipairs(var_49_0) do
			if arg_49_1 == nil then
				table.insert(var_49_1, iter_49_1)
			else
				table.insert(var_49_1, arg_49_1(iter_49_1))
			end
		end
	end

	return var_49_1
end

function var_0_0.GetShelfList()
	local var_50_0 = {}
	local var_50_1 = var_0_0.GetCurEditStage()
	local var_50_2 = nullable(SimBusinessStageCfg, var_50_1, "override_shelf_cfg")

	if var_50_2 and next(var_50_2) then
		for iter_50_0, iter_50_1 in ipairs(var_50_2) do
			local var_50_3 = iter_50_1[1]

			if iter_50_1[2] > 0 then
				table.insert(var_50_0, var_50_3)
			end
		end
	else
		for iter_50_2, iter_50_3 in ipairs(SimBusinessShelfCfg.all) do
			if SimBusinessData:GetShelfLevel(iter_50_3) > 0 then
				table.insert(var_50_0, iter_50_3)
			end
		end
	end

	return var_50_0
end

function var_0_0.GetShelfOverrideLevel(arg_51_0)
	local var_51_0 = var_0_0.GetCurEditStage()
	local var_51_1 = nullable(SimBusinessStageCfg, var_51_0, "override_shelf_cfg")

	if var_51_1 and next(var_51_1) then
		for iter_51_0, iter_51_1 in ipairs(var_51_1) do
			local var_51_2 = iter_51_1[1]
			local var_51_3 = iter_51_1[2]

			if var_51_2 == arg_51_0 then
				return var_51_3
			end
		end
	end
end

function var_0_0.GetShelfSellAbility(arg_52_0, arg_52_1)
	local var_52_0 = var_0_0.GetShelfOverrideLevel(arg_52_0) or SimBusinessData:GetShelfLevel(arg_52_0)
	local var_52_1 = SimBusinessShelfCfg[arg_52_0]
	local var_52_2 = var_52_1.sell_ability[var_52_0]

	if var_52_2 == nil then
		if var_52_0 and var_52_0 > #var_52_1.sell_ability then
			var_52_2 = var_52_1.sell_ability[#var_52_1.sell_ability]
		else
			var_52_2 = 0
		end
	end

	local var_52_3 = 0

	if arg_52_1 then
		local var_52_4 = SimBusinessGoodsCfg[arg_52_1]

		var_52_3 = (nullable(var_52_4, "sell_ability_addition") or 0) + SimBusinessGoodsTrait.Apply(arg_52_1, nil, arg_52_0)
	end

	return var_52_2, var_52_3
end

function var_0_0.GetShelfLevelText(arg_53_0, arg_53_1)
	local var_53_0

	if not arg_53_1 then
		var_53_0 = var_0_0.GetShelfOverrideLevel(arg_53_0)
	end

	local var_53_1 = var_53_0 or SimBusinessData:GetShelfLevel(arg_53_0)
	local var_53_2 = var_53_0 and "SIM_BUSINESS_STAGE_OVERRIDE_SHELF_LEVEL" or "SIM_BUSINESS_SHELF_LEVEL"

	return GetTipsF(var_53_2, var_53_1)
end

function var_0_0.GetSellAbilityTextShort(arg_54_0, arg_54_1)
	local var_54_0, var_54_1 = var_0_0.GetShelfSellAbility(arg_54_0, arg_54_1)
	local var_54_2 = "SIM_BUSINESS_SELL_ABILITY_SHORT"

	return GetTipsF(var_54_2, var_54_0 + var_54_1, var_54_0, var_54_1)
end

function var_0_0.GetSellAbilityText(arg_55_0, arg_55_1)
	local var_55_0, var_55_1 = var_0_0.GetShelfSellAbility(arg_55_0, arg_55_1)
	local var_55_2 = "SIM_BUSINESS_SELL_ABILITY"

	return GetTipsF(var_55_2, var_55_0 + var_55_1, var_55_0, var_55_1)
end

function var_0_0.GetSellUpgradeText(arg_56_0)
	local var_56_0 = SimBusinessShelfCfg[arg_56_0]
	local var_56_1 = SimBusinessData:GetShelfLevel(arg_56_0)
	local var_56_2 = var_56_0.sell_ability[var_56_1]

	if var_56_2 == nil then
		if var_56_1 and var_56_1 > #var_56_0.sell_ability then
			var_56_2 = var_56_0.sell_ability[#var_56_0.sell_ability]
		else
			var_56_2 = 0
		end
	end

	if var_56_1 >= #var_56_0.sell_ability then
		return GetTipsF("SIM_BUSINESS_MAX_SELL_ABILITY", var_56_2)
	else
		local var_56_3 = var_56_0.sell_ability[var_56_1 + 1] or 0

		return GetTipsF("SIM_BUSINESS_NEXT_SELL_ABILITY", var_56_2, var_56_3)
	end
end

function var_0_0.GetShelfTotalLevel()
	local var_57_0 = 0

	for iter_57_0, iter_57_1 in SimBusinessGame.EnumerateShelves() do
		local var_57_1 = DormUtils.GetEntityData(iter_57_1).cfgID

		var_57_0 = var_57_0 + (var_0_0.GetShelfOverrideLevel(var_57_1) or SimBusinessData:GetShelfLevel(var_57_1))
	end
end

function var_0_0.GetShelfTotalCnt()
	local var_58_0 = 0

	for iter_58_0, iter_58_1 in SimBusinessGame.EnumerateShelves() do
		var_58_0 = var_58_0 + 1
	end

	return var_58_0
end

function var_0_0.GetSellGoodsShelfCnt(arg_59_0)
	local var_59_0 = 0

	for iter_59_0, iter_59_1 in SimBusinessGame.EnumerateShelves() do
		if arg_59_0 == DormUtils.GetEntityData(iter_59_1).goods then
			var_59_0 = var_59_0 + 1
		end
	end

	return var_59_0
end

function var_0_0.GetSellGoodsTypeCntInCatagory(arg_60_0)
	local var_60_0 = {}
	local var_60_1 = 0

	for iter_60_0, iter_60_1 in SimBusinessGame.EnumerateShelves() do
		local var_60_2 = DormUtils.GetEntityData(iter_60_1).goods or 0

		if var_60_2 ~= 0 and nullable(SimBusinessGoodsCfg, var_60_2, "type") == arg_60_0 and not var_60_0[var_60_2] then
			var_60_0[var_60_2] = true
			var_60_1 = var_60_1 + 1
		end
	end

	return var_60_1
end

function var_0_0.GetEachCatagoryGoodsShelfCnt()
	local var_61_0 = {}

	for iter_61_0, iter_61_1 in SimBusinessGame.EnumerateShelves() do
		local var_61_1 = DormUtils.GetEntityData(iter_61_1).goods or 0

		if var_61_1 ~= 0 then
			local var_61_2 = nullable(SimBusinessGoodsCfg, var_61_1, "type")

			if var_61_2 then
				var_61_0[var_61_2] = (var_61_0[var_61_2] or 0) + 1
			end
		end
	end

	return var_61_0
end

function var_0_0.GetPreviewPathLength()
	if SimBusinessMgr.instance then
		return SimBusinessMgr.instance.previewPathLength
	end

	return 0
end

function var_0_0.CheckIsStageNewGuest(arg_63_0)
	local var_63_0 = var_0_0.GetLocalDataKey("simBusinessGuest")
	local var_63_1 = getData(var_63_0, tostring(arg_63_0))

	return var_63_1 == nil or var_63_1 == 0
end

function var_0_0.MarkGuestShown(arg_64_0)
	local var_64_0 = var_0_0.GetLocalDataKey("simBusinessGuest")

	saveData(var_64_0, tostring(arg_64_0), 1)
end

function var_0_0.ClearLocalShelfGoods(arg_65_0, arg_65_1)
	local var_65_0 = {}

	for iter_65_0, iter_65_1 in ipairs(arg_65_1) do
		var_65_0[iter_65_1] = true
	end

	for iter_65_2, iter_65_3 in pairs(arg_65_0) do
		if var_65_0[iter_65_3.goods] then
			iter_65_3.goods = 0
		end
	end
end

return var_0_0
