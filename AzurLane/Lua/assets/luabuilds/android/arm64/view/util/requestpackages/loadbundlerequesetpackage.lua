class = var_0_10000

local var_0_0 = "LoadBundleRequesetPackage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".RequestPackage"))

function var_0_1.__call(arg_1_0)
	if arg_1_0.stopped then
		return
	end

	seriesAsync = var_1

	var_1({
		function(arg_2_0)
			pg = var_2_10001

			local var_2_0 = var_2_10001.UIMgr.GetInstance()

			var_1.LoadingOn(var_2_0)

			local var_2_1 = arg_1_0.path

			xpcall = var_2_10002

			var_2_10002(function()
				AssetBundleHelper = var_3_10000

				var_3_10000.StoreAssetBundle(var_2_1, true, true, function(arg_4_0)
					pg = var_4_10001

					local var_4_0 = var_4_10001.UIMgr.GetInstance()

					var_1.LoadingOff(var_4_0)

					if arg_1_0.stopped then
						AssetBundleHelper = var_1

						var_1.UnstoreAssetBundle(var_2_1)

						return
					end

					arg_2_0(arg_4_0)

					return
				end)

				return
			end, function(...)
				errorMsg = var_3_10000
				debug = var_3_10002

				var_3_10000(var_3_10002.traceback(...))

				pg = var_3_10000

				local var_5_0 = var_3_10000.UIMgr.GetInstance()

				var_0.LoadingOff(var_5_0)

				return
			end)

			return
		end,
		function(arg_6_0, arg_6_1)
			existCall = var_2_10002

			var_2_10002(arg_1_0.onLoaded, arg_6_1)

			return
		end
	})

	return arg_1_0
end

function var_0_1.Ctor(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.path = arg_7_1
	arg_7_0.onLoaded = arg_7_2

	return
end

return var_0_1
