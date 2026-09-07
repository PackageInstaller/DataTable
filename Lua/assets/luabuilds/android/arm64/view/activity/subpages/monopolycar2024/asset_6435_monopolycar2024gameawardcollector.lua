local MonopolyCar2024GameAwardCollector = class("MonopolyCar2024GameAwardCollector")

function MonopolyCar2024GameAwardCollector:Ctor()
	self.list = {}
	self.isSetUp = false

	return
end

function MonopolyCar2024GameAwardCollector:Add(arg_2_1)
	if not self.isSetUp then
		return
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_1 or {}) do
		table.insert(self.list, iter_2_1)
	end

	return
end

function MonopolyCar2024GameAwardCollector:SetUp()
	self.isSetUp = true

	self:Clear()

	return
end

function MonopolyCar2024GameAwardCollector:Disable()
	self.isSetUp = false

	self:Clear()

	return
end

function MonopolyCar2024GameAwardCollector:Fetch()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(self.list or {}) do
		table.insert(var_5_0, iter_5_1)
	end

	self:Clear()

	return var_5_0
end

function MonopolyCar2024GameAwardCollector:Clear()
	self.list = {}

	return
end

function MonopolyCar2024GameAwardCollector:Dispose()
	self:Clear()

	return
end

return MonopolyCar2024GameAwardCollector
