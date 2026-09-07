local ReturnPrefabRequestPackage = class("ReturnPrefabRequestPackage", import(".RequestPackage"))

function ReturnPrefabRequestPackage:__call()
	if self.stopped then
		return
	end

	if self.callback then
		self.callback(self.go)
	end

	PoolMgr.GetInstance():ReturnPrefab(self.path, self.name, self.go, true)

	return self
end

function ReturnPrefabRequestPackage:Ctor(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.path = arg_2_1
	self.name = arg_2_2
	self.go = arg_2_3
	self.callback = arg_2_4

	return
end

return ReturnPrefabRequestPackage
