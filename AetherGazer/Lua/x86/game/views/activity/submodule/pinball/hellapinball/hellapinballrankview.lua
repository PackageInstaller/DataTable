local var_0_0 = class("HellaPinballRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Hel/Com/Activity_Hel_RankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BindCfgUI(arg_4_0.commonRankGo_)

	arg_4_0.tabController_ = arg_4_0.toggleConEx:GetController("tab")
	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetListItem), arg_4_0.list_, HellaPinballRankItem)
	arg_4_0.commonPortrait_ = CommonHeadPortrait.New(arg_4_0.headItem_)
end

function var_0_0.SetListItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.rankData[arg_5_1]

	arg_5_2:SetData(var_5_0, arg_5_1)
end

function var_0_0.AddUIListener(arg_6_0)
	return
end

function var_0_0.UpdateView(arg_7_0)
	local var_7_0 = RankData:GetActivityRank(arg_7_0.rankActivityID)

	arg_7_0.rankData = var_7_0.rankList

	if var_7_0 then
		local var_7_1, var_7_2 = var_7_0:GetCurRankDes()

		arg_7_0.myScoreLabel_.text = var_7_2
		arg_7_0.myRankLabel_.text = var_7_1
	else
		arg_7_0.myScoreLabel_.text = ""
		arg_7_0.myRankLabel_.text = ""
	end

	arg_7_0.list:StartScroll(#arg_7_0.rankData)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.selectIndex = 1

	local var_8_0 = PinballData:GetActivityID()

	arg_8_0.rankActivityID = ActivityCfg[var_8_0].sub_activity_list[1]

	RankAction.QueryActivityRank(arg_8_0.rankActivityID, 0)

	arg_8_0.nameLabel_.text = PlayerData:GetPlayerInfo().nick

	arg_8_0.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	arg_8_0.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_10_0:Back()
	end)
end

function var_0_0.OnRankUpdate(arg_12_0)
	arg_12_0:UpdateView()

	arg_12_0.isInit_ = true
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.commonPortrait_:Dispose()

	if arg_13_0.list then
		arg_13_0.list:Dispose()

		arg_13_0.list = nil
	end

	var_0_0.super.Dispose(arg_13_0)
	Object.Destroy(arg_13_0.gameObject_)
end

return var_0_0
