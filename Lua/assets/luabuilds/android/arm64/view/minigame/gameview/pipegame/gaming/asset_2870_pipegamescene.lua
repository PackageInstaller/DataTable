local PipeGameScene = class("PipeGameScene")
local var_0_5

function PipeGameScene:Ctor(arg_1_1, arg_1_2)
	var_0_5 = PipeGameVo
	self._tf = arg_1_1
	self._event = arg_1_2
	self.sceneMask = findTF(self._tf, "sceneMask")
	self.sceneContent = findTF(self._tf, "sceneMask/sceneContainer")
	self._moveAnimator = GetComponent(self.sceneContent, typeof(Animator))
	self._bgRight = findTF(self.sceneContent, "scene_background/content/bgRight")
	self._bgRightAnimator = GetComponent(findTF(self._bgRight, "img"), typeof(Animator))

	local function var_1_0(arg_2_0, arg_2_1)
		if arg_2_0 == PipeGameEvent.REMOVE_RECT_TOP then
			self.rectCtrl:removeTopRectData()
		elseif arg_2_0 == PipeGameEvent.PALY_ANIMATION_COMPLETE then
			var_0_5.scoreNum = self.mapCtrl:getSuccessCount()

			self:playMove(function()
				self._event:emit(PipeGameEvent.GAME_OVER)

				return
			end)
		elseif arg_2_0 == PipeGameEvent.STOP_RECT_DRAG then
			self.rectCtrl:stopTopDrag()
		elseif arg_2_0 == PipeGameEvent.SET_TOP_RECT then
			self.mapCtrl:setClickTempItem((self.rectCtrl:getTopData()))
		elseif arg_2_0 == PipeGameEvent.START_SETTLEMENT then
			var_0_5.startSettlement = true
		end

		return
	end

	self.mapCtrl = PipeMapControl.New(findTF(self.sceneContent, "scene/content/map"), var_1_0)
	self.rectCtrl = PipeRectControll.New(findTF(self.sceneContent, "scene/content/rect"), findTF(self.sceneContent, "scene/content/dragPos"), var_1_0)
	self.passCtrl = PiPePassTest.New(findTF(self.sceneContent, "scene/content/passTest"), function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		if self.mapCtrl then
			self.passCtrl:setPassDesc((self.mapCtrl:checkItemSuccess(arg_4_0, arg_4_1, arg_4_2, arg_4_3)))
		end

		return
	end)

	self.passCtrl:setVisible(false)
	self:showContainer(false)

	return
end

function PipeGameScene:start()
	self:showContainer(true)
	self:resetScene()
	self.mapCtrl:start()
	self.rectCtrl:start()

	return
end

function PipeGameScene:step(arg_6_1)
	self.mapCtrl:step()
	self.rectCtrl:step()

	return
end

function PipeGameScene:clear()
	self.mapCtrl:clear()
	self.rectCtrl:clear()

	return
end

function PipeGameScene:stop()
	self.mapCtrl:stop()
	self.rectCtrl:stop()

	return
end

function PipeGameScene:resume()
	self.mapCtrl:resume()
	self.rectCtrl:resume()

	return
end

function PipeGameScene:setGameOver()
	self.mapCtrl:startOverAniamtion()

	return
end

function PipeGameScene:dispose()
	self.mapCtrl:dispose()
	self.rectCtrl:dispose()
	self.passCtrl:dispose()

	if LeanTween.isTweening(go(self.sceneContent)) then
		LeanTween.cancel(go(self.sceneContent))
	end

	return
end

function PipeGameScene:resetScene()
	setActive(self._bgRight, false)
	self._moveAnimator:SetTrigger("reset")

	return
end

function PipeGameScene:playMove(arg_13_1)
	setActive(self._bgRight, true)
	self._bgRightAnimator:SetTrigger(tostring((var_0_5.GetResultLevel())))
	self._moveAnimator:SetTrigger("move")
	LeanTween.delayedCall(go(self.sceneContent), 5, System.Action(function()
		if arg_13_1 then
			arg_13_1()
		end

		return
	end))

	return
end

function PipeGameScene:showContainer(arg_15_1)
	setActive(self.sceneMask, arg_15_1)

	return
end

function PipeGameScene:press(arg_16_1, arg_16_2)
	return
end

function PipeGameScene:joystickActive(arg_17_1)
	return
end

return PipeGameScene
