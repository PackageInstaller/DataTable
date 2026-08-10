local var_0_0 = class("AutoChessScoreBoardDataTemplate")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.userId = 0
	arg_1_0.isSelf = false
	arg_1_0.playerData = nil
	arg_1_0.battleUserId = 0
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.userId = arg_2_1.user_id
	arg_2_0.name = arg_2_1.name
	arg_2_0.icon = arg_2_1.icon
	arg_2_0.iconFrame = arg_2_1.icon_frame
	arg_2_0.rankIndex = arg_2_1.rank_index

	if arg_2_1.old_rank_index == 0 then
		-- block empty
	end

	arg_2_0.oldRankIndex = arg_2_1.old_rank_index
	arg_2_0.isSelf = PlayerData:GetPlayerInfo().userID == arg_2_0.userId

	if arg_2_1.chessboard_info then
		arg_2_0.playerData = AutoChessPlayerDataTemplate.New()

		arg_2_0.playerData:Init(arg_2_1.chessboard_info, true)
	else
		arg_2_0.playerData = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_1.base_info_list) do
			if iter_2_1.key == AutoChessConst.USER_INFO_KEY.HP then
				arg_2_0.playerData.hp = iter_2_1.value
			elseif iter_2_1.key == AutoChessConst.USER_INFO_KEY.VICTORY_ROUND_COUNT then
				arg_2_0.playerData.victoryRoundCount = iter_2_1.value
			elseif iter_2_1.key == AutoChessConst.USER_INFO_KEY.CUR_ROUND_COUNT then
				arg_2_0.playerData.curRoundCount = iter_2_1.value
			end
		end
	end

	if arg_2_1.battle_user_id then
		arg_2_0.battleUserId = arg_2_1.battle_user_id
	end
end

return var_0_0
