module("frameworkext.lmvc.view.ViewLifetimeMgr", package.seeall)

local var_0_0 = class("ViewLifetimeMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._viewCloseTimeDict = {}
	arg_1_0._isTicking = false
	arg_1_0._isPaused = false
	arg_1_0._tickInterval = 1
end

function var_0_0.onOpenView(arg_2_0, arg_2_1)
	if ViewSetting.instance:getAutoDestroyTime(arg_2_1) <= 0 then
		return
	end

	arg_2_0._viewCloseTimeDict[arg_2_1] = nil

	if table.nums(arg_2_0._viewCloseTimeDict) < 1 then
		arg_2_0._isTicking = false

		removetimer(var_0_0.onTick, arg_2_0)
	end
end

function var_0_0.onCloseView(arg_3_0, arg_3_1)
	if ViewSetting.instance:getAutoDestroyTime(arg_3_1) <= 0 then
		return
	end

	if arg_3_0._viewCloseTimeDict[arg_3_1] then
		return
	end

	arg_3_0._viewCloseTimeDict[arg_3_1] = Time.time

	if not arg_3_0._isTicking then
		arg_3_0._isTicking = true

		settimer(arg_3_0._tickInterval, var_0_0.onTick, arg_3_0)
	end
end

function var_0_0.onTick(arg_4_0, arg_4_1)
	if arg_4_0._isPaused then
		return
	end

	local var_4_0 = {}
	local var_4_1 = Time.time

	for iter_4_0, iter_4_1 in pairs(arg_4_0._viewCloseTimeDict) do
		if var_4_1 > iter_4_1 + ViewSetting.instance:getAutoDestroyTime(iter_4_0) and not ViewMgr.instance:isOpen(iter_4_0) and ViewMgr.instance:isClosed(iter_4_0) or arg_4_1 then
			table.insert(var_4_0, iter_4_0)
		end
	end

	local var_4_2 = #var_4_0

	for iter_4_2 = 1, var_4_2 do
		arg_4_0._viewCloseTimeDict[var_4_0[iter_4_2]] = nil

		ViewMgr.instance:destroy(var_4_0[iter_4_2])
	end

	local var_4_3

	if table.nums(arg_4_0._viewCloseTimeDict) < 1 then
		arg_4_0._isTicking = false

		removetimer(var_0_0.onTick, arg_4_0)
	end
end

function var_0_0.pauseTick(arg_5_0)
	arg_5_0._isPaused = true
end

function var_0_0.resumeTick(arg_6_0)
	arg_6_0._isPaused = false
end

var_0_0.instance = var_0_0.New()

return var_0_0
