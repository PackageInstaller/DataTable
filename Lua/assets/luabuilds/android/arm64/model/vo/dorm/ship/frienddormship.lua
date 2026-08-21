local var_0_0 = class("FriendDormShip", import(".DormShip"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.configId = arg_1_1.tid
	arg_1_0.skinId = arg_1_1.skin_id

	return
end

function var_0_0.ToBayShip(arg_2_0)
	return (Ship.New({
		energy = 100,
		id = arg_2_0.id,
		configId = arg_2_0.configId,
		skin_id = arg_2_0.skinId
	}))
end

return var_0_0
