local CookGameCharController = class("CookGameCharController")

function CookGameCharController:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._sceneContainer = arg_1_1
	self._scene = findTF(self._sceneContainer, "scene")
	self._tpl = findTF(arg_1_1, "scene_background/charTpl")
	self._cakeTpl = findTF(arg_1_1, "scene_background/cakeTpl")

	setActive(self._cakeTpl, false)
	setActive(self._tpl, false)

	self._gameData = arg_1_2
	self._event = arg_1_3
	self.playerChar = CookGameChar.New(tf(instantiate(self._tpl)), self._gameData, self._event)

	self.playerChar:isPlayer(true)

	self.partnerChar = CookGameChar.New(tf(instantiate(self._tpl)), self._gameData, self._event)

	self.partnerChar:isPartner(true)

	self.partnerPet = CookGameChar.New(tf(instantiate(self._tpl)), self._gameData, self._event)

	self.partnerPet:isPartner(true)

	self.enemy1Char = CookGameChar.New(tf(instantiate(self._tpl)), self._gameData, self._event)
	self.enemy2Char = CookGameChar.New(tf(instantiate(self._tpl)), self._gameData, self._event)
	self.enemyPet = CookGameChar.New(tf(instantiate(self._tpl)), self._gameData, self._event)

	self.playerChar:setParent(self._sceneContainer, CookGameConst.char_instiate_data[CookGameConst.player_char])
	self.partnerChar:setParent(self._sceneContainer, CookGameConst.char_instiate_data[CookGameConst.parter_char])
	self.partnerPet:setParent(self._sceneContainer, CookGameConst.char_instiate_data[CookGameConst.parter_pet])
	self.enemy1Char:setParent(self._sceneContainer, CookGameConst.char_instiate_data[CookGameConst.enemy1_char])
	self.enemy2Char:setParent(self._sceneContainer, CookGameConst.char_instiate_data[CookGameConst.enemy2_char])
	self.enemyPet:setParent(self._sceneContainer, CookGameConst.char_instiate_data[CookGameConst.enemy_pet])
	self.enemy1Char:isPartner(false)
	self.enemy2Char:isPartner(false)
	self.enemyPet:isPartner(false)

	self.chars = {
		self.playerChar,
		self.partnerChar,
		self.enemy1Char,
		self.enemy2Char,
		self.partnerPet,
		self.enemyPet
	}
	self._playerBox = findTF(self._sceneContainer, "scene_background/playerBox")
	self.uiCam = self.uiCam or GameObject.Find("UICamera"):GetComponent("Camera")
	self._playerCollider = findTF(self._playerBox, "collider")
	self._playerColliderEvenet = GetComponent(self._playerCollider, typeof(EventTriggerListener))

	self._playerColliderEvenet:AddPointDownFunc(function(arg_2_0, arg_2_1)
		self.playerChar:clearCake()
		self.playerChar:clearJudge()
		self.playerChar:setTargetPos(self._scene:InverseTransformPoint((self.uiCam:ScreenToWorldPoint(arg_2_1.pressPosition))), nil)

		return
	end)

	self.playerCakes = {}

	for iter_1_0 = 1, self._gameData.cake_num do
		local var_1_0 = iter_1_0
		local var_1_1 = findTF(self._playerBox, "table/cake/" .. iter_1_0)
		local var_1_2 = findTF(var_1_1, "pos")
		local var_1_3 = GetComponent(findTF(var_1_1, "collider"), typeof(EventTriggerListener))

		var_1_3:AddPointDownFunc(function(arg_3_0, arg_3_1)
			self:onPickupCake(self.playerChar, var_1_0, self.playerCakes, true)

			return
		end)
		table.insert(self.playerCakes, {
			tf = var_1_1,
			pos = var_1_2,
			id = iter_1_0,
			event = var_1_3
		})
	end

	self.enemyCakes = {}
	self._enemyBox = findTF(self._sceneContainer, "scene_background/enemyBox")

	for iter_1_1 = 1, self._gameData.cake_num do
		local var_1_4 = findTF(self._enemyBox, "table/cake/" .. iter_1_1)

		table.insert(self.enemyCakes, {
			tf = var_1_4,
			pos = findTF(var_1_4, "pos"),
			id = iter_1_1,
			event = arg_1_3
		})
	end

	self.acCakes = {}

	return
end

function CookGameCharController:changeSpeed(arg_4_1)
	for iter_4_0 = 1, #self.chars do
		self.chars[iter_4_0]:changeSpeed(arg_4_1)
	end

	return
end

function CookGameCharController:onPickupCake(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_1:isActiving() then
		return
	end

	for iter_5_0 = 1, #arg_5_3 do
		if arg_5_3[iter_5_0].id == arg_5_2 then
			arg_5_3[iter_5_0].cakePos = self._scene:InverseTransformPoint(findTF(arg_5_3[iter_5_0].tf, "pos").position)

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

function CookGameCharController:readyStart()
	self.playerChar:setData(self:createCharData(self._gameData.playerChar))
	self.partnerChar:setData(self:createCharData(self._gameData.partnerChar))

	if self._gameData.partnerPet then
		self.partnerPet:setData(self:createCharData(self._gameData.partnerPet))
	else
		self.partnerPet:setData(nil)
	end

	self.enemy1Char:setData(self:createCharData(self._gameData.enemy1Char))
	self.enemy2Char:setData(self:createCharData(self._gameData.enemy2Char))

	if self._gameData.enemyPet then
		self.enemyPet:setData(self:createCharData(self._gameData.enemyPet))
	else
		self.enemyPet:setData(nil)
	end

	self.playerChar:readyStart()
	self.partnerChar:readyStart()
	self.partnerPet:readyStart()
	self.enemy1Char:readyStart()
	self.enemy2Char:readyStart()
	self.enemyPet:readyStart()

	self.sceneTfs = nil

	return
end

function CookGameCharController:start()
	return
end

function CookGameCharController:step(arg_8_1)
	for iter_8_0 = 1, #self.chars do
		local var_8_0 = self.chars[iter_8_0]

		if self.chars[iter_8_0]:getCharActive() then
			local var_8_1 = var_8_0:getTargetPos()

			if var_8_1 then
				local var_8_2 = var_8_0:getPos()

				if not var_8_0:getVelocity() then
					if math.abs(var_8_1.y - var_8_2.y) ~= 0 then
						local var_8_3 = math.atan(math.abs(var_8_1.y - var_8_2.y) / math.abs(var_8_1.x - var_8_2.x))

						var_8_0:setVelocity(math.cos(var_8_3) * (var_8_1.x > var_8_2.x and 1 or -1), math.sin(var_8_3) * (var_8_1.y > var_8_2.y and 1 or -1), var_8_3)
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

	if not self.sceneTfs then
		self.sceneTfs = {}

		local var_8_4 = {}

		self.judgeNum = 0

		for iter_8_1 = 0, self._scene.childCount - 1 do
			local var_8_5 = self._scene:GetChild(iter_8_1)

			if string.match(var_8_5.name, "judge") then
				self.judgeNum = self.judgeNum + 1

				table.insert(var_8_4, var_8_5)
			else
				table.insert(self.sceneTfs, {
					tf = var_8_5,
					offset = self:getTfOffset(var_8_5.name)
				})
			end
		end

		table.sort(var_8_4, function(arg_9_0, arg_9_1)
			if arg_9_0.anchoredPosition.y > arg_9_1.anchoredPosition.y then
				return true
			else
				return false
			end

			return
		end)
	end

	table.sort(self.sceneTfs, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0.tf.anchoredPosition

		if arg_10_1.offset then
			if var_10_0.y + ((arg_10_0.offset or nil) and (arg_10_0.offset or Vector2(0, 0))).y > arg_10_1.tf.anchoredPosition.y + (arg_10_1.offset or Vector2(0, 0)).y then
				do return true end

				goto label_10_0
			end
		end

		do return false end

		::label_10_0::

		return
	end)

	for iter_8_2 = 1, #self.sceneTfs do
		self.sceneTfs[iter_8_2].tf:SetSiblingIndex(iter_8_2 - 1 + self.judgeNum)
	end

	self._judges = self._judges or self._gameData.judges

	local var_8_6 = self:getFillterWanted({
		self.partnerChar
	})

	if CookGameConst.player_use_ai then
		self:setCharAction(self.playerChar, self:getFillterWanted({
			self.playerChar,
			self.partnerPet
		}), self.playerCakes)
	end

	self:setCharAction(self.partnerChar, var_8_6, self.playerCakes)
	self:setCharAction(self.partnerPet, self:getFillterWanted({
		self.playerChar,
		self.partnerPet
	}), self.playerCakes)

	if self._gameData.gameTime and self._gameData.gameTime > 0 then
		self:setCharAction(self.enemy1Char, self:getFillterWanted({
			self.enemy2Char,
			self.enemyPet
		}), self.enemyCakes)
		self:setCharAction(self.enemy2Char, self:getFillterWanted({
			self.enemy1Char,
			self.enemyPet
		}), self.enemyCakes)
		self:setCharAction(self.enemyPet, self:getFillterWanted({
			self.enemy1Char,
			self.enemy2Char
		}), self.enemyCakes)
	end

	for iter_8_3 = #self.acCakes, 1, -1 do
		local var_8_8 = self.acCakes[iter_8_3].tf.anchoredPosition
		local var_8_9 = self.acCakes[iter_8_3].targetPos
		local var_8_10 = math.atan(math.abs(self.acCakes[iter_8_3].targetPos.y - self.acCakes[iter_8_3].tf.anchoredPosition.y) / math.abs(self.acCakes[iter_8_3].targetPos.x - self.acCakes[iter_8_3].tf.anchoredPosition.x))
		local var_8_11 = Vector2(self.acCakes[iter_8_3].tf.anchoredPosition.x + math.cos(var_8_10) * (self.acCakes[iter_8_3].targetPos.x > self.acCakes[iter_8_3].tf.anchoredPosition.x and 1 or -1) * 600 * arg_8_1, self.acCakes[iter_8_3].tf.anchoredPosition.y + math.sin(var_8_10) * (self.acCakes[iter_8_3].targetPos.y > self.acCakes[iter_8_3].tf.anchoredPosition.y and 1 or -1) * 600 * arg_8_1)
		local var_8_12 = self.acCakes[iter_8_3].tf.anchoredPosition

		var_8_12.x = self.acCakes[iter_8_3].tf.anchoredPosition.x < self.acCakes[iter_8_3].targetPos.x and var_8_11.x < var_8_9.x and var_8_11.x or var_8_8.x > var_8_9.x and var_8_11.x > var_8_9.x and var_8_11.x or var_8_9.x
		var_8_12.y = var_8_8.y < var_8_9.y and var_8_11.y < var_8_9.y and var_8_11.y or var_8_8.y > var_8_9.y and var_8_11.y > var_8_9.y and var_8_11.y or var_8_9.y
		self.acCakes[iter_8_3].tf.anchoredPosition = var_8_12

		if math.abs(var_8_12.y - var_8_9.y) < 3 and math.abs(var_8_12.x - var_8_9.x) < 3 then
			local var_8_13 = table.remove(self.acCakes, iter_8_3)

			if var_8_13.callback then
				var_8_13.callback()
			end

			Destroy(var_8_13.tf)
		end
	end

	return
end

function CookGameCharController:getTfOffset(arg_11_1)
	for iter_11_0 = 1, #self.chars do
		if self.chars[iter_11_0]:getTf().name == arg_11_1 then
			return self.chars[iter_11_0]:getOffset()
		end
	end

	return Vector2(0, 0)
end

function CookGameCharController:getFillterWanted(arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		if iter_12_1:getCharActive() then
			local var_12_1 = iter_12_1:getJudge()

			for iter_12_2 = 1, #self._judges do
				if (not var_12_1 or self._judges[iter_12_2] ~= var_12_1) and not self._judges[iter_12_2]:isInServe() and not self._judges[iter_12_2]:isInTrigger() and self._judges[iter_12_2]:getWantedCake() then
					table.insert(var_12_0, self._judges[iter_12_2]:getWantedCake())
				end
			end
		end
	end

	return var_12_0
end

function CookGameCharController:setCharAction(arg_13_1, arg_13_2, arg_13_3)
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
			self:onPickupCake(arg_13_1, arg_13_2[math.random(1, #arg_13_2)], arg_13_3, false)

			return
		end

		local var_13_2 = {}

		for iter_13_0 = 1, #self._judges do
			if not self._judges[iter_13_0]:isInTrigger() and not self._judges[iter_13_0]:isInServe() then
				if table.contains(var_13_0, self._judges[iter_13_0]:getWantedCake()) then
					table.insert(var_13_2, self._judges[iter_13_0])
				elseif arg_13_1:getId() == 7 then
					table.insert(var_13_2, self._judges[iter_13_0])
				end
			end
		end

		if #var_13_2 == 0 then
			if not arg_13_1:getCake() then
				self:onPickupCake(arg_13_1, arg_13_2[math.random(1, #arg_13_2)], arg_13_3, false)
			end
		else
			self:setJudgeAction(var_13_2[math.random(1, #var_13_2)], arg_13_1, function()
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

		self:onPickupCake(arg_13_1, arg_13_2[math.random(1, #arg_13_2)], arg_13_3, false)
	end

	return
end

function CookGameCharController:createCharData(arg_15_1)
	self.charDic = self.charDic or {}

	if self.charDic[arg_15_1] then
		return Clone(self.charDic[arg_15_1])
	end

	local var_15_0 = self:getBattleData(arg_15_1)
	local var_15_1 = {}
	local var_15_2 = {}
	local var_15_3 = var_15_0.name

	if var_15_0.double_able then
		for iter_15_0 = 0, self._gameData.cake_num do
			for iter_15_1 = 0, self._gameData.cake_num do
				local var_15_4

				if iter_15_0 == 0 and iter_15_1 == 0 or iter_15_0 ~= 0 then
					var_15_4 = var_15_3 .. "_L" .. iter_15_0 .. "_R" .. iter_15_1
				end

				if var_15_4 then
					table.insert(var_15_2, {
						runtimeAnimator = LoadAny(self._gameData.char_path .. "cookgame" .. var_15_0.name .. "_atlas", var_15_4, typeof(RuntimeAnimatorController)),
						name = var_15_4
					})
				end
			end
		end
	elseif var_15_0.speed_able then
		for iter_15_2 = 0, self._gameData.cake_num do
			for iter_15_3 = 0, self._gameData.speed_num do
				table.insert(var_15_2, {
					runtimeAnimator = LoadAny(self._gameData.char_path .. "cookgame" .. var_15_0.name .. "_atlas", var_15_3 .. "_L" .. iter_15_2 .. "_" .. iter_15_3, typeof(RuntimeAnimatorController)),
					name = var_15_3 .. "_L" .. iter_15_2 .. "_" .. iter_15_3
				})
			end
		end
	else
		for iter_15_4 = 0, self._gameData.cake_num do
			table.insert(var_15_2, {
				runtimeAnimator = LoadAny(self._gameData.char_path .. "cookgame" .. var_15_0.name .. "_atlas", var_15_3 .. "_L" .. iter_15_4, typeof(RuntimeAnimatorController)),
				name = var_15_3 .. "_L" .. iter_15_4
			})
		end
	end

	var_15_1.battleData = var_15_0
	var_15_1.animDatas = var_15_2
	self.charDic[arg_15_1] = var_15_1

	return Clone(self.charDic[arg_15_1])
end

function CookGameCharController:createAcCake(arg_16_1)
	local var_16_0

	if not self.acCakes then
		self.acCakes = {}
		var_16_0 = tf(instantiate(self._cakeTpl))
	end

	GetSpriteFromAtlasAsync(self._gameData.path, "cake_" .. arg_16_1.cakeId, function(arg_17_0)
		setImageSprite(findTF(var_16_0, "img"), arg_17_0, true)

		return
	end)
	SetParent(var_16_0, self._scene)
	setActive(var_16_0, true)

	var_16_0.anchoredPosition = arg_16_1.startPos

	table.insert(self.acCakes, {
		tf = var_16_0,
		targetPos = arg_16_1.targetPos,
		callback = arg_16_1.callback
	})

	return
end

function CookGameCharController:clearAcCake()
	if self.acCakes then
		for iter_18_0 = 1, #self.acCakes do
			Destroy(self.acCakes[iter_18_0].tf)
		end
	end

	self.acCakes = {}

	return
end

function CookGameCharController:getBattleData(arg_19_1)
	for iter_19_0 = 1, #CookGameConst.char_battle_data do
		if CookGameConst.char_battle_data[iter_19_0].id == arg_19_1 then
			return Clone(CookGameConst.char_battle_data[iter_19_0])
		end
	end

	return nil
end

function CookGameCharController:setJudgeAction(arg_20_1, arg_20_2, arg_20_3)
	arg_20_2 = arg_20_2 or self.playerChar

	if #arg_20_2:getCakeIds() > 0 then
		local var_20_0 = arg_20_1:getTf()
		local var_20_1 = arg_20_1:getIndex()
		local var_20_2 = arg_20_2:getPos()
		local var_20_3 = var_20_2.x < arg_20_1:getPos().x and self._scene:InverseTransformPoint(arg_20_1:getLeftTf().position) or self._scene:InverseTransformPoint(arg_20_1:getRightTf().position)

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

function CookGameCharController:clear()
	self.playerChar:clear()
	self.partnerChar:clear()
	self.enemy1Char:clear()
	self.enemy2Char:clear()
	self:clearAcCake()

	return
end

function CookGameCharController:destroy()
	return
end

return CookGameCharController
