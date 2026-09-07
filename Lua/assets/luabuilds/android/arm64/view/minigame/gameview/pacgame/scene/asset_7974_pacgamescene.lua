local PacGameScene = class("PacGameScene")

PacGameScene.GET_SCORE = "PacGameScene:get_score"
PacGameScene.HIT_PLAYER = "PacGameScene:hit_player"

function PacGameScene:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3
	self._sceneMask = findTF(self._tf, "sceneMask")
	self._sceneContainer = findTF(self._tf, "sceneMask/sceneContainer")

	function self._eventCallback(arg_2_0, arg_2_1, arg_2_2)
		self:onEventHandle(arg_2_0, arg_2_1, arg_2_2)

		return
	end

	self._pacGameRunningData = PacGameRunningData.New()

	self._pacGameRunningData:SetTpl(findTF(self._tf, "tpl"))
	self:ShowContainer(false)

	self._mapController = PacGameMapController.New(self._sceneMask, self._eventCallback, self._pacGameRunningData)
	self._movingController = PacGameMovingController.New(self._sceneMask, self._eventCallback, self._pacGameRunningData)
	self._roleController = PacGameRoleController.New(self._sceneMask, self._eventCallback, self._pacGameRunningData)
	self._enemyController = PacGameEnemyController.New(self._sceneMask, self._eventCallback, self._pacGameRunningData)
	self._itemController = PacGameItemController.New(self._sceneMask, self._eventCallback, self._pacGameRunningData)
	self._editorController = PacGameEditorController.New(self._sceneMask, self._eventCallback, self._pacGameRunningData)

	return
end

function PacGameScene:onEventHandle(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 == PacGameScene.GET_SCORE then
		self._event:emit(SimpleMGEvent.ADD_SCORE, {
			num = arg_3_2
		})
	elseif arg_3_1 == PacGameScene.HIT_PLAYER then
		self._event:emit(SimpleMGEvent.GAME_OVER)
	end

	return
end

function PacGameScene:ShowContainer(arg_4_1)
	setActive(self._sceneMask, arg_4_1)

	return
end

function PacGameScene:Prepare()
	local var_5_0 = self._gameVo:GetGameRound()

	print("round id = " .. var_5_0)
	self._pacGameRunningData:SetChapterData(PacGameConst.chapter_data[var_5_0])
	self._pacGameRunningData:SetEditor((self._gameVo:GetEditor()))
	self._mapController:Prepare()
	self._movingController:Prepare()
	self._roleController:Prepare()
	self._enemyController:Prepare()
	self._itemController:Prepare()
	self._editorController:Prepare()

	return
end

function PacGameScene:Start()
	self:ShowContainer(true)
	self._mapController:Start()
	self._movingController:Start()
	self._roleController:Start()
	self._enemyController:Start()
	self._itemController:Start()
	self._editorController:Start()

	return
end

function PacGameScene:Step()
	local var_7_0 = self._gameVo:GetDeltaTime()

	self._pacGameRunningData:SetJoyData((self._gameVo:GetJoyStickData()))
	self._mapController:Step(var_7_0)
	self._movingController:Step(var_7_0)
	self._roleController:Step(var_7_0)
	self._enemyController:Step(var_7_0)
	self._itemController:Step(var_7_0)
	self._editorController:Step(var_7_0)

	return
end

function PacGameScene:Clear()
	self._mapController:Clear()
	self._movingController:Clear()
	self._roleController:Clear()
	self._enemyController:Clear()
	self._itemController:Clear()
	self._pacGameRunningData:Clear()
	self._editorController:Clear()

	return
end

function PacGameScene:Stop()
	self._mapController:Stop()
	self._movingController:Stop()
	self._roleController:Stop()
	self._enemyController:Stop()
	self._itemController:Stop()
	self._editorController:Stop()

	return
end

function PacGameScene:Resume()
	self._mapController:Resume()
	self._movingController:Resume()
	self._roleController:Resume()
	self._enemyController:Resume()
	self._itemController:Resume()
	self._editorController:Resume()

	return
end

function PacGameScene:Dispose()
	self._mapController:Dispose()
	self._movingController:Dispose()
	self._roleController:Dispose()
	self._enemyController:Dispose()
	self._itemController:Dispose()
	self._editorController:Dispose()
	self._pacGameRunningData:Dispose()

	self._pacGameRunningData = nil

	return
end

return PacGameScene
