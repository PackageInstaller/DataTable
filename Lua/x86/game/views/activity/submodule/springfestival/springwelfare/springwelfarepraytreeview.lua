local var_0_0 = class("SpringWelfarePrayTreeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
	arg_3_0:InitBranch()

	arg_3_0.stageController_ = ControllerUtil.GetController(arg_3_0.transform_, "stage")

	arg_3_0.stageController_:SetSelectedState("welfare")

	arg_3_0.prayController_ = ControllerUtil.GetController(arg_3_0.prayBtn_.transform, "state")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.mailBtn_, nil, function()
		JumpTools.OpenPageByJump("springWelfareLetterBox", {})
	end)
	arg_4_0:AddBtnListener(arg_4_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("springWelfareTask", {})
	end)
	arg_4_0:AddBtnListener(arg_4_0.prayBtn_, nil, function()
		arg_4_0:TryStartPray()
	end)
end

function var_0_0.InitBranch(arg_8_0)
	local var_8_0 = arg_8_0:GetDays()

	arg_8_0.branchList_ = {}

	for iter_8_0 = 1, var_8_0 do
		local var_8_1 = arg_8_0[string.format("bubbleGo_%d", iter_8_0)]
		local var_8_2 = SpringWelfarePrayBubbleView.New(var_8_1)

		var_8_2:SetData(iter_8_0)
		var_8_2:SetClickHandler(function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
			arg_8_0:OnClickBubble(iter_8_0, arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		end)

		arg_8_0.branchList_[iter_8_0] = var_8_2
	end
end

function var_0_0.UpdateBar(arg_10_0)
	local var_10_0, var_10_1 = SpringWelfareData:GetPoolSignCost()
	local var_10_2, var_10_3 = SpringWelfareData:GetPoolCost()

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		var_10_0,
		var_10_2
	})
	manager.windowBar:SetBarCanAdd(var_10_0, true)
	manager.windowBar:SetBarCanAdd(var_10_2, true)
	manager.windowBar:SetGameHelpKey("SPRING_BLESSING_DES")
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:UpdateBar()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.branchList_) do
		iter_11_1:OnEnter()
	end

	local var_11_0 = arg_11_0:GetActivityID()
	local var_11_1 = ActivityTools.GetRedPointKey(var_11_0) .. var_11_0

	manager.redPoint:bindUIandKey(arg_11_0.mailBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_LETTER, var_11_1))
	manager.redPoint:bindUIandKey(arg_11_0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_REWARD, var_11_1))
	arg_11_0:RefreshUI()
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:NewDayEffect()
	arg_12_0:RefreshPrayStateUI()
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.branchList_) do
		iter_13_1:OnExit()
	end

	local var_13_0 = arg_13_0:GetActivityID()
	local var_13_1 = ActivityTools.GetRedPointKey(var_13_0) .. var_13_0

	manager.redPoint:unbindUIandKey(arg_13_0.mailBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_LETTER, var_13_1))
	manager.redPoint:unbindUIandKey(arg_13_0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_REWARD, var_13_1))
end

function var_0_0.Dispose(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.branchList_) do
		iter_14_1:Dispose()
	end

	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.RefreshUI(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.branchList_) do
		iter_15_1:UpdateItemIdList()
		iter_15_1:RefreshItemUiList()
	end

	arg_15_0:RefreshPrayStateUI()

	local var_15_0 = arg_15_0:GetActivityID()
	local var_15_1 = ActivityData:GetActivityData(var_15_0)
	local var_15_2 = var_15_1.startTime
	local var_15_3 = var_15_1.stopTime

	arg_15_0.tipsText_.text = string.format(GetTips("SPRING_BLESSING_SCREEN_TIPS"), manager.time:STimeDescS(var_15_2, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(var_15_3, "!%Y.%m.%d %H:%M"))

	SpringWelfareAction:UpdateRedPoint(arg_15_0:GetActivityID())
end

function var_0_0.RefreshPrayStateUI(arg_16_0)
	local var_16_0 = SpringWelfareData:GetCurPrayDay()
	local var_16_1 = arg_16_0:GetDays()
	local var_16_2 = SpringWelfareData:GetDayState(var_16_0)
	local var_16_3 = 0
	local var_16_4 = 0

	if var_16_2 == SPRING_WELFARE_DAY_STATE_TYPE.ACQUIRED then
		arg_16_0.prayController_:SetSelectedState(var_16_0 == var_16_1 and "finish" or "prayed")
		SetActive(arg_16_0.prayCostGo_, false)

		return
	elseif var_16_2 == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
		var_16_3, var_16_4 = SpringWelfareData:GetPoolSignCost()

		arg_16_0.prayController_:SetSelectedState("sign")
	elseif var_16_2 == SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY then
		var_16_3, var_16_4 = SpringWelfareData:GetPoolCost()

		arg_16_0.prayController_:SetSelectedState("pray")

		if var_16_4 > ItemTools.getItemNum(var_16_3) then
			local var_16_5 = SpringWelfareData:GetCurSignDay()

			if arg_16_0:CanSign(var_16_5) then
				local var_16_6 = var_16_5

				var_16_3, var_16_4 = SpringWelfareData:GetPoolSignCost()

				arg_16_0.prayController_:SetSelectedState("sign")
			end
		end
	end

	SetActive(arg_16_0.prayCostGo_, true)

	arg_16_0.prayIcon_.sprite = ItemTools.getItemSprite(var_16_3)
	arg_16_0.prayInfoText_.text = var_16_4
end

function var_0_0.OnNewDay(arg_17_0)
	arg_17_0:RefreshUI()

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.branchList_) do
		iter_17_1:RefreshUI()
	end

	if gameContext:GetLastOpenPage() == "springWelfarePrayTree" then
		arg_17_0:NewDayEffect()
	end
end

function var_0_0.OnActivitySpringWelfareInit(arg_18_0)
	arg_18_0:OnNewDay()
end

function var_0_0.OnTaskListChange(arg_19_0)
	SpringWelfareAction:UpdateRedPoint(arg_19_0:GetActivityID())
end

function var_0_0.OnClickBubble(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	JumpTools.OpenPageByJump("springWelfarePrayBranch", {
		day = arg_20_3
	})
end

function var_0_0.TryStartPray(arg_21_0)
	local var_21_0 = SpringWelfareData:GetCurPrayDay()
	local var_21_1 = SpringWelfareData:GetDayState(var_21_0)

	if var_21_1 == SPRING_WELFARE_DAY_STATE_TYPE.ACQUIRED then
		ShowTips("SPRING_WELFARE_ALREADY_PRAY")
	elseif var_21_1 == SPRING_WELFARE_DAY_STATE_TYPE.NOT_ACQUIRE then
		return
	end

	local var_21_2 = false
	local var_21_3 = 0
	local var_21_4 = 0

	if var_21_1 == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
		var_21_3, var_21_4 = SpringWelfareData:GetPoolSignCost()
		var_21_2 = true
	elseif var_21_1 == SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY then
		var_21_3, var_21_4 = SpringWelfareData:GetPoolCost()
	end

	if var_21_4 > ItemTools.getItemNum(var_21_3) then
		local var_21_5 = SpringWelfareData:GetCurSignDay()

		if arg_21_0:CanSign(var_21_5) then
			var_21_0 = var_21_5
			var_21_2 = false
		elseif var_21_3 == 1 then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

			return
		else
			ShowTips("SPRING_WELFARE_PRAY_COST_LACK")

			return
		end
	end

	if not var_21_2 or _G.SkipTip.SkipSpringWelfareResignTip then
		SpringWelfareAction:StartPray(var_21_0, handler(arg_21_0, arg_21_0.OnFinishPray))
	else
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = {
				GetTips("WHETHER_TO_CONSUME"),
				{
					var_21_3,
					var_21_4
				},
				(string.format(GetTips("RESIGN"), var_21_4))
			},
			OkCallback = function()
				SpringWelfareAction:StartPray(var_21_0, handler(arg_21_0, arg_21_0.OnFinishPray))
			end,
			ToggleCallback = function(arg_23_0)
				_G.SkipTip.SkipSpringWelfareResignTip = arg_23_0
			end,
			toggleText = GetTips("LOGIN_MUTE_TIP")
		})
	end
end

function var_0_0.OnFinishPray(arg_24_0, arg_24_1)
	arg_24_0:PlayEffect(function()
		arg_24_0:RefreshUI()

		for iter_25_0, iter_25_1 in ipairs(arg_24_0.branchList_) do
			iter_25_1:RefreshUI()
		end
	end)
end

function var_0_0.PlayEffect(arg_26_0, arg_26_1)
	if arg_26_0.prayAni_ then
		arg_26_0.isAniPlaying_ = true

		manager.windowBar:HideBar()
		SetActive(arg_26_0.prayAniGo_, true)
		arg_26_0.prayAni_:Play("IndiaWishingTreeUI_sign", -1, 0)
		arg_26_0.prayAni_:Update(0)
		AnimatorTools.PlayAnimationWithCallback(arg_26_0.prayAni_, "IndiaWishingTreeUI_sign", function()
			arg_26_0.isAniPlaying_ = false

			SetActive(arg_26_0.prayAniGo_, false)
			arg_26_0:UpdateBar()
			arg_26_1()
		end)
	else
		arg_26_1()
	end
end

function var_0_0.NewDayEffect(arg_28_0)
	local var_28_0 = SpringWelfareData:GetNextNewSystemLetterId()

	if not var_28_0 then
		return
	end

	local var_28_1 = SpringWelfareData:GetLetterData(var_28_0)

	if var_28_1 and not var_28_1.gotReward then
		JumpTools.OpenPageByJump("springWelfareSystemLetter", {
			gotReward = false,
			firstView = true,
			letterServerId = var_28_0
		})
	end
end

function var_0_0.GetDays(arg_29_0)
	return SpringPreheatData:GetMaxProgress()
end

function var_0_0.GetActivityID(arg_30_0)
	return SpringWelfareData:GetActivityId()
end

function var_0_0.CanSign(arg_31_0, arg_31_1)
	arg_31_1 = arg_31_1 or SpringWelfareData:GetCurSignDay()

	if arg_31_1 < 0 then
		return false
	end

	local var_31_0, var_31_1 = SpringWelfareData:GetPoolSignCost()

	if var_31_1 > ItemTools.getItemNum(var_31_0) then
		return false
	end

	return true
end

return var_0_0
