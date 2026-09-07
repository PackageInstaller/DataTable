local ShipProfileMainExCvBtn = class("ShipProfileMainExCvBtn", import(".ShipProfileCvBtn"))

function ShipProfileMainExCvBtn:Init(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.shipGroup = arg_1_1
	self.isLive2d = arg_1_3
	self.skin = arg_1_2

	local var_1_0 = i18n("word_cv_key_main") .. arg_1_4 .. "Ex"

	if pg.character_voice["main" .. arg_1_4] then
		self.voice = Clone(pg.character_voice["main" .. arg_1_4])
		self.voice.voice_name = var_1_0
	else
		self.voice = {
			spine_action = "normal",
			profile_index = 5,
			l2d_action = "main_3",
			key = "main" .. arg_1_4,
			voice_name = var_1_0,
			resource_key = "main_" .. arg_1_4,
			unlock_condition = {
				0,
				0
			}
		}
	end

	local var_1_1 = self.voice

	self.words = pg.ship_skin_words[self.skin.id]

	local var_1_2
	local var_1_3
	local var_1_4
	local var_1_5
	local var_1_6
	local var_1_7
	local var_1_8 = self.shipGroup:GetMaxIntimacy()

	if string.find(var_1_1.key, ShipWordHelper.WORD_TYPE_MAIN) then
		var_1_5 = tonumber((string.gsub(var_1_1.key, ShipWordHelper.WORD_TYPE_MAIN, "")))
		var_1_2, var_1_3, var_1_4 = ShipWordHelper.GetWordAndCV(self.skin.id, ShipWordHelper.WORD_TYPE_MAIN, var_1_5, nil, var_1_8)

		if self.isLive2d then
			var_1_6 = ShipWordHelper.GetL2dCvCalibrate(self.skin.id, ShipWordHelper.WORD_TYPE_MAIN, var_1_5)
			var_1_7 = ShipWordHelper.GetL2dSoundEffect(self.skin.id, ShipWordHelper.WORD_TYPE_MAIN, var_1_5)
		end
	else
		var_1_2, var_1_3, var_1_4 = ShipWordHelper.GetWordAndCV(self.skin.id, var_1_1.key)

		if self.isLive2d then
			var_1_6 = ShipWordHelper.GetL2dCvCalibrate(self.skin.id, var_1_1.key)
			var_1_7 = ShipWordHelper.GetL2dSoundEffect(self.skin.id, var_1_1.key)
		end
	end

	self.wordData = {
		cvKey = var_1_2,
		cvPath = var_1_3,
		textContent = var_1_4,
		mainIndex = var_1_5,
		voiceCalibrate = var_1_6,
		se = var_1_7,
		maxfavor = var_1_8
	}

	return
end

function ShipProfileMainExCvBtn:Update()
	local var_2_0 = self.voice.unlock_condition[1] < 0
	local var_2_1 = self.wordData.textContent == nil or self.wordData.textContent == "nil" or self.wordData.textContent == ""

	var_2_0 = not self.isLive2d and (var_2_0 or var_2_1) or var_2_0 or var_2_1 and self.voice.l2d_action:match("^" .. ShipWordHelper.WORD_TYPE_MAIN .. "_")

	setActive(self._tf, not var_2_0)

	if not var_2_0 then
		self:UpdateCvBtn()
		self:UpdateIcon()
	end

	return
end

function ShipProfileMainExCvBtn:UpdateCvBtn()
	if true then
		self.nameTxt.text = self.voice.voice_name or "???"
	end

	setActive(self.tagDiff, (ShipWordHelper.ExistDifferentMainExWord(self.skin.id, self.voice.key, self.wordData.mainIndex, (self.shipGroup:GetMaxIntimacy()))))

	return
end

return ShipProfileMainExCvBtn
