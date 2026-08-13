class = var_0_10000

local var_0_0 = var_0_10000("SailBoatBulletsControl")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	SailBoatGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._bullets = {}
	arg_1_0._bulletPool = {}
	findTF = var_3
	arg_1_0._content = var_3(arg_1_0._tf, "scene_front/content")

	return
end

function var_0_0.start(arg_2_0)
	for iter_2_0 = #arg_2_0._bullets, 1, -1 do
		table = var_1_10005

		local var_2_0 = var_1_10005.remove(arg_2_0._bullets, iter_2_0)

		var_1_10005.clear(var_2_0)

		table = var_6

		var_6.insert(arg_2_0._bulletPool, var_1_10005)
	end

	arg_2_0._bulletStep = var_0_1.bullet_step

	return
end

function var_0_0.step(arg_3_0, arg_3_1)
	for iter_3_0 = #arg_3_0._bullets, 1, -1 do
		local var_3_0 = arg_3_0._bullets[iter_3_0]

		var_6.step(var_3_0, arg_3_1)
	end

	arg_3_0._bulletStep = arg_3_0._bulletStep - 1

	if arg_3_0._bulletStep > 0 then
		return
	end

	arg_3_0._bulletStep = var_0_1.bullet_step

	local var_3_1 = var_0_1.GetGameEnemys()
	local var_3_2 = var_0_1.GetGameChar()
	local var_3_3 = var_3.getGroup(var_3_2)
	local var_3_4 = 0

	for iter_3_1 = #arg_3_0._bullets, 1, -1 do
		local var_3_5 = arg_3_0._bullets[iter_3_1]
		local var_3_6 = var_10.getHitGroup(var_3_5)
		local var_3_7 = var_10:getWorld()

		if not var_10:getRemoveFlag() then
			ipairs = var_13

			for iter_3_2, iter_3_3 in var_13(var_3_1) do
				if iter_3_3:getLife() then
					local var_3_8 = iter_3_3:getGroup()

					if iter_3_3:getLife() then
						local var_3_9, var_3_10 = iter_3_3:getMinMaxPosition()

						if var_0_1.PointInRect2(var_3_7, var_3_9, var_3_10) then
							table = var_22

							if var_22.contains(var_3_6, var_3_8) then
								var_10:hit()

								local var_3_11 = var_10:getDamage()

								if iter_3_3:damage(var_3_11) then
									local var_3_12 = arg_3_0._event

									SailBoatGameEvent = var_25

									var_3_12(var_25.DESTROY_ENEMY, iter_3_3:getDestroyData())
								end

								return
							end
						end
					end
				end
			end
		end

		if not var_10:getRemoveFlag() and var_3:getLife() then
			table = var_13

			if var_13.contains(var_3_6, var_3_3) then
				local var_3_13, var_3_14 = var_3:getMinMaxPosition()

				if var_0_1.PointInRect2(var_3_7, var_3_13, var_3_14) then
					var_10:hit()

					local var_3_15 = var_10:getDamage()

					var_3:damage(var_3_15)

					return
				end
			end
		end

		if var_10:getRemoveFlag() then
			table = var_13

			local var_3_16 = var_13.remove(arg_3_0._bullets, iter_3_1)

			var_13.clear(var_3_16)
			arg_3_0:returnBullet(var_13)
		end
	end

	return
end

function var_0_0.returnBullet(arg_4_0, arg_4_1)
	table = var_1_10002

	var_1_10002.insert(arg_4_0._bulletPool, arg_4_1)

	return
end

function var_0_0.createBullet(arg_5_0, arg_5_1)
	local var_5_0
	local var_5_1 = #arg_5_0._bulletPool

	if 0 < var_5_1 then
		table = var_5_1
		var_5_0 = var_5_1.remove(arg_5_0._bulletPool, 1)
	end

	if not var_5_0 then
		var_5_1 = var_0_1.GetGameBullet()
		SailBoatBullet = var_4

		local var_5_2 = var_4.New(var_5_1, arg_5_0._event)

		var_5_0.setContent(var_5_2, arg_5_0._content)
	end

	SailBoatGameConst = var_5_1

	local var_5_3 = var_5_1.game_bullet[arg_5_1]

	var_5_0:setData(var_5_3)

	table = var_4

	var_4.insert(arg_5_0._bullets, var_5_0)

	return var_5_0
end

function var_0_0.onEventCall(arg_6_0, arg_6_1, arg_6_2)
	SailBoatGameEvent = var_1_10003

	if arg_6_1 == var_1_10003.BOAT_EVENT_FIRE then
		local var_6_0 = arg_6_0:createBullet(arg_6_2.bullet_id)

		var_3.setFireData(var_6_0, arg_6_2.fire_data)
		var_3:setWeapon(arg_6_2.weapon_data)
		var_3:start()
	end

	return
end

function var_0_0.dispose(arg_7_0)
	return
end

function var_0_0.clear(arg_8_0)
	return
end

return var_0_0
