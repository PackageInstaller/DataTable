local var_0_0 = class("CourtYardFurnitureDescPage", import(".CourtYardBaseSubPage"))

function var_0_0.getUIName(arg_1_0)
	return "CourtYardFurnitureDescUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.descPanel = arg_2_0._tf:Find("desc")
	arg_2_0.okBtn = arg_2_0.descPanel:Find("ok_btn")
	arg_2_0.iconImg = findTF(arg_2_0._tf, "desc/iconframe/icon"):GetComponent(typeof(Image))
	arg_2_0.nameTxt = findTF(arg_2_0._tf, "desc/Text"):GetComponent(typeof(Text))
	arg_2_0.typeTxt = findTF(arg_2_0._tf, "desc/container/frame/type"):GetComponent(typeof(Text))
	arg_2_0.contentTxt = findTF(arg_2_0._tf, "desc/container/frame/content"):GetComponent(typeof(Text))
	arg_2_0.comtableTxt = findTF(arg_2_0._tf, "desc/container/frame/comfortable_container/Text"):GetComponent(typeof(Text))
	arg_2_0.approachTxt = findTF(arg_2_0._tf, "desc/container/frame/approach_container/Text"):GetComponent(typeof(Text))
	arg_2_0.approachLongTxt = findTF(arg_2_0._tf, "desc/container/frame/approach_container/TextLong"):GetComponent(typeof(Text))
	arg_2_0.approachLabel = findTF(arg_2_0._tf, "desc/container/frame/approach_container/label")
	arg_2_0.dateTxt = findTF(arg_2_0._tf, "desc/container/frame/date_container/Text"):GetComponent(typeof(Text))
	arg_2_0.voiceBtn = findTF(arg_2_0._tf, "desc/container/frame/music_btn/voice")
	arg_2_0.bgVoiceBtn = findTF(arg_2_0._tf, "desc/container/frame/music_btn/bg_voice")
	arg_2_0.bgVoiceMark = findTF(arg_2_0._tf, "desc/container/frame/music_btn/bg_voice/mark")
	arg_2_0.musicalInstrumentsBtn = findTF(arg_2_0._tf, "desc/container/frame/music_btn/play")

	setText(findTF(arg_2_0._tf, "desc/container/frame/comfortable_container/label"), i18n("word_comfort_level"))
	setText(arg_2_0.approachLabel, i18n("word_get_way"))
	setText(findTF(arg_2_0._tf, "desc/container/frame/date_container/label"), i18n("word_get_date"))
	setText(findTF(arg_2_0._tf, "desc/ok_btn/text"), i18n("word_ok"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Close()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.okBtn, function()
		arg_3_0:Close()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.voiceBtn, function()
		arg_3_0:Emit("PlayFurnitureVoice", arg_3_0.furniture.id)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.bgVoiceBtn, function()
		arg_3_0:Emit("PlayFurnitureBg", arg_3_0.furniture.id)
		setActive(arg_3_0.bgVoiceMark, arg_3_0.furniture:GetMusicData())

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.musicalInstrumentsBtn, function()
		if arg_3_0.furniture:IsMusicalInstruments() then
			arg_3_0:Emit("PlayMusicalInstruments", arg_3_0.furniture.id)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_9_0, arg_9_1)
	local var_9_9000

	setActive(arg_9_0._tf, true)

	arg_9_0.furniture = arg_9_1

	local var_9_0, var_9_1 = arg_9_1:ExistVoice()

	setActive(arg_9_0.voiceBtn, var_9_0 and (var_9_1 == 1 or var_9_1 == 3))
	setActive(arg_9_0.bgVoiceBtn, var_9_0 and (var_9_1 == 2 or var_9_1 == 3))
	setAnchoredPosition(arg_9_0.voiceBtn, {
		y = var_9_1 == 3 and -72 or -22
	})
	setActive(arg_9_0.musicalInstrumentsBtn, arg_9_1:IsMusicalInstruments())
	setActive(arg_9_0.bgVoiceMark, arg_9_0.furniture:GetMusicData())
	LoadSpriteAsync("FurnitureIcon/" .. arg_9_1:GetIcon(), function(arg_10_0)
		if not arg_9_0.exited then
			arg_9_0.iconImg.sprite = arg_10_0
		end

		return
	end)

	arg_9_0.nameTxt.text = shortenString(arg_9_1:GetName(), 6)

	local var_9_2 = getProxy(DormProxy):getRawData()
	local var_9_3 = var_9_2.GetFurniture(var_9_9000, arg_9_1.configId)
	local var_9_4 = arg_9_0.dateTxt
	local var_9_5 = var_9_3 and var_9_3:getDate() or arg_9_1:GetAddDate()

	var_9_4.text = var_9_2
	arg_9_0.comtableTxt.text = "+" .. arg_9_1:GetComfortable()
	arg_9_0.contentTxt.text = arg_9_1:GetDescription()

	arg_9_0:ShowTxt()

	arg_9_0.typeTxt.text = arg_9_1:GetGametipType()

	pg.UIMgr.GetInstance():BlurPanel(arg_9_0._tf)

	local var_9_6 = arg_9_1:IsType(Furniture.TYPE_LUTE)

	setActive(arg_9_0.approachTxt.gameObject.transform.parent, not var_9_6)
	setActive(arg_9_0.dateTxt.gameObject.transform.parent, not var_9_6)

	return
end

function var_0_0.ShowTxt(arg_11_0)
	local var_11_0 = arg_11_0.furniture:GetAddMode()

	arg_11_0.approachTxt.text = var_11_0
	arg_11_0.approachLongTxt.text = i18n("word_get_way") .. var_11_0

	Canvas.ForceUpdateCanvases()

	local var_11_1 = arg_11_0.approachTxt.preferredWidth > arg_11_0.approachTxt:GetComponent(typeof(RectTransform)).rect.width

	setActive(arg_11_0.approachTxt.gameObject, not var_11_1)
	setActive(arg_11_0.approachLongTxt.gameObject, var_11_1)
	setActive(arg_11_0.approachLabel, not var_11_1)

	return
end

function var_0_0.Close(arg_12_0)
	setActive(arg_12_0._tf, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_12_0._tf, arg_12_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_13_0)
	arg_13_0.exited = true

	arg_13_0:Close()

	return
end

return var_0_0
