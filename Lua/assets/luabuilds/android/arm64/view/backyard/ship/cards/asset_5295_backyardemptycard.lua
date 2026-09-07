local BackYardEmptyCard = class("BackYardEmptyCard", import(".BackYardBaseCard"))

function BackYardEmptyCard:OnInit()
	onButton(self, self._content, function()
		self:emit(NewBackYardShipInfoMediator.OPEN_CHUANWU, self.type)

		return
	end, SFX_PANEL)

	return
end

return BackYardEmptyCard
