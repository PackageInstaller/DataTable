local CommanderHomeLevelCard = class("CommanderHomeLevelCard")
local var_0_1 = "#9A9898"
local var_0_2 = "#a59897"
local var_0_3 = "#6a5a5a"

function CommanderHomeLevelCard:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.view = arg_1_2
	self.mask = findTF(self._tf, "mask"):GetComponent(typeof(RectMask2D))
	self.progress = findTF(self._tf, "mask/progress/bar")
	self.unlockTF = findTF(self._tf, "unlock")
	self.doingTF = findTF(self._tf, "doing")
	self.lockTF = findTF(self._tf, "lock")
	self.levelTxt = findTF(self._tf, "level"):GetComponent(typeof(Text))
	self.descUnLockIcon = findTF(self._tf, "desc/icon_pass")
	self.descDoingIcon = findTF(self._tf, "desc/icon_doing")
	self.descTxt = findTF(self._tf, "desc/Text"):GetComponent(typeof(Text))
	self.expTxt = findTF(self._tf, "exp"):GetComponent(typeof(Text))

	return
end

function CommanderHomeLevelCard:Update(arg_2_1, arg_2_2)
	self:Clear()

	self.home = arg_2_1
	self.config = arg_2_2
	self.mask.enabled = arg_2_2.tail == true

	setActive(self.unlockTF, false)
	setActive(self.doingTF, false)
	setActive(self.lockTF, false)
	setActive(self.descUnLockIcon, false)
	setActive(self.descDoingIcon, false)

	local var_2_1

	if arg_2_1.level + 1 == arg_2_2.level then
		self:UpdateDoingState()

		var_2_1 = var_0_3
	elseif arg_2_1.level < arg_2_2.level then
		self:UpdateLockState()

		var_2_1 = var_0_1
	elseif arg_2_1.level >= arg_2_2.level then
		self:UpdateUnlockState()

		var_2_1 = var_0_2
	end

	self.levelTxt.text = setColorStr("LV." .. arg_2_2.level, var_2_1)
	self.descTxt.text = setColorStr(shortenString(arg_2_2.desc, 12), var_2_1)
	self.expTxt.text = setColorStr(arg_2_2.totalExp, var_2_1)

	return
end

function CommanderHomeLevelCard:UpdateLockState()
	setFillAmount(self.progress, 0)
	setActive(self.lockTF, true)
	onButton(nil, self.lockTF, function()
		self:ShowDesc()

		return
	end, SFX_PANEL)

	return
end

function CommanderHomeLevelCard:UpdateDoingState()
	setFillAmount(self.progress, self.home.exp / ((pg.commander_home[self.config.level - 1] or nil) and pg.commander_home[self.config.level - 1].home_exp))
	setActive(self.doingTF, true)
	setActive(self.descDoingIcon, true)
	onButton(nil, self.doingTF, function()
		self:ShowDesc()

		return
	end, SFX_PANEL)

	return
end

function CommanderHomeLevelCard:UpdateUnlockState()
	setFillAmount(self.progress, 1)
	setActive(self.unlockTF, true)
	setActive(self.descUnLockIcon, true)
	onButton(nil, self.unlockTF, function()
		self:ShowDesc()

		return
	end, SFX_PANEL)

	return
end

function CommanderHomeLevelCard:ShowDesc()
	self.view:ShowDescWindow(self.config.desc, self.config.level)

	return
end

function CommanderHomeLevelCard:Clear()
	removeOnButton(self.lockTF)
	removeOnButton(self.doingTF)
	removeOnButton(self.unlockTF)

	return
end

function CommanderHomeLevelCard:Dispose()
	self:Clear()

	return
end

return CommanderHomeLevelCard
