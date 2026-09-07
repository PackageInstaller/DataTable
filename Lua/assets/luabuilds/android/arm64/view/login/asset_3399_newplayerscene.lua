local NewPlayerScene = class("NewPlayerScene", import("..base.BaseUI"))
local var_0_3 = Vector3(-380, 265, 0)
local var_0_5 = {
	101171,
	201211,
	401231
}
local var_0_6 = {
	[201211] = "biaoqiang",
	[301051] = "lingbo",
	[401231] = "z23",
	[101171] = "lafei"
}
local var_0_7 = {
	[101171] = i18n("login_newPlayerScene_word_laFei"),
	[201211] = i18n("login_newPlayerScene_word_biaoqiang"),
	[401231] = i18n("login_newPlayerScene_word_z23")
}

function NewPlayerScene:getUIName()
	return "NewPlayerUI"
end

function NewPlayerScene:init()
	self.eventTriggers = {}
	self.characters = self._tf:Find("select_character/characters")
	self.propPanel = self._tf:Find("prop_panel")
	self.selectPanel = self._tf:Find("select_character")

	setActive(self.propPanel, false)
	setActive(self.selectPanel, true)

	self.confirmBtn = self.propPanel:Find("bg/qr_btn")
	self.tip = self._tf:Find("select_character/tip")
	self.skillPanel = self.propPanel:Find("bg/skill_panel")
	self.skillTpl = self:getTpl("bg/skill_panel/frame/skilltpl", self.propPanel)
	self.skillContainer = self.propPanel:Find("bg/skill_panel/frame")
	self.namedPanel = self._tf:Find("named_panel")

	setActive(self.namedPanel, false)

	self.info = self.namedPanel:Find("info")
	self.nickname = self.info:Find("nickname")
	self.qChar = self.propPanel:Find("q_char")
	self.chat = self.namedPanel:Find("info/tip/chatbgtop0/Text")
	self.propertyPanel = PropertyPanel.New(self.propPanel:Find("bg/property_panel/frame"))
	self.paintTF = self._tf:Find("prop_panel/bg/paint")
	self.nameTF = self._tf:Find("prop_panel/bg/name")
	self.nameEnTF = self._tf:Find("prop_panel/bg/english_name_bg")
	self.titleShipinfoTF = self._tf:Find("lines/hori/shipinfo_text")
	self.titleShipchooseTF = self._tf:Find("lines/hori/shipchoose_text")

	setImageAlpha(self.titleShipinfoTF, 1)
	setImageAlpha(self.titleShipchooseTF, 0)

	self.randBtn = findTF(self.info, "random_button")

	setActive(self.randBtn, PLATFORM_CODE == PLATFORM_CH)

	return
end

function NewPlayerScene:onBackPressed()
	if LeanTween.isTweening(go(self.propPanel)) then
		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if isActive(self.namedPanel) then
		self:closeNamedPanel()

		return
	end

	pg.SdkMgr.GetInstance():OnAndoridBackPress()

	return
end

function NewPlayerScene:switchPanel()
	setActive(self.propPanel, true)

	local var_4_0 = self.propPanel:GetComponent(typeof(CanvasGroup))
	local var_4_1 = self.selectPanel:GetComponent(typeof(CanvasGroup))

	LeanTween.value(go(self.propPanel), 0, 1, 0.5):setOnUpdate(System.Action_float(function(arg_5_0)
		var_4_0.alpha = arg_5_0
		var_4_1.alpha = 1 - arg_5_0

		return
	end)):setOnComplete(System.Action(function()
		setActive(self.selectPanel, false)

		return
	end))

	self.skillPanel.localPosition = Vector3.New(-1000, self.skillPanel.localPosition.y, self.skillPanel.localPosition.z)

	LeanTween.moveX(self.skillPanel, 339, 0.2)
	LeanTween.moveY(self._tf:Find("lines/line"), -328, 0.2)
	LeanTween.moveX(self._tf:Find("lines/hori"), -820, 0.2)

	for iter_4_0 = 1, 3 do
		local var_4_2 = self.characters:Find("character_" .. iter_4_0)
		local var_4_3 = self.propPanel:Find("bg/characters/character_" .. iter_4_0)

		setImageAlpha(var_4_2, 1)
		LeanTween.alpha(var_4_2, 0, 0.25)
		LeanTween.move(go(var_4_2), var_4_3.position, 0.3)
		setImageAlpha(self.titleShipinfoTF, 0)
		setImageAlpha(self.titleShipchooseTF, 1)
		LeanTween.alpha(self.titleShipinfoTF, 1, 0.25)
		LeanTween.alpha(self.titleShipchooseTF, 0, 0.25)
	end

	return
end

function NewPlayerScene:initCharacters()
	self.charInitPos = {}

	for iter_7_0 = 1, 3 do
		local var_7_0 = self._tf:Find("prop_panel/bg/characters/character_" .. iter_7_0)

		onToggle(self, var_7_0, function(arg_8_0)
			if arg_8_0 then
				self:selectCharacterByIdx(var_7_0, var_0_5[iter_7_0])
				setActive(var_7_0:Find("selected"), true)

				var_7_0:GetComponent(typeof(RectTransform)).sizeDelta = Vector2(196, 196)
			else
				setActive(var_7_0:Find("selected"), false)

				var_7_0:GetComponent(typeof(RectTransform)).sizeDelta = Vector2(140, 140)
			end

			return
		end)
	end

	local var_7_1 = {
		0.2,
		0.3,
		0.1
	}

	for iter_7_1 = 1, 3 do
		local var_7_2 = self.characters:Find("character_" .. iter_7_1)

		onButton(self, var_7_2, function()
			self:switchPanel()
			triggerToggle(self._tf:Find("prop_panel/bg/characters/character_" .. iter_7_1), true)

			return
		end)

		var_7_2.localPosition = Vector3.New(var_7_2.localPosition.x, 912, var_7_2.localPosition.z)

		setImageAlpha(var_7_2, 0)
		LeanTween.alpha(var_7_2, 1, 0.3):setDelay(var_7_1[iter_7_1])
		LeanTween.moveY(var_7_2, 0, 0.2):setDelay(var_7_1[iter_7_1])
	end

	return
end

function NewPlayerScene:didEnter()
	onButton(self, self.confirmBtn, function()
		self:showNamedPanel()

		return
	end, SFX_PANEL)
	onButton(self, findTF(self.info, "random_button"), function()
		local names = require("GameCfg.names")

		setInputText(self.nickname, names[1][math.random(#names[1])] .. names[2][math.random(#names[2])] .. names[3][math.random(#names[3])] .. names[4][math.random(#names[4])])

		return
	end, SFX_MAIN)
	onButton(self, findTF(self.info, "btn_container/enter_button"), function()
		if not self.contextData.configId then
			pg.TipsMgr.GetInstance():ShowTips(i18n("login_newPlayerScene_error_notChoiseShip"))

			return
		end

		local var_13_0 = getInputText(self.nickname)

		if var_13_0 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("login_newPlayerScene_inputName"))

			return
		end

		if not nameValidityCheck(var_13_0, 4, 14, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"login_newPlayerScene_invalideName"
		}) then
			return
		end

		self.event:emit(NewPlayerMediator.ON_CREATE, var_13_0, self.contextData.configId)

		return
	end, SFX_CONFIRM)
	onButton(self, findTF(self.info, "btn_container/cancel_button"), function()
		self:closeNamedPanel()

		return
	end)
	self:initCharacters()

	return
end

function NewPlayerScene:selectCharacterByIdx(arg_15_1, arg_15_2)
	self.inProp = true
	self.contextData.configId = arg_15_2

	self.propertyPanel:initProperty(arg_15_2)
	self:initSkills()
	setPaintingPrefab(self.paintTF, var_0_6[arg_15_2], "chuanwu")
	setText(self.nameTF:Find("name_mask/Text"), pg.ship_data_statistics[arg_15_2].name)
	setText(self.nameTF:Find("english_name"), pg.ship_data_statistics[arg_15_2].english_name)
	setText(self.nameEnTF, string.upper(pg.ship_data_statistics[arg_15_2].english_name))

	local var_15_0 = Ship.New({
		configId = self.contextData.configId
	}):getPrefab()

	if var_15_0 == self.shipPrefab then
		return
	end

	self:recycleSpineChar()
	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetSpineChar(var_15_0, true, function(arg_16_0)
		pg.UIMgr.GetInstance():LoadingOff()

		self.shipPrefab = var_15_0
		self.shipModel = arg_16_0

		arg_16_0:GetComponent("SpineAnimUI"):SetAction("stand", 0)

		tf(arg_16_0).localScale = Vector3(0.5, 0.5, 1)
		tf(arg_16_0).localPosition = Vector3(15, -95, 0)

		pg.ViewUtils.SetLayer(tf(arg_16_0), Layer.UI)
		removeAllChildren(self.qChar)
		SetParent(arg_16_0, self.qChar, false)

		return
	end)

	return
end

function NewPlayerScene:initSkills()
	removeAllChildren(self.skillContainer)

	for iter_17_0, iter_17_1 in ipairs(pg.ship_data_template[self.contextData.configId].buff_list_display) do
		local var_17_0 = getSkillConfig(iter_17_1)
		local var_17_1 = cloneTplTo(self.skillTpl, self.skillContainer)

		setActive(var_17_1:Find("mask"), not table.contains(pg.ship_data_template[self.contextData.configId].buff_list, iter_17_1))
		onButton(self, var_17_1, function()
			self:emit(NewPlayerMediator.ON_SKILLINFO, var_17_0.id)

			return
		end, SFX_PANEL)
		LoadImageSpriteAsync("skillicon/" .. var_17_0.icon, findTF(var_17_1, "icon"))
	end

	return
end

function NewPlayerScene:showNamedPanel()
	self.qChar:SetParent(self.info)
	pg.UIMgr.GetInstance():BlurPanel(self.namedPanel)
	setActive(self.namedPanel, true)
	setInputText(self.nickname, "")
	setText(self.chat, var_0_7[self.contextData.configId])

	return
end

function NewPlayerScene:closeNamedPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.namedPanel, self._tf)
	setActive(self.namedPanel, false)
	self.qChar:SetParent(self.propPanel)

	return
end

function NewPlayerScene:recycleSpineChar()
	if self.shipPrefab and self.shipModel then
		PoolMgr.GetInstance():ReturnSpineChar(self.shipPrefab, self.shipModel)

		self.shipPrefab = nil
		self.shipModel = nil
	end

	return
end

function NewPlayerScene:willExit()
	if self.eventTriggers then
		for iter_22_0, iter_22_1 in pairs(self.eventTriggers) do
			ClearEventTrigger(iter_22_0)
		end

		self.eventTriggers = nil
	end

	self:closeNamedPanel()

	return
end

return NewPlayerScene
