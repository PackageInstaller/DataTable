local var_0_0 = class("MatrixRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Matrix/Main/MatrixRankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()

	arg_3_0.rankTypeController = ControllerUtil.GetController(arg_3_0.m_rankTypeController, "toggle")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, MatrixRankItem)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_guildBtn, nil, function()
		arg_5_0:SelectRankType(MatrixConst.MatirxRankType.GUILD)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_allBtn, nil, function()
		arg_5_0:SelectRankType(MatrixConst.MatirxRankType.ALL)
	end)
end

function var_0_0.SelectRankType(arg_8_0, arg_8_1)
	if arg_8_0.rankType == arg_8_1 then
		return
	end

	arg_8_0:Refresh(arg_8_1)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function var_0_0.OnUpdate(arg_10_0)
	local var_10_0 = arg_10_0.params_.type

	arg_10_0:Refresh(var_10_0)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:RefreshGuildRankGo()
	RankAction.QueryCommonRank(RankConst.RANK_ID.MATRIX)

	local var_11_0 = GuildData:GetGuildInfo()

	if var_11_0 and var_11_0.id ~= nil and var_11_0.id ~= 0 then
		RankAction.QueryGuildCommonRank(RankConst.RANK_ID.MATRIX)
	end

	local var_11_1 = arg_11_0.params_.type

	arg_11_0:Refresh(var_11_1)
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.Refresh(arg_13_0, arg_13_1)
	arg_13_0.rankType = arg_13_1

	if arg_13_0.rankType == MatrixConst.MatirxRankType.ALL then
		local var_13_0 = RankData:GetCommonRank(RankConst.RANK_ID.MATRIX)

		arg_13_0.rankList = var_13_0 and var_13_0.rankList or {}

		if var_13_0 then
			local var_13_1, var_13_2 = var_13_0:GetCurRankDes()

			arg_13_0.m_rank.text = var_13_1
			arg_13_0.m_score.text = var_13_2
		else
			arg_13_0.m_rank.text = ""
			arg_13_0.m_score.text = ""
		end
	else
		local var_13_3 = RankData:GetGuildCommonRank(RankConst.RANK_ID.MATRIX)

		arg_13_0.rankList = var_13_3 and var_13_3.rankList or {}

		if var_13_3 then
			local var_13_4, var_13_5 = var_13_3:GetCurRankDes()

			arg_13_0.m_rank.text = var_13_4
			arg_13_0.m_score.text = var_13_5
		else
			arg_13_0.m_rank.text = ""
			arg_13_0.m_score.text = ""
		end
	end

	arg_13_0.list_:StartScroll(#arg_13_0.rankList)

	local var_13_6 = PlayerData:GetPlayerInfo()

	arg_13_0.m_icon.sprite = ItemTools.getItemSprite(var_13_6 and var_13_6.portrait)
	arg_13_0.m_frame.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. var_13_6.icon_frame)

	arg_13_0.rankTypeController:SetSelectedIndex(arg_13_0.rankType - 1)
end

function var_0_0.RefreshNone(arg_14_0)
	arg_14_0.m_rank.text = GetTips("MATRIX_RANK_NO_RANK")
	arg_14_0.m_score.text = GetTips("MATRIX_RANK_NO_INFO")
end

function var_0_0.IndexItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.rankList[arg_15_1]

	arg_15_2:Refresh(var_15_0)
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.list_:Dispose()
	var_0_0.super.Dispose(arg_16_0)

	arg_16_0.refreshGuildHandler_ = nil
end

function var_0_0.RefreshGuildRankGo(arg_17_0)
	if GuildData:GetGuildInfo().id == nil then
		SetActive(arg_17_0.m_guildGo, false)
	else
		SetActive(arg_17_0.m_guildGo, true)
	end
end

function var_0_0.OnRankUpdate(arg_18_0)
	arg_18_0:Refresh(arg_18_0.rankType)
end

return var_0_0
