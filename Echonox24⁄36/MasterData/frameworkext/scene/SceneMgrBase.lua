module("frameworkext.scene.SceneMgrBase", package.seeall)

local var_0_0 = class("SceneMgrBase")

function var_0_0.ctor(arg_1_0)
	arg_1_0._curSceneType = 0
	arg_1_0._curSceneId = 0
	arg_1_0._lastSceneType = 0
	arg_1_0._lastSceneId = 0
	arg_1_0._scenes = {}
	arg_1_0._root = goutil.find("SCENEROOT")
	arg_1_0._isEnetering = false
	arg_1_0._enterCmds = {}

	arg_1_0:_extendConstDef()
	arg_1_0:_createSingletonComps()
	arg_1_0:_registerScenes()
end

function var_0_0._registerScene(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = goutil.create(arg_2_2.__cname, false)

	goutil.addChildToParent(var_2_0, arg_2_0._root)

	local var_2_1 = arg_2_2.New(var_2_0)

	var_2_1:setEnterFinishedHandler(arg_2_0.onEnterFinished, arg_2_0)
	var_2_1:setStageLoadFinishedHandler(arg_2_0.onStageLoadFinished, arg_2_0)

	arg_2_0._scenes[arg_2_1] = var_2_1
end

function var_0_0.getScene(arg_3_0, arg_3_1)
	return arg_3_0._scenes[arg_3_1]
end

function var_0_0.getCurSceneType(arg_4_0)
	return arg_4_0._curSceneType
end

function var_0_0.getCurSceneId(arg_5_0)
	return arg_5_0._curSceneId
end

function var_0_0.getCurScene(arg_6_0)
	if arg_6_0._curSceneType then
		return arg_6_0._scenes[arg_6_0._curSceneType]
	end

	return nil
end

function var_0_0._checkNextEnterCmd(arg_7_0)
	if #arg_7_0._enterCmds > 0 then
		local var_7_0 = arg_7_0._enterCmds[1]

		table.remove(arg_7_0._enterCmds, 1)
		arg_7_0:enter(var_7_0[1], var_7_0[2], var_7_0[3], var_7_0[4])
	end
end

function var_0_0.exitCurScene(arg_8_0)
	if arg_8_0._curSceneType == 0 or arg_8_0._curSceneId == 0 then
		return
	end

	arg_8_0:_showLoading()

	arg_8_0._lastSceneType = arg_8_0._curSceneType
	arg_8_0._lastSceneId = arg_8_0._curSceneId

	arg_8_0._scenes[arg_8_0._curSceneType]:onExit()

	arg_8_0._curSceneType = 0
	arg_8_0._curSceneId = 0
end

function var_0_0.onExitFinished(arg_9_0)
	arg_9_0:_hideLoading()
end

function var_0_0.enter(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_0._isEnetering then
		local var_10_0 = {
			arg_10_1,
			arg_10_2,
			arg_10_3,
			arg_10_4
		}

		table.insert(arg_10_0._enterCmds, var_10_0)

		return
	end

	if arg_10_0._curSceneType == arg_10_1 and arg_10_0._curSceneId == arg_10_2 then
		arg_10_0:_checkNextEnterCmd()

		return
	end

	arg_10_0:_showLoading()

	arg_10_0._isEnetering = true

	if arg_10_0._curSceneType > 0 and arg_10_0._curSceneId > 0 then
		arg_10_0._scenes[arg_10_0._curSceneType]:onExit()
	end

	arg_10_0._lastSceneType = arg_10_0._curSceneType
	arg_10_0._lastSceneId = arg_10_0._curSceneId
	arg_10_0._curSceneType = arg_10_1
	arg_10_0._curSceneId = arg_10_2

	arg_10_0._scenes[arg_10_1]:onEnter(arg_10_2, arg_10_3, arg_10_4)
end

function var_0_0.onEnterFinished(arg_11_0)
	arg_11_0._isEnetering = false

	arg_11_0:_hideLoading()
	arg_11_0:_checkNextEnterCmd()
end

function var_0_0._extendConstDef(arg_12_0)
	return
end

function var_0_0._registerScenes(arg_13_0)
	return
end

function var_0_0._createSingletonComps(arg_14_0)
	return
end

function var_0_0._showLoading(arg_15_0)
	return
end

function var_0_0._hideLoading(arg_16_0)
	return
end

function var_0_0.onStageLoadFinished(arg_17_0)
	return
end

return var_0_0
