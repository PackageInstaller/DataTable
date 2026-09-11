local AffixSelectMainView = class("AffixSelectMainView", ReduxView)

function AffixSelectMainView:UIName()
	return "UI/VersionUI/DarkFlameUI/DFQualsDrilUI/DFQualsDrillStageUI"
end

function AffixSelectMainView:UIParent()
	return manager.ui.uiMain.transform
end

function AffixSelectMainView:OnCtor()
	return
end

function AffixSelectMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AffixSelectMainView:InitUI()
	self:BindCfgUI()

	self.reward_btnstateController_ = ControllerUtil.GetController(self.gameObject_.transform, "reward_btnstate")
	self.bonusItem_ = CommonItem.New(self.bonusItemGo_)
	self.items_ = {}

	for iter_5_0 = 1, 8 do
		table.insert(self.items_, (AffixSelectItemView.New(self["itemGo" .. iter_5_0 .. "_"])))
	end
end

function AffixSelectMainView:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("affixSelectFirstReward", {
			affixActivityId = self.activityId
		})
	end)
	self:AddBtnListener(self.checkBtn_, nil, function()
		JumpTools.OpenPageByJump("affixSelectScoreReward", {
			affixActivityId = self.activityId
		})
	end)
	self:AddBtnListener(self.getBtn_, nil, function()
		ActivityAction.ReceivePointReward({
			(ActivityAffixSelectData:GetCurrentActivityReward(self.activityId))
		})
	end)
	self.bonusItem_:RegistCallBack(function(arg_10_0)
		ShowPopItem(POP_ITEM, {
			arg_10_0.id
		})
	end)
end

function AffixSelectMainView:AddEventListeners()
	return
end

function AffixSelectMainView:OnTop()
	self:UpdateBar()
end

function AffixSelectMainView:OnBehind()
	manager.windowBar:HideBar()
end

function AffixSelectMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("AFFIX_SELECT_HELP")
end

function AffixSelectMainView:OnEnter()
	self:AddEventListeners()

	self.activityId = self.params_.activityID

	for iter_15_0, iter_15_1 in ipairs(self.items_) do
		iter_15_1:SetData(iter_15_0, ActivityCfg[self.activityId].sub_activity_list[iter_15_0])
	end

	ActivityAffixSelectAction.ReadUnPassRedPoint()
	manager.redPoint:bindUIandKey(self.firstPassNoticeContainer_, string.format("%s_%s", RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET, self.activityId), {
		x = 0,
		y = 0
	})
	self:UpdateView()

	local var_15_0 = getData("affixSelect", "mainScrollPos")

	if var_15_0 then
		self.itemScrollRect_.horizontalNormalizedPosition = var_15_0
	end

	self:StartTimer()
end

function AffixSelectMainView:OnExit()
	self:StopTimer()
	self:RemoveAllEventListener()
	saveData("affixSelect", "mainScrollPos", self.itemScrollRect_.horizontalNormalizedPosition)
	manager.redPoint:unbindUIandKey(self.firstPassNoticeContainer_)
	manager.windowBar:HideBar()
end

function AffixSelectMainView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
end

function AffixSelectMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function AffixSelectMainView:UpdateTimer()
	self.lastTimeLabel_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(self.activityId).stopTime)
end

function AffixSelectMainView:UpdateView()
	local var_21_0 = ActivityAffixSelectData:GetCurrentActivityReward(self.activityId)
	local var_21_1 = ActivityPointRewardCfg[var_21_0]

	self.currentScoreLabel_.text = ActivityAffixSelectData:GetTotalScore(self.activityId)
	self.totalScoreLabel_.text = "/" .. var_21_1.need

	local var_21_2 = ActivityAffixSelectData:GetRewardStatus(self.activityId, var_21_0)

	if var_21_2 == 0 then
		self.reward_btnstateController_:SetSelectedState("received")
	elseif var_21_2 == 1 then
		self.reward_btnstateController_:SetSelectedState("normal")
	else
		self.reward_btnstateController_:SetSelectedState("receive")
	end

	self.bonusItem_:RefreshData({
		id = var_21_1.reward_item_list[1][1],
		number = var_21_1.reward_item_list[1][2]
	})
	self.bonusItem_:SetBottomText("")

	self.bonusNumLabel_.text = var_21_1.reward_item_list[1][2]

	self:UpdateTimer()
end

function AffixSelectMainView:OnReceivePointReward(arg_22_1)
	self:UpdateView()
end

function AffixSelectMainView:OnMainHomeViewTop()
	return
end

function AffixSelectMainView:Dispose()
	if self.bonusItem_ then
		self.bonusItem_:Dispose()

		self.bonusItem_ = nil
	end

	if self.items_ then
		for iter_24_0, iter_24_1 in pairs(self.items_) do
			iter_24_1:Dispose()
		end

		self.items_ = nil
	end

	self:StopTimer()
	AffixSelectMainView.super.Dispose(self)
end

return AffixSelectMainView
