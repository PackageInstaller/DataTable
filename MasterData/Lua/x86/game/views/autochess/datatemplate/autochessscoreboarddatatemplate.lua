local AutoChessScoreBoardDataTemplate = class("AutoChessScoreBoardDataTemplate")

function AutoChessScoreBoardDataTemplate:Ctor()
	self.userId = 0
	self.isSelf = false
	self.playerData = nil
	self.battleUserId = 0
end

function AutoChessScoreBoardDataTemplate:Init(arg_2_1)
	self.userId = arg_2_1.user_id
	self.name = arg_2_1.name
	self.icon = arg_2_1.icon
	self.iconFrame = arg_2_1.icon_frame
	self.rankIndex = arg_2_1.rank_index

	if arg_2_1.old_rank_index == 0 then
		-- block empty
	end

	self.oldRankIndex = arg_2_1.old_rank_index
	self.isSelf = PlayerData:GetPlayerInfo().userID == self.userId

	if arg_2_1.chessboard_info then
		self.playerData = AutoChessPlayerDataTemplate.New()

		self.playerData:Init(arg_2_1.chessboard_info, true)
	else
		self.playerData = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_1.base_info_list) do
			if iter_2_1.key == AutoChessConst.USER_INFO_KEY.HP then
				self.playerData.hp = iter_2_1.value
			elseif iter_2_1.key == AutoChessConst.USER_INFO_KEY.VICTORY_ROUND_COUNT then
				self.playerData.victoryRoundCount = iter_2_1.value
			elseif iter_2_1.key == AutoChessConst.USER_INFO_KEY.CUR_ROUND_COUNT then
				self.playerData.curRoundCount = iter_2_1.value
			end
		end
	end

	if arg_2_1.battle_user_id then
		self.battleUserId = arg_2_1.battle_user_id
	end
end

return AutoChessScoreBoardDataTemplate
