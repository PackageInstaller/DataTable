class = var_0_10000

local var_0_0 = "CourtYardOtherPlayerShipModule"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardShipModule"))

function var_0_1.Emit(arg_1_0, arg_1_1, ...)
	if arg_1_1 == "TouchShip" or arg_1_1 == "ShipAnimtionFinish" then
		var_0_1.super.Emit(arg_1_0, arg_1_1, ...)
	end

	return
end

function var_0_1.OnBeginDrag(arg_2_0)
	return
end

function var_0_1.OnDragging(arg_3_0, arg_3_1)
	return
end

function var_0_1.OnDragEnd(arg_4_0, arg_4_1)
	return
end

return var_0_1
