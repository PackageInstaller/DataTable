class = var_0_10000

local var_0_0 = var_0_10000("ChapterCommonAction")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	setmetatable = var_1_10002

	local var_1_0 = {}

	ChapterOpCommand = var_1_10004
	arg_1_0.command = var_1_10002(var_1_0, var_1_10004)

	local var_1_1 = arg_1_0.command

	var_2.initData(var_1_1, arg_1_1.op, arg_1_1.data, arg_1_1.chapter)

	return
end

function var_0_0.applyTo(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 then
		return true
	end

	arg_2_0.command.chapter = arg_2_1

	local var_2_0 = arg_2_0.command

	var_3.doMapUpdate(var_2_0)

	local var_2_1 = arg_2_0.command

	var_3.doAIUpdate(var_2_1)

	local var_2_2 = arg_2_0.command

	var_3.doShipUpdate(var_2_2)

	local var_2_3 = arg_2_0.command

	var_3.doBuffUpdate(var_2_3)

	local var_2_4 = arg_2_0.command

	var_3.doCellFlagUpdate(var_2_4)

	local var_2_5 = arg_2_0.command

	var_3.doExtraFlagUpdate(var_2_5)

	return true, arg_2_0.command.flag, arg_2_0.command.extraFlag
end

function var_0_0.PlayAIAction(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	existCall = var_1_10004

	var_1_10004(arg_3_3)

	return
end

return var_0_0
