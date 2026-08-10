local var_0_0 = require("game.config.AutoChessMedalCfg")
local var_0_1 = singletonClass("AutoChessData")

function var_0_1.Init(arg_1_0)
	arg_1_0.gameStatusDic_ = {}
	arg_1_0.battleDataDic_ = {}
	arg_1_0.replayBattleDataDic_ = {}
	arg_1_0.prepareDataDic_ = {}
	arg_1_0.lastShopLevelDic_ = {}
	arg_1_0.isOnlineShopUpgrade_ = false
	arg_1_0.onlineShopLevel_ = 1
	arg_1_0.stageStateDic_ = {}
	arg_1_0.medalInfo = {}

	for iter_1_0, iter_1_1 in ipairs(var_0_0.all) do
		arg_1_0.medalInfo[iter_1_1] = var_0_1.LockedMedalInfo(iter_1_1)
	end

	arg_1_0.recordDataDic_ = {}
	arg_1_0.globalChessDataDic_ = {}
	arg_1_0.globalBuffDataDic_ = {}
	arg_1_0.timeStampDic_ = {}
	arg_1_0.chessSkinList_ = {}
	arg_1_0.sunglassFlag_ = {}
	arg_1_0.scoreBoardDataList_ = {}
	arg_1_0.isCanReconnect_ = false

	arg_1_0:ResetChessData()
end

function var_0_1.SetActivityID(arg_2_0, arg_2_1)
	arg_2_0.activityID_ = arg_2_1
end

function var_0_1.GetActivityID(arg_3_0)
	return arg_3_0.activityID_
end

function var_0_1.UpdateGameStatus(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2 or arg_4_1.game_type

	arg_4_0.gameStatusDic_[var_4_0] = arg_4_1.state

	if arg_4_1.state == AutoChessConst.GAME_STATUS.PREPARE_END then
		AutoChessTools.CheckPrePareEnd(var_4_0)

		if var_4_0 ~= AutoChessConst.GAME_TYPE.ONLINE then
			AutoChessTools.OnExportData(true)
		end
	end
end

function var_0_1.GetGameStatus(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1 or arg_5_0.currentGameType_

	if not arg_5_0.gameStatusDic_[var_5_0] then
		arg_5_0.gameStatusDic_[var_5_0] = AutoChessConst.GAME_STATUS.NONE
	end

	return arg_5_0.gameStatusDic_[var_5_0]
end

function var_0_1.GetIsReplayBattle(arg_6_0, arg_6_1)
	return arg_6_0.gameStatusDic_[arg_6_1] == AutoChessConst.GAME_STATUS.REPLAY
end

function var_0_1.InitPrepareData(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2 or arg_7_1.game_type

	arg_7_0.currentGameType_ = var_7_0
	arg_7_0.prepareDataDic_[arg_7_0.currentGameType_] = AutoChessPrepareDataTemplate.New()

	arg_7_0.prepareDataDic_[arg_7_0.currentGameType_]:Init(arg_7_1, var_7_0)

	if arg_7_0.prepareDataDic_[arg_7_0.currentGameType_].prepareTotalNum > 0 then
		var_0_1:SetIsInPrepareEnd(true)
	end

	arg_7_0:SetTimeStamp(arg_7_0.currentGameType_, arg_7_1.start_timestamp, arg_7_1.end_timestamp)
	manager.notify:Invoke(AUTO_CHESS_UPDATE)
end

function var_0_1.SaveNextRoundPrepareData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.nextRoundData_ = arg_8_1

	for iter_8_0, iter_8_1 in pairs(arg_8_0.nextRoundData_.attr_list) do
		if iter_8_1.key == AutoChessConst.ATTR_KEY.SHOP_STAR_NUM then
			arg_8_0:SetIsOnlineShopUpgrade(arg_8_0.onlineShopLevel_ < iter_8_1.value)
			arg_8_0:SaveOnlineShopLevel(iter_8_1.value)
		end
	end

	arg_8_0:SetTimeStamp(arg_8_2, arg_8_1.start_timestamp, arg_8_1.end_timestamp)
end

function var_0_1.UpdateNextRoundPrepareData(arg_9_0)
	if arg_9_0.nextRoundData_ then
		arg_9_0.prepareDataDic_[arg_9_0.currentGameType_] = AutoChessPrepareDataTemplate.New()

		arg_9_0.prepareDataDic_[arg_9_0.currentGameType_]:Init(arg_9_0.nextRoundData_, arg_9_0.currentGameType_)
		arg_9_0:InitGlobalPrepareData(arg_9_0.currentGameType_)

		if arg_9_0.prepareDataDic_[arg_9_0.currentGameType_].prepareTotalNum > 0 then
			var_0_1:SetIsInPrepareEnd(true)
		end
	end

	arg_9_0.nextRoundData_ = nil
end

function var_0_1.SetTimeStamp(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_2 or not arg_10_3 then
		return
	end

	if not arg_10_0.timeStampDic_ then
		arg_10_0.timeStampDic_ = {}
	end

	arg_10_0.timeStampDic_[arg_10_1] = {
		startTime = arg_10_2,
		endTime = arg_10_3
	}
end

function var_0_1.GetEndTimeStamp(arg_11_0, arg_11_1)
	return arg_11_0.timeStampDic_[arg_11_1]
end

function var_0_1.UpdatePrepareReadyData(arg_12_0, arg_12_1, arg_12_2)
	if AutoChessBattleRenderer.GetInstance():GetIsInPrepareView() then
		arg_12_0.prepareDataDic_[arg_12_1]:ResetHeroUpgradeInfo()
		arg_12_0.prepareDataDic_[arg_12_1]:UpdatePrepareReadyData(arg_12_2)
		manager.notify:Invoke(AUTO_CHESS_PREPARE_NUM, arg_12_2.prepare_num, arg_12_2.all_num)

		if gameContext:GetLastOpenPage() == "autoChessHeroUpgradePopView_4_8" or gameContext:GetLastOpenPage() == "autoChessShopLevelUpPop" then
			JumpTools.Back()
		end
	elseif arg_12_0.nextRoundData_ then
		arg_12_0.nextRoundData_.hero_upgrade_info.old_level = 0
		arg_12_0.nextRoundData_.hero_upgrade_info.new_level = 0
		arg_12_0.nextRoundData_.close_opt.prepare_num = arg_12_2.prepare_num
		arg_12_0.nextRoundData_.close_opt.all_num = arg_12_2.all_num

		for iter_12_0, iter_12_1 in pairs(arg_12_0.nextRoundData_) do
			if iter_12_1.key == AutoChessConst.ATTR_KEY.SHOP_STAR_NUM then
				arg_12_0.lastShopLevelDic_[arg_12_1] = iter_12_1.value
			end
		end
	end
end

function var_0_1.SetChessSkin(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.chessSkinList_[arg_13_1] = arg_13_2
end

function var_0_1.GetChessSkin(arg_14_0, arg_14_1)
	return arg_14_0.chessSkinList_[arg_14_1]
end

function var_0_1.SetSunglassFlag(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.sunglassFlag_[arg_15_1] = arg_15_2
end

function var_0_1.GetSunglassFlag(arg_16_0, arg_16_1)
	if arg_16_0.currentGameType_ == AutoChessConst.GAME_TYPE.ONLINE then
		return arg_16_0.sunglassFlag_[arg_16_1]
	else
		return false
	end
end

function var_0_1.GetChessSkinByChessId(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0.chessSkinList_[arg_17_1] == nil then
		return nil
	end

	return arg_17_0.chessSkinList_[arg_17_1][arg_17_2]
end

function var_0_1.SetCurGameType(arg_18_0, arg_18_1)
	arg_18_0.currentGameType_ = arg_18_1
end

function var_0_1.GetCurGameType(arg_19_0)
	return arg_19_0.currentGameType_
end

function var_0_1.GetPrepareData(arg_20_0, arg_20_1)
	if arg_20_0.prepareDataDic_ == nil then
		return
	end

	if arg_20_1 then
		return arg_20_0.prepareDataDic_[arg_20_1]
	end

	return arg_20_0.prepareDataDic_[arg_20_0.currentGameType_]
end

function var_0_1.GetShopChessDataByByUniqueId(arg_21_0, arg_21_1, arg_21_2)
	return arg_21_0:GetPrepareData(arg_21_1):GetShopChessDataByByUniqueId(arg_21_2)
end

function var_0_1.InitBattleData(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.currentGameType_ = arg_22_2 or arg_22_1.game_type

	if arg_22_0:GetIsReplayBattle(arg_22_0.currentGameType_) then
		arg_22_0.replayBattleDataDic_[arg_22_0.currentGameType_] = AutoChessBattleDataTemplate.New()

		arg_22_0.replayBattleDataDic_[arg_22_0.currentGameType_]:Init(arg_22_1)
	else
		arg_22_0.replayBattleDataDic_[arg_22_0.currentGameType_] = nil
		arg_22_0.battleDataDic_[arg_22_0.currentGameType_] = AutoChessBattleDataTemplate.New()

		arg_22_0.battleDataDic_[arg_22_0.currentGameType_]:Init(arg_22_1, arg_22_0.currentGameType_)
	end
end

function var_0_1.SaveOnlineBattleData(arg_23_0, arg_23_1)
	arg_23_0.onlineBattleData_ = arg_23_1
end

function var_0_1.GetOnlineBattleData(arg_24_0)
	return arg_24_0.onlineBattleData_
end

function var_0_1.GetBattleData(arg_25_0, arg_25_1)
	if arg_25_0:GetIsReplayBattle(arg_25_1) then
		return arg_25_0.replayBattleDataDic_[arg_25_1]
	else
		if arg_25_1 then
			return arg_25_0.battleDataDic_[arg_25_1]
		end

		return arg_25_0.battleDataDic_[arg_25_0.currentGameType_]
	end
end

function var_0_1.GetReplayBattleData(arg_26_0, arg_26_1)
	return arg_26_0.replayBattleDataDic_[arg_26_1]
end

function var_0_1.InitRoundBattleData(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_2 or arg_27_1.game_type

	if arg_27_0:GetIsReplayBattle(var_27_0) then
		arg_27_0.replayBattleDataDic_[var_27_0]:InitRoundBattleData(arg_27_1)
	else
		arg_27_0.battleDataDic_[var_27_0]:InitRoundBattleData(arg_27_1)
	end
end

function var_0_1.SaveBattleRoundData(arg_28_0, arg_28_1)
	arg_28_0.battleRoundData_ = arg_28_0.battleRoundData_ or {}

	table.insert(arg_28_0.battleRoundData_, arg_28_1)
end

function var_0_1.InitOnlineBattleRoundData(arg_29_0)
	for iter_29_0, iter_29_1 in pairs(arg_29_0.battleRoundData_ or {}) do
		arg_29_0.battleDataDic_[AutoChessConst.GAME_TYPE.ONLINE]:InitRoundBattleData(iter_29_1)
	end

	arg_29_0.battleRoundData_ = nil
end

function var_0_1.UpdateAttrData(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0.prepareDataDic_[arg_30_1]:UpdateAttrData(arg_30_2)
	manager.notify:Invoke(AUTO_CHESS_ROUND_UPDATE)
end

function var_0_1.UpdateShopItemData(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0.prepareDataDic_[arg_31_1]:UpdateShopData(arg_31_2)
	manager.notify:Invoke(AUTO_CHESS_SHOP_UPDATE)
end

function var_0_1.UpdateShopItemLock(arg_32_0, arg_32_1)
	arg_32_0.prepareDataDic_[arg_32_1.game_type]:UpdateShopLock(arg_32_1.type, arg_32_1.info_list)
	manager.notify:Invoke(AUTO_CHESS_SHOP_UPDATE)
end

function var_0_1.RemoveShopItemByUniqueId(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0.prepareDataDic_[arg_33_1]:RemoveShopItemByUniqueId(arg_33_2)
	manager.notify:Invoke(AUTO_CHESS_SHOP_UPDATE)
end

function var_0_1.UpdateChessTeamDataList(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0.prepareDataDic_[arg_34_1]:UpdateChessTeamDataList(arg_34_2)

	local var_34_0 = arg_34_0:GetPrepareData(arg_34_1).playerData

	for iter_34_0, iter_34_1 in pairs(arg_34_2) do
		arg_34_0:AddChess(var_34_0, iter_34_1)
	end
end

function var_0_1.ClearPlayerChessData(arg_35_0, arg_35_1)
	arg_35_0.prepareDataDic_[arg_35_1]:ClearPlayerChessData()
end

function var_0_1.GetPlayerChessData(arg_36_0, arg_36_1)
	return arg_36_0.prepareDataDic_[arg_36_1]:GetPlayerData():GetPlayerChessData()
end

function var_0_1.GetPlayerData(arg_37_0, arg_37_1)
	arg_37_1 = arg_37_1 or arg_37_0.currentGameType_

	return arg_37_0.prepareDataDic_[arg_37_1]:GetPlayerData()
end

function var_0_1.UpdatePrepareActionList(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if not AutoChessBattleRenderer.GetInstance():GetIsInPrepareView() then
		return
	end

	if not arg_38_0.prepareDataDic_[arg_38_1] then
		return
	end

	if arg_38_0.isInPrepareEnd_ then
		arg_38_0:SetIsInPrepareEndAction(true)
	end

	if arg_38_3 then
		arg_38_0:SaveCatchPrepareActionList(arg_38_1, arg_38_2)
	else
		arg_38_0.prepareDataDic_[arg_38_1]:UpdatePrepareActionList(arg_38_2)
	end
end

function var_0_1.ClearBattleData(arg_39_0, arg_39_1)
	if arg_39_0.battleDataDic_[arg_39_1] then
		arg_39_0.battleDataDic_[arg_39_1] = nil
	end

	if arg_39_0.gameStatusDic_[arg_39_1] then
		arg_39_0.gameStatusDic_[arg_39_1] = AutoChessConst.GAME_STATUS.NONE
	end

	if arg_39_0.prepareDataDic_[arg_39_1] then
		arg_39_0.prepareDataDic_[arg_39_1] = nil
	end
end

function var_0_1.SetIsInChangeTeam(arg_40_0, arg_40_1)
	arg_40_0.isInChangeTeam_ = arg_40_1
end

function var_0_1.GetIsInChangeTeam(arg_41_0)
	return arg_41_0.isInChangeTeam_
end

function var_0_1.SetIsInBuyChess(arg_42_0, arg_42_1)
	arg_42_0.isInBuyChess_ = arg_42_1
end

function var_0_1.GetIsInBuyChess(arg_43_0)
	return arg_43_0.isInBuyChess_
end

function var_0_1.SetPointChessData(arg_44_0, arg_44_1)
	arg_44_0.pointChessData_ = arg_44_1
end

function var_0_1.GetPointChessData(arg_45_0)
	return arg_45_0.pointChessData_
end

function var_0_1.SetIsInUseProp(arg_46_0, arg_46_1)
	arg_46_0.isInUseProp_ = arg_46_1
end

function var_0_1.GetIsInUseProp(arg_47_0)
	return arg_47_0.isInUseProp_
end

function var_0_1.SetIsInPrepareEnd(arg_48_0, arg_48_1)
	arg_48_0.isInPrepareEnd_ = arg_48_1
end

function var_0_1.GetIsInPrepareEnd(arg_49_0)
	return arg_49_0.isInPrepareEnd_
end

function var_0_1.SetIsInPrepareEndAction(arg_50_0, arg_50_1)
	arg_50_0.isInPrepareEndAction_ = arg_50_1
end

function var_0_1.GetIsInPrepareEndAction(arg_51_0)
	return arg_51_0.isInPrepareEndAction_
end

function var_0_1.SetStageStoryId(arg_52_0, arg_52_1)
	arg_52_0.stageStoryId_ = arg_52_1
end

function var_0_1.GetStageStoryId(arg_53_0)
	return arg_53_0.stageStoryId_
end

function var_0_1.SetRandomBgIndex(arg_54_0, arg_54_1)
	arg_54_0.randomBgIndex_ = arg_54_1
end

function var_0_1.GetRandomBgIndex(arg_55_0)
	return arg_55_0.randomBgIndex_
end

function var_0_1.SetIsInMatch(arg_56_0, arg_56_1)
	arg_56_0.isInMatch_ = arg_56_1
	arg_56_0.startMatchTime_ = arg_56_1 and manager.time:GetServerTime() or nil
end

function var_0_1.GetIsInMatch(arg_57_0)
	return arg_57_0.isInMatch_, arg_57_0.startMatchTime_
end

function var_0_1.ResetChessData(arg_58_0)
	arg_58_0.lastShopLevelDic_ = {}
	arg_58_0.isOnlineShopUpgrade_ = false
	arg_58_0.onlineShopLevel_ = 1
	arg_58_0.battleBossRound = nil
	arg_58_0.isInChangeTeam_ = false
	arg_58_0.isInBuyChess_ = false
	arg_58_0.pointChessData_ = nil
	arg_58_0.isInUseProp_ = false
	arg_58_0.isInPrepareEnd_ = false
	arg_58_0.isInPrepareEndAction_ = false
	arg_58_0.randomBgIndex_ = nil
	arg_58_0.globalChessDataDic_ = {}
	arg_58_0.globalBuffDataDic_ = {}
	arg_58_0.simulateSelfPlayerData = nil
	arg_58_0.simulateOpPlayerData = nil
	arg_58_0.nextRoundData_ = nil
	arg_58_0.battleData_ = nil
	arg_58_0.roundSettlePlayerDataList_ = nil
	arg_58_0.totalSettlePlayerData_ = nil
	arg_58_0.scoreBoardDataList_ = nil
	arg_58_0.catchPrepareActionList_ = {}

	if AutoChessBattleSimulator.GetInstance().isInit then
		AutoChessBattleSimulator.GetInstance():Dispose()
	end
end

function var_0_1.SaveLastShopLevel(arg_59_0, arg_59_1)
	arg_59_0.lastShopLevelDic_[arg_59_1] = AutoChessTools.GetAttrValue(arg_59_1, AutoChessConst.ATTR_KEY.SHOP_STAR_NUM)
end

function var_0_1.GetLastShopLevel(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0.lastShopLevelDic_[arg_60_1]

	arg_60_0.lastShopLevelDic_[arg_60_1] = nil

	return var_60_0
end

function var_0_1.SetIsOnlineShopUpgrade(arg_61_0, arg_61_1)
	arg_61_0.isOnlineShopUpgrade_ = arg_61_1
end

function var_0_1.GetIsOnlineShopUpgrade(arg_62_0)
	return arg_62_0.isOnlineShopUpgrade_
end

function var_0_1.SaveOnlineShopLevel(arg_63_0, arg_63_1)
	arg_63_0.onlineShopLevel_ = arg_63_1 or AutoChessTools.GetAttrValue(gameType, AutoChessConst.ATTR_KEY.SHOP_STAR_NUM)
end

function var_0_1.GetOnlineShopLevel(arg_64_0)
	return arg_64_0.onlineShopLevel_
end

function var_0_1.GetNowShopLevel(arg_65_0, arg_65_1)
	return AutoChessTools.GetAttrValue(arg_65_1, AutoChessConst.ATTR_KEY.SHOP_STAR_NUM)
end

function var_0_1.UpdateStageData(arg_66_0, arg_66_1)
	for iter_66_0, iter_66_1 in ipairs(arg_66_1) do
		if iter_66_1.id == nil then
			debugger.WaitIDE()
			debugger.BreakHere()
		end

		arg_66_0.stageStateDic_[iter_66_1.id] = iter_66_1.time
	end

	arg_66_0:UpdateStageRedPoint()
end

function var_0_1.GetStageData(arg_67_0)
	return arg_67_0.stageStateDic_
end

var_0_1.MedalCategory = {
	Advanced = 2,
	Locked = 0,
	Basic = 1
}

function var_0_1.InitMedal(arg_68_0, arg_68_1)
	for iter_68_0, iter_68_1 in ipairs(arg_68_1) do
		local var_68_0 = arg_68_0.medalInfo[iter_68_1.id]

		if var_68_0 == nil then
			debugger.WaitIDE()
			debugger.BreakHere()
		end

		var_68_0.level = iter_68_1.level or var_0_1.MedalCategory.Locked
		var_68_0.unlockTime, var_68_0.advanceTime = iter_68_1.unlock_time, iter_68_1.upgrade_time
	end
end

function var_0_1.IsMedalUnlockedFromInfo(arg_69_0)
	return (nullable(arg_69_0, "level") or var_0_1.MedalCategory.Locked) ~= var_0_1.MedalCategory.Locked
end

function var_0_1.IsMedalAdvancedFromInfo(arg_70_0)
	return (nullable(arg_70_0, "level") or var_0_1.MedalCategory.Locked) == var_0_1.MedalCategory.Advanced
end

function var_0_1.IsMedalUnlocked(arg_71_0, arg_71_1)
	local var_71_0, var_71_1 = arg_71_0:FindMedalInfo(arg_71_1)

	return var_71_0 and var_0_1.IsMedalUnlockedFromInfo(var_71_1), var_71_1
end

function var_0_1.IsMedalAdvanced(arg_72_0, arg_72_1)
	local var_72_0, var_72_1 = arg_72_0:FindMedalInfo(arg_72_1)

	return var_0_1.IsMedalAdvancedFromInfo(var_72_1), var_72_1
end

function var_0_1.FindMedalInfo(arg_73_0, arg_73_1)
	if arg_73_0.medalInfo then
		return table.indexof(var_0_0.all, arg_73_1), arg_73_0.medalInfo[arg_73_1]
	end

	return nil, nil
end

function var_0_1.LockedMedalInfo(arg_74_0)
	return {
		advanceTime = 0,
		unlockTime = 0,
		level = 0,
		id = arg_74_0
	}
end

function var_0_1.InitBattleRecord(arg_75_0, arg_75_1)
	arg_75_0.recordDataDic_ = {}
	arg_75_0.recordDataDic_[AutoChessConst.RECORD_TYPE.PVP] = {}

	for iter_75_0, iter_75_1 in ipairs(arg_75_1.record) do
		local var_75_0 = AutoChessRecordItemDataTemplate.New()

		var_75_0:Init(iter_75_1, AutoChessConst.RECORD_TYPE.PVP)
		table.insert(arg_75_0.recordDataDic_[AutoChessConst.RECORD_TYPE.PVP], var_75_0)
	end

	arg_75_0.recordDataDic_[AutoChessConst.RECORD_TYPE.GLORY] = {}

	for iter_75_2, iter_75_3 in ipairs(arg_75_1.medal_record) do
		for iter_75_4, iter_75_5 in ipairs(iter_75_3.medal_ids or {}) do
			local var_75_1 = AutoChessRecordItemDataTemplate.New(iter_75_5)

			var_75_1:Init(iter_75_3, AutoChessConst.RECORD_TYPE.GLORY)
			table.insert(arg_75_0.recordDataDic_[AutoChessConst.RECORD_TYPE.GLORY], var_75_1)
		end
	end
end

function var_0_1.InitOnlineBattleRecord(arg_76_0, arg_76_1, arg_76_2)
	arg_76_0.recordDataDic_[arg_76_2] = {}

	for iter_76_0, iter_76_1 in ipairs(arg_76_1.record_list) do
		local var_76_0 = AutoChessRecordItemDataTemplate.New()

		var_76_0:Init(iter_76_1, arg_76_2)
		table.insert(arg_76_0.recordDataDic_[arg_76_2], var_76_0)
	end
end

function var_0_1.UpdateBattleRecord(arg_77_0, arg_77_1)
	if arg_77_1.type == 1 then
		for iter_77_0, iter_77_1 in ipairs(arg_77_1.record) do
			local var_77_0 = AutoChessRecordItemDataTemplate.New()

			var_77_0:Init(iter_77_1, AutoChessConst.RECORD_TYPE.PVP)
			table.insert(arg_77_0.recordDataDic_[AutoChessConst.RECORD_TYPE.PVP], var_77_0)
		end
	end

	table.sort(arg_77_0.recordDataDic_[AutoChessConst.RECORD_TYPE.PVP], function(arg_78_0, arg_78_1)
		return arg_78_1.timestamp < arg_78_0.timestamp
	end)

	if arg_77_1.type == 2 then
		for iter_77_2, iter_77_3 in ipairs(arg_77_1.record) do
			for iter_77_4, iter_77_5 in ipairs(iter_77_3.medal_ids or {}) do
				local var_77_1 = AutoChessRecordItemDataTemplate.New(iter_77_5)

				var_77_1:Init(iter_77_3, AutoChessConst.RECORD_TYPE.GLORY)
				table.insert(arg_77_0.recordDataDic_[AutoChessConst.RECORD_TYPE.GLORY], var_77_1)
			end
		end
	end

	table.sort(arg_77_0.recordDataDic_[AutoChessConst.RECORD_TYPE.GLORY], function(arg_79_0, arg_79_1)
		return arg_79_1.timestamp < arg_79_0.timestamp
	end)
end

function var_0_1.GetRecordDataList(arg_80_0, arg_80_1)
	return arg_80_0.recordDataDic_[arg_80_1]
end

function var_0_1.InitGlobalPrepareData(arg_81_0, arg_81_1)
	arg_81_0.globalChessDataDic_ = {}
	arg_81_0.globalBuffDataDic_ = {}

	local var_81_0 = arg_81_0:GetPrepareData(arg_81_1)
	local var_81_1 = var_81_0.playerData
	local var_81_2 = var_81_1.chessDataDicByUniqueId

	for iter_81_0, iter_81_1 in pairs(var_81_2) do
		arg_81_0:AddChess(var_81_1, iter_81_1)
	end

	for iter_81_2, iter_81_3 in pairs(var_81_0.buffDataList) do
		arg_81_0:AddGlobalBuffDataDic(iter_81_3, var_81_1, iter_81_3.ownType, iter_81_3.sourceUid)
	end
end

function var_0_1.InitGlobalBattleData(arg_82_0, arg_82_1)
	local var_82_0 = arg_82_0:GetBattleData(arg_82_1)

	if not var_82_0 then
		return
	end

	arg_82_0.simulateSelfPlayerData = deepClone(var_82_0.selfPlayerData)
	arg_82_0.simulateOpPlayerData = deepClone(var_82_0.oppenentPlayerData)
	arg_82_0.globalChessDataDic_ = {}
	arg_82_0.globalBuffDataDic_ = {}

	local var_82_1 = arg_82_0.simulateSelfPlayerData.chessDataDicByUniqueId

	for iter_82_0, iter_82_1 in pairs(var_82_1) do
		arg_82_0:AddChess(arg_82_0.simulateSelfPlayerData, iter_82_1)
	end

	local var_82_2 = arg_82_0.simulateOpPlayerData.chessDataDicByUniqueId

	for iter_82_2, iter_82_3 in pairs(var_82_2) do
		arg_82_0:AddChess(arg_82_0.simulateOpPlayerData, iter_82_3)
	end
end

function var_0_1.GetSimulatePlayerData(arg_83_0, arg_83_1)
	if arg_83_1 == AutoChessConst.PLAYER_TYPE.SELF then
		return arg_83_0.simulateSelfPlayerData
	elseif arg_83_1 == AutoChessConst.PLAYER_TYPE.OPPONENT then
		return arg_83_0.simulateOpPlayerData
	end
end

function var_0_1.GetBattlerPlayerUid(arg_84_0)
	local var_84_0 = arg_84_0:GetBattleData(arg_84_0.currentGameType_)

	if not var_84_0 then
		return
	end

	return var_84_0.selfPlayerUid, var_84_0.oppenentPlayerUid
end

function var_0_1.AddGlobalChessDataDic(arg_85_0, arg_85_1, arg_85_2)
	arg_85_0.globalChessDataDic_[arg_85_1.uniqueId] = {
		playerData = arg_85_2,
		chessData = arg_85_1
	}
end

function var_0_1.GetPlayerTypeByChessUid(arg_86_0, arg_86_1)
	if arg_86_0.globalChessDataDic_[arg_86_1] then
		return arg_86_0.globalChessDataDic_[arg_86_1].playerData.playerType
	else
		arg_86_0:PrintAllChes(arg_86_1)
	end
end

function var_0_1.GetPlayerDataByChessUid(arg_87_0, arg_87_1)
	if arg_87_0.globalChessDataDic_[arg_87_1] then
		return arg_87_0.globalChessDataDic_[arg_87_1].playerData
	else
		arg_87_0:PrintAllChes(arg_87_1)
	end
end

function var_0_1.GetChessData(arg_88_0, arg_88_1)
	if arg_88_0.globalChessDataDic_[arg_88_1] then
		return arg_88_0.globalChessDataDic_[arg_88_1].chessData
	else
		arg_88_0:PrintAllChes(arg_88_1)
	end
end

function var_0_1.PrintAllChes(arg_89_0, arg_89_1)
	Debug.Log("PrintAllChes(), chessData not exist: " .. arg_89_1)

	local var_89_0 = {}

	for iter_89_0, iter_89_1 in pairs(arg_89_0.globalChessDataDic_) do
		table.insert(var_89_0, iter_89_0)
	end

	trace("nowChessList:%o", var_89_0)
end

function var_0_1.AddChess(arg_90_0, arg_90_1, arg_90_2)
	arg_90_1:AddChess(arg_90_2)
	arg_90_0:AddGlobalChessDataDic(arg_90_2, arg_90_1)

	local var_90_0 = arg_90_2.buffDataList

	for iter_90_0, iter_90_1 in pairs(var_90_0) do
		arg_90_0:AddGlobalBuffDataDic(iter_90_1, arg_90_1, AutoChessConst.BUFF_TARGET_TYPE.CHESS, arg_90_2.uniqueId)
	end
end

function var_0_1.RemoveChess(arg_91_0, arg_91_1)
	arg_91_0:GetPlayerDataByChessUid(arg_91_1):RemoveChess(arg_91_1)
end

function var_0_1.AddGlobalBuffDataDic(arg_92_0, arg_92_1, arg_92_2, arg_92_3, arg_92_4)
	arg_92_0.globalBuffDataDic_[arg_92_1.uniqueId] = {
		playerData = arg_92_2,
		buffData = arg_92_1,
		targetType = arg_92_3,
		targetUid = arg_92_4
	}
end

function var_0_1.GetPlayerTypeByBuffUid(arg_93_0, arg_93_1)
	if arg_93_0.globalBuffDataDic_[arg_93_1] then
		return arg_93_0.globalBuffDataDic_[arg_93_1].playerType
	else
		Debug.LogError("GetPlayerTypeByBuffUid(), buffData not exist :" .. arg_93_1)
	end
end

function var_0_1.GetBuffData(arg_94_0, arg_94_1)
	if arg_94_0.globalBuffDataDic_[arg_94_1] then
		return arg_94_0.globalBuffDataDic_[arg_94_1].buffData
	else
		Debug.Log("GetBuffData(), buffData not exis :" .. arg_94_1 .. ", 可能是商店道具的buff")
	end
end

function var_0_1.GetBuffTargetInfo(arg_95_0, arg_95_1)
	if arg_95_0.globalBuffDataDic_[arg_95_1] then
		return arg_95_0.globalBuffDataDic_[arg_95_1].targetType, arg_95_0.globalBuffDataDic_[arg_95_1].targetUid
	else
		Debug.Log("GetBuffTargetInfo(), buffData not exis :" .. arg_95_1 .. ", 可能是商店偷取棋子的buff")
	end
end

function var_0_1.RemoveBuff(arg_96_0, arg_96_1)
	if arg_96_0.globalBuffDataDic_[arg_96_1] then
		local var_96_0 = arg_96_0.globalBuffDataDic_[arg_96_1].targetType
		local var_96_1 = arg_96_0.globalBuffDataDic_[arg_96_1].targetUid

		if var_96_0 == AutoChessConst.BUFF_TARGET_TYPE.CHESS then
			local var_96_2 = arg_96_0:GetChessData(var_96_1)

			if var_96_2 then
				var_96_2:RemoveBuff(arg_96_1)
			end
		elseif var_96_0 == AutoChessConst.BUFF_TARGET_TYPE.PLAYER or var_96_0 == AutoChessConst.BUFF_TARGET_TYPE.GAME then
			arg_96_0:GetPrepareData():RemoveBuffDataList(arg_96_0.globalBuffDataDic_[arg_96_1].buffData)
		end
	else
		Debug.Log("RemoveBuff(), buffData not exis :" .. arg_96_1)
	end
end

function var_0_1.RefreshBuff(arg_97_0, arg_97_1)
	local var_97_0 = arg_97_0.globalBuffDataDic_[arg_97_1.uniqueId]

	if var_97_0 then
		local var_97_1 = var_97_0.targetType
		local var_97_2 = var_97_0.targetUid

		if var_97_1 == AutoChessConst.BUFF_TARGET_TYPE.CHESS then
			local var_97_3 = arg_97_0:GetChessData(var_97_2)

			if var_97_3 then
				var_97_3:RefreshBuff(arg_97_1)

				return
			end
		end
	end

	Debug.Log("RefreshBuff(), buffData not exis :" .. arg_97_1.uniqueId .. ", 可能不是棋子的buff")
end

function var_0_1.AddBuff(arg_98_0, arg_98_1, arg_98_2, arg_98_3)
	if arg_98_2 == AutoChessConst.BUFF_TARGET_TYPE.CHESS then
		local var_98_0 = arg_98_0:GetPlayerDataByChessUid(arg_98_3)
		local var_98_1 = arg_98_0:GetChessData(arg_98_3)

		if not var_98_1 then
			Debug.LogError("AutoChessData:AddBuff(), chessData not exis :" .. arg_98_3)

			return
		end

		var_98_1:AddBuff(arg_98_1)
		arg_98_0:AddGlobalBuffDataDic(arg_98_1, var_98_0, arg_98_2, arg_98_3)
	elseif arg_98_1.ownType == AutoChessConst.BUFF_TARGET_TYPE.PLAYER or arg_98_1.ownType == AutoChessConst.BUFF_TARGET_TYPE.GAME then
		arg_98_0:AddGlobalBuffDataDic(arg_98_1, playerData, arg_98_2, arg_98_3)
		arg_98_0:GetPrepareData():AddBuffDataList(arg_98_1)
	end
end

function var_0_1.CheckIsBattleBossRound(arg_99_0, arg_99_1)
	local var_99_0 = AutoChessTools.GetCurStageId()
	local var_99_1 = AutoChessTools.GetCurRound()

	if tonumber(arg_99_1) >= 4 and not arg_99_0.battleBossRound and var_99_1 ~= 0 and tonumber(var_99_0) == GameSetting.auto_chess_boss_stage.value[1] then
		arg_99_0.battleBossRound = var_99_1
	end
end

function var_0_1.GetBattleBossRound(arg_100_0)
	return arg_100_0.battleBossRound
end

function var_0_1.InitRedPointGroup(arg_101_0)
	local var_101_0 = RedPointConst.AUTO_CHESS_ACTIVITY_MAIN .. ActivityConst.ACTIVITY_AUTO_CHESS_MAIN
	local var_101_1 = RedPointConst.AUTO_CHESS_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_TASK
	local var_101_2 = ActivityCfg[ActivityConst.ACTIVITY_AUTO_CHESS_TASK]
	local var_101_3 = {
		RedPointConst.AUTO_CHESS_LIMIT_TASK_TAG .. ActivityConst.ACTIVITY_AUTO_CHESS_TASK
	}

	for iter_101_0, iter_101_1 in pairs(var_101_2.sub_activity_list) do
		local var_101_4 = RedPointConst.AUTO_CHESS_LIMIT_TASK_TAG .. iter_101_1

		table.insert(var_101_3, var_101_4)
	end

	manager.redPoint:addGroup(var_101_1, var_101_3)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		var_0_1:UpdateTaskRedPoint()
	end)

	local var_101_5 = RedPointConst.AUTO_CHESS_RESIDENT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_MAIN
	local var_101_6 = RedPointConst.AUTO_CHESS_PVE_STAGE
	local var_101_7 = {}

	for iter_101_2, iter_101_3 in ipairs(AutoChessAreaCfg.all) do
		local var_101_8 = RedPointConst.AUTO_CHESS_PVE_STAGE_AREA .. iter_101_3
		local var_101_9 = AutoChessAreaCfg[iter_101_3]
		local var_101_10 = RedPointConst.AUTO_CHESS_PVE_STAGE_ITEM .. var_101_9.stage_list[4]

		manager.redPoint:addGroup(var_101_8, {
			var_101_10
		})
		table.insert(var_101_7, var_101_8)
	end

	manager.redPoint:addGroup(var_101_6, var_101_7)

	local var_101_11 = RedPointConst.AUTO_CHESS_SKIN_DLC_GIFT .. ActivityConst.ACTIVITY_AUTO_CHESS_SKIN

	manager.redPoint:addGroup(RedPointConst.AUTO_CHESS_GO_BTN, {
		var_101_1,
		var_101_5,
		var_101_6,
		var_101_11
	})
	manager.redPoint:addGroup(var_101_0, {
		RedPointConst.AUTO_CHESS_GO_BTN,
		var_101_11,
		var_101_1
	})
end

function var_0_1.UpdateTaskRedPoint(arg_103_0)
	local var_103_0 = ActivityCfg[ActivityConst.ACTIVITY_AUTO_CHESS_TASK]

	arg_103_0:TaskRedSet(var_103_0.sub_activity_list, RedPointConst.AUTO_CHESS_LIMIT_TASK_TAG)
	arg_103_0:TaskRedSet({
		ActivityConst.ACTIVITY_AUTO_CHESS_TASK
	}, RedPointConst.AUTO_CHESS_LIMIT_TASK_TAG)
	arg_103_0:TaskRedSet({
		ActivityConst.ACTIVITY_AUTO_CHESS_MAIN
	}, RedPointConst.AUTO_CHESS_RESIDENT_TASK)
	arg_103_0:TaskRedSet({
		ActivityConst.ACTIVITY_AUTO_CHESS_SKIN
	}, RedPointConst.AUTO_CHESS_SKIN_DLC_GIFT)
end

function var_0_1.TaskRedSet(arg_104_0, arg_104_1, arg_104_2)
	for iter_104_0, iter_104_1 in pairs(arg_104_1) do
		local var_104_0 = ActivityData:GetActivityIsOpen(iter_104_1)

		for iter_104_2, iter_104_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_104_1]) do
			local var_104_1 = arg_104_2 .. iter_104_1

			if var_104_0 then
				local var_104_2 = TaskData2:GetTaskProgress(iter_104_3)
				local var_104_3 = AssignmentCfg[iter_104_3]

				if TaskData2:GetTaskComplete(iter_104_3) then
					manager.redPoint:setTip(var_104_1, 0)
				elseif var_104_2 >= var_104_3.need then
					manager.redPoint:setTip(var_104_1, 1)

					break
				else
					manager.redPoint:setTip(var_104_1, 0)
				end
			else
				manager.redPoint:setTip(var_104_1, 0)
			end
		end
	end
end

function var_0_1.UpdateStageRedPoint(arg_105_0)
	for iter_105_0, iter_105_1 in ipairs(AutoChessAreaCfg.all) do
		local var_105_0 = AutoChessAreaCfg[iter_105_1].stage_list[4]

		if AutoChessTools.GetStageState(var_105_0) == AutoChessConst.STAGE_STATE.UNLOCK and getData("auto_chess_pve_stage", "diffcult_" .. var_105_0) ~= 1 then
			manager.redPoint:setTip(RedPointConst.AUTO_CHESS_PVE_STAGE_ITEM .. var_105_0, 1)
		else
			manager.redPoint:setTip(RedPointConst.AUTO_CHESS_PVE_STAGE_ITEM .. var_105_0, 0)
		end
	end
end

function var_0_1.UpdateScoreBoardData(arg_106_0, arg_106_1)
	arg_106_0.scoreBoardDataList_ = {}

	for iter_106_0, iter_106_1 in ipairs(arg_106_1) do
		local var_106_0 = AutoChessScoreBoardDataTemplate.New()

		var_106_0:Init(iter_106_1)
		table.insert(arg_106_0.scoreBoardDataList_, var_106_0)
	end

	table.sort(arg_106_0.scoreBoardDataList_, function(arg_107_0, arg_107_1)
		return arg_107_0.rankIndex < arg_107_1.rankIndex
	end)
end

function var_0_1.GetScoreBoardDataList(arg_108_0)
	return arg_108_0.scoreBoardDataList_
end

function var_0_1.UpdateRoundSettlePlayerData(arg_109_0, arg_109_1)
	arg_109_0.roundSettlePlayerDataList_ = {}

	for iter_109_0, iter_109_1 in ipairs(arg_109_1) do
		local var_109_0 = AutoChessScoreBoardDataTemplate.New()

		var_109_0:Init(iter_109_1)
		table.insert(arg_109_0.roundSettlePlayerDataList_, var_109_0)
	end

	table.sort(arg_109_0.roundSettlePlayerDataList_, function(arg_110_0, arg_110_1)
		return arg_110_0.rankIndex < arg_110_1.rankIndex
	end)
end

function var_0_1.GetRoundSettlePlayerDataList(arg_111_0)
	return arg_111_0.roundSettlePlayerDataList_
end

function var_0_1.UpdateTotalSettlePlayerData(arg_112_0, arg_112_1)
	arg_112_0.totalSettlePlayerData_ = {}
	arg_112_0.totalSettlePlayerData_.rankIndex = arg_112_1.rank_index
	arg_112_0.totalSettlePlayerData_.rankTotalScore = arg_112_1.total_score
	arg_112_0.totalSettlePlayerData_.rankChangeScore = arg_112_1.change_score
end

function var_0_1.GetTotalSettlePlayerData(arg_113_0)
	return arg_113_0.totalSettlePlayerData_
end

function var_0_1.SetIsCanReconnectAutoChess(arg_114_0, arg_114_1)
	arg_114_0.isCanReconnect_ = arg_114_1
end

function var_0_1.GetIsCanReconnectAutoChess(arg_115_0)
	return arg_115_0.isCanReconnect_
end

function var_0_1.SaveCatchPrepareActionList(arg_116_0, arg_116_1, arg_116_2)
	arg_116_0.catchPrepareActionList_[arg_116_1] = arg_116_0.catchPrepareActionList_[arg_116_1] or {}

	if arg_116_2 then
		for iter_116_0, iter_116_1 in ipairs(arg_116_2) do
			table.insert(arg_116_0.catchPrepareActionList_[arg_116_1], iter_116_1)
		end
	end
end

function var_0_1.GetCatchPrepareActionList(arg_117_0, arg_117_1)
	return arg_117_0.catchPrepareActionList_[arg_117_1]
end

function var_0_1.ResetCatchPrepareActionList(arg_118_0, arg_118_1)
	arg_118_0.catchPrepareActionList_[arg_118_1] = {}
end

return var_0_1
