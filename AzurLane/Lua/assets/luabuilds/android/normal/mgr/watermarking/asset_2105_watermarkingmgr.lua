pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
singletonClass = pg

local var_0_1 = var_0("WatermarkingMgr")

pg = var_1
var_1.WatermarkingMgr = var_0_1

function var_0_1.Init(arg_1_0, arg_1_1)
	STATE_LOADING = var_1_10002
	arg_1_0.state = var_1_10002
	LoadAndInstantiateAsync = var_1_10002

	var_1_10002("ui", "WatermarkingUI", function(arg_2_0)
		local var_2_0 = arg_1_0

		GameObject = var_2_10002
		var_2_0.UIOverlay = var_2_10002.Find("Overlay/UIEffect")

		local var_2_1 = arg_2_0.transform

		var_1.SetParent(var_2_1, arg_1_0.UIOverlay.transform, false)

		local var_2_2 = arg_1_0

		var_1.InitMain(var_2_2, arg_1_1, arg_2_0)

		return
	end, true, true)

	return
end

function var_0_1.InitMain(arg_3_0, arg_3_1, arg_3_2)
	setText = var_1_10003

	local var_3_0 = arg_3_2.transform

	var_1_10003(var_4.Find(var_3_0, "uid"), "UID" .. arg_3_1.id)

	return
end

return
