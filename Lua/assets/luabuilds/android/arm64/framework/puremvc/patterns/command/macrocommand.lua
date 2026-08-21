local var_0_0 = class("MacroCommand", (import("..observer.Notifier")))

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.subCommands = {}

	arg_1_0:initializeMacroCommand()

	return
end

function var_0_0.initializeMacroCommand(arg_2_0)
	return
end

function var_0_0.addSubCommand(arg_3_0, arg_3_1)
	table.insert(arg_3_0.subCommands, arg_3_1)

	return
end

function var_0_0.execute(arg_4_0, arg_4_1)
	while #arg_4_0.subCommands > 0 do
		local var_4_0 = table.remove(arg_4_0.subCommands, 1).New()

		var_4_0:initializeNotifier(arg_4_0.multitonKey)
		var_4_0:execute(arg_4_1)
	end

	return
end

return var_0_0
