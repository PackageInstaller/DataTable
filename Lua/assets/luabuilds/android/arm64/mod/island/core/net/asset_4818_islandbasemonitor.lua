local IslandBaseMonitor = class("IslandBaseMonitor")

function IslandBaseMonitor:Ctor(arg_1_1)
	self.island = arg_1_1

	self:onRegister()

	return
end

function IslandBaseMonitor:emitCore(arg_2_1, ...)
	self:GetIsland():DispatchEvent(IslandProxy.LINK_CORE, arg_2_1, ...)

	return
end

function IslandBaseMonitor:GetIsland()
	return self.island
end

function IslandBaseMonitor:IsCurrentIsland(arg_4_1)
	return self.island.id == arg_4_1
end

function IslandBaseMonitor:onRegister()
	self.event = {}

	self:register()

	return
end

function IslandBaseMonitor:on(arg_6_1, arg_6_2)
	pg.ConnectionMgr.GetInstance():On(arg_6_1, function(arg_7_0)
		arg_6_2(arg_7_0)

		return
	end)
	table.insert(self.event, arg_6_1)

	return
end

function IslandBaseMonitor:onRemove()
	self:remove()

	for iter_8_0, iter_8_1 in ipairs(self.event) do
		pg.ConnectionMgr.GetInstance():Off(iter_8_1)
	end

	return
end

function IslandBaseMonitor:Dispose()
	self:onRemove()

	return
end

function IslandBaseMonitor:register()
	return
end

function IslandBaseMonitor:remove()
	return
end

return IslandBaseMonitor
