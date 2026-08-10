local var_0_0 = class("PushSnowBallRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballRankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.rankTypeConst_ = PushSnowBallData:GetRankTypeConst()

	arg_3_0:InitUI()

	arg_3_0.modeController_ = ControllerUtil.GetController(arg_3_0.transform_, "mode")
	arg_3_0.guildController_ = ControllerUtil.GetController(arg_3_0.guildBtn_.transform, "toggle")
	arg_3_0.allController_ = ControllerUtil.GetController(arg_3_0.allBtn_.transform, "toggle")
	arg_3_0.bossController_ = ControllerUtil.GetController(arg_3_0.bossModelBtn_.transform, "toggle")
	arg_3_0.survivalController_ = ControllerUtil.GetController(arg_3_0.survivalModelBtn_.transform, "toggle")

	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.rankList_, PushSnowBallRankItem)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.allBtn_, nil, function()
		if PushSnowBallData:GetCurRankType() ~= arg_5_0.rankTypeConst_.ALL then
			RankAction.QueryActivityRank(arg_5_0.activityID_, arg_5_0.index)
		end

		PushSnowBallData:SetCurRankType(arg_5_0.rankTypeConst_.ALL)
		arg_5_0.allController_:SetSelectedState("on")
		arg_5_0.guildController_:SetSelectedState("off")
		arg_5_0:Refresh()
	end)
	arg_5_0:AddBtnListener(arg_5_0.guildBtn_, nil, function()
		if PushSnowBallData:GetCurRankType() ~= arg_5_0.rankTypeConst_.GUILD then
			RankAction.QueryGuildActivityRank(arg_5_0.activityID_, arg_5_0.index)
		end

		PushSnowBallData:SetCurRankType(arg_5_0.rankTypeConst_.GUILD)
		arg_5_0.guildController_:SetSelectedState("on")
		arg_5_0.allController_:SetSelectedState("off")
		arg_5_0:Refresh()
	end)
	arg_5_0:AddBtnListener(arg_5_0.bossModelBtn_, nil, function()
		arg_5_0:OnClickSubType(1)
		arg_5_0.bossController_:SetSelectedState("on")
		arg_5_0.survivalController_:SetSelectedState("off")
	end)
	arg_5_0:AddBtnListener(arg_5_0.survivalModelBtn_, nil, function()
		arg_5_0:OnClickSubType(2)
		arg_5_0.survivalController_:SetSelectedState("on")
		arg_5_0.bossController_:SetSelectedState("off")
	end)
end

function var_0_0.OnClickSubType(arg_10_0, arg_10_1)
	local var_10_0 = PushSnowBallData:GetCurRankType()

	if arg_10_0.index ~= arg_10_1 then
		if var_10_0 == arg_10_0.rankTypeConst_.ALL then
			RankAction.QueryActivityRank(arg_10_0.activityID_, arg_10_1)
		elseif var_10_0 == arg_10_0.rankTypeConst_.GUILD then
			RankAction.QueryGuildActivityRank(arg_10_0.activityID_, arg_10_1)
		end
	end

	arg_10_0.index = arg_10_1

	arg_10_0:Refresh()
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.activityID_ = PushSnowBallData:GetTeamRankActivtyID()

	local var_11_0 = ActivityData:GetActivityData(arg_11_0.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_11_0.startTime_ = var_11_0.startTime
	arg_11_0.stopTime_ = var_11_0.stopTime
	arg_11_0.index = 1

	RankAction.QueryActivityRank(arg_11_0.activityID_, arg_11_0.index)
	arg_11_0.bossController_:SetSelectedState("on")
	arg_11_0.survivalController_:SetSelectedState("off")
	arg_11_0:Refresh()
	arg_11_0:AddTimer()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0.pos_ = arg_12_0.list_:GetScrolledPosition()

	arg_12_0:StopTimer()
	manager.windowBar:HideBar()
	PushSnowBallData:SetCurRankType(arg_12_0.rankTypeConst_.ALL)
end

function var_0_0.Refresh(arg_13_0)
	local var_13_0 = PushSnowBallData:GetCurRankType()

	if arg_13_0.index == 1 then
		arg_13_0.modeController_:SetSelectedState("boss")
	else
		arg_13_0.modeController_:SetSelectedState("necking")
	end

	if var_13_0 == arg_13_0.rankTypeConst_.ALL then
		local var_13_1 = RankData:GetActivityRank(arg_13_0.activityID_, arg_13_0.index)

		arg_13_0.rankList = var_13_1 and var_13_1.rankList or {}

		if var_13_1 then
			local var_13_2, var_13_3 = var_13_1:GetCurRankDes()

			arg_13_0.rankText_.text = var_13_2
			arg_13_0.scoreText_.text = var_13_3
		else
			arg_13_0.rankText_.text = ""
			arg_13_0.scoreText_.text = ""
		end
	else
		local var_13_4 = RankData:GetGuildActivityRank(arg_13_0.activityID_, arg_13_0.index)

		arg_13_0.rankList = var_13_4 and var_13_4.rankList or {}

		if var_13_4 then
			local var_13_5, var_13_6 = var_13_4:GetCurRankDes()

			arg_13_0.rankText_.text = var_13_5
			arg_13_0.scoreText_.text = var_13_6
		else
			arg_13_0.rankText_.text = ""
			arg_13_0.scoreText_.text = ""
		end
	end

	arg_13_0.list_:StartScroll(#arg_13_0.rankList)

	if arg_13_0.pos_ then
		arg_13_0.list_:SetScrolledPosition(arg_13_0.pos_)
	end

	local var_13_7 = PlayerData:GetPlayerInfo()

	arg_13_0.nameText_.text = var_13_7 and var_13_7.nick
	arg_13_0.iconImg_.sprite = ItemTools.getItemSprite(var_13_7 and var_13_7.portrait)
	arg_13_0.frameImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. var_13_7.icon_frame)

	arg_13_0:RefreshGuildRankGo()
end

function var_0_0.IndexItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.rankList[arg_14_1]

	arg_14_2:Refresh(var_14_0, arg_14_0.index)
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.list_ then
		arg_15_0.list_:Dispose()

		arg_15_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_15_0)
end

function var_0_0.AddTimer(arg_16_0)
	arg_16_0:StopTimer()

	arg_16_0.leftTimeText_.text = manager.time:GetLostTimeStr2(arg_16_0.stopTime_, nil, true)
	arg_16_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_16_0.stopTime_ then
			return
		end

		arg_16_0.leftTimeText_.text = manager.time:GetLostTimeStr2(arg_16_0.stopTime_, nil, true)
	end, 1, -1)

	arg_16_0.timer_:Start()
end

function var_0_0.StopTimer(arg_18_0)
	if arg_18_0.timer_ then
		arg_18_0.timer_:Stop()

		arg_18_0.timer_ = nil
	end
end

function var_0_0.RefreshGuildRankGo(arg_19_0)
	if GuildData:GetGuildInfo().id == nil then
		SetActive(arg_19_0.guildBtn_.gameObject, false)
	else
		SetActive(arg_19_0.guildBtn_.gameObject, true)
	end
end

function var_0_0.OnRankUpdate(arg_20_0)
	arg_20_0:Refresh()
end

return var_0_0
