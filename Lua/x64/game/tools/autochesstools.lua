local var_0_0 = {
	GoToGameView = function(arg_1_0, arg_1_1, arg_1_2)
		local var_1_0 = AutoChessData:GetGameStatus(arg_1_0)

		if not AutoChessBattleSimulator.GetInstance().isInit or AutoChessBattleSimulator.GetInstance().gameType ~= arg_1_0 then
			AutoChessBattleSimulator.GetInstance():Init(arg_1_0)
		end

		if var_1_0 == AutoChessConst.GAME_STATUS.PREPARE then
			if arg_1_1 then
				AutoChessTools.GotoPrepareView(arg_1_0, arg_1_1, arg_1_2)
			else
				AutoChessData:SetCurGameType(arg_1_0)
				DestroyLua()
				AutoChessBridge.Launcher()
			end
		elseif var_1_0 == AutoChessConst.GAME_STATUS.PREPARE_END then
			AutoChessTools.LaunchRoundBattle(arg_1_0)
		else
			AutoChessTools.GoToSettleView(arg_1_0)
			AutoChessData:SaveLastShopLevel(arg_1_0)
		end
	end,
	QuitGame = function(arg_2_0, arg_2_1, arg_2_2)
		if not arg_2_1 then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
		end

		manager.net:ResetForceReconnect()
		AutoChessTools.ResetPrepareState()
		AutoChessData:ResetChessData()

		if arg_2_0 == AutoChessConst.GAME_TYPE.PVE then
			if AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 or AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_5_0 then
				OpenPageUntilLoaded("/autoChessRemakeMainView")
			else
				OpenPageUntilLoaded("/autoChessPVESelectStageView")
			end
		elseif arg_2_0 == AutoChessConst.GAME_TYPE.PVP then
			OpenPageUntilLoaded("/autoChessPVPEnterView")
		elseif arg_2_0 == AutoChessConst.GAME_TYPE.ONLINE or arg_2_0 == AutoChessConst.GAME_TYPE.PVP_5_0 then
			local var_2_0 = arg_2_2 and arg_2_2.isStartMatch or false
			local var_2_1 = arg_2_2 and arg_2_2.isShowQuitPop or false

			OpenPageUntilLoaded("/autoChessRemakeMainView", {
				isStartMatch = var_2_0,
				isShowQuitPop = var_2_1
			})
		end
	end,
	GetIsPVPGame = function(arg_3_0)
		return arg_3_0 == AutoChessConst.GAME_TYPE.PVP or arg_3_0 == AutoChessConst.GAME_TYPE.PVP_5_0
	end,
	GotoPrepareView = function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == AutoChessConst.GAME_TYPE.ONLINE then
			JumpTools.OpenPageByJump("/autoChessPrepareView_4_8", {
				gameType = arg_4_0,
				isBattleBack = arg_4_1,
				isStageEnter = arg_4_2
			})
		else
			JumpTools.OpenPageByJump("/autoChessPrepareView", {
				gameType = arg_4_0,
				isBattleBack = arg_4_1,
				isStageEnter = arg_4_2
			})
		end
	end,
	ResetPrepareState = function()
		AutoChessData:SetIsInPrepareEnd(false)
		AutoChessData:SetIsInPrepareEndAction(false)
		AutoChessData:SaveOnlineBattleData(nil)
	end,
	GoToSettleView = function(arg_6_0)
		if AutoChessData:GetGameStatus(arg_6_0) == AutoChessConst.GAME_STATUS.REPLAY then
			AutoChessData:UpdateGameStatus({
				game_type = arg_6_0,
				state = AutoChessConst.GAME_STATUS.PREPARE
			})
			AutoChessData:InitGlobalPrepareData(arg_6_0)
			AutoChessTools.GotoPrepareView(arg_6_0)
		else
			AutoChessTools.GoToRoundSettleView(arg_6_0)
		end
	end,
	GoToRoundSettleView = function(arg_7_0)
		if arg_7_0 == AutoChessConst.GAME_TYPE.ONLINE then
			JumpTools.OpenPageByJump("autoChessRoundSettleView_4_8", {
				gameType = arg_7_0
			})
		else
			JumpTools.OpenPageByJump("autoChessRoundSettleView", {
				gameType = arg_7_0
			})
		end
	end,
	GoToGameSettleView = function(arg_8_0)
		saveData("auto_chess_pop", "skip_" .. arg_8_0, false)

		if arg_8_0 == AutoChessConst.GAME_TYPE.ONLINE then
			JumpTools.OpenPageByJump("autoChessBattleSettleView_4_8", {
				gameType = arg_8_0
			})
		else
			JumpTools.OpenPageByJump("autoChessBattleSettle", {
				gameType = arg_8_0
			})
		end
	end,
	QuitSettle = function(arg_9_0)
		local var_9_0 = AutoChessData:GetGameStatus(arg_9_0)

		if var_9_0 == AutoChessConst.GAME_STATUS.PREPARE then
			AutoChessTools.GoToGameView(arg_9_0, true)
		elseif var_9_0 == AutoChessConst.GAME_STATUS.NONE then
			AutoChessTools.QuitGame(arg_9_0)
		end
	end,
	IsPreapreToBattle = function(arg_10_0)
		local var_10_0 = AutoChessData:GetIsReplayBattle(arg_10_0) and AutoChessData:GetReplayBattleData(arg_10_0) or AutoChessData:GetBattleData(arg_10_0)

		if var_10_0 == nil then
			return false
		end

		if var_10_0.maxRound == var_10_0.initedRoundDataCount then
			return true
		end

		return false
	end,
	PlayRoundBattle = function(arg_11_0)
		AutoChessBattleSimulator.GetInstance():InitBattleData(arg_11_0)

		if arg_11_0 == AutoChessConst.GAME_TYPE.ONLINE then
			JumpTools.OpenPageByJump("/autoChessBattleView_4_8")
		else
			JumpTools.OpenPageByJump("/autoChessBattle")
		end
	end,
	CheckPrePareEnd = function(arg_12_0)
		local var_12_0
		local var_12_1 = AutoChessBattleRenderer.GetInstance():GetPrepareView()

		if var_12_1 == nil then
			AutoChessTools.LaunchRoundBattle(arg_12_0)

			return
		end

		local var_12_2 = GameSetting.auto_chess_2_round_end_play.value[1]
		local var_12_3 = 0

		var_12_0 = Timer.New(function()
			local var_13_0 = AutoChessBattleSimulator.GetInstance():GetStatus()

			if var_12_3 >= var_12_2 or var_12_1:GetIsExit() or var_13_0 == AutoChessConst.BATTLE_STATUS.END or var_13_0 == AutoChessConst.BATTLE_STATUS.IDLE then
				if arg_12_0 == AutoChessConst.GAME_TYPE.ONLINE and AutoChessData:GetOnlineBattleData() == nil then
					Debug.Log("AutoChessData:GetOnlineBattleData self.onlineBattleData_ is nil")

					return
				end

				var_12_0:Stop()

				var_12_0 = nil

				AutoChessTools.PlayPrepareExit(function()
					AutoChessTools.LaunchRoundBattle(arg_12_0)
				end)
			end

			var_12_3 = var_12_3 + 0.33
		end, 0.33, -1)

		var_12_0:Start()
	end,
	ShotDownBattle = function()
		if AutoChessBattleSimulator.GetInstance().isInit then
			AutoChessBattleSimulator.GetInstance():ShotDown()
		end
	end,
	IsHideBottomButton = function()
		local var_16_0 = AutoChessTools.GetCurStageId()
		local var_16_1 = AutoChessTools.GetCurRound()

		for iter_16_0, iter_16_1 in ipairs(AutoChessConst.HIDE_BOTTOM_BUTTON_INFO) do
			if iter_16_1[1] == var_16_0 and iter_16_1[2] == var_16_1 then
				return true
			end
		end

		if AutoChessData:GetBattleBossRound() == var_16_1 then
			return true
		end

		return false
	end,
	PlayPrepareExit = function(arg_17_0)
		if AutoChessBattleRenderer.GetInstance():GetIsInPrepareView() then
			AutoChessBattleRenderer.GetInstance():GetPrepareView():PlayExitAnim(arg_17_0)
		elseif arg_17_0 then
			gameContext:Go("/blank")
			arg_17_0()
		end
	end,
	IsPrepareStatus = function(arg_18_0)
		if arg_18_0 == nil then
			arg_18_0 = AutoChessData:GetGameStatus()
		end

		return arg_18_0 == AutoChessConst.GAME_STATUS.PREPARE or arg_18_0 == AutoChessConst.GAME_STATUS.PREPARE_END
	end,
	GetNowMoneyEnough = function(arg_19_0, arg_19_1)
		local var_19_0 = AutoChessData:GetPrepareData(arg_19_0):GetAttributeList()

		if var_19_0 and arg_19_1 <= var_19_0[AutoChessConst.ATTR_KEY.NOW_MONEY] then
			return true
		end

		return false
	end,
	GetPrepareNum = function(arg_20_0)
		return GameSetting.auto_chess_prepare_grid_num.value[1]
	end,
	IsTargetProp = function(arg_21_0)
		local var_21_0 = AutoChessItemCfg[arg_21_0]

		if table.indexof(AutoChessConst.TARGET_PROP_TYPE, var_21_0.relevant_type) then
			return true
		end

		return false
	end
}

function var_0_0.CheckPropTarget(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = AutoChessItemCfg[arg_22_0]

	if var_22_0.relevant_type == AutoChessConst.ITEM_TARGET_TYPE.CHESS and AutoChessData:GetPrepareData(arg_22_1):GetChessNum() < 1 then
		return false
	end

	if var_22_0.relevant_type == AutoChessConst.ITEM_TARGET_TYPE.RANDOM_SHOP_ONE and AutoChessData:GetPrepareData(arg_22_1):GetShopAndRewardChessNum() < 1 then
		return false
	end

	if var_22_0.relevant_type == AutoChessConst.ITEM_TARGET_TYPE.WITHOUT_PLAYER then
		if not arg_22_2 then
			return false
		end

		if var_0_0.IsPlayerChess(arg_22_2.chessId) then
			return false
		end
	end

	return true
end

function var_0_0.CheckUseProp(arg_23_0, arg_23_1, arg_23_2)
	if not var_0_0.CheckPropTarget(arg_23_0, arg_23_1, arg_23_2) then
		return false
	end

	if not var_0_0.CheckPropBuff(arg_23_0, arg_23_1, arg_23_2) then
		return false
	end

	return true
end

function var_0_0.CheckPropBuff(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = AutoChessItemCfg[arg_24_0]
	local var_24_1 = GameSetting.auto_chess_prepare_grid_num.value[1]

	for iter_24_0, iter_24_1 in ipairs(var_24_0.buff_list) do
		local var_24_2 = AutoChessBuffCfg[iter_24_1]

		if type(var_24_2.repeated) == "table" then
			for iter_24_2, iter_24_3 in ipairs(var_24_2.repeated) do
				if arg_24_2 and arg_24_2:ContainBuff(iter_24_3) then
					return false
				elseif AutoChessData:GetPrepareData(arg_24_1):ContainBuff(iter_24_3) then
					return false
				end
			end
		end

		if var_24_2.action_type == AutoChessConst.ACTION_EFFECT_TYPE.REMOVE_SHOP then
			if var_24_1 < AutoChessData:GetPrepareData(arg_24_1):GetChessNum() + var_24_2.param[1] then
				return false
			end

			if AutoChessData:GetPrepareData(arg_24_1):GetShopChessNum() < var_24_2.param[1] then
				return false
			end
		elseif var_24_2.action_type == AutoChessConst.ACTION_EFFECT_TYPE.IMMUNE then
			for iter_24_4, iter_24_5 in pairs(arg_24_2 and arg_24_2:GetBuffList() or {}) do
				if AutoChessBuffCfg[iter_24_5.buffId].action_type == AutoChessConst.ACTION_EFFECT_TYPE.IMMUNE then
					return false
				end
			end
		elseif var_24_2.action_type == AutoChessConst.ACTION_EFFECT_TYPE.ADD_EXPERIENCE then
			if arg_24_2 and arg_24_2.attributeData.exp + var_24_2.param[1] > arg_24_2.attributeData.expTable[#arg_24_2.attributeData.expTable] then
				return false
			end
		elseif var_24_2.action_type == AutoChessConst.ACTION_EFFECT_TYPE.TRANSFER_FORMATION then
			if AutoChessData:GetPrepareData(arg_24_1):GetChessNum() <= 1 then
				return false
			end
		elseif var_24_2.action_type == AutoChessConst.ACTION_EFFECT_TYPE.SUMMON_CHESS and var_24_1 <= AutoChessData:GetPrepareData(arg_24_1):GetChessNum() then
			return false
		end
	end

	return true
end

function var_0_0.IsPlayerChess(arg_25_0)
	local var_25_0 = AutoChessCfg[arg_25_0]

	if var_25_0 == nil then
		return false
	end

	return var_25_0.type == AutoChessConst.CHESS_TYPE.PLAYER_CHESS or var_25_0.type == AutoChessConst.CHESS_TYPE.OP_PLAYER_CHESS
end

function var_0_0.GetAttrValue(arg_26_0, arg_26_1)
	local var_26_0 = AutoChessData:GetPrepareData(arg_26_0):GetAttributeList()

	if var_26_0 and var_26_0[arg_26_1] then
		return var_26_0[arg_26_1]
	end

	return 0
end

function var_0_0.IsBossRound(arg_27_0)
	local var_27_0 = AutoChessData:GetPrepareData(arg_27_0)
	local var_27_1 = var_0_0.GetCurStageId(arg_27_0)

	if not var_27_0 then
		return false
	end

	local var_27_2 = var_27_0:GetIsBrahmaBoss()

	return var_27_1 == GameSetting.auto_chess_boss_stage.value[1] and var_27_2 ~= nil and var_27_2 ~= 0
end

function var_0_0.GetCurRound(arg_28_0)
	local var_28_0 = AutoChessData:GetPrepareData(arg_28_0)

	if not var_28_0 then
		return 0
	end

	return var_28_0:GetCurRound()
end

function var_0_0.GetCurStageId(arg_29_0)
	local var_29_0 = AutoChessData:GetPrepareData(arg_29_0)

	if not var_29_0 then
		return 0
	end

	return var_29_0:GetStageId()
end

function var_0_0.GetActionLogicNodeClassName(arg_30_0)
	local var_30_0 = arg_30_0.actionType

	if var_30_0 ~= AutoChessConst.ACTION_TYPE.EFFECT then
		return AutoChessConst.ACTION_CONFIG[var_30_0].nodeClassName
	else
		local var_30_1 = arg_30_0.actionEffectType

		if AutoChessConst.ACTION_EFFECT_CONFIG[var_30_1] then
			return AutoChessConst.ACTION_EFFECT_CONFIG[var_30_1].nodeClassName
		end
	end
end

function var_0_0.GetActionRendererClassName(arg_31_0)
	local var_31_0 = arg_31_0.actionType

	if var_31_0 ~= AutoChessConst.ACTION_TYPE.EFFECT then
		return AutoChessConst.ACTION_CONFIG[var_31_0].rendererClassName
	else
		local var_31_1 = arg_31_0.actionEffectType

		if AutoChessConst.ACTION_EFFECT_CONFIG[var_31_1] then
			return AutoChessConst.ACTION_EFFECT_CONFIG[var_31_1].rendererClassName
		end
	end
end

function var_0_0.GetPlayerChessLevelBuff(arg_32_0)
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_0.level_buffs[4]) do
		local var_32_1 = {}

		for iter_32_2, iter_32_3 in ipairs(iter_32_1[2]) do
			table.insert(var_32_1, iter_32_3[1])
		end

		var_32_0[iter_32_0] = var_32_1
	end

	var_32_0[#var_32_0 + 1] = {
		GameSetting.auto_chess_boss_manager_buff.value[1]
	}

	return var_32_0
end

function var_0_0.GetHeroSelectedBuffList()
	local var_33_0 = AutoChessData:GetCurGameType()
	local var_33_1 = AutoChessData:GetPlayerChessData(var_33_0)

	if not var_33_1.chessId then
		return {}
	end

	local var_33_2 = AutoChessCfg[var_33_1.chessId]
	local var_33_3 = var_0_0.GetPlayerChessLevelBuff(var_33_2)
	local var_33_4 = {}

	for iter_33_0, iter_33_1 in pairs(var_33_3) do
		for iter_33_2, iter_33_3 in ipairs(iter_33_1) do
			if table.indexof(var_33_1.buffList, iter_33_3) then
				table.insert(var_33_4, iter_33_3)

				break
			end
		end
	end

	return var_33_4
end

function var_0_0.IsStageUnlock(arg_34_0)
	local var_34_0 = AutoChessData:GetStageData()
	local var_34_1 = AutoChessStageCfg[arg_34_0].prev_stage

	if var_34_1 == 0 then
		return true
	end

	if var_34_0[var_34_1] then
		return true
	else
		return false
	end
end

function var_0_0.IsAreaUnlock(arg_35_0)
	local var_35_0 = AutoChessAreaCfg[arg_35_0]

	if var_35_0.prev_stage == 0 then
		return true
	end

	return var_0_0.GetStageState(var_35_0.prev_stage) == AutoChessConst.STAGE_STATE.COMPLETED
end

function var_0_0.IsAreaComplete(arg_36_0)
	local var_36_0 = AutoChessAreaCfg[arg_36_0].stage_list
	local var_36_1 = true

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		if AutoChessStageCfg[iter_36_1].is_challenge == 0 and var_0_0.GetStageState(iter_36_1) ~= AutoChessConst.STAGE_STATE.COMPLETED then
			var_36_1 = false

			break
		end
	end

	return var_36_1
end

function var_0_0.GetStageState(arg_37_0)
	if AutoChessData:GetStageData()[arg_37_0] then
		return AutoChessConst.STAGE_STATE.COMPLETED
	end

	if var_0_0.IsStageUnlock(arg_37_0) then
		return AutoChessConst.STAGE_STATE.UNLOCK
	end

	return AutoChessConst.STAGE_STATE.LOCK
end

function var_0_0.GetCurChallengeStage()
	if AutoChessData:GetGameStatus(AutoChessConst.GAME_TYPE.PVE) == AutoChessConst.GAME_STATUS.NONE then
		return 0
	end

	local var_38_0 = AutoChessData:GetPlayerData(AutoChessConst.GAME_TYPE.PVE)

	if var_38_0 then
		local var_38_1 = GameSetting.auto_chess_2_tutorial_stage_id.value[1]

		if var_38_0.stageID == var_38_1 then
			return 0
		end

		return var_38_0.stageID
	end

	return 0
end

function var_0_0.GetCurChallengeArea()
	local var_39_0 = AutoChessData:GetStageData()
	local var_39_1 = 1

	for iter_39_0, iter_39_1 in ipairs(AutoChessAreaCfg.all) do
		local var_39_2 = AutoChessAreaCfg[iter_39_1]

		if (var_39_2.prev_stage == 0 or var_39_0[var_39_2.prev_stage]) and var_39_1 < var_39_2.id then
			var_39_1 = var_39_2.id
		end
	end

	return var_39_1
end

function var_0_0.IsCanChallengeStage()
	local var_40_0 = AutoChessData:GetStageData()

	for iter_40_0, iter_40_1 in ipairs(AutoChessStageCfg.all) do
		local var_40_1 = AutoChessStageCfg[iter_40_1]

		if var_40_1.is_challenge == 1 and var_40_0[var_40_1.prev_stage] and not var_40_0[iter_40_1] then
			return true
		end
	end

	return false
end

function var_0_0.GetCurrentStageBgIndex()
	local var_41_0 = AutoChessData:GetCurGameType()

	if var_41_0 == AutoChessConst.GAME_TYPE.PVP then
		return 0
	else
		local var_41_1 = AutoChessData:GetPrepareData(var_41_0):GetStageId()
		local var_41_2 = AutoChessStageCfg[var_41_1]
		local var_41_3 = var_41_2.is_challenge == 0 and 2 or 1

		return 2 * var_41_2.area - var_41_3
	end
end

function var_0_0.GetChessBuffStr(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0

	if arg_42_0 and arg_42_1 then
		var_42_0 = AutoChessBuffCfg[AutoChessCfg[arg_42_0].level_buffs[arg_42_1][1]]
	else
		var_42_0 = AutoChessBuffCfg[arg_42_2]
	end

	local var_42_1 = ""

	if var_42_0 then
		var_42_1 = var_42_0.desc

		if var_42_0.action_type == AutoChessConst.SPECIAL_BUFF_TYPE.ADD_BODY_WITH_USED_PROP_COUNT then
			local var_42_2 = var_42_0.param[3][1]
			local var_42_3 = var_42_0.param[3][2]
			local var_42_4 = var_42_0.param[4][1]
			local var_42_5 = var_42_0.param[4][2]

			var_42_1 = string.format(var_42_1, var_42_2, var_42_3, var_42_4, var_42_5)
		elseif var_42_0.action_type == AutoChessConst.SPECIAL_BUFF_TYPE.ADD_NUM_WITH_ROUND then
			var_42_1 = string.format(var_42_1, var_42_0.param[3] + var_42_0.trigger_time)
		elseif var_42_0.action_type == AutoChessConst.SPECIAL_BUFF_TYPE.ADD_ATTR_WITH_ATK_COUNT then
			local var_42_6 = var_42_0.param[3][1]
			local var_42_7 = var_42_0.param[3][2]

			var_42_1 = string.format(var_42_1, var_42_6, var_42_7)
		end
	end

	return var_42_1
end

function var_0_0.GetStarChessList(arg_43_0)
	local var_43_0 = {}
	local var_43_1 = AutoChessData:GetActivityID()

	for iter_43_0, iter_43_1 in pairs(AutoChessCfg.all) do
		local var_43_2 = AutoChessCfg[iter_43_1]

		if var_43_2.star == arg_43_0 and var_43_2.type == 0 then
			if var_43_1 == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 then
				if table.indexof(var_43_2.activity_id, ActivityConst.ACTIVITY_AUTO_CHESS_4_8) then
					local var_43_3 = var_0_0.CheckChessUnlock(iter_43_1)

					table.insert(var_43_0, {
						id = iter_43_1,
						isLock = not var_43_3
					})
				end
			elseif var_43_1 == ActivityConst.ACTIVITY_AUTO_CHESS_5_0 then
				if table.indexof(var_43_2.activity_id, ActivityConst.ACTIVITY_AUTO_CHESS_5_0) then
					local var_43_4 = var_0_0.CheckChessUnlock(iter_43_1)

					table.insert(var_43_0, {
						id = iter_43_1,
						isLock = not var_43_4
					})
				end
			elseif var_43_1 == ActivityConst.ACTIVITY_AUTO_CHESS_MAIN and table.indexof(var_43_2.activity_id, ActivityConst.ACTIVITY_AUTO_CHESS_MAIN) then
				local var_43_5 = var_43_2.unlock_stage ~= 0 and var_0_0.GetStageState(var_43_2.unlock_stage) == AutoChessConst.STAGE_STATE.LOCK

				table.insert(var_43_0, {
					id = iter_43_1,
					isLock = var_43_5
				})
			end
		end
	end

	table.sort(var_43_0, function(arg_44_0, arg_44_1)
		if arg_44_0.isLock == arg_44_1.isLock then
			return arg_44_0.id < arg_44_1.id
		else
			return not arg_44_0.isLock and arg_44_1.isLock
		end
	end)

	return var_43_0
end

function var_0_0.GetStarPropList(arg_45_0)
	local var_45_0 = {}
	local var_45_1 = AutoChessData:GetActivityID()

	for iter_45_0, iter_45_1 in pairs(AutoChessItemCfg.all) do
		local var_45_2 = AutoChessItemCfg[iter_45_1]

		if var_45_2.star == arg_45_0 then
			if var_45_1 == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 then
				if table.indexof(var_45_2.activity_id, ActivityConst.ACTIVITY_AUTO_CHESS_4_8) then
					table.insert(var_45_0, {
						isLock = false,
						id = iter_45_1
					})
				end
			elseif var_45_1 == ActivityConst.ACTIVITY_AUTO_CHESS_5_0 then
				if table.indexof(var_45_2.activity_id, ActivityConst.ACTIVITY_AUTO_CHESS_5_0) then
					table.insert(var_45_0, {
						isLock = false,
						id = iter_45_1
					})
				end
			elseif var_45_1 == ActivityConst.ACTIVITY_AUTO_CHESS_MAIN and table.indexof(var_45_2.activity_id, ActivityConst.ACTIVITY_AUTO_CHESS_MAIN) then
				local var_45_3 = var_45_2.unlock_stage ~= 0 and var_0_0.GetStageState(var_45_2.unlock_stage) == AutoChessConst.STAGE_STATE.LOCK

				table.insert(var_45_0, {
					id = iter_45_1,
					isLock = var_45_3
				})
			end
		end
	end

	table.sort(var_45_0, function(arg_46_0, arg_46_1)
		if arg_46_0.isLock == arg_46_1.isLock then
			return arg_46_0.id < arg_46_1.id
		else
			return not arg_46_0.isLock and arg_46_1.isLock
		end
	end)

	return var_45_0
end

function var_0_0.GetAdminSkillList(arg_47_0)
	if arg_47_0 == 1 then
		return {}
	end

	local var_47_0 = {}
	local var_47_1 = AutoChessCfg[AutoChessConst.ADMIN_CHESS_ID[AutoChessData:GetActivityID()]]

	if var_47_1 then
		var_47_0 = var_47_1.level_buffs
	end

	local var_47_2 = {}
	local var_47_3 = var_47_0[4][arg_47_0 - 1]

	for iter_47_0, iter_47_1 in pairs(var_47_3[2] or {}) do
		table.insert(var_47_2, iter_47_1)
	end

	return var_47_2
end

function var_0_0.GetStagBgPath(arg_48_0)
	local var_48_0
	local var_48_1

	if AutoChessData:GetCurGameType() == AutoChessConst.GAME_TYPE.PVP then
		var_48_1 = 10001
	else
		local var_48_2 = AutoChessStageCfg[arg_48_0]

		var_48_1 = var_48_2 and var_48_2.background or 10001
	end

	local var_48_3 = string.format("TextureConfig/Activity_OsirisHorus/PKBg/%s", var_48_1)
	local var_48_4 = string.format("TextureConfig/Activity_OsirisHorus/PKBg/%s_1", var_48_1)
	local var_48_5 = string.format("TextureConfig/Activity_OsirisHorus/PKBg/%s_Fuzzy", var_48_1)

	return var_48_3, var_48_4, var_48_5
end

function var_0_0.GetRandomBgPath(arg_49_0)
	local var_49_0 = AutoChessData:GetRandomBgIndex()

	if var_49_0 then
		local var_49_1 = AutoChessConst.BACKGROUND_ID[var_49_0]
		local var_49_2 = string.format("TextureConfig/Activity_OsirisHorus/PKBg/%s", var_49_1)
		local var_49_3 = string.format("TextureConfig/Activity_OsirisHorus/PKBg/%s_1", var_49_1)
		local var_49_4 = string.format("TextureConfig/Activity_OsirisHorus/PKBg/%s_Fuzzy", var_49_1)

		return var_49_2, var_49_3, var_49_4
	end
end

function var_0_0.GetPropIcon(arg_50_0)
	return pureGetSpriteWithoutAtlas("TextureConfig/Activity_item/Shop_props/" .. arg_50_0)
end

function var_0_0.GetChessBody(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = arg_51_1 or AutoChessConst.PLAYER_TYPE.SELF
	local var_51_1 = var_51_0 == AutoChessConst.PLAYER_TYPE.OPPONENT
	local var_51_2 = arg_51_2 or AutoChessData:GetChessSkinByChessId(var_51_0, arg_51_0)
	local var_51_3 = 1
	local var_51_4

	if var_51_2 then
		var_51_4 = AutoChessCardCfg[var_51_2]
	else
		local var_51_5 = AutoChessCfg[arg_51_0]

		if not var_51_5 then
			Debugger.LogError("AutoChessTools.GetChessBody: chessId not found: " .. arg_51_0)

			return
		end

		local var_51_6 = var_51_5.group_id
		local var_51_7 = AutoChessCardCfg.get_id_list_by_group_id[var_51_6]

		if var_51_7 and #var_51_7 > 0 then
			chessCardId = var_51_7[1]
			var_51_4 = AutoChessCardCfg[chessCardId]
		end
	end

	if var_51_4 then
		local var_51_8 = var_51_4.type
		local var_51_9 = var_51_1 and var_51_4.pic_turn or var_51_4.pic
		local var_51_10 = var_51_1 and var_51_4.sunglass_reverse or var_51_4.sunglass
		local var_51_11
		local var_51_12

		if not string.isNullOrEmpty(var_51_9) then
			var_51_11 = pureGetSpriteWithoutAtlas("TextureConfig/Activity_AutoChess_Chess/RoleBattle/" .. var_51_9)
		end

		if not string.isNullOrEmpty(var_51_10) then
			var_51_12 = pureGetSpriteWithoutAtlas("TextureConfig/Activity_AutoChess_Chess/Sunglass/" .. var_51_10)
		else
			local var_51_13 = var_51_1 and "com_1_m" or "com_m"

			var_51_12 = pureGetSpriteWithoutAtlas("TextureConfig/Activity_AutoChess_Chess/Sunglass/" .. var_51_13)
		end

		return var_51_11, var_51_8, var_51_12
	else
		Debug.LogError("AutoChessTools.GetChessBody: AutoChessCardCfg final not found")
	end
end

function var_0_0.GetBuffIcon(arg_52_0)
	return pureGetSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/Buff_icon/" .. arg_52_0)
end

function var_0_0.GetPlayerIcon(arg_53_0)
	local var_53_0 = ItemCfg[arg_53_0]

	if var_53_0 and var_53_0.type == ItemConst.ITEM_TYPE.PORTRAIT then
		if var_53_0.sub_type == ItemConst.ITEM_SUB_TYPE.NORMAL_PORTRAIT then
			return pureGetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. ItemCfg[arg_53_0].icon)
		else
			return pureGetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. arg_53_0)
		end
	else
		arg_53_0 = arg_53_0 or 1084

		return pureGetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. arg_53_0)
	end
end

var_0_0.exportDataList = {}
var_0_0.isOnlySaveData = true

function var_0_0.SetCurExportData(arg_54_0, arg_54_1)
	if not GameToSDK.IsEditorPlatform() then
		return
	end

	local var_54_0 = AutoChessData:GetCurGameType()
	local var_54_1 = arg_54_0.round or AutoChessTools.GetCurRound(var_54_0)
	local var_54_2 = arg_54_1 or var_0_0.isOnlySaveData

	if var_54_1 == 0 then
		return
	end

	local var_54_3 = AutoChessData:GetPlayerData()
	local var_54_4 = var_54_3 and var_54_3.victoryRoundCount or 0
	local var_54_5 = var_54_3 and var_54_3.hp or AutoChessStageCfg[var_0_0.GetCurStageId(var_54_0)].defeat_num
	local var_54_6 = arg_54_0.chess_list
	local var_54_7 = arg_54_0.user_buff
	local var_54_8 = {}
	local var_54_9 = {
		AutoChessCfg[1].level_buffs[3][1]
	}

	table.insertto(var_54_9, AutoChessTools.GetHeroSelectedBuffList() or {})
	table.sort(var_54_6, function(arg_55_0, arg_55_1)
		return arg_55_0.index < arg_55_1.index
	end)

	for iter_54_0, iter_54_1 in ipairs(var_54_6) do
		local var_54_10 = {}

		if iter_54_1 then
			table.insert(var_54_10, iter_54_1.chess_id)

			for iter_54_2, iter_54_3 in ipairs(iter_54_1.chess_kv) do
				if iter_54_3.key == AutoChessConst.CHESS_ATTRI_KEY.EXPERIENCE then
					var_54_10[2] = iter_54_3.value
				elseif iter_54_3.key == AutoChessConst.CHESS_ATTRI_KEY.ATK then
					var_54_10[3] = iter_54_3.value
				elseif iter_54_3.key == AutoChessConst.CHESS_ATTRI_KEY.HP then
					var_54_10[4] = iter_54_3.value
				end
			end

			var_54_10[2] = var_54_10[2] or 0
			var_54_10[3] = var_54_10[3] or 0
			var_54_10[4] = var_54_10[4] or 0

			table.insert(var_54_10, var_0_0.GetExportBuff(iter_54_1.buffs))
			table.insert(var_54_8, var_54_10)
		end
	end

	local var_54_11 = var_0_0.GetExportBuff(var_54_7)
	local var_54_12 = {}
	local var_54_13 = {
		var_54_0 + 1,
		var_54_1,
		var_54_4,
		var_54_5,
		var_54_8,
		var_54_11,
		{},
		var_54_9
	}

	var_0_0.exportDataList[var_54_1] = var_54_13

	if not var_54_2 then
		LuaForUtil.SetAutoChessExportData()
	end
end

function var_0_0.OnExportData(arg_56_0)
	if not GameToSDK.IsEditorPlatform() then
		return
	end

	var_0_0.isOnlySaveData = arg_56_0

	if AutoChessData:GetCurGameType() == AutoChessConst.GAME_TYPE.ONLINE then
		AutoChessMatchAction.ExportChessInfo()
	else
		AutoChessAction.ExportChessInfo()
	end
end

function var_0_0.GetExportData(arg_57_0)
	local var_57_0 = {}

	for iter_57_0, iter_57_1 in pairs(var_0_0.exportDataList) do
		if arg_57_0 and arg_57_0 ~= 0 then
			for iter_57_2, iter_57_3 in ipairs(iter_57_1[5]) do
				if var_0_0.IsPlayerChess(iter_57_3[1]) then
					iter_57_3[1] = arg_57_0
				end
			end
		end

		table.insert(var_57_0, iter_57_1)
	end

	table.sort(var_57_0, function(arg_58_0, arg_58_1)
		return arg_58_0[2] < arg_58_1[2]
	end)
	trace("exportDataList%o", var_57_0)

	return var_57_0
end

function var_0_0.GetExportBuff(arg_59_0)
	local var_59_0 = {}

	for iter_59_0, iter_59_1 in ipairs(arg_59_0) do
		local var_59_1 = {
			iter_59_1.buff_id or {},
			{}
		}

		for iter_59_2, iter_59_3 in ipairs(iter_59_1.chess_kv) do
			if iter_59_3.key then
				var_59_1[2][iter_59_3.key] = iter_59_3.value
			end
		end

		table.insert(var_59_0, var_59_1)
	end

	return var_59_0
end

function var_0_0.ClearExportData()
	var_0_0.exportDataList = {}
	var_0_0.isOnlySaveData = false
end

function var_0_0.GetAutoChessHeadIndex()
	local var_61_0 = getData("auto_chess_head_tips", "index")
	local var_61_1 = GameSetting.auto_chess_easter_keys.value

	if var_61_0 then
		if var_61_0 >= #var_61_1 then
			var_61_0 = 1
		else
			var_61_0 = var_61_0 + 1
		end
	else
		var_61_0 = 1
	end

	saveData("auto_chess_head_tips", "index", var_61_0)

	return var_61_0
end

function var_0_0.ScreenAdapter(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0, var_62_1 = SettingTools.GetDefaultScreenSize()
	local var_62_2 = arg_62_0:GetWidth() / 2
	local var_62_3 = arg_62_0:GetHeight() / 2
	local var_62_4 = arg_62_1:GetTipsPos()
	local var_62_5 = arg_62_1:GetLocalPos()
	local var_62_6 = var_62_4.x + var_62_2
	local var_62_7
	local var_62_8

	if arg_62_2 then
		var_62_7 = var_62_5.x - var_62_6
		var_62_8 = var_62_5.y - var_62_4.y + var_62_3 + 60
	else
		var_62_8 = var_62_5.y - (var_62_4.y + var_62_3 + 20)
		var_62_7 = var_62_5.x - var_62_6 + 50
	end

	local var_62_9 = arg_62_1:GetTipsHeight()

	if var_62_8 - (var_62_9 - var_62_4.y) <= -var_62_1 / 2 then
		var_62_8 = var_62_9 - var_62_4.y - var_62_1 / 2
	end

	local var_62_10 = arg_62_1:GetTipsWidth()

	if var_62_5.x - var_62_2 + var_62_10 >= var_62_0 / 2 then
		var_62_7 = var_62_0 / 2 - var_62_10 - var_62_4.x
	end

	local var_62_11 = arg_62_1:GetBuffWidth()

	if var_62_5.x - var_62_2 - var_62_11 <= -var_62_0 / 2 then
		var_62_7 = -var_62_0 / 2 + var_62_11 - var_62_4.x
	end

	local var_62_12 = Vector2.New(var_62_7, var_62_8)

	arg_62_1:SetLocalPos(var_62_12)
end

function var_0_0.GetTeamTag(arg_63_0)
	local var_63_0 = {}
	local var_63_1 = arg_63_0:GetTeamDataList()
	local var_63_2 = 1

	var_63_0[var_63_2] = 1

	local var_63_3 = AutoChessTeamTagCfg[var_63_2]

	if var_63_3 then
		for iter_63_0, iter_63_1 in ipairs(var_63_1) do
			local var_63_4 = iter_63_1.attributeData.hp + iter_63_1.attributeData.atk

			if var_63_4 >= var_63_3.param_threshold[2] then
				var_63_0[var_63_2] = 3

				break
			end

			if var_63_4 >= var_63_3.param_threshold[1] then
				var_63_0[var_63_2] = 2

				break
			end
		end
	end

	local var_63_5 = 2
	local var_63_6 = AutoChessTeamTagCfg[var_63_5]

	if var_63_6 then
		local var_63_7 = var_0_0.GetChessKeyWordTypeNum(var_63_1, AutoChessConst.BUFF_KEYWORD_TYPE.DEATH_WHISPE)

		if var_63_7 >= var_63_6.param_threshold[2] then
			var_63_0[var_63_5] = 3
		elseif var_63_7 >= var_63_6.param_threshold[1] then
			var_63_0[var_63_5] = 2
		else
			var_63_0[var_63_5] = 1
		end
	end

	local var_63_8 = 3
	local var_63_9 = AutoChessTeamTagCfg[var_63_8]

	if var_63_9 then
		local var_63_10 = var_0_0.GetChessKeyWordTypeNum(var_63_1, AutoChessConst.BUFF_KEYWORD_TYPE.SHIELD)

		if var_63_10 >= var_63_9.param_threshold[2] then
			var_63_0[var_63_8] = 3
		elseif var_63_10 >= var_63_9.param_threshold[1] then
			var_63_0[var_63_8] = 2
		else
			var_63_0[var_63_8] = 1
		end
	end

	local var_63_11 = 4
	local var_63_12 = AutoChessTeamTagCfg[var_63_11]

	if var_63_12 then
		local var_63_13 = var_0_0.GetChessKeyWordTypeNum(var_63_1, AutoChessConst.BUFF_KEYWORD_TYPE.RAGE)

		if var_63_13 >= var_63_12.param_threshold[2] then
			var_63_0[var_63_11] = 3
		elseif var_63_13 >= var_63_12.param_threshold[1] then
			var_63_0[var_63_11] = 2
		else
			var_63_0[var_63_11] = 1
		end
	end

	local var_63_14 = 5
	local var_63_15 = AutoChessTeamTagCfg[var_63_14]

	if var_63_15 then
		local var_63_16 = 0

		for iter_63_2, iter_63_3 in ipairs(var_63_1) do
			if not var_0_0.IsPlayerChess(iter_63_3.chessId) and iter_63_3.attributeData.level >= 3 then
				var_63_16 = var_63_16 + 1
			end
		end

		if var_63_16 >= var_63_15.param_threshold[2] then
			var_63_0[var_63_14] = 3
		elseif var_63_16 >= var_63_15.param_threshold[1] then
			var_63_0[var_63_14] = 2
		else
			var_63_0[var_63_14] = 1
		end
	end

	local var_63_17 = 6
	local var_63_18 = AutoChessTeamTagCfg[var_63_17]

	if var_63_18 then
		local var_63_19 = 0

		for iter_63_4, iter_63_5 in ipairs(var_63_1) do
			for iter_63_6, iter_63_7 in pairs(iter_63_5:GetBuffList()) do
				local var_63_20 = AutoChessBuffCfg[iter_63_7.buffId]

				if table.indexof({
					1,
					7
				}, var_63_20.action_type) then
					var_63_19 = var_63_19 + 1
				end
			end
		end

		if var_63_19 >= var_63_18.param_threshold[2] then
			var_63_0[var_63_17] = 3
		elseif var_63_19 >= var_63_18.param_threshold[1] then
			var_63_0[var_63_17] = 2
		else
			var_63_0[var_63_17] = 1
		end
	end

	local var_63_21 = 7
	local var_63_22 = AutoChessTeamTagCfg[var_63_21]

	if var_63_22 then
		local var_63_23 = 0

		for iter_63_8, iter_63_9 in ipairs(var_63_1) do
			for iter_63_10, iter_63_11 in pairs(iter_63_9:GetBuffList()) do
				local var_63_24 = AutoChessBuffCfg[iter_63_11.buffId]

				if iter_63_11.source_cfg_id and AutoChessItemCfg[iter_63_11.source_cfg_id] then
					var_63_23 = var_63_23 + 1
				end
			end
		end

		if var_63_23 >= var_63_22.param_threshold[2] then
			var_63_0[var_63_21] = 3
		elseif var_63_23 >= var_63_22.param_threshold[1] then
			var_63_0[var_63_21] = 2
		else
			var_63_0[var_63_21] = 1
		end
	end

	local var_63_25 = 8
	local var_63_26 = AutoChessTeamTagCfg[var_63_25]

	if var_63_26 then
		local var_63_27 = 0

		for iter_63_12, iter_63_13 in ipairs(var_63_1) do
			for iter_63_14, iter_63_15 in pairs(iter_63_13:GetBuffList()) do
				if AutoChessBuffCfg[iter_63_15.buffId].keyword_type ~= AutoChessConst.BUFF_KEYWORD_TYPE.NONE then
					var_63_27 = var_63_27 + 1
				end
			end
		end

		if var_63_27 >= var_63_26.param_threshold[2] then
			var_63_0[var_63_25] = 3
		elseif var_63_27 >= var_63_26.param_threshold[1] then
			var_63_0[var_63_25] = 2
		else
			var_63_0[var_63_25] = 1
		end
	end

	local var_63_28 = 9
	local var_63_29 = AutoChessTeamTagCfg[var_63_28]

	if var_63_29 then
		local var_63_30 = 0

		for iter_63_16, iter_63_17 in ipairs(var_63_1) do
			var_63_30 = var_63_30 + iter_63_17.attributeData.hp
			var_63_30 = var_63_30 + iter_63_17.attributeData.atk
		end

		if var_63_30 >= var_63_29.param_threshold[2] then
			var_63_0[var_63_28] = 3
		elseif var_63_30 >= var_63_29.param_threshold[1] then
			var_63_0[var_63_28] = 2
		else
			var_63_0[var_63_28] = 1
		end
	end

	local var_63_31 = 10
	local var_63_32 = AutoChessTeamTagCfg[var_63_31]

	if var_63_32 then
		if arg_63_0.hp >= var_63_32.param_threshold[2] then
			var_63_0[var_63_31] = 3
		elseif arg_63_0.hp >= var_63_32.param_threshold[1] then
			var_63_0[var_63_31] = 2
		else
			var_63_0[var_63_31] = 1
		end
	end

	return var_63_0
end

function var_0_0.GetChessKeyWordTypeNum(arg_64_0, arg_64_1)
	local var_64_0 = 0

	for iter_64_0, iter_64_1 in ipairs(arg_64_0) do
		for iter_64_2, iter_64_3 in pairs(iter_64_1:GetBuffList()) do
			if AutoChessBuffCfg[iter_64_3.buffId].keyword_type == arg_64_1 then
				var_64_0 = var_64_0 + 1

				break
			end
		end
	end

	return var_64_0
end

function var_0_0.GetRankLevelCfg(arg_65_0)
	local var_65_0
	local var_65_1
	local var_65_2 = AutoChessRankCfg.all

	for iter_65_0 = #var_65_2, 1, -1 do
		local var_65_3 = AutoChessRankCfg[var_65_2[iter_65_0]]

		if arg_65_0 >= var_65_3.baseline then
			var_65_0 = var_65_3
			var_65_1 = AutoChessRankCfg[var_65_2[iter_65_0 + 1]]

			break
		end
	end

	return var_65_0, var_65_1
end

function var_0_0.GetChessBuffDesc(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = arg_66_0:GetBuffOtherParams(arg_66_1)
	local var_66_1 = AutoChessBuffCfg[arg_66_1]
	local var_66_2 = ""

	if var_66_1 ~= nil then
		var_66_2 = var_66_1.desc

		if var_66_1.action_type == AutoChessConst.SPECIAL_BUFF_TYPE.ADD_BODY_WITH_USED_PROP_COUNT then
			local var_66_3 = var_66_0 and var_66_0.otherParamAtk or 0
			local var_66_4 = var_66_0 and var_66_0.otherParamHp or 0
			local var_66_5 = var_66_1.param[3][1]
			local var_66_6 = var_66_1.param[3][2]

			var_66_2 = string.format(var_66_2, var_66_5 + var_66_3, var_66_6 + var_66_4, var_66_5, var_66_6)
		elseif var_66_1.action_type == AutoChessConst.SPECIAL_BUFF_TYPE.ADD_NUM_WITH_ROUND then
			local var_66_7 = var_66_1.trigger_time
			local var_66_8 = var_66_0 and var_66_0.getBuffRound or 0
			local var_66_9 = var_66_8 ~= 0 and AutoChessTools.GetCurRound() - var_66_8 + 1 or 1

			var_66_2 = string.format(var_66_2, var_66_7 + var_66_9)
		elseif var_66_1.action_type == AutoChessConst.SPECIAL_BUFF_TYPE.ADD_ATTR_WITH_ATK_COUNT then
			local var_66_10 = var_66_0 and var_66_0.otherParamAtk or var_66_1.param[3][1]
			local var_66_11 = var_66_0 and var_66_0.otherParamHp or var_66_1.param[3][2]

			var_66_2 = string.format(var_66_2, var_66_10, var_66_11)
		end

		RichTextTools.SetMixedTextWithImage(arg_66_2, var_66_2)
	end

	arg_66_2.text = var_66_2
end

function var_0_0.GetChessTrackingPointStr(arg_67_0)
	local var_67_0 = {}

	for iter_67_0, iter_67_1 in ipairs(arg_67_0.buffDataList) do
		table.insert(var_67_0, iter_67_1.buffId)
	end

	local var_67_1 = string.format("[%s]", table.concat(var_67_0, ","))

	return (string.format("[{uid:%s,hero_id:%d,location:%d,hero_star:%d,hero_level:%d,hero_exp:%d,hero_atk:%d,hero_hp:%d,hero_buff:%s}]", arg_67_0.uniqueId, arg_67_0.chessId, arg_67_0.index, AutoChessCfg[arg_67_0.chessId].star, arg_67_0.attributeData.level, arg_67_0.attributeData.exp, arg_67_0.attributeData.atk, arg_67_0.attributeData.hp, var_67_1))
end

function var_0_0.StartNewGame(arg_68_0, arg_68_1)
	var_0_0.ResetPrepareState()

	if arg_68_0 == AutoChessConst.GAME_TYPE.ONLINE then
		AutoChessMatchAction.StartMatch()
	else
		AutoChessAction.StartNewGame(arg_68_0, arg_68_1)
	end
end

function var_0_0.LaunchRoundBattle(arg_69_0)
	if arg_69_0 == AutoChessConst.GAME_TYPE.ONLINE then
		AutoChessBattleSimulator.GetInstance():ResetSimulator()

		local var_69_0 = AutoChessData:GetTotalSettlePlayerData()

		if var_69_0 then
			AutoChessData:UpdateGameStatus({
				game_type = arg_69_0,
				state = var_69_0.rankIndex == 1 and AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN or AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE
			})
		else
			AutoChessData:UpdateGameStatus({
				game_type = arg_69_0,
				state = AutoChessConst.GAME_STATUS.ROUND_SETTLE
			})
		end

		local var_69_1 = AutoChessData:GetOnlineBattleData()

		AutoChessData:InitBattleData(var_69_1, AutoChessConst.GAME_TYPE.ONLINE)
		AutoChessData:InitOnlineBattleRoundData()
		AutoChessTools.PlayRoundBattle(arg_69_0)
	else
		AutoChessAction.LaunchRoundBattle(arg_69_0)
	end
end

function var_0_0.SettleBattle(arg_70_0, arg_70_1, arg_70_2)
	if arg_70_0 == AutoChessConst.GAME_TYPE.ONLINE then
		if arg_70_1 then
			AutoChessData:UpdateGameStatus({
				state = AutoChessConst.GAME_STATUS.PREPARE
			}, arg_70_0)
			AutoChessData:UpdateNextRoundPrepareData()
			AutoChessTools.GoToGameView(arg_70_0, true)
		else
			AutoChessTools.QuitGame(arg_70_0, false, {
				isStartMatch = arg_70_2
			})
		end
	else
		AutoChessAction.SettleBattle(arg_70_0)
	end
end

function var_0_0.CancelGame(arg_71_0, arg_71_1, arg_71_2)
	if arg_71_0 == AutoChessConst.GAME_TYPE.ONLINE then
		AutoChessMatchAction.CancelGame(arg_71_0)
	else
		AutoChessAction.CancelGame(arg_71_0, arg_71_1, arg_71_2)
	end
end

function var_0_0.BuyChess(arg_72_0, arg_72_1, arg_72_2)
	if arg_72_0 == AutoChessConst.GAME_TYPE.ONLINE then
		AutoChessMatchAction.BuyChess(var_0_0.GetCurRound(arg_72_0), arg_72_1, arg_72_2)
	else
		AutoChessAction.BuyChess(arg_72_0, arg_72_1, arg_72_2)
	end
end

function var_0_0.SellChess(arg_73_0, arg_73_1)
	if arg_73_0 == AutoChessConst.GAME_TYPE.ONLINE then
		AutoChessMatchAction.SellChess(var_0_0.GetCurRound(arg_73_0), arg_73_1)
	else
		AutoChessAction.SellChess(arg_73_0, arg_73_1)
	end
end

function var_0_0.RefreshShop(arg_74_0)
	if arg_74_0 == AutoChessConst.GAME_TYPE.ONLINE then
		AutoChessMatchAction.RefreshShop(var_0_0.GetCurRound(arg_74_0))
	else
		AutoChessAction.RefreshShop(arg_74_0)
	end
end

function var_0_0.LockShop(arg_75_0, arg_75_1, arg_75_2)
	if arg_75_0 == AutoChessConst.GAME_TYPE.ONLINE then
		AutoChessMatchAction.LockShop(var_0_0.GetCurRound(arg_75_0), arg_75_1, arg_75_2)
	else
		AutoChessAction.LockShop(arg_75_0, arg_75_1, arg_75_2)
	end
end

function var_0_0.ChangeChessTeam(arg_76_0, arg_76_1)
	if arg_76_0 == AutoChessConst.GAME_TYPE.ONLINE then
		AutoChessMatchAction.ChangeChessTeam(var_0_0.GetCurRound(arg_76_0), arg_76_1)
	else
		AutoChessAction.ChangeChessTeam(arg_76_0, arg_76_1)
	end
end

function var_0_0.MergeChess(arg_77_0, arg_77_1, arg_77_2)
	if arg_77_0 == AutoChessConst.GAME_TYPE.ONLINE then
		AutoChessMatchAction.MergeChess(var_0_0.GetCurRound(arg_77_0), arg_77_1, arg_77_2)
	else
		AutoChessAction.MergeChess(arg_77_0, arg_77_1, arg_77_2)
	end
end

function var_0_0.PlayerCheesUpgrade(arg_78_0, arg_78_1, arg_78_2)
	if arg_78_0 == AutoChessConst.GAME_TYPE.ONLINE then
		AutoChessMatchAction.PlayerCheesUpgrade(var_0_0.GetCurRound(arg_78_0), arg_78_1, arg_78_2)
	else
		AutoChessAction.PlayerCheesUpgrade(arg_78_0, arg_78_1, arg_78_2)
	end
end

function var_0_0.PrepareEnd(arg_79_0)
	if arg_79_0 == AutoChessConst.GAME_TYPE.ONLINE then
		-- block empty
	else
		AutoChessAction.PrepareEnd(arg_79_0)
	end
end

function var_0_0.CheckChessUnlock(arg_80_0)
	local var_80_0 = AutoChessCfg[arg_80_0]

	if table.indexof(var_80_0.activity_id, ActivityConst.ACTIVITY_AUTO_CHESS_MAIN) then
		return true
	elseif table.indexof(var_80_0.activity_id, ActivityConst.ACTIVITY_AUTO_CHESS_4_8) then
		local var_80_1 = var_80_0.group_id
		local var_80_2 = AutoChessCardCfg.get_id_list_by_group_id[var_80_1]

		for iter_80_0, iter_80_1 in ipairs(var_80_2) do
			if AutoChessCardData:GetCardNum(iter_80_1) > 0 then
				return true
			end
		end

		return false
	else
		return false
	end
end

return var_0_0
