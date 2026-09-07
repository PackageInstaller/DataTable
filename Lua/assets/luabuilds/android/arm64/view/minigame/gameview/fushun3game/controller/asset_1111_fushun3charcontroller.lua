local Fushun3CharController = class("Fushun3CharController")
local var_0_1 = 3

function Fushun3CharController:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self._rectCollider = arg_1_1
	self._charTf = arg_1_2
	self._anim = findTF(self._charTf, "anim")
	self._pos = findTF(self._charTf, "pos")
	self._itemPos = findTF(self._charTf, "itemPos")
	self._dftEvent = GetOrAddComponent(self._anim, typeof(DftAniEvent))
	self._effectPos = findTF(self._charTf, "effectPos")
	self._effectFrPos = findTF(self._charTf, "effectFrPos")
	self._effectBkPos = findTF(self._charTf, "effectBkPos")
	self._powerSlider = arg_1_4
	self._collider = findTF(self._charTf, "collider")
	self._collider.gameObject.layer = LayerMask.NameToLayer("Character")

	self._dftEvent:SetTriggerEvent(function()
		local var_2_0
		local var_2_1 = self._animator:GetCurrentAnimatorClipInfo(0)

		if var_2_1 and var_2_1.Length > 0 then
			var_2_0 = ReflectionHelp.RefGetProperty(typeof("UnityEngine.AnimatorClipInfo"), "clip", var_2_1[0])
		end

		if var_2_0 then
			self._event:emit(Fushun3GameEvent.add_anim_effect_call, {
				clipName = var_2_0.name,
				targetTf = self._effectPos
			})
		end

		return
	end)

	self._charItemCatchTf = findTF(self._effectPos, "charItem")
	self._charItemCatch = GetComponent(findTF(self._charItemCatchTf, "catch"), typeof(Animator))
	self._charShieldTf = findTF(self._effectPos, "shield")
	self._collisionInfo = arg_1_3
	self._event = arg_1_5
	self._animator = GetComponent(self._anim, typeof(Animator))
	self._powerScript = self._rectCollider:getScript(FuShunPowerSpeedScript)
	self._jumpScript = self._rectCollider:getScript(FuShunJumpScript)
	self._damageScript = self._rectCollider:getScript(FuShunDamageScript)
	self._attackScript = self._rectCollider:getScript(FuShunAttakeScript)
	self._monsterLayer = LayerMask.NameToLayer("Character")
	self._damageTf = findTF(self._charTf, "damage")
	self._damageCollider = GetComponent(self._damageTf, typeof(BoxCollider2D))
	self._attackCd = nil

	self._event:bind(Fushun3GameEvent.script_jump_event, function()
		if self._attackCd == 0 and self.damageCd == 0 and self._animator then
			self._animator:SetTrigger("jump")
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_JUMP)
		end

		return
	end)
	self._event:bind(Fushun3GameEvent.script_attack_event, function()
		if self._attackCd == 0 and self.damageCd == 0 then
			self._animator:SetTrigger("attack")

			self._attackCd = Fushun3GameConst.attack_cd

			if self:getBuff(Fushun3GameConst.buff_weapon) then
				self._event:emit(Fushun3GameEvent.create_item_call, {
					name = math.random(1, 30) == 1 and "tamachan" or "rocket",
					pos = self._itemPos.position
				})
				self._charItemCatch:SetTrigger("attack")
			else
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_ATTACK)

				self._attackTime = Fushun3GameConst.attack_time
			end
		end

		return
	end)
	self._event:bind(Fushun3GameEvent.script_power_event, function(arg_5_0, arg_5_1, arg_5_2)
		self._animator:SetTrigger("ex")
		self._charItemCatch:SetTrigger("ex")

		return
	end)

	self.damageCd = 0
	self.buffList = {}

	if Application.isEditor then
		self.handle = self.handle or UpdateBeat:CreateListener(function()
			if Input.GetKeyDown(KeyCode.Y) then
				if self:getBuffById(Fushun3GameConst.buff_data[1].id) then
					self:removeBuff(Clone(Fushun3GameConst.buff_data[1]))
				else
					self:addBuff(Clone(Fushun3GameConst.buff_data[1]))
				end
			elseif Input.GetKeyDown(KeyCode.U) then
				if self:getBuffById(Fushun3GameConst.buff_data[2].id) then
					self:removeBuff(Clone(Fushun3GameConst.buff_data[2]))
				else
					self:addBuff(Clone(Fushun3GameConst.buff_data[2]))
				end
			elseif Input.GetKeyDown(KeyCode.I) then
				if self:getBuffById(Fushun3GameConst.buff_data[4].id) then
					self:removeBuff(Clone(Fushun3GameConst.buff_data[4]))
				else
					self:addBuff(Clone(Fushun3GameConst.buff_data[4]))
				end
			elseif Input.GetKeyDown(KeyCode.O) then
				self:addBuff(Clone(Fushun3GameConst.buff_data[5]))
			end

			return
		end, self)

		UpdateBeat:AddListener(self.handle, self)
	end

	return
end

function Fushun3CharController:start()
	self._animator:SetBool("la", false)
	self._animator:SetBool("s", false)
	self._animator:SetBool("below", self._collisionInfo.below)

	self._attackCd = Fushun3GameConst.attack_cd
	self._charTf.anchoredPosition = Fushun3GameConst.char_init_pos
	self.buffList = {}
	self._attackTime = 0
	self.power = 0
	self._powerTime = 0
	self.powerFlag = false
	self.shieldNum = 0

	self:updateBuffShow(Fushun3GameConst.buff_shield)

	self.heart = Fushun3GameConst.heart_num

	setActive(self._charItemCatchTf, false)

	return
end

function Fushun3CharController:step()
	if self._charTf.anchoredPosition.y >= 1200 or self._charTf.anchoredPosition.y <= -200 then
		if self._powerTime > 0 then
			self._charTf.anchoredPosition = Vector2(self._charTf.anchoredPosition.x + 100, 1000)
		else
			self._event:emit(Fushun3GameEvent.game_over_call)
		end

		return
	end

	self._powerSlider.value = self.power / Fushun3GameConst.power_max_num

	self._animator:SetBool("below", self._collisionInfo.below)

	local var_8_0 = self._collisionInfo:getVelocity()

	self._animator:SetFloat("moveAmountX", var_8_0.x)
	self._animator:SetFloat("moveAmountY", var_8_0.y)

	if self._attackCd > 0 then
		self._attackCd = self._attackCd - Time.deltaTime
		self._attackCd = self._attackCd < 0 and 0 or self._attackCd
	end

	if self._powerTime > 0 then
		self._powerTime = self._powerTime - Time.deltaTime

		if self._powerTime < 0 then
			self._powerTime = 0
		end
	end

	for iter_8_0 = #self.buffList, 1, -1 do
		if self.buffList[iter_8_0].time then
			self.buffList[iter_8_0].time = self.buffList[iter_8_0].time - Time.deltaTime

			if self.buffList[iter_8_0].time <= 0 then
				self:removeBuff(self.buffList[iter_8_0])
			end
		end
	end

	local var_8_1 = {}

	for iter_8_1, iter_8_2 in pairs(self._collisionInfo.horizontalLeftTfs) do
		table.insert(var_8_1, iter_8_2)
	end

	for iter_8_3, iter_8_4 in pairs(self._collisionInfo.horizontalRightTfs) do
		table.insert(var_8_1, iter_8_4)
	end

	local var_8_2 = {}

	for iter_8_5, iter_8_6 in pairs(self._collisionInfo.verticalBottomTfs) do
		table.insert(var_8_2, iter_8_6)
	end

	if #var_8_1 > 0 then
		if self:getBuff(Fushun3GameConst.buff_power_speed) then
			for iter_8_7 = 1, #var_8_1 do
				if go(var_8_1[iter_8_7]).layer == self._monsterLayer then
					self._event:emit(Fushun3GameEvent.power_damage_monster_call, {
						tf = var_8_1[iter_8_7]
					})
				end
			end
		else
			for iter_8_8 = 1, #var_8_1 do
				if self._powerTime == 0 and go(var_8_1[iter_8_8]).layer == self._monsterLayer and self.damageCd == 0 then
					self._event:emit(Fushun3GameEvent.check_player_damage, {
						tf = var_8_1[iter_8_8],
						callback = function(arg_9_0)
							if not arg_9_0 then
								self:damageChar()
							end

							return
						end
					})
				elseif findTF(var_8_1[iter_8_8], "high_roof") then
					setActive(findTF(var_8_1[iter_8_8], "high_roof"), false)
					self._collisionInfo:changeVelocity(0, self._collisionInfo.config.minJumpVelocity, nil)

					if self._powerTime == 0 and self.damageCd == 0 then
						self:damageChar()
					end
				end
			end
		end
	elseif var_8_2 and #var_8_2 > 0 then
		for iter_8_9 = 1, #var_8_2 do
			if go(var_8_2[iter_8_9]).layer == self._monsterLayer then
				if self:getBuff(Fushun3GameConst.buff_speed) then
					self._event:emit(Fushun3GameEvent.kick_damage_monster_call, {
						tf = var_8_2[iter_8_9],
						callback = function(arg_10_0)
							if arg_10_0 then
								self._collisionInfo:changeVelocity(nil, self._collisionInfo.config.minJumpVelocity, nil)
							end

							return
						end
					})
				else
					self._event:emit(Fushun3GameEvent.check_player_damage, {
						tf = var_8_1[iter_8_9],
						callback = function(arg_11_0)
							if not arg_11_0 then
								self:damageChar()
							end

							return
						end
					})
				end
			end
		end
	end

	self:flushBuff()

	if self.damageCd > 0 then
		self.damageCd = self.damageCd - Time.deltaTime
		self.damageCd = self.damageCd <= 0 and 0 or self.damageCd
	end

	if self._attackTime > 0 then
		self._event:emit(Fushun3GameEvent.player_attack_call, {
			collider = self._damageCollider,
			callback = function(arg_12_0)
				if arg_12_0 then
					self._event:emit(Fushun3GameEvent.add_effect_call, {
						effectName = "EF_fr_Attack",
						targetTf = self._effectPos
					})
				end

				return
			end
		})

		self._attackTime = self._attackTime - Time.deltaTime
		self._attackTime = self._attackTime <= 0 and 0 or self._attackTime
	end

	if self.power == Fushun3GameConst.power_max_num and not self.powerFlag and self._charTf.anchoredPosition.y >= 200 then
		self.powerFlag = true

		self._event:emit(Fushun3GameEvent.power_speed_call)

		if not self.powerBuff then
			for iter_8_10 = 1, #Fushun3GameConst.buff_data do
				if Fushun3GameConst.buff_data[iter_8_10].buff == Fushun3GameConst.buff_power_speed then
					self.powerBuff = Clone(Fushun3GameConst.buff_data[iter_8_10])
				end
			end
		end

		self:addBuff(Clone(self.powerBuff))
	end

	if self.powerFlag then
		self.power = self.power - Fushun3GameConst.power_sub_time * Time.deltaTime

		if self.power <= 0 then
			self.power = 0
			self.powerFlag = false

			self:removeBuff(Clone(self.powerBuff))
		end
	elseif self.power >= Fushun3GameConst.power_max_num then
		self.power = Fushun3GameConst.power_max_num
	end

	return
end

function Fushun3CharController:jump()
	if self._jumpScript:checkScirptApply() then
		self._jumpScript:active(true)
	end

	return
end

function Fushun3CharController:attack()
	if self._attackScript:checkScirptApply() then
		self._attackScript:active(true)
	end

	return
end

function Fushun3CharController:damageChar()
	if self._damageScript:checkScirptApply() then
		self._damageScript:active(true)

		if self.damageCd == 0 then
			if self.shieldNum > 0 then
				self.shieldNum = self.shieldNum - 1

				self._animator:SetTrigger("damage")
				self:updateBuffShow(Fushun3GameConst.buff_shield)
				self._event:emit(Fushun3GameEvent.add_effect_call, {
					effectName = "EF_Barrier_Break",
					targetTf = self._effectPos
				})
			else
				self.heart = self.heart - 1

				if self.heart <= 0 then
					self.heart = 0
				end

				if self.heart == 0 then
					self._animator:SetTrigger("down")
				elseif #self.buffList > 0 then
					self:removeBuff(self.buffList[math.random(1, #self.buffList)], true)
					self._animator:SetTrigger("respawn")
				else
					self._animator:SetTrigger("damage")
				end
			end

			self.damageCd = Fushun3GameConst.damage_cd

			if self._attackTime > 0 then
				self._attackTime = 0
			end

			self._event:emit(Fushun3GameEvent.char_damaged_call)
		end
	end

	return
end

function Fushun3CharController:addPower(arg_16_1)
	if not self.powerFlag then
		self.power = self.power + arg_16_1
	end

	return
end

function Fushun3CharController:getBuff(arg_17_1)
	for iter_17_0 = 1, #self.buffList do
		if self.buffList[iter_17_0].buff == arg_17_1 then
			return self.buffList[iter_17_0]
		end
	end

	return nil
end

function Fushun3CharController:getBuffById(arg_18_1)
	for iter_18_0 = 1, #self.buffList do
		if self.buffList[iter_18_0].id == arg_18_1 then
			return self.buffList[iter_18_0]
		end
	end

	return nil
end

function Fushun3CharController:setBuff(arg_19_1)
	local var_19_0

	for iter_19_0 = 1, #Fushun3GameConst.buff_data do
		if Fushun3GameConst.buff_data[iter_19_0].id == arg_19_1.buff_id then
			var_19_0 = Fushun3GameConst.buff_data[iter_19_0]
		end
	end

	if var_19_0 then
		self:addBuff(Clone(var_19_0))
	end

	return
end

function Fushun3CharController:addBuff(arg_20_1)
	for iter_20_0 = 1, #self.buffList do
		if self.buffList[iter_20_0].id == arg_20_1.id then
			if arg_20_1.buff == Fushun3GameConst.buff_shield then
				if self.shieldNum == var_0_1 then
					return
				end
			else
				return
			end
		end
	end

	local var_20_0 = self:getItemTriggerFlag()

	if arg_20_1.buff == Fushun3GameConst.buff_speed then
		self._animator:SetBool("s", true)

		self._collisionInfo.config.moveSpeed = Fushun3GameConst.move_speed_shoose

		if not var_20_0 then
			self._animator:SetTrigger("item")
		end
	elseif arg_20_1.buff == Fushun3GameConst.buff_power_speed then
		if self._powerScript:checkScirptApply() then
			self._powerScript:active(true)
			self._animator:SetTrigger("ex_on")
			self._charItemCatch:SetTrigger("ex_on")
		end
	elseif arg_20_1.buff == Fushun3GameConst.buff_weapon then
		self._animator:SetBool("la", true)

		if not var_20_0 then
			self._animator:SetTrigger("item")
		end
	elseif arg_20_1.buff == Fushun3GameConst.buff_catch then
		setActive(self._charItemCatchTf, true)
		self._charItemCatch:SetTrigger("ride")
	elseif arg_20_1.buff == Fushun3GameConst.buff_shield then
		self.shieldNum = self.shieldNum + 1

		if self.shieldNum > var_0_1 then
			self.shieldNum = var_0_1
		end

		self:updateBuffShow(Fushun3GameConst.buff_shield)
		self._event:emit(Fushun3GameEvent.add_effect_call, {
			effectName = "EF_Barrier_Get",
			targetTf = self._effectPos
		})
	end

	table.insert(self.buffList, arg_20_1)

	return
end

function Fushun3CharController:updateBuffShow(arg_21_1)
	if arg_21_1 == Fushun3GameConst.buff_shield then
		for iter_21_0 = 1, var_0_1 do
			local var_21_0 = iter_21_0

			setActive(findTF(self._charShieldTf, tostring(iter_21_0)), iter_21_0 <= self.shieldNum)
			setActive(findTF(self._effectFrPos, "Barrier/" .. tostring(var_21_0)), self.shieldNum == var_21_0)
			setActive(findTF(self._effectBkPos, "Barrier/" .. tostring(var_21_0)), self.shieldNum == var_21_0)
		end

		setActive(self._charShieldTf, false)
		setActive(self._charShieldTf, true)
	end

	return
end

function Fushun3CharController:removeBuff(arg_22_1, arg_22_2)
	for iter_22_0 = 1, #self.buffList do
		if self.buffList[iter_22_0].buff == arg_22_1.buff then
			local var_22_0 = self:getItemTriggerFlag()

			if self.buffList[iter_22_0].buff == Fushun3GameConst.buff_speed then
				self._animator:SetBool("s", false)

				self._collisionInfo.config.moveSpeed = Fushun3GameConst.move_speed

				if not var_22_0 and not arg_22_2 then
					self._animator:SetTrigger("item")
				end
			elseif self.buffList[iter_22_0].buff == Fushun3GameConst.buff_power_speed then
				self._powerScript:active(false)
				self._animator:SetTrigger("ex_off")
				self._charItemCatch:SetTrigger("ex_off")

				self._powerTime = Fushun3GameConst.power_time
			elseif self.buffList[iter_22_0].buff == Fushun3GameConst.buff_weapon then
				self._animator:SetBool("la", false)

				if not var_22_0 and not arg_22_2 then
					self._animator:SetTrigger("item")
				end
			elseif self.buffList[iter_22_0].buff == Fushun3GameConst.buff_catch then
				setActive(self._charItemCatchTf, false)
			end

			table.remove(self.buffList, iter_22_0)

			return
		end
	end

	return
end

function Fushun3CharController:flushBuff()
	for iter_23_0 = 1, #self.buffList do
		if self.buffList[iter_23_0].buff == Fushun3GameConst.buff_speed then
			-- block empty
		elseif self.buffList[iter_23_0].buff == Fushun3GameConst.buff_power_speed then
			-- block empty
		elseif self.buffList[iter_23_0].buff == Fushun3GameConst.buff_weapon then
			-- block empty
		elseif self.buffList[iter_23_0].buff == Fushun3GameConst.buff_catch then
			self._charTf.anchoredPosition.y = self._charTf.anchoredPosition.y + self._itemPos.anchoredPosition.y

			self._event:emit(Fushun3GameEvent.item_follow_call, {
				anchoredPos = self._charTf.anchoredPosition
			})
		end
	end

	return
end

function Fushun3CharController:getHeart()
	return self.heart
end

function Fushun3CharController:getItemTriggerFlag()
	for iter_25_0 = 1, #self.buffList do
		if self.buffList[iter_25_0].lock_item then
			return true
		end
	end

	return false
end

function Fushun3CharController:dispose()
	if Application.isEditor then
		UpdateBeat:RemoveListener(self.handle)

		self.handle = nil
	end

	return
end

return Fushun3CharController
