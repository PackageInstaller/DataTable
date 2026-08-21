local var_0_0 = class("PassportRewardPageView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.HeadTailChangeHandler(arg_3_0, arg_3_1, arg_3_2)
	arg_3_2 = arg_3_2 + 1
	arg_3_2 = math.max(1, arg_3_2)

	if not arg_3_0.minEndIndex_ then
		arg_3_0.minEndIndex_ = arg_3_2
	end

	arg_3_0.nearestBonusIndex_ = arg_3_0:GetNextBonusIndex(arg_3_2)

	arg_3_0:UpdateNextBonus()
end

function var_0_0.UpdateNextBonus(arg_4_0)
	local var_4_0 = BattlePassCfg[arg_4_0.rewardIdList_[arg_4_0.nearestBonusIndex_]]
	local var_4_1 = GameLevelSetting[arg_4_0.nearestBonusIndex_]

	arg_4_0.nextBonusLevelLabel_.text = string.format("%d", arg_4_0.nearestBonusIndex_)
	arg_4_0.nextBonusBottomLabel_.text = string.format("%d", arg_4_0.nearestBonusIndex_)

	arg_4_0.nextCommonItem1_:RefreshData({
		id = var_4_0.reward_free[1][1],
		number = var_4_0.reward_free[1][2]
	})
	arg_4_0.nextCommonItem2_:RefreshData({
		id = var_4_0.reward_pay[1][1],
		number = var_4_0.reward_pay[1][2]
	})

	local var_4_2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP)
	local var_4_3 = PassportData:HaveGetBonus(var_4_0.id)
	local var_4_4 = PassportData:GetPayLevel() > 0 and "pay" or "free"

	if var_4_3 then
		arg_4_0.statusController_:SetSelectedState(var_4_4 .. "HaveGet")
	elseif var_4_2 >= var_4_1.battlepass_lv_exp_sum then
		if var_4_4 == "free" then
			arg_4_0.statusController_:SetSelectedState(var_4_4 .. "CanGet")
		elseif PassportData:HaveReceiveInfo(var_4_0.id) then
			arg_4_0.statusController_:SetSelectedState(var_4_4 .. "HalfCanGet")
		else
			arg_4_0.statusController_:SetSelectedState(var_4_4 .. "CanGet")
		end
	else
		arg_4_0.statusController_:SetSelectedState(var_4_4 .. "CannotGet")
	end
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0:AdaptScreen()
	arg_5_0:AddEventListeners()
end

function var_0_0.Show(arg_6_0)
	SetActive(arg_6_0.gameObject_, true)
end

function var_0_0.Hide(arg_7_0)
	SetActive(arg_7_0.gameObject_, false)
end

function var_0_0.OnBuyPassportLevel(arg_8_0)
	arg_8_0.list_:Refresh()
	arg_8_0:UpdateView()
	arg_8_0:UpdateNextBonus()
end

return var_0_0
