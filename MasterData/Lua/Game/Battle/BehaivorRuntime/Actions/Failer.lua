import 'Game.Battle.BehaivorRuntime.Core.Action'

local failer = b3.Class("Failer", b3.Action)
b3.Failer = failer

function failer:__init()
	b3.Action.__init(self)
	
	self.name = "Failer"
end

function failer:tick()
	return b3.SUCCESS
end
