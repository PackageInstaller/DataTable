local LoadBundleRequesetPackage = class("LoadBundleRequesetPackage", import(".RequestPackage"))

function LoadBundleRequesetPackage:__call()
	if self.stopped then
		return
	end

	seriesAsync({
		function(arg_2_0)
			pg.UIMgr.GetInstance():LoadingOn()

			local var_2_0 = self.path

			xpcall(function()
				AssetBundleHelper.StoreAssetBundle(var_2_0, true, true, function(arg_4_0)
					pg.UIMgr.GetInstance():LoadingOff()

					if self.stopped then
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
			existCall(self.onLoaded, arg_6_1)

			return
		end
	})

	return self
end

function LoadBundleRequesetPackage:Ctor(arg_7_1, arg_7_2)
	self.path = arg_7_1
	self.onLoaded = arg_7_2

	return
end

return LoadBundleRequesetPackage
