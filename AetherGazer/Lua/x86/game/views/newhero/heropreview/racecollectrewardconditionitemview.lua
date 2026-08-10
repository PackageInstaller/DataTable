local var_0_0 = class("RaceCollectRewardConditionItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:AddEventListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status")
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexRewardItem), arg_3_0.uiListGo_, CommonItemView)
end

function var_0_0.IndexRewardItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = HeroRaceCollectData.GetRewardOfTier(arg_4_0.index_)
	local var_4_1 = rewardToItemTemplate(var_4_0[arg_4_1], nil, true)

	arg_4_2:SetData(var_4_1)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.getBtn_, nil, function()
		local var_6_0 = HeroRaceCollectData.GetHeroCntNeedOfEachTier() * arg_5_0.index_

		HeroRaceCollectAction.ReceiveOneTaskReward(arg_5_0.raceId_, var_6_0)
	end)
end

function var_0_0.AddEventListeners(arg_7_0)
	arg_7_0:RegistEventListener(RACE_COLLECT_REWARD_GET, function(arg_8_0)
		arg_7_0:UpdateView()
	end)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.index_ = arg_9_1
	arg_9_0.raceId_ = arg_9_2

	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	local var_10_0 = HeroRaceCollectData.GetHeroCntNeedOfEachTier() * arg_10_0.index_
	local var_10_1 = HeroRaceCollectData:GetHeroRaceCount(arg_10_0.raceId_)
	local var_10_2

	if var_10_0 <= var_10_1 then
		var_10_2 = var_10_0
	else
		var_10_2 = var_10_1
	end

	local var_10_3 = GetI18NText(RaceEffectCfg[arg_10_0.raceId_].name)

	arg_10_0.conditionLabel_.text = string.format(GetTips("COLLECT_HERO_RACE_DES"), var_10_2, var_10_0, var_10_3)

	local var_10_4 = HeroRaceCollectData.GetRewardOfTier(arg_10_0.index_)

	arg_10_0.uiList_:StartScroll(#var_10_4)

	local var_10_5 = HeroRaceCollectData:GetTaskState(arg_10_0.raceId_, arg_10_0.index_)

	if var_10_5 == 0 then
		arg_10_0.statusController_:SetSelectedState("unFinish")
	elseif var_10_5 == 1 then
		arg_10_0.statusController_:SetSelectedState("canGet")
	else
		arg_10_0.statusController_:SetSelectedState("haveGet")
	end
end

function var_0_0.OnEnter(arg_11_0)
	return
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllEventListener()

	arg_14_0.data_ = nil

	if arg_14_0.uiList_ then
		arg_14_0.uiList_:Dispose()

		arg_14_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
	Object.Destroy(arg_14_0.gameObject_)
end

return var_0_0
