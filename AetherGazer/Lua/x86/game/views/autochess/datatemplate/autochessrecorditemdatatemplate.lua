local var_0_0 = class("AutoChessRecordItemDataTemplate")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.type = AutoChessConst.RECORD_TYPE.PVP
	arg_1_0.result = AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN
	arg_1_0.timestamp = 0
	arg_1_0.playerData = nil
	arg_1_0.score = 0
	arg_1_0.scoreDetailList = {}
	arg_1_0.medalId = arg_1_1
	arg_1_0.oldRankScore = 0
	arg_1_0.newRankScore = 0
	arg_1_0.rank = 0
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 == AutoChessConst.RECORD_TYPE.PVP_4_8_ONLINE then
		arg_2_0.oldRankScore = arg_2_1.rank_score
		arg_2_0.newRankScore = arg_2_1.new_rank_score
		arg_2_0.rank = arg_2_1.rank
	else
		arg_2_0.score = arg_2_1.point
		arg_2_0.scoreDetailList = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_1.point_detail) do
			local var_2_0 = {
				id = iter_2_1.key,
				score = iter_2_1.value
			}

			table.insert(arg_2_0.scoreDetailList, var_2_0)
		end
	end

	arg_2_0.type = arg_2_2
	arg_2_0.result = arg_2_1.result
	arg_2_0.isWin = arg_2_0.result == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN
	arg_2_0.timestamp = arg_2_1.time
	arg_2_0.playerData = AutoChessPlayerDataTemplate.New()

	arg_2_0.playerData:Init(arg_2_1.auto_chessboard_info, true)
end

return var_0_0
