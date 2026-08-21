local var_0_0 = class("CalcCatteryExpCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(CommanderProxy):GetCommanderHome()
	local var_1_1 = arg_1_1:getBody().isPeriod

	if not var_1_0 then
		return
	end

	arg_1_0.commanderExps = {}

	local var_1_2 = var_1_0:getConfig("exp_number")

	for iter_1_0, iter_1_1 in pairs((var_1_0:GetCatteries())) do
		if iter_1_1:ExistCommander() then
			arg_1_0:CalcExp(iter_1_1, var_1_2, var_1_1)
		end
	end

	arg_1_0:sendNotification(GAME.CALC_CATTERY_EXP_DONE, {
		commanderExps = arg_1_0.commanderExps
	})

	return
end

function var_0_0.CalcExp(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_2_1 = not arg_2_3 and var_2_0 - arg_2_1:GetCalcExpTime() or 3600

	if var_2_1 > 0 then
		local var_2_2 = arg_2_0:AddCommanderExp(arg_2_1:GetCommanderId(), (math.floor(arg_2_2 / 16 * var_2_1)))

		table.insert(arg_2_0.commanderExps, {
			id = arg_2_1.id,
			value = var_2_2
		})
		arg_2_1:UpdateCalcExpTime(var_2_0)

		if not getProxy(CommanderProxy):InCommanderScene() then
			arg_2_1:UpdateCacheExp(var_2_2)
		end
	end

	return
end

function var_0_0.AddCommanderExp(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2
	local var_3_1 = getProxy(CommanderProxy)
	local var_3_2 = var_3_1:getCommanderById(arg_3_1)
	local var_3_3 = var_3_2:isMaxLevel()

	if var_3_3 then
		var_3_0 = 0
	end

	var_3_2:addExp(arg_3_2)
	var_3_1:updateCommander(var_3_2)

	if not var_3_3 and var_3_2:isMaxLevel() then
		var_3_0 = math.max(arg_3_2 - var_3_2.exp, 0)
	end

	return var_3_0
end

return var_0_0
