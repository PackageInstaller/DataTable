local var_0_0 = class("TowerClimbingMapVO")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.view = arg_1_2
	arg_1_0.nextBlockIndex = 0
	arg_1_0.level = 0
	arg_1_0.higestLevel = 0
	arg_1_0.id = arg_1_1

	assert(arg_1_0.id, arg_1_1)

	return
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.mapWidth = arg_2_1.screenWidth
	arg_2_0.mapHeight = arg_2_1.screenHeight
	arg_2_0.awards = arg_2_1.awards[arg_2_0.id]

	seriesAsync({
		function(arg_3_0)
			arg_2_0:InitBlock(arg_3_0)

			return
		end,
		function(arg_4_0)
			arg_2_0:InitPlayer(arg_2_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			arg_2_0:InitGround(arg_2_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			assert(arg_2_0.blocks[1])
			arg_2_0.player:SetPosition(arg_2_0.blocks[1].position)
			arg_2_0:SendMapEvent("OnPlayerLifeUpdate", arg_2_0.player.life)
			arg_6_0()

			return
		end
	}, arg_2_2)

	return
end

function var_0_0.InitGround(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.ground = {
		sleepTime = 0,
		IsRuning = false,
		position = TowerClimbingGameSettings.MANJUU_START_POS,
		name = arg_7_1.npcName
	}

	arg_7_0:SendMapEvent("OnCreateGround", arg_7_0.ground, arg_7_2)

	return
end

function var_0_0.InitBlock(arg_8_0, arg_8_1)
	arg_8_0.blocks = {}

	for iter_8_0 = 1, TowerClimbingGameSettings.GetBlockInitCnt(arg_8_0.mapHeight) do
		table.insert({}, function(arg_9_0)
			local var_9_0 = arg_8_0:CreateBlock()

			table.insert(arg_8_0.blocks, var_9_0)
			arg_8_0:SendMapEvent("OnCreateBlock", var_9_0, arg_9_0)

			return
		end)
	end

	parallelAsync({}, arg_8_1)

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
			local var_11_5 = TowerClimbingGameSettings.BLOCK_MAX_INTERVAL_WIDTH[1]

			if var_11_4 >= 0 then
				var_11_5 = 0
			end

			table.insert(var_11_3, arg_11_1.position.x + arg_11_1.width / 2 + math.random(var_11_5, (math.min(TowerClimbingGameSettings.BLOCK_MAX_INTERVAL_WIDTH[2], var_11_4))) + arg_11_0 / 2)
		end

		local var_11_6 = var_11_0.x - var_11_1 / 2
		local var_11_7 = math.abs(TowerClimbingGameSettings.BOUNDS[1] - (var_11_0.x - var_11_1 / 2)) - arg_11_0

		if TowerClimbingGameSettings.BLOCK_MAX_INTERVAL_WIDTH[1] < var_11_7 then
			local var_11_8 = TowerClimbingGameSettings.BLOCK_MAX_INTERVAL_WIDTH[1]

			if var_11_7 >= 0 then
				var_11_8 = 0
			end

			table.insert(var_11_3, var_11_6 - math.random(var_11_8, (math.min(TowerClimbingGameSettings.BLOCK_MAX_INTERVAL_WIDTH[2], var_11_7))) - arg_11_0 / 2)
		end

		assert(#var_11_3 > 0, var_11_4 .. " & " .. var_11_7 .. " - " .. arg_11_0 .. " - " .. var_11_0.x .. "-" .. var_11_1)

		return Vector2(var_11_3[math.random(1, #var_11_3)], var_11_0.y + var_11_2)
	end

	return
end

function var_0_0.CreateBlock(arg_12_0)
	arg_12_0.nextBlockIndex = arg_12_0.nextBlockIndex + 1

	local var_12_0 = var_0_1(arg_12_0.nextBlockIndex, arg_12_0.id)

	return {
		id = arg_12_0.nextBlockIndex,
		type = var_12_0[1],
		width = var_12_0[2],
		position = var_0_2(var_12_0[2], arg_12_0.blocks[#arg_12_0.blocks]),
		isActive = not arg_12_0.blocks[#arg_12_0.blocks],
		level = arg_12_0.nextBlockIndex
	}
end

function var_0_0.ActicveNextBlock(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.blocks) do
		if iter_13_1.level == arg_13_1 then
			iter_13_1.isActive = true

			arg_13_0:SendMapEvent("OnActiveBlock", iter_13_1)

			if arg_13_0.player:IsInvincible() then
				arg_13_0:SendMapEvent("OnEnableStab", iter_13_1, false)
			end

			break
		end
	end

	return
end

function var_0_0.DeactiveAboveBlocks(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.blocks) do
		if arg_14_1 < iter_14_1.level and iter_14_1.isActive == true then
			iter_14_1.isActive = false

			arg_14_0:SendMapEvent("OnActiveBlock", iter_14_1)
		end
	end

	return
end

function var_0_0.AddNewBlock(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:CreateBlock()

	table.insert(arg_15_0.blocks, var_15_0)
	arg_15_0:SendMapEvent("OnCreateBlock", var_15_0, arg_15_1)

	return
end

function var_0_0.DoSink(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	table.insert({}, function(arg_17_0)
		arg_16_0:SendMapEvent("SinkHandler", TowerClimbingGameSettings.SINK_DISTANCE * arg_16_2)

		return
	end)
	table.insert({}, 1, function(arg_18_0)
		if not arg_16_0.ground.IsRuning then
			arg_18_0()

			return
		end

		arg_16_0.ground.position = Vector2(arg_16_0.ground.position.x, arg_16_0.ground.position.y - TowerClimbingGameSettings.SINK_DISTANCE * arg_16_2)

		arg_16_0:SendMapEvent("OnGroundPositionChange", arg_16_0.ground.position)
		arg_18_0()

		return
	end)
	parallelAsync({}, arg_16_3)

	return
end

function var_0_0.CheckCorssBoundBlocks(arg_19_0, arg_19_1)
	for iter_19_0 = #arg_19_0.blocks, 1, -1 do
		if 0 >= arg_19_0.blocks[iter_19_0].position.y then
			table.remove(arg_19_0.blocks, iter_19_0)
			arg_19_0:SendMapEvent("OnBlockDestory", arg_19_0.blocks[iter_19_0].level)
		elseif TowerClimbingGameSettings.MANJUU_HEIGHT + arg_19_0.ground.position.y >= arg_19_0.blocks[iter_19_0].position.y then
			arg_19_0.blocks[iter_19_0].isActive = false

			arg_19_0:SendMapEvent("OnActiveBlock", arg_19_0.blocks[iter_19_0])
		end
	end

	arg_19_1()

	return
end

function var_0_0.InitPlayer(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0.player = TowerClimbingPlayerVO.New(arg_20_0.view, {
		id = arg_20_1.shipId,
		life = arg_20_1.life,
		score = arg_20_1.score,
		higestscore = arg_20_1.higestscore,
		pageIndex = arg_20_1.pageIndex,
		mapScore = arg_20_1.mapScores[arg_20_0.id]
	})

	arg_20_0:SendMapEvent("OnCreatePlayer", arg_20_0.player, arg_20_2)

	return
end

function var_0_0.GetPlayer(arg_21_0)
	return arg_21_0.player
end

function var_0_0.GetBlocks(arg_22_0)
	return arg_22_0.blocks
end

function var_0_0.SetCurrentLevel(arg_23_0, arg_23_1)
	if arg_23_1 > arg_23_0.level then
		arg_23_0:ActicveNextBlock(arg_23_1 + 1)
	elseif arg_23_1 < arg_23_0.level then
		arg_23_0:DeactiveAboveBlocks(arg_23_1 + 1)
	end

	arg_23_0.level = arg_23_1

	if arg_23_1 > arg_23_0.higestLevel then
		arg_23_0.higestLevel = arg_23_1

		arg_23_0.player:AddScore()
		arg_23_0:DoCheck(arg_23_1 - arg_23_0.higestLevel)
		arg_23_0:OverHigestScore()
	end

	return
end

function var_0_0.OverHigestScore(arg_24_0)
	if arg_24_0.player:IsOverHigestScore() and (function(arg_25_0)
		for iter_25_0, iter_25_1 in ipairs(arg_24_0.awards) do
			if arg_25_0 == iter_25_1 then
				return true
			end
		end

		return false
	end)(arg_24_0.player.score) then
		arg_24_0:SendMapEvent("OnReachAwardScore")
	end

	return
end

function var_0_0.DoCheck(arg_26_0, arg_26_1)
	if arg_26_0.higestLevel <= 1 then
		return
	end

	seriesAsync({
		function(arg_27_0)
			arg_26_0:AddNewBlock(arg_27_0)

			return
		end,
		function(arg_28_0)
			parallelAsync({
				function(arg_29_0)
					arg_26_0:DoSink(arg_26_0.higestLevel, arg_26_1, arg_29_0)

					return
				end,
				function(arg_30_0)
					arg_26_0:SendMapEvent("OnSink", TowerClimbingGameSettings.SINK_DISTANCE * arg_26_1, arg_30_0)

					return
				end
			}, arg_28_0)

			return
		end,
		function(arg_31_0)
			arg_26_0:CheckCorssBoundBlocks(arg_31_0)

			return
		end,
		function(arg_32_0)
			arg_26_0:CheckGroundState()
			arg_32_0()

			return
		end
	})

	return
end

function var_0_0.CheckGroundState(arg_33_0)
	if not arg_33_0.ground.IsRuning and arg_33_0.higestLevel >= TowerClimbingGameSettings.GROUND_RISE_UP_LEVEL then
		arg_33_0.ground.IsRuning = true

		arg_33_0:SendMapEvent("OnGroundRuning")
	end

	return
end

function var_0_0.ReBornPlayer(arg_34_0)
	for iter_34_0, iter_34_1 in ipairs(arg_34_0.blocks) do
		if iter_34_1.isActive then
			table.insert({}, iter_34_1)
		end
	end

	assert(#{} > 0)

	local var_34_1 = _.detect({}, function(arg_35_0)
		return arg_35_0.level == arg_34_0.higestLevel
	end)

	if not var_34_1 then
		table.sort({}, function(arg_36_0, arg_36_1)
			return arg_36_0.position.y > arg_36_1.position.y
		end)

		var_34_1 = ({})[1]
	end

	arg_34_0.player:SetPosition(var_34_1.position + Vector2(0, 10))

	return
end

function var_0_0.AddPlayerInvincibleEffect(arg_37_0, arg_37_1)
	for iter_37_0, iter_37_1 in ipairs(arg_37_0.blocks) do
		if iter_37_1.isActive then
			arg_37_0:SendMapEvent("OnEnableStab", iter_37_1, not arg_37_1)
		end
	end

	if arg_37_0.ground.IsRuning then
		arg_37_0:SendMapEvent("OnEnableGround", not arg_37_1)
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

function var_0_0.Update(arg_39_0)
	if arg_39_0.ground.sleepTime > 0 then
		arg_39_0.ground.sleepTime = arg_39_0.ground.sleepTime - Time.deltaTime

		arg_39_0:SendMapEvent("OnGroundSleepTimeChange", arg_39_0.ground.sleepTime)
	end

	if arg_39_0.ground.IsRuning and arg_39_0.ground.sleepTime <= 0 then
		arg_39_0.ground.position = Vector2(arg_39_0.ground.position.x, arg_39_0.ground.position.y + var_0_3(arg_39_0.higestLevel) * Time.deltaTime)

		arg_39_0:SendMapEvent("OnGroundPositionChange", arg_39_0.ground.position)
	end

	if arg_39_0.player:IsInvincible() then
		local var_39_0 = arg_39_0.player:GetInvincibleTime()

		if var_39_0 == TowerClimbingGameSettings.INVINCEIBLE_TIME then
			arg_39_0:AddPlayerInvincibleEffect(true)
		end

		arg_39_0.player:SetInvincibleTime(var_39_0 - Time.deltaTime)

		if not arg_39_0.player:IsInvincible() then
			arg_39_0:AddPlayerInvincibleEffect(false)
		end
	end

	return
end

function var_0_0.SetGroundSleep(arg_40_0, arg_40_1)
	if arg_40_0.ground.IsRuning then
		arg_40_0.ground.position = Vector2(arg_40_0.ground.position.x, arg_40_0.ground.position.y - TowerClimbingGameSettings.GROUND_SLIDE_DOWNWARD_DISTANCE)

		arg_40_0:SendMapEvent("OnGroundPositionChange", arg_40_0.ground.position)

		arg_40_0.ground.sleepTime = arg_40_1
	end

	return
end

function var_0_0.SendMapEvent(arg_41_0, arg_41_1, ...)
	arg_41_0.view.map[arg_41_1](arg_41_0.view.map, unpack({
		...
	}))

	return
end

function var_0_0.Dispose(arg_42_0)
	if arg_42_0.player then
		arg_42_0.player:Dispose()

		arg_42_0.player = nil
	end

	if arg_42_0.ground then
		arg_42_0.ground = nil
	end

	if arg_42_0.blocks then
		arg_42_0.blocks = nil
	end

	return
end

return var_0_0
