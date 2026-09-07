local TowerClimbingMapVO = class("TowerClimbingMapVO")

function TowerClimbingMapVO:Ctor(arg_1_1, arg_1_2)
	self.view = arg_1_2
	self.nextBlockIndex = 0
	self.level = 0
	self.higestLevel = 0
	self.id = arg_1_1

	assert(self.id, arg_1_1)

	return
end

function TowerClimbingMapVO:Init(arg_2_1, arg_2_2)
	self.mapWidth = arg_2_1.screenWidth
	self.mapHeight = arg_2_1.screenHeight
	self.awards = arg_2_1.awards[self.id]

	seriesAsync({
		function(arg_3_0)
			self:InitBlock(arg_3_0)

			return
		end,
		function(arg_4_0)
			self:InitPlayer(arg_2_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			self:InitGround(arg_2_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			assert(self.blocks[1])
			self.player:SetPosition(self.blocks[1].position)
			self:SendMapEvent("OnPlayerLifeUpdate", self.player.life)
			arg_6_0()

			return
		end
	}, arg_2_2)

	return
end

function TowerClimbingMapVO:InitGround(arg_7_1, arg_7_2)
	self.ground = {
		sleepTime = 0,
		IsRuning = false,
		position = TowerClimbingGameSettings.MANJUU_START_POS,
		name = arg_7_1.npcName
	}

	self:SendMapEvent("OnCreateGround", self.ground, arg_7_2)

	return
end

function TowerClimbingMapVO:InitBlock(arg_8_1)
	self.blocks = {}

	local var_8_0 = {}

	for iter_8_0 = 1, TowerClimbingGameSettings.GetBlockInitCnt(self.mapHeight) do
		table.insert(var_8_0, function(arg_9_0)
			local var_9_0 = self:CreateBlock()

			table.insert(self.blocks, var_9_0)
			self:SendMapEvent("OnCreateBlock", var_9_0, arg_9_0)

			return
		end)
	end

	parallelAsync(var_8_0, arg_8_1)

	return
end

local function var_0_1(arg_10_0, arg_10_1)
	if arg_10_0 == 1 then
		return TowerClimbingGameSettings.HEAD_BLOCK_TYPE
	else
		local var_10_0 = TowerClimbingGameSettings.MapId2BlockType[arg_10_1]

		assert(TowerClimbingGameSettings.MapId2BlockType[arg_10_1], arg_10_1)

		local var_10_1 = math.random(1, 100)

		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			if var_10_1 <= iter_10_1[2] then
				return iter_10_1[1]
			end
		end

		assert(false)
	end

	return
end

local function var_0_2(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return TowerClimbingGameSettings.BLOCK_START_POSITION
	else
		local var_11_0 = arg_11_1.position
		local var_11_1 = arg_11_1.width
		local var_11_2 = TowerClimbingGameSettings.BLOCK_INTERVAL_HEIGHT
		local var_11_3 = {}
		local var_11_4 = TowerClimbingGameSettings.BOUNDS[2] - (arg_11_1.position.x + arg_11_1.width / 2) - arg_11_0

		if TowerClimbingGameSettings.BLOCK_MAX_INTERVAL_WIDTH[1] < TowerClimbingGameSettings.BOUNDS[2] - (arg_11_1.position.x + arg_11_1.width / 2) - arg_11_0 then
			table.insert(var_11_3, arg_11_1.position.x + arg_11_1.width / 2 + math.random((var_11_4 >= 0 or nil) and 0, (math.min(TowerClimbingGameSettings.BLOCK_MAX_INTERVAL_WIDTH[2], var_11_4))) + arg_11_0 / 2)
		end

		local var_11_6 = var_11_0.x - var_11_1 / 2
		local var_11_7 = math.abs(TowerClimbingGameSettings.BOUNDS[1] - (var_11_0.x - var_11_1 / 2)) - arg_11_0

		if TowerClimbingGameSettings.BLOCK_MAX_INTERVAL_WIDTH[1] < var_11_7 then
			table.insert(var_11_3, var_11_6 - math.random((var_11_7 >= 0 or nil) and 0, (math.min(TowerClimbingGameSettings.BLOCK_MAX_INTERVAL_WIDTH[2], var_11_7))) - arg_11_0 / 2)
		end

		assert(#var_11_3 > 0, var_11_4 .. " & " .. var_11_7 .. " - " .. arg_11_0 .. " - " .. var_11_0.x .. "-" .. var_11_1)

		return Vector2(var_11_3[math.random(1, #var_11_3)], var_11_0.y + var_11_2)
	end

	return
end

function TowerClimbingMapVO:CreateBlock()
	self.nextBlockIndex = self.nextBlockIndex + 1

	local var_12_0 = var_0_1(self.nextBlockIndex, self.id)

	return {
		id = self.nextBlockIndex,
		type = var_12_0[1],
		width = var_12_0[2],
		position = var_0_2(var_12_0[2], self.blocks[#self.blocks]),
		isActive = not self.blocks[#self.blocks],
		level = self.nextBlockIndex
	}
end

function TowerClimbingMapVO:ActicveNextBlock(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(self.blocks) do
		if iter_13_1.level == arg_13_1 then
			iter_13_1.isActive = true

			self:SendMapEvent("OnActiveBlock", iter_13_1)

			if self.player:IsInvincible() then
				self:SendMapEvent("OnEnableStab", iter_13_1, false)
			end

			break
		end
	end

	return
end

function TowerClimbingMapVO:DeactiveAboveBlocks(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(self.blocks) do
		if arg_14_1 < iter_14_1.level and iter_14_1.isActive == true then
			iter_14_1.isActive = false

			self:SendMapEvent("OnActiveBlock", iter_14_1)
		end
	end

	return
end

function TowerClimbingMapVO:AddNewBlock(arg_15_1)
	local var_15_0 = self:CreateBlock()

	table.insert(self.blocks, var_15_0)
	self:SendMapEvent("OnCreateBlock", var_15_0, arg_15_1)

	return
end

function TowerClimbingMapVO:DoSink(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = {}

	table.insert(var_16_0, function(arg_17_0)
		self:SendMapEvent("SinkHandler", TowerClimbingGameSettings.SINK_DISTANCE * arg_16_2)

		return
	end)
	table.insert(var_16_0, 1, function(arg_18_0)
		if not self.ground.IsRuning then
			arg_18_0()

			return
		end

		self.ground.position = Vector2(self.ground.position.x, self.ground.position.y - TowerClimbingGameSettings.SINK_DISTANCE * arg_16_2)

		self:SendMapEvent("OnGroundPositionChange", self.ground.position)
		arg_18_0()

		return
	end)
	parallelAsync(var_16_0, arg_16_3)

	return
end

function TowerClimbingMapVO:CheckCorssBoundBlocks(arg_19_1)
	for iter_19_0 = #self.blocks, 1, -1 do
		if 0 >= self.blocks[iter_19_0].position.y then
			table.remove(self.blocks, iter_19_0)
			self:SendMapEvent("OnBlockDestory", self.blocks[iter_19_0].level)
		elseif TowerClimbingGameSettings.MANJUU_HEIGHT + self.ground.position.y >= self.blocks[iter_19_0].position.y then
			self.blocks[iter_19_0].isActive = false

			self:SendMapEvent("OnActiveBlock", self.blocks[iter_19_0])
		end
	end

	arg_19_1()

	return
end

function TowerClimbingMapVO:InitPlayer(arg_20_1, arg_20_2)
	self.player = TowerClimbingPlayerVO.New(self.view, {
		id = arg_20_1.shipId,
		life = arg_20_1.life,
		score = arg_20_1.score,
		higestscore = arg_20_1.higestscore,
		pageIndex = arg_20_1.pageIndex,
		mapScore = arg_20_1.mapScores[self.id]
	})

	self:SendMapEvent("OnCreatePlayer", self.player, arg_20_2)

	return
end

function TowerClimbingMapVO:GetPlayer()
	return self.player
end

function TowerClimbingMapVO:GetBlocks()
	return self.blocks
end

function TowerClimbingMapVO:SetCurrentLevel(arg_23_1)
	if arg_23_1 > self.level then
		self:ActicveNextBlock(arg_23_1 + 1)
	elseif arg_23_1 < self.level then
		self:DeactiveAboveBlocks(arg_23_1 + 1)
	end

	self.level = arg_23_1

	if arg_23_1 > self.higestLevel then
		self.higestLevel = arg_23_1

		self.player:AddScore()
		self:DoCheck(arg_23_1 - self.higestLevel)
		self:OverHigestScore()
	end

	return
end

function TowerClimbingMapVO:OverHigestScore()
	if self.player:IsOverHigestScore() and (function(arg_25_0)
		for iter_25_0, iter_25_1 in ipairs(self.awards) do
			if arg_25_0 == iter_25_1 then
				return true
			end
		end

		return false
	end)(self.player.score) then
		self:SendMapEvent("OnReachAwardScore")
	end

	return
end

function TowerClimbingMapVO:DoCheck(arg_26_1)
	if self.higestLevel <= 1 then
		return
	end

	seriesAsync({
		function(arg_27_0)
			self:AddNewBlock(arg_27_0)

			return
		end,
		function(arg_28_0)
			parallelAsync({
				function(arg_29_0)
					self:DoSink(self.higestLevel, arg_26_1, arg_29_0)

					return
				end,
				function(arg_30_0)
					self:SendMapEvent("OnSink", TowerClimbingGameSettings.SINK_DISTANCE * arg_26_1, arg_30_0)

					return
				end
			}, arg_28_0)

			return
		end,
		function(arg_31_0)
			self:CheckCorssBoundBlocks(arg_31_0)

			return
		end,
		function(arg_32_0)
			self:CheckGroundState()
			arg_32_0()

			return
		end
	})

	return
end

function TowerClimbingMapVO:CheckGroundState()
	if not self.ground.IsRuning and self.higestLevel >= TowerClimbingGameSettings.GROUND_RISE_UP_LEVEL then
		self.ground.IsRuning = true

		self:SendMapEvent("OnGroundRuning")
	end

	return
end

function TowerClimbingMapVO:ReBornPlayer()
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in ipairs(self.blocks) do
		if iter_34_1.isActive then
			table.insert(var_34_0, iter_34_1)
		end
	end

	assert(#var_34_0 > 0)

	local var_34_2 = _.detect(var_34_0, function(arg_35_0)
		return arg_35_0.level == self.higestLevel
	end)

	if not var_34_2 then
		table.sort(var_34_0, function(arg_36_0, arg_36_1)
			return arg_36_0.position.y > arg_36_1.position.y
		end)

		var_34_2 = var_34_0[1]
	end

	self.player:SetPosition(var_34_2.position + Vector2(0, 10))

	return
end

function TowerClimbingMapVO:AddPlayerInvincibleEffect(arg_37_1)
	for iter_37_0, iter_37_1 in ipairs(self.blocks) do
		if iter_37_1.isActive then
			self:SendMapEvent("OnEnableStab", iter_37_1, not arg_37_1)
		end
	end

	if self.ground.IsRuning then
		self:SendMapEvent("OnEnableGround", not arg_37_1)
	end

	return
end

local function var_0_3(arg_38_0)
	local var_38_0 = TowerClimbingGameSettings.GROUND_RISE_UP_SPEED[#TowerClimbingGameSettings.GROUND_RISE_UP_SPEED][2]

	for iter_38_0, iter_38_1 in ipairs(TowerClimbingGameSettings.GROUND_RISE_UP_SPEED) do
		if arg_38_0 < iter_38_1[1] then
			var_38_0 = iter_38_1[2]

			break
		end
	end

	return var_38_0
end

function TowerClimbingMapVO:Update()
	if self.ground.sleepTime > 0 then
		self.ground.sleepTime = self.ground.sleepTime - Time.deltaTime

		self:SendMapEvent("OnGroundSleepTimeChange", self.ground.sleepTime)
	end

	if self.ground.IsRuning and self.ground.sleepTime <= 0 then
		self.ground.position = Vector2(self.ground.position.x, self.ground.position.y + var_0_3(self.higestLevel) * Time.deltaTime)

		self:SendMapEvent("OnGroundPositionChange", self.ground.position)
	end

	if self.player:IsInvincible() then
		local var_39_0 = self.player:GetInvincibleTime()

		if var_39_0 == TowerClimbingGameSettings.INVINCEIBLE_TIME then
			self:AddPlayerInvincibleEffect(true)
		end

		self.player:SetInvincibleTime(var_39_0 - Time.deltaTime)

		if not self.player:IsInvincible() then
			self:AddPlayerInvincibleEffect(false)
		end
	end

	return
end

function TowerClimbingMapVO:SetGroundSleep(arg_40_1)
	if self.ground.IsRuning then
		self.ground.position = Vector2(self.ground.position.x, self.ground.position.y - TowerClimbingGameSettings.GROUND_SLIDE_DOWNWARD_DISTANCE)

		self:SendMapEvent("OnGroundPositionChange", self.ground.position)

		self.ground.sleepTime = arg_40_1
	end

	return
end

function TowerClimbingMapVO:SendMapEvent(arg_41_1, ...)
	self.view.map[arg_41_1](self.view.map, unpack({
		...
	}))

	return
end

function TowerClimbingMapVO:Dispose()
	if self.player then
		self.player:Dispose()

		self.player = nil
	end

	if self.ground then
		self.ground = nil
	end

	if self.blocks then
		self.blocks = nil
	end

	return
end

return TowerClimbingMapVO
