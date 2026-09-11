local SummerPubEnterView = class("SummerPubEnterView", ReduxView)
local var_0_1 = {
	[1] = 1,
	[2] = 2
}

function SummerPubEnterView:UIName()
	return "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_HomeUI"
end

function SummerPubEnterView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerPubEnterView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SummerPubEnterView:InitUI()
	self:BindCfgUI()

	self.teamController_ = self.controllerEx_:GetController("Team")
	self.cookController_ = self.controllerEx_:GetController("Cook")
	self.exploreController_ = self.controllerEx_:GetController("Explore")
	self.skinDlcController_ = self.controllerEx_:GetController("skinDLC")
	self.skinGiftController_ = self.controllerEx_:GetController("skinGift")
	self.skinGotController_ = self.controllerEx_:GetController("skinGot")
	self.recruitController_ = self.controllerEx_:GetController("recruit")
	self.NightToSunnyController_ = self.controllerEx_:GetController("NightToSunny")
	self.showRewardTipsController_ = self.controllerEx_:GetController("showRewardTips")
	self.taskLevelObj_ = ActivityTaskLevelCommonItem.New(self.questBtnGo_, ActivityConst.ACTIVITY_NYA_SUMMER_PUB)
	self.partnerTokenList = {}
	self.partnerTokenList[var_0_1[1]] = {}

	for iter_4_0 = 1, self.sunny_.transform.childCount - 1 do
		self.partnerTokenList[var_0_1[1]][iter_4_0] = SummerPubPartnerTokenItem.New(self.sunny_.transform:GetChild(iter_4_0 - 1), iter_4_0)
	end

	self.partnerTokenList[var_0_1[2]] = {}

	for iter_4_1 = 1, self.night_.transform.childCount - 1 do
		self.partnerTokenList[var_0_1[2]][iter_4_1] = SummerPubPartnerTokenItem.New(self.night_.transform:GetChild(iter_4_1 - 1), iter_4_1)
	end
end

function SummerPubEnterView:AddUIListeners()
	self:AddBtnListener(self.exploreBtn_, nil, function()
		if SummerPubData:getWaitCook() ~= 0 and SummerPubData:GetClearNumByStageID(SummerPubConst.SECOND_LEVEL_ID) > 0 then
			if SummerPubData:GetClearNumByStageID(SummerPubConst.FIFTH_LEVEL_ID, 1) > 0 then
				ShowTips("NYA_SUMMER_FIGHT_LOCKED_NIGHT")
			else
				ShowTips("NYA_SUMMER_FIGHT_LOCKED")
			end
		elseif self.timeState == 1 then
			JumpTools.OpenPageByJump("/summerPubStageView")
		else
			SummerPubAction.changeTimeState(1)
		end
	end)
	self:AddBtnListener(self.cookBtn_, nil, function()
		local var_7_0 = SummerPubData:getWaitCook()

		if SummerPubData:GetClearNumByStageID(SummerPubConst.SECOND_LEVEL_ID) <= 0 then
			ShowTips("NYA_SUMMER_COOK_LOCKED")
		elseif SummerPubData:getWaitCook() ~= 0 then
			JumpTools.OpenPageByJump("summerCookMenuView", {
				dishIndex = var_7_0
			})
		else
			JumpTools.OpenPageByJump("summerCookMenuView", {
				dishIndex = var_7_0
			})
		end
	end)
	self:AddBtnListener(self.teamBtn_, nil, function()
		if SummerPubData:GetCookClearNumByStageID(SummerPubConst.COOK_FIRST_STAGE) <= 0 then
			ShowTips("NYA_SUMMER_TEAM_LOCKED")
		else
			JumpTools.OpenPageByJump("/summerPubPartnerView")
		end
	end)
	self:AddBtnListener(self.notesBtn_, nil, function()
		local var_9_0 = SummerPubData:getWaitPartner()
		local var_9_1 = getData("summer_pub_main", "look_recruit" .. var_9_0) or 0

		if var_9_0 == 0 then
			ShowTips("NYA_TEAM_NOT_RECRUITED")
		elseif var_9_1 ~= 0 then
			JumpTools.OpenPageByJump("summerPubRecruitLookView", {
				id = var_9_0
			})
		else
			saveData("summer_pub_main", "look_recruit" .. var_9_0, 1)
			JumpTools.OpenPageByJump("summerPubRecruitLookView", {
				id = var_9_0
			})
		end
	end)
	self:AddBtnListener(self.limitReward_, nil, function()
		JumpTools.OpenPageByJump("/summerPubLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK
		})
	end)
	self:AddBtnListener(self.skinBtn_, nil, function()
		JumpTools.OpenPageByJump("summerPubSkinPopView")
	end)
end

function SummerPubEnterView:OnEnter()
	self.timeState = var_0_1[SummerPubData:GetTimeState()]

	self:RefrehsView()
	self:RefreshRedPoint()
end

function SummerPubEnterView:RefreshRedPoint()
	manager.redPoint:bindUIandKey(self.exploreUnlockText_.transform, RedPointConst.SUMMER_PUB_RESIDENT_EXPLORE)
	manager.redPoint:bindUIandKey(self.limitReward_.transform, RedPointConst.SUMMER_PUB_LIMIT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK)
	manager.redPoint:bindUIandKey(self.skinBtn_.transform, RedPointConst.SUMMER_PUB_SKIN_DLC_GIFT)
	manager.redPoint:bindUIandKey(self.notesBtn_.transform, RedPointConst.SUMMER_PUB_RECRUIT)
end

function SummerPubEnterView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("NYA_SUMMER_ENTRANCE_TIP")
	self:RefreshSkinDlc()
	self:RefreshNotesBtn()
	self:RefreshLimitTime()
end

function SummerPubEnterView:RefrehsView()
	self:RefreshBtnView()
	self:RefreshSkinDlc()
	self:RefreshPartnerItem()
	self:RefreshBg()
	self:RefreshLimitTime()
	self:RefreshTask()
	self:RefreshExploreText()
end

function SummerPubEnterView:RefreshExploreText()
	if self.timeState == 1 then
		self.exploreLockText_.text = GetTips("NYA_SUMMER_OUT_DAY")
		self.exploreUnlockText_.text = GetTips("NYA_SUMMER_OUT_DAY")
	elseif SummerPubData:getWaitCook() ~= 0 and SummerPubData:GetClearNumByStageID(SummerPubConst.SECOND_LEVEL_ID) > 0 then
		self.exploreLockText_.text = GetTips("NYA_SUMMER_OUT_DAY")
		self.exploreUnlockText_.text = GetTips("NYA_SUMMER_OUT_DAY")
	else
		self.exploreLockText_.text = GetTips("NYA_SUMMER_OUT_NIGHT")
		self.exploreUnlockText_.text = GetTips("NYA_SUMMER_OUT_NIGHT")
	end
end

function SummerPubEnterView:RefreshTask()
	self.taskLevelObj_:Refresh({
		type = 1
	})

	if #TaskTools:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_NYA_SUMMER_PUB) > 0 then
		self.showRewardTipsController_:SetSelectedState("true")
	else
		self.showRewardTipsController_:SetSelectedState("false")
	end
end

function SummerPubEnterView:RefreshBg()
	self.bg_.sprite = self.timeState == 1 and pureGetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/MainPub/SummerPub_bg_02.png") or pureGetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/MainPub/SummerPub_bg_01.png")
end

function SummerPubEnterView:RefreshBtnView()
	self:RefreshSelectStageBtn()
	self:RefreshCookBtn()
	self:RefreshTeamBtn()
	self:RefreshNotesBtn()
end

function SummerPubEnterView:RefreshTeamBtn()
	if SummerPubData:GetCookClearNumByStageID(SummerPubConst.COOK_FIRST_STAGE) <= 0 then
		self.teamController_:SetSelectedIndex(0)
	else
		self.teamController_:SetSelectedIndex(1)
	end
end

function SummerPubEnterView:RefreshNotesBtn()
	local var_21_0 = SummerPubData:getWaitPartner()
	local var_21_1 = getData("summer_pub_main", "look_recruit" .. var_21_0) or 0

	manager.redPoint:setTip(RedPointConst.SUMMER_PUB_RECRUIT, 0)

	if var_21_0 == 0 then
		self.recruitController_:SetSelectedIndex(0)
	elseif var_21_1 ~= 0 then
		self.recruitController_:SetSelectedIndex(1)
	else
		self.recruitController_:SetSelectedIndex(1)
		manager.redPoint:setTip(RedPointConst.SUMMER_PUB_RECRUIT, 1)
	end
end

function SummerPubEnterView:RefreshCookBtn()
	if SummerPubData:GetClearNumByStageID(SummerPubConst.SECOND_LEVEL_ID) <= 0 then
		self.cookController_:SetSelectedIndex(0)
	elseif SummerPubData:getWaitCook() ~= 0 then
		self.cookController_:SetSelectedIndex(1)
	else
		self.cookController_:SetSelectedIndex(2)
	end
end

function SummerPubEnterView:RefreshSelectStageBtn()
	if SummerPubData:getWaitCook() ~= 0 and SummerPubData:GetClearNumByStageID(SummerPubConst.SECOND_LEVEL_ID) > 0 then
		self.exploreController_:SetSelectedIndex(0)
	else
		self.exploreController_:SetSelectedIndex(1)
	end
end

function SummerPubEnterView:RefreshLimitTime()
	local var_24_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK) then
		SetActive(self.limitReward_.gameObject, true)

		self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_24_0.stopTime)

		if self.limittimer_ == nil then
			self.limittimer_ = Timer.New(function()
				if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK) then
					if self.limittimer_ == nil then
						self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_24_0.stopTime)
					end
				else
					SetActive(self.limitReward_.gameObject, false)
					self:LimitStopTimer()
				end
			end, 1, -1)
		end

		self.limittimer_:Start()
	else
		SetActive(self.limitReward_.gameObject, false)
	end
end

function SummerPubEnterView:LimitStopTimer()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end
end

function SummerPubEnterView:RefreshSkinDlc()
	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC) then
		self.skinDlcController_:SetSelectedState("on")

		local var_27_0 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC] or {}

		if TaskTools:IsHasReceiveTask(var_27_0) then
			self.skinGiftController_:SetSelectedState("on")
		else
			self.skinGiftController_:SetSelectedState("off")

			if TaskTools:GetFinishTaskNum(var_27_0) == #var_27_0 then
				self.skinGotController_:SetSelectedState("on")
			else
				self.skinGotController_:SetSelectedState("off")
			end
		end

		self:RefreshSkinTimeText()
	else
		self.skinDlcController_:SetSelectedState("off")
	end
end

function SummerPubEnterView:RefreshSkinTimeText()
	local var_28_0 = ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC
	local var_28_1 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC) then
		self.skinTimeTxt_.text = manager.time:GetLostTimeStr2(var_28_1.stopTime)
	elseif manager.time:GetServerTime() < var_28_1.startTime then
		self.skinTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_28_1.startTime))
	elseif manager.time:GetServerTime() > var_28_1.stopTime then
		self.skinTimeTxt_.text = GetTips("TIME_OVER")
	end

	if self.skinTimer_ == nil then
		self.skinTimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(var_28_0) then
				if self.skinTimer_ == nil then
					self.skinTimeTxt_.text = manager.time:GetLostTimeStr2(var_28_1.stopTime)
				end
			elseif manager.time:GetServerTime() < var_28_1.startTime then
				self.skinTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_28_1.startTime))
			elseif manager.time:GetServerTime() > var_28_1.stopTime then
				self.skinTimeTxt_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	self.skinTimer_:Start()
end

function SummerPubEnterView:RefreshPartnerItem()
	if self.timeState == 1 then
		self.NightToSunnyController_:SetSelectedState("sunny")
	else
		self.NightToSunnyController_:SetSelectedState("night")
	end

	for iter_30_0, iter_30_1 in ipairs(self.partnerTokenList[self.timeState]) do
		iter_30_1:updateState()
	end
end

function SummerPubEnterView:SkinStopTimer()
	if self.skinTimer_ then
		self.skinTimer_:Stop()

		self.skinTimer_ = nil
	end
end

function SummerPubEnterView:OnExit()
	manager.redPoint:unbindUIandKey(self.exploreUnlockText_.transform, RedPointConst.SUMMER_PUB_RESIDENT_EXPLORE)
	manager.redPoint:unbindUIandKey(self.limitReward_.transform, RedPointConst.SUMMER_PUB_LIMIT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK)
	manager.redPoint:unbindUIandKey(self.skinBtn_.transform, RedPointConst.SUMMER_PUB_SKIN_DLC_GIFT)
	manager.redPoint:unbindUIandKey(self.notesBtn_.transform, RedPointConst.SUMMER_PUB_RECRUIT)
	self:SkinStopTimer()
	self:LimitStopTimer()
	manager.windowBar:HideBar()
end

function SummerPubEnterView:Dispose()
	self.taskLevelObj_:Dispose()

	for iter_33_0, iter_33_1 in ipairs(self.partnerTokenList) do
		for iter_33_2, iter_33_3 in ipairs(iter_33_1) do
			iter_33_3:Dispose()
		end
	end

	self.super.Dispose(self)
end

return SummerPubEnterView
