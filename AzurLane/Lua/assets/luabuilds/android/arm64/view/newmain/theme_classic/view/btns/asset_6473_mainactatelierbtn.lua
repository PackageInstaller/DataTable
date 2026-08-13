class = var_0_10000

local var_0_0 = "MainActAtelierBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_Atelier"
end

function var_0_1.OnInit(arg_2_0)
	setActive = var_1_10001

	var_1_10001(arg_2_0.tipTr.gameObject, false)

	return
end

return var_0_1
