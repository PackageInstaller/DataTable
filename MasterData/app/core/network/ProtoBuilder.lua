local var_0_0 = tostring
local var_0_1 = string
local var_0_2 = string.format

return {
	encode = function(self, arg_1_1, arg_1_2)
		local var_1_0 = g.core.network.proto.list[var_0_0(arg_1_1)]

		assert(var_1_0, "Invalid msg id: " .. var_0_0(arg_1_1))

		return self:encodeByMsgName(var_0_2("C2%s_%s", var_1_0[2], var_1_0[1]), arg_1_2)
	end,
	encodeByMsgName = function(self, arg_2_1, arg_2_2)
		assert(arg_2_1, "Invalid magName: " .. var_0_0(arg_2_1))
		assert(type(arg_2_2) == "table", "Invalid content: " .. tostring(arg_2_2))

		arg_2_1 = g.core.network.proto[arg_2_1] and arg_2_1 or "Empty_Message"

		local var_2_0 = g.core.network.proto[arg_2_1]()

		self:_encodeMessage(var_2_0, arg_2_2)

		return var_2_0:SerializeToString()
	end,
	decode = function(self, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = g.core.network.proto.list[var_0_0(arg_3_1)]

		assert(var_3_0, "Invalid msg id: " .. var_0_0(arg_3_1))

		return self:decodeByMsgName(var_0_2("%s2C_%s", var_3_0[2], var_3_0[1]), arg_3_2)
	end,
	checkBlack = function(self, arg_4_1)
		for iter_4_0, iter_4_1 in pairs(arg_4_1) do
			if type(iter_4_1) == "string" then
				if iter_4_0 == "content" or iter_4_0 == "message" or iter_4_0 == "declaration" or iter_4_0 == "announcement" or var_0_1.match(iter_4_0, "name$") then
					arg_4_1[iter_4_0] = g.core.utils.Black:filterBlack(iter_4_1)
				end
			elseif type(iter_4_1) == "table" then
				arg_4_1[iter_4_0] = self:checkBlack(iter_4_1)
			end
		end

		return arg_4_1
	end,
	decodeByMsgName = function(self, arg_5_1, arg_5_2)
		assert(arg_5_1, "Invalid magName: " .. var_0_0(arg_5_1))
		assert(type(arg_5_2) == "string", "Invalid msg: " .. tostring(arg_5_2))

		local var_5_0 = g.core.network.proto[arg_5_1]()

		var_5_0:ParseFromString(arg_5_2)

		local var_5_1 = self:_transProto(var_5_0)

		if arg_5_1 ~= "S2C_Questionnaire_GetInfo" and arg_5_1 ~= "S2C_ChatBroadcast" and arg_5_1 ~= "S2C_Mail_Info" and arg_5_1 ~= "S2C_Announce_Info" and arg_5_1 ~= "S2C_Announce_Flush" then
			var_5_1 = self:checkBlack(var_5_1)
		end

		return var_5_1
	end,
	_encodeMessage = function(self, arg_6_1, arg_6_2)
		for iter_6_0, iter_6_1 in pairs(arg_6_2) do
			if type(iter_6_1) == "table" then
				if iter_6_1[1] then
					self:_encodeRepeated(arg_6_1[iter_6_0], iter_6_1)
				elseif iter_6_1.__bytes then
					arg_6_1[iter_6_0] = self:encode(iter_6_1.msgId, iter_6_1.content)
				else
					self:_encodeMessage(arg_6_1[iter_6_0], iter_6_1)
				end
			else
				arg_6_1[iter_6_0] = iter_6_1
			end
		end
	end,
	_encodeRepeated = function(self, arg_7_1, arg_7_2)
		for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
			if type(iter_7_1) == "table" then
				self:_encodeMessage(arg_7_1:add(), iter_7_1)
			else
				arg_7_1:append(iter_7_1)
			end
		end
	end,
	_transProto = function(self, arg_8_1, arg_8_2)
		local var_8_0 = {}

		if arg_8_1._fields then
			for iter_8_0, iter_8_1 in pairs(arg_8_1._fields) do
				local var_8_1 = false
				local var_8_2 = iter_8_0

				if type(iter_8_0) == "table" then
					if iter_8_0.type == 4 or iter_8_0.type == 3 then
						var_8_1 = true
					end

					var_8_2 = iter_8_0.name
				end

				if type(iter_8_1) == "table" then
					iter_8_1 = self:_transProto(iter_8_1, var_8_1)
				elseif type(iter_8_1) == "string" and var_8_1 then
					iter_8_1 = var_8_1 and tonumber(iter_8_1) or g.core.utils.Black:filterBlack(iter_8_1)
				end

				var_8_0[var_8_2] = iter_8_1
			end
		else
			for iter_8_2, iter_8_3 in ipairs(arg_8_1) do
				if type(iter_8_3) == "table" then
					iter_8_3 = self:_transProto(iter_8_3)
				elseif type(iter_8_3) == "string" and arg_8_2 then
					iter_8_3 = arg_8_2 and tonumber(iter_8_3) or g.core.utils.Black:filterBlack(iter_8_3)
				end

				var_8_0[iter_8_2] = iter_8_3
			end
		end

		return var_8_0
	end
}
