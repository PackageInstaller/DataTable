local CommanderCard = class("CommanderCard")

function CommanderCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = tf(arg_1_1)
	self.infoTF = self._tf:Find("info")
	self.emptyTF = self._tf:Find("empty")
	self.quitTF = self._tf:Find("quit")
	self.scrollTxt = self.infoTF:Find("name_bg/mask/Text"):GetComponent("ScrollText")
	self.levelTF = self.infoTF:Find("level_bg/Text"):GetComponent(typeof(Text))
	self.iconTF = self.infoTF:Find("icon")
	self.mark2 = self.infoTF:Find("mark1")
	self.mark1 = self.infoTF:Find("mark2")

	setActive(self.mark1, false)
	setActive(self.mark2, false)

	self.expUp = self._tf:Find("up")

	setActive(self.expUp, false)

	self.formationTF = self.infoTF:Find("formation")
	self.inbattleTF = self.infoTF:Find("inbattle")

	setActive(self.inbattleTF, false)
	setActive(self.formationTF, false)

	self.tip = self._tf:Find("tip")

	setActive(self.tip, false)

	self.lockTr = self._tf:Find("lock")

	return
end

function CommanderCard:clearSelected()
	setActive(self.mark1, false)
	setActive(self.mark2, false)
	setActive(self.expUp, false)
	self:UpdateCommanderName(self.commanderVO, false)

	return
end

function CommanderCard:selectedAnim()
	if LeanTween.isTweening(self.infoTF) then
		LeanTween.cancel(self.infoTF)
	end

	LeanTween.moveY(rtf(self.infoTF), 20, 0.1):setOnComplete(System.Action(function()
		LeanTween.moveY(rtf(self.infoTF), 0, 0.1)

		return
	end))
	self:UpdateCommanderName(self.commanderVO, true)

	return
end

function CommanderCard:update(arg_5_1)
	if not IsNil(self.lockTr) then
		setActive(self.lockTr, false)
	end

	if arg_5_1 then
		self.commanderVO = arg_5_1

		if arg_5_1.id ~= 0 then
			self:updateCommander()
		end
	end

	local var_5_0

	if arg_5_1 then
		::label_5_0::

		var_5_0 = arg_5_1.inFleet and not arg_5_1.inBattle
	end

	setActive(self.formationTF, var_5_0)
	setActive(self.inbattleTF, arg_5_1 and arg_5_1.inBattle)
	setActive(self.infoTF, arg_5_1 and arg_5_1.id ~= 0)
	setActive(self.emptyTF, not arg_5_1)
	setActive(self.quitTF, arg_5_1 and arg_5_1.id == 0)
	setActive(self.tip, arg_5_1 and arg_5_1.id ~= 0 and arg_5_1:getTalentPoint() > 0 and not LOCK_COMMANDER_TALENT_TIP)

	return
end

function CommanderCard:updateCommander()
	self:UpdateCommanderName(self.commanderVO, false)

	self.levelTF.text = self.commanderVO.level

	GetImageSpriteFromAtlasAsync("commandericon/" .. self.commanderVO:getPainting(), "", self.iconTF)

	if not IsNil(self.lockTr) then
		setActive(self.lockTr, self.commanderVO:isLocked())
	end

	return
end

function CommanderCard:UpdateCommanderName(arg_7_1, arg_7_2)
	if not arg_7_1 or arg_7_1.id == 0 then
		return
	end

	if arg_7_2 then
		self.scrollTxt:SetText(arg_7_1:getName())
	else
		self.scrollTxt:SetText(self:ShortenString(arg_7_1:getName(), 6))
	end

	return
end

function CommanderCard:ShortenString(arg_8_1, arg_8_2)
	local function var_8_0(arg_9_0)
		if not arg_9_0 then
			return 0, 1
		elseif arg_9_0 > 240 then
			return 4, 1
		elseif arg_9_0 > 225 then
			return 3, 1
		elseif arg_9_0 > 192 then
			return 2, 1
		elseif arg_9_0 < 126 then
			return 1, 0.75
		else
			return 1, 1
		end

		return
	end

	local var_8_1 = 1
	local var_8_2 = 0
	local var_8_3 = 0
	local var_8_4 = false

	while var_8_1 <= #arg_8_1 do
		local var_8_5, var_8_6 = var_8_0((string.byte(arg_8_1, var_8_1)))

		var_8_1 = var_8_1 + var_8_5
		var_8_2 = var_8_2 + var_8_6

		local var_8_7 = math.ceil(var_8_2)

		if var_8_7 == arg_8_2 - 1 then
			var_8_3 = var_8_1
		elseif arg_8_2 < var_8_7 then
			var_8_4 = true

			break
		end
	end

	if var_8_3 == 0 or #arg_8_1 < var_8_3 or not var_8_4 then
		return arg_8_1
	end

	return string.sub(arg_8_1, 1, var_8_3 - 1) .. ".."
end

function CommanderCard:clear()
	if LeanTween.isTweening(self.infoTF) then
		LeanTween.cancel(self.infoTF)
	end

	return
end

function CommanderCard:Dispose()
	self:clear()

	return
end

return CommanderCard
