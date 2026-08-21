local var_0_0 = class("SortGameScene")

var_0_0.GET_SCORE = "SortGameScene:get_score"
var_0_0.REMOVE_ITEM = "SortGameScene:remove_item"

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

	arg_1_0._sortGameRunningData = SortGameRunningData.New()
	arg_1_0._gridController = SortGameGridController.New(findTF(arg_1_0._sceneContainer, "scene/content"), arg_1_0._event, arg_1_0._sortGameRunningData)

	arg_1_0:ShowContainer(false)

	return
end

function var_0_0.onEventHandle(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 == var_0_0.GET_SCORE then
		arg_3_0._event:emit(SimpleMGEvent.ADD_SCORE, {
			num = arg_3_2
		})
	end

	return
end

function var_0_0.ShowContainer(arg_4_0, arg_4_1)
	setActive(arg_4_0._sceneMask, arg_4_1)

	return
end

function var_0_0.Prepare(arg_5_0)
	arg_5_0._sortGameRunningData:SetChapterData(SortGameConst.chapter_data[arg_5_0._gameVo:GetGameRound()])
	arg_5_0._gridController:Prepare()
	arg_5_0._event:emit(SortGameView.UPDATE_PLAYER, arg_5_0._sortGameRunningData:GetPlayerPrefab())

	return
end

function var_0_0.Start(arg_6_0)
	arg_6_0:ShowContainer(true)
	arg_6_0._gridController:Start()

	arg_6_0._gameTimeSpeak = false

	return
end

function var_0_0.Step(arg_7_0)
	local var_7_0 = arg_7_0._gameVo:GetTimeInteger()

	if var_7_0 <= SortGameConst.last_speak_time and not arg_7_0._gameTimeSpeak then
		arg_7_0._event:emit(SortGameView.PLAYER_SPEAK, arg_7_0._sortGameRunningData:GetSpeakData(SortGameConst.sort_conifg_type_time))

		arg_7_0._gameTimeSpeak = true
	end

	arg_7_0._gridController:Step(arg_7_0._gameVo:GetDeltaTime(), var_7_0)

	return
end

function var_0_0.Clear(arg_8_0)
	arg_8_0._gridController:Clear()

	return
end

function var_0_0.Stop(arg_9_0)
	arg_9_0._gridController:Stop()

	return
end

function var_0_0.Resume(arg_10_0)
	arg_10_0._gridController:Resume()

	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0._sortGameRunningData:Dispose()

	arg_11_0._sortGameRunningData = nil

	arg_11_0._gridController:Dispose()

	return
end

return var_0_0
