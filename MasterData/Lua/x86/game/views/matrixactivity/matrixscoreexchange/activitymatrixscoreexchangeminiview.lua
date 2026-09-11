local ActivityMatrixScoreExchangeMiniView = class("ActivityMatrixScoreExchangeMiniView", ReduxView)

function ActivityMatrixScoreExchangeMiniView:UIName()
	return "UI/Matrix/ScoreExchange/MatrixScoreExchangeMiniUI"
end

function ActivityMatrixScoreExchangeMiniView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityMatrixScoreExchangeMiniView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityMatrixScoreExchangeMiniView:InitUI()
	self:BindCfgUI()

	self.exchangeList = LuaList.New(handler(self, self.IndexItem), self.scoreListGo_, ActivityMatrixScoreExchangeMiniItem)
end

function ActivityMatrixScoreExchangeMiniView:AddUIListener()
	self:AddBtnListener(self.oneKeyGetBtn_, nil, function()
		return
	end)
end

function ActivityMatrixScoreExchangeMiniView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityMatrixScoreExchangeMiniView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id
	self.rewards = ActivityPointRewardCfg.get_id_list_by_activity_id[self.matrix_activity_id]

	self.exchangeList:StartScroll(#self.rewards)
	self:Refresh()
end

function ActivityMatrixScoreExchangeMiniView:Refresh()
	local var_9_0 = ActivityMatrixData:GetMatrixScore(self.matrix_activity_id)

	self.myScoreText_.text = string.format("%d", var_9_0)

	local var_9_1 = false

	for iter_9_0, iter_9_1 in ipairs(self.rewards) do
		if var_9_0 >= ActivityPointRewardCfg[iter_9_1].need and not ActivityMatrixData:GetMatrixPointRewardState(self.matrix_activity_id, iter_9_1) then
			var_9_1 = true

			break
		end
	end

	SetActive(self.oneKeyGetBtn_.gameObject, var_9_1)

	self.countdownText_.text = ""
end

function ActivityMatrixScoreExchangeMiniView:OnExit()
	manager.windowBar:HideBar()
end

function ActivityMatrixScoreExchangeMiniView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(self.rewards[arg_11_1], self.matrix_activity_id)
end

function ActivityMatrixScoreExchangeMiniView:Dispose()
	self.exchangeList:Dispose()
	ActivityMatrixScoreExchangeMiniView.super.Dispose(self)
end

return ActivityMatrixScoreExchangeMiniView
