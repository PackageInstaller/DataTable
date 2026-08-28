import 'Game.Battle.BehaivorRuntime.Core.Action'

local callLuaAction = b3.Class("CallLuaAction", b3.Action)
b3.CallLuaAction = callLuaAction

function callLuaAction:__init()
	b3.Action.__init(self)
	self.name = "callLuaAction"
end

function callLuaAction:tick(tick)
	-- print(table.toString(self.properties, "callLuaAction"))

	local functionName = self.properties.funcName
	assert(functionName, "Can't find function")

	local func = tick.target[functionName]
	assert(func, "Can't find function:"..functionName)

	func(tick.target, self.properties)
	return b3.SUCCESS
end