import 'Game.Battle.BehaivorRuntime.Core.BaseNode'

local condition = b3.Class("Condition", b3.BaseNode)
b3.Condition = condition

function condition:__init(params)
	b3.BaseNode.__init(self, params)
end