local var_0_0 = import("manager/net/BinaryReader")
local var_0_1 = class("Protocol")

var_0_1.protocols = {}
var_0_1.binaryReader = var_0_0.New()
var_0_1.ps = PackStream.New()

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._id = arg_1_1
	arg_1_0._name = arg_1_2
	arg_1_0._object = arg_1_3
end

function var_0_1.GetMessage(arg_2_0)
	return arg_2_0._object[arg_2_0._name]()
end

function var_0_1.GetId(arg_3_0)
	return arg_3_0._id
end

function var_0_1.GetName(arg_4_0)
	return arg_4_0._name
end

function var_0_1.Pack(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_3:SerializeToString()
	local var_5_1 = var_0_1.ps

	if var_5_1.Length ~= 0 then
		print("##   # pack string error !!!!!!!!!!!")
	end

	if #var_5_0 == 0 then
		var_5_1:WriteUint32LittleEndian(9)
	else
		var_5_1:WriteUint32LittleEndian(9 + #var_5_0)
	end

	local var_5_2 = arg_5_4 and 7 or 8

	var_5_1:WriteUint8(var_5_2)
	var_5_1:WriteUint32LittleEndian(arg_5_2)
	var_5_1:WriteUint16LittleEndian(arg_5_0)
	var_5_1:WriteUint16LittleEndian(arg_5_1)
	var_5_1:WriteBuffer(var_5_0)

	return var_5_1:ToArray()
end

var_0_1.gameFrameTimePart1Index_ = 3
var_0_1.gameFrameTimePart2Index_ = 4

function var_0_1.SetSyncPlayerCount(arg_6_0)
	var_0_1.gameFrameTimePart1Index_ = arg_6_0 + 2
	var_0_1.gameFrameTimePart2Index_ = arg_6_0 + 3
end

function var_0_1.ToByte(arg_7_0)
	local var_7_0 = #arg_7_0
	local var_7_1 = string.byte(arg_7_0, 1)

	for iter_7_0 = 2, var_7_0 do
		var_7_1 = var_7_1 .. "-" .. string.byte(arg_7_0, iter_7_0)
	end
end

function var_0_1.Unpack(arg_8_0, arg_8_1)
	if arg_8_0 ~= 65522 then
		local var_8_0 = var_0_1.GetProtocolWithName("sc_" .. arg_8_0)

		if var_8_0 ~= nil then
			local var_8_1 = var_8_0._object[var_8_0._name]()

			var_8_1:ParseFromString(arg_8_1)

			return var_8_1
		end
	else
		local var_8_2 = {
			frames = {}
		}

		var_0_1.binaryReader:Initialize(arg_8_1)

		var_8_2.currentServerFrame = var_0_1.binaryReader:Read(4)

		if var_8_2.currentServerFrame == 0 then
			var_8_2.isFirstKeyFrameUpdate = true
		end

		while not var_0_1.binaryReader:EOF() do
			local var_8_3 = var_0_1.binaryReader:Read(4)
			local var_8_4 = var_0_1.binaryReader:Read(1)
			local var_8_5 = {}

			var_8_2.frames[var_8_3] = {
				playerOps = var_8_5
			}

			for iter_8_0 = 1, var_8_4 do
				local var_8_6 = var_0_1.binaryReader:Read(1)
				local var_8_7 = var_0_1.binaryReader:Read(1)
				local var_8_8 = {}

				var_8_5[var_8_6] = var_8_8

				for iter_8_1 = 1, var_8_7 do
					local var_8_9
					local var_8_10 = var_0_1.binaryReader:Read(1)

					if var_8_10 == 3 then
						var_8_9 = var_0_1.binaryReader:Read(2)
					else
						var_8_9 = var_0_1.binaryReader:Read(1)
					end

					table.insert(var_8_8, {
						opCode = var_8_9,
						opType = var_8_10
					})
				end
			end
		end

		return var_8_2
	end
end

function var_0_1.GetProtocolWithName(arg_9_0)
	if not var_0_1.protocols[arg_9_0] then
		local var_9_0 = string.sub(arg_9_0, 4, #arg_9_0)
		local var_9_1 = "protocol/"
		local var_9_2 = "p" .. string.sub(var_9_0, 1, 2) .. "_pb"
		local var_9_3

		if require(var_9_1 .. var_9_2) then
			local var_9_4 = Protocol.New(var_9_0, arg_9_0, package.loaded[var_9_2])

			var_0_1.protocols[arg_9_0] = var_9_4
		end
	end

	return var_0_1.protocols[arg_9_0]
end

function var_0_1.BuildProtocolMessage(arg_10_0, arg_10_1)
	if arg_10_1 == nil then
		print("data is nil...")
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		if type(iter_10_1) == "table" then
			if #iter_10_1 > 0 then
				var_0_1.BuildProtocolMessageRepeat(arg_10_0[iter_10_0], iter_10_1)
			else
				var_0_1.BuildProtocolMessageNormalTable(arg_10_0[iter_10_0], iter_10_1)
			end
		else
			arg_10_0[iter_10_0] = iter_10_1
		end
	end
end

function var_0_1.BuildProtocolMessageRepeat(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if arg_11_0.add then
			local var_11_0 = arg_11_0:add()

			var_0_1.BuildProtocolMessage(var_11_0, iter_11_1)
		elseif type(iter_11_1) == "table" then
			if #iter_11_1 > 0 or table.nums(iter_11_1) == 0 then
				var_0_1.BuildProtocolMessageRepeat(arg_11_0[iter_11_0], iter_11_1)
			else
				var_0_1.BuildProtocolMessageNormalTable(arg_11_0[iter_11_0], iter_11_1)
			end
		else
			arg_11_0:append(iter_11_1)
		end
	end
end

function var_0_1.BuildProtocolMessageNormalTable(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		if arg_12_0.add then
			var_0_1.BuildProtocolMessage(arg_12_0:add(), iter_12_1)
		elseif type(iter_12_1) == "table" then
			if #iter_12_1 > 0 or table.nums(iter_12_1) == 0 then
				var_0_1.BuildProtocolMessageRepeat(arg_12_0[iter_12_0], iter_12_1)
			else
				var_0_1.BuildProtocolMessageNormalTable(arg_12_0[iter_12_0], iter_12_1)
			end
		else
			arg_12_0[iter_12_0] = iter_12_1
		end
	end
end

return var_0_1
