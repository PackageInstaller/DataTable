local var_0_0 = class("Responder")
local var_0_1 = {
	__index = function(arg_1_0, arg_1_1)
		arg_1_0[arg_1_1] = {}

		return arg_1_0[arg_1_1]
	end
}

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.binder = arg_2_1

	return
end

function var_0_0.reset(arg_3_0)
	if arg_3_0.map then
		for iter_3_0, iter_3_1 in pairs(arg_3_0.map) do
			underscore.each(iter_3_1, function(arg_4_0)
				Destroy(arg_4_0._tf)

				return
			end)
		end
	end

	arg_3_0.timeRiver = {}
	arg_3_0.fireList = {}
	arg_3_0.eventRange = {}
	arg_3_0.map = setmetatable({}, var_0_1)
	arg_3_0.findingResult = {}
	arg_3_0.reactorRyza = nil
	arg_3_0.enemyCount = 0

	return
end

function var_0_0.AddListener(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.eventRange[arg_5_1] = arg_5_0.eventRange[arg_5_1] or setmetatable({}, var_0_1)

	for iter_5_0, iter_5_1 in ipairs(arg_5_3) do
		table.insert(arg_5_0.eventRange[arg_5_1][tostring(arg_5_2.pos + iter_5_1)], arg_5_2)
	end

	return
end

function var_0_0.RemoveListener(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_3 then
		return
	end

	local var_6_0 = arg_6_0.eventRange[arg_6_1]

	for iter_6_0, iter_6_1 in ipairs(arg_6_3) do
		table.removebyvalue(var_6_0[tostring(arg_6_2.pos + iter_6_1)], arg_6_2)
	end

	return
end

local var_0_2 = {
	{
		0,
		1
	},
	{
		1,
		0
	},
	{
		0,
		-1
	},
	{
		-1,
		0
	}
}

function var_0_0.InRange(arg_7_0, arg_7_1)
	if arg_7_1.x < 0 or arg_7_1.y < 0 or arg_7_1.x >= arg_7_0.binder.config.mapSize.x or arg_7_1.y >= arg_7_0.binder.config.mapSize.y then
		return false
	else
		return true
	end

	return
end

function var_0_0.GetCrossFire(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0, iter_8_1 in ipairs(var_0_2) do
		for iter_8_2 = 1, arg_8_2 do
			local var_8_0 = arg_8_0:GetFirePassability(arg_8_1 + NewPos(unpack(iter_8_1)) * iter_8_2)

			if var_8_0 < 2 then
				({
					0,
					0,
					0,
					0
				})[iter_8_0] = iter_8_2
			end

			if var_8_0 > 0 then
				break
			end
		end
	end

	for iter_8_3, iter_8_4 in ipairs(arg_8_0.timeRiver) do
		if isa(iter_8_4, EnemyConductor) then
			iter_8_4:CheckBlock(arg_8_1, {
				0,
				0,
				0,
				0
			}, {})
		end
	end

	for iter_8_5, iter_8_6 in ipairs(var_0_2) do
		for iter_8_7 = 1, ({
			0,
			0,
			0,
			0
		})[iter_8_5] do
			table.insert({
				{
					0,
					0
				}
			}, {
				iter_8_6[1] * iter_8_7,
				iter_8_6[2] * iter_8_7
			})
		end
	end

	return {
		0,
		0,
		0,
		0
	}, {
		{
			0,
			0
		}
	}, {}
end

function var_0_0.getRangeList(arg_9_0, arg_9_1, arg_9_2)
	return underscore.map(arg_9_2, function(arg_10_0)
		return arg_9_1.pos + NewPos(unpack(arg_10_0))
	end)
end

function var_0_0.EventCall(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if isa(arg_11_4, Reactor) then
		if arg_11_4 == MoveRyza then
			arg_11_0.reactorRyza:React(arg_11_1, arg_11_2)
		else
			arg_11_4:React(arg_11_1, arg_11_2)
		end
	else
		if not arg_11_0.eventRange[arg_11_1] then
			return
		end

		for iter_11_0, iter_11_1 in ipairs(arg_11_0:getRangeList(arg_11_3, arg_11_4)) do
			for iter_11_2, iter_11_3 in ipairs(underscore.rest(var_11_0[tostring(iter_11_1)], 1)) do
				iter_11_3:React(arg_11_1, arg_11_2)
			end
		end
	end

	return
end

function var_0_0.CreateCall(arg_12_0, arg_12_1)
	table.insert(arg_12_0.map[tostring(arg_12_1.pos)], arg_12_1)

	if arg_12_1:InTimeRiver() then
		table.insert(arg_12_0.timeRiver, arg_12_1)
	end

	if isa(arg_12_1, MoveRyza) then
		arg_12_0.reactorRyza = arg_12_1
	elseif isa(arg_12_1, MoveEnemy) then
		arg_12_0.enemyCount = defaultValue(arg_12_0.enemyCount, 0) + 1
	elseif isa(arg_12_1, EffectFire) then
		table.insert(arg_12_0.fireList, arg_12_1)
	end

	return
end

function var_0_0.DestroyCall(arg_13_0, arg_13_1, arg_13_2)
	table.removebyvalue(arg_13_0.map[tostring(arg_13_1.pos)], arg_13_1)

	if arg_13_1:InTimeRiver() then
		table.removebyvalue(arg_13_0.timeRiver, arg_13_1)
	end

	arg_13_0.binder:emit(RyzaMiniGameView.EVENT_DESTROY, arg_13_1, arg_13_2)

	if isa(arg_13_1, MoveEnemy) then
		arg_13_0.enemyCount = arg_13_0.enemyCount - 1

		if arg_13_0.enemyCount == 0 then
			arg_13_0:GameFinish(true)
		end
	elseif isa(arg_13_1, EffectFire) then
		table.removebyvalue(arg_13_0.fireList, arg_13_1)
	end

	return
end

function var_0_0.GetCellPassability(arg_14_0, arg_14_1)
	if not arg_14_0:InRange(arg_14_1) then
		return false
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.map[tostring(arg_14_1)]) do
		if not iter_14_1:CellPassability() then
			return false, iter_14_1
		end
	end

	return true
end

function var_0_0.GetFirePassability(arg_15_0, arg_15_1)
	if not arg_15_0:InRange(arg_15_1) then
		return 2
	end

	return underscore.reduce(arg_15_0.map[tostring(arg_15_1)], 0, function(arg_16_0, arg_16_1)
		return math.max(arg_16_0, arg_16_1:FirePassability())
	end)
end

function var_0_0.GetCellCanBomb(arg_17_0, arg_17_1)
	if not arg_17_0:InRange(arg_17_1) then
		return false
	end

	return underscore.all(arg_17_0.map[tostring(arg_17_1)], function(arg_18_0)
		return not isa(arg_18_0, ObjectBomb)
	end)
end

function var_0_0.TimeFlow(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.timeRiver) do
		iter_19_1:TimeUpdate(arg_19_1)
	end

	return
end

function var_0_0.Create(arg_20_0, arg_20_1)
	arg_20_0.binder:emit(RyzaMiniGameView.EVENT_CREATE, arg_20_1)

	return
end

function var_0_0.GetJoyStick(arg_21_0)
	return NewPos(arg_21_0.binder.uiMgr.hrz, -arg_21_0.binder.uiMgr.vtc)
end

function var_0_0.RyzaBomb(arg_22_0)
	arg_22_0.reactorRyza:SetBomb()

	return
end

function var_0_0.GameFinish(arg_23_0, arg_23_1)
	arg_23_0.binder:emit(RyzaMiniGameView.EVENT_FINISH, arg_23_1)

	return
end

function var_0_0.WindowFocrus(arg_24_0, arg_24_1)
	arg_24_0.binder:emit(RyzaMiniGameView.EVENT_WINDOW_FOCUS, arg_24_1)

	return
end

function var_0_0.SyncStatus(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_0.binder:emit(RyzaMiniGameView.EVENT_STATUS_SYNC, arg_25_1, arg_25_2, arg_25_3)

	return
end

function var_0_0.UpdateHide(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0.binder:emit(RyzaMiniGameView.EVENT_UPDATE_HIDE, arg_26_1, arg_26_2)

	return
end

function var_0_0.UpdatePos(arg_27_0, arg_27_1, arg_27_2)
	table.removebyvalue(arg_27_0.map[tostring(arg_27_1.pos)], arg_27_1)
	table.insert(arg_27_0.map[tostring(arg_27_2)], arg_27_1)

	return
end

local function var_0_3(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.range) do
		for iter_28_2, iter_28_3 in ipairs(arg_28_1.range) do
			for iter_28_4, iter_28_5 in ipairs(iter_28_1) do
				({
					{},
					{}
				})[iter_28_4][1] = iter_28_5[1] - iter_28_3[iter_28_4][2]
				;({
					{},
					{}
				})[iter_28_4][2] = iter_28_5[2] - iter_28_3[iter_28_4][1]
			end

			if (arg_28_1.pos - arg_28_0.pos).x > ({
				{},
				{}
			})[1][1] and (arg_28_1.pos - arg_28_0.pos).x < ({
				{},
				{}
			})[1][2] and (arg_28_1.pos - arg_28_0.pos).y > ({
				{},
				{}
			})[2][1] and (arg_28_1.pos - arg_28_0.pos).y < ({
				{},
				{}
			})[2][2] then
				return true
			end
		end
	end

	return false
end

function var_0_0.Wayfinding(arg_29_0, arg_29_1)
	if arg_29_0.reactorRyza.hide or arg_29_0:CollideRyza(arg_29_1) then
		arg_29_0.findingResult[arg_29_1] = nil

		return {
			arg_29_0.realPos
		}
	elseif arg_29_0.findingResult[arg_29_1] then
		if arg_29_0.findingResult[arg_29_1].ryzaPos == arg_29_0.reactorRyza.pos and arg_29_0.findingResult[arg_29_1].reactorPos == arg_29_1.pos then
			return arg_29_0.findingResult[arg_29_1].path
		else
			arg_29_0.findingResult[arg_29_1] = nil
		end
	end

	local var_29_0 = {
		arg_29_1.pos
	}
	local var_29_1 = {
		[tostring(arg_29_1.pos)] = 0
	}
	local var_29_2 = 0

	while var_29_2 < #var_29_0 do
		var_29_2 = var_29_2 + 1

		for iter_29_0, iter_29_1 in ipairs(var_0_2) do
			local var_29_4 = var_29_0[var_29_2] + NewPos(unpack(iter_29_1))

			if var_29_1[tostring(var_29_4)] == nil then
				if arg_29_0:GetCellPassability(var_29_4) then
					var_29_1[tostring(var_29_4)] = var_29_2

					table.insert(var_29_0, var_29_4)

					if var_0_3({
						pos = arg_29_0.reactorRyza.realPos,
						range = arg_29_0.reactorRyza:GetCollideRange()
					}, {
						pos = var_29_4,
						range = arg_29_1:GetCollideRange()
					}) then
						return (function(arg_30_0)
							while var_29_1[tostring(var_29_0[arg_30_0])] > 0 do
								table.insert({}, var_29_0[arg_30_0])

								arg_30_0 = var_29_1[tostring(var_29_0[arg_30_0])]
							end

							arg_29_0.findingResult[arg_29_1] = {
								ryzaPos = arg_29_0.reactorRyza.pos,
								reactorPos = arg_29_1.pos,
								path = {}
							}

							return {}
						end)(#var_29_0)
					end
				else
					var_29_1[tostring(var_29_4)] = false
				end
			end
		end

		for iter_29_2, iter_29_3 in ipairs(var_0_2) do
			local var_29_5 = NewPos(unpack(iter_29_3))
			local var_29_6 = NewPos(unpack(var_0_2[iter_29_2 % 4 + 1]))

			if var_29_1[tostring(var_29_0[var_29_2] + var_29_5)] and var_29_1[tostring(var_29_0[var_29_2] + var_29_6)] and var_29_1[tostring(var_29_0[var_29_2] + var_29_5 + var_29_6)] == nil and arg_29_0:GetCellPassability(var_29_0[var_29_2] + var_29_5 + var_29_6) then
				var_29_1[tostring(var_29_0[var_29_2] + var_29_5 + var_29_6)] = var_29_2

				table.insert(var_29_0, var_29_0[var_29_2] + var_29_5 + var_29_6)

				if var_0_3({
					pos = arg_29_0.reactorRyza.realPos,
					range = arg_29_0.reactorRyza:GetCollideRange()
				}, {
					pos = var_29_0[var_29_2] + var_29_5 + var_29_6,
					range = arg_29_1:GetCollideRange()
				}) then
					return (function(arg_30_0)
						while var_29_1[tostring(var_29_0[arg_30_0])] > 0 do
							table.insert({}, var_29_0[arg_30_0])

							arg_30_0 = var_29_1[tostring(var_29_0[arg_30_0])]
						end

						arg_29_0.findingResult[arg_29_1] = {
							ryzaPos = arg_29_0.reactorRyza.pos,
							reactorPos = arg_29_1.pos,
							path = {}
						}

						return {}
					end)(#var_29_0)
				end
			end
		end
	end

	return
end

function var_0_0.SearchRyza(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_0.reactorRyza.hide then
		return false
	else
		return (var_31_0 - arg_31_0.reactorRyza.realPos):SqrMagnitude() < arg_31_2 * arg_31_2
	end

	return
end

function var_0_0.CollideRyza(arg_32_0, arg_32_1)
	return var_0_3({
		pos = arg_32_0.reactorRyza.realPos,
		range = arg_32_0.reactorRyza:GetCollideRange()
	}, {
		pos = arg_32_1.realPos,
		range = arg_32_1:GetCollideRange()
	})
end

function var_0_0.CollideFire(arg_33_0, arg_33_1)
	return underscore.filter(arg_33_0.fireList, function(arg_34_0)
		return var_0_3({
			pos = arg_34_0.pos,
			range = arg_34_0:GetCollideRange()
		}, {
			pos = arg_33_1.realPos,
			range = arg_33_1:GetCollideRange()
		})
	end)
end

return var_0_0
