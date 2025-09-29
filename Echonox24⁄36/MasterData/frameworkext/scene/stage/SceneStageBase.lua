module("frameworkext.scene.stage.SceneStageBase", package.seeall)

local var_0_0 = class("SceneStageBase", SceneComponentBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
end

function var_0_0.onEnterScene(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:load(arg_2_1)
end

function var_0_0.onExitScene(arg_3_0)
	arg_3_0:unload()
end

function var_0_0._onAllLoaded(arg_4_0)
	arg_4_0._scene:onEnterFinished()
end

function var_0_0.load(arg_5_0, arg_5_1)
	return
end

function var_0_0._onStageLoadFinished(arg_6_0)
	arg_6_0._scene:onStageLoadFinished()
end

function var_0_0.unload(arg_7_0)
	return
end

return var_0_0
