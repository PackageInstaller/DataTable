local NewNavalTacticsBaseCard = class("NewNavalTacticsBaseCard")

function NewNavalTacticsBaseCard:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self.event = arg_1_2
	self._tf = arg_1_1
	self._go = arg_1_1.gameObject

	self:OnInit()

	return
end

function NewNavalTacticsBaseCard:emit(...)
	if self.event then
		self.event:emit(...)
	end

	return
end

function NewNavalTacticsBaseCard:UpdatePosition(arg_3_1)
	self._tf.anchoredPosition3D = Vector3(-493 + (arg_3_1 - 1) * (self._tf.sizeDelta.x + 0), self._tf.anchoredPosition3D.y, 0)

	return
end

function NewNavalTacticsBaseCard:Update(arg_4_1, arg_4_2)
	self.index = arg_4_1

	self:UpdatePosition(arg_4_1)
	self:OnUpdate(arg_4_2)

	return
end

function NewNavalTacticsBaseCard:Enable()
	setActive(self._go, true)

	return
end

function NewNavalTacticsBaseCard:Disable()
	setActive(self._go, false)

	return
end

function NewNavalTacticsBaseCard:Dispose()
	pg.DelegateInfo.Dispose(self)
	Object.Destroy(self._go)
	self:OnDispose()

	return
end

function NewNavalTacticsBaseCard:Clone()
	local var_8_0 = Object.Instantiate(self._go, self._tf.parent)

	assert(var_8_0)

	return _G[self.__cname].New(var_8_0.transform, self.event)
end

function NewNavalTacticsBaseCard:OnInit()
	return
end

function NewNavalTacticsBaseCard:OnUpdate(arg_10_1)
	return
end

function NewNavalTacticsBaseCard:OnDispose()
	return
end

return NewNavalTacticsBaseCard
