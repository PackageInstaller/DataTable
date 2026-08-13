class = var_0_10000

local var_0_0 = "Reactor"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.miniGame.gameView.RyzaMiniGame.BaseReactor"))

function var_0_1.GetBaseOrder(arg_1_0)
	return 1
end

function var_0_1.CellPassability(arg_2_0)
	return true
end

function var_0_1.FirePassability(arg_3_0)
	return 0
end

function var_0_1.InTimeRiver(arg_4_0)
	return false
end

function var_0_1.Init(arg_5_0, arg_5_1)
	arg_5_0.name = arg_5_1.name

	if arg_5_0:GetBaseOrder() ~= "floor" then
		SetCanvasOverrideSorting = var_2

		var_2(arg_5_0._tf, true)
	end

	local var_5_0 = var_0_1.UpdatePos
	local var_5_1 = arg_5_0

	NewPos = var_1_10004
	unpack = var_1_10005

	var_5_0(var_5_1, var_1_10004(var_1_10005(arg_5_1.pos)))

	NewPos = var_5_0
	unpack = var_5_1

	local var_5_2

	if not arg_5_1.realPos then
		var_5_2 = arg_5_1.pos
	end

	arg_5_0.realPos = var_5_0(var_5_1(var_5_2))

	arg_5_0:UpdatePosition()
	arg_5_0:InitUI(arg_5_1)
	arg_5_0:InitRegister(arg_5_1)

	return
end

function var_0_1.InitUI(arg_6_0, arg_6_1)
	return
end

function var_0_1.InitRegister(arg_7_0, arg_7_1)
	return
end

function var_0_1.UpdatePos(arg_8_0, arg_8_1)
	if arg_8_0:GetBaseOrder() ~= "floor" then
		local var_8_0 = arg_8_0._tf
		local var_8_1 = var_3.GetComponent

		typeof = var_1_10005
		Canvas = var_1_10006
		var_8_1(var_8_0, var_1_10005(var_1_10006)).sortingOrder = arg_8_1.y * 10 + var_2
	end

	arg_8_0.pos = arg_8_1

	return
end

function var_0_1.UpdatePosition(arg_9_0)
	setAnchoredPosition = var_1_10001

	var_1_10001(arg_9_0._tf, {
		x = arg_9_0.realPos.x * 32,
		y = arg_9_0.realPos.y * -32
	})

	return
end

return var_0_1
