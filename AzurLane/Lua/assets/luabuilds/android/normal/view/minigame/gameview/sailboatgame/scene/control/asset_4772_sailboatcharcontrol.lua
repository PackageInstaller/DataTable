class = var_0_10000

local var_0_0 = var_0_10000("SailBoatCharControl")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	SailBoatGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._bgContent = arg_1_1
	arg_1_0._eventCall = arg_1_2
	findTF = var_1_10003
	arg_1_0._charContent = var_1_10003(arg_1_0._bgContent, "scene/content")
	SailBoatGameConst = var_3

	local var_1_0 = var_3.game_char[var_0_1.char_id]
	local var_1_1 = var_0_1.GetGameCharTf(var_1_0.tpl)

	SailBoatChar = var_5
	arg_1_0._char = var_5.New(var_1_1, arg_1_0._eventCall)

	local var_1_2 = arg_1_0._char

	var_5.setData(var_1_2, var_1_0)

	local var_1_3 = arg_1_0._char

	var_5.setContent(var_1_3, arg_1_0._charContent, var_0_1.char_start_pos)

	return
end

function var_0_0.start(arg_2_0)
	var_0_1.SetGameChar(arg_2_0._char)

	arg_2_0._fireIndex = var_0_1.fire_step

	local var_2_0 = {}
	local var_2_1 = {}
	local var_2_2 = arg_2_0._char

	var_3.clearEquipData(var_2_2)

	for iter_2_0 = 1, #var_0_1.equips do
		if var_0_1.equips[iter_2_0] and var_0_1.equips[iter_2_0] > 0 then
			SailBoatGameConst = var_7

			local var_2_3 = var_7.equip_data[var_0_1.equips[iter_2_0]]

			var_1_10009 = arg_2_0._char

			var_8.setEquipData(var_1_10009, var_2_3)

			if var_2_3.weapon_id and var_2_3.weapon_id ~= 0 then
				SailBoatGameConst = var_8

				local var_2_4 = var_8.game_weapon[var_2_3.weapon_id]

				SailBoatWeapon = var_1_10009
				var_1_10009 = var_1_10009.New(var_2_4)
				SailBoatWeapon = var_1_10010
				var_1_10010 = var_1_10010.New(var_2_4)
				table = var_1_10011

				var_1_10011.insert(var_2_0, var_1_10009)

				table = var_1_10011

				var_1_10011.insert(var_2_1, var_1_10010)
			end
		end
	end

	local var_2_5 = var_0_1.char_weapons

	for iter_2_1 = 1, #var_2_5[1] do
		local var_2_6 = var_2_5[1][iter_2_1]

		SailBoatGameConst = var_1_10009
		var_1_10009 = var_1_10009.game_weapon[var_2_6]
		SailBoatWeapon = var_1_10010
		var_1_10010 = var_1_10010.New
		Clone = var_1_10011
		var_1_10010 = var_1_10010(var_1_10011(var_1_10009))
		table = var_1_10011

		var_1_10011.insert(var_2_0, var_1_10010)
	end

	for iter_2_2 = 1, #var_2_5[2] do
		local var_2_7 = var_2_5[2][iter_2_2]

		SailBoatGameConst = var_1_10009
		var_1_10009 = var_1_10009.game_weapon[var_2_7]
		SailBoatWeapon = var_1_10010
		var_1_10010 = var_1_10010.New
		Clone = var_1_10011
		var_1_10010 = var_1_10010(var_1_10011(var_1_10009))
		table = var_1_10011

		var_1_10011.insert(var_2_1, var_1_10010)
	end

	local var_2_8 = arg_2_0._char

	var_4.setWeapon(var_2_8, var_2_0, var_2_1)

	local var_2_9 = arg_2_0._char

	var_4.start(var_2_9)

	arg_2_0._ableFire = true

	return
end

function var_0_0.step(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1.joyStickData
	local var_3_1 = 0
	local var_3_2 = 0
	local var_3_3 = 0
	local var_3_4 = 0

	if var_3_0 and var_3_0.active then
		var_3_1, var_3_2 = var_3_0.x, var_3_0.y

		local var_3_5 = var_3_0.directX

		var_3_4 = var_3_0.directY
		var_3_3 = var_3_5
		math = var_3_5

		if var_3_5.abs(var_3_3) < 0.1 then
			var_3_3 = 0
		end

		math = var_7

		if var_7.abs(var_3_4) < 0.1 then
			var_3_4 = 0
		end
	end

	if arg_3_0:getCharNextTouchFlag(var_3_1, var_3_2, var_3_3, var_3_4) then
		var_3_1, var_3_2 = 0, 0
	end

	local var_3_6 = arg_3_0._char

	var_8.changeDirect(var_3_6, var_3_1, var_3_2)

	local var_3_7 = arg_3_0._char

	var_8.step(var_3_7, arg_3_1)

	arg_3_0._fireIndex = arg_3_0._fireIndex - 1

	if arg_3_0._fireIndex <= 0 then
		arg_3_0._fireIndex = var_0_1.fire_step
	end

	if arg_3_0._ableFire then
		local var_3_8 = arg_3_0._char
		local var_3_9 = var_8.getPosition(var_3_8)
		local var_3_10 = var_0_1.GetGameEnemys()

		for iter_3_0 = 1, #var_3_10 do
			local var_3_11 = var_3_10[iter_3_0]

			arg_3_0:checkCharEnemyFire(arg_3_0._char, var_3_11)
		end
	end

	return
end

function var_0_0.checkCharEnemyFire(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:getPosition()
	local var_4_1 = arg_4_1:getWeaponMaxDistance()
	local var_4_2 = arg_4_2:getPosition().x > var_4_0.x and 1 or -1

	if arg_4_1:getLife() and arg_4_2:getLife() and not arg_4_1:inFireCd(var_4_2) then
		local var_4_3 = arg_4_0._char
		local var_4_4, var_4_5 = var_7.getWeapons(var_4_3)
		local var_4_6 = arg_4_0._char
		local var_4_7, var_4_8 = var_9.getFirePos(var_4_6)
		local var_4_9 = arg_4_0._char
		local var_4_10, var_4_11 = var_11.getFireContent(var_4_9)
		local var_4_12 = var_5.x > var_4_0.x and var_4_5 or var_4_4
		local var_4_13 = (var_5.x > var_4_0.x and var_4_8 or var_4_7).y

		math = var_1_10016
		var_14.y = var_4_13 + var_1_10016.random(-10, 10)

		local var_4_14 = var_5.x
		local var_4_15 = var_4_0.x < var_4_14 and var_4_11 or var_4_10

		math = var_16

		local var_4_16 = var_16.sqrt

		math = var_17

		local var_4_17 = var_17.pow(var_5.x - var_4_0.x, 2)

		math = var_18

		local var_4_18 = var_4_16(var_4_17 + var_18.pow(var_5.y - var_4_0.y, 2))
		local var_4_19 = arg_4_0._char

		if var_4_18 < var_17.getWeaponMaxDistance(var_4_19) then
			math = var_4_19

			local var_4_20 = var_4_19.atan2
			local var_4_21 = var_5.y - var_4_0.y

			math = var_20

			local var_4_22 = var_4_21 + var_20.random(-20, 20)
			local var_4_23 = var_5.x - var_4_0.x

			math = var_21

			local var_4_24 = var_4_20(var_4_22, var_4_23 + var_21.random(-20, 20))

			math = var_4_22

			local var_4_25 = var_4_24 * var_4_22.rad2Deg

			for iter_4_0 = 1, #var_4_12 do
				local var_4_26 = var_4_12[iter_4_0]

				if var_24.getFireAble(var_4_26) then
					local var_4_27 = var_24:getAngel()
					local var_4_28 = false

					math = var_1_10027

					if var_1_10027.abs(var_4_25) < var_4_27 and var_4_2 == 1 then
						var_4_28 = true
					else
						math = var_1_10027
						var_1_10027 = var_1_10027.abs
						math = var_28

						if var_1_10027(180 - var_28.abs(var_4_25)) < var_4_27 and var_4_2 == -1 then
							var_4_28 = true
						end
					end

					if var_4_28 and var_24:fire() then
						arg_4_1:fire(var_4_2)

						pg = var_28

						local var_4_29 = var_28.CriMgr.GetInstance()

						var_28.PlaySoundEffect_V3(var_4_29, var_0_1.SFX_SOUND_FIRE)

						local var_4_30 = {
							pos = var_14
						}

						Vector2 = var_4_29
						math = var_30

						local var_4_31 = var_30.cos(var_4_24)

						math = var_31
						var_4_30.move = var_4_29(var_4_31, var_31.sin(var_4_24))

						local var_4_32 = arg_4_0._char

						var_4_30.hit = var_29.getHitGroup(var_4_32)
						Vector2 = var_29
						var_4_30.effect_pos = var_29(0, 0)
						var_4_30.effect_content = var_4_15

						local var_4_33 = arg_4_0._eventCall

						SailBoatGameEvent = var_30

						var_4_33(var_30.BOAT_EVENT_FIRE, {
							bullet_id = var_1_10027.bullet_id,
							weapon_data = var_1_10027,
							fire_data = var_4_30
						})

						return
					end
				end
			end
		end
	elseif not arg_4_1:inFireCd(var_4_2) then
		-- block empty
	end

	return
end

function var_0_0.getCharNextTouchFlag(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_0._char
	local var_5_1 = var_5.getNextPosition(var_5_0, arg_5_1, arg_5_2)
	local var_5_2 = arg_5_0._char
	local var_5_3 = var_6.getBoundData(var_5_2)
	local var_5_4 = arg_5_0._char
	local var_5_5 = var_7.getColliderMinPosition(var_5_4)

	Vector2 = var_5_4

	local var_5_6 = var_5_4(0, 0)

	var_5_6.x = var_5_1.x + var_5_5.x
	var_5_6.y = var_5_1.y + var_5_5.y

	local var_5_7 = var_0_1.GetGameItems()

	for iter_5_0 = 1, #var_5_7 do
		local var_5_8 = var_5_7[iter_5_0]
		local var_5_9 = var_14.getConfig(var_5_8, "type")

		SailBoatGameConst = var_5_8

		if var_5_9 == var_5_8.item_static then
			local var_5_10 = var_14
			local var_5_11 = var_14.getPosition(var_5_10)

			math = var_5_10

			if var_5_10.abs(var_5_11.x - var_5_1.x) < 500 then
				math = var_16

				if var_16.abs(var_5_11.y - var_5_1.y) < 500 then
					local var_5_12, var_5_13 = var_14:getColliderData()

					if not arg_5_0:checkLeave(arg_5_3, arg_5_4, var_5_1, var_5_11) and var_0_1.CheckRectCollider(var_5_6, var_5_12, var_5_3, var_5_13) then
						return true
					end
				end
			end
		end
	end

	return false
end

function var_0_0.checkLeave(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0
	local var_6_1
	local var_6_2 = false
	local var_6_3
	local var_6_4

	if arg_6_1 ~= 0 then
		var_6_3 = arg_6_3.x > arg_6_4.x and arg_6_1 == 1 and true or arg_6_3.x <= arg_6_4.x and arg_6_1 == -1 and true or false
	end

	if arg_6_2 ~= 0 then
		var_6_4 = arg_6_3.y > arg_6_4.y and arg_6_2 == 1 and true or arg_6_3.y <= arg_6_4.y and arg_6_2 == -1 and true or false
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

function var_0_0.ableFire(arg_7_0)
	return
end

function var_0_0.clear(arg_8_0)
	return
end

function var_0_0.stop(arg_9_0)
	return
end

function var_0_0.dispose(arg_10_0)
	return
end

function var_0_0.useSkill(arg_11_0)
	local var_11_0 = arg_11_0._char

	var_1.useSkill(var_11_0)

	return
end

function var_0_0.onEventCall(arg_12_0, arg_12_1, arg_12_2)
	SailBoatGameEvent = var_1_10003

	if arg_12_1 == var_1_10003.PLAYER_EVENT_DAMAGE then
		local var_12_0 = arg_12_0._char

		var_3.damage(var_12_0, arg_12_2)
	else
		SailBoatGameEvent = var_3

		if arg_12_1 == var_3.USE_ITEM then
			local var_12_1 = arg_12_2.hp
			local var_12_2 = arg_12_0._char

			var_4.addHp(var_12_2, var_12_1)
		end
	end

	return
end

return var_0_0
