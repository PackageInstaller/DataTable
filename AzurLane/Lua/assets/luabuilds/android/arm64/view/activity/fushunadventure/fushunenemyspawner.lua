local var_0_0 = class("FuShunEnemySpawner")
local var_0_1 = 1
local var_0_2 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.parent = arg_1_1
	arg_1_0.index = 0
	arg_1_0.score = 0
	arg_1_0.changeTime = -1
	arg_1_0.mode = var_0_1
	arg_1_0.OnSpawn = arg_1_2
	arg_1_0.targetTime = 0
	arg_1_0.delta = 0
	arg_1_0.starting = false

	return
end

function var_0_0.Start(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.delta = 0
	arg_2_0.changeTime = -1

	if arg_2_3 then
		arg_2_0.delta = arg_2_2
	end

	arg_2_0.targetTime = arg_2_2
	arg_2_0.mode = arg_2_1
	arg_2_0.starting = true

	FushunAdventureGame.LOG(" spawner time  :", arg_2_2)

	return
end

function var_0_0.Update(arg_3_0)
	if not arg_3_0.starting then
		return
	end

	arg_3_0.delta = arg_3_0.delta + Time.deltaTime

	if arg_3_0.delta >= arg_3_0.targetTime then
		arg_3_0.delta = 0

		arg_3_0:Spawn()

		if arg_3_0.changeTime ~= -1 then
			arg_3_0:Start(arg_3_0.mode, arg_3_0.changeTime, false)
		end
	end

	return
end

function var_0_0.NormalMode(arg_4_0)
	arg_4_0:Start(var_0_1, arg_4_0:CalcTime(arg_4_0.score), true)

	return
end

function var_0_0.CarzyMode(arg_5_0)
	arg_5_0:Start(var_0_2, FushunAdventureGameConst.EX_ENEMY_SPAWN_TIME, true)

	return
end

function var_0_0.Spawn(arg_6_0)
	local var_6_0 = arg_6_0.mode

	arg_6_0.index = arg_6_0.index + 1

	local var_6_1 = arg_6_0.index
	local var_6_2 = arg_6_0:GetConfigByScore(arg_6_0.score)

	assert(var_6_2)
	ResourceMgr.Inst:getAssetAsync("ui/fa_" .. var_6_2.name, "", function(arg_7_0)
		local var_7_0 = instantiate(arg_7_0)

		var_7_0.transform:SetParent(arg_6_0.parent, false)

		if arg_6_0.OnSpawn then
			local var_7_2 = {
				go = var_7_0,
				config = var_6_2
			}

			if var_6_0 == var_0_1 then
				var_7_2.speed = var_6_2.speed or var_6_2.crazy_speed
				var_7_2.index = var_6_1

				var_7_1(var_7_2)

				return
			end
		end
	end, true, true)

	return
end

function var_0_0.GetConfigByScore(arg_8_0, arg_8_1)
	local var_8_0

	for iter_8_0, iter_8_1 in ipairs(FushunAdventureGameConst.PROPABILITES) do
		if iter_8_1[1][1] <= arg_8_1 and arg_8_1 <= iter_8_1[1][2] then
			var_8_0 = iter_8_1

			break
		end
	end

	var_8_0 = var_8_0 or FushunAdventureGameConst.PROPABILITES[#FushunAdventureGameConst.PROPABILITES]

	local var_8_1 = var_8_0[2]
	local var_8_2 = math.random(1, 100)

	FushunAdventureGame.LOG("rate :", var_8_0[2], var_8_0[3], var_8_0[4], " r :", var_8_2)

	local var_8_3 = 1

	if var_8_1 < var_8_2 and var_8_2 <= var_8_1 + var_8_0[3] then
		var_8_3 = 2
	elseif var_8_2 > var_8_1 + var_8_0[3] and var_8_2 <= 100 then
		var_8_3 = 3
	end

	return FushunAdventureGameConst.ENEMYS[var_8_3]
end

function var_0_0.UpdateScore(arg_9_0, arg_9_1)
	arg_9_0.score = arg_9_1

	if arg_9_0.mode == var_0_2 then
		return
	end

	local var_9_0 = arg_9_0:CalcTime(arg_9_1)

	if arg_9_0.targetTime ~= var_9_0 then
		arg_9_0.changeTime = var_9_0
	end

	return
end

function var_0_0.CalcTime(arg_10_0, arg_10_1)
	local var_10_0

	for iter_10_0, iter_10_1 in ipairs(FushunAdventureGameConst.ENEMY_SPAWN_TIME_ADDITION) do
		if iter_10_1[1][1] <= arg_10_1 and arg_10_1 <= iter_10_1[1][2] then
			var_10_0 = iter_10_1

			break
		end
	end

	var_10_0 = var_10_0 or FushunAdventureGameConst.ENEMY_SPAWN_TIME_ADDITION[#FushunAdventureGameConst.ENEMY_SPAWN_TIME_ADDITION]

	return (math.random(var_10_0[2][1], var_10_0[2][2]))
end

function var_0_0.Stop(arg_11_0)
	arg_11_0.starting = false

	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:Stop()

	return
end

return var_0_0
