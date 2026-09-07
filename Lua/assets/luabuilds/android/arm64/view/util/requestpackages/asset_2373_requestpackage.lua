local RequestPackage = class("RequestPackage")

function RequestPackage:Start(...)
	if self.__call then
		self:__call(...)
	end

	return self
end

function RequestPackage:Stop()
	setmetatable(self, nil)
	table.clear(self)

	self.stopped = true

	return
end

return RequestPackage
