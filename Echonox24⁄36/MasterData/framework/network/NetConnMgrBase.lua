module("framework.network.NetConnMgrBase", package.seeall)

local var_0_0 = class("NetConnMgrBase")
local var_0_1 = 3
local var_0_2 = Astral.LuaExtensions

var_0_0._connectCallback = {}
var_0_0._disconnectCallback = {}

function var_0_0.ctor(arg_1_0)
	arg_1_0._networkMgr = Astral.NetworkManager.Instance
	arg_1_0._pipeline = NetworkPipeline.New(arg_1_0)
	arg_1_0._sysCmdHandler = SysCmdHandler.New()
	arg_1_0._ignoreCodeIds = {}
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or var_0_1
	arg_2_0._setting = arg_2_1

	arg_2_0:_initSetting(arg_2_1, arg_2_2)
	var_0_2.SetNetworkMessageCallback(arg_2_0._handleMsg, arg_2_0)
end

function var_0_0.getCode(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_1 * 256 + arg_3_2
end

function var_0_0.ignoreLog(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3 ~= false then
		arg_4_3 = true
	end

	local var_4_0 = arg_4_0:getCode(arg_4_1, arg_4_2)

	if arg_4_3 then
		arg_4_0._ignoreCodeIds[var_4_0] = true
	else
		arg_4_0._ignoreCodeIds[var_4_0] = nil
	end

	arg_4_0._networkMgr:IgnoreLog(arg_4_1, arg_4_2, arg_4_3)
end

function var_0_0.isIgnored(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getCode(arg_5_1, arg_5_2)

	if arg_5_0._ignoreCodeIds[var_5_0] then
		return true
	end

	return false
end

function var_0_0._getPbName(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._setting[arg_6_1]

	if var_6_0 then
		return var_6_0[255]
	end

	return nil
end

function var_0_0._getUpMessageName(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._setting[arg_7_1]
	local var_7_1 = var_7_0 and var_7_0[arg_7_2]

	return var_7_1 and var_7_1[1]
end

function var_0_0._getDownMessageName(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._setting[arg_8_1]
	local var_8_1 = var_8_0 and var_8_0[arg_8_2]

	return var_8_1 and var_8_1[#var_8_1]
end

function var_0_0.addSendFilter(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0._pipeline:addFilter(true, arg_9_3, arg_9_1, arg_9_2)
end

function var_0_0.addReceiveFilter(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0._pipeline:addFilter(false, arg_10_3, arg_10_1, arg_10_2)
end

function var_0_0._addCallback(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = arg_11_1[arg_11_2]

	if arg_11_3 then
		if not var_11_0 then
			var_11_0 = {}
			arg_11_1[arg_11_2] = var_11_0
		end

		var_11_0[1] = arg_11_3
		var_11_0[2] = arg_11_4
	elseif var_11_0 then
		var_11_0[1] = nil
		var_11_0[2] = nil
	end
end

function var_0_0._invokeCallback(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = arg_12_0[arg_12_1]
	local var_12_1 = var_12_0 and var_12_0[1]
	local var_12_2 = var_12_0 and var_12_0[2]

	if not var_12_1 then
		-- block empty
	elseif var_12_2 then
		var_12_1(var_12_2, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	else
		var_12_1(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	end
end

function var_0_0.setConnectCallback(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = var_0_0._connectCallback[arg_13_1]

	arg_13_0:_addCallback(var_0_0._connectCallback, arg_13_1, arg_13_2, arg_13_3)

	if not var_13_0 then
		arg_13_0._networkMgr:SetConnectCallback(arg_13_1, arg_13_0._onConnectCompleted)
	end
end

function var_0_0._onConnectCompleted(arg_14_0, arg_14_1)
	var_0_0._invokeCallback(var_0_0._connectCallback, arg_14_0, arg_14_1)
end

function var_0_0.setDisconnectCallback(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = var_0_0._disconnectCallback[arg_15_1]

	arg_15_0:_addCallback(var_0_0._disconnectCallback, arg_15_1, arg_15_2, arg_15_3)

	if not var_15_0 then
		arg_15_0._networkMgr:SetDisconnectCallback(arg_15_1, arg_15_0._onDisconnect)
	end
end

function var_0_0._onDisconnect(arg_16_0)
	var_0_0._invokeCallback(var_0_0._disconnectCallback, arg_16_0)
end

function var_0_0.connect(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_3 = arg_17_3 or ConnectionType.Logic

	if arg_17_4 and type(arg_17_4) == "number" then
		arg_17_0._networkMgr:Connect(arg_17_3, arg_17_1, arg_17_2, arg_17_4)
	else
		arg_17_0._networkMgr:Connect(arg_17_3, arg_17_1, arg_17_2)
	end
end

function var_0_0.disconnect(arg_18_0, arg_18_1)
	arg_18_0._networkMgr:Disconnect(arg_18_1 or ConnectionType.Logic)
end

function var_0_0._send(arg_19_0, ...)
	arg_19_0._pipeline:send(...)
end

function var_0_0.resetSeqNo(arg_20_0, arg_20_1)
	arg_20_1 = arg_20_1 or ConnectionType.Logic

	arg_20_0._networkMgr:ResetSeqNo(arg_20_1)
end

function var_0_0.resetUpTag(arg_21_0, arg_21_1)
	arg_21_1 = arg_21_1 or ConnectionType.Logic

	arg_21_0._networkMgr:ResetUpTag(arg_21_1)
end

function var_0_0.nodelay(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	arg_22_5 = arg_22_5 or ConnectionType.Battle

	arg_22_0._networkMgr:SetNoDelay(arg_22_5, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
end

function var_0_0.setWndSize(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_3 = arg_23_3 or ConnectionType.Battle

	arg_23_0._networkMgr:SetWndSize(arg_23_3, arg_23_1, arg_23_2)
end

function var_0_0.setMtu(arg_24_0, arg_24_1, arg_24_2)
	arg_24_2 = arg_24_2 or ConnectionType.Battle

	arg_24_0._networkMgr:SetMtu(arg_24_2, arg_24_1)
end

function var_0_0.setMinRto(arg_25_0, arg_25_1, arg_25_2)
	arg_25_2 = arg_25_2 or ConnectionType.Battle

	arg_25_0._networkMgr:SetMinRto(arg_25_2, arg_25_1)
end

function var_0_0.getStat(arg_26_0, arg_26_1)
	arg_26_1 = arg_26_1 or ConnectionType.Battle

	return (arg_26_0._networkMgr:GetStat(arg_26_1))
end

function var_0_0._initSetting(arg_27_0, arg_27_1, arg_27_2)
	return
end

function var_0_0.sendMsg(arg_28_0, ...)
	return
end

function var_0_0.doSend(arg_29_0, ...)
	return
end

function var_0_0._handleMsg(arg_30_0, ...)
	return
end

function var_0_0.doReceive(arg_31_0, ...)
	return
end

return var_0_0
