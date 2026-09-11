local ActivityInfinityPoolCfg = class("ActivityInfinityPoolCfg", ReduxView)

function ActivityInfinityPoolCfg:GetAssetName()
	return "UI/VersionUI/OsirisUI/OsirisUIInfinitypoolUI"
end

function ActivityInfinityPoolCfg:GetInfinityPoolItem()
	return ActivityInfinityPoolBaseItem
end

function ActivityInfinityPoolCfg:ClickRewardPreview()
	JumpTools.OpenPageByJump("osirisRewardPreview", {
		poolID = self.poolID_
	})
end

function ActivityInfinityPoolCfg:Ctor(arg_4_1, arg_4_2)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:GetAssetName()), arg_4_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.activityID_ = arg_4_2
	self.lotteryItemList_ = {}
	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
	self.rewardController_ = ControllerUtil.GetController(self.goMainReward_.transform, "name")
	self.openCoreItemHandler_ = handler(self, self.OpenCoreItem)

	self:OnEnter()
end

function ActivityInfinityPoolCfg:OnEnter()
	manager.notify:RegistListener(OSIRIS_INFINITY_OPEN_CORE_ITEM, self.openCoreItemHandler_)

	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:AddTimer()

	self.leftTime_.text = GetTips("REMAINING_TIME")
end

function ActivityInfinityPoolCfg:OnExit()
	manager.notify:RemoveListener(OSIRIS_INFINITY_OPEN_CORE_ITEM, self.openCoreItemHandler_)
	self:StopTimer()
end

function ActivityInfinityPoolCfg:Dispose()
	ActivityInfinityPoolCfg.super.Dispose(self)

	self.openCoreItemHandler_ = nil

	for iter_7_0, iter_7_1 in pairs(self.lotteryItemList_) do
		iter_7_1:Dispose()
	end

	self.lotteryItemList_ = nil

	if self.mainRewardItem_ then
		self.mainRewardItem_:Dispose()

		self.mainRewardItem_ = nil
	end

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ActivityInfinityPoolCfg:AddListeners()
	self:AddBtnListener(self.btnRewardView_, nil, function()
		self:ClickRewardPreview()
	end)
	self:AddBtnListener(self.btnReset_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("RESET_INFINITY"),
			OkCallback = function()
				OsirisAction.ResetPool(self.poolID_, function(arg_12_0)
					if isSuccess(arg_12_0.result) then
						self:RefreshUI()
					else
						ShowTips(arg_12_0.result)
					end
				end)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListener(self.unresetBtn_, nil, function()
		ShowTips("UNLOCK_INFINITY_RESET_TIPS")
	end)
end

function ActivityInfinityPoolCfg:SetPhase(arg_15_1)
	if self.phase_ == arg_15_1 then
		return
	end

	self.phase_ = arg_15_1

	self:RefreshUI()
end

function ActivityInfinityPoolCfg:RefreshUI()
	self.poolID_ = ActivityInfinityPoolCfg.get_id_list_by_activity_id[self.activityID_][self.phase_]

	local var_16_0 = OsirisInfinityPoolData:GetPoolData(ActivityInfinityPoolCfg.get_id_list_by_activity_id[self.activityID_][self.phase_])
	local var_16_1 = #var_16_0.itemList

	if var_16_0.coreItem then
		var_16_1 = var_16_1 + 1
	end

	for iter_16_0 = 1, var_16_1 do
		if self.lotteryItemList_[iter_16_0] == nil then
			self.lotteryItemList_[iter_16_0] = self:GetInfinityPoolItem().New(self.goItem_, self.goItemParent_)
		end

		self.lotteryItemList_[iter_16_0]:SetData(ActivityInfinityPoolCfg.get_id_list_by_activity_id[self.activityID_][self.phase_], iter_16_0)
	end

	for iter_16_1 = #self.lotteryItemList_, var_16_1 + 1, -1 do
		self.lotteryItemList_[iter_16_1]:Show(false)
	end

	self.phase_ = self.phase_

	self:RefreshCoreItem()
end

function ActivityInfinityPoolCfg:RefreshCoreItem()
	local var_17_0 = OsirisInfinityPoolData:GetPoolData(ActivityInfinityPoolCfg.get_id_list_by_activity_id[self.activityID_][self.phase_])

	if self.phase_ == #ActivityInfinityPoolCfg.get_id_list_by_activity_id[self.activityID_] == false then
		self.controller_:SetSelectedState("false")

		self.canReset_ = false
	elseif table.length(var_17_0.openBoxList) < #var_17_0.itemList then
		self.controller_:SetSelectedState("noreset")

		self.canReset_ = false
	else
		self.controller_:SetSelectedState("true")

		self.canReset_ = true
	end

	if var_17_0.isOpenCoreItem then
		self.rewardController_:SetSelectedState("get")
	else
		self.rewardController_:SetSelectedState("normal")
	end

	self:RefreshMainReward(var_17_0.coreItem)
end

function ActivityInfinityPoolCfg:RefreshMainReward(arg_18_1)
	if arg_18_1 == nil then
		return
	end

	if arg_18_1[1] == 0 then
		return
	end

	if self.mainRewardItem_ == nil then
		self.mainRewardItem_ = self:GetRewardItem(arg_18_1)
	else
		self.mainRewardItem_:SetData(arg_18_1)
	end
end

function ActivityInfinityPoolCfg:GetRewardItem(arg_19_1)
	return RewardPoolItem.New(self.goMainReward_, arg_19_1)
end

function ActivityInfinityPoolCfg:Show(arg_20_1)
	if arg_20_1 == false then
		self.phase_ = nil
	end

	if self.gameObject_.activeSelf == arg_20_1 then
		return
	end

	SetActive(self.gameObject_, arg_20_1)
end

function ActivityInfinityPoolCfg:OpenCoreItem()
	self:RefreshCoreItem()
end

function ActivityInfinityPoolCfg:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		return
	end

	self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.textTime_.text = GetTips("TIME_OVER")

			return
		end

		self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function ActivityInfinityPoolCfg:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ActivityInfinityPoolCfg
