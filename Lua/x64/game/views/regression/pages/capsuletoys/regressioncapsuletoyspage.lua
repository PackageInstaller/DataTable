local var_0_0 = class("RegressionCapsuleToysPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/ReturnTwo/RT2stTwistedEggUI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.rewardItemList_ = {}
	arg_2_0.itemDataList_ = {}

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.descText_.text = GetTips("REGRESSION_GASHAPON_DESCRIPE")

	local var_3_0 = GameSetting.regression_gashapon_cost

	arg_3_0.drawOnceIcon_.sprite = ItemTools.getItemSprite(var_3_0.value[1])
	arg_3_0.drawOnceCostText_.text = "x" .. var_3_0.value[2]
	arg_3_0.drawMultiIcon_.sprite = ItemTools.getItemSprite(var_3_0.value[1])
	arg_3_0.drawMultiCostText_.text = "x" .. tostring(var_3_0.value[2] * 10)
	arg_3_0.drawController_ = ControllerUtil.GetController(arg_3_0.transform_, "draw")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.drawOnceBtn_, nil, function()
		if not RegressionData:IsRegressionOpen() then
			ShowTips("TIME_OVER")

			return
		end

		local var_5_0 = GameSetting.regression_gashapon_cost

		if ItemTools.getItemNum(var_5_0.value[1]) >= var_5_0.value[2] then
			manager.audio:PlayEffect("ui_system", "back_niudan")
			arg_4_0.drawController_:SetSelectedState("true")
			RegressionAction.RegressionCapsuleToysDraw(1, handler(arg_4_0, arg_4_0.OnCapsuleToysDraw))
		else
			ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.drawMultipleBtn_, nil, function()
		if not RegressionData:IsRegressionOpen() then
			ShowTips("TIME_OVER")

			return
		end

		local var_6_0 = GameSetting.regression_gashapon_cost
		local var_6_1 = ItemTools.getItemNum(var_6_0.value[1])
		local var_6_2 = var_6_0.value[2]

		if var_6_1 >= var_6_2 * 2 then
			manager.audio:PlayEffect("ui_system", "back_niudan")

			local var_6_3 = math.floor(var_6_1 / var_6_2)

			var_6_3 = var_6_3 <= 10 and var_6_3 or 10

			arg_4_0.drawController_:SetSelectedState("true")
			RegressionAction.RegressionCapsuleToysDraw(var_6_3, handler(arg_4_0, arg_4_0.OnCapsuleToysDraw))
		else
			ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("capsuleToysReward")
	end)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	if arg_8_0.rewardItemList_ then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.rewardItemList_) do
			iter_8_1:Dispose()
		end

		arg_8_0.rewardItemList_ = nil
	end

	Object.Destroy(arg_8_0.gameObject_)

	arg_8_0.transform_ = nil
	arg_8_0.gameObject_ = nil
end

function var_0_0.SetActive(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)

	if arg_9_1 == false and arg_9_0.timer_ ~= nil then
		arg_9_0.timer_:Stop()

		arg_9_0.timer_ = nil
	end

	arg_9_0.drawController_:SetSelectedState("false")
end

function var_0_0.SetData(arg_10_0)
	arg_10_0.version_ = RegressionData:GetRegressionVersion()

	local var_10_0 = RegressionCfg[arg_10_0.version_].gashapon

	arg_10_0.rewardCfgList_ = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if RegressionCapsuleToysCfg[iter_10_1].reward_type == 1 then
			arg_10_0.rewardCfgList_[#arg_10_0.rewardCfgList_ + 1] = iter_10_1
		end
	end

	for iter_10_2, iter_10_3 in ipairs(arg_10_0.rewardCfgList_) do
		if not arg_10_0.rewardItemList_[iter_10_2] then
			arg_10_0.rewardItemList_[iter_10_2] = CapsuleToysRewardItem.New(arg_10_0.goRewardPanel_, arg_10_0.rewardGo_, false)
		end

		arg_10_0.rewardItemList_[iter_10_2]:SetData(iter_10_3)
	end

	for iter_10_4 = #arg_10_0.rewardCfgList_ + 1, #arg_10_0.rewardItemList_ do
		arg_10_0.rewardItemList_[iter_10_4]:Show(false)
	end

	arg_10_0:RefreshMultiDrawBtn()
end

function var_0_0.OnCapsuleToysDraw(arg_11_0, arg_11_1, arg_11_2)
	if isSuccess(arg_11_1.result) then
		local var_11_0 = {}
		local var_11_1 = {}

		for iter_11_0, iter_11_1 in ipairs(arg_11_1.item_list) do
			local var_11_2 = iter_11_1.id
			local var_11_3 = iter_11_1.num

			var_11_0[#var_11_0 + 1] = {
				var_11_2,
				var_11_3
			}

			local var_11_4

			if var_11_2 == 0 then
				var_11_4 = GameSetting.regression_gashapon_reward.value
			else
				var_11_4 = RegressionCapsuleToysCfg[var_11_2].reward
			end

			local var_11_5 = var_11_4[1]
			local var_11_6 = var_11_4[2] * var_11_3

			var_11_1[#var_11_1 + 1] = {
				var_11_5,
				var_11_6
			}
		end

		RegressionData:SetCapsuleToysStatus(var_11_0)
		arg_11_0:GetCapsuleReward(var_11_1)
	else
		ShowTips(arg_11_1.result)
		arg_11_0.drawController_:SetSelectedState("false")
	end
end

function var_0_0.GetCapsuleReward(arg_12_0, arg_12_1)
	arg_12_0:RefreshMultiDrawBtn()

	local var_12_0 = "Fx_niudanji_cx"

	arg_12_0.animator_:Play(var_12_0, -1, 0)
	arg_12_0.animator_:Update(0)

	if arg_12_0.timer_ ~= nil then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end

	arg_12_0.timer_ = Timer.New(function()
		local var_13_0 = arg_12_0.animator_:GetCurrentAnimatorStateInfo(0)

		if var_13_0:IsName(var_12_0) and var_13_0.normalizedTime >= 1 then
			if arg_12_0.timer_ ~= nil then
				arg_12_0.timer_:Stop()

				arg_12_0.timer_ = nil
			end

			arg_12_0:SetData()

			for iter_13_0, iter_13_1 in ipairs(arg_12_1) do
				if iter_13_1[1] == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS or iter_13_1[1] == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS then
					iter_13_1[1] = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE
				end
			end

			arg_12_0.drawController_:SetSelectedState("false")
			JumpTools.OpenPageByJump("capsuleToysGetReward", {
				list = arg_12_1
			})
		end
	end, 0.033, -1)

	arg_12_0.timer_:Start()
end

function var_0_0.UpdateBar(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_NEW_RETURN_COIN
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_NEW_RETURN_COIN, true)
end

function var_0_0.RefreshMultiDrawBtn(arg_15_0)
	local var_15_0 = GameSetting.regression_gashapon_cost
	local var_15_1 = ItemTools.getItemNum(var_15_0.value[1])
	local var_15_2 = var_15_0.value[2]
	local var_15_3 = 2

	if var_15_1 >= var_15_2 * 2 then
		local var_15_4 = math.floor(var_15_1 / var_15_2)

		var_15_3 = var_15_4 <= 10 and var_15_4 or 10
	end

	arg_15_0.multiDrawTimesText_.text = string.format(GetTips("REGRESSION_GASHAPON_EXTRACT"), var_15_3)
	arg_15_0.drawMultiCostText_.text = "x" .. tostring(var_15_2 * var_15_3)
end

function var_0_0.OnExit(arg_16_0)
	if arg_16_0.timer_ ~= nil then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

return var_0_0
