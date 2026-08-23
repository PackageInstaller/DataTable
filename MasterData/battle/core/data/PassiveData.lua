local PassiveData = class("PassiveData")

function PassiveData.create()
	return PassiveData.new()
end

function PassiveData:ctor()
	self.list = {}
end

function PassiveData:push(arg_3_1)
	self.list[#self.list + 1] = arg_3_1
end

function PassiveData:pop()
	if #self.list > 0 then
		return table.remove(self.list, 1)
	end
end

function PassiveData:clear()
	self.list = {}
end

function PassiveData:isEmpty()
	return self.list[1] == nil
end

return PassiveData
