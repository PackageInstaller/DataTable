local var_0_0 = class("TaskSwitchView", ReduxView)
local var_0_1 = import("game.tools.TaskTools")
local var_0_2 = import("game.const.TaskConst")

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.btnType_ = arg_1_2

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.btnController_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "name")
end

function var_0_0.OnEnter(arg_3_0)
	local var_3_0 = arg_3_0.btnType_

	if var_3_0 == var_0_2.TASK_TYPE.PLOT then
		manager.redPoint:bindUIandKey(arg_3_0.transform_, RedPointConst.TASK_PLOT)
	elseif var_3_0 == var_0_2.TASK_TYPE.DAILY then
		manager.redPoint:bindUIandKey(arg_3_0.transform_, RedPointConst.TASK_DAILY)
	elseif var_3_0 == var_0_2.TASK_TYPE.WEEK then
		manager.redPoint:bindUIandKey(arg_3_0.transform_, RedPointConst.TASK_WEEK)
	end

	arg_3_0.refreshLockHandler_ = handler(arg_3_0, arg_3_0.RefreshLock)

	manager.notify:RegistListener(PLAYER_LEVEL_UP, arg_3_0.refreshLockHandler_)
	arg_3_0:RefreshLock()
end

function var_0_0.OnExit(arg_4_0)
	manager.notify:RemoveListener(PLAYER_LEVEL_UP, arg_4_0.refreshLockHandler_)

	arg_4_0.refreshLockHandler_ = nil

	manager.redPoint:unbindUIandKey(arg_4_0.transform_)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		if not arg_5_0:GetOpen() then
			local var_6_0 = arg_5_0:GetSystemID(arg_5_0.btnType_)
			local var_6_1, var_6_2 = JumpTools.GetSystemLockedText({
				var_6_0
			})

			if var_6_1 then
				ShowTips(var_6_2)
			end
		else
			arg_5_0.BtnFunc_(arg_5_0.btnType_)
			OperationRecorder.Record(arg_5_0.class.__cname, arg_5_0.btnType_)
		end
	end)
end

function var_0_0.SetBtnFunc(arg_7_0, arg_7_1)
	arg_7_0.BtnFunc_ = arg_7_1
end

function var_0_0.RemoveListeners(arg_8_0)
	arg_8_0.btn_.onClick:RemoveAllListeners()
end

function var_0_0.SwitchButton(arg_9_0, arg_9_1)
	if arg_9_0.lastBtnType_ == arg_9_1 then
		return
	end

	if arg_9_0.btnType_ == arg_9_1 then
		arg_9_0.btnController_:SetSelectedState("false")
	else
		arg_9_0.btnController_:SetSelectedState("true")
	end

	arg_9_0.lastBtnType_ = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveListeners()
	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.GetOpen(arg_11_0)
	local var_11_0 = arg_11_0.btnType_
	local var_11_1 = arg_11_0:GetSystemID(var_11_0)

	return not JumpTools.IsSystemLocked(var_11_1)
end

function var_0_0.GetSystemID(arg_12_0, arg_12_1)
	local var_12_0

	if arg_12_1 == var_0_2.TASK_TYPE.PLOT then
		var_12_0 = ViewConst.SYSTEM_ID.TASK_PLOT
	elseif arg_12_1 == var_0_2.TASK_TYPE.DAILY then
		var_12_0 = ViewConst.SYSTEM_ID.TASK_DAILY
	elseif arg_12_1 == var_0_2.TASK_TYPE.WEEK then
		var_12_0 = ViewConst.SYSTEM_ID.TASK_WEEK
	else
		print("未知的任务类型")
	end

	return var_12_0
end

function var_0_0.RefreshLock(arg_13_0)
	return
end

return var_0_0
