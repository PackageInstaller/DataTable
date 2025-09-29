module("frameworkext.scene.SceneBase", package.seeall)

local var_0_0 = class("SceneBase")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._container = arg_1_1
	arg_1_0._enterFinishedHandler = nil
	arg_1_0._enterFinishedObj = nil
	arg_1_0._innerChannelId = -1
	arg_1_0._stageLoadFinishedHandler = nil
	arg_1_0._stageLoadFinishedObj = nil
	arg_1_0._curSceneId = 0
	arg_1_0._curBornX = 0
	arg_1_0._curBornZ = 0
	arg_1_0._isExiting = false
	arg_1_0._compList = {}

	arg_1_0:_initComponents()

	local var_1_0 = #arg_1_0._compList
	local var_1_1

	for iter_1_0 = 1, var_1_0 do
		local var_1_2 = arg_1_0._compList[iter_1_0]

		if var_1_2.onInit then
			var_1_2:onInit()
		end
	end
end

function var_0_0.getInnerChannelId(arg_2_0)
	return arg_2_0._innerChannelId
end

function var_0_0.getSceneId(arg_3_0)
	return arg_3_0._curSceneId
end

function var_0_0.getBornX(arg_4_0)
	return arg_4_0._curBornX
end

function var_0_0.getBornZ(arg_5_0)
	return arg_5_0._curBornZ
end

function var_0_0.getContainer(arg_6_0)
	return arg_6_0._container
end

function var_0_0.setEnterFinishedHandler(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._enterFinishedHandler = arg_7_1
	arg_7_0._enterFinishedObj = arg_7_2
end

function var_0_0.setStageLoadFinishedHandler(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._stageLoadFinishedHandler = arg_8_1
	arg_8_0._stageLoadFinishedObj = arg_8_2
end

function var_0_0._addComponent(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0

	if arg_9_2.instance then
		var_9_0 = arg_9_2.instance
		arg_9_0[arg_9_1] = var_9_0
	else
		var_9_0 = arg_9_2.New(arg_9_0)
		arg_9_0[arg_9_1] = var_9_0
	end

	table.insert(arg_9_0._compList, var_9_0)
end

function var_0_0.onEnterFinished(arg_10_0)
	local var_10_0 = #arg_10_0._compList
	local var_10_1

	for iter_10_0 = 1, var_10_0 do
		local var_10_2 = arg_10_0._compList[iter_10_0]

		if var_10_2.onEnterScene and not var_10_2.isOnEnterScene then
			var_10_2.isOnEnterScene = true

			var_10_2:onEnterScene(arg_10_0._curSceneId, arg_10_0._curBornX, arg_10_0._curBornZ)
		end
	end

	for iter_10_1 = 1, var_10_0 do
		local var_10_3 = arg_10_0._compList[iter_10_1]

		if var_10_3.onEnterSceneFinished then
			var_10_3:onEnterSceneFinished(arg_10_0._curSceneId, arg_10_0._curBornX, arg_10_0._curBornZ)
		end
	end

	if arg_10_0._enterFinishedHandler then
		arg_10_0._enterFinishedHandler(arg_10_0._enterFinishedObj)
	end
end

function var_0_0.onStageLoadFinished(arg_11_0)
	if arg_11_0._stageLoadFinishedHandler then
		arg_11_0._stageLoadFinishedHandler(arg_11_0._stageLoadFinishedObj)
	end
end

function var_0_0.onEnter(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0._curSceneId = arg_12_1
	arg_12_0._curBornX = arg_12_2
	arg_12_0._curBornZ = arg_12_3
	arg_12_0._innerChannelId = IDRecycleGenerater.getInnerChannelUid()

	local var_12_0 = #arg_12_0._compList
	local var_12_1

	for iter_12_0 = 1, var_12_0 do
		local var_12_2 = arg_12_0._compList[iter_12_0]

		if var_12_2.onAddEvents then
			var_12_2:onAddEvents()
		end
	end

	for iter_12_1 = 1, var_12_0 do
		local var_12_3 = arg_12_0._compList[iter_12_1]

		if var_12_3.onEnterScene and not var_12_3.isOnEnterScene then
			var_12_3.isOnEnterScene = true

			var_12_3:onEnterScene(arg_12_1, arg_12_2, arg_12_3)
		end
	end
end

function var_0_0.onExit(arg_13_0)
	arg_13_0._isExiting = true

	local var_13_0 = #arg_13_0._compList
	local var_13_1

	for iter_13_0 = 1, var_13_0 do
		local var_13_2 = arg_13_0._compList[iter_13_0]

		if var_13_2.onRemoveEvents then
			var_13_2:onRemoveEvents()
		end
	end

	for iter_13_1 = 1, var_13_0 do
		local var_13_3 = arg_13_0._compList[iter_13_1]

		if var_13_3.onExitScene then
			var_13_3.isOnEnterScene = nil

			var_13_3:onExitScene()
		end
	end

	arg_13_0._isExiting = false

	IDRecycleGenerater.recycleInnerChannelUid(arg_13_0:getInnerChannelId())
end

function var_0_0.isExiting(arg_14_0)
	return arg_14_0._isExiting
end

function var_0_0._initComponents(arg_15_0)
	return
end

function var_0_0.addInnerEventListener(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	SceneInnerDispatcher:addEventListener(UIDUtil.getUidWithSum(arg_16_0:getInnerChannelId(), arg_16_1), arg_16_2, arg_16_3, arg_16_4)
end

function var_0_0.removeInnerEventListener(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	SceneInnerDispatcher:removeEventListener(UIDUtil.getUidWithSum(arg_17_0:getInnerChannelId(), arg_17_1), arg_17_2, arg_17_3, arg_17_4)
end

function var_0_0.dispatchInnerEvent(arg_18_0, arg_18_1, ...)
	SceneInnerDispatcher:dispatchEvent(UIDUtil.getUidWithSum(arg_18_0:getInnerChannelId(), arg_18_1), unitActionType, ...)
end

return var_0_0
