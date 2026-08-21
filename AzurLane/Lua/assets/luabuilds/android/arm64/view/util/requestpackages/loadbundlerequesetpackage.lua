local var_0_0 = class("LoadBundleRequesetPackage", import(".RequestPackage"))

function var_0_0.__call(arg_1_0)
	if arg_1_0.stopped then
		return
	end

	seriesAsync({
		function(arg_2_0)
			pg.UIMgr.GetInstance():LoadingOn()

			local var_2_0 = arg_1_0.path

			xpcall(function()
				AssetBundleHelper.StoreAssetBundle(var_2_0, true, true, function(arg_4_0)
					pg.UIMgr.GetInstance():LoadingOff()

					if arg_1_0.stopped then
						AssetBundleHelper.UnstoreAssetBundle(var_2_0)

						return
					end

					arg_2_0(arg_4_0)

					return
				end)

				return
			end, function(...)
				errorMsg(debug.traceback(...))
				pg.UIMgr.GetInstance():LoadingOff()

				return
			end)

			return
		end,
		function(arg_6_0, arg_6_1)
			existCall(arg_1_0.onLoaded, arg_6_1)

			return
		end
	})

	return arg_1_0
end

function var_0_0.Ctor(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.path = arg_7_1
	arg_7_0.onLoaded = arg_7_2

	return
end

return var_0_0
