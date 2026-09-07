local LoadPrefabRequestPackage = class("LoadPrefabRequestPackage", import(".RequestPackage"))

function LoadPrefabRequestPackage:__call()
	if self.stopped then
		return
	end

	LoadAnyAsync(self.path, self.name, nil, function(arg_2_0)
		if self.stopped then
			return
		end

		if self.onLoaded then
			self.onLoaded((Object.Instantiate(arg_2_0)))
		end

		return
	end)

	return self
end

function LoadPrefabRequestPackage:Ctor(arg_3_1, arg_3_2, arg_3_3)
	self.path = arg_3_1
	self.name = arg_3_2
	self.onLoaded = arg_3_3

	return
end

return LoadPrefabRequestPackage
