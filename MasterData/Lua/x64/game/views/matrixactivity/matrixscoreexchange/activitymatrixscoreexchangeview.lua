local ActivityMatrixScoreExchangeMiniView = class("ActivityMatrixScoreExchangeMiniView", ReduxView)

function ActivityMatrixScoreExchangeMiniView:UIName()
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeRewardshow"
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

	self.exchangeList = LuaList.New(handler(self, self.IndexItem), self.scoreListGo_, ActivityMatrixScoreExchangeItem)
end

function ActivityMatrixScoreExchangeMiniView:AddUIListener()
	self:AddBtnListener(self.oneKeyGetBtn_, nil, function()
		local var_6_0 = {}
		local var_6_1 = ActivityMatrixData:GetMatrixScore(self.matrix_activity_id)

		for iter_6_0, iter_6_1 in ipairs(self.rewards) do
			if var_6_1 >= ActivityPointRewardCfg[iter_6_1].need and not ActivityMatrixData:GetMatrixPointRewardState(self.matrix_activity_id, iter_6_1) then
				table.insert(var_6_0, iter_6_1)
			end
		end

		ActivityAction.ReceivePointReward(var_6_0)
	end)
	self:AddBtnListener(self.bgMask_, nil, function()
		self:Back()
	end)
end

function ActivityMatrixScoreExchangeMiniView:OnTop()
	manager.windowBar:SwitchBar({})
end

function ActivityMatrixScoreExchangeMiniView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id
	self.rewards = ActivityPointRewardCfg.get_id_list_by_activity_id[self.matrix_activity_id] or {}

	self.exchangeList:StartScroll(#self.rewards)
	self:Refresh()
end

function ActivityMatrixScoreExchangeMiniView:Refresh()
	local var_10_0 = ActivityMatrixData:GetMatrixScore(self.matrix_activity_id)

	self.myScoreText_.text = string.format("%d", var_10_0)

	local var_10_1 = false

	for iter_10_0, iter_10_1 in ipairs(self.rewards) do
		if var_10_0 >= ActivityPointRewardCfg[iter_10_1].need and not ActivityMatrixData:GetMatrixPointRewardState(self.matrix_activity_id, iter_10_1) then
			var_10_1 = true

			break
		end
	end

	SetActive(self.oneKeyGetBtn_.gameObject, var_10_1)

	self.m_name.text = GetI18NText(ActivityMatrixCfg[self.matrix_activity_id].name)
end

function ActivityMatrixScoreExchangeMiniView:OnExit()
	manager.windowBar:HideBar()
end

function ActivityMatrixScoreExchangeMiniView:IndexItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.rewards[arg_12_1], self.matrix_activity_id)
end

function ActivityMatrixScoreExchangeMiniView:Dispose()
	self.exchangeList:Dispose()
	ActivityMatrixScoreExchangeMiniView.super.Dispose(self)
end

function ActivityMatrixScoreExchangeMiniView:OnReceivePointReward()
	self:Refresh()
	self.exchangeList:Refresh()
end

return ActivityMatrixScoreExchangeMiniView
