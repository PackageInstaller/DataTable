local var_0_0 = class("SPHeroChallengeEntrustView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeEntrustView"
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

	arg_5_0.activityID = SPHeroChallengeData:GetActivityID()
	arg_5_0.curEntrustItemList = {}

	for iter_5_0 = 1, SPHeroChallengeTools:GetMaxStartEntrustPosNum(arg_5_0.activityID) do
		local var_5_0 = SPHeroChallengeEntrustStartItem.New(arg_5_0["entrustitem" .. iter_5_0 .. "Go_"], iter_5_0)

		var_5_0:ClickEmptyFunc(handler(arg_5_0, arg_5_0.OpenChooseList))

		arg_5_0.curEntrustItemList[iter_5_0] = var_5_0
	end

	arg_5_0.waitEntrustItemScroll = LuaList.New(handler(arg_5_0, arg_5_0.indexWaitEntrust), arg_5_0.waitListGo_, SPHeroChallengeEntrustWaitItem)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.activityInfo = SPHeroChallengeData:GetCurActivityInfo()

	arg_6_0:RefreshStartEntrust()
	arg_6_0:RefreshWaitEntrustList()
	arg_6_0:StartTimer()
	arg_6_0:RefreshBar()
	arg_6_0:RegisterEvents()
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:BindRedPonit()
	arg_7_0:StartTimer()
	SPHeroChallengeAction:RefreshEntrust()
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:StopTimer()
	manager.windowBar:HideBar()
end

function var_0_0.BindRedPonit(arg_9_0)
	return
end

function var_0_0.UnBindRedPonit(arg_10_0)
	return
end

function var_0_0.RefreshBar(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_HERO_CHALLENGE_COIN_1,
		CurrencyConst.CURRENCY_HERO_CHALLENGE_TICKET
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_HERO_CHALLENGE_COIN_1, true)
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_HERO_CHALLENGE_TICKET, true)
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
	arg_12_0:StopTimer()
	arg_12_0:UnBindRedPonit()
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.AddUIListener(arg_13_0)
	arg_13_0:AddBtnListener(arg_13_0.receiveBtn_, nil, function()
		local var_14_0 = SPHeroChallengeData:GetCurActivityInfo()

		if var_14_0 then
			local var_14_1 = var_14_0:GetCanGetRewardEntrustIndexList()

			if #var_14_1 > 0 then
				SPHeroChallengeAction:GetEntrustAward(var_14_1)
			else
				ShowTips("ACTIVITY_HERO_CHALLENGE_NONE_ENTRUST_FINISH")
			end
		end
	end)
end

function var_0_0.RegisterEvents(arg_15_0)
	arg_15_0:RegistEventListener(SP_HERO_CHALLENGE_START_ENTRUST, function()
		arg_15_0:RefreshStartEntrust()
		arg_15_0:RefreshWaitEntrustList()
	end)
	arg_15_0:RegistEventListener(SP_HERO_CHALLENGE_FIN_ENTRUST, function()
		arg_15_0:RefreshStartEntrust()
		arg_15_0:RefreshWaitEntrustList()
	end)
end

function var_0_0.Dispose(arg_18_0)
	if arg_18_0.curEntrustItemList then
		for iter_18_0, iter_18_1 in pairs(arg_18_0.curEntrustItemList) do
			iter_18_1:Dispose()
		end
	end

	if arg_18_0.waitEntrustItemList then
		arg_18_0.waitEntrustItemList:Dispose()
	end

	if arg_18_0.waitEntrustItemScroll then
		arg_18_0.waitEntrustItemScroll:Dispose()
	end

	arg_18_0:StopTimer()
	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.RefreshStartEntrust(arg_19_0)
	if arg_19_0.curEntrustItemList then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0.curEntrustItemList) do
			local var_19_0 = arg_19_0.activityInfo:GetShowIndexEntrustInfo(iter_19_0)
			local var_19_1 = {
				showIndex = iter_19_0
			}

			if var_19_0 then
				if arg_19_0.activityInfo:GetEntrustEndTime(var_19_0.index) then
					var_19_1.state = "end"
				else
					var_19_1.state = "start"
				end
			elseif SPHeroChallengeTools:GetEntrustPosState(arg_19_0.activityID, iter_19_0) == SpHeroChallengeConst.EntrustPosState.empty then
				var_19_1.state = "empty"
			else
				var_19_1.state = "lock"
			end

			iter_19_1:RefreshUI(var_19_1)
		end
	end
end

function var_0_0.RefreshWaitEntrustList(arg_20_0)
	arg_20_0.startWaitList = {}

	local var_20_0 = SPHeroChallengeTools:GetMaxWaitEntrustPosNum(arg_20_0.activityID)
	local var_20_1 = SPHeroChallengeTools:GetMaxStartEntrustPosNum(arg_20_0.activityID)

	for iter_20_0 = 1, var_20_0 do
		local var_20_2 = {}
		local var_20_3 = arg_20_0.activityInfo:GetShowIndexEntrustInfo(iter_20_0 + var_20_1)

		if var_20_3 then
			var_20_2 = {
				showIndex = iter_20_0 + var_20_1,
				entrustIndex = var_20_3.index
			}
		elseif SPHeroChallengeTools:GetEntrustPosState(arg_20_0.activityID, iter_20_0 + var_20_1) == SpHeroChallengeConst.EntrustPosState.lock then
			var_20_2 = {
				state = "lock"
			}
		else
			var_20_2 = {
				state = "empty"
			}
		end

		var_20_2.showiIndex = iter_20_0 + var_20_1
		arg_20_0.startWaitList[iter_20_0] = var_20_2
	end

	arg_20_0.waitEntrustItemScroll:StartScroll(#arg_20_0.startWaitList)
end

function var_0_0.indexCanEntrust(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = {
		index = arg_21_1,
		id = arg_21_0.canChooseList[arg_21_1]
	}

	arg_21_2:RefreshUI(var_21_0)
end

function var_0_0.indexWaitEntrust(arg_22_0, arg_22_1, arg_22_2)
	arg_22_2:RefreshUI(arg_22_0.startWaitList[arg_22_1])
	arg_22_2:ClickEmptyFunc(handler(arg_22_0, arg_22_0.OpenChooseList))
end

function var_0_0.OpenChooseList(arg_23_0)
	JumpTools.OpenPageByJump("spHeroChallengeChooseEntrustPop")
end

function var_0_0.StartTimer(arg_24_0)
	if arg_24_0.timer then
		arg_24_0.timer:Stop()

		arg_24_0.timer = nil
	end

	arg_24_0.timer = Timer.New(function()
		if arg_24_0.curEntrustItemList then
			for iter_25_0, iter_25_1 in pairs(arg_24_0.curEntrustItemList) do
				iter_25_1:RefreshTime()
			end
		end
	end, 1, -1)

	arg_24_0.timer:Start()
end

function var_0_0.StopTimer(arg_26_0)
	if arg_26_0.timer then
		arg_26_0.timer:Stop()

		arg_26_0.timer = nil
	end
end

return var_0_0
