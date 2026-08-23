local ModuleStack = class("ModuleStack")

function ModuleStack:ctor()
	self._container = {}
end

function ModuleStack:push(arg_2_1)
	table.insert(self._container, arg_2_1)

	return #self._container
end

function ModuleStack:front()
	return self._container[#self._container]
end

function ModuleStack:previous()
	return self._container[#self._container - 1]
end

function ModuleStack:empty()
	return #self._container == 0
end

function ModuleStack:pop()
	return table.remove(self._container)
end

function ModuleStack:size()
	return #self._container
end

function ModuleStack:at(arg_8_1)
	return self._container[arg_8_1]
end

function ModuleStack:erase(arg_9_1)
	return table.remove(self._container, arg_9_1)
end

function ModuleStack:remove(arg_10_1)
	for iter_10_0, iter_10_1 in self:ipairs(true) do
		if iter_10_1 == arg_10_1 then
			self:erase(iter_10_0)

			break
		end
	end
end

function ModuleStack:find(arg_11_1)
	for iter_11_0, iter_11_1 in self:ipairs(true) do
		if iter_11_1 == arg_11_1 then
			return iter_11_0
		end
	end

	return nil
end

function ModuleStack:ipairs(arg_12_1)
	return function(arg_13_0, arg_13_1)
		arg_13_1 = arg_13_1 + (arg_12_1 and -1 or 1)

		if not self._container[arg_13_1] then
			return nil, nil
		end

		return arg_13_1, self._container[arg_13_1]
	end, self, (arg_12_1 or nil) and (#self._container + 1 or 0)
end

return ModuleStack
