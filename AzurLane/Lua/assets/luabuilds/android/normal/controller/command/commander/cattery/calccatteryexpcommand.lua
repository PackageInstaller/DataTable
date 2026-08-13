class = var_0_10000

local var_0_0 = "CalcCatteryExpCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	CommanderProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_3.GetCommanderHome(var_1_2)
	local var_1_4 = var_1_1.isPeriod

	if not var_1_3 then
		return
	end

	arg_1_0.commanderExps = {}

	local var_1_5 = var_1_3:GetCatteries()
	local var_1_6 = var_1_3
	local var_1_7 = var_1_3.getConfig(var_1_6, "exp_number")

	pairs = var_1_6

	for iter_1_0, iter_1_1 in var_1_6(var_1_5) do
		if iter_1_1:ExistCommander() then
			arg_1_0:CalcExp(iter_1_1, var_1_7, var_1_4)
		end
	end

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.sendNotification

	GAME = var_10

	var_1_9(var_1_8, var_10.CALC_CATTERY_EXP_DONE, {
		commanderExps = arg_1_0.commanderExps
	})

	return
end

function var_0_1.CalcExp(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_2 / 16

	pg = var_1_10005

	local var_2_1 = var_1_10005.TimeMgr.GetInstance()
	local var_2_2 = var_5.GetServerTime(var_2_1)
	local var_2_3

	if not arg_2_3 then
		var_2_3 = var_2_2 - arg_2_1:GetCalcExpTime()
	else
		var_2_3 = 3600
	end

	if 0 < var_2_3 then
		math = var_7

		local var_2_4 = var_7.floor(var_2_0 * var_2_3)
		local var_2_5 = arg_2_0
		local var_2_6 = arg_2_0.AddCommanderExp(var_2_5, arg_2_1:GetCommanderId(), var_2_4)

		table = var_2_5

		var_2_5.insert(arg_2_0.commanderExps, {
			id = arg_2_1.id,
			value = var_2_6
		})

		local var_2_7 = arg_2_1

		arg_2_1.UpdateCalcExpTime(var_2_7, var_2_2)

		getProxy = var_9
		CommanderProxy = var_2_7

		local var_2_8 = var_9(var_2_7)

		if not var_9.InCommanderScene(var_2_8) then
			arg_2_1:UpdateCacheExp(var_2_6)
		end
	end

	return
end

function var_0_1.AddCommanderExp(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2

	getProxy = var_1_10004
	CommanderProxy = var_1_10005

	local var_3_1 = var_1_10004(var_1_10005)
	local var_3_2 = var_4.getCommanderById(var_3_1, arg_3_1)

	if var_5.isMaxLevel(var_3_2) then
		var_3_0 = 0
	end

	var_5:addExp(arg_3_2)
	var_4:updateCommander(var_5)

	if not var_6 and var_5:isMaxLevel() then
		math = var_7
		var_3_0 = var_7.max(arg_3_2 - var_5.exp, 0)
	end

	return var_3_0
end

return var_0_1
