local var_0_0 = class("NewServerCapsuleToysPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/NewServer/NewServerGashaponUI")
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
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.drawOnceBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(arg_4_0.activityID_) then
			return
		end

		local var_5_0 = NewServerCfg[arg_4_0.activityID_].coin_id

		if NewServerCfg[arg_4_0.activityID_].coin_num <= ItemTools.getItemNum(var_5_0) then
			manager.audio:PlayEffect("ui_system", "back_niudan")
			NewServerAction.CapsuleToysDraw(1, handler(arg_4_0, arg_4_0.OnCapsuleToysDraw))
		else
			ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.drawMultipleBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(arg_4_0.activityID_) then
			return
		end

		local var_6_0 = NewServerCfg[arg_4_0.activityID_].coin_id
		local var_6_1 = NewServerCfg[arg_4_0.activityID_].coin_num
		local var_6_2 = ItemTools.getItemNum(var_6_0)

		if var_6_2 >= var_6_1 * 2 then
			manager.audio:PlayEffect("ui_system", "back_niudan")

			local var_6_3 = math.floor(var_6_2 / var_6_1)

			var_6_3 = var_6_3 <= 10 and var_6_3 or 10

			NewServerAction.CapsuleToysDraw(var_6_3, handler(arg_4_0, arg_4_0.OnCapsuleToysDraw))
		else
			ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("newServerCapsuleToysReward", {
			activityID = arg_4_0.activityID_
		})
	end)
end

function var_0_0.Dispose(arg_8_0)
	if arg_8_0.rewardItemList_ then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.rewardItemList_) do
			iter_8_1:Dispose()
		end

		arg_8_0.rewardItemList_ = nil
	end

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.SetActive(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)

	if arg_9_1 == false then
		if arg_9_0.timer_ ~= nil then
			arg_9_0.timer_:Stop()

			arg_9_0.timer_ = nil
		end

		manager.ui:UIEventEnabledByUI(true, false)
	end
end

function var_0_0.SetData(arg_10_0, arg_10_1)
	arg_10_0.activityID_ = arg_10_1

	local var_10_0 = NewServerCfg[arg_10_0.activityID_].gashapon

	arg_10_0.rewardCfgList_ = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if NewServerCapsuleToysCfg[iter_10_1].reward_type == 1 then
			arg_10_0.rewardCfgList_[#arg_10_0.rewardCfgList_ + 1] = iter_10_1
		end
	end

	for iter_10_2, iter_10_3 in ipairs(arg_10_0.rewardCfgList_) do
		if not arg_10_0.rewardItemList_[iter_10_2] then
			local var_10_1 = Object.Instantiate(arg_10_0.rewardGo_, arg_10_0.rewardPanelTrans_)

			arg_10_0.rewardItemList_[iter_10_2] = NewServerCapsuleToysItem.New(var_10_1)
		end

		arg_10_0.rewardItemList_[iter_10_2]:SetData(iter_10_3)
	end

	for iter_10_4 = #arg_10_0.rewardCfgList_ + 1, #arg_10_0.rewardItemList_ do
		arg_10_0.rewardItemList_[iter_10_4]:Show(false)
	end

	local var_10_2 = NewServerCfg[arg_10_0.activityID_].coin_id
	local var_10_3 = NewServerCfg[arg_10_0.activityID_].coin_num

	arg_10_0.drawOnceIcon_.sprite = ItemTools.getItemSprite(var_10_2)
	arg_10_0.drawOnceCostText_.text = "x" .. var_10_3
	arg_10_0.drawMultiIcon_.sprite = ItemTools.getItemSprite(var_10_2)
	arg_10_0.drawMultiCostText_.text = "x" .. tostring(var_10_3 * 10)

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
				var_11_4 = NewServerCfg[arg_11_0.activityID_].gashapon_default
			else
				var_11_4 = NewServerCapsuleToysCfg[var_11_2].reward
			end

			local var_11_5 = var_11_4[1]
			local var_11_6 = var_11_4[2] * var_11_3

			var_11_1[#var_11_1 + 1] = {
				id = var_11_5,
				num = var_11_6
			}
		end

		NewServerData:SetCapsuleToysStatus(var_11_0)
		arg_11_0:GetCapsuleReward(var_11_1)
	else
		ShowTips(arg_11_1.result)
	end
end

function var_0_0.GetCapsuleReward(arg_12_0, arg_12_1)
	manager.ui:UIEventEnabledByUI(false, true)
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

			arg_12_0:SetData(arg_12_0.activityID_)

			for iter_13_0, iter_13_1 in ipairs(arg_12_1) do
				if iter_13_1.id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS or iter_13_1.id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS then
					iter_13_1.id = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE
				end
			end

			manager.ui:UIEventEnabledByUI(true, false)
			getReward(arg_12_1)
		end
	end, 0.033, -1)

	arg_12_0.timer_:Start()
end

function var_0_0.UpdateBar(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NewServerCfg[arg_14_0.activityID_].coin_id
	})
	manager.windowBar:SetBarCanClick(NewServerCfg[arg_14_0.activityID_].coin_id, true)
end

function var_0_0.RefreshMultiDrawBtn(arg_15_0)
	local var_15_0 = NewServerCfg[arg_15_0.activityID_].coin_id
	local var_15_1 = NewServerCfg[arg_15_0.activityID_].coin_num
	local var_15_2 = ItemTools.getItemNum(var_15_0)
	local var_15_3 = 2

	if var_15_2 >= var_15_1 * 2 then
		local var_15_4 = math.floor(var_15_2 / var_15_1)

		var_15_3 = var_15_4 <= 10 and var_15_4 or 10
	end

	arg_15_0.multiDrawTimesText_.text = string.format(GetTips("REGRESSION_GASHAPON_EXTRACT"), var_15_3)
	arg_15_0.drawMultiCostText_.text = "x" .. tostring(var_15_1 * var_15_3)
end

function var_0_0.OnExit(arg_16_0)
	if arg_16_0.timer_ ~= nil then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

return var_0_0
