local NewNavalTacticsLockCard = class("NewNavalTacticsLockCard", import(".NewNavalTacticsBaseCard"))

function NewNavalTacticsLockCard:UnlockCnt2ShopId(arg_1_1)
	return ({
		21,
		22
	})[arg_1_1 - 1]
end

function NewNavalTacticsLockCard:OnInit()
	onButton(self, self._tf, function()
		self:emit(NewNavalTacticsLayer.ON_UNLOCK, (self:UnlockCnt2ShopId((getProxy(NavalAcademyProxy):getSkillClassNum()))))

		return
	end, SFX_PANEL)

	return
end

return NewNavalTacticsLockCard
