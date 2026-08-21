module("framework.network.pipeline.NetworkHandler", package.seeall)

local var_0_0 = class("NetworkHandler")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._inboundEnabled = true
	arg_1_0._outboundEnabled = true
	arg_1_0._pipeline = nil
	arg_1_0._pre = nil
	arg_1_0._next = nil

	if arg_1_1 == false then
		arg_1_0._inboundEnabled = false
	end

	if arg_1_2 == false then
		arg_1_0._outboundEnabled = false
	end
end

function var_0_0.findNextOutboundHandler(arg_2_0)
	while arg_2_0 do
		if arg_2_0:getOutboundEnabled() and arg_2_0:getAvailable() then
			return arg_2_0
		else
			arg_2_0 = arg_2_0._pre
		end
	end
end

function var_0_0.findNextInboundHandler(arg_3_0)
	while arg_3_0 do
		if arg_3_0:getInboundEnabled() and arg_3_0:getAvailable() then
			return arg_3_0
		else
			arg_3_0 = arg_3_0._next
		end
	end
end

function var_0_0.getInboundEnabled(arg_4_0)
	return arg_4_0._inboundEnabled
end

function var_0_0.setInboundEnabled(arg_5_0, arg_5_1)
	arg_5_0._inboundEnabled = arg_5_1
end

function var_0_0.getOutboundEnabled(arg_6_0)
	return arg_6_0._outboundEnabled
end

function var_0_0.setOutboundEnabled(arg_7_0, arg_7_1)
	arg_7_0._outboundEnabled = arg_7_1
end

function var_0_0.getAvailable(arg_8_0)
	return arg_8_0._pipeline ~= nil
end

function var_0_0.getPipeline(arg_9_0)
	return arg_9_0._pipeline
end

function var_0_0.getManager(arg_10_0)
	return arg_10_0._pipeline and arg_10_0._pipeline:getManager()
end

function var_0_0.onAdded(arg_11_0)
	return
end

function var_0_0.onRemoved(arg_12_0)
	return
end

function var_0_0.fireSend(arg_13_0, ...)
	local var_13_0 = NetworkHandler.findNextOutboundHandler(arg_13_0._pre)

	if not var_13_0 then
		return
	end

	var_13_0:onSend(...)
end

function var_0_0.onSend(arg_14_0, ...)
	arg_14_0:fireSend(...)
end

function var_0_0.fireReceive(arg_15_0, ...)
	local var_15_0 = NetworkHandler.findNextInboundHandler(arg_15_0._next)

	if not var_15_0 then
		return
	end

	var_15_0:onReceive(...)
end

function var_0_0.onReceive(arg_16_0, ...)
	arg_16_0:fireReceive(...)
end

return var_0_0
