local var_0_0 = class("NetManager")
local var_0_1 = require("manager/net/ReconnectLogic")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.gateWayConnection_ = StreamConnection.New("gateway")
	arg_1_0.tcpConnection_ = StreamConnection.New("game")
	arg_1_0.chatTcpConnection_ = StreamConnection.New("chat")
	arg_1_0.connectionS_ = {
		gateway = arg_1_0.gateWayConnection_,
		game = arg_1_0.tcpConnection_,
		chat = arg_1_0.chatTcpConnection_
	}

	arg_1_0.tcpConnection_:RegistReconnectFunc(LoginAction.Reconnect)
	arg_1_0.tcpConnection_:RegistErrorHandlingFunc(ConnectionHelper.OnErrorHandling)
	arg_1_0.tcpConnection_:RegistTimeOutFunc(ConnectionHelper.OnTimeOut)

	arg_1_0.frameTimer_ = FrameTimer.New(function()
		local var_2_0 = false

		for iter_2_0, iter_2_1 in pairs(arg_1_0.connectionS_) do
			var_2_0 = var_2_0 or iter_2_1:GetIsNeedShowQuanQuan()
		end

		ShowQuanquan(var_2_0)
	end, 1, -1)

	arg_1_0.frameTimer_:Start()
end

function var_0_0.ChatConnect(arg_3_0, arg_3_1, arg_3_2)
	return deferred.new(function(arg_4_0)
		arg_3_0.chatTcpConnection_:Connect(arg_3_1, arg_3_2, function(arg_5_0)
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

function var_0_0.ChatReconnect(arg_7_0)
	return deferred.new(function(arg_8_0)
		arg_7_0.chatTcpConnection_:Reconnect(function(arg_9_0)
			arg_8_0:resolve(arg_9_0)
		end)
	end)
end

function var_0_0.ChatBind(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.chatTcpConnection_:Bind(arg_10_1, arg_10_2)
end

function var_0_0.ChatUnBind(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.chatTcpConnection_:UnBind(arg_11_1, arg_11_2)
end

function var_0_0.ChatSendWithLoading(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = true
	local var_12_1 = true
	local var_12_2 = true

	return deferred.new(function(arg_13_0)
		var_0_1.CheckChatConnectStatusAndTryReconnect(arg_13_0)
	end):next(function()
		local var_14_0 = deferred.new()

		arg_12_0.chatTcpConnection_:SendSync(arg_12_1, arg_12_2, arg_12_3, function(arg_15_0)
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

function var_0_0.ChatSendSyncNoEnqueue(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	arg_17_4 = defaultValue(arg_17_4, true)
	arg_17_5 = defaultValue(arg_17_5, true)

	local var_17_0 = false

	return deferred.new(function(arg_18_0)
		arg_17_0.chatTcpConnection_:SendSyncNoEnqueue(arg_17_1, arg_17_2, arg_17_3, function(arg_19_0)
			arg_18_0:resolve(arg_19_0)
		end, arg_17_4, arg_17_5, var_17_0, function(arg_20_0)
			arg_18_0:reject(arg_20_0)
		end)
	end)
end

function var_0_0.ChatPush(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.chatTcpConnection_:SendAsync(arg_21_1, arg_21_2, true)
end

function var_0_0.ChatAutoDequeueOn(arg_22_0)
	return
end

function var_0_0.ChatDisconnect(arg_23_0)
	arg_23_0.chatTcpConnection_:Disconnect()
end

function var_0_0.GetChatTCPState(arg_24_0)
	return arg_24_0.chatTcpConnection_:GetMachineState()
end

function var_0_0.Connect(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if not arg_25_0.tcpConnection_ then
		arg_25_0.tcpConnection_ = StreamConnection.New()
	end

	arg_25_0.tcpConnection_:Connect(arg_25_1, arg_25_2, arg_25_3)
end

function var_0_0.GetConnectHostAndPort(arg_26_0, arg_26_1)
	arg_26_1 = arg_26_1 or "game"

	if arg_26_0.connectionS_[arg_26_1] then
		return arg_26_0.connectionS_[arg_26_1]:GetConnectHostAndPort()
	end

	return arg_26_0.tcpConnection_:GetConnectHostAndPort()
end

function var_0_0.Reconnect(arg_27_0, arg_27_1)
	arg_27_0.tcpConnection_:Reconnect(arg_27_1)
end

function var_0_0.Disconnect(arg_28_0)
	arg_28_0.tcpConnection_:Disconnect()
end

function var_0_0.AutoDequeueOn(arg_29_0)
	arg_29_0.tcpConnection_:StartSendPacket()
end

function var_0_0.SetIsPauseSendPacket(arg_30_0, arg_30_1)
	arg_30_0.tcpConnection_:SetIsPauseSendPacket(arg_30_1)
end

function var_0_0.SendSyncNoEnqueue(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5, arg_31_6)
	arg_31_5 = defaultValue(arg_31_5, true)
	arg_31_6 = defaultValue(arg_31_6, true)

	arg_31_0.tcpConnection_:SendSyncNoEnqueue(arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5, arg_31_6)
end

function var_0_0.Push(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0.tcpConnection_:SendAsync(arg_32_1, arg_32_2, true)
end

function var_0_0.Send(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = true
	local var_33_1 = true
	local var_33_2 = true

	return deferred.new(function(arg_34_0)
		arg_33_0.tcpConnection_:SendSync(arg_33_1, arg_33_2, arg_33_3, function(arg_35_0)
			arg_34_0:resolve(arg_35_0)
		end, var_33_0, var_33_1, var_33_2)
	end)
end

function var_0_0.SendWithLoading(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = true
	local var_36_1 = true
	local var_36_2 = true

	return deferred.new(function(arg_37_0)
		arg_36_0.tcpConnection_:SendSync(arg_36_1, arg_36_2, arg_36_3, function(arg_38_0)
			arg_37_0:resolve(arg_38_0)
		end, var_36_0, var_36_1, var_36_2)
	end)
end

function var_0_0.SendWithLoadingNew(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	local var_39_0 = true
	local var_39_1 = true

	arg_39_0.tcpConnection_:SendSync(arg_39_1, arg_39_2, arg_39_3, arg_39_4, var_39_0, var_39_1)
end

function var_0_0.RegistPushWaiting(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0.tcpConnection_:RegistPushWaiting(arg_40_1, arg_40_2)
end

function var_0_0.Bind(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0.tcpConnection_:Bind(arg_41_1, arg_41_2)
end

function var_0_0.UnBind(arg_42_0, arg_42_1, arg_42_2)
	arg_42_0.tcpConnection_:UnBind(arg_42_1, arg_42_2)
end

function var_0_0.GetTCPState(arg_43_0, arg_43_1)
	arg_43_1 = arg_43_1 or "game"

	if arg_43_0.connectionS_[arg_43_1] then
		return arg_43_0.connectionS_[arg_43_1]:GetMachineState()
	end

	return arg_43_0.tcpConnection_:GetMachineState()
end

function var_0_0.ForceReconnect(arg_44_0, arg_44_1)
	return arg_44_0.tcpConnection_:ForceReconnect(arg_44_1)
end

function var_0_0.ResetForceReconnect(arg_45_0)
	return arg_45_0.tcpConnection_:ResetForceReconnect()
end

function var_0_0.GetDelayTime(arg_46_0)
	return arg_46_0.tcpConnection_:GetDelayTime()
end

function var_0_0.GetMainSendingPacketNum(arg_47_0)
	return arg_47_0.tcpConnection_:GetSendingPacketNum()
end

function var_0_0.GateWayConnect(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	if not arg_48_0.gateWayConnection_ then
		arg_48_0.gateWayConnection_ = StreamConnection.New()
	end

	arg_48_0.gateWayConnection_:Connect(arg_48_1, arg_48_2, arg_48_3)
end

function var_0_0.GateWayReconnect(arg_49_0, arg_49_1)
	arg_49_0.gateWayConnection_:Reconnect(arg_49_1)
end

function var_0_0.GateWaySend(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4, arg_50_5, arg_50_6)
	arg_50_5 = defaultValue(arg_50_5, true)
	arg_50_6 = defaultValue(arg_50_6, true)

	arg_50_0.gateWayConnection_:SendSyncNoEnqueue(arg_50_1, arg_50_2, arg_50_3, arg_50_4, arg_50_5, arg_50_6)
end

return var_0_0
