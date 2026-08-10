RankBaseView = import("game.views.rank.RankBaseView")

local var_0_0 = class("DestroyBoxRankView", RankBaseView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/BaichaoUI_3_8/BaichaoUI_3_8_BoxUI/BaichaoUI_3_8_BoxRankUI"
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)
	arg_3_0.tabController_ = arg_3_0.ndtabControllerexcollection_:GetController("tab")
	arg_3_0.tabNumController_ = arg_3_0.ndtabControllerexcollection_:GetController("num")

	arg_3_0:AddUIListener()

	arg_3_0.list_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.m_list, DestroyBoxRankItem)
	arg_3_0.subTypeController_ = arg_3_0.conExCollection_:GetController("subType")
	arg_3_0.rankTypeController_ = arg_3_0.toggleConEx:GetController("tab")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_easyBtn, nil, function()
		local var_5_0 = arg_4_0:GetRankActivityID(1)
		local var_5_1 = ActivityData:GetActivityData(var_5_0)
		local var_5_2 = manager.time:GetServerTime()

		if var_5_2 < var_5_1.startTime then
			local var_5_3 = GetTips("OPEN_TIME")

			ShowTips(string.format(var_5_3, manager.time:GetLostTimeStr2(var_5_1.startTime, nil, true)))

			return
		elseif var_5_2 >= var_5_1.stopTime then
			ShowTips("TIME_OVER")

			return
		end

		arg_4_0.rankIndex_ = 1

		arg_4_0:SwitchRank(RankBaseConst.RANK_TYPE.ALL, arg_4_0.subType_, arg_4_0.heroID_)
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_hardBtn, nil, function()
		local var_6_0 = arg_4_0:GetRankActivityID(2)
		local var_6_1 = ActivityData:GetActivityData(var_6_0)
		local var_6_2 = manager.time:GetServerTime()

		if var_6_2 < var_6_1.startTime then
			local var_6_3 = GetTips("OPEN_TIME")

			ShowTips(string.format(var_6_3, manager.time:GetLostTimeStr2(var_6_1.startTime, nil, true)))

			return
		elseif var_6_2 >= var_6_1.stopTime then
			ShowTips("TIME_OVER")

			return
		end

		arg_4_0.rankIndex_ = 2

		arg_4_0:SwitchRank(RankBaseConst.RANK_TYPE.ALL, arg_4_0.subType_, arg_4_0.heroID_)
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_guildBtn, nil, function()
		if arg_4_0.rankType_ == RankBaseConst.RANK_TYPE.GUILD then
			return
		end

		arg_4_0:SwitchRank(RankBaseConst.RANK_TYPE.GUILD, arg_4_0.subType_, arg_4_0.heroID_)
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_allBtn, nil, function()
		if arg_4_0.rankType_ == RankBaseConst.RANK_TYPE.ALL then
			return
		end

		arg_4_0:SwitchRank(RankBaseConst.RANK_TYPE.ALL, arg_4_0.subType_, arg_4_0.heroID_)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_9_0.rankIndex_ = 1
	arg_9_0.initCache_ = {}
	arg_9_0.heroCache_ = {}

	arg_9_0:RefreshGuildRankGo()
	RankAction.QueryActivityAllRank(arg_9_0:GetRankID(), function()
		RankAction.QueryActivityRankWitchCallBack(arg_9_0:GetRankID(), 0, function()
			arg_9_0.heroIDList_, arg_9_0.trialIDList_ = arg_9_0:GetHeroList()
			arg_9_0.rankType_ = arg_9_0.params_.type or RankBaseConst.RANK_TYPE.ALL
			arg_9_0.subType_ = arg_9_0.params_.subType or RankBaseConst.SUB_TYPE.BASE
			arg_9_0.heroID_ = arg_9_0.params_.heroID or arg_9_0.heroIDList_[1]

			arg_9_0:Refresh(arg_9_0.rankType_, arg_9_0.subType_, arg_9_0.heroID_)
			arg_9_0:AddTimer()
		end)
	end)
end

function var_0_0.GetRankID(arg_12_0)
	arg_12_0.id_ = DestroyBoxGameData:GetDifficultList(arg_12_0:GetActivityID())[DestroyBoxGameData.SPECTIAL_HARD_LEVEL][arg_12_0.rankIndex_]

	local var_12_0 = DestroyBoxGameCfg[arg_12_0.id_].activity_id

	return ActivityCfg[var_12_0].sub_activity_list[1]
end

function var_0_0.GetRankActivityID(arg_13_0, arg_13_1)
	local var_13_0 = DestroyBoxGameData:GetDifficultList(arg_13_0:GetActivityID())[DestroyBoxGameData.SPECTIAL_HARD_LEVEL][arg_13_1]
	local var_13_1 = DestroyBoxGameCfg[var_13_0]

	return ActivityCfg[var_13_1.activity_id].sub_activity_list[1]
end

function var_0_0.SwitchRank(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = 0

	if arg_14_2 == RankBaseConst.SUB_TYPE.HERO then
		var_14_0 = arg_14_0:GetSendSeverHeroID(arg_14_3)
	else
		var_14_0 = 0
	end

	if arg_14_1 == RankBaseConst.RANK_TYPE.GUILD then
		RankAction.QueryGuildActivityRankWitchCallBack(arg_14_0:GetRankID(), var_14_0, function()
			arg_14_0:Refresh(arg_14_1, arg_14_2, arg_14_3)
		end)
	else
		RankAction.QueryActivityRankWitchCallBack(arg_14_0:GetRankID(), var_14_0, function()
			arg_14_0:Refresh(arg_14_1, arg_14_2, arg_14_3)
		end)
	end
end

function var_0_0.Refresh(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0.initCache_[arg_17_1] = arg_17_0.initCache_[arg_17_1] or {}

	if arg_17_2 == RankBaseConst.SUB_TYPE.SCORE then
		arg_17_0.initCache_[arg_17_1][arg_17_2] = true
	else
		arg_17_0.initCache_[arg_17_1][arg_17_2] = arg_17_0.initCache_[arg_17_1][arg_17_2] or {}
		arg_17_0.initCache_[arg_17_1][arg_17_2][arg_17_3] = true
	end

	arg_17_0.rankType_ = arg_17_1
	arg_17_0.subType_ = arg_17_2

	if arg_17_2 == RankBaseConst.SUB_TYPE.HERO then
		arg_17_3 = arg_17_3 or arg_17_0.heroIDList_[1]
		arg_17_0.heroID_ = arg_17_3
	end

	local var_17_0 = 0

	if arg_17_0.subType_ == RankBaseConst.SUB_TYPE.HERO then
		var_17_0 = arg_17_0:GetSendSeverHeroID(arg_17_0.heroID_)
	else
		var_17_0 = 0
	end

	if arg_17_0.rankType_ == RankBaseConst.RANK_TYPE.ALL then
		local var_17_1 = RankData:GetActivityRank(arg_17_0:GetRankID(), var_17_0)

		arg_17_0.rankList_ = var_17_1 and var_17_1.rankList or {}

		if var_17_1 then
			local var_17_2, var_17_3 = var_17_1:GetCurRankDes()

			arg_17_0.m_rank.text = var_17_2
			arg_17_0.m_score.text = var_17_3
		else
			arg_17_0.m_rank.text = ""
			arg_17_0.m_score.text = ""
		end
	else
		local var_17_4 = RankData:GetGuildActivityRank(arg_17_0:GetRankID(), var_17_0)

		arg_17_0.rankList_ = var_17_4 and var_17_4.rankList or {}

		if var_17_4 then
			local var_17_5, var_17_6 = var_17_4:GetCurRankDes()

			arg_17_0.m_rank.text = var_17_5
			arg_17_0.m_score.text = var_17_6
		else
			arg_17_0.m_rank.text = ""
			arg_17_0.m_score.text = ""
		end
	end

	arg_17_0.list_:StartScroll(#arg_17_0.rankList_)

	if arg_17_2 == RankBaseConst.SUB_TYPE.SCORE then
		local var_17_7 = PlayerData:GetPlayerInfo()

		arg_17_0.commonPortrait_:RenderHead(var_17_7 and var_17_7.portrait)
		arg_17_0.commonPortrait_:RenderFrame(var_17_7 and var_17_7.icon_frame)

		if arg_17_0.playerAnimator_ then
			SetActive(arg_17_0.playerIconGo_, false)
			arg_17_0.playerAnimator_:Play("PolyhedronRankUI_Hero", -1, 0)
		end
	else
		local var_17_8 = HeroCfg[arg_17_3]
		local var_17_9 = arg_17_0:GetHeroSkinID(arg_17_3)

		arg_17_0.m_heroIcon.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. var_17_9)
		arg_17_0.m_heroNameText_.text = string.format("%s·%s", var_17_8.name, var_17_8.suffix)

		if arg_17_0.heroAnimator_ then
			SetActive(arg_17_0.heroIconGo_, false)
			arg_17_0.heroAnimator_:Play("PolyhedronRankUI_Hero", -1, 0)
		end
	end

	if arg_17_0.tabConState_ == nil then
		arg_17_0.tabConState_ = {
			"all",
			"club"
		}
	end

	arg_17_0.rankTypeController_:SetSelectedState(arg_17_0.tabConState_[arg_17_0.rankType_])
	arg_17_0.subTypeController_:SetSelectedState(tostring(arg_17_0.rankIndex_))
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
