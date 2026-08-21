local var_0_0 = class("ActivityInviteMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionConserverUI/JapanRegionInvitationUI"
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

	arg_4_0.itemViewList = {}
	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetItem), arg_4_0.listGo_, ActivityInviteHeadItem)
	arg_4_0.drawController = ControllerUtil.GetController(arg_4_0.drawGo_.transform, "state")
end

function var_0_0.SetItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData({
		heroId = arg_5_0.heroPlotList[arg_5_1][1].hero_id,
		image = arg_5_0.heroPlotList[arg_5_1][1].hero_image_route
	}, arg_5_1, handler(arg_5_0, arg_5_0.SelectListener), arg_5_0.selectIndex)
end

function var_0_0.AddUIListener(arg_6_0)
	local function var_6_0()
		local var_7_0 = InviteData:GetDataByPara("activityId")
		local var_7_1 = arg_6_0.heroPlotList[arg_6_0.selectIndex][1].id

		if not InviteData:GetDataByPara("completeHeroTable")[var_7_1] then
			InviteAction.CompletePlot(var_7_0, var_7_1)
		end
	end

	arg_6_0:AddBtnListener(arg_6_0.drawBtn_, nil, function()
		local var_8_0 = InviteData:GetDataByPara("poolID")

		JumpTools.GoToSystem("/draw", {
			poolId = var_8_0
		}, ViewConst.SYSTEM_ID.DRAW)
	end)
	arg_6_0:AddBtnListener(arg_6_0.inviteBtn_, nil, function()
		local var_9_0 = HeroCfg[arg_6_0.heroPlotList[arg_6_0.selectIndex][1].hero_id]
		local var_9_1 = GetI18NText(var_9_0.suffix)

		if arg_6_0:SafeCheck() then
			arg_6_0:Back()
			JumpTools.GoToSystem("/ActivityInviteRegionView", {
				selectIndex = arg_6_0.selectIndex
			})

			return
		end

		if InviteData:GetDataByPara("inviteTimes") == 0 then
			ShowTips("ACTIVITY_INVITE_TIME_NOT_ENOUGH")

			return
		end

		ShowMessageBox({
			content = string.format(GetTips("ACTIVITY_INVITE_CONFIRM_TIPS"), var_9_1),
			OkCallback = var_6_0
		})
	end)
end

function var_0_0.SelectListener(arg_10_0, arg_10_1)
	if arg_10_0.list:GetItemList()[arg_10_1]:GetFinishController():GetSelectedState() == "2" then
		arg_10_0:Back()
		JumpTools.GoToSystem("/ActivityInviteRegionView", {
			selectIndex = arg_10_1
		})

		return
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.list:GetItemList()) do
		local var_10_0 = iter_10_1:GetController()

		if iter_10_1:GetFinishController() ~= "2" then
			arg_10_0.selectIndex = arg_10_1

			var_10_0:SetSelectedState(iter_10_0 == arg_10_0.selectIndex and "true" or "false")
		end
	end

	arg_10_0:UpdateRefreshView()
end

function var_0_0.UpdateDefaultView(arg_11_0)
	if arg_11_0.updateTimer_ then
		arg_11_0.updateTimer_:Stop()

		arg_11_0.updateTimer_ = nil
	end

	arg_11_0.activityId = InviteData:GetDataByPara("activityId")
	arg_11_0.heroPlotList = InviteData:GetDataByPara("heroPlotList")
	arg_11_0.drawItemId = InviteData:GetDataByPara("drawItemId")

	arg_11_0.list:StartScroll(#arg_11_0.heroPlotList)

	local var_11_0 = ActivityData:GetActivityData(arg_11_0.activityId)

	arg_11_0.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(var_11_0.stopTime, nil, true)
	arg_11_0.updateTimer_ = Timer.New(function()
		arg_11_0.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(var_11_0.stopTime, nil, true)
	end, 1, var_11_0.stopTime, 1)
end

function var_0_0.UpdateRefreshView(arg_13_0)
	local var_13_0 = arg_13_0.heroPlotList[arg_13_0.selectIndex][1].hero_id
	local var_13_1 = HeroCfg[var_13_0]

	arg_13_0.nameTxt_.text = GetI18NText(var_13_1.suffix)
	arg_13_0.roleImg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/" .. tostring(arg_13_0.heroPlotList[arg_13_0.selectIndex][1].hero_image_route))

	arg_13_0:UpdateDrawController()
end

function var_0_0.UpdateFreeDraw(arg_14_0)
	arg_14_0:UpdateDrawController()
end

function var_0_0.UpdateDrawController(arg_15_0)
	local var_15_0 = ItemTools.getItemNum(arg_15_0.drawItemId)
	local var_15_1 = InviteData:GetDataByPara("inviteTimes")
	local var_15_2 = InviteData:GetDataByPara("allComplete")
	local var_15_3 = GameSetting.activity_invite_daily_opportunities.value[1]

	arg_15_0.inviteTimeTxt_.text = string.format(GetTips("ACTIVITY_INVITE_TIME"), var_15_1)
	arg_15_0.inviteTxt_.text = string.format(GetTips("ACTIVITY_INVITE_REWARD_TIME"), var_15_3)

	if var_15_0 > 0 then
		arg_15_0.drawController:SetSelectedState("2")
	elseif var_15_1 == 0 and var_15_0 == 0 or var_15_2 then
		arg_15_0.drawController:SetSelectedState("3")
	else
		arg_15_0.drawController:SetSelectedState("1")
	end
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0.selectIndex = arg_16_0.params_.selectIndex or arg_16_0:GetDefaultSelect()

	arg_16_0:UpdateDefaultView()
	arg_16_0:UpdateRefreshView()
	arg_16_0:BindRedPoint()
end

function var_0_0.SafeCheck(arg_17_0)
	arg_17_0.heroPlotList = InviteData:GetDataByPara("heroPlotList")

	if InviteData:GetDataByPara("completeHeroTable")[arg_17_0.heroPlotList[arg_17_0.selectIndex][1].hero_id] then
		return true
	end

	return false
end

function var_0_0.GetDefaultSelect(arg_18_0)
	arg_18_0.heroPlotList = InviteData:GetDataByPara("heroPlotList")

	local var_18_0 = InviteData:GetDataByPara("completeHeroTable")

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.heroPlotList) do
		if var_18_0[iter_18_1[1].hero_id] == nil then
			return iter_18_0
		end
	end
end

function var_0_0.BindRedPoint(arg_19_0)
	manager.redPoint:bindUIandKey(arg_19_0.drawGo_.transform, RedPointConst.INVITE_DRAW, {
		x = 50,
		y = 70
	})
	manager.redPoint:bindUIandKey(arg_19_0.inviteBtn_.transform, RedPointConst.INVITE_PLOT, {
		x = 150,
		y = 35
	})
end

function var_0_0.UnbindRedPoint(arg_20_0)
	manager.redPoint:unbindUIandKey(arg_20_0.drawGo_.transform, RedPointConst.INVITE_DRAW)
	manager.redPoint:unbindUIandKey(arg_20_0.inviteBtn_.transform, RedPointConst.INVITE_PLOT)
end

function var_0_0.OnInviteUpdate(arg_21_0)
	arg_21_0:Back()
	JumpTools.GoToSystem("/ActivityInviteRegionView", {
		selectIndex = arg_21_0.selectIndex
	})
end

function var_0_0.OnExit(arg_22_0)
	arg_22_0:UnbindRedPoint()

	if arg_22_0.updateTimer_ then
		arg_22_0.updateTimer_:Stop()

		arg_22_0.updateTimer_ = nil
	end

	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_23_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_INVITE_DESCRIPTION")
end

function var_0_0.Dispose(arg_24_0)
	if arg_24_0.list then
		arg_24_0.list:Dispose()

		arg_24_0.list = nil
	end

	var_0_0.super.Dispose(arg_24_0)
	Object.Destroy(arg_24_0.gameObject_)
end

return var_0_0
