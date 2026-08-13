class = var_0_10000

local var_0_0 = var_0_10000("Responder")
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
		pairs = var_1

		for iter_3_0, iter_3_1 in var_1(arg_3_0.map) do
			underscore = var_1_10006

			var_1_10006.each(iter_3_1, function(arg_4_0)
				Destroy = var_2_10001

				var_2_10001(arg_4_0._tf)

				return
			end)
		end
	end

	arg_3_0.timeRiver = {}
	arg_3_0.fireList = {}
	arg_3_0.eventRange = {}
	setmetatable = var_1
	arg_3_0.map = var_1({}, var_0_1)
	arg_3_0.findingResult = {}
	arg_3_0.reactorRyza = nil
	arg_3_0.enemyCount = 0

	return
end

function var_0_0.AddListener(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0.eventRange
	local var_5_1

	if not arg_5_0.eventRange[arg_5_1] then
		setmetatable = var_5_1
		var_5_1 = var_5_1({}, var_0_1)
	end

	var_5_0[arg_5_1] = var_5_1

	local var_5_2 = arg_5_0.eventRange[arg_5_1]

	ipairs = var_5_1

	for iter_5_0, iter_5_1 in var_5_1(arg_5_3) do
		table = var_1_10010
		var_1_10010 = var_1_10010.insert
		tostring = var_1_10012

		var_1_10010(var_5_2[var_1_10012(arg_5_2.pos + iter_5_1)], arg_5_2)
	end

	return
end

function var_0_0.RemoveListener(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_3 then
		return
	end

	local var_6_0 = arg_6_0.eventRange[arg_6_1]

	ipairs = var_1_10005

	for iter_6_0, iter_6_1 in var_1_10005(arg_6_3) do
		table = var_1_10010
		var_1_10010 = var_1_10010.removebyvalue
		tostring = var_1_10012

		var_1_10010(var_6_0[var_1_10012(arg_6_2.pos + iter_6_1)], arg_6_2)
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
	local var_7_0 = arg_7_0.binder.config.mapSize

	if arg_7_1.x < 0 or arg_7_1.y < 0 or arg_7_1.x >= var_7_0.x or arg_7_1.y >= var_7_0.y then
		return false
	else
		return true
	end

	return
end

function var_0_0.GetCrossFire(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		0,
		0,
		0,
		0
	}

	ipairs = var_1_10004

	for iter_8_0, iter_8_1 in var_1_10004(var_0_2) do
		for iter_8_2 = 1, arg_8_2 do
			NewPos = var_1_10013
			unpack = var_1_10015
			var_1_10013 = arg_8_1 + var_1_10013(var_1_10015(iter_8_1)) * iter_8_2

			if arg_8_0:GetFirePassability(var_1_10013) < 2 then
				var_8_0[iter_8_0] = iter_8_2
			end

			if 0 < var_14 then
				break
			end
		end
	end

	local var_8_1 = {}

	ipairs = var_5

	for iter_8_3, iter_8_4 in var_5(arg_8_0.timeRiver) do
		isa = var_1_10010

		local var_8_2 = iter_8_4

		EnemyConductor = var_1_10013

		if var_1_10010(var_8_2, var_1_10013) then
			iter_8_4:CheckBlock(arg_8_1, var_8_0, var_8_1)
		end
	end

	local var_8_3 = {
		{
			0,
			0
		}
	}

	ipairs = var_6

	for iter_8_5, iter_8_6 in var_6(var_0_2) do
		for iter_8_7 = 1, var_8_0[iter_8_5] do
			table = var_1_10015

			var_1_10015.insert(var_8_3, {
				iter_8_6[1] * iter_8_7,
				iter_8_6[2] * iter_8_7
			})
		end
	end

	return var_8_0, var_8_3, var_8_1
end

function var_0_0.getRangeList(arg_9_0, arg_9_1, arg_9_2)
	underscore = var_1_10003

	return var_1_10003.map(arg_9_2, function(arg_10_0)
		local var_10_0 = arg_9_1.pos

		NewPos = var_2_10002
		unpack = var_2_10004

		return var_10_0 + var_2_10002(var_2_10004(arg_10_0))
	end)
end

function var_0_0.EventCall(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	isa = var_1_10005

	local var_11_0 = arg_11_4

	Reactor = var_1_10008

	if var_1_10005(var_11_0, var_1_10008) then
		MoveRyza = var_5

		if arg_11_4 == var_5 then
			local var_11_1 = arg_11_0.reactorRyza

			var_5.React(var_11_1, arg_11_1, arg_11_2)
		else
			arg_11_4:React(arg_11_1, arg_11_2)
		end
	else
		if not arg_11_0.eventRange[arg_11_1] then
			return
		end

		ipairs = var_1_10006

		for iter_11_0, iter_11_1 in var_1_10006(arg_11_0:getRangeList(arg_11_3, arg_11_4)) do
			ipairs = var_11
			underscore = var_1_10013
			var_1_10013 = var_1_10013.rest
			tostring = iter_11_3

			for iter_11_2, iter_11_3 in var_11(var_1_10013(var_5[iter_11_3(iter_11_1)], 1)) do
				iter_11_3:React(arg_11_1, arg_11_2)
			end
		end
	end

	return
end

function var_0_0.CreateCall(arg_12_0, arg_12_1)
	table = var_1_10002

	local var_12_0 = var_1_10002.insert
	local var_12_1 = arg_12_0.map

	tostring = var_1_10005

	var_12_0(var_12_1[var_1_10005(arg_12_1.pos)], arg_12_1)

	if arg_12_1:InTimeRiver() then
		table = var_2

		var_2.insert(arg_12_0.timeRiver, arg_12_1)
	end

	isa = var_2

	local var_12_2 = arg_12_1

	MoveRyza = var_5

	if var_2(var_12_2, var_5) then
		arg_12_0.reactorRyza = arg_12_1
	else
		isa = var_2

		local var_12_3 = arg_12_1

		MoveEnemy = var_5

		if var_2(var_12_3, var_5) then
			defaultValue = var_2
			arg_12_0.enemyCount = var_2(arg_12_0.enemyCount, 0) + 1
		else
			isa = var_2

			local var_12_4 = arg_12_1

			EffectFire = var_5

			if var_2(var_12_4, var_5) then
				table = var_2

				var_2.insert(arg_12_0.fireList, arg_12_1)
			end
		end
	end

	return
end

function var_0_0.DestroyCall(arg_13_0, arg_13_1, arg_13_2)
	table = var_1_10003

	local var_13_0 = var_1_10003.removebyvalue
	local var_13_1 = arg_13_0.map

	tostring = var_1_10006

	var_13_0(var_13_1[var_1_10006(arg_13_1.pos)], arg_13_1)

	if arg_13_1:InTimeRiver() then
		table = var_3

		var_3.removebyvalue(arg_13_0.timeRiver, arg_13_1)
	end

	local var_13_2 = arg_13_0.binder
	local var_13_3 = var_3.emit

	RyzaMiniGameView = var_6

	var_13_3(var_13_2, var_6.EVENT_DESTROY, arg_13_1, arg_13_2)

	isa = var_13_3

	local var_13_4 = arg_13_1

	MoveEnemy = var_6

	if var_13_3(var_13_4, var_6) then
		arg_13_0.enemyCount = arg_13_0.enemyCount - 1

		if arg_13_0.enemyCount == 0 then
			arg_13_0:GameFinish(true)
		end
	else
		isa = var_3

		local var_13_5 = arg_13_1

		EffectFire = var_6

		if var_3(var_13_5, var_6) then
			table = var_3

			var_3.removebyvalue(arg_13_0.fireList, arg_13_1)
		end
	end

	return
end

function var_0_0.GetCellPassability(arg_14_0, arg_14_1)
	if not arg_14_0:InRange(arg_14_1) then
		return false
	end

	ipairs = var_2

	local var_14_0 = arg_14_0.map

	tostring = var_5

	for iter_14_0, iter_14_1 in var_2(var_14_0[var_5(arg_14_1)]) do
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

	underscore = var_2

	local var_15_0 = var_2.reduce
	local var_15_1 = arg_15_0.map

	tostring = var_5

	return var_15_0(var_15_1[var_5(arg_15_1)], 0, function(arg_16_0, arg_16_1)
		math = var_2_10002

		return var_2_10002.max(arg_16_0, arg_16_1:FirePassability())
	end)
end

function var_0_0.GetCellCanBomb(arg_17_0, arg_17_1)
	if not arg_17_0:InRange(arg_17_1) then
		return false
	end

	underscore = var_2

	local var_17_0 = var_2.all
	local var_17_1 = arg_17_0.map

	tostring = var_5

	return var_17_0(var_17_1[var_5(arg_17_1)], function(arg_18_0)
		isa = var_2_10001

		local var_18_0 = arg_18_0

		ObjectBomb = var_2_10004

		return not var_2_10001(var_18_0, var_2_10004)
	end)
end

function var_0_0.TimeFlow(arg_19_0, arg_19_1)
	ipairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(arg_19_0.timeRiver) do
		iter_19_1:TimeUpdate(arg_19_1)
	end

	return
end

function var_0_0.Create(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.binder
	local var_20_1 = var_2.emit

	RyzaMiniGameView = var_1_10005

	var_20_1(var_20_0, var_1_10005.EVENT_CREATE, arg_20_1)

	return
end

function var_0_0.GetJoyStick(arg_21_0)
	NewPos = var_1_10001

	return var_1_10001(arg_21_0.binder.uiMgr.hrz, -arg_21_0.binder.uiMgr.vtc)
end

function var_0_0.RyzaBomb(arg_22_0)
	local var_22_0 = arg_22_0.reactorRyza

	var_1.SetBomb(var_22_0)

	return
end

function var_0_0.GameFinish(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.binder
	local var_23_1 = var_2.emit

	RyzaMiniGameView = var_1_10005

	var_23_1(var_23_0, var_1_10005.EVENT_FINISH, arg_23_1)

	return
end

function var_0_0.WindowFocrus(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.binder
	local var_24_1 = var_2.emit

	RyzaMiniGameView = var_1_10005

	var_24_1(var_24_0, var_1_10005.EVENT_WINDOW_FOCUS, arg_24_1)

	return
end

function var_0_0.SyncStatus(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_0.binder
	local var_25_1 = var_4.emit

	RyzaMiniGameView = var_1_10007

	var_25_1(var_25_0, var_1_10007.EVENT_STATUS_SYNC, arg_25_1, arg_25_2, arg_25_3)

	return
end

function var_0_0.UpdateHide(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0.binder
	local var_26_1 = var_3.emit

	RyzaMiniGameView = var_1_10006

	var_26_1(var_26_0, var_1_10006.EVENT_UPDATE_HIDE, arg_26_1, arg_26_2)

	return
end

function var_0_0.UpdatePos(arg_27_0, arg_27_1, arg_27_2)
	table = var_1_10003

	local var_27_0 = var_1_10003.removebyvalue
	local var_27_1 = arg_27_0.map

	tostring = var_1_10006

	var_27_0(var_27_1[var_1_10006(arg_27_1.pos)], arg_27_1)

	table = var_27_0

	local var_27_2 = var_27_0.insert
	local var_27_3 = arg_27_0.map

	tostring = var_6

	var_27_2(var_27_3[var_6(arg_27_2)], arg_27_1)

	return
end

local function var_0_3(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1.pos - arg_28_0.pos

	ipairs = var_3

	for iter_28_0, iter_28_1 in var_3(arg_28_0.range) do
		ipairs = var_1_10008

		for iter_28_2, iter_28_3 in var_1_10008(arg_28_1.range) do
			local var_28_1 = {
				{},
				{}
			}

			ipairs = var_14

			for iter_28_4, iter_28_5 in var_14(iter_28_1) do
				var_28_1[iter_28_4][1] = iter_28_5[1] - iter_28_3[iter_28_4][2]
				var_28_1[iter_28_4][2] = iter_28_5[2] - iter_28_3[iter_28_4][1]
			end

			if var_28_0.x > var_28_1[1][1] and var_28_0.x < var_28_1[1][2] and var_28_0.y > var_28_1[2][1] and var_28_0.y < var_28_1[2][2] then
				return true
			end
		end
	end

	return false
end

function var_0_0.Wayfinding(arg_29_0, arg_29_1)
	if not arg_29_0.reactorRyza.hide then
		var_1_10004 = arg_29_0

		if arg_29_0.CollideRyza(var_1_10004, arg_29_1) then
			arg_29_0.findingResult[arg_29_1] = nil

			return {
				arg_29_0.realPos
			}
		elseif arg_29_0.findingResult[arg_29_1] then
			if arg_29_0.findingResult[arg_29_1].ryzaPos == arg_29_0.reactorRyza.pos and var_2.reactorPos == arg_29_1.pos then
				return var_2.path
			else
				arg_29_0.findingResult[arg_29_1] = nil
			end
		end

		local var_29_0 = {
			arg_29_1.pos
		}
		local var_29_1 = {}

		tostring = var_1_10004
		var_29_1[var_1_10004(arg_29_1.pos)] = 0

		local function var_29_2(arg_30_0)
			local var_30_0 = {}

			::label_30_0::

			local var_30_1 = var_29_1

			tostring = var_2_10003

			local var_30_2 = var_30_1[var_2_10003(var_29_0[arg_30_0])]

			if 0 < var_30_2 then
				repeat
					table = var_30_2

					var_30_2.insert(var_30_0, var_29_0[arg_30_0])

					var_30_2 = var_29_1
					tostring = var_2_10003
					arg_30_0 = var_30_2[var_2_10003(var_29_0[arg_30_0])]

					goto label_30_0
				until true
			end

			arg_29_0.findingResult[arg_29_1] = {
				ryzaPos = arg_29_0.reactorRyza.pos,
				reactorPos = arg_29_1.pos,
				path = var_30_0
			}

			return var_30_0
		end

		local var_29_3 = 0
		local var_29_4

		while var_29_3 < #var_29_0 do
			var_29_3 = var_29_3 + 1
			ipairs = var_7

			for iter_29_0, iter_29_1 in var_7(var_0_2) do
				var_1_10012 = var_29_0[var_29_3]
				NewPos = var_1_10013
				unpack = var_1_10015

				local var_29_5 = var_1_10012 + var_1_10013(var_1_10015(iter_29_1))

				tostring = var_1_10012

				if var_29_1[var_1_10012(var_29_5)] == nil then
					var_1_10014 = arg_29_0

					if arg_29_0.GetCellPassability(var_1_10014, var_29_5) then
						tostring = var_1_10012
						var_29_1[var_1_10012(var_29_5)] = var_29_3
						table = var_1_10012

						var_1_10012.insert(var_29_0, var_29_5)

						var_1_10012 = var_0_3
						var_1_10014 = {
							pos = arg_29_0.reactorRyza.realPos
						}

						local var_29_6 = arg_29_0.reactorRyza

						var_1_10014.range = var_1_10015.GetCollideRange(var_29_6)

						if var_1_10012(var_1_10014, {
							pos = var_29_5,
							range = arg_29_1:GetCollideRange()
						}) then
							return var_29_2(#var_29_0)
						end
					else
						tostring = var_1_10012
						var_29_1[var_1_10012(var_29_5)] = false
					end
				end
			end

			ipairs = var_7

			for iter_29_2, iter_29_3 in var_7(var_0_2) do
				NewPos = var_1_10012
				unpack = var_1_10014
				var_1_10012 = var_1_10012(var_1_10014(iter_29_3))
				NewPos = var_1_10013
				unpack = var_1_10015
				var_1_10013 = var_1_10013(var_1_10015(var_0_2[iter_29_2 % 4 + 1]))

				local var_29_7 = var_29_0[var_29_3] + var_1_10012 + var_1_10013

				tostring = var_1_10014

				if var_29_1[var_1_10014(var_29_0[var_29_3] + var_1_10012)] then
					tostring = var_1_10014

					if var_29_1[var_1_10014(var_29_0[var_29_3] + var_1_10013)] then
						tostring = var_1_10014

						if var_29_1[var_1_10014(var_29_7)] == nil and arg_29_0:GetCellPassability(var_29_7) then
							tostring = var_1_10014
							var_29_1[var_1_10014(var_29_7)] = var_29_3
							table = var_1_10014

							var_1_10014.insert(var_29_0, var_29_7)

							var_1_10014 = var_0_3

							local var_29_8 = {
								pos = arg_29_0.reactorRyza.realPos
							}
							local var_29_9 = arg_29_0.reactorRyza

							var_29_8.range = var_17.GetCollideRange(var_29_9)

							if var_1_10014(var_29_8, {
								pos = var_29_7,
								range = arg_29_1:GetCollideRange()
							}) then
								return var_29_2(#var_29_0)
							end
						end
					end
				end
			end
		end

		return
	end
end

function var_0_0.SearchRyza(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_0.reactorRyza.hide then
		return false
	else
		local var_31_0

		if not arg_31_1.realPos then
			var_31_0 = arg_31_1.pos
		end

		local var_31_1 = var_31_0 - arg_31_0.reactorRyza.realPos

		return var_3.SqrMagnitude(var_31_1) < arg_31_2 * arg_31_2
	end

	return
end

function var_0_0.CollideRyza(arg_32_0, arg_32_1)
	local var_32_0 = var_0_3
	local var_32_1 = {
		pos = arg_32_0.reactorRyza.realPos
	}
	local var_32_2 = arg_32_0.reactorRyza

	var_32_1.range = var_5.GetCollideRange(var_32_2)

	return var_32_0(var_32_1, {
		pos = arg_32_1.realPos,
		range = arg_32_1:GetCollideRange()
	})
end

function var_0_0.CollideFire(arg_33_0, arg_33_1)
	underscore = var_1_10002

	return var_1_10002.filter(arg_33_0.fireList, function(arg_34_0)
		local var_34_0 = var_0_3
		local var_34_1 = {
			pos = arg_34_0.pos,
			range = arg_34_0:GetCollideRange()
		}
		local var_34_2 = {
			pos = arg_33_1.realPos
		}
		local var_34_3 = arg_33_1

		var_34_2.range = var_5.GetCollideRange(var_34_3)

		return var_34_0(var_34_1, var_34_2)
	end)
end

return var_0_0
