local var_0_0 = class("PacGameEnemyController")

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
	arg_3_0._player = arg_3_0._runningData:GetPlayer()
	arg_3_0._enemys = arg_3_0._runningData:GetEnemys()
	arg_3_0._gridDic = arg_3_0._runningData:GetGridDic()
	arg_3_0._rateTime = PacGameConst.difficult_time

	return
end

function var_0_0.Step(arg_4_0, arg_4_1)
	arg_4_0._deltaTime = arg_4_1

	local var_4_0 = false

	if arg_4_0._rateTime and arg_4_0._rateTime > 0 then
		arg_4_0._rateTime = arg_4_0._rateTime - arg_4_1

		if arg_4_0._rateTime <= 0 then
			arg_4_0._rateTime = PacGameConst.difficult_time
			var_4_0 = true
		end
	end

	for iter_4_0 = 1, #arg_4_0._enemys do
		arg_4_0:setEnemyAutoData(arg_4_0._enemys[iter_4_0], arg_4_0._player)
		arg_4_0:checkEnemyHit(arg_4_0._enemys[iter_4_0], arg_4_0._player)

		if var_4_0 then
			arg_4_0._enemys[iter_4_0]:SetRateAdd()
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
	local var_9_0 = arg_9_1:GetAutoState()

	if not var_9_0 then
		return
	end

	if not arg_9_0:getEnemySetRoadAble(arg_9_1, arg_9_2:GetGridIndex()) then
		return
	end

	local var_9_1 = arg_9_1:GetGridIndex()

	if arg_9_2:GetRush() then
		local var_9_2 = arg_9_2:GetGridIndex()

		;({})[var_9_2] = {
			var_9_2
		}

		local var_9_3 = arg_9_0:getTargetRoadByCount({
			var_9_2
		}, {}, 1, 5)
		local var_9_4 = arg_9_0:getEnemyTargetRoad(arg_9_1, (arg_9_0:getTargetMatchCountRandom({}, 6)))

		if var_9_4 and var_9_4[var_9_1] then
			arg_9_0:setEnemyRoad(arg_9_1, var_9_4[var_9_1], 3)
		end
	elseif var_9_0 == 1 then
		local var_9_5 = arg_9_0:getEnemyTargetRoad(arg_9_1, arg_9_0._player:GetGridIndex())

		if var_9_5 and var_9_5[var_9_1] then
			arg_9_0:setEnemyRoad(arg_9_1, var_9_5[var_9_1], 4)
		end
	elseif var_9_0 == 2 then
		local var_9_6 = arg_9_2:GetGridIndex()

		;({})[var_9_6] = {
			var_9_6
		}

		local var_9_7 = arg_9_0:getTargetRoadByCount({
			var_9_6
		}, {}, 1, 3)
		local var_9_8 = arg_9_0:getEnemyTargetRoad(arg_9_1, (arg_9_0:getTargetMatchCountRandom({}, 4)))

		if var_9_8 and var_9_8[var_9_1] then
			arg_9_0:setEnemyRoad(arg_9_1, var_9_8[var_9_1], 4)
		end
	elseif var_9_0 == 3 then
		local var_9_9 = arg_9_2:GetGridIndex()

		;({})[var_9_9] = {
			var_9_9
		}

		local var_9_10 = arg_9_0:getTargetRoadByCount({
			var_9_9
		}, {}, 1, 4)
		local var_9_11 = arg_9_0:getEnemyTargetRoad(arg_9_1, (arg_9_0:getTargetMatchCountRandom({}, 5)))

		if var_9_11 and var_9_11[var_9_1] then
			arg_9_0:setEnemyRoad(arg_9_1, var_9_11[var_9_1], 4)
		end
	elseif var_9_0 == 4 then
		if arg_9_1:GetRoadBack() then
			local var_9_12 = arg_9_2:GetGridIndex()

			;({})[var_9_12] = {
				var_9_12
			}

			local var_9_13 = arg_9_0:getTargetRoadByCount({
				var_9_12
			}, {}, 1, 5)
			local var_9_14 = arg_9_0:getEnemyTargetRoad(arg_9_1, (arg_9_0:getTargetMatchCountRandom({}, 6)))

			if var_9_14 and var_9_14[var_9_1] then
				arg_9_0:setEnemyRoad(arg_9_1, var_9_14[var_9_1], 0)
			end

			arg_9_1:SetRoadBack(false)
		else
			local var_9_15 = arg_9_0:getEnemyTargetRoad(arg_9_1, arg_9_1:GetStartIndex())

			if var_9_15 and var_9_15[var_9_1] then
				arg_9_0:setEnemyRoad(arg_9_1, var_9_15[var_9_1], 4)
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

	local var_10_0 = arg_10_1:GetPosition()
	local var_10_1 = arg_10_2:GetPosition()

	if math.abs(var_10_0.x - var_10_1.x) <= 30 and math.abs(var_10_0.y - var_10_1.y) <= 30 then
		if not arg_10_2:GetRush() then
			arg_10_0._event(PacGameScene.HIT_PLAYER, nil, nil)
		else
			if arg_10_1:GetTarget() then
				arg_10_1:SetGridIndex(arg_10_1:GetTargetIndex())
				arg_10_1:SetTarget(nil)
			end

			arg_10_1:SetRoads({})

			local var_10_2 = arg_10_1:GetStartIndex()
			local var_10_3 = arg_10_0:getEnemyTargetRoad(arg_10_1, arg_10_1:GetStartIndex())

			if var_10_3 and var_10_3[arg_10_1:GetGridIndex()] then
				arg_10_0:setEnemyRoad(arg_10_1, var_10_3[arg_10_1:GetGridIndex()], 0)
				arg_10_1:SetBackStart(true)
			else
				arg_10_1:SetPosition(arg_10_0._gridDic[arg_10_1:GetStartIndex()]:GetPosition())
				arg_10_1:SetBackStart(true)
				arg_10_1:SetHangAction()
				arg_10_1:SetGridIndex(arg_10_1:GetStartIndex())
			end
		end
	end

	return
end

function var_0_0.getTargetMatchCountRandom(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		if #iter_11_1 == arg_11_2 then
			table.insert({}, iter_11_1[#iter_11_1])
		end
	end

	return ({})[math.random(1, #{})]
end

function var_0_0.getEnemyTargetRoad(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 and arg_12_0:getEnemySetRoadAble(arg_12_1, arg_12_2) then
		arg_12_0:calcRoad({
			arg_12_2
		}, arg_12_2, {
			[arg_12_2] = {
				arg_12_2
			}
		}, 1)

		return {
			[arg_12_2] = {
				arg_12_2
			}
		}
	end

	return {}
end

function var_0_0.getEnemySetRoadAble(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1:GetRoads()

	if var_13_0 and #var_13_0 == 0 and not arg_13_1:HasTarget() and not arg_13_1:GetBackStart() and arg_13_2 ~= arg_13_1:GetGridIndex() then
		return true
	end

	return false
end

function var_0_0.getTargetRoadByCount(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if arg_14_4 < arg_14_3 then
		return arg_14_2
	end

	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_1 = arg_14_0._runningData:GetNearGridIndex(iter_14_1)
		local var_14_2 = arg_14_0:getLastIndexWithFrom(iter_14_1, arg_14_2)

		for iter_14_2 = 1, #var_14_1 do
			local var_14_3 = true
			local var_14_4 = arg_14_0:getLastIndexWithFrom(var_14_1[iter_14_2], arg_14_2)

			if var_14_4 and #var_14_4 > 0 then
				var_14_3 = false
			end

			if var_14_3 then
				local var_14_5 = Clone(var_14_2)

				table.insert(var_14_5, var_14_1[iter_14_2])

				arg_14_2[var_14_1[iter_14_2]] = var_14_5

				table.insert(var_14_0, var_14_1[iter_14_2])
			end
		end
	end

	if #var_14_0 > 0 then
		arg_14_0:getTargetRoadByCount(var_14_0, arg_14_2, arg_14_3 + 1, arg_14_4)
	end

	return arg_14_2
end

function var_0_0.calcRoad(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_0 = arg_15_0._runningData:GetNearGridIndex(iter_15_1)
		local var_15_1 = arg_15_0:getLastIndexWithFrom(iter_15_1, arg_15_3)

		for iter_15_2 = 1, #var_15_0 do
			local var_15_2 = true
			local var_15_3 = arg_15_0:getLastIndexWithFrom(var_15_0[iter_15_2], arg_15_3)

			if var_15_3 and #var_15_3 > 0 then
				var_15_2 = false
			end

			if var_15_2 then
				local var_15_4 = Clone(var_15_1)

				table.insert(var_15_4, var_15_0[iter_15_2])

				arg_15_3[var_15_0[iter_15_2]] = var_15_4

				table.insert({}, var_15_0[iter_15_2])

				if var_15_0[iter_15_2] == arg_15_2 then
					return
				end
			end
		end
	end

	if #{} > 0 then
		arg_15_0:calcRoad({}, arg_15_2, arg_15_3, arg_15_4 + 1)
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

	for iter_17_0 = #arg_17_2, 1, -1 do
		if arg_17_2[iter_17_0] ~= var_17_0 then
			table.insert({}, arg_17_2[iter_17_0])

			local var_17_1 = arg_17_0._runningData:GetNearGridIndex(arg_17_2[iter_17_0])

			if arg_17_3 and arg_17_3 > 0 and var_17_1 and arg_17_3 <= #var_17_1 then
				break
			end
		end
	end

	arg_17_1:SetRoads({})

	return
end

return var_0_0
