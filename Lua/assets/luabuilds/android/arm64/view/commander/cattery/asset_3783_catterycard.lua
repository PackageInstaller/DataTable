local CatteryCard = class("CatteryCard")

function CatteryCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = tf(arg_1_1)
	self.lockTF = findTF(self._tf, "lock")
	self.unlockTF = findTF(self._tf, "unlock")
	self.style = self.unlockTF:Find("mask/bg"):GetComponent(typeof(Image))
	self.char = findTF(self.unlockTF, "char")
	self.empty = findTF(self.unlockTF, "empty")
	self.commanderExp = findTF(self.unlockTF, "commander_exp")
	self.bubble = findTF(self.unlockTF, "bubble")
	self.levelTxt = findTF(self.commanderExp, "level/Text"):GetComponent(typeof(Text))
	self.expTxt = findTF(self.commanderExp, "exp/Text"):GetComponent(typeof(Text))
	self.clean = findTF(self.bubble, "clean")
	self.feed = findTF(self.bubble, "feed")
	self.play = findTF(self.bubble, "play")
	self.expAddition = findTF(self.unlockTF, "exp_addition")
	self.expAdditionTxt = self.expAddition:Find("Text"):GetComponent(typeof(Text))

	return
end

function CatteryCard:Update(arg_2_1)
	self.cattery = arg_2_1

	local var_2_0 = arg_2_1:GetState()
	local var_2_1 = var_2_0 == Cattery.STATE_LOCK

	if var_2_0 == Cattery.STATE_LOCK then
		setActive(self.bubble, false)
	elseif var_2_0 == Cattery.STATE_EMPTY then
		self:FlushEmpty()
	elseif var_2_0 == Cattery.STATE_OCCUPATION then
		self:FlushCommander()
	end

	setActive(self.lockTF, var_2_1)
	setActive(self.unlockTF, not var_2_1)
	self:UpdateStyle()

	return
end

function CatteryCard:UpdateStyle()
	local var_3_0 = self.cattery:GetState()

	if var_3_0 ~= Cattery.STATE_LOCK then
		local var_3_1 = self.cattery:_GetStyle_()

		self.style.sprite = var_3_0 == Cattery.STATE_EMPTY and GetSpriteFromAtlas("CatteryStyle/" .. var_3_1:GetName(false), "") or GetSpriteFromAtlas("CatteryStyle/" .. var_3_1:GetName(self.cattery:IsDirty()), "")
	end

	return
end

function CatteryCard:FlushEmpty()
	setActive(self.empty, true)
	setActive(self.commanderExp, false)
	setActive(self.bubble, false)
	self:ReturnChar()
	self:InitBubble()

	return
end

function CatteryCard:FlushCommander()
	setActive(self.empty, false)
	setActive(self.commanderExp, true)
	setActive(self.bubble, true)

	local var_5_0 = self.cattery:GetCommander()

	self.levelTxt.text = "LV." .. var_5_0:getLevel()
	self.expTxt.text = var_5_0.exp .. "/" .. var_5_0:getNextLevelExp()

	self:LoadChar(var_5_0)
	self:InitBubble()

	return
end

function CatteryCard:LoadChar(arg_6_1)
	self.painting = arg_6_1:getPainting()

	setCommanderPaintingPrefab(self.char, self.painting, "info")

	return
end

function CatteryCard:ReturnChar()
	if self.painting then
		retCommanderPaintingPrefab(self.char, self.painting)

		self.painting = nil
	end

	return
end

function CatteryCard:InitBubble()
	local var_8_0 = self.cattery:ExistCleanOP()
	local var_8_1 = self.cattery:ExiseFeedOP()
	local var_8_2 = self.cattery:ExistPlayOP()

	setActive(self.clean, var_8_0)
	setActive(self.feed, var_8_1)
	setActive(self.play, var_8_2)
	setActive(self.bubble, var_8_0 or var_8_1 or var_8_2)

	return
end

function CatteryCard:AddExpAnim(arg_9_1, arg_9_2)
	self:RemoveTimer()

	self.expAdditionTxt.text = arg_9_1

	setActive(self.expAddition, true)

	self.timer = Timer.New(function()
		self:RemoveTimer()
		setActive(self.expAddition, false)
		arg_9_2()

		return
	end, 1, 1)

	self.timer:Start()

	return
end

function CatteryCard:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CatteryCard:Dispose()
	self:ReturnChar()
	self:RemoveTimer()

	return
end

return CatteryCard
