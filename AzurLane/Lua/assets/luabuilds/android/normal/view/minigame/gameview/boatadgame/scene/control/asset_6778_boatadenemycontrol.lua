class = var_0_10000

local var_0_0 = var_0_10000("BoatAdEnemyControl")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	BoatAdGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._bgContent = arg_1_1
	arg_1_0._eventCall = arg_1_2
	findTF = var_1_10003
	arg_1_0._content = var_1_10003(arg_1_0._bgContent, "scene/content")
	arg_1_0._enemys = {}
	arg_1_0._enemyPool = {}

	return
end

function var_0_0.start(arg_2_0)
	for iter_2_0 = #arg_2_0._enemys, 1, -1 do
		local var_2_0 = arg_2_0
		local var_2_1 = arg_2_0.returnEnemy

		table = var_1_10007

		var_2_1(var_2_0, var_1_10007.remove(arg_2_0._enemys, iter_2_0))
	end

	var_0_1.SetGameEnemys(arg_2_0._enemys)

	arg_2_0._speedDownTime = 0
	arg_2_0._moveSpeed = 1

	return
end

function var_0_0.step(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1.GetGameItems()

	for iter_3_0 = #arg_3_0._enemys, 1, -1 do
		local var_3_1 = arg_3_0._enemys[iter_3_0]

		var_7.step(var_3_1, arg_3_1)

		if var_7:getRemoveFlag() then
			local var_3_2

			if var_7:getHp() <= 0 then
				var_3_2 = arg_3_0._eventCall
				BoatAdGameEvent = var_9

				var_3_2(var_9.ADD_SCORE, var_7:getConfig("score"))

				local var_3_3 = var_7

				if var_7.getBoss(var_3_3) and not var_0_1.isEndLessRound then
					var_3_2 = arg_3_0._eventCall
					BoatAdGameEvent = var_3_3

					var_3_2(var_3_3.PLAYER_DEAD, true)
				end
			end

			table = var_3_2

			var_3_2.remove(arg_3_0._enemys, iter_3_0)
			arg_3_0:returnEnemy(var_7)
		end

		if not var_7:getRemoveFlag() and var_7:getConfig("boss") and not var_7:getBattle() then
			local var_3_4 = var_0_1.char
			local var_3_5 = var_8.getPosition(var_3_4)
			local var_3_6, var_3_7 = var_7:getRelaPositionX()

			if var_3_7 - var_3_5.y < 600 then
				math = var_11

				if var_11.abs(var_3_6 - var_3_5.x) > 10 then
					local var_3_8 = var_7:getScale()
					local var_3_9 = (var_3_6 > var_3_5.x and -1 or 1) * 700 * arg_3_1 * var_3_8

					var_7:bossFocus(var_3_9)
				end
			end
		end
	end

	if arg_3_0._moveSpeed ~= 0 and arg_3_0._speedDownTime > 0 then
		arg_3_0._speedDownTime = arg_3_0._speedDownTime - arg_3_1

		if arg_3_0._speedDownTime <= 0 then
			arg_3_0._speedDownTime = 0

			for iter_3_1 = 1, #arg_3_0._enemys do
				local var_3_10 = arg_3_0._enemys[iter_3_1]

				var_7.speedDown(var_3_10, false)
			end
		end
	end

	return
end

function var_0_0.setMoveSpeed(arg_4_0, arg_4_1)
	arg_4_0._moveSpeed = arg_4_1

	for iter_4_0 = 1, #arg_4_0._enemys do
		local var_4_0 = arg_4_0._enemys[iter_4_0]

		var_6.setSpeed(var_4_0, arg_4_1)
	end

	return
end

function var_0_0.getMoveSpeed(arg_5_0)
	return arg_5_0._moveSpeed
end

function var_0_0.returnEnemy(arg_6_0, arg_6_1)
	arg_6_1:clear()

	table = var_2

	var_2.insert(arg_6_0._enemyPool, arg_6_1)

	return
end

function var_0_0.createEnemy(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.id
	local var_7_1 = arg_7_1.move_count
	local var_7_2 = arg_7_1.round
	local var_7_3 = arg_7_0:getOrCreateEnemy(var_7_0)
	local var_7_4 = arg_7_1.line

	var_7_3:start()
	var_7_3:setMoveCount(var_7_1, var_7_4)

	if arg_7_0._speedDownTime > 0 then
		var_7_3:speedDown(true)
	end

	table = var_7

	var_7.insert(arg_7_0._enemys, var_7_3)

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
		BoatAdGameConst = var_8_1

		if not var_8_1.game_enemy[arg_8_1] then
			print = var_4

			var_4("id = " .. arg_8_1 .. " 的敌人不存在")
		end

		Clone = var_4
		BoatAdGameConst = var_5

		local var_8_3 = var_4(var_5.game_enemy[arg_8_1])
		local var_8_4 = var_0_1.GetGameTplTf(var_8_3.tpl)

		BoatAdEnemy = var_6

		local var_8_5 = var_6.New(var_8_4, arg_8_0._event)

		var_8_0.setData(var_8_5, var_8_3)
		var_8_0:setContent(arg_8_0._content)
	end

	return var_8_0
end

function var_0_0.speedDown(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_1 > 0 then
		arg_9_0._speedDownTime = arg_9_1

		for iter_9_0 = 1, #arg_9_0._enemys do
			local var_9_0 = arg_9_0._enemys[iter_9_0]

			var_6.speedDown(var_9_0, true)
		end
	end

	return
end

function var_0_0.clear(arg_10_0)
	return
end

function var_0_0.stop(arg_11_0)
	local var_11_0

	if not arg_11_0._moveSpeed then
		var_11_0 = 1
	end

	arg_11_0.lastMoveSpeed = var_11_0

	arg_11_0:setMoveSpeed(0)

	return
end

function var_0_0.resume(arg_12_0)
	arg_12_0:setMoveSpeed(arg_12_0.lastMoveSpeed)

	return
end

function var_0_0.dispose(arg_13_0)
	return
end

return var_0_0
