import 'Game.Battle.BehaivorRuntime.Core.Action'

local succeeder = b3.Class("Succeeder", b3.Action)
b3.Succeeder = succeeder

function succeeder:__init()
	b3.Action.__init(self)

	self.name = "Succeeder"
end

function succeeder:tick(tick)
	return b3.SUCCESS
end