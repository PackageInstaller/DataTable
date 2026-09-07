local GetPrefabRequestPackage = class("GetPrefabRequestPackage", import(".RequestPackage"))

function GetPrefabRequestPackage:__call()
	if self.stopped then
		return
	end

	local var_1_0 = self.path
	local var_1_1 = self.name

	PoolMgr.GetInstance():GetPrefab(self.path, self.name, true, function(arg_2_0)
		if self.stopped then
			PoolMgr.GetInstance():ReturnPrefab(var_1_0, var_1_1, arg_2_0, true)

			return
		end

		if self.onLoaded then
			self.onLoaded(arg_2_0)
		end

		return
	end)

	return self
end

function GetPrefabRequestPackage:Ctor(arg_3_1, arg_3_2, arg_3_3)
	self.path = arg_3_1
	self.name = arg_3_2
	self.onLoaded = arg_3_3

	return
end

return GetPrefabRequestPackage
