local var_0_0 = class("SailBoatBulletsControl")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1 = SailBoatGameVo
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._bullets = {}
	arg_1_0._bulletPool = {}
	arg_1_0._content = findTF(arg_1_0._tf, "scene_front/content")

	return
end

function var_0_0.start(arg_2_0)
	for iter_2_0 = #arg_2_0._bullets, 1, -1 do
		local var_2_0 = table.remove(arg_2_0._bullets, iter_2_0)

		var_2_0:clear()
		table.insert(arg_2_0._bulletPool, var_2_0)
	end

	arg_2_0._bulletStep = var_0_1.bullet_step

	return
end

function var_0_0.step(arg_3_0, arg_3_1)
	for iter_3_0 = #arg_3_0._bullets, 1, -1 do
		arg_3_0._bullets[iter_3_0]:step(arg_3_1)
	end

	arg_3_0._bulletStep = arg_3_0._bulletStep - 1

	if arg_3_0._bulletStep > 0 then
		return
	end

	arg_3_0._bulletStep = var_0_1.bullet_step

	local var_3_0 = var_0_1.GetGameEnemys()
	local var_3_1 = var_0_1.GetGameChar()
	local var_3_2 = var_3_1:getGroup()

	for iter_3_1 = #arg_3_0._bullets, 1, -1 do
		local var_3_4 = arg_3_0._bullets[iter_3_1]:getHitGroup()
		local var_3_5 = arg_3_0._bullets[iter_3_1]:getWorld()

		if not arg_3_0._bullets[iter_3_1]:getRemoveFlag() then
			for iter_3_2, iter_3_3 in ipairs(var_3_0) do
				if iter_3_3:getLife() then
					local var_3_6 = iter_3_3:getGroup()

					if iter_3_3:getLife() then
						local var_3_7, var_3_8 = iter_3_3:getMinMaxPosition()

						if var_0_1.PointInRect2(var_3_5, var_3_7, var_3_8) and table.contains(var_3_4, var_3_6) then
							arg_3_0._bullets[iter_3_1]:hit()

							if iter_3_3:damage((arg_3_0._bullets[iter_3_1]:getDamage())) then
								arg_3_0._event(SailBoatGameEvent.DESTROY_ENEMY, iter_3_3:getDestroyData())
							end

							return
						end
					end
				end
			end
		end

		if not arg_3_0._bullets[iter_3_1]:getRemoveFlag() and var_3_1:getLife() and table.contains(var_3_4, var_3_2) then
			local var_3_9, var_3_10 = var_3_1:getMinMaxPosition()

			if var_0_1.PointInRect2(var_3_5, var_3_9, var_3_10) then
				arg_3_0._bullets[iter_3_1]:hit()
				var_3_1:damage((arg_3_0._bullets[iter_3_1]:getDamage()))

				return
			end
		end

		if arg_3_0._bullets[iter_3_1]:getRemoveFlag() then
			local var_3_11 = table.remove(arg_3_0._bullets, iter_3_1)

			var_3_11:clear()
			arg_3_0:returnBullet(var_3_11)
		end
	end

	return
end

function var_0_0.returnBullet(arg_4_0, arg_4_1)
	table.insert(arg_4_0._bulletPool, arg_4_1)

	return
end

function var_0_0.createBullet(arg_5_0, arg_5_1)
	local var_5_0

	if #arg_5_0._bulletPool > 0 then
		var_5_0 = table.remove(arg_5_0._bulletPool, 1)
	end

	if not var_5_0 then
		var_5_0 = SailBoatBullet.New(var_0_1.GetGameBullet(), arg_5_0._event)

		var_5_0:setContent(arg_5_0._content)
	end

	var_5_0:setData(SailBoatGameConst.game_bullet[arg_5_1])
	table.insert(arg_5_0._bullets, var_5_0)

	return var_5_0
end

function var_0_0.onEventCall(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == SailBoatGameEvent.BOAT_EVENT_FIRE then
		local var_6_0 = arg_6_0:createBullet(arg_6_2.bullet_id)

		var_6_0:setFireData(arg_6_2.fire_data)
		var_6_0:setWeapon(arg_6_2.weapon_data)
		var_6_0:start()
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
