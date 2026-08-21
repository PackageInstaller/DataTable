local var_0_0 = class("StartupCommand", pm.MacroCommand)

function var_0_0.initializeMacroCommand(arg_1_0)
	arg_1_0:addSubCommand(PrepControllerCommand)
	arg_1_0:addSubCommand(PrepModelCommand)
	arg_1_0:addSubCommand(PrepViewCommand)

	return
end

return var_0_0
