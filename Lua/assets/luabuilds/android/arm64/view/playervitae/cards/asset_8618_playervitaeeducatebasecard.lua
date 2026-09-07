local PlayerVitaeEducateBaseCard = class("PlayerVitaeEducateBaseCard", import("view.base.BaseEventLogic"))

function PlayerVitaeEducateBaseCard:Ctor(arg_1_1, arg_1_2)
	PlayerVitaeEducateBaseCard.super.Ctor(self, arg_1_2)
	pg.DelegateInfo.New(self)

	self._tf = arg_1_1
	self._go = arg_1_1.gameObject

	return
end

function PlayerVitaeEducateBaseCard:ShowOrHide(arg_2_1)
	setActive(self._tf, arg_2_1)

	if not arg_2_1 then
		self:Clear()
	end

	return
end

function PlayerVitaeEducateBaseCard:Flush()
	return
end

function PlayerVitaeEducateBaseCard:Clear()
	return
end

function PlayerVitaeEducateBaseCard:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:Clear()

	return
end

return PlayerVitaeEducateBaseCard
