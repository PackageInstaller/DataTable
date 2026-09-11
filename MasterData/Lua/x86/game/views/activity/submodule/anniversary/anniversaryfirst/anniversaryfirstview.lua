ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local AnniversaryFirstView = class("AnniversaryFirstView", ActivityMainBasePanel)

function AnniversaryFirstView:GetUIName()
	return "UI/VersionUI/XuHeng1stUI/XH1stYearsHomeUI/XH1stYearsHomeUI"
end

function AnniversaryFirstView:Init()
	AnniversaryFirstView.super.Init(self)

	self.anniversaryGiftView_ = AnniversaryGiftView.New(self.giftGo_)
	self.taskUpdateHandler_ = handler(self, self.TaskUpdate)
	self.scrollHelper_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, AnniversaryTaskItem)
end

function AnniversaryFirstView:OnEnter()
	AnniversaryFirstView.super.OnEnter(self)
	self.anniversaryGiftView_:OnEnter()
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, self.taskUpdateHandler_)
end

function AnniversaryFirstView:OnExit()
	AnniversaryFirstView.super.OnExit(self)
	self.anniversaryGiftView_:OnExit()
	manager.notify:RemoveListener(OSIRIS_TASK_UPDATE, self.taskUpdateHandler_)
end

function AnniversaryFirstView:Dispose()
	self.taskUpdateHandler_ = nil

	self.scrollHelper_:Dispose()
	self.anniversaryGiftView_:Dispose()

	self.anniversaryGiftView_ = nil

	AnniversaryFirstView.super.Dispose(self)
end

function AnniversaryFirstView:AddListeners()
	self:AddBtnListener(self.infoButton_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ANNIVERSARY_INFO",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ANNIVERSARY_INFO")
		})
	end)
end

function AnniversaryFirstView:Show(arg_8_1)
	AnniversaryFirstView.super.Show(self, arg_8_1)

	if arg_8_1 then
		self.scrollHelper_:StartScroll(#TaskData2:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_ANNIVERSARY_NORMAL_TASK))
	end
end

function AnniversaryFirstView:TaskUpdate()
	self.scrollHelper_:StartScroll(#TaskData2:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_ANNIVERSARY_NORMAL_TASK))
	self.anniversaryGiftView_:UpdateItem()
end

function AnniversaryFirstView:RefreshItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(TaskData2:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_ANNIVERSARY_NORMAL_TASK)[arg_10_1].id)
end

return AnniversaryFirstView
