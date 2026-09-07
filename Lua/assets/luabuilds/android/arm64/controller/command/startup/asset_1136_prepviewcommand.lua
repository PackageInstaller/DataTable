local PrepViewCommand = class("PrepViewCommand", pm.SimpleCommand)

function PrepViewCommand:execute(arg_1_1)
	self.facade:registerMediator(GameMediator.New())

	return
end

return PrepViewCommand
