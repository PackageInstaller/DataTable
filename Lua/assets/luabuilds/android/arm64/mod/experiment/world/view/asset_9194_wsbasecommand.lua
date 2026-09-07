local WSBaseCommand = class("WSBaseCommand")

local function var_0_1(arg_1_0, arg_1_1)
	return arg_1_0 ~= nil and type(arg_1_0) == arg_1_1
end

local var_0_2 = {
	__index = function(arg_2_0, arg_2_1)
		local var_2_0 = rawget(arg_2_0, "class")

		if var_0_1(rawget(WSBaseCommand, arg_2_1), "function") then
			return var_2_0[arg_2_1]
		elseif var_0_1(rawget(var_2_0, arg_2_1), "function") then
			return function(arg_3_0, ...)
				arg_3_0:Op(arg_2_1, ...)

				return
			end
		else
			local var_2_1 = rawget(arg_2_0, arg_2_1)

			if var_2_1 == nil then
				return var_2_0[arg_2_1]
			else
				return var_2_1
			end
		end

		return
	end
}

function WSBaseCommand:Ctor(arg_4_1)
	self.index = arg_4_1
	self.wsOps = {}

	setmetatable(self, var_0_2)

	return
end

function WSBaseCommand:Dispose()
	return
end

function WSBaseCommand:Op(arg_6_1, ...)
	assert(arg_6_1 and #arg_6_1 > 0)

	if #self.wsOps > 0 then
		WorldConst.Print("ignore operation: " .. arg_6_1 .. ", current operation: " .. self.wsOps[#self.wsOps])

		return
	end

	WorldConst.Print(self.index .. " do operation: " .. arg_6_1)
	table.insert(self.wsOps, arg_6_1)
	self.class[arg_6_1](self, ...)

	return
end

function WSBaseCommand:OpDone(arg_7_1, ...)
	assert(#self.wsOps > 0, "current operation can not be nil.")

	if arg_7_1 ~= nil and self.wsOps[#self.wsOps] .. "Done" ~= arg_7_1 then
		assert(false, "current operation " .. self.wsOps[#self.wsOps] .. " mismatch with " .. arg_7_1)

		return
	end

	WorldConst.Print(self.index .. " operation done: " .. self.wsOps[#self.wsOps])
	table.remove(self.wsOps, #self.wsOps)

	if arg_7_1 then
		self.class[arg_7_1](self, ...)
	end

	return
end

function WSBaseCommand:OpRaw(arg_8_1, ...)
	local var_8_0 = setmetatable({
		Op = function(self, arg_9_1, ...)
			self.class[arg_9_1](self, ...)

			return
		end,
		OpDone = function(self, arg_10_1, ...)
			if arg_10_1 then
				self[arg_10_1](self, ...)
			end

			return
		end
	}, {
		__index = self,
		__newindex = self
	})

	var_8_0[arg_8_1](var_8_0, ...)

	return
end

function WSBaseCommand:OpClear()
	self.wsOps = {}

	return
end

return WSBaseCommand
