local SailBoatCharControl = class("SailBoatCharControl")
local var_0_1

function SailBoatCharControl:Ctor(arg_1_1, arg_1_2)
	var_0_1 = SailBoatGameVo
	self._bgContent = arg_1_1
	self._eventCall = arg_1_2
	self._charContent = findTF(self._bgContent, "scene/content")
	self._char = SailBoatChar.New(var_0_1.GetGameCharTf(SailBoatGameConst.game_char[var_0_1.char_id].tpl), self._eventCall)

	self._char:setData(SailBoatGameConst.game_char[var_0_1.char_id])
	self._char:setContent(self._charContent, var_0_1.char_start_pos)

	return
end

function SailBoatCharControl:start()
	var_0_1.SetGameChar(self._char)

	self._fireIndex = var_0_1.fire_step

	local var_2_0 = {}
	local var_2_1 = {}

	self._char:clearEquipData()

	for iter_2_0 = 1, #var_0_1.equips do
		if var_0_1.equips[iter_2_0] and var_0_1.equips[iter_2_0] > 0 then
			self._char:setEquipData(SailBoatGameConst.equip_data[var_0_1.equips[iter_2_0]])

			if SailBoatGameConst.equip_data[var_0_1.equips[iter_2_0]].weapon_id and SailBoatGameConst.equip_data[var_0_1.equips[iter_2_0]].weapon_id ~= 0 then
				local var_2_2 = SailBoatWeapon.New(SailBoatGameConst.game_weapon[SailBoatGameConst.equip_data[var_0_1.equips[iter_2_0]].weapon_id])

				table.insert(var_2_0, (SailBoatWeapon.New(SailBoatGameConst.game_weapon[SailBoatGameConst.equip_data[var_0_1.equips[iter_2_0]].weapon_id])))
				table.insert(var_2_1, var_2_2)
			end
		end
	end

	for iter_2_1 = 1, #var_0_1.char_weapons[1] do
		table.insert(var_2_0, (SailBoatWeapon.New(Clone(SailBoatGameConst.game_weapon[var_0_1.char_weapons[1][iter_2_1]]))))
	end

	for iter_2_2 = 1, #var_0_1.char_weapons[2] do
		table.insert(var_2_1, (SailBoatWeapon.New(Clone(SailBoatGameConst.game_weapon[var_0_1.char_weapons[2][iter_2_2]]))))
	end

	self._char:setWeapon(var_2_0, var_2_1)
	self._char:start()

	self._ableFire = true

	return
end

function SailBoatCharControl:step(arg_3_1)
	local var_3_0 = 0
	local var_3_1 = 0
	local var_3_2 = 0
	local var_3_3 = 0

	if var_0_1.joyStickData and var_0_1.joyStickData.active then
		var_3_1 = var_0_1.joyStickData.y
		var_3_0 = var_0_1.joyStickData.x
		var_3_3 = var_0_1.joyStickData.directY
		var_3_2 = var_0_1.joyStickData.directX

		if math.abs(var_0_1.joyStickData.directX) < 0.1 then
			var_3_2 = 0
		end

		if math.abs(var_3_3) < 0.1 then
			var_3_3 = 0
		end
	end

	if self:getCharNextTouchFlag(var_3_0, var_3_1, var_3_2, var_3_3) then
		var_3_1 = 0
		var_3_0 = 0
	end

	self._char:changeDirect(var_3_0, var_3_1)
	self._char:step(arg_3_1)

	self._fireIndex = self._fireIndex - 1

	if self._fireIndex <= 0 then
		self._fireIndex = var_0_1.fire_step
	end

	if self._ableFire then
		local var_3_4 = self._char:getPosition()
		local var_3_5 = var_0_1.GetGameEnemys()

		for iter_3_0 = 1, #var_3_5 do
			self:checkCharEnemyFire(self._char, var_3_5[iter_3_0])
		end
	end

	return
end

function SailBoatCharControl:checkCharEnemyFire(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:getPosition()
	local var_4_1 = arg_4_1:getWeaponMaxDistance()
	local var_4_2 = arg_4_2:getPosition()
	local var_4_3 = var_4_2.x > var_4_0.x and 1 or -1

	if arg_4_1:getLife() and arg_4_2:getLife() and not arg_4_1:inFireCd(var_4_3) then
		local var_4_4, var_4_5 = self._char:getWeapons()
		local var_4_6, var_4_7 = self._char:getFirePos()
		local var_4_8, var_4_9 = self._char:getFireContent()
		local var_4_10 = var_4_2.x > var_4_0.x and var_4_5 or var_4_4
		local var_4_11 = var_4_2.x > var_4_0.x and var_4_7 or var_4_6

		var_4_11.y = (var_4_2.x > var_4_0.x and var_4_7 or var_4_6).y + math.random(-10, 10)

		local var_4_12 = var_4_2.x > var_4_0.x and var_4_9 or var_4_8

		if math.sqrt(math.pow(var_4_2.x - var_4_0.x, 2) + math.pow(var_4_2.y - var_4_0.y, 2)) < self._char:getWeaponMaxDistance() then
			local var_4_13 = math.atan2(var_4_2.y - var_4_0.y + math.random(-20, 20), var_4_2.x - var_4_0.x + math.random(-20, 20))

			for iter_4_0 = 1, #var_4_10 do
				local var_4_14 = var_4_10[iter_4_0]

				if var_4_10[iter_4_0]:getFireAble() then
					local var_4_15 = var_4_14:getAngel()
					local var_4_16 = false

					if var_4_15 > math.abs(var_4_13 * math.rad2Deg) and var_4_3 == 1 then
						var_4_16 = true
					elseif var_4_15 > math.abs(180 - math.abs(var_4_13 * math.rad2Deg)) and var_4_3 == -1 then
						var_4_16 = true
					end

					if var_4_16 then
						local var_4_17 = var_4_14:fire()

						if var_4_17 then
							arg_4_1:fire(var_4_3)
							pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1.SFX_SOUND_FIRE)
							self._eventCall(SailBoatGameEvent.BOAT_EVENT_FIRE, {
								bullet_id = var_4_17.bullet_id,
								weapon_data = var_4_17,
								fire_data = {
									pos = var_4_11,
									move = Vector2(math.cos(var_4_13), math.sin(var_4_13)),
									hit = self._char:getHitGroup(),
									effect_pos = Vector2(0, 0),
									effect_content = var_4_12
								}
							})

							return
						end
					end
				end
			end
		end
	elseif not arg_4_1:inFireCd(var_4_3) then
		-- block empty
	end

	return
end

function SailBoatCharControl:getCharNextTouchFlag(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = self._char:getNextPosition(arg_5_1, arg_5_2)
	local var_5_1 = self._char:getBoundData()
	local var_5_2 = self._char:getColliderMinPosition()
	local var_5_3 = Vector2(0, 0)

	var_5_3.x = var_5_0.x + var_5_2.x
	var_5_3.y = var_5_0.y + var_5_2.y

	local var_5_4 = var_0_1.GetGameItems()

	for iter_5_0 = 1, #var_5_4 do
		if var_5_4[iter_5_0]:getConfig("type") == SailBoatGameConst.item_static then
			local var_5_5 = var_5_4[iter_5_0]:getPosition()

			if math.abs(var_5_5.x - var_5_0.x) < 500 and math.abs(var_5_5.y - var_5_0.y) < 500 then
				local var_5_6, var_5_7 = var_5_4[iter_5_0]:getColliderData()

				if not self:checkLeave(arg_5_3, arg_5_4, var_5_0, var_5_5) and var_0_1.CheckRectCollider(var_5_3, var_5_6, var_5_1, var_5_7) then
					return true
				end
			end
		end
	end

	return false
end

function SailBoatCharControl:checkLeave(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_2 = false
	local var_6_3
	local var_6_4

	if arg_6_1 ~= 0 then
		var_6_3 = arg_6_3.x > arg_6_4.x and arg_6_1 == 1 and true or arg_6_3.x <= arg_6_4.x and arg_6_1 == -1
	end

	if arg_6_2 ~= 0 then
		var_6_4 = arg_6_3.y > arg_6_4.y and arg_6_2 == 1 and true or arg_6_3.y <= arg_6_4.y and arg_6_2 == -1
	end

	if arg_6_1 ~= 0 and arg_6_2 ~= 0 then
		-- block empty
	elseif arg_6_1 ~= 0 and arg_6_2 == 0 then
		var_6_2 = var_6_3
	elseif arg_6_1 == 0 and arg_6_2 ~= 0 then
		var_6_2 = var_6_4
	end

	return var_6_2
end

function SailBoatCharControl:ableFire()
	return
end

function SailBoatCharControl:clear()
	return
end

function SailBoatCharControl:stop()
	return
end

function SailBoatCharControl:dispose()
	return
end

function SailBoatCharControl:useSkill()
	self._char:useSkill()

	return
end

function SailBoatCharControl:onEventCall(arg_12_1, arg_12_2)
	if arg_12_1 == SailBoatGameEvent.PLAYER_EVENT_DAMAGE then
		self._char:damage(arg_12_2)
	elseif arg_12_1 == SailBoatGameEvent.USE_ITEM then
		self._char:addHp(arg_12_2.hp)
	end

	return
end

return SailBoatCharControl
