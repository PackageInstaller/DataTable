local var_0_0 = class("NewEducateTopProgress")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.event = arg_1_2
	arg_1_0.hardTF = arg_1_0._tf:Find("hard")
	arg_1_0.detailTF = arg_1_0._tf:Find("detail")
	arg_1_0.endlessTF = arg_1_0._tf:Find("endless")

	setText(arg_1_0.endlessTF:Find("title/Text"), i18n("child2_endless_stage"))

	arg_1_0.resetTF = arg_1_0._tf:Find("reset")

	setText(arg_1_0.resetTF:Find("Text"), i18n("child2_reset_stage"))

	arg_1_0.endingTF = arg_1_0._tf:Find("ending")

	setText(arg_1_0.endingTF:Find("Text"), i18n("child2_ending_stage"))
	onButton(arg_1_0.event, arg_1_0._tf:Find("back"), function()
		arg_1_0.event:emit(NewEducateBaseUI.ON_BACK)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Update(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.char = arg_3_1

	local var_3_0 = arg_3_2 or arg_3_0.char:GetFSM():GetSystemNo()

	setActive(arg_3_0.hardTF, arg_3_0.char.difficulty == NewEducateChar.DIFFICULTY.HARD)

	local var_3_1 = var_3_0 ~= NewEducateFSM.SYSTEM.ENDING

	setActive(arg_3_0.detailTF, var_3_0 ~= NewEducateFSM.SYSTEM.ENDING)
	setActive(arg_3_0.endlessTF, var_3_1)
	setActive(arg_3_0.endingTF, not var_3_1)
	setActive(arg_3_0.resetTF, not var_3_1)

	if var_3_1 then
		if arg_3_0.char:GetRoundData():IsEndless() then
			arg_3_0:FlushEndless()
		else
			arg_3_0:FlushNormal()
		end
	else
		local var_3_2 = arg_3_0.char:GetFSM():GetState(NewEducateFSM.SYSTEM.ENDING)
		local var_3_3 = var_3_2 and var_3_2:IsFinish()

		setActive(arg_3_0.endingTF, not var_3_3)
		setActive(arg_3_0.resetTF, var_3_3)
	end

	return
end

function var_0_0.FlushNormal(arg_4_0)
	setActive(arg_4_0.detailTF, true)
	setActive(arg_4_0.endlessTF, false)

	local var_4_0 = arg_4_0.char:GetRoundData()
	local var_4_1, var_4_2, var_4_3 = var_4_0:GetProgressInfo()
	local var_4_4 = var_4_0:IsTemp() and i18n("child2_cur_round_temp") or i18n("child2_cur_round", var_4_1)

	setText(arg_4_0.detailTF:Find("round/Text"), var_4_4)

	local var_4_5 = arg_4_0.detailTF:Find("round/assess")

	setText(var_4_5, i18n("child2_assess_round", var_4_2))
	setTextColor(var_4_5, Color.NewHex(var_4_2 > 0 and "39bfff" or "ff6767"))

	local var_4_6 = arg_4_0.detailTF:Find("target/content/value")
	local var_4_7 = arg_4_0.char:GetAttrSum()

	setText(var_4_6, i18n("child2_assess_target", var_4_7, var_4_3))
	setTextColor(var_4_6, Color.NewHex(var_4_3 <= var_4_7 and "39bfff" or "848498"))

	return
end

function var_0_0.FlushEndless(arg_5_0)
	setActive(arg_5_0.detailTF, false)
	setActive(arg_5_0.endlessTF, true)

	local var_5_0, var_5_1, var_5_2 = arg_5_0.char:GetRoundData():GetEndlessProgressInfos()

	setText(arg_5_0.endlessTF:Find("title/wave"), i18n("child2_cur_wave", var_5_0))
	setActive(arg_5_0.endlessTF:Find("title/new"), var_5_1)
	setText(arg_5_0.endlessTF:Find("target/boss"), i18n("child2_endless_boss_value", var_5_2))
	setText(arg_5_0.endlessTF:Find("target/attrs/value"), i18n("child2_endless_attrs_value", arg_5_0.char:GetAttrSum()))

	return
end

function var_0_0.Dispose(arg_6_0)
	return
end

return var_0_0
