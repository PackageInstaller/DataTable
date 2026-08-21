local var_0_0 = class("BoatAdEnemyControl")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	arg_1_0._bgContent = arg_1_1
	arg_1_0._eventCall = arg_1_2
	arg_1_0._content = findTF(arg_1_0._bgContent, "scene/content")
	arg_1_0._enemys = {}
	arg_1_0._enemyPool = {}

	return
end

function var_0_0.start(arg_2_0)
	for iter_2_0 = #arg_2_0._enemys, 1, -1 do
		arg_2_0:returnEnemy(table.remove(arg_2_0._enemys, iter_2_0))
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

		arg_3_0._enemys[iter_3_0]:step(arg_3_1)

		if var_3_1:getRemoveFlag() then
			if var_3_1:getHp() <= 0 then
				arg_3_0._eventCall(BoatAdGameEvent.ADD_SCORE, var_3_1:getConfig("score"))

				if var_3_1:getBoss() and not var_0_1.isEndLessRound then
					arg_3_0._eventCall(BoatAdGameEvent.PLAYER_DEAD, true)
				end
			end

			table.remove(arg_3_0._enemys, iter_3_0)
			arg_3_0:returnEnemy(var_3_1)
		end

		if not var_3_1:getRemoveFlag() and var_3_1:getConfig("boss") and not var_3_1:getBattle() then
			local var_3_2 = var_0_1.char:getPosition()
			local var_3_3, var_3_4 = var_3_1:getRelaPositionX()

			if var_3_4 - var_3_2.y < 600 and math.abs(var_3_3 - var_3_2.x) > 10 then
				var_3_1:bossFocus((var_3_3 > var_3_2.x and -1 or 1) * 700 * arg_3_1 * var_3_1:getScale())
			end
		end
	end

	if arg_3_0._moveSpeed ~= 0 and arg_3_0._speedDownTime > 0 then
		arg_3_0._speedDownTime = arg_3_0._speedDownTime - arg_3_1

		if arg_3_0._speedDownTime <= 0 then
			arg_3_0._speedDownTime = 0

			for iter_3_1 = 1, #arg_3_0._enemys do
				arg_3_0._enemys[iter_3_1]:speedDown(false)
			end
		end
	end

	return
end

function var_0_0.setMoveSpeed(arg_4_0, arg_4_1)
	arg_4_0._moveSpeed = arg_4_1

	for iter_4_0 = 1, #arg_4_0._enemys do
		arg_4_0._enemys[iter_4_0]:setSpeed(arg_4_1)
	end

	return
end

function var_0_0.getMoveSpeed(arg_5_0)
	return arg_5_0._moveSpeed
end

function var_0_0.returnEnemy(arg_6_0, arg_6_1)
	arg_6_1:clear()
	table.insert(arg_6_0._enemyPool, arg_6_1)

	return
end

function var_0_0.createEnemy(arg_7_0, arg_7_1)
	local var_7_1 = arg_7_0:getOrCreateEnemy(arg_7_1.id)

	var_7_1:start()
	var_7_1:setMoveCount(arg_7_1.move_count, arg_7_1.line)

	if arg_7_0._speedDownTime > 0 then
		var_7_1:speedDown(true)
	end

	table.insert(arg_7_0._enemys, var_7_1)

	return
end

function var_0_0.getOrCreateEnemy(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0

	if #arg_8_0._enemyPool > 0 then
		for iter_8_0 = #arg_8_0._enemyPool, 1, -1 do
			if not var_8_0 and arg_8_0._enemyPool[iter_8_0]:getId() == arg_8_1 then
				var_8_0 = table.remove(arg_8_0._enemyPool, iter_8_0)

				break
			end
		end
	end

	if not var_8_0 then
		if not BoatAdGameConst.game_enemy[arg_8_1] then
			print("id = " .. arg_8_1 .. " 的敌人不存在")
		end

		local var_8_1 = Clone(BoatAdGameConst.game_enemy[arg_8_1])

		var_8_0 = BoatAdEnemy.New(var_0_1.GetGameTplTf(var_8_1.tpl), arg_8_0._event)

		var_8_0:setData(var_8_1)
		var_8_0:setContent(arg_8_0._content)
	end

	return var_8_0
end

function var_0_0.speedDown(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_1 > 0 then
		arg_9_0._speedDownTime = arg_9_1

		for iter_9_0 = 1, #arg_9_0._enemys do
			arg_9_0._enemys[iter_9_0]:speedDown(true)
		end
	end

	return
end

function var_0_0.clear(arg_10_0)
	return
end

function var_0_0.stop(arg_11_0)
	arg_11_0.lastMoveSpeed = arg_11_0._moveSpeed or 1

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
