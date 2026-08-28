import 'Game.Battle.BehaivorRuntime.Core.Action'

local error = b3.Class("Error", b3.Action)
b3.Error = error

function error:__init()
	b3.Action.__init(self)
	
	self.name = "Error"
end

function error:tick()
	return b3.ERROR
end
