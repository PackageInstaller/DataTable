pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.ConnectionMgr = var_0_10001("ConnectionMgr")

local var_0_1 = var_0.ConnectionMgr

createLog = var_0_10002

local var_0_2 = "ConnectionMgr"

LOG_CONNECTION = var_0_10005

local var_0_3 = var_0_10002(var_0_2, var_0_10005)
local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8 = false
local var_0_9 = {}
local var_0_10
local var_0_11
local var_0_12
local var_0_13

var_0_1.needStartSend = false

local var_0_14
local var_0_15
local var_0_16
local var_0_17

function var_0_1.Connect(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = var_0_1

	var_1_0.erroCode = arg_1_4
	var_0_17 = arg_1_3
	Connection = var_1_0
	var_0_4 = var_1_0.New(arg_1_1, arg_1_2)

	local var_1_1 = var_0.UIMgr.GetInstance()

	var_5.LoadingOn(var_1_1)

	local var_1_2 = var_0_4.onConnected

	var_5.AddListener(var_1_2, function()
		local var_2_0 = var_0.UIMgr.GetInstance()

		var_0.LoadingOff(var_2_0)

		originalPrint = var_0

		var_0("Network Connected.")

		var_0_6 = arg_1_1
		var_0_7 = arg_1_2

		local var_2_1

		if not var_0_5 then
			var_2_1 = var_0.SendWindow.New(arg_1_0, 0)
		end

		var_0_5 = var_2_1

		local var_2_2 = var_0_4.onData

		var_0.AddListener(var_2_2, var_0_5.onData)

		PLATFORM_CODE = var_0
		PLATFORM_CHT = var_2_10001

		if var_0 == var_2_10001 then
			var_0_14 = var_0.IPAddress.New()
		end

		var_0_16 = -1
		var_0_8 = true
		var_0_11 = false

		arg_1_3()

		local var_2_3 = arg_1_0

		var_0.resetHBTimer(var_2_3)

		return
	end)

	local var_1_3 = var_0_4.onData

	var_5.AddListener(var_1_3, arg_1_0.onData)

	local var_1_4 = var_0_4.onError

	var_5.AddListener(var_1_4, arg_1_0.onError)

	local var_1_5 = var_0_4.onDisconnected

	var_5.AddListener(var_1_5, arg_1_0.onDisconnected)

	var_0_11 = true

	local var_1_6 = var_0_4

	var_5.Connect(var_1_6)

	originalPrint = var_5

	var_5("connect to - " .. arg_1_1 .. ":" .. arg_1_2)

	return
end

function var_0_1.ConnectByProxy(arg_3_0)
	VersionMgr = var_1_10001

	local var_3_0 = var_1_10001.Inst

	var_1.SetUseProxy(var_3_0, true)

	if arg_3_0:GetLastHost() ~= nil and arg_3_0:GetLastPort() ~= "" then
		originalPrint = var_1

		var_1("switch proxy! reason: first connect error")
		arg_3_0:Connect(arg_3_0:GetLastHost(), arg_3_0:GetLastPort(), var_0_17)
	else
		originalPrint = var_1

		var_1("not proxy -> logout")

		local var_3_1 = var_0.m02
		local var_3_2 = var_1.sendNotification

		GAME = var_4

		local var_3_3 = var_4.LOGOUT
		local var_3_4 = {}
		local var_3_5

		if not var_0_1.erroCode then
			var_3_5 = 3
		end

		var_3_4.code = var_3_5

		var_3_2(var_3_1, var_3_3, var_3_4)
	end

	return
end

function var_0_1.ConnectByDomain(arg_4_0, arg_4_1, arg_4_2)
	LuaHelper = var_1_10003

	local var_4_0 = var_1_10003.getHostByDomain(arg_4_1)

	DEFAULT_PORT = var_1_10004

	arg_4_0:Connect(var_4_0, var_1_10004, arg_4_2)

	return
end

function var_0_1.Reconnect(arg_5_0, arg_5_1)
	if not var_0_6 or not var_0_7 then
		warning = var_2

		var_2("Network is not connected.")

		return
	end

	if var_0_11 then
		warning = var_2

		var_2("connecting, please wait...")

		return
	end

	if var_0_8 and var_0_4 ~= nil then
		warning = var_2

		var_2("Network is connected.")

		return
	end

	var_0_12 = arg_5_1

	arg_5_0:stopHBTimer()

	local var_5_0 = var_0_5

	var_2.stopTimer(var_5_0)

	originalPrint = var_2

	var_2("reconnect --> " .. arg_5_0:GetLastHost() .. ":" .. arg_5_0:GetLastPort())
	arg_5_0:Connect(arg_5_0:GetLastHost(), arg_5_0:GetLastPort(), function()
		getProxy = var_2_10000
		UserProxy = var_2_10002

		local var_6_0 = var_2_10000(var_2_10002)
		local var_6_1 = var_0.getData(var_6_0)
		local var_6_2 = var_0.SdkMgr.GetInstance()

		if var_2.GetChannelUID(var_6_2) == "" then
			PLATFORM_LOCAL = var_2
		end

		if not var_6_1 or not var_6_1:isLogin() then
			if var_0_5.currentCS == 10020 then
				local var_6_3 = var_0_13

				DISCONNECT_TIME_OUT = var_6_2

				if var_6_3 ~= var_6_2 then
					arg_5_0.needStartSend = false

					local var_6_4 = var_0_5

					var_3.StartSend(var_6_4)

					goto label_6_0
				end
			end

			do
				local var_6_5 = var_0.m02
				local var_6_6 = var_3.sendNotification

				GAME = var_2_10006

				var_6_6(var_6_5, var_2_10006.LOGOUT, {
					code = 3
				})
			end

			::label_6_0::

			return
		end

		local var_6_7 = var_0_5
		local var_6_8 = var_3.Send
		local var_6_9 = 10022
		local var_6_10 = {
			platform = var_2,
			account_id = var_6_1.uid,
			server_ticket = var_6_1.token,
			serverid = var_6_1.server
		}

		HashUtil = var_8

		local var_6_11 = var_8.CalcMD5
		local var_6_12 = var_6_1.token

		AABBUDUD = var_2_10011
		var_6_10.check_key = var_6_11(var_6_12 .. var_2_10011)

		local var_6_13 = var_0.SdkMgr.GetInstance()

		var_6_10.device_id = var_8.GetDeviceId(var_6_13)

		var_6_8(var_6_7, var_6_9, var_6_10, 10023, function(arg_7_0)
			local var_7_0

			if arg_7_0.result == 0 then
				originalPrint = var_7_0

				var_7_0("reconnect success: " .. arg_7_0.user_id, " - ", arg_7_0.server_ticket)

				var_7_0 = var_6_1
				var_7_0.token = arg_7_0.server_ticket

				local var_7_1 = var_0

				var_7_0.setLastLogin(var_7_1, var_6_1)
				arg_5_1()

				local var_7_2 = var_0_5

				var_7_0.RemoveLoginPacket(var_7_2)

				var_7_0 = var_0_13
				DISCONNECT_TIME_OUT = var_2

				if var_7_0 ~= var_2 then
					var_7_2 = var_0_5

					if var_7_0.getPacketIdx(var_7_2) > 0 then
						var_7_0 = arg_5_0
						var_7_0.needStartSend = false
						var_7_2 = var_0_5

						var_7_0.Send(var_7_2, 11001, {
							timestamp = 1
						}, 11002, function(arg_8_0)
							local var_8_0 = var_0.TimeMgr.GetInstance()

							var_1.SetServerTime(var_8_0, arg_8_0.timestamp, arg_8_0.monday_0oclock_timestamp)

							local var_8_1 = var_0.m02
							local var_8_2 = var_1.sendNotification

							GAME = var_4

							var_8_2(var_8_1, var_4.CHANGE_CHAT_ROOM, 0)

							return
						end)

						nowWorld = var_7_0

						local var_7_3

						if var_7_0() then
							var_7_3 = var_7_0.type
							World = var_7_2

							if var_7_3 ~= var_7_2.TypeBase then
								WorldConst = var_7_3

								var_7_3.ReqWorldForServer()
							end
						end

						NewEducateHelper = var_7_3

						var_7_3.ReqDataForServer()

						goto label_7_0
					end
				end

				if arg_5_0.needStartSend then
					var_7_0 = arg_5_0
					var_7_0.needStartSend = false
					var_7_2 = var_0_5

					var_7_0.StartSend(var_7_2)
				end

				::label_7_0::

				var_0_13 = nil
				getProxy = var_7_0
				PlayerProxy = var_7_2

				if var_7_0(var_7_2) and var_7_0:getInited() then
					local var_7_4 = var_0.SecondaryPWDMgr.GetInstance()

					var_2.FetchData(var_7_4)
				end

				local var_7_5 = var_0.NewGuideMgr.GetInstance()

				var_2.Resume(var_7_5)

				local var_7_6 = var_0.m02
				local var_7_7 = var_2.sendNotification

				GAME = var_5

				var_7_7(var_7_6, var_5.ON_RECONNECTION)

				local var_7_8 = var_0.m02
				local var_7_9 = var_2.sendNotification

				GAME = var_5

				var_7_9(var_7_8, var_5.ON_APPLICATION_PAUSE, false)
			else
				originalPrint = var_7_0

				var_7_0("reconnect failed: " .. arg_7_0.result)

				local var_7_10 = var_0.m02
				local var_7_11 = var_1.sendNotification

				GAME = var_4

				var_7_11(var_7_10, var_4.LOGOUT, {
					code = 199,
					tip = arg_7_0.result
				})
			end

			return
		end, false, false)

		return
	end)

	return
end

function var_0_1.onDisconnected(arg_9_0, arg_9_1)
	originalPrint = var_1_10002

	local var_9_0 = "Network onDisconnected: "

	tostring = var_1_10005

	var_1_10002(var_9_0 .. var_1_10005(arg_9_0))

	var_0_13 = arg_9_1

	if var_0_4 then
		if not arg_9_0 then
			local var_9_1 = var_0_4.onDisconnected

			var_2.RemoveAllListeners(var_9_1)
		end

		local var_9_2 = var_0_4

		var_2.Dispose(var_9_2)

		var_0_4 = nil
	end

	if arg_9_0 then
		var_0_8 = false
	end

	if var_0_11 then
		local var_9_3 = var_0.UIMgr.GetInstance()

		var_2.LoadingOff(var_9_3)
	end

	var_0_11 = false

	return
end

function var_0_1.onData(arg_10_0)
	if var_0_9[arg_10_0.cmd] then
		local var_10_0 = var_0.Packer.GetInstance()
		local var_10_1 = var_1.Unpack(var_10_0, arg_10_0.cmd, arg_10_0:getLuaStringBuffer())

		ipairs = var_2

		for iter_10_0, iter_10_1 in var_2(var_0_9[arg_10_0.cmd]) do
			iter_10_1(var_10_1)
		end
	end

	return
end

function var_0_1.onError(arg_11_0)
	tostring = var_1_10001
	arg_11_0 = var_1_10001(arg_11_0)
	originalPrint = var_1

	var_1("Network Error: " .. arg_11_0)

	if var_0_4 then
		local var_11_0 = var_0_4

		var_1.Dispose(var_11_0)

		var_0_4 = nil
	end

	local function var_11_1()
		local var_12_0 = var_0.m02
		local var_12_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_12_2 = var_2_10003.LOGOUT
		local var_12_3 = {}
		local var_12_4

		if not var_0_1.erroCode then
			var_12_4 = 3
		end

		var_12_3.code = var_12_4

		var_12_1(var_12_0, var_12_2, var_12_3)

		return
	end

	local function var_11_2()
		return
	end

	if var_0_11 then
		var_0_11 = false
		var_11_2 = var_0_12
	end

	local var_11_3 = var_0.ConnectionMgr.GetInstance()

	var_3.CheckProxyCounter(var_11_3)

	if var_0_6 and var_0_7 then
		local var_11_4 = var_0.ConnectionMgr.GetInstance()

		var_3.stopHBTimer(var_11_4)

		table = var_3

		if var_3.contains({
			"NotSocket"
		}, arg_11_0) then
			local var_11_5 = var_0.ConnectionMgr.GetInstance()

			var_4.Reconnect(var_11_5, var_11_2)
		else
			local var_11_6 = var_0.MsgboxMgr.GetInstance()
			local var_11_7 = var_4.ShowMsgBox
			local var_11_8 = {
				modal = true
			}

			i18n = var_1_10008
			var_11_8.content = var_1_10008("reconnect_tip", arg_11_0)

			function var_11_8.onYes()
				local var_14_0 = var_0.ConnectionMgr.GetInstance()

				var_0.Reconnect(var_14_0, var_11_2)

				return
			end

			var_11_8.onNo = var_11_1

			var_11_7(var_11_6, var_11_8)

			local var_11_9 = var_0.NewStoryMgr.GetInstance()

			var_4.Stop(var_11_9)

			local var_11_10 = var_0.NewGuideMgr.GetInstance()

			var_4.Pause(var_11_10)
		end
	else
		local var_11_11 = var_0.ConnectionMgr.GetInstance()

		var_3.ConnectByProxy(var_11_11)
	end

	return
end

function var_0_1.Send(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
	local function var_15_0(arg_16_0)
		if arg_16_0.result == 14 then
			local var_16_0 = var_0.m02
			local var_16_1 = var_1.sendNotification

			GAME = var_2_10004

			var_16_1(var_16_0, var_2_10004.EXTRA_PROTO_RESULT, {
				result = arg_16_0.result
			})
		else
			arg_15_4(arg_16_0)
		end

		return
	end

	if not var_0_5 then
		warning = var_8

		var_8("sendWindow is nil. msgid " .. arg_15_1)

		return
	end

	local var_15_1 = var_0_5

	var_8.Queue(var_15_1, arg_15_1, arg_15_2, arg_15_3, var_15_0, arg_15_5, nil, arg_15_6)

	return
end

function var_0_1.setPacketIdx(arg_17_0, arg_17_1)
	local var_17_0 = var_0_5

	var_2.setPacketIdx(var_17_0, arg_17_1)

	return
end

function var_0_1.On(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0

	if var_0_9[arg_18_1] == nil then
		var_18_0 = var_0_9
		var_18_0[arg_18_1] = {}
	end

	table = var_18_0

	var_18_0.insert(var_0_9[arg_18_1], arg_18_2)

	return
end

function var_0_1.Off(arg_19_0, arg_19_1, arg_19_2)
	if var_0_9[arg_19_1] == nil then
		return
	end

	local var_19_0

	if arg_19_2 == nil then
		var_19_0 = var_0_9
		var_19_0[arg_19_1] = nil
	else
		ipairs = var_19_0

		for iter_19_0, iter_19_1 in var_19_0(var_0_9[arg_19_1]) do
			if iter_19_1 == arg_19_2 then
				table = var_1_10008

				var_1_10008.remove(var_0_9[arg_19_1], iter_19_0)

				break
			end
		end
	end

	return
end

function var_0_1.Disconnect(arg_20_0)
	arg_20_0:stopHBTimer()

	var_0_9 = {}
	originalPrint = var_1

	var_1("Manually Disconnect !!!")

	if var_0_4 then
		local var_20_0 = var_0_4

		var_1.Dispose(var_20_0)

		var_0_4 = nil
	end

	var_0_6 = nil
	var_0_7 = nil

	local var_20_1
	local var_20_2 = lastProxyHost
	local var_20_3
	local var_20_4 = lastProxyPort

	var_0_5 = nil
	var_0_8 = false

	return
end

function var_0_1.getConnection(arg_21_0)
	return var_0_4
end

function var_0_1.isConnecting(arg_22_0)
	return var_0_11
end

function var_0_1.isConnected(arg_23_0)
	return var_0_8
end

function var_0_1.stopHBTimer(arg_24_0)
	if var_0_10 then
		local var_24_0 = var_0_10

		var_1.Stop(var_24_0)

		var_0_10 = nil
	end

	return
end

function var_0_1.resetHBTimer(arg_25_0)
	arg_25_0:stopHBTimer()

	Timer = var_1

	local var_25_0 = var_1.New

	local function var_25_1()
		TimeUtil = var_2_10000
		var_0_15 = var_2_10000.GetSystemTime()

		local var_26_0 = arg_25_0

		var_0.Send(var_26_0, 10100, {
			need_request = 1
		}, 10101, function(arg_27_0)
			TimeUtil = var_3_10001

			local var_27_0 = var_3_10001.GetSystemTime() - var_0_15

			if var_0_16 == -1 then
				var_0_16 = var_27_0
			else
				var_0_16 = (var_27_0 + var_0_16) / 2
			end

			return
		end, false)

		return
	end

	HEART_BEAT_TIMEOUT = var_1_10004
	var_0_10 = var_25_0(var_25_1, var_1_10004, -1, true)

	local var_25_2 = var_0_10

	var_1.Start(var_25_2)

	return
end

function var_0_1.GetPingDelay(arg_28_0)
	return var_0_16
end

local var_0_18 = 0
local var_0_19 = 2
local var_0_20
local var_0_21

function var_0_1.SetProxyHost(arg_29_0, arg_29_1, arg_29_2)
	var_0_20 = arg_29_1
	var_0_21 = arg_29_2
	originalPrint = var_1_10003

	var_1_10003("Proxy host --> " .. var_0_20 .. ":" .. var_0_21)

	return
end

function var_0_1.GetLastHost(arg_30_0)
	VersionMgr = var_1_10001

	local var_30_0 = var_1_10001.Inst

	if var_1.OnProxyUsing(var_30_0) and var_0_20 ~= nil and var_0_20 ~= "" then
		return var_0_20
	end

	return var_0_6
end

function var_0_1.GetLastPort(arg_31_0)
	VersionMgr = var_1_10001

	local var_31_0 = var_1_10001.Inst

	if var_1.OnProxyUsing(var_31_0) and var_0_21 ~= nil and var_0_21 ~= 0 then
		return var_0_21
	end

	return var_0_7
end

function var_0_1.CheckProxyCounter(arg_32_0)
	var_0_18 = var_0_18 + 1
	originalPrint = var_1

	var_1("proxyCounter: " .. var_0_18)

	VersionMgr = var_1

	local var_32_0 = var_1.Inst

	if not var_1.OnProxyUsing(var_32_0) then
		if var_0_18 == var_0_19 then
			originalPrint = var_1

			var_1("switch proxy! reason: " .. var_0_19 .. " error limit")

			VersionMgr = var_1

			local var_32_1 = var_1.Inst

			var_1.SetUseProxy(var_32_1, true)
		end
	else
		VersionMgr = var_1

		local var_32_2 = var_1.Inst

		var_1.SetUseProxy(var_32_2, false)

		var_0_18 = 0
	end

	return
end

function var_0_1.SwitchProxy(arg_33_0)
	if var_0_14 then
		local var_33_0 = var_0_14

		if var_1.IsSpecialIP(var_33_0) then
			VersionMgr = var_1

			local var_33_1 = var_1.Inst

			if not var_1.OnProxyUsing(var_33_1) then
				originalPrint = var_1

				var_1("switch proxy! reason: tw specialIP send timeout")

				VersionMgr = var_1

				local var_33_2 = var_1.Inst

				var_1.SetUseProxy(var_33_2, true)
			else
				VersionMgr = var_1

				local var_33_3 = var_1.Inst

				var_1.SetUseProxy(var_33_3, false)
			end

			local var_33_4 = var_0_1.onDisconnected
			local var_33_5 = false

			DISCONNECT_TIME_OUT = var_1_10004

			var_33_4(var_33_5, var_1_10004)
		end
	end

	return
end

return
