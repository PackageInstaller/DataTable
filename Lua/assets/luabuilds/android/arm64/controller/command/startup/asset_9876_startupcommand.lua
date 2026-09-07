local StartupCommand = class("StartupCommand", pm.MacroCommand)

function StartupCommand:initializeMacroCommand()
	self:addSubCommand(PrepControllerCommand)
	self:addSubCommand(PrepModelCommand)
	self:addSubCommand(PrepViewCommand)

	return
end

return StartupCommand
