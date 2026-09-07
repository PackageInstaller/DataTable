local LoadReferenceRequestPackage = class("LoadReferenceRequestPackage", import(".RequestPackage"))

function LoadReferenceRequestPackage:__call()
	if self.stopped then
		return
	end

	LoadAnyAsync(self.path, self.name, self.type, function(arg_2_0)
		if self.stopped then
			return
		end

		if self.onLoaded then
			self.onLoaded(arg_2_0)
		end

		return
	end)

	return self
end

function LoadReferenceRequestPackage:Ctor(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.path = arg_3_1
	self.name = arg_3_2
	self.type = arg_3_3
	self.onLoaded = arg_3_4

	return
end

return LoadReferenceRequestPackage
