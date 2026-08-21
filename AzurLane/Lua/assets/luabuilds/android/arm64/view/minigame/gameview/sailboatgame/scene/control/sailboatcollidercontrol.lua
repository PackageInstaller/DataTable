local var_0_0 = class("SailBoatColliderControl")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1 = SailBoatGameVo
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

	for iter_3_0 = 1, #var_3_1 do
		local var_3_7, var_3_8 = var_3_1[iter_3_0]:getWorldColliderData()

		if var_0_1.CheckRectCollider(var_3_3, var_3_7, var_3_4, var_3_8) then
			if var_3_1[iter_3_0]:getConfig("type") == SailBoatGameConst.item_static then
				local var_3_9 = var_3_1[iter_3_0]:getSpeed()

				var_3_0:move(var_3_9.x, var_3_9.y)
			elseif var_3_1[iter_3_0]:getConfig("type") == SailBoatGameConst.item_used then
				arg_3_0._eventCall(SailBoatGameEvent.USE_ITEM, var_3_1[iter_3_0]:getUseData())
				var_3_1[iter_3_0]:setRemoveFlag(true)
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1.SFX_SOUND_ITEM)
			end
		end
	end

	for iter_3_1 = 1, #var_3_2 do
		if var_3_2[iter_3_1]:getLife() then
			local var_3_10, var_3_11 = var_3_2[iter_3_1]:getWorldColliderData()

			if var_0_1.CheckRectCollider(var_3_3, var_3_10, var_3_4, var_3_11) then
				if var_3_2[iter_3_1]:getConfig("boom") and var_3_2[iter_3_1]:getConfig("boom") > 0 then
					if var_3_2[iter_3_1]:damage({
						num = 999
					}) then
						arg_3_0._eventCall(SailBoatGameEvent.DESTROY_ENEMY, var_3_2[iter_3_1]:getDestroyData())
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
