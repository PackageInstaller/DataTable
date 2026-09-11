local AutoChessRankItem_4_8 = class("AutoChessRankItem_4_8", (require("game/views/autoChess/view/rank/AutoChessRankItem")))

function AutoChessRankItem_4_8:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function AutoChessRankItem_4_8:InitUI()
	AutoChessRankItem_4_8.super.InitUI(self)

	self.typeController = self.conExCollection_:GetController("type")
end

function AutoChessRankItem_4_8:AddUIListeners()
	self:AddBtnListener(self.viewBtn_, nil, function()
		AutoChessMatchAction.OpenTeamnfoPopAfterFetch(self:GetRankActivityID(), self.data)
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_rank_team_touch",
			activity_id = AutoChessData:GetActivityID(),
			source = self.data.user_id
		})
	end)
end

function AutoChessRankItem_4_8:Dispose()
	AutoChessRankItem_4_8.super.Dispose(self)
end

function AutoChessRankItem_4_8:GetRankActivityID()
	if self.isLevelRank_ then
		return ActivityConst.ACTIVITY_AUTO_CHESS_LEVEL_RANK
	else
		return ActivityConst.ACTIVITY_AUTO_CHESS_SCORE_RANK
	end
end

function AutoChessRankItem_4_8:SetData(arg_7_1, arg_7_2)
	AutoChessRankItem_4_8.super.SetData(self, arg_7_1)

	self.isLevelRank = arg_7_2

	self.typeController:SetSelectedIndex(arg_7_2 and 0 or 1)

	if self.isLevelRank then
		local var_7_0 = AutoChessTools.GetRankLevelCfg(arg_7_1.score)

		self.rankLevelText_.text = var_7_0.name
		self.rankLevelIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_7_0.icon)
	end
end

return AutoChessRankItem_4_8
