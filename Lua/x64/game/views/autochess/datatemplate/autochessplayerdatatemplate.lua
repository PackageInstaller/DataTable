local var_0_0 = class("AutoChessPlayerDataTemplate")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.uid = 0
	arg_1_0.playerType = AutoChessConst.PLAYER_TYPE.SELF
	arg_1_0.hp = 0
	arg_1_0.victoryRoundCount = 0
	arg_1_0.curRoundCount = 0
	arg_1_0.stageID = 0
	arg_1_0.isBrahmaBoss = nil
	arg_1_0.battleUID = ""
	arg_1_0.sunglassFlag = 0
	arg_1_0.chessSkinList_ = {}
	arg_1_0.icon = 2200103
	arg_1_0.nick = ""
	arg_1_0.chessDataDicByUniqueId = {}
	arg_1_0.teamChessDataList = {}
	arg_1_0.playerChessData = {}
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.isIgnoreToGlobal = arg_2_2

	arg_2_0:InitBaseData(arg_2_1.base_info_list)
	arg_2_0:InitChessData(arg_2_1.chess_list)
	arg_2_0:InitGlobalPlayerData(arg_2_1.card_ids)
end

function var_0_0.InitBaseData(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if iter_3_1.key == AutoChessConst.USER_INFO_KEY.HP then
			arg_3_0.hp = iter_3_1.value
		elseif iter_3_1.key == AutoChessConst.USER_INFO_KEY.VICTORY_ROUND_COUNT then
			arg_3_0.victoryRoundCount = iter_3_1.value

			AutoChessData:CheckIsBattleBossRound(arg_3_0.victoryRoundCount)
		elseif iter_3_1.key == AutoChessConst.USER_INFO_KEY.CUR_ROUND_COUNT then
			arg_3_0.curRoundCount = iter_3_1.value
		elseif iter_3_1.key == AutoChessConst.USER_INFO_KEY.STAGE_ID then
			arg_3_0.stageID = iter_3_1.value
		elseif iter_3_1.key == AutoChessConst.USER_INFO_KEY.BRAHMA_BOSS_FLAG then
			arg_3_0.isBrahmaBoss = iter_3_1.value
		elseif iter_3_1.key == AutoChessConst.USER_INFO_KEY.BATTLE_UID then
			arg_3_0.battleUID = iter_3_1.value2
		elseif iter_3_1.key == AutoChessConst.USER_INFO_KEY.SUNGLASS_FLAG then
			arg_3_0.sunglassFlag = iter_3_1.value
		end
	end
end

function var_0_0.InitChessData(arg_4_0, arg_4_1)
	arg_4_0.chessDataDicByUniqueId = {}
	arg_4_0.teamChessDataList = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1 or {}) do
		local var_4_0 = AutoChessItemDataTemplate.New()

		var_4_0:Init(iter_4_1)
		arg_4_0:AddChess(var_4_0)
	end
end

function var_0_0.InitGlobalPlayerData(arg_5_0, arg_5_1)
	arg_5_0.chessSkinList_ = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_1 or {}) do
		if iter_5_1.key and iter_5_1.value then
			arg_5_0.chessSkinList_[iter_5_1.key] = iter_5_1.value
		end
	end

	if not arg_5_1 then
		return
	end

	if arg_5_0.isIgnoreToGlobal then
		return
	end

	AutoChessData:SetSunglassFlag(arg_5_0.playerType, arg_5_0.sunglassFlag)
	AutoChessData:SetChessSkin(arg_5_0.playerType, arg_5_0.chessSkinList_)
end

function var_0_0.SetPlayerType(arg_6_0, arg_6_1)
	arg_6_0.playerType = arg_6_1
end

function var_0_0.SetPlayerName(arg_7_0, arg_7_1)
	arg_7_0.nick = arg_7_1
end

function var_0_0.SetPlayerIcon(arg_8_0, arg_8_1)
	if arg_8_1 == 0 then
		return
	end

	arg_8_0.icon = arg_8_1
end

function var_0_0.AddChess(arg_9_0, arg_9_1)
	arg_9_0.chessDataDicByUniqueId[arg_9_1.uniqueId] = arg_9_1
	arg_9_0.teamChessDataList[arg_9_1.index] = arg_9_1

	if AutoChessCfg[arg_9_1.chessId].type == AutoChessConst.CHESS_TYPE.PLAYER_CHESS then
		arg_9_0.playerChessData = clone(arg_9_1)
	end
end

function var_0_0.RemoveChess(arg_10_0, arg_10_1)
	if arg_10_0.chessDataDicByUniqueId[arg_10_1] then
		arg_10_0.teamChessDataList[arg_10_0.chessDataDicByUniqueId[arg_10_1].index] = nil
		arg_10_0.chessDataDicByUniqueId[arg_10_1] = nil
	else
		Debug.LogError("AutoChessPlayerDataTemplate:RemoveChess uniqueId = " .. arg_10_1 .. " not found")
	end
end

function var_0_0.UpdateChessTeamDataList(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		local var_11_0 = iter_11_1

		if iter_11_1.uniqueId == nil and iter_11_1.unique_id then
			var_11_0 = AutoChessItemDataTemplate.New()

			var_11_0:Init(iter_11_1)
		end

		if arg_11_0.chessDataDicByUniqueId[var_11_0.uniqueId] then
			arg_11_0.teamChessDataList[arg_11_0.chessDataDicByUniqueId[var_11_0.uniqueId].index] = nil
		end

		if AutoChessCfg[var_11_0.chessId].type == AutoChessConst.CHESS_TYPE.PLAYER_CHESS then
			arg_11_0.playerChessData = clone(var_11_0)
		end

		arg_11_0.teamChessDataList[var_11_0.index] = var_11_0
		arg_11_0.chessDataDicByUniqueId[var_11_0.uniqueId] = var_11_0
	end

	manager.notify:Invoke("AUTO_CHESS_FORMATION_UPDATE")
end

function var_0_0.GetTeamDataList(arg_12_0)
	return arg_12_0.teamChessDataList
end

function var_0_0.GetChessDataByIndex(arg_13_0, arg_13_1)
	return arg_13_0.teamChessDataList[arg_13_1]
end

function var_0_0.GetPlayerChessData(arg_14_0)
	return clone(arg_14_0.playerChessData)
end

function var_0_0.GetStageId(arg_15_0)
	return arg_15_0.stageID
end

function var_0_0.GetIsBrahmaBoss(arg_16_0)
	return arg_16_0.isBrahmaBoss
end

function var_0_0.GetCurRound(arg_17_0)
	return arg_17_0.curRoundCount
end

function var_0_0.ClearPlayerChessData(arg_18_0)
	arg_18_0.chessDataDicByUniqueId = {}
	arg_18_0.teamChessDataList = {}
	arg_18_0.playerChessData = {}
end

return var_0_0
