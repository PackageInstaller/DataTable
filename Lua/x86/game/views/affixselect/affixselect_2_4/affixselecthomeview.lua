local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("AffixSelectHomeView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "Widget/Version/NorseUI_3_2/NorseUI_3_2_AffixSelect/NorseUI_3_2_StageUI"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.reward_btnstateController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "reward_btnstate")
	arg_3_0.bonusItem_ = CommonItem.New(arg_3_0.bonusItemGo_)
	arg_3_0.items_ = {}

	for iter_3_0 = 1, 8 do
		local var_3_0 = AffixSelectItemView.New(arg_3_0["itemGo" .. iter_3_0 .. "_"])

		table.insert(arg_3_0.items_, var_3_0)
	end
end

function var_0_1.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.rewardBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("activity_affixbattle_reward_firstpass")
		JumpTools.OpenPageByJump("affixSelectFirstRewardJapanRegion", {
			affixActivityId = arg_4_0.activityId
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.checkBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("activity_affixbattle_reward_score")
		JumpTools.OpenPageByJump("affixSelectScoreRewardJapanRegion", {
			affixActivityId = arg_4_0.activityId
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.getBtn_, nil, function()
		local var_7_0 = ActivityAffixSelectData:GetCurrentActivityReward(arg_4_0.activityId)

		ActivityAction.ReceivePointReward({
			var_7_0
		})
	end)
	arg_4_0.bonusItem_:RegistCallBack(function(arg_8_0)
		ShowPopItem(POP_ITEM, {
			arg_8_0.id
		})
	end)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_tipBtn, function()
		local var_9_0 = GetTips("ACTIVITY_SKADI_SEA_DESCRIBE")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_AFFIX_DESCRIBE")
		})
	end)
end

function var_0_1.OnEnter(arg_10_0)
	arg_10_0.activityId = ActivityConst.ACTIVITY_3_2_AFFIX_SELECT

	local var_10_0 = ActivityCfg[arg_10_0.activityId].sub_activity_list

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.items_) do
		iter_10_1:SetData(iter_10_0, var_10_0[iter_10_0])
	end

	ActivityAffixSelectAction.ReadUnPassRedPoint()
	manager.redPoint:bindUIandKey(arg_10_0.firstPassNoticeContainer_, string.format("%s_%s", RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET, arg_10_0.activityId), {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(arg_10_0.getBtn_.transform, string.format("%s_%s", RedPointConst.AFFIX_SELECT_SCORE_BONUS_CAN_GET, arg_10_0.activityId))
	arg_10_0:UpdateView()

	local var_10_1 = getData("affixSelect", "mainScrollPos")

	if var_10_1 then
		arg_10_0.itemScrollRect_.horizontalNormalizedPosition = var_10_1
	end

	arg_10_0:StartTimer()
	arg_10_0:RegistEventListener(ACTIVITY_REWARD_GET, handler(arg_10_0, arg_10_0.UpdateView))
end

function var_0_1.OnExit(arg_11_0)
	arg_11_0:StopTimer()
	arg_11_0:RemoveAllEventListener()
	saveData("affixSelect", "mainScrollPos", arg_11_0.itemScrollRect_.horizontalNormalizedPosition)
	manager.redPoint:unbindUIandKey(arg_11_0.firstPassNoticeContainer_)
	manager.redPoint:unbindUIandKey(arg_11_0.getBtn_.transform)
	arg_11_0:RemoveAllEventListener()
end

function var_0_1.StartTimer(arg_12_0)
	if arg_12_0.timer_ == nil then
		arg_12_0.timer_ = Timer.New(function()
			arg_12_0:UpdateTimer()
		end, 1, -1)
	end

	arg_12_0.timer_:Start()
end

function var_0_1.StopTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end
end

function var_0_1.UpdateTimer(arg_15_0)
	local var_15_0 = ActivityData:GetActivityData(arg_15_0.activityId).stopTime

	arg_15_0.lastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_15_0)
end

function var_0_1.UpdateView(arg_16_0)
	local var_16_0 = ActivityAffixSelectData:GetCurrentActivityReward(arg_16_0.activityId)
	local var_16_1 = ActivityPointRewardCfg[var_16_0]

	arg_16_0.currentScoreLabel_.text = ActivityAffixSelectData:GetTotalScore(arg_16_0.activityId)
	arg_16_0.totalScoreLabel_.text = "/" .. var_16_1.need

	local var_16_2 = ActivityAffixSelectData:GetRewardStatus(arg_16_0.activityId, var_16_0)

	if var_16_2 == 0 then
		arg_16_0.reward_btnstateController_:SetSelectedState("received")
	elseif var_16_2 == 1 then
		arg_16_0.reward_btnstateController_:SetSelectedState("normal")
	else
		arg_16_0.reward_btnstateController_:SetSelectedState("receive")
	end

	arg_16_0.bonusItem_:RefreshData({
		id = var_16_1.reward_item_list[1][1],
		number = var_16_1.reward_item_list[1][2]
	})
	arg_16_0.bonusItem_:SetBottomText("")

	arg_16_0.bonusNumLabel_.text = var_16_1.reward_item_list[1][2]

	arg_16_0:UpdateTimer()
end

function var_0_1.OnReceivePointReward(arg_17_0, arg_17_1)
	arg_17_0:UpdateView()
end

function var_0_1.OnMainHomeViewTop(arg_18_0)
	return
end

function var_0_1.Dispose(arg_19_0)
	if arg_19_0.bonusItem_ then
		arg_19_0.bonusItem_:Dispose()

		arg_19_0.bonusItem_ = nil
	end

	if arg_19_0.items_ then
		for iter_19_0, iter_19_1 in pairs(arg_19_0.items_) do
			iter_19_1:Dispose()
		end

		arg_19_0.items_ = nil
	end

	arg_19_0:StopTimer()
	var_0_1.super.Dispose(arg_19_0)
end

return var_0_1
