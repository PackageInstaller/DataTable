local var_0_0 = class("GuildBossRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club_boss/ClubBossReward"
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

	arg_5_0.bonusList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uiListGo_, GuildBossBonusItem)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = GuildData:GetCurrentBossRemainHp()

	arg_6_2:SetData(arg_6_0.bonusDataList_[arg_6_1], math.max(var_6_0, 0), arg_6_1)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.AddEventListeners(arg_9_0)
	arg_9_0:RegistEventListener(GUILD_BOSS_BONUS_GET, function()
		arg_9_0:InitData()
		arg_9_0:UpdateView()
	end)
	arg_9_0:RegistEventListener(GUILD_EXIT, function()
		arg_9_0:Go("/home")
	end)
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.InitData(arg_14_0)
	arg_14_0.bonusDataList_ = ClubBossCfg[GuildData:GetBossDifficulty()].reward

	table.sort(arg_14_0.bonusDataList_, function(arg_15_0, arg_15_1)
		return arg_15_0[1] < arg_15_1[1]
	end)
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0:AddEventListeners()
	arg_16_0:InitData()
	arg_16_0:UpdateView()
end

function var_0_0.UpdateView(arg_17_0)
	arg_17_0.bonusList_:StartScroll(#arg_17_0.bonusDataList_)
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_19_0)
	return
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.bonusList_ then
		arg_20_0.bonusList_:Dispose()

		arg_20_0.bonusList_ = nil
	end

	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
