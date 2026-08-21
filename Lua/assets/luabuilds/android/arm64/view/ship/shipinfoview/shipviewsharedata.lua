local var_0_0 = class("ShipViewShareData")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.shipVO = nil

	return
end

function var_0_0.SetShipVO(arg_2_0, arg_2_1)
	arg_2_0.shipVO = arg_2_1

	return
end

function var_0_0.SetPlayer(arg_3_0, arg_3_1)
	arg_3_0.player = arg_3_1

	return
end

function var_0_0.HasFashion(arg_4_0)
	return getProxy(ShipSkinProxy):HasFashion(arg_4_0.shipVO)
end

function var_0_0.GetCurGroupSkinList(arg_5_0)
	return arg_5_0:GetGroupSkinList(arg_5_0.shipVO.groupId)
end

function var_0_0.GetGroupSkinList(arg_6_0, arg_6_1)
	return getProxy(ShipSkinProxy):GetAllSkinForShip(arg_6_0.shipVO)
end

return var_0_0
