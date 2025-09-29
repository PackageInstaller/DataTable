module("frameworkext.lmvc.agent.BaseAgent", package.seeall)

local var_0_0 = class("BaseAgent")

var_0_0.netMgr = nil

function var_0_0.ctor(arg_1_0)
	arg_1_0._funCallList = {}
end

function var_0_0.setExtId(arg_2_0, arg_2_1)
	arg_2_0._extId = arg_2_1
end

function var_0_0.sendMsg(arg_3_0, ...)
	connType = connType or ConnectionType.Logic

	;(var_0_0.netMgr or NetConnMgr.instance):sendMsg(...)
end

function var_0_0.sendEmptyMsg(arg_4_0, ...)
	connType = connType or ConnectionType.Logic

	;(var_0_0.netMgr or NetConnMgr.instance):sendEmptyMsg(arg_4_0._extId, ...)
end

function var_0_0.invoke(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_1.funcName then
		local var_5_0 = arg_5_1.funcName

		arg_5_0:sendMsg(arg_5_1.sendData, arg_5_1.connType)

		if not arg_5_0[var_5_0] then
			arg_5_0[var_5_0] = function(arg_6_0, arg_6_1, arg_6_2)
				local var_6_0 = table.remove(arg_6_0._funCallList[var_5_0], 1)

				if var_6_0 then
					var_6_0(arg_6_1, arg_6_2)
				end
			end
		end

		if arg_5_1.handleCall then
			local var_5_1 = arg_5_0._funCallList[var_5_0]

			if not var_5_1 then
				var_5_1 = {}
				arg_5_0._funCallList[var_5_0] = var_5_1
			end

			table.insert(var_5_1, arg_5_1.handleCall)
		end
	end
end

function var_0_0.onInit(arg_7_0)
	return
end

return var_0_0
