local CourtYardDispatcher = class("CourtYardDispatcher")

function CourtYardDispatcher:Ctor(arg_1_1)
	self.host = arg_1_1
	self.__callbacks = {}
	self.__list = {}

	return
end

function CourtYardDispatcher:GetHost()
	return self.host
end

function CourtYardDispatcher:AddListener(arg_3_1, arg_3_2)
	assert(type(arg_3_1) == "string" and type(arg_3_2) == "function")

	self.__callbacks[arg_3_1] = self.__callbacks[arg_3_1] or {}

	table.insert(self.__callbacks[arg_3_1], arg_3_2)

	return
end

function CourtYardDispatcher:RemoveListener(arg_4_1, arg_4_2)
	assert(type(arg_4_1) == "string" and type(arg_4_2) == "function")

	if self.__callbacks[arg_4_1] then
		for iter_4_0 = #self.__callbacks[arg_4_1], 1, -1 do
			if self.__callbacks[arg_4_1][iter_4_0] == arg_4_2 then
				table.remove(self.__callbacks[arg_4_1], iter_4_0)
			end
		end
	end

	return
end

function CourtYardDispatcher:ClearListener(arg_5_1)
	assert(type(arg_5_1) == "string")

	self.__callbacks[arg_5_1] = nil

	return
end

function CourtYardDispatcher:DispatchEvent(arg_6_1, ...)
	assert(type(arg_6_1) == "string")

	if self.__callbacks[arg_6_1] then
		for iter_6_0 = 1, #self.__callbacks[arg_6_1] do
			self.__list[iter_6_0] = self.__callbacks[arg_6_1][iter_6_0]
		end

		for iter_6_1 = 1, #self.__callbacks[arg_6_1] do
			self.__list[iter_6_1](arg_6_1, self, ...)
		end
	end

	return
end

function CourtYardDispatcher:ClearListeners()
	for iter_7_0, iter_7_1 in pairs(self.__callbacks) do
		self.__callbacks[iter_7_0] = nil
	end

	for iter_7_2, iter_7_3 in ipairs(self.__list) do
		self.__list[iter_7_2] = nil
	end

	return
end

return CourtYardDispatcher
