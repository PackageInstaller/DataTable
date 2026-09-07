local CourtYardFurnitureDescPage = class("CourtYardFurnitureDescPage", import(".CourtYardBaseSubPage"))

function CourtYardFurnitureDescPage:getUIName()
	return "CourtYardFurnitureDescUI"
end

function CourtYardFurnitureDescPage:OnLoaded()
	self.descPanel = self._tf:Find("desc")
	self.okBtn = self.descPanel:Find("ok_btn")
	self.iconImg = findTF(self._tf, "desc/iconframe/icon"):GetComponent(typeof(Image))
	self.nameTxt = findTF(self._tf, "desc/Text"):GetComponent(typeof(Text))
	self.typeTxt = findTF(self._tf, "desc/container/frame/type"):GetComponent(typeof(Text))
	self.contentTxt = findTF(self._tf, "desc/container/frame/content"):GetComponent(typeof(Text))
	self.comtableTxt = findTF(self._tf, "desc/container/frame/comfortable_container/Text"):GetComponent(typeof(Text))
	self.approachTxt = findTF(self._tf, "desc/container/frame/approach_container/Text"):GetComponent(typeof(Text))
	self.approachLongTxt = findTF(self._tf, "desc/container/frame/approach_container/TextLong"):GetComponent(typeof(Text))
	self.approachLabel = findTF(self._tf, "desc/container/frame/approach_container/label")
	self.dateTxt = findTF(self._tf, "desc/container/frame/date_container/Text"):GetComponent(typeof(Text))
	self.voiceBtn = findTF(self._tf, "desc/container/frame/music_btn/voice")
	self.bgVoiceBtn = findTF(self._tf, "desc/container/frame/music_btn/bg_voice")
	self.bgVoiceMark = findTF(self._tf, "desc/container/frame/music_btn/bg_voice/mark")
	self.musicalInstrumentsBtn = findTF(self._tf, "desc/container/frame/music_btn/play")

	setText(findTF(self._tf, "desc/container/frame/comfortable_container/label"), i18n("word_comfort_level"))
	setText(self.approachLabel, i18n("word_get_way"))
	setText(findTF(self._tf, "desc/container/frame/date_container/label"), i18n("word_get_date"))
	setText(findTF(self._tf, "desc/ok_btn/text"), i18n("word_ok"))

	return
end

function CourtYardFurnitureDescPage:OnInit()
	onButton(self, self._tf, function()
		self:Close()

		return
	end, SFX_PANEL)
	onButton(self, self.okBtn, function()
		self:Close()

		return
	end, SFX_PANEL)
	onButton(self, self.voiceBtn, function()
		self:Emit("PlayFurnitureVoice", self.furniture.id)

		return
	end, SFX_PANEL)
	onButton(self, self.bgVoiceBtn, function()
		self:Emit("PlayFurnitureBg", self.furniture.id)
		setActive(self.bgVoiceMark, self.furniture:GetMusicData())

		return
	end, SFX_PANEL)
	onButton(self, self.musicalInstrumentsBtn, function()
		if self.furniture:IsMusicalInstruments() then
			self:Emit("PlayMusicalInstruments", self.furniture.id)
		end

		return
	end, SFX_PANEL)

	return
end

function CourtYardFurnitureDescPage:Show(arg_9_1)
	setActive(self._tf, true)

	self.furniture = arg_9_1

	local var_9_0, var_9_1 = arg_9_1:ExistVoice()

	setActive(self.voiceBtn, var_9_0 and (var_9_1 == 1 or var_9_1 == 3))
	setActive(self.bgVoiceBtn, var_9_0 and (var_9_1 == 2 or var_9_1 == 3))
	setAnchoredPosition(self.voiceBtn, {
		y = var_9_1 == 3 and -72 or -22
	})
	setActive(self.musicalInstrumentsBtn, arg_9_1:IsMusicalInstruments())
	setActive(self.bgVoiceMark, self.furniture:GetMusicData())
	LoadSpriteAsync("FurnitureIcon/" .. arg_9_1:GetIcon(), function(arg_10_0)
		if not self.exited then
			self.iconImg.sprite = arg_10_0
		end

		return
	end)

	self.nameTxt.text = shortenString(arg_9_1:GetName(), 6)

	local var_9_2 = getProxy(DormProxy):getRawData()
	local var_9_3 = var_9_2:GetFurniture(arg_9_1.configId)
	local var_9_4 = self.dateTxt
	local var_9_5 = var_9_3 and var_9_3:getDate() or arg_9_1:GetAddDate()

	var_9_4.text = var_9_2
	self.comtableTxt.text = "+" .. arg_9_1:GetComfortable()
	self.contentTxt.text = arg_9_1:GetDescription()

	self:ShowTxt()

	self.typeTxt.text = arg_9_1:GetGametipType()

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	local var_9_6 = arg_9_1:IsType(Furniture.TYPE_LUTE)

	setActive(self.approachTxt.gameObject.transform.parent, not var_9_6)
	setActive(self.dateTxt.gameObject.transform.parent, not var_9_6)

	return
end

function CourtYardFurnitureDescPage:ShowTxt()
	local var_11_0 = self.furniture:GetAddMode()

	self.approachTxt.text = var_11_0
	self.approachLongTxt.text = i18n("word_get_way") .. var_11_0

	Canvas.ForceUpdateCanvases()

	local var_11_1 = self.approachTxt.preferredWidth > self.approachTxt:GetComponent(typeof(RectTransform)).rect.width

	setActive(self.approachTxt.gameObject, not var_11_1)
	setActive(self.approachLongTxt.gameObject, var_11_1)
	setActive(self.approachLabel, not var_11_1)

	return
end

function CourtYardFurnitureDescPage:Close()
	setActive(self._tf, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function CourtYardFurnitureDescPage:OnDestroy()
	self.exited = true

	self:Close()

	return
end

return CourtYardFurnitureDescPage
