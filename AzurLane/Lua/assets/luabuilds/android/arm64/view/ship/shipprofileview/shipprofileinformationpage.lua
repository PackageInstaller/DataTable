local var_0_0 = class("ShipProfileInformationPage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "ShipProfileInformationPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.voiceActor = arg_2_0._tf:Find("bg/author_panel/cvPanel/label/mask/Text"):GetComponent("ScrollText")
	arg_2_0.illustrator = arg_2_0._tf:Find("bg/author_panel/illustPanel/illustrator/label/mask/Text"):GetComponent("ScrollText")
	arg_2_0.cvContainer = arg_2_0._tf:Find("bg/lines_panel/lines_list/Grid")
	arg_2_0.cvTpl = arg_2_0:getTpl("bg/lines_panel/lines_list/Grid/lines_tpl")
	arg_2_0.weddingReview = arg_2_0._tf:Find("bg/wedding")
	arg_2_0.voiceBtn = arg_2_0._tf:Find("bg/language_change")
	arg_2_0.voiceBtnSel = arg_2_0.voiceBtn:Find("sel")
	arg_2_0.voiceBtnUnsel = arg_2_0.voiceBtn:Find("unsel")
	arg_2_0.voiceBtnPositions = {
		arg_2_0.voiceBtnSel.localPosition,
		arg_2_0.voiceBtnUnsel.localPosition
	}
	arg_2_0.voiceBtnTxt = arg_2_0.voiceBtn:Find("Text"):GetComponent(typeof(Text))
	arg_2_0.voiceBtnTxt1 = arg_2_0.voiceBtn:Find("Text1"):GetComponent(typeof(Text))
	arg_2_0.profilePlayBtn = arg_2_0._tf:Find("bg/prototype_panel/title/playButton")
	arg_2_0.profileTxt = arg_2_0._tf:Find("bg/prototype_panel/desc/scroll/Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.UpdateCvBtn(arg_3_0, arg_3_1)
	arg_3_0.voiceBtnSel.localPosition = arg_3_0.voiceBtnPositions[arg_3_1 and 2 or 1]
	arg_3_0.voiceBtnUnsel.localPosition = arg_3_0.voiceBtnPositions[arg_3_1 and 1 or 2]

	local var_3_0 = Color.New(1, 1, 1, 1)
	local var_3_1 = Color.New(0.5, 0.5, 0.5, 1)

	arg_3_0.voiceBtnTxt.color = arg_3_1 and var_3_0 or var_3_1
	arg_3_0.voiceBtnTxt1.color = arg_3_1 and var_3_1 or var_3_0

	return
end

function var_0_0.UpdateLang2(arg_4_0)
	local var_4_0 = pg.ship_skin_words[ShipGroup.getDefaultSkin(arg_4_0.skin.ship_group).id]

	PlayerPrefs.SetInt(CV_LANGUAGE_KEY .. arg_4_0.skin.ship_group, 2)
	arg_4_0.cvLoader:Load(arg_4_0.skin.id)
	arg_4_0:SetAuthorInfo()
	arg_4_0:UpdateCvList(arg_4_0.isLive2d)
	arg_4_0:UpdateProfileInfo()

	return
end

function var_0_0.UpdateLang1(arg_5_0)
	local var_5_0 = pg.ship_skin_words[ShipGroup.getDefaultSkin(arg_5_0.skin.ship_group).id]

	PlayerPrefs.SetInt(CV_LANGUAGE_KEY .. arg_5_0.skin.ship_group, 1)
	arg_5_0.cvLoader:Load(arg_5_0.skin.id)
	arg_5_0:SetAuthorInfo()
	arg_5_0:UpdateCvList(arg_5_0.isLive2d)
	arg_5_0:UpdateProfileInfo()

	return
end

function var_0_0.OnCvBtn(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1

	onButton(arg_6_0, arg_6_0.voiceBtn, function()
		var_6_0 = not var_6_0

		arg_6_0:UpdateCvBtn(var_6_0)

		if var_6_0 then
			arg_6_0:UpdateLang2()
		else
			arg_6_0:UpdateLang1()
		end

		return
	end, SFX_PANEL)
	arg_6_0:UpdateCvBtn(arg_6_1)

	return
end

function var_0_0.OnInit(arg_8_0)
	onButton(arg_8_0, arg_8_0.weddingReview, function()
		arg_8_0:emit(ShipProfileScene.WEDDING_REVIEW, {
			group = arg_8_0.shipGroup,
			skinID = arg_8_0.skin.id
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.EnterAnim(arg_10_0, arg_10_1, arg_10_2)
	LeanTween.moveX(rtf(arg_10_0._tf), 0, arg_10_1):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(arg_10_2))

	return
end

function var_0_0.ExistAnim(arg_11_0, arg_11_1, arg_11_2)
	LeanTween.moveX(rtf(arg_11_0._tf), 1000, arg_11_1):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
		if arg_11_2 then
			arg_11_2()
		end

		arg_11_0:Hide()

		return
	end))

	return
end

function var_0_0.Update(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0:Show()

	arg_13_0.shipGroup = arg_13_1
	arg_13_0.showTrans = arg_13_2

	setActive(arg_13_0.weddingReview, arg_13_1.married == 1)

	if isActive(arg_13_0.weddingReview) then
		local var_13_0 = arg_13_1:getProposeType()

		eachChild(arg_13_0.weddingReview, function(arg_14_0)
			setActive(arg_14_0, arg_14_0.name == var_13_0)

			return
		end)
	end

	if arg_13_3 then
		arg_13_3()
	end

	return
end

function var_0_0.Flush(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.skin and arg_15_0.skin.id == arg_15_1.id and arg_15_0.isLive2d == arg_15_2 then
		return
	end

	arg_15_0.skin = arg_15_1
	arg_15_0.isLive2d = arg_15_2

	arg_15_0:SetAuthorInfo()
	arg_15_0:SetIllustrator()
	arg_15_0:UpdateLanguage()
	arg_15_0:UpdateProfileInfo()
	arg_15_0:UpdateCvList(arg_15_2)
	arg_15_0.cvLoader:Load(arg_15_0.skin.id)

	return
end

function var_0_0.UpdateProfileInfo(arg_16_0)
	local var_16_0, var_16_1, var_16_2 = ShipWordHelper.GetWordAndCV(arg_16_0.skin.id, ShipWordHelper.WORD_TYPE_PROFILE)

	arg_16_0.profileTxt.text = SwitchSpecialChar(var_16_2, true)

	local var_16_3 = pg.ship_skin_words[arg_16_0.skin.id]
	local var_16_4 = pg.ship_skin_words[arg_16_0.skin.id] and (var_16_3.voice_key >= 0 or var_16_3.voice_key == -2) or var_16_3.voice_key_2 > 0 and var_16_3.voice_key < 0

	if pg.ship_skin_words[arg_16_0.skin.id] and (var_16_3.voice_key >= 0 or var_16_3.voice_key == -2) or var_16_3.voice_key_2 > 0 and var_16_3.voice_key < 0 then
		onButton(arg_16_0, arg_16_0.profilePlayBtn, function()
			arg_16_0.cvLoader:PlaySound(var_16_1)

			return
		end, SFX_PANEL)
	end

	setActive(arg_16_0.profilePlayBtn, var_16_4)

	return
end

function var_0_0.SetCvLoader(arg_18_0, arg_18_1)
	arg_18_0.cvLoader = arg_18_1

	return
end

function var_0_0.SetCallback(arg_19_0, arg_19_1)
	arg_19_0.callback = arg_19_1

	return
end

function var_0_0.UpdateLanguage(arg_20_0)
	local var_20_0 = arg_20_0.skin.ship_group
	local var_20_1 = ShipGroup.getDefaultSkin(arg_20_0.skin.ship_group)
	local var_20_3 = setmetatable({}, {
		__index = function(arg_21_0, arg_21_1)
			if arg_21_1 == "voice_key_2" and pg.ship_skin_words[arg_20_0.skin.id][arg_21_1] == 0 then
				rawset(arg_21_0, arg_21_1, pg.ship_skin_words[var_20_1.id][arg_21_1])
			else
				rawset(arg_21_0, arg_21_1, pg.ship_skin_words[arg_20_0.skin.id][arg_21_1])
			end

			return arg_21_0[arg_21_1]
		end
	})
	local var_20_4 = ShipWordHelper.GetLanguageSetting(arg_20_0.skin.id)
	local var_20_5 = pg.ship_skin_words[arg_20_0.skin.id].voice_key_2 >= 0 or var_20_3.voice_key_2 == -2

	if pg.ship_skin_words[arg_20_0.skin.id].voice_key_2 >= 0 and var_20_4 == 0 then
		var_20_4 = pg.gameset.language_default.key_value

		PlayerPrefs.SetInt(CV_LANGUAGE_KEY .. var_20_0, pg.gameset.language_default.key_value)
	end

	arg_20_0:OnCvBtn(var_20_4 == 2)

	if var_20_3.voice_key_2 >= 0 or var_20_3.voice_key_2 == -2 then
		local var_20_6 = var_20_3.voice_key_2 % 10

		if var_20_3.voice_key_2 % 10 == 2 then
			arg_20_0.voiceBtnTxt.text = i18n("word_chinese")
			arg_20_0.voiceBtnTxt1.text = i18n("word_japanese")
		elseif var_20_6 == 3 then
			arg_20_0.voiceBtnTxt.text = i18n("word_japanese_2")
			arg_20_0.voiceBtnTxt1.text = i18n("word_japanese_3")
		end
	end

	setActive(arg_20_0.voiceBtn, var_20_5)

	return
end

function var_0_0.SetAuthorInfo(arg_22_0)
	local var_22_0 = ShipWordHelper.GetCVAuthor(arg_22_0.skin.id)

	print(var_22_0 .. "  ----")
	arg_22_0.voiceActor:SetText(var_22_0)

	return
end

function var_0_0.SetIllustrator(arg_23_0)
	local var_23_0 = arg_23_0.shipGroup:GetNationTxt()

	print(var_23_0)
	arg_23_0.illustrator:SetText(var_23_0)

	return
end

function var_0_0.GetCvList(arg_24_0, arg_24_1)
	return arg_24_1 and (pg.ship_skin_template[arg_24_0.skin.id].spine_use_live2d == 1 and pg.AssistantInfo.GetCVListForProfile(true, arg_24_0.skin.id) or pg.AssistantInfo.GetCVListForProfile(false, arg_24_0.skin.id)) or ShipWordHelper.GetCVList()
end

function var_0_0.UpdateCvList(arg_25_0, arg_25_1)
	arg_25_0:DestroyCvBtns()

	arg_25_0.cvBtns = {}
	arg_25_0.dispalys = arg_25_0:GetCvList(arg_25_1)

	table.sort(arg_25_0.dispalys, function(arg_26_0, arg_26_1)
		return arg_26_0.profile_index < arg_26_1.profile_index
	end)

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.dispalys) do
		arg_25_0:AddCvBtn(iter_25_1)
		arg_25_0:AddExCvBtn(iter_25_1)
	end

	local var_25_0 = (pg.character_voice.touch.profile_index - 1) * 2

	var_25_0 = arg_25_0.cvBtns[(pg.character_voice.touch.profile_index - 1) * 2] and arg_25_0.cvBtns[(pg.character_voice.touch.profile_index - 1) * 2]._tf:GetSiblingIndex() or var_25_0

	local var_25_1 = ShipWordHelper.GetMainSceneWordCnt(arg_25_0.skin.id, -1)
	local var_25_2 = ShipWordHelper.GetMainSceneWordCnt(arg_25_0.skin.id, (arg_25_0.shipGroup:GetMaxIntimacy()))

	if var_25_1 < var_25_2 then
		for iter_25_2 = var_25_1 + 1, var_25_2 do
			arg_25_0:AddMainExBtn(iter_25_2, var_25_0)

			var_25_0 = var_25_0 + 1
		end
	end

	return
end

function var_0_0.AddMainExBtn(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = ShipProfileMainExCvBtn.New(cloneTplTo(arg_27_0.cvTpl, arg_27_0.cvContainer))

	onButton(arg_27_0, var_27_0._tf, function()
		if arg_27_0.callback then
			arg_27_0.callback(var_27_0)
		end

		return
	end, SFX_PANEL)
	var_27_0:Init(arg_27_0.shipGroup, arg_27_0.skin, arg_27_0.isLive2d, arg_27_1)
	var_27_0:Update()
	var_27_0._tf:SetSiblingIndex(arg_27_2)
	table.insert(arg_27_0.cvBtns, var_27_0)

	return
end

function var_0_0.AddCvBtn(arg_29_0, arg_29_1)
	local var_29_0 = ShipProfileCvBtn.New(cloneTplTo(arg_29_0.cvTpl, arg_29_0.cvContainer))

	onButton(arg_29_0, var_29_0._tf, function()
		if arg_29_0.callback then
			arg_29_0.callback(var_29_0)
		end

		return
	end, SFX_PANEL)
	var_29_0:Init(arg_29_0.shipGroup, arg_29_0.skin, arg_29_0.isLive2d, arg_29_1)
	var_29_0:Update()
	table.insert(arg_29_0.cvBtns, var_29_0)

	return
end

function var_0_0.AddExCvBtn(arg_31_0, arg_31_1)
	local var_31_0 = ShipProfileExCvBtn.New(cloneTplTo(arg_31_0.cvTpl, arg_31_0.cvContainer))

	onButton(arg_31_0, var_31_0._tf, function()
		if arg_31_0.callback then
			arg_31_0.callback(var_31_0)
		end

		return
	end, SFX_PANEL)
	var_31_0:Init(arg_31_0.shipGroup, arg_31_0.skin, arg_31_0.isLive2d, arg_31_1, (arg_31_0.shipGroup:GetMaxIntimacy()))
	var_31_0:Update()
	table.insert(arg_31_0.cvBtns, var_31_0)

	return
end

function var_0_0.DestroyCvBtns(arg_33_0)
	if not arg_33_0.cvBtns then
		return
	end

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.cvBtns) do
		iter_33_1:Destroy()
	end

	return
end

function var_0_0.OnDestroy(arg_34_0)
	arg_34_0:DestroyCvBtns()

	arg_34_0.cvLoader = nil
	arg_34_0.callback = nil

	return
end

return var_0_0
