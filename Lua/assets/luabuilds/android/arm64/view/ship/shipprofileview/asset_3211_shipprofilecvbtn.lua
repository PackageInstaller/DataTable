local ShipProfileCvBtn = class("ShipProfileCvBtn")

function ShipProfileCvBtn:Ctor(arg_1_1)
	self._tf = arg_1_1
	self._go = go(arg_1_1)
	self.nameTxt = self._tf:Find("Text"):GetComponent(typeof(Text))

	setActive(self._tf:Find("tag_common"), true)

	self.tagDiff = self._tf:Find("tag_diff")
	self.playIcon = self._tf:Find("play_icon")

	return
end

function ShipProfileCvBtn:Init(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.shipGroup = arg_2_1
	self.isLive2d = arg_2_3
	self.skin = arg_2_2
	self.voice = arg_2_4
	self.words = pg.ship_skin_words[self.skin.id]

	local var_2_0 = arg_2_1:getIntimacyName(self.voice.key)

	if var_2_0 then
		self.voice = setmetatable({
			voice_name = var_2_0
		}, {
			__index = arg_2_4
		})
	end

	local var_2_1
	local var_2_2
	local var_2_3
	local var_2_4
	local var_2_5
	local var_2_6

	if string.find(arg_2_4.key, ShipWordHelper.WORD_TYPE_MAIN) then
		var_2_4 = tonumber((string.gsub(arg_2_4.key, ShipWordHelper.WORD_TYPE_MAIN, "")))
		var_2_1, var_2_2, var_2_3 = ShipWordHelper.GetWordAndCV(self.skin.id, ShipWordHelper.WORD_TYPE_MAIN, var_2_4)

		if self.isLive2d then
			var_2_5 = ShipWordHelper.GetL2dCvCalibrate(self.skin.id, ShipWordHelper.WORD_TYPE_MAIN, var_2_4)
			var_2_6 = ShipWordHelper.GetL2dSoundEffect(self.skin.id, ShipWordHelper.WORD_TYPE_MAIN, var_2_4)
		end
	else
		var_2_1, var_2_2, var_2_3 = ShipWordHelper.GetWordAndCV(self.skin.id, arg_2_4.key)

		if self.isLive2d then
			var_2_5 = ShipWordHelper.GetL2dCvCalibrate(self.skin.id, arg_2_4.key)
			var_2_6 = ShipWordHelper.GetL2dSoundEffect(self.skin.id, arg_2_4.key)
		end
	end

	self.l2dEventFlag = var_2_5 == -1
	var_2_5 = self.l2dEventFlag and 0 or var_2_5
	self.wordData = {
		maxfavor = 0,
		cvKey = var_2_1,
		cvPath = var_2_2,
		textContent = var_2_3,
		mainIndex = var_2_4,
		voiceCalibrate = var_2_5,
		se = var_2_6
	}

	return
end

function ShipProfileCvBtn:Update()
	local var_3_0 = self.voice.unlock_condition[1] < 0
	local var_3_1 = self.wordData.textContent == nil or self.wordData.textContent == "nil" or self.wordData.textContent == ""

	var_3_0 = not self.isLive2d and (var_3_0 or var_3_1) or var_3_0 or var_3_1 and self.voice.l2d_action:match("^" .. ShipWordHelper.WORD_TYPE_MAIN .. "_")

	setActive(self._tf, not var_3_0)

	if not var_3_0 then
		self:UpdateCvBtn()
		self:UpdateIcon()
	end

	return
end

function ShipProfileCvBtn:UpdateCvBtn()
	local var_4_0, var_4_1 = self.shipGroup:VoiceReplayCodition(self.voice)

	if var_4_0 then
		self.nameTxt.text = self.voice.voice_name or "???"
	end

	setActive(self.tagDiff, (ShipWordHelper.ExistDifferentWord(self.skin.id, self.voice.key, self.wordData.mainIndex)))

	if not var_4_0 then
		onButton(nil, self._tf, function()
			pg.TipsMgr.GetInstance():ShowTips(var_4_1)

			return
		end, SFX_PANEL)
	end

	return
end

function ShipProfileCvBtn:UpdateIcon()
	setActive(self.playIcon, self.voice.key == "unlock" and checkABExist("ui/skinunlockanim/star_level_unlock_anim_" .. self.skin.id))

	return
end

function ShipProfileCvBtn:L2dHasEvent()
	return self.l2dEventFlag
end

function ShipProfileCvBtn:isEx()
	return false
end

function ShipProfileCvBtn:Destroy()
	Destroy(self._go)
	removeOnButton(self._tf)

	return
end

return ShipProfileCvBtn
