local FuShunEnemySpawner = class("FuShunEnemySpawner")
local var_0_1 = 1
local var_0_2 = 2

function FuShunEnemySpawner:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.parent = arg_1_1
	self.index = 0
	self.score = 0
	self.changeTime = -1
	self.mode = var_0_1
	self.OnSpawn = arg_1_2
	self.targetTime = 0
	self.delta = 0
	self.starting = false

	return
end

function FuShunEnemySpawner:Start(arg_2_1, arg_2_2, arg_2_3)
	self.delta = 0
	self.changeTime = -1

	if arg_2_3 then
		self.delta = arg_2_2
	end

	self.targetTime = arg_2_2
	self.mode = arg_2_1
	self.starting = true

	FushunAdventureGame.LOG(" spawner time  :", arg_2_2)

	return
end

function FuShunEnemySpawner:Update()
	if not self.starting then
		return
	end

	self.delta = self.delta + Time.deltaTime

	if self.delta >= self.targetTime then
		self.delta = 0

		self:Spawn()

		if self.changeTime ~= -1 then
			self:Start(self.mode, self.changeTime, false)
		end
	end

	return
end

function FuShunEnemySpawner:NormalMode()
	self:Start(var_0_1, self:CalcTime(self.score), true)

	return
end

function FuShunEnemySpawner:CarzyMode()
	self:Start(var_0_2, FushunAdventureGameConst.EX_ENEMY_SPAWN_TIME, true)

	return
end

function FuShunEnemySpawner:Spawn()
	local var_6_0 = self.mode

	self.index = self.index + 1

	local var_6_1 = self.index
	local var_6_2 = self:GetConfigByScore(self.score)

	assert(var_6_2)
	ResourceMgr.Inst:getAssetAsync("ui/fa_" .. var_6_2.name, "", function(arg_7_0)
		local var_7_0 = instantiate(arg_7_0)

		var_7_0.transform:SetParent(self.parent, false)

		if self.OnSpawn then
			local var_7_1 = {
				go = var_7_0,
				config = var_6_2
			}

			if var_6_0 == var_0_1 then
				var_7_1.speed = var_6_2.speed or var_6_2.crazy_speed
			end

			var_7_1.index = var_6_1

			self.OnSpawn(var_7_1)
		end

		return
	end, true, true)

	return
end

function FuShunEnemySpawner:GetConfigByScore(arg_8_1)
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

function FuShunEnemySpawner:UpdateScore(arg_9_1)
	self.score = arg_9_1

	if self.mode == var_0_2 then
		return
	end

	local var_9_0 = self:CalcTime(arg_9_1)

	if self.targetTime ~= var_9_0 then
		self.changeTime = var_9_0
	end

	return
end

function FuShunEnemySpawner:CalcTime(arg_10_1)
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

function FuShunEnemySpawner:Stop()
	self.starting = false

	return
end

function FuShunEnemySpawner:Dispose()
	self:Stop()

	return
end

return FuShunEnemySpawner
