pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
class = var_0_10001
var_0.SendWindow = var_0_10001("SendWindow")

local var_0_1 = var_0.SendWindow
local var_0_2

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.connectionMgr = arg_1_1
	defaultValue = var_1_10003
	arg_1_0.packetIdx = var_1_10003(arg_1_2, 0)
	arg_1_0.isSending = false
	arg_1_0.toSends = {}
	arg_1_0.retryCount = 0
	var_0_2 = {}

	return
end

function var_0_1.setPacketIdx(arg_2_0, arg_2_1)
	arg_2_0.packetIdx = arg_2_1

	return
end

function var_0_1.getPacketIdx(arg_3_0)
	return arg_3_0.packetIdx
end

function var_0_1.incPacketIdx(arg_4_0)
	arg_4_0.packetIdx = arg_4_0.packetIdx + 1

	return
end

function var_0_1.Queue(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
	table = var_1_10008

	var_1_10008.insert(arg_5_0.toSends, {
		arg_5_1,
		arg_5_2,
		arg_5_3,
		arg_5_4 and function(arg_6_0)
			table = var_2_10001

			var_2_10001.remove(arg_5_0.toSends, 1)
			arg_5_4(arg_6_0)

			if arg_6_0 and arg_6_0.result and arg_6_0.result == 0 or arg_5_3 == 20012 then
				local var_6_0 = var_0.SeriesGuideMgr.GetInstance()

				var_1.receiceProtocol(var_6_0, arg_5_3, arg_5_2, arg_6_0)
			end

			return
		end,
		arg_5_5,
		arg_5_6,
		arg_5_7
	})

	if arg_5_0.isSending then
		return
	end

	arg_5_0:StartSend()

	return
end

function var_0_1.RemoveLoginPacket(arg_7_0)
	if #arg_7_0.toSends > 0 and arg_7_0.toSends[1][1] == 10022 then
		table = var_1

		var_1.remove(arg_7_0.toSends, 1)
	end

	return
end

function var_0_1.StartSend(arg_8_0)
	local var_8_1

	if #arg_8_0.toSends > 0 then
		local var_8_0 = arg_8_0

		var_8_1 = arg_8_0.Send
		unpack = var_1_10004

		var_8_1(var_8_0, var_1_10004(arg_8_0.toSends[1]))
	else
		warning = var_8_1

		var_8_1("No more packets to send.")
	end

	return
end

function var_0_1.Send(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7)
	arg_9_0.isSending = true
	arg_9_0.currentCS = arg_9_1

	local var_9_0 = arg_9_0.connectionMgr

	if var_8.isConnecting(var_9_0) then
		arg_9_0.connectionMgr.needStartSend = true

		return
	end

	local var_9_1 = arg_9_0.connectionMgr

	if not var_8.getConnection(var_9_1) then
		var_1_10009 = arg_9_0.connectionMgr
		var_1_10009.needStartSend = true

		local var_9_2 = arg_9_0.connectionMgr

		var_1_10009.Reconnect(var_9_2, function()
			return
		end)

		return
	end

	defaultValue = var_1_10009
	arg_9_5 = var_1_10009(arg_9_5, true)
	defaultValue = var_9
	arg_9_6 = var_9(arg_9_6, true)
	defaultValue = var_9

	local var_9_3 = arg_9_7

	SEND_TIMEOUT = var_12
	arg_9_7 = var_9(var_9_3, var_12)

	local var_9_4 = arg_9_0:getPacketIdx()

	if arg_9_3 ~= nil then
		local var_9_5 = var_0.UIMgr.GetInstance()

		var_10.LoadingOn(var_9_5)

		local var_9_6

		if arg_9_5 then
			var_9_6 = arg_9_3 .. "_" .. var_9_4
		else
			var_9_6 = arg_9_3
		end

		local var_9_7 = var_0_2

		var_9_7[var_9_6] = function(arg_11_0)
			arg_9_0.isSending = false

			local var_11_0 = var_0.UIMgr.GetInstance()

			var_1.LoadingOff(var_11_0)

			local var_11_1 = arg_9_0.connectionMgr

			var_1.resetHBTimer(var_11_1)

			if arg_9_0.timer then
				local var_11_2 = arg_9_0.timer

				var_1.Stop(var_11_2)

				arg_9_0.timer = nil
			end

			arg_9_4(arg_11_0)

			if arg_9_6 and not arg_9_0.isSending and #arg_9_0.toSends > 0 then
				local var_11_3 = arg_9_0

				var_1.StartSend(var_11_3)
			end

			return
		end
		Timer = var_9_7
		arg_9_0.timer = var_9_7.New(function()
			local var_12_0 = var_0.UIMgr.GetInstance()

			var_0.LoadingOff(var_12_0)

			var_0_2[var_9_6] = nil

			local var_12_1 = arg_9_0

			var_0.setPacketIdx(var_12_1, var_9_4)

			local var_12_2 = arg_9_0.retryCount

			if 3 < var_12_2 then
				var_12_2 = arg_9_0.connectionMgr.onDisconnected

				local var_12_3 = false

				DISCONNECT_TIME_OUT = var_3

				var_12_2(var_12_3, var_3)

				var_12_2 = arg_9_0
				var_12_2.retryCount = 0
			end

			PLATFORM_CODE = var_12_2
			PLATFORM_CHT = var_1

			if var_12_2 == var_1 then
				arg_9_0.connectionMgr.SwitchProxy()
			end

			warning = var_12_2

			var_12_2("Network is timedOut, resend: " .. var_9_4 .. ", protocal: " .. arg_9_1)

			arg_9_0.retryCount = arg_9_0.retryCount + 1

			local var_12_4 = arg_9_0

			var_0.StartSend(var_12_4)

			return
		end, arg_9_7, 1)

		local var_9_8 = arg_9_0.timer

		var_11.Start(var_9_8)
	else
		arg_9_5 = false
	end

	local var_9_9 = var_0.Packer.GetInstance()
	local var_9_10 = var_10.GetProtocolWithName(var_9_9, "cs_" .. arg_9_1)

	local function var_9_11(arg_13_0, arg_13_1)
		pairs = var_2_10002

		for iter_13_0, iter_13_1 in var_2_10002(arg_13_1) do
			type = var_2_10007

			if var_2_10007(iter_13_1) == "table" then
				if arg_13_0[iter_13_0].add then
					ipairs = var_2_10007

					for iter_13_2, iter_13_3 in var_2_10007(iter_13_1) do
						local var_13_0 = var_9_11
						local var_13_1 = arg_13_0[iter_13_0]

						var_13_0(var_14.add(var_13_1), iter_13_3)
					end
				elseif arg_13_0[iter_13_0].append then
					ipairs = var_2_10007

					for iter_13_4, iter_13_5 in var_2_10007(iter_13_1) do
						local var_13_2 = arg_13_0[iter_13_0]

						var_12.append(var_13_2, iter_13_5)
					end
				else
					var_9_11(arg_13_0[iter_13_0], iter_13_1)
				end
			else
				arg_13_0[iter_13_0] = iter_13_1
			end
		end

		return
	end

	local var_9_12 = var_9_10:GetMessage()

	var_9_11(var_9_12, arg_9_2)

	local var_9_14

	if arg_9_5 then
		local var_9_13 = var_8

		var_9_14 = var_8.Send

		local var_9_15 = var_0.Packer.GetInstance()

		var_9_14(var_9_13, var_16.Pack(var_9_15, var_9_4, var_9_10:GetId(), var_9_12))

		originalPrint = var_9_14

		var_9_14("Network sent protocol: " .. arg_9_1 .. " with idx: " .. var_9_4)
		arg_9_0:incPacketIdx()
	else
		local var_9_16 = var_8

		var_9_14 = var_8.Send

		local var_9_17 = var_0.Packer.GetInstance()

		var_9_14(var_9_16, var_16.Pack(var_9_17, 0, var_9_10:GetId(), var_9_12))

		if arg_9_1 ~= 21211 then
			originalPrint = var_9_14

			var_9_14("Network sent protocol: " .. arg_9_1 .. " without idx")
		end
	end

	if not arg_9_3 then
		table = var_9_14

		var_9_14.remove(arg_9_0.toSends, 1)

		if #arg_9_0.toSends > 0 then
			arg_9_0:StartSend()
		else
			arg_9_0.isSending = false
		end
	end

	return
end

function var_0_1.stopTimer(arg_14_0)
	if arg_14_0.timer then
		local var_14_0 = arg_14_0.timer

		var_1.Stop(var_14_0)

		arg_14_0.timer = nil
	end

	return
end

function var_0_1.onData(arg_15_0)
	if arg_15_0.cmd ~= 21212 then
		originalPrint = var_1

		var_1("Network Receive idx: " .. arg_15_0.idx .. " cmd: " .. arg_15_0.cmd)
	end

	local var_15_0 = var_0.Packer.GetInstance()
	local var_15_1 = var_1.Unpack(var_15_0, arg_15_0.cmd, arg_15_0:getLuaStringBuffer())
	local var_15_2 = arg_15_0.cmd .. "_" .. arg_15_0.idx

	if var_0_2[var_15_2] then
		local var_15_3 = var_0_2[var_15_2]

		var_0_2[var_15_2] = nil

		var_15_3(var_15_1)
	elseif var_0_2[arg_15_0.cmd] then
		local var_15_4 = var_0_2[arg_15_0.cmd]

		var_0_2[arg_15_0.cmd] = nil

		var_15_4(var_15_1)
	end

	return
end

return
