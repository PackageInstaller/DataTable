local ReturnSpineRequestPackage = class("ReturnSpineRequestPackage", import(".RequestPackage"))

function ReturnSpineRequestPackage:__call()
	if self.stopped then
		return
	end

	if self.callback then
		self.callback(self.spineChar)
	end

	self.spineChar:Dispose()

	return self
end

function ReturnSpineRequestPackage:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.path = "Spine"
	self.name = arg_2_1
	self.spineChar = arg_2_2
	self.callback = arg_2_3

	return
end

return ReturnSpineRequestPackage
