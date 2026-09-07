local RandomDockYardCard = class("RandomDockYardCard")

function RandomDockYardCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.npcTr = findTF(self._tf, "content/dockyard/npc")
	self.nameTF = findTF(self._tf, "content/info/name_mask/name")
	self.lockTr = findTF(self._tf, "content/dockyard/container/lock")
	self.selected = findTF(self._tf, "content/front/selected")
	self.existAnim = false

	ClearTweenItemAlphaAndWhite(self._go)

	return
end

function RandomDockYardCard:Update(arg_2_1, arg_2_2)
	TweenItemAlphaAndWhite(self._go)

	if not self.ship or self.ship.id ~= arg_2_1.id then
		self.ship = arg_2_1

		self:Flush()
	end

	self:UpdateSelected(arg_2_2)

	return
end

function RandomDockYardCard:UpdateSelected(arg_3_1)
	setActive(self.selected, arg_3_1)

	if not arg_3_1 then
		self.existAnim = false

		LeanTween.cancel(self.selected.gameObject)
	elseif self.existAnim then
		-- block empty
	else
		self.existAnim = true

		blinkAni(self.selected, 0.6, -1, 0.3):setFrom(1)
	end

	return
end

function RandomDockYardCard:Flush()
	flushShipCard(self._tf, self.ship)
	setActive(self.npcTr, self.ship:isActivityNpc())
	setText(self.nameTF, self.ship:GetColorName(shortenString(self.ship:getName(), PLATFORM_CODE == PLATFORM_US and 6 or 7)))
	self.lockTr.gameObject:SetActive(self.ship:GetLockState() == Ship.LOCK_STATE_LOCK)

	return
end

function RandomDockYardCard:Dispose()
	ClearTweenItemAlphaAndWhite(self._go)
	self:UpdateSelected(false)

	return
end

return RandomDockYardCard
