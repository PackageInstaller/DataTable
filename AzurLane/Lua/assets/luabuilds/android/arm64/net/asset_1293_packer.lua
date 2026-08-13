pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.Packer = var_0_10001("Packer")

local var_0_1 = var_0.Packer

var_0_1.ps = nil

function var_0_1.Ctor(arg_1_0)
	arg_1_0._protocols = {}

	local var_1_0 = var_0_1

	PackStream = var_1_10002
	var_1_0.ps = var_1_10002.New()
	arg_1_0.defaultBuffSize = 8192

	return
end

function var_0_1.Pack(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_3:SerializeToString()
	local var_2_1 = ""
	local var_2_2 = arg_2_0.ps

	if #var_2_0 > arg_2_0.defaultBuffSize - 7 then
		PackStream = var_7
		var_2_2 = var_7.New(#var_2_0 + 7)
	end

	if var_2_2.Length ~= 0 then
		print = var_7

		var_7("### pack string error !!!!!!!!!!!")
	end

	if #var_2_0 == 0 then
		var_2_2:WriteUint16(6)
	else
		var_2_2:WriteUint16(5 + #var_2_0)
	end

	var_2_2:WriteUint8(0)
	var_2_2:WriteUint16(arg_2_2)
	var_2_2:WriteUint16(arg_2_1)
	var_2_2:WriteBuffer(var_2_0)

	return var_2_2:ToArray()
end

function var_0_1.Unpack(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_1.GetInstance()

	if var_3.GetProtocolWithName(var_3_0, "sc_" .. arg_3_1) ~= nil then
		local var_3_1 = var_3._object[var_3._name]()

		var_4.ParseFromString(var_3_1, arg_3_2)

		return var_4
	end

	return
end

function var_0_1.GetProtocolWithName(arg_4_0, arg_4_1)
	if arg_4_0._protocols[arg_4_1] ~= nil then
		return arg_4_0._protocols[arg_4_1]
	end

	string = var_2

	local var_4_0 = var_2.sub(arg_4_1, 4, #arg_4_1)
	local var_4_1 = "Net/Protocol/"
	local var_4_2 = "p"

	string = var_5

	local var_4_3 = var_4_2 .. var_5.sub(var_4_0, 1, 2) .. "_pb"
	local var_4_4

	pcall = var_6

	var_6(function()
		require = var_2_10000
		var_4_4 = var_2_10000(var_4_1 .. var_4_3)

		return
	end)

	if var_4_4 then
		local var_4_5 = var_0.Protocol.New
		local var_4_6 = var_4_0
		local var_4_7 = arg_4_1

		package = var_1_10010

		local var_4_8 = var_4_5(var_4_6, var_4_7, var_1_10010.loaded[var_4_3])

		arg_4_0._protocols[arg_4_1] = var_4_8

		return var_4_8
	else
		return nil
	end

	return
end

return
