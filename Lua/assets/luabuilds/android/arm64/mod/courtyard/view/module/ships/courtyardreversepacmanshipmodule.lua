local CourtYardReversePacmanShipModule = class("CourtYardReversePacmanShipModule", import(".CourtYardShipModule"))

function CourtYardReversePacmanShipModule:OnInit()
	CourtYardReversePacmanShipModule.super.OnInit(self)

	self.chatBubble = self._tf:Find("reversePacmanAttachments/chat")
	self.chatBubbleTxt = self._tf:Find("reversePacmanAttachments/chat/Text"):GetComponent(typeof(Text))

	setActive(self.chatBubble, false)

	return
end

function CourtYardReversePacmanShipModule:AddListeners()
	CourtYardReversePacmanShipModule.super.AddListeners(self)
	self:AddListener(CourtYardEvent.REVERSE_PACMAN_CHAT_BUBBLE, self.OnShowText)

	return
end

function CourtYardReversePacmanShipModule:RemoveListeners()
	CourtYardReversePacmanShipModule.super.RemoveListeners(self)
	self:RemoveListener(CourtYardEvent.REVERSE_PACMAN_CHAT_BUBBLE, self.OnShowText)

	return
end

function CourtYardReversePacmanShipModule:OnShowText(arg_4_1)
	if pg.activity_chasing_character[self.data.roleID].random_talk[1] == nil then
		return
	end

	setActive(self.chatBubble, true)
	setText(self.chatBubbleTxt, ShipWordHelper.GetShipWord(pg.activity_chasing_character[self.data.roleID].random_talk[1], pg.activity_chasing_character[self.data.roleID].random_talk[2][math.random(1, #pg.activity_chasing_character[self.data.roleID].random_talk[2])], {}))
	self:DisappearTimer()

	return
end

function CourtYardReversePacmanShipModule:DisappearTimer()
	self.disappearTimer = Timer.New(function()
		setActive(self.chatBubble, false)
		self:RemoveDisappearTimer()

		return
	end, CourtYardConst.REVERSE_PACMAN_CHAT_SHOW_TIME, 1)

	self.disappearTimer:Start()

	return
end

function CourtYardReversePacmanShipModule:RemoveDisappearTimer()
	if self.disappearTimer then
		self.disappearTimer:Stop()

		self.disappearTimer = nil
	end

	return
end

function CourtYardReversePacmanShipModule:OnDispose()
	self:RemoveDisappearTimer()
	CourtYardReversePacmanShipModule.super.OnDispose(self)

	return
end

return CourtYardReversePacmanShipModule
