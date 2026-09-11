local AutoChessRankView_4_8 = class("AutoChessRankView_4_8", (import("game.views.autoChess.view.rank.AutoChessRankView")))

function AutoChessRankView_4_8:UIName()
	return "Widget/System/Activity_Xihe/Activity_Xihe_RankUI"
end

function AutoChessRankView_4_8:InitUI()
	self:BindCfgUI()

	self.commonPortrait = CommonHeadPortrait.New(self.headItem_)
	self.tabController = self.controllers_:GetController("tab")
	self.btnController = self.controllers_:GetController("btn")
	self.scoreTabController = self.controllers_:GetController("scoreTab")
	self.list = LuaList.New(function(...)
		self:RenderRankItem(...)
	end, self.list_, AutoChessRankItem_4_8)
	self.title_.text = GetTips("AUTO_CHESS_LEADERBOARD_TITLE")
end

function AutoChessRankView_4_8:AddUIListeners()
	self:AddBtnListener(self.levelBtn_, nil, function()
		if self.isLevelRank_ then
			return
		end

		self.isLevelRank_ = true

		self.tabController:SetSelectedIndex(0)
		self:FetchRankData()
	end)
	self:AddBtnListener(self.scoreBtn_, nil, function()
		if not self.isLevelRank_ then
			return
		end

		self.isLevelRank_ = false

		self.tabController:SetSelectedIndex(1)
		self:FetchRankData()
	end)
	self:AddBtnListener(self.formationBtn_, nil, function()
		if self.playerData and self.playerData.score > 0 then
			AutoChessMatchAction.OpenTeamnfoPopAfterFetch(self:GetRankActivityID(), self.playerData)
			OperationRecorder.RecordButtonTouch({
				button_name = "activity_autochess_rank_team_touch",
				activity_id = AutoChessData:GetActivityID(),
				source = self.playerData.user_id
			})
		end
	end)
end

function AutoChessRankView_4_8:OnEnter()
	local var_8_0 = ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_SCORE_RANK)

	self.isLevelRank_ = not var_8_0

	self.scoreTabController:SetSelectedState(var_8_0 and "show" or "hide")
	self.tabController:SetSelectedIndex(var_8_0 and 1 or 0)
	self:FetchRankData()
	self:UpdatePlayerPortrait()
end

function AutoChessRankView_4_8:Dispose()
	AutoChessRankView_4_8.super.Dispose(self)
end

function AutoChessRankView_4_8:GetRankActivityID()
	if self.isLevelRank_ then
		return ActivityConst.ACTIVITY_AUTO_CHESS_LEVEL_RANK
	else
		return ActivityConst.ACTIVITY_AUTO_CHESS_SCORE_RANK
	end
end

function AutoChessRankView_4_8:OnRankUpdate()
	local var_11_0 = RankData:GetActivityRank(self:GetRankActivityID(), 0)

	if var_11_0 == nil then
		return
	end

	self.rankedPlayers = var_11_0.rankList or {}
	self.playerData = var_11_0.curRank

	if self.playerData.score > 0 then
		self.btnController:SetSelectedState("normal")
	else
		self.btnController:SetSelectedState("empty")
	end

	self:UpdatePlayerRankInfo(var_11_0)
	self:UpdateRankList(self.rankedPlayers)
end

function AutoChessRankView_4_8:RenderRankItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.rankedPlayers[arg_12_1], self.isLevelRank_)
end

function AutoChessRankView_4_8:UpdatePlayerRankInfo(arg_13_1)
	SetActive(self.formationBtn_.gameObject, false)

	if arg_13_1 then
		local var_13_0, var_13_1 = arg_13_1:GetCurRankDes()

		self.rank_.text = var_13_0

		if self.isLevelRank_ then
			local var_13_2 = AutoChessCardData:GetRankScore()

			self.score_.text = var_13_2 > self.playerData.score and var_13_2 or var_13_1
		else
			if self.playerData and self.playerData.score > 0 then
				self.score_.text = self.historyScore_ or var_13_1
			end

			SetActive(self.formationBtn_.gameObject, self.playerData.score > 0)
		end
	else
		self.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
		self.score_.text = GetTips("MATRIX_RANK_NO_INFO")
	end
end

return AutoChessRankView_4_8
