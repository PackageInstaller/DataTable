local BoatAdEnemyControl = class("BoatAdEnemyControl")
local var_0_1

function BoatAdEnemyControl:Ctor(arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	self._bgContent = arg_1_1
	self._eventCall = arg_1_2
	self._content = findTF(self._bgContent, "scene/content")
	self._enemys = {}
	self._enemyPool = {}

	return
end

function BoatAdEnemyControl:start()
	for iter_2_0 = #self._enemys, 1, -1 do
		self:returnEnemy(table.remove(self._enemys, iter_2_0))
	end

	var_0_1.SetGameEnemys(self._enemys)

	self._speedDownTime = 0
	self._moveSpeed = 1

	return
end

function BoatAdEnemyControl:step(arg_3_1)
	local var_3_0 = var_0_1.GetGameItems()

	for iter_3_0 = #self._enemys, 1, -1 do
		local var_3_1 = self._enemys[iter_3_0]

		self._enemys[iter_3_0]:step(arg_3_1)

		if var_3_1:getRemoveFlag() then
			if var_3_1:getHp() <= 0 then
				self._eventCall(BoatAdGameEvent.ADD_SCORE, var_3_1:getConfig("score"))

				if var_3_1:getBoss() and not var_0_1.isEndLessRound then
					self._eventCall(BoatAdGameEvent.PLAYER_DEAD, true)
				end
			end

			table.remove(self._enemys, iter_3_0)
			self:returnEnemy(var_3_1)
		end

		if not var_3_1:getRemoveFlag() and var_3_1:getConfig("boss") and not var_3_1:getBattle() then
			local var_3_2 = var_0_1.char:getPosition()
			local var_3_3, var_3_4 = var_3_1:getRelaPositionX()

			if var_3_4 - var_3_2.y < 600 and math.abs(var_3_3 - var_3_2.x) > 10 then
				var_3_1:bossFocus((var_3_3 > var_3_2.x and -1 or 1) * 700 * arg_3_1 * var_3_1:getScale())
			end
		end
	end

	if self._moveSpeed ~= 0 and self._speedDownTime > 0 then
		self._speedDownTime = self._speedDownTime - arg_3_1

		if self._speedDownTime <= 0 then
			self._speedDownTime = 0

			for iter_3_1 = 1, #self._enemys do
				self._enemys[iter_3_1]:speedDown(false)
			end
		end
	end

	return
end

function BoatAdEnemyControl:setMoveSpeed(arg_4_1)
	self._moveSpeed = arg_4_1

	for iter_4_0 = 1, #self._enemys do
		self._enemys[iter_4_0]:setSpeed(arg_4_1)
	end

	return
end

function BoatAdEnemyControl:getMoveSpeed()
	return self._moveSpeed
end

function BoatAdEnemyControl:returnEnemy(arg_6_1)
	arg_6_1:clear()
	table.insert(self._enemyPool, arg_6_1)

	return
end

function BoatAdEnemyControl:createEnemy(arg_7_1)
	local var_7_1 = self:getOrCreateEnemy(arg_7_1.id)

	var_7_1:start()
	var_7_1:setMoveCount(arg_7_1.move_count, arg_7_1.line)

	if self._speedDownTime > 0 then
		var_7_1:speedDown(true)
	end

	table.insert(self._enemys, var_7_1)

	return
end

function BoatAdEnemyControl:getOrCreateEnemy(arg_8_1, arg_8_2)
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
		if not BoatAdGameConst.game_enemy[arg_8_1] then
			print("id = " .. arg_8_1 .. " 的敌人不存在")
		end

		local var_8_1 = Clone(BoatAdGameConst.game_enemy[arg_8_1])

		var_8_0 = BoatAdEnemy.New(var_0_1.GetGameTplTf(var_8_1.tpl), self._event)

		var_8_0:setData(var_8_1)
		var_8_0:setContent(self._content)
	end

	return var_8_0
end

function BoatAdEnemyControl:speedDown(arg_9_1)
	if arg_9_1 and arg_9_1 > 0 then
		self._speedDownTime = arg_9_1

		for iter_9_0 = 1, #self._enemys do
			self._enemys[iter_9_0]:speedDown(true)
		end
	end

	return
end

function BoatAdEnemyControl:clear()
	return
end

function BoatAdEnemyControl:stop()
	self.lastMoveSpeed = self._moveSpeed or 1

	self:setMoveSpeed(0)

	return
end

function BoatAdEnemyControl:resume()
	self:setMoveSpeed(self.lastMoveSpeed)

	return
end

function BoatAdEnemyControl:dispose()
	return
end

return BoatAdEnemyControl
