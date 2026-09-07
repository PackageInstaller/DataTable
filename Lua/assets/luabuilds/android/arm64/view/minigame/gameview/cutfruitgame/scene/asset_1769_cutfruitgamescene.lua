local CutFruitGameScene = class("CutFruitGameScene")

CutFruitGameScene.GET_SCORE = "CutFruitGameScene:get_score"

function CutFruitGameScene:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3
	self._sceneMask = findTF(self._tf, "sceneMask")
	self._sceneContainer = findTF(self._tf, "sceneMask/sceneContainer")

	function self._eventCallback(arg_2_0, arg_2_1, arg_2_2)
		self:onEventHandle(arg_2_0, arg_2_1, arg_2_2)

		return
	end

	self._cutFruitGameRunningData = CutFruitGameRunningData.New()

	self:ShowContainer(false)
	self._event:bind(CutFruitGameView.EVENT_DIRECT, function(arg_3_0, arg_3_1, arg_3_2)
		self._gameController:InputDirect(arg_3_1)

		return
	end)

	self._gameController = CutFruitGameController.New(findTF(self._sceneContainer, "scene/content"), self._event, self._cutFruitGameRunningData)

	return
end

function CutFruitGameScene:onEventHandle(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == CutFruitGameScene.GET_SCORE then
		self._event:emit(SimpleMGEvent.ADD_SCORE, {
			num = arg_4_2
		})
	end

	return
end

function CutFruitGameScene:ShowContainer(arg_5_1)
	setActive(self._sceneMask, arg_5_1)

	return
end

function CutFruitGameScene:Prepare(arg_6_1)
	self._cutFruitGameRunningData:SetChapterConfig(CutFruitGameConst.chapter_data[self._gameVo:GetGameRound()])
	self._cutFruitGameRunningData:SetCharData(arg_6_1)
	self._gameController:Prepare()

	return
end

function CutFruitGameScene:Start()
	self:ShowContainer(true)
	self._gameController:Start()

	return
end

function CutFruitGameScene:Step()
	self._gameController:Step((self._gameVo:GetDeltaTime()))

	return
end

function CutFruitGameScene:Clear()
	self._gameController:Clear()

	return
end

function CutFruitGameScene:Stop()
	self._gameController:Stop()

	return
end

function CutFruitGameScene:Resume()
	self._gameController:Resume()

	return
end

function CutFruitGameScene:GameOver()
	self._gameController:GameOver()

	return
end

function CutFruitGameScene:Dispose()
	self._cutFruitGameRunningData:Dispose()

	self._cutFruitGameRunningData = nil

	return
end

return CutFruitGameScene
