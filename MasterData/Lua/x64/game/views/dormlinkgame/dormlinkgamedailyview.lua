local DormLinkGameDailyView = class("DormLinkGameDailyView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function DormLinkGameDailyView:GetUIName()
	return DormLinkGameTools.GetMainUIName(self.activityID_)
end

function DormLinkGameDailyView:Init()
	self:InitUI()
	self:AddListeners()
end

function DormLinkGameDailyView:InitUI()
	self:BindCfgUI()

	self.openController = self.controllers_:GetController("open")
	self.taskList = CommonActivityTaskListModule.New(self.questListGo_)
end

function DormLinkGameDailyView:indexDailyItemList(arg_4_1, arg_4_2)
	arg_4_2:RefreshUI(self.list_[arg_4_1], self.activityID_)
end

function DormLinkGameDailyView:AddListeners()
	self:AddBtnListenerScale(self.goBtn_, nil, function()
		if self.isAdvanceActivity_ then
			return
		end

		JumpTools.OpenPageByJump("/dormLinkGameLevelView", {
			activityID_ = self.activityID_
		})
	end)
	self:AddBtnListener(self.tipBtn_, nil, DormLinkGameTools.OpenGameTips)
end

function DormLinkGameDailyView:HideRedPoint()
	return
end

function DormLinkGameDailyView:OnEnter()
	DormLinkGameDailyView.super.OnEnter(self)
	self:RefreshView()

	if not self.isAdvanceActivity_ then
		self:RegisterEvents()
		manager.redPoint:bindUIandKey(self.goBtn_.transform, DormLinkGameData:RedPointKey(DormLinkGameData.LIANLIANKAN_IN_GAME))
	end
end

function DormLinkGameDailyView:UpdateBar()
	local var_9_0 = DormLinkGameTools:GetCurrencyID(self.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_9_0
	})
	manager.windowBar:SetBarCanClick(var_9_0, true)
end

function DormLinkGameDailyView:RegisterEvents()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, function()
		self:RefreshTask()
	end)
end

function DormLinkGameDailyView:RefreshView()
	self:RefreshTask()

	self.uiCharacterImage_.sprite = getSpriteWithoutAtlas(DormLinkGameTools.GetVersionCharaImgPath(self.activityID_))
end

function DormLinkGameDailyView:RefreshAcvanceStatus(arg_13_1)
	if self.isAdvanceActivity_ then
		arg_13_1 = false
	end

	self.openController:SetSelectedState(arg_13_1 and "true" or "false")
end

function DormLinkGameDailyView:RefreshTask()
	if self.isAdvanceActivity_ then
		return
	end

	self.taskList:RenderView((DormLinkGameTools:GetTaskActivityID(self.activityID_)))
end

function DormLinkGameDailyView:RefreshTimeText()
	DormLinkGameDailyView.super.RefreshTimeText(self)
end

function DormLinkGameDailyView:OnExit()
	if not self.isAdvanceActivity_ then
		manager.redPoint:unbindUIandKey(self.goBtn_.transform, DormLinkGameData:RedPointKey(DormLinkGameData.LIANLIANKAN_IN_GAME))
	end

	self:RemoveAllEventListener()
	DormLinkGameDailyView.super.OnExit(self)
end

function DormLinkGameDailyView:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	self.taskList:Dispose()
	DormLinkGameDailyView.super.Dispose(self)
end

return DormLinkGameDailyView
