local PlayerVitaeBaseCard = class("PlayerVitaeBaseCard")
local var_0_1 = 160
local var_0_2 = 25

function PlayerVitaeBaseCard:Ctor(arg_1_1, arg_1_2)
	self.event = arg_1_2

	pg.DelegateInfo.New(self)
	self:Init(arg_1_1)

	return
end

function PlayerVitaeBaseCard:Init(arg_2_1)
	self._go = arg_2_1
	self._tf = arg_2_1.transform
	self.width = self._tf.sizeDelta.x
	self.mask = self._tf:Find("mask")

	self:OnInit()

	return
end

function PlayerVitaeBaseCard:UpdatePosition(arg_3_1)
	self._tf.anchoredPosition3D = Vector3(var_0_1 + (self.width + var_0_2) * (arg_3_1 - 1), 0, 0)

	self._tf:SetSiblingIndex(arg_3_1 - 1)

	return
end

function PlayerVitaeBaseCard:Update(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	self:OnUpdate(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	self:UpdatePosition(arg_4_1)

	return
end

function PlayerVitaeBaseCard:Enable()
	setActive(self._tf, true)

	return
end

function PlayerVitaeBaseCard:Disable()
	setActive(self._tf, false)

	return
end

function PlayerVitaeBaseCard:Clone()
	return _G[self.__cname].New(cloneTplTo(self._go, self._go.parent), self.event)
end

function PlayerVitaeBaseCard:emit(...)
	if self.event then
		self.event:emit(...)
	end

	return
end

function PlayerVitaeBaseCard:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:OnDispose()

	return
end

function PlayerVitaeBaseCard:OnInit()
	return
end

function PlayerVitaeBaseCard:OnUpdate(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	return
end

function PlayerVitaeBaseCard:OnDispose()
	return
end

return PlayerVitaeBaseCard
