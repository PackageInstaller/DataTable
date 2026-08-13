class = var_0_10000

local var_0_0 = "StoryShip"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.Ship"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.configId = 9999999999

	local var_1_0

	if not arg_1_1.skin_id then
		var_1_0 = 0
	end

	arg_1_0.skinId = var_1_0
	arg_1_0.noChangeSkin = true

	return
end

return var_0_1
