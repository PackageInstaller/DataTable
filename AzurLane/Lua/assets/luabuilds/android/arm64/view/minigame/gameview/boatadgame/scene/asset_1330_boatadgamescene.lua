class = var_0_10000

local var_0_0 = var_0_10000("BoatAdGameScene")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
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
	BoatAdGameVo = var_1_10003
	var_0_5 = var_1_10003
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0.sceneMask = var_1_10003(arg_1_0._tf, "sceneMask")
	setActive = var_3

	var_3(arg_1_0.sceneMask, false)

	setActive = var_3
	findTF = var_5

	var_3(var_5(arg_1_0._tf, "tpl"), false)

	findTF = var_3
	arg_1_0.sceneContent = var_3(arg_1_0._tf, "sceneMask/sceneContainer")
	findTF = var_3

	local var_1_0 = var_3(arg_1_0.sceneContent, "scene_background/content/leftTop").anchoredPosition

	findTF = var_1_10004

	local var_1_1 = var_1_10004(arg_1_0.sceneContent, "scene_background/content/leftBottom").anchoredPosition

	findTF = var_5

	local var_1_2 = var_5(arg_1_0.sceneContent, "scene_background/content/rightTop").anchoredPosition

	findTF = var_6

	local var_1_3 = var_6(arg_1_0.sceneContent, "scene_background/content/rightBottom").anchoredPosition

	findTF = var_7
	arg_1_0.testPt = var_7(arg_1_0.sceneContent, "scene_background/content/testPt")

	var_0_5.SetMovePoint(var_1_0, var_1_1, var_1_2, var_1_3)

	local function var_1_4(arg_2_0, arg_2_1)
		BoatAdGameEvent = var_2_10002

		if arg_2_0 == var_2_10002.CREATE_ITEM then
			local var_2_0 = arg_1_0.itemControl

			var_2.createItem(var_2_0, arg_2_1)
		else
			BoatAdGameEvent = var_2

			if arg_2_0 == var_2.CREATE_ENEMY then
				local var_2_1 = arg_1_0.enemyControl

				var_2.createEnemy(var_2_1, arg_2_1)
			else
				BoatAdGameEvent = var_2

				local var_2_3

				if arg_2_0 == var_2.PLAYER_DEAD then
					local var_2_2 = arg_1_0._event

					var_2_3 = var_2_3.emit
					SimpleMGEvent = var_2_10005

					var_2_3(var_2_2, var_2_10005.GAME_OVER, arg_2_1)

					local var_2_4 = arg_1_0

					var_2_3.clear(var_2_4)
				else
					BoatAdGameEvent = var_2_3

					local var_2_6

					if arg_2_0 == var_2_3.PLAY_AD then
						local var_2_5 = arg_1_0._event

						var_2_6 = var_2_6.emit
						BoatAdGameEvent = var_2_10005

						var_2_6(var_2_5, var_2_10005.OPEN_AD_WINDOW)
					else
						BoatAdGameEvent = var_2_6

						local var_2_8

						if arg_2_0 == var_2_6.ADD_SCORE then
							local var_2_7 = arg_1_0._event

							var_2_8 = var_2_8.emit
							SimpleMGEvent = var_2_10005

							var_2_8(var_2_7, var_2_10005.ADD_SCORE, arg_2_1)
						else
							BoatAdGameEvent = var_2_8

							if arg_2_0 == var_2_8.ADD_GUARD then
								-- block empty
							else
								BoatAdGameEvent = var_2

								if arg_2_0 == var_2.SPEED_DOWN then
									local var_2_9 = arg_1_0.enemyControl

									var_2.speedDown(var_2_9, arg_2_1)
								end
							end
						end
					end
				end
			end
		end

		local var_2_10 = arg_1_0

		var_2.onSceneEventCall(var_2_10, arg_2_0, arg_2_1)

		return
	end

	BoatAdCharControl = var_8
	arg_1_0.charControl = var_8.New(arg_1_0.sceneContent, var_1_4)
	BoatAdCreateControl = var_8
	arg_1_0.createControl = var_8.New(arg_1_0.sceneContent, var_1_4)
	BoatAdItemControl = var_8
	arg_1_0.itemControl = var_8.New(arg_1_0.sceneContent, var_1_4)
	BoatAdBgControl = var_8
	arg_1_0.bgControl = var_8.New(arg_1_0.sceneContent, var_1_4)
	BoatAdColliderControl = var_8
	arg_1_0.colliderControl = var_8.New(arg_1_0.sceneContent, var_1_4)
	BoatAdEnemyControl = var_8
	arg_1_0.enemyControl = var_8.New(arg_1_0.sceneContent, var_1_4)

	return
end

function var_0_0.start(arg_3_0)
	arg_3_0:showContainer(true)

	local var_3_0 = arg_3_0.charControl

	var_1.start(var_3_0)

	local var_3_1 = arg_3_0.bgControl

	var_1.start(var_3_1)

	local var_3_2 = arg_3_0.itemControl

	var_1.start(var_3_2)

	local var_3_3 = arg_3_0.colliderControl

	var_1.start(var_3_3)

	local var_3_4 = arg_3_0.enemyControl

	var_1.start(var_3_4)

	local var_3_5 = arg_3_0.createControl

	var_1.start(var_3_5)

	arg_3_0.sortIndex = 10

	return
end

function var_0_0.step(arg_4_0, arg_4_1)
	arg_4_0:checkCharBattle()

	local var_4_0 = arg_4_0.charControl

	var_2.step(var_4_0, arg_4_1)

	local var_4_1 = arg_4_0.bgControl

	var_2.step(var_4_1, arg_4_1)

	local var_4_2 = arg_4_0.itemControl

	var_2.step(var_4_2, arg_4_1)

	local var_4_3 = arg_4_0.colliderControl

	var_2.step(var_4_3, arg_4_1)

	local var_4_4 = arg_4_0.enemyControl

	var_2.step(var_4_4, arg_4_1)

	local var_4_5 = arg_4_0.createControl

	var_2.step(var_4_5, arg_4_1)
	arg_4_0:sortSceneObject()

	return
end

function var_0_0.checkCharBattle(arg_5_0)
	local var_5_0 = var_0_5.char

	if var_1.getBattle(var_5_0) then
		local var_5_1 = arg_5_0.enemyControl

		if var_1.getMoveSpeed(var_5_1) > 0 then
			local var_5_2 = arg_5_0.enemyControl

			var_1.setMoveSpeed(var_5_2, 0)
		end

		local var_5_3 = arg_5_0.itemControl

		if var_1.getMoveSpeed(var_5_3) > 0 then
			local var_5_4 = arg_5_0.itemControl

			var_1.setMoveSpeed(var_5_4, 0)
		end

		local var_5_5 = arg_5_0.bgControl

		if var_1.getMoveSpeed(var_5_5) > 0 then
			local var_5_6 = arg_5_0.bgControl

			var_1.setMoveSpeed(var_5_6, 0)
		end
	else
		local var_5_7 = arg_5_0.enemyControl

		if var_1.getMoveSpeed(var_5_7) == 0 then
			local var_5_8 = arg_5_0.enemyControl

			var_1.setMoveSpeed(var_5_8, 1)
		end

		local var_5_9 = arg_5_0.itemControl

		if var_1.getMoveSpeed(var_5_9) == 0 then
			local var_5_10 = arg_5_0.itemControl

			var_1.setMoveSpeed(var_5_10, 1)
		end

		local var_5_11 = arg_5_0.bgControl

		if var_1.getMoveSpeed(var_5_11) == 0 then
			local var_5_12 = arg_5_0.bgControl

			var_1.setMoveSpeed(var_5_12, 1)
		end
	end

	return
end

function var_0_0.sortSceneObject(arg_6_0)
	local var_6_0 = var_0_5.GetGameEnemys()
	local var_6_1 = var_0_5.GetGameChar()
	local var_6_2 = var_0_5.GetGameItems()

	if not arg_6_0.sortTfs or #arg_6_0.sortTfs ~= #var_6_0 + 1 + #var_6_2 then
		arg_6_0.sortTfs = {}

		for iter_6_0 = 1, #var_6_0 do
			table = var_1_10008

			var_1_10008.insert(arg_6_0.sortTfs, var_6_0[iter_6_0])
		end

		for iter_6_1 = 1, #var_6_2 do
			table = var_1_10008

			var_1_10008.insert(arg_6_0.sortTfs, var_6_2[iter_6_1])
		end

		table = var_4

		var_4.insert(arg_6_0.sortTfs, var_6_1)
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
	local var_7_0 = arg_7_0._event
	local var_7_1 = var_2.emit

	SimpleMGEvent = var_1_10005

	var_7_1(var_7_0, var_1_10005.ADD_SCORE, {
		num = arg_7_1.score
	})

	return
end

function var_0_0.sortItems(arg_8_0, arg_8_1)
	table = var_1_10002

	var_1_10002.sort(arg_8_1, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0:getTf().anchoredPosition
		local var_9_1 = arg_9_1:getTf().anchoredPosition
		local var_9_2 = arg_9_0
		local var_9_3 = arg_9_0.getMoveCount(var_9_2)
		local var_9_4 = arg_9_1
		local var_9_5 = arg_9_1.getMoveCount(var_9_4)

		math = var_9_2

		local var_9_6 = var_9_2.abs(var_9_1.x - var_9_0.x)

		math = var_9_4

		if var_9_4.abs(var_9_1.y - var_9_0.y) > 1 then
			if var_9_0.y > var_9_1.y then
				return false
			elseif var_9_0.y < var_9_1.y then
				return true
			end
		end

		if var_9_5 == 3 and var_9_3 ~= 3 then
			return false
		elseif var_9_3 == 3 and var_9_5 ~= 3 then
			return true
		end

		if var_9_6 > 1 then
			if var_9_0.x < var_9_1.x then
				return false
			elseif var_9_0.x > var_9_1.x then
				return true
			end
		end

		return false
	end)

	for iter_8_0 = 1, #arg_8_1 do
		local var_8_0 = arg_8_1[iter_8_0]
		local var_8_1 = var_6.getTf(var_8_0)

		var_6.SetSiblingIndex(var_8_1, 0)
	end

	return
end

function var_0_0.useSkill(arg_10_0)
	local var_10_0 = arg_10_0.charControl

	var_1.useSkill(var_10_0)

	return
end

function var_0_0.clear(arg_11_0)
	local var_11_0 = arg_11_0.charControl

	var_1.clear(var_11_0)

	return
end

function var_0_0.stop(arg_12_0)
	local var_12_0 = arg_12_0.charControl

	var_1.stop(var_12_0)

	local var_12_1 = arg_12_0.enemyControl

	var_1.stop(var_12_1)

	local var_12_2 = arg_12_0.createControl

	var_1.stop(var_12_2)

	local var_12_3 = arg_12_0.itemControl

	var_1.stop(var_12_3)

	local var_12_4 = arg_12_0.bgControl

	var_1.stop(var_12_4)

	return
end

function var_0_0.resume(arg_13_0)
	local var_13_0 = arg_13_0.charControl

	var_1.resume(var_13_0)

	local var_13_1 = arg_13_0.enemyControl

	var_1.resume(var_13_1)

	local var_13_2 = arg_13_0.createControl

	var_1.resume(var_13_2)

	local var_13_3 = arg_13_0.itemControl

	var_1.resume(var_13_3)

	local var_13_4 = arg_13_0.bgControl

	var_1.resume(var_13_4)

	return
end

function var_0_0.onSceneEventCall(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.charControl

	var_3.onEventCall(var_14_0, arg_14_1, arg_14_2)

	return
end

function var_0_0.dispose(arg_15_0)
	local var_15_0 = arg_15_0.charControl

	var_1.dispose(var_15_0)

	local var_15_1 = arg_15_0.bgControl

	var_1.dispose(var_15_1)

	local var_15_2 = arg_15_0.itemControl

	var_1.dispose(var_15_2)

	local var_15_3 = arg_15_0.enemyControl

	var_1.dispose(var_15_3)

	return
end

function var_0_0.showContainer(arg_16_0, arg_16_1)
	setActive = var_1_10002

	var_1_10002(arg_16_0.sceneMask, arg_16_1)

	return
end

function var_0_0.press(arg_17_0, arg_17_1, arg_17_2)
	KeyCode = var_1_10003

	if arg_17_1 == var_1_10003.J and arg_17_2 then
		-- block empty
	end

	return
end

function var_0_0.joystickActive(arg_18_0, arg_18_1)
	return
end

return var_0_0
