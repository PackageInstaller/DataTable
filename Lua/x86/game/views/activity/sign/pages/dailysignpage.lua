local var_0_0 = class("DailySignPage", BaseSignPage)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.hander_ = arg_1_1

	local var_1_0 = Asset.Load("Widget/System/ActivitySign/SignUI")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.animPlaying = false
	arg_3_0.signItem_ = {}
	arg_3_0.itemList_ = {}
	arg_3_0.accuController_ = arg_3_0.accumulateControllerEx_:GetController("sel")
	arg_3_0.itemNumController_ = arg_3_0.accumulateControllerEx_:GetController("number")
	arg_3_0.accuStateontroller_ = arg_3_0.accumulateControllerEx_:GetController("state")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.accumulateBtn_, nil, function()
		JumpTools.OpenPageByJump("accumulateSignView")
	end)
end

function var_0_0.OnShow(arg_6_0)
	arg_6_0:RefreshSignItem()
end

function var_0_0.OnHide(arg_7_0)
	if arg_7_0.timer_ then
		arg_7_0.timer_:Stop()

		arg_7_0.timer_ = nil
	end

	if arg_7_0.accutimer_ then
		arg_7_0.accutimer_:Stop()

		arg_7_0.accutimer_ = nil
	end
end

function var_0_0.RefreshSignItem(arg_8_0)
	local var_8_0 = SignData:GetDailySignInfo().month
	local var_8_1 = manager.time:CalcMonthDays(manager.time:STimeDescS(manager.time:GetServerTime(), "!%Y"), var_8_0)

	for iter_8_0 = #arg_8_0.signItem_, var_8_1 + 1, -1 do
		arg_8_0.signItem_[iter_8_0]:Show(false)
	end

	for iter_8_1 = 1, var_8_1 do
		if not arg_8_0.signItem_[iter_8_1] then
			local var_8_2 = Object.Instantiate(arg_8_0.itemGo_, arg_8_0.contentParent_)

			arg_8_0.signItem_[iter_8_1] = DailySignItem.New(arg_8_0, var_8_2)
		end

		local var_8_3 = {
			month = var_8_0,
			day = iter_8_1,
			state = SignTools.GetDailySignState(iter_8_1)
		}

		arg_8_0.signItem_[iter_8_1]:SetData(var_8_3)
	end

	local var_8_4, var_8_5, var_8_6, var_8_7, var_8_8 = AccumulateSignData:GetShowProgress()

	arg_8_0.accumulateSlider_.value = var_8_6
	arg_8_0.accumulateText_.text = var_8_4 .. "/" .. var_8_5

	if AccumulateSignData:GetCanReward() then
		arg_8_0.accuController_:SetSelectedIndex(1)
	else
		arg_8_0.accuController_:SetSelectedIndex(0)
	end

	local var_8_9 = AccumulateLoginCfg[var_8_7]
	local var_8_10 = {}

	if var_8_9 then
		var_8_10 = var_8_9.reward
	end

	arg_8_0.itemNumController_:SetSelectedIndex(#var_8_10 - 1)

	for iter_8_2 = 1, #var_8_10 do
		if not arg_8_0.itemList_[iter_8_2] then
			local var_8_11 = arg_8_0["commonItem_" .. iter_8_2]

			arg_8_0.itemList_[iter_8_2] = CommonItemView.New(var_8_11, true)
		end

		arg_8_0.itemList_[iter_8_2]:SetData(var_8_10[iter_8_2])
		arg_8_0.itemList_[iter_8_2]:RefreshCompleted(var_8_8)
		arg_8_0.itemList_[iter_8_2]:Show(true)
	end

	if not AccumulateSignData:GetIsOpened() then
		SetActive(arg_8_0.accumulateGo_, true)
		arg_8_0.accuStateontroller_:SetSelectedState("normal")
	else
		SetActive(arg_8_0.accumulateGo_, false)
		arg_8_0.accuStateontroller_:SetSelectedState("first")
	end
end

function var_0_0.AutoGetReward(arg_9_0)
	arg_9_0.signIndex_ = SignTools.GetDailySignIndex()

	if arg_9_0.signIndex_ > 0 then
		manager.notify:CallUpdateFunc(SIGN_INPUT, false)

		arg_9_0.timer_ = Timer.New(function()
			SignAction.QueryDailySign()
		end, 0.033, 1)

		arg_9_0.timer_:Start()
	end
end

function var_0_0.OnSign(arg_11_0, arg_11_1)
	if isSuccess(arg_11_1.result) then
		if arg_11_0.signIndex_ <= 0 then
			return
		end

		arg_11_0.signItem_[arg_11_0.signIndex_]:StartPlayAnimator()

		arg_11_0.timer_ = Timer.New(function()
			if arg_11_0.signItem_[arg_11_0.signIndex_]:GetAnimator():GetCurrentAnimatorStateInfo(0).normalizedTime >= 2 or not arg_11_0.animPlaying then
				if arg_11_0.animPlaying then
					manager.notify:CallUpdateFunc(READY_TO_SKIP_SIGN_ANIMATION, true)
				end

				local var_12_0 = arg_11_1.item_list

				if AccumulateSignData:GetIsOpened() then
					getReward2(var_12_0, {
						ItemConst.ITEM_TYPE.HERO,
						ItemConst.ITEM_TYPE.WEAPON_SERVANT
					}, function()
						manager.ui:UIEventEnabled(false)

						arg_11_0.accuAnimator_.enabled = true

						arg_11_0.accuAnimator_:Play("UI_nd_unlock")

						arg_11_0.accutimer_ = Timer.New(function()
							if arg_11_0.accuAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1.5 then
								manager.ui:UIEventEnabled(true)
								arg_11_0.accutimer_:Stop()

								arg_11_0.accutimer_ = nil

								arg_11_0.accuStateontroller_:SetSelectedState("normal")
								arg_11_0.accuAnimator_:Play("Default")
								JumpTools.OpenPageByJump("accumulateSignView", {
									check_sign = true
								})
							end
						end, 0.033, -1)

						arg_11_0.accutimer_:Start()
						arg_11_0.accuStateontroller_:SetSelectedState("ani")
					end)
				elseif AccumulateSignData:GetCanReward() then
					getReward2(var_12_0, {
						ItemConst.ITEM_TYPE.HERO,
						ItemConst.ITEM_TYPE.WEAPON_SERVANT
					}, function()
						JumpTools.OpenPageByJump("accumulateSignView", {
							check_sign = true
						})
					end)
				else
					getReward2(var_12_0, {
						ItemConst.ITEM_TYPE.HERO,
						ItemConst.ITEM_TYPE.WEAPON_SERVANT
					}, handler(arg_11_0.hander_, arg_11_0.hander_.CheckSign))
				end

				arg_11_0.timer_:Stop()

				arg_11_0.timer_ = nil
			end
		end, 0.033, -1)

		manager.notify:CallUpdateFunc(SIGN_INPUT, true)
		manager.notify:CallUpdateFunc(READY_TO_SKIP_SIGN_ANIMATION, false)
		arg_11_0.timer_:Start()
	else
		manager.notify:CallUpdateFunc(SIGN_INPUT, true)
		ShowTips(arg_11_1.result)
	end
end

function var_0_0.OnAccumulateLoginRefresh(arg_16_0)
	arg_16_0:RefreshSignItem()
end

function var_0_0.Dispose(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.signItem_) do
		iter_17_1:Dispose()
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.itemList_) do
		iter_17_3:Dispose()
	end

	arg_17_0.signItem_ = {}

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
