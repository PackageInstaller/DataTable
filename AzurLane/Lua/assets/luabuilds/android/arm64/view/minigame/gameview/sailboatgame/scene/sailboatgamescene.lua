local var_0_0 = class("SailBoatGameScene")
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
	var_0_5 = SailBoatGameVo
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0.sceneMask = findTF(arg_1_0._tf, "sceneMask")
	arg_1_0.sceneContent = findTF(arg_1_0._tf, "sceneMask/sceneContainer")
	arg_1_0.charControl = SailBoatCharControl.New(arg_1_0.sceneContent, function(arg_2_0, arg_2_1)
		if arg_2_0 == SailBoatGameEvent.DESTROY_ENEMY then
			arg_1_0:destroyEnemy(arg_2_1)
		elseif arg_2_0 == SailBoatGameEvent.USE_ITEM then
			arg_1_0._event:emit(SailBoatGameView.ADD_SCORE, {
				num = arg_2_1.score
			})

			if arg_2_1.skill then
				var_0_5.AddSkill()
			end
		elseif arg_2_0 == SailBoatGameEvent.PLAYER_DEAD then
			arg_1_0._event:emit(SailBoatGameView.GAME_OVER)
		end

		arg_1_0:onSceneEventCall(arg_2_0, arg_2_1)

		return
	end)
	arg_1_0.bgControl = SailBoatBgControl.New(arg_1_0.sceneContent, function(arg_2_0, arg_2_1)
		if arg_2_0 == SailBoatGameEvent.DESTROY_ENEMY then
			arg_1_0:destroyEnemy(arg_2_1)
		elseif arg_2_0 == SailBoatGameEvent.USE_ITEM then
			arg_1_0._event:emit(SailBoatGameView.ADD_SCORE, {
				num = arg_2_1.score
			})

			if arg_2_1.skill then
				var_0_5.AddSkill()
			end
		elseif arg_2_0 == SailBoatGameEvent.PLAYER_DEAD then
			arg_1_0._event:emit(SailBoatGameView.GAME_OVER)
		end

		arg_1_0:onSceneEventCall(arg_2_0, arg_2_1)

		return
	end)
	arg_1_0.itemControl = SailBoatItemControl.New(arg_1_0.sceneContent, function(arg_2_0, arg_2_1)
		if arg_2_0 == SailBoatGameEvent.DESTROY_ENEMY then
			arg_1_0:destroyEnemy(arg_2_1)
		elseif arg_2_0 == SailBoatGameEvent.USE_ITEM then
			arg_1_0._event:emit(SailBoatGameView.ADD_SCORE, {
				num = arg_2_1.score
			})

			if arg_2_1.skill then
				var_0_5.AddSkill()
			end
		elseif arg_2_0 == SailBoatGameEvent.PLAYER_DEAD then
			arg_1_0._event:emit(SailBoatGameView.GAME_OVER)
		end

		arg_1_0:onSceneEventCall(arg_2_0, arg_2_1)

		return
	end)
	arg_1_0.colliderControl = SailBoatColliderControl.New(arg_1_0.sceneContent, function(arg_2_0, arg_2_1)
		if arg_2_0 == SailBoatGameEvent.DESTROY_ENEMY then
			arg_1_0:destroyEnemy(arg_2_1)
		elseif arg_2_0 == SailBoatGameEvent.USE_ITEM then
			arg_1_0._event:emit(SailBoatGameView.ADD_SCORE, {
				num = arg_2_1.score
			})

			if arg_2_1.skill then
				var_0_5.AddSkill()
			end
		elseif arg_2_0 == SailBoatGameEvent.PLAYER_DEAD then
			arg_1_0._event:emit(SailBoatGameView.GAME_OVER)
		end

		arg_1_0:onSceneEventCall(arg_2_0, arg_2_1)

		return
	end)
	arg_1_0.enemyControl = SailBoatEnemyControl.New(arg_1_0.sceneContent, function(arg_2_0, arg_2_1)
		if arg_2_0 == SailBoatGameEvent.DESTROY_ENEMY then
			arg_1_0:destroyEnemy(arg_2_1)
		elseif arg_2_0 == SailBoatGameEvent.USE_ITEM then
			arg_1_0._event:emit(SailBoatGameView.ADD_SCORE, {
				num = arg_2_1.score
			})

			if arg_2_1.skill then
				var_0_5.AddSkill()
			end
		elseif arg_2_0 == SailBoatGameEvent.PLAYER_DEAD then
			arg_1_0._event:emit(SailBoatGameView.GAME_OVER)
		end

		arg_1_0:onSceneEventCall(arg_2_0, arg_2_1)

		return
	end)
	arg_1_0.bulletControl = SailBoatBulletsControl.New(arg_1_0.sceneContent, function(arg_2_0, arg_2_1)
		if arg_2_0 == SailBoatGameEvent.DESTROY_ENEMY then
			arg_1_0:destroyEnemy(arg_2_1)
		elseif arg_2_0 == SailBoatGameEvent.USE_ITEM then
			arg_1_0._event:emit(SailBoatGameView.ADD_SCORE, {
				num = arg_2_1.score
			})

			if arg_2_1.skill then
				var_0_5.AddSkill()
			end
		elseif arg_2_0 == SailBoatGameEvent.PLAYER_DEAD then
			arg_1_0._event:emit(SailBoatGameView.GAME_OVER)
		end

		arg_1_0:onSceneEventCall(arg_2_0, arg_2_1)

		return
	end)
	arg_1_0.effectControl = SailBoatEffectControl.New(arg_1_0.sceneContent, function(arg_2_0, arg_2_1)
		if arg_2_0 == SailBoatGameEvent.DESTROY_ENEMY then
			arg_1_0:destroyEnemy(arg_2_1)
		elseif arg_2_0 == SailBoatGameEvent.USE_ITEM then
			arg_1_0._event:emit(SailBoatGameView.ADD_SCORE, {
				num = arg_2_1.score
			})

			if arg_2_1.skill then
				var_0_5.AddSkill()
			end
		elseif arg_2_0 == SailBoatGameEvent.PLAYER_DEAD then
			arg_1_0._event:emit(SailBoatGameView.GAME_OVER)
		end

		arg_1_0:onSceneEventCall(arg_2_0, arg_2_1)

		return
	end)
	arg_1_0.bgRules = {}
	arg_1_0.bgTfs = {}
	arg_1_0.bgTfPool = {}

	for iter_1_0 = 1, #var_0_0.random_scene_imgs do
		table.insert(arg_1_0.bgRules, {
			time = 0,
			ruleData = var_0_0.random_scene_imgs[iter_1_0]
		})
	end

	return
end

function var_0_0.start(arg_3_0)
	arg_3_0:showContainer(true)
	arg_3_0.charControl:start()
	arg_3_0.bgControl:start()
	arg_3_0.itemControl:start()
	arg_3_0.colliderControl:start()
	arg_3_0.enemyControl:start()
	arg_3_0.bulletControl:start()
	arg_3_0.effectControl:start()

	arg_3_0.sortIndex = 10
	arg_3_0.bgImgTpl = var_0_5.GetGameBgTf("bgs/bg_other")

	for iter_3_0 = #arg_3_0.bgTfs, 1, -1 do
		local var_3_0 = table.remove(arg_3_0.bgTfs, iter_3_0)

		setActive(var_3_0, false)
		table.insert(arg_3_0.bgTfPool, var_3_0)
	end

	for iter_3_1 = 1, #arg_3_0.bgRules do
		arg_3_0.bgRules[iter_3_1].time = 0
	end

	return
end

function var_0_0.step(arg_4_0, arg_4_1)
	arg_4_0.charControl:step(arg_4_1)

	local var_4_7 = (os.clock() - os.clock()) * 1000

	arg_4_0.bgControl:step(arg_4_1)

	local var_4_8 = (os.clock() - os.clock()) * 1000

	arg_4_0.itemControl:step(arg_4_1)

	local var_4_9 = (os.clock() - os.clock()) * 1000

	arg_4_0.colliderControl:step(arg_4_1)

	local var_4_10 = (os.clock() - os.clock()) * 1000

	arg_4_0.enemyControl:step(arg_4_1)

	local var_4_11 = (os.clock() - os.clock()) * 1000

	arg_4_0.bulletControl:step(arg_4_1)

	local var_4_12 = tostring((os.clock() - os.clock()) * 1000, 2)

	arg_4_0.effectControl:step(arg_4_1)

	local var_4_13 = (os.clock() - os.clock()) * 1000
	local var_4_14 = os.clock()
	local var_4_15 = var_0_5.GetGameEnemys()
	local var_4_16 = var_0_5.GetGameItems()

	if not arg_4_0.sortTfs or #arg_4_0.sortTfs ~= #var_4_15 + 1 + #var_4_16 then
		arg_4_0.sortTfs = {}

		for iter_4_0 = 1, #var_4_15 do
			table.insert(arg_4_0.sortTfs, var_4_15[iter_4_0]:getTf())
		end

		for iter_4_1 = 1, #var_4_16 do
			table.insert(arg_4_0.sortTfs, var_4_16[iter_4_1]:getTf())
		end

		table.insert(arg_4_0.sortTfs, var_0_5.GetGameChar():getTf())
	end

	if arg_4_0.sortIndex and arg_4_0.sortIndex == 0 then
		arg_4_0:sortItems(arg_4_0.sortTfs)

		arg_4_0.sortIndex = 10
	else
		arg_4_0.sortIndex = arg_4_0.sortIndex - 1
	end

	for iter_4_2 = 1, #arg_4_0.bgRules do
		if arg_4_0.bgRules[iter_4_2].time <= 0 then
			arg_4_0.bgRules[iter_4_2].time = math.random(30, 45)

			local var_4_17 = arg_4_0.bgRules[iter_4_2].ruleData.icon[math.random(1, #arg_4_0.bgRules[iter_4_2].ruleData.icon)]
			local var_4_18

			if #arg_4_0.bgTfPool > 0 then
				var_4_18 = table.remove(arg_4_0.bgTfPool, 1)
			else
				var_4_18 = tf(instantiate(arg_4_0.bgImgTpl))

				SetParent(var_4_18, findTF(arg_4_0.sceneContent, arg_4_0.bgRules[iter_4_2].ruleData.content))
			end

			setImageSprite(findTF(var_4_18, "img"), var_0_5.GetBgIcon(var_4_17), true)
			setActive(var_4_18, true)
			table.insert(arg_4_0.bgTfs, var_4_18)

			var_4_18.anchoredPosition = Vector2(math.random(-300, 300), 2000)
			var_4_18.localEulerAngles = Vector3(0, 0, math.random(1, 360))
		end

		arg_4_0.bgRules[iter_4_2].time = arg_4_0.bgRules[iter_4_2].time - arg_4_1
	end

	local var_4_19 = var_0_5.GetSceneSpeed()

	for iter_4_3 = #arg_4_0.bgTfs, 1, -1 do
		if arg_4_0.bgTfs[iter_4_3].anchoredPosition.y < -2000 then
			setActive(arg_4_0.bgTfs[iter_4_3], false)
			table.insert(arg_4_0.bgTfPool, arg_4_0.bgTfs[iter_4_3])
			table.remove(arg_4_0.bgTfs, iter_4_3)
		else
			local var_4_20 = arg_4_0.bgTfs[iter_4_3].anchoredPosition

			var_4_20.y = arg_4_0.bgTfs[iter_4_3].anchoredPosition.y + var_4_19.y
			arg_4_0.bgTfs[iter_4_3].anchoredPosition = var_4_20
		end
	end

	return
end

function var_0_0.destroyEnemy(arg_5_0, arg_5_1)
	arg_5_0._event:emit(SailBoatGameView.ADD_SCORE, {
		num = arg_5_1.score
	})

	if arg_5_1.boom then
		arg_5_0:checkBoomDamage(arg_5_1)
	end

	return
end

function var_0_0.checkBoomDamage(arg_6_0, arg_6_1)
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
			arg_6_0:destroyEnemy(var_6_1[iter_6_0]:getDestroyData())
		end
	end

	return
end

function var_0_0.sortItems(arg_7_0, arg_7_1)
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

function var_0_0.useSkill(arg_9_0)
	arg_9_0.charControl:useSkill()

	return
end

function var_0_0.clear(arg_10_0)
	return
end

function var_0_0.stop(arg_11_0)
	return
end

function var_0_0.resume(arg_12_0)
	return
end

function var_0_0.onSceneEventCall(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.charControl:onEventCall(arg_13_1, arg_13_2)
	arg_13_0.bulletControl:onEventCall(arg_13_1, arg_13_2)
	arg_13_0.effectControl:onEventCall(arg_13_1, arg_13_2)

	return
end

function var_0_0.dispose(arg_14_0)
	arg_14_0.charControl:dispose()
	arg_14_0.bgControl:dispose()
	arg_14_0.itemControl:dispose()
	arg_14_0.enemyControl:dispose()

	return
end

function var_0_0.showContainer(arg_15_0, arg_15_1)
	setActive(arg_15_0.sceneMask, arg_15_1)

	return
end

function var_0_0.press(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == KeyCode.J and arg_16_2 then
		arg_16_0.charControl:ableFire()
	end

	return
end

function var_0_0.joystickActive(arg_17_0, arg_17_1)
	return
end

return var_0_0
