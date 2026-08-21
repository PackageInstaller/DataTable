module("framework.network.NetConnMgr", package.seeall)

local var_0_0 = Astral.LuaExtensions
local var_0_1 = class("NetConnMgr", NetConnMgrBase)

function var_0_1.newUpMessage(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0:_getPbName(arg_1_1)

	if not var_1_0 then
		printError(string.format("No proto setting -> extId:%s", arg_1_1))

		return
	end

	local var_1_1 = getmodule(var_1_0 .. "_pb")

	if not var_1_1 then
		printError(string.format("No pb file -> extId:% pbName:%s", arg_1_1, var_1_0))

		return
	end

	local var_1_2 = arg_1_0:_getUpMessageName(arg_1_1, arg_1_2)
	local var_1_3 = var_1_2 and var_1_1[var_1_2]

	if not var_1_3 then
		printError(string.format("No cmd -> extId:%s cmd:%s", arg_1_1, arg_1_2))

		return
	end

	return (var_1_3())
end

function var_0_1.newDownMessage(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0
	local var_2_1
	local var_2_2 = arg_2_0:_getPbName(arg_2_1)

	if not var_2_2 then
		printError(string.format("No proto setting -> extId:", arg_2_1))

		return
	end

	local var_2_3 = getmodule(var_2_2 .. "_pb")

	if not var_2_3 then
		printError(string.format("No pb file -> extId:%s pbName:%s", arg_2_1, var_2_2))

		return
	end

	local var_2_4 = arg_2_0:_getDownMessageName(arg_2_1, arg_2_2)
	local var_2_5 = var_2_4 and var_2_3[var_2_4]

	if not var_2_5 then
		printError(string.format("No down message -> extId:%s cmd:%s name:%s", arg_2_1, arg_2_2, tostring(var_2_4)))

		return
	end

	local var_2_6 = var_2_5()

	if var_2_6 and arg_2_3 ~= nil then
		var_2_6:ParseFromString(arg_2_3)
	end

	return var_2_6, var_2_4
end

function var_0_1.getPbUpStruct(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0
	local var_3_1
	local var_3_2 = arg_3_0:_getPbName(arg_3_1)

	if var_3_2 ~= nil then
		local var_3_3 = getmodule(var_3_2 .. "_pb")

		if var_3_3 ~= nil then
			local var_3_4 = arg_3_0:_getPbUpStructName(arg_3_1, arg_3_2)

			if var_3_4 ~= nil then
				local var_3_5 = var_3_3[var_3_4]

				if var_3_5 ~= nil then
					var_3_0 = var_3_5()
				else
					printError("Cannot find proto struct for extId=" .. arg_3_1 .. ",structName=" .. var_3_4)
				end
			else
				printError("No proto struct setting for extId=" .. arg_3_1 .. ",cmd=" .. arg_3_2)
			end
		else
			printError("Cannot find proto file for extId=" .. arg_3_1 .. ",pbName=" .. var_3_2)
		end
	else
		printError("No proto setting for extId=" .. arg_3_1)
	end

	return var_3_0
end

function var_0_1._getPbUpStructName(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._setting[arg_4_1]

	if var_4_0 then
		local var_4_1 = var_4_0[arg_4_2]

		for iter_4_0, iter_4_1 in pairs(var_4_1) do
			print(iter_4_0, iter_4_1)
		end

		if var_4_1 then
			return var_4_1[1]
		end
	end

	return nil
end

function var_0_1.messageToUpCmdInfo(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1 and getmetatable(arg_5_1)
	local var_5_1 = var_5_0 and var_5_0._member and var_5_0._member.type
	local var_5_2 = var_5_1 and arg_5_0._nameToUpCmdInfo[var_5_1]

	if var_5_2 then
		return var_5_2[1], var_5_2[2]
	end
end

function var_0_1.sendEmptyMsg(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:_send(arg_6_1, arg_6_2, nil, arg_6_3)
end

function var_0_1.sendSysMsg(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:_send(-1, arg_7_1, arg_7_2, arg_7_3)
end

function var_0_1.forceSendMsg(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if enableLog and not arg_8_0:isIgnored(arg_8_1, arg_8_2) then
		printInfo(string.format("NetConnMgr.forceSendMsg -> extId:%s cmd:%s", arg_8_1, arg_8_2))
	end

	arg_8_0:_send(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
end

function var_0_1._dumpMsg(arg_9_0, arg_9_1)
	if arg_9_1._fields ~= nil then
		printInfo(tostring(arg_9_1))
	end
end

function var_0_1._initSetting(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._nameToUpCmdInfo = {}
	arg_10_0._requestExtAndCmdMap = {}

	if type(arg_10_1) == "table" then
		for iter_10_0, iter_10_1 in pairs(arg_10_1) do
			local var_10_0 = iter_10_1[255] and getglobal(iter_10_1[255] .. "_pb")

			for iter_10_2, iter_10_3 in pairs(iter_10_1) do
				if iter_10_2 < 255 and #iter_10_3 > 1 then
					local var_10_1 = var_10_0[iter_10_3[1]]

					arg_10_0._nameToUpCmdInfo[var_10_1] = {
						iter_10_0,
						iter_10_2
					}
					arg_10_0._requestExtAndCmdMap[iter_10_3[1]] = {
						iter_10_0,
						iter_10_2
					}
				end
			end
		end
	end
end

function var_0_1.sendMsg(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0, var_11_1 = arg_11_0:messageToUpCmdInfo(arg_11_1)

	if not var_11_0 then
		printError(string.format("NetConnMgr.sendMsg -> Cannot find cmd:%s", name))

		return
	end

	arg_11_2 = arg_11_2 or ConnectionType.Logic

	if enableLog and var_11_0 ~= -1 and arg_11_1 and not arg_11_0:isIgnored(var_11_0, var_11_1) then
		local var_11_2 = arg_11_1 and arg_11_1._cname

		printInfo(string.format("NetConnMgr.sendMsg -> extId:%s cmd:%s name:%s", var_11_0, var_11_1, var_11_2 or "nil"))
		arg_11_0:_dumpMsg(arg_11_1)
	end

	arg_11_0:_send(var_11_0, var_11_1, arg_11_1, arg_11_2)
end

function var_0_1.doSend(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0

	if arg_12_3 then
		if arg_12_1 == -1 then
			var_12_0 = arg_12_0._sysCmdHandler:GetSendMsg(arg_12_2, arg_12_3, arg_12_4)
		else
			var_12_0 = arg_12_3:SerializeToString()
		end
	end

	arg_12_4 = arg_12_4 or ConnectionType.Logic

	var_0_0.SendNetworkMessage(arg_12_4, arg_12_1, arg_12_2, var_12_0)
end

function var_0_1._handleMsg(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	local var_13_0
	local var_13_1

	if arg_13_1 == -1 then
		var_13_0, var_13_1 = arg_13_0._sysCmdHandler:GetReceiveMsg(arg_13_2, arg_13_4)
	else
		var_13_1, var_13_0 = arg_13_0:newDownMessage(arg_13_1, arg_13_2, arg_13_4)
	end

	if not var_13_1 then
		return
	end

	if enableLog and not arg_13_0:isIgnored(arg_13_1, arg_13_2) then
		printInfo(string.format("NetConnMgr._handleMsg -> extId:%s cmd:%s status:%s,name:%s", arg_13_1, arg_13_2, arg_13_3, var_13_0))
		arg_13_0:_dumpMsg(var_13_1)
	end

	arg_13_0._pipeline:onReceive(arg_13_1, arg_13_2, arg_13_3, var_13_0, var_13_1, arg_13_5, arg_13_6)
end

function var_0_1.doReceive(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6, arg_14_7)
	local var_14_0 = "handle" .. arg_14_4

	ExtensionMgr.instance:_handleMsg(arg_14_1, arg_14_2, arg_14_3, var_14_0, arg_14_5, arg_14_6, arg_14_7)
end

var_0_1.instance = var_0_1.New()

return var_0_1
