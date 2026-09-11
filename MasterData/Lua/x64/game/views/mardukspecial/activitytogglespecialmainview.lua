local ActivityToggleSpecialMainView = class("ActivityToggleSpecialMainView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))
local var_0_1 = "MARDUK_SPECIAL_NOTE_1"

function ActivityToggleSpecialMainView:GetUIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdEscortUI/XH3rdEscortUI"
end

function ActivityToggleSpecialMainView:Init()
	self.items_ = {}

	self:InitUI()
	self:AddUIListener()
end

function ActivityToggleSpecialMainView:InitUI()
	self:BindCfgUI()

	self.rankLockController_ = ControllerUtil.GetController(self.rankBtn_.transform, "rankLock")
end

function ActivityToggleSpecialMainView:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("activityToggleSpecialRewardView", {
			activityId = self.activityID_
		})
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		local var_6_0

		if not self.rankOpen_ then
			do return end

			var_6_0 = {
				activityId = self.activityID_
			}
		end

		var_6_0.subActivityId = self.activityIds_[self.curIndex_]

		JumpTools.OpenPageByJump("/mardukSpecialRank", var_6_0)
	end)
	self:AddBtnListener(self.tipsBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips(var_0_1),
			key = var_0_1
		})
	end)
end

function ActivityToggleSpecialMainView:OnTop()
	self:UpdateBar()
end

function ActivityToggleSpecialMainView:OnEnter()
	ActivityToggleSpecialMainView.super.OnEnter(self)

	self.activityIds_ = ActivityCfg[self.activityID_].sub_activity_list

	for iter_9_0, iter_9_1 in ipairs(self.activityIds_) do
		self.items_[iter_9_0] = self.items_[iter_9_0] or self:CreateItem(iter_9_0)

		self.items_[iter_9_0]:SetData(iter_9_0, self.activityID_, iter_9_1)
		self.items_[iter_9_0]:OnEnter()
	end

	manager.redPoint:bindUIandKey(self.rewardbtntrans_, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.ACTIVITY_2_2_SPECIAL))
	self:StartMyTimer()
	self:UpdateTimer()
end

function ActivityToggleSpecialMainView:OnExit()
	ActivityToggleSpecialMainView.super.OnExit(self)

	self.curIndex_ = nil

	for iter_10_0, iter_10_1 in pairs(self.items_) do
		iter_10_1:OnExit()
	end

	AnimatorTools.Stop()
	self:StopMyTimer()
	manager.redPoint:unbindUIandKey(self.rewardbtntrans_, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.ACTIVITY_2_2_SPECIAL))
	manager.windowBar:HideBar()
end

function ActivityToggleSpecialMainView:StartMyTimer()
	if self.mytimer_ == nil then
		self.mytimer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.mytimer_:Start()
end

function ActivityToggleSpecialMainView:StopMyTimer()
	if self.mytimer_ then
		self.mytimer_:Stop()

		self.mytimer_ = nil
	end
end

function ActivityToggleSpecialMainView:CreateItem(arg_14_1)
	local var_14_0 = ActivityToggleSpecialItem.New(self["item" .. arg_14_1 .. "Go_"])

	var_14_0:SetItemSelectHandler(handler(self, self.OnNodeSelect))

	return var_14_0
end

function ActivityToggleSpecialMainView:OnNodeSelect(arg_15_1, arg_15_2)
	if not arg_15_2 then
		self.items_[self.curIndex_]:ShowSelect(false)

		self.curIndex_ = nil

		self:UpdateView()

		return
	end

	if self.curIndex_ ~= nil and arg_15_1 == self.curIndex_ then
		return
	end

	self:SetSelect(arg_15_1)
end

function ActivityToggleSpecialMainView:SetSelect(arg_16_1)
	if self.curIndex_ then
		self.items_[self.curIndex_]:ShowSelect(false)
	end

	self.curIndex_ = arg_16_1

	if self.curIndex_ then
		self:ScrollToItem(arg_16_1)
	end

	self.items_[arg_16_1]:ShowSelect(true)
	self:UpdateView()
end

function ActivityToggleSpecialMainView:ScrollToItem(arg_17_1)
	local var_17_0 = 0 + 140 * (arg_17_1 - 1) + 470 / 2 - self.scrollViewTransform_.rect.height / 2

	if 0 + 140 * (arg_17_1 - 1) + 470 / 2 - self.scrollViewTransform_.rect.height / 2 < 0 then
		var_17_0 = 0
	end

	if var_17_0 > self.container_.rect.width + 470 / 2 then
		var_17_0 = self.container_.rect.width + 470 / 2
	end

	self.container_.localPosition.y = var_17_0

	LeanTween.moveLocalY(self.container_.gameObject, var_17_0, 0.2)
end

function ActivityToggleSpecialMainView:UpdateView()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contenttrans_)

	self.lastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(self.activityID_).stopTime)
end

function ActivityToggleSpecialMainView:UpdateTimer()
	local var_19_0 = false
	local var_19_1 = 0

	for iter_19_0, iter_19_1 in ipairs(self.activityIds_) do
		if #ActivityCfg[iter_19_1].sub_activity_list > 0 then
			if var_19_1 == 0 then
				var_19_1 = iter_19_1
			end

			if ActivityData:GetActivityIsOpen(iter_19_1) then
				var_19_0 = true

				break
			end
		end
	end

	self.rankOpen_ = var_19_0

	if var_19_0 then
		self.rankLockController_:SetSelectedState("false")
	else
		self.rankLockController_:SetSelectedState("true")

		local var_19_2 = ActivityData:GetActivityData(var_19_1).stopTime

		self.timeLabel_.text = ActivityData:GetActivityData(var_19_1).stopTime < manager.time:GetServerTime() and GetTips("TIME_OVER") or string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(var_19_1).startTime)))
	end

	local var_19_3 = ActivityData:GetActivityData(self.activityID_).stopTime

	self.lastTimeLabel_.text = var_19_3 > manager.time:GetServerTime() and manager.time:GetLostTimeStrWith2Unit(var_19_3) or GetTips("TIME_OVER")

	for iter_19_2, iter_19_3 in pairs(self.items_) do
		iter_19_3:UpdateTime()
	end
end

function ActivityToggleSpecialMainView:Dispose()
	if self.items_ then
		for iter_20_0, iter_20_1 in pairs(self.items_) do
			iter_20_1:Dispose()
		end

		self.items_ = nil
	end

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.activityOpenHandler_ = nil

	ActivityToggleSpecialMainView.super.Dispose(self)
end

return ActivityToggleSpecialMainView
