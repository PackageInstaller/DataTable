local AffixSelectHomeView = class("AffixSelectHomeView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function AffixSelectHomeView:GetUIName()
	return "Widget/Version/NorseUI_3_2/NorseUI_3_2_AffixSelect/NorseUI_3_2_StageUI"
end

function AffixSelectHomeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AffixSelectHomeView:InitUI()
	self:BindCfgUI()

	self.reward_btnstateController_ = ControllerUtil.GetController(self.gameObject_.transform, "reward_btnstate")
	self.bonusItem_ = CommonItem.New(self.bonusItemGo_)
	self.items_ = {}

	for iter_3_0 = 1, 8 do
		table.insert(self.items_, (AffixSelectItemView.New(self["itemGo" .. iter_3_0 .. "_"])))
	end
end

function AffixSelectHomeView:AddUIListener()
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
	self.bonusItem_:RegistCallBack(function(arg_8_0)
		ShowPopItem(POP_ITEM, {
			arg_8_0.id
		})
	end)
	self:AddBtnListener(nil, self.m_tipBtn, function()
		local var_9_0 = GetTips("ACTIVITY_SKADI_SEA_DESCRIBE")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_AFFIX_DESCRIBE")
		})
	end)
end

function AffixSelectHomeView:OnEnter()
	self.activityId = ActivityConst.ACTIVITY_3_2_AFFIX_SELECT

	for iter_10_0, iter_10_1 in ipairs(self.items_) do
		iter_10_1:SetData(iter_10_0, ActivityCfg[self.activityId].sub_activity_list[iter_10_0])
	end

	ActivityAffixSelectAction.ReadUnPassRedPoint()
	manager.redPoint:bindUIandKey(self.firstPassNoticeContainer_, string.format("%s_%s", RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET, self.activityId), {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(self.getBtn_.transform, string.format("%s_%s", RedPointConst.AFFIX_SELECT_SCORE_BONUS_CAN_GET, self.activityId))
	self:UpdateView()

	local var_10_0 = getData("affixSelect", "mainScrollPos")

	if var_10_0 then
		self.itemScrollRect_.horizontalNormalizedPosition = var_10_0
	end

	self:StartTimer()
	self:RegistEventListener(ACTIVITY_REWARD_GET, handler(self, self.UpdateView))
end

function AffixSelectHomeView:OnExit()
	self:StopTimer()
	self:RemoveAllEventListener()
	saveData("affixSelect", "mainScrollPos", self.itemScrollRect_.horizontalNormalizedPosition)
	manager.redPoint:unbindUIandKey(self.firstPassNoticeContainer_)
	manager.redPoint:unbindUIandKey(self.getBtn_.transform)
	self:RemoveAllEventListener()
end

function AffixSelectHomeView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
end

function AffixSelectHomeView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function AffixSelectHomeView:UpdateTimer()
	self.lastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(self.activityId).stopTime)
end

function AffixSelectHomeView:UpdateView()
	local var_16_0 = ActivityAffixSelectData:GetCurrentActivityReward(self.activityId)
	local var_16_1 = ActivityPointRewardCfg[var_16_0]

	self.currentScoreLabel_.text = ActivityAffixSelectData:GetTotalScore(self.activityId)
	self.totalScoreLabel_.text = "/" .. var_16_1.need

	local var_16_2 = ActivityAffixSelectData:GetRewardStatus(self.activityId, var_16_0)

	if var_16_2 == 0 then
		self.reward_btnstateController_:SetSelectedState("received")
	elseif var_16_2 == 1 then
		self.reward_btnstateController_:SetSelectedState("normal")
	else
		self.reward_btnstateController_:SetSelectedState("receive")
	end

	self.bonusItem_:RefreshData({
		id = var_16_1.reward_item_list[1][1],
		number = var_16_1.reward_item_list[1][2]
	})
	self.bonusItem_:SetBottomText("")

	self.bonusNumLabel_.text = var_16_1.reward_item_list[1][2]

	self:UpdateTimer()
end

function AffixSelectHomeView:OnReceivePointReward(arg_17_1)
	self:UpdateView()
end

function AffixSelectHomeView:OnMainHomeViewTop()
	return
end

function AffixSelectHomeView:Dispose()
	if self.bonusItem_ then
		self.bonusItem_:Dispose()

		self.bonusItem_ = nil
	end

	if self.items_ then
		for iter_19_0, iter_19_1 in pairs(self.items_) do
			iter_19_1:Dispose()
		end

		self.items_ = nil
	end

	self:StopTimer()
	AffixSelectHomeView.super.Dispose(self)
end

return AffixSelectHomeView
