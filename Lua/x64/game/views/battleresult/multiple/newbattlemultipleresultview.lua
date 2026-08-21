NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("NewBattleMultipleResultView", NewBattleSettlementView)

function var_0_0.OnAddListner(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.nextStageBtn_, nil, function()
		arg_1_0:OnceMoreFunc()
	end)
	SetActive(arg_1_0.costImage_.gameObject, false)
end

function var_0_0.Init(arg_3_0)
	arg_3_0.hasSnapshot_ = GetBattleResultSnapShot()

	arg_3_0:InitUI()

	arg_3_0.btnController = arg_3_0.btnController_:GetController("btn")
	arg_3_0.multiController = arg_3_0.multiController_:GetController("double")
	arg_3_0.adaptComp = arg_3_0:FindCom("AdaptImage", nil, arg_3_0.commonMaskBg_.transform)

	arg_3_0:AddListener()
end

function var_0_0.ShowCost(arg_4_0)
	local var_4_0 = arg_4_0.stageData:GetCost()
	local var_4_1 = arg_4_0.stageData:GetMultiple()
	local var_4_2 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
	local var_4_3 = CurrencyConst.CURRENCY_TYPE_VITALITY

	if arg_4_0.stageType ~= BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE and arg_4_0.stageType ~= BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL then
		SetActive(arg_4_0.costImage_.gameObject, true)

		if var_4_2 >= var_4_0 * var_4_1 then
			arg_4_0.vitalityCostText_.text = string.format("<color=#%s>%s</color>", ColorConst.BLACK_HEX, var_4_0 * var_4_1)
		else
			arg_4_0.vitalityCostText_.text = string.format("<color=#%s>%s</color>", ColorConst.RED_HEX, var_4_0 * var_4_1)
		end
	else
		SetActive(arg_4_0.costImage_.gameObject, false)
	end
end

function var_0_0.ShowContent(arg_5_0)
	arg_5_0:onRenderMultiResultContent()
end

function var_0_0.onRenderMultiResultContent(arg_6_0)
	if not arg_6_0.multiView then
		arg_6_0.multiView = BattleSettlementMultiResultModule.New(arg_6_0.contentContainer_)
	end

	arg_6_0.multiView:RenderView({
		stageData = arg_6_0.stageData,
		rewardList = arg_6_0.params_.rewardList,
		extraReward = arg_6_0.params_.extraReward,
		rewardTimes = arg_6_0.params_.multiple
	})
	arg_6_0.multiController:SetSelectedState("false")

	if arg_6_0.params_.extraReward then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.params_.extraReward) do
			if type(iter_6_1) == "table" and #iter_6_1 > 0 then
				local var_6_0, var_6_1, var_6_2 = ActivityMultiRewardData:GetLastBattleMultiData()
				local var_6_3
				local var_6_4
				local var_6_5
				local var_6_6 = RegressionDataNew:GetMultipleUseTimes()
				local var_6_7 = RegressionDataNew:GetLastMultipleUseTimes()

				if var_6_6 > 0 and var_6_7 > 0 then
					var_6_3, var_6_4, var_6_5 = RegressionDataNew:GetMultipleValue()
				end

				if var_6_3 ~= nil and var_6_4 ~= nil and var_6_5 ~= nil then
					arg_6_0.multiCountText_.text = string.format(GetTips("NEW_REGRESSION_DOUBLE_REWARD_DESC"), var_6_3, var_6_4)
					arg_6_0.multiRatioText_.text = var_6_5 / 100
				else
					arg_6_0.multiCountText_.text = string.format(GetTips("NEW_REGRESSION_DOUBLE_REWARD_DESC"), var_6_0, var_6_1)
					arg_6_0.multiRatioText_.text = var_6_2 / 100
				end

				arg_6_0.multiController:SetSelectedState("true")

				break
			end
		end
	end

	arg_6_0:SetBtnOnceMore()
end

function var_0_0.SetBtnOnceMore(arg_7_0)
	if arg_7_0.stageType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT then
		SetActive(arg_7_0.nextStageBtn_.gameObject, false)
	else
		SetActive(arg_7_0.nextStageBtn_.gameObject, arg_7_0:NeedOnceMore())
	end
end

function var_0_0.NeedOnceMore(arg_8_0)
	if arg_8_0.params_.notOnceMore then
		return false
	end

	return true
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.multiView:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
