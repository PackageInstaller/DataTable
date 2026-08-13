class = var_0_10000

local var_0_0 = "WSMapResource"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	map = "table",
	rtDarkFog = "userdata",
	rtSairenFog = "userdata"
}

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.map = arg_1_1

	return
end

function var_0_1.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_1.Load(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = arg_3_0.map

	table = var_1_10004

	var_1_10004.insert(var_3_0, function(arg_4_0)
		PoolMgr = var_2_10001

		local var_4_0 = var_2_10001.GetInstance()

		var_1.GetUI(var_4_0, "darkfog", true, function(arg_5_0)
			setParent = var_3_10001

			local var_5_0 = arg_5_0

			GameObject = var_3_10004

			var_3_10001(var_5_0, var_3_10004.Find("__Pool__").transform)

			local var_5_1 = arg_3_0

			var_5_1.rtDarkFog = arg_5_0.transform
			setActive = var_5_1

			var_5_1(arg_3_0.rtDarkFog, false)
			arg_4_0()

			return
		end)

		return
	end)

	table = var_4

	var_4.insert(var_3_0, function(arg_6_0)
		PoolMgr = var_2_10001

		local var_6_0 = var_2_10001.GetInstance()

		var_1.GetUI(var_6_0, "sairenfog", true, function(arg_7_0)
			setParent = var_3_10001

			local var_7_0 = arg_7_0

			GameObject = var_3_10004

			var_3_10001(var_7_0, var_3_10004.Find("__Pool__").transform)

			local var_7_1 = arg_3_0

			var_7_1.rtSairenFog = arg_7_0.transform
			setActive = var_7_1

			var_7_1(arg_3_0.rtSairenFog, false)
			arg_6_0()

			return
		end)

		return
	end)

	seriesAsync = var_4

	var_4(var_3_0, arg_3_1)

	return
end

function var_0_1.Unload(arg_8_0)
	if arg_8_0.rtDarkFog then
		PoolMgr = var_1

		local var_8_0 = var_1.GetInstance()

		var_1.ReturnUI(var_8_0, "darkfog", arg_8_0.rtDarkFog.gameObject)

		arg_8_0.rtDarkFog = nil
	end

	if arg_8_0.rtSairenFog then
		PoolMgr = var_1

		local var_8_1 = var_1.GetInstance()

		var_1.ReturnUI(var_8_1, "darkfog", arg_8_0.rtSairenFog.gameObject)

		arg_8_0.rtSairenFog = nil
	end

	return
end

return var_0_1
