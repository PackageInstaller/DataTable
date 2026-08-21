local var_0_0 = class("CourtYardOtherPlayerShipModule", import(".CourtYardShipModule"))

function var_0_0.Emit(arg_1_0, arg_1_1, ...)
	if arg_1_1 == "TouchShip" or arg_1_1 == "ShipAnimtionFinish" then
		var_0_0.super.Emit(arg_1_0, arg_1_1, ...)
	end

	return
end

function var_0_0.OnBeginDrag(arg_2_0)
	return
end

function var_0_0.OnDragging(arg_3_0, arg_3_1)
	return
end

function var_0_0.OnDragEnd(arg_4_0, arg_4_1)
	return
end

return var_0_0
