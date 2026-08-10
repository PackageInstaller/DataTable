local var_0_0 = class("ActivityInvitePlotView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionConserverUI/JapanRegionContenuUI"
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

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetItem), arg_4_0.listGo_, ActivityInvitePlotItem)
end

function var_0_0.SetItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData({
		id = arg_5_0.inviteCfg.chat_order_seq[arg_5_1],
		role = arg_5_0.inviteCfg.chat_name_seq[arg_5_1],
		heroId = arg_5_0.inviteCfg.hero_id
	}, arg_5_1, arg_5_0.inviteCfg, arg_5_0.index)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.finishBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.listBtn_, nil, function()
		arg_6_0.index = arg_6_0.index + 1

		if #arg_6_0.inviteCfg.chat_order_seq > arg_6_0.index - 1 then
			arg_6_0.list:StartScroll(arg_6_0.index, arg_6_0.index)
			manager.audio:PlayEffect("minigame_activity_2_6", "minigame_activity_2_6_talk_3", "")
		else
			SetActive(arg_6_0.finishBtn_.gameObject, true)
		end
	end)
end

function var_0_0.UpdateBar(arg_9_0)
	return
end

function var_0_0.UpdateView(arg_10_0)
	arg_10_0.activityId = InviteData:GetDataByPara("activityId")

	local var_10_0 = ActivityData:GetActivityData(arg_10_0.activityId)

	SetActive(arg_10_0.finishBtn_.gameObject, false)

	arg_10_0.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(var_10_0.stopTime, nil, true)
	arg_10_0.updateTimer_ = Timer.New(function()
		arg_10_0.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(var_10_0.stopTime, nil, true)
	end, 1, var_10_0.stopTime, 1)
	arg_10_0.inviteCfg = ActivityInviteCfg[arg_10_0.params_.id]

	local var_10_1 = HeroCfg[arg_10_0.inviteCfg.hero_id]

	arg_10_0.nameTxt_.text = GetI18NText(var_10_1.suffix)
	arg_10_0.roleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/" .. tostring(arg_10_0.inviteCfg.hero_image_route))

	arg_10_0.list:StartScroll(arg_10_0.index, arg_10_0.index)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.index = 1

	arg_12_0:UpdateView()
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()

	if arg_13_0.updateTimer_ then
		arg_13_0.updateTimer_:Stop()

		arg_13_0.updateTimer_ = nil
	end

	if arg_13_0.params_.haveReward then
		arg_13_0.params_.haveReward = false

		ShowTips("ACTIVITY_INVITE_FINISH_TIPS")
	end
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)

	if arg_15_0.list then
		arg_15_0.list:Dispose()

		arg_15_0.list = nil
	end

	Object.Destroy(arg_15_0.gameObject_)
end

return var_0_0
