local OsirisMainView = class("OsirisMainView", ReduxView)

function OsirisMainView:UIName()
	return "UI/VersionUI/OsirisUI/OsirisUIHomeUI"
end

function OsirisMainView:UIParent()
	return manager.ui.uiMain.transform
end

function OsirisMainView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.mainStageBtnList_ = {
		OsirisMainStageView.New(self.goStory_, BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY),
		OsirisMainStageView.New(self.goChess_, BattleConst.STAGE_TYPE_NEW.OSIRIS_CHESS),
		OsirisMainStageView.New(self.goChallenge_, BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON),
		OsirisMainStageView.New(self.goSimulator_, BattleConst.STAGE_TYPE_NEW.RACE_TRIAL)
	}
end

function OsirisMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.redPoint:bindUIandKey(self.transformTask_, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.OSIRIS_TASK_DAILY))
	manager.redPoint:bindUIandKey(self.transformTrial_, string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.OSIRIS_HERO_TRIAL_STAGE))
	manager.redPoint:bindUIandKey(self.transformSkinTrial_, string.format("%s_%s", RedPointConst.SKIN_TRIAL, ActivityConst.OSIRIS_SKIN_TRIAL_STAGE))

	local var_4_0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_ACTIVITY)

	self.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(var_4_0.startTime, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(var_4_0.stopTime, "!%Y.%m.%d %H:%M"))

	for iter_4_0, iter_4_1 in pairs(self.mainStageBtnList_) do
		iter_4_1:OnEnter()
	end
end

function OsirisMainView:OnExit()
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.transformTask_, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.OSIRIS_TASK_DAILY))
	manager.redPoint:unbindUIandKey(self.transformTrial_, string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.OSIRIS_HERO_TRIAL_STAGE))
	manager.redPoint:unbindUIandKey(self.transformSkinTrial_, string.format("%s_%s", RedPointConst.SKIN_TRIAL, ActivityConst.OSIRIS_SKIN_TRIAL_STAGE))

	for iter_5_0, iter_5_1 in pairs(self.mainStageBtnList_) do
		iter_5_1:OnExit()
	end
end

function OsirisMainView:Dispose()
	OsirisMainView.super.Dispose(self)

	for iter_6_0, iter_6_1 in pairs(self.mainStageBtnList_) do
		iter_6_1:Dispose()
	end

	self.mainStageBtnList_ = nil
end

function OsirisMainView:AddListeners()
	self:AddBtnListener(self.btnStoryView_, nil, function()
		self:Go("/osirisRecall")
	end)
	self:AddBtnListener(self.btnHeroTrial_, nil, function()
		if ActivityData:GetActivityData(ActivityConst.OSIRIS_HERO_TRIAL_STAGE).stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		self:Go("/heroTrialActivity", {
			activityID = ActivityConst.OSIRIS_HERO_TRIAL_STAGE
		})
	end)
	self:AddBtnListener(self.btnGift_, nil, function()
		if ActivityData:GetActivityData(ActivityConst.OSIRIS_INFINITY_POOL).stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		self:Go("/osirisActivity", {
			activityType = OsirisConst.ACTIVITY_TYPE.TASK,
			activityTaskID = ActivityConst.OSIRIS_TASK_DAILY,
			activityInfinityID = ActivityConst.OSIRIS_INFINITY_POOL
		})
	end)
	self:AddBtnListener(self.btnSkinTrial_, nil, function()
		if ActivityData:GetActivityData(ActivityConst.OSIRIS_SKIN_TRIAL_STAGE).stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		self:Go("/skinTrialActivity", {
			activityID = ActivityConst.OSIRIS_SKIN_TRIAL_STAGE
		})
	end)
end

return OsirisMainView
