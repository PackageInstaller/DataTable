class = var_0_10000

local var_0_0 = var_0_10000("SortGameScene")

var_0_0.GET_SCORE = "SortGameScene:get_score"
var_0_0.REMOVE_ITEM = "SortGameScene:remove_item"

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

	SortGameRunningData = var_4
	arg_1_0._sortGameRunningData = var_4.New()
	SortGameGridController = var_4

	local var_1_0 = var_4.New

	findTF = var_6
	arg_1_0._gridController = var_1_0(var_6(arg_1_0._sceneContainer, "scene/content"), arg_1_0._event, arg_1_0._sortGameRunningData)

	arg_1_0:ShowContainer(false)

	return
end

function var_0_0.onEventHandle(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 == var_0_0.GET_SCORE then
		local var_3_0 = arg_3_0._event
		local var_3_1 = var_4.emit

		SimpleMGEvent = var_1_10007

		var_3_1(var_3_0, var_1_10007.ADD_SCORE, {
			num = arg_3_2
		})
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

	SortGameConst = var_1_10002

	local var_5_2 = var_1_10002.chapter_data[var_5_1]
	local var_5_3 = arg_5_0._sortGameRunningData

	var_3.SetChapterData(var_5_3, var_5_2)

	local var_5_4 = arg_5_0._gridController

	var_3.Prepare(var_5_4)

	local var_5_5 = arg_5_0._event
	local var_5_6 = var_3.emit

	SortGameView = var_6

	local var_5_7 = var_6.UPDATE_PLAYER
	local var_5_8 = arg_5_0._sortGameRunningData

	var_5_6(var_5_5, var_5_7, var_7.GetPlayerPrefab(var_5_8))

	return
end

function var_0_0.Start(arg_6_0)
	arg_6_0:ShowContainer(true)

	local var_6_0 = arg_6_0._gridController

	var_1.Start(var_6_0)

	arg_6_0._gameTimeSpeak = false

	return
end

function var_0_0.Step(arg_7_0)
	local var_7_0 = arg_7_0._gameVo
	local var_7_1 = var_1.GetDeltaTime(var_7_0)
	local var_7_2 = arg_7_0._gameVo
	local var_7_3 = var_2.GetTimeInteger(var_7_2)

	SortGameConst = var_7_0

	if var_7_3 <= var_7_0.last_speak_time and not arg_7_0._gameTimeSpeak then
		local var_7_4 = arg_7_0._event
		local var_7_5 = var_3.emit

		SortGameView = var_1_10006

		local var_7_6 = var_1_10006.PLAYER_SPEAK
		local var_7_7 = arg_7_0._sortGameRunningData
		local var_7_8 = var_7.GetSpeakData

		SortGameConst = var_1_10010

		var_7_5(var_7_4, var_7_6, var_7_8(var_7_7, var_1_10010.sort_conifg_type_time))

		arg_7_0._gameTimeSpeak = true
	end

	local var_7_9 = arg_7_0._gridController

	var_3.Step(var_7_9, var_7_1, var_7_3)

	return
end

function var_0_0.Clear(arg_8_0)
	local var_8_0 = arg_8_0._gridController

	var_1.Clear(var_8_0)

	return
end

function var_0_0.Stop(arg_9_0)
	local var_9_0 = arg_9_0._gridController

	var_1.Stop(var_9_0)

	return
end

function var_0_0.Resume(arg_10_0)
	local var_10_0 = arg_10_0._gridController

	var_1.Resume(var_10_0)

	return
end

function var_0_0.Dispose(arg_11_0)
	local var_11_0 = arg_11_0._sortGameRunningData

	var_1.Dispose(var_11_0)

	arg_11_0._sortGameRunningData = nil

	local var_11_1 = arg_11_0._gridController

	var_1.Dispose(var_11_1)

	return
end

return var_0_0
