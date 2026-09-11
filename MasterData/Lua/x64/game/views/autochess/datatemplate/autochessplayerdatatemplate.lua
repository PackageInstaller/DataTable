local AutoChessPlayerDataTemplate = class("AutoChessPlayerDataTemplate")

function AutoChessPlayerDataTemplate:Ctor()
	self.uid = 0
	self.playerType = AutoChessConst.PLAYER_TYPE.SELF
	self.hp = 0
	self.victoryRoundCount = 0
	self.curRoundCount = 0
	self.stageID = 0
	self.isBrahmaBoss = nil
	self.battleUID = ""
	self.sunglassFlag = 0
	self.chessSkinList_ = {}
	self.icon = 2200103
	self.nick = ""
	self.chessDataDicByUniqueId = {}
	self.teamChessDataList = {}
	self.playerChessData = {}
end

function AutoChessPlayerDataTemplate:Init(arg_2_1, arg_2_2)
	self.isIgnoreToGlobal = arg_2_2

	self:InitBaseData(arg_2_1.base_info_list)
	self:InitChessData(arg_2_1.chess_list)
	self:InitGlobalPlayerData(arg_2_1.card_ids)
end

function AutoChessPlayerDataTemplate:InitBaseData(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if iter_3_1.key == AutoChessConst.USER_INFO_KEY.HP then
			self.hp = iter_3_1.value
		elseif iter_3_1.key == AutoChessConst.USER_INFO_KEY.VICTORY_ROUND_COUNT then
			self.victoryRoundCount = iter_3_1.value

			AutoChessData:CheckIsBattleBossRound(self.victoryRoundCount)
		elseif iter_3_1.key == AutoChessConst.USER_INFO_KEY.CUR_ROUND_COUNT then
			self.curRoundCount = iter_3_1.value
		elseif iter_3_1.key == AutoChessConst.USER_INFO_KEY.STAGE_ID then
			self.stageID = iter_3_1.value
		elseif iter_3_1.key == AutoChessConst.USER_INFO_KEY.BRAHMA_BOSS_FLAG then
			self.isBrahmaBoss = iter_3_1.value
		elseif iter_3_1.key == AutoChessConst.USER_INFO_KEY.BATTLE_UID then
			self.battleUID = iter_3_1.value2
		elseif iter_3_1.key == AutoChessConst.USER_INFO_KEY.SUNGLASS_FLAG then
			self.sunglassFlag = iter_3_1.value
		end
	end
end

function AutoChessPlayerDataTemplate:InitChessData(arg_4_1)
	self.chessDataDicByUniqueId = {}
	self.teamChessDataList = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1 or {}) do
		local var_4_0 = AutoChessItemDataTemplate.New()

		var_4_0:Init(iter_4_1)
		self:AddChess(var_4_0)
	end
end

function AutoChessPlayerDataTemplate:InitGlobalPlayerData(arg_5_1)
	self.chessSkinList_ = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_1 or {}) do
		if iter_5_1.key and iter_5_1.value then
			self.chessSkinList_[iter_5_1.key] = iter_5_1.value
		end
	end

	if not arg_5_1 then
		return
	end

	if self.isIgnoreToGlobal then
		return
	end

	AutoChessData:SetSunglassFlag(self.playerType, self.sunglassFlag)
	AutoChessData:SetChessSkin(self.playerType, self.chessSkinList_)
end

function AutoChessPlayerDataTemplate:SetPlayerType(arg_6_1)
	self.playerType = arg_6_1
end

function AutoChessPlayerDataTemplate:SetPlayerName(arg_7_1)
	self.nick = arg_7_1
end

function AutoChessPlayerDataTemplate:SetPlayerIcon(arg_8_1)
	if arg_8_1 == 0 then
		return
	end

	self.icon = arg_8_1
end

function AutoChessPlayerDataTemplate:AddChess(arg_9_1)
	self.chessDataDicByUniqueId[arg_9_1.uniqueId] = arg_9_1
	self.teamChessDataList[arg_9_1.index] = arg_9_1

	if AutoChessCfg[arg_9_1.chessId].type == AutoChessConst.CHESS_TYPE.PLAYER_CHESS then
		self.playerChessData = clone(arg_9_1)
	end
end

function AutoChessPlayerDataTemplate:RemoveChess(arg_10_1)
	if self.chessDataDicByUniqueId[arg_10_1] then
		self.teamChessDataList[self.chessDataDicByUniqueId[arg_10_1].index] = nil
		self.chessDataDicByUniqueId[arg_10_1] = nil
	else
		Debug.LogError("AutoChessPlayerDataTemplate:RemoveChess uniqueId = " .. arg_10_1 .. " not found")
	end
end

function AutoChessPlayerDataTemplate:UpdateChessTeamDataList(arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		local var_11_0 = iter_11_1

		if iter_11_1.uniqueId == nil and iter_11_1.unique_id then
			var_11_0 = AutoChessItemDataTemplate.New()

			var_11_0:Init(iter_11_1)
		end

		if self.chessDataDicByUniqueId[var_11_0.uniqueId] then
			self.teamChessDataList[self.chessDataDicByUniqueId[var_11_0.uniqueId].index] = nil
		end

		if AutoChessCfg[var_11_0.chessId].type == AutoChessConst.CHESS_TYPE.PLAYER_CHESS then
			self.playerChessData = clone(var_11_0)
		end

		self.teamChessDataList[var_11_0.index] = var_11_0
		self.chessDataDicByUniqueId[var_11_0.uniqueId] = var_11_0
	end

	manager.notify:Invoke("AUTO_CHESS_FORMATION_UPDATE")
end

function AutoChessPlayerDataTemplate:GetTeamDataList()
	return self.teamChessDataList
end

function AutoChessPlayerDataTemplate:GetChessDataByIndex(arg_13_1)
	return self.teamChessDataList[arg_13_1]
end

function AutoChessPlayerDataTemplate:GetPlayerChessData()
	return clone(self.playerChessData)
end

function AutoChessPlayerDataTemplate:GetStageId()
	return self.stageID
end

function AutoChessPlayerDataTemplate:GetIsBrahmaBoss()
	return self.isBrahmaBoss
end

function AutoChessPlayerDataTemplate:GetCurRound()
	return self.curRoundCount
end

function AutoChessPlayerDataTemplate:ClearPlayerChessData()
	self.chessDataDicByUniqueId = {}
	self.teamChessDataList = {}
	self.playerChessData = {}
end

return AutoChessPlayerDataTemplate
