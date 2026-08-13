class = var_0_10000

local var_0_0 = var_0_10000("PacGameScene")

var_0_0.GET_SCORE = "PacGameScene:get_score"
var_0_0.HIT_PLAYER = "PacGameScene:hit_player"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3
	findTF = var_1_10004
	arg_1_0._sceneMask = var_1_10004(arg_1_0._tf, "sceneMask")
	findTF = var_4
	arg_1_0._sceneContainer = var_4(arg_1_0._tf, "sceneMask/sceneContainer")

	function arg_1_0._eventCallback(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0

		var_3.onEventHandle(var_2_0, arg_2_0, arg_2_1, arg_2_2)

		return
	end

	PacGameRunningData = var_4
	arg_1_0._pacGameRunningData = var_4.New()

	local var_1_0 = arg_1_0._pacGameRunningData
	local var_1_1 = var_4.SetTpl

	findTF = var_6

	var_1_1(var_1_0, var_6(arg_1_0._tf, "tpl"))
	arg_1_0:ShowContainer(false)

	PacGameMapController = var_4
	arg_1_0._mapController = var_4.New(arg_1_0._sceneMask, arg_1_0._eventCallback, arg_1_0._pacGameRunningData)
	PacGameMovingController = var_4
	arg_1_0._movingController = var_4.New(arg_1_0._sceneMask, arg_1_0._eventCallback, arg_1_0._pacGameRunningData)
	PacGameRoleController = var_4
	arg_1_0._roleController = var_4.New(arg_1_0._sceneMask, arg_1_0._eventCallback, arg_1_0._pacGameRunningData)
	PacGameEnemyController = var_4
	arg_1_0._enemyController = var_4.New(arg_1_0._sceneMask, arg_1_0._eventCallback, arg_1_0._pacGameRunningData)
	PacGameItemController = var_4
	arg_1_0._itemController = var_4.New(arg_1_0._sceneMask, arg_1_0._eventCallback, arg_1_0._pacGameRunningData)
	PacGameEditorController = var_4
	arg_1_0._editorController = var_4.New(arg_1_0._sceneMask, arg_1_0._eventCallback, arg_1_0._pacGameRunningData)

	return
end

function var_0_0.onEventHandle(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 == var_0_0.GET_SCORE then
		local var_3_0 = arg_3_0._event
		local var_3_1 = var_4.emit

		SimpleMGEvent = var_1_10006

		var_3_1(var_3_0, var_1_10006.ADD_SCORE, {
			num = arg_3_2
		})
	elseif arg_3_1 == var_0_0.HIT_PLAYER then
		local var_3_2 = arg_3_0._event
		local var_3_3 = var_4.emit

		SimpleMGEvent = var_1_10006

		var_3_3(var_3_2, var_1_10006.GAME_OVER)
	end

	return
end

function var_0_0.ShowContainer(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0._sceneMask, arg_4_1)

	return
end

function var_0_0.Prepare(arg_5_0)
	local var_5_0 = arg_5_0._gameVo
	local var_5_1 = var_1.GetGameRound(var_5_0)

	print = var_5_0

	var_5_0("round id = " .. var_5_1)

	PacGameConst = var_5_0

	local var_5_2 = var_5_0.chapter_data[var_5_1]
	local var_5_3 = arg_5_0._gameVo
	local var_5_4 = var_3.GetEditor(var_5_3)
	local var_5_5 = arg_5_0._pacGameRunningData

	var_4.SetChapterData(var_5_5, var_5_2)

	local var_5_6 = arg_5_0._pacGameRunningData

	var_4.SetEditor(var_5_6, var_5_4)

	local var_5_7 = arg_5_0._mapController

	var_4.Prepare(var_5_7)

	local var_5_8 = arg_5_0._movingController

	var_4.Prepare(var_5_8)

	local var_5_9 = arg_5_0._roleController

	var_4.Prepare(var_5_9)

	local var_5_10 = arg_5_0._enemyController

	var_4.Prepare(var_5_10)

	local var_5_11 = arg_5_0._itemController

	var_4.Prepare(var_5_11)

	local var_5_12 = arg_5_0._editorController

	var_4.Prepare(var_5_12)

	return
end

function var_0_0.Start(arg_6_0)
	arg_6_0:ShowContainer(true)

	local var_6_0 = arg_6_0._mapController

	var_1.Start(var_6_0)

	local var_6_1 = arg_6_0._movingController

	var_1.Start(var_6_1)

	local var_6_2 = arg_6_0._roleController

	var_1.Start(var_6_2)

	local var_6_3 = arg_6_0._enemyController

	var_1.Start(var_6_3)

	local var_6_4 = arg_6_0._itemController

	var_1.Start(var_6_4)

	local var_6_5 = arg_6_0._editorController

	var_1.Start(var_6_5)

	return
end

function var_0_0.Step(arg_7_0)
	local var_7_0 = arg_7_0._gameVo
	local var_7_1 = var_1.GetDeltaTime(var_7_0)
	local var_7_2 = arg_7_0._gameVo
	local var_7_3 = var_2.GetJoyStickData(var_7_2)
	local var_7_4 = arg_7_0._pacGameRunningData

	var_3.SetJoyData(var_7_4, var_7_3)

	local var_7_5 = arg_7_0._mapController

	var_3.Step(var_7_5, var_7_1)

	local var_7_6 = arg_7_0._movingController

	var_3.Step(var_7_6, var_7_1)

	local var_7_7 = arg_7_0._roleController

	var_3.Step(var_7_7, var_7_1)

	local var_7_8 = arg_7_0._enemyController

	var_3.Step(var_7_8, var_7_1)

	local var_7_9 = arg_7_0._itemController

	var_3.Step(var_7_9, var_7_1)

	local var_7_10 = arg_7_0._editorController

	var_3.Step(var_7_10, var_7_1)

	return
end

function var_0_0.Clear(arg_8_0)
	local var_8_0 = arg_8_0._mapController

	var_1.Clear(var_8_0)

	local var_8_1 = arg_8_0._movingController

	var_1.Clear(var_8_1)

	local var_8_2 = arg_8_0._roleController

	var_1.Clear(var_8_2)

	local var_8_3 = arg_8_0._enemyController

	var_1.Clear(var_8_3)

	local var_8_4 = arg_8_0._itemController

	var_1.Clear(var_8_4)

	local var_8_5 = arg_8_0._pacGameRunningData

	var_1.Clear(var_8_5)

	local var_8_6 = arg_8_0._editorController

	var_1.Clear(var_8_6)

	return
end

function var_0_0.Stop(arg_9_0)
	local var_9_0 = arg_9_0._mapController

	var_1.Stop(var_9_0)

	local var_9_1 = arg_9_0._movingController

	var_1.Stop(var_9_1)

	local var_9_2 = arg_9_0._roleController

	var_1.Stop(var_9_2)

	local var_9_3 = arg_9_0._enemyController

	var_1.Stop(var_9_3)

	local var_9_4 = arg_9_0._itemController

	var_1.Stop(var_9_4)

	local var_9_5 = arg_9_0._editorController

	var_1.Stop(var_9_5)

	return
end

function var_0_0.Resume(arg_10_0)
	local var_10_0 = arg_10_0._mapController

	var_1.Resume(var_10_0)

	local var_10_1 = arg_10_0._movingController

	var_1.Resume(var_10_1)

	local var_10_2 = arg_10_0._roleController

	var_1.Resume(var_10_2)

	local var_10_3 = arg_10_0._enemyController

	var_1.Resume(var_10_3)

	local var_10_4 = arg_10_0._itemController

	var_1.Resume(var_10_4)

	local var_10_5 = arg_10_0._editorController

	var_1.Resume(var_10_5)

	return
end

function var_0_0.Dispose(arg_11_0)
	local var_11_0 = arg_11_0._mapController

	var_1.Dispose(var_11_0)

	local var_11_1 = arg_11_0._movingController

	var_1.Dispose(var_11_1)

	local var_11_2 = arg_11_0._roleController

	var_1.Dispose(var_11_2)

	local var_11_3 = arg_11_0._enemyController

	var_1.Dispose(var_11_3)

	local var_11_4 = arg_11_0._itemController

	var_1.Dispose(var_11_4)

	local var_11_5 = arg_11_0._editorController

	var_1.Dispose(var_11_5)

	local var_11_6 = arg_11_0._pacGameRunningData

	var_1.Dispose(var_11_6)

	arg_11_0._pacGameRunningData = nil

	return
end

return var_0_0
