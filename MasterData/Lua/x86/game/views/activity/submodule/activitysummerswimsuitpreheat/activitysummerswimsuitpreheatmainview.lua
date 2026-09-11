local ActivitySummerSwimsuitPreheatMainView = class("ActivitySummerSwimsuitPreheatMainView", ReduxView)

function ActivitySummerSwimsuitPreheatMainView:UIName()
	return "Widget/Version/Alone_SummerUI_PreheatUI/Alone_SummerUI_PreheatUI"
end

function ActivitySummerSwimsuitPreheatMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivitySummerSwimsuitPreheatMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivitySummerSwimsuitPreheatMainView:InitUI()
	self:BindCfgUI()

	self.stageItemList_ = {}

	for iter_4_0 = 1, 6 do
		table.insert(self.stageItemList_, (ActivitySummerSwimsuitPreheatStageItem.New(self["stageItemGo_" .. iter_4_0])))
	end

	self.stateController_ = self.conEx_:GetController("state")
end

function ActivitySummerSwimsuitPreheatMainView:AddUIListener()
	for iter_5_0, iter_5_1 in ipairs(self.stageItemList_) do
		iter_5_1:SetClickHandler(function(arg_6_0)
			self:OnClickStage(iter_5_0, arg_6_0)
		end)
	end
end

function ActivitySummerSwimsuitPreheatMainView:OnEnter()
	self.activityID_ = self.params_.activityID

	local var_7_0 = ActivityData:GetActivityData(self.activityID_)

	self.startTime_ = var_7_0.startTime
	self.stopTime_ = var_7_0.stopTime

	self:RefreshUI()

	for iter_7_0, iter_7_1 in ipairs(self.stageItemList_) do
		iter_7_1:BindRedPoint(true)
	end
end

function ActivitySummerSwimsuitPreheatMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshUI()
	self:AddTimer()
end

function ActivitySummerSwimsuitPreheatMainView:OnBehind()
	manager.windowBar:HideBar()
	self:StopTimer()
end

function ActivitySummerSwimsuitPreheatMainView:OnExit()
	for iter_10_0, iter_10_1 in ipairs(self.stageItemList_) do
		iter_10_1:BindRedPoint(false)
	end
end

function ActivitySummerSwimsuitPreheatMainView:OnActivitySummerSwimsuitPreheatInit()
	self:RefreshUI()

	for iter_11_0, iter_11_1 in ipairs(self.stageItemList_) do
		iter_11_1:BindRedPoint(true)
	end
end

function ActivitySummerSwimsuitPreheatMainView:RefreshUI()
	local var_12_0 = ActivitySummerSwimsuitPreheatTools.GetCfgIdList(self.activityID_)

	for iter_12_0, iter_12_1 in ipairs(self.stageItemList_) do
		local var_12_1

		if #var_12_0 < iter_12_0 then
			var_12_1 = var_12_0[#var_12_0]

			Debug.LogError(string.format("ActivitySummerSwimsuitPreheatCfg(%d) has no config of index %d", self.activityID_, iter_12_0))
		else
			var_12_1 = var_12_0[iter_12_0]
		end

		iter_12_1:SetData(var_12_1, iter_12_0)
		iter_12_1:RefreshUI()
	end

	local var_12_2 = true

	for iter_12_2, iter_12_3 in ipairs(var_12_0) do
		if not ActivitySummerSwimsuitPreheatData.IsStageClear(self.activityID_, iter_12_3) then
			var_12_2 = false

			break
		end
	end

	self.stateController_:SetSelectedState(var_12_2 and "allClear" or "normal")
end

function ActivitySummerSwimsuitPreheatMainView:OnClickStage(arg_13_1, arg_13_2)
	local var_13_0

	if not ActivityData:GetActivityIsOpen(ActivitySummerSwimsuitPreheatCfg[arg_13_2].activity_id) then
		do return end

		var_13_0 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(ActivitySummerSwimsuitPreheatCfg[arg_13_2])
	end

	ActivitySummerSwimsuitPreheatAction.BanRedPoint(var_13_0, (string.format("%s_%d_%s", RedPointConst.ACTIVITY_SUMMER_SWIMSUIT_PREHEAT_STAGE, ActivitySummerSwimsuitPreheatCfg[arg_13_2].id, ActivityTools.GetRedPointKey(var_13_0) .. var_13_0)))
	JumpTools.OpenPageByJump("activitySummerSwimsuitPreheatStage", {
		cfgId = arg_13_2
	})
end

function ActivitySummerSwimsuitPreheatMainView:AddTimer()
	self:StopTimer()
	self:RefreshTimeText()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.stopTime_ then
			return
		end

		self:RefreshTimeText()
	end, 1, -1)

	self.timer_:Start()
end

function ActivitySummerSwimsuitPreheatMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivitySummerSwimsuitPreheatMainView:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = not ActivityData:GetActivityIsOpen(self.activityID_) and GetTips("TIME_OUT") or manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
	end
end

function ActivitySummerSwimsuitPreheatMainView:Dispose()
	self:StopTimer()

	for iter_18_0, iter_18_1 in ipairs(self.stageItemList_) do
		iter_18_1:Dispose()
	end

	ActivitySummerSwimsuitPreheatMainView.super.Dispose(self)
end

return ActivitySummerSwimsuitPreheatMainView
