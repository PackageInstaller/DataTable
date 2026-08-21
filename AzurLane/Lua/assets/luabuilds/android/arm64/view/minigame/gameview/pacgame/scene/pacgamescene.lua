local var_0_0 = class("PacGameScene")

var_0_0.GET_SCORE = "PacGameScene:get_score"
var_0_0.HIT_PLAYER = "PacGameScene:hit_player"

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

	arg_1_0._pacGameRunningData = PacGameRunningData.New()

	arg_1_0._pacGameRunningData:SetTpl(findTF(arg_1_0._tf, "tpl"))
	arg_1_0:ShowContainer(false)

	arg_1_0._mapController = PacGameMapController.New(arg_1_0._sceneMask, arg_1_0._eventCallback, arg_1_0._pacGameRunningData)
	arg_1_0._movingController = PacGameMovingController.New(arg_1_0._sceneMask, arg_1_0._eventCallback, arg_1_0._pacGameRunningData)
	arg_1_0._roleController = PacGameRoleController.New(arg_1_0._sceneMask, arg_1_0._eventCallback, arg_1_0._pacGameRunningData)
	arg_1_0._enemyController = PacGameEnemyController.New(arg_1_0._sceneMask, arg_1_0._eventCallback, arg_1_0._pacGameRunningData)
	arg_1_0._itemController = PacGameItemController.New(arg_1_0._sceneMask, arg_1_0._eventCallback, arg_1_0._pacGameRunningData)
	arg_1_0._editorController = PacGameEditorController.New(arg_1_0._sceneMask, arg_1_0._eventCallback, arg_1_0._pacGameRunningData)

	return
end

function var_0_0.onEventHandle(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 == var_0_0.GET_SCORE then
		arg_3_0._event:emit(SimpleMGEvent.ADD_SCORE, {
			num = arg_3_2
		})
	elseif arg_3_1 == var_0_0.HIT_PLAYER then
		arg_3_0._event:emit(SimpleMGEvent.GAME_OVER)
	end

	return
end

function var_0_0.ShowContainer(arg_4_0, arg_4_1)
	setActive(arg_4_0._sceneMask, arg_4_1)

	return
end

function var_0_0.Prepare(arg_5_0)
	local var_5_0 = arg_5_0._gameVo:GetGameRound()

	print("round id = " .. var_5_0)
	arg_5_0._pacGameRunningData:SetChapterData(PacGameConst.chapter_data[var_5_0])
	arg_5_0._pacGameRunningData:SetEditor((arg_5_0._gameVo:GetEditor()))
	arg_5_0._mapController:Prepare()
	arg_5_0._movingController:Prepare()
	arg_5_0._roleController:Prepare()
	arg_5_0._enemyController:Prepare()
	arg_5_0._itemController:Prepare()
	arg_5_0._editorController:Prepare()

	return
end

function var_0_0.Start(arg_6_0)
	arg_6_0:ShowContainer(true)
	arg_6_0._mapController:Start()
	arg_6_0._movingController:Start()
	arg_6_0._roleController:Start()
	arg_6_0._enemyController:Start()
	arg_6_0._itemController:Start()
	arg_6_0._editorController:Start()

	return
end

function var_0_0.Step(arg_7_0)
	local var_7_0 = arg_7_0._gameVo:GetDeltaTime()

	arg_7_0._pacGameRunningData:SetJoyData((arg_7_0._gameVo:GetJoyStickData()))
	arg_7_0._mapController:Step(var_7_0)
	arg_7_0._movingController:Step(var_7_0)
	arg_7_0._roleController:Step(var_7_0)
	arg_7_0._enemyController:Step(var_7_0)
	arg_7_0._itemController:Step(var_7_0)
	arg_7_0._editorController:Step(var_7_0)

	return
end

function var_0_0.Clear(arg_8_0)
	arg_8_0._mapController:Clear()
	arg_8_0._movingController:Clear()
	arg_8_0._roleController:Clear()
	arg_8_0._enemyController:Clear()
	arg_8_0._itemController:Clear()
	arg_8_0._pacGameRunningData:Clear()
	arg_8_0._editorController:Clear()

	return
end

function var_0_0.Stop(arg_9_0)
	arg_9_0._mapController:Stop()
	arg_9_0._movingController:Stop()
	arg_9_0._roleController:Stop()
	arg_9_0._enemyController:Stop()
	arg_9_0._itemController:Stop()
	arg_9_0._editorController:Stop()

	return
end

function var_0_0.Resume(arg_10_0)
	arg_10_0._mapController:Resume()
	arg_10_0._movingController:Resume()
	arg_10_0._roleController:Resume()
	arg_10_0._enemyController:Resume()
	arg_10_0._itemController:Resume()
	arg_10_0._editorController:Resume()

	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0._mapController:Dispose()
	arg_11_0._movingController:Dispose()
	arg_11_0._roleController:Dispose()
	arg_11_0._enemyController:Dispose()
	arg_11_0._itemController:Dispose()
	arg_11_0._editorController:Dispose()
	arg_11_0._pacGameRunningData:Dispose()

	arg_11_0._pacGameRunningData = nil

	return
end

return var_0_0
