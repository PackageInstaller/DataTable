local var_0_0 = class("AreaBattleAreaItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller = arg_3_0.controller_:GetController("state")

	arg_3_0:AddBtnListener(arg_3_0.clickBtn_, nil, function()
		JumpTools.GoToSystem("/AreaBattleMapView", {
			selectIndex = 999,
			index = arg_3_0.index,
			activityID = arg_3_0.activityID,
			mainActivityID = arg_3_0.mainActivityID
		})
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_AREA_NEW, arg_3_0.activityID), 0)
		saveData("AREA_BATTLE", string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_AREA_NEW, arg_3_0.activityID), "1")
	end)
	arg_3_0:AddBtnListener(arg_3_0.lockBtn_, nil, function()
		ShowTips(string.format(GetTips("ACTIVITY_AREA_BATTLE_UNLOCK_TIME"), manager.time:GetLostTimeStr(arg_3_0.startTime_)))
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.index = arg_6_1
	arg_6_0.cfg = ActivityAreaBattleCfg[arg_6_2]
	arg_6_0.data = arg_6_3
	arg_6_0.activityID = arg_6_2
	arg_6_0.mainActivityID = arg_6_4

	arg_6_0:AddTimer()
	arg_6_0:UpdateView()
	arg_6_0:BindRedPoint()
end

function var_0_0.BindRedPoint(arg_7_0)
	manager.redPoint:bindUIandKey(arg_7_0.gameObject_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_AREA, arg_7_0.activityID))
end

function var_0_0.AddTimer(arg_8_0)
	local var_8_0 = ActivityData:GetActivityData(arg_8_0.activityID)

	arg_8_0.stopTime_ = var_8_0.stopTime
	arg_8_0.startTime_ = var_8_0.startTime
	arg_8_0.lockTxt_.text = string.format(GetTips("ACTIVITY_AREA_BATTLE_UNLOCK_TIME"), manager.time:GetLostTimeStr(arg_8_0.startTime_))
	arg_8_0.timer = Timer.New(function()
		arg_8_0:UpdateController()
	end, 1, -1)

	arg_8_0.timer:Start()
end

function var_0_0.UpdateController(arg_10_0)
	if manager.time:GetServerTime() >= arg_10_0.startTime_ then
		arg_10_0.lockTxt_.text = GetTips("TIME_OVER")

		arg_10_0.controller:SetSelectedState("normal")

		local var_10_0, var_10_1 = TaskTools.GetCompleteTaskNumInfo(arg_10_0.activityID)

		if var_10_1 <= var_10_0 then
			arg_10_0.controller:SetSelectedState("complete")
		end

		return
	end

	arg_10_0.lockTxt_.text = string.format(GetTips("ACTIVITY_AREA_BATTLE_UNLOCK_TIME"), manager.time:GetLostTimeStr(arg_10_0.startTime_))

	arg_10_0.controller:SetSelectedState("lock")
end

function var_0_0.UpdateView(arg_11_0)
	arg_11_0:UpdateController()

	arg_11_0.areaTxt_.text = arg_11_0.cfg.name

	local var_11_0, var_11_1 = TaskTools.GetCompleteTaskNumInfo(arg_11_0.activityID)

	arg_11_0.rewardTxt_.text = var_11_0 .. "/" .. var_11_1
	arg_11_0.areaNameTxt_.text = arg_11_0.cfg.name
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:UpdateView()
end

function var_0_0.OnExit(arg_13_0)
	if arg_13_0.timer then
		arg_13_0.timer:Stop()

		arg_13_0.timer = nil
	end

	arg_13_0:UnbindRedPoint()
end

function var_0_0.UnbindRedPoint(arg_14_0)
	manager.redPoint:unbindUIandKey(arg_14_0.gameObject_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_AREA, arg_14_0.activityID))
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
	Object.Destroy(arg_15_0.gameObject_)
end

return var_0_0
