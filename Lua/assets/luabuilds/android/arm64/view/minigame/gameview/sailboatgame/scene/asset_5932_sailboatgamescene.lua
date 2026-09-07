local SailBoatGameScene = class("SailBoatGameScene")
local var_0_5

SailBoatGameScene.random_scene_imgs = {
	{
		content = "scene_background/content/bg_6",
		icon = {
			"06_Deep_Multiply_1",
			"06_Deep_Multiply_2",
			"06_Deep_Multiply_3",
			"06_Deep_Multiply_4",
			"06_Deep_Multiply_5",
			"06_Deep_Multiply_6",
			"06_Deep_Multiply_7"
		}
	}
}

function SailBoatGameScene:Ctor(arg_1_1, arg_1_2)
	var_0_5 = SailBoatGameVo
	self._tf = arg_1_1
	self._event = arg_1_2
	self.sceneMask = findTF(self._tf, "sceneMask")
	self.sceneContent = findTF(self._tf, "sceneMask/sceneContainer")

	local function var_1_0(arg_2_0, arg_2_1)
		if arg_2_0 == SailBoatGameEvent.DESTROY_ENEMY then
			self:destroyEnemy(arg_2_1)
		elseif arg_2_0 == SailBoatGameEvent.USE_ITEM then
			self._event:emit(SailBoatGameView.ADD_SCORE, {
				num = arg_2_1.score
			})

			if arg_2_1.skill then
				var_0_5.AddSkill()
			end
		elseif arg_2_0 == SailBoatGameEvent.PLAYER_DEAD then
			self._event:emit(SailBoatGameView.GAME_OVER)
		end

		self:onSceneEventCall(arg_2_0, arg_2_1)

		return
	end

	self.charControl = SailBoatCharControl.New(self.sceneContent, var_1_0)
	self.bgControl = SailBoatBgControl.New(self.sceneContent, var_1_0)
	self.itemControl = SailBoatItemControl.New(self.sceneContent, var_1_0)
	self.colliderControl = SailBoatColliderControl.New(self.sceneContent, var_1_0)
	self.enemyControl = SailBoatEnemyControl.New(self.sceneContent, var_1_0)
	self.bulletControl = SailBoatBulletsControl.New(self.sceneContent, var_1_0)
	self.effectControl = SailBoatEffectControl.New(self.sceneContent, var_1_0)
	self.bgRules = {}
	self.bgTfs = {}
	self.bgTfPool = {}

	for iter_1_0 = 1, #SailBoatGameScene.random_scene_imgs do
		table.insert(self.bgRules, {
			time = 0,
			ruleData = SailBoatGameScene.random_scene_imgs[iter_1_0]
		})
	end

	return
end

function SailBoatGameScene:start()
	self:showContainer(true)
	self.charControl:start()
	self.bgControl:start()
	self.itemControl:start()
	self.colliderControl:start()
	self.enemyControl:start()
	self.bulletControl:start()
	self.effectControl:start()

	self.sortIndex = 10
	self.bgImgTpl = var_0_5.GetGameBgTf("bgs/bg_other")

	for iter_3_0 = #self.bgTfs, 1, -1 do
		local var_3_0 = table.remove(self.bgTfs, iter_3_0)

		setActive(var_3_0, false)
		table.insert(self.bgTfPool, var_3_0)
	end

	for iter_3_1 = 1, #self.bgRules do
		self.bgRules[iter_3_1].time = 0
	end

	return
end

function SailBoatGameScene:step(arg_4_1)
	self.charControl:step(arg_4_1)

	local var_4_7 = (os.clock() - os.clock()) * 1000

	self.bgControl:step(arg_4_1)

	local var_4_8 = (os.clock() - os.clock()) * 1000

	self.itemControl:step(arg_4_1)

	local var_4_9 = (os.clock() - os.clock()) * 1000

	self.colliderControl:step(arg_4_1)

	local var_4_10 = (os.clock() - os.clock()) * 1000

	self.enemyControl:step(arg_4_1)

	local var_4_11 = (os.clock() - os.clock()) * 1000

	self.bulletControl:step(arg_4_1)

	local var_4_12 = tostring((os.clock() - os.clock()) * 1000, 2)

	self.effectControl:step(arg_4_1)

	local var_4_13 = (os.clock() - os.clock()) * 1000
	local var_4_14 = os.clock()
	local var_4_15 = var_0_5.GetGameEnemys()
	local var_4_16 = var_0_5.GetGameItems()

	if not self.sortTfs or #self.sortTfs ~= #var_4_15 + 1 + #var_4_16 then
		self.sortTfs = {}

		for iter_4_0 = 1, #var_4_15 do
			table.insert(self.sortTfs, var_4_15[iter_4_0]:getTf())
		end

		for iter_4_1 = 1, #var_4_16 do
			table.insert(self.sortTfs, var_4_16[iter_4_1]:getTf())
		end

		table.insert(self.sortTfs, var_0_5.GetGameChar():getTf())
	end

	if self.sortIndex and self.sortIndex == 0 then
		self:sortItems(self.sortTfs)

		self.sortIndex = 10
	else
		self.sortIndex = self.sortIndex - 1
	end

	for iter_4_2 = 1, #self.bgRules do
		if self.bgRules[iter_4_2].time <= 0 then
			self.bgRules[iter_4_2].time = math.random(30, 45)

			local var_4_17 = self.bgRules[iter_4_2].ruleData.icon[math.random(1, #self.bgRules[iter_4_2].ruleData.icon)]
			local var_4_18

			if #self.bgTfPool > 0 then
				var_4_18 = table.remove(self.bgTfPool, 1)
			else
				var_4_18 = tf(instantiate(self.bgImgTpl))

				SetParent(var_4_18, findTF(self.sceneContent, self.bgRules[iter_4_2].ruleData.content))
			end

			setImageSprite(findTF(var_4_18, "img"), var_0_5.GetBgIcon(var_4_17), true)
			setActive(var_4_18, true)
			table.insert(self.bgTfs, var_4_18)

			var_4_18.anchoredPosition = Vector2(math.random(-300, 300), 2000)
			var_4_18.localEulerAngles = Vector3(0, 0, math.random(1, 360))
		end

		self.bgRules[iter_4_2].time = self.bgRules[iter_4_2].time - arg_4_1
	end

	local var_4_19 = var_0_5.GetSceneSpeed()

	for iter_4_3 = #self.bgTfs, 1, -1 do
		if self.bgTfs[iter_4_3].anchoredPosition.y < -2000 then
			setActive(self.bgTfs[iter_4_3], false)
			table.insert(self.bgTfPool, self.bgTfs[iter_4_3])
			table.remove(self.bgTfs, iter_4_3)
		else
			local var_4_20 = self.bgTfs[iter_4_3].anchoredPosition

			var_4_20.y = self.bgTfs[iter_4_3].anchoredPosition.y + var_4_19.y
			self.bgTfs[iter_4_3].anchoredPosition = var_4_20
		end
	end

	return
end

function SailBoatGameScene:destroyEnemy(arg_5_1)
	self._event:emit(SailBoatGameView.ADD_SCORE, {
		num = arg_5_1.score
	})

	if arg_5_1.boom then
		self:checkBoomDamage(arg_5_1)
	end

	return
end

function SailBoatGameScene:checkBoomDamage(arg_6_1)
	local var_6_0 = var_0_5.GetGameChar()
	local var_6_1 = var_0_5.GetGameEnemys()
	local var_6_2 = var_6_0:getPosition()
	local var_6_3 = var_6_0:getConfig("range")

	if math.abs(arg_6_1.position.x - var_6_2.x) < arg_6_1.range.x + var_6_3.x / 2 and math.abs(arg_6_1.position.y - var_6_2.y) < arg_6_1.range.y + var_6_3.y / 2 then
		var_6_0:damage({
			num = arg_6_1.boom,
			position = arg_6_1.position
		})
	end

	for iter_6_0 = 1, #var_6_1 do
		local var_6_4 = var_6_1[iter_6_0]:getPosition()
		local var_6_5 = var_6_1[iter_6_0]:getConfig("range")

		if math.abs(arg_6_1.position.x - var_6_4.x) < arg_6_1.range.x + var_6_4.x / 2 and math.abs(arg_6_1.position.y - var_6_4.y) < arg_6_1.range.y + var_6_4.y / 2 and var_6_1[iter_6_0]:damage({
			num = arg_6_1.boom,
			position = arg_6_1.position
		}) then
			self:destroyEnemy(var_6_1[iter_6_0]:getDestroyData())
		end
	end

	return
end

function SailBoatGameScene:sortItems(arg_7_1)
	table.sort(arg_7_1, function(arg_8_0, arg_8_1)
		if arg_8_0.anchoredPosition.y > arg_8_1.anchoredPosition.y then
			return false
		elseif arg_8_0.anchoredPosition.y < arg_8_1.anchoredPosition.y then
			return true
		end

		if arg_8_0.anchoredPosition.x > arg_8_1.anchoredPosition.x then
			return false
		elseif arg_8_0.anchoredPosition.x < arg_8_1.anchoredPosition.x then
			return true
		end

		return false
	end)

	for iter_7_0 = 1, #arg_7_1 do
		arg_7_1[iter_7_0]:SetSiblingIndex(0)
	end

	return
end

function SailBoatGameScene:useSkill()
	self.charControl:useSkill()

	return
end

function SailBoatGameScene:clear()
	return
end

function SailBoatGameScene:stop()
	return
end

function SailBoatGameScene:resume()
	return
end

function SailBoatGameScene:onSceneEventCall(arg_13_1, arg_13_2)
	self.charControl:onEventCall(arg_13_1, arg_13_2)
	self.bulletControl:onEventCall(arg_13_1, arg_13_2)
	self.effectControl:onEventCall(arg_13_1, arg_13_2)

	return
end

function SailBoatGameScene:dispose()
	self.charControl:dispose()
	self.bgControl:dispose()
	self.itemControl:dispose()
	self.enemyControl:dispose()

	return
end

function SailBoatGameScene:showContainer(arg_15_1)
	setActive(self.sceneMask, arg_15_1)

	return
end

function SailBoatGameScene:press(arg_16_1, arg_16_2)
	if arg_16_1 == KeyCode.J and arg_16_2 then
		self.charControl:ableFire()
	end

	return
end

function SailBoatGameScene:joystickActive(arg_17_1)
	return
end

return SailBoatGameScene
