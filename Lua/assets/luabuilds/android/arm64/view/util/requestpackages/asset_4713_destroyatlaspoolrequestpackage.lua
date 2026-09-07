local DestroyAtlasPoolRequestPackage = class("DestroyAtlasPoolRequestPackage", import(".RequestPackage"))

function DestroyAtlasPoolRequestPackage:__call()
	if self.stopped then
		return
	end

	if self.callback then
		self.callback(self.path)
	end

	PoolMgr.GetInstance():DestroySprite(self.path)

	return self
end

function DestroyAtlasPoolRequestPackage:Ctor(arg_2_1, arg_2_2)
	self.path = arg_2_1
	self.name = ""
	self.callback = arg_2_2

	return
end

return DestroyAtlasPoolRequestPackage
