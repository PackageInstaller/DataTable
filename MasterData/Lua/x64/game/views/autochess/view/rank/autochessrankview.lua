local AutoChessRankView = class("AutoChessRankView", ReduxView)

function AutoChessRankView:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_RankUI"
end

function AutoChessRankView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessRankView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AutoChessRankView:InitUI()
	self:BindCfgUI()

	self.commonPortrait = CommonHeadPortrait.New(self.headItem_)
	self.stageController = self.controllers_:GetController("stage")
	self.btnController = self.controllers_:GetController("btn")
	self.list = LuaList.New(function(...)
		self:RenderRankItem(...)
	end, self.list_, AutoChessRankItem)
	self.title_.text = GetTips("AUTO_CHESS_LEADERBOARD_TITLE")
end

function AutoChessRankView:AddUIListeners()
	self:AddBtnListener(self.formationBtn_, nil, function()
		if self.playerData and self.playerData.score > 0 then
			AutoChessAction.OpenTeamnfoPopAfterFetch(self:GetRankActivityID(), self.playerData)
			OperationRecorder.RecordButtonTouch({
				button_name = "activity_autochess_rank_team_touch",
				activity_id = AutoChessData:GetActivityID(),
				source = self.playerData.user_id
			})
		end
	end)
end

function AutoChessRankView:OnEnter()
	self:FetchRankData()

	self.rankType = RankBaseConst.RANK_TYPE.ALL

	self:UpdatePlayerPortrait()
end

function AutoChessRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function AutoChessRankView:OnBehind()
	manager.windowBar:HideBar()
end

function AutoChessRankView:Dispose()
	self.commonPortrait:Dispose()
	self.list:Dispose()
	AutoChessRankView.super.Dispose(self)
end

function AutoChessRankView:GetRankActivityID()
	return 3740701
end

function AutoChessRankView:FetchRankData()
	RankAction.QueryActivityRankWitchCallBack(self:GetRankActivityID(), 0, function()
		manager.notify:CallUpdateFunc("OnRankUpdate")
	end)
end

function AutoChessRankView:OnRankUpdate()
	local var_15_0 = RankData:GetActivityRank(self:GetRankActivityID(), 0)

	if var_15_0 == nil then
		return
	end

	self.rankedPlayers = var_15_0.rankList or {}
	self.playerData = var_15_0.curRank

	if self.playerData.score > 0 then
		self.btnController:SetSelectedState("normal")
	else
		self.btnController:SetSelectedState("empty")
	end

	self:UpdatePlayerRankInfo(var_15_0)
	self:UpdateRankList(self.rankedPlayers)
end

function AutoChessRankView:UpdateRankList(arg_16_1)
	self.list:StartScroll(#arg_16_1)
end

function AutoChessRankView:UpdatePlayerRankInfo(arg_17_1)
	if arg_17_1 then
		local var_17_0, var_17_1 = arg_17_1:GetCurRankDes()

		self.rank_.text = var_17_0
		self.score_.text = var_17_1
	else
		self.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
		self.score_.text = GetTips("MATRIX_RANK_NO_INFO")
	end
end

function AutoChessRankView:UpdatePlayerPortrait()
	local var_18_0 = PlayerData:GetPlayerInfo()

	self.commonPortrait:RenderHead(var_18_0.portrait)
	self.commonPortrait:RenderFrame(var_18_0.icon_frame)

	self.nameTxt_.text = var_18_0.nick
end

function AutoChessRankView:RenderRankItem(arg_19_1, arg_19_2)
	arg_19_2:SetData(self.rankedPlayers[arg_19_1])
end

return AutoChessRankView
