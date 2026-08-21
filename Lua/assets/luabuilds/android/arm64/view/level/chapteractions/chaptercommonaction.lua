local var_0_0 = class("ChapterCommonAction")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.command = setmetatable({}, ChapterOpCommand)

	arg_1_0.command:initData(arg_1_1.op, arg_1_1.data, arg_1_1.chapter)

	return
end

function var_0_0.applyTo(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 then
		return true
	end

	arg_2_0.command.chapter = arg_2_1

	arg_2_0.command:doMapUpdate()
	arg_2_0.command:doAIUpdate()
	arg_2_0.command:doShipUpdate()
	arg_2_0.command:doBuffUpdate()
	arg_2_0.command:doCellFlagUpdate()
	arg_2_0.command:doExtraFlagUpdate()

	return true, arg_2_0.command.flag, arg_2_0.command.extraFlag
end

function var_0_0.PlayAIAction(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	existCall(arg_3_3)

	return
end

return var_0_0
