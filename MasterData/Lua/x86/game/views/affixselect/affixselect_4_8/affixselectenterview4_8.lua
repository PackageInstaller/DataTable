local AffixSelectEnterView4_8 = class("AffixSelectEnterView4_8", ReduxView)

function AffixSelectEnterView4_8:UIName()
	return "Widget/Version/Alone_AffixSelect/Alone_AffixSelect_StageUI"
end

function AffixSelectEnterView4_8:UIParent()
	return manager.ui.uiMain.transform
end

function AffixSelectEnterView4_8:Init()
	self:InitUI()
	self:AddUIListener()
end

function AffixSelectEnterView4_8:InitUI()
	self:BindCfgUI()

	self.reward_btnstateController_ = ControllerUtil.GetController(self.gameObject_.transform, "reward_btnstate")
	self.bonusItem_ = CommonItemView.New(self.bonusItemGo_, true)
	self.items_ = {}

	for iter_4_0 = 1, 8 do
		table.insert(self.items_, (AffixSelectItemView.New(self["itemGo" .. iter_4_0 .. "_"])))
	end
end

function AffixSelectEnterView4_8:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("activity_affixbattle_reward_firstpass")
		JumpTools.OpenPageByJump("affixSelectFirstRewardJapanRegion", {
			affixActivityId = self.activityId
		})
	end)
	self:AddBtnListener(self.checkBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("activity_affixbattle_reward_score")
		JumpTools.OpenPageByJump("affixSelectScoreRewardJapanRegion", {
			affixActivityId = self.activityId
		})
	end)
	self:AddBtnListener(self.getBtn_, nil, function()
		ActivityAction.ReceivePointReward({
			(ActivityAffixSelectData:GetCurrentActivityReward(self.activityId))
		})
	end)
end

function AffixSelectEnterView4_8:OnTop()
	self:UpdateBar()
end

function AffixSelectEnterView4_8:OnBehind()
	manager.windowBar:HideBar()
end

function AffixSelectEnterView4_8:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function AffixSelectEnterView4_8:OnEnter()
	self:UpdateBar()

	self.activityId = self.params_.activityID

	for iter_12_0, iter_12_1 in ipairs(self.items_) do
		iter_12_1:SetData(iter_12_0, ActivityCfg[self.activityId].sub_activity_list[iter_12_0])
	end

	manager.redPoint:bindUIandKey(self.firstPassNoticeContainer_, string.format("%s_%s", RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET, self.activityId), {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(self.getBtn_.transform, string.format("%s_%s", RedPointConst.AFFIX_SELECT_SCORE_BONUS_CAN_GET, self.activityId))
	self:UpdateView()

	local var_12_0 = getData("affixSelect", "mainScrollPos")

	if var_12_0 then
		self.itemScrollRect_.horizontalNormalizedPosition = var_12_0
	end

	self:RegistEventListener(ACTIVITY_REWARD_GET, handler(self, self.UpdateView))
end

function AffixSelectEnterView4_8:OnExit()
	self:RemoveAllEventListener()
	saveData("affixSelect", "mainScrollPos", self.itemScrollRect_.horizontalNormalizedPosition)
	manager.redPoint:unbindUIandKey(self.firstPassNoticeContainer_, string.format("%s_%s", RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET, self.activityId))
	manager.redPoint:unbindUIandKey(self.getBtn_.transform, string.format("%s_%s", RedPointConst.AFFIX_SELECT_SCORE_BONUS_CAN_GET, self.activityId))
	self:RemoveAllEventListener()
end

function AffixSelectEnterView4_8:UpdateView()
	local var_14_0 = ActivityAffixSelectData:GetCurrentActivityReward(self.activityId)
	local var_14_1 = ActivityPointRewardCfg[var_14_0]

	self.currentScoreLabel_.text = ActivityAffixSelectData:GetTotalScore(self.activityId)
	self.totalScoreLabel_.text = "/" .. var_14_1.need

	local var_14_2 = ActivityAffixSelectData:GetRewardStatus(self.activityId, var_14_0)

	if var_14_2 == 3 then
		self.reward_btnstateController_:SetSelectedState("received")
	elseif var_14_2 == 1 then
		self.reward_btnstateController_:SetSelectedState("normal")
	else
		self.reward_btnstateController_:SetSelectedState("receive")
	end

	self.bonusItem_:SetData({
		id = var_14_1.reward_item_list[1][1],
		number = var_14_1.reward_item_list[1][2]
	})

	self.bonusItem_.clickFun = CustomClickRewardFunc
	self.bonusNumLabel_.text = " "
end

function AffixSelectEnterView4_8:OnReceivePointReward(arg_16_1)
	self:UpdateView()
end

function AffixSelectEnterView4_8:OnMainHomeViewTop()
	return
end

function AffixSelectEnterView4_8:Dispose()
	if self.bonusItem_ then
		self.bonusItem_:Dispose()

		self.bonusItem_ = nil
	end

	if self.items_ then
		for iter_18_0, iter_18_1 in pairs(self.items_) do
			iter_18_1:Dispose()
		end

		self.items_ = nil
	end

	AffixSelectEnterView4_8.super.Dispose(self)
end

return AffixSelectEnterView4_8
