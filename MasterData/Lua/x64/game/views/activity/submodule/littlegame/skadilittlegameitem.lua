local SkadiLittleGameItem = class("SkadiLittleGameItem", ReduxView)

function SkadiLittleGameItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chapterID_ = arg_1_2
	self.activityID_ = arg_1_3

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
	self.starController_ = ControllerUtil.GetController(self.starsGo_.transform, "name")
end

function SkadiLittleGameItem:OnEnter()
	self.name1Text_.text = GetI18NText(ActivityCrossWaveCfg[self.chapterID_].name)
	self.name2Text_.text = GetI18NText(ActivityCrossWaveCfg[self.chapterID_].name)

	self:AddTimer()
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.LEVIATHAN_GAME, ActivityConst.LEVIATHAN_GAME, self.activityID_))
end

function SkadiLittleGameItem:OnExit()
	self:StopTimer()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.LEVIATHAN_GAME, ActivityConst.LEVIATHAN_GAME, self.activityID_))
end

function SkadiLittleGameItem:Dispose()
	self.transform_ = nil
	self.gameObject_ = nil

	SkadiLittleGameItem.super.Dispose(self)
end

function SkadiLittleGameItem:AddListeners()
	self:AddBtnListener(self.btnBtn_, nil, function()
		local var_6_0

		if manager.time:GetServerTime() < self:GetOpenTimestamp() then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self:GetOpenTimestamp())))

			do return end

			var_6_0 = {
				activityID = self.activityID_,
				chapterID = self.chapterID_
			}
		end

		var_6_0.section = ActivityCrossWaveCfg[self.chapterID_].stage_id
		var_6_0.sectionType = BattleConst.STAGE_TYPE_NEW.SKADI_GAME

		self:Go("skadiSectionInfo", var_6_0)
	end)
end

function SkadiLittleGameItem:GetOpenTimestamp()
	return ActivityData:GetActivityData(self.chapterID_).startTime or 0
end

function SkadiLittleGameItem:GetStopTimestamp()
	return ActivityData:GetActivityData(self.chapterID_).stop_time
end

function SkadiLittleGameItem:AddTimer()
	self:RefreshState()

	local var_9_0 = manager.time:GetServerTime() - self:GetOpenTimestamp()

	if var_9_0 >= 0 then
		return
	end

	self.countdownText_.text = string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(self:GetOpenTimestamp())))

	self:StopTimer()

	self.timer_ = Timer.New(function()
		var_9_0 = manager.time:GetServerTime() - self:GetOpenTimestamp()

		self:RefreshState()

		self.countdownText_.text = string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(self:GetOpenTimestamp())))

		if var_9_0 >= 0 then
			self:StopTimer()
		end
	end, 1, -1)

	self.timer_:Start()
end

function SkadiLittleGameItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SkadiLittleGameItem:RefreshState()
	if manager.time:GetServerTime() < self:GetOpenTimestamp() then
		self.controller_:SetSelectedState("close")

		return
	end

	self.starController_:SetSelectedState((table.length(SummerLittleGameData:GetSkadiStars(self.chapterID_))))

	if manager.time:GetServerTime() >= self:GetOpenTimestamp() then
		self.controller_:SetSelectedState("normal")

		return
	end
end

function SkadiLittleGameItem:IsOpen()
	if manager.time:GetServerTime() >= self:GetOpenTimestamp() then
		return true
	end

	return false
end

return SkadiLittleGameItem
