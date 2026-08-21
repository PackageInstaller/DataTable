local var_0_0 = class("Reactor", import("view.miniGame.gameView.RyzaMiniGame.BaseReactor"))

function var_0_0.GetBaseOrder(arg_1_0)
	return 1
end

function var_0_0.CellPassability(arg_2_0)
	return true
end

function var_0_0.FirePassability(arg_3_0)
	return 0
end

function var_0_0.InTimeRiver(arg_4_0)
	return false
end

function var_0_0.Init(arg_5_0, arg_5_1)
	arg_5_0.name = arg_5_1.name

	if arg_5_0:GetBaseOrder() ~= "floor" then
		SetCanvasOverrideSorting(arg_5_0._tf, true)
	end

	var_0_0.UpdatePos(arg_5_0, NewPos(unpack(arg_5_1.pos)))

	arg_5_0.realPos = NewPos(unpack(var_5_0))

	arg_5_0:UpdatePosition()
	arg_5_0:InitUI(arg_5_1)
	arg_5_0:InitRegister(arg_5_1)

	return
end

function var_0_0.InitUI(arg_6_0, arg_6_1)
	return
end

function var_0_0.InitRegister(arg_7_0, arg_7_1)
	return
end

function var_0_0.UpdatePos(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetBaseOrder()

	if var_8_0 ~= "floor" then
		arg_8_0._tf:GetComponent(typeof(Canvas)).sortingOrder = arg_8_1.y * 10 + var_8_0
	end

	arg_8_0.pos = arg_8_1

	return
end

function var_0_0.UpdatePosition(arg_9_0)
	setAnchoredPosition(arg_9_0._tf, {
		x = arg_9_0.realPos.x * 32,
		y = arg_9_0.realPos.y * -32
	})

	return
end

return var_0_0
