local ShipProfileExCvBtn = class("ShipProfileExCvBtn", import(".ShipProfileCvBtn"))

function ShipProfileExCvBtn:Init(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	ShipProfileExCvBtn.super.Init(self, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	self.favor = arg_1_5

	local var_1_0
	local var_1_1

	if string.find(arg_1_4.key, ShipWordHelper.WORD_TYPE_MAIN) then
		mainIndex = tonumber((string.gsub(arg_1_4.key, ShipWordHelper.WORD_TYPE_MAIN, "")))
		var_1_0, var_1_1 = ShipWordHelper.ExistExCv(arg_1_2.id, ShipWordHelper.WORD_TYPE_MAIN, mainIndex, arg_1_5)
	else
		var_1_0, var_1_1 = ShipWordHelper.ExistExCv(arg_1_2.id, arg_1_4.key, nil, arg_1_5)
	end

	if self.wordData.cvPath and var_1_1 then
		self.wordData.cvPath = self.wordData.cvPath .. "_ex" .. var_1_1
	end

	self.wordData.matchFavor = var_1_1
	self.wordData.textContent = var_1_0
	self.wordData.maxfavor = arg_1_5

	return
end

function ShipProfileExCvBtn:Update()
	local var_2_0 = self.voice.unlock_condition[1] < 0

	if self.voice.unlock_condition[1] >= 0 then
		var_2_0 = self.wordData.textContent == nil or self.wordData.textContent == "nil" or self.wordData.textContent == ""
	end

	setActive(self._tf, not var_2_0)

	if not var_2_0 then
		self:UpdateCvBtn()
		self:UpdateIcon()
	end

	return
end

function ShipProfileExCvBtn:UpdateCvBtn()
	local var_3_0, var_3_1 = self.shipGroup:VoiceReplayCodition(self.voice)

	if var_3_0 then
		self.nameTxt.text = self.voice.voice_name .. "Ex" or "???"
	end

	setActive(self.tagDiff, (ShipWordHelper.ExistDifferentExWord(self.skin.id, self.voice.key, self.wordData.mainIndex, self.favor)))

	if not var_3_0 then
		onButton(nil, self._tf, function()
			pg.TipsMgr.GetInstance():ShowTips(var_3_1)

			return
		end, SFX_PANEL)
	end

	return
end

function ShipProfileExCvBtn:isEx()
	return self.shipGroup:VoiceReplayCodition(self.voice)
end

return ShipProfileExCvBtn
