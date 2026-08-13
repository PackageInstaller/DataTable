class = var_0_10000

local var_0_0 = "StartupCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.MacroCommand)

function var_0_1.initializeMacroCommand(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.addSubCommand

	PrepControllerCommand = var_1_10004

	var_1_1(var_1_0, var_1_10004)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.addSubCommand

	PrepModelCommand = var_1_10004

	var_1_3(var_1_2, var_1_10004)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.addSubCommand

	PrepViewCommand = var_1_10004

	var_1_5(var_1_4, var_1_10004)

	return
end

return var_0_1
