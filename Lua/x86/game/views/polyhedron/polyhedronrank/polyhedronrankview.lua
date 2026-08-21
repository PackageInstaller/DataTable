local var_0_0 = class("PolyhedronRankView", ReduxView)

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

	arg_3_0.subTypeController = ControllerUtil.GetController(arg_3_0.m_subTypeController, "subType")
	arg_3_0.tabController_ = arg_3_0.toggleConEx:GetController("tab")
	arg_3_0.tabNumController_ = arg_3_0.toggleConEx:GetController("num")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, PolyhedronRankItem)
	arg_4_0.heroList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexHeroItem), arg_4_0.heroListGo_, PolyhedronRankHeroItem)
	arg_4_0.heroClickHandler_ = handler(arg_4_0, arg_4_0.OnClickHero)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_scoreBtn, nil, function()
		if arg_5_0.subType == PolyhedronConst.RANK_SUB_TYPE.SCORE then
			return
		end

		arg_5_0:SwitchRank(arg_5_0.rankType, PolyhedronConst.RANK_SUB_TYPE.SCORE, arg_5_0.heroID)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_heroBtn, nil, function()
		if arg_5_0.subType == PolyhedronConst.RANK_SUB_TYPE.HERO then
			return
		end

		if arg_5_0.heroIDList_ == nil then
			PolyhedronAction.QueryCurRank(PolyhedronConst.RANK_SUB_TYPE.HERO, function()
				arg_5_0:SelectHeroRank()
			end)
		else
			arg_5_0:SelectHeroRank()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_guildBtn, nil, function()
		if arg_5_0.rankType == PolyhedronConst.RANK_TYPE.GUILD then
			return
		end

		arg_5_0:SwitchRank(PolyhedronConst.RANK_TYPE.GUILD, arg_5_0.subType, arg_5_0.heroID)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_allBtn, nil, function()
		if arg_5_0.rankType == PolyhedronConst.RANK_TYPE.ALL then
			return
		end

		arg_5_0:SwitchRank(PolyhedronConst.RANK_TYPE.ALL, arg_5_0.subType, arg_5_0.heroID)
	end)
end

function var_0_0.SelectHeroRank(arg_11_0)
	arg_11_0.heroIDList_ = PolyhedronData:GetSortRankHeroIDList()

	local var_11_0 = arg_11_0.heroID or arg_11_0.heroIDList_[1]

	arg_11_0:SwitchRank(arg_11_0.rankType, PolyhedronConst.RANK_SUB_TYPE.HERO, var_11_0)
	arg_11_0.heroList_:StartScroll(#arg_11_0.heroIDList_)
end

function var_0_0.SwitchRank(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = true

	if arg_12_0.initCache[arg_12_1] and arg_12_0.initCache[arg_12_1][arg_12_2] then
		if arg_12_2 == PolyhedronConst.RANK_SUB_TYPE.HERO and not arg_12_0.initCache[arg_12_1][arg_12_2][arg_12_3] then
			var_12_0 = false
		end
	else
		var_12_0 = false
	end

	if var_12_0 == true then
		arg_12_0:Refresh(arg_12_1, arg_12_2, arg_12_3)
	elseif arg_12_1 == PolyhedronConst.RANK_TYPE.GUILD then
		PolyhedronAction.QueryGuildRankList(arg_12_2, arg_12_3)
	else
		PolyhedronAction.QueryRankList(arg_12_2, arg_12_3)
	end
end

function var_0_0.OnClickHero(arg_13_0, arg_13_1)
	if arg_13_0.heroID == arg_13_1 then
		return
	end

	local var_13_0 = arg_13_0.heroList_:GetItemList()

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		iter_13_1:SetSelect(arg_13_1)
	end

	arg_13_0:SwitchRank(arg_13_0.rankType, arg_13_0.subType, arg_13_1)
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnUpdate(arg_15_0)
	if arg_15_0.params_.type == nil then
		return
	end

	local var_15_0 = arg_15_0.params_.type
	local var_15_1 = arg_15_0.params_.subType
	local var_15_2 = arg_15_0.params_.heroID

	arg_15_0.params_.type = nil
	arg_15_0.params_.subType = nil
	arg_15_0.params_.heroID = nil

	arg_15_0:Refresh(var_15_0, var_15_1, var_15_2)
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0.panelAnim_:Update(0)

	arg_16_0.initCache = {}
	arg_16_0.heroCache = {}

	if arg_16_0.params_.subType ~= PolyhedronConst.RANK_SUB_TYPE.HERO then
		arg_16_0.heroIDList_ = nil
	else
		local var_16_0 = table.indexof(arg_16_0.heroIDList_, arg_16_0.heroID) or 1

		arg_16_0.heroList_:StartScroll(#arg_16_0.heroIDList_, var_16_0)
	end

	arg_16_0:RefreshGuildRankGo()
	arg_16_0:OnUpdate()
	arg_16_0:AddTimer()
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:StopTimer()
	manager.windowBar:HideBar()
end

function var_0_0.Refresh(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0.initCache[arg_18_1] = arg_18_0.initCache[arg_18_1] or {}

	if arg_18_2 == PolyhedronConst.RANK_SUB_TYPE.SCORE then
		arg_18_0.initCache[arg_18_1][arg_18_2] = true
	else
		arg_18_0.initCache[arg_18_1][arg_18_2] = arg_18_0.initCache[arg_18_1][arg_18_2] or {}
		arg_18_0.initCache[arg_18_1][arg_18_2][arg_18_3] = true
	end

	arg_18_0.rankType = arg_18_1
	arg_18_0.subType = arg_18_2

	if arg_18_2 == PolyhedronConst.RANK_SUB_TYPE.HERO then
		arg_18_3 = arg_18_3 or arg_18_0.heroIDList_[1]
		arg_18_0.heroID = arg_18_3
	end

	local var_18_0 = 0

	if arg_18_0.subType == PolyhedronConst.RANK_SUB_TYPE.HERO then
		var_18_0 = arg_18_0.heroID
	else
		var_18_0 = 0
	end

	if arg_18_0.rankType == PolyhedronConst.RANK_TYPE.ALL then
		local var_18_1 = RankData:GetCommonRank(RankConst.RANK_ID.POLYHERON, var_18_0)

		arg_18_0.rankList = var_18_1 and var_18_1.rankList or {}

		if var_18_1 then
			local var_18_2, var_18_3 = var_18_1:GetCurRankDes()

			arg_18_0.m_rank.text = var_18_2
			arg_18_0.m_score.text = var_18_3
		else
			arg_18_0.m_rank.text = ""
			arg_18_0.m_score.text = ""
		end
	else
		local var_18_4 = RankData:GetGuildCommonRank(RankConst.RANK_ID.POLYHERON, var_18_0)

		arg_18_0.rankList = var_18_4 and var_18_4.rankList or {}

		if var_18_4 then
			local var_18_5, var_18_6 = var_18_4:GetCurRankDes()

			arg_18_0.m_rank.text = var_18_5
			arg_18_0.m_score.text = var_18_6
		else
			arg_18_0.m_rank.text = ""
			arg_18_0.m_score.text = ""
		end
	end

	arg_18_0.list_:StartScroll(#arg_18_0.rankList)

	if arg_18_2 == PolyhedronConst.RANK_SUB_TYPE.SCORE then
		local var_18_7 = PlayerData:GetPlayerInfo()

		arg_18_0.commonPortrait_:RenderHead(var_18_7 and var_18_7.portrait)
		arg_18_0.commonPortrait_:RenderFrame(var_18_7.icon_frame)

		if arg_18_0.playerAnimator_ then
			SetActive(arg_18_0.playerIconGo_, false)
			arg_18_0.playerAnimator_:Play("PolyhedronRankUI_Hero", -1, 0)
		end
	else
		local var_18_8 = HeroCfg[arg_18_3]
		local var_18_9 = PolyhedronData:GetHeroUsingSkinInfo(arg_18_3).id

		arg_18_0.m_heroIcon.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. var_18_9)
		arg_18_0.m_heroNameText_.text = string.format("%s·%s", GetI18NText(var_18_8.name), GetI18NText(var_18_8.suffix))

		if arg_18_0.heroAnimator_ then
			SetActive(arg_18_0.heroIconGo_, false)
			arg_18_0.heroAnimator_:Play("PolyhedronRankUI_Hero", -1, 0)
		end
	end

	if arg_18_0.tabConState_ == nil then
		arg_18_0.tabConState_ = {
			"all",
			"club"
		}
	end

	arg_18_0.tabController_:SetSelectedState(arg_18_0.tabConState_[arg_18_0.rankType])
	arg_18_0.subTypeController:SetSelectedIndex(arg_18_0.subType - 1)
end

function var_0_0.IndexItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.rankList[arg_19_1]

	arg_19_2:Refresh(var_19_0)
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0.commonPortrait_:Dispose()
	arg_20_0.list_:Dispose()

	arg_20_0.list_ = nil

	arg_20_0.heroList_:Dispose()

	arg_20_0.heroList_ = nil
	arg_20_0.heroClickHandler_ = nil

	PolyhedronAction.ResetRankCache()
	var_0_0.super.Dispose(arg_20_0)
end

function var_0_0.RefreshGuildRankGo(arg_21_0)
	if GuildData:GetGuildInfo().id == nil then
		arg_21_0.tabNumController_:SetSelectedState("01")
	else
		arg_21_0.tabNumController_:SetSelectedState("02")
	end
end

function var_0_0.IndexHeroItem(arg_22_0, arg_22_1, arg_22_2)
	arg_22_2:SetData(arg_22_0.heroIDList_[arg_22_1])
	arg_22_2:SetClickHandler(arg_22_0.heroClickHandler_)
	arg_22_2:SetSelect(arg_22_0.heroID)
end

function var_0_0.AddTimer(arg_23_0)
	arg_23_0.activityID_ = PolyhedronData:GetActivityID()
	arg_23_0.stopTime_ = ActivityData:GetActivityData(arg_23_0.activityID_).stopTime

	arg_23_0:StopTimer()

	arg_23_0.timeText_.text = manager.time:GetLostTimeStr(arg_23_0.stopTime_)
	arg_23_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_23_0.stopTime_ then
			arg_23_0:StopTimer()

			arg_23_0.timeText_.text = GetTips("TIME_OVER")

			return
		end

		arg_23_0.timeText_.text = manager.time:GetLostTimeStr(arg_23_0.stopTime_)
	end, 1, -1)
end

function var_0_0.StopTimer(arg_25_0)
	if arg_25_0.timer_ then
		arg_25_0.timer_:Stop()
	end

	arg_25_0.timer_ = nil
end

function var_0_0.AdaptLeft(arg_26_0)
	if arg_26_0.leftTrs_ == nil then
		arg_26_0.leftGo_ = arg_26_0:FindGo("RankList_01/panel/left")
		arg_26_0.leftTrs_ = arg_26_0.leftGo_:GetComponent(typeof(RectTransform))
		arg_26_0.needAdaptLeft_ = false
	end

	var_0_0.super.AdaptLeft(arg_26_0)
end

function var_0_0.AdaptRight(arg_27_0)
	if arg_27_0.rightTrs_ == nil then
		arg_27_0.rightGo_ = arg_27_0:FindGo("RankList_01/panel/right_adapt")
		arg_27_0.rightTrs_ = arg_27_0.rightGo_:GetComponent(typeof(RectTransform))
		arg_27_0.needAdaptRight_ = true
	end

	var_0_0.super.AdaptRight(arg_27_0)
end

return var_0_0
