local ActivityPushBoxMainView = class("ActivityPushBoxMainView", ReduxView)
local var_0_1 = 2.25

function ActivityPushBoxMainView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10AnniversaryEntranceUI"
end

function ActivityPushBoxMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityPushBoxMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPushBoxMainView:InitUI()
	self:BindCfgUI()

	self.rewardPreviewTbl_ = {
		"CAKE_INDEX_REWARD_1",
		"CAKE_INDEX_REWARD_2",
		"CAKE_INDEX_REWARD_3",
		"CAKE_INDEX_REWARD_4",
		"CAKE_INDEX_REWARD_5",
		"CAKE_INDEX_REWARD_6",
		"CAKE_INDEX_REWARD_7"
	}
	self.materialPreviewTbl_ = {
		"CAKE_INDEX_MATERIAL_1",
		"CAKE_INDEX_MATERIAL_2",
		"CAKE_INDEX_MATERIAL_3",
		"CAKE_INDEX_MATERIAL_4",
		"CAKE_INDEX_MATERIAL_5",
		"CAKE_INDEX_MATERIAL_6",
		"CAKE_INDEX_MATERIAL_7"
	}
	self.cakeClip_ = {
		"00",
		"01",
		"02",
		"03",
		"04",
		"05",
		"06",
		"07"
	}
	self.materialItem_ = {}
	self.rewardItem_ = CommonItem.New(self.rewardGo_)

	self.rewardItem_:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id,
			arg_5_0.number
		})
	end)

	self.rewardCon_ = {}

	for iter_4_0, iter_4_1 in ipairs(ActivityCelebrationCakeCfg.get_id_list_by_activity_id[self.params_.activityID]) do
		self.rewardCon_[iter_4_0] = ControllerUtil.GetController(self["preRewardGo_" .. iter_4_0].transform, "state")
	end

	self.OnMaterialUpdateHandler_ = handler(self, self.OnMaterialUpdate)
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.progressCon_ = ControllerUtil.GetController(self.transform_, "progress")
	self.rewardItemCon_ = ControllerUtil.GetController(self.rewardItem_.transform_, "completed")
end

function ActivityPushBoxMainView:AddUIListeners()
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("activityPushBoxReward", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.materialBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityPushBoxMaterial", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.makeBtn_, nil, function()
		if self:IsComplete(self.curIndex_ + 1) then
			ActivityPushBoxAction.StartMaking(self.activityID_, self.curIndex_ + 1)
		end
	end)
	self:AddBtnListener(self.preViewBtn_, nil, function()
		JumpTools.OpenPageByJump("activityPushBoxRewardPre", {
			activityID = self.activityID_
		})
	end)
end

function ActivityPushBoxMainView:OnEnter()
	SetActive(self.countDownGo_, false)
	self.progressCon_:SetSelectedState(-1)

	self.activityID_ = self.params_.activityID

	manager.notify:RegistListener(MATERIAL_MODIFY, self.OnMaterialUpdateHandler_)
	self:BindRedPointUI()
	self:RefreshData()
	self:RefreshTime()
	self:RefreshUI()
	self:RefreshAni()
end

function ActivityPushBoxMainView:RefreshData()
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function ActivityPushBoxMainView:RefreshTime()
	self:StopTimer()

	local var_13_0 = manager.time:GetServerTime()

	if var_13_0 < self.startTime_ then
		self.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			if self.startTime_ <= manager.time:GetServerTime() then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_13_0 < self.stopTime_ then
		self.timeLable_.text = manager.time:GetLostTimeStr2(self.stopTime_)
		self.timer_ = Timer.New(function()
			if self.stopTime_ <= manager.time:GetServerTime() then
				self:StopTimer()
				self:RefreshTime()

				return
			end

			self.timeLable_.text = manager.time:GetLostTimeStr2(self.stopTime_)
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeLable_.text = GetTips("TIME_OVER")
	end
end

function ActivityPushBoxMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityPushBoxMainView:RefreshUI()
	self:RefreshState()
	self:RefreshMaterial()
end

function ActivityPushBoxMainView:RefreshState()
	self.curIndex_ = ActivityPushBoxData:GetCurIndex(self.activityID_)

	self.progressCon_:SetSelectedState(self.curIndex_)

	for iter_18_0 = 1, self.curIndex_ do
		self.rewardCon_[iter_18_0]:SetSelectedState("complete")
	end

	for iter_18_1 = self.curIndex_ + 2, #self.rewardCon_ do
		self.rewardCon_[iter_18_1]:SetSelectedState("uncomplete")
	end

	local var_18_0 = ActivityCelebrationCakeCfg.get_id_list_by_activity_id[self.activityID_]

	if self.curIndex_ >= #ActivityCelebrationCakeCfg.get_id_list_by_activity_id[self.activityID_] then
		self.makeBtn_.interactable = false
		self.cfg_ = ActivityCelebrationCakeCfg[var_18_0[self.curIndex_]]

		self.rewardItemCon_:SetSelectedState("true")

		self.rewardPreviewTxt_.text = GetTips(self.rewardPreviewTbl_[self.curIndex_])
		self.materialPreviewTxt_.text = GetTips(self.materialPreviewTbl_[self.curIndex_])

		self.stateCon_:SetSelectedState("finished")
	else
		local var_18_1 = self:IsComplete(self.curIndex_ + 1)

		self.rewardCon_[self.curIndex_ + 1]:SetSelectedState(var_18_1 and "current" or "uncomplete")

		self.makeBtn_.interactable = var_18_1
		self.cfg_ = ActivityCelebrationCakeCfg[var_18_0[self.curIndex_ + 1]]

		self.rewardItemCon_:SetSelectedState("false")

		self.rewardPreviewTxt_.text = GetTips(self.rewardPreviewTbl_[self.curIndex_ + 1])
		self.materialPreviewTxt_.text = GetTips(self.materialPreviewTbl_[self.curIndex_ + 1])

		self.stateCon_:SetSelectedState(self.curIndex_ == #self.rewardCon_ - 1 and "last" or "normal")
	end

	self.rewardItem_:RefreshData(formatReward(self.cfg_.award_list[1]))
end

function ActivityPushBoxMainView:IsComplete(arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(ActivityCelebrationCakeCfg[ActivityCelebrationCakeCfg.get_id_list_by_activity_id[self.activityID_][arg_19_1]].cost_list) do
		if iter_19_1[2] > ItemTools.getItemNum(iter_19_1[1]) then
			return false
		end
	end

	return true
end

function ActivityPushBoxMainView:RefreshMaterial()
	for iter_20_0, iter_20_1 in ipairs(self.cfg_.cost_list) do
		if not self.materialItem_[iter_20_0] then
			self.materialItem_[iter_20_0] = RewardItem.New(self.materialTemplate_, self.materialParent_)

			self.materialItem_[iter_20_0]:UpdateCommonItemAni()
		end

		self.materialItem_[iter_20_0]:SetData(iter_20_1)

		local var_20_0 = ItemTools.getItemNum(iter_20_1[1])

		self.materialItem_[iter_20_0].commonItem_:SetBottomText((var_20_0 < iter_20_1[2] or nil) and string.format("<color=#FF0000>%d</color>", var_20_0) .. "/" .. iter_20_1[2])
		self.materialItem_[iter_20_0].commonItem_:RegistCallBack(function()
			ShowPopItem(POP_MERGE_ITEM, iter_20_1)
		end)
	end

	for iter_20_2 = #self.cfg_.cost_list + 1, #self.materialItem_ do
		self.materialItem_[iter_20_2]:Show(false)
	end
end

function ActivityPushBoxMainView:RefreshAni()
	self.cakeAni_:Play(self.cakeClip_[self.curIndex_ + 1], -1, 1)
end

function ActivityPushBoxMainView:OnPushBoxMakeCake(arg_23_1)
	self.curIndex_ = ActivityPushBoxData:GetCurIndex(self.activityID_)

	self.cakeAni_:Play(self.cakeClip_[self.curIndex_ + 1], -1, 0)
	SetActive(self.countDownGo_.gameObject, true)

	self.makeBtn_.interactable = false

	if self.curIndex_ >= #self.rewardCon_ then
		manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_cake02")
	else
		manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_cake01")
	end

	self:RemoveTween()

	self.tween_ = LeanTween.value(var_0_1, 0, var_0_1):setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
		self.countSlider_.fillAmount = 1 - arg_24_0 / var_0_1
		self.countText_.text = string.format("%.2f", arg_24_0)
	end)):setOnComplete(System.Action(function()
		SetActive(self.countDownGo_.gameObject, false)

		if #arg_23_1 > 0 then
			getReward(arg_23_1, nil, nil, nil, true)
		end

		self:RefreshUI()
		self:RemoveTween()
	end))
end

function ActivityPushBoxMainView:OnMaterialUpdate()
	self:RefreshMaterial()
end

function ActivityPushBoxMainView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function ActivityPushBoxMainView:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. ActivityConst.ACTIVITY_2_10_PUSH_BOX_TASK)
	manager.redPoint:bindUIandKey(self.makeBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX_MATERIAL .. "_" .. self.activityID_)
	manager.redPoint:bindUIandKey(self.materialBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX_FATIGUE .. "_" .. self.activityID_)
end

function ActivityPushBoxMainView:UnbindRedPointUI()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. ActivityConst.ACTIVITY_2_10_PUSH_BOX_TASK)
	manager.redPoint:unbindUIandKey(self.makeBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX_MATERIAL .. "_" .. self.activityID_)
	manager.redPoint:unbindUIandKey(self.materialBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX_FATIGUE .. "_" .. self.activityID_)
end

function ActivityPushBoxMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityPushBoxMainView:OnExit()
	self:StopTimer()
	self:RemoveTween()
	self:UnbindRedPointUI()
	self.rewardItem_:OnExit()
	manager.windowBar:HideBar()

	for iter_31_0, iter_31_1 in ipairs(self.materialItem_) do
		iter_31_1:OnExit()
	end

	manager.notify:RemoveListener(MATERIAL_MODIFY, self.OnMaterialUpdateHandler_)
end

function ActivityPushBoxMainView:Dispose()
	self:RemoveAllListeners()

	self.OnMaterialUpdateHandler_ = nil

	self.rewardItem_:Dispose()

	for iter_32_0, iter_32_1 in ipairs(self.materialItem_) do
		iter_32_1:Dispose()
	end

	self.super.Dispose(self)
end

return ActivityPushBoxMainView
