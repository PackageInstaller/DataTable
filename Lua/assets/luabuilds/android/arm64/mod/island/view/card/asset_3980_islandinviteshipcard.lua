local IslandInviteShipCard = class("IslandInviteShipCard")

function IslandInviteShipCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.selectedTF = self._tf:Find("frame/sel")
	self.selectedDotTF = self._tf:Find("frame/sel_dot")
	self.frameTF = self._tf:Find("frame")
	self.iconTF = self.frameTF:Find("main")
	self.textTF = self.frameTF:Find("main/Text")

	return
end

function IslandInviteShipCard:Update(arg_2_1, arg_2_2)
	self.item = arg_2_1

	setText(self.textTF, "")
	GetImageSpriteFromAtlasAsync(string.format("island/islandInvitation/invite_%s", self.item.shipId), "", self.iconTF)
	self:UpdateSelected(arg_2_2)

	return
end

function IslandInviteShipCard:UpdateSelected(arg_3_1)
	local var_3_0 = arg_3_1 and arg_3_1 == self.item.shipId

	SetCompomentEnabled(self.frameTF, "EventTriggerListener", arg_3_1 and arg_3_1 == self.item.shipId)
	setActive(self.selectedTF, var_3_0)
	setActive(self.selectedDotTF, var_3_0)
	setLocalScale(self.frameTF, {
		x = var_3_0 and 1 or 0.8,
		y = var_3_0 and 1 or 0.8,
		z = var_3_0 and 1 or 0.8
	})

	return
end

function IslandInviteShipCard:Dispose()
	return
end

return IslandInviteShipCard
