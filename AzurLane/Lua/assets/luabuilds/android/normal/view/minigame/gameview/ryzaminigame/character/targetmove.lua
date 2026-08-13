class = var_0_10000

local var_0_0 = "TargetMove"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.miniGame.gameView.RyzaMiniGame.Reactor"))

function var_0_1.GetBaseOrder(arg_1_0)
	return 2
end

function var_0_1.InTimeRiver(arg_2_0)
	return true
end

function var_0_1.Init(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._tf

	arg_3_0.rtScale = var_2.Find(var_3_0, "scale")

	var_0_1.super.Init(arg_3_0, arg_3_1)

	return
end

function var_0_1.UpdatePos(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.responder

	var_2.UpdatePos(var_4_0, arg_4_0, arg_4_1)

	pairs = var_2

	for iter_4_0, iter_4_1 in var_2(arg_4_0.rangeDic) do
		local var_4_1 = arg_4_0.responder

		var_7.RemoveListener(var_4_1, iter_4_0, arg_4_0, iter_4_1)
	end

	arg_4_0:Calling("leave", {
		arg_4_0
	}, {
		{
			0,
			0
		}
	})
	var_0_1.super.UpdatePos(arg_4_0, arg_4_1)

	pairs = var_2

	for iter_4_2, iter_4_3 in var_2(arg_4_0.rangeDic) do
		local var_4_2 = arg_4_0.responder

		var_7.AddListener(var_4_2, iter_4_2, arg_4_0, iter_4_3)
	end

	arg_4_0:Calling("move", {
		arg_4_0
	}, {
		{
			0,
			0
		}
	})

	return
end

function var_0_1.SetHide(arg_5_0, arg_5_1)
	arg_5_0.hide = arg_5_1

	local var_5_0 = arg_5_0.responder

	var_2.UpdateHide(var_5_0, arg_5_0, arg_5_1)

	return
end

function var_0_1.GetSpeed(arg_6_0)
	return arg_6_0.speed
end

var_0_1.SpeedDistance = {
	[0] = 3.5,
	4,
	4.5,
	5,
	5.5,
	6,
	6.3,
	6.5
}

function var_0_1.GetSpeedDis(arg_7_0)
	return arg_7_0.SpeedDistance[arg_7_0:GetSpeed()]
end

function var_0_1.TimeUpdate(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.MoveUpdate

	NewPos = var_1_10004

	var_8_1(var_8_0, var_1_10004(0, 0))

	return
end

function var_0_1.MoveUpdate(arg_9_0, arg_9_1)
	if arg_9_1.x == 0 and arg_9_1.y == 0 then
		return arg_9_1
	end

	arg_9_0.realPos = arg_9_0.realPos + arg_9_1

	arg_9_0:UpdatePosition()

	local var_9_0 = arg_9_0.realPos - arg_9_0.pos

	ipairs = var_3

	for iter_9_0, iter_9_1 in var_3({
		"x",
		"y"
	}) do
		math = var_1_10008

		if var_1_10008.abs(var_9_0[iter_9_1]) > 0.5 then
			var_1_10008 = var_9_0[iter_9_1] < 0 and -1 or 1
			var_9_0[iter_9_1] = var_1_10008
		else
			var_9_0[iter_9_1] = 0
		end
	end

	if var_9_0.x ~= 0 or var_9_0.y ~= 0 then
		arg_9_0:UpdatePos(arg_9_0.pos + var_9_0)
	end

	return
end

local var_0_2 = {
	x = "y",
	y = "x"
}

function var_0_1.MoveDelta(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1.x == 0 and arg_10_1.y == 0 or arg_10_2 == 0 then
		NewPos = var_3

		return var_3(0, 0)
	end

	local function var_10_0(arg_11_0)
		if (arg_11_0 - arg_10_0.realPos).x * var_1.x < 1 and var_1.y * var_1.y < 1 then
			return true
		else
			local var_11_0 = arg_10_0.responder

			return var_2.GetCellPassability(var_11_0, arg_11_0)
		end

		return
	end

	local var_10_1 = {
		x = {
			0,
			0
		},
		y = {
			0,
			0
		}
	}

	ipairs = var_5

	for iter_10_0, iter_10_1 in var_5({
		"x",
		"y"
	}) do
		ipairs = var_1_10010

		for iter_10_2, iter_10_3 in var_1_10010({
			-1,
			1
		}) do
			NewPos = var_1_10015
			var_1_10015[iter_10_1] = var_1_10015(arg_10_0.pos.x, arg_10_0.pos.y)[iter_10_1] + iter_10_3

			if var_10_0(var_1_10015) then
				var_10_1[iter_10_1][iter_10_2] = var_10_1[iter_10_1][iter_10_2] + iter_10_3
			end
		end
	end

	local var_10_2 = arg_10_0.realPos - arg_10_0.pos + arg_10_1 * arg_10_2

	math = var_7

	local var_10_3 = var_7.clamp
	local var_10_4 = var_10_2.x

	unpack = iter_10_1
	var_10_2.x = var_10_3(var_10_4, iter_10_1(var_10_1.x))
	math = var_7

	local var_10_5 = var_7.clamp
	local var_10_6 = var_10_2.y

	unpack = var_9
	var_10_2.y = var_10_5(var_10_6, var_9(var_10_1.y))

	if var_10_2.x == 0 and var_10_2.y == 0 then
		return var_10_2 - var_5
	elseif var_10_2.x == 0 then
		math = var_7

		local var_10_7 = var_7.clamp
		local var_10_8 = var_5.y + arg_10_1.y * arg_10_2

		unpack = var_9
		var_10_2.y = var_10_7(var_10_8, var_9(var_10_1.y))

		return var_10_2 - var_5
	else
		local var_10_9

		if var_10_2.y == 0 then
			math = var_10_9
			var_10_9 = var_10_9.clamp

			local var_10_10 = var_5.x + arg_10_1.x * arg_10_2

			unpack = var_9
			var_10_2.x = var_10_9(var_10_10, var_9(var_10_1.x))

			return var_10_2 - var_5
		else
			NewPos = var_10_9

			local var_10_11 = var_10_9(arg_10_0.pos.x + (var_10_2.x < 0 and -1 or 1), arg_10_0.pos.y + (var_10_2.y < 0 and -1 or 1))

			if not var_10_0(var_10_11) then
				local var_10_12 = arg_10_1.y * arg_10_1.y > arg_10_1.x * arg_10_1.x and "y" or "x"
				local var_10_13 = var_0_2[var_10_12]

				NewPos = var_10

				local var_10_14 = var_10(0, 0)
				local var_10_15

				if var_5[var_10_13] * var_5[var_10_13] > arg_10_2 * arg_10_2 then
					var_10_14[var_10_12] = -var_5[var_10_12]
					var_10_15 = -var_5[var_10_13] < 0 and -1 or 1
					math = var_12
					var_10_14[var_10_13] = var_10_15 * var_12.sqrt(arg_10_2 * arg_10_2 - var_10_14[var_10_12] * var_10_14[var_10_12])
				else
					var_10_14[var_10_13] = -var_5[var_10_13]
					var_10_15 = arg_10_1[var_10_12] < 0 and -1 or 1
					math = var_12
					var_10_14[var_10_12] = var_10_15 * var_12.sqrt(arg_10_2 * arg_10_2 - var_10_14[var_10_13] * var_10_14[var_10_13])
				end

				local var_10_16 = var_5 + var_10_14

				math = var_10_15

				local var_10_17 = var_10_15.clamp
				local var_10_18 = var_10_16.x

				unpack = iter_10_2
				var_10_16.x = var_10_17(var_10_18, iter_10_2(var_10_1.x))
				math = var_11

				local var_10_19 = var_11.clamp
				local var_10_20 = var_10_16.y

				unpack = var_13
				var_10_16.y = var_10_19(var_10_20, var_13(var_10_1.y))

				return var_10_16 - var_5
			else
				return arg_10_1 * arg_10_2
			end
		end
	end

	return
end

function var_0_1.GetMoveInfo(arg_12_0)
	local var_12_0 = arg_12_0.pos

	NewPos = var_1_10002

	local var_12_1 = var_1_10002(0, 0)
end

function var_0_1.GetCollideRange(arg_13_0)
	return {
		{
			{
				-0.5,
				0.5
			},
			{
				-0.5,
				0.5
			}
		}
	}
end

var_0_1.loopDic = {}

function var_0_1.PlayAnim(arg_14_0, arg_14_1)
	if arg_14_0.status ~= arg_14_1 then
		arg_14_0.status = arg_14_1

		local var_14_0 = arg_14_0.loopDic

		string = var_1_10003

		if not var_14_0[var_1_10003.split(arg_14_1, "_")[1]] then
			arg_14_0.lock = true
		end

		local var_14_1 = arg_14_0.mainTarget
		local var_14_2 = var_2.GetComponent

		typeof = var_4
		Animator = var_5

		local var_14_3 = var_14_2(var_14_1, var_4(var_5))

		var_2.Play(var_14_3, arg_14_1)
	end

	return
end

return var_0_1
