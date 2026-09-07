local PlayerVitaeEducateAddCard = class("PlayerVitaeEducateAddCard", import(".PlayerVitaeEducateBaseCard"))

function PlayerVitaeEducateAddCard:Flush()
	onButton(self, self._tf, function()
		self:emit(PlayerVitaeMediator.ON_SEL_EDUCATE_CHAR)

		return
	end, SFX_PANEL)

	return
end

function PlayerVitaeEducateAddCard:Clear()
	removeOnButton(self._tf)

	return
end

return PlayerVitaeEducateAddCard
