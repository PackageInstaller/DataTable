local audio_manager = require("controller.audio_manager")
local var_0_1 = {}
local var_0_2 = 640
local var_0_3 = 994
local var_0_4 = {
	drop_bullet_num_add_random = 0.1,
	bullet_speed = 400,
	prop_speed = 100,
	drop_damage_add_random = 0.1,
	time = 60,
	drop_boom_random = 0.05,
	hp = 5,
	drop_attack_speed_add_random = 0.1,
	init_height = 950,
	monster_conf = {
		{
			speed = 200,
			score = 20,
			hp = 1,
			random = 0.5
		},
		{
			speed = 160,
			score = 40,
			hp = 3,
			random = 0.3
		},
		{
			speed = 120,
			score = 60,
			hp = 5,
			random = 0.2
		}
	},
	bullet_num_conf = {
		1,
		2,
		3,
		4,
		5
	},
	damage_conf = {
		1,
		2,
		3,
		4,
		5
	},
	attack_speed_conf = {
		1,
		0.9,
		0.8,
		0.7,
		0.6,
		0.5
	},
	time_stage = {
		0,
		10,
		20,
		30,
		40,
		50
	},
	monster_generate_time = {
		2,
		1.8,
		1.6,
		1.4,
		1.2,
		1
	},
	monster_hp_multi = {
		1,
		1.5,
		2,
		2.5,
		3,
		4
	},
	bullet_rotation_conf = {
		{
			0
		},
		{
			-10,
			10
		},
		{
			-15,
			0,
			15
		},
		{
			-24,
			-8,
			8,
			24
		},
		{
			-30,
			-15,
			0,
			15,
			30
		}
	}
}
local var_0_5 = {
	60,
	110,
	150
}

local function var_0_8(arg_1_0, arg_1_1)
	local function var_1_0(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		return arg_2_0 * arg_2_2 + arg_2_1 * arg_2_3
	end

	local function var_1_1(arg_3_0, arg_3_1)
		return math.sqrt(arg_3_0 * arg_3_0 + arg_3_1 * arg_3_1)
	end

	local function var_1_2(arg_4_0, arg_4_1)
		local var_4_0 = var_1_1(arg_4_0, arg_4_1)

		if var_4_0 > 0 then
			return arg_4_0 / var_4_0, arg_4_1 / var_4_0
		end

		return 0, 0
	end

	local function var_1_3(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		local var_5_0 = {}
		local var_5_1 = math.rad(arg_5_4)
		local var_5_2 = math.cos(var_5_1)
		local var_5_3 = math.sin(var_5_1)

		for iter_5_0, iter_5_1 in ipairs({
			{
				-(arg_5_2 * 0.5),
				-(arg_5_3 * 0.5)
			},
			{
				arg_5_2 * 0.5,
				-(arg_5_3 * 0.5)
			},
			{
				arg_5_2 * 0.5,
				arg_5_3 * 0.5
			},
			{
				-(arg_5_2 * 0.5),
				arg_5_3 * 0.5
			}
		}) do
			var_5_0[iter_5_0] = {
				x = iter_5_1[1] * var_5_2 - iter_5_1[2] * var_5_3 + arg_5_0,
				y = iter_5_1[1] * var_5_3 + iter_5_1[2] * var_5_2 + arg_5_1
			}
		end

		return var_5_0
	end

	local function var_1_4(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = var_1_0(arg_6_0[1].x, arg_6_0[1].y, arg_6_1, arg_6_2)
		local var_6_1 = var_6_0

		for iter_6_0 = 2, #arg_6_0 do
			local var_6_2 = var_1_0(arg_6_0[iter_6_0].x, arg_6_0[iter_6_0].y, arg_6_1, arg_6_2)

			if var_6_2 < var_6_0 then
				var_6_0 = var_6_2
			end

			if var_6_1 < var_6_2 then
				var_6_1 = var_6_2
			end
		end

		return var_6_0, var_6_1
	end

	local var_1_5 = var_1_3(arg_1_0.x, arg_1_0.y, arg_1_0.width, arg_1_0.height, arg_1_0.rotation)
	local var_1_6 = var_1_3(arg_1_1.x, arg_1_1.y, arg_1_1.width, arg_1_1.height, arg_1_1.rotation)
	local var_1_7 = {}
	local var_1_8, var_1_9 = var_1_2(-(var_1_5[2].y - var_1_5[1].y), var_1_5[2].x - var_1_5[1].x)
	local var_1_10, var_1_11 = var_1_2(-(var_1_5[4].y - var_1_5[1].y), var_1_5[4].x - var_1_5[1].x)

	table.insert(var_1_7, {
		x = var_1_8,
		y = var_1_9
	})
	table.insert(var_1_7, {
		x = var_1_10,
		y = var_1_11
	})

	local var_1_12, var_1_13 = var_1_2(-(var_1_6[2].y - var_1_6[1].y), var_1_6[2].x - var_1_6[1].x)
	local var_1_14, var_1_15 = var_1_2(-(var_1_6[4].y - var_1_6[1].y), var_1_6[4].x - var_1_6[1].x)

	table.insert(var_1_7, {
		x = var_1_12,
		y = var_1_13
	})
	table.insert(var_1_7, {
		x = var_1_14,
		y = var_1_15
	})

	for iter_1_0, iter_1_1 in ipairs(var_1_7) do
		local var_1_16, var_1_17 = var_1_4(var_1_5, iter_1_1.x, iter_1_1.y)
		local var_1_18, var_1_19 = var_1_4(var_1_6, iter_1_1.x, iter_1_1.y)

		if var_1_17 < var_1_18 or var_1_19 < var_1_16 then
			return false
		end
	end

	return true
end

function var_0_1.resetData(arg_7_0)
	arg_7_0.score = 0
	arg_7_0.hp = 0
	arg_7_0.time = 0
	arg_7_0.monsters = {}
	arg_7_0.bullets = {}
	arg_7_0.props = {}
	arg_7_0.damage_level = 1
	arg_7_0.bullet_num_level = 1
	arg_7_0.attack_speed_level = 1
	arg_7_0.attack_time = 0
	arg_7_0.monster_generate_time = 0
	arg_7_0.stage = 1
end

function var_0_1.initData(arg_8_0, arg_8_1)
	arg_8_0.score = 0
	arg_8_0.hp = var_0_4.hp
	arg_8_0.time = 0
	arg_8_0.monsters = {}
	arg_8_0.bullets = {}
	arg_8_0.props = {}
	arg_8_0.damage_level = arg_8_1.damage_level or 1
	arg_8_0.bullet_num_level = arg_8_1.bullet_num_level or 1
	arg_8_0.attack_speed_level = arg_8_1.attack_speed_level or 1
	arg_8_0.attack_time = 0
	arg_8_0.monster_generate_time = 0
	arg_8_0.stage = 1
end

function var_0_1.registerUIRef(arg_9_0, arg_9_1)
	arg_9_0.uiref = arg_9_1
end

function var_0_1.unregisterUIRef(arg_10_0)
	arg_10_0.uiref = nil
end

function var_0_1:exitGame()
	self:unloop()
	self:resetData()
	self:unregisterUIRef()

	self.gameEvents = {}
end

function var_0_1:registerGameEvent(arg_12_1, arg_12_2, arg_12_3)
	self.gameEvents = self.gameEvents or {}
	self.gameEvents[arg_12_1] = self.gameEvents[arg_12_1] or {}

	table.insert(self.gameEvents[arg_12_1], {
		obj = arg_12_2,
		handler = arg_12_3
	})
end

function var_0_1:unregisterGameEvent(arg_13_1, arg_13_2)
	if self.gameEvents[arg_13_1] then
		for iter_13_0, iter_13_1 in pairs(self.gameEvents[arg_13_1]) do
			if iter_13_1.handler == arg_13_2 then
				table.remove(self.gameEvents[arg_13_1], iter_13_1)
			end
		end
	end
end

function var_0_1:dispatcherEvent(arg_14_1, ...)
	if self.gameEvents[arg_14_1] then
		for iter_14_0, iter_14_1 in pairs(self.gameEvents[arg_14_1]) do
			iter_14_1.handler(iter_14_1.obj, ...)
		end
	end
end

function var_0_1:gameStart(arg_15_1)
	if not self.uiref then
		return
	end

	if self.mainloop then
		return
	end

	self:initData(arg_15_1)
	self:createMainLoop()
end

function var_0_1:gameUpdate(arg_16_1)
	if not self.mainloop then
		return
	end

	if self.gamePaused then
		return
	end

	self.time = self.time + arg_16_1
	self.attack_time = self.attack_time - arg_16_1

	if self.time >= var_0_4.time then
		self:gameEnd()

		return
	end

	if var_0_4.time_stage[self.stage + 1] and self.time > var_0_4.time_stage[self.stage + 1] then
		self.stage = self.stage + 1
	end

	self:updateMonster(arg_16_1)

	if self.hp <= 0 then
		return
	end

	self:updateBullet(arg_16_1)
	self:updateProp(arg_16_1)
	self:dispatcherEvent("UPDATE_GAMEDATA", {
		time = math.max(0, math.floor(var_0_4.time - self.time)),
		hp = self.hp,
		score = self.score
	})
end

function var_0_1:updateMonster(arg_17_1)
	self.monster_generate_time = self.monster_generate_time - arg_17_1

	if self.monster_generate_time <= 0 then
		self.monster_generate_time = var_0_4.monster_generate_time[self.stage]

		local var_17_1 = math.random()
		local var_17_2 = 0

		for iter_17_0, iter_17_1 in ipairs(var_0_4.monster_conf) do
			var_17_2 = var_17_2 + iter_17_1.random

			if var_17_1 < var_17_2 then
				local var_17_3 = math.floor(iter_17_1.hp * var_0_4.monster_hp_multi[self.stage])
				local var_17_4 = {
					type = iter_17_0,
					max_hp = var_17_3,
					hp = var_17_3,
					speed = iter_17_1.speed,
					score = iter_17_1.score,
					pos_y = var_0_4.init_height,
					pos_x = math.random(30, var_0_2 - 30)
				}

				table.insert(self.monsters, var_17_4)
				self:dispatcherEvent("GENERATE_MONSTER", {
					monster = var_17_4
				})

				break
			end
		end
	end

	for iter_17_2, iter_17_3 in pairs(self.monsters) do
		iter_17_3.pos_y = iter_17_3.pos_y - iter_17_3.speed * arg_17_1

		if iter_17_3.node then
			iter_17_3.node:setPositionY(iter_17_3.pos_y)
		end

		if iter_17_3.pos_y <= 0 then
			self.hp = self.hp - 1

			self:dispatcherEvent("DELETE_MONSTER", {
				monster = iter_17_3
			})

			self.monsters[iter_17_2] = nil

			if self.hp <= 0 then
				self:gameEnd()

				return
			end
		end
	end
end

local function var_0_9(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = math.rad(arg_18_3 or arg_18_0:getRotation())

	return cc.p(arg_18_0:getPositionX() + math.sin(var_18_0) * (arg_18_1 * arg_18_2), arg_18_0:getPositionY() + math.cos(var_18_0) * (arg_18_1 * arg_18_2))
end

function var_0_1:updateBullet(arg_19_1)
	local var_19_0 = var_0_4.damage_conf[math.min(self.damage_level, #var_0_4.damage_conf)]

	for iter_19_0, iter_19_1 in pairs(self.bullets) do
		if iter_19_1.node then
			local var_19_1 = var_0_9(iter_19_1.node, iter_19_1.speed, arg_19_1)

			iter_19_1.pos_x = var_19_1.x
			iter_19_1.pos_y = var_19_1.y

			iter_19_1.node:setPosition(var_19_1)

			if var_19_1.x < 0 or var_19_1.x > var_0_2 or var_19_1.y < 0 or var_19_1.y > var_0_3 then
				self:dispatcherEvent("DELETE_BULLET", {
					bullet = iter_19_1
				})

				self.bullets[iter_19_0] = nil

				break
			end

			local var_19_2

			for iter_19_2, iter_19_3 in pairs(self.props) do
				if iter_19_3.node and var_0_8({
					x = iter_19_3.node:getPositionX(),
					y = iter_19_3.node:getPositionY(),
					width = iter_19_3.node:getContentSize().width,
					height = iter_19_3.node:getContentSize().height,
					rotation = math.rad(iter_19_3.node:getRotation())
				}, {
					x = iter_19_1.node:getPositionX(),
					y = iter_19_1.node:getPositionY(),
					width = iter_19_1.node:getContentSize().width,
					height = iter_19_1.node:getContentSize().height,
					rotation = math.rad(iter_19_1.node:getRotation())
				}) then
					if iter_19_3.type == "bullet_num_add" then
						self.bullet_num_level = math.min(self.bullet_num_level + 1, #var_0_4.bullet_num_conf)

						self:dispatcherEvent("TOWER_LEVELUP")
					elseif iter_19_3.type == "damage_add" then
						self.damage_level = math.min(self.damage_level + 1, #var_0_4.damage_conf)

						self:dispatcherEvent("TOWER_LEVELUP")
					elseif iter_19_3.type == "attack_speed_add" then
						self.attack_speed_level = math.min(self.attack_speed_level + 1, #var_0_4.attack_speed_conf)

						self:dispatcherEvent("TOWER_LEVELUP")
					elseif iter_19_3.type == "boom" then
						self:boom()
					end

					self:dispatcherEvent("DELETE_BULLET", {
						bullet = iter_19_1
					})

					self.bullets[iter_19_0] = nil

					self:dispatcherEvent("DELETE_PROP", {
						prop = iter_19_3
					})

					self.props[iter_19_2] = nil
					var_19_2 = true

					break
				end
			end

			if var_19_2 then
				break
			end

			for iter_19_4, iter_19_5 in pairs(self.monsters) do
				if iter_19_5.node and var_0_8({
					x = iter_19_5.node:getPositionX(),
					y = iter_19_5.node:getPositionY(),
					width = var_0_5[iter_19_5.type],
					height = var_0_5[iter_19_5.type],
					rotation = math.rad(iter_19_5.node:getRotation())
				}, {
					x = iter_19_1.node:getPositionX(),
					y = iter_19_1.node:getPositionY(),
					width = iter_19_1.node:getContentSize().width,
					height = iter_19_1.node:getContentSize().height,
					rotation = math.rad(iter_19_1.node:getRotation())
				}) then
					iter_19_5.hp = iter_19_5.hp - var_19_0

					self:dispatcherEvent("UPDATE_MONSTER", {
						monster = iter_19_5
					})

					if iter_19_5.hp <= 0 then
						self.score = self.score + iter_19_5.score

						self:dispatcherEvent("DELETE_MONSTER", {
							monster = iter_19_5
						})

						self.monsters[iter_19_4] = nil

						local var_19_3 = math.random()
						local var_19_4

						if var_19_3 <= var_0_4.drop_bullet_num_add_random then
							var_19_4 = {
								type = "bullet_num_add",
								pos_x = iter_19_5.pos_x,
								pos_y = iter_19_5.pos_y,
								speed = var_0_4.prop_speed,
								rotation = math.random(0, 360)
							}
						elseif var_19_3 <= var_0_4.drop_bullet_num_add_random + var_0_4.drop_damage_add_random then
							var_19_4 = {
								type = "damage_add",
								pos_x = iter_19_5.pos_x,
								pos_y = iter_19_5.pos_y,
								speed = var_0_4.prop_speed,
								rotation = math.random(0, 360)
							}
						elseif var_19_3 <= var_0_4.drop_bullet_num_add_random + var_0_4.drop_damage_add_random + var_0_4.drop_attack_speed_add_random then
							var_19_4 = {
								type = "attack_speed_add",
								pos_x = iter_19_5.pos_x,
								pos_y = iter_19_5.pos_y,
								speed = var_0_4.prop_speed,
								rotation = math.random(0, 360)
							}
						elseif var_19_3 <= var_0_4.drop_bullet_num_add_random + var_0_4.drop_damage_add_random + var_0_4.drop_attack_speed_add_random + var_0_4.drop_boom_random then
							var_19_4 = {
								type = "boom",
								pos_x = iter_19_5.pos_x,
								pos_y = iter_19_5.pos_y,
								speed = var_0_4.prop_speed,
								rotation = math.random(0, 360)
							}
						end

						if var_19_4 then
							table.insert(self.props, var_19_4)
							self:dispatcherEvent("GENERATE_PROP", {
								prop = var_19_4
							})
						end
					end

					self:dispatcherEvent("DELETE_BULLET", {
						bullet = iter_19_1
					})

					self.bullets[iter_19_0] = nil

					break
				end
			end
		end
	end
end

function var_0_1:updateProp(arg_20_1)
	for iter_20_0, iter_20_1 in pairs(self.props) do
		if iter_20_1.node then
			local var_20_1 = var_0_9(iter_20_1.node, iter_20_1.speed, arg_20_1, iter_20_1.rotation)

			iter_20_1.pos_x = math.min(math.max(0, var_20_1.x), var_0_2)
			iter_20_1.pos_y = math.min(math.max(0, var_20_1.y), var_0_3)

			iter_20_1.node:setPosition(iter_20_1.pos_x, iter_20_1.pos_y)

			if iter_20_1.pos_x <= 0 or iter_20_1.pos_x >= var_0_2 then
				iter_20_1.rotation = 360 - iter_20_1.rotation
			elseif iter_20_1.pos_y <= 0 or iter_20_1.pos_y >= var_0_3 then
				iter_20_1.rotation = iter_20_1.rotation <= 180 and 180 - iter_20_1.rotation or 540 - iter_20_1.rotation
			end
		end
	end
end

function var_0_1:boom()
	for iter_21_0, iter_21_1 in pairs(self.monsters) do
		self.score = self.score + iter_21_1.score
	end

	self.monsters = {}
	self.bullets = {}
	self.props = {}

	self:dispatcherEvent("BOOM", {
		score = self.score,
		monsters = self.monsters
	})
end

function var_0_1:PanelTouch(arg_22_1)
	if not self.mainloop then
		return
	end

	if self.attack_time > 0 then
		return
	end

	self.attack_time = var_0_4.attack_speed_conf[math.min(self.attack_speed_level, #var_0_4.attack_speed_conf)]

	local var_22_0 = var_0_4.bullet_num_conf[math.min(self.bullet_num_level, #var_0_4.bullet_num_conf)]

	for iter_22_0 = 1, var_22_0 do
		local var_22_1 = arg_22_1 + var_0_4.bullet_rotation_conf[var_22_0][iter_22_0]

		if arg_22_1 + var_0_4.bullet_rotation_conf[var_22_0][iter_22_0] > 360 then
			var_22_1 = var_22_1 - 360
		end

		if var_22_1 < 0 then
			var_22_1 = 360 + var_22_1
		end

		if var_22_1 < 0 then
			var_22_1 = 360 + var_22_1
		end

		local var_22_2 = {
			pos_y = 50,
			pos_x = var_0_2 / 2,
			rotation = var_22_1,
			speed = var_0_4.bullet_speed
		}

		table.insert(self.bullets, var_22_2)
		self:dispatcherEvent("GENERATE_BULLET", {
			bullet = var_22_2
		})
	end
end

function var_0_1:gameEnd()
	self:unloop()
	self:dispatcherEvent("GAME_END", {
		time = math.max(0, math.floor(var_0_4.time - self.time)),
		hp = self.hp,
		score = self.score
	})
	self:resetData()
end

function var_0_1:createMainLoop()
	self.mainloop = self.mainloop or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_25_0)
		self:gameUpdate(arg_25_0)
	end, 0, false)
end

function var_0_1:unloop()
	if self.mainloop then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.mainloop)

		self.mainloop = nil
	end
end

return var_0_1
