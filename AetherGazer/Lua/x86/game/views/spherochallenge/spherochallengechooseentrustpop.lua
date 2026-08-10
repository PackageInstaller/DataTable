local var_0_0 = class("SPHeroChallengeChooseEntrustPop", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeEntrustPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
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

	arg_5_0.canChooseEntrustScroll = LuaList.New(handler(arg_5_0, arg_5_0.indexCanEntrust), arg_5_0.uilistGo_, SPHeroChallengeEntrustItem)
	arg_5_0.refreshTimeController = arg_5_0.descController:GetController("refreshState")
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.activityInfo = SPHeroChallengeData:GetCurActivityInfo()
	arg_6_0.activityID = SPHeroChallengeData:GetActivityID()

	arg_6_0:RefreshOpenPage()
	arg_6_0:RegisterEvents()
end

function var_0_0.OnTop(arg_7_0)
	return
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:RemoveAllEventListener()
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.backMaskbtn, nil, function()
		arg_10_0:Back()
	end)
	arg_10_0:AddBtnListener(arg_10_0.refreshBtn_, nil, function()
		local var_12_0 = arg_10_0.activityInfo:GetRefreshFreeEntrustTime()

		if GameSetting.activity_hero_challenge_task_refresh_num.value[1] <= arg_10_0.activityInfo.entrustTime then
			return
		end

		if var_12_0 <= 0 then
			local var_12_1 = SPHeroChallengeData.activityCfg[arg_10_0.activityID].refreshEntrustCost[1]

			if CurrencyData:GetCurrencyNum(var_12_1[1]) < var_12_1[2] then
				ShowTips(GetTips("ACTIVITY_HERO_CHALLENGE_REFRESH_LACK"))

				return
			end
		end

		SPHeroChallengeAction:RefreshEntrustList()
	end)
end

function var_0_0.RegisterEvents(arg_13_0)
	arg_13_0:RegistEventListener(SP_HERO_CHALLENGE_REFRESH_ENTRUST, function()
		arg_13_0:RefreshOpenPage()
	end)
	arg_13_0:RegistEventListener(SP_HERO_CHALLENGE_START_ENTRUST, function()
		arg_13_0:RefreshOpenPage()
	end)
end

function var_0_0.Dispose(arg_16_0)
	if arg_16_0.canChooseEntrustScroll then
		arg_16_0.canChooseEntrustScroll:Dispose()
	end

	var_0_0.super.Dispose(arg_16_0)
end

function var_0_0.RefreshCanChooseEntrustList(arg_17_0)
	arg_17_0.canChooseList = {}

	if arg_17_0.activityInfo then
		arg_17_0.canChooseList = arg_17_0.activityInfo.waitEntrustList or {}
	end

	arg_17_0.canChooseEntrustScroll:StartScroll(#arg_17_0.canChooseList)
end

function var_0_0.indexCanEntrust(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = {
		index = arg_18_1,
		id = arg_18_0.canChooseList[arg_18_1]
	}

	arg_18_2:RefreshUI(var_18_0)
end

function var_0_0.RefreshOpenPage(arg_19_0)
	arg_19_0:RefreshCanChooseEntrustList()

	local var_19_0 = arg_19_0.activityInfo:GetRefreshFreeEntrustTime()
	local var_19_1 = arg_19_0.activityInfo:GetRefreshTotalEntrustTime()

	if var_19_0 > 0 then
		arg_19_0.refreshTimeController:SetSelectedState("free")

		arg_19_0.freetextText_.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_FREE_REFRESH"), var_19_0, GameSetting.activity_hero_challenge_task_free_refresh_num.value[1])
	elseif var_19_1 > 0 then
		arg_19_0.refreshTimeController:SetSelectedState("charge")

		local var_19_2 = SPHeroChallengeData.activityCfg[arg_19_0.activityID].refreshEntrustCost[1]

		arg_19_0.curiconImg_.sprite = ItemTools.getItemSprite(var_19_2[1])
		arg_19_0.freetextText_.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_REFRESH_NEED"), var_19_2[2])
	else
		arg_19_0.refreshTimeController:SetSelectedState("none")

		arg_19_0.freetextText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_REFRESH_NONE")
	end
end

return var_0_0
