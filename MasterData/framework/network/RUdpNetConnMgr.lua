module("framework.network.RUdpNetConnMgr", package.seeall)

local var_0_0 = class("RUdpNetConnMgr", NetConnMgrBase)

function var_0_0._initSetting(arg_1_0)
	arg_1_0._pingCallback = {}
end

function var_0_0.sendMsg(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_1.extId
	local var_2_1 = arg_2_1.cmdId

	if not var_2_0 then
		printError(string.format("NetConnMgr.sendMsg -> Cannot find cmd:%s", var_2_0))

		return
	end

	local var_2_2 = arg_2_0:_getUpMessageName(var_2_0, var_2_1)

	if enableLog and var_2_0 ~= -1 and arg_2_1 and not arg_2_0:isIgnored(var_2_0, var_2_1) then
		printInfo(string.format("NetConnMgr.sendMsg -> extId:%s cmd:%s name:%s", var_2_0, var_2_1, var_2_2 or "nil"))
		arg_2_0:_dumpMsg(arg_2_1)
	end

	arg_2_0:_send(var_2_0, var_2_1, arg_2_1, arg_2_2, arg_2_3)
end

function var_0_0.sendPing(arg_3_0, arg_3_1)
	arg_3_1 = arg_3_1 or ConnectionType.Battle

	Astral.LuaExtensions.SendNetworkMessage(arg_3_1, 0, 0, "", false)
end

function var_0_0.doSend(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	arg_4_4 = arg_4_4 or ConnectionType.Logic

	if arg_4_5 == nil then
		arg_4_5 = true
	end

	local var_4_0 = arg_4_0:_getUpMessageName(arg_4_1, arg_4_2)
	local var_4_1 = pb.encode(var_4_0, arg_4_3)

	Astral.LuaExtensions.SendNetworkMessage(arg_4_4, arg_4_1, arg_4_2, var_4_1, arg_4_5)
end

function var_0_0._handleMsg(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	local var_5_0, var_5_1 = arg_5_0:_getDownMessageName(arg_5_1, arg_5_2)

	if arg_5_4 then
		var_5_1 = pb.decode(var_5_0, arg_5_4)
	end

	if not var_5_1 then
		return
	end

	if enableLog and not arg_5_0:isIgnored(arg_5_1, arg_5_2) then
		printInfo(string.format("NetConnMgr._handleMsg -> extId:%s cmd:%s status:%s,name:%s", arg_5_1, arg_5_2, arg_5_3, var_5_0))
		arg_5_0:_dumpMsg(var_5_1)
	end

	arg_5_0._pipeline:onReceive(arg_5_1, arg_5_2, arg_5_3, var_5_0, var_5_1, arg_5_5, arg_5_6)
end

function var_0_0.doReceive(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	ExtensionMgr.instance:_handleMsg(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
end

function var_0_0._dumpMsg(arg_7_0, arg_7_1)
	if serpent then
		printInfo(serpent.block(arg_7_1))
	end
end

function var_0_0.resetRouteCode(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._networkMgr:ResetRouteCode(arg_8_2 or ConnectionType.Battle, arg_8_1)
end

function var_0_0.setPingCallback(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0._pingCallback[arg_9_1]

	arg_9_0:_addCallback(arg_9_0._pingCallback, arg_9_1, arg_9_2, arg_9_3)

	if not var_9_0 then
		printWarn(string.format("Set PingCallback, channelId:%s", arg_9_1))
		arg_9_0._networkMgr:SetPingCallback(arg_9_1, arg_9_0._onPingCallback)
	end
end

function var_0_0._onPingCallback(arg_10_0)
	local var_10_0 = var_0_0.instance

	var_10_0._invokeCallback(var_10_0._pingCallback, arg_10_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
