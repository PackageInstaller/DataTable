local var_0_0 = import("manager.windowBar.WindowCurrencyItem")
local var_0_1 = class("KagutsuchiGachaView", ReduxView)

function var_0_1.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionKagutsuchiJackpotUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_1.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.drawController_ = ControllerUtil.GetController(arg_3_0.transform_, "draw")
	arg_3_0.bigDrawController_ = ControllerUtil.GetController(arg_3_0.transform_, "bigDraw")
	arg_3_0.poolRewardItem_ = {}
	arg_3_0.poolRewardItem_[1] = KagutsuchiGachaRewardItem.New(arg_3_0.rewardItem1Go_)
	arg_3_0.poolRewardItem_[2] = KagutsuchiGachaRewardItem.New(arg_3_0.rewardItem2Go_)
	arg_3_0.poolRewardItem_[3] = KagutsuchiGachaRewardItem.New(arg_3_0.rewardItem3Go_)

	local var_3_0 = var_0_0.New(arg_3_0.token2Go_, CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id)

	var_3_0:SetActive(true)
	var_3_0:SetCanAdd(false)
	var_3_0:SetCanClick(true)

	arg_3_0.token2_ = var_3_0
end

function var_0_1.OnEnter(arg_4_0)
	arg_4_0:InitBar()

	arg_4_0.isAniPlaying_ = false

	arg_4_0:RefreshUI()
	arg_4_0:AddTimer()

	local var_4_0 = ActivityConst.KAGUTSUCHI_ACTIVITY
	local var_4_1 = ActivityTools.GetRedPointKey(var_4_0) .. var_4_0
	local var_4_2 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_ONE, var_4_1)
	local var_4_3 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_MULTI, var_4_1)

	manager.redPoint:bindUIandKey(arg_4_0.oneDrawBtn_.transform, var_4_2)
	manager.redPoint:bindUIandKey(arg_4_0.bigDrawBtn_.transform, var_4_3)
	KagutsuchiWorkAction:UpdateRedPoint(ActivityConst.KAGUTSUCHI_ACTIVITY)
end

function var_0_1.InitBar(arg_5_0)
	return
end

function var_0_1.OnExit(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.poolRewardItem_) do
		arg_6_0.poolRewardItem_[iter_6_0]:OnExit()
	end

	AnimatorTools.Stop()
	arg_6_0:StopTimer()

	local var_6_0 = ActivityConst.KAGUTSUCHI_ACTIVITY
	local var_6_1 = ActivityTools.GetRedPointKey(var_6_0) .. var_6_0
	local var_6_2 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_ONE, var_6_1)
	local var_6_3 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_MULTI, var_6_1)

	manager.redPoint:unbindUIandKey(arg_6_0.oneDrawBtn_.transform, var_6_2)
	manager.redPoint:unbindUIandKey(arg_6_0.bigDrawBtn_.transform, var_6_3)
end

function var_0_1.Dispose(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.poolRewardItem_) do
		arg_7_0.poolRewardItem_[iter_7_0]:Dispose()
	end

	arg_7_0.token2_:Dispose()
	var_0_1.super.Dispose(arg_7_0)
end

function var_0_1.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.previewBtn_, nil, function()
		JumpTools.OpenPageByJump("kagutsuchiGachaPreview", {
			activityId = arg_8_0:GetActivityID(),
			poolId = arg_8_0:GetPoolId()
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.oneDrawBtn_, nil, function()
		arg_8_0:TryStartDraw(1)
	end)
	arg_8_0:AddBtnListener(arg_8_0.bigDrawBtn_, nil, function()
		arg_8_0:TryStartDraw(arg_8_0.bigDrawTimes)
	end)
	arg_8_0:AddBtnListener(arg_8_0.backBtn_, nil, function()
		if arg_8_0.isAniPlaying_ then
			return
		end

		JumpTools.Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.homeBtn_, nil, function()
		if arg_8_0.isAniPlaying_ then
			return
		end

		gameContext:Go("/home", nil, nil, true)
	end)
	arg_8_0:AddBtnListener(arg_8_0.infoBtn_, nil, function()
		if arg_8_0.isAniPlaying_ then
			return
		end

		local var_14_0 = "ACTIVITY_KAGUTSUCHI_REWARD_DESCRIBE"
		local var_14_1 = GetTips(var_14_0)

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_14_1,
			key = var_14_0
		})
	end)
end

function var_0_1.RefreshUI(arg_15_0)
	local var_15_0 = arg_15_0:GetPoolId()
	local var_15_1 = KagutsuchiGachaData:GetMaxDrawTimes(var_15_0)
	local var_15_2 = math.max(var_15_1, 2)
	local var_15_3 = KagutsuchiGachaData:GetPoolRemains(var_15_0)

	if var_15_3 == 0 then
		arg_15_0.drawController_:SetSelectedState("empty")
	elseif var_15_3 == 1 then
		arg_15_0.bigDrawController_:SetSelectedState("lack")
	end

	local var_15_4, var_15_5 = KagutsuchiGachaData:GetDrawCost(var_15_0, var_15_2)

	arg_15_0.bigDrawText_.text = var_15_2

	if var_15_1 < 2 then
		arg_15_0.bigDrawCostText_.text = "x<color=#CC0013>" .. var_15_5 .. "</color>"
	else
		arg_15_0.bigDrawCostText_.text = "x" .. var_15_5
	end

	local var_15_6, var_15_7 = KagutsuchiGachaData:GetDrawCost(var_15_0, 1)

	arg_15_0.oneDrawText_.text = 1

	if var_15_1 == 0 then
		arg_15_0.oneDrawCostText_.text = "x<color=#CC0013>" .. var_15_7 .. "</color>"
	else
		arg_15_0.oneDrawCostText_.text = "x" .. var_15_7
	end

	arg_15_0.bigDrawTimes = var_15_2

	arg_15_0:RefreshPoolDisplayItems(var_15_0)

	arg_15_0.coinText_.text = KagutsuchiWorkData:GetCoins()

	local var_15_8 = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id)

	arg_15_0.coinImage_.sprite = var_15_8
	arg_15_0.oneDrawImage_.sprite = var_15_8
	arg_15_0.bigDrawImage_.sprite = var_15_8
end

function var_0_1.RefreshPoolDisplayItems(arg_16_0, arg_16_1)
	local var_16_0 = KagutsuchiGachaData:GetDisplayDrawItemIds(arg_16_1)

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if not arg_16_0.poolRewardItem_[iter_16_0] then
			local var_16_1 = Object.Instantiate(arg_16_0.templateItem_, arg_16_0.poolRewardContent_)

			arg_16_0.poolRewardItem_[iter_16_0] = KagutsuchiGachaRewardItem.New(var_16_1)
		end

		arg_16_0.poolRewardItem_[iter_16_0]:SetData(arg_16_0:GetActivityID(), arg_16_1, iter_16_1)
	end
end

function var_0_1.RefreshTimeUI(arg_17_0)
	local var_17_0 = arg_17_0:GetActivityID()
	local var_17_1 = ActivityData:GetActivityData(var_17_0)

	arg_17_0.timeText_.text = manager.time:GetLostTimeStr2(var_17_1.stopTime, nil)
end

function var_0_1.AddTimer(arg_18_0)
	arg_18_0:StopTimer()
	arg_18_0:RefreshTimeUI()

	arg_18_0.timer_ = Timer.New(function()
		arg_18_0:RefreshTimeUI()
	end, 1, -1)

	arg_18_0.timer_:Start()
end

function var_0_1.StopTimer(arg_20_0)
	if arg_20_0.timer_ then
		arg_20_0.timer_:Stop()

		arg_20_0.timer_ = nil
	end
end

function var_0_1.TryStartDraw(arg_21_0, arg_21_1)
	if arg_21_0.isAniPlaying_ then
		return
	end

	local var_21_0 = arg_21_0:GetPoolId()
	local var_21_1 = KagutsuchiGachaData:GetMaxDrawTimes(var_21_0)
	local var_21_2, var_21_3 = KagutsuchiGachaData:GetDrawCost(var_21_0, arg_21_1)

	if var_21_1 < arg_21_1 then
		ShowTips("ACTIVITY_KAGUTSUCHI_POLL_COST_NOTE_ENOUGH")

		return
	end

	KagutsuchiGachaAction:StartDraw(arg_21_1, arg_21_0:GetActivityID(), var_21_0, handler(arg_21_0, arg_21_0.OnFinishDraw))
end

function var_0_1.OnFinishDraw(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:PlayEffects(function()
		arg_22_0:RefreshUI()

		local var_23_0 = arg_22_1.pool_id
		local var_23_1 = {}

		for iter_23_0, iter_23_1 in ipairs(arg_22_1.reward_list) do
			local var_23_2, var_23_3 = KagutsuchiGachaData:GetDrawItemReward(var_23_0, iter_23_1)

			table.insert(var_23_1, {
				id = var_23_2,
				num = var_23_3
			})
		end

		getReward(var_23_1)
		KagutsuchiWorkAction:UpdateRedPoint(ActivityConst.KAGUTSUCHI_ACTIVITY)
	end)
end

function var_0_1.GetActivityID(arg_24_0)
	return ActivityConst.KAGUTSUCHI_ACTIVITY_REWARD
end

function var_0_1.GetPoolId(arg_25_0)
	return KagutsuchiGachaData:GetPoolIds(arg_25_0:GetActivityID())[1]
end

function var_0_1.PlayEffects(arg_26_0, arg_26_1)
	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_toy", "")

	arg_26_0.isAniPlaying_ = true

	arg_26_0.gachaDrawAni_:Play("JapanRegionKagutsuchiJackpotUI_roll", -1, 0)
	arg_26_0.gachaDrawAni_:Update(0)
	AnimatorTools.PlayAnimationWithCallback(arg_26_0.gachaDrawAni_, "JapanRegionKagutsuchiJackpotUI_roll", function()
		arg_26_0.isAniPlaying_ = false

		arg_26_1()
	end)
end

return var_0_1
