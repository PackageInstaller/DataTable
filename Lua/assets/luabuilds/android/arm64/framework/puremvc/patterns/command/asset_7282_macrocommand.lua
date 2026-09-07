local MacroCommand = class("MacroCommand", (import("..observer.Notifier")))

function MacroCommand:Ctor()
	MacroCommand.super.Ctor(self)

	self.subCommands = {}

	self:initializeMacroCommand()

	return
end

function MacroCommand:initializeMacroCommand()
	return
end

function MacroCommand:addSubCommand(arg_3_1)
	table.insert(self.subCommands, arg_3_1)

	return
end

function MacroCommand:execute(arg_4_1)
	while #self.subCommands > 0 do
		local var_4_0 = table.remove(self.subCommands, 1).New()

		var_4_0:initializeNotifier(self.multitonKey)
		var_4_0:execute(arg_4_1)
	end

	return
end

return MacroCommand
