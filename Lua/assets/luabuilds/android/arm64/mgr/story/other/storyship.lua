local var_0_0 = class("StoryShip", import("model.vo.Ship"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.configId = 9999999999
	arg_1_0.skinId = arg_1_1.skin_id or 0
	arg_1_0.noChangeSkin = true

	return
end

return var_0_0
