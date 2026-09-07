local NewEducateTopProgress = class("NewEducateTopProgress")

function NewEducateTopProgress:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.event = arg_1_2
	self.hardTF = self._tf:Find("hard")
	self.detailTF = self._tf:Find("detail")
	self.endlessTF = self._tf:Find("endless")

	setText(self.endlessTF:Find("title/Text"), i18n("child2_endless_stage"))

	self.resetTF = self._tf:Find("reset")

	setText(self.resetTF:Find("Text"), i18n("child2_reset_stage"))

	self.endingTF = self._tf:Find("ending")

	setText(self.endingTF:Find("Text"), i18n("child2_ending_stage"))
	onButton(self.event, self._tf:Find("back"), function()
		self.event:emit(NewEducateBaseUI.ON_BACK)

		return
	end, SFX_PANEL)

	return
end

function NewEducateTopProgress:Update(arg_3_1, arg_3_2)
	self.char = arg_3_1

	local var_3_0 = arg_3_2 or self.char:GetFSM():GetSystemNo()

	setActive(self.hardTF, self.char.difficulty == NewEducateChar.DIFFICULTY.HARD)

	local var_3_1 = var_3_0 ~= NewEducateFSM.SYSTEM.ENDING

	setActive(self.detailTF, var_3_0 ~= NewEducateFSM.SYSTEM.ENDING)
	setActive(self.endlessTF, var_3_1)
	setActive(self.endingTF, not var_3_1)
	setActive(self.resetTF, not var_3_1)

	if var_3_1 then
		if self.char:GetRoundData():IsEndless() then
			self:FlushEndless()
		else
			self:FlushNormal()
		end
	else
		local var_3_2 = self.char:GetFSM():GetState(NewEducateFSM.SYSTEM.ENDING)
		local var_3_3 = var_3_2 and var_3_2:IsFinish()

		setActive(self.endingTF, not var_3_3)
		setActive(self.resetTF, var_3_3)
	end

	return
end

function NewEducateTopProgress:FlushNormal()
	setActive(self.detailTF, true)
	setActive(self.endlessTF, false)

	local var_4_0 = self.char:GetRoundData()
	local var_4_1, var_4_2, var_4_3 = var_4_0:GetProgressInfo()

	setText(self.detailTF:Find("round/Text"), var_4_0:IsTemp() and i18n("child2_cur_round_temp") or i18n("child2_cur_round", var_4_1))

	local var_4_4 = self.detailTF:Find("round/assess")

	setText(var_4_4, i18n("child2_assess_round", var_4_2))
	setTextColor(var_4_4, Color.NewHex(var_4_2 > 0 and "39bfff" or "ff6767"))

	local var_4_5 = self.detailTF:Find("target/content/value")
	local var_4_6 = self.char:GetAttrSum()

	setText(var_4_5, i18n("child2_assess_target", var_4_6, var_4_3))
	setTextColor(var_4_5, Color.NewHex(var_4_3 <= var_4_6 and "39bfff" or "848498"))

	return
end

function NewEducateTopProgress:FlushEndless()
	setActive(self.detailTF, false)
	setActive(self.endlessTF, true)

	local var_5_0, var_5_1, var_5_2 = self.char:GetRoundData():GetEndlessProgressInfos()

	setText(self.endlessTF:Find("title/wave"), i18n("child2_cur_wave", var_5_0))
	setActive(self.endlessTF:Find("title/new"), var_5_1)
	setText(self.endlessTF:Find("target/boss"), i18n("child2_endless_boss_value", var_5_2))
	setText(self.endlessTF:Find("target/attrs/value"), i18n("child2_endless_attrs_value", self.char:GetAttrSum()))

	return
end

function NewEducateTopProgress:Dispose()
	return
end

return NewEducateTopProgress
