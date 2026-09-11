local ActivityGodEaterGameRewardView = class("ActivityGodEaterGameRewardView", ReduxView)

function ActivityGodEaterGameRewardView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_AFK/V4_2_GodEaterUI_AFK_BaseUI"
end

function ActivityGodEaterGameRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityGodEaterGameRewardView:Init()
	self:InitUI()
	self:AddUIListeners()

	self.rewardList = {}
	self.nowExp = 0
	self.rewardNum = 0
end

function ActivityGodEaterGameRewardView:InitUI()
	self:BindCfgUI()
end

function ActivityGodEaterGameRewardView:OnEnter()
	if self.param_ then
		self.activity_id = self.param_.activity_id or 343671
	end

	self:RefreshUI()
	self:StopTimer()
	self:UpdateItem()

	self.timer = Timer.New(function()
		self:UpdateItem()
	end, 1)

	self.timer:Start()
end

function ActivityGodEaterGameRewardView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_TOWER_DEFENSE_DESC")
	self:RefreshUI()
end

function ActivityGodEaterGameRewardView:RefreshUI()
	local var_8_0, var_8_1, var_8_2 = GodEaterTool.HubExpToLevel(GodEaterData.totalExp)

	self.lvtextText_.text = "Lv" .. var_8_0
	self.textnumText_.text = var_8_1 .. "/" .. var_8_2
	self.fillImg_.fillAmount = var_8_1 / var_8_2
	self.iconImg_.sprite = ItemTools.getItemSprite(CurrencyConst.ACTIVITY_GOD_EATER_HUB_EXP)

	local var_8_3 = GodEaterTool.GetGodAddNum()

	for iter_8_0, iter_8_1 in ipairs(ActivityGodEaterLevelCfg[var_8_0].reward_param) do
		self.rewardList[iter_8_0] = self.rewardList[iter_8_0] or GodEaterAwardItem.New(self[string.format("benefititemTrs%s_", iter_8_0)].gameObject)

		self.rewardList[iter_8_0]:SetData({
			reward_param = iter_8_1,
			now = var_8_1,
			max = var_8_2,
			second = ActivityGodEaterLevelCfg[var_8_0].interval_second,
			addedNum = var_8_3[iter_8_0].now
		})
	end
end

function ActivityGodEaterGameRewardView:UpdateItem()
	local var_9_0, var_9_1, var_9_2 = GodEaterTool.HubExpToLevel(GodEaterData.totalExp)
	local var_9_3 = GodEaterTool.GetGodAddNum()

	for iter_9_0, iter_9_1 in ipairs(ActivityGodEaterLevelCfg[var_9_0].reward_param) do
		self.rewardList[iter_9_0] = self.rewardList[iter_9_0] or GodEaterAwardItem.New(self[string.format("benefititemTrs%s_", iter_9_0)].gameObject)

		if iter_9_1.id == CurrencyConst.ACTIVITY_GOD_EATER_HUB_EXP then
			self.nowExp = var_9_3[iter_9_0].now
		else
			self.rewardNum = var_9_3[iter_9_0].now
		end

		self.rewardList[iter_9_0]:SetData({
			reward_param = iter_9_1,
			now = var_9_1,
			max = var_9_2,
			second = ActivityGodEaterLevelCfg[var_9_0].interval_second,
			addedNum = var_9_3[iter_9_0].now
		})
	end
end

function ActivityGodEaterGameRewardView:AddUIListeners()
	self:AddBtnListener(self.allbackBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btn01Btn_, nil, function()
		if self.nowExp <= 0 and self.rewardNum <= 0 then
			ShowTips(GetTips("CANTEEN_ADMITTED_NULL"))
		else
			local var_12_0 = self.activity_id

			for iter_12_0, iter_12_1 in ipairs(self.rewardList) do
				if iter_12_0 == #self.rewardList then
					iter_12_1:ShowReceiveAnimation(function()
						GodEaterAction.DrawHudReward(var_12_0)
					end)
				else
					iter_12_1:ShowReceiveAnimation()
				end
			end
		end
	end)
end

function ActivityGodEaterGameRewardView:OnBehind()
	manager.windowBar:HideBar()
end

function ActivityGodEaterGameRewardView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	self:RemoveTween()
	manager.redPoint:unbindUIandKey(self.rewardbtntrans_, RedPointConst.MARDUK_TOWERGAME_REWARD)
end

function ActivityGodEaterGameRewardView:RemoveTween()
	return
end

function ActivityGodEaterGameRewardView:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function ActivityGodEaterGameRewardView:Dispose()
	ActivityGodEaterGameRewardView.super.Dispose(self)

	for iter_18_0, iter_18_1 in ipairs(self.rewardList) do
		if iter_18_1 then
			iter_18_1:Dispose()
		end
	end
end

return ActivityGodEaterGameRewardView
