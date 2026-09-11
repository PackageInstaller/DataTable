local StreamConnection = class("StreamConnection")
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

function StreamConnection:Ctor(arg_2_1)
	self.connectType_ = arg_2_1

	self:Reset()
end

function StreamConnection:Reset()
	self.netStatus = var_0_3.NONE
	self.reconnectTryTime_ = 0
	self.errorHandlingTime_ = 0
	self.packetList_ = {}
	self.sendingPacketCount = {}
	self.connection_ = nil
	self.notifies_ = self.notifies_ or {}
	self.idx_ = 1
	self.serverIdx_ = 0
	self.syncSendQueue_ = {}
	self.syncSendNoQueueTmp_ = {}
	self.forceReconnet = false
	self.waitCallbacks_ = {}
	self.OnConnectedHandler_ = handler(self, self.OnConnectedHandler)
	self.OnDisconnectedHandler_ = handler(self, self.OnDisconnectedHandler)
	self.OnReceiveHandler_ = handler(self, self.OnReceiveHandler)
	self.OnSocketError_ = handler(self, self.OnSocketError)
	self.isPauseSendPacket_ = false

	print("===============================connection reset=========================================")
end

function StreamConnection:Connect(arg_4_1, arg_4_2, arg_4_3)
	if self.netStatus ~= var_0_3.CONNECTING and self.netStatus ~= var_0_3.CONNECTED then
		self.netStatus = var_0_3.CONNECTING
		self.peerAddr_ = arg_4_1
		self.peerPort_ = arg_4_2
		self.onConnectExternal_ = arg_4_3
		self.connection_ = YSTcpConnection.New(self.peerAddr_, self.peerPort_)

		self.connection_.onConnected:AddListener(self.OnConnectedHandler_)
		self.connection_.onDisconnected:AddListener(self.OnDisconnectedHandler_)
		self.connection_:Connect()

		if self.frameTimer_ then
			self.frameTimer_:Stop()

			self.frameTimer_ = nil
		end

		local var_4_0 = 0

		self.frameTimer_ = FrameTimer.New(function()
			if self.netStatus == var_0_3.CONNECTED or self.netStatus == var_0_3.CONNECTING then
				self.connection_:AsyncUpdate()
			end

			self:AddCallBackTime()

			var_4_0 = var_4_0 + 1

			if var_4_0 > var_0_7 then
				self:AutoReconnect()

				var_4_0 = 0
			end
		end, 1, -1)

		self.frameTimer_:Start()
	end
end

function StreamConnection:OnConnectedHandler(arg_6_1)
	if arg_6_1 == SocketError.Success then
		self.netStatus = var_0_3.CONNECTED

		print("<color=#00ff00>TCP</color> Network connected")
		self.connection_.onData:AddListener(self.OnReceiveHandler_)
		self.connection_.onError:AddListener(self.OnSocketError_)

		self.reconnectTryTime_ = 0
		self.errorHandlingTime_ = 0

		self:StartHeartBeat()
	else
		print("<color=#ff0000>TCP</color> Network connect fail", tostring(arg_6_1))

		self.netStatus = var_0_3.DISCONNECTED
	end

	if self.onConnectExternal_ then
		self.onConnectExternal_(arg_6_1)
	end

	self.onConnectExternal_ = nil

	self:SendNoQueuePacket()
end

function StreamConnection:StartHeartBeat()
	if self.heartBeatTimer_ == nil and self.netStatus == var_0_3.CONNECTED then
		self.heartBeatTimer_ = Timer.New(function()
			self:SendAsync(10050, {
				need_request = 1
			})
		end, var_0_6, -1)

		self.heartBeatTimer_:Start()
	end
end

function StreamConnection:StopHeartBeat()
	if self.heartBeatTimer_ then
		self.heartBeatTimer_:Stop()

		self.heartBeatTimer_ = nil
	end
end

function StreamConnection:AddCallBackTime()
	local var_10_0 = false

	for iter_10_0, iter_10_1 in pairs(self.waitCallbacks_) do
		iter_10_1.waitTime = iter_10_1.waitTime + Time.deltaTime

		if iter_10_1.waitTime > var_0_4 then
			var_10_0 = true
		end
	end

	if var_10_0 and self.timeOutFunc_ ~= nil then
		self:timeOutFunc_(self.connectType_)
	end
end

function StreamConnection:GetIsNeedShowQuanQuan()
	if self.reconnectTryTime_ > var_0_5 then
		return false
	end

	return self.netStatus == var_0_3.CONNECTING or table.nums(self.waitCallbacks_) > 0 or #self.syncSendQueue_ > 0
end

function StreamConnection:GetSendingPacketNum()
	return table.nums(self.packetList_)
end

function StreamConnection:CheckConnectStatus()
	if self.netStatus == var_0_3.DISCONNECTED then
		self.reconnectTryTime_ = 0

		self:AutoReconnect()
	end
end

function StreamConnection:Disconnect()
	self.syncSendQueue_ = {}
	self.waitCallbacks_ = {}
	self.syncSendNoQueueTmp_ = {}
	self.packetList_ = {}
	self.sendingPacketCount = {}

	if self.connection_ then
		self.connection_:Disconnect()
	end
end

function StreamConnection:OnDisconnectedHandler(arg_15_1)
	if self.netStatus == var_0_3.DISCONNECTED or self.netStatus == var_0_3.NONE then
		return
	end

	self.netStatus = var_0_3.DISCONNECTED

	if self.frameTimer_ then
		self.frameTimer_:Stop()

		self.frameTimer_ = nil
	end

	self:StopHeartBeat()

	if self.waitCallbacks_ then
		if arg_15_1 and table.nums(self.waitCallbacks_) > 0 and self.errorHandlingFunc_ then
			self:errorHandlingFunc_(self.connectType_, 0, arg_15_1)
		end

		self.waitCallbacks_ = {}
	end

	self.connection_:Dispose()
	print("<color=#ff0000>TCP</color> Network disconnect by peer")
end

function StreamConnection:RegistReconnectFunc(arg_16_1)
	self.reconnectFunc_ = arg_16_1
end

function StreamConnection:RegistTimeOutFunc(arg_17_1)
	self.timeOutFunc_ = arg_17_1
end

function StreamConnection:RegistErrorHandlingFunc(arg_18_1)
	self.errorHandlingFunc_ = arg_18_1
end

function StreamConnection:ResetReconnectTime()
	self.reconnectTryTime_ = 0
end

function StreamConnection:AutoReconnect()
	if self.netStatus == var_0_3.DISCONNECTED and (self.forceReconnet or #self.syncSendQueue_ > 0 or table.nums(self.waitCallbacks_) > 0 or #self.syncSendNoQueueTmp_ > 0) then
		self.forceReconnet = false

		if self.reconnectTryTime_ < var_0_5 then
			self.reconnectTryTime_ = self.reconnectTryTime_ + 1

			if self.reconnectFunc_ then
				self.reconnectFunc_()
			else
				Debug.LogError("检查B")
				self:Reconnect()
			end
		elseif self.reconnectTryTime_ == var_0_5 then
			self.reconnectTryTime_ = self.reconnectTryTime_ + 1

			if self.errorHandlingFunc_ then
				self.errorHandlingTime_ = self.errorHandlingTime_ + 1

				self:errorHandlingFunc_(self.connectType_, self.errorHandlingTime_)
			end
		end
	end
end

function StreamConnection:Reconnect(arg_21_1)
	print("===================reconnect=========================")

	if self.netStatus == var_0_3.DISCONNECTED then
		self:Connect(self.peerAddr_, self.peerPort_, arg_21_1)
	else
		print("reconnect faile: status: " + self.netStatus)
	end
end

function StreamConnection:ForceReconnect()
	self.forceReconnet = true

	self:CheckConnectStatus()
end

function StreamConnection:ResetForceReconnect()
	self.forceReconnet = false
end

function StreamConnection:OnReceiveHandler(arg_24_1)
	if arg_24_1.Cmd ~= 10051 then
		print(string.format("Network received protocol %d, %d, currentIndex %d", arg_24_1.Cmd, arg_24_1.Index, self.serverIdx_), arg_24_1.ServerIndex)
	end

	local var_24_0 = arg_24_1.Cmd

	self.packetList_[arg_24_1.Cmd] = nil
	self.sendingPacketCount[var_24_0] = 0

	local var_24_1 = Protocol.Unpack(var_24_0, arg_24_1:getLuaStringBuffer())

	StreamConnection.CollectMsgPacket(true, var_24_0, var_24_1)

	if arg_24_1.ServerIndex > 0 then
		self.serverIdx_ = arg_24_1.ServerIndex
	end

	if self.notifies_[var_24_0] then
		for iter_24_0, iter_24_1 in ipairs(self.notifies_[var_24_0]) do
			var_0_2("notify", var_24_0, iter_24_1)
			iter_24_1(var_24_1)
		end
	end

	local var_24_2 = var_24_0 .. "_" .. arg_24_1.Index

	if self.waitCallbacks_[var_24_0 .. "_" .. arg_24_1.Index] then
		var_0_2("sync notify", var_24_2)

		if self.waitCallbacks_[var_24_2].callback then
			self.waitCallbacks_[var_24_2].callback(var_24_1, self.waitCallbacks_[var_24_2].data)
		end

		self.lastDelayTime_ = self.waitCallbacks_[var_24_2].waitTime
		self.waitCallbacks_[var_24_2] = nil
	elseif self.waitCallbacks_[var_24_0] then
		var_0_2("sync notify", var_24_0)

		if self.waitCallbacks_[var_24_0].callback then
			self.waitCallbacks_[var_24_0].callback(var_24_1, self.waitCallbacks_[var_24_0].data)
		end

		self.lastDelayTime_ = self.waitCallbacks_[var_24_0].waitTime
		self.waitCallbacks_[var_24_0] = nil
	else
		var_0_2("can not find callback function!!!!", var_24_0, var_24_2)
	end
end

function StreamConnection:OnSocketError(arg_25_1)
	print("<color=#ff0000>TCP</color> Network error: " .. tostring(arg_25_1))

	if self.errorHandlingFunc_ then
		self:errorHandlingFunc_(self.connectType_, self.errorHandlingTime_, tostring(arg_25_1))
	end

	self:OnDisconnectedHandler()
end

function StreamConnection:SendSyncImplOneByOne(arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6, arg_26_7)
	if self.packetList_[arg_26_3] then
		print("正在发送中.... 丢弃！！！！！！！！！", arg_26_1)

		self.sendingPacketCount[arg_26_3] = (self.sendingPacketCount[arg_26_3] or 0) + 1

		if self.sendingPacketCount[arg_26_3] > var_0_8 or #self.syncSendQueue_ > var_0_9 then
			print("堆积过多的包，进行重连操作", arg_26_1)

			if self.timeOutFunc_ ~= nil then
				self:timeOutFunc_(self.connectType_)
			end
		end

		return
	end

	self.packetList_[arg_26_3] = true

	self:EnQueuePacket(arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6, arg_26_7)

	if self.netStatus == var_0_3.CONNECTED then
		self:StartSendPacket()
	else
		self:CheckConnectStatus()
	end
end

function StreamConnection:SendSyncNoEnqueueImpl(arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6, arg_27_7)
	if self.netStatus == var_0_3.CONNECTED then
		self:SendSyncImpl(arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6, arg_27_7)
	else
		table.insert(self.syncSendNoQueueTmp_, {
			arg_27_1,
			arg_27_2,
			arg_27_3,
			arg_27_4,
			arg_27_5,
			arg_27_6,
			arg_27_7
		})
		self:CheckConnectStatus()
	end
end

function StreamConnection:SendSyncImpl(arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5, arg_28_6, arg_28_7)
	var_0_2("SendSync", arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5, arg_28_6, arg_28_7)

	self.waitCallbacks_[arg_28_5 and arg_28_3 .. "_" .. self.idx_ or arg_28_3] = {
		waitTime = 0,
		callback = arg_28_4,
		data = arg_28_2
	}

	if arg_28_5 then
		self:SendBuildProtocol(self.idx_, self.serverIdx_, arg_28_1, arg_28_2)

		self.idx_ = self.idx_ + 1
	else
		self:SendBuildProtocol(0, self.serverIdx_, arg_28_1, arg_28_2)
	end
end

function StreamConnection:CollectMsgPacket(arg_29_1, arg_29_2)
	return
end

function StreamConnection:SendBuildProtocol(arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5)
	if arg_30_3 == 10050 and _G.PrintAllOpen_ then
		-- block empty
	end

	local var_30_0 = Protocol.GetProtocolWithName("cs_" .. arg_30_3)
	local var_30_1 = var_30_0:GetMessage()

	Protocol.BuildProtocolMessage(var_30_1, arg_30_4)

	if arg_30_3 ~= 10050 or _G.PrintAllOpen_ then
		print("index", arg_30_1, arg_30_2, arg_30_3, self.connectType_)
	end

	if self.connection_ then
		self.connection_:Send(Protocol.Pack(arg_30_1, arg_30_2, var_30_0:GetId(), var_30_1, arg_30_5))
	end

	StreamConnection.CollectMsgPacket(false, var_30_0:GetId(), arg_30_4)
end

function StreamConnection:EnQueuePacket(arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5, arg_31_6, arg_31_7)
	table.insert(self.syncSendQueue_, {
		arg_31_1,
		arg_31_2,
		arg_31_3,
		arg_31_4,
		arg_31_5,
		arg_31_6,
		arg_31_7
	})
end

function StreamConnection:OnSendComplete()
	local var_32_0 = table.remove(self.syncSendQueue_, 1)

	self:StartSendPacket()
end

function StreamConnection:StartSendPacket()
	if #self.syncSendQueue_ > 0 and not self.isPauseSendPacket_ then
		self:SendSyncImpl(unpack(self.syncSendQueue_[1]))
		self:OnSendComplete()
	end
end

function StreamConnection:SendNoQueuePacket()
	for iter_34_0 = 1, #self.syncSendNoQueueTmp_ do
		self:SendSyncImpl(unpack(self.syncSendNoQueueTmp_[iter_34_0]))
	end

	self.syncSendNoQueueTmp_ = {}
end

function StreamConnection:SetIsPauseSendPacket(arg_35_1)
	self.isPauseSendPacket_ = arg_35_1

	if not arg_35_1 then
		self:StartSendPacket()
	end
end

function StreamConnection:SendAsync(...)
	if self.netStatus == var_0_3.CONNECTED then
		self:SendBuildProtocol(0, self.serverIdx_, ...)
	end
end

function StreamConnection:SendSync(...)
	self:SendSyncImplOneByOne(...)
end

function StreamConnection:SendSyncNoEnqueue(...)
	self:SendSyncNoEnqueueImpl(...)
end

function StreamConnection:RegistPushWaiting(arg_39_1, arg_39_2)
	self.waitCallbacks_[arg_39_1] = {
		waitTime = 0,
		callback = arg_39_2
	}

	self:CheckConnectStatus()
end

function StreamConnection:Bind(arg_40_1, arg_40_2)
	self.notifies_[arg_40_1] = self.notifies_[arg_40_1] or {}

	if not table.indexof(self.notifies_[arg_40_1], arg_40_2) then
		var_0_2("Bind", arg_40_1, arg_40_2)
		table.insert(self.notifies_[arg_40_1], arg_40_2)
	else
		print("sc_" .. arg_40_1 .. " StreamConnection:Bind twice.")
	end
end

function StreamConnection:UnBind(arg_41_1, arg_41_2)
	if self.notifies_[arg_41_1] then
		if arg_41_2 == nil then
			var_0_2("UnBind", arg_41_1, "all")

			self.notifies_[arg_41_1] = nil
		else
			local var_41_0 = self.notifies_[arg_41_1]

			for iter_41_0 = #self.notifies_[arg_41_1], 1 do
				if var_41_0[iter_41_0] == arg_41_2 then
					var_0_2("UnBind", arg_41_1, arg_41_2)
					table.remove(var_41_0, iter_41_0)

					break
				end
			end
		end
	end
end

function StreamConnection:GetDelayTime()
	return self.lastDelayTime_ or 0
end

function StreamConnection:GetMachineState()
	return self.netStatus
end

function StreamConnection:GetConnectHostAndPort()
	return self.peerAddr_, self.peerPort_
end

return StreamConnection
