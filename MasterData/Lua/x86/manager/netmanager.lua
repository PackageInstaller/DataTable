local NetManager = class("NetManager")
local ReconnectLogic = require("manager/net/ReconnectLogic")

function NetManager:Ctor()
	self.gateWayConnection_ = StreamConnection.New("gateway")
	self.tcpConnection_ = StreamConnection.New("game")
	self.chatTcpConnection_ = StreamConnection.New("chat")
	self.connectionS_ = {
		gateway = self.gateWayConnection_,
		game = self.tcpConnection_,
		chat = self.chatTcpConnection_
	}

	self.tcpConnection_:RegistReconnectFunc(LoginAction.Reconnect)
	self.tcpConnection_:RegistErrorHandlingFunc(ConnectionHelper.OnErrorHandling)
	self.tcpConnection_:RegistTimeOutFunc(ConnectionHelper.OnTimeOut)

	self.frameTimer_ = FrameTimer.New(function()
		local var_2_0 = false

		for iter_2_0, iter_2_1 in pairs(self.connectionS_) do
			var_2_0 = var_2_0 or iter_2_1:GetIsNeedShowQuanQuan()
		end

		ShowQuanquan(var_2_0)
	end, 1, -1)

	self.frameTimer_:Start()
end

function NetManager:ChatConnect(arg_3_1, arg_3_2)
	return deferred.new(function(arg_4_0)
		self.chatTcpConnection_:Connect(arg_3_1, arg_3_2, function(arg_5_0)
			if arg_5_0 == SocketError.Success then
				print(string.format("[<color=#00ff00>TCP</color>]connect to <color=#FFDE00FF>%s:%d</color> <color=#00ff00>%s</color>", arg_3_1, arg_3_2, tostring(arg_5_0)))
				print("success")
				arg_4_0:resolve("connect success")
			else
				print(string.format("[<color=#00ff00>TCP</color>]connect to <color=#FFDE00FF>%s:%d</color> <color=#ff0000>%s</color>", arg_3_1, arg_3_2, tostring(arg_5_0)))
				arg_4_0:reject("connect fail")
			end
		end, function(arg_6_0, arg_6_1)
			arg_4_0:reject("connect fail")
		end)
	end)
end

function NetManager:ChatReconnect()
	return deferred.new(function(arg_8_0)
		self.chatTcpConnection_:Reconnect(function(arg_9_0)
			arg_8_0:resolve(arg_9_0)
		end)
	end)
end

function NetManager:ChatBind(arg_10_1, arg_10_2)
	self.chatTcpConnection_:Bind(arg_10_1, arg_10_2)
end

function NetManager:ChatUnBind(arg_11_1, arg_11_2)
	self.chatTcpConnection_:UnBind(arg_11_1, arg_11_2)
end

function NetManager:ChatSendWithLoading(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = true
	local var_12_1 = true
	local var_12_2 = true

	return deferred.new(function(arg_13_0)
		ReconnectLogic.CheckChatConnectStatusAndTryReconnect(arg_13_0)
	end):next(function()
		local var_14_0 = deferred.new()

		self.chatTcpConnection_:SendSync(arg_12_1, arg_12_2, arg_12_3, function(arg_15_0)
			var_14_0:resolve(arg_15_0)
		end, var_12_0, var_12_1, var_12_2)

		return var_14_0
	end, function(arg_16_0)
		local var_16_0 = deferred.new()

		var_16_0:reject(arg_16_0)
		print("reconnect fail", arg_16_0)

		return var_16_0
	end)
end

function NetManager:ChatSendSyncNoEnqueue(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	arg_17_4 = defaultValue(arg_17_4, true)
	arg_17_5 = defaultValue(arg_17_5, true)

	local var_17_0 = false

	return deferred.new(function(arg_18_0)
		self.chatTcpConnection_:SendSyncNoEnqueue(arg_17_1, arg_17_2, arg_17_3, function(arg_19_0)
			arg_18_0:resolve(arg_19_0)
		end, arg_17_4, arg_17_5, var_17_0, function(arg_20_0)
			arg_18_0:reject(arg_20_0)
		end)
	end)
end

function NetManager:ChatPush(arg_21_1, arg_21_2)
	self.chatTcpConnection_:SendAsync(arg_21_1, arg_21_2, true)
end

function NetManager:ChatAutoDequeueOn()
	return
end

function NetManager:ChatDisconnect()
	self.chatTcpConnection_:Disconnect()
end

function NetManager:GetChatTCPState()
	return self.chatTcpConnection_:GetMachineState()
end

function NetManager:Connect(arg_25_1, arg_25_2, arg_25_3)
	self.tcpConnection_ = self.tcpConnection_ or StreamConnection.New()

	self.tcpConnection_:Connect(arg_25_1, arg_25_2, arg_25_3)
end

function NetManager:GetConnectHostAndPort(arg_26_1)
	arg_26_1 = arg_26_1 or "game"

	if self.connectionS_[arg_26_1] then
		return self.connectionS_[arg_26_1]:GetConnectHostAndPort()
	end

	return self.tcpConnection_:GetConnectHostAndPort()
end

function NetManager:Reconnect(arg_27_1)
	self.tcpConnection_:Reconnect(arg_27_1)
end

function NetManager:Disconnect()
	self.tcpConnection_:Disconnect()
end

function NetManager:AutoDequeueOn()
	self.tcpConnection_:StartSendPacket()
end

function NetManager:SetIsPauseSendPacket(arg_30_1)
	self.tcpConnection_:SetIsPauseSendPacket(arg_30_1)
end

function NetManager:SendSyncNoEnqueue(arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5, arg_31_6)
	arg_31_5 = defaultValue(arg_31_5, true)
	arg_31_6 = defaultValue(arg_31_6, true)

	self.tcpConnection_:SendSyncNoEnqueue(arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5, arg_31_6)
end

function NetManager:Push(arg_32_1, arg_32_2)
	self.tcpConnection_:SendAsync(arg_32_1, arg_32_2, true)
end

function NetManager:Send(arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = true
	local var_33_1 = true
	local var_33_2 = true

	return deferred.new(function(arg_34_0)
		self.tcpConnection_:SendSync(arg_33_1, arg_33_2, arg_33_3, function(arg_35_0)
			arg_34_0:resolve(arg_35_0)
		end, var_33_0, var_33_1, var_33_2)
	end)
end

function NetManager:SendWithLoading(arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = true
	local var_36_1 = true
	local var_36_2 = true

	return deferred.new(function(arg_37_0)
		self.tcpConnection_:SendSync(arg_36_1, arg_36_2, arg_36_3, function(arg_38_0)
			arg_37_0:resolve(arg_38_0)
		end, var_36_0, var_36_1, var_36_2)
	end)
end

function NetManager:SendWithLoadingNew(arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	self.tcpConnection_:SendSync(arg_39_1, arg_39_2, arg_39_3, arg_39_4, true, true)
end

function NetManager:RegistPushWaiting(arg_40_1, arg_40_2)
	self.tcpConnection_:RegistPushWaiting(arg_40_1, arg_40_2)
end

function NetManager:Bind(arg_41_1, arg_41_2)
	self.tcpConnection_:Bind(arg_41_1, arg_41_2)
end

function NetManager:UnBind(arg_42_1, arg_42_2)
	self.tcpConnection_:UnBind(arg_42_1, arg_42_2)
end

function NetManager:GetTCPState(arg_43_1)
	arg_43_1 = arg_43_1 or "game"

	if self.connectionS_[arg_43_1] then
		return self.connectionS_[arg_43_1]:GetMachineState()
	end

	return self.tcpConnection_:GetMachineState()
end

function NetManager:ForceReconnect(arg_44_1)
	return self.tcpConnection_:ForceReconnect(arg_44_1)
end

function NetManager:ResetForceReconnect()
	return self.tcpConnection_:ResetForceReconnect()
end

function NetManager:GetDelayTime()
	return self.tcpConnection_:GetDelayTime()
end

function NetManager:GetMainSendingPacketNum()
	return self.tcpConnection_:GetSendingPacketNum()
end

function NetManager:GateWayConnect(arg_48_1, arg_48_2, arg_48_3)
	self.gateWayConnection_ = self.gateWayConnection_ or StreamConnection.New()

	self.gateWayConnection_:Connect(arg_48_1, arg_48_2, arg_48_3)
end

function NetManager:GateWayReconnect(arg_49_1)
	self.gateWayConnection_:Reconnect(arg_49_1)
end

function NetManager:GateWaySend(arg_50_1, arg_50_2, arg_50_3, arg_50_4, arg_50_5, arg_50_6)
	arg_50_5 = defaultValue(arg_50_5, true)
	arg_50_6 = defaultValue(arg_50_6, true)

	self.gateWayConnection_:SendSyncNoEnqueue(arg_50_1, arg_50_2, arg_50_3, arg_50_4, arg_50_5, arg_50_6)
end

return NetManager
