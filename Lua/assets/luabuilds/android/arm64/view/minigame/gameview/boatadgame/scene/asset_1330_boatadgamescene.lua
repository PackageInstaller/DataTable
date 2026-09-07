local BoatAdGameScene = class("BoatAdGameScene")
local var_0_5

BoatAdGameScene.random_scene_imgs = {
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

function BoatAdGameScene:Ctor(arg_1_1, arg_1_2)
	var_0_5 = BoatAdGameVo
	self._tf = arg_1_1
	self._event = arg_1_2
	self.sceneMask = findTF(self._tf, "sceneMask")

	setActive(self.sceneMask, false)
	setActive(findTF(self._tf, "tpl"), false)

	self.sceneContent = findTF(self._tf, "sceneMask/sceneContainer")
	self.testPt = findTF(self.sceneContent, "scene_background/content/testPt")

	var_0_5.SetMovePoint(findTF(self.sceneContent, "scene_background/content/leftTop").anchoredPosition, findTF(self.sceneContent, "scene_background/content/leftBottom").anchoredPosition, findTF(self.sceneContent, "scene_background/content/rightTop").anchoredPosition, findTF(self.sceneContent, "scene_background/content/rightBottom").anchoredPosition)

	local function var_1_0(arg_2_0, arg_2_1)
		if arg_2_0 == BoatAdGameEvent.CREATE_ITEM then
			self.itemControl:createItem(arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.CREATE_ENEMY then
			self.enemyControl:createEnemy(arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.PLAYER_DEAD then
			self._event:emit(SimpleMGEvent.GAME_OVER, arg_2_1)
			self:clear()
		elseif arg_2_0 == BoatAdGameEvent.PLAY_AD then
			self._event:emit(BoatAdGameEvent.OPEN_AD_WINDOW)
		elseif arg_2_0 == BoatAdGameEvent.ADD_SCORE then
			self._event:emit(SimpleMGEvent.ADD_SCORE, arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.ADD_GUARD then
			-- block empty
		elseif arg_2_0 == BoatAdGameEvent.SPEED_DOWN then
			self.enemyControl:speedDown(arg_2_1)
		end

		self:onSceneEventCall(arg_2_0, arg_2_1)

		return
	end

	self.charControl = BoatAdCharControl.New(self.sceneContent, var_1_0)
	self.createControl = BoatAdCreateControl.New(self.sceneContent, var_1_0)
	self.itemControl = BoatAdItemControl.New(self.sceneContent, var_1_0)
	self.bgControl = BoatAdBgControl.New(self.sceneContent, var_1_0)
	self.colliderControl = BoatAdColliderControl.New(self.sceneContent, var_1_0)
	self.enemyControl = BoatAdEnemyControl.New(self.sceneContent, var_1_0)

	return
end

function BoatAdGameScene:start()
	self:showContainer(true)
	self.charControl:start()
	self.bgControl:start()
	self.itemControl:start()
	self.colliderControl:start()
	self.enemyControl:start()
	self.createControl:start()

	self.sortIndex = 10

	return
end

function BoatAdGameScene:step(arg_4_1)
	self:checkCharBattle()
	self.charControl:step(arg_4_1)
	self.bgControl:step(arg_4_1)
	self.itemControl:step(arg_4_1)
	self.colliderControl:step(arg_4_1)
	self.enemyControl:step(arg_4_1)
	self.createControl:step(arg_4_1)
	self:sortSceneObject()

	return
end

function BoatAdGameScene:checkCharBattle()
	if var_0_5.char:getBattle() then
		if self.enemyControl:getMoveSpeed() > 0 then
			self.enemyControl:setMoveSpeed(0)
		end

		if self.itemControl:getMoveSpeed() > 0 then
			self.itemControl:setMoveSpeed(0)
		end

		if self.bgControl:getMoveSpeed() > 0 then
			self.bgControl:setMoveSpeed(0)
		end
	else
		if self.enemyControl:getMoveSpeed() == 0 then
			self.enemyControl:setMoveSpeed(1)
		end

		if self.itemControl:getMoveSpeed() == 0 then
			self.itemControl:setMoveSpeed(1)
		end

		if self.bgControl:getMoveSpeed() == 0 then
			self.bgControl:setMoveSpeed(1)
		end
	end

	return
end

function BoatAdGameScene:sortSceneObject()
	local var_6_0 = var_0_5.GetGameEnemys()
	local var_6_1 = var_0_5.GetGameItems()

	if not self.sortTfs or #self.sortTfs ~= #var_6_0 + 1 + #var_6_1 then
		self.sortTfs = {}

		for iter_6_0 = 1, #var_6_0 do
			table.insert(self.sortTfs, var_6_0[iter_6_0])
		end

		for iter_6_1 = 1, #var_6_1 do
			table.insert(self.sortTfs, var_6_1[iter_6_1])
		end

		table.insert(self.sortTfs, (var_0_5.GetGameChar()))
	end

	if self.sortIndex and self.sortIndex == 0 then
		self:sortItems(self.sortTfs)

		self.sortIndex = 10
	else
		self.sortIndex = self.sortIndex - 1
	end

	return
end

function BoatAdGameScene:destroyEnemy(arg_7_1)
	self._event:emit(SimpleMGEvent.ADD_SCORE, {
		num = arg_7_1.score
	})

	return
end

function BoatAdGameScene:sortItems(arg_8_1)
	table.sort(arg_8_1, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0:getTf().anchoredPosition
		local var_9_1 = arg_9_1:getTf().anchoredPosition
		local var_9_2 = arg_9_0:getMoveCount()
		local var_9_3 = arg_9_1:getMoveCount()

		if math.abs(var_9_1.y - var_9_0.y) > 1 then
			if var_9_0.y > var_9_1.y then
				return false
			elseif var_9_0.y < var_9_1.y then
				return true
			end
		end

		if var_9_3 == 3 and var_9_2 ~= 3 then
			return false
		elseif var_9_2 == 3 and var_9_3 ~= 3 then
			return true
		end

		if math.abs(var_9_1.x - var_9_0.x) > 1 then
			if var_9_0.x < var_9_1.x then
				return false
			elseif var_9_0.x > var_9_1.x then
				return true
			end
		end

		return false
	end)

	for iter_8_0 = 1, #arg_8_1 do
		arg_8_1[iter_8_0]:getTf():SetSiblingIndex(0)
	end

	return
end

function BoatAdGameScene:useSkill()
	self.charControl:useSkill()

	return
end

function BoatAdGameScene:clear()
	self.charControl:clear()

	return
end

function BoatAdGameScene:stop()
	self.charControl:stop()
	self.enemyControl:stop()
	self.createControl:stop()
	self.itemControl:stop()
	self.bgControl:stop()

	return
end

function BoatAdGameScene:resume()
	self.charControl:resume()
	self.enemyControl:resume()
	self.createControl:resume()
	self.itemControl:resume()
	self.bgControl:resume()

	return
end

function BoatAdGameScene:onSceneEventCall(arg_14_1, arg_14_2)
	self.charControl:onEventCall(arg_14_1, arg_14_2)

	return
end

function BoatAdGameScene:dispose()
	self.charControl:dispose()
	self.bgControl:dispose()
	self.itemControl:dispose()
	self.enemyControl:dispose()

	return
end

function BoatAdGameScene:showContainer(arg_16_1)
	setActive(self.sceneMask, arg_16_1)

	return
end

function BoatAdGameScene:press(arg_17_1, arg_17_2)
	if arg_17_1 == KeyCode.J and arg_17_2 then
		-- block empty
	end

	return
end

function BoatAdGameScene:joystickActive(arg_18_1)
	return
end

return BoatAdGameScene
