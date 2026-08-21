local var_0_0 = class("AutoChessBattleDataTemplate")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.gameType = AutoChessConst.GAME_TYPE.PVE
	arg_1_0.result = AutoChessConst.BATTLE_ROUND_RESULT.DRAW
	arg_1_0.battleUid = 0
	arg_1_0.selfPlayerUid = 0
	arg_1_0.oppenentPlayerUid = 0
	arg_1_0.selfPlayerData = nil
	arg_1_0.oppenentPlayerData = nil
	arg_1_0.maxRound = 0
	arg_1_0.score = 0
	arg_1_0.scoreDetailList = {}
	arg_1_0.roundBattleDataDic = {}
	arg_1_0.initedRoundDataCount = 0
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.gameType = arg_2_2 or arg_2_1.game_type
	arg_2_0.selfPlayerUid = tonumber(PlayerData:GetPlayerInfo().userID)

	local var_2_0 = tonumber(arg_2_1.user_id1)

	arg_2_0.isSelfFirst = var_2_0 == 0 or arg_2_0.selfPlayerUid == var_2_0
	arg_2_0.oppenentPlayerUid = arg_2_0.isSelfFirst and tonumber(arg_2_1.user_id2) or var_2_0

	arg_2_0:InitBaseData(arg_2_1)
	arg_2_0:InitPlayerData(arg_2_1)

	arg_2_0.roundBattleDataDic = {}
	arg_2_0.initedRoundDataCount = 0
end

function var_0_0.InitBaseData(arg_3_0, arg_3_1)
	if arg_3_0.isSelfFirst or arg_3_1.result == AutoChessConst.BATTLE_ROUND_RESULT.DRAW then
		arg_3_0.result = arg_3_1.result
	else
		arg_3_0.result = arg_3_1.result == AutoChessConst.BATTLE_ROUND_RESULT.WIN and AutoChessConst.BATTLE_ROUND_RESULT.LOSE or AutoChessConst.BATTLE_ROUND_RESULT.WIN
	end

	arg_3_0.battleUid = arg_3_1.battle_uid
	arg_3_0.maxRound = arg_3_1.max_group_id
	arg_3_0.score = arg_3_1.point or 0
	arg_3_0.scoreDetailList = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.point_detail or {}) do
		local var_3_0 = {
			id = iter_3_1.key,
			score = iter_3_1.value
		}

		table.insert(arg_3_0.scoreDetailList, var_3_0)
	end
end

function var_0_0.InitPlayerData(arg_4_0, arg_4_1)
	arg_4_0.selfPlayerData = AutoChessPlayerDataTemplate.New()
	arg_4_0.oppenentPlayerData = AutoChessPlayerDataTemplate.New()

	arg_4_0.selfPlayerData:SetPlayerType(AutoChessConst.PLAYER_TYPE.SELF)
	arg_4_0.oppenentPlayerData:SetPlayerType(AutoChessConst.PLAYER_TYPE.OPPONENT)

	if arg_4_0.selfPlayerUid == 0 or arg_4_0.isSelfFirst then
		arg_4_0.selfPlayerData:Init(arg_4_1.auto_chessboard_info1)
		arg_4_0.oppenentPlayerData:Init(arg_4_1.auto_chessboard_info2)
	else
		arg_4_0.selfPlayerData:Init(arg_4_1.auto_chessboard_info2)
		arg_4_0.oppenentPlayerData:Init(arg_4_1.auto_chessboard_info1)
	end

	arg_4_0.oppenentPlayerData:SetPlayerName(arg_4_1.enemy_name)
	arg_4_0.oppenentPlayerData:SetPlayerIcon(arg_4_1.enemy_icon)
end

function var_0_0.InitRoundBattleData(arg_5_0, arg_5_1)
	local var_5_0 = AutoChessRoundBattleDataTemplate.New()

	var_5_0:Init(arg_5_1.battle_info)

	local var_5_1 = var_5_0.round

	if arg_5_0.roundBattleDataDic[var_5_1] == nil then
		arg_5_0.roundBattleDataDic[var_5_1] = var_5_0
		arg_5_0.initedRoundDataCount = arg_5_0.initedRoundDataCount + 1
	end
end

function var_0_0.UpdateSettleData(arg_6_0)
	local var_6_0 = AutoChessData:GetGameStatus(arg_6_0.gameType)

	if var_6_0 == AutoChessConst.GAME_STATUS.ROUND_SETTLE then
		if arg_6_0.result == AutoChessConst.BATTLE_ROUND_RESULT.WIN then
			arg_6_0.selfPlayerData.victoryRoundCount = arg_6_0.selfPlayerData.victoryRoundCount + 1

			AutoChessData:CheckIsBattleBossRound(arg_6_0.selfPlayerData.victoryRoundCount)
		elseif arg_6_0.result == AutoChessConst.BATTLE_ROUND_RESULT.LOSE then
			arg_6_0.selfPlayerData.hp = arg_6_0.selfPlayerData.hp - 1
		end
	elseif var_6_0 == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
		arg_6_0.selfPlayerData.victoryRoundCount = arg_6_0.selfPlayerData.victoryRoundCount + 1
	elseif var_6_0 == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE then
		arg_6_0.selfPlayerData.hp = arg_6_0.selfPlayerData.hp - 1
	end
end

return var_0_0
