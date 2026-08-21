local var_0_0 = class("RectBaseScript")

function var_0_0.Ctor(arg_1_0)
	arg_1_0._weight = 1
	arg_1_0._loop = false
	arg_1_0._active = false
	arg_1_0._scriptTime = 0
	arg_1_0._overrideAble = false
	arg_1_0._lateActive = false
	arg_1_0._name = ""

	return
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.setData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._collisionInfo = arg_3_1
	arg_3_0._keyInfo = arg_3_2
	arg_3_0._event = arg_3_3

	arg_3_0:onInit()

	return
end

function var_0_0.step(arg_4_0)
	arg_4_0:onStep()

	arg_4_0._triggerKey = nil
	arg_4_0._triggerStatus = nil

	return
end

function var_0_0.addScriptApply(arg_5_0)
	arg_5_0._collisionInfo:removeScript()
	arg_5_0._collisionInfo:setScript(arg_5_0, arg_5_0._weight, arg_5_0._scriptTime, arg_5_0._overrideAble)

	return
end

function var_0_0.checkScirptApply(arg_6_0)
	if not arg_6_0._collisionInfo.script then
		arg_6_0:addScriptApply()

		return true
	elseif arg_6_0._collisionInfo.script ~= arg_6_0 and arg_6_0._collisionInfo.scriptOverrideAble and arg_6_0._collisionInfo.scriptWeight <= arg_6_0._weight then
		arg_6_0:addScriptApply()

		return true
	end

	print("当前脚本 " .. arg_6_0._collisionInfo.script._name .. " 中，无法执行" .. arg_6_0._name)

	return false
end

function var_0_0.onStep(arg_7_0)
	return
end

function var_0_0.lateStep(arg_8_0)
	arg_8_0._lateActive = arg_8_0._active

	arg_8_0:onLateStep()

	return
end

function var_0_0.onLateStep(arg_9_0)
	return
end

function var_0_0.active(arg_10_0, arg_10_1)
	arg_10_0._active = arg_10_1

	return
end

function var_0_0.onActive(arg_11_0)
	return
end

function var_0_0.keyTrigger(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._triggerKey = arg_12_1
	arg_12_0._triggerStatus = arg_12_2

	arg_12_0:onTrigger(arg_12_1, arg_12_2)

	return
end

function var_0_0.getWeight(arg_13_0)
	return arg_13_0._weight
end

return var_0_0
