local var_0_0 = class("SummerPubEnterView", ReduxView)
local var_0_1 = {
	[1] = 1,
	[2] = 2
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_HomeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.teamController_ = arg_4_0.controllerEx_:GetController("Team")
	arg_4_0.cookController_ = arg_4_0.controllerEx_:GetController("Cook")
	arg_4_0.exploreController_ = arg_4_0.controllerEx_:GetController("Explore")
	arg_4_0.skinDlcController_ = arg_4_0.controllerEx_:GetController("skinDLC")
	arg_4_0.skinGiftController_ = arg_4_0.controllerEx_:GetController("skinGift")
	arg_4_0.skinGotController_ = arg_4_0.controllerEx_:GetController("skinGot")
	arg_4_0.recruitController_ = arg_4_0.controllerEx_:GetController("recruit")
	arg_4_0.NightToSunnyController_ = arg_4_0.controllerEx_:GetController("NightToSunny")
	arg_4_0.showRewardTipsController_ = arg_4_0.controllerEx_:GetController("showRewardTips")
	arg_4_0.taskLevelObj_ = ActivityTaskLevelCommonItem.New(arg_4_0.questBtnGo_, ActivityConst.ACTIVITY_NYA_SUMMER_PUB)
	arg_4_0.partnerTokenList = {}
	arg_4_0.partnerTokenList[var_0_1[1]] = {}

	for iter_4_0 = 1, arg_4_0.sunny_.transform.childCount - 1 do
		local var_4_0 = arg_4_0.sunny_.transform:GetChild(iter_4_0 - 1)

		arg_4_0.partnerTokenList[var_0_1[1]][iter_4_0] = SummerPubPartnerTokenItem.New(var_4_0, iter_4_0)
	end

	arg_4_0.partnerTokenList[var_0_1[2]] = {}

	for iter_4_1 = 1, arg_4_0.night_.transform.childCount - 1 do
		local var_4_1 = arg_4_0.night_.transform:GetChild(iter_4_1 - 1)

		arg_4_0.partnerTokenList[var_0_1[2]][iter_4_1] = SummerPubPartnerTokenItem.New(var_4_1, iter_4_1)
	end
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.exploreBtn_, nil, function()
		if SummerPubData:getWaitCook() ~= 0 and SummerPubData:GetClearNumByStageID(SummerPubConst.SECOND_LEVEL_ID) > 0 then
			if SummerPubData:GetClearNumByStageID(SummerPubConst.FIFTH_LEVEL_ID, 1) > 0 then
				ShowTips("NYA_SUMMER_FIGHT_LOCKED_NIGHT")
			else
				ShowTips("NYA_SUMMER_FIGHT_LOCKED")
			end
		elseif arg_5_0.timeState == 1 then
			JumpTools.OpenPageByJump("/summerPubStageView")
		else
			SummerPubAction.changeTimeState(1)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.cookBtn_, nil, function()
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
	arg_5_0:AddBtnListener(arg_5_0.teamBtn_, nil, function()
		if SummerPubData:GetCookClearNumByStageID(SummerPubConst.COOK_FIRST_STAGE) <= 0 then
			ShowTips("NYA_SUMMER_TEAM_LOCKED")
		else
			JumpTools.OpenPageByJump("/summerPubPartnerView")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.notesBtn_, nil, function()
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
	arg_5_0:AddBtnListener(arg_5_0.limitReward_, nil, function()
		JumpTools.OpenPageByJump("/summerPubLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.skinBtn_, nil, function()
		JumpTools.OpenPageByJump("summerPubSkinPopView")
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.timeState = var_0_1[SummerPubData:GetTimeState()]

	arg_12_0:RefrehsView()
	arg_12_0:RefreshRedPoint()
end

function var_0_0.RefreshRedPoint(arg_13_0)
	manager.redPoint:bindUIandKey(arg_13_0.exploreUnlockText_.transform, RedPointConst.SUMMER_PUB_RESIDENT_EXPLORE)
	manager.redPoint:bindUIandKey(arg_13_0.limitReward_.transform, RedPointConst.SUMMER_PUB_LIMIT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK)
	manager.redPoint:bindUIandKey(arg_13_0.skinBtn_.transform, RedPointConst.SUMMER_PUB_SKIN_DLC_GIFT)
	manager.redPoint:bindUIandKey(arg_13_0.notesBtn_.transform, RedPointConst.SUMMER_PUB_RECRUIT)
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("NYA_SUMMER_ENTRANCE_TIP")
	arg_14_0:RefreshSkinDlc()
	arg_14_0:RefreshNotesBtn()
	arg_14_0:RefreshLimitTime()
end

function var_0_0.RefrehsView(arg_15_0)
	arg_15_0:RefreshBtnView()
	arg_15_0:RefreshSkinDlc()
	arg_15_0:RefreshPartnerItem()
	arg_15_0:RefreshBg()
	arg_15_0:RefreshLimitTime()
	arg_15_0:RefreshTask()
	arg_15_0:RefreshExploreText()
end

function var_0_0.RefreshExploreText(arg_16_0)
	if arg_16_0.timeState == 1 then
		arg_16_0.exploreLockText_.text = GetTips("NYA_SUMMER_OUT_DAY")
		arg_16_0.exploreUnlockText_.text = GetTips("NYA_SUMMER_OUT_DAY")
	elseif SummerPubData:getWaitCook() ~= 0 and SummerPubData:GetClearNumByStageID(SummerPubConst.SECOND_LEVEL_ID) > 0 then
		arg_16_0.exploreLockText_.text = GetTips("NYA_SUMMER_OUT_DAY")
		arg_16_0.exploreUnlockText_.text = GetTips("NYA_SUMMER_OUT_DAY")
	else
		arg_16_0.exploreLockText_.text = GetTips("NYA_SUMMER_OUT_NIGHT")
		arg_16_0.exploreUnlockText_.text = GetTips("NYA_SUMMER_OUT_NIGHT")
	end
end

function var_0_0.RefreshTask(arg_17_0)
	arg_17_0.taskLevelObj_:Refresh({
		type = 1
	})

	if #TaskTools:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_NYA_SUMMER_PUB) > 0 then
		arg_17_0.showRewardTipsController_:SetSelectedState("true")
	else
		arg_17_0.showRewardTipsController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshBg(arg_18_0)
	if arg_18_0.timeState == 1 then
		arg_18_0.bg_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/MainPub/SummerPub_bg_02.png")
	else
		arg_18_0.bg_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/MainPub/SummerPub_bg_01.png")
	end
end

function var_0_0.RefreshBtnView(arg_19_0)
	arg_19_0:RefreshSelectStageBtn()
	arg_19_0:RefreshCookBtn()
	arg_19_0:RefreshTeamBtn()
	arg_19_0:RefreshNotesBtn()
end

function var_0_0.RefreshTeamBtn(arg_20_0)
	if SummerPubData:GetCookClearNumByStageID(SummerPubConst.COOK_FIRST_STAGE) <= 0 then
		arg_20_0.teamController_:SetSelectedIndex(0)
	else
		arg_20_0.teamController_:SetSelectedIndex(1)
	end
end

function var_0_0.RefreshNotesBtn(arg_21_0)
	local var_21_0 = SummerPubData:getWaitPartner()
	local var_21_1 = getData("summer_pub_main", "look_recruit" .. var_21_0) or 0

	manager.redPoint:setTip(RedPointConst.SUMMER_PUB_RECRUIT, 0)

	if var_21_0 == 0 then
		arg_21_0.recruitController_:SetSelectedIndex(0)
	elseif var_21_1 ~= 0 then
		arg_21_0.recruitController_:SetSelectedIndex(1)
	else
		arg_21_0.recruitController_:SetSelectedIndex(1)
		manager.redPoint:setTip(RedPointConst.SUMMER_PUB_RECRUIT, 1)
	end
end

function var_0_0.RefreshCookBtn(arg_22_0)
	if SummerPubData:GetClearNumByStageID(SummerPubConst.SECOND_LEVEL_ID) <= 0 then
		arg_22_0.cookController_:SetSelectedIndex(0)
	elseif SummerPubData:getWaitCook() ~= 0 then
		arg_22_0.cookController_:SetSelectedIndex(1)
	else
		arg_22_0.cookController_:SetSelectedIndex(2)
	end
end

function var_0_0.RefreshSelectStageBtn(arg_23_0)
	if SummerPubData:getWaitCook() ~= 0 and SummerPubData:GetClearNumByStageID(SummerPubConst.SECOND_LEVEL_ID) > 0 then
		arg_23_0.exploreController_:SetSelectedIndex(0)
	else
		arg_23_0.exploreController_:SetSelectedIndex(1)
	end
end

function var_0_0.RefreshLimitTime(arg_24_0)
	local var_24_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK) then
		SetActive(arg_24_0.limitReward_.gameObject, true)

		arg_24_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_24_0.stopTime)

		if arg_24_0.limittimer_ == nil then
			arg_24_0.limittimer_ = Timer.New(function()
				if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK) then
					if arg_24_0.limittimer_ == nil then
						arg_24_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_24_0.stopTime)
					end
				else
					SetActive(arg_24_0.limitReward_.gameObject, false)
					arg_24_0:LimitStopTimer()
				end
			end, 1, -1)
		end

		arg_24_0.limittimer_:Start()
	else
		SetActive(arg_24_0.limitReward_.gameObject, false)
	end
end

function var_0_0.LimitStopTimer(arg_26_0)
	if arg_26_0.limittimer_ then
		arg_26_0.limittimer_:Stop()

		arg_26_0.limittimer_ = nil
	end
end

function var_0_0.RefreshSkinDlc(arg_27_0)
	local var_27_0 = ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC

	if ActivityData:GetActivityIsOpen(var_27_0) then
		arg_27_0.skinDlcController_:SetSelectedState("on")

		local var_27_1 = AssignmentCfg.get_id_list_by_activity_id[var_27_0] or {}

		if TaskTools:IsHasReceiveTask(var_27_1) then
			arg_27_0.skinGiftController_:SetSelectedState("on")
		else
			arg_27_0.skinGiftController_:SetSelectedState("off")

			if TaskTools:GetFinishTaskNum(var_27_1) == #var_27_1 then
				arg_27_0.skinGotController_:SetSelectedState("on")
			else
				arg_27_0.skinGotController_:SetSelectedState("off")
			end
		end

		arg_27_0:RefreshSkinTimeText()
	else
		arg_27_0.skinDlcController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshSkinTimeText(arg_28_0)
	local var_28_0 = ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC
	local var_28_1 = ActivityData:GetActivityData(var_28_0)

	if ActivityData:GetActivityIsOpen(var_28_0) then
		arg_28_0.skinTimeTxt_.text = manager.time:GetLostTimeStr2(var_28_1.stopTime)
	elseif manager.time:GetServerTime() < var_28_1.startTime then
		arg_28_0.skinTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_28_1.startTime))
	elseif manager.time:GetServerTime() > var_28_1.stopTime then
		arg_28_0.skinTimeTxt_.text = GetTips("TIME_OVER")
	end

	if arg_28_0.skinTimer_ == nil then
		arg_28_0.skinTimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(var_28_0) then
				if arg_28_0.skinTimer_ == nil then
					arg_28_0.skinTimeTxt_.text = manager.time:GetLostTimeStr2(var_28_1.stopTime)
				end
			elseif manager.time:GetServerTime() < var_28_1.startTime then
				arg_28_0.skinTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_28_1.startTime))
			elseif manager.time:GetServerTime() > var_28_1.stopTime then
				arg_28_0.skinTimeTxt_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	arg_28_0.skinTimer_:Start()
end

function var_0_0.RefreshPartnerItem(arg_30_0)
	if arg_30_0.timeState == 1 then
		arg_30_0.NightToSunnyController_:SetSelectedState("sunny")
	else
		arg_30_0.NightToSunnyController_:SetSelectedState("night")
	end

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.partnerTokenList[arg_30_0.timeState]) do
		iter_30_1:updateState()
	end
end

function var_0_0.SkinStopTimer(arg_31_0)
	if arg_31_0.skinTimer_ then
		arg_31_0.skinTimer_:Stop()

		arg_31_0.skinTimer_ = nil
	end
end

function var_0_0.OnExit(arg_32_0)
	manager.redPoint:unbindUIandKey(arg_32_0.exploreUnlockText_.transform, RedPointConst.SUMMER_PUB_RESIDENT_EXPLORE)
	manager.redPoint:unbindUIandKey(arg_32_0.limitReward_.transform, RedPointConst.SUMMER_PUB_LIMIT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK)
	manager.redPoint:unbindUIandKey(arg_32_0.skinBtn_.transform, RedPointConst.SUMMER_PUB_SKIN_DLC_GIFT)
	manager.redPoint:unbindUIandKey(arg_32_0.notesBtn_.transform, RedPointConst.SUMMER_PUB_RECRUIT)
	arg_32_0:SkinStopTimer()
	arg_32_0:LimitStopTimer()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_33_0)
	arg_33_0.taskLevelObj_:Dispose()

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.partnerTokenList) do
		for iter_33_2, iter_33_3 in ipairs(iter_33_1) do
			iter_33_3:Dispose()
		end
	end

	arg_33_0.super.Dispose(arg_33_0)
end

return var_0_0
