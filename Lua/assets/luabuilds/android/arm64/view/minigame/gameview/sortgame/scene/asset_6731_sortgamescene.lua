local SortGameScene = class("SortGameScene")

SortGameScene.GET_SCORE = "SortGameScene:get_score"
SortGameScene.REMOVE_ITEM = "SortGameScene:remove_item"

function SortGameScene:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3
	self._sceneMask = findTF(self._tf, "sceneMask")
	self._sceneContainer = findTF(self._tf, "sceneMask/sceneContainer")

	function self._eventCallback(arg_2_0, arg_2_1, arg_2_2)
		self:onEventHandle(arg_2_0, arg_2_1, arg_2_2)

		return
	end

	self._sortGameRunningData = SortGameRunningData.New()
	self._gridController = SortGameGridController.New(findTF(self._sceneContainer, "scene/content"), self._event, self._sortGameRunningData)

	self:ShowContainer(false)

	return
end

function SortGameScene:onEventHandle(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 == SortGameScene.GET_SCORE then
		self._event:emit(SimpleMGEvent.ADD_SCORE, {
			num = arg_3_2
		})
	end

	return
end

function SortGameScene:ShowContainer(arg_4_1)
	setActive(self._sceneMask, arg_4_1)

	return
end

function SortGameScene:Prepare()
	self._sortGameRunningData:SetChapterData(SortGameConst.chapter_data[self._gameVo:GetGameRound()])
	self._gridController:Prepare()
	self._event:emit(SortGameView.UPDATE_PLAYER, self._sortGameRunningData:GetPlayerPrefab())

	return
end

function SortGameScene:Start()
	self:ShowContainer(true)
	self._gridController:Start()

	self._gameTimeSpeak = false

	return
end

function SortGameScene:Step()
	local var_7_0 = self._gameVo:GetTimeInteger()

	if var_7_0 <= SortGameConst.last_speak_time and not self._gameTimeSpeak then
		self._event:emit(SortGameView.PLAYER_SPEAK, self._sortGameRunningData:GetSpeakData(SortGameConst.sort_conifg_type_time))

		self._gameTimeSpeak = true
	end

	self._gridController:Step(self._gameVo:GetDeltaTime(), var_7_0)

	return
end

function SortGameScene:Clear()
	self._gridController:Clear()

	return
end

function SortGameScene:Stop()
	self._gridController:Stop()

	return
end

function SortGameScene:Resume()
	self._gridController:Resume()

	return
end

function SortGameScene:Dispose()
	self._sortGameRunningData:Dispose()

	self._sortGameRunningData = nil

	self._gridController:Dispose()

	return
end

return SortGameScene
