local var_0_0 = class("SevenDaySignPage", BaseSignPage)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.hander_ = arg_1_1
	arg_1_0.activit_id = arg_1_3

	local var_1_0 = Asset.Load(ActivityCumulativeSignCfg[arg_1_0.activit_id].ui_path)

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:Refresh()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.animPlaying = false
	arg_3_0.scrollHelper = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.m_list, SevenDaySignItem)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:Show()
end

function var_0_0.OnShow(arg_5_0)
	arg_5_0:Refresh()
	arg_5_0:RefreshSignItem()
end

function var_0_0.OnHide(arg_6_0)
	if arg_6_0.remainingTimer then
		arg_6_0.remainingTimer:Stop()

		arg_6_0.remainingTimer = nil
	end
end

function var_0_0.RefreshSignItem(arg_7_0)
	local var_7_0 = SignData:GetSevenDaySignInfo(arg_7_0.activit_id)
	local var_7_1 = SignTools.GetSevenDaySignIndex(arg_7_0.activit_id)
	local var_7_2 = 0

	if var_7_1 ~= 0 then
		var_7_2 = var_7_1
	elseif var_7_0 ~= nil then
		var_7_2 = var_7_0.signCount
	end

	local var_7_3 = #ActivityCumulativeSignCfg[arg_7_0.activit_id].config_list

	arg_7_0.scrollHelper:StartScroll(var_7_3, var_7_2)
end

function var_0_0.indexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = ActivityCumulativeSignCfg[arg_8_0.activit_id]
	local var_8_1 = var_8_0.config_list[arg_8_1]
	local var_8_2 = SignTools.GetSevenDaySignState(arg_8_0.activit_id, arg_8_1)
	local var_8_3 = #var_8_0.config_list
	local var_8_4 = false

	if var_8_3 == 14 then
		var_8_4 = true
	end

	arg_8_2:Refresh(arg_8_1, var_8_1, var_8_2, var_8_4)
end

function var_0_0.Refresh(arg_9_0)
	if arg_9_0.remainingTimer then
		arg_9_0.remainingTimer:Stop()

		arg_9_0.remainingTimer = nil
	end

	arg_9_0.remainingTimer = Timer.New(function()
		arg_9_0:RefreshTime()
	end, 1, -1)

	arg_9_0.remainingTimer:Start()
	arg_9_0:RefreshTime()
end

function var_0_0.RefreshTime(arg_11_0)
	local var_11_0 = ActivityData:GetActivityData(arg_11_0.activit_id)

	if var_11_0 then
		local var_11_1 = var_11_0.stopTime
		local var_11_2 = manager.time:GetLostTimeStrWith2Unit(var_11_1)

		arg_11_0.m_timer.text = string.format(GetTips("LEFT_TIME"), var_11_2)
	end
end

function var_0_0.AutoGetReward(arg_12_0)
	arg_12_0.signIndex_ = SignTools.GetSevenDaySignIndex(arg_12_0.activit_id)

	if arg_12_0.signIndex_ > 0 then
		manager.notify:CallUpdateFunc(SIGN_INPUT, false)

		if arg_12_0.timer_ then
			arg_12_0.timer_:Stop()
		end

		local var_12_0 = #ActivityCumulativeSignCfg[arg_12_0.activit_id].config_list or 7

		if var_12_0 > 7 then
			var_12_0 = 7
		end

		arg_12_0.timer_ = nil
		arg_12_0.limitTime = 0
		arg_12_0.timer_ = Timer.New(function()
			arg_12_0.limitTime = arg_12_0.limitTime + 0.033

			if #arg_12_0.scrollHelper:GetItemList() >= var_12_0 or arg_12_0.limitTime > 1 then
				SignAction.QuerySevenDaySign(arg_12_0.activit_id)
				arg_12_0.timer_:Stop()

				arg_12_0.timer_ = nil
			end
		end, 0.033, -1)

		arg_12_0.timer_:Start()
	end
end

function var_0_0.GetItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.scrollHelper:GetItemList()

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if arg_14_1 == iter_14_1.index then
			return iter_14_1
		end
	end

	return nil
end

function var_0_0.OnSign(arg_15_0, arg_15_1)
	if isSuccess(arg_15_1.result) then
		if arg_15_0.signIndex_ <= 0 then
			return
		end

		local var_15_0 = arg_15_0:GetItem(arg_15_0.signIndex_)

		if not var_15_0 then
			manager.notify:CallUpdateFunc(SIGN_INPUT, true)
			arg_15_0:RefreshSignItem()

			return
		end

		var_15_0:StartPlayAnimator()

		arg_15_0.timer_ = Timer.New(function()
			if var_15_0:GetAnimator():GetCurrentAnimatorStateInfo(0).normalizedTime >= 2 or not arg_15_0.animPlaying then
				if arg_15_0.animPlaying then
					manager.notify:CallUpdateFunc(READY_TO_SKIP_SIGN_ANIMATION, true)
				end

				local var_16_0 = arg_15_1.item_list

				getReward2(var_16_0, nil, handler(arg_15_0.hander_, arg_15_0.hander_.CheckSign))
				arg_15_0.timer_:Stop()

				arg_15_0.timer_ = nil
			end
		end, 0.033, -1)

		manager.notify:CallUpdateFunc(SIGN_INPUT, true)
		manager.notify:CallUpdateFunc(READY_TO_SKIP_SIGN_ANIMATION, false)
		arg_15_0.timer_:Start()
	else
		manager.notify:CallUpdateFunc(SIGN_INPUT, true)
		ShowTips(arg_15_1.result)
	end
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end

	arg_17_0.scrollHelper:Dispose()
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
