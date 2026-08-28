import 'Game.Battle.BehaivorRuntime.Core.BaseNode'

local decorator = b3.Class("Decorator", b3.BaseNode)
b3.Decorator = decorator

function decorator:__init(params)
	b3.BaseNode.__init(self, params)

	if not params then
		params = {}
	end

	self.child = params.child or nil
end
