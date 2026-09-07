local IslandDispatcher = class("IslandDispatcher")

function IslandDispatcher:Ctor()
	self.__callbacks = {}
	self.__list = {}

	return
end

function IslandDispatcher:AddListener(arg_2_1, arg_2_2)
	assert(type(arg_2_1) == "string" and type(arg_2_2) == "function")

	self.__callbacks[arg_2_1] = self.__callbacks[arg_2_1] or {}

	table.insert(self.__callbacks[arg_2_1], arg_2_2)

	return
end

function IslandDispatcher:RemoveListener(arg_3_1, arg_3_2)
	assert(type(arg_3_1) == "string" and type(arg_3_2) == "function")

	if self.__callbacks[arg_3_1] then
		for iter_3_0 = #self.__callbacks[arg_3_1], 1, -1 do
			if self.__callbacks[arg_3_1][iter_3_0] == arg_3_2 then
				table.remove(self.__callbacks[arg_3_1], iter_3_0)
			end
		end
	end

	return
end

function IslandDispatcher:ClearListener(arg_4_1)
	assert(type(arg_4_1) == "string")

	self.__callbacks[arg_4_1] = nil

	return
end

function IslandDispatcher:DispatchEvent(arg_5_1, ...)
	assert(type(arg_5_1) == "string")

	if self.__callbacks[arg_5_1] then
		for iter_5_0 = 1, #self.__callbacks[arg_5_1] do
			self.__list[iter_5_0] = self.__callbacks[arg_5_1][iter_5_0]
		end

		for iter_5_1 = 1, #self.__callbacks[arg_5_1] do
			self.__list[iter_5_1](arg_5_1, ...)
		end
	end

	return
end

function IslandDispatcher:ClearListeners()
	for iter_6_0, iter_6_1 in pairs(self.__callbacks) do
		self.__callbacks[iter_6_0] = nil
	end

	for iter_6_2, iter_6_3 in ipairs(self.__list) do
		self.__list[iter_6_2] = nil
	end

	return
end

return IslandDispatcher
