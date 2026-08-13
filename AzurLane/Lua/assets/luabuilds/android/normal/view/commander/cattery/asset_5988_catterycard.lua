class = var_0_10000

local var_0_0 = var_0_10000("CatteryCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	tf = var_1_10002
	arg_1_0._tf = var_1_10002(arg_1_1)
	findTF = var_2
	arg_1_0.lockTF = var_2(arg_1_0._tf, "lock")
	findTF = var_2
	arg_1_0.unlockTF = var_2(arg_1_0._tf, "unlock")

	local var_1_0 = arg_1_0.unlockTF
	local var_1_1 = var_2.Find(var_1_0, "mask/bg")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.style = var_1_2(var_1_1, var_4(var_1_10005))
	findTF = var_2
	arg_1_0.char = var_2(arg_1_0.unlockTF, "char")
	findTF = var_2
	arg_1_0.empty = var_2(arg_1_0.unlockTF, "empty")
	findTF = var_2
	arg_1_0.commanderExp = var_2(arg_1_0.unlockTF, "commander_exp")
	findTF = var_2
	arg_1_0.bubble = var_2(arg_1_0.unlockTF, "bubble")
	findTF = var_2

	local var_1_3 = var_2(arg_1_0.commanderExp, "level/Text")
	local var_1_4 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.levelTxt = var_1_4(var_1_3, var_4(var_1_10005))
	findTF = var_2

	local var_1_5 = var_2(arg_1_0.commanderExp, "exp/Text")
	local var_1_6 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.expTxt = var_1_6(var_1_5, var_4(var_1_10005))
	findTF = var_2
	arg_1_0.clean = var_2(arg_1_0.bubble, "clean")
	findTF = var_2
	arg_1_0.feed = var_2(arg_1_0.bubble, "feed")
	findTF = var_2
	arg_1_0.play = var_2(arg_1_0.bubble, "play")
	findTF = var_2
	arg_1_0.expAddition = var_2(arg_1_0.unlockTF, "exp_addition")

	local var_1_7 = arg_1_0.expAddition
	local var_1_8 = var_2.Find(var_1_7, "Text")
	local var_1_9 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.expAdditionTxt = var_1_9(var_1_8, var_4(var_1_10005))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.cattery = arg_2_1

	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1.GetState(var_2_0)

	Cattery = var_2_0

	if var_2_1 == var_2_0.STATE_LOCK then
		setActive = var_1_10004

		var_1_10004(arg_2_0.bubble, false)
	else
		Cattery = var_1_10004

		if var_2_1 == var_1_10004.STATE_EMPTY then
			arg_2_0:FlushEmpty()
		else
			Cattery = var_1_10004

			if var_2_1 == var_1_10004.STATE_OCCUPATION then
				arg_2_0:FlushCommander()
			end
		end
	end

	setActive = var_1_10004

	var_1_10004(arg_2_0.lockTF, var_3)

	setActive = var_1_10004

	var_1_10004(arg_2_0.unlockTF, not var_3)
	arg_2_0:UpdateStyle()

	return
end

function var_0_0.UpdateStyle(arg_3_0)
	local var_3_0 = arg_3_0.cattery
	local var_3_1 = var_1.GetState(var_3_0)

	Cattery = var_3_0

	if not (var_3_1 == var_3_0.STATE_LOCK) then
		local var_3_2 = var_1
		local var_3_3 = var_1._GetStyle_(var_3_2)

		Cattery = var_3_2

		if var_3_1 == var_3_2.STATE_EMPTY then
			local var_3_4 = arg_3_0.style

			GetSpriteFromAtlas = var_1_10006
			var_3_4.sprite = var_1_10006("CatteryStyle/" .. var_3_3:GetName(false), "")
		else
			local var_3_5 = arg_3_0.style

			GetSpriteFromAtlas = var_1_10006
			var_3_5.sprite = var_1_10006("CatteryStyle/" .. var_3_3:GetName(var_1:IsDirty()), "")
		end
	end

	return
end

function var_0_0.FlushEmpty(arg_4_0)
	setActive = var_1_10001

	var_1_10001(arg_4_0.empty, true)

	setActive = var_1_10001

	var_1_10001(arg_4_0.commanderExp, false)

	setActive = var_1_10001

	var_1_10001(arg_4_0.bubble, false)
	arg_4_0:ReturnChar()
	arg_4_0:InitBubble()

	return
end

function var_0_0.FlushCommander(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0.empty, false)

	setActive = var_1_10001

	var_1_10001(arg_5_0.commanderExp, true)

	setActive = var_1_10001

	var_1_10001(arg_5_0.bubble, true)

	local var_5_0 = arg_5_0.cattery
	local var_5_1 = var_1.GetCommander(var_5_0)

	arg_5_0.levelTxt.text = "LV." .. var_5_1:getLevel()
	arg_5_0.expTxt.text = var_5_1.exp .. "/" .. var_5_1:getNextLevelExp()

	arg_5_0:LoadChar(var_5_1)
	arg_5_0:InitBubble()

	return
end

function var_0_0.LoadChar(arg_6_0, arg_6_1)
	arg_6_0.painting = arg_6_1:getPainting()
	setCommanderPaintingPrefab = var_2

	var_2(arg_6_0.char, arg_6_0.painting, "info")

	return
end

function var_0_0.ReturnChar(arg_7_0)
	if arg_7_0.painting then
		retCommanderPaintingPrefab = var_1

		var_1(arg_7_0.char, arg_7_0.painting)

		arg_7_0.painting = nil
	end

	return
end

function var_0_0.InitBubble(arg_8_0)
	local var_8_0 = arg_8_0.cattery
	local var_8_1 = var_1.ExistCleanOP(var_8_0)
	local var_8_2 = var_1:ExiseFeedOP()
	local var_8_3 = var_1
	local var_8_4 = var_1.ExistPlayOP(var_8_3)

	setActive = var_8_3

	var_8_3(arg_8_0.clean, var_8_1)

	setActive = var_8_3

	var_8_3(arg_8_0.feed, var_8_2)

	setActive = var_8_3

	var_8_3(arg_8_0.play, var_8_4)

	setActive = var_8_3

	var_8_3(arg_8_0.bubble, var_8_1 or var_8_2 or var_8_4)

	return
end

function var_0_0.AddExpAnim(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:RemoveTimer()

	local var_9_0 = arg_9_0.expAdditionTxt

	var_9_0.text = arg_9_1
	setActive = var_9_0

	var_9_0(arg_9_0.expAddition, true)

	Timer = var_9_0
	arg_9_0.timer = var_9_0.New(function()
		local var_10_0 = arg_9_0

		var_0.RemoveTimer(var_10_0)

		setActive = var_0

		var_0(arg_9_0.expAddition, false)
		arg_9_2()

		return
	end, 1, 1)

	local var_9_1 = arg_9_0.timer

	var_3.Start(var_9_1)

	return
end

function var_0_0.RemoveTimer(arg_11_0)
	if arg_11_0.timer then
		local var_11_0 = arg_11_0.timer

		var_1.Stop(var_11_0)

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
