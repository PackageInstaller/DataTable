local var_0_0 = class("RoguelikeRankView", ReduxView)
local var_0_1 = {
	ALL = 2,
	Club = 1
}

function var_0_0.UIName(arg_1_0)
	return "UI/StrategyMatrix/StrategyMatrixRankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.UIBackCount(arg_3_0)
	return 2
end

function var_0_0.OnCtor(arg_4_0)
	return
end

function var_0_0.Init(arg_5_0)
	arg_5_0:InitUI()
	arg_5_0:AddUIListener()
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.isInit_ = false
	arg_6_0.rank_id = arg_6_0.params_.rank_id

	RankAction.QueryActivityRank(arg_6_0.rank_id)

	local var_6_0 = GuildData:GetGuildInfo().id
	local var_6_1 = GuildData.IsGuildValid(var_6_0)

	arg_6_0.TogClub:SetActive(var_6_1)

	if var_6_1 then
		RankAction.QueryGuildActivityRank(arg_6_0.rank_id)
	end
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0.gameObject_:InjectUI(arg_8_0)

	arg_8_0.scroll = LuaList.New(handler(arg_8_0, arg_8_0.RefreshItem), arg_8_0.GoList, RoguelikeRankItemView)
	arg_8_0.toggleList = {
		arg_8_0.TogClub,
		arg_8_0.TogAll
	}
	arg_8_0.commonPortrait_ = CommonHeadPortrait.New(arg_8_0.GoHeadItem)
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:UpdateBar()
end

function var_0_0.OnBehind(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.commonPortrait_:Dispose()

	if arg_11_0.scroll then
		arg_11_0.scroll:Dispose()

		arg_11_0.scroll = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.SwitchTab(arg_12_0, arg_12_1)
	arg_12_0.toggleList[arg_12_1].isOn = true
	arg_12_0.tab = arg_12_1
	arg_12_0.dataList = arg_12_0:GetListFromIndex(arg_12_0.rank_id, arg_12_1)

	arg_12_0:RefreshView()
end

function var_0_0.UpdateBar(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.RefreshView(arg_14_0)
	arg_14_0.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	arg_14_0.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)

	if arg_14_0.tab == var_0_1.Club then
		local var_14_0 = RankData:GetGuildActivityRank(arg_14_0.rank_id)

		if var_14_0 then
			local var_14_1, var_14_2 = var_14_0:GetCurRankDes()

			arg_14_0.TxtMyRank.text = var_14_1
			arg_14_0.TxtMyScore.text = var_14_2
		else
			arg_14_0.TxtMyRank.text = ""
			arg_14_0.TxtMyScore.text = ""
		end
	elseif arg_14_0.tab == var_0_1.ALL then
		local var_14_3 = RankData:GetActivityRank(arg_14_0.rank_id)

		if var_14_3 then
			local var_14_4, var_14_5 = var_14_3:GetCurRankDes()

			arg_14_0.TxtMyRank.text = var_14_4
			arg_14_0.TxtMyScore.text = var_14_5
		else
			arg_14_0.TxtMyRank.text = ""
			arg_14_0.TxtMyScore.text = ""
		end
	end

	arg_14_0.scroll:StartScroll(#arg_14_0.dataList)
end

function var_0_0.RefreshItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2:SetData(arg_15_1, arg_15_0.dataList[arg_15_1], arg_15_0.tab == var_0_1.Club)
end

function var_0_0.OnActivityMatrixRankUpdate(arg_16_0)
	arg_16_0:SwitchTab(var_0_1.ALL)
end

function var_0_0.AddUIListener(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.toggleList) do
		arg_17_0:AddToggleListener(iter_17_1, function(arg_18_0)
			if arg_18_0 then
				arg_17_0:SwitchTab(iter_17_0)
			end
		end)
	end
end

function var_0_0.GetListFromIndex(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = {}

	if arg_19_2 == var_0_1.Club then
		local var_19_1 = RankData:GetGuildActivityRank(arg_19_0.rank_id)

		var_19_0 = var_19_1 and var_19_1.rankList or {}
	elseif arg_19_2 == var_0_1.ALL then
		local var_19_2 = RankData:GetActivityRank(arg_19_0.rank_id)

		var_19_0 = var_19_2 and var_19_2.rankList or {}
	end

	table.sort(var_19_0, function(arg_20_0, arg_20_1)
		return arg_20_0.rank < arg_20_1.rank
	end)

	return var_19_0
end

function var_0_0.OnRankUpdate(arg_21_0)
	arg_21_0:SwitchTab(var_0_1.ALL)
end

return var_0_0
