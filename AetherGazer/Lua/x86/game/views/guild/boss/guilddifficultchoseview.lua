local var_0_0 = class("GuildDifficultChoseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club_boss/ClubBossDifficltChose"
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

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uilistGo_, GuildBossDifficultyItemView)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.difficultyListData_[arg_6_1])
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.AddEventListeners(arg_9_0)
	arg_9_0:RegistEventListener(GUILD_BOSS_DIFFICULTY_CHANGE, function()
		arg_9_0:UpdateView()
	end)
	arg_9_0:RegistEventListener(GUILD_EXIT, function()
		arg_9_0:Go("/home")
	end)
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.OnBehind(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(GetTips("CLUB_BOSS_DESCRIPE"))
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0:AddEventListeners()

	arg_15_0.difficultyListData_ = ClubBossCfg.all

	arg_15_0.uiList_:StartScroll(#arg_15_0.difficultyListData_)
	arg_15_0:UpdateView()
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.UpdateView(arg_17_0)
	arg_17_0.uiList_:Refresh()
end

function var_0_0.OnMainHomeViewTop(arg_18_0)
	return
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.uiList_ then
		arg_19_0.uiList_:Dispose()

		arg_19_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
