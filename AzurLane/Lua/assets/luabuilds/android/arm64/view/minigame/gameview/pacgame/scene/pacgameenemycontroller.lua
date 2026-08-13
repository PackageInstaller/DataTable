class = var_0_10000

local var_0_0 = var_0_10000("PacGameEnemyController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneMask = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._runningData = arg_1_3

	return
end

function var_0_0.Prepare(arg_2_0)
	return
end

function var_0_0.Start(arg_3_0)
	local var_3_0 = arg_3_0._runningData

	arg_3_0._player = var_1.GetPlayer(var_3_0)

	local var_3_1 = arg_3_0._runningData

	arg_3_0._enemys = var_1.GetEnemys(var_3_1)

	local var_3_2 = arg_3_0._runningData

	arg_3_0._gridDic = var_1.GetGridDic(var_3_2)
	PacGameConst = var_1
	arg_3_0._rateTime = var_1.difficult_time

	return
end

function var_0_0.Step(arg_4_0, arg_4_1)
	arg_4_0._deltaTime = arg_4_1

	local var_4_0 = false

	if arg_4_0._rateTime and arg_4_0._rateTime > 0 then
		arg_4_0._rateTime = arg_4_0._rateTime - arg_4_1

		if arg_4_0._rateTime <= 0 then
			PacGameConst = var_3
			arg_4_0._rateTime = var_3.difficult_time
			var_4_0 = true
		end
	end

	for iter_4_0 = 1, #arg_4_0._enemys do
		local var_4_1 = arg_4_0._enemys[iter_4_0]

		arg_4_0:setEnemyAutoData(var_4_1, arg_4_0._player)
		arg_4_0:checkEnemyHit(var_4_1, arg_4_0._player)

		if var_4_0 then
			var_4_1:SetRateAdd()
		end
	end

	return
end

function var_0_0.Clear(arg_5_0)
	return
end

function var_0_0.Stop(arg_6_0)
	return
end

function var_0_0.Resume(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	return
end

function var_0_0.setEnemyAutoData(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_1:GetAutoState() then
		return
	end

	if not arg_9_0:getEnemySetRoadAble(arg_9_1, arg_9_2:GetGridIndex()) then
		return
	end

	local var_9_0 = arg_9_1:GetGridIndex()

	if arg_9_2:GetRush() then
		local var_9_1 = arg_9_2:GetGridIndex()
		local var_9_2 = {
			[var_9_1] = {
				var_9_1
			}
		}
		local var_9_3 = arg_9_0:getTargetRoadByCount({
			var_9_1
		}, var_9_2, 1, 5)
		local var_9_4 = arg_9_0:getTargetMatchCountRandom(var_9_2, 6)

		if arg_9_0:getEnemyTargetRoad(arg_9_1, var_9_4) and var_9[var_9_0] then
			local var_9_5 = var_9[var_9_0]

			arg_9_0:setEnemyRoad(arg_9_1, var_9_5, 3)
		end
	elseif var_3 == 1 then
		local var_9_6 = arg_9_0
		local var_9_7 = arg_9_0.getEnemyTargetRoad
		local var_9_8 = arg_9_1
		local var_9_9 = arg_9_0._player

		if var_9_7(var_9_6, var_9_8, var_9.GetGridIndex(var_9_9)) and var_5[var_9_0] then
			local var_9_10 = var_5[var_9_0]

			arg_9_0:setEnemyRoad(arg_9_1, var_9_10, 4)
		end
	elseif var_3 == 2 then
		local var_9_11 = arg_9_2:GetGridIndex()
		local var_9_12 = {
			[var_9_11] = {
				var_9_11
			}
		}
		local var_9_13 = arg_9_0:getTargetRoadByCount({
			var_9_11
		}, var_9_12, 1, 3)
		local var_9_14 = arg_9_0:getTargetMatchCountRandom(var_9_12, 4)

		if arg_9_0:getEnemyTargetRoad(arg_9_1, var_9_14) and var_9[var_9_0] then
			local var_9_15 = var_9[var_9_0]

			arg_9_0:setEnemyRoad(arg_9_1, var_9_15, 4)
		end
	elseif var_3 == 3 then
		local var_9_16 = arg_9_2:GetGridIndex()
		local var_9_17 = {
			[var_9_16] = {
				var_9_16
			}
		}
		local var_9_18 = arg_9_0:getTargetRoadByCount({
			var_9_16
		}, var_9_17, 1, 4)
		local var_9_19 = arg_9_0:getTargetMatchCountRandom(var_9_17, 5)

		if arg_9_0:getEnemyTargetRoad(arg_9_1, var_9_19) and var_9[var_9_0] then
			local var_9_20 = var_9[var_9_0]

			arg_9_0:setEnemyRoad(arg_9_1, var_9_20, 4)
		end
	elseif var_3 == 4 then
		if arg_9_1:GetRoadBack() then
			local var_9_21 = arg_9_2:GetGridIndex()
			local var_9_22 = {
				[var_9_21] = {
					var_9_21
				}
			}
			local var_9_23 = arg_9_0:getTargetRoadByCount({
				var_9_21
			}, var_9_22, 1, 5)
			local var_9_24 = arg_9_0:getTargetMatchCountRandom(var_9_22, 6)

			if arg_9_0:getEnemyTargetRoad(arg_9_1, var_9_24) and var_9[var_9_0] then
				local var_9_25 = var_9[var_9_0]

				arg_9_0:setEnemyRoad(arg_9_1, var_9_25, 0)
			end

			arg_9_1:SetRoadBack(false)
		else
			if arg_9_0:getEnemyTargetRoad(arg_9_1, arg_9_1:GetStartIndex()) and var_5[var_9_0] then
				local var_9_26 = var_5[var_9_0]

				arg_9_0:setEnemyRoad(arg_9_1, var_9_26, 4)
			end

			arg_9_1:SetRoadBack(true)
		end
	end

	return
end

function var_0_0.checkEnemyHit(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1:GetBackStart() then
		return
	end

	local var_10_0 = arg_10_1
	local var_10_1 = arg_10_1.GetPosition(var_10_0)
	local var_10_2 = arg_10_2:GetPosition()

	math = var_10_0

	if var_10_0.abs(var_10_1.x - var_10_2.x) <= 30 then
		math = var_5

		if var_5.abs(var_10_1.y - var_10_2.y) <= 30 then
			if not arg_10_2:GetRush() then
				local var_10_3 = arg_10_0._event

				PacGameScene = var_8

				var_10_3(var_8.HIT_PLAYER, nil, nil)
			else
				if arg_10_1:GetTarget() then
					arg_10_1:SetGridIndex(arg_10_1:GetTargetIndex())
					arg_10_1:SetTarget(nil)
				end

				arg_10_1:SetRoads({})

				local var_10_4 = arg_10_1:GetStartIndex()

				if arg_10_0:getEnemyTargetRoad(arg_10_1, arg_10_1:GetStartIndex()) and var_7[arg_10_1:GetGridIndex()] then
					local var_10_5 = var_7[arg_10_1:GetGridIndex()]

					arg_10_0:setEnemyRoad(arg_10_1, var_10_5, 0)
					arg_10_1:SetBackStart(true)
				else
					local var_10_6 = arg_10_1
					local var_10_7 = arg_10_1.SetPosition
					local var_10_8 = arg_10_0._gridDic[arg_10_1:GetStartIndex()]

					var_10_7(var_10_6, var_11.GetPosition(var_10_8))
					arg_10_1:SetBackStart(true)
					arg_10_1:SetHangAction()
					arg_10_1:SetGridIndex(arg_10_1:GetStartIndex())
				end
			end
		end
	end

	return
end

function var_0_0.getTargetMatchCountRandom(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}

	pairs = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10004(arg_11_1) do
		if #iter_11_1 == arg_11_2 then
			table = var_9

			var_9.insert(var_11_0, iter_11_1[#iter_11_1])
		end
	end

	math = var_4

	return var_11_0[var_4.random(1, #var_11_0)]
end

function var_0_0.getEnemyTargetRoad(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 and arg_12_0:getEnemySetRoadAble(arg_12_1, arg_12_2) then
		local var_12_0 = {
			[arg_12_2] = {
				arg_12_2
			}
		}

		arg_12_0:calcRoad({
			arg_12_2
		}, arg_12_2, var_12_0, 1)

		return var_12_0
	end

	return {}
end

function var_0_0.getEnemySetRoadAble(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1:GetRoads()
	local var_13_1 = arg_13_1:HasTarget()
	local var_13_2 = arg_13_1:GetBackStart()
	local var_13_3 = arg_13_1:GetGridIndex()

	if var_13_0 and #var_13_0 == 0 and not var_13_1 and not var_13_2 and arg_13_2 ~= var_13_3 then
		return true
	end

	return false
end

function var_0_0.getTargetRoadByCount(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if arg_14_4 < arg_14_3 then
		return arg_14_2
	end

	local var_14_0 = {}

	ipairs = var_1_10006

	for iter_14_0, iter_14_1 in var_1_10006(arg_14_1) do
		local var_14_1 = arg_14_0._runningData
		local var_14_2 = var_11.GetNearGridIndex(var_14_1, iter_14_1)
		local var_14_3 = arg_14_0:getLastIndexWithFrom(iter_14_1, arg_14_2)

		for iter_14_2 = 1, #var_14_2 do
			local var_14_4 = var_14_2[iter_14_2]
			local var_14_5 = true
			local var_14_6 = arg_14_0

			if arg_14_0.getLastIndexWithFrom(var_14_6, var_14_2[iter_14_2], arg_14_2) then
				var_1_10020 = #var_19

				if 0 < var_1_10020 then
					var_14_5 = false
				end
			end

			if var_14_5 then
				Clone = var_1_10020
				var_1_10020 = var_1_10020(var_14_3)
				table = var_14_6

				var_14_6.insert(var_1_10020, var_14_4)

				arg_14_2[var_14_4] = var_1_10020
				table = var_21

				var_21.insert(var_14_0, var_14_4)
			end
		end
	end

	if #var_14_0 > 0 then
		arg_14_0:getTargetRoadByCount(var_14_0, arg_14_2, arg_14_3 + 1, arg_14_4)
	end

	return arg_14_2
end

function var_0_0.calcRoad(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = {}

	ipairs = var_1_10006

	for iter_15_0, iter_15_1 in var_1_10006(arg_15_1) do
		local var_15_1 = arg_15_0._runningData
		local var_15_2 = var_11.GetNearGridIndex(var_15_1, iter_15_1)
		local var_15_3 = arg_15_0:getLastIndexWithFrom(iter_15_1, arg_15_3)

		for iter_15_2 = 1, #var_15_2 do
			local var_15_4 = var_15_2[iter_15_2]
			local var_15_5 = true
			local var_15_6 = arg_15_0

			if arg_15_0.getLastIndexWithFrom(var_15_6, var_15_2[iter_15_2], arg_15_3) then
				var_1_10020 = #var_19

				if 0 < var_1_10020 then
					var_15_5 = false
				end
			end

			if var_15_5 then
				Clone = var_1_10020
				var_1_10020 = var_1_10020(var_15_3)
				table = var_15_6

				var_15_6.insert(var_1_10020, var_15_4)

				arg_15_3[var_15_4] = var_1_10020
				table = var_21

				var_21.insert(var_15_0, var_15_4)

				if var_15_4 == arg_15_2 then
					return
				end
			end
		end
	end

	if #var_15_0 > 0 then
		arg_15_0:calcRoad(var_15_0, arg_15_2, arg_15_3, arg_15_4 + 1)
	end

	return
end

function var_0_0.getLastIndexWithFrom(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2[arg_16_1] then
		return arg_16_2[arg_16_1]
	end

	return nil
end

function var_0_0.setEnemyRoad(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_1:GetGridIndex()
	local var_17_1 = {}

	for iter_17_0 = #arg_17_2, 1, -1 do
		if arg_17_2[iter_17_0] ~= var_17_0 then
			table = var_1_10011

			var_1_10011.insert(var_17_1, var_10)

			local var_17_2 = arg_17_0._runningData

			var_1_10011 = var_1_10011.GetNearGridIndex(var_17_2, var_10)

			if arg_17_3 and arg_17_3 > 0 and var_1_10011 and arg_17_3 <= #var_1_10011 then
				break
			end
		end
	end

	arg_17_1:SetRoads(var_17_1)

	return
end

return var_0_0
