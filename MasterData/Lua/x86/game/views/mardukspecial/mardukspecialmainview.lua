local MardukSpecialMainView = class("MardukSpecialMainView", ReduxView)

function MardukSpecialMainView:UIName()
	return "UI/MardukUI/special/MardukSpecialUI"
end

function MardukSpecialMainView:UIParent()
	return manager.ui.uiMain.transform
end

function MardukSpecialMainView:OnCtor()
	return
end

function MardukSpecialMainView:Init()
	self.items_ = {}

	self:InitUI()
	self:AddUIListener()
end

function MardukSpecialMainView:InitUI()
	self:BindCfgUI()

	self.rankLockController_ = ControllerUtil.GetController(self.rankBtn_.transform, "rankLock")
end

function MardukSpecialMainView:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("mardukSpecialReward", {
			activityID = self.params_.activityID
		})
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		local var_8_0

		if not self.rankOpen_ then
			do return end

			var_8_0 = {
				activityID = self.params_.activityID
			}
		end

		var_8_0.subActivityId = self.activityIds_[self.curIndex_]

		JumpTools.OpenPageByJump("/mardukSpecialRank", var_8_0)
	end)
end

function MardukSpecialMainView:AddEventListeners()
	return
end

function MardukSpecialMainView:OnTop()
	self:UpdateBar()
end

function MardukSpecialMainView:OnBehind()
	manager.windowBar:HideBar()
end

function MardukSpecialMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("MARDUK_SPECIAL_NOTE")
end

function MardukSpecialMainView:OnEnter()
	self:AddEventListeners()

	self.activityIds_ = ActivityCfg[self.params_.activityID].sub_activity_list

	for iter_13_0, iter_13_1 in ipairs(self.activityIds_) do
		self.items_[iter_13_0] = self.items_[iter_13_0] or self:CreateItem(iter_13_0)

		self.items_[iter_13_0]:SetData(iter_13_0, self.params_.activityID, iter_13_1)
	end

	manager.redPoint:bindUIandKey(self.rewardbtntrans_, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.FACTORY_MARDUK))
	self:StartTimer()
	self:UpdateTimer()
end

function MardukSpecialMainView:OnExit()
	AnimatorTools.Stop()
	self:StopTimer()
	self:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(self.rewardbtntrans_, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.FACTORY_MARDUK))
	manager.windowBar:HideBar()
end

function MardukSpecialMainView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
end

function MardukSpecialMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function MardukSpecialMainView:CreateItem(arg_18_1)
	local var_18_0 = MardukSpecialItemView.New(self["item" .. arg_18_1 .. "Go_"])

	var_18_0:SetItemSelectHandler(handler(self, self.OnNodeSelect))

	return var_18_0
end

function MardukSpecialMainView:OnNodeSelect(arg_19_1, arg_19_2)
	if not arg_19_2 then
		self.items_[self.curIndex_]:ShowSelect(false)

		self.curIndex_ = nil

		self:UpdateView()

		return
	end

	if self.curIndex_ ~= nil and arg_19_1 == self.curIndex_ then
		return
	end

	self:SetSelect(arg_19_1)
end

function MardukSpecialMainView:SetSelect(arg_20_1)
	if self.curIndex_ then
		self.items_[self.curIndex_]:ShowSelect(false)
	end

	self.curIndex_ = arg_20_1

	if self.curIndex_ then
		self:ScrollToItem(arg_20_1)
	end

	self:UpdateView()
end

function MardukSpecialMainView:ScrollToItem(arg_21_1)
	local var_21_1 = 21 + 491 * (arg_21_1 - 1) + 1091 / 2 - self.scrollViewTransform_.rect.width / 2

	if 21 + 491 * (arg_21_1 - 1) + 1091 / 2 - self.scrollViewTransform_.rect.width / 2 < 0 then
		var_21_1 = 0
	end

	self.container_.localPosition.x = -var_21_1

	LeanTween.moveLocalX(self.container_.gameObject, -var_21_1, 0.2)
	self.items_[arg_21_1]:ShowSelect(true)
end

function MardukSpecialMainView:UpdateView()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contenttrans_)

	self.lastTimeLabel_.text = manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.params_.activityID).stopTime)
end

function MardukSpecialMainView:UpdateTimer()
	local var_23_0 = false
	local var_23_1 = 0

	for iter_23_0, iter_23_1 in ipairs(self.activityIds_) do
		if #ActivityCfg[iter_23_1].sub_activity_list > 0 then
			if var_23_1 == 0 then
				var_23_1 = iter_23_1
			end

			if ActivityData:GetActivityIsOpen(iter_23_1) then
				var_23_0 = true

				break
			end
		end
	end

	self.rankOpen_ = var_23_0

	if var_23_0 then
		self.rankLockController_:SetSelectedState("false")
	else
		self.rankLockController_:SetSelectedState("true")

		local var_23_2 = ActivityData:GetActivityData(var_23_1).stopTime

		self.timeLabel_.text = ActivityData:GetActivityData(var_23_1).stopTime < manager.time:GetServerTime() and GetTips("TIME_OVER") or string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(var_23_1).startTime)))
	end

	local var_23_3 = ActivityData:GetActivityData(self.params_.activityID).stopTime

	self.lastTimeLabel_.text = var_23_3 > manager.time:GetServerTime() and manager.time:GetLostTimeStr(var_23_3) or GetTips("TIME_OVER")

	for iter_23_2, iter_23_3 in pairs(self.items_) do
		iter_23_3:UpdateTime()
	end
end

function MardukSpecialMainView:OnMainHomeViewTop()
	return
end

function MardukSpecialMainView:Dispose()
	if self.items_ then
		for iter_25_0, iter_25_1 in pairs(self.items_) do
			iter_25_1:Dispose()
		end

		self.items_ = nil
	end

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	MardukSpecialMainView.super.Dispose(self)
end

return MardukSpecialMainView
