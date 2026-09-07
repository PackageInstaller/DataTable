local NewNavalTacticsEmptyCard = class("NewNavalTacticsEmptyCard", import(".NewNavalTacticsBaseCard"))

function NewNavalTacticsEmptyCard:OnInit()
	onButton(self, self._tf, function()
		self:emit(NewNavalTacticsLayer.ON_ADD_STUDENT, self.index)

		return
	end, SFX_PANEL)

	return
end

return NewNavalTacticsEmptyCard
