local BackYardBaseCard = class("BackYardBaseCard")

function BackYardBaseCard:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self.event = arg_1_2
	self._go = arg_1_1
	self._content = arg_1_1:Find("content")

	self:OnInit()

	self.startPos = Vector2(135, -354)
	self.space = 255

	return
end

function BackYardBaseCard:Disable()
	setActive(self._go, false)

	return
end

function BackYardBaseCard:Enable()
	setActive(self._go, true)

	return
end

function BackYardBaseCard:Flush(arg_4_1, arg_4_2)
	self.type = arg_4_1
	self.ship = arg_4_2

	self:OnFlush()

	return
end

function BackYardBaseCard:emit(...)
	if self.event then
		self.event:emit(...)
	end

	return
end

function BackYardBaseCard:Clone()
	return _G[self.__cname].New(cloneTplTo(self._go, self._go.parent), self.event)
end

function BackYardBaseCard:SetSiblingIndex(arg_7_1)
	self._go.gameObject.name = arg_7_1
	self._go.anchoredPosition3D = Vector3(self.startPos.x + (arg_7_1 - 1) * self.space, self.startPos.y, 0)

	return
end

function BackYardBaseCard:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:OnDispose()

	if not IsNil(self._go) then
		Object.Destroy(self._go.gameObject)
	end

	return
end

function BackYardBaseCard:OnInit()
	return
end

function BackYardBaseCard:OnFlush()
	return
end

function BackYardBaseCard:OnDispose()
	return
end

return BackYardBaseCard
