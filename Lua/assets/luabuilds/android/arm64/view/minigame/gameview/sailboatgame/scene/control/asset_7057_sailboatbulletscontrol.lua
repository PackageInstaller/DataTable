local SailBoatBulletsControl = class("SailBoatBulletsControl")
local var_0_1

function SailBoatBulletsControl:Ctor(arg_1_1, arg_1_2)
	var_0_1 = SailBoatGameVo
	self._tf = arg_1_1
	self._event = arg_1_2
	self._bullets = {}
	self._bulletPool = {}
	self._content = findTF(self._tf, "scene_front/content")

	return
end

function SailBoatBulletsControl:start()
	for iter_2_0 = #self._bullets, 1, -1 do
		local var_2_0 = table.remove(self._bullets, iter_2_0)

		var_2_0:clear()
		table.insert(self._bulletPool, var_2_0)
	end

	self._bulletStep = var_0_1.bullet_step

	return
end

function SailBoatBulletsControl:step(arg_3_1)
	for iter_3_0 = #self._bullets, 1, -1 do
		self._bullets[iter_3_0]:step(arg_3_1)
	end

	self._bulletStep = self._bulletStep - 1

	if self._bulletStep > 0 then
		return
	end

	self._bulletStep = var_0_1.bullet_step

	local var_3_0 = var_0_1.GetGameEnemys()
	local var_3_1 = var_0_1.GetGameChar()
	local var_3_2 = var_3_1:getGroup()

	for iter_3_1 = #self._bullets, 1, -1 do
		local var_3_4 = self._bullets[iter_3_1]:getHitGroup()
		local var_3_5 = self._bullets[iter_3_1]:getWorld()

		if not self._bullets[iter_3_1]:getRemoveFlag() then
			for iter_3_2, iter_3_3 in ipairs(var_3_0) do
				if iter_3_3:getLife() then
					if iter_3_3:getLife() then
						local var_3_6, var_3_7 = iter_3_3:getMinMaxPosition()

						if var_0_1.PointInRect2(var_3_5, var_3_6, var_3_7) and table.contains(var_3_4, (iter_3_3:getGroup())) then
							self._bullets[iter_3_1]:hit()

							if iter_3_3:damage((self._bullets[iter_3_1]:getDamage())) then
								self._event(SailBoatGameEvent.DESTROY_ENEMY, iter_3_3:getDestroyData())
							end

							return
						end
					end
				end
			end
		end

		if not self._bullets[iter_3_1]:getRemoveFlag() and var_3_1:getLife() and table.contains(var_3_4, var_3_2) then
			local var_3_8, var_3_9 = var_3_1:getMinMaxPosition()

			if var_0_1.PointInRect2(var_3_5, var_3_8, var_3_9) then
				self._bullets[iter_3_1]:hit()
				var_3_1:damage((self._bullets[iter_3_1]:getDamage()))

				return
			end
		end

		if self._bullets[iter_3_1]:getRemoveFlag() then
			local var_3_10 = table.remove(self._bullets, iter_3_1)

			var_3_10:clear()
			self:returnBullet(var_3_10)
		end
	end

	return
end

function SailBoatBulletsControl:returnBullet(arg_4_1)
	table.insert(self._bulletPool, arg_4_1)

	return
end

function SailBoatBulletsControl:createBullet(arg_5_1)
	local var_5_0

	if #self._bulletPool > 0 then
		var_5_0 = table.remove(self._bulletPool, 1)
	end

	if not var_5_0 then
		var_5_0 = SailBoatBullet.New(var_0_1.GetGameBullet(), self._event)

		var_5_0:setContent(self._content)
	end

	var_5_0:setData(SailBoatGameConst.game_bullet[arg_5_1])
	table.insert(self._bullets, var_5_0)

	return var_5_0
end

function SailBoatBulletsControl:onEventCall(arg_6_1, arg_6_2)
	if arg_6_1 == SailBoatGameEvent.BOAT_EVENT_FIRE then
		local var_6_0 = self:createBullet(arg_6_2.bullet_id)

		var_6_0:setFireData(arg_6_2.fire_data)
		var_6_0:setWeapon(arg_6_2.weapon_data)
		var_6_0:start()
	end

	return
end

function SailBoatBulletsControl:dispose()
	return
end

function SailBoatBulletsControl:clear()
	return
end

return SailBoatBulletsControl
