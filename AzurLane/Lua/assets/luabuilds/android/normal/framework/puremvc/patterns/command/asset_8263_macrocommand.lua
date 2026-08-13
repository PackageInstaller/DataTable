import = var_0_10000

local var_0_0 = var_0_10000("..observer.Notifier")

class = var_1

local var_0_1 = var_1("MacroCommand", var_0_0)

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.subCommands = {}

	arg_1_0:initializeMacroCommand()

	return
end

function var_0_1.initializeMacroCommand(arg_2_0)
	return
end

function var_0_1.addSubCommand(arg_3_0, arg_3_1)
	table = var_1_10002

	var_1_10002.insert(arg_3_0.subCommands, arg_3_1)

	return
end

function var_0_1.execute(arg_4_0, arg_4_1)
	while #arg_4_0.subCommands > 0 do
		table = var_2

		local var_4_0 = var_2.remove(arg_4_0.subCommands, 1).New()

		var_3.initializeNotifier(var_4_0, arg_4_0.multitonKey)
		var_3:execute(arg_4_1)
	end

	return
end

return var_0_1
