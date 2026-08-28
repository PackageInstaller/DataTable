import 'Game.Battle.BehaivorRuntime.Core.BaseNode'

local action = b3.Class("Action", b3.BaseNode)
b3.Action = action

function action:__init()
	b3.BaseNode.__init(self)

	self.category = b3.ACTION
end