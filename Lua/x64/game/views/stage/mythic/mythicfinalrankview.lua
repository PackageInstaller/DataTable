local var_0_0 = class("MythicFinalRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Mythic/MythicRankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.rankTypeConst_ = MythicData:GetRankTypeConst()

	arg_3_0:InitUI()

	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)

	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BindCfgUI(arg_4_0.commonRankGo_)

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, MythicFinalRankItem)
	arg_4_0.tabController_ = arg_4_0.toggleConEx:GetController("tab")
	arg_4_0.tabNumController_ = arg_4_0.toggleConEx:GetController("num")
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.clubBtn_, nil, function()
		arg_5_0:SwitchPageIfDiff(arg_5_0.rankTypeConst_.GUILD)
	end)
	arg_5_0:AddBtnListener(arg_5_0.allBtn_, nil, function()
		arg_5_0:SwitchPageIfDiff(arg_5_0.rankTypeConst_.ALL)
	end)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:RefreshGuildRankGo()
	RankAction.QueryCommonRank(RankConst.RANK_ID.MYTHIC)

	local var_9_0 = GuildData:GetGuildInfo()

	if var_9_0 and var_9_0.id ~= nil and var_9_0.id ~= 0 then
		RankAction.QueryGuildCommonRank(RankConst.RANK_ID.MYTHIC)
	end

	if arg_9_0.params_.reset then
		arg_9_0.params_.reset = nil

		arg_9_0:SwitchPageIfDiff(arg_9_0.rankTypeConst_.ALL)
	end

	arg_9_0:Refresh()
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0.pos_ = arg_10_0.list_:GetScrolledPosition()

	manager.windowBar:HideBar()
end

function var_0_0.Refresh(arg_11_0)
	if MythicData:GetCurRankType() == arg_11_0.rankTypeConst_.ALL then
		local var_11_0 = RankData:GetCommonRank(RankConst.RANK_ID.MYTHIC)

		arg_11_0.rankList = var_11_0 and var_11_0.rankList or {}

		if var_11_0 then
			local var_11_1, var_11_2 = var_11_0:GetCurRankDes()

			arg_11_0.myRankLabel_.text = var_11_1
			arg_11_0.myScoreLabel_.text = var_11_2
		else
			arg_11_0.myRankLabel_.text = ""
			arg_11_0.myScoreLabel_.text = ""
		end

		arg_11_0.tabController_:SetSelectedState("all")
	else
		local var_11_3 = RankData:GetGuildCommonRank(RankConst.RANK_ID.MYTHIC)

		arg_11_0.rankList = var_11_3 and var_11_3.rankList or {}

		if var_11_3 then
			local var_11_4, var_11_5 = var_11_3:GetCurRankDes()

			arg_11_0.myRankLabel_.text = var_11_4
			arg_11_0.myScoreLabel_.text = var_11_5
		else
			arg_11_0.myRankLabel_.text = ""
			arg_11_0.myScoreLabel_.text = ""
		end

		arg_11_0.tabController_:SetSelectedState("club")
	end

	arg_11_0.list_:StartScroll(#arg_11_0.rankList)

	if arg_11_0.pos_ then
		arg_11_0.list_:SetScrolledPosition(arg_11_0.pos_)
	end

	local var_11_6 = PlayerData:GetPlayerInfo()

	arg_11_0.commonPortrait_:RenderHead(var_11_6 and var_11_6.portrait)
	arg_11_0.commonPortrait_:RenderFrame(var_11_6.icon_frame)
end

function var_0_0.SwitchPageIfDiff(arg_12_0, arg_12_1)
	if arg_12_1 ~= MythicData:GetCurRankType() then
		MythicData:SetCurRankType(arg_12_1)
		arg_12_0:Refresh()
	end
end

function var_0_0.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.rankList[arg_13_1]

	arg_13_2:Refresh(var_13_0)
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.commonPortrait_:Dispose()
	arg_14_0.list_:Dispose()
	var_0_0.super.Dispose(arg_14_0)

	arg_14_0.refreshGuildHandler_ = nil
end

function var_0_0.RefreshGuildRankGo(arg_15_0)
	if GuildData:GetGuildInfo().id == nil then
		arg_15_0.tabNumController_:SetSelectedState("01")
	else
		arg_15_0.tabNumController_:SetSelectedState("02")
	end
end

function var_0_0.OnRankUpdate(arg_16_0)
	arg_16_0:Refresh()
end

return var_0_0
