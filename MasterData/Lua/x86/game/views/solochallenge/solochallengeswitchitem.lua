local SoloChallengeSwitchItem = class("SoloChallengeSwitchItem", ReduxView)

function SoloChallengeSwitchItem:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")

	SetActive(self.gameObject_, true)
end

function SoloChallengeSwitchItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.isLock_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_)))

			return
		end

		if manager.time:GetServerTime() >= self.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		SoloChallengeData:SetSelectActivityID(self.mainActivityID_, self.activityID_)

		if self.callBack_ then
			self.callBack_()
		end
	end)
end

function SoloChallengeSwitchItem:SetActivityID(arg_4_1, arg_4_2)
	if self.activityID_ == nil then
		manager.redPoint:bindUIandKey(self.transformBtn_, (string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, arg_4_2, arg_4_1)))
	elseif self.activityID_ ~= arg_4_1 then
		manager.redPoint:unbindUIandKey(self.transformBtn_, (string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, arg_4_2, self.activityID_)))
		manager.redPoint:bindUIandKey(self.transformBtn_, (string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, arg_4_2, arg_4_1)))
	end

	self.activityID_ = arg_4_1
	self.mainActivityID_ = arg_4_2
	self.startTime_ = ActivityData:GetActivityData(self.activityID_).startTime
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime
	self.index_ = table.keyof(ActivityCfg[self.mainActivityID_].sub_activity_list, self.activityID_) or 1

	self:RefreshUI()
end

function SoloChallengeSwitchItem:RefreshUI()
	self.isLock_ = manager.time:GetServerTime() < self.startTime_

	if self.isLock_ == true then
		self.lockController_:SetSelectedState("true")

		self.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_))
	else
		self.lockController_:SetSelectedState("false")
	end

	self:RefreshImage()
	self:RefreshTitle()
	self:RefreshCompleted()
end

function SoloChallengeSwitchItem:RefreshCompleted()
	if self.completedImageGo_ ~= nil then
		local var_6_1 = SoloChallengeData:GetCompletedActivityList()

		SetActive(self.completedImageGo_, var_6_1[self.activityID_] and #var_6_1[self.activityID_] > 0)
	end
end

function SoloChallengeSwitchItem:RefreshImage()
	self.icon_.sprite = getSprite("Atlas/SummerUI", ActivitySoloChallengeCfg[self.activityID_].option_bg)
end

function SoloChallengeSwitchItem:RefreshTitle()
	self.titleText_.text = GetI18NText(ActivitySoloChallengeCfg[self.activityID_].name)
end

function SoloChallengeSwitchItem:RegisterClickListener(arg_9_1)
	self.callBack_ = arg_9_1
end

function SoloChallengeSwitchItem:OnSelect(arg_10_1)
	if self.activityID_ == arg_10_1 then
		self.selectController_:SetSelectedState("select")
	else
		self.selectController_:SetSelectedState("no")
	end
end

function SoloChallengeSwitchItem:RefreshLock()
	if self.isLock_ == false then
		return
	end

	self.isLock_ = manager.time:GetServerTime() < self.startTime_

	if self.isLock_ == true then
		self.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_))
	else
		self.lockController_:SetSelectedState("false")
	end
end

function SoloChallengeSwitchItem:UnRegisterRedPoint()
	manager.redPoint:unbindUIandKey(self.transformBtn_, (string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, self.mainActivityID_, self.activityID_)))
end

function SoloChallengeSwitchItem:Dispose()
	SoloChallengeSwitchItem.super.Dispose(self)
	self:UnRegisterRedPoint()
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
	self.selectController_ = nil
	self.lockController_ = nil
end

return SoloChallengeSwitchItem
