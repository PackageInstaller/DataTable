local CommanderCatCard = class("CommanderCatCard")

CommanderCatCard.MARK_TYPE_CIRCLE = 1
CommanderCatCard.MARK_TYPE_TICK = 2

function CommanderCatCard:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1
	self._tf = tf(arg_1_1)
	self.infoTF = self._tf:Find("info")
	self.emptyTF = self._tf:Find("empty")
	self.quitTF = self._tf:Find("quit")
	self.scrollTxt = self.infoTF:Find("name_bg/mask/Text"):GetComponent("ScrollText")
	self.levelTF = self.infoTF:Find("level_bg/Text"):GetComponent(typeof(Text))
	self.iconTF = self.infoTF:Find("icon")
	self.marks = {
		self.infoTF:Find("mark1"),
		self.infoTF:Find("mark2")
	}
	self.expUp = self._tf:Find("up")
	self.formationTF = self.infoTF:Find("formation")

	setActive(self.formationTF, false)

	self.inbattleTF = self.infoTF:Find("inbattle")

	setActive(self.inbattleTF, false)

	self.tip = self._tf:Find("tip")

	setActive(self.tip, false)

	self.lockTr = self._tf:Find("lock")

	for iter_1_0, iter_1_1 in ipairs(self.marks) do
		setActive(iter_1_1, false)
	end

	self.mark = self.marks[arg_1_2] or self.marks[1]

	setActive(self.expUp, false)

	return
end

function CommanderCatCard:Update(arg_2_1, arg_2_2, arg_2_3)
	if not IsNil(self.lockTr) then
		setActive(self.lockTr, false)
	end

	if arg_2_1 then
		self.commanderVO = arg_2_1

		if arg_2_1.id ~= 0 then
			self:UpdateCommander(arg_2_2, arg_2_3)
		end
	end

	local var_2_0

	if arg_2_1 then
		::label_2_0::

		var_2_0 = arg_2_1.inFleet and not arg_2_1.inBattle
	end

	setActive(self.formationTF, var_2_0)
	setActive(self.inbattleTF, arg_2_1 and arg_2_1.inBattle)
	setActive(self.infoTF, arg_2_1 and arg_2_1.id ~= 0)
	setActive(self.emptyTF, not arg_2_1)
	setActive(self.quitTF, arg_2_1 and arg_2_1.id == 0)
	setActive(self.tip, arg_2_1 and arg_2_1.id ~= 0 and arg_2_1:getTalentPoint() > 0 and not LOCK_COMMANDER_TALENT_TIP)

	return
end

function CommanderCatCard:UpdateCommander(arg_3_1, arg_3_2)
	self.levelTF.text = self.commanderVO.level

	GetImageSpriteFromAtlasAsync("commandericon/" .. self.commanderVO:getPainting(), "", self.iconTF)

	if not IsNil(self.lockTr) then
		setActive(self.lockTr, self.commanderVO:isLocked())
	end

	self:UpdateSelected(arg_3_1, arg_3_2)

	return
end

function CommanderCatCard:UpdateSelected(arg_4_1, arg_4_2)
	if not self.commanderVO then
		setActive(self.mark, false)

		return
	end

	local var_4_0 = table.contains(arg_4_1 or {}, self.commanderVO.id)

	setActive(self.mark, var_4_0)
	self:UpdateCommanderName(var_4_0, arg_4_2)

	return
end

function CommanderCatCard:UpdateCommanderName(arg_5_1, arg_5_2)
	if not self.commanderVO or self.commanderVO.id == 0 then
		self.scrollTxt:SetText("")

		return
	end

	if arg_5_1 then
		self.scrollTxt:SetText(self.commanderVO:getName(arg_5_2))
	else
		self.scrollTxt:SetText(CommanderCatUtil.ShortenString(self.commanderVO:getName(arg_5_2), 6))
	end

	return
end

function CommanderCatCard:Dispose()
	return
end

return CommanderCatCard
