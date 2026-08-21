module("framework.schedule.Scheduler", package.seeall)

local var_0_0 = {}

function var_0_0.init()
	var_0_0._listeners = {}
	var_0_0._dispatching = false
	var_0_0._pendings = {}
	var_0_0._onceList = {}
	var_0_0._tempEntry = nil
	var_0_0._tempExecuted = false

	ScheduleEntry.initPool()

	var_0_0._pool = ScheduleEntry.getPool()

	UpdateBeat:Add(var_0_0._update, var_0_0)
end

function var_0_0._update(arg_2_0)
	local var_2_0 = Time.deltaTime

	var_0_0._dispatching = true

	local var_2_1 = #var_0_0._listeners

	for iter_2_0 = 1, var_2_1 do
		var_0_0._tempEntry = var_0_0._listeners[iter_2_0]

		if var_0_0._getStatusInPending(var_0_0._tempEntry.handler, var_0_0._tempEntry.handlerObj) ~= kScheduleStatusToDelete then
			var_0_0._tempExecuted = var_0_0._tempEntry:update(var_2_0)

			if var_0_0._tempExecuted and not var_0_0._tempEntry.isRepeat then
				table.insert(var_0_0._onceList, iter_2_0)
			end
		end
	end

	var_0_0._tempEntry = nil
	var_0_0._tempExecuted = false
	var_0_0._dispatching = false

	for iter_2_1 = #var_0_0._onceList, 1, -1 do
		local var_2_2 = var_0_0._onceList[iter_2_1]

		ScheduleEntry._pool:returnObject(var_0_0._listeners[var_2_2])
		table.remove(var_0_0._listeners, var_2_2)

		var_0_0._onceList[iter_2_1] = nil
	end

	local var_2_3 = #var_0_0._pendings

	for iter_2_2 = 1, var_2_3 do
		var_0_0._tempEntry = var_0_0._pendings[iter_2_2]

		if var_0_0._tempEntry.status == kScheduleStatusToInsert then
			var_0_0._safeAddListener(var_0_0._tempEntry)
		elseif var_0_0._tempEntry.status == kScheduleStatusToDelete then
			var_0_0._safeRemoveListener(var_0_0._tempEntry.handler, var_0_0._tempEntry.handlerObj)
			ScheduleEntry._pool:returnObject(var_0_0._tempEntry)
		end

		var_0_0._pendings[iter_2_2] = nil
	end

	ScheduleEntry.curFrame = ScheduleEntry.curFrame + 1
end

function var_0_0.addListener(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_0 == nil or arg_3_1 == nil then
		printError("Scheduler.addListener invoking error, interval=", tostring(arg_3_0), ",handler=", tostring(arg_3_1))

		return
	end

	local var_3_0 = false
	local var_3_1 = false

	if var_0_0._dispatching then
		local var_3_2 = var_0_0._getStatusInPending(arg_3_1, arg_3_2)

		if var_3_2 == kScheduleStatusToInsert then
			var_3_0 = true
		elseif var_3_2 == kScheduleStatusToDelete then
			var_3_1 = true
		end
	end

	if var_3_0 then
		return
	end

	local var_3_3 = var_0_0._findListenerInQueue(arg_3_1, arg_3_2)

	if var_3_3 ~= nil and var_3_3.isRepeat and not var_3_1 then
		return
	end

	local var_3_4 = ScheduleEntry._pool:fetchObject()

	var_3_4.handlerObj = arg_3_2
	var_3_4.handler = arg_3_1
	var_3_4.interval = arg_3_0
	var_3_4.regFrame = ScheduleEntry.curFrame

	if arg_3_3 == nil then
		arg_3_3 = true
	end

	var_3_4.isRepeat = arg_3_3

	if var_0_0._dispatching then
		var_0_0._removeFromPending(arg_3_1, arg_3_2)

		var_3_4.status = kScheduleStatusToInsert

		table.insert(var_0_0._pendings, var_3_4)
	else
		var_0_0._safeAddListener(var_3_4)
	end
end

function var_0_0.removeListener(arg_4_0, arg_4_1)
	if var_0_0._dispatching then
		var_0_0._removeFromPending(arg_4_0, arg_4_1)

		local var_4_0 = ScheduleEntry._pool:fetchObject()

		var_4_0.handler = arg_4_0
		var_4_0.handlerObj = arg_4_1
		var_4_0.status = kScheduleStatusToDelete

		table.insert(var_0_0._pendings, var_4_0)
	else
		var_0_0._safeRemoveListener(arg_4_0, arg_4_1)
	end
end

function var_0_0.hasListener(arg_5_0, arg_5_1)
	local var_5_0 = false

	if var_0_0._findListenerInQueue(arg_5_0, arg_5_1) ~= nil then
		var_5_0 = true
	end

	if var_0_0._dispatching then
		local var_5_1 = var_0_0._getStatusInPending(arg_5_0, arg_5_1)

		if var_5_1 == kScheduleStatusToInsert then
			var_5_0 = true
		elseif var_5_1 == kScheduleStatusToDelete then
			var_5_0 = false
		end
	end

	return var_5_0
end

function var_0_0.executeNextFrame(arg_6_0, arg_6_1)
	var_0_0.addListener(0, arg_6_0, arg_6_1, false)
end

function var_0_0.executeOnce(arg_7_0, arg_7_1, arg_7_2)
	var_0_0.addListener(arg_7_0, arg_7_1, arg_7_2, false)
end

function var_0_0._removeFromPending(arg_8_0, arg_8_1)
	local var_8_0 = 1

	for iter_8_0 = #var_0_0._pendings, 1, -1 do
		local var_8_1 = var_0_0._pendings[iter_8_0]

		if var_8_1.handlerObj == arg_8_1 and var_8_1.handler == arg_8_0 then
			ScheduleEntry._pool:returnObject(var_8_1)
			table.remove(var_0_0._pendings, iter_8_0)

			break
		end
	end
end

function var_0_0._safeRemoveListener(arg_9_0, arg_9_1)
	local var_9_0 = #var_0_0._listeners
	local var_9_1

	for iter_9_0 = var_9_0, 1, -1 do
		local var_9_2 = var_0_0._listeners[iter_9_0]

		if var_9_2.handler == arg_9_0 and var_9_2.handlerObj == arg_9_1 then
			ScheduleEntry._pool:returnObject(var_9_2)
			table.remove(var_0_0._listeners, iter_9_0)

			break
		end
	end
end

function var_0_0._safeAddListener(arg_10_0)
	if var_0_0._findListenerInQueue(arg_10_0.handler, arg_10_0.handlerObj) ~= nil then
		ScheduleEntry._pool:returnObject(arg_10_0)

		return
	end

	arg_10_0.status = NotifyStatus.Active

	table.insert(var_0_0._listeners, arg_10_0)
end

function var_0_0._getStatusInPending(arg_11_0, arg_11_1)
	local var_11_0 = 0

	for iter_11_0 = #var_0_0._pendings, 1, -1 do
		local var_11_1 = var_0_0._pendings[iter_11_0]

		if var_11_1.handlerObj == arg_11_1 and var_11_1.handler == arg_11_0 then
			if var_11_1.status == kScheduleStatusToInsert then
				var_11_0 = kScheduleStatusToInsert

				break
			elseif var_11_1.status == kScheduleStatusToDelete then
				var_11_0 = kScheduleStatusToDelete

				break
			end
		end
	end

	return var_11_0
end

function var_0_0._findListenerInQueue(arg_12_0, arg_12_1)
	local var_12_0
	local var_12_1

	for iter_12_0 = #var_0_0._listeners, 1, -1 do
		local var_12_2 = var_0_0._listeners[iter_12_0]

		if var_12_2.handler == arg_12_0 and var_12_2.handlerObj == arg_12_1 then
			var_12_0 = var_12_2

			break
		end
	end

	return var_12_0
end

return var_0_0
