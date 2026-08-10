local var_0_0 = class("RankBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Polyhedron/PolyhedronRankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)

	arg_3_0:AddListeners()

	arg_3_0.rankTypeController_ = arg_3_0.toggleConEx:GetController("tab")
	arg_3_0.tabNumController_ = arg_3_0.toggleConEx:GetController("num")
	arg_3_0.subTypeController_ = ControllerUtil.GetController(arg_3_0.m_subTypeController, "subType")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, RankItemBase)
	arg_4_0.heroList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexHeroItem), arg_4_0.heroListGo_, RankHeroItemBase)
	arg_4_0.heroClickHandler_ = handler(arg_4_0, arg_4_0.OnClickHero)
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.panelAnim_:Update(0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_5_0.initCache_ = {}
	arg_5_0.heroCache_ = {}

	arg_5_0:RefreshGuildRankGo()
	RankAction.QueryActivityAllRank(arg_5_0:GetRankID(), function()
		RankAction.QueryActivityRankWitchCallBack(arg_5_0:GetRankID(), 0, function()
			arg_5_0.heroIDList_, arg_5_0.trialIDList_ = arg_5_0:GetHeroList()
			arg_5_0.rankType_ = arg_5_0.params_.type or RankBaseConst.RANK_TYPE.ALL
			arg_5_0.subType_ = arg_5_0.params_.subType or RankBaseConst.SUB_TYPE.BASE
			arg_5_0.heroID_ = arg_5_0.params_.heroID or arg_5_0.heroIDList_[1]

			arg_5_0:Refresh(arg_5_0.rankType_, arg_5_0.subType_, arg_5_0.heroID_)
			arg_5_0:AddTimer()
		end)
	end)
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:StopTimer()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.commonPortrait_:Dispose()

	arg_9_0.commonPortrait_ = nil

	if arg_9_0.list_ then
		arg_9_0.list_:Dispose()

		arg_9_0.list_ = nil
	end

	if arg_9_0.heroList_ then
		arg_9_0.heroList_:Dispose()

		arg_9_0.heroList_ = nil
	end

	arg_9_0.heroClickHandler_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.AddListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.m_scoreBtn, nil, function()
		if arg_10_0.subType_ == RankBaseConst.SUB_TYPE.SCORE then
			return
		end

		arg_10_0:SwitchRank(arg_10_0.rankType_, RankBaseConst.SUB_TYPE.SCORE, arg_10_0.heroID_)
	end)
	arg_10_0:AddBtnListener(arg_10_0.m_heroBtn, nil, function()
		if arg_10_0.subType_ == RankBaseConst.SUB_TYPE.HERO then
			return
		end

		local var_12_0 = arg_10_0:GetSendSeverHeroID(arg_10_0.heroID_)

		RankAction.QueryActivityRankWitchCallBack(arg_10_0:GetRankID(), var_12_0, function()
			local var_13_0 = arg_10_0.heroID_ or arg_10_0.heroIDList_[1]

			arg_10_0:SwitchRank(arg_10_0.rankType_, RankBaseConst.SUB_TYPE.HERO, var_13_0)
			arg_10_0.heroList_:StartScroll(#arg_10_0.heroIDList_)
		end)
	end)
	arg_10_0:AddBtnListener(arg_10_0.m_guildBtn, nil, function()
		if arg_10_0.rankType_ == RankBaseConst.RANK_TYPE.GUILD then
			return
		end

		arg_10_0:SwitchRank(RankBaseConst.RANK_TYPE.GUILD, arg_10_0.subType_, arg_10_0.heroID_)
	end)
	arg_10_0:AddBtnListener(arg_10_0.m_allBtn, nil, function()
		if arg_10_0.rankType_ == RankBaseConst.RANK_TYPE.ALL then
			return
		end

		arg_10_0:SwitchRank(RankBaseConst.RANK_TYPE.ALL, arg_10_0.subType_, arg_10_0.heroID_)
	end)
end

function var_0_0.SwitchRank(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = true

	if arg_16_0.initCache_[arg_16_1] and arg_16_0.initCache_[arg_16_1][arg_16_2] then
		if arg_16_2 == RankBaseConst.SUB_TYPE.HERO and not arg_16_0.initCache_[arg_16_1][arg_16_2][arg_16_3] then
			var_16_0 = false
		end
	else
		var_16_0 = false
	end

	if var_16_0 == true then
		arg_16_0:Refresh(arg_16_1, arg_16_2, arg_16_3)
	else
		local var_16_1 = 0

		if arg_16_2 == RankBaseConst.SUB_TYPE.HERO then
			var_16_1 = arg_16_0:GetSendSeverHeroID(arg_16_3)
		else
			var_16_1 = 0
		end

		if arg_16_1 == RankBaseConst.RANK_TYPE.GUILD then
			RankAction.QueryGuildActivityRankWitchCallBack(arg_16_0:GetRankID(), var_16_1, function()
				arg_16_0:Refresh(arg_16_1, arg_16_2, arg_16_3)
			end)
		else
			RankAction.QueryActivityRankWitchCallBack(arg_16_0:GetRankID(), var_16_1, function()
				arg_16_0:Refresh(arg_16_1, arg_16_2, arg_16_3)
			end)
		end
	end
end

function var_0_0.OnClickHero(arg_19_0, arg_19_1)
	if arg_19_0.heroID_ == arg_19_1 then
		return
	end

	local var_19_0 = arg_19_0.heroList_:GetItemList()

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		iter_19_1:SetSelect(arg_19_1)
	end

	arg_19_0:SwitchRank(arg_19_0.rankType_, arg_19_0.subType_, arg_19_1)
end

function var_0_0.Refresh(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0.initCache_[arg_20_1] = arg_20_0.initCache_[arg_20_1] or {}

	if arg_20_2 == RankBaseConst.SUB_TYPE.SCORE then
		arg_20_0.initCache_[arg_20_1][arg_20_2] = true
	else
		arg_20_0.initCache_[arg_20_1][arg_20_2] = arg_20_0.initCache_[arg_20_1][arg_20_2] or {}
		arg_20_0.initCache_[arg_20_1][arg_20_2][arg_20_3] = true
	end

	arg_20_0.rankType_ = arg_20_1
	arg_20_0.subType_ = arg_20_2

	if arg_20_2 == RankBaseConst.SUB_TYPE.HERO then
		arg_20_3 = arg_20_3 or arg_20_0.heroIDList_[1]
		arg_20_0.heroID_ = arg_20_3
	end

	local var_20_0 = 0

	if arg_20_0.subType_ == RankBaseConst.SUB_TYPE.HERO then
		var_20_0 = arg_20_0:GetSendSeverHeroID(arg_20_0.heroID_)
	else
		var_20_0 = 0
	end

	if arg_20_0.rankType_ == RankBaseConst.RANK_TYPE.ALL then
		local var_20_1 = RankData:GetActivityRank(arg_20_0:GetRankID(), var_20_0)

		arg_20_0.rankList_ = var_20_1 and var_20_1.rankList or {}

		if var_20_1 then
			local var_20_2, var_20_3 = var_20_1:GetCurRankDes()

			arg_20_0.m_rank.text = var_20_2
			arg_20_0.m_score.text = var_20_3
		else
			arg_20_0.m_rank.text = ""
			arg_20_0.m_score.text = ""
		end
	else
		local var_20_4 = RankData:GetGuildActivityRank(arg_20_0:GetRankID(), var_20_0)

		arg_20_0.rankList_ = var_20_4 and var_20_4.rankList or {}

		if var_20_4 then
			local var_20_5, var_20_6 = var_20_4:GetCurRankDes()

			arg_20_0.m_rank.text = var_20_5
			arg_20_0.m_score.text = var_20_6
		else
			arg_20_0.m_rank.text = ""
			arg_20_0.m_score.text = ""
		end
	end

	arg_20_0.list_:StartScroll(#arg_20_0.rankList_)

	if arg_20_2 == RankBaseConst.SUB_TYPE.SCORE then
		local var_20_7 = PlayerData:GetPlayerInfo()

		arg_20_0.commonPortrait_:RenderHead(var_20_7 and var_20_7.portrait)
		arg_20_0.commonPortrait_:RenderFrame(var_20_7 and var_20_7.icon_frame)

		if arg_20_0.playerAnimator_ then
			SetActive(arg_20_0.playerIconGo_, false)
			arg_20_0.playerAnimator_:Play("PolyhedronRankUI_Hero", -1, 0)
		end
	else
		local var_20_8 = HeroCfg[arg_20_3]
		local var_20_9 = arg_20_0:GetHeroSkinID(arg_20_3)

		arg_20_0.m_heroIcon.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. var_20_9)
		arg_20_0.m_heroNameText_.text = string.format("%s·%s", var_20_8.name, var_20_8.suffix)

		if arg_20_0.heroAnimator_ then
			SetActive(arg_20_0.heroIconGo_, false)
			arg_20_0.heroAnimator_:Play("PolyhedronRankUI_Hero", -1, 0)
		end
	end

	if arg_20_0.tabConState_ == nil then
		arg_20_0.tabConState_ = {
			"all",
			"club"
		}
	end

	arg_20_0.rankTypeController_:SetSelectedState(arg_20_0.tabConState_[arg_20_0.rankType_])
	arg_20_0.subTypeController_:SetSelectedIndex(arg_20_0.subType_ - 1)
end

function var_0_0.IndexItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.rankList_[arg_21_1]

	arg_21_2:Refresh(var_21_0)
end

function var_0_0.RefreshGuildRankGo(arg_22_0)
	if GuildData:GetGuildInfo().id == nil then
		arg_22_0.tabNumController_:SetSelectedState("01")
	else
		arg_22_0.tabNumController_:SetSelectedState("02")
	end
end

function var_0_0.IndexHeroItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.heroIDList_[arg_23_1]

	arg_23_2:SetData(var_23_0, arg_23_0:GetRankID(), arg_23_0:GetHeroSkinID(var_23_0), arg_23_0:GetSendSeverHeroID(var_23_0))
	arg_23_2:SetClickHandler(arg_23_0.heroClickHandler_)
	arg_23_2:SetSelect(arg_23_0.heroID_)
end

function var_0_0.AddTimer(arg_24_0)
	arg_24_0.activityID_ = arg_24_0:GetActivityID()
	arg_24_0.stopTime_ = ActivityData:GetActivityData(arg_24_0.activityID_).stopTime

	arg_24_0:StopTimer()

	arg_24_0.timeText_.text = manager.time:GetLostTimeStr(arg_24_0.stopTime_)
	arg_24_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_24_0.stopTime_ then
			arg_24_0:StopTimer()

			arg_24_0.timeText_.text = GetTips("TIME_OVER")

			return
		end

		arg_24_0.timeText_.text = manager.time:GetLostTimeStr(arg_24_0.stopTime_)
	end, 1, -1)
end

function var_0_0.StopTimer(arg_26_0)
	if arg_26_0.timer_ then
		arg_26_0.timer_:Stop()
	end

	arg_26_0.timer_ = nil
end

function var_0_0.GetRankID(arg_27_0)
	return arg_27_0.params_.rankID or arg_27_0:GetActivityID()
end

function var_0_0.GetActivityID(arg_28_0)
	return arg_28_0.params_.activityID
end

function var_0_0.GetHeroList(arg_29_0)
	return RankTools.GetRankHeroList(arg_29_0:GetRankID(), arg_29_0:GetActivityID())
end

function var_0_0.GetHeroSkinID(arg_30_0, arg_30_1)
	local var_30_0 = table.keyof(arg_30_0.heroIDList_, arg_30_1)
	local var_30_1 = arg_30_0.trialIDList_[var_30_0]

	if var_30_1 == nil or var_30_1 == 0 then
		return HeroTools.HeroUsingSkinInfo(arg_30_1).id
	else
		return HeroStandardSystemCfg[var_30_1].skin_id
	end
end

function var_0_0.GetSendSeverHeroID(arg_31_0, arg_31_1)
	local var_31_0 = table.keyof(arg_31_0.heroIDList_, arg_31_1)

	if arg_31_0.trialIDList_[var_31_0] and arg_31_0.trialIDList_[var_31_0] ~= 0 then
		return arg_31_0.trialIDList_[var_31_0]
	end

	return arg_31_1
end

return var_0_0
