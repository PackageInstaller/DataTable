local CryptolaliaProxy = class("CryptolaliaProxy", import(".NetProxy"))

function CryptolaliaProxy:register()
	self.isLoop = false

	return
end

function CryptolaliaProxy:SetLoop(arg_2_1)
	self.isLoop = arg_2_1

	return
end

function CryptolaliaProxy:GetLoop()
	return self.isLoop
end

return CryptolaliaProxy
