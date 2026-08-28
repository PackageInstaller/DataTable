import 'Game.Battle.BehaivorRuntime.Core.Composite'

local priority = b3.Class("Priority", b3.Composite)
b3.Priority = priority

function priority:__init()
	b3.Composite.__init(self)

	self.name = "Priority"
end

function priority:tick(tick)
	for i,v in pairs(self.children) do
		local status = v:_execute(tick)

		if status ~= b3.FAILURE then
			return status
		end
	end

	return b3.FAILURE
end

