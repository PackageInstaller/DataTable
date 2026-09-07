local WatermelonGameScene = class("WatermelonGameScene")

function WatermelonGameScene:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3
	self.sceneMask = findTF(self._tf, "sceneMask")
	self.sceneContainer = findTF(self._tf, "sceneMask/sceneContainer")

	self:showContainer(false)

	self.physicsCtrl = WatermelonCollisionCtrl.New(self.contextData, self._event)
	self.ballCtrl = WatermelonBallCtrl.New(findTF(self.sceneContainer, "scene/content/physics_content"), self.contextData, self._event)

	self.physicsCtrl:setGameVo(self._gameVo)
	self.ballCtrl:setGameVo(self._gameVo)
	self._event:bind(WatermelonGameEvent.CLICK_DOWN, function(arg_2_0, arg_2_1, arg_2_2)
		self.ballCtrl:dropBall()

		return
	end)
	self._event:bind(WatermelonGameEvent.CLICK_MOVE, function(arg_3_0, arg_3_1, arg_3_2)
		self.ballCtrl:moveWorld(arg_3_1)

		return
	end)

	return
end

function WatermelonGameScene:start()
	self:showContainer(true)
	self.physicsCtrl:start()
	self.ballCtrl:start()

	return
end

function WatermelonGameScene:step(arg_5_1)
	self.physicsCtrl:step(arg_5_1)
	self.ballCtrl:step(arg_5_1)

	return
end

function WatermelonGameScene:clear()
	self.physicsCtrl:clear()
	self.ballCtrl:clear()

	return
end

function WatermelonGameScene:stop()
	self.physicsCtrl:stop()
	self.ballCtrl:stop()

	return
end

function WatermelonGameScene:resume()
	self.physicsCtrl:resume()
	self.ballCtrl:resume()

	return
end

function WatermelonGameScene:dispose()
	self.physicsCtrl:dispose()
	self.ballCtrl:dispose()

	return
end

function WatermelonGameScene:showContainer(arg_10_1)
	setActive(self.sceneMask, arg_10_1)

	return
end

return WatermelonGameScene
