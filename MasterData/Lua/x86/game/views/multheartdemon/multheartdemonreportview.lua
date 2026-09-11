local MultHeartDemonReportView = class("MultHeartDemonReportView", ReduxView)

function MultHeartDemonReportView:UIName()
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_MatchRecordUI"
end

function MultHeartDemonReportView:UIParent()
	return manager.ui.uiMain.transform
end

function MultHeartDemonReportView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MultHeartDemonReportView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.uiList_, MultHeartDemonReportItem)
end

function MultHeartDemonReportView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function MultHeartDemonReportView:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_1, self.data)
end

function MultHeartDemonReportView:UpdateView()
	self.list:StartScroll((self.data ~= nil and self.data.stageData ~= nil or nil) and (#self.data.stageData or 0))

	self.pointText_.text = self.maxScore
end

function MultHeartDemonReportView:OnEnter()
	self:UpdateData()
	self:UpdateView()
end

function MultHeartDemonReportView:UpdateData()
	self.activityId = MultHeartDemonData:GetDataByPara("activityId")
	self.maxScore = 0
	self.titleTxt_.text = GetTips("MULTI_HEART_DEMON_TOTAL_SCORE")
	self.difficult = self.params_.difficult
	self.cfg = MultHeartDemonCfg[self.activityId]
	self.data = self.params_.data

	for iter_10_0, iter_10_1 in pairs(self.data.stageData or {}) do
		self.maxScore = iter_10_1.maxScore + self.maxScore
	end
end

function MultHeartDemonReportView:OnMultDemonHeartSaveTeam()
	self:UpdateData()
	self:UpdateView()
end

function MultHeartDemonReportView:OnExit()
	manager.windowBar:HideBar()
end

function MultHeartDemonReportView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function MultHeartDemonReportView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	MultHeartDemonReportView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return MultHeartDemonReportView
