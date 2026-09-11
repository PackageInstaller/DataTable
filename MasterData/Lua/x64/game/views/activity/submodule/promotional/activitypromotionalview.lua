ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityPromotionalView = class("ActivityPromotionalView", ActivityMainBasePanel)

function ActivityPromotionalView:GetUIName()
	return "Widget/System/Activity_Resident/Activity_HeroPubliciz/Activity_HeroPublicizMainUI"
end

function ActivityPromotionalView:Init()
	ActivityPromotionalView.super.Init(self)

	self.trailShowController_ = self.tansCon_:GetController("show1")
	self.skinShowController_ = self.tansCon_:GetController("show2")
	self.heroController_ = self.tansCon_:GetController("complete1")
	self.skinController_ = self.tansCon_:GetController("complete2")
end

function ActivityPromotionalView:OnEnter()
	ActivityPromotionalView.super.OnEnter(self)

	self.promotionalCfg_ = ActivityPromotionalCfg[self.activityID_]

	self:AddTimer()
	self:BindRedPoint()
end

function ActivityPromotionalView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.heroTrialBtn_.transform, RedPointConst.ACTIVITY_TRIAL .. ActivityPromotionalCfg[self.activityID_].hero_trial_id)
	manager.redPoint:bindUIandKey(self.heroSkinBtn_.transform, RedPointConst.ACTIVITY_TRIAL .. ActivityPromotionalCfg[self.activityID_].hero_skin_id)
end

function ActivityPromotionalView:OnExit()
	ActivityPromotionalView.super.OnExit(self)
	self:StopTimer()
	self:UnBindRedPoint()
end

function ActivityPromotionalView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.heroTrialBtn_.transform, RedPointConst.ACTIVITY_TRIAL .. ActivityPromotionalCfg[self.activityID_].hero_trial_id)
	manager.redPoint:unbindUIandKey(self.heroSkinBtn_.transform, RedPointConst.ACTIVITY_TRIAL .. ActivityPromotionalCfg[self.activityID_].hero_skin_id)
end

function ActivityPromotionalView:Dispose()
	ActivityPromotionalView.super.Dispose(self)
end

function ActivityPromotionalView:AddListeners()
	self:AddBtnListener(self.heroTrialBtn_, nil, function()
		SDKTools.SendMessageToSDK("hero_publicize_page_jump", {
			type = 1
		})
		HeroTrialData:SetSelectActivityHeroID(self.promotionalCfg_.hero_trial_navigation[3], self.promotionalCfg_.hero_trial_id)
		JumpTools.JumpToPage2(self.promotionalCfg_.hero_trial_navigation)
	end)
	self:AddBtnListener(self.heroSkinBtn_, nil, function()
		SDKTools.SendMessageToSDK("hero_publicize_page_jump", {
			type = 2
		})
		JumpTools.JumpToPage2(self.promotionalCfg_.hero_skin_navigation)
	end)
	self:AddBtnListener(self.heroDrawBtn_, nil, function()
		SDKTools.SendMessageToSDK("hero_publicize_page_jump", {
			type = 3
		})
		OperationRecorder.RecordButtonTouch("activity_hero_" .. self.activityID_)
		JumpTools.JumpToPage2(self.promotionalCfg_.hero_draw_navigation)
	end)

	while self[string.format("extraJumpBtn_%s", 1)] ~= nil do
		local var_8_0 = 1

		self:AddBtnListener(self[string.format("extraJumpBtn_%s", 1)], nil, function()
			if type(self.promotionalCfg_.extra_jump_list) == "table" and self.promotionalCfg_.extra_jump_list[var_8_0] then
				JumpTools.JumpToPage2(self.promotionalCfg_.extra_jump_list[var_8_0])
			else
				Debug.LogError(string.format("ActivityPromotionalCfg[%s]的extra_jump_list[%s]没有配", self.activityID_, var_8_0))
			end
		end)
	end
end

function ActivityPromotionalView:HideRedPoint()
	if not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_RANGE + self.activityID_) then
		RedPointAction.HandleRedPoint(RedPointConst.ACTIVITY_RANGE + self.activityID_)
		manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_), 0)
	end
end

function ActivityPromotionalView:Show(arg_14_1)
	ActivityPromotionalView.super.Show(self, arg_14_1)

	if arg_14_1 then
		self:RefreshHeroView()
		self:RefreshHeroTrialState()
		self:RefreshHeroSkinState()
	end
end

function ActivityPromotionalView:RefreshHeroView()
	local var_15_0 = Asset.Load(self.promotionalCfg_.background)

	if not isNil(var_15_0) and not self.bgGo_ then
		self.bgGo_ = GameObject.Instantiate(var_15_0, self.bgContent_, false)
	end

	self.imgRace_.sprite = HeroTools.GetHeroRaceIcon(self.promotionalCfg_.hero_id)
	self.textName_.text = HeroTools.GetHeroFullName(self.promotionalCfg_.hero_id)
end

function ActivityPromotionalView:RefreshHeroTrialState()
	local var_16_0 = self.promotionalCfg_.hero_trial_id

	if self.promotionalCfg_.hero_trial_id then
		local var_16_1 = HeroTrialData:GetHeroTrialStateList()[var_16_0]

		self.heroController_:SetSelectedState((var_16_1 == 1 or var_16_1 == 2) and "show" or "hide")
		self.trailShowController_:SetSelectedState("on")

		if var_16_1 == 1 then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_TRIAL .. var_16_0, 1)
		else
			manager.redPoint:setTip(RedPointConst.ACTIVITY_TRIAL .. var_16_0, 0)
		end
	else
		self.trailShowController_:SetSelectedState("off")
	end
end

function ActivityPromotionalView:RefreshHeroSkinState()
	local var_17_0 = self.promotionalCfg_.hero_skin_id
	local var_17_1 = SkinTrialData:GetSkinTrialStatus(self.promotionalCfg_.hero_skin_id)

	if self.promotionalCfg_.hero_skin_id and var_17_0 ~= 0 then
		self.skinController_:SetSelectedState((var_17_1 == 1 or var_17_1 == 2) and "show" or "hide")
		self.skinShowController_:SetSelectedState("on")

		if var_17_1 == 2 then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_TRIAL .. var_17_0, 1)
		else
			manager.redPoint:setTip(RedPointConst.ACTIVITY_TRIAL .. var_17_0, 0)
		end
	else
		self.skinShowController_:SetSelectedState("off")
	end
end

function ActivityPromotionalView:RefreshTime()
	local var_18_0 = manager.time:GetServerTime()

	self.timeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(self.activityID_).stopTime, true)
end

function ActivityPromotionalView:AddTimer()
	self:StopTimer()
	self:RefreshTime()

	self.timer_ = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.timer_:Start()
end

function ActivityPromotionalView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ActivityPromotionalView
