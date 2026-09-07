local TouchCakeScene = class("TouchCakeScene")
local var_0_5

TouchCakeScene.EVENT_ACTION_PROP = "event action prop"
TouchCakeScene.EVENT_ACTION_CAKE = "event action cake"
TouchCakeScene.EVENT_ACTION_WIELD = "event action wield"

function TouchCakeScene:Ctor(arg_1_1, arg_1_2)
	var_0_5 = TouchCakeGameVo
	self._tf = arg_1_1
	self._event = arg_1_2
	self.sceneMask = findTF(self._tf, "sceneMask")
	self.sceneContent = findTF(self._tf, "sceneMask/sceneContainer")

	local function var_1_0(arg_2_0, arg_2_1, arg_2_2)
		self:onSceneEventCall(arg_2_0, arg_2_1, arg_2_2)

		return
	end

	self:showContainer(false)

	self.cakeController = TouchCakeTowerController.New(findTF(self.sceneContent, "scene/content/cakeContent"), var_1_0)
	self.charController = TouchCakeCharController.New(findTF(self.sceneContent, "scene/content/charContent"), var_1_0)
	self.effectController = TouchCakeEffectController.New(findTF(self.sceneContent, "scene/content/effectContent"), var_1_0)

	return
end

function TouchCakeScene:onSceneEventCall(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 == TouchCakeScene.EVENT_ACTION_PROP then
		if arg_3_2.prop.direct == self.charController:getDirect() then
			if arg_3_3 then
				arg_3_3(true)
			end

			if arg_3_2.prop.data.score and arg_3_2.prop.data.score >= 0 then
				self._event:emit(TouchCakeGameEvent.ADD_SCORE, (self:getScore(arg_3_2.prop.data.score, var_0_5.comboNum)))
			end

			if arg_3_2.prop.data.guard and arg_3_2.prop.data.guard > 0 then
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_5.SFX_COUNT_PERFECT)
				self.charController:guard(arg_3_2.prop.data.guard)
			end

			if arg_3_2.prop.data.dizzi and arg_3_2.prop.data.dizzi > 0 and self.charController:dizzi(arg_3_2.prop.data.dizzi) then
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_5.SFX_COUNT_STEP)
				self._event:emit(TouchCakeGameEvent.PLAYER_DIZZI, arg_3_2.prop.data.score)
			end

			if arg_3_2.prop.data.boom and arg_3_2.prop.data.boom > 0 and not self.charController:getGuard() then
				self.effectController:showBoom(arg_3_2.prop.data.boom, 0.1)
				self._event:emit(TouchCakeGameEvent.PLAYER_BOOM)
			end
		elseif arg_3_3 then
			arg_3_3(false)
		end
	elseif arg_3_1 == TouchCakeScene.EVENT_ACTION_WIELD then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_5.SFX_COUNT_THROW)
		self.cakeController:touchBottomCake(arg_3_2, arg_3_3)
	elseif arg_3_1 == TouchCakeScene.EVENT_ACTION_CAKE then
		if arg_3_2.cake.score and arg_3_2.cake.score >= 0 then
			self._event:emit(TouchCakeGameEvent.ADD_COMBO)
			self._event:emit(TouchCakeGameEvent.ADD_SCORE, (self:getScore(arg_3_2.cake.score, var_0_5.comboNum)))
		end
	end

	return
end

function TouchCakeScene:start()
	self.touchTimeCache = -1

	self:showContainer(true)
	self.cakeController:start()
	self.charController:start()
	self.effectController:start()

	return
end

function TouchCakeScene:step()
	if self.touchTimeCache and self.touchTimeCache > 0 then
		self.touchTimeCache = self.touchTimeCache - var_0_5.deltaTime

		if self.touchTimeCache <= 0 then
			self.touchTimeCache = -1

			self:touchDirect(self.touchDirectCache, true)
		end
	end

	self.cakeController:step()
	self.charController:step()
	self.effectController:step()

	return
end

function TouchCakeScene:clear()
	return
end

function TouchCakeScene:stop()
	self.cakeController:stop()
	self.charController:stop()
	self.effectController:stop()

	return
end

function TouchCakeScene:resume()
	self.cakeController:resume()
	self.charController:resume()
	self.effectController:resume()

	return
end

function TouchCakeScene:setGameOver()
	return
end

function TouchCakeScene:dispose()
	self.cakeController:dispose()
	self.charController:dispose()

	return
end

function TouchCakeScene:showContainer(arg_11_1)
	setActive(self.sceneMask, arg_11_1)

	return
end

function TouchCakeScene:press(arg_12_1, arg_12_2)
	if arg_12_1 == KeyCode.A and arg_12_2 then
		self:touchDirect(-1, false)
	elseif arg_12_1 == KeyCode.D and arg_12_2 then
		self:touchDirect(1, false)
	end

	return
end

function TouchCakeScene:getScore(arg_13_1, arg_13_2)
	if arg_13_2 <= 0 then
		arg_13_2 = 1
	end

	for iter_13_0 = #TouchCakeGameConst.score_rate_count, 1, -1 do
		if TouchCakeGameConst.score_rate_count[iter_13_0][1] <= arg_13_2 then
			return math.floor(arg_13_1 * TouchCakeGameConst.score_rate_count[iter_13_0][2])
		end
	end

	return arg_13_1
end

function TouchCakeScene:touchDirect(arg_14_1, arg_14_2)
	if not self.charController:getTouchAble() or not self.cakeController:getTouchAble() then
		if not arg_14_2 then
			self.touchTimeCache = 0.1
			self.touchDirectCache = arg_14_1
		end

		return
	end

	self.touchTimeCache = -1

	if arg_14_1 == -1 then
		self.charController:onTouchLeft()
	elseif arg_14_1 == 1 then
		self.charController:onTouchRight()
	end

	return
end

return TouchCakeScene
