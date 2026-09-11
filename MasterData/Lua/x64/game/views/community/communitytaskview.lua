local CommunityTaskView = class("CommunityTaskView", ReduxView)

function CommunityTaskView:UIName()
	return "Widget/System/Club/ClubCtivityUI"
end

function CommunityTaskView:UIParent()
	return manager.ui.uiMain.transform
end

function CommunityTaskView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CommunityTaskView:InitUI()
	self:BindCfgUI()

	self.taskList_ = {}
	self.taskListModule = CommonTaskListModule.New(self.comTaskList_)

	self.taskListModule:RegisterTaskListChangedEvent(handler(self, self.RefreshUI))

	self.guildExitHandler_ = handler(self, self.ExitGuild)
	self.btnController_ = self.exController_:GetController("btnController")
end

function CommunityTaskView:AddUIListener()
	self:AddBtnListener(self.btnReceive_, nil, function()
		TaskAction:SubmitTaskList(TaskTools:GetFinishTaskIds(TaskConst.TASK_TYPE.CLUB_TASK), TaskConst.TASK_TYPE.CLUB_TASK)
	end)
end

function CommunityTaskView:OnEnter()
	self.taskListModule:OnEnter()
	self.taskListModule:RenderTypeTaskList(TaskConst.TASK_TYPE.CLUB_TASK)
	self:RefreshUI()
	manager.notify:RegistListener(GUILD_EXIT, self.guildExitHandler_)
end

function CommunityTaskView:RefreshUI()
	self.identity_ = CommunityData:GetIdentity()

	self:RefreshBar()

	if #TaskTools:GetFinishTaskIds(TaskConst.TASK_TYPE.CLUB_TASK) > 0 then
		self.btnController_:SetSelectedState("true")
	else
		self.btnController_:SetSelectedState("false")
	end
end

function CommunityTaskView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function CommunityTaskView:ExitGuild()
	self:Go("/home")
end

function CommunityTaskView:OnExit()
	self.taskListModule:OnExit()
	manager.notify:RemoveListener(GUILD_EXIT, self.guildExitHandler_)
	manager.windowBar:HideBar()
end

function CommunityTaskView:Dispose()
	self.taskListModule:Dispose()
	self:RemoveAllListeners()
	CommunityTaskView.super.Dispose(self)
end

return CommunityTaskView
