local var_0_0 = class("AbyssRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Abyss/AbyssRankUI"
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
	arg_5_0:BindCfgUI(arg_5_0.commonRankGo_)

	arg_5_0.tabController_ = arg_5_0.toggleConEx:GetController("tab")
	arg_5_0.tabNumController_ = arg_5_0.toggleConEx:GetController("num")
	arg_5_0.rankList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uiListGo_, AbyssRankItemView)
	arg_5_0.commonPortrait_ = CommonHeadPortrait.New(arg_5_0.headItem_)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.dataList_[arg_6_1], arg_6_0.curPage_ == 1)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.clubBtn_, nil, function()
		arg_7_0:SwitchPageIfDiff(1)
	end)
	arg_7_0:AddBtnListener(arg_7_0.allBtn_, nil, function()
		arg_7_0:SwitchPageIfDiff(2)
	end)
end

function var_0_0.AddEventListeners(arg_10_0)
	arg_10_0:RegistEventListener(ABYSS_RANK_UPDATE, function()
		if not arg_10_0.isInit_ then
			arg_10_0:SwitchPage(2)

			arg_10_0.isInit_ = true
		end
	end)
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.OnBehind(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.SwitchPage(arg_14_0, arg_14_1)
	if arg_14_0.tabConState_ == nil then
		arg_14_0.tabConState_ = {
			"club",
			"all"
		}
	end

	arg_14_0.tabController_:SetSelectedState(arg_14_0.tabConState_[arg_14_1])

	arg_14_0.curPage_ = arg_14_1
	arg_14_0.dataList_ = arg_14_0:GetListFromIndex(arg_14_1)

	arg_14_0:UpdateView()
end

function var_0_0.SwitchPageIfDiff(arg_15_0, arg_15_1)
	if arg_15_0.curPage_ ~= arg_15_1 then
		arg_15_0:SwitchPage(arg_15_1)
	end
end

function var_0_0.UpdateBar(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0.isInit_ = false

	arg_17_0:AddEventListeners()
	RankAction.QueryCommonRank(RankConst.RANK_ID.ABYSS)

	local var_17_0 = true

	if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
		var_17_0 = false
	end

	arg_17_0.tabNumController_:SetSelectedState(var_17_0 and "02" or "01")

	if var_17_0 then
		RankAction.QueryGuildCommonRank(RankConst.RANK_ID.ABYSS)
	end
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.GetListFromIndex(arg_19_0, arg_19_1)
	if arg_19_1 == 1 then
		local var_19_0 = RankData:GetGuildCommonRank(RankConst.RANK_ID.ABYSS)

		return var_19_0 and var_19_0.rankList or {}
	else
		local var_19_1 = RankData:GetCommonRank(RankConst.RANK_ID.ABYSS)

		return var_19_1 and var_19_1.rankList or {}
	end
end

function var_0_0.UpdateView(arg_20_0)
	arg_20_0.rankList_:StartScroll(#arg_20_0.dataList_)
	arg_20_0.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	arg_20_0.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)

	if arg_20_0.curPage_ == 1 then
		local var_20_0 = RankData:GetGuildCommonRank(RankConst.RANK_ID.ABYSS)

		if var_20_0 then
			local var_20_1, var_20_2 = var_20_0:GetCurRankDes()

			arg_20_0.myRankLabel_.text = var_20_1
			arg_20_0.myScoreLabel_.text = var_20_2
		else
			arg_20_0.myRankLabel_.text = ""
			arg_20_0.myScoreLabel_.text = ""
		end
	else
		local var_20_3 = RankData:GetCommonRank(RankConst.RANK_ID.ABYSS)

		if var_20_3 then
			local var_20_4, var_20_5 = var_20_3:GetCurRankDes()

			arg_20_0.myRankLabel_.text = var_20_4
			arg_20_0.myScoreLabel_.text = var_20_5
		else
			arg_20_0.myRankLabel_.text = ""
			arg_20_0.myScoreLabel_.text = ""
		end
	end
end

function var_0_0.OnMainHomeViewTop(arg_21_0)
	return
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0.commonPortrait_:Dispose()

	if arg_22_0.rankList_ then
		arg_22_0.rankList_:Dispose()

		arg_22_0.rankList_ = nil
	end

	var_0_0.super.Dispose(arg_22_0)
end

function var_0_0.OnRankUpdate(arg_23_0)
	if not arg_23_0.isInit_ then
		arg_23_0:SwitchPage(2)

		arg_23_0.isInit_ = true
	end
end

return var_0_0
