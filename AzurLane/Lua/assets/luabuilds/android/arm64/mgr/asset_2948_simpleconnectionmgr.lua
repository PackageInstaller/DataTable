pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.SimpleConnectionMgr = var_0_10001("SimpleConnectionMgr")

local var_0_1 = var_0.SimpleConnectionMgr

createLog = var_0_10002

local var_0_2 = var_0_10002("SimpleConnectionMgr", false)
local var_0_3
local var_0_4
local var_0_5 = false
local var_0_6 = {}
local var_0_7

function var_0_1.Connect(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_1.stopTimer()

	Connection = var_5
	var_0_3 = var_5.New(arg_1_1, arg_1_2)

	local var_1_0 = var_0.UIMgr.GetInstance()

	var_5.LoadingOn(var_1_0)

	local var_1_1 = var_0_3.onConnected

	var_5.AddListener(var_1_1, function()
		local var_2_0 = var_0.UIMgr.GetInstance()

		var_0.LoadingOff(var_2_0)
		var_0_2("Simple Network Connected.")

		local var_2_1

		if not var_0_4 then
			var_2_1 = var_0.SendWindow.New(arg_1_0, 0)
		end

		var_0_4 = var_2_1

		local var_2_2 = var_0_3.onData

		var_0.AddListener(var_2_2, var_0_4.onData)

		var_0_5 = true
		var_0_7 = false

		arg_1_3()

		return
	end)

	local var_1_2 = var_0_3.onData

	var_5.AddListener(var_1_2, arg_1_0.onData)

	local var_1_3 = var_0_3.onError

	var_5.AddListener(var_1_3, arg_1_0.onError)

	local var_1_4 = var_0_3.onDisconnected

	var_5.AddListener(var_1_4, arg_1_0.onDisconnected)

	var_0_7 = true

	local var_1_5 = var_0_3

	var_5.Connect(var_1_5)

	defaultValue = var_5

	local var_1_6 = arg_1_4

	SEND_TIMEOUT = var_8
	arg_1_4 = var_5(var_1_6, var_8)

	local var_1_7 = var_0_1

	Timer = var_1_10006
	var_1_7.timer = var_1_10006.New(function()
		if not var_0_5 then
			warning = var_0

			var_0("connect timeout error (custom): " .. arg_1_4)
			var_0_1.stopTimer()

			local var_3_0 = arg_1_0.onDisconnected
			local var_3_1 = false

			DISCONNECT_TIME_OUT = var_3

			var_3_0(var_3_1, var_3)

			if var_0_1.errorCB then
				var_0_1.errorCB()
			end
		end

		return
	end, arg_1_4, 1)

	local var_1_8 = var_0_1.timer

	var_5.Start(var_1_8)

	return
end

function var_0_1.stopTimer()
	if var_0_1.timer then
		local var_4_0 = var_0_1.timer

		var_0.Stop(var_4_0)

		var_0_1.timer = nil
	end

	return
end

function var_0_1.onDisconnected(arg_5_0, arg_5_1)
	local var_5_0 = var_0_2
	local var_5_1 = "Simple Network onDisconnected: "

	tostring = var_1_10005

	var_5_0(var_5_1 .. var_1_10005(arg_5_0))

	if var_0_3 then
		if not arg_5_0 then
			local var_5_2 = var_0_3.onDisconnected

			var_2.RemoveAllListeners(var_5_2)
		end

		local var_5_3 = var_0_3

		var_2.Dispose(var_5_3)

		var_0_3 = nil
	end

	if arg_5_0 then
		var_0_5 = false
	end

	if var_0_7 then
		local var_5_4 = var_0.UIMgr.GetInstance()

		var_2.LoadingOff(var_5_4)
	end

	var_0_7 = false

	return
end

function var_0_1.onData(arg_6_0)
	if var_0_6[arg_6_0.cmd] then
		local var_6_0 = var_0.Packer.GetInstance()
		local var_6_1 = var_1.Unpack(var_6_0, arg_6_0.cmd, arg_6_0:getLuaStringBuffer())

		ipairs = var_2

		for iter_6_0, iter_6_1 in var_2(var_0_6[arg_6_0.cmd]) do
			iter_6_1(var_6_1)
		end
	end

	return
end

function var_0_1.SetErrorCB(arg_7_0, arg_7_1)
	var_0_1.errorCB = arg_7_1

	return
end

function var_0_1.onError(arg_8_0)
	var_0_1.stopTimer()

	tostring = var_1
	arg_8_0 = var_1(arg_8_0)

	var_0_2("Simple Network Error: " .. arg_8_0)

	if var_0_3 then
		local var_8_0 = var_0_3

		var_1.Dispose(var_8_0)

		var_0_3 = nil
	end

	if var_0_7 then
		var_0_7 = false
	end

	if var_0_1.errorCB then
		var_0_1.errorCB()
	end

	return
end

function var_0_1.Send(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	if not var_0_5 then
		warning = var_7

		var_7("Simple Network is not connected. msgid " .. arg_9_1)

		return
	end

	local var_9_0 = var_0_4

	var_7.Queue(var_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, nil, arg_9_6)

	return
end

function var_0_1.setPacketIdx(arg_10_0, arg_10_1)
	local var_10_0 = var_0_4

	var_2.setPacketIdx(var_10_0, arg_10_1)

	return
end

function var_0_1.On(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0

	if var_0_6[arg_11_1] == nil then
		var_11_0 = var_0_6
		var_11_0[arg_11_1] = {}
	end

	table = var_11_0

	var_11_0.insert(var_0_6[arg_11_1], arg_11_2)

	return
end

function var_0_1.Off(arg_12_0, arg_12_1, arg_12_2)
	if var_0_6[arg_12_1] == nil then
		return
	end

	local var_12_0

	if arg_12_2 == nil then
		var_12_0 = var_0_6
		var_12_0[arg_12_1] = nil
	else
		ipairs = var_12_0

		for iter_12_0, iter_12_1 in var_12_0(var_0_6[arg_12_1]) do
			if iter_12_1 == arg_12_2 then
				table = var_1_10008

				var_1_10008.remove(var_0_6[arg_12_1], iter_12_0)

				break
			end
		end
	end

	return
end

function var_0_1.Disconnect(arg_13_0)
	var_0_6 = {}

	var_0_2("Simple Network Disconnect !!!")

	if var_0_3 then
		local var_13_0 = var_0_3

		var_1.Dispose(var_13_0)

		var_0_3 = nil
	end

	var_0_4 = nil
	var_0_5 = false

	return
end

function var_0_1.Reconnect(arg_14_0, arg_14_1)
	arg_14_0:Disconnect()

	if var_0_1.errorCB then
		var_0_1.errorCB()
	end

	return
end

function var_0_1.resetHBTimer(arg_15_0)
	return
end

function var_0_1.getConnection(arg_16_0)
	return var_0_3
end

function var_0_1.isConnecting(arg_17_0)
	return var_0_7
end

function var_0_1.isConnected(arg_18_0)
	return var_0_5
end

function var_0_1.SwitchProxy(arg_19_0)
	return
end

return
