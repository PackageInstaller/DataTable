local var_0_0 = class("CookGameCharController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneContainer = arg_1_1
	arg_1_0._scene = findTF(arg_1_0._sceneContainer, "scene")
	arg_1_0._tpl = findTF(arg_1_1, "scene_background/charTpl")
	arg_1_0._cakeTpl = findTF(arg_1_1, "scene_background/cakeTpl")

	setActive(arg_1_0._cakeTpl, false)
	setActive(arg_1_0._tpl, false)

	arg_1_0._gameData = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0.playerChar = CookGameChar.New(tf(instantiate(arg_1_0._tpl)), arg_1_0._gameData, arg_1_0._event)

	arg_1_0.playerChar:isPlayer(true)

	arg_1_0.partnerChar = CookGameChar.New(tf(instantiate(arg_1_0._tpl)), arg_1_0._gameData, arg_1_0._event)

	arg_1_0.partnerChar:isPartner(true)

	arg_1_0.partnerPet = CookGameChar.New(tf(instantiate(arg_1_0._tpl)), arg_1_0._gameData, arg_1_0._event)

	arg_1_0.partnerPet:isPartner(true)

	arg_1_0.enemy1Char = CookGameChar.New(tf(instantiate(arg_1_0._tpl)), arg_1_0._gameData, arg_1_0._event)
	arg_1_0.enemy2Char = CookGameChar.New(tf(instantiate(arg_1_0._tpl)), arg_1_0._gameData, arg_1_0._event)
	arg_1_0.enemyPet = CookGameChar.New(tf(instantiate(arg_1_0._tpl)), arg_1_0._gameData, arg_1_0._event)

	arg_1_0.playerChar:setParent(arg_1_0._sceneContainer, CookGameConst.char_instiate_data[CookGameConst.player_char])
	arg_1_0.partnerChar:setParent(arg_1_0._sceneContainer, CookGameConst.char_instiate_data[CookGameConst.parter_char])
	arg_1_0.partnerPet:setParent(arg_1_0._sceneContainer, CookGameConst.char_instiate_data[CookGameConst.parter_pet])
	arg_1_0.enemy1Char:setParent(arg_1_0._sceneContainer, CookGameConst.char_instiate_data[CookGameConst.enemy1_char])
	arg_1_0.enemy2Char:setParent(arg_1_0._sceneContainer, CookGameConst.char_instiate_data[CookGameConst.enemy2_char])
	arg_1_0.enemyPet:setParent(arg_1_0._sceneContainer, CookGameConst.char_instiate_data[CookGameConst.enemy_pet])
	arg_1_0.enemy1Char:isPartner(false)
	arg_1_0.enemy2Char:isPartner(false)
	arg_1_0.enemyPet:isPartner(false)

	arg_1_0.chars = {
		arg_1_0.playerChar,
		arg_1_0.partnerChar,
		arg_1_0.enemy1Char,
		arg_1_0.enemy2Char,
		arg_1_0.partnerPet,
		arg_1_0.enemyPet
	}
	arg_1_0._playerBox = findTF(arg_1_0._sceneContainer, "scene_background/playerBox")
	arg_1_0.uiCam = arg_1_0.uiCam or GameObject.Find("UICamera"):GetComponent("Camera")
	arg_1_0._playerCollider = findTF(arg_1_0._playerBox, "collider")
	arg_1_0._playerColliderEvenet = GetComponent(arg_1_0._playerCollider, typeof(EventTriggerListener))

	arg_1_0._playerColliderEvenet:AddPointDownFunc(function(arg_2_0, arg_2_1)
		arg_1_0.playerChar:clearCake()
		arg_1_0.playerChar:clearJudge()
		arg_1_0.playerChar:setTargetPos(arg_1_0._scene:InverseTransformPoint((arg_1_0.uiCam:ScreenToWorldPoint(arg_2_1.pressPosition))), nil)

		return
	end)

	arg_1_0.playerCakes = {}

	for iter_1_0 = 1, arg_1_0._gameData.cake_num do
		local var_1_0 = iter_1_0
		local var_1_1 = findTF(arg_1_0._playerBox, "table/cake/" .. iter_1_0)
		local var_1_2 = findTF(var_1_1, "pos")
		local var_1_3 = GetComponent(findTF(var_1_1, "collider"), typeof(EventTriggerListener))

		var_1_3:AddPointDownFunc(function(arg_3_0, arg_3_1)
			arg_1_0:onPickupCake(arg_1_0.playerChar, var_1_0, arg_1_0.playerCakes, true)

			return
		end)
		table.insert(arg_1_0.playerCakes, {
			tf = var_1_1,
			pos = var_1_2,
			id = iter_1_0,
			event = var_1_3
		})
	end

	arg_1_0.enemyCakes = {}
	arg_1_0._enemyBox = findTF(arg_1_0._sceneContainer, "scene_background/enemyBox")

	for iter_1_1 = 1, arg_1_0._gameData.cake_num do
		local var_1_4 = findTF(arg_1_0._enemyBox, "table/cake/" .. iter_1_1)

		table.insert(arg_1_0.enemyCakes, {
			tf = var_1_4,
			pos = findTF(var_1_4, "pos"),
			id = iter_1_1,
			event = arg_1_3
		})
	end

	arg_1_0.acCakes = {}

	return
end

function var_0_0.changeSpeed(arg_4_0, arg_4_1)
	for iter_4_0 = 1, #arg_4_0.chars do
		arg_4_0.chars[iter_4_0]:changeSpeed(arg_4_1)
	end

	return
end

function var_0_0.onPickupCake(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_1:isActiving() then
		return
	end

	for iter_5_0 = 1, #arg_5_3 do
		if arg_5_3[iter_5_0].id == arg_5_2 then
			arg_5_3[iter_5_0].cakePos = arg_5_0._scene:InverseTransformPoint(findTF(arg_5_3[iter_5_0].tf, "pos").position)

			arg_5_1:setCake(arg_5_3[iter_5_0])

			if arg_5_4 then
				setActive(findTF(arg_5_3[iter_5_0].tf, "select"), true)
			end
		else
			setActive(findTF(arg_5_3[iter_5_0].tf, "select"), false)
		end
	end

	return
end

function var_0_0.readyStart(arg_6_0)
	arg_6_0.playerChar:setData(arg_6_0:createCharData(arg_6_0._gameData.playerChar))
	arg_6_0.partnerChar:setData(arg_6_0:createCharData(arg_6_0._gameData.partnerChar))

	if arg_6_0._gameData.partnerPet then
		arg_6_0.partnerPet:setData(arg_6_0:createCharData(arg_6_0._gameData.partnerPet))
	else
		arg_6_0.partnerPet:setData(nil)
	end

	arg_6_0.enemy1Char:setData(arg_6_0:createCharData(arg_6_0._gameData.enemy1Char))
	arg_6_0.enemy2Char:setData(arg_6_0:createCharData(arg_6_0._gameData.enemy2Char))

	if arg_6_0._gameData.enemyPet then
		arg_6_0.enemyPet:setData(arg_6_0:createCharData(arg_6_0._gameData.enemyPet))
	else
		arg_6_0.enemyPet:setData(nil)
	end

	arg_6_0.playerChar:readyStart()
	arg_6_0.partnerChar:readyStart()
	arg_6_0.partnerPet:readyStart()
	arg_6_0.enemy1Char:readyStart()
	arg_6_0.enemy2Char:readyStart()
	arg_6_0.enemyPet:readyStart()

	arg_6_0.sceneTfs = nil

	return
end

function var_0_0.start(arg_7_0)
	return
end

function var_0_0.step(arg_8_0, arg_8_1)
	for iter_8_0 = 1, #arg_8_0.chars do
		if arg_8_0.chars[iter_8_0]:getCharActive() then
			local var_8_1 = var_8_0:getTargetPos()
			local var_8_2 = var_8_0:getVelocity()

			if var_8_1 then
				local var_8_3 = var_8_0:getPos()

				if not var_8_2 then
					if math.abs(var_8_1.y - var_8_3.y) ~= 0 then
						local var_8_4 = math.atan(math.abs(var_8_1.y - var_8_3.y) / math.abs(var_8_1.x - var_8_3.x))

						var_8_0:setVelocity(math.cos(var_8_4) * (var_8_1.x > var_8_3.x and 1 or -1), math.sin(var_8_4) * (var_8_1.y > var_8_3.y and 1 or -1), var_8_4)
					else
						var_8_0:stopMove()
					end
				end
			elseif var_8_0:getJudgeData() then
				var_8_0:setTargetPos(var_8_0:getJudgeData().targetPos)
			elseif var_8_0:getCake() then
				var_8_0:setTargetPos(var_8_0:getCake().cakePos)
			end

			var_8_0:step(arg_8_1)
		end
	end

	if not arg_8_0.sceneTfs then
		arg_8_0.sceneTfs = {}
		arg_8_0.judgeNum = 0

		for iter_8_1 = 0, arg_8_0._scene.childCount - 1 do
			local var_8_5 = arg_8_0._scene:GetChild(iter_8_1)

			if string.match(var_8_5.name, "judge") then
				arg_8_0.judgeNum = arg_8_0.judgeNum + 1

				table.insert({}, var_8_5)
			else
				table.insert(arg_8_0.sceneTfs, {
					tf = var_8_5,
					offset = arg_8_0:getTfOffset(var_8_5.name)
				})
			end
		end

		table.sort({}, function(arg_9_0, arg_9_1)
			if arg_9_0.anchoredPosition.y > arg_9_1.anchoredPosition.y then
				return true
			else
				return false
			end

			return
		end)
	end

	table.sort(arg_8_0.sceneTfs, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0.tf.anchoredPosition

		if arg_10_0.offset then
			local var_10_1 = arg_10_0.offset or Vector2(0, 0)
			local var_10_2 = arg_10_1.tf.anchoredPosition

			if arg_10_1.offset then
				local var_10_3 = arg_10_1.offset or Vector2(0, 0)

				if var_10_0.y + var_10_1.y > var_10_2.y + var_10_3.y then
					return true
				else
					return false
				end

				return
			end
		end
	end)

	for iter_8_2 = 1, #arg_8_0.sceneTfs do
		arg_8_0.sceneTfs[iter_8_2].tf:SetSiblingIndex(iter_8_2 - 1 + arg_8_0.judgeNum)
	end

	arg_8_0._judges = arg_8_0._judges or arg_8_0._gameData.judges

	local var_8_6 = arg_8_0:getFillterWanted({
		arg_8_0.partnerChar
	})

	if CookGameConst.player_use_ai then
		arg_8_0:setCharAction(arg_8_0.playerChar, arg_8_0:getFillterWanted({
			arg_8_0.playerChar,
			arg_8_0.partnerPet
		}), arg_8_0.playerCakes)
	end

	arg_8_0:setCharAction(arg_8_0.partnerChar, var_8_6, arg_8_0.playerCakes)
	arg_8_0:setCharAction(arg_8_0.partnerPet, arg_8_0:getFillterWanted({
		arg_8_0.playerChar,
		arg_8_0.partnerPet
	}), arg_8_0.playerCakes)

	if arg_8_0._gameData.gameTime and arg_8_0._gameData.gameTime > 0 then
		arg_8_0:setCharAction(arg_8_0.enemy1Char, arg_8_0:getFillterWanted({
			arg_8_0.enemy2Char,
			arg_8_0.enemyPet
		}), arg_8_0.enemyCakes)
		arg_8_0:setCharAction(arg_8_0.enemy2Char, arg_8_0:getFillterWanted({
			arg_8_0.enemy1Char,
			arg_8_0.enemyPet
		}), arg_8_0.enemyCakes)
		arg_8_0:setCharAction(arg_8_0.enemyPet, arg_8_0:getFillterWanted({
			arg_8_0.enemy1Char,
			arg_8_0.enemy2Char
		}), arg_8_0.enemyCakes)
	end

	for iter_8_3 = #arg_8_0.acCakes, 1, -1 do
		local var_8_8 = arg_8_0.acCakes[iter_8_3].tf.anchoredPosition
		local var_8_9 = arg_8_0.acCakes[iter_8_3].targetPos
		local var_8_10 = math.atan(math.abs(arg_8_0.acCakes[iter_8_3].targetPos.y - arg_8_0.acCakes[iter_8_3].tf.anchoredPosition.y) / math.abs(arg_8_0.acCakes[iter_8_3].targetPos.x - arg_8_0.acCakes[iter_8_3].tf.anchoredPosition.x))
		local var_8_11 = Vector2(arg_8_0.acCakes[iter_8_3].tf.anchoredPosition.x + math.cos(var_8_10) * (arg_8_0.acCakes[iter_8_3].targetPos.x > arg_8_0.acCakes[iter_8_3].tf.anchoredPosition.x and 1 or -1) * 600 * arg_8_1, arg_8_0.acCakes[iter_8_3].tf.anchoredPosition.y + math.sin(var_8_10) * (arg_8_0.acCakes[iter_8_3].targetPos.y > arg_8_0.acCakes[iter_8_3].tf.anchoredPosition.y and 1 or -1) * 600 * arg_8_1)
		local var_8_12 = arg_8_0.acCakes[iter_8_3].tf.anchoredPosition

		var_8_12.x = arg_8_0.acCakes[iter_8_3].tf.anchoredPosition.x < arg_8_0.acCakes[iter_8_3].targetPos.x and var_8_11.x < var_8_9.x and var_8_11.x or var_8_8.x > var_8_9.x and var_8_11.x > var_8_9.x and var_8_11.x or var_8_9.x
		var_8_12.y = var_8_8.y < var_8_9.y and var_8_11.y < var_8_9.y and var_8_11.y or var_8_8.y > var_8_9.y and var_8_11.y > var_8_9.y and var_8_11.y or var_8_9.y
		arg_8_0.acCakes[iter_8_3].tf.anchoredPosition = var_8_12

		if math.abs(var_8_12.y - var_8_9.y) < 3 and math.abs(var_8_12.x - var_8_9.x) < 3 then
			local var_8_13 = table.remove(arg_8_0.acCakes, iter_8_3)

			if var_8_13.callback then
				var_8_13.callback()
			end

			Destroy(var_8_13.tf)
		end
	end

	return
end

function var_0_0.getTfOffset(arg_11_0, arg_11_1)
	for iter_11_0 = 1, #arg_11_0.chars do
		if arg_11_0.chars[iter_11_0]:getTf().name == arg_11_1 then
			return arg_11_0.chars[iter_11_0]:getOffset()
		end
	end

	return Vector2(0, 0)
end

function var_0_0.getFillterWanted(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		if iter_12_1:getCharActive() then
			local var_12_0 = iter_12_1:getJudge()

			for iter_12_2 = 1, #arg_12_0._judges do
				if (not var_12_0 or arg_12_0._judges[iter_12_2] ~= var_12_0) and not arg_12_0._judges[iter_12_2]:isInServe() and not arg_12_0._judges[iter_12_2]:isInTrigger() and arg_12_0._judges[iter_12_2]:getWantedCake() then
					table.insert({}, arg_12_0._judges[iter_12_2]:getWantedCake())
				end
			end
		end
	end

	return {}
end

function var_0_0.setCharAction(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_1:getCharActive() then
		return
	end

	if arg_13_1:isActiving() then
		return
	end

	local var_13_0 = arg_13_1:getCakeIds()

	if #var_13_0 > 0 then
		if arg_13_1:getCake() then
			return
		elseif arg_13_1:getJudge() then
			local var_13_1 = arg_13_1:getJudge()

			if var_13_1:isInTrigger() and var_13_1:isInServe() then
				arg_13_1:clearJudge()
				arg_13_1:stopMove()
			end

			return
		elseif not arg_13_1:isFullCakes() and arg_13_1:getPickupFull() then
			arg_13_0:onPickupCake(arg_13_1, arg_13_2[math.random(1, #arg_13_2)], arg_13_3, false)

			return
		end

		local var_13_2 = {}

		for iter_13_0 = 1, #arg_13_0._judges do
			if not arg_13_0._judges[iter_13_0]:isInTrigger() and not arg_13_0._judges[iter_13_0]:isInServe() then
				if table.contains(var_13_0, arg_13_0._judges[iter_13_0]:getWantedCake()) then
					table.insert(var_13_2, arg_13_0._judges[iter_13_0])
				elseif arg_13_1:getId() == 7 then
					table.insert(var_13_2, arg_13_0._judges[iter_13_0])
				end
			end
		end

		if #var_13_2 == 0 then
			if not arg_13_1:getCake() then
				arg_13_0:onPickupCake(arg_13_1, arg_13_2[math.random(1, #arg_13_2)], arg_13_3, false)
			end
		else
			arg_13_0:setJudgeAction(var_13_2[math.random(1, #var_13_2)], arg_13_1, function()
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

		arg_13_0:onPickupCake(arg_13_1, arg_13_2[math.random(1, #arg_13_2)], arg_13_3, false)
	end

	return
end

function var_0_0.createCharData(arg_15_0, arg_15_1)
	arg_15_0.charDic = arg_15_0.charDic or {}

	if arg_15_0.charDic[arg_15_1] then
		return Clone(arg_15_0.charDic[arg_15_1])
	end

	local var_15_0 = arg_15_0:getBattleData(arg_15_1)
	local var_15_1 = {}
	local var_15_2 = {}
	local var_15_3 = var_15_0.name

	if var_15_0.double_able then
		for iter_15_0 = 0, arg_15_0._gameData.cake_num do
			for iter_15_1 = 0, arg_15_0._gameData.cake_num do
				local var_15_4

				if iter_15_0 == 0 and iter_15_1 == 0 or iter_15_0 ~= 0 then
					var_15_4 = var_15_3 .. "_L" .. iter_15_0 .. "_R" .. iter_15_1
				end

				if var_15_4 then
					table.insert(var_15_2, {
						runtimeAnimator = LoadAny(arg_15_0._gameData.char_path .. "cookgame" .. var_15_0.name .. "_atlas", var_15_4, typeof(RuntimeAnimatorController)),
						name = var_15_4
					})
				end
			end
		end
	elseif var_15_0.speed_able then
		for iter_15_2 = 0, arg_15_0._gameData.cake_num do
			for iter_15_3 = 0, arg_15_0._gameData.speed_num do
				table.insert(var_15_2, {
					runtimeAnimator = LoadAny(arg_15_0._gameData.char_path .. "cookgame" .. var_15_0.name .. "_atlas", var_15_3 .. "_L" .. iter_15_2 .. "_" .. iter_15_3, typeof(RuntimeAnimatorController)),
					name = var_15_3 .. "_L" .. iter_15_2 .. "_" .. iter_15_3
				})
			end
		end
	else
		for iter_15_4 = 0, arg_15_0._gameData.cake_num do
			table.insert(var_15_2, {
				runtimeAnimator = LoadAny(arg_15_0._gameData.char_path .. "cookgame" .. var_15_0.name .. "_atlas", var_15_3 .. "_L" .. iter_15_4, typeof(RuntimeAnimatorController)),
				name = var_15_3 .. "_L" .. iter_15_4
			})
		end
	end

	var_15_1.battleData = var_15_0
	var_15_1.animDatas = var_15_2
	arg_15_0.charDic[arg_15_1] = var_15_1

	return Clone(arg_15_0.charDic[arg_15_1])
end

function var_0_0.createAcCake(arg_16_0, arg_16_1)
	local var_16_0

	if not arg_16_0.acCakes then
		arg_16_0.acCakes = {}
		var_16_0 = tf(instantiate(arg_16_0._cakeTpl))
	end

	GetSpriteFromAtlasAsync(arg_16_0._gameData.path, "cake_" .. arg_16_1.cakeId, function(arg_17_0)
		setImageSprite(findTF(var_16_0, "img"), arg_17_0, true)

		return
	end)
	SetParent(var_16_0, arg_16_0._scene)
	setActive(var_16_0, true)

	var_16_0.anchoredPosition = arg_16_1.startPos

	table.insert(arg_16_0.acCakes, {
		tf = var_16_0,
		targetPos = arg_16_1.targetPos,
		callback = arg_16_1.callback
	})

	return
end

function var_0_0.clearAcCake(arg_18_0)
	if arg_18_0.acCakes then
		for iter_18_0 = 1, #arg_18_0.acCakes do
			Destroy(arg_18_0.acCakes[iter_18_0].tf)
		end
	end

	arg_18_0.acCakes = {}

	return
end

function var_0_0.getBattleData(arg_19_0, arg_19_1)
	for iter_19_0 = 1, #CookGameConst.char_battle_data do
		if CookGameConst.char_battle_data[iter_19_0].id == arg_19_1 then
			return Clone(CookGameConst.char_battle_data[iter_19_0])
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
		local var_20_3 = var_20_2.x < arg_20_1:getPos().x and arg_20_0._scene:InverseTransformPoint(arg_20_1:getLeftTf().position) or arg_20_0._scene:InverseTransformPoint(arg_20_1:getRightTf().position)

		arg_20_2:setJudge({
			judge = arg_20_1,
			judgeIndex = var_20_1,
			targetPos = var_20_3,
			tf = var_20_0,
			acPos = var_20_2
		})

		if arg_20_3 then
			arg_20_3(true)
		end
	elseif arg_20_3 then
		arg_20_3(false)
	end

	return
end

function var_0_0.clear(arg_21_0)
	arg_21_0.playerChar:clear()
	arg_21_0.partnerChar:clear()
	arg_21_0.enemy1Char:clear()
	arg_21_0.enemy2Char:clear()
	arg_21_0:clearAcCake()

	return
end

function var_0_0.destroy(arg_22_0)
	return
end

return var_0_0
