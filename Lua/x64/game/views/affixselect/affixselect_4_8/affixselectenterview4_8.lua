local var_0_0 = class("AffixSelectEnterView4_8", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_AffixSelect/Alone_AffixSelect_StageUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.reward_btnstateController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "reward_btnstate")
	arg_4_0.bonusItem_ = CommonItemView.New(arg_4_0.bonusItemGo_, true)
	arg_4_0.items_ = {}

	for iter_4_0 = 1, 8 do
		local var_4_0 = AffixSelectItemView.New(arg_4_0["itemGo" .. iter_4_0 .. "_"])

		table.insert(arg_4_0.items_, var_4_0)
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("activity_affixbattle_reward_firstpass")
		JumpTools.OpenPageByJump("affixSelectFirstRewardJapanRegion", {
			affixActivityId = arg_5_0.activityId
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.checkBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("activity_affixbattle_reward_score")
		JumpTools.OpenPageByJump("affixSelectScoreRewardJapanRegion", {
			affixActivityId = arg_5_0.activityId
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.getBtn_, nil, function()
		local var_8_0 = ActivityAffixSelectData:GetCurrentActivityReward(arg_5_0.activityId)

		ActivityAction.ReceivePointReward({
			var_8_0
		})
	end)
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:UpdateBar()
end

function var_0_0.OnBehind(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:UpdateBar()

	arg_12_0.activityId = arg_12_0.params_.activityID

	local var_12_0 = ActivityCfg[arg_12_0.activityId].sub_activity_list

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.items_) do
		iter_12_1:SetData(iter_12_0, var_12_0[iter_12_0])
	end

	manager.redPoint:bindUIandKey(arg_12_0.firstPassNoticeContainer_, string.format("%s_%s", RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET, arg_12_0.activityId), {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(arg_12_0.getBtn_.transform, string.format("%s_%s", RedPointConst.AFFIX_SELECT_SCORE_BONUS_CAN_GET, arg_12_0.activityId))
	arg_12_0:UpdateView()

	local var_12_1 = getData("affixSelect", "mainScrollPos")

	if var_12_1 then
		arg_12_0.itemScrollRect_.horizontalNormalizedPosition = var_12_1
	end

	arg_12_0:RegistEventListener(ACTIVITY_REWARD_GET, handler(arg_12_0, arg_12_0.UpdateView))
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
	saveData("affixSelect", "mainScrollPos", arg_13_0.itemScrollRect_.horizontalNormalizedPosition)
	manager.redPoint:unbindUIandKey(arg_13_0.firstPassNoticeContainer_, string.format("%s_%s", RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET, arg_13_0.activityId))
	manager.redPoint:unbindUIandKey(arg_13_0.getBtn_.transform, string.format("%s_%s", RedPointConst.AFFIX_SELECT_SCORE_BONUS_CAN_GET, arg_13_0.activityId))
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.UpdateView(arg_14_0)
	local var_14_0 = ActivityAffixSelectData:GetCurrentActivityReward(arg_14_0.activityId)
	local var_14_1 = ActivityPointRewardCfg[var_14_0]

	arg_14_0.currentScoreLabel_.text = ActivityAffixSelectData:GetTotalScore(arg_14_0.activityId)
	arg_14_0.totalScoreLabel_.text = "/" .. var_14_1.need

	local var_14_2 = ActivityAffixSelectData:GetRewardStatus(arg_14_0.activityId, var_14_0)

	if var_14_2 == 3 then
		arg_14_0.reward_btnstateController_:SetSelectedState("received")
	elseif var_14_2 == 1 then
		arg_14_0.reward_btnstateController_:SetSelectedState("normal")
	else
		arg_14_0.reward_btnstateController_:SetSelectedState("receive")
	end

	arg_14_0.bonusItem_:SetData({
		id = var_14_1.reward_item_list[1][1],
		number = var_14_1.reward_item_list[1][2]
	})

	arg_14_0.bonusItem_.clickFun = CustomClickRewardFunc
	arg_14_0.bonusNumLabel_.text = " "
end

local function var_0_1(arg_15_0)
	ShowPopItem(POP_ITEM, arg_15_0)
end

function var_0_0.OnReceivePointReward(arg_16_0, arg_16_1)
	arg_16_0:UpdateView()
end

function var_0_0.OnMainHomeViewTop(arg_17_0)
	return
end

function var_0_0.Dispose(arg_18_0)
	if arg_18_0.bonusItem_ then
		arg_18_0.bonusItem_:Dispose()

		arg_18_0.bonusItem_ = nil
	end

	if arg_18_0.items_ then
		for iter_18_0, iter_18_1 in pairs(arg_18_0.items_) do
			iter_18_1:Dispose()
		end

		arg_18_0.items_ = nil
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
