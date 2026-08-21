pg = pg or {}

local var_0_0 = singletonClass("WatermarkingMgr")

pg.WatermarkingMgr = var_0_0

function var_0_0.Init(arg_1_0, arg_1_1)
	arg_1_0.state = STATE_LOADING

	LoadAndInstantiateAsync("ui", "WatermarkingUI", function(arg_2_0)
		arg_1_0.UIOverlay = GameObject.Find("Overlay/UIEffect")

		arg_2_0.transform:SetParent(arg_1_0.UIOverlay.transform, false)
		arg_1_0:InitMain(arg_1_1, arg_2_0)

		return
	end, true, true)

	return
end

function var_0_0.InitMain(arg_3_0, arg_3_1, arg_3_2)
	setText(arg_3_2.transform:Find("uid"), "UID" .. arg_3_1.id)

	return
end

return
