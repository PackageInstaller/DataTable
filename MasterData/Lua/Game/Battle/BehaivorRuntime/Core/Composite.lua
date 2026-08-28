import 'Game.Battle.BehaivorRuntime.Core.BaseNode'

local composite = b3.Class("Composite", b3.BaseNode)
b3.Composite = composite

function composite:__init(params)
	self.children = (params and params.children) or {}
end