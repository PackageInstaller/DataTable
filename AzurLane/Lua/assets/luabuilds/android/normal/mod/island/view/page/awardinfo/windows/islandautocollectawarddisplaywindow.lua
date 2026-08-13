class = var_0_10000

local var_0_0 = "IslandAutoCollectAwardDisplayWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandAwardDisplayWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandAutoCollectAwardDisplayUI"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.textTF = var_1.Find(var_2_0, "frame/Board/Top/text/text")
	setActive = var_1

	var_1(arg_2_0.textTF, false)

	return
end

return var_0_1
