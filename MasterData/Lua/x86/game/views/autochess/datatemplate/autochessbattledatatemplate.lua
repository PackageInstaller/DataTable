local AutoChessBattleDataTemplate = class("AutoChessBattleDataTemplate")

function AutoChessBattleDataTemplate:Ctor()
	self.gameType = AutoChessConst.GAME_TYPE.PVE
	self.result = AutoChessConst.BATTLE_ROUND_RESULT.DRAW
	self.battleUid = 0
	self.selfPlayerUid = 0
	self.oppenentPlayerUid = 0
	self.selfPlayerData = nil
	self.oppenentPlayerData = nil
	self.maxRound = 0
	self.score = 0
	self.scoreDetailList = {}
	self.roundBattleDataDic = {}
	self.initedRoundDataCount = 0
end

function AutoChessBattleDataTemplate:Init(arg_2_1, arg_2_2)
	self.gameType = arg_2_2 or arg_2_1.game_type
	self.selfPlayerUid = tonumber(PlayerData:GetPlayerInfo().userID)

	local var_2_0 = tonumber(arg_2_1.user_id1)

	self.isSelfFirst = var_2_0 == 0 or self.selfPlayerUid == var_2_0
	self.oppenentPlayerUid = self.isSelfFirst and tonumber(arg_2_1.user_id2) or var_2_0

	self:InitBaseData(arg_2_1)
	self:InitPlayerData(arg_2_1)

	self.roundBattleDataDic = {}
	self.initedRoundDataCount = 0
end

function AutoChessBattleDataTemplate:InitBaseData(arg_3_1)
	if self.isSelfFirst or arg_3_1.result == AutoChessConst.BATTLE_ROUND_RESULT.DRAW then
		self.result = arg_3_1.result
	elseif arg_3_1.result == AutoChessConst.BATTLE_ROUND_RESULT.WIN then
		self.result = AutoChessConst.BATTLE_ROUND_RESULT.LOSE or AutoChessConst.BATTLE_ROUND_RESULT.WIN
	end

	self.battleUid = arg_3_1.battle_uid
	self.maxRound = arg_3_1.max_group_id
	self.score = arg_3_1.point or 0
	self.scoreDetailList = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.point_detail or {}) do
		table.insert(self.scoreDetailList, {
			id = iter_3_1.key,
			score = iter_3_1.value
		})
	end
end

function AutoChessBattleDataTemplate:InitPlayerData(arg_4_1)
	self.selfPlayerData = AutoChessPlayerDataTemplate.New()
	self.oppenentPlayerData = AutoChessPlayerDataTemplate.New()

	self.selfPlayerData:SetPlayerType(AutoChessConst.PLAYER_TYPE.SELF)
	self.oppenentPlayerData:SetPlayerType(AutoChessConst.PLAYER_TYPE.OPPONENT)

	if self.selfPlayerUid == 0 or self.isSelfFirst then
		self.selfPlayerData:Init(arg_4_1.auto_chessboard_info1)
		self.oppenentPlayerData:Init(arg_4_1.auto_chessboard_info2)
	else
		self.selfPlayerData:Init(arg_4_1.auto_chessboard_info2)
		self.oppenentPlayerData:Init(arg_4_1.auto_chessboard_info1)
	end

	self.oppenentPlayerData:SetPlayerName(arg_4_1.enemy_name)
	self.oppenentPlayerData:SetPlayerIcon(arg_4_1.enemy_icon)
end

function AutoChessBattleDataTemplate:InitRoundBattleData(arg_5_1)
	local var_5_0 = AutoChessRoundBattleDataTemplate.New()

	var_5_0:Init(arg_5_1.battle_info)

	if self.roundBattleDataDic[var_5_0.round] == nil then
		self.roundBattleDataDic[var_5_0.round] = var_5_0
		self.initedRoundDataCount = self.initedRoundDataCount + 1
	end
end

function AutoChessBattleDataTemplate:UpdateSettleData()
	local var_6_0 = AutoChessData:GetGameStatus(self.gameType)

	if var_6_0 == AutoChessConst.GAME_STATUS.ROUND_SETTLE then
		if self.result == AutoChessConst.BATTLE_ROUND_RESULT.WIN then
			self.selfPlayerData.victoryRoundCount = self.selfPlayerData.victoryRoundCount + 1

			AutoChessData:CheckIsBattleBossRound(self.selfPlayerData.victoryRoundCount)
		elseif self.result == AutoChessConst.BATTLE_ROUND_RESULT.LOSE then
			self.selfPlayerData.hp = self.selfPlayerData.hp - 1
		end
	elseif var_6_0 == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
		self.selfPlayerData.victoryRoundCount = self.selfPlayerData.victoryRoundCount + 1
	elseif var_6_0 == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE then
		self.selfPlayerData.hp = self.selfPlayerData.hp - 1
	end
end

return AutoChessBattleDataTemplate
