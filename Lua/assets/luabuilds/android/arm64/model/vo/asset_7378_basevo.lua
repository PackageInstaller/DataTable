local BaseVO = class("BaseVO")

function BaseVO:Ctor(arg_1_1)
	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		self[iter_1_0] = iter_1_1
	end

	return
end

function BaseVO:display(arg_2_1, arg_2_2)
	if arg_2_1 == "loaded" or not arg_2_2 then
		return
	end

	local var_2_0 = self.__cname .. " id: " .. tostring(self.id) .. " " .. (arg_2_1 or ".")

	for iter_2_0, iter_2_1 in pairs(self) do
		if iter_2_0 ~= "class" then
			var_2_0 = var_2_0 .. "\n" .. iter_2_0 .. ":" .. tostring(iter_2_1)

			if type(iter_2_1) == "table" then
				var_2_0 = var_2_0 .. " ["

				for iter_2_2, iter_2_3 in pairs(iter_2_1) do
					var_2_0 = var_2_0 .. tostring(iter_2_3) .. ", "
				end

				var_2_0 = var_2_0 .. "]" or var_2_0
			end
		end
	end

	print(var_2_0)

	return
end

function BaseVO:clone()
	return Clone(self)
end

function BaseVO:bindConfigTable()
	return
end

function BaseVO:GetConfigID()
	return self.configId
end

function BaseVO:getConfigTable()
	local var_6_0 = self:bindConfigTable()

	assert(var_6_0, "should bindConfigTable() first: " .. self.__cname)

	return var_6_0[self.configId]
end

function BaseVO:getConfig(arg_7_1)
	local var_7_0 = self:getConfigTable()

	assert(var_7_0 ~= nil, "Config missed, type -" .. self.__cname .. " configId: " .. tostring(self.configId))

	if arg_7_1 == "name" or arg_7_1 == "desc" then
		return (HXSet.hxLan(var_7_0[arg_7_1]))
	end

	return var_7_0[arg_7_1]
end

return BaseVO
