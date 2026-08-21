local var_0_0 = class("CutFruitGameScene")

var_0_0.GET_SCORE = "CutFruitGameScene:get_score"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3
	arg_1_0._sceneMask = findTF(arg_1_0._tf, "sceneMask")
	arg_1_0._sceneContainer = findTF(arg_1_0._tf, "sceneMask/sceneContainer")

	function arg_1_0._eventCallback(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:onEventHandle(arg_2_0, arg_2_1, arg_2_2)

		return
	end

	arg_1_0._cutFruitGameRunningData = CutFruitGameRunningData.New()

	arg_1_0:ShowContainer(false)
	arg_1_0._event:bind(CutFruitGameView.EVENT_DIRECT, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0._gameController:InputDirect(arg_3_1)

		return
	end)

	arg_1_0._gameController = CutFruitGameController.New(findTF(arg_1_0._sceneContainer, "scene/content"), arg_1_0._event, arg_1_0._cutFruitGameRunningData)

	return
end

function var_0_0.onEventHandle(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == var_0_0.GET_SCORE then
		arg_4_0._event:emit(SimpleMGEvent.ADD_SCORE, {
			num = arg_4_2
		})
	end

	return
end

function var_0_0.ShowContainer(arg_5_0, arg_5_1)
	setActive(arg_5_0._sceneMask, arg_5_1)

	return
end

function var_0_0.Prepare(arg_6_0, arg_6_1)
	arg_6_0._cutFruitGameRunningData:SetChapterConfig(CutFruitGameConst.chapter_data[arg_6_0._gameVo:GetGameRound()])
	arg_6_0._cutFruitGameRunningData:SetCharData(arg_6_1)
	arg_6_0._gameController:Prepare()

	return
end

function var_0_0.Start(arg_7_0)
	arg_7_0:ShowContainer(true)
	arg_7_0._gameController:Start()

	return
end

function var_0_0.Step(arg_8_0)
	arg_8_0._gameController:Step((arg_8_0._gameVo:GetDeltaTime()))

	return
end

function var_0_0.Clear(arg_9_0)
	arg_9_0._gameController:Clear()

	return
end

function var_0_0.Stop(arg_10_0)
	arg_10_0._gameController:Stop()

	return
end

function var_0_0.Resume(arg_11_0)
	arg_11_0._gameController:Resume()

	return
end

function var_0_0.GameOver(arg_12_0)
	arg_12_0._gameController:GameOver()

	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0._cutFruitGameRunningData:Dispose()

	arg_13_0._cutFruitGameRunningData = nil

	return
end

return var_0_0
