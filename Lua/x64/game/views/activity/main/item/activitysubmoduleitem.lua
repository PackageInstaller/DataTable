local var_0_0 = class("ActivitySubmoduleItem", ReduxView)
local var_0_1 = {
	ScarcattyBtn = "Summer_btn_00094",
	PTBtn = "Summer_btn_00093",
	frontierBtn = "Summer_btn_00010",
	onlineBtn = "Summer_btn_00008",
	challengedBtn = "Summer_btn_00009",
	plotBtn = "Summer_btn_00007",
	artifactBtn = "Summer_btn_00011"
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.activityId_ = ActivityTools.GetReprintActivityID(arg_1_2)
	arg_1_0.clickHandler_ = arg_1_3

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.controller_ = ControllerUtil.GetController(arg_2_0.transform_, "lock")
	arg_2_0.updateHandler_ = handler(arg_2_0, arg_2_0.UpdateActivity)
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0.activiteData_ = ActivityData:GetActivityData(arg_3_0.activityId_)
	arg_3_0.startTime_ = arg_3_0.activiteData_.startTime
	arg_3_0.stopTime_ = arg_3_0.activiteData_.stopTime

	if manager.time:GetServerTime() > arg_3_0.stopTime_ then
		if arg_3_0.activityId_ == ActivityConst.SIKADI_GAME then
			SummerLittleGameAction.InitSkadiRedPoint()
		elseif arg_3_0.activityId_ == ActivityConst.LEVIATHAN_GAME then
			SummerLittleGameAction.InitLeviathanRedPoint()
		end
	end

	arg_3_0:BindRedPoint()
	manager.notify:RegistListener(ACTIVITY_UPDATE, arg_3_0.updateHandler_)
	arg_3_0:RefreshUI()
	arg_3_0:AddTimer()
end

function var_0_0.OnExit(arg_4_0)
	arg_4_0:UnBindRedPoint()
	manager.notify:RemoveListener(ACTIVITY_UPDATE, arg_4_0.updateHandler_)
	arg_4_0:StopTimer()
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)

	arg_5_0.updateHandler_ = nil
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.button_, nil, function()
		if manager.time:GetServerTime() < arg_6_0.startTime_ then
			local var_7_0 = GetTips("OPEN_TIME")

			ShowTips(string.format(var_7_0, manager.time:GetLostTimeStr(arg_6_0.startTime_)))

			return
		end

		if manager.time:GetServerTime() >= arg_6_0.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		if arg_6_0.clickHandler_ ~= nil then
			arg_6_0.clickHandler_()

			return
		end

		ActivityTools.JumpToSubmodulePage(arg_6_0.activityId_)
	end)
end

function var_0_0.BindRedPoint(arg_8_0)
	manager.redPoint:bindUIandKey(arg_8_0.transform_, ActivityTools.GetRedPointKey(arg_8_0.activityId_) .. arg_8_0.activityId_)
end

function var_0_0.UnBindRedPoint(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.transform_, ActivityTools.GetRedPointKey(arg_9_0.activityId_) .. arg_9_0.activityId_)
end

function var_0_0.RefreshUI(arg_10_0)
	if arg_10_0.nameText_ then
		arg_10_0.nameText_.text = ActivityCfg[arg_10_0.activityId_].remark
	end
end

function var_0_0.RefreshLock(arg_11_0)
	local var_11_0 = manager.time:GetServerTime() < arg_11_0.startTime_
	local var_11_1 = manager.time:GetServerTime() >= arg_11_0.stopTime_

	if arg_11_0.controller_ then
		if var_11_1 then
			arg_11_0.controller_:SetSelectedState("end")
		else
			arg_11_0.controller_:SetSelectedState(tostring(var_11_0))
		end
	end

	if arg_11_0.bgImg_ then
		arg_11_0.bgImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SummerUI/" .. var_0_1[arg_11_0.gameObject_.name])
	end

	if arg_11_0.textTime_ then
		arg_11_0.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(arg_11_0.startTime_, "!%m.%d"), manager.time:STimeDescS(arg_11_0.stopTime_, "!%m.%d"))
	end
end

function var_0_0.UpdateActivity(arg_12_0, arg_12_1)
	if arg_12_0.activityId_ == arg_12_1 then
		arg_12_0.activiteData_ = ActivityData:GetActivityData(arg_12_0.activityId_)
		arg_12_0.startTime_ = arg_12_0.activiteData_.startTime
		arg_12_0.stopTime_ = arg_12_0.activiteData_.stopTime

		arg_12_0:AddTimer()
	end
end

function var_0_0.AddTimer(arg_13_0)
	arg_13_0:StopTimer()
	arg_13_0:RefreshLock()

	local var_13_0 = manager.time:GetServerTime() < arg_13_0.startTime_

	arg_13_0.timer_ = Timer.New(function()
		local var_14_0 = manager.time:GetServerTime()

		if var_13_0 and var_14_0 > arg_13_0.startTime_ then
			arg_13_0:RefreshLock()

			var_13_0 = false
		elseif var_14_0 >= arg_13_0.stopTime_ then
			arg_13_0:RefreshLock()
			arg_13_0:StopTimer()
		end
	end, 1, -1)

	arg_13_0.timer_:Start()
end

function var_0_0.StopTimer(arg_15_0)
	if arg_15_0.timer_ then
		arg_15_0.timer_:Stop()

		arg_15_0.timer_ = nil
	end
end

return var_0_0
