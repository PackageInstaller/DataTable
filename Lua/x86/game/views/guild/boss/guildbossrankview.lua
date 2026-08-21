local var_0_0 = class("GuildBossRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club/ClubRankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0.myRank_ = 0
	arg_4_0.myRankData_ = nil

	arg_4_0:InitUI()

	arg_4_0.commonPortrait_ = CommonHeadPortrait.New(arg_4_0.headItem_)

	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uilistGo_, GuildBossRankItem)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.rankDataList_[arg_6_1])
end

function var_0_0.InitData(arg_7_0)
	arg_7_0.rankDataList_ = GuildData:GetRankList()

	table.sort(arg_7_0.rankDataList_, function(arg_8_0, arg_8_1)
		if arg_8_0.score ~= arg_8_1.score then
			return arg_8_0.score > arg_8_1.score
		end

		if arg_8_0.timestamp ~= arg_8_1.timestamp then
			return arg_8_0.timestamp < arg_8_1.timestamp
		end

		return arg_8_0.id < arg_8_1.id
	end)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.rankDataList_) do
		if iter_7_1.id == tostring(PlayerData:GetPlayerInfo().userID) then
			arg_7_0.myRankData_ = iter_7_1
			arg_7_0.myRank_ = iter_7_0

			break
		end
	end
end

function var_0_0.AddUIListener(arg_9_0)
	return
end

function var_0_0.AddEventListeners(arg_10_0)
	arg_10_0:RegistEventListener(GUILD_BOSS_RANK_UPDATE, function()
		arg_10_0:InitData()
		arg_10_0:UpdateView()
	end)
	arg_10_0:RegistEventListener(GUILD_EXIT, function()
		arg_10_0:Go("/home")
	end)
end

function var_0_0.OnTop(arg_13_0)
	arg_13_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnBehind(arg_15_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0:AddEventListeners()
	GuildAction.GuildBossGetRankInfo(GuildData:GetGuildInfo().id)
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.OnMainHomeViewTop(arg_18_0)
	return
end

function var_0_0.UpdateView(arg_19_0)
	arg_19_0.uiList_:StartScroll(#arg_19_0.rankDataList_)

	if arg_19_0.myRank_ > 0 then
		arg_19_0.m_rank.text = arg_19_0.myRank_
	else
		arg_19_0.m_rank.text = GetTips("MATRIX_RANK_NO_RANK")
	end

	if arg_19_0.myRankData_ ~= nil then
		arg_19_0.m_score.text = arg_19_0.myRankData_.score
	else
		arg_19_0.m_score.text = GetTips("MATRIX_RANK_NO_INFO")
	end

	arg_19_0.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	arg_19_0.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0.commonPortrait_:Dispose()

	if arg_20_0.uiList_ then
		arg_20_0.uiList_:Dispose()

		arg_20_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
