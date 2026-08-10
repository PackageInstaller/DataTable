local var_0_0 = import(".ChapterChallengeItemWithCD")
local var_0_1 = class("ChapterChallengeMatrixItemView", var_0_0)

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	arg_1_0.updateHandler_ = handler(arg_1_0, arg_1_0.UpdateMatrix)
end

function var_0_1.OnEnter(arg_2_0)
	var_0_1.super.OnEnter(arg_2_0)
	manager.notify:RegistListener(MATRIX_UPDATE, arg_2_0.updateHandler_)
end

function var_0_1.OnExit(arg_3_0)
	manager.notify:RemoveListener(MATRIX_UPDATE, arg_3_0.updateHandler_)
	var_0_1.super.OnExit(arg_3_0)
end

function var_0_1.Dispose(arg_4_0)
	arg_4_0.updateHandler_ = nil

	var_0_1.super.Dispose(arg_4_0)
end

function var_0_1.GetLostTime(arg_5_0)
	local var_5_0 = PolyhedronData:GetActivityID()

	return ActivityData:GetActivityData(var_5_0).stopTime
end

function var_0_1.ClickItem(arg_6_0)
	if arg_6_0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_polyhedron_above")

		arg_6_0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_polyhedron_below")
	end

	if arg_6_0:CheckLock() then
		return
	end

	local var_6_0 = PolyhedronData:GetPolyhedronInfo()

	if not var_6_0 then
		return
	end

	local var_6_1 = PolyhedronData:GetActivityID()

	if not ActivityData:GetActivityIsOpen(var_6_1) then
		ShowTips("TIME_OVER")

		return
	end

	if arg_6_0.isShowNew_ == 1 and not arg_6_0.isLock_ then
		arg_6_0.isShowNew_ = 0

		RedPointData:SetJsonCacheRedPoint("Polyhedron")
		manager.redPoint:bindUIandKey(arg_6_0.panelTf_, RedPointConst.POLYHEDRON)
	end

	local var_6_2 = var_6_0:GetState()

	if PolyhedronConst.STATE_TYPE.SETTLEMENT == var_6_2 then
		JumpTools.GoToSystem("/polyhedronBlank/polyhedronOver", nil, ViewConst.SYSTEM_ID.MATRIX)
	else
		JumpTools.GoToSystem("/polyhedronBlank/polyhedronLobby", nil, ViewConst.SYSTEM_ID.MATRIX)
	end
end

function var_0_1.AddRedPoint(arg_7_0)
	arg_7_0.isShowNew_ = RedPointData:GetJsonCacheRedPoint("Polyhedron")

	manager.redPoint:bindUIandKey(arg_7_0.panelTf_, RedPointConst.POLYHEDRON)
end

function var_0_1.RemoveRedPoint(arg_8_0)
	manager.redPoint:unbindUIandKey(arg_8_0.panelTf_)
end

function var_0_1.UpdateMatrix(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.panelTf_)
	arg_9_0:AddRedPoint()
end

function var_0_1.RefreshTimeText(arg_10_0)
	local var_10_0 = arg_10_0.tiemLock_

	arg_10_0.timeLock_ = manager.time:GetServerTime() >= arg_10_0:GetLostTime()

	if var_10_0 ~= arg_10_0.timeLock_ then
		arg_10_0:RefreshLock()
	end

	if arg_10_0.timeLock_ or arg_10_0.isLock_ then
		arg_10_0.timeText_.text = ""

		arg_10_0.timeController_:SetSelectedState("state1")
	else
		arg_10_0.timeController_:SetSelectedState("state0")

		arg_10_0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr(arg_10_0:GetLostTime(), nil, true))
	end
end

return var_0_1
