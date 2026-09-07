local LoadLive2dRequestPackage = class("LoadLive2dRequestPackage", import(".RequestPackage"))

function LoadLive2dRequestPackage:__call()
	if self.stopped then
		return
	end

	ResourceMgr.Inst:getAssetAsync(self.path, self.name, UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_2_0)
		if self.stopped then
			return
		end

		if self.onLoaded then
			self.onLoaded((Object.Instantiate(arg_2_0)))
		end

		return
	end), true, true)

	return self
end

function LoadLive2dRequestPackage:Ctor(arg_3_1, arg_3_2, arg_3_3)
	self.path = arg_3_1
	self.name = arg_3_2
	self.onLoaded = arg_3_3

	return
end

return LoadLive2dRequestPackage
