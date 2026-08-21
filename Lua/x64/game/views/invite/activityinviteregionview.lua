local var_0_0 = class("ActivityInviteRegionView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionConserverUI/JapanRegionCarteUI"
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

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetItem), arg_4_0.listGo_, ActivityInviteHeadItem)
	arg_4_0.drawController = ControllerUtil.GetController(arg_4_0.drawGo_.transform, "state")
	arg_4_0.listController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "state")
	arg_4_0.regionItem = {}

	for iter_4_0 = 1, 6 do
		arg_4_0.regionItem[iter_4_0] = ActivityInviteRegionItem.New(arg_4_0["regionGo" .. iter_4_0 .. "_"])
	end
end

function var_0_0.SetItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = InviteData:GetDataByPara("heroPlotList")

	arg_5_2:SetData({
		heroId = var_5_0[arg_5_1][1].hero_id,
		image = var_5_0[arg_5_1][1].hero_image_route
	}, arg_5_1, handler(arg_5_0, arg_5_0.SelectListener), arg_5_0.selectIndex)
end

function var_0_0.SelectListener(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == arg_6_0.selectIndex then
		return
	end

	if arg_6_0.completeHeroTable[arg_6_2] then
		arg_6_0.selectIndex = arg_6_1

		arg_6_0:UpdateView()
	else
		arg_6_0.selectIndex = nil

		arg_6_0:Back()
		JumpTools.GoToSystem("/ActivityInviteMain", {
			needBack = false,
			selectIndex = arg_6_1
		})
	end
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.drawBtn_, nil, function()
		local var_8_0 = InviteData:GetDataByPara("poolID")

		JumpTools.GoToSystem("/draw", {
			poolId = var_8_0
		}, ViewConst.SYSTEM_ID.DRAW)
	end)
end

function var_0_0.UpdateView(arg_9_0)
	if arg_9_0.updateTimer_ then
		arg_9_0.updateTimer_:Stop()

		arg_9_0.updateTimer_ = nil
	end

	local var_9_0 = InviteData:GetDataByPara("heroPlotList")
	local var_9_1 = GameSetting.activity_invite_daily_opportunities.value[1]

	arg_9_0.inviteTimes = InviteData:GetDataByPara("inviteTimes")
	arg_9_0.completeHeroTable = InviteData:GetDataByPara("completeHeroTable")
	arg_9_0.heroPlotList = var_9_0[arg_9_0.selectIndex]
	arg_9_0.heroId = arg_9_0.heroPlotList[1].hero_id
	arg_9_0.InviteTime_.text = string.format(GetTips("ACTIVITY_INVITE_TIME"), arg_9_0.inviteTimes)
	arg_9_0.inviteTxt_.text = string.format(GetTips("ACTIVITY_INVITE_REWARD_TIME"), var_9_1 - (#arg_9_0.completeHeroTable[arg_9_0.heroId] - 1) % 3)
	arg_9_0.activityId = InviteData:GetDataByPara("activityId")

	local var_9_2 = HeroCfg[arg_9_0.heroId]

	arg_9_0.roleIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/" .. arg_9_0.heroPlotList[1].hero_image_route)
	arg_9_0.nameTxt_.text = GetI18NText(var_9_2.suffix)

	for iter_9_0 = 1, 6 do
		local var_9_3 = arg_9_0.heroPlotList[iter_9_0 + 1].id

		arg_9_0.regionItem[iter_9_0]:SetData(var_9_3, iter_9_0)
	end

	SetActive(arg_9_0.headListGo_, #arg_9_0.completeHeroTable[arg_9_0.heroId] == 7)
	arg_9_0.listController:SetSelectedState(#arg_9_0.completeHeroTable[arg_9_0.heroId] == 7 and "2" or "1")

	if #arg_9_0.completeHeroTable[arg_9_0.heroId] == 7 then
		arg_9_0.list:StartScroll(#var_9_0)
	end

	arg_9_0:UpdateDrawController()

	local var_9_4 = ActivityData:GetActivityData(arg_9_0.activityId)

	arg_9_0.remainTime_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(var_9_4.stopTime, nil, true)
	arg_9_0.updateTimer_ = Timer.New(function()
		arg_9_0.remainTime_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(var_9_4.stopTime, nil, true)
	end, 1, var_9_4.stopTime, 1)

	arg_9_0.updateTimer_:Start()
end

function var_0_0.UpdateFreeDraw(arg_11_0)
	arg_11_0:UpdateDrawController()
end

function var_0_0.UpdateDrawController(arg_12_0)
	local var_12_0 = InviteData:GetDataByPara("drawItemId")
	local var_12_1 = ItemTools.getItemNum(var_12_0)
	local var_12_2 = InviteData:GetDataByPara("inviteTimes")
	local var_12_3 = InviteData:GetDataByPara("allComplete")

	if var_12_1 > 0 then
		arg_12_0.drawController:SetSelectedState("2")
	elseif var_12_2 == 0 and var_12_1 == 0 or var_12_3 then
		arg_12_0.drawController:SetSelectedState("3")
	else
		arg_12_0.drawController:SetSelectedState("1")
	end
end

function var_0_0.OnInviteUpdate(arg_13_0, arg_13_1)
	arg_13_0:UpdateView()

	if arg_13_1 == nil then
		return
	end

	JumpTools.GoToSystem("ActivityInvitePlotView", {
		id = arg_13_1,
		haveReward = arg_13_0.getReward
	})

	arg_13_0.getReward = nil
end

function var_0_0.OnInviteGetReward(arg_14_0, arg_14_1)
	arg_14_0.getReward = arg_14_1 ~= nil
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.selectHeroIndex = 1
	arg_15_0.selectIndex = arg_15_0.selectIndex or arg_15_0.params_.selectIndex
	arg_15_0.params_.selectIndex = nil

	manager.redPoint:bindUIandKey(arg_15_0.drawGo_.transform, RedPointConst.INVITE_DRAW, {
		x = 50,
		y = 70
	})
	arg_15_0:UpdateView()
end

function var_0_0.OnExit(arg_16_0)
	if arg_16_0.updateTimer_ then
		arg_16_0.updateTimer_:Stop()

		arg_16_0.updateTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(arg_16_0.drawGo_.transform, RedPointConst.INVITE_DRAW)
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)

	for iter_18_0, iter_18_1 in pairs(arg_18_0.regionItem) do
		iter_18_1:Dispose()
	end

	if arg_18_0.list then
		arg_18_0.list:Dispose()

		arg_18_0.list = nil
	end

	Object.Destroy(arg_18_0.gameObject_)
end

return var_0_0
