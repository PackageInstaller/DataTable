local Protocol = class("Protocol")

Protocol.protocols = {}
Protocol.binaryReader = import("manager/net/BinaryReader").New()
Protocol.ps = PackStream.New()

function Protocol:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._id = arg_1_1
	self._name = arg_1_2
	self._object = arg_1_3
end

function Protocol:GetMessage()
	return self._object[self._name]()
end

function Protocol:GetId()
	return self._id
end

function Protocol:GetName()
	return self._name
end

function Protocol:Pack(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_3:SerializeToString()
	local var_5_1 = Protocol.ps

	if Protocol.ps.Length ~= 0 then
		print("##   # pack string error !!!!!!!!!!!")
	end

	if #var_5_0 == 0 then
		var_5_1:WriteUint32LittleEndian(9)
	else
		var_5_1:WriteUint32LittleEndian(9 + #var_5_0)
	end

	var_5_1:WriteUint8(arg_5_4 and 7 or 8)
	var_5_1:WriteUint32LittleEndian(arg_5_2)
	var_5_1:WriteUint16LittleEndian(self)
	var_5_1:WriteUint16LittleEndian(arg_5_1)
	var_5_1:WriteBuffer(var_5_0)

	return var_5_1:ToArray()
end

Protocol.gameFrameTimePart1Index_ = 3
Protocol.gameFrameTimePart2Index_ = 4

function Protocol:SetSyncPlayerCount()
	Protocol.gameFrameTimePart1Index_ = self + 2
	Protocol.gameFrameTimePart2Index_ = self + 3
end

function Protocol:ToByte()
	local var_7_0 = string.byte(self, 1)

	for iter_7_0 = 2, #self do
		var_7_0 = var_7_0 .. "-" .. string.byte(self, iter_7_0)
	end
end

function Protocol:Unpack(arg_8_1)
	if self ~= 65522 then
		local var_8_0 = Protocol.GetProtocolWithName("sc_" .. self)

		if var_8_0 ~= nil then
			local var_8_1 = var_8_0._object[var_8_0._name]()

			var_8_1:ParseFromString(arg_8_1)

			return var_8_1
		end
	else
		local var_8_2 = {
			frames = {}
		}

		Protocol.binaryReader:Initialize(arg_8_1)

		var_8_2.currentServerFrame = Protocol.binaryReader:Read(4)

		if var_8_2.currentServerFrame == 0 then
			var_8_2.isFirstKeyFrameUpdate = true
		end

		while not Protocol.binaryReader:EOF() do
			local var_8_3 = Protocol.binaryReader:Read(1)
			local var_8_4 = {}

			var_8_2.frames[Protocol.binaryReader:Read(4)] = {
				playerOps = var_8_4
			}

			for iter_8_0 = 1, var_8_3 do
				local var_8_5 = Protocol.binaryReader:Read(1)
				local var_8_6 = {}

				var_8_4[Protocol.binaryReader:Read(1)] = var_8_6

				for iter_8_1 = 1, var_8_5 do
					local var_8_7
					local var_8_8 = Protocol.binaryReader:Read(1)

					var_8_7 = var_8_8 == 3 and Protocol.binaryReader:Read(2) or Protocol.binaryReader:Read(1)

					table.insert(var_8_6, {
						opCode = var_8_7,
						opType = var_8_8
					})
				end
			end
		end

		return var_8_2
	end
end

function Protocol:GetProtocolWithName()
	if not Protocol.protocols[self] then
		local var_9_0 = string.sub(self, 4, #self)
		local var_9_1 = "p" .. string.sub(var_9_0, 1, 2) .. "_pb"

		if require("protocol/" .. var_9_1) then
			Protocol.protocols[self] = Protocol.New(var_9_0, self, package.loaded[var_9_1])
		end
	end

	return Protocol.protocols[self]
end

function Protocol:BuildProtocolMessage(arg_10_1)
	if arg_10_1 == nil then
		print("data is nil...")
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		if type(iter_10_1) == "table" then
			if #iter_10_1 > 0 then
				Protocol.BuildProtocolMessageRepeat(self[iter_10_0], iter_10_1)
			else
				Protocol.BuildProtocolMessageNormalTable(self[iter_10_0], iter_10_1)
			end
		else
			self[iter_10_0] = iter_10_1
		end
	end
end

function Protocol:BuildProtocolMessageRepeat(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if self.add then
			Protocol.BuildProtocolMessage(self:add(), iter_11_1)
		elseif type(iter_11_1) == "table" then
			if #iter_11_1 > 0 or table.nums(iter_11_1) == 0 then
				Protocol.BuildProtocolMessageRepeat(self[iter_11_0], iter_11_1)
			else
				Protocol.BuildProtocolMessageNormalTable(self[iter_11_0], iter_11_1)
			end
		else
			self:append(iter_11_1)
		end
	end
end

function Protocol:BuildProtocolMessageNormalTable(arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		if self.add then
			Protocol.BuildProtocolMessage(self:add(), iter_12_1)
		elseif type(iter_12_1) == "table" then
			if #iter_12_1 > 0 or table.nums(iter_12_1) == 0 then
				Protocol.BuildProtocolMessageRepeat(self[iter_12_0], iter_12_1)
			else
				Protocol.BuildProtocolMessageNormalTable(self[iter_12_0], iter_12_1)
			end
		else
			self[iter_12_0] = iter_12_1
		end
	end
end

return Protocol
