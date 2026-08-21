local var_0_0 = class("WSMapResource", import("...BaseEntity"))

var_0_0.Fields = {
	map = "table",
	rtDarkFog = "userdata",
	rtSairenFog = "userdata"
}

function var_0_0.Setup(arg_1_0, arg_1_1)
	arg_1_0.map = arg_1_1

	return
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_0.Load(arg_3_0, arg_3_1)
	table.insert({}, function(arg_4_0)
		PoolMgr.GetInstance():GetUI("darkfog", true, function(arg_5_0)
			setParent(arg_5_0, GameObject.Find("__Pool__").transform)

			arg_3_0.rtDarkFog = arg_5_0.transform

			setActive(arg_3_0.rtDarkFog, false)
			arg_4_0()

			return
		end)

		return
	end)
	table.insert({}, function(arg_6_0)
		PoolMgr.GetInstance():GetUI("sairenfog", true, function(arg_7_0)
			setParent(arg_7_0, GameObject.Find("__Pool__").transform)

			arg_3_0.rtSairenFog = arg_7_0.transform

			setActive(arg_3_0.rtSairenFog, false)
			arg_6_0()

			return
		end)

		return
	end)
	seriesAsync({}, arg_3_1)

	return
end

function var_0_0.Unload(arg_8_0)
	if arg_8_0.rtDarkFog then
		PoolMgr.GetInstance():ReturnUI("darkfog", arg_8_0.rtDarkFog.gameObject)

		arg_8_0.rtDarkFog = nil
	end

	if arg_8_0.rtSairenFog then
		PoolMgr.GetInstance():ReturnUI("darkfog", arg_8_0.rtSairenFog.gameObject)

		arg_8_0.rtSairenFog = nil
	end

	return
end

return var_0_0
