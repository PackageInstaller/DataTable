local ActivityQuizSceneResultView = class("ActivityQuizSceneResultView", ReduxView)
local QuizFunction = import("game.quiz.QuizFunction")

function ActivityQuizSceneResultView:UIName()
	return ActivityQuizTools.GetResultUIName(self.params_.activityId)
end

function ActivityQuizSceneResultView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityQuizSceneResultView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityQuizSceneResultView:InitUI()
	self:BindCfgUI()

	self.rankScrollHelper_ = LuaList.New(handler(self, self.RankIndexItem), self.rankListGo_, ActivityQuizRankItem)
end

function ActivityQuizSceneResultView:RankIndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshData(self.rankList_[arg_5_1], self.rankIndexList_[arg_5_1])
	arg_5_2:SetMine(self.rankList_[arg_5_1] == self.userID_)
end

function ActivityQuizSceneResultView:AddUIListeners()
	self:AddBtnListener(self.shareBtn_, nil, function()
		manager.share:Share(function()
			self:SetShareItem(false)
		end, function()
			self:SetShareItem(true)
		end)
	end)
	self:AddBtnListener(self.quitBtn_, nil, function()
		QuitQuizScene()
	end)
	self:AddBtnListener(self.oneMoreBtn_, nil, function()
		ActivityQuizAction.StartMarch()
	end)
end

function ActivityQuizSceneResultView:OnEnter()
	self.activityID_ = self.params_.activityId
	self.userID_ = tostring(PlayerData:GetPlayerInfo().userID)

	self:RefreshRank()
	self:RefreshHero()
end

function ActivityQuizSceneResultView:RefreshRank()
	self.rankList_ = QuizFunction:GetPlayerList()

	self:SortRank()

	self.numIndex_.text = string.format(GetTips("SOLO_HEART_DEMON_REWARD_TIPS2"), self.rankIndexList_[table.indexof(self.rankList_, self.userID_)])
	self.rankScore_.text = QuizFunction:GetRankData(self.userID_).score
end

function ActivityQuizSceneResultView:SortRank()
	table.sort(self.rankList_, function(arg_15_0, arg_15_1)
		return QuizFunction:GetRankData(arg_15_0).score > QuizFunction:GetRankData(arg_15_1).score
	end)

	local var_14_0 = 1

	self.rankIndexList_ = {}

	local var_14_1 = QuizFunction:GetRankData(self.rankList_[1]).score

	for iter_14_0, iter_14_1 in ipairs(self.rankList_) do
		local var_14_2 = QuizFunction:GetRankData(iter_14_1)

		if var_14_1 > var_14_2.score then
			var_14_1 = var_14_2.score
			var_14_0 = iter_14_0
		end

		table.insert(self.rankIndexList_, var_14_0)
	end

	self.rankScrollHelper_:StartScroll(#self.rankList_)
end

function ActivityQuizSceneResultView:RefreshHero()
	local var_16_0 = {}
	local var_16_1 = {}

	for iter_16_0 = 1, 3 do
		if self.rankList_[iter_16_0] then
			table.insert(var_16_0, self.rankList_[iter_16_0])
			table.insert(var_16_1, self.rankIndexList_[iter_16_0])
		end
	end

	QuizFunction:ShowModels(var_16_0, var_16_1)
end

function ActivityQuizSceneResultView:SetShareItem(arg_17_1)
	if arg_17_1 then
		self:SetDefaultBar()
		SetActive(self.shareBtn_.gameObject, true)
		SetActive(self.quitBtn_.gameObject, true)
		SetActive(self.oneMoreBtn_.gameObject, true)
	else
		manager.windowBar:HideBar()
		SetActive(self.shareBtn_.gameObject, false)
		SetActive(self.quitBtn_.gameObject, false)
		SetActive(self.oneMoreBtn_.gameObject, false)
	end
end

function ActivityQuizSceneResultView:SetDefaultBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(ActivityQuizTools.GetHelpKey(self.activityID_))
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_QUIZ_QUIT"),
			OkCallback = function()
				ActivityQuizAction.ExitRoom()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function ActivityQuizSceneResultView:OnActivityQuizStartMarch()
	ActivityQuizTools.SetCurActivityID(self.activityID_, ActivityQuizTools.GetCurActivityBackTo())
	JumpTools.OpenPageByJump("activityQuizMatchPop", {
		activityId = self.activityID_
	})
end

function ActivityQuizSceneResultView:OnTop()
	self:SetShareItem(true)
end

function ActivityQuizSceneResultView:OnExit()
	self:RemoveAllEventListener()
end

function ActivityQuizSceneResultView:Dispose()
	self:RemoveAllListeners()
	self.rankScrollHelper_:Dispose()
	self.super.Dispose(self)
end

return ActivityQuizSceneResultView
