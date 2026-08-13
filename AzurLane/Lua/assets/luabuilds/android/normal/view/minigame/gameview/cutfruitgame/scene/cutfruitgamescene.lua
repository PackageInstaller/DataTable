class = var_0_10000

local var_0_0 = var_0_10000("CutFruitGameScene")

var_0_0.GET_SCORE = "CutFruitGameScene:get_score"

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

	CutFruitGameRunningData = var_4
	arg_1_0._cutFruitGameRunningData = var_4.New()

	arg_1_0:ShowContainer(false)

	local var_1_0 = arg_1_0._event
	local var_1_1 = var_4.bind

	CutFruitGameView = var_6

	var_1_1(var_1_0, var_6.EVENT_DIRECT, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0._gameController

		var_3.InputDirect(var_3_0, arg_3_1)

		return
	end)

	CutFruitGameController = var_1_1

	local var_1_2 = var_1_1.New

	findTF = var_1_0
	arg_1_0._gameController = var_1_2(var_1_0(arg_1_0._sceneContainer, "scene/content"), arg_1_0._event, arg_1_0._cutFruitGameRunningData)

	return
end

function var_0_0.onEventHandle(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == var_0_0.GET_SCORE then
		local var_4_0 = arg_4_0._event
		local var_4_1 = var_4.emit

		SimpleMGEvent = var_1_10006

		var_4_1(var_4_0, var_1_10006.ADD_SCORE, {
			num = arg_4_2
		})
	end

	return
end

function var_0_0.ShowContainer(arg_5_0, arg_5_1)
	setActive = var_1_10002

	var_1_10002(arg_5_0._sceneMask, arg_5_1)

	return
end

function var_0_0.Prepare(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._cutFruitGameRunningData
	local var_6_1 = var_2.SetChapterConfig

	CutFruitGameConst = var_1_10004

	local var_6_2 = var_1_10004.chapter_data
	local var_6_3 = arg_6_0._gameVo

	var_6_1(var_6_0, var_6_2[var_5.GetGameRound(var_6_3)])

	local var_6_4 = arg_6_0._cutFruitGameRunningData

	var_2.SetCharData(var_6_4, arg_6_1)

	local var_6_5 = arg_6_0._gameController

	var_2.Prepare(var_6_5)

	return
end

function var_0_0.Start(arg_7_0)
	arg_7_0:ShowContainer(true)

	local var_7_0 = arg_7_0._gameController

	var_1.Start(var_7_0)

	return
end

function var_0_0.Step(arg_8_0)
	local var_8_0 = arg_8_0._gameVo
	local var_8_1 = var_1.GetDeltaTime(var_8_0)
	local var_8_2 = arg_8_0._gameController

	var_2.Step(var_8_2, var_8_1)

	return
end

function var_0_0.Clear(arg_9_0)
	local var_9_0 = arg_9_0._gameController

	var_1.Clear(var_9_0)

	return
end

function var_0_0.Stop(arg_10_0)
	local var_10_0 = arg_10_0._gameController

	var_1.Stop(var_10_0)

	return
end

function var_0_0.Resume(arg_11_0)
	local var_11_0 = arg_11_0._gameController

	var_1.Resume(var_11_0)

	return
end

function var_0_0.GameOver(arg_12_0)
	local var_12_0 = arg_12_0._gameController

	var_1.GameOver(var_12_0)

	return
end

function var_0_0.Dispose(arg_13_0)
	local var_13_0 = arg_13_0._cutFruitGameRunningData

	var_1.Dispose(var_13_0)

	arg_13_0._cutFruitGameRunningData = nil

	return
end

return var_0_0
