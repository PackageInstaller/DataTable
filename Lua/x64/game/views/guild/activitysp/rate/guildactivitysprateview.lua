local var_0_0 = class("GuildActivitySPRateView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivitySPUI/GuildActivitySPRatePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.premissItemList_ = LuaList.New(handler(arg_5_0, arg_5_0.RefreshItem), arg_5_0.uiList_, GuildActivitySPRatePremissItem)
	arg_5_0.levelController_ = ControllerUtil.GetController(arg_5_0.transform_, "level")
	arg_5_0.stateController_ = ControllerUtil.GetController(arg_5_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.AddEventListeners(arg_8_0)
	return
end

function var_0_0.OnEnter(arg_9_0)
	GuildActivitySPLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true

	manager.windowBar:HideBar()
	arg_9_0:AddEventListeners()

	arg_9_0.activityID_ = arg_9_0.params_.activityID
	arg_9_0.curRateID_ = GuildActivitySPData:GetCurRateID(arg_9_0.activityID_)

	local var_9_0 = ActivityClubSPLevelSettingCfg.get_id_list_by_activity[arg_9_0.activityID_]
	local var_9_1 = table.keyof(var_9_0, arg_9_0.curRateID_)

	if var_9_1 then
		arg_9_0.nextRateID_ = var_9_0[var_9_1 + 1]
	end

	if arg_9_0.nextRateID_ ~= nil then
		arg_9_0.premissIDList_ = ActivityClubSPLevelSettingCfg[arg_9_0.nextRateID_].condition

		arg_9_0.stateController_:SetSelectedState("false")
	else
		arg_9_0.premissIDList_ = {}

		arg_9_0.stateController_:SetSelectedState("true")
	end

	arg_9_0:RefreshUI()
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.premissItemList_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.premissItemList_:StartScroll(#arg_11_0.premissIDList_)

	local var_11_0 = ActivityClubSPLevelSettingCfg[arg_11_0.curRateID_]

	arg_11_0.levelController_:SetSelectedState(tostring(var_11_0.user_level))

	arg_11_0.titleText_.text = var_11_0.desc
	arg_11_0.domainMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_CAT"), #var_11_0.dispatch or 0)
	arg_11_0.heroMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_HERO"), var_11_0.max_hero)
end

function var_0_0.RefreshItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_0.premissIDList_[arg_12_1], arg_12_0.activityID_)
end

return var_0_0
