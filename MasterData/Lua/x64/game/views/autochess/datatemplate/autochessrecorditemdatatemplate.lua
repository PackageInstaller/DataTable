local AutoChessRecordItemDataTemplate = class("AutoChessRecordItemDataTemplate")

function AutoChessRecordItemDataTemplate:Ctor(arg_1_1)
	self.type = AutoChessConst.RECORD_TYPE.PVP
	self.result = AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN
	self.timestamp = 0
	self.playerData = nil
	self.score = 0
	self.scoreDetailList = {}
	self.medalId = arg_1_1
	self.oldRankScore = 0
	self.newRankScore = 0
	self.rank = 0
end

function AutoChessRecordItemDataTemplate:Init(arg_2_1, arg_2_2)
	if arg_2_2 == AutoChessConst.RECORD_TYPE.PVP_4_8_ONLINE then
		self.oldRankScore = arg_2_1.rank_score
		self.newRankScore = arg_2_1.new_rank_score
		self.rank = arg_2_1.rank
	else
		self.score = arg_2_1.point
		self.scoreDetailList = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_1.point_detail) do
			table.insert(self.scoreDetailList, {
				id = iter_2_1.key,
				score = iter_2_1.value
			})
		end
	end

	self.type = arg_2_2
	self.result = arg_2_1.result
	self.isWin = self.result == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN
	self.timestamp = arg_2_1.time
	self.playerData = AutoChessPlayerDataTemplate.New()

	self.playerData:Init(arg_2_1.auto_chessboard_info, true)
end

return AutoChessRecordItemDataTemplate
