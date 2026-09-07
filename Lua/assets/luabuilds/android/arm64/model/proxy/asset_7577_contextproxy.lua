local ContextProxy = class("ContextProxy", pm.Proxy)

function ContextProxy:getCurrentContext()
	return self.data[#self.data]
end

function ContextProxy:pushContext(arg_2_1)
	table.insert(self.data, arg_2_1)

	return
end

function ContextProxy:popContext()
	return table.remove(self.data)
end

function ContextProxy:cleanContext()
	self.data = {}

	return
end

function ContextProxy:getContextCount()
	return #self.data
end

function ContextProxy:getContextByMediator(arg_6_1)
	for iter_6_0 = #self.data, 1, -1 do
		local var_6_0 = self.data[iter_6_0]:getContextByMediator(arg_6_1)

		if var_6_0 then
			return var_6_0, self.data[iter_6_0]
		end
	end

	return nil
end

function ContextProxy:CleanUntilMediator(arg_7_1)
	for iter_7_0 = #self.data, 1, -1 do
		if self.data[iter_7_0].mediator.__cname ~= arg_7_1.__cname then
			table.remove(self.data, iter_7_0)
		else
			break
		end
	end

	return
end

function ContextProxy:GetPrevContext(arg_8_1)
	return self.data[#self.data - arg_8_1]
end

function ContextProxy:RemoveContext(arg_9_1)
	for iter_9_0 = #self.data, 1, -1 do
		if arg_9_1 == self.data[iter_9_0] then
			table.remove(self.data, iter_9_0)
		end
	end

	return
end

function ContextProxy:PushContext2Prev(arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or 1

	table.insert(self.data, math.clamp(#self.data + 1 - arg_10_2, 1, #self.data + 1), arg_10_1)

	return
end

return ContextProxy
