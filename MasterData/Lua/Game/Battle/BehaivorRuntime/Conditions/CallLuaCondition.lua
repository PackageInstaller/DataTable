import 'Game.Battle.BehaivorRuntime.Core.Condition'

local callLuaCondition = b3.Class("CallLuaCondition", b3.Condition)
b3.CallLuaCondition = callLuaCondition

function callLuaCondition:__init()
	b3.Action.__init(self)
	self.name = "callLuaCondition"
end

function callLuaCondition:tick(tick)
	-- print(table.toString(self.properties, "callLuaCondition"))

	local functionName = self.properties.funcName
	assert(functionName, "Can't find function")

	local func = tick.target[functionName]
	assert(func, "Can't find function:"..functionName)

	local isTrue = func(tick.target, self.properties)
	return isTrue and b3.SUCCESS or b3.FAILURE
end