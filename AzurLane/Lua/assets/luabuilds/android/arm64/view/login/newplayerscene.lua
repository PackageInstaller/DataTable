class = var_0_10000

local var_0_0 = "NewPlayerScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))
local var_0_2 = 0.5
local var_0_3 = -300

Vector3 = var_3

local var_0_4 = var_3(-380, 265, 0)
local var_0_5 = 19
local var_0_6 = {
	101171,
	201211,
	401231
}
local var_0_7 = {
	[201211] = "biaoqiang",
	[301051] = "lingbo",
	[401231] = "z23",
	[101171] = "lafei"
}
local var_0_8 = {}

i18n = var_0_10008

local var_0_9 = var_0_10008("login_newPlayerScene_word_laFei")

var_0_8[101171] = var_0_9
i18n = var_0_9

local var_0_10 = var_0_9("login_newPlayerScene_word_biaoqiang")

var_0_8[201211] = var_0_10
i18n = var_0_10

local var_0_11 = var_0_10("login_newPlayerScene_word_z23")

var_0_8[401231] = var_0_11

function var_0_1.getUIName(arg_1_0)
	return "NewPlayerUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0.eventTriggers = {}

	local var_2_0 = arg_2_0._tf

	arg_2_0.characters = var_1.Find(var_2_0, "select_character/characters")

	local var_2_1 = arg_2_0._tf

	arg_2_0.propPanel = var_1.Find(var_2_1, "prop_panel")

	local var_2_2 = arg_2_0._tf

	arg_2_0.selectPanel = var_1.Find(var_2_2, "select_character")
	setActive = var_1

	var_1(arg_2_0.propPanel, false)

	setActive = var_1

	var_1(arg_2_0.selectPanel, true)

	local var_2_3 = arg_2_0.propPanel

	arg_2_0.confirmBtn = var_1.Find(var_2_3, "bg/qr_btn")

	local var_2_4 = arg_2_0._tf

	arg_2_0.tip = var_1.Find(var_2_4, "select_character/tip")

	local var_2_5 = arg_2_0.propPanel

	arg_2_0.skillPanel = var_1.Find(var_2_5, "bg/skill_panel")
	arg_2_0.skillTpl = arg_2_0:getTpl("bg/skill_panel/frame/skilltpl", arg_2_0.propPanel)

	local var_2_6 = arg_2_0.propPanel

	arg_2_0.skillContainer = var_1.Find(var_2_6, "bg/skill_panel/frame")

	local var_2_7 = arg_2_0._tf

	arg_2_0.namedPanel = var_1.Find(var_2_7, "named_panel")
	setActive = var_1

	var_1(arg_2_0.namedPanel, false)

	local var_2_8 = arg_2_0.namedPanel

	arg_2_0.info = var_1.Find(var_2_8, "info")

	local var_2_9 = arg_2_0.info

	arg_2_0.nickname = var_1.Find(var_2_9, "nickname")

	local var_2_10 = arg_2_0.propPanel

	arg_2_0.qChar = var_1.Find(var_2_10, "q_char")

	local var_2_11 = arg_2_0.namedPanel

	arg_2_0.chat = var_1.Find(var_2_11, "info/tip/chatbgtop0/Text")
	PropertyPanel = var_1

	local var_2_12 = var_1.New
	local var_2_13 = arg_2_0.propPanel

	arg_2_0.propertyPanel = var_2_12(var_3.Find(var_2_13, "bg/property_panel/frame"))

	local var_2_14 = arg_2_0._tf

	arg_2_0.paintTF = var_1.Find(var_2_14, "prop_panel/bg/paint")

	local var_2_15 = arg_2_0._tf

	arg_2_0.nameTF = var_1.Find(var_2_15, "prop_panel/bg/name")

	local var_2_16 = arg_2_0._tf

	arg_2_0.nameEnTF = var_1.Find(var_2_16, "prop_panel/bg/english_name_bg")

	local var_2_17 = arg_2_0._tf

	arg_2_0.titleShipinfoTF = var_1.Find(var_2_17, "lines/hori/shipinfo_text")

	local var_2_18 = arg_2_0._tf

	arg_2_0.titleShipchooseTF = var_1.Find(var_2_18, "lines/hori/shipchoose_text")
	setImageAlpha = var_1

	var_1(arg_2_0.titleShipinfoTF, 1)

	setImageAlpha = var_1

	var_1(arg_2_0.titleShipchooseTF, 0)

	findTF = var_1
	arg_2_0.randBtn = var_1(arg_2_0.info, "random_button")
	setActive = var_1

	local var_2_19 = arg_2_0.randBtn

	PLATFORM_CODE = var_4
	PLATFORM_CH = var_2_13

	var_1(var_2_19, var_4 == var_2_13)

	return
end

function var_0_1.onBackPressed(arg_3_0)
	LeanTween = var_1_10001

	local var_3_0 = var_1_10001.isTweening

	go = var_1_10003

	if var_3_0(var_1_10003(arg_3_0.propPanel)) then
		return
	end

	pg = var_1

	local var_3_1 = var_1.CriMgr.GetInstance()
	local var_3_2 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_3_2(var_3_1, var_1_10004)

	isActive = var_3_2

	if var_3_2(arg_3_0.namedPanel) then
		arg_3_0:closeNamedPanel()

		return
	end

	pg = var_1

	local var_3_3 = var_1.SdkMgr.GetInstance()

	var_1.OnAndoridBackPress(var_3_3)

	return
end

function var_0_1.switchPanel(arg_4_0)
	setActive = var_1_10001

	var_1_10001(arg_4_0.propPanel, true)

	local var_4_0 = arg_4_0.propPanel
	local var_4_1 = var_1.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10006

	local var_4_2 = var_4_1(var_4_0, var_4(var_1_10006))
	local var_4_3 = arg_4_0.selectPanel
	local var_4_4 = var_2.GetComponent

	typeof = var_1_10005
	CanvasGroup = var_1_10007

	local var_4_5 = var_4_4(var_4_3, var_1_10005(var_1_10007))

	LeanTween = var_4_0

	local var_4_6 = var_4_0.value

	go = var_5

	local var_4_7 = var_4_6(var_5(arg_4_0.propPanel), 0, 1, 0.5)
	local var_4_8 = var_3.setOnUpdate

	System = var_6

	local var_4_9 = var_4_8(var_4_7, var_6.Action_float(function(arg_5_0)
		var_4_2.alpha = arg_5_0
		var_4_5.alpha = 1 - arg_5_0

		return
	end))
	local var_4_10 = var_3.setOnComplete

	System = var_6

	var_4_10(var_4_9, var_6.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_4_0.selectPanel, false)

		return
	end))

	local var_4_11 = arg_4_0.skillPanel

	Vector3 = var_4_3
	var_4_11.localPosition = var_4_3.New(-1000, arg_4_0.skillPanel.localPosition.y, arg_4_0.skillPanel.localPosition.z)
	LeanTween = var_4_11

	var_4_11.moveX(arg_4_0.skillPanel, 339, 0.2)

	local var_4_12 = arg_4_0._tf
	local var_4_13 = var_3.Find(var_4_12, "lines/line")
	local var_4_14 = arg_4_0._tf
	local var_4_15 = var_4.Find(var_4_14, "lines/hori")

	LeanTween = var_4_12

	var_4_12.moveY(var_4_13, -328, 0.2)

	LeanTween = var_5

	var_5.moveX(var_4_15, -820, 0.2)

	for iter_4_0 = 1, 3 do
		local var_4_16 = arg_4_0.characters
		local var_4_17 = var_9.Find(var_4_16, "character_" .. iter_4_0)
		local var_4_18 = arg_4_0.propPanel
		local var_4_19 = var_10.Find(var_4_18, "bg/characters/character_" .. iter_4_0)

		setImageAlpha = var_4_16

		var_4_16(var_4_17, 1)

		LeanTween = var_4_16

		var_4_16.alpha(var_4_17, 0, 0.25)

		LeanTween = var_11

		local var_4_20 = var_11.move

		go = var_13

		var_4_20(var_13(var_4_17), var_4_19.position, 0.3)

		setImageAlpha = var_4_20

		var_4_20(arg_4_0.titleShipinfoTF, 0)

		setImageAlpha = var_4_20

		var_4_20(arg_4_0.titleShipchooseTF, 1)

		LeanTween = var_4_20

		var_4_20.alpha(arg_4_0.titleShipinfoTF, 1, 0.25)

		LeanTween = var_11

		var_11.alpha(arg_4_0.titleShipchooseTF, 0, 0.25)
	end

	return
end

function var_0_1.initCharacters(arg_7_0)
	arg_7_0.charInitPos = {}

	for iter_7_0 = 1, 3 do
		var_1_10007 = arg_7_0._tf

		local var_7_0 = var_5.Find(var_1_10007, "prop_panel/bg/characters/character_" .. iter_7_0)

		onToggle = var_1_10006

		var_1_10006(arg_7_0, var_7_0, function(arg_8_0)
			if arg_8_0 then
				local var_8_0 = arg_7_0

				var_2_10001.selectCharacterByIdx(var_8_0, var_7_0, var_0_6[iter_7_0])

				setActive = var_2_10001

				local var_8_1 = var_7_0

				var_2_10001(var_3.Find(var_8_1, "selected"), true)

				local var_8_2 = var_7_0

				var_2_10001 = var_2_10001.GetComponent
				typeof = var_4
				RectTransform = var_6
				var_2_10001 = var_2_10001(var_8_2, var_4(var_6))
				Vector2 = var_2_10002
				var_2_10001.sizeDelta = var_2_10002(196, 196)
			else
				setActive = var_2_10001

				local var_8_3 = var_7_0

				var_2_10001(var_3.Find(var_8_3, "selected"), false)

				local var_8_4 = var_7_0
				local var_8_5 = var_1.GetComponent

				typeof = var_4
				RectTransform = var_6

				local var_8_6 = var_8_5(var_8_4, var_4(var_6))

				Vector2 = var_2_10002
				var_8_6.sizeDelta = var_2_10002(140, 140)
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
		local var_7_2 = arg_7_0.characters
		local var_7_3 = var_6.Find(var_7_2, "character_" .. iter_7_1)

		onButton = var_1_10007

		var_1_10007(arg_7_0, var_7_3, function()
			local var_9_0 = arg_7_0

			var_0.switchPanel(var_9_0)

			triggerToggle = var_0

			local var_9_1 = arg_7_0._tf

			var_0(var_2.Find(var_9_1, "prop_panel/bg/characters/character_" .. iter_7_1), true)

			return
		end)

		Vector3 = var_1_10007
		var_7_3.localPosition = var_1_10007.New(var_7_3.localPosition.x, 912, var_7_3.localPosition.z)
		setImageAlpha = var_1_10007

		var_1_10007(var_7_3, 0)

		LeanTween = var_1_10007

		local var_7_4 = var_1_10007.alpha(var_7_3, 1, 0.3)

		var_1_10007.setDelay(var_7_4, var_7_1[iter_7_1])

		LeanTween = var_1_10007

		local var_7_5 = var_1_10007.moveY(var_7_3, 0, 0.2)

		var_1_10007.setDelay(var_7_5, var_7_1[iter_7_1])
	end

	return
end

function var_0_1.didEnter(arg_10_0)
	onButton = var_1_10001

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.confirmBtn

	local function var_10_2()
		local var_11_0 = arg_10_0

		var_0.showNamedPanel(var_11_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_0, var_10_1, var_10_2, var_1_10006)

	onButton = var_1_10001

	local var_10_3 = arg_10_0

	findTF = var_10_1

	local var_10_4 = var_10_1(arg_10_0.info, "random_button")

	local function var_10_5()
		require = var_2_10000

		local var_12_0 = var_2_10000("GameCfg.names")[1]

		math = var_2

		local var_12_1 = var_12_0[var_2.random(#var_0[1])]
		local var_12_2 = var_0[2]

		math = var_2_10003

		local var_12_3 = var_12_2[var_2_10003.random(#var_0[2])]
		local var_12_4 = var_0[3]

		math = var_4

		local var_12_5 = var_12_4[var_4.random(#var_0[3])]
		local var_12_6 = var_0[4]

		math = var_5

		local var_12_7 = var_12_6[var_5.random(#var_0[4])]

		setInputText = var_5

		var_5(arg_10_0.nickname, var_12_1 .. var_12_3 .. var_12_5 .. var_12_7)

		return
	end

	SFX_MAIN = var_6

	var_1_10001(var_10_3, var_10_4, var_10_5, var_6)

	onButton = var_1_10001

	local var_10_6 = arg_10_0

	findTF = var_10_4

	local var_10_7 = var_10_4(arg_10_0.info, "btn_container/enter_button")

	local function var_10_8()
		local var_13_1

		if not arg_10_0.contextData.configId then
			pg = var_13_1

			local var_13_0 = var_13_1.TipsMgr.GetInstance()

			var_13_1 = var_13_1.ShowTips
			i18n = var_2_10003

			var_13_1(var_13_0, var_2_10003("login_newPlayerScene_error_notChoiseShip"))

			return
		end

		getInputText = var_13_1

		if var_13_1(arg_10_0.nickname) == "" then
			pg = var_2_10001

			local var_13_2 = var_2_10001.TipsMgr.GetInstance()

			var_2_10001 = var_2_10001.ShowTips
			i18n = var_2_10004

			var_2_10001(var_13_2, var_2_10004("login_newPlayerScene_inputName"))

			return
		end

		nameValidityCheck = var_2_10001

		if not var_2_10001(var_0, 4, 14, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"login_newPlayerScene_invalideName"
		}) then
			return
		end

		local var_13_3 = arg_10_0.event
		local var_13_4 = var_1.emit

		NewPlayerMediator = var_4

		var_13_4(var_13_3, var_4.ON_CREATE, var_0, arg_10_0.contextData.configId)

		return
	end

	SFX_CONFIRM = var_6

	var_1_10001(var_10_6, var_10_7, var_10_8, var_6)

	onButton = var_1_10001

	local var_10_9 = arg_10_0

	findTF = var_10_7

	var_1_10001(var_10_9, var_10_7(arg_10_0.info, "btn_container/cancel_button"), function()
		local var_14_0 = arg_10_0

		var_0.closeNamedPanel(var_14_0)

		return
	end)
	arg_10_0:initCharacters()

	return
end

local var_0_12 = 0.3
local var_0_13 = -47

function var_0_1.selectCharacterByIdx(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.inProp = true
	arg_15_0.contextData.configId = arg_15_2

	local var_15_0 = arg_15_0.propertyPanel

	var_3.initProperty(var_15_0, arg_15_2)
	arg_15_0:initSkills()

	pg = var_3

	local var_15_1 = var_3.ship_data_statistics[arg_15_2]

	setPaintingPrefab = var_1_10004

	var_1_10004(arg_15_0.paintTF, var_0_7[arg_15_2], "chuanwu")

	setText = var_1_10004

	local var_15_2 = arg_15_0.nameTF

	var_1_10004(var_6.Find(var_15_2, "name_mask/Text"), var_15_1.name)

	setText = var_1_10004

	local var_15_3 = arg_15_0.nameTF

	var_1_10004(var_6.Find(var_15_3, "english_name"), var_15_1.english_name)

	setText = var_1_10004

	local var_15_4 = arg_15_0.nameEnTF

	string = var_7

	var_1_10004(var_15_4, var_7.upper(var_15_1.english_name))

	Ship = var_1_10004

	local var_15_5 = var_1_10004.New({
		configId = arg_15_0.contextData.configId
	})

	if var_4.getPrefab(var_15_5) == arg_15_0.shipPrefab then
		return
	end

	arg_15_0:recycleSpineChar()

	pg = var_6

	local var_15_6 = var_6.UIMgr.GetInstance()

	var_6.LoadingOn(var_15_6)

	PoolMgr = var_6

	local var_15_7 = var_6.GetInstance()

	var_6.GetSpineChar(var_15_7, var_5, true, function(arg_16_0)
		pg = var_2_10001

		local var_16_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_16_0)

		arg_15_0.shipPrefab = var_0
		arg_15_0.shipModel = arg_16_0

		local var_16_1 = arg_16_0:GetComponent("SpineAnimUI")

		var_1.SetAction(var_16_1, "stand", 0)

		tf = var_1

		local var_16_2 = var_1(arg_16_0)

		Vector3 = var_2
		var_16_2.localScale = var_2(0.5, 0.5, 1)
		tf = var_16_2

		local var_16_3 = var_16_2(arg_16_0)

		Vector3 = var_2
		var_16_3.localPosition = var_2(15, -95, 0)
		pg = var_16_3

		local var_16_4 = var_16_3.ViewUtils.SetLayer

		tf = var_3

		local var_16_5 = var_3(arg_16_0)

		Layer = var_4

		var_16_4(var_16_5, var_4.UI)

		removeAllChildren = var_16_4

		var_16_4(arg_15_0.qChar)

		SetParent = var_16_4

		var_16_4(arg_16_0, arg_15_0.qChar, false)

		return
	end)

	return
end

function var_0_1.initSkills(arg_17_0)
	pg = var_1_10001

	local var_17_0 = var_1_10001.ship_data_template[arg_17_0.contextData.configId]

	removeAllChildren = var_2

	var_2(arg_17_0.skillContainer)

	ipairs = var_2

	for iter_17_0, iter_17_1 in var_2(var_17_0.buff_list_display) do
		getSkillConfig = var_1_10007
		var_1_10007 = var_1_10007(iter_17_1)
		table = var_1_10008
		var_1_10008 = var_1_10008.contains(var_17_0.buff_list, iter_17_1)
		cloneTplTo = var_9

		local var_17_1 = var_9(arg_17_0.skillTpl, arg_17_0.skillContainer)

		setActive = var_10

		var_10(var_17_1:Find("mask"), not var_1_10008)

		onButton = var_10

		local var_17_2 = arg_17_0
		local var_17_3 = var_17_1

		local function var_17_4()
			local var_18_0 = arg_17_0
			local var_18_1 = var_0.emit

			NewPlayerMediator = var_2_10003

			var_18_1(var_18_0, var_2_10003.ON_SKILLINFO, var_1_10007.id)

			return
		end

		SFX_PANEL = var_15

		var_10(var_17_2, var_17_3, var_17_4, var_15)

		LoadImageSpriteAsync = var_10

		local var_17_5 = "skillicon/" .. var_1_10007.icon

		findTF = var_13

		var_10(var_17_5, var_13(var_17_1, "icon"))
	end

	return
end

function var_0_1.showNamedPanel(arg_19_0)
	local var_19_0 = arg_19_0.qChar

	var_1.SetParent(var_19_0, arg_19_0.info)

	pg = var_1

	local var_19_1 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_19_1, arg_19_0.namedPanel)

	setActive = var_1

	var_1(arg_19_0.namedPanel, true)

	setInputText = var_1

	var_1(arg_19_0.nickname, "")

	setText = var_1

	var_1(arg_19_0.chat, var_0_8[arg_19_0.contextData.configId])

	return
end

function var_0_1.closeNamedPanel(arg_20_0)
	pg = var_1_10001

	local var_20_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_20_0, arg_20_0.namedPanel, arg_20_0._tf)

	setActive = var_1

	var_1(arg_20_0.namedPanel, false)

	local var_20_1 = arg_20_0.qChar

	var_1.SetParent(var_20_1, arg_20_0.propPanel)

	return
end

function var_0_1.recycleSpineChar(arg_21_0)
	if arg_21_0.shipPrefab and arg_21_0.shipModel then
		PoolMgr = var_1

		local var_21_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_21_0, arg_21_0.shipPrefab, arg_21_0.shipModel)

		arg_21_0.shipPrefab = nil
		arg_21_0.shipModel = nil
	end

	return
end

function var_0_1.willExit(arg_22_0)
	if arg_22_0.eventTriggers then
		pairs = var_1

		for iter_22_0, iter_22_1 in var_1(arg_22_0.eventTriggers) do
			ClearEventTrigger = var_1_10006

			var_1_10006(iter_22_0)
		end

		arg_22_0.eventTriggers = nil
	end

	arg_22_0:closeNamedPanel()

	return
end

return var_0_1
