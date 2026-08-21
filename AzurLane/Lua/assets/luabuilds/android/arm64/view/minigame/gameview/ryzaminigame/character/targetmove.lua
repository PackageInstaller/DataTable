local var_0_0 = class("TargetMove", import("view.miniGame.gameView.RyzaMiniGame.Reactor"))

function var_0_0.GetBaseOrder(arg_1_0)
	return 2
end

function var_0_0.InTimeRiver(arg_2_0)
	return true
end

function var_0_0.Init(arg_3_0, arg_3_1)
	arg_3_0.rtScale = arg_3_0._tf:Find("scale")

	var_0_0.super.Init(arg_3_0, arg_3_1)

	return
end

function var_0_0.UpdatePos(arg_4_0, arg_4_1)
	arg_4_0.responder:UpdatePos(arg_4_0, arg_4_1)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.rangeDic) do
		arg_4_0.responder:RemoveListener(iter_4_0, arg_4_0, iter_4_1)
	end

	arg_4_0:Calling("leave", {
		arg_4_0
	}, {
		{
			0,
			0
		}
	})
	var_0_0.super.UpdatePos(arg_4_0, arg_4_1)

	for iter_4_2, iter_4_3 in pairs(arg_4_0.rangeDic) do
		arg_4_0.responder:AddListener(iter_4_2, arg_4_0, iter_4_3)
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

function var_0_0.SetHide(arg_5_0, arg_5_1)
	arg_5_0.hide = arg_5_1

	arg_5_0.responder:UpdateHide(arg_5_0, arg_5_1)

	return
end

function var_0_0.GetSpeed(arg_6_0)
	return arg_6_0.speed
end

var_0_0.SpeedDistance = {
	[0] = 3.5,
	4,
	4.5,
	5,
	5.5,
	6,
	6.3,
	6.5
}

function var_0_0.GetSpeedDis(arg_7_0)
	return arg_7_0.SpeedDistance[arg_7_0:GetSpeed()]
end

function var_0_0.TimeUpdate(arg_8_0, arg_8_1)
	arg_8_0:MoveUpdate(NewPos(0, 0))

	return
end

function var_0_0.MoveUpdate(arg_9_0, arg_9_1)
	if arg_9_1.x == 0 and arg_9_1.y == 0 then
		return arg_9_1
	end

	arg_9_0.realPos = arg_9_0.realPos + arg_9_1

	arg_9_0:UpdatePosition()

	local var_9_0 = arg_9_0.realPos - arg_9_0.pos

	for iter_9_0, iter_9_1 in ipairs({
		"x",
		"y"
	}) do
		var_9_0[iter_9_1] = math.abs(var_9_0[iter_9_1]) > 0.5 and (var_9_0[iter_9_1] < 0 and -1 or 1) or 0
	end

	if var_9_0.x ~= 0 or var_9_0.y ~= 0 then
		arg_9_0:UpdatePos(arg_9_0.pos + var_9_0)
	end

	return
end

local var_0_1 = {
	x = "y",
	y = "x"
}

function var_0_0.MoveDelta(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1.x == 0 and arg_10_1.y == 0 or arg_10_2 == 0 then
		return NewPos(0, 0)
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

	for iter_10_0, iter_10_1 in ipairs({
		"x",
		"y"
	}) do
		for iter_10_2, iter_10_3 in ipairs({
			-1,
			1
		}) do
			local var_10_2 = NewPos(arg_10_0.pos.x, arg_10_0.pos.y)

			var_10_2[iter_10_1] = var_10_2[iter_10_1] + iter_10_3

			if var_10_0(var_10_2) then
				var_10_1[iter_10_1][iter_10_2] = var_10_1[iter_10_1][iter_10_2] + iter_10_3
			end
		end
	end

	local var_10_3 = arg_10_0.realPos - arg_10_0.pos
	local var_10_4 = arg_10_0.realPos - arg_10_0.pos + arg_10_1 * arg_10_2

	var_10_4.x = math.clamp((arg_10_0.realPos - arg_10_0.pos + arg_10_1 * arg_10_2).x, unpack(var_10_1.x))
	var_10_4.y = math.clamp(var_10_4.y, unpack(var_10_1.y))

	if var_10_4.x == 0 and var_10_4.y == 0 then
		return var_10_4 - var_10_3
	elseif var_10_4.x == 0 then
		var_10_4.y = math.clamp(var_10_3.y + arg_10_1.y * arg_10_2, unpack(var_10_1.y))

		return var_10_4 - var_10_3
	elseif var_10_4.y == 0 then
		var_10_4.x = math.clamp(var_10_3.x + arg_10_1.x * arg_10_2, unpack(var_10_1.x))

		return var_10_4 - var_10_3
	elseif not var_10_0((NewPos(arg_10_0.pos.x + (var_10_4.x < 0 and -1 or 1), arg_10_0.pos.y + (var_10_4.y < 0 and -1 or 1)))) then
		local var_10_5 = arg_10_1.y * arg_10_1.y > arg_10_1.x * arg_10_1.x and "y" or "x"
		local var_10_6 = var_0_1[arg_10_1.y * arg_10_1.y > arg_10_1.x * arg_10_1.x and "y" or "x"]
		local var_10_7 = NewPos(0, 0)

		if var_10_3[var_0_1[arg_10_1.y * arg_10_1.y > arg_10_1.x * arg_10_1.x and "y" or "x"]] * var_10_3[var_0_1[arg_10_1.y * arg_10_1.y > arg_10_1.x * arg_10_1.x and "y" or "x"]] > arg_10_2 * arg_10_2 then
			var_10_7[var_10_5] = -var_10_3[var_10_5]
			var_10_7[var_10_6] = (-var_10_3[var_10_6] < 0 and -1 or 1) * math.sqrt(arg_10_2 * arg_10_2 - var_10_7[var_10_5] * var_10_7[var_10_5])
		else
			var_10_7[var_10_6] = -var_10_3[var_10_6]
			var_10_7[var_10_5] = (arg_10_1[var_10_5] < 0 and -1 or 1) * math.sqrt(arg_10_2 * arg_10_2 - var_10_7[var_10_6] * var_10_7[var_10_6])
		end

		local var_10_8 = var_10_3 + var_10_7

		var_10_8.x = math.clamp((var_10_3 + var_10_7).x, unpack(var_10_1.x))
		var_10_8.y = math.clamp(var_10_8.y, unpack(var_10_1.y))

		return var_10_8 - var_10_3
	else
		return arg_10_1 * arg_10_2
	end

	return
end

function var_0_0.GetMoveInfo(arg_12_0)
	local var_12_1 = NewPos(0, 0)
end

function var_0_0.GetCollideRange(arg_13_0)
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

var_0_0.loopDic = {}

function var_0_0.PlayAnim(arg_14_0, arg_14_1)
	if arg_14_0.status ~= arg_14_1 then
		arg_14_0.status = arg_14_1

		if not arg_14_0.loopDic[string.split(arg_14_1, "_")[1]] then
			arg_14_0.lock = true
		end

		arg_14_0.mainTarget:GetComponent(typeof(Animator)):Play(arg_14_1)
	end

	return
end

return var_0_0
