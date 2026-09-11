local ActivitySubmoduleItem = class("ActivitySubmoduleItem", ReduxView)
local var_0_1 = {
	ScarcattyBtn = "Summer_btn_00094",
	PTBtn = "Summer_btn_00093",
	frontierBtn = "Summer_btn_00010",
	onlineBtn = "Summer_btn_00008",
	challengedBtn = "Summer_btn_00009",
	plotBtn = "Summer_btn_00007",
	artifactBtn = "Summer_btn_00011"
}

function ActivitySubmoduleItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.activityId_ = ActivityTools.GetReprintActivityID(arg_1_2)
	self.clickHandler_ = arg_1_3

	self:InitUI()
end

function ActivitySubmoduleItem:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "lock")
	self.updateHandler_ = handler(self, self.UpdateActivity)
end

function ActivitySubmoduleItem:OnEnter()
	self.activiteData_ = ActivityData:GetActivityData(self.activityId_)
	self.startTime_ = self.activiteData_.startTime
	self.stopTime_ = self.activiteData_.stopTime

	if manager.time:GetServerTime() > self.stopTime_ then
		if self.activityId_ == ActivityConst.SIKADI_GAME then
			SummerLittleGameAction.InitSkadiRedPoint()
		elseif self.activityId_ == ActivityConst.LEVIATHAN_GAME then
			SummerLittleGameAction.InitLeviathanRedPoint()
		end
	end

	self:BindRedPoint()
	manager.notify:RegistListener(ACTIVITY_UPDATE, self.updateHandler_)
	self:RefreshUI()
	self:AddTimer()
end

function ActivitySubmoduleItem:OnExit()
	self:UnBindRedPoint()
	manager.notify:RemoveListener(ACTIVITY_UPDATE, self.updateHandler_)
	self:StopTimer()
end

function ActivitySubmoduleItem:Dispose()
	ActivitySubmoduleItem.super.Dispose(self)

	self.updateHandler_ = nil
end

function ActivitySubmoduleItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if manager.time:GetServerTime() < self.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_)))

			return
		end

		if manager.time:GetServerTime() >= self.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		if self.clickHandler_ ~= nil then
			self.clickHandler_()

			return
		end

		ActivityTools.JumpToSubmodulePage(self.activityId_)
	end)
end

function ActivitySubmoduleItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.transform_, ActivityTools.GetRedPointKey(self.activityId_) .. self.activityId_)
end

function ActivitySubmoduleItem:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.transform_, ActivityTools.GetRedPointKey(self.activityId_) .. self.activityId_)
end

function ActivitySubmoduleItem:RefreshUI()
	if self.nameText_ then
		self.nameText_.text = ActivityCfg[self.activityId_].remark
	end
end

function ActivitySubmoduleItem:RefreshLock()
	if self.controller_ then
		if manager.time:GetServerTime() >= self.stopTime_ then
			self.controller_:SetSelectedState("end")
		else
			self.controller_:SetSelectedState(tostring(manager.time:GetServerTime() < self.startTime_))
		end
	end

	if self.bgImg_ then
		self.bgImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SummerUI/" .. var_0_1[self.gameObject_.name])
	end

	if self.textTime_ then
		self.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(self.startTime_, "!%m.%d"), manager.time:STimeDescS(self.stopTime_, "!%m.%d"))
	end
end

function ActivitySubmoduleItem:UpdateActivity(arg_12_1)
	if self.activityId_ == arg_12_1 then
		self.activiteData_ = ActivityData:GetActivityData(self.activityId_)
		self.startTime_ = self.activiteData_.startTime
		self.stopTime_ = self.activiteData_.stopTime

		self:AddTimer()
	end
end

function ActivitySubmoduleItem:AddTimer()
	self:StopTimer()
	self:RefreshLock()

	local var_13_0 = manager.time:GetServerTime() < self.startTime_

	self.timer_ = Timer.New(function()
		local var_14_0 = manager.time:GetServerTime()

		if var_13_0 and var_14_0 > self.startTime_ then
			self:RefreshLock()

			var_13_0 = false
		elseif var_14_0 >= self.stopTime_ then
			self:RefreshLock()
			self:StopTimer()
		end
	end, 1, -1)

	self.timer_:Start()
end

function ActivitySubmoduleItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ActivitySubmoduleItem
