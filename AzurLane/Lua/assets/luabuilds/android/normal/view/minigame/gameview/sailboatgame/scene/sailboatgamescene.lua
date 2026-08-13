class = var_0_10000

local var_0_0 = var_0_10000("SailBoatGameScene")
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
	SailBoatGameVo = var_1_10003
	var_0_5 = var_1_10003
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0.sceneMask = var_1_10003(arg_1_0._tf, "sceneMask")
	findTF = var_3
	arg_1_0.sceneContent = var_3(arg_1_0._tf, "sceneMask/sceneContainer")

	local function var_1_0(arg_2_0, arg_2_1)
		SailBoatGameEvent = var_2_10002

		if arg_2_0 == var_2_10002.DESTROY_ENEMY then
			local var_2_0 = arg_1_0

			var_2.destroyEnemy(var_2_0, arg_2_1)
		else
			SailBoatGameEvent = var_2

			local var_2_2

			if arg_2_0 == var_2.USE_ITEM then
				local var_2_1 = arg_1_0._event

				var_2_2 = var_2_2.emit
				SailBoatGameView = var_2_10004

				var_2_2(var_2_1, var_2_10004.ADD_SCORE, {
					num = arg_2_1.score
				})

				if arg_2_1.skill then
					var_0_5.AddSkill()
				end
			else
				SailBoatGameEvent = var_2_2

				if arg_2_0 == var_2_2.PLAYER_DEAD then
					local var_2_3 = arg_1_0._event
					local var_2_4 = var_2.emit

					SailBoatGameView = var_2_10004

					var_2_4(var_2_3, var_2_10004.GAME_OVER)
				end
			end
		end

		local var_2_5 = arg_1_0

		var_2.onSceneEventCall(var_2_5, arg_2_0, arg_2_1)

		return
	end

	SailBoatCharControl = var_4
	arg_1_0.charControl = var_4.New(arg_1_0.sceneContent, var_1_0)
	SailBoatBgControl = var_4
	arg_1_0.bgControl = var_4.New(arg_1_0.sceneContent, var_1_0)
	SailBoatItemControl = var_4
	arg_1_0.itemControl = var_4.New(arg_1_0.sceneContent, var_1_0)
	SailBoatColliderControl = var_4
	arg_1_0.colliderControl = var_4.New(arg_1_0.sceneContent, var_1_0)
	SailBoatEnemyControl = var_4
	arg_1_0.enemyControl = var_4.New(arg_1_0.sceneContent, var_1_0)
	SailBoatBulletsControl = var_4
	arg_1_0.bulletControl = var_4.New(arg_1_0.sceneContent, var_1_0)
	SailBoatEffectControl = var_4
	arg_1_0.effectControl = var_4.New(arg_1_0.sceneContent, var_1_0)
	arg_1_0.bgRules = {}
	arg_1_0.bgTfs = {}
	arg_1_0.bgTfPool = {}

	for iter_1_0 = 1, #var_0_0.random_scene_imgs do
		local var_1_1 = var_0_0.random_scene_imgs[iter_1_0]

		table = var_1_10009

		var_1_10009.insert(arg_1_0.bgRules, {
			time = 0,
			ruleData = var_1_1
		})
	end

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

	local var_3_5 = arg_3_0.bulletControl

	var_1.start(var_3_5)

	local var_3_6 = arg_3_0.effectControl

	var_1.start(var_3_6)

	arg_3_0.sortIndex = 10
	arg_3_0.bgImgTpl = var_0_5.GetGameBgTf("bgs/bg_other")

	for iter_3_0 = #arg_3_0.bgTfs, 1, -1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.remove(arg_3_0.bgTfs, iter_3_0)
		setActive = var_6

		var_6(var_1_10005, false)

		table = var_6

		var_6.insert(arg_3_0.bgTfPool, var_1_10005)
	end

	for iter_3_1 = 1, #arg_3_0.bgRules do
		arg_3_0.bgRules[iter_3_1].time = 0
	end

	return
end

function var_0_0.step(arg_4_0, arg_4_1)
	local var_4_0
	local var_4_1
	local var_4_2
	local var_4_3
	local var_4_4
	local var_4_5
	local var_4_6

	os = var_1_10009

	local var_4_7 = var_1_10009.clock()
	local var_4_8 = arg_4_0.charControl

	var_10.step(var_4_8, arg_4_1)

	os = var_10

	local var_4_9 = (var_10.clock() - var_4_7) * 1000

	os = var_10

	local var_4_10 = var_10.clock()
	local var_4_11 = arg_4_0.bgControl

	var_10.step(var_4_11, arg_4_1)

	os = var_10

	local var_4_12 = (var_10.clock() - var_4_10) * 1000

	os = var_10

	local var_4_13 = var_10.clock()
	local var_4_14 = arg_4_0.itemControl

	var_10.step(var_4_14, arg_4_1)

	os = var_10

	local var_4_15 = (var_10.clock() - var_4_13) * 1000

	os = var_10

	local var_4_16 = var_10.clock()
	local var_4_17 = arg_4_0.colliderControl

	var_10.step(var_4_17, arg_4_1)

	os = var_10

	local var_4_18 = (var_10.clock() - var_4_16) * 1000

	os = var_10

	local var_4_19 = var_10.clock()
	local var_4_20 = arg_4_0.enemyControl

	var_10.step(var_4_20, arg_4_1)

	os = var_10

	local var_4_21 = (var_10.clock() - var_4_19) * 1000

	os = var_10

	local var_4_22 = var_10.clock()
	local var_4_23 = arg_4_0.bulletControl

	var_10.step(var_4_23, arg_4_1)

	tostring = var_10
	os = var_4_23

	local var_4_24 = var_10((var_4_23.clock() - var_4_22) * 1000, 2)

	os = var_10

	local var_4_25 = var_10.clock()
	local var_4_26 = arg_4_0.effectControl

	var_10.step(var_4_26, arg_4_1)

	os = var_10

	local var_4_27 = (var_10.clock() - var_4_25) * 1000

	os = var_10

	local var_4_28 = var_10.clock()
	local var_4_29 = var_0_5.GetGameEnemys()
	local var_4_30 = var_0_5.GetGameChar()
	local var_4_31 = var_0_5.GetGameItems()

	if not arg_4_0.sortTfs or #arg_4_0.sortTfs ~= #var_4_29 + 1 + #var_4_31 then
		arg_4_0.sortTfs = {}

		for iter_4_0 = 1, #var_4_29 do
			table = var_1_10017
			var_1_10017 = var_1_10017.insert

			local var_4_32 = arg_4_0.sortTfs
			local var_4_33 = var_4_29[iter_4_0]

			var_1_10017(var_4_32, var_19.getTf(var_4_33))
		end

		for iter_4_1 = 1, #var_4_31 do
			table = var_1_10017
			var_1_10017 = var_1_10017.insert

			local var_4_34 = arg_4_0.sortTfs
			local var_4_35 = var_4_31[iter_4_1]

			var_1_10017(var_4_34, var_19.getTf(var_4_35))
		end

		table = var_13

		var_13.insert(arg_4_0.sortTfs, var_4_30:getTf())
	end

	if arg_4_0.sortIndex and arg_4_0.sortIndex == 0 then
		arg_4_0:sortItems(arg_4_0.sortTfs)

		arg_4_0.sortIndex = 10
	else
		arg_4_0.sortIndex = arg_4_0.sortIndex - 1
	end

	for iter_4_2 = 1, #arg_4_0.bgRules do
		if arg_4_0.bgRules[iter_4_2].time <= 0 then
			local var_4_36 = arg_4_0.bgRules[iter_4_2]

			math = var_18
			var_4_36.time = var_18.random(30, 45)

			local var_4_37 = arg_4_0.bgRules[iter_4_2].ruleData.icon

			math = var_18

			local var_4_38 = var_4_37[var_18.random(1, #var_4_37)]
			local var_4_39
			local var_4_40 = #arg_4_0.bgTfPool
			local var_4_41

			if 0 < var_4_40 then
				table = var_4_40
				var_4_39 = var_4_40.remove(arg_4_0.bgTfPool, 1)
			else
				tf = var_4_40
				instantiate = var_4_41
				var_4_39 = var_4_40(var_4_41(arg_4_0.bgImgTpl))
				SetParent = var_4_40
				var_4_41 = var_4_39
				findTF = var_22

				var_4_40(var_4_41, var_22(arg_4_0.sceneContent, arg_4_0.bgRules[iter_4_2].ruleData.content))
			end

			setImageSprite = var_4_40
			findTF = var_4_41

			var_4_40(var_4_41(var_4_39, "img"), var_0_5.GetBgIcon(var_4_38), true)

			setActive = var_4_40

			var_4_40(var_4_39, true)

			table = var_4_40

			var_4_40.insert(arg_4_0.bgTfs, var_4_39)

			Vector2 = var_20
			math = var_21
			var_4_39.anchoredPosition = var_20(var_21.random(-300, 300), 2000)
			Vector3 = var_20

			local var_4_42 = 0
			local var_4_43 = 0

			math = var_23
			var_4_39.localEulerAngles = var_20(var_4_42, var_4_43, var_23.random(1, 360))
		end

		arg_4_0.bgRules[iter_4_2].time = arg_4_0.bgRules[iter_4_2].time - arg_4_1
	end

	local var_4_44 = var_0_5.GetSceneSpeed()

	for iter_4_3 = #arg_4_0.bgTfs, 1, -1 do
		if arg_4_0.bgTfs[iter_4_3].anchoredPosition.y < -2000 then
			setActive = var_19

			var_19(var_18, false)

			table = var_19

			var_19.insert(arg_4_0.bgTfPool, var_18)

			table = var_19

			var_19.remove(arg_4_0.bgTfs, iter_4_3)
		else
			var_19.y = var_18.anchoredPosition.y + var_4_44.y
			var_18.anchoredPosition = var_19
		end
	end

	return
end

function var_0_0.destroyEnemy(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._event
	local var_5_1 = var_2.emit

	SailBoatGameView = var_1_10004

	var_5_1(var_5_0, var_1_10004.ADD_SCORE, {
		num = arg_5_1.score
	})

	if arg_5_1.boom then
		arg_5_0:checkBoomDamage(arg_5_1)
	end

	return
end

function var_0_0.checkBoomDamage(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.boom
	local var_6_1 = arg_6_1.position
	local var_6_2 = arg_6_1.range
	local var_6_3 = var_0_5.GetGameChar()
	local var_6_4 = var_0_5.GetGameEnemys()
	local var_6_5 = var_6_3:getPosition()
	local var_6_6 = var_6_3
	local var_6_7 = var_6_3.getConfig(var_6_6, "range")

	math = var_6_6

	if var_6_6.abs(var_6_1.x - var_6_5.x) < var_6_2.x + var_6_7.x / 2 then
		math = var_9

		if var_9.abs(var_6_1.y - var_6_5.y) < var_6_2.y + var_6_7.y / 2 then
			var_6_3:damage({
				num = var_6_0,
				position = var_6_1
			})
		end
	end

	for iter_6_0 = 1, #var_6_4 do
		local var_6_8 = var_6_4[iter_6_0]
		local var_6_9 = var_13.getPosition(var_6_8)
		local var_6_10 = var_13
		local var_6_11 = var_13.getConfig(var_6_10, "range")

		math = var_6_10

		if var_6_10.abs(var_6_1.x - var_6_9.x) < var_6_2.x + var_6_9.x / 2 then
			math = var_16

			if var_16.abs(var_6_1.y - var_6_9.y) < var_6_2.y + var_6_9.y / 2 and var_13:damage({
				num = var_6_0,
				position = var_6_1
			}) then
				arg_6_0:destroyEnemy(var_13:getDestroyData())
			end
		end
	end

	return
end

function var_0_0.sortItems(arg_7_0, arg_7_1)
	table = var_1_10002

	var_1_10002.sort(arg_7_1, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_0.anchoredPosition
		local var_8_1 = arg_8_1.anchoredPosition

		if var_8_0.y > var_8_1.y then
			return false
		elseif var_8_0.y < var_8_1.y then
			return true
		end

		if var_8_0.x > var_8_1.x then
			return false
		elseif var_8_0.x < var_8_1.x then
			return true
		end

		return false
	end)

	for iter_7_0 = 1, #arg_7_1 do
		local var_7_0 = arg_7_1[iter_7_0]

		var_6.SetSiblingIndex(var_7_0, 0)
	end

	return
end

function var_0_0.useSkill(arg_9_0)
	local var_9_0 = arg_9_0.charControl

	var_1.useSkill(var_9_0)

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
	local var_13_0 = arg_13_0.charControl

	var_3.onEventCall(var_13_0, arg_13_1, arg_13_2)

	local var_13_1 = arg_13_0.bulletControl

	var_3.onEventCall(var_13_1, arg_13_1, arg_13_2)

	local var_13_2 = arg_13_0.effectControl

	var_3.onEventCall(var_13_2, arg_13_1, arg_13_2)

	return
end

function var_0_0.dispose(arg_14_0)
	local var_14_0 = arg_14_0.charControl

	var_1.dispose(var_14_0)

	local var_14_1 = arg_14_0.bgControl

	var_1.dispose(var_14_1)

	local var_14_2 = arg_14_0.itemControl

	var_1.dispose(var_14_2)

	local var_14_3 = arg_14_0.enemyControl

	var_1.dispose(var_14_3)

	return
end

function var_0_0.showContainer(arg_15_0, arg_15_1)
	setActive = var_1_10002

	var_1_10002(arg_15_0.sceneMask, arg_15_1)

	return
end

function var_0_0.press(arg_16_0, arg_16_1, arg_16_2)
	KeyCode = var_1_10003

	if arg_16_1 == var_1_10003.J and arg_16_2 then
		local var_16_0 = arg_16_0.charControl

		var_3.ableFire(var_16_0)
	end

	return
end

function var_0_0.joystickActive(arg_17_0, arg_17_1)
	return
end

return var_0_0
