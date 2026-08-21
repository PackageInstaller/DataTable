local var_0_0 = class("AreaBattleAreaView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityAreaBattleData:GetPrefabByActivityID(arg_1_0.params_.activityId) .. "NormalfightingAreaUI"
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

	arg_4_0.itemList = {}
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.UpdateView(arg_6_0)
	for iter_6_0 = 1, 4 do
		local var_6_0 = arg_6_0.itemList[iter_6_0]

		if not var_6_0 then
			var_6_0 = AreaBattleAreaItem.New(arg_6_0["item" .. iter_6_0 .. "Go_"])
			arg_6_0.itemList[iter_6_0] = var_6_0
		end

		var_6_0:SetData(iter_6_0, ActivityCfg[arg_6_0.activityID].sub_activity_list[iter_6_0], arg_6_0.data[ActivityCfg[arg_6_0.activityID].sub_activity_list[iter_6_0]], arg_6_0.activityID)
	end

	arg_6_0.titleTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_NAME")
end

function var_0_0.UpdateData(arg_7_0)
	arg_7_0.activityID = arg_7_0.params_.activityId
	arg_7_0.data = ActivityAreaBattleData:GetDataByActivityID(arg_7_0.activityID) or {}
end

function var_0_0.AddTimer(arg_8_0)
	arg_8_0.stopTime_ = ActivityData:GetActivityData(arg_8_0.activityID).stopTime
	arg_8_0.remainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(arg_8_0.stopTime_, true))
	arg_8_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_8_0.stopTime_ then
			arg_8_0.remainTxt_.text = GetTips("TIME_OVER")

			return
		end

		arg_8_0.remainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(arg_8_0.stopTime_, true))
	end, 1, -1)

	arg_8_0.timer_:Start()
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:UpdateData()
	arg_10_0:UpdateView()
	arg_10_0:AddTimer()
end

function var_0_0.OnExit(arg_11_0)
	if arg_11_0.timer_ then
		arg_11_0.timer_:Stop()

		arg_11_0.timer_ = nil
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0.itemList) do
		iter_11_1:OnExit()
	end

	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_AREA_BATTLE_DESCRIBE")
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.itemList) do
		iter_13_1:Dispose()
	end

	arg_13_0.itemList = {}

	var_0_0.super.Dispose(arg_13_0)
	Object.Destroy(arg_13_0.gameObject_)
end

return var_0_0
