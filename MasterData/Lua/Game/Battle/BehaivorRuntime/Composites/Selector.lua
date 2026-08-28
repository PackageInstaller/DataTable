import 'Game.Battle.BehaivorRuntime.Core.Composite'

local selector = b3.Class("Selector", b3.Composite)
b3.Selector = selector

function selector:__init()
	b3.Composite.__init(self)
	
	self.name = "Sele__init"
end

function selector:tick(tick)
	for i = 1,table.getn(self.children) do
		local v = self.children[i]
		local status = v:_execute(tick)
	end
end
