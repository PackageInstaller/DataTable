local SailBoatEnemyControllua = class("SailBoatEnemyControllua")
local var_0_1

function SailBoatEnemyControllua:Ctor(arg_1_1, arg_1_2)
	var_0_1 = SailBoatGameVo
	self._bgContent = arg_1_1
	self._eventCall = arg_1_2
	self._content = findTF(self._bgContent, "scene/content")
	self._enemys = {}
	self._enemyPool = {}
	self._rules = {}

	return
end

function SailBoatEnemyControllua:start()
	for iter_2_0 = #self._enemys, 1, -1 do
		self:returnEnemy(table.remove(self._enemys, iter_2_0))
	end

	self._rules = {}

	var_0_1.SetGameEnemys(self._enemys)

	local var_2_0 = var_0_1.GetRoundData()

	if var_2_0 then
		for iter_2_1 = 1, #var_2_0.enemy_rule do
			local var_2_1

			if not SailBoatGameConst.enemy_rule[var_2_0.enemy_rule[iter_2_1]] then
				print("不存在 rule id " .. var_2_0.enemy_rule[iter_2_1])

				var_2_1 = {
					data = SailBoatGameConst.enemy_rule[var_2_0.enemy_rule[iter_2_1]]
				}
			end

			var_2_1.time = 0

			table.insert(self._rules, var_2_1)
		end
	end

	self._fireIndex = var_0_1.fire_step

	return
end

function SailBoatEnemyControllua:step(arg_3_1)
	self._fireIndex = self._fireIndex - 1

	if self._fireIndex <= 0 then
		self._fireIndex = var_0_1.fire_step

		local var_3_0 = var_0_1.GetGameChar()
		local var_3_1 = var_3_0:getPosition()
		local var_3_2 = var_0_1.GetGameEnemys()

		for iter_3_0 = 1, #var_3_2 do
			if var_3_2[iter_3_0]:canFire() then
				self:checkEnemyFire(var_3_0, var_3_2[iter_3_0])
			end
		end
	end

	local var_3_3 = var_0_1.GetGameItems()

	for iter_3_1 = #self._enemys, 1, -1 do
		self._enemys[iter_3_1]:step(arg_3_1)

		if self._enemys[iter_3_1]:getRemoveFlag() then
			table.remove(self._enemys, iter_3_1)
			self:returnEnemy(self._enemys[iter_3_1])
		elseif not self._enemys[iter_3_1]:getStop() then
			for iter_3_2, iter_3_3 in ipairs(var_3_3) do
				if self:checkEnemyCollider(self._enemys[iter_3_1], iter_3_3) then
					self._enemys[iter_3_1]:stopTarget(Vector2(0, 0))

					if self._enemys[iter_3_1]:getConfig("boom") and self._enemys[iter_3_1]:damage({
						num = 99999
					}) then
						self._eventCall(SailBoatGameEvent.DESTROY_ENEMY, self._enemys[iter_3_1]:getDestroyData())
					end
				end
			end
		end
	end

	for iter_3_4 = 1, #self._rules do
		if var_0_1.gameTime > self._rules[iter_3_4].data.create_time[1] and var_0_1.gameTime < self._rules[iter_3_4].data.create_time[2] and self._rules[iter_3_4].time and self._rules[iter_3_4].time >= 0 then
			self._rules[iter_3_4].time = self._rules[iter_3_4].time - arg_3_1

			if self._rules[iter_3_4].time <= 0 then
				self._rules[iter_3_4].time = math.random(1, self._rules[iter_3_4].data.time[2] - self._rules[iter_3_4].data.time[1]) + self._rules[iter_3_4].data.time[1]

				self:applyRule(self._rules[iter_3_4])
			end
		end
	end

	return
end

function SailBoatEnemyControllua:checkEnemyFire(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:getPosition()

	if arg_4_1:getLife() and arg_4_2:getLife() and not arg_4_2:inFireCd() then
		local var_4_1 = arg_4_2:getPosition()
		local var_4_2, var_4_3 = arg_4_2:getWeapons()
		local var_4_4, var_4_5 = arg_4_2:getFirePos()
		local var_4_6, var_4_7 = arg_4_2:getFireContent()
		local var_4_8 = var_4_0.x > var_4_1.x and var_4_3 or var_4_2
		local var_4_9 = var_4_0.x > var_4_1.x and var_4_5 or var_4_4

		var_4_9.y = (var_4_0.x > var_4_1.x and var_4_5 or var_4_4).y + math.random(-15, 15)

		local var_4_10 = var_4_0.x > var_4_1.x and var_4_7 or var_4_6

		if math.sqrt(math.pow(var_4_0.x - var_4_1.x, 2) + math.pow(var_4_0.y - var_4_1.y, 2)) < arg_4_2:getWeaponMaxDistance() then
			local var_4_11 = math.atan2(var_4_0.y - var_4_1.y + math.random(-50, 50), var_4_0.x - var_4_1.x + math.random(-50, 50))

			for iter_4_0 = 1, #var_4_8 do
				if var_4_8[iter_4_0]:getFireAble() then
					local var_4_12 = var_4_8[iter_4_0]:getAngel()

					if var_4_12 > math.abs(var_4_11 * math.rad2Deg) or var_4_12 > math.abs(180 - math.abs(var_4_11 * math.rad2Deg)) then
						local var_4_13 = var_4_8[iter_4_0]:fire()

						if var_4_13 then
							arg_4_2:fire()
							self._eventCall(SailBoatGameEvent.BOAT_EVENT_FIRE, {
								bullet_id = var_4_13.bullet_id,
								weapon_data = var_4_13,
								fire_data = {
									pos = var_4_9,
									move = Vector2(math.cos(var_4_11), math.sin(var_4_11)),
									hit = arg_4_2:getHitGroup(),
									effect_pos = Vector2(0, 0),
									effect_content = var_4_10
								}
							})

							return
						end
					end
				end
			end
		end
	end

	return
end

function SailBoatEnemyControllua:returnEnemy(arg_5_1)
	arg_5_1:clear()
	table.insert(self._enemyPool, arg_5_1)

	return
end

function SailBoatEnemyControllua:checkEnemyCollider(arg_6_1, arg_6_2)
	if arg_6_2:getConfig("type") == SailBoatGameConst.item_static then
		local var_6_0 = arg_6_2:getPosition()
		local var_6_1 = arg_6_1:getPosition()

		if math.abs(var_6_0.x - var_6_1.x) < 500 and math.abs(var_6_0.y - var_6_1.y) < 500 then
			local var_6_2, var_6_3 = arg_6_2:getWorldColliderData()
			local var_6_4, var_6_5 = arg_6_1:getWorldColliderData()

			if var_0_1.CheckRectCollider(var_6_4, var_6_2, var_6_5, var_6_3) then
				return true
			end
		end
	end

	return false
end

function SailBoatEnemyControllua:applyRule(arg_7_1)
	local var_7_0 = arg_7_1.data.enemys
	local var_7_1 = arg_7_1.data.screen_pos_x
	local var_7_2 = arg_7_1.data.screen_pos_y

	if not arg_7_1.data.screen_pos_x or not var_7_2 then
		print("rule id = " .. arg_7_1.data .. " 异常，没有范围参数")
	end

	local var_7_3 = var_7_0[math.random(1, #var_7_0)]
	local var_7_4 = var_0_1.GetRangePos(var_7_1, var_7_2)

	if not var_7_4 then
		return
	end

	local var_7_5 = self:getOrCreateEnemy(var_7_3)

	var_7_5:setPosition(var_7_4)
	table.insert(self._enemys, var_7_5)
	var_7_5:setTarget(arg_7_1.data.target_x, arg_7_1.data.target_y, arg_7_1.data.target_speed)
	var_7_5:start()

	return
end

function SailBoatEnemyControllua:getOrCreateEnemy(arg_8_1, arg_8_2)
	local var_8_0

	if #self._enemyPool > 0 then
		for iter_8_0 = #self._enemyPool, 1, -1 do
			if not var_8_0 and self._enemyPool[iter_8_0]:getId() == arg_8_1 then
				var_8_0 = table.remove(self._enemyPool, iter_8_0)

				break
			end
		end
	end

	if not var_8_0 then
		if not SailBoatGameConst.game_enemy[arg_8_1] then
			print("id = " .. arg_8_1 .. " 的敌人不存在")
		end

		local var_8_1 = Clone(SailBoatGameConst.game_enemy[arg_8_1])

		var_8_0 = SailBoatEnemy.New(var_0_1.GetGameEnemyTf(var_8_1.tpl), self._event)

		var_8_0:setData(var_8_1)
		self:initWeapon(var_8_0, var_8_1.weapons)
		var_8_0:setContent(self._content)
	end

	return var_8_0
end

function SailBoatEnemyControllua:initWeapon(arg_9_1, arg_9_2)
	local var_9_0 = {}
	local var_9_1 = {}

	for iter_9_0 = 1, #arg_9_2[1] do
		table.insert(var_9_0, (SailBoatWeapon.New(SailBoatGameConst.game_weapon[arg_9_2[1][iter_9_0]])))
	end

	for iter_9_1 = 1, #arg_9_2[2] do
		table.insert(var_9_1, (SailBoatWeapon.New(SailBoatGameConst.game_weapon[arg_9_2[2][iter_9_1]])))
	end

	arg_9_1:setWeapon(var_9_0, var_9_1)

	return
end

function SailBoatEnemyControllua:clear()
	return
end

function SailBoatEnemyControllua:stop()
	return
end

function SailBoatEnemyControllua:dispose()
	return
end

return SailBoatEnemyControllua
