module("framework.schedule.ScheduleEntry", package.seeall)

local var_0_0 = class("ScheduleEntry")

setglobal("kScheduleStatusIdle", 1)
setglobal("kScheduleStatusActive", 2)
setglobal("kScheduleStatusToInsert", 3)
setglobal("kScheduleStatusToDelete", 4)

var_0_0.curFrame = 0

function var_0_0._poolCreateFunc()
	return var_0_0.New()
end

function var_0_0._poolDisposeFunc(arg_2_0)
	return
end

function var_0_0._poolResetFunc(arg_3_0)
	arg_3_0:reset()
end

function var_0_0.initPool()
	var_0_0._pool = ObjectPool.New(30, var_0_0._poolCreateFunc, var_0_0._poolDisposeFunc, var_0_0._poolResetFunc)
end

function var_0_0.getPool()
	return var_0_0._pool
end

function var_0_0.ctor(arg_6_0)
	arg_6_0:reset()
end

function var_0_0.reset(arg_7_0)
	arg_7_0.interval = 0
	arg_7_0.regFrame = 0
	arg_7_0.elapsed = 0
	arg_7_0.handler = nil
	arg_7_0.handlerObj = nil
	arg_7_0.status = kScheduleStatusIdle
	arg_7_0.isRepeat = true
	arg_7_0.isExecuted = false
end

function var_0_0.update(arg_8_0, arg_8_1)
	arg_8_0.isExecuted = false

	if arg_8_0.regFrame == nil or var_0_0.curFrame == nil or arg_8_0.elapsed == nil or arg_8_0.interval == nil then
		arg_8_0.isExecuted = true

		printError("ScheduleEntry.update", tostring(arg_8_0.regFrame), tostring(var_0_0.curFrame), tostring(arg_8_0.elapsed), tostring(arg_8_0.interval))
	elseif arg_8_0.regFrame < var_0_0.curFrame then
		arg_8_0.elapsed = arg_8_0.elapsed + arg_8_1

		if arg_8_0.elapsed >= arg_8_0.interval then
			arg_8_0.elapsed = arg_8_0.elapsed - arg_8_0.interval
			arg_8_0.isExecuted = true

			if enableDebug then
				trycall(arg_8_0.handler, arg_8_0.handlerObj)
			else
				arg_8_0.handler(arg_8_0.handlerObj)
			end
		end
	end

	return arg_8_0.isExecuted
end

return var_0_0
