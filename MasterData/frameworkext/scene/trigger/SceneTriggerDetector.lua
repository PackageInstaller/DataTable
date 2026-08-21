module("frameworkext.scene.trigger.SceneTriggerDetector", package.seeall)

local var_0_0 = class("SceneTriggerDetector")

function var_0_0.Get(arg_1_0)
	Astral.LuaComponentContainer.Add(arg_1_0, var_0_0)
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1.gameObject
	arg_2_0._userData = nil
end

function var_0_0.setUserData(arg_3_0, arg_3_1)
	arg_3_0._userData = arg_3_1
end

function var_0_0.OnTriggerEnter(arg_4_0, arg_4_1)
	SceneTriggerMgr.instance:onTriggerEnter(arg_4_1, arg_4_0._userData)
end

function var_0_0.OnTriggerExit(arg_5_0, arg_5_1)
	SceneTriggerMgr.instance:onTriggerExit(arg_5_1, arg_5_0._userData)
end

function var_0_0.OnDestroy(arg_6_0)
	arg_6_0._userData = nil
end

return var_0_0
