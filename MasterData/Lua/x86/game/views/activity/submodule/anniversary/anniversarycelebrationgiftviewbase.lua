local AnniversaryCelebrationGiftViewBase = class("AnniversaryCelebrationGiftViewBase", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function AnniversaryCelebrationGiftViewBase:Init()
	AnniversaryCelebrationGiftViewBase.super.Init(self)

	self.openController = self.controllers_:GetController("open")
	self.quests = CommonActivityTaskListModule.New(self.questListGo_)
end

function AnniversaryCelebrationGiftViewBase:OnEnter()
	AnniversaryCelebrationGiftViewBase.super.OnEnter(self)

	if self.isAdvanceActivity_ then
		self.openController:SetSelectedState("false")
	else
		self.openController:SetSelectedState("true")
	end
end

function AnniversaryCelebrationGiftViewBase:OnExit()
	AnniversaryCelebrationGiftViewBase.super.OnExit(self)
end

function AnniversaryCelebrationGiftViewBase:Dispose()
	self.quests:Dispose()
	AnniversaryCelebrationGiftViewBase.super.Dispose(self)
end

function AnniversaryCelebrationGiftViewBase:GetSubTaskActivity()
	return ActivityTools.GetAllTaskSubActivityID(self.activityID_)[1]
end

function AnniversaryCelebrationGiftViewBase:Show(arg_6_1)
	AnniversaryCelebrationGiftViewBase.super.Show(self, arg_6_1)

	if self.isAdvanceActivity_ then
		return
	end

	if arg_6_1 then
		self.quests:OnEnter()
		self.quests:RenderView(self:GetSubTaskActivity())
	else
		self.quests:OnExit()
	end
end

function AnniversaryCelebrationGiftViewBase:HideRedPoint()
	if self.isAdvanceActivity_ then
		return
	end

	manager.redPoint:setTip("ANNIVERSARY_CELEBRATION_GIFT_REMIND_TASK_AVAILABLE" .. self:GetSubTaskActivity(), 0)
end

return AnniversaryCelebrationGiftViewBase
