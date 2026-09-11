local OsirisMainStageView = class("OsirisMainStageView", ReduxView)

function OsirisMainStageView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.type_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function OsirisMainStageView:OnEnter()
	local var_2_0

	if self.type_ == BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY then
		var_2_0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_STROY)
	elseif self.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_CHESS then
		manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS))

		var_2_0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_CHESS)
	elseif self.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.OSIRIS_DEMON)

		var_2_0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_DEMON)
	elseif self.type_ == BattleConst.STAGE_TYPE_NEW.RACE_TRIAL then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.OSIRIS_RACE_TRIAL)

		var_2_0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_TRIAL)
	end

	self.startTime_ = var_2_0.startTime
	self.stopTime_ = var_2_0.stopTime

	self:RefreshLock()
	self:AddTimer()
end

function OsirisMainStageView:OnExit()
	if self.type_ == BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY then
		-- block empty
	elseif self.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_CHESS then
		manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS))
	elseif self.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON then
		manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.OSIRIS_DEMON)
	elseif self.type_ == BattleConst.STAGE_TYPE_NEW.RACE_TRIAL then
		manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.OSIRIS_RACE_TRIAL)
	end

	self:StopTimer()
end

function OsirisMainStageView:Dispose()
	OsirisMainStageView.super.Dispose(self)
end

function OsirisMainStageView:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if manager.time:GetServerTime() < self.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_)))

			return
		end

		if manager.time:GetServerTime() >= self.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		if self.type_ == BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY then
			self:Go("/osirisStoryStage")
		elseif self.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_CHESS then
			self:Go("/osirisChess")
		elseif self.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON then
			ActivityTools.JumpToSubmodulePage(ActivityConst.OSIRIS_DEMON)
		elseif self.type_ == BattleConst.STAGE_TYPE_NEW.RACE_TRIAL then
			self:Go("/raceTrial", {
				activityID = ActivityConst.OSIRIS_TRIAL
			})
		end
	end)
end

function OsirisMainStageView:RefreshLock()
	self.controller_:SetSelectedState(tostring(manager.time:GetServerTime() < self.startTime_))
end

function OsirisMainStageView:AddTimer()
	local var_8_0 = GetTips("OPEN_TIME")

	self.textTime_.text = string.format(var_8_0, manager.time:GetLostTimeStr(self.startTime_))
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() < self.startTime_ then
			self.textTime_.text = string.format(var_8_0, manager.time:GetLostTimeStr(self.startTime_))
		else
			self:RefreshLock()
			self:StopTimer()
		end
	end, 1, -1)

	self.timer_:Start()
end

function OsirisMainStageView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return OsirisMainStageView
