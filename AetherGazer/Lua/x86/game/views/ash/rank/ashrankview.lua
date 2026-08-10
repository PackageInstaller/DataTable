local var_0_0 = class("AshRankView", ReduxView)
local var_0_1 = {
	ALL = 1,
	GUILD = 2
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_EkChuah/EkChuah_BattleUI/EkChuah_BoundlessRankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.curRankType_ = var_0_1.ALL

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, ActivityAshRankItem)
	arg_4_0.commonPortrait_ = CommonHeadPortrait.New(arg_4_0.headItem_)
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(arg_6_0.rankList_[arg_6_1])
end

function var_0_0.QueryRankData(arg_7_0, arg_7_1)
	RankAction.QueryActivityRank(arg_7_0.activityID_, nil, arg_7_1)
end

function var_0_0.OnEnter(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_8_0.activityID_ = ActivityConst.ACTIVITY_ASH_RANK

	arg_8_0:QueryRankData(function()
		arg_8_0:RefreshUI()
	end)
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshSelfRank()
	arg_10_0:RefreshList()
end

function var_0_0.SwitchPageIfDiff(arg_11_0, arg_11_1)
	if arg_11_0.curRankType_ ~= arg_11_1 then
		arg_11_0:SwitchPage(arg_11_1)
	end
end

function var_0_0.SwitchPage(arg_12_0, arg_12_1)
	arg_12_0.curRankType_ = arg_12_1

	arg_12_0:RefreshSelfRank()
	arg_12_0:RefreshList()
end

function var_0_0.RefreshSelfRank(arg_13_0)
	local var_13_0 = PlayerData:GetPlayerInfo()

	arg_13_0.commonPortrait_:RenderHead(var_13_0 and var_13_0.portrait)
	arg_13_0.commonPortrait_:RenderFrame(var_13_0.icon_frame)

	arg_13_0.nametextText_.text = var_13_0.nick

	if arg_13_0.curRankType_ == var_0_1.ALL then
		local var_13_1 = RankData:GetActivityRank(arg_13_0.activityID_)

		if var_13_1 then
			local var_13_2, var_13_3 = var_13_1:GetCurRankDes()

			arg_13_0.textnumText_.text = var_13_2
			arg_13_0.textscoreText_.text = var_13_3
		else
			arg_13_0.textnumText_.text = ""
			arg_13_0.textscoreText_.text = ""
		end
	else
		local var_13_4 = RankData:GetGuildActivityRank(arg_13_0.activityID_)

		if var_13_4 then
			local var_13_5, var_13_6 = var_13_4:GetCurRankDes()

			arg_13_0.textnumText_.text = var_13_5
			arg_13_0.textscoreText_.text = var_13_6
		else
			arg_13_0:RefreshNone()
		end
	end
end

function var_0_0.RefreshNone(arg_14_0)
	arg_14_0.textnumText_.text = GetTips("MATRIX_RANK_NO_RANK")
	arg_14_0.textscoreText_.text = GetTips("MATRIX_RANK_NO_INFO")
end

function var_0_0.RefreshList(arg_15_0)
	if arg_15_0.curRankType_ == var_0_1.ALL then
		local var_15_0 = RankData:GetActivityRank(arg_15_0.activityID_)

		arg_15_0.rankList_ = var_15_0 and var_15_0.rankList or {}
	else
		local var_15_1 = RankData:GetGuildActivityRank(arg_15_0.activityID_)

		arg_15_0.rankList_ = var_15_1 and var_15_1.rankList or {}
	end

	arg_15_0.scrollHelper_:StartScroll(#arg_15_0.rankList_)
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0.scrollHelper_:StartScroll(0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)
	arg_18_0:RemoveAllListeners()
	arg_18_0.commonPortrait_:Dispose()

	arg_18_0.commonPortrait_ = nil

	arg_18_0.scrollHelper_:Dispose()

	arg_18_0.scrollHelper_ = nil
end

return var_0_0
