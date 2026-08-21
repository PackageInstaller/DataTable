local var_0_0 = class("AffixSelectMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/DarkFlameUI/DFQualsDrilUI/DFQualsDrillStageUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.reward_btnstateController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "reward_btnstate")
	arg_5_0.bonusItem_ = CommonItem.New(arg_5_0.bonusItemGo_)
	arg_5_0.items_ = {}

	for iter_5_0 = 1, 8 do
		local var_5_0 = AffixSelectItemView.New(arg_5_0["itemGo" .. iter_5_0 .. "_"])

		table.insert(arg_5_0.items_, var_5_0)
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("affixSelectFirstReward", {
			affixActivityId = arg_6_0.activityId
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.checkBtn_, nil, function()
		JumpTools.OpenPageByJump("affixSelectScoreReward", {
			affixActivityId = arg_6_0.activityId
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.getBtn_, nil, function()
		local var_9_0 = ActivityAffixSelectData:GetCurrentActivityReward(arg_6_0.activityId)

		ActivityAction.ReceivePointReward({
			var_9_0
		})
	end)
	arg_6_0.bonusItem_:RegistCallBack(function(arg_10_0)
		ShowPopItem(POP_ITEM, {
			arg_10_0.id
		})
	end)
end

function var_0_0.AddEventListeners(arg_11_0)
	return
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.OnBehind(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("AFFIX_SELECT_HELP")
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0:AddEventListeners()

	arg_15_0.activityId = arg_15_0.params_.activityID

	local var_15_0 = ActivityCfg[arg_15_0.activityId].sub_activity_list

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.items_) do
		iter_15_1:SetData(iter_15_0, var_15_0[iter_15_0])
	end

	ActivityAffixSelectAction.ReadUnPassRedPoint()
	manager.redPoint:bindUIandKey(arg_15_0.firstPassNoticeContainer_, string.format("%s_%s", RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET, arg_15_0.activityId), {
		x = 0,
		y = 0
	})
	arg_15_0:UpdateView()

	local var_15_1 = getData("affixSelect", "mainScrollPos")

	if var_15_1 then
		arg_15_0.itemScrollRect_.horizontalNormalizedPosition = var_15_1
	end

	arg_15_0:StartTimer()
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:StopTimer()
	arg_16_0:RemoveAllEventListener()
	saveData("affixSelect", "mainScrollPos", arg_16_0.itemScrollRect_.horizontalNormalizedPosition)
	manager.redPoint:unbindUIandKey(arg_16_0.firstPassNoticeContainer_)
	manager.windowBar:HideBar()
end

function var_0_0.StartTimer(arg_17_0)
	if arg_17_0.timer_ == nil then
		arg_17_0.timer_ = Timer.New(function()
			arg_17_0:UpdateTimer()
		end, 1, -1)
	end

	arg_17_0.timer_:Start()
end

function var_0_0.StopTimer(arg_19_0)
	if arg_19_0.timer_ then
		arg_19_0.timer_:Stop()

		arg_19_0.timer_ = nil
	end
end

function var_0_0.UpdateTimer(arg_20_0)
	local var_20_0 = ActivityData:GetActivityData(arg_20_0.activityId).stopTime

	arg_20_0.lastTimeLabel_.text = manager.time:GetLostTimeStr2(var_20_0)
end

function var_0_0.UpdateView(arg_21_0)
	local var_21_0 = ActivityAffixSelectData:GetCurrentActivityReward(arg_21_0.activityId)
	local var_21_1 = ActivityPointRewardCfg[var_21_0]

	arg_21_0.currentScoreLabel_.text = ActivityAffixSelectData:GetTotalScore(arg_21_0.activityId)
	arg_21_0.totalScoreLabel_.text = "/" .. var_21_1.need

	local var_21_2 = ActivityAffixSelectData:GetRewardStatus(arg_21_0.activityId, var_21_0)

	if var_21_2 == 0 then
		arg_21_0.reward_btnstateController_:SetSelectedState("received")
	elseif var_21_2 == 1 then
		arg_21_0.reward_btnstateController_:SetSelectedState("normal")
	else
		arg_21_0.reward_btnstateController_:SetSelectedState("receive")
	end

	arg_21_0.bonusItem_:RefreshData({
		id = var_21_1.reward_item_list[1][1],
		number = var_21_1.reward_item_list[1][2]
	})
	arg_21_0.bonusItem_:SetBottomText("")

	arg_21_0.bonusNumLabel_.text = var_21_1.reward_item_list[1][2]

	arg_21_0:UpdateTimer()
end

function var_0_0.OnReceivePointReward(arg_22_0, arg_22_1)
	arg_22_0:UpdateView()
end

function var_0_0.OnMainHomeViewTop(arg_23_0)
	return
end

function var_0_0.Dispose(arg_24_0)
	if arg_24_0.bonusItem_ then
		arg_24_0.bonusItem_:Dispose()

		arg_24_0.bonusItem_ = nil
	end

	if arg_24_0.items_ then
		for iter_24_0, iter_24_1 in pairs(arg_24_0.items_) do
			iter_24_1:Dispose()
		end

		arg_24_0.items_ = nil
	end

	arg_24_0:StopTimer()
	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
