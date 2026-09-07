local GetSpineRequestPackage = class("GetSpineRequestPackage", import(".RequestPackage"))

function GetSpineRequestPackage:__call()
	if self.stopped then
		return
	end

	local var_1_0 = self.name

	self.spineChar = SpineAnimChar.New()

	self.spineChar:SetPaint(var_1_0)
	self.spineChar:Load(true, function(arg_2_0)
		if self.stopped then
			arg_2_0:Dispose()

			return
		end

		if self.onLoaded then
			self.onLoaded(arg_2_0)
		end

		return
	end)

	return self
end

function GetSpineRequestPackage:Ctor(arg_3_1, arg_3_2)
	self.name = arg_3_1
	self.path = "Spine"
	self.onLoaded = arg_3_2

	return
end

return GetSpineRequestPackage
