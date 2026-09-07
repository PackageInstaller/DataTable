local LaunchBallGameScene = class("LaunchBallGameScene")
local var_0_5 = 90
local var_0_6 = {
	{
		tpl = "pointer01"
	},
	{
		tpl = "pointer02"
	},
	{
		tpl = "pointer03"
	},
	{
		tpl = "pointer04"
	},
	{
		tpl = "pointer05"
	},
	{
		tpl = "pointer06"
	},
	{
		tpl = "pointer07"
	}
}

LaunchBallGameScene.PLAYING_CHANGE = "playing change"
LaunchBallGameScene.FIRE_AMULET = "fire amulet"
LaunchBallGameScene.ENEMY_FINISH = "enemy finish"
LaunchBallGameScene.HIT_ENEMY = "hit enemy"
LaunchBallGameScene.RANDOM_FIRE = "random fire"
LaunchBallGameScene.CHANGE_AMULET = "change amulet"
LaunchBallGameScene.CONCENTRATE_TRIGGER = "concentrate trigger"
LaunchBallGameScene.SLEEP_TIME_TRIGGER = "sleep time trigger"
LaunchBallGameScene.SPILT_ENEMY_SCORE = "spilt enemy score"
LaunchBallGameScene.SPLIT_ALL_ENEMYS = "split all enemys"
LaunchBallGameScene.STOP_ENEMY_TIME = "stop enemy time"
LaunchBallGameScene.SPLIT_BUFF_ENEMY = "split buff enemy"
LaunchBallGameScene.SLASH_ENEMY = "slash enemy"
LaunchBallGameScene.PLAYER_EFFECT = "player effect"

function LaunchBallGameScene:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	self.sceneMask = findTF(self._tf, "sceneMask")
	self.tplContent = findTF(self._tf, "sceneMask/sceneContainer/scene/tpl")
	self.contentBack = findTF(self._tf, "sceneMask/sceneContainer/scene_background/content")
	self.contentMid = findTF(self._tf, "sceneMask/sceneContainer/scene/content")
	self.contentTop = findTF(self._tf, "sceneMask/sceneContainer/scene_front/content")
	self.contentEF = findTF(self._tf, "sceneMask/sceneContainer/scene/effect_front")
	self.playerContent = findTF(self.contentTop, "player")
	self.amuletContent = findTF(self.contentTop, "amulet")
	self.amuletsContent = findTF(self.contentTop, "amulets")
	self.amuletLifeContent = findTF(self.contentTop, "amuletLifeContent")
	self.enemyContent = findTF(self.contentMid, "enemy")
	self.lineContent = findTF(self.contentMid, "line")
	self.joyStick = LaunchBallGameJoyStick.New(findTF(self.contentTop, "joyStick"))

	self.joyStick:setActiveCallback(function(arg_2_0)
		self:joystickActive(arg_2_0)

		return
	end)

	local function var_1_0(arg_3_0, arg_3_1)
		self.launchBallAmulet:eventCall(arg_3_0, arg_3_1)
		self.launchBallPlayer:eventCall(arg_3_0, arg_3_1)
		self.launchBallEnemy:eventCall(arg_3_0, arg_3_1)

		if arg_3_0 == LaunchBallGameScene.ENEMY_FINISH then
			self._event:emit(LaunchBallGameView.GAME_OVER)
		elseif arg_3_0 == LaunchBallGameScene.SPILT_ENEMY_SCORE then
			self._event:emit(LaunchBallGameView.ADD_SCORE, arg_3_1)
		elseif arg_3_0 == LaunchBallGameScene.SLASH_ENEMY then
			self.timeSlashDirect = arg_3_1.direct
			self.timeSlash = arg_3_1.time
		end

		return
	end

	local var_1_1 = Clone(LaunchBallGameConst.map_data[LaunchBallGameVo.gameRoundData.map].map)
	local var_1_2 = findTF(self.contentBack, "bg")
	local var_1_3 = findTF(self.contentTop, "bg")

	for iter_1_0 = 0, var_1_2.childCount - 1 do
		local var_1_4 = var_1_2:GetChild(iter_1_0)

		setActive(var_1_4, var_1_4.name == var_1_1)
	end

	for iter_1_1 = 0, var_1_3.childCount - 1 do
		local var_1_5 = var_1_3:GetChild(iter_1_1)

		setActive(var_1_5, var_1_5.name == var_1_1)
	end

	for iter_1_2 = 0, self.lineContent.childCount - 1 do
		setActive(self.lineContent:GetChild(iter_1_2), false)
	end

	self.launchBallAmulet = LaunchBallAmulet.New(self.amuletContent, self.amuletsContent, self.amuletLifeContent, self.tplContent, var_1_0)
	self.launchBallPlayer = LaunchBallPlayerControl.New(self.contentTop, self.playerContent, self.tplContent, var_1_0)
	self.launchBallEnemy = LaunchBallEnemy.New(self.enemyContent, self.lineContent, self.tplContent, var_1_0)
	self.pointerContent = self.pointerContent or findTF(self.contentTop, "pointer")

	if not self.pointerCollider then
		self.pointerCollider = findTF(self.contentTop, "collider")

		setActive(self.pointerCollider, false)
	end

	return
end

local var_0_7 = 50
local var_0_8 = 500 / 50

function LaunchBallGameScene:start()
	self:prepareScene()
	self.launchBallAmulet:start()
	self.launchBallPlayer:start()
	self.launchBallEnemy:start()

	self.pointerRotation = Vector3(0, 0, 0)
	self.pointerPosition = Vector2(0, 0)

	for iter_4_0 = 0, self.pointerContent.childCount - 1 do
		setActive(self.pointerContent:GetChild(iter_4_0), false)
	end

	self.timeSlash = nil

	return
end

function LaunchBallGameScene:step()
	self.joyStick:step()

	LaunchBallGameVo.joyStickData = self.joyStick:getValue()

	self.launchBallAmulet:step()
	self.launchBallPlayer:step()
	self.launchBallEnemy:step()

	local var_5_0 = self.launchBallAmulet:getAngle()

	if var_5_0 < 0 and self.lastContent ~= self.amuletContent then
		self.amuletContent:SetAsLastSibling()
		self.amuletsContent:SetAsFirstSibling()

		self.lastContent = self.amuletContent
	elseif var_5_0 > 0 and self.lastContent ~= self.playerContent then
		self.amuletContent:SetAsFirstSibling()
		self.amuletsContent:SetAsLastSibling()

		self.lastContent = self.playerContent
	end

	if self.timeSlash and self.timeSlash > 0 then
		self.timeSlash = self.timeSlash - LaunchBallGameVo.deltaTime

		if self.timeSlash <= 0 then
			self.timeSlash = nil

			local var_5_1 = GetComponent(findTF(self.contentTop, "effect/SlashBound/ad/" .. self.timeSlashDirect), typeof(BoxCollider2D))
			local var_5_2 = self.launchBallEnemy:getEnemysInBounds(var_5_1.bounds.min, var_5_1.bounds.max)

			for iter_5_0 = 1, #var_5_2 do
				var_5_2[iter_5_0]:hit()
				self._event:emit(LaunchBallGameView.ADD_SCORE, {
					num = LaunchBallGameVo.GetScore(1, 1)
				})
			end

			LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_skill_count, #var_5_2)
		end
	end

	local var_5_3 = self.launchBallAmulet:getFireAmulet()

	for iter_5_1 = #var_5_3, 1, -1 do
		if not var_5_3[iter_5_1].removeFlag and self.launchBallEnemy:checkAmulet(var_5_3[iter_5_1]) then
			var_5_3[iter_5_1].removeFlag = true
		end
	end

	local var_5_5 = self.launchBallAmulet:getButterfly()

	for iter_5_2 = #var_5_5, 1, -1 do
		if not var_5_5[iter_5_2].removeFlag and not var_5_5[iter_5_2].removeTime then
			local var_5_6 = self.launchBallEnemy:checkPositionIn(var_5_5[iter_5_2].tf.position)

			if var_5_6 then
				var_5_5[iter_5_2].removeTime = 0.2
				var_5_5[iter_5_2].speed.x = 0
				var_5_5[iter_5_2].speed.y = 0

				var_5_5[iter_5_2].anim:Play("Hit")
				var_5_6:setTimeRemove()
				self._event:emit(LaunchBallGameView.ADD_SCORE, {
					num = LaunchBallGameVo.GetScore(1, 1)
				})
				LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_pass_skill_count, 1)
			end
		end
	end

	if LaunchBallGameVo.joyStickData.active and LaunchBallGameVo.amulet then
		self.pointerTime = self.pointerTime + LaunchBallGameVo.deltaTime

		if not self.pointerColor then
			for iter_5_3 = 0, self.pointerContent.childCount - 1 do
				local var_5_8 = self.pointerContent:GetChild(iter_5_3)

				if var_5_8.name == var_0_6[LaunchBallGameVo.amulet.color].tpl then
					self.anglePointer = var_5_8
				end

				setActive(var_5_8, false)
			end
		end

		if self.pointerTime > 0.3 and LaunchBallGameVo.joyStickData.active then
			if LaunchBallGameVo.joyStickData.angle and LaunchBallGameVo.joyStickData.rad then
				self.pointerRotation.z = LaunchBallGameVo.joyStickData.angle + var_0_5
				self.anglePointer.localEulerAngles = self.pointerRotation

				setActive(self.anglePointer, true)

				local var_5_9 = 0

				for iter_5_4 = 1, var_0_8 do
					var_5_9 = iter_5_4 * var_0_7
					self.pointerPosition.x = math.cos(LaunchBallGameVo.joyStickData.rad) * (iter_5_4 * var_0_7)
					self.pointerPosition.y = math.sin(LaunchBallGameVo.joyStickData.rad) * var_5_9

					if self.launchBallEnemy:checkWorldInEnemy((self.pointerContent:TransformPoint(self.pointerPosition))) then
						break
					end
				end

				for iter_5_5 = 1, 4 do
					self.pointerPosition.x = 0
					self.pointerPosition.y = (5 - iter_5_5) / 4 * var_5_9 * -1
					findTF(self.anglePointer, "ad/" .. iter_5_5).anchoredPosition = self.pointerPosition
				end
			end
		end
	else
		self.pointerTime = 0
		self.pointerColor = nil

		if self.anglePointer then
			setActive(self.anglePointer, false)
		end
	end

	return
end

function LaunchBallGameScene:clear()
	self.launchBallAmulet:clear()
	self.launchBallPlayer:clear()
	self.launchBallEnemy:clear()

	return
end

function LaunchBallGameScene:stop()
	return
end

function LaunchBallGameScene:resume()
	return
end

function LaunchBallGameScene:dispose()
	return
end

function LaunchBallGameScene:prepareScene()
	self:showContainer(true)

	return
end

function LaunchBallGameScene:showContainer(arg_11_1)
	setActive(self.sceneMask, arg_11_1)

	return
end

function LaunchBallGameScene:useSkill()
	self.launchBallPlayer:useSkill()

	return
end

function LaunchBallGameScene:press(arg_13_1)
	self.launchBallEnemy:press(arg_13_1)

	return
end

function LaunchBallGameScene:joystickActive(arg_14_1)
	self.launchBallPlayer:joystickActive(arg_14_1)

	return
end

return LaunchBallGameScene
