class = var_0_10000

local var_0_0 = var_0_10000("SailBoatColliderControl")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	SailBoatGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._tf = arg_1_1
	arg_1_0._eventCall = arg_1_2

	return
end

function var_0_0.start(arg_2_0)
	arg_2_0._itemMoveSpeed = var_0_1.item_move_speed

	return
end

function var_0_0.step(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1.GetGameChar()
	local var_3_1 = var_0_1.GetGameItems()
	local var_3_2 = var_0_1.GetGameEnemys()
	local var_3_3, var_3_4 = var_3_0:getWorldColliderData()
	local var_3_5 = var_3_0:getPosition()
	local var_3_6 = false

	for iter_3_0 = 1, #var_3_1 do
		local var_3_7 = var_3_1[iter_3_0]
		local var_3_8, var_3_9 = var_13.getWorldColliderData(var_3_7)

		if var_0_1.CheckRectCollider(var_3_3, var_3_8, var_3_4, var_3_9) then
			local var_3_10 = var_13:getConfig("type")

			SailBoatGameConst = var_1_10017

			if var_3_10 == var_1_10017.item_static then
				local var_3_11 = var_13:getSpeed()

				var_3_0:move(var_3_11.x, var_3_11.y)
			else
				local var_3_12 = var_13
				local var_3_13 = var_13.getConfig(var_3_12, "type")

				SailBoatGameConst = var_1_10017

				if var_3_13 == var_1_10017.item_used then
					local var_3_14 = arg_3_0._eventCall

					SailBoatGameEvent = var_3_12

					var_3_14(var_3_12.USE_ITEM, var_13:getUseData())
					var_13:setRemoveFlag(true)

					pg = var_16

					local var_3_15 = var_16.CriMgr.GetInstance()

					var_16.PlaySoundEffect_V3(var_3_15, var_0_1.SFX_SOUND_ITEM)
				end
			end
		end
	end

	for iter_3_1 = 1, #var_3_2 do
		local var_3_16 = var_3_2[iter_3_1]

		if var_13.getLife(var_3_16) then
			local var_3_17, var_3_18 = var_13:getWorldColliderData()

			if var_0_1.CheckRectCollider(var_3_3, var_3_17, var_3_4, var_3_18) then
				if var_13:getConfig("boom") and var_13:getConfig("boom") > 0 then
					if var_13:damage({
						num = 999
					}) then
						local var_3_19 = arg_3_0._eventCall

						SailBoatGameEvent = var_19

						var_3_19(var_19.DESTROY_ENEMY, var_13:getDestroyData())
					end
				elseif var_3_0:checkColliderDamage() then
					var_3_0:flash()
					var_3_0:damage({
						num = var_0_1.colliderDamage
					})
				end
			end
		end
	end

	return
end

function var_0_0.dispose(arg_4_0)
	return
end

function var_0_0.clear(arg_5_0)
	return
end

return var_0_0
