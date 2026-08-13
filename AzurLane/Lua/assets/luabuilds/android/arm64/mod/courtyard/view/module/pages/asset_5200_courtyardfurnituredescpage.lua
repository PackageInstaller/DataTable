class = var_0_10000

local var_0_0 = "CourtYardFurnitureDescPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardBaseSubPage"))

function var_0_1.getUIName(arg_1_0)
	return "CourtYardFurnitureDescUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.descPanel = var_1.Find(var_2_0, "desc")

	local var_2_1 = arg_2_0.descPanel

	arg_2_0.okBtn = var_1.Find(var_2_1, "ok_btn")
	findTF = var_1

	local var_2_2 = var_1(arg_2_0._tf, "desc/iconframe/icon")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.iconImg = var_2_3(var_2_2, var_4(var_1_10006))
	findTF = var_1

	local var_2_4 = var_1(arg_2_0._tf, "desc/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.nameTxt = var_2_5(var_2_4, var_4(var_1_10006))
	findTF = var_1

	local var_2_6 = var_1(arg_2_0._tf, "desc/container/frame/type")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.typeTxt = var_2_7(var_2_6, var_4(var_1_10006))
	findTF = var_1

	local var_2_8 = var_1(arg_2_0._tf, "desc/container/frame/content")
	local var_2_9 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.contentTxt = var_2_9(var_2_8, var_4(var_1_10006))
	findTF = var_1

	local var_2_10 = var_1(arg_2_0._tf, "desc/container/frame/comfortable_container/Text")
	local var_2_11 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.comtableTxt = var_2_11(var_2_10, var_4(var_1_10006))
	findTF = var_1

	local var_2_12 = var_1(arg_2_0._tf, "desc/container/frame/approach_container/Text")
	local var_2_13 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.approachTxt = var_2_13(var_2_12, var_4(var_1_10006))
	findTF = var_1

	local var_2_14 = var_1(arg_2_0._tf, "desc/container/frame/approach_container/TextLong")
	local var_2_15 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.approachLongTxt = var_2_15(var_2_14, var_4(var_1_10006))
	findTF = var_1
	arg_2_0.approachLabel = var_1(arg_2_0._tf, "desc/container/frame/approach_container/label")
	findTF = var_1

	local var_2_16 = var_1(arg_2_0._tf, "desc/container/frame/date_container/Text")
	local var_2_17 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.dateTxt = var_2_17(var_2_16, var_4(var_1_10006))
	findTF = var_1
	arg_2_0.voiceBtn = var_1(arg_2_0._tf, "desc/container/frame/music_btn/voice")
	findTF = var_1
	arg_2_0.bgVoiceBtn = var_1(arg_2_0._tf, "desc/container/frame/music_btn/bg_voice")
	findTF = var_1
	arg_2_0.bgVoiceMark = var_1(arg_2_0._tf, "desc/container/frame/music_btn/bg_voice/mark")
	findTF = var_1
	arg_2_0.musicalInstrumentsBtn = var_1(arg_2_0._tf, "desc/container/frame/music_btn/play")
	setText = var_1
	findTF = var_3

	local var_2_18 = var_3(arg_2_0._tf, "desc/container/frame/comfortable_container/label")

	i18n = var_4

	var_1(var_2_18, var_4("word_comfort_level"))

	setText = var_1

	local var_2_19 = arg_2_0.approachLabel

	i18n = var_4

	var_1(var_2_19, var_4("word_get_way"))

	setText = var_1
	findTF = var_2_19

	local var_2_20 = var_2_19(arg_2_0._tf, "desc/container/frame/date_container/label")

	i18n = var_4

	var_1(var_2_20, var_4("word_get_date"))

	setText = var_1
	findTF = var_2_20

	local var_2_21 = var_2_20(arg_2_0._tf, "desc/ok_btn/text")

	i18n = var_4

	var_1(var_2_21, var_4("word_ok"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Close(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.okBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Close(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.voiceBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Emit(var_6_0, "PlayFurnitureVoice", arg_3_0.furniture.id)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.bgVoiceBtn

	local function var_3_11()
		local var_7_0 = arg_3_0

		var_0.Emit(var_7_0, "PlayFurnitureBg", arg_3_0.furniture.id)

		setActive = var_0

		local var_7_1 = arg_3_0.bgVoiceMark
		local var_7_2 = arg_3_0.furniture

		var_0(var_7_1, var_3.GetMusicData(var_7_2))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.musicalInstrumentsBtn

	local function var_3_14()
		local var_8_0 = arg_3_0.furniture

		if var_0.IsMusicalInstruments(var_8_0) then
			local var_8_1 = arg_3_0

			var_0.Emit(var_8_1, "PlayMusicalInstruments", arg_3_0.furniture.id)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10006)

	return
end

function var_0_1.Show(arg_9_0, arg_9_1)
	setActive = var_1_10002

	var_1_10002(arg_9_0._tf, true)

	arg_9_0.furniture = arg_9_1

	local var_9_0 = arg_9_1
	local var_9_1, var_9_2 = arg_9_1.ExistVoice(var_9_0)

	setActive = var_9_0

	var_9_0(arg_9_0.voiceBtn, var_9_1 and (var_9_2 == 1 or var_9_2 == 3))

	setActive = var_9_0

	var_9_0(arg_9_0.bgVoiceBtn, var_9_1 and (var_9_2 == 2 or var_9_2 == 3))

	setAnchoredPosition = var_9_0

	var_9_0(arg_9_0.voiceBtn, {
		y = var_9_2 == 3 and -72 or -22
	})

	setActive = var_9_0

	var_9_0(arg_9_0.musicalInstrumentsBtn, arg_9_1:IsMusicalInstruments())

	setActive = var_9_0

	local var_9_3 = arg_9_0.bgVoiceMark
	local var_9_4 = arg_9_0.furniture

	var_9_0(var_9_3, var_7.GetMusicData(var_9_4))

	LoadSpriteAsync = var_9_0

	var_9_0("FurnitureIcon/" .. arg_9_1:GetIcon(), function(arg_10_0)
		if not arg_9_0.exited then
			arg_9_0.iconImg.sprite = arg_10_0
		end

		return
	end)

	local var_9_5 = arg_9_0.nameTxt

	shortenString = var_5
	var_9_5.text = var_5(arg_9_1:GetName(), 6)
	getProxy = var_9_5
	DormProxy = var_6

	local var_9_6 = var_9_5(var_6)
	local var_9_7 = var_4.getRawData(var_9_6)
	local var_9_8 = var_4.GetFurniture(var_9_7, arg_9_1.configId)
	local var_9_9 = arg_9_0.dateTxt
	local var_9_10

	if not var_9_8 or not var_9_8:getDate() then
		var_9_10 = arg_9_1:GetAddDate()
	end

	var_9_9.text = var_9_10
	arg_9_0.comtableTxt.text = "+" .. arg_9_1:GetComfortable()
	arg_9_0.contentTxt.text = arg_9_1:GetDescription()

	arg_9_0:ShowTxt()

	local var_9_11 = arg_9_0.typeTxt

	var_9_11.text = arg_9_1:GetGametipType()
	pg = var_9_11

	local var_9_12 = var_9_11.UIMgr.GetInstance()

	var_5.BlurPanel(var_9_12, arg_9_0._tf)

	local var_9_13 = arg_9_1
	local var_9_14 = arg_9_1.IsType

	Furniture = var_8

	local var_9_15 = var_9_14(var_9_13, var_8.TYPE_LUTE)

	setActive = var_6

	var_6(arg_9_0.approachTxt.gameObject.transform.parent, not var_9_15)

	setActive = var_6

	var_6(arg_9_0.dateTxt.gameObject.transform.parent, not var_9_15)

	return
end

function var_0_1.ShowTxt(arg_11_0)
	local var_11_0 = arg_11_0.furniture
	local var_11_1 = var_1.GetAddMode(var_11_0)

	i18n = var_1_10002

	local var_11_2 = var_1_10002("word_get_way") .. var_11_1

	arg_11_0.approachTxt.text = var_11_1

	local var_11_3 = arg_11_0.approachLongTxt

	var_11_3.text = var_11_2
	Canvas = var_11_3

	var_11_3.ForceUpdateCanvases()

	local var_11_4 = arg_11_0.approachTxt
	local var_11_5 = var_3.GetComponent

	typeof = var_1_10006
	RectTransform = var_1_10008

	local var_11_6 = var_11_5(var_11_4, var_1_10006(var_1_10008))
	local var_11_7 = arg_11_0.approachTxt.preferredWidth
	local var_11_8 = var_11_6.rect.width < var_11_7

	setActive = var_5

	var_5(arg_11_0.approachTxt.gameObject, not var_11_8)

	setActive = var_5

	var_5(arg_11_0.approachLongTxt.gameObject, var_11_8)

	setActive = var_5

	var_5(arg_11_0.approachLabel, not var_11_8)

	return
end

function var_0_1.Close(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0._tf, false)

	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_0, arg_12_0._tf, arg_12_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	arg_13_0.exited = true

	arg_13_0:Close()

	return
end

return var_0_1
