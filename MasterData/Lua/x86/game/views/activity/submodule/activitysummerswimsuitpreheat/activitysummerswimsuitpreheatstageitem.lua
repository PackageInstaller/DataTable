local ActivitySummerSwimsuitPreheatStageItem = class("ActivitySummerSwimsuitPreheatStageItem", ReduxView)

function ActivitySummerSwimsuitPreheatStageItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function ActivitySummerSwimsuitPreheatStageItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.conEx_:GetController("state")
end

function ActivitySummerSwimsuitPreheatStageItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.onClickHandler_ then
			self.onClickHandler_(self.cfgId_)
		end
	end)
end

function ActivitySummerSwimsuitPreheatStageItem:SetClickHandler(arg_5_1)
	if arg_5_1 then
		self.onClickHandler_ = arg_5_1
	end
end

function ActivitySummerSwimsuitPreheatStageItem:SetData(arg_6_1, arg_6_2)
	self.cfgId_ = arg_6_1
	self.index_ = arg_6_2
end

function ActivitySummerSwimsuitPreheatStageItem:RefreshUI()
	local var_7_0 = ActivitySummerSwimsuitPreheatCfg[self.cfgId_]
	local var_7_1 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(ActivitySummerSwimsuitPreheatCfg[self.cfgId_])
	local var_7_2 = ActivityData:GetActivityData(ActivitySummerSwimsuitPreheatCfg[self.cfgId_].activity_id)

	if not var_7_2:IsActivitying() then
		self.stateController_:SetSelectedState("lock")

		self.lockText_.text = GetTipsF("ACTIVITY_SUMMER_SWIMSUIT_PREHEAT_LOCK_DAY", manager.time:DiffDay2(manager.time:GetServerTime(), var_7_2.startTime) + 1)
	elseif ActivitySummerSwimsuitPreheatData.IsStageClear(var_7_1, var_7_0.id) then
		self.stateController_:SetSelectedState(ActivitySummerSwimsuitPreheatData.IsGotStageReward(var_7_1, var_7_0.id) and "finished" or "finished&award")
	else
		self.stateController_:SetSelectedState("unfinished")
	end

	self.img_.sprite = ActivitySummerSwimsuitPreheatTools.GetCfgStageImage(var_7_0)
end

function ActivitySummerSwimsuitPreheatStageItem:BindRedPoint(arg_8_1)
	local var_8_0 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(ActivitySummerSwimsuitPreheatCfg[self.cfgId_])
	local var_8_1 = string.format("%s_%d_%s", RedPointConst.ACTIVITY_SUMMER_SWIMSUIT_PREHEAT_STAGE, ActivitySummerSwimsuitPreheatCfg[self.cfgId_].id, ActivityTools.GetRedPointKey(var_8_0) .. var_8_0)

	if arg_8_1 then
		manager.redPoint:bindUIandKey(self.btn_.transform, var_8_1)
	else
		manager.redPoint:unbindUIandKey(self.btn_.transform, var_8_1)
	end
end

function ActivitySummerSwimsuitPreheatStageItem:Dispose()
	ActivitySummerSwimsuitPreheatStageItem.super.Dispose(self)
end

return ActivitySummerSwimsuitPreheatStageItem
