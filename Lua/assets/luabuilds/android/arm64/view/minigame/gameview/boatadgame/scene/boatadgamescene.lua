local var_0_0 = class("BoatAdGameScene")
local var_0_5

var_0_0.random_scene_imgs = {
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

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_5 = BoatAdGameVo
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0.sceneMask = findTF(arg_1_0._tf, "sceneMask")

	setActive(arg_1_0.sceneMask, false)
	setActive(findTF(arg_1_0._tf, "tpl"), false)

	arg_1_0.sceneContent = findTF(arg_1_0._tf, "sceneMask/sceneContainer")
	arg_1_0.testPt = findTF(arg_1_0.sceneContent, "scene_background/content/testPt")

	var_0_5.SetMovePoint(findTF(arg_1_0.sceneContent, "scene_background/content/leftTop").anchoredPosition, findTF(arg_1_0.sceneContent, "scene_background/content/leftBottom").anchoredPosition, findTF(arg_1_0.sceneContent, "scene_background/content/rightTop").anchoredPosition, findTF(arg_1_0.sceneContent, "scene_background/content/rightBottom").anchoredPosition)

	arg_1_0.charControl = BoatAdCharControl.New(arg_1_0.sceneContent, function(arg_2_0, arg_2_1)
		if arg_2_0 == BoatAdGameEvent.CREATE_ITEM then
			arg_1_0.itemControl:createItem(arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.CREATE_ENEMY then
			arg_1_0.enemyControl:createEnemy(arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.PLAYER_DEAD then
			arg_1_0._event:emit(SimpleMGEvent.GAME_OVER, arg_2_1)
			arg_1_0:clear()
		elseif arg_2_0 == BoatAdGameEvent.PLAY_AD then
			arg_1_0._event:emit(BoatAdGameEvent.OPEN_AD_WINDOW)
		elseif arg_2_0 == BoatAdGameEvent.ADD_SCORE then
			arg_1_0._event:emit(SimpleMGEvent.ADD_SCORE, arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.ADD_GUARD then
			-- block empty
		elseif arg_2_0 == BoatAdGameEvent.SPEED_DOWN then
			arg_1_0.enemyControl:speedDown(arg_2_1)
		end

		arg_1_0:onSceneEventCall(arg_2_0, arg_2_1)

		return
	end)
	arg_1_0.createControl = BoatAdCreateControl.New(arg_1_0.sceneContent, function(arg_2_0, arg_2_1)
		if arg_2_0 == BoatAdGameEvent.CREATE_ITEM then
			arg_1_0.itemControl:createItem(arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.CREATE_ENEMY then
			arg_1_0.enemyControl:createEnemy(arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.PLAYER_DEAD then
			arg_1_0._event:emit(SimpleMGEvent.GAME_OVER, arg_2_1)
			arg_1_0:clear()
		elseif arg_2_0 == BoatAdGameEvent.PLAY_AD then
			arg_1_0._event:emit(BoatAdGameEvent.OPEN_AD_WINDOW)
		elseif arg_2_0 == BoatAdGameEvent.ADD_SCORE then
			arg_1_0._event:emit(SimpleMGEvent.ADD_SCORE, arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.ADD_GUARD then
			-- block empty
		elseif arg_2_0 == BoatAdGameEvent.SPEED_DOWN then
			arg_1_0.enemyControl:speedDown(arg_2_1)
		end

		arg_1_0:onSceneEventCall(arg_2_0, arg_2_1)

		return
	end)
	arg_1_0.itemControl = BoatAdItemControl.New(arg_1_0.sceneContent, function(arg_2_0, arg_2_1)
		if arg_2_0 == BoatAdGameEvent.CREATE_ITEM then
			arg_1_0.itemControl:createItem(arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.CREATE_ENEMY then
			arg_1_0.enemyControl:createEnemy(arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.PLAYER_DEAD then
			arg_1_0._event:emit(SimpleMGEvent.GAME_OVER, arg_2_1)
			arg_1_0:clear()
		elseif arg_2_0 == BoatAdGameEvent.PLAY_AD then
			arg_1_0._event:emit(BoatAdGameEvent.OPEN_AD_WINDOW)
		elseif arg_2_0 == BoatAdGameEvent.ADD_SCORE then
			arg_1_0._event:emit(SimpleMGEvent.ADD_SCORE, arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.ADD_GUARD then
			-- block empty
		elseif arg_2_0 == BoatAdGameEvent.SPEED_DOWN then
			arg_1_0.enemyControl:speedDown(arg_2_1)
		end

		arg_1_0:onSceneEventCall(arg_2_0, arg_2_1)

		return
	end)
	arg_1_0.bgControl = BoatAdBgControl.New(arg_1_0.sceneContent, function(arg_2_0, arg_2_1)
		if arg_2_0 == BoatAdGameEvent.CREATE_ITEM then
			arg_1_0.itemControl:createItem(arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.CREATE_ENEMY then
			arg_1_0.enemyControl:createEnemy(arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.PLAYER_DEAD then
			arg_1_0._event:emit(SimpleMGEvent.GAME_OVER, arg_2_1)
			arg_1_0:clear()
		elseif arg_2_0 == BoatAdGameEvent.PLAY_AD then
			arg_1_0._event:emit(BoatAdGameEvent.OPEN_AD_WINDOW)
		elseif arg_2_0 == BoatAdGameEvent.ADD_SCORE then
			arg_1_0._event:emit(SimpleMGEvent.ADD_SCORE, arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.ADD_GUARD then
			-- block empty
		elseif arg_2_0 == BoatAdGameEvent.SPEED_DOWN then
			arg_1_0.enemyControl:speedDown(arg_2_1)
		end

		arg_1_0:onSceneEventCall(arg_2_0, arg_2_1)

		return
	end)
	arg_1_0.colliderControl = BoatAdColliderControl.New(arg_1_0.sceneContent, function(arg_2_0, arg_2_1)
		if arg_2_0 == BoatAdGameEvent.CREATE_ITEM then
			arg_1_0.itemControl:createItem(arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.CREATE_ENEMY then
			arg_1_0.enemyControl:createEnemy(arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.PLAYER_DEAD then
			arg_1_0._event:emit(SimpleMGEvent.GAME_OVER, arg_2_1)
			arg_1_0:clear()
		elseif arg_2_0 == BoatAdGameEvent.PLAY_AD then
			arg_1_0._event:emit(BoatAdGameEvent.OPEN_AD_WINDOW)
		elseif arg_2_0 == BoatAdGameEvent.ADD_SCORE then
			arg_1_0._event:emit(SimpleMGEvent.ADD_SCORE, arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.ADD_GUARD then
			-- block empty
		elseif arg_2_0 == BoatAdGameEvent.SPEED_DOWN then
			arg_1_0.enemyControl:speedDown(arg_2_1)
		end

		arg_1_0:onSceneEventCall(arg_2_0, arg_2_1)

		return
	end)
	arg_1_0.enemyControl = BoatAdEnemyControl.New(arg_1_0.sceneContent, function(arg_2_0, arg_2_1)
		if arg_2_0 == BoatAdGameEvent.CREATE_ITEM then
			arg_1_0.itemControl:createItem(arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.CREATE_ENEMY then
			arg_1_0.enemyControl:createEnemy(arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.PLAYER_DEAD then
			arg_1_0._event:emit(SimpleMGEvent.GAME_OVER, arg_2_1)
			arg_1_0:clear()
		elseif arg_2_0 == BoatAdGameEvent.PLAY_AD then
			arg_1_0._event:emit(BoatAdGameEvent.OPEN_AD_WINDOW)
		elseif arg_2_0 == BoatAdGameEvent.ADD_SCORE then
			arg_1_0._event:emit(SimpleMGEvent.ADD_SCORE, arg_2_1)
		elseif arg_2_0 == BoatAdGameEvent.ADD_GUARD then
			-- block empty
		elseif arg_2_0 == BoatAdGameEvent.SPEED_DOWN then
			arg_1_0.enemyControl:speedDown(arg_2_1)
		end

		arg_1_0:onSceneEventCall(arg_2_0, arg_2_1)

		return
	end)

	return
end

function var_0_0.start(arg_3_0)
	arg_3_0:showContainer(true)
	arg_3_0.charControl:start()
	arg_3_0.bgControl:start()
	arg_3_0.itemControl:start()
	arg_3_0.colliderControl:start()
	arg_3_0.enemyControl:start()
	arg_3_0.createControl:start()

	arg_3_0.sortIndex = 10

	return
end

function var_0_0.step(arg_4_0, arg_4_1)
	arg_4_0:checkCharBattle()
	arg_4_0.charControl:step(arg_4_1)
	arg_4_0.bgControl:step(arg_4_1)
	arg_4_0.itemControl:step(arg_4_1)
	arg_4_0.colliderControl:step(arg_4_1)
	arg_4_0.enemyControl:step(arg_4_1)
	arg_4_0.createControl:step(arg_4_1)
	arg_4_0:sortSceneObject()

	return
end

function var_0_0.checkCharBattle(arg_5_0)
	if var_0_5.char:getBattle() then
		if arg_5_0.enemyControl:getMoveSpeed() > 0 then
			arg_5_0.enemyControl:setMoveSpeed(0)
		end

		if arg_5_0.itemControl:getMoveSpeed() > 0 then
			arg_5_0.itemControl:setMoveSpeed(0)
		end

		if arg_5_0.bgControl:getMoveSpeed() > 0 then
			arg_5_0.bgControl:setMoveSpeed(0)
		end
	else
		if arg_5_0.enemyControl:getMoveSpeed() == 0 then
			arg_5_0.enemyControl:setMoveSpeed(1)
		end

		if arg_5_0.itemControl:getMoveSpeed() == 0 then
			arg_5_0.itemControl:setMoveSpeed(1)
		end

		if arg_5_0.bgControl:getMoveSpeed() == 0 then
			arg_5_0.bgControl:setMoveSpeed(1)
		end
	end

	return
end

function var_0_0.sortSceneObject(arg_6_0)
	local var_6_0 = var_0_5.GetGameEnemys()
	local var_6_1 = var_0_5.GetGameItems()

	if not arg_6_0.sortTfs or #arg_6_0.sortTfs ~= #var_6_0 + 1 + #var_6_1 then
		arg_6_0.sortTfs = {}

		for iter_6_0 = 1, #var_6_0 do
			table.insert(arg_6_0.sortTfs, var_6_0[iter_6_0])
		end

		for iter_6_1 = 1, #var_6_1 do
			table.insert(arg_6_0.sortTfs, var_6_1[iter_6_1])
		end

		table.insert(arg_6_0.sortTfs, (var_0_5.GetGameChar()))
	end

	if arg_6_0.sortIndex and arg_6_0.sortIndex == 0 then
		arg_6_0:sortItems(arg_6_0.sortTfs)

		arg_6_0.sortIndex = 10
	else
		arg_6_0.sortIndex = arg_6_0.sortIndex - 1
	end

	return
end

function var_0_0.destroyEnemy(arg_7_0, arg_7_1)
	arg_7_0._event:emit(SimpleMGEvent.ADD_SCORE, {
		num = arg_7_1.score
	})

	return
end

function var_0_0.sortItems(arg_8_0, arg_8_1)
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

function var_0_0.useSkill(arg_10_0)
	arg_10_0.charControl:useSkill()

	return
end

function var_0_0.clear(arg_11_0)
	arg_11_0.charControl:clear()

	return
end

function var_0_0.stop(arg_12_0)
	arg_12_0.charControl:stop()
	arg_12_0.enemyControl:stop()
	arg_12_0.createControl:stop()
	arg_12_0.itemControl:stop()
	arg_12_0.bgControl:stop()

	return
end

function var_0_0.resume(arg_13_0)
	arg_13_0.charControl:resume()
	arg_13_0.enemyControl:resume()
	arg_13_0.createControl:resume()
	arg_13_0.itemControl:resume()
	arg_13_0.bgControl:resume()

	return
end

function var_0_0.onSceneEventCall(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.charControl:onEventCall(arg_14_1, arg_14_2)

	return
end

function var_0_0.dispose(arg_15_0)
	arg_15_0.charControl:dispose()
	arg_15_0.bgControl:dispose()
	arg_15_0.itemControl:dispose()
	arg_15_0.enemyControl:dispose()

	return
end

function var_0_0.showContainer(arg_16_0, arg_16_1)
	setActive(arg_16_0.sceneMask, arg_16_1)

	return
end

function var_0_0.press(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == KeyCode.J and arg_17_2 then
		-- block empty
	end

	return
end

function var_0_0.joystickActive(arg_18_0, arg_18_1)
	return
end

return var_0_0
