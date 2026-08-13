class = var_0_10000

local var_0_0 = var_0_10000("NewEducateTopProgress")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.event = arg_1_2

	local var_1_0 = arg_1_0._tf

	arg_1_0.hardTF = var_3.Find(var_1_0, "hard")

	local var_1_1 = arg_1_0._tf

	arg_1_0.detailTF = var_3.Find(var_1_1, "detail")

	local var_1_2 = arg_1_0._tf

	arg_1_0.endlessTF = var_3.Find(var_1_2, "endless")
	setText = var_3

	local var_1_3 = arg_1_0.endlessTF
	local var_1_4 = var_4.Find(var_1_3, "title/Text")

	i18n = var_1_3

	var_3(var_1_4, var_1_3("child2_endless_stage"))

	local var_1_5 = arg_1_0._tf

	arg_1_0.resetTF = var_3.Find(var_1_5, "reset")
	setText = var_3

	local var_1_6 = arg_1_0.resetTF
	local var_1_7 = var_4.Find(var_1_6, "Text")

	i18n = var_1_6

	var_3(var_1_7, var_1_6("child2_reset_stage"))

	local var_1_8 = arg_1_0._tf

	arg_1_0.endingTF = var_3.Find(var_1_8, "ending")
	setText = var_3

	local var_1_9 = arg_1_0.endingTF
	local var_1_10 = var_4.Find(var_1_9, "Text")

	i18n = var_1_9

	var_3(var_1_10, var_1_9("child2_ending_stage"))

	onButton = var_3

	local var_1_11 = arg_1_0.event
	local var_1_12 = arg_1_0._tf
	local var_1_13 = var_5.Find(var_1_12, "back")

	local function var_1_14()
		local var_2_0 = arg_1_0.event
		local var_2_1 = var_0.emit

		NewEducateBaseUI = var_2_10002

		var_2_1(var_2_0, var_2_10002.ON_BACK)

		return
	end

	SFX_PANEL = var_7

	var_3(var_1_11, var_1_13, var_1_14, var_7)

	return
end

function var_0_0.Update(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.char = arg_3_1

	local var_3_0

	if not arg_3_2 then
		::label_3_0::

		var_1_10004 = arg_3_0.char
		var_1_10004 = var_3.GetFSM(var_1_10004)
		var_3_0 = var_3.GetSystemNo(var_1_10004)
	end

	setActive = var_1_10004

	local var_3_1 = arg_3_0.hardTF
	local var_3_2 = arg_3_0.char.difficulty

	NewEducateChar = var_1_10007

	var_1_10004(var_3_1, var_3_2 == var_1_10007.DIFFICULTY.HARD)

	NewEducateFSM = var_1_10004

	local var_3_3 = var_3_0 ~= var_1_10004.SYSTEM.ENDING

	setActive = var_3_1

	var_3_1(arg_3_0.detailTF, var_3_3)

	setActive = var_3_1

	var_3_1(arg_3_0.endlessTF, var_3_3)

	setActive = var_3_1

	var_3_1(arg_3_0.endingTF, not var_3_3)

	setActive = var_3_1

	var_3_1(arg_3_0.resetTF, not var_3_3)

	if var_3_3 then
		local var_3_4 = arg_3_0.char
		local var_3_5 = var_5.GetRoundData(var_3_4)

		if var_5.IsEndless(var_3_5) then
			arg_3_0:FlushEndless()
		else
			arg_3_0:FlushNormal()
		end
	else
		local var_3_6 = arg_3_0.char
		local var_3_7 = var_5.GetFSM(var_3_6)
		local var_3_8 = var_5.GetState

		NewEducateFSM = var_7

		local var_3_9, var_3_10

		if var_3_8(var_3_7, var_7.SYSTEM.ENDING) then
			::label_3_1::

			var_3_9 = var_5
			var_3_10 = var_5.IsFinish(var_3_9)
		end

		setActive = var_3_9

		var_3_9(arg_3_0.endingTF, not var_3_10)

		setActive = var_3_9

		var_3_9(arg_3_0.resetTF, var_3_10)
	end

	return
end

function var_0_0.FlushNormal(arg_4_0)
	setActive = var_1_10001

	var_1_10001(arg_4_0.detailTF, true)

	setActive = var_1_10001

	var_1_10001(arg_4_0.endlessTF, false)

	local var_4_0 = arg_4_0.char
	local var_4_1 = var_1.GetRoundData(var_4_0)
	local var_4_2, var_4_3, var_4_4 = var_1.GetProgressInfo(var_4_1)
	local var_4_5 = var_1

	if var_1.IsTemp(var_4_5) then
		i18n = var_4_6

		local var_4_6

		if not var_4_6("child2_cur_round_temp") then
			i18n = var_4_6
			var_4_6 = var_4_6("child2_cur_round", var_4_2)
		end

		setText = var_4_5

		local var_4_7 = arg_4_0.detailTF

		var_4_5(var_7.Find(var_4_7, "round/Text"), var_4_6)

		local var_4_8 = arg_4_0.detailTF
		local var_4_9 = var_6.Find(var_4_8, "round/assess")

		setText = var_4_8

		local var_4_10 = var_4_9

		i18n = var_9

		var_4_8(var_4_10, var_9("child2_assess_round", var_4_3))

		local var_4_11 = var_4_3 > 0 and "39bfff" or "ff6767"

		setTextColor = var_4_10

		local var_4_12 = var_4_9

		Color = var_10

		var_4_10(var_4_12, var_10.NewHex(var_4_11))

		local var_4_13 = arg_4_0.detailTF
		local var_4_14 = var_8.Find(var_4_13, "target/content/value")
		local var_4_15 = arg_4_0.char
		local var_4_16 = var_9.GetAttrSum(var_4_15)

		setText = var_4_15

		local var_4_17 = var_4_14

		i18n = var_1_10012

		var_4_15(var_4_17, var_1_10012("child2_assess_target", var_4_16, var_4_4))

		local var_4_18 = var_4_4 <= var_4_16 and "39bfff" or "848498"

		setTextColor = var_4_17

		local var_4_19 = var_4_14

		Color = var_13

		var_4_17(var_4_19, var_13.NewHex(var_4_18))

		return
	end
end

function var_0_0.FlushEndless(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0.detailTF, false)

	setActive = var_1_10001

	var_1_10001(arg_5_0.endlessTF, true)

	local var_5_0 = arg_5_0.char
	local var_5_1 = var_1.GetRoundData(var_5_0)
	local var_5_2, var_5_3, var_5_4 = var_1.GetEndlessProgressInfos(var_5_1)

	setText = var_1_10005

	local var_5_5 = arg_5_0.endlessTF
	local var_5_6 = var_6.Find(var_5_5, "title/wave")

	i18n = var_5_5

	var_1_10005(var_5_6, var_5_5("child2_cur_wave", var_5_2))

	setActive = var_1_10005

	local var_5_7 = arg_5_0.endlessTF

	var_1_10005(var_6.Find(var_5_7, "title/new"), var_5_3)

	setText = var_1_10005

	local var_5_8 = arg_5_0.endlessTF
	local var_5_9 = var_6.Find(var_5_8, "target/boss")

	i18n = var_5_8

	var_1_10005(var_5_9, var_5_8("child2_endless_boss_value", var_5_4))

	setText = var_1_10005

	local var_5_10 = arg_5_0.endlessTF
	local var_5_11 = var_6.Find(var_5_10, "target/attrs/value")

	i18n = var_5_10

	local var_5_12 = "child2_endless_attrs_value"
	local var_5_13 = arg_5_0.char

	var_1_10005(var_5_11, var_5_10(var_5_12, var_9.GetAttrSum(var_5_13)))

	return
end

function var_0_0.Dispose(arg_6_0)
	return
end

return var_0_0
