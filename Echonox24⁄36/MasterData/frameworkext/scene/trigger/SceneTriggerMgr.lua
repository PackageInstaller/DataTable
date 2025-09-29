module("frameworkext.scene.trigger.SceneTriggerMgr", package.seeall)

local var_0_0 = class("SceneTriggerMgr", SceneComponentBase)

var_0_0.TriggerParamType = typeof(Astral.TriggerParam)
var_0_0.EmptyStr = ""

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
end

function var_0_0.onTriggerEnter(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:GetComponent(var_0_0.TriggerParamType)
	local var_2_1 = 0
	local var_2_2 = var_0_0.EmptyStr

	if var_2_0 then
		var_2_1 = var_2_0.numberParam

		if var_2_0.stringParam then
			var_2_2 = var_2_0.stringParam
		end
	end

	arg_2_0:dispatch(arg_2_1.gameObject.tag, true, arg_2_1, var_2_1, var_2_2, arg_2_2)
end

function var_0_0.onTriggerExit(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1:GetComponent(var_0_0.TriggerParamType)
	local var_3_1 = 0
	local var_3_2 = var_0_0.EmptyStr

	if var_3_0 then
		var_3_1 = var_3_0.numberParam

		if var_3_0.stringParam then
			var_3_2 = var_3_0.stringParam
		end
	end

	arg_3_0:dispatch(arg_3_1.gameObject.tag, false, arg_3_1, var_3_1, var_3_2, arg_3_2)
end

return var_0_0
