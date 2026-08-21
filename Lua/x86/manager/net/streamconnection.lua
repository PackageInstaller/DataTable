local var_0_0 = class("StreamConnection")
local var_0_1 = false

local function var_0_2(...)
	if var_0_1 then
		print(...)
	end
end

local var_0_3 = {
	CONNECTED = "connected",
	DISCONNECTED = "disconnected",
	CONNECTING = "connecting",
	NONE = "none"
}
local var_0_4 = 20
local var_0_5 = 5
local var_0_6 = 10
local var_0_7 = 90
local var_0_8 = 5
local var_0_9 = 10

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.connectType_ = arg_2_1

	arg_2_0:Reset()
end

function var_0_0.Reset(arg_3_0)
	arg_3_0.netStatus = var_0_3.NONE
	arg_3_0.reconnectTryTime_ = 0
	arg_3_0.errorHandlingTime_ = 0
	arg_3_0.packetList_ = {}
	arg_3_0.sendingPacketCount = {}
	arg_3_0.connection_ = nil
	arg_3_0.notifies_ = arg_3_0.notifies_ or {}
	arg_3_0.idx_ = 1
	arg_3_0.serverIdx_ = 0
	arg_3_0.syncSendQueue_ = {}
	arg_3_0.syncSendNoQueueTmp_ = {}
	arg_3_0.forceReconnet = false
	arg_3_0.waitCallbacks_ = {}
	arg_3_0.OnConnectedHandler_ = handler(arg_3_0, arg_3_0.OnConnectedHandler)
	arg_3_0.OnDisconnectedHandler_ = handler(arg_3_0, arg_3_0.OnDisconnectedHandler)
	arg_3_0.OnReceiveHandler_ = handler(arg_3_0, arg_3_0.OnReceiveHandler)
	arg_3_0.OnSocketError_ = handler(arg_3_0, arg_3_0.OnSocketError)
	arg_3_0.isPauseSendPacket_ = false

	print("===============================connection reset=========================================")
end

function var_0_0.Connect(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0.netStatus ~= var_0_3.CONNECTING and arg_4_0.netStatus ~= var_0_3.CONNECTED then
		arg_4_0.netStatus = var_0_3.CONNECTING
		arg_4_0.peerAddr_ = arg_4_1
		arg_4_0.peerPort_ = arg_4_2
		arg_4_0.onConnectExternal_ = arg_4_3
		arg_4_0.connection_ = YSTcpConnection.New(arg_4_0.peerAddr_, arg_4_0.peerPort_)

		arg_4_0.connection_.onConnected:AddListener(arg_4_0.OnConnectedHandler_)
		arg_4_0.connection_.onDisconnected:AddListener(arg_4_0.OnDisconnectedHandler_)
		arg_4_0.connection_:Connect()

		if arg_4_0.frameTimer_ then
			arg_4_0.frameTimer_:Stop()

			arg_4_0.frameTimer_ = nil
		end

		local var_4_0 = 0

		arg_4_0.frameTimer_ = FrameTimer.New(function()
			if arg_4_0.netStatus == var_0_3.CONNECTED or arg_4_0.netStatus == var_0_3.CONNECTING then
				arg_4_0.connection_:AsyncUpdate()
			end

			arg_4_0:AddCallBackTime()

			var_4_0 = var_4_0 + 1

			if var_4_0 > var_0_7 then
				arg_4_0:AutoReconnect()

				var_4_0 = 0
			end
		end, 1, -1)

		arg_4_0.frameTimer_:Start()
	end
end

function var_0_0.OnConnectedHandler(arg_6_0, arg_6_1)
	if arg_6_1 == SocketError.Success then
		arg_6_0.netStatus = var_0_3.CONNECTED

		print("<color=#00ff00>TCP</color> Network connected")
		arg_6_0.connection_.onData:AddListener(arg_6_0.OnReceiveHandler_)
		arg_6_0.connection_.onError:AddListener(arg_6_0.OnSocketError_)

		arg_6_0.reconnectTryTime_ = 0
		arg_6_0.errorHandlingTime_ = 0

		arg_6_0:StartHeartBeat()
	else
		print("<color=#ff0000>TCP</color> Network connect fail", tostring(arg_6_1))

		arg_6_0.netStatus = var_0_3.DISCONNECTED
	end

	if arg_6_0.onConnectExternal_ then
		arg_6_0.onConnectExternal_(arg_6_1)
	end

	arg_6_0.onConnectExternal_ = nil

	arg_6_0:SendNoQueuePacket()
end

function var_0_0.StartHeartBeat(arg_7_0)
	if arg_7_0.heartBeatTimer_ == nil and arg_7_0.netStatus == var_0_3.CONNECTED then
		arg_7_0.heartBeatTimer_ = Timer.New(function()
			arg_7_0:SendAsync(10050, {
				need_request = 1
			})
		end, var_0_6, -1)

		arg_7_0.heartBeatTimer_:Start()
	end
end

function var_0_0.StopHeartBeat(arg_9_0)
	if arg_9_0.heartBeatTimer_ then
		arg_9_0.heartBeatTimer_:Stop()

		arg_9_0.heartBeatTimer_ = nil
	end
end

function var_0_0.AddCallBackTime(arg_10_0)
	local var_10_0 = false

	for iter_10_0, iter_10_1 in pairs(arg_10_0.waitCallbacks_) do
		iter_10_1.waitTime = iter_10_1.waitTime + Time.deltaTime

		if iter_10_1.waitTime > var_0_4 then
			var_10_0 = true
		end
	end

	if var_10_0 and arg_10_0.timeOutFunc_ ~= nil then
		arg_10_0.timeOutFunc_(arg_10_0, arg_10_0.connectType_)
	end
end

function var_0_0.GetIsNeedShowQuanQuan(arg_11_0)
	if arg_11_0.reconnectTryTime_ > var_0_5 then
		return false
	end

	return arg_11_0.netStatus == var_0_3.CONNECTING or table.nums(arg_11_0.waitCallbacks_) > 0 or #arg_11_0.syncSendQueue_ > 0
end

function var_0_0.GetSendingPacketNum(arg_12_0)
	return table.nums(arg_12_0.packetList_)
end

function var_0_0.CheckConnectStatus(arg_13_0)
	if arg_13_0.netStatus == var_0_3.DISCONNECTED then
		arg_13_0.reconnectTryTime_ = 0

		arg_13_0:AutoReconnect()
	end
end

function var_0_0.Disconnect(arg_14_0)
	arg_14_0.syncSendQueue_ = {}
	arg_14_0.waitCallbacks_ = {}
	arg_14_0.syncSendNoQueueTmp_ = {}
	arg_14_0.packetList_ = {}
	arg_14_0.sendingPacketCount = {}

	if arg_14_0.connection_ then
		arg_14_0.connection_:Disconnect()
	end
end

function var_0_0.OnDisconnectedHandler(arg_15_0, arg_15_1)
	if arg_15_0.netStatus == var_0_3.DISCONNECTED or arg_15_0.netStatus == var_0_3.NONE then
		return
	end

	arg_15_0.netStatus = var_0_3.DISCONNECTED

	if arg_15_0.frameTimer_ then
		arg_15_0.frameTimer_:Stop()

		arg_15_0.frameTimer_ = nil
	end

	arg_15_0:StopHeartBeat()

	if arg_15_0.waitCallbacks_ then
		if arg_15_1 and table.nums(arg_15_0.waitCallbacks_) > 0 and arg_15_0.errorHandlingFunc_ then
			arg_15_0.errorHandlingFunc_(arg_15_0, arg_15_0.connectType_, 0, arg_15_1)
		end

		arg_15_0.waitCallbacks_ = {}
	end

	arg_15_0.connection_:Dispose()
	print("<color=#ff0000>TCP</color> Network disconnect by peer")
end

function var_0_0.RegistReconnectFunc(arg_16_0, arg_16_1)
	arg_16_0.reconnectFunc_ = arg_16_1
end

function var_0_0.RegistTimeOutFunc(arg_17_0, arg_17_1)
	arg_17_0.timeOutFunc_ = arg_17_1
end

function var_0_0.RegistErrorHandlingFunc(arg_18_0, arg_18_1)
	arg_18_0.errorHandlingFunc_ = arg_18_1
end

function var_0_0.ResetReconnectTime(arg_19_0)
	arg_19_0.reconnectTryTime_ = 0
end

function var_0_0.AutoReconnect(arg_20_0)
	if arg_20_0.netStatus == var_0_3.DISCONNECTED and (arg_20_0.forceReconnet or #arg_20_0.syncSendQueue_ > 0 or table.nums(arg_20_0.waitCallbacks_) > 0 or #arg_20_0.syncSendNoQueueTmp_ > 0) then
		arg_20_0.forceReconnet = false

		if arg_20_0.reconnectTryTime_ < var_0_5 then
			arg_20_0.reconnectTryTime_ = arg_20_0.reconnectTryTime_ + 1

			if arg_20_0.reconnectFunc_ then
				arg_20_0.reconnectFunc_()
			else
				Debug.LogError("检查B")
				arg_20_0:Reconnect()
			end
		elseif arg_20_0.reconnectTryTime_ == var_0_5 then
			arg_20_0.reconnectTryTime_ = arg_20_0.reconnectTryTime_ + 1

			if arg_20_0.errorHandlingFunc_ then
				arg_20_0.errorHandlingTime_ = arg_20_0.errorHandlingTime_ + 1

				arg_20_0.errorHandlingFunc_(arg_20_0, arg_20_0.connectType_, arg_20_0.errorHandlingTime_)
			end
		end
	end
end

function var_0_0.Reconnect(arg_21_0, arg_21_1)
	print("===================reconnect=========================")

	if arg_21_0.netStatus == var_0_3.DISCONNECTED then
		arg_21_0:Connect(arg_21_0.peerAddr_, arg_21_0.peerPort_, arg_21_1)
	else
		print("reconnect faile: status: " + arg_21_0.netStatus)
	end
end

function var_0_0.ForceReconnect(arg_22_0)
	arg_22_0.forceReconnet = true

	arg_22_0:CheckConnectStatus()
end

function var_0_0.ResetForceReconnect(arg_23_0)
	arg_23_0.forceReconnet = false
end

function var_0_0.OnReceiveHandler(arg_24_0, arg_24_1)
	if arg_24_1.Cmd ~= 10051 then
		print(string.format("Network received protocol %d, %d, currentIndex %d", arg_24_1.Cmd, arg_24_1.Index, arg_24_0.serverIdx_), arg_24_1.ServerIndex)
	end

	local var_24_0 = arg_24_1.Cmd

	arg_24_0.packetList_[var_24_0] = nil
	arg_24_0.sendingPacketCount[var_24_0] = 0

	local var_24_1 = Protocol.Unpack(var_24_0, arg_24_1:getLuaStringBuffer())

	var_0_0.CollectMsgPacket(true, var_24_0, var_24_1)

	if arg_24_1.ServerIndex > 0 then
		arg_24_0.serverIdx_ = arg_24_1.ServerIndex
	end

	if arg_24_0.notifies_[var_24_0] then
		for iter_24_0, iter_24_1 in ipairs(arg_24_0.notifies_[var_24_0]) do
			var_0_2("notify", var_24_0, iter_24_1)
			iter_24_1(var_24_1)
		end
	end

	local var_24_2 = var_24_0 .. "_" .. arg_24_1.Index
	local var_24_3 = arg_24_0.waitCallbacks_

	if var_24_3[var_24_2] then
		var_0_2("sync notify", var_24_2)

		if var_24_3[var_24_2].callback then
			var_24_3[var_24_2].callback(var_24_1, var_24_3[var_24_2].data)
		end

		arg_24_0.lastDelayTime_ = var_24_3[var_24_2].waitTime
		var_24_3[var_24_2] = nil
	elseif var_24_3[var_24_0] then
		var_0_2("sync notify", var_24_0)

		if var_24_3[var_24_0].callback then
			var_24_3[var_24_0].callback(var_24_1, var_24_3[var_24_0].data)
		end

		arg_24_0.lastDelayTime_ = var_24_3[var_24_0].waitTime
		var_24_3[var_24_0] = nil
	else
		var_0_2("can not find callback function!!!!", var_24_0, var_24_2)
	end
end

function var_0_0.OnSocketError(arg_25_0, arg_25_1)
	print("<color=#ff0000>TCP</color> Network error: " .. tostring(arg_25_1))

	if arg_25_0.errorHandlingFunc_ then
		arg_25_0.errorHandlingFunc_(arg_25_0, arg_25_0.connectType_, arg_25_0.errorHandlingTime_, tostring(arg_25_1))
	end

	arg_25_0:OnDisconnectedHandler()
end

function var_0_0.SendSyncImplOneByOne(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6, arg_26_7)
	if arg_26_0.packetList_[arg_26_3] then
		print("正在发送中.... 丢弃！！！！！！！！！", arg_26_1)

		arg_26_0.sendingPacketCount[arg_26_3] = (arg_26_0.sendingPacketCount[arg_26_3] or 0) + 1

		if arg_26_0.sendingPacketCount[arg_26_3] > var_0_8 or #arg_26_0.syncSendQueue_ > var_0_9 then
			print("堆积过多的包，进行重连操作", arg_26_1)

			if arg_26_0.timeOutFunc_ ~= nil then
				arg_26_0.timeOutFunc_(arg_26_0, arg_26_0.connectType_)
			end
		end

		return
	end

	arg_26_0.packetList_[arg_26_3] = true

	arg_26_0:EnQueuePacket(arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6, arg_26_7)

	if arg_26_0.netStatus == var_0_3.CONNECTED then
		arg_26_0:StartSendPacket()
	else
		arg_26_0:CheckConnectStatus()
	end
end

function var_0_0.SendSyncNoEnqueueImpl(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6, arg_27_7)
	if arg_27_0.netStatus == var_0_3.CONNECTED then
		arg_27_0:SendSyncImpl(arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6, arg_27_7)
	else
		table.insert(arg_27_0.syncSendNoQueueTmp_, {
			arg_27_1,
			arg_27_2,
			arg_27_3,
			arg_27_4,
			arg_27_5,
			arg_27_6,
			arg_27_7
		})
		arg_27_0:CheckConnectStatus()
	end
end

function var_0_0.SendSyncImpl(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5, arg_28_6, arg_28_7)
	var_0_2("SendSync", arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5, arg_28_6, arg_28_7)

	local var_28_0

	if arg_28_5 then
		var_28_0 = arg_28_3 .. "_" .. arg_28_0.idx_
	else
		var_28_0 = arg_28_3
	end

	arg_28_0.waitCallbacks_[var_28_0] = {
		waitTime = 0,
		callback = arg_28_4,
		data = arg_28_2
	}

	if arg_28_5 then
		arg_28_0:SendBuildProtocol(arg_28_0.idx_, arg_28_0.serverIdx_, arg_28_1, arg_28_2)

		arg_28_0.idx_ = arg_28_0.idx_ + 1
	else
		arg_28_0:SendBuildProtocol(0, arg_28_0.serverIdx_, arg_28_1, arg_28_2)
	end
end

function var_0_0.CollectMsgPacket(arg_29_0, arg_29_1, arg_29_2)
	return
end

function var_0_0.SendBuildProtocol(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5)
	if arg_30_3 == 10050 and _G.PrintAllOpen_ then
		-- block empty
	end

	local var_30_0 = Protocol.GetProtocolWithName("cs_" .. arg_30_3)
	local var_30_1 = var_30_0:GetMessage()

	Protocol.BuildProtocolMessage(var_30_1, arg_30_4)

	if arg_30_3 ~= 10050 or _G.PrintAllOpen_ then
		print("index", arg_30_1, arg_30_2, arg_30_3, arg_30_0.connectType_)
	end

	if arg_30_0.connection_ then
		arg_30_0.connection_:Send(Protocol.Pack(arg_30_1, arg_30_2, var_30_0:GetId(), var_30_1, arg_30_5))
	end

	var_0_0.CollectMsgPacket(false, var_30_0:GetId(), arg_30_4)
end

function var_0_0.EnQueuePacket(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5, arg_31_6, arg_31_7)
	table.insert(arg_31_0.syncSendQueue_, {
		arg_31_1,
		arg_31_2,
		arg_31_3,
		arg_31_4,
		arg_31_5,
		arg_31_6,
		arg_31_7
	})
end

function var_0_0.OnSendComplete(arg_32_0)
	local var_32_0 = table.remove(arg_32_0.syncSendQueue_, 1)

	arg_32_0:StartSendPacket()
end

function var_0_0.StartSendPacket(arg_33_0)
	if #arg_33_0.syncSendQueue_ > 0 and not arg_33_0.isPauseSendPacket_ then
		arg_33_0:SendSyncImpl(unpack(arg_33_0.syncSendQueue_[1]))
		arg_33_0:OnSendComplete()
	end
end

function var_0_0.SendNoQueuePacket(arg_34_0)
	for iter_34_0 = 1, #arg_34_0.syncSendNoQueueTmp_ do
		arg_34_0:SendSyncImpl(unpack(arg_34_0.syncSendNoQueueTmp_[iter_34_0]))
	end

	arg_34_0.syncSendNoQueueTmp_ = {}
end

function var_0_0.SetIsPauseSendPacket(arg_35_0, arg_35_1)
	arg_35_0.isPauseSendPacket_ = arg_35_1

	if not arg_35_1 then
		arg_35_0:StartSendPacket()
	end
end

function var_0_0.SendAsync(arg_36_0, ...)
	if arg_36_0.netStatus == var_0_3.CONNECTED then
		arg_36_0:SendBuildProtocol(0, arg_36_0.serverIdx_, ...)
	end
end

function var_0_0.SendSync(arg_37_0, ...)
	arg_37_0:SendSyncImplOneByOne(...)
end

function var_0_0.SendSyncNoEnqueue(arg_38_0, ...)
	arg_38_0:SendSyncNoEnqueueImpl(...)
end

function var_0_0.RegistPushWaiting(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0.waitCallbacks_[arg_39_1] = {
		waitTime = 0,
		callback = arg_39_2
	}

	arg_39_0:CheckConnectStatus()
end

function var_0_0.Bind(arg_40_0, arg_40_1, arg_40_2)
	if not arg_40_0.notifies_[arg_40_1] then
		arg_40_0.notifies_[arg_40_1] = {}
	end

	if not table.indexof(arg_40_0.notifies_[arg_40_1], arg_40_2) then
		var_0_2("Bind", arg_40_1, arg_40_2)
		table.insert(arg_40_0.notifies_[arg_40_1], arg_40_2)
	else
		print("sc_" .. arg_40_1 .. " StreamConnection:Bind twice.")
	end
end

function var_0_0.UnBind(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_0.notifies_[arg_41_1] then
		if arg_41_2 == nil then
			var_0_2("UnBind", arg_41_1, "all")

			arg_41_0.notifies_[arg_41_1] = nil
		else
			local var_41_0 = arg_41_0.notifies_[arg_41_1]

			for iter_41_0 = #var_41_0, 1 do
				if var_41_0[iter_41_0] == arg_41_2 then
					var_0_2("UnBind", arg_41_1, arg_41_2)
					table.remove(var_41_0, iter_41_0)

					break
				end
			end
		end
	end
end

function var_0_0.GetDelayTime(arg_42_0)
	return arg_42_0.lastDelayTime_ or 0
end

function var_0_0.GetMachineState(arg_43_0)
	return arg_43_0.netStatus
end

function var_0_0.GetConnectHostAndPort(arg_44_0)
	return arg_44_0.peerAddr_, arg_44_0.peerPort_
end

return var_0_0
