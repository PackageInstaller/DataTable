local var_0_0 = class("OsirisPlayGameRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Osiris/Activity_Osiris_RankUI"
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

	arg_4_0.tabController_ = arg_4_0.toggleConEx:GetController("tab")
	arg_4_0.tabNumController_ = arg_4_0.toggleConEx:GetController("num")
	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetListItem), arg_4_0.list_, OsirisPlayGameRankItem)
	arg_4_0.commonPortrait_ = CommonHeadPortrait.New(arg_4_0.headItem_)
	arg_4_0.tabConList_ = {}

	for iter_4_0 = 1, 6 do
		local var_4_0 = arg_4_0["tab_" .. iter_4_0].gameObject

		arg_4_0.tabConList_[iter_4_0] = ControllerUtil.GetController(var_4_0.transform, "name")
	end
end

function var_0_0.SetListItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.rankData[arg_5_1]

	arg_5_2:SetData(var_5_0, arg_5_1)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.clubBtn_, nil, function()
		arg_6_0:SwitchPageIfDiff(1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.allBtn_, nil, function()
		arg_6_0:SwitchPageIfDiff(2)
	end)

	for iter_6_0 = 1, 6 do
		arg_6_0:AddBtnListener(arg_6_0["tab_" .. iter_6_0], nil, function()
			if arg_6_0.selectIndex == iter_6_0 then
				return
			end

			arg_6_0.selectIndex = iter_6_0
			arg_6_0.activityID = ActivityCfg[arg_6_0.rankActivityID].sub_activity_list[arg_6_0.selectIndex]

			RankAction.QueryActivityRank(arg_6_0.activityID)
			arg_6_0:RefreshTab(iter_6_0)
			arg_6_0:SwitchPage(2)
		end)
	end
end

function var_0_0.SwitchPage(arg_10_0, arg_10_1)
	if arg_10_0.tabConState_ == nil then
		arg_10_0.tabConState_ = {
			"club",
			"all"
		}
	end

	arg_10_0.tabController_:SetSelectedState(arg_10_0.tabConState_[arg_10_1])

	arg_10_0.curPage_ = arg_10_1
	arg_10_0.rankData = arg_10_0:GetListFromIndex(arg_10_1)

	arg_10_0:UpdateView()
end

function var_0_0.SwitchPageIfDiff(arg_11_0, arg_11_1)
	if arg_11_0.curPage_ ~= arg_11_1 then
		arg_11_0:SwitchPage(arg_11_1)
	end
end

function var_0_0.UpdateView(arg_12_0)
	arg_12_0.list:StartScroll(#arg_12_0.rankData)

	local var_12_0 = RankData[arg_12_0.curPage_ == 1 and "GetGuildActivityRank" or "GetActivityRank"](RankData, arg_12_0.activityID)

	if var_12_0 then
		local var_12_1, var_12_2 = var_12_0:GetCurRankDes()

		arg_12_0.myScoreLabel_.text = var_12_2
		arg_12_0.myRankLabel_.text = var_12_1
	else
		arg_12_0.myScoreLabel_.text = ""
		arg_12_0.myRankLabel_.text = ""
	end
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.selectIndex = 1

	local var_13_0 = arg_13_0.params_.activityID

	arg_13_0.rankActivityID = ActivityCfg[var_13_0].sub_activity_list[1]
	arg_13_0.activityID = ActivityCfg[arg_13_0.rankActivityID].sub_activity_list[arg_13_0.selectIndex]

	RankAction.QueryActivityRank(arg_13_0.activityID)

	arg_13_0.nameLabel_.text = PlayerData:GetPlayerInfo().nick

	arg_13_0.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	arg_13_0.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)

	local var_13_1 = true

	if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
		var_13_1 = false
	end

	arg_13_0.tabNumController_:SetSelectedState(var_13_1 and "02" or "01")

	if var_13_1 then
		RankAction.QueryGuildActivityRank(arg_13_0.activityID)
	end

	arg_13_0:RefreshTab(1)
end

function var_0_0.RefreshTab(arg_14_0, arg_14_1)
	for iter_14_0 = 1, 6 do
		arg_14_0.tabConList_[iter_14_0]:SetSelectedIndex(iter_14_0 == arg_14_1 and 0 or 1)
	end
end

function var_0_0.GetListFromIndex(arg_15_0, arg_15_1)
	if arg_15_1 == 1 then
		local var_15_0 = RankData:GetGuildActivityRank(arg_15_0.activityID)

		return var_15_0 and var_15_0.rankList or {}
	else
		local var_15_1 = RankData:GetActivityRank(arg_15_0.activityID)

		return var_15_1 and var_15_1.rankList or {}
	end
end

function var_0_0.OnExit(arg_16_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnRankUpdate(arg_18_0)
	arg_18_0:SwitchPage(2)

	arg_18_0.isInit_ = true
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0.commonPortrait_:Dispose()

	if arg_19_0.list then
		arg_19_0.list:Dispose()

		arg_19_0.list = nil
	end

	if arg_19_0.tabConList_ then
		arg_19_0.tabConList_ = nil
	end

	var_0_0.super.Dispose(arg_19_0)
	Object.Destroy(arg_19_0.gameObject_)
end

return var_0_0
