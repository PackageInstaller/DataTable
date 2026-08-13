class = var_0_10000

local var_0_0 = "ShipProfileInformationPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ShipProfileInformationPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "bg/author_panel/cvPanel/label/mask/Text")

	arg_2_0.voiceActor = var_1.GetComponent(var_2_1, "ScrollText")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "bg/author_panel/illustPanel/illustrator/label/mask/Text")

	arg_2_0.illustrator = var_1.GetComponent(var_2_3, "ScrollText")

	local var_2_4 = arg_2_0._tf

	arg_2_0.cvContainer = var_1.Find(var_2_4, "bg/lines_panel/lines_list/Grid")
	arg_2_0.cvTpl = arg_2_0:getTpl("bg/lines_panel/lines_list/Grid/lines_tpl")

	local var_2_5 = arg_2_0._tf

	arg_2_0.weddingReview = var_1.Find(var_2_5, "bg/wedding")

	local var_2_6 = arg_2_0._tf

	arg_2_0.voiceBtn = var_1.Find(var_2_6, "bg/language_change")

	local var_2_7 = arg_2_0.voiceBtn

	arg_2_0.voiceBtnSel = var_1.Find(var_2_7, "sel")

	local var_2_8 = arg_2_0.voiceBtn

	arg_2_0.voiceBtnUnsel = var_1.Find(var_2_8, "unsel")
	arg_2_0.voiceBtnPositions = {
		arg_2_0.voiceBtnSel.localPosition,
		arg_2_0.voiceBtnUnsel.localPosition
	}

	local var_2_9 = arg_2_0.voiceBtn
	local var_2_10 = var_1.Find(var_2_9, "Text")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.voiceBtnTxt = var_2_11(var_2_10, var_3(var_1_10004))

	local var_2_12 = arg_2_0.voiceBtn
	local var_2_13 = var_1.Find(var_2_12, "Text1")
	local var_2_14 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.voiceBtnTxt1 = var_2_14(var_2_13, var_3(var_1_10004))

	local var_2_15 = arg_2_0._tf

	arg_2_0.profilePlayBtn = var_1.Find(var_2_15, "bg/prototype_panel/title/playButton")

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_1.Find(var_2_16, "bg/prototype_panel/desc/scroll/Text")
	local var_2_18 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.profileTxt = var_2_18(var_2_17, var_3(var_1_10004))

	return
end

function var_0_1.UpdateCvBtn(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.voiceBtnPositions[arg_3_1 and 2 or 1]
	local var_3_1 = arg_3_0.voiceBtnPositions[arg_3_1 and 1 or 2]

	arg_3_0.voiceBtnSel.localPosition = var_3_0

	local var_3_2 = arg_3_0.voiceBtnUnsel

	var_3_2.localPosition = var_3_1
	Color = var_3_2

	local var_3_3 = var_3_2.New(1, 1, 1, 1)

	Color = var_5

	local var_3_4 = var_5.New(0.5, 0.5, 0.5, 1)

	arg_3_0.voiceBtnTxt.color = arg_3_1 and var_3_3 or var_3_4
	arg_3_0.voiceBtnTxt1.color = arg_3_1 and var_3_4 or var_3_3

	return
end

function var_0_1.UpdateLang2(arg_4_0)
	local var_4_0 = arg_4_0.skin.ship_group

	ShipGroup = var_1_10002

	local var_4_1 = var_1_10002.getDefaultSkin(var_4_0)

	pg = var_3

	local var_4_2 = var_3.ship_skin_words[var_4_1.id]

	PlayerPrefs = var_4

	local var_4_3 = var_4.SetInt

	CV_LANGUAGE_KEY = var_1_10005

	var_4_3(var_1_10005 .. var_4_0, 2)

	local var_4_4 = arg_4_0.cvLoader

	var_4.Load(var_4_4, arg_4_0.skin.id)
	arg_4_0:SetAuthorInfo()
	arg_4_0:UpdateCvList(arg_4_0.isLive2d)
	arg_4_0:UpdateProfileInfo()

	return
end

function var_0_1.UpdateLang1(arg_5_0)
	local var_5_0 = arg_5_0.skin.ship_group

	ShipGroup = var_1_10002

	local var_5_1 = var_1_10002.getDefaultSkin(var_5_0)

	pg = var_3

	local var_5_2 = var_3.ship_skin_words[var_5_1.id]

	PlayerPrefs = var_4

	local var_5_3 = var_4.SetInt

	CV_LANGUAGE_KEY = var_1_10005

	var_5_3(var_1_10005 .. var_5_0, 1)

	local var_5_4 = arg_5_0.cvLoader

	var_4.Load(var_5_4, arg_5_0.skin.id)
	arg_5_0:SetAuthorInfo()
	arg_5_0:UpdateCvList(arg_5_0.isLive2d)
	arg_5_0:UpdateProfileInfo()

	return
end

function var_0_1.OnCvBtn(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1

	onButton = var_1_10003

	local var_6_1 = arg_6_0
	local var_6_2 = arg_6_0.voiceBtn

	local function var_6_3()
		var_6_0 = not var_6_0

		local var_7_0 = arg_6_0

		var_0.UpdateCvBtn(var_7_0, var_6_0)

		if var_6_0 then
			local var_7_1 = arg_6_0

			var_0.UpdateLang2(var_7_1)
		else
			local var_7_2 = arg_6_0

			var_0.UpdateLang1(var_7_2)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10003(var_6_1, var_6_2, var_6_3, var_1_10007)
	arg_6_0:UpdateCvBtn(var_6_0)

	return
end

function var_0_1.OnInit(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.weddingReview

	local function var_8_2()
		local var_9_0 = arg_8_0
		local var_9_1 = var_0.emit

		ShipProfileScene = var_2_10002

		var_9_1(var_9_0, var_2_10002.WEDDING_REVIEW, {
			group = arg_8_0.shipGroup,
			skinID = arg_8_0.skin.id
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	return
end

function var_0_1.EnterAnim(arg_10_0, arg_10_1, arg_10_2)
	LeanTween = var_1_10003

	local var_10_0 = var_1_10003.moveX

	rtf = var_1_10004

	local var_10_1 = var_10_0(var_1_10004(arg_10_0._tf), 0, arg_10_1)
	local var_10_2 = var_3.setEase

	LeanTweenType = var_5

	local var_10_3 = var_10_2(var_10_1, var_5.easeInOutSine)
	local var_10_4 = var_3.setOnComplete

	System = var_5

	var_10_4(var_10_3, var_5.Action(arg_10_2))

	return
end

function var_0_1.ExistAnim(arg_11_0, arg_11_1, arg_11_2)
	LeanTween = var_1_10003

	local var_11_0 = var_1_10003.moveX

	rtf = var_1_10004

	local var_11_1 = var_11_0(var_1_10004(arg_11_0._tf), 1000, arg_11_1)
	local var_11_2 = var_3.setEase

	LeanTweenType = var_5

	local var_11_3 = var_11_2(var_11_1, var_5.easeInOutSine)
	local var_11_4 = var_3.setOnComplete

	System = var_5

	var_11_4(var_11_3, var_5.Action(function()
		if arg_11_2 then
			arg_11_2()
		end

		local var_12_0 = arg_11_0

		var_0.Hide(var_12_0)

		return
	end))

	return
end

function var_0_1.Update(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0:Show()

	arg_13_0.shipGroup = arg_13_1
	arg_13_0.showTrans = arg_13_2
	setActive = var_4

	var_4(arg_13_0.weddingReview, arg_13_1.married == 1)

	isActive = var_4

	if var_4(arg_13_0.weddingReview) then
		local var_13_0 = arg_13_1
		local var_13_1 = arg_13_1.getProposeType(var_13_0)

		eachChild = var_13_0

		var_13_0(arg_13_0.weddingReview, function(arg_14_0)
			setActive = var_2_10001

			var_2_10001(arg_14_0, arg_14_0.name == var_13_1)

			return
		end)
	end

	if arg_13_3 then
		arg_13_3()
	end

	return
end

function var_0_1.Flush(arg_15_0, arg_15_1, arg_15_2)
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

	local var_15_0 = arg_15_0.cvLoader

	var_3.Load(var_15_0, arg_15_0.skin.id)

	return
end

function var_0_1.UpdateProfileInfo(arg_16_0)
	ShipWordHelper = var_1_10001

	local var_16_0 = var_1_10001.GetWordAndCV
	local var_16_1 = arg_16_0.skin.id

	ShipWordHelper = var_1_10003

	local var_16_2, var_16_3, var_16_4 = var_16_0(var_16_1, var_1_10003.WORD_TYPE_PROFILE)
	local var_16_5 = arg_16_0.profileTxt

	SwitchSpecialChar = var_1_10005
	var_16_5.text = var_1_10005(var_16_4, true)
	pg = var_16_5

	if var_16_5.ship_skin_words[arg_16_0.skin.id] then
		local var_16_6 = var_4.voice_key
		local var_16_8

		if not (0 <= var_16_6) and var_4.voice_key ~= -2 then
			local var_16_7 = var_4.voice_key_2

			if not (0 < var_16_7) or not (var_4.voice_key < 0) then
				var_16_8 = false

				goto label_16_0
			end
		end

		var_16_8 = true

		::label_16_0::

		if var_16_8 then
			onButton = var_6

			local var_16_9 = arg_16_0
			local var_16_10 = arg_16_0.profilePlayBtn

			local function var_16_11()
				local var_17_0 = arg_16_0.cvLoader

				var_0.PlaySound(var_17_0, var_16_3)

				return
			end

			SFX_PANEL = var_1_10010

			var_6(var_16_9, var_16_10, var_16_11, var_1_10010)
		end

		setActive = var_6

		var_6(arg_16_0.profilePlayBtn, var_16_8)

		return
	end
end

function var_0_1.SetCvLoader(arg_18_0, arg_18_1)
	arg_18_0.cvLoader = arg_18_1

	return
end

function var_0_1.SetCallback(arg_19_0, arg_19_1)
	arg_19_0.callback = arg_19_1

	return
end

function var_0_1.UpdateLanguage(arg_20_0)
	local var_20_0 = arg_20_0.skin.ship_group

	ShipGroup = var_1_10002

	local var_20_1 = var_1_10002.getDefaultSkin(var_20_0)

	pg = var_3

	local var_20_2 = var_3.ship_skin_words[arg_20_0.skin.id]

	setmetatable = var_4

	local var_20_3 = var_4({}, {
		__index = function(arg_21_0, arg_21_1)
			if arg_21_1 == "voice_key_2" then
				pg = var_2_10002

				if var_2_10002.ship_skin_words[arg_20_0.skin.id][arg_21_1] == 0 then
					rawset = var_2_10002

					local var_21_0 = arg_21_0
					local var_21_1 = arg_21_1

					pg = var_2_10005

					var_2_10002(var_21_0, var_21_1, var_2_10005.ship_skin_words[var_20_1.id][arg_21_1])

					goto label_21_0
				end
			end

			rawset = var_2_10002

			do
				local var_21_2 = arg_21_0
				local var_21_3 = arg_21_1

				pg = var_2_10005

				var_2_10002(var_21_2, var_21_3, var_2_10005.ship_skin_words[arg_20_0.skin.id][arg_21_1])
			end

			::label_21_0::

			return arg_21_0[arg_21_1]
		end
	})

	ShipWordHelper = var_4

	local var_20_4 = var_4.GetLanguageSetting(arg_20_0.skin.id)
	local var_20_5 = var_20_3.voice_key_2 >= 0 or var_20_3.voice_key_2 == -2
	local var_20_6 = var_20_3.voice_key_2

	if 0 <= var_20_6 and var_20_4 == 0 then
		pg = var_20_6
		var_20_4 = var_20_6.gameset.language_default.key_value
		PlayerPrefs = var_6

		local var_20_7 = var_6.SetInt

		CV_LANGUAGE_KEY = var_7

		var_20_7(var_7 .. var_20_0, var_20_4)
	end

	arg_20_0:OnCvBtn(var_20_4 == 2)

	if var_20_3.voice_key_2 >= 0 or var_20_3.voice_key_2 == -2 then
		if var_20_3.voice_key_2 % 10 == 2 then
			local var_20_8 = arg_20_0.voiceBtnTxt

			i18n = var_8
			var_20_8.text = var_8("word_chinese")

			local var_20_9 = arg_20_0.voiceBtnTxt1

			i18n = var_8
			var_20_9.text = var_8("word_japanese")
		elseif var_6 == 3 then
			local var_20_10 = arg_20_0.voiceBtnTxt

			i18n = var_8
			var_20_10.text = var_8("word_japanese_2")

			local var_20_11 = arg_20_0.voiceBtnTxt1

			i18n = var_8
			var_20_11.text = var_8("word_japanese_3")
		end
	end

	setActive = var_6

	var_6(arg_20_0.voiceBtn, var_20_5)

	return
end

function var_0_1.SetAuthorInfo(arg_22_0)
	local var_22_0 = arg_22_0.skin

	ShipWordHelper = var_1_10002

	local var_22_1 = var_1_10002.GetCVAuthor(var_22_0.id)

	print = var_3

	var_3(var_22_1 .. "  ----")

	local var_22_2 = arg_22_0.voiceActor

	var_3.SetText(var_22_2, var_22_1)

	return
end

function var_0_1.SetIllustrator(arg_23_0)
	local var_23_0 = arg_23_0.shipGroup
	local var_23_1 = var_1.GetNationTxt(var_23_0)

	print = var_23_0

	var_23_0(var_23_1)

	local var_23_2 = arg_23_0.illustrator

	var_3.SetText(var_23_2, var_23_1)

	return
end

function var_0_1.GetCvList(arg_24_0, arg_24_1)
	local var_24_0 = {}

	if arg_24_1 then
		pg = var_1_10003

		if var_1_10003.ship_skin_template[arg_24_0.skin.id].spine_use_live2d == 1 then
			pg = var_1_10003
			var_24_0 = var_1_10003.AssistantInfo.GetCVListForProfile(true, arg_24_0.skin.id)
		else
			pg = var_1_10003
			var_24_0 = var_1_10003.AssistantInfo.GetCVListForProfile(false, arg_24_0.skin.id)
		end
	else
		ShipWordHelper = var_1_10003
		var_24_0 = var_1_10003.GetCVList()
	end

	return var_24_0
end

function var_0_1.UpdateCvList(arg_25_0, arg_25_1)
	arg_25_0:DestroyCvBtns()

	arg_25_0.cvBtns = {}
	arg_25_0.dispalys = arg_25_0:GetCvList(arg_25_1)
	table = var_2

	var_2.sort(arg_25_0.dispalys, function(arg_26_0, arg_26_1)
		return arg_26_0.profile_index < arg_26_1.profile_index
	end)

	ipairs = var_2

	for iter_25_0, iter_25_1 in var_2(arg_25_0.dispalys) do
		arg_25_0:AddCvBtn(iter_25_1)
		arg_25_0:AddExCvBtn(iter_25_1)
	end

	pg = var_2

	local var_25_0 = (var_2.character_voice.touch.profile_index - 1) * 2

	if arg_25_0.cvBtns[var_25_0] then
		local var_25_1 = var_3._tf

		var_25_0 = var_4.GetSiblingIndex(var_25_1) or var_25_0
	end

	ShipWordHelper = var_4

	local var_25_2 = var_4.GetMainSceneWordCnt(arg_25_0.skin.id, -1)
	local var_25_3 = arg_25_0.shipGroup
	local var_25_4 = var_5.GetMaxIntimacy(var_25_3)

	ShipWordHelper = var_25_3

	if var_25_2 < var_25_3.GetMainSceneWordCnt(arg_25_0.skin.id, var_25_4) then
		for iter_25_2 = var_25_2 + 1, var_6 do
			arg_25_0:AddMainExBtn(iter_25_2, var_25_0)

			var_25_0 = var_25_0 + 1
		end
	end

	return
end

function var_0_1.AddMainExBtn(arg_27_0, arg_27_1, arg_27_2)
	ShipProfileMainExCvBtn = var_1_10003

	local var_27_0 = var_1_10003.New

	cloneTplTo = var_1_10004

	local var_27_1 = var_27_0(var_1_10004(arg_27_0.cvTpl, arg_27_0.cvContainer))

	onButton = var_4

	local var_27_2 = arg_27_0
	local var_27_3 = var_27_1._tf

	local function var_27_4()
		if arg_27_0.callback then
			arg_27_0.callback(var_27_1)
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_27_2, var_27_3, var_27_4, var_1_10008)
	var_27_1:Init(arg_27_0.shipGroup, arg_27_0.skin, arg_27_0.isLive2d, arg_27_1)
	var_27_1:Update()

	local var_27_5 = var_27_1._tf

	var_4.SetSiblingIndex(var_27_5, arg_27_2)

	table = var_4

	var_4.insert(arg_27_0.cvBtns, var_27_1)

	return
end

function var_0_1.AddCvBtn(arg_29_0, arg_29_1)
	ShipProfileCvBtn = var_1_10002

	local var_29_0 = var_1_10002.New

	cloneTplTo = var_1_10003

	local var_29_1 = var_29_0(var_1_10003(arg_29_0.cvTpl, arg_29_0.cvContainer))

	onButton = var_3

	local var_29_2 = arg_29_0
	local var_29_3 = var_29_1._tf

	local function var_29_4()
		if arg_29_0.callback then
			arg_29_0.callback(var_29_1)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_29_2, var_29_3, var_29_4, var_1_10007)
	var_29_1:Init(arg_29_0.shipGroup, arg_29_0.skin, arg_29_0.isLive2d, arg_29_1)
	var_29_1:Update()

	table = var_3

	var_3.insert(arg_29_0.cvBtns, var_29_1)

	return
end

function var_0_1.AddExCvBtn(arg_31_0, arg_31_1)
	ShipProfileExCvBtn = var_1_10002

	local var_31_0 = var_1_10002.New

	cloneTplTo = var_1_10003

	local var_31_1 = var_31_0(var_1_10003(arg_31_0.cvTpl, arg_31_0.cvContainer))

	onButton = var_3

	local var_31_2 = arg_31_0
	local var_31_3 = var_31_1._tf

	local function var_31_4()
		if arg_31_0.callback then
			arg_31_0.callback(var_31_1)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_31_2, var_31_3, var_31_4, var_1_10007)

	local var_31_5 = arg_31_0.shipGroup
	local var_31_6 = var_3.GetMaxIntimacy(var_31_5)

	var_31_1:Init(arg_31_0.shipGroup, arg_31_0.skin, arg_31_0.isLive2d, arg_31_1, var_31_6)
	var_31_1:Update()

	table = var_4

	var_4.insert(arg_31_0.cvBtns, var_31_1)

	return
end

function var_0_1.DestroyCvBtns(arg_33_0)
	if not arg_33_0.cvBtns then
		return
	end

	ipairs = var_1

	for iter_33_0, iter_33_1 in var_1(arg_33_0.cvBtns) do
		iter_33_1:Destroy()
	end

	return
end

function var_0_1.OnDestroy(arg_34_0)
	arg_34_0:DestroyCvBtns()

	arg_34_0.cvLoader = nil
	arg_34_0.callback = nil

	return
end

return var_0_1
