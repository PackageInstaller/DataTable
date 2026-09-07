local ShipProfileInformationPage = class("ShipProfileInformationPage", import("...base.BaseSubView"))

function ShipProfileInformationPage:getUIName()
	return "ShipProfileInformationPage"
end

function ShipProfileInformationPage:OnLoaded()
	self.voiceActor = self._tf:Find("bg/author_panel/cvPanel/label/mask/Text"):GetComponent("ScrollText")
	self.illustrator = self._tf:Find("bg/author_panel/illustPanel/illustrator/label/mask/Text"):GetComponent("ScrollText")
	self.cvContainer = self._tf:Find("bg/lines_panel/lines_list/Grid")
	self.cvTpl = self:getTpl("bg/lines_panel/lines_list/Grid/lines_tpl")
	self.weddingReview = self._tf:Find("bg/wedding")
	self.voiceBtn = self._tf:Find("bg/language_change")
	self.voiceBtnSel = self.voiceBtn:Find("sel")
	self.voiceBtnUnsel = self.voiceBtn:Find("unsel")
	self.voiceBtnPositions = {
		self.voiceBtnSel.localPosition,
		self.voiceBtnUnsel.localPosition
	}
	self.voiceBtnTxt = self.voiceBtn:Find("Text"):GetComponent(typeof(Text))
	self.voiceBtnTxt1 = self.voiceBtn:Find("Text1"):GetComponent(typeof(Text))
	self.profilePlayBtn = self._tf:Find("bg/prototype_panel/title/playButton")
	self.profileTxt = self._tf:Find("bg/prototype_panel/desc/scroll/Text"):GetComponent(typeof(Text))

	return
end

function ShipProfileInformationPage:UpdateCvBtn(arg_3_1)
	self.voiceBtnSel.localPosition = self.voiceBtnPositions[arg_3_1 and 2 or 1]
	self.voiceBtnUnsel.localPosition = self.voiceBtnPositions[arg_3_1 and 1 or 2]

	local var_3_0 = Color.New(1, 1, 1, 1)
	local var_3_1 = Color.New(0.5, 0.5, 0.5, 1)

	self.voiceBtnTxt.color = arg_3_1 and var_3_0 or var_3_1
	self.voiceBtnTxt1.color = arg_3_1 and var_3_1 or var_3_0

	return
end

function ShipProfileInformationPage:UpdateLang2()
	local var_4_0 = pg.ship_skin_words[ShipGroup.getDefaultSkin(self.skin.ship_group).id]

	PlayerPrefs.SetInt(CV_LANGUAGE_KEY .. self.skin.ship_group, 2)
	self.cvLoader:Load(self.skin.id)
	self:SetAuthorInfo()
	self:UpdateCvList(self.isLive2d)
	self:UpdateProfileInfo()

	return
end

function ShipProfileInformationPage:UpdateLang1()
	local var_5_0 = pg.ship_skin_words[ShipGroup.getDefaultSkin(self.skin.ship_group).id]

	PlayerPrefs.SetInt(CV_LANGUAGE_KEY .. self.skin.ship_group, 1)
	self.cvLoader:Load(self.skin.id)
	self:SetAuthorInfo()
	self:UpdateCvList(self.isLive2d)
	self:UpdateProfileInfo()

	return
end

function ShipProfileInformationPage:OnCvBtn(arg_6_1)
	local var_6_0 = arg_6_1

	onButton(self, self.voiceBtn, function()
		var_6_0 = not var_6_0

		self:UpdateCvBtn(var_6_0)

		if var_6_0 then
			self:UpdateLang2()
		else
			self:UpdateLang1()
		end

		return
	end, SFX_PANEL)
	self:UpdateCvBtn(arg_6_1)

	return
end

function ShipProfileInformationPage:OnInit()
	onButton(self, self.weddingReview, function()
		self:emit(ShipProfileScene.WEDDING_REVIEW, {
			group = self.shipGroup,
			skinID = self.skin.id
		})

		return
	end, SFX_PANEL)

	return
end

function ShipProfileInformationPage:EnterAnim(arg_10_1, arg_10_2)
	LeanTween.moveX(rtf(self._tf), 0, arg_10_1):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(arg_10_2))

	return
end

function ShipProfileInformationPage:ExistAnim(arg_11_1, arg_11_2)
	LeanTween.moveX(rtf(self._tf), 1000, arg_11_1):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
		if arg_11_2 then
			arg_11_2()
		end

		self:Hide()

		return
	end))

	return
end

function ShipProfileInformationPage:Update(arg_13_1, arg_13_2, arg_13_3)
	self:Show()

	self.shipGroup = arg_13_1
	self.showTrans = arg_13_2

	setActive(self.weddingReview, arg_13_1.married == 1)

	if isActive(self.weddingReview) then
		local var_13_0 = arg_13_1:getProposeType()

		eachChild(self.weddingReview, function(arg_14_0)
			setActive(arg_14_0, arg_14_0.name == var_13_0)

			return
		end)
	end

	if arg_13_3 then
		arg_13_3()
	end

	return
end

function ShipProfileInformationPage:Flush(arg_15_1, arg_15_2)
	if self.skin and self.skin.id == arg_15_1.id and self.isLive2d == arg_15_2 then
		return
	end

	self.skin = arg_15_1
	self.isLive2d = arg_15_2

	self:SetAuthorInfo()
	self:SetIllustrator()
	self:UpdateLanguage()
	self:UpdateProfileInfo()
	self:UpdateCvList(arg_15_2)
	self.cvLoader:Load(self.skin.id)

	return
end

function ShipProfileInformationPage:UpdateProfileInfo()
	local var_16_0, var_16_1, var_16_2 = ShipWordHelper.GetWordAndCV(self.skin.id, ShipWordHelper.WORD_TYPE_PROFILE)

	self.profileTxt.text = SwitchSpecialChar(var_16_2, true)

	local var_16_3 = pg.ship_skin_words[self.skin.id]
	local var_16_4 = pg.ship_skin_words[self.skin.id] and (var_16_3.voice_key >= 0 or var_16_3.voice_key == -2) or var_16_3.voice_key_2 > 0 and var_16_3.voice_key < 0

	if pg.ship_skin_words[self.skin.id] and (var_16_3.voice_key >= 0 or var_16_3.voice_key == -2) or var_16_3.voice_key_2 > 0 and var_16_3.voice_key < 0 then
		onButton(self, self.profilePlayBtn, function()
			self.cvLoader:PlaySound(var_16_1)

			return
		end, SFX_PANEL)
	end

	setActive(self.profilePlayBtn, var_16_4)

	return
end

function ShipProfileInformationPage:SetCvLoader(arg_18_1)
	self.cvLoader = arg_18_1

	return
end

function ShipProfileInformationPage:SetCallback(arg_19_1)
	self.callback = arg_19_1

	return
end

function ShipProfileInformationPage:UpdateLanguage()
	local var_20_0 = self.skin.ship_group
	local var_20_1 = ShipGroup.getDefaultSkin(self.skin.ship_group)
	local var_20_3 = setmetatable({}, {
		__index = function(self, arg_21_1)
			if arg_21_1 == "voice_key_2" and pg.ship_skin_words[self.skin.id][arg_21_1] == 0 then
				rawset(self, arg_21_1, pg.ship_skin_words[var_20_1.id][arg_21_1])
			else
				rawset(self, arg_21_1, pg.ship_skin_words[self.skin.id][arg_21_1])
			end

			return self[arg_21_1]
		end
	})
	local var_20_4 = ShipWordHelper.GetLanguageSetting(self.skin.id)
	local var_20_5 = pg.ship_skin_words[self.skin.id].voice_key_2 >= 0 or var_20_3.voice_key_2 == -2

	if pg.ship_skin_words[self.skin.id].voice_key_2 >= 0 and var_20_4 == 0 then
		var_20_4 = pg.gameset.language_default.key_value

		PlayerPrefs.SetInt(CV_LANGUAGE_KEY .. var_20_0, pg.gameset.language_default.key_value)
	end

	self:OnCvBtn(var_20_4 == 2)

	if var_20_3.voice_key_2 >= 0 or var_20_3.voice_key_2 == -2 then
		local var_20_6 = var_20_3.voice_key_2 % 10

		if var_20_3.voice_key_2 % 10 == 2 then
			self.voiceBtnTxt.text = i18n("word_chinese")
			self.voiceBtnTxt1.text = i18n("word_japanese")
		elseif var_20_6 == 3 then
			self.voiceBtnTxt.text = i18n("word_japanese_2")
			self.voiceBtnTxt1.text = i18n("word_japanese_3")
		end
	end

	setActive(self.voiceBtn, var_20_5)

	return
end

function ShipProfileInformationPage:SetAuthorInfo()
	local var_22_0 = ShipWordHelper.GetCVAuthor(self.skin.id)

	print(var_22_0 .. "  ----")
	self.voiceActor:SetText(var_22_0)

	return
end

function ShipProfileInformationPage:SetIllustrator()
	local var_23_0 = self.shipGroup:GetNationTxt()

	print(var_23_0)
	self.illustrator:SetText(var_23_0)

	return
end

function ShipProfileInformationPage:GetCvList(arg_24_1)
	return arg_24_1 and (pg.ship_skin_template[self.skin.id].spine_use_live2d == 1 and pg.AssistantInfo.GetCVListForProfile(true, self.skin.id) or pg.AssistantInfo.GetCVListForProfile(false, self.skin.id)) or ShipWordHelper.GetCVList()
end

function ShipProfileInformationPage:UpdateCvList(arg_25_1)
	self:DestroyCvBtns()

	self.cvBtns = {}
	self.dispalys = self:GetCvList(arg_25_1)

	table.sort(self.dispalys, function(arg_26_0, arg_26_1)
		return arg_26_0.profile_index < arg_26_1.profile_index
	end)

	for iter_25_0, iter_25_1 in ipairs(self.dispalys) do
		self:AddCvBtn(iter_25_1)
		self:AddExCvBtn(iter_25_1)
	end

	local var_25_0 = (pg.character_voice.touch.profile_index - 1) * 2

	var_25_0 = self.cvBtns[(pg.character_voice.touch.profile_index - 1) * 2] and self.cvBtns[(pg.character_voice.touch.profile_index - 1) * 2]._tf:GetSiblingIndex() or var_25_0

	local var_25_1 = ShipWordHelper.GetMainSceneWordCnt(self.skin.id, -1)
	local var_25_2 = ShipWordHelper.GetMainSceneWordCnt(self.skin.id, (self.shipGroup:GetMaxIntimacy()))

	if var_25_1 < var_25_2 then
		for iter_25_2 = var_25_1 + 1, var_25_2 do
			self:AddMainExBtn(iter_25_2, var_25_0)

			var_25_0 = var_25_0 + 1
		end
	end

	return
end

function ShipProfileInformationPage:AddMainExBtn(arg_27_1, arg_27_2)
	local var_27_0 = ShipProfileMainExCvBtn.New(cloneTplTo(self.cvTpl, self.cvContainer))

	onButton(self, var_27_0._tf, function()
		if self.callback then
			self.callback(var_27_0)
		end

		return
	end, SFX_PANEL)
	var_27_0:Init(self.shipGroup, self.skin, self.isLive2d, arg_27_1)
	var_27_0:Update()
	var_27_0._tf:SetSiblingIndex(arg_27_2)
	table.insert(self.cvBtns, var_27_0)

	return
end

function ShipProfileInformationPage:AddCvBtn(arg_29_1)
	local var_29_0 = ShipProfileCvBtn.New(cloneTplTo(self.cvTpl, self.cvContainer))

	onButton(self, var_29_0._tf, function()
		if self.callback then
			self.callback(var_29_0)
		end

		return
	end, SFX_PANEL)
	var_29_0:Init(self.shipGroup, self.skin, self.isLive2d, arg_29_1)
	var_29_0:Update()
	table.insert(self.cvBtns, var_29_0)

	return
end

function ShipProfileInformationPage:AddExCvBtn(arg_31_1)
	local var_31_0 = ShipProfileExCvBtn.New(cloneTplTo(self.cvTpl, self.cvContainer))

	onButton(self, var_31_0._tf, function()
		if self.callback then
			self.callback(var_31_0)
		end

		return
	end, SFX_PANEL)
	var_31_0:Init(self.shipGroup, self.skin, self.isLive2d, arg_31_1, (self.shipGroup:GetMaxIntimacy()))
	var_31_0:Update()
	table.insert(self.cvBtns, var_31_0)

	return
end

function ShipProfileInformationPage:DestroyCvBtns()
	if not self.cvBtns then
		return
	end

	for iter_33_0, iter_33_1 in ipairs(self.cvBtns) do
		iter_33_1:Destroy()
	end

	return
end

function ShipProfileInformationPage:OnDestroy()
	self:DestroyCvBtns()

	self.cvLoader = nil
	self.callback = nil

	return
end

return ShipProfileInformationPage
