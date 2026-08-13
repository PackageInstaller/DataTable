class = var_0_10000

local var_0_0 = var_0_10000("SailBoatEnemyControllua")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	SailBoatGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._bgContent = arg_1_1
	arg_1_0._eventCall = arg_1_2
	findTF = var_1_10003
	arg_1_0._content = var_1_10003(arg_1_0._bgContent, "scene/content")
	arg_1_0._enemys = {}
	arg_1_0._enemyPool = {}
	arg_1_0._rules = {}

	return
end

function var_0_0.start(arg_2_0)
	for iter_2_0 = #arg_2_0._enemys, 1, -1 do
		var_1_10006 = arg_2_0

		local var_2_0 = arg_2_0.returnEnemy

		table = var_1_10007

		var_2_0(var_1_10006, var_1_10007.remove(arg_2_0._enemys, iter_2_0))
	end

	arg_2_0._rules = {}

	var_0_1.SetGameEnemys(arg_2_0._enemys)

	if var_0_1.GetRoundData() then
		for iter_2_1 = 1, #var_1.enemy_rule do
			SailBoatGameConst = var_1_10006

			if not var_1_10006.enemy_rule[var_1.enemy_rule[iter_2_1]] then
				print = var_7

				var_7("不存在 rule id " .. var_1.enemy_rule[iter_2_1])
			end

			local var_2_1 = 0

			table = var_1_10008

			var_1_10008.insert(arg_2_0._rules, {
				data = var_1_10006,
				time = var_2_1
			})
		end
	end

	arg_2_0._fireIndex = var_0_1.fire_step

	return
end

function var_0_0.step(arg_3_0, arg_3_1)
	arg_3_0._fireIndex = arg_3_0._fireIndex - 1

	if arg_3_0._fireIndex <= 0 then
		arg_3_0._fireIndex = var_0_1.fire_step

		local var_3_0 = var_0_1.GetGameChar()
		local var_3_1 = var_2.getPosition(var_3_0)
		local var_3_2 = var_0_1.GetGameEnemys()

		for iter_3_0 = 1, #var_3_2 do
			local var_3_3 = var_3_2[iter_3_0]

			if var_9.canFire(var_3_3) then
				arg_3_0:checkEnemyFire(var_2, var_9)
			end
		end
	end

	local var_3_4 = var_0_1.GetGameItems()

	for iter_3_1 = #arg_3_0._enemys, 1, -1 do
		local var_3_5 = arg_3_0._enemys[iter_3_1]

		var_7.step(var_3_5, arg_3_1)

		if var_7:getRemoveFlag() then
			table = var_8

			var_8.remove(arg_3_0._enemys, iter_3_1)
			arg_3_0:returnEnemy(var_7)
		elseif not var_7:getStop() then
			ipairs = var_8

			for iter_3_2, iter_3_3 in var_8(var_3_4) do
				if arg_3_0:checkEnemyCollider(var_7, iter_3_3) then
					local var_3_6 = var_7
					local var_3_7 = var_7.stopTarget

					Vector2 = var_15

					var_3_7(var_3_6, var_15(0, 0))

					if var_7:getConfig("boom") and var_7:damage({
						num = 99999
					}) then
						local var_3_8 = arg_3_0._eventCall

						SailBoatGameEvent = var_15

						var_3_8(var_15.DESTROY_ENEMY, var_7:getDestroyData())
					end
				end
			end
		end
	end

	local var_3_9 = var_0_1.gameTime

	for iter_3_4 = 1, #arg_3_0._rules do
		if var_3_9 > arg_3_0._rules[iter_3_4].data.create_time[1] and var_3_9 < var_9[2] and var_8.time and var_8.time >= 0 then
			var_8.time = var_8.time - arg_3_1

			if var_8.time <= 0 then
				math = var_10
				var_8.time = var_10.random(1, var_8.data.time[2] - var_8.data.time[1]) + var_8.data.time[1]

				arg_3_0:applyRule(var_8)
			end
		end
	end

	return
end

function var_0_0.checkEnemyFire(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:getPosition()

	if arg_4_1:getLife() and arg_4_2:getLife() and not arg_4_2:inFireCd() then
		local var_4_1 = arg_4_2:getPosition()
		local var_4_2, var_4_3 = arg_4_2:getWeapons()
		local var_4_4, var_4_5 = arg_4_2:getFirePos()
		local var_4_6, var_4_7 = arg_4_2:getFireContent()
		local var_4_8 = var_4_0.x > var_4_1.x and var_4_3 or var_4_2
		local var_4_9 = (var_4_0.x > var_4_1.x and var_4_5 or var_4_4).y

		math = var_1_10014
		var_12.y = var_4_9 + var_1_10014.random(-15, 15)

		local var_4_10 = var_4_0.x
		local var_4_11 = var_4_1.x < var_4_10 and var_4_7 or var_4_6

		math = var_14

		local var_4_12 = var_14.sqrt

		math = var_15

		local var_4_13 = var_15.pow(var_4_0.x - var_4_1.x, 2)

		math = var_16

		local var_4_14 = var_4_12(var_4_13 + var_16.pow(var_4_0.y - var_4_1.y, 2))
		local var_4_15 = arg_4_2

		if var_4_14 < arg_4_2.getWeaponMaxDistance(var_4_15) then
			math = var_4_15

			local var_4_16 = var_4_15.atan2
			local var_4_17 = var_4_0.y - var_4_1.y

			math = var_18

			local var_4_18 = var_4_17 + var_18.random(-50, 50)
			local var_4_19 = var_4_0.x - var_4_1.x

			math = var_19

			local var_4_20 = var_4_16(var_4_18, var_4_19 + var_19.random(-50, 50))

			math = var_4_18

			local var_4_21 = var_4_20 * var_4_18.rad2Deg

			for iter_4_0 = 1, #var_4_8 do
				local var_4_22 = var_4_8[iter_4_0]

				if var_22.getFireAble(var_4_22) then
					local var_4_23 = var_22
					local var_4_24 = var_22.getAngel(var_4_23)

					math = var_4_23

					if not (var_4_23.abs(var_4_21) < var_4_24) then
						math = var_24

						local var_4_25 = var_24.abs

						math = var_25

						if var_4_24 > var_4_25(180 - var_25.abs(var_4_21)) then
							if var_22:fire() then
								local var_4_26 = arg_4_2

								arg_4_2.fire(var_4_26)

								local var_4_27 = {
									pos = var_12
								}

								Vector2 = var_4_26
								math = var_1_10027
								var_1_10027 = var_1_10027.cos(var_4_20)
								math = var_28
								var_4_27.move = var_4_26(var_1_10027, var_28.sin(var_4_20))
								var_1_10027 = arg_4_2
								var_4_27.hit = arg_4_2.getHitGroup(var_1_10027)
								Vector2 = var_26
								var_4_27.effect_pos = var_26(0, 0)
								var_4_27.effect_content = var_4_11

								local var_4_28 = arg_4_0._eventCall

								SailBoatGameEvent = var_1_10027

								var_4_28(var_1_10027.BOAT_EVENT_FIRE, {
									bullet_id = var_24.bullet_id,
									weapon_data = var_24,
									fire_data = var_4_27
								})

								return
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_0.returnEnemy(arg_5_0, arg_5_1)
	arg_5_1:clear()

	table = var_2

	var_2.insert(arg_5_0._enemyPool, arg_5_1)

	return
end

function var_0_0.checkEnemyCollider(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2
	local var_6_1 = arg_6_2.getConfig(var_6_0, "type")

	SailBoatGameConst = var_6_0

	if var_6_1 == var_6_0.item_static then
		local var_6_2 = arg_6_2:getPosition()
		local var_6_3 = arg_6_1
		local var_6_4 = arg_6_1.getPosition(var_6_3)

		math = var_6_3

		if var_6_3.abs(var_6_2.x - var_6_4.x) < 500 then
			math = var_5

			if var_5.abs(var_6_2.y - var_6_4.y) < 500 then
				local var_6_5, var_6_6 = arg_6_2:getWorldColliderData()
				local var_6_7, var_6_8 = arg_6_1:getWorldColliderData()

				if var_0_1.CheckRectCollider(var_6_7, var_6_5, var_6_8, var_6_6) then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.applyRule(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.data.enemys
	local var_7_1 = var_2.screen_pos_x
	local var_7_2 = var_2.screen_pos_y

	if not var_7_1 or not var_7_2 then
		print = var_1_10006

		var_1_10006("rule id = " .. var_2 .. " 异常，没有范围参数")
	end

	math = var_1_10006

	local var_7_3 = var_7_0[var_1_10006.random(1, #var_7_0)]

	if not var_0_1.GetRangePos(var_7_1, var_7_2) then
		return
	end

	local var_7_4 = arg_7_0:getOrCreateEnemy(var_7_3)

	var_8.setPosition(var_7_4, var_7)

	table = var_9

	var_9.insert(arg_7_0._enemys, var_8)

	local var_7_5 = arg_7_1.data.target_x
	local var_7_6 = arg_7_1.data.target_y
	local var_7_7 = arg_7_1.data.target_speed

	var_8:setTarget(var_7_5, var_7_6, var_7_7)
	var_8:start()

	return
end

function var_0_0.getOrCreateEnemy(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0
	local var_8_1 = #arg_8_0._enemyPool

	if 0 < var_8_1 then
		for iter_8_0 = #arg_8_0._enemyPool, 1, -1 do
			if not var_8_0 then
				local var_8_2 = arg_8_0._enemyPool[iter_8_0]

				if var_8.getId(var_8_2) == arg_8_1 then
					table = var_9
					var_8_0 = var_9.remove(arg_8_0._enemyPool, iter_8_0)

					break
				end
			end
		end
	end

	if not var_8_0 then
		SailBoatGameConst = var_8_1

		if not var_8_1.game_enemy[arg_8_1] then
			print = var_4

			var_4("id = " .. arg_8_1 .. " 的敌人不存在")
		end

		Clone = var_4
		SailBoatGameConst = var_5

		local var_8_3 = var_4(var_5.game_enemy[arg_8_1])
		local var_8_4 = var_0_1.GetGameEnemyTf(var_8_3.tpl)

		SailBoatEnemy = var_6

		local var_8_5 = var_6.New(var_8_4, arg_8_0._event)

		var_8_0.setData(var_8_5, var_8_3)
		arg_8_0:initWeapon(var_8_0, var_8_3.weapons)
		var_8_0:setContent(arg_8_0._content)
	end

	return var_8_0
end

function var_0_0.initWeapon(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}
	local var_9_1 = {}

	for iter_9_0 = 1, #arg_9_2[1] do
		local var_9_2 = arg_9_2[1][iter_9_0]

		SailBoatGameConst = var_1_10010
		var_1_10010 = var_1_10010.game_weapon[var_9_2]
		SailBoatWeapon = var_1_10011
		var_1_10011 = var_1_10011.New(var_1_10010)
		table = var_12

		var_12.insert(var_9_0, var_1_10011)
	end

	for iter_9_1 = 1, #arg_9_2[2] do
		local var_9_3 = arg_9_2[2][iter_9_1]

		SailBoatGameConst = var_1_10010
		var_1_10010 = var_1_10010.game_weapon[var_9_3]
		SailBoatWeapon = var_1_10011
		var_1_10011 = var_1_10011.New(var_1_10010)
		table = var_12

		var_12.insert(var_9_1, var_1_10011)
	end

	arg_9_1:setWeapon(var_9_0, var_9_1)

	return
end

function var_0_0.clear(arg_10_0)
	return
end

function var_0_0.stop(arg_11_0)
	return
end

function var_0_0.dispose(arg_12_0)
	return
end

return var_0_0
