import 'Game.Battle.BehaivorRuntime.Core.Action'

local runner = b3.Class("Runner", b3.Action)
b3.Runner = runner

function runner:__init()
	b3.Action.__init(self)

	self.name = "Runner"
end

function runner:tick(tick)
	return b3.RUNNING
end