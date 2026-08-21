local var_0_0 = class("CatteryCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_1)
	arg_1_0.lockTF = findTF(arg_1_0._tf, "lock")
	arg_1_0.unlockTF = findTF(arg_1_0._tf, "unlock")
	arg_1_0.style = arg_1_0.unlockTF:Find("mask/bg"):GetComponent(typeof(Image))
	arg_1_0.char = findTF(arg_1_0.unlockTF, "char")
	arg_1_0.empty = findTF(arg_1_0.unlockTF, "empty")
	arg_1_0.commanderExp = findTF(arg_1_0.unlockTF, "commander_exp")
	arg_1_0.bubble = findTF(arg_1_0.unlockTF, "bubble")
	arg_1_0.levelTxt = findTF(arg_1_0.commanderExp, "level/Text"):GetComponent(typeof(Text))
	arg_1_0.expTxt = findTF(arg_1_0.commanderExp, "exp/Text"):GetComponent(typeof(Text))
	arg_1_0.clean = findTF(arg_1_0.bubble, "clean")
	arg_1_0.feed = findTF(arg_1_0.bubble, "feed")
	arg_1_0.play = findTF(arg_1_0.bubble, "play")
	arg_1_0.expAddition = findTF(arg_1_0.unlockTF, "exp_addition")
	arg_1_0.expAdditionTxt = arg_1_0.expAddition:Find("Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.cattery = arg_2_1

	local var_2_0 = arg_2_1:GetState()
	local var_2_1 = var_2_0 == Cattery.STATE_LOCK

	if var_2_0 == Cattery.STATE_LOCK then
		setActive(arg_2_0.bubble, false)
	elseif var_2_0 == Cattery.STATE_EMPTY then
		arg_2_0:FlushEmpty()
	elseif var_2_0 == Cattery.STATE_OCCUPATION then
		arg_2_0:FlushCommander()
	end

	setActive(arg_2_0.lockTF, var_2_1)
	setActive(arg_2_0.unlockTF, not var_2_1)
	arg_2_0:UpdateStyle()

	return
end

function var_0_0.UpdateStyle(arg_3_0)
	local var_3_0 = arg_3_0.cattery:GetState()

	if var_3_0 ~= Cattery.STATE_LOCK then
		local var_3_1 = arg_3_0.cattery:_GetStyle_()

		arg_3_0.style.sprite = var_3_0 == Cattery.STATE_EMPTY and GetSpriteFromAtlas("CatteryStyle/" .. var_3_1:GetName(false), "") or GetSpriteFromAtlas("CatteryStyle/" .. var_3_1:GetName(arg_3_0.cattery:IsDirty()), "")
	end

	return
end

function var_0_0.FlushEmpty(arg_4_0)
	setActive(arg_4_0.empty, true)
	setActive(arg_4_0.commanderExp, false)
	setActive(arg_4_0.bubble, false)
	arg_4_0:ReturnChar()
	arg_4_0:InitBubble()

	return
end

function var_0_0.FlushCommander(arg_5_0)
	setActive(arg_5_0.empty, false)
	setActive(arg_5_0.commanderExp, true)
	setActive(arg_5_0.bubble, true)

	local var_5_0 = arg_5_0.cattery:GetCommander()

	arg_5_0.levelTxt.text = "LV." .. var_5_0:getLevel()
	arg_5_0.expTxt.text = var_5_0.exp .. "/" .. var_5_0:getNextLevelExp()

	arg_5_0:LoadChar(var_5_0)
	arg_5_0:InitBubble()

	return
end

function var_0_0.LoadChar(arg_6_0, arg_6_1)
	arg_6_0.painting = arg_6_1:getPainting()

	setCommanderPaintingPrefab(arg_6_0.char, arg_6_0.painting, "info")

	return
end

function var_0_0.ReturnChar(arg_7_0)
	if arg_7_0.painting then
		retCommanderPaintingPrefab(arg_7_0.char, arg_7_0.painting)

		arg_7_0.painting = nil
	end

	return
end

function var_0_0.InitBubble(arg_8_0)
	local var_8_0 = arg_8_0.cattery:ExistCleanOP()
	local var_8_1 = arg_8_0.cattery:ExiseFeedOP()
	local var_8_2 = arg_8_0.cattery:ExistPlayOP()

	setActive(arg_8_0.clean, var_8_0)
	setActive(arg_8_0.feed, var_8_1)
	setActive(arg_8_0.play, var_8_2)
	setActive(arg_8_0.bubble, var_8_0 or var_8_1 or var_8_2)

	return
end

function var_0_0.AddExpAnim(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:RemoveTimer()

	arg_9_0.expAdditionTxt.text = arg_9_1

	setActive(arg_9_0.expAddition, true)

	arg_9_0.timer = Timer.New(function()
		arg_9_0:RemoveTimer()
		setActive(arg_9_0.expAddition, false)
		arg_9_2()

		return
	end, 1, 1)

	arg_9_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_11_0)
	if arg_11_0.timer then
		arg_11_0.timer:Stop()

		arg_11_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:ReturnChar()
	arg_12_0:RemoveTimer()

	return
end

return var_0_0
