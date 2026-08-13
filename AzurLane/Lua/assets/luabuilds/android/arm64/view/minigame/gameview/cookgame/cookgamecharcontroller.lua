class = var_0_10000

local var_0_0 = var_0_10000("CookGameCharController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneContainer = arg_1_1
	findTF = var_1_10004
	arg_1_0._scene = var_1_10004(arg_1_0._sceneContainer, "scene")
	findTF = var_4
	arg_1_0._tpl = var_4(arg_1_1, "scene_background/charTpl")
	findTF = var_4
	arg_1_0._cakeTpl = var_4(arg_1_1, "scene_background/cakeTpl")
	setActive = var_4

	var_4(arg_1_0._cakeTpl, false)

	setActive = var_4

	var_4(arg_1_0._tpl, false)

	arg_1_0._gameData = arg_1_2
	arg_1_0._event = arg_1_3
	CookGameChar = var_4

	local var_1_0 = var_4.New

	tf = var_6
	instantiate = var_1_10008
	arg_1_0.playerChar = var_1_0(var_6(var_1_10008(arg_1_0._tpl)), arg_1_0._gameData, arg_1_0._event)

	local var_1_1 = arg_1_0.playerChar

	var_4.isPlayer(var_1_1, true)

	CookGameChar = var_4

	local var_1_2 = var_4.New

	tf = var_1_1
	instantiate = var_8
	arg_1_0.partnerChar = var_1_2(var_1_1(var_8(arg_1_0._tpl)), arg_1_0._gameData, arg_1_0._event)

	local var_1_3 = arg_1_0.partnerChar

	var_4.isPartner(var_1_3, true)

	CookGameChar = var_4

	local var_1_4 = var_4.New

	tf = var_1_3
	instantiate = var_8
	arg_1_0.partnerPet = var_1_4(var_1_3(var_8(arg_1_0._tpl)), arg_1_0._gameData, arg_1_0._event)

	local var_1_5 = arg_1_0.partnerPet

	var_4.isPartner(var_1_5, true)

	CookGameChar = var_4

	local var_1_6 = var_4.New

	tf = var_1_5
	instantiate = var_8
	arg_1_0.enemy1Char = var_1_6(var_1_5(var_8(arg_1_0._tpl)), arg_1_0._gameData, arg_1_0._event)
	CookGameChar = var_4

	local var_1_7 = var_4.New

	tf = var_6
	instantiate = var_8
	arg_1_0.enemy2Char = var_1_7(var_6(var_8(arg_1_0._tpl)), arg_1_0._gameData, arg_1_0._event)
	CookGameChar = var_4

	local var_1_8 = var_4.New

	tf = var_6
	instantiate = var_8
	arg_1_0.enemyPet = var_1_8(var_6(var_8(arg_1_0._tpl)), arg_1_0._gameData, arg_1_0._event)

	local var_1_9 = arg_1_0.playerChar
	local var_1_10 = var_4.setParent
	local var_1_11 = arg_1_0._sceneContainer

	CookGameConst = var_8

	local var_1_12 = var_8.char_instiate_data

	CookGameConst = var_1_10009

	var_1_10(var_1_9, var_1_11, var_1_12[var_1_10009.player_char])

	local var_1_13 = arg_1_0.partnerChar
	local var_1_14 = var_4.setParent
	local var_1_15 = arg_1_0._sceneContainer

	CookGameConst = var_8

	local var_1_16 = var_8.char_instiate_data

	CookGameConst = var_9

	var_1_14(var_1_13, var_1_15, var_1_16[var_9.parter_char])

	local var_1_17 = arg_1_0.partnerPet
	local var_1_18 = var_4.setParent
	local var_1_19 = arg_1_0._sceneContainer

	CookGameConst = var_8

	local var_1_20 = var_8.char_instiate_data

	CookGameConst = var_9

	var_1_18(var_1_17, var_1_19, var_1_20[var_9.parter_pet])

	local var_1_21 = arg_1_0.enemy1Char
	local var_1_22 = var_4.setParent
	local var_1_23 = arg_1_0._sceneContainer

	CookGameConst = var_8

	local var_1_24 = var_8.char_instiate_data

	CookGameConst = var_9

	var_1_22(var_1_21, var_1_23, var_1_24[var_9.enemy1_char])

	local var_1_25 = arg_1_0.enemy2Char
	local var_1_26 = var_4.setParent
	local var_1_27 = arg_1_0._sceneContainer

	CookGameConst = var_8

	local var_1_28 = var_8.char_instiate_data

	CookGameConst = var_9

	var_1_26(var_1_25, var_1_27, var_1_28[var_9.enemy2_char])

	local var_1_29 = arg_1_0.enemyPet
	local var_1_30 = var_4.setParent
	local var_1_31 = arg_1_0._sceneContainer

	CookGameConst = var_8

	local var_1_32 = var_8.char_instiate_data

	CookGameConst = var_9

	var_1_30(var_1_29, var_1_31, var_1_32[var_9.enemy_pet])

	local var_1_33 = arg_1_0.enemy1Char

	var_4.isPartner(var_1_33, false)

	local var_1_34 = arg_1_0.enemy2Char

	var_4.isPartner(var_1_34, false)

	local var_1_35 = arg_1_0.enemyPet

	var_4.isPartner(var_1_35, false)

	arg_1_0.chars = {
		arg_1_0.playerChar,
		arg_1_0.partnerChar,
		arg_1_0.enemy1Char,
		arg_1_0.enemy2Char,
		arg_1_0.partnerPet,
		arg_1_0.enemyPet
	}
	findTF = var_4
	arg_1_0._playerBox = var_4(arg_1_0._sceneContainer, "scene_background/playerBox")

	if not arg_1_0.uiCam then
		GameObject = var_4

		local var_1_36 = var_4.Find("UICamera")

		arg_1_0.uiCam = var_4.GetComponent(var_1_36, "Camera")
	end

	findTF = var_4
	arg_1_0._playerCollider = var_4(arg_1_0._playerBox, "collider")
	GetComponent = var_4

	local var_1_37 = arg_1_0._playerCollider

	typeof = var_7
	EventTriggerListener = var_1_40
	arg_1_0._playerColliderEvenet = var_4(var_1_37, var_7(var_1_40))

	local var_1_38 = arg_1_0._playerColliderEvenet

	var_4.AddPointDownFunc(var_1_38, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0.uiCam
		local var_2_1 = var_2.ScreenToWorldPoint(var_2_0, arg_2_1.pressPosition)
		local var_2_2 = arg_1_0._scene
		local var_2_3 = var_3.InverseTransformPoint(var_2_2, var_2_1)
		local var_2_4 = arg_1_0.playerChar

		var_4.clearCake(var_2_4)

		local var_2_5 = arg_1_0.playerChar

		var_4.clearJudge(var_2_5)

		local var_2_6 = arg_1_0.playerChar

		var_4.setTargetPos(var_2_6, var_2_3, nil)

		return
	end)

	arg_1_0.playerCakes = {}

	for iter_1_0 = 1, arg_1_0._gameData.cake_num do
		local var_1_39 = iter_1_0

		findTF = var_1_40

		local var_1_40 = var_1_40(arg_1_0._playerBox, "table/cake/" .. iter_1_0)

		findTF = var_1_41

		local var_1_41 = var_1_41(var_1_40, "pos")

		GetComponent = var_11
		findTF = var_13

		local var_1_42 = var_13(var_1_40, "collider")

		typeof = var_1_10014
		EventTriggerListener = var_16
		var_1_10014 = var_11(var_1_42, var_1_10014(var_16))

		var_11.AddPointDownFunc(var_1_10014, function(arg_3_0, arg_3_1)
			local var_3_0 = arg_1_0

			var_2.onPickupCake(var_3_0, arg_1_0.playerChar, var_1_39, arg_1_0.playerCakes, true)

			return
		end)

		table = var_12

		var_12.insert(arg_1_0.playerCakes, {
			tf = var_1_40,
			pos = var_1_41,
			id = var_1_39,
			event = var_11
		})
	end

	arg_1_0.enemyCakes = {}
	findTF = var_4
	arg_1_0._enemyBox = var_4(arg_1_0._sceneContainer, "scene_background/enemyBox")

	for iter_1_1 = 1, arg_1_0._gameData.cake_num do
		local var_1_43 = iter_1_1

		findTF = var_1_40
		var_1_40 = var_1_40(arg_1_0._enemyBox, "table/cake/" .. iter_1_1)
		findTF = var_1_41
		var_1_41 = var_1_41(var_1_40, "pos")
		table = var_11

		var_11.insert(arg_1_0.enemyCakes, {
			tf = var_1_40,
			pos = var_1_41,
			id = var_1_43,
			event = arg_1_3
		})
	end

	arg_1_0.acCakes = {}

	return
end

function var_0_0.changeSpeed(arg_4_0, arg_4_1)
	for iter_4_0 = 1, #arg_4_0.chars do
		local var_4_0 = arg_4_0.chars[iter_4_0]

		var_6.changeSpeed(var_4_0, arg_4_1)
	end

	return
end

function var_0_0.onPickupCake(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_1:isActiving() then
		return
	end

	for iter_5_0 = 1, #arg_5_3 do
		local var_5_0 = arg_5_3[iter_5_0].tf
		local var_5_1

		if var_9.id == arg_5_2 then
			findTF = var_5_1
			var_5_1 = var_5_1(var_9.tf, "pos")

			local var_5_2 = arg_5_0._scene

			var_9.cakePos = var_12.InverseTransformPoint(var_5_2, var_5_1.position)

			local var_5_3 = arg_5_1

			arg_5_1.setCake(var_5_3, var_9)

			if arg_5_4 then
				setActive = var_1_10013
				findTF = var_5_3

				var_1_10013(var_5_3(var_5_0, "select"), true)
			end
		else
			setActive = var_5_1
			findTF = var_1_10013

			var_5_1(var_1_10013(var_5_0, "select"), false)
		end
	end

	return
end

function var_0_0.readyStart(arg_6_0)
	local var_6_0 = arg_6_0.playerChar

	var_1.setData(var_6_0, arg_6_0:createCharData(arg_6_0._gameData.playerChar))

	local var_6_1 = arg_6_0.partnerChar

	var_1.setData(var_6_1, arg_6_0:createCharData(arg_6_0._gameData.partnerChar))

	if arg_6_0._gameData.partnerPet then
		local var_6_2 = arg_6_0.partnerPet

		var_1.setData(var_6_2, arg_6_0:createCharData(arg_6_0._gameData.partnerPet))
	else
		local var_6_3 = arg_6_0.partnerPet

		var_1.setData(var_6_3, nil)
	end

	local var_6_4 = arg_6_0.enemy1Char

	var_1.setData(var_6_4, arg_6_0:createCharData(arg_6_0._gameData.enemy1Char))

	local var_6_5 = arg_6_0.enemy2Char

	var_1.setData(var_6_5, arg_6_0:createCharData(arg_6_0._gameData.enemy2Char))

	if arg_6_0._gameData.enemyPet then
		local var_6_6 = arg_6_0.enemyPet

		var_1.setData(var_6_6, arg_6_0:createCharData(arg_6_0._gameData.enemyPet))
	else
		local var_6_7 = arg_6_0.enemyPet

		var_1.setData(var_6_7, nil)
	end

	local var_6_8 = arg_6_0.playerChar

	var_1.readyStart(var_6_8)

	local var_6_9 = arg_6_0.partnerChar

	var_1.readyStart(var_6_9)

	local var_6_10 = arg_6_0.partnerPet

	var_1.readyStart(var_6_10)

	local var_6_11 = arg_6_0.enemy1Char

	var_1.readyStart(var_6_11)

	local var_6_12 = arg_6_0.enemy2Char

	var_1.readyStart(var_6_12)

	local var_6_13 = arg_6_0.enemyPet

	var_1.readyStart(var_6_13)

	arg_6_0.sceneTfs = nil

	return
end

function var_0_0.start(arg_7_0)
	return
end

function var_0_0.step(arg_8_0, arg_8_1)
	for iter_8_0 = 1, #arg_8_0.chars do
		var_1_10009 = arg_8_0.chars[iter_8_0]

		if var_6.getCharActive(var_1_10009) then
			var_1_10009 = var_6

			local var_8_0 = var_6.getTargetPos(var_1_10009)
			local var_8_1 = var_6
			local var_8_2 = var_6.getVelocity(var_8_1)

			if var_8_0 then
				var_1_10009 = var_6:getPos()

				if not var_8_2 then
					math = var_8_1

					if var_8_1.abs(var_8_0.y - var_1_10009.y) ~= 0 then
						math = var_10

						local var_8_3 = var_10.atan

						math = var_12

						local var_8_4 = var_12.abs(var_8_0.y - var_1_10009.y)

						math = var_13

						local var_8_5 = var_8_3(var_8_4 / var_13.abs(var_8_0.x - var_1_10009.x))
						local var_8_6 = var_8_0.x > var_1_10009.x and 1 or -1
						local var_8_7 = var_8_0.y
						local var_8_8 = var_1_10009.y < var_8_7 and 1 or -1

						math = var_13

						local var_8_9 = var_13.cos(var_8_5) * var_8_6

						math = var_14

						local var_8_10 = var_14.sin(var_8_5) * var_8_8

						var_1_10017 = var_6

						var_6.setVelocity(var_1_10017, var_8_9, var_8_10, var_8_5)
					else
						var_6:stopMove()
					end
				end
			elseif var_6:getJudgeData() then
				var_6:setTargetPos(var_6:getJudgeData().targetPos)
			elseif var_6:getCake() then
				var_6:setTargetPos(var_6:getCake().cakePos)
			end

			var_6:step(arg_8_1)
		end
	end

	local var_8_11

	if not arg_8_0.sceneTfs then
		arg_8_0.sceneTfs = {}
		var_8_11 = {}

		local var_8_12 = arg_8_0._scene.childCount

		arg_8_0.judgeNum = 0

		for iter_8_1 = 0, var_8_12 - 1 do
			local var_8_13 = arg_8_0._scene
			local var_8_14 = var_8.GetChild(var_8_13, iter_8_1)

			string = var_1_10009

			if var_1_10009.match(var_8_14.name, "judge") then
				arg_8_0.judgeNum = arg_8_0.judgeNum + 1
				table = var_1_10009

				var_1_10009.insert(var_8_11, var_8_14)
			else
				table = var_1_10009
				var_1_10009 = var_1_10009.insert

				local var_8_15 = arg_8_0.sceneTfs
				local var_8_16 = {
					tf = var_8_14
				}

				var_1_10015 = arg_8_0
				var_8_16.offset = arg_8_0.getTfOffset(var_1_10015, var_8_14.name)

				var_1_10009(var_8_15, var_8_16)
			end
		end

		table = var_4

		var_4.sort(var_8_11, function(arg_9_0, arg_9_1)
			if arg_9_0.anchoredPosition.y > arg_9_1.anchoredPosition.y then
				return true
			else
				return false
			end

			return
		end)
	end

	table = var_8_11

	var_8_11.sort(arg_8_0.sceneTfs, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0.tf.anchoredPosition
		local var_10_1

		if not arg_10_0.offset or not arg_10_0.offset then
			Vector2 = var_10_1
			var_10_1 = var_10_1(0, 0)
		end

		local var_10_2 = arg_10_1.tf.anchoredPosition
		local var_10_3

		if not arg_10_1.offset or not arg_10_1.offset then
			Vector2 = var_10_3
			var_10_3 = var_10_3(0, 0)
		end

		if var_10_0.y + var_10_1.y > var_10_2.y + var_10_3.y then
			return true
		else
			return false
		end

		return
	end)

	for iter_8_2 = 1, #arg_8_0.sceneTfs do
		local var_8_17 = arg_8_0.sceneTfs[iter_8_2].tf

		var_6.SetSiblingIndex(var_8_17, iter_8_2 - 1 + arg_8_0.judgeNum)
	end

	if not arg_8_0._judges then
		arg_8_0._judges = arg_8_0._gameData.judges
	end

	local var_8_18 = arg_8_0:getFillterWanted({
		arg_8_0.partnerChar
	})
	local var_8_19 = arg_8_0:getFillterWanted({
		arg_8_0.playerChar,
		arg_8_0.partnerPet
	})
	local var_8_20 = arg_8_0:getFillterWanted({
		arg_8_0.playerChar,
		arg_8_0.partnerPet
	})
	local var_8_21 = arg_8_0:getFillterWanted({
		arg_8_0.enemy2Char,
		arg_8_0.enemyPet
	})
	local var_8_22 = arg_8_0
	local var_8_23 = arg_8_0.getFillterWanted(var_8_22, {
		arg_8_0.enemy1Char,
		arg_8_0.enemyPet
	})
	local var_8_24 = arg_8_0:getFillterWanted({
		arg_8_0.enemy1Char,
		arg_8_0.enemy2Char
	})

	CookGameConst = var_8_22

	if var_8_22.player_use_ai then
		arg_8_0:setCharAction(arg_8_0.playerChar, var_8_19, arg_8_0.playerCakes)
	end

	arg_8_0:setCharAction(arg_8_0.partnerChar, var_8_18, arg_8_0.playerCakes)
	arg_8_0:setCharAction(arg_8_0.partnerPet, var_8_20, arg_8_0.playerCakes)

	if arg_8_0._gameData.gameTime and arg_8_0._gameData.gameTime > 0 then
		arg_8_0:setCharAction(arg_8_0.enemy1Char, var_8_21, arg_8_0.enemyCakes)
		arg_8_0:setCharAction(arg_8_0.enemy2Char, var_8_23, arg_8_0.enemyCakes)
		arg_8_0:setCharAction(arg_8_0.enemyPet, var_8_24, arg_8_0.enemyCakes)
	end

	for iter_8_3 = #arg_8_0.acCakes, 1, -1 do
		local var_8_25 = arg_8_0.acCakes[iter_8_3].tf
		local var_8_26 = arg_8_0.acCakes[iter_8_3].tf.anchoredPosition
		local var_8_27 = arg_8_0.acCakes[iter_8_3].targetPos

		math = var_1_10015
		var_1_10015 = var_1_10015.atan
		math = var_1_10017
		var_1_10017 = var_1_10017.abs(var_8_27.y - var_8_26.y)
		math = var_1_10018
		var_1_10015 = var_1_10015(var_1_10017 / var_1_10018.abs(var_8_27.x - var_8_26.x))

		local var_8_28 = var_8_27.x
		local var_8_29 = var_8_26.x < var_8_28 and 1 or -1

		var_1_10017 = var_8_27.y
		var_1_10017 = var_8_26.y < var_1_10017 and 1 or -1
		math = var_1_10018
		var_1_10018 = var_1_10018.cos(var_1_10015) * var_8_29 * 600 * arg_8_1
		math = var_19

		local var_8_30 = var_19.sin(var_1_10015) * var_1_10017 * 600 * arg_8_1

		Vector2 = var_20

		local var_8_31 = var_20(var_8_26.x + var_1_10018, var_8_26.y + var_8_30)
		local var_8_32 = arg_8_0.acCakes[iter_8_3].tf.anchoredPosition

		if var_8_26.x < var_8_27.x and var_8_31.x < var_8_27.x then
			var_8_32.x = var_8_31.x
		elseif var_8_26.x > var_8_27.x and var_8_31.x > var_8_27.x then
			var_8_32.x = var_8_31.x
		else
			var_8_32.x = var_8_27.x
		end

		if var_8_26.y < var_8_27.y and var_8_31.y < var_8_27.y then
			var_8_32.y = var_8_31.y
		elseif var_8_26.y > var_8_27.y and var_8_31.y > var_8_27.y then
			var_8_32.y = var_8_31.y
		else
			var_8_32.y = var_8_27.y
		end

		local var_8_33 = arg_8_0.acCakes[iter_8_3].tf

		var_8_33.anchoredPosition = var_8_32
		math = var_8_33

		if var_8_33.abs(var_8_32.y - var_8_27.y) < 3 then
			math = var_22

			if var_22.abs(var_8_32.x - var_8_27.x) < 3 then
				table = var_22

				if var_22.remove(arg_8_0.acCakes, iter_8_3).callback then
					var_22.callback()
				end

				Destroy = var_23

				var_23(var_22.tf)

				local var_8_34
			end
		end
	end

	return
end

function var_0_0.getTfOffset(arg_11_0, arg_11_1)
	for iter_11_0 = 1, #arg_11_0.chars do
		local var_11_0 = arg_11_0.chars[iter_11_0]

		if var_6.getTf(var_11_0).name == arg_11_1 then
			local var_11_1 = arg_11_0.chars[iter_11_0]

			return var_7.getOffset(var_11_1)
		end
	end

	Vector2 = var_2

	return var_2(0, 0)
end

function var_0_0.getFillterWanted(arg_12_0, arg_12_1)
	local var_12_0 = {}

	ipairs = var_1_10003

	for iter_12_0, iter_12_1 in var_1_10003(arg_12_1) do
		if iter_12_1:getCharActive() then
			local var_12_1 = iter_12_1:getJudge()

			for iter_12_2 = 1, #arg_12_0._judges do
				local var_12_2 = arg_12_0._judges[iter_12_2]

				if (not var_12_1 or var_12_2 ~= var_12_1) and not var_12_2:isInServe() and not var_12_2:isInTrigger() and var_12_2:getWantedCake() then
					table = var_14

					var_14.insert(var_12_0, var_12_2:getWantedCake())
				end
			end
		end
	end

	return var_12_0
end

function var_0_0.setCharAction(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_1:getCharActive() then
		return
	end

	if arg_13_1:isActiving() then
		return
	end

	local var_13_0 = arg_13_1:getCakeIds()
	local var_13_1 = arg_13_1:isFullCakes()

	if #var_13_0 > 0 then
		if arg_13_1:getCake() then
			return
		elseif arg_13_1:getJudge() then
			local var_13_2 = arg_13_1:getJudge()

			if var_6.isInTrigger(var_13_2) and var_6:isInServe() then
				arg_13_1:clearJudge()
				arg_13_1:stopMove()
			end

			return
		elseif not var_13_1 and arg_13_1:getPickupFull() then
			math = var_6

			local var_13_3 = arg_13_2[var_6.random(1, #arg_13_2)]

			arg_13_0:onPickupCake(arg_13_1, var_13_3, arg_13_3, false)

			return
		end

		local var_13_4 = {}

		for iter_13_0 = 1, #arg_13_0._judges do
			local var_13_5 = arg_13_0._judges[iter_13_0]

			if not var_11.isInTrigger(var_13_5) and not var_11:isInServe() then
				table = var_12

				if var_12.contains(var_13_0, var_11:getWantedCake()) then
					table = var_12

					var_12.insert(var_13_4, var_11)
				elseif arg_13_1:getId() == 7 then
					table = var_12

					var_12.insert(var_13_4, var_11)
				end
			end
		end

		local var_13_6

		if #var_13_4 == 0 then
			if not arg_13_1:getCake() then
				math = var_13_6
				var_13_6 = arg_13_2[var_13_6.random(1, #arg_13_2)]

				arg_13_0:onPickupCake(arg_13_1, var_13_6, arg_13_3, false)
			end
		else
			math = var_13_6

			local var_13_7 = var_13_4[var_13_6.random(1, #var_13_4)]

			arg_13_0:setJudgeAction(var_13_7, arg_13_1, function()
				return
			end)
		end
	elseif not arg_13_1:getCake() then
		if arg_13_1:getDoubleAble() and #var_13_0 == 0 then
			arg_13_1:setPickupFull(true)
		end

		if arg_13_2 == nil then
			return
		end

		math = var_6

		local var_13_8 = arg_13_2[var_6.random(1, #arg_13_2)]

		arg_13_0:onPickupCake(arg_13_1, var_13_8, arg_13_3, false)
	end

	return
end

function var_0_0.createCharData(arg_15_0, arg_15_1)
	if not arg_15_0.charDic then
		arg_15_0.charDic = {}
	end

	if arg_15_0.charDic[arg_15_1] then
		Clone = var_2

		return var_2(arg_15_0.charDic[arg_15_1])
	end

	local var_15_0 = arg_15_0:getBattleData(arg_15_1)
	local var_15_1 = {}
	local var_15_2 = {}
	local var_15_3 = var_15_0.double_able
	local var_15_4 = var_15_0.speed_able
	local var_15_5 = arg_15_0._gameData.cake_num
	local var_15_6 = var_15_0.name
	local var_15_7 = arg_15_0._gameData.char_path .. "cookgame" .. var_15_6 .. "_atlas"

	if var_15_3 then
		for iter_15_0 = 0, var_15_5 do
			for iter_15_1 = 0, var_15_5 do
				local var_15_8

				if iter_15_0 == 0 and iter_15_1 == 0 or iter_15_0 ~= 0 then
					var_15_8 = var_15_6 .. "_L" .. iter_15_0 .. "_R" .. iter_15_1
				end

				if var_15_8 then
					LoadAny = var_1_10019
					var_1_10021 = var_15_7

					local var_15_9 = var_15_8

					typeof = var_1_10023
					RuntimeAnimatorController = var_1_10025
					var_1_10019 = var_1_10019(var_1_10021, var_15_9, var_1_10023(var_1_10025))
					table = var_1_10020

					var_1_10020.insert(var_15_2, {
						runtimeAnimator = var_1_10019,
						name = var_15_8
					})
				end
			end
		end
	elseif var_15_4 then
		for iter_15_2 = 0, var_15_5 do
			for iter_15_3 = 0, arg_15_0._gameData.speed_num do
				local var_15_10 = var_15_6 .. "_L" .. iter_15_2 .. "_" .. iter_15_3

				LoadAny = var_1_10019
				var_1_10021 = var_15_7

				local var_15_11 = var_15_10

				typeof = var_1_10023
				RuntimeAnimatorController = var_1_10025
				var_1_10019 = var_1_10019(var_1_10021, var_15_11, var_1_10023(var_1_10025))
				table = var_20

				var_20.insert(var_15_2, {
					runtimeAnimator = var_1_10019,
					name = var_15_10
				})
			end
		end
	else
		for iter_15_4 = 0, var_15_5 do
			local var_15_12 = var_15_6 .. "_L" .. iter_15_4

			LoadAny = var_15

			local var_15_13 = var_15_7
			local var_15_14 = var_15_12

			typeof = var_1_10019
			RuntimeAnimatorController = var_1_10021

			local var_15_15 = var_15(var_15_13, var_15_14, var_1_10019(var_1_10021))

			table = var_16

			var_16.insert(var_15_2, {
				runtimeAnimator = var_15_15,
				name = var_15_12
			})
		end
	end

	var_15_1.battleData = var_15_0
	var_15_1.animDatas = var_15_2

	local var_15_16 = arg_15_0.charDic

	var_15_16[arg_15_1] = var_15_1
	Clone = var_15_16

	return var_15_16(arg_15_0.charDic[arg_15_1])
end

function var_0_0.createAcCake(arg_16_0, arg_16_1)
	if not arg_16_0.acCakes then
		arg_16_0.acCakes = {}
	end

	local var_16_0 = arg_16_1.cakeId
	local var_16_1 = arg_16_1.startPos
	local var_16_2 = arg_16_1.targetPos
	local var_16_3 = arg_16_1.callback

	tf = var_1_10006
	instantiate = var_1_10008

	local var_16_4 = var_1_10006(var_1_10008(arg_16_0._cakeTpl))

	GetSpriteFromAtlasAsync = var_1_10007

	var_1_10007(arg_16_0._gameData.path, "cake_" .. var_16_0, function(arg_17_0)
		setImageSprite = var_2_10001
		findTF = var_2_10003

		var_2_10001(var_2_10003(var_16_4, "img"), arg_17_0, true)

		return
	end)

	SetParent = var_1_10007

	var_1_10007(var_16_4, arg_16_0._scene)

	setActive = var_1_10007

	var_1_10007(var_16_4, true)

	var_16_4.anchoredPosition = var_16_1

	local var_16_5 = {
		tf = var_16_4,
		targetPos = var_16_2,
		callback = var_16_3
	}

	table = var_8

	var_8.insert(arg_16_0.acCakes, var_16_5)

	return
end

function var_0_0.clearAcCake(arg_18_0)
	if arg_18_0.acCakes then
		for iter_18_0 = 1, #arg_18_0.acCakes do
			local var_18_0 = arg_18_0.acCakes[iter_18_0].tf

			Destroy = var_1_10006

			var_1_10006(var_18_0)
		end
	end

	arg_18_0.acCakes = {}

	return
end

function var_0_0.getBattleData(arg_19_0, arg_19_1)
	local var_19_0 = 1

	CookGameConst = var_1_10003

	for iter_19_0 = var_19_0, #var_1_10003.char_battle_data do
		CookGameConst = var_1_10006

		if var_1_10006.char_battle_data[iter_19_0].id == arg_19_1 then
			Clone = var_1_10006
			CookGameConst = var_1_10008

			return var_1_10006(var_1_10008.char_battle_data[iter_19_0])
		end
	end

	return nil
end

function var_0_0.setJudgeAction(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_2 = arg_20_2 or arg_20_0.playerChar

	if #arg_20_2:getCakeIds() > 0 then
		local var_20_0 = arg_20_1:getTf()
		local var_20_1 = arg_20_1:getIndex()
		local var_20_2 = arg_20_2:getPos()
		local var_20_3 = arg_20_1:getPos()
		local var_20_4

		if var_20_2.x < var_20_3.x then
			local var_20_5 = arg_20_1:getLeftTf()
			local var_20_6 = arg_20_0._scene

			var_20_4 = var_10.InverseTransformPoint(var_20_6, var_20_5.position)
		else
			local var_20_7 = arg_20_1:getRightTf()
			local var_20_8 = arg_20_0._scene

			var_20_4 = var_10.InverseTransformPoint(var_20_8, var_20_7.position)
		end

		local var_20_9 = {
			judge = arg_20_1,
			judgeIndex = var_20_1,
			targetPos = var_20_4,
			tf = var_20_0,
			acPos = var_20_2
		}

		arg_20_2:setJudge(var_20_9)

		if arg_20_3 then
			arg_20_3(true)
		end
	elseif arg_20_3 then
		arg_20_3(false)
	end

	return
end

function var_0_0.clear(arg_21_0)
	local var_21_0 = arg_21_0.playerChar

	var_1.clear(var_21_0)

	local var_21_1 = arg_21_0.partnerChar

	var_1.clear(var_21_1)

	local var_21_2 = arg_21_0.enemy1Char

	var_1.clear(var_21_2)

	local var_21_3 = arg_21_0.enemy2Char

	var_1.clear(var_21_3)
	arg_21_0:clearAcCake()

	return
end

function var_0_0.destroy(arg_22_0)
	return
end

return var_0_0
