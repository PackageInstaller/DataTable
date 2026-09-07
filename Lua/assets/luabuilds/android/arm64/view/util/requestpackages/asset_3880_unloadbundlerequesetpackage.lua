local UnloadBundleRequesetPackage = class("UnloadBundleRequesetPackage", import(".RequestPackage"))

function UnloadBundleRequesetPackage:__call()
	if self.stopped then
		return
	end

	AssetBundleHelper.UnstoreAssetBundle(self.path, true)

	return self
end

function UnloadBundleRequesetPackage:Ctor(arg_2_1)
	self.path = arg_2_1

	return
end

return UnloadBundleRequesetPackage
