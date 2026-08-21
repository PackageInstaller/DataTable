pg = pg or {}

local var_0_0 = pg

pg.SimpleConnectionMgr = singletonClass("SimpleConnectionMgr")

local var_0_1 = pg.SimpleConnectionMgr
local var_0_2 = createLog("SimpleConnectionMgr", false)
local var_0_3
local var_0_4
local var_0_5 = false
local var_0_6 = {}
local var_0_7

function pg.SimpleConnectionMgr.Connect(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_1.stopTimer()

	var_0_3 = Connection.New(arg_1_1, arg_1_2)

	var_0_0.UIMgr.GetInstance():LoadingOn()
	var_0_3.onConnected:AddListener(function()
		var_0_0.UIMgr.GetInstance():LoadingOff()
		var_0_2("Simple Network Connected.")

		var_0_4 = var_0_4 or var_0_0.SendWindow.New(arg_1_0, 0)

		var_0_3.onData:AddListener(var_0_4.onData)

		var_0_5 = true
		var_0_7 = false

		arg_1_3()

		return
	end)
	var_0_3.onData:AddListener(arg_1_0.onData)
	var_0_3.onError:AddListener(arg_1_0.onError)
	var_0_3.onDisconnected:AddListener(arg_1_0.onDisconnected)

	var_0_7 = true

	var_0_3:Connect()

	arg_1_4 = defaultValue(arg_1_4, SEND_TIMEOUT)
	var_0_1.timer = Timer.New(function()
		if not var_0_5 then
			warning("connect timeout error (custom): " .. arg_1_4)
			var_0_1.stopTimer()
			arg_1_0.onDisconnected(false, DISCONNECT_TIME_OUT)

			if var_0_1.errorCB then
				var_0_1.errorCB()
			end
		end

		return
	end, arg_1_4, 1)

	var_0_1.timer:Start()

	return
end

function pg.SimpleConnectionMgr.stopTimer()
	if var_0_1.timer then
		var_0_1.timer:Stop()

		var_0_1.timer = nil
	end

	return
end

function pg.SimpleConnectionMgr.onDisconnected(arg_5_0, arg_5_1)
	var_0_2("Simple Network onDisconnected: " .. tostring(arg_5_0))

	if var_0_3 then
		if not arg_5_0 then
			var_0_3.onDisconnected:RemoveAllListeners()
		end

		var_0_3:Dispose()

		var_0_3 = nil
	end

	if arg_5_0 then
		var_0_5 = false
	end

	if var_0_7 then
		var_0_0.UIMgr.GetInstance():LoadingOff()
	end

	var_0_7 = false

	return
end

function pg.SimpleConnectionMgr.onData(arg_6_0)
	if var_0_6[arg_6_0.cmd] then
		local var_6_0 = var_0_0.Packer.GetInstance():Unpack(arg_6_0.cmd, arg_6_0:getLuaStringBuffer())

		for iter_6_0, iter_6_1 in ipairs(var_0_6[arg_6_0.cmd]) do
			iter_6_1(var_6_0)
		end
	end

	return
end

function pg.SimpleConnectionMgr.SetErrorCB(arg_7_0, arg_7_1)
	var_0_1.errorCB = arg_7_1

	return
end

function pg.SimpleConnectionMgr.onError(arg_8_0)
	var_0_1.stopTimer()

	arg_8_0 = tostring(arg_8_0)

	var_0_2("Simple Network Error: " .. arg_8_0)

	if var_0_3 then
		var_0_3:Dispose()

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

function pg.SimpleConnectionMgr.Send(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	if not var_0_5 then
		warning("Simple Network is not connected. msgid " .. arg_9_1)

		return
	end

	var_0_4:Queue(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, nil, arg_9_6)

	return
end

function pg.SimpleConnectionMgr.setPacketIdx(arg_10_0, arg_10_1)
	var_0_4:setPacketIdx(arg_10_1)

	return
end

function pg.SimpleConnectionMgr.On(arg_11_0, arg_11_1, arg_11_2)
	if var_0_6[arg_11_1] == nil then
		var_0_6[arg_11_1] = {}
	end

	table.insert(var_0_6[arg_11_1], arg_11_2)

	return
end

function pg.SimpleConnectionMgr.Off(arg_12_0, arg_12_1, arg_12_2)
	if var_0_6[arg_12_1] == nil then
		return
	end

	if arg_12_2 == nil then
		var_0_6[arg_12_1] = nil
	else
		for iter_12_0, iter_12_1 in ipairs(var_0_6[arg_12_1]) do
			if iter_12_1 == arg_12_2 then
				table.remove(var_0_6[arg_12_1], iter_12_0)

				break
			end
		end
	end

	return
end

function pg.SimpleConnectionMgr.Disconnect(arg_13_0)
	var_0_6 = {}

	var_0_2("Simple Network Disconnect !!!")

	if var_0_3 then
		var_0_3:Dispose()

		var_0_3 = nil
	end

	var_0_4 = nil
	var_0_5 = false

	return
end

function pg.SimpleConnectionMgr.Reconnect(arg_14_0, arg_14_1)
	arg_14_0:Disconnect()

	if var_0_1.errorCB then
		var_0_1.errorCB()
	end

	return
end

function pg.SimpleConnectionMgr.resetHBTimer(arg_15_0)
	return
end

function pg.SimpleConnectionMgr.getConnection(arg_16_0)
	return var_0_3
end

function pg.SimpleConnectionMgr.isConnecting(arg_17_0)
	return var_0_7
end

function pg.SimpleConnectionMgr.isConnected(arg_18_0)
	return var_0_5
end

function pg.SimpleConnectionMgr.SwitchProxy(arg_19_0)
	return
end

return
