class = var_0_10000

local var_0_0 = "NewEducateMainScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.newEducate.base.NewEducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducateMainUI"
end

function var_0_1.PlayBGM(arg_2_0)
	local var_2_0 = arg_2_0.contextData.char

	if var_1.GetBgm(var_2_0) then
		pg = var_1_10002

		local var_2_1 = var_1_10002.BgmMgr.GetInstance()

		var_2.Push(var_2_1, arg_2_0.__cname, var_1)
	end

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.rootTF = var_1.Find(var_3_0, "root")

	local var_3_1 = arg_3_0.rootTF
	local var_3_2 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_3_0.mainAnim = var_3_2(var_3_1, var_4(var_1_10006))

	local var_3_3 = arg_3_0.rootTF

	arg_3_0.bgTF = var_1.Find(var_3_3, "bg")

	local var_3_4 = arg_3_0.rootTF

	arg_3_0.paintTF = var_1.Find(var_3_4, "painting")

	local var_3_5 = arg_3_0.rootTF

	arg_3_0.dialogueTF = var_1.Find(var_3_5, "main/dialogue")

	local var_3_6 = arg_3_0.dialogueTF

	arg_3_0.dialogueContent = var_1.Find(var_3_6, "content")
	setActive = var_1

	var_1(arg_3_0.dialogueTF, false)

	setActive = var_1

	local var_3_7 = arg_3_0.dialogueTF

	var_1(var_3.Find(var_3_7, "arrows"), false)

	local var_3_8 = arg_3_0.rootTF

	arg_3_0.topicBtn = var_1.Find(var_3_8, "main/topic")
	setActive = var_1

	var_1(arg_3_0.topicBtn, false)

	local var_3_9 = arg_3_0.rootTF

	arg_3_0.mindBtn = var_1.Find(var_3_9, "main/mind")
	setActive = var_1

	var_1(arg_3_0.mindBtn, false)

	local var_3_10 = arg_3_0.rootTF

	arg_3_0.adaptTF = var_1.Find(var_3_10, "adapt")

	local var_3_11 = arg_3_0.adaptTF

	arg_3_0.favorTF = var_1.Find(var_3_11, "favor")

	local var_3_12 = arg_3_0.adaptTF

	arg_3_0.normalBtns = var_1.Find(var_3_12, "normal")

	local var_3_13 = arg_3_0.normalBtns

	arg_3_0.scheduleBtn = var_1.Find(var_3_13, "schedule")

	local var_3_14 = arg_3_0.normalBtns

	arg_3_0.mapBtn = var_1.Find(var_3_14, "map")

	local var_3_15 = arg_3_0.adaptTF

	arg_3_0.endingBtn = var_1.Find(var_3_15, "ending")

	local var_3_16 = arg_3_0.adaptTF

	arg_3_0.resetInEndlessBtn = var_1.Find(var_3_16, "reset_endless")

	local var_3_17 = arg_3_0.adaptTF

	arg_3_0.resetBtns = var_1.Find(var_3_17, "reset")

	local var_3_18 = arg_3_0.resetBtns

	arg_3_0.resetBtn = var_1.Find(var_3_18, "reset")

	local var_3_19 = arg_3_0.resetBtns

	arg_3_0.endlessBtn = var_1.Find(var_3_19, "endless")
	NewEducateTopPanel = var_1

	local var_3_20 = var_1.New
	local var_3_21 = arg_3_0.adaptTF
	local var_3_22 = arg_3_0.event

	setmetatable = var_3_7
	arg_3_0.topPanel = var_3_20(var_3_21, var_3_22, var_3_7({
		hideBlurBg = true
	}, {
		__index = arg_3_0.contextData
	}))

	local var_3_23 = arg_3_0.topPanel

	var_1.RegisterView(var_3_23, arg_3_0)

	NewEducateInfoPanel = var_1
	arg_3_0.infoPanel = var_1.New(arg_3_0.adaptTF, arg_3_0.event, arg_3_0.contextData)

	local var_3_24 = arg_3_0.infoPanel

	var_1.RegisterView(var_3_24, arg_3_0)

	NewEducateRoundTipPanel = var_1
	arg_3_0.roundTipPanel = var_1.New(arg_3_0.adaptTF, arg_3_0.event, arg_3_0.contextData)

	local var_3_25 = arg_3_0.roundTipPanel

	var_1.RegisterView(var_3_25, arg_3_0)

	NewEducateAssessPanel = var_1
	arg_3_0.assessPanel = var_1.New(arg_3_0.adaptTF, arg_3_0.event, arg_3_0.contextData)

	local var_3_26 = arg_3_0.assessPanel

	var_1.RegisterView(var_3_26, arg_3_0)

	NewEducateFavorPanel = var_1
	arg_3_0.favorPanel = var_1.New(arg_3_0.adaptTF, arg_3_0.event, arg_3_0.contextData)

	local var_3_27 = arg_3_0.favorPanel

	var_1.RegisterView(var_3_27, arg_3_0)

	NewEducatePersonalityTipPanel = var_1
	arg_3_0.personalityTipPanel = var_1.New(arg_3_0.adaptTF, arg_3_0.event, arg_3_0.contextData)

	local var_3_28 = arg_3_0.personalityTipPanel

	var_1.RegisterView(var_3_28, arg_3_0)

	NewEducateNodePanel = var_1

	local var_3_29 = var_1.New
	local var_3_30 = arg_3_0.adaptTF
	local var_3_31 = arg_3_0.event

	setmetatable = var_5
	arg_3_0.nodePanel = var_3_29(var_3_30, var_3_31, var_5({
		view = arg_3_0
	}, {
		__index = arg_3_0.contextData
	}))

	local var_3_32 = arg_3_0.nodePanel

	var_1.RegisterView(var_3_32, arg_3_0)

	return
end

function var_0_1.didEnter(arg_4_0)
	local var_4_0 = "neweducateicon/"
	local var_4_1 = arg_4_0.contextData.char
	local var_4_2 = var_4_0 .. var_2.getConfig(var_4_1, "child2_data_personality_icon")[2]

	LoadImageSpriteAsync = var_2

	var_2(var_4_2, arg_4_0.mindBtn, true)

	onButton = var_2

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.paintTF
	local var_4_5 = var_5.Find(var_4_4, "fitter")

	local function var_4_6()
		local var_5_0 = arg_4_0

		var_0.ShowDialogue(var_5_0)

		return
	end

	SFX_PANEL = var_4_4

	var_2(var_4_3, var_4_5, var_4_6, var_4_4)

	onButton = var_2

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.mindBtn

	local function var_4_9()
		local var_6_0 = arg_4_0.contextData.char
		local var_6_1 = var_0.GetFSM(var_6_0)
		local var_6_3

		if var_0.CheckPriorityStystem(var_6_1) then
			pg = var_6_3

			local var_6_2 = var_6_3.TipsMgr.GetInstance()

			var_6_3 = var_6_3.ShowTips
			i18n = var_2_10003

			var_6_3(var_6_2, var_2_10003("child2_priority_tip"))

			return
		end

		setActive = var_6_3

		var_6_3(arg_4_0.mindBtn, false)

		local var_6_4 = arg_4_0
		local var_6_5 = var_0.emit

		NewEducateMainMediator = var_3

		var_6_5(var_6_4, var_3.ON_SELECT_MIND, function()
			local var_7_0 = arg_4_0

			var_0.SeriesCheck(var_7_0)

			return
		end)

		return
	end

	SFX_PANEL = var_4_4

	var_2(var_4_7, var_4_8, var_4_9, var_4_4)

	onButton = var_2

	local var_4_10 = arg_4_0
	local var_4_11 = arg_4_0.favorTF

	local function var_4_12()
		local var_8_0 = arg_4_0.contextData.char
		local var_8_1 = var_0.GetFSM(var_8_0)

		if var_0.CheckPriorityStystem(var_8_1) then
			pg = var_0

			local var_8_2 = var_0.TipsMgr.GetInstance()
			local var_8_3 = var_0.ShowTips

			i18n = var_2_10003

			var_8_3(var_8_2, var_2_10003("child2_priority_tip"))

			return
		end

		local var_8_4 = arg_4_0.favorPanel

		var_0.ExecuteAction(var_8_4, "Show")

		return
	end

	SFX_PANEL = var_4_4

	var_2(var_4_10, var_4_11, var_4_12, var_4_4)

	onButton = var_2

	local var_4_13 = arg_4_0
	local var_4_14 = arg_4_0.scheduleBtn

	local function var_4_15()
		local var_9_0 = arg_4_0.contextData.char
		local var_9_1 = var_0.GetFSM(var_9_0)

		if var_0.CheckPriorityStystem(var_9_1) then
			pg = var_0

			local var_9_2 = var_0.TipsMgr.GetInstance()
			local var_9_3 = var_0.ShowTips

			i18n = var_2_10003

			var_9_3(var_9_2, var_2_10003("child2_priority_tip"))

			return
		end

		local var_9_4 = arg_4_0
		local var_9_5 = var_0.emit
		local var_9_6 = var_0_1.GO_SCENE

		SCENE = var_2_10004

		var_9_5(var_9_4, var_9_6, var_2_10004.NEW_EDUCATE_SCHEDULE, {
			scheduleDataTable = arg_4_0.contextData.scheduleDataTable
		})

		return
	end

	SFX_PANEL = var_4_4

	var_2(var_4_13, var_4_14, var_4_15, var_4_4)

	onButton = var_2

	local var_4_16 = arg_4_0
	local var_4_17 = arg_4_0.mapBtn

	local function var_4_18()
		local var_10_0 = arg_4_0.contextData.char
		local var_10_1 = var_0.GetFSM(var_10_0)

		if var_0.CheckPriorityStystem(var_10_1) then
			pg = var_0

			local var_10_2 = var_0.TipsMgr.GetInstance()
			local var_10_3 = var_0.ShowTips

			i18n = var_2_10003

			var_10_3(var_10_2, var_2_10003("child2_priority_tip"))

			return
		end

		local var_10_4 = arg_4_0.contextData.char

		if not var_0.IsUnlock(var_10_4, "out") then
			return
		end

		local var_10_5 = arg_4_0
		local var_10_6 = var_0.emit
		local var_10_7 = var_0_1.GO_SCENE

		SCENE = var_2_10004

		var_10_6(var_10_5, var_10_7, var_2_10004.NEW_EDUCATE_MAP)

		return
	end

	SFX_PANEL = var_4_4

	var_2(var_4_16, var_4_17, var_4_18, var_4_4)

	onButton = var_2

	local var_4_19 = arg_4_0
	local var_4_20 = arg_4_0.endingBtn

	local function var_4_21()
		local var_11_0 = arg_4_0

		var_0.OnEndingClick(var_11_0)

		return
	end

	SFX_PANEL = var_4_4

	var_2(var_4_19, var_4_20, var_4_21, var_4_4)

	onButton = var_2

	local var_4_22 = arg_4_0
	local var_4_23 = arg_4_0.resetBtn

	local function var_4_24()
		local var_12_0 = arg_4_0

		var_0.OnClickResetBtn(var_12_0)

		return
	end

	SFX_PANEL = var_4_4

	var_2(var_4_22, var_4_23, var_4_24, var_4_4)

	onButton = var_2

	local var_4_25 = arg_4_0
	local var_4_26 = arg_4_0.resetInEndlessBtn

	local function var_4_27()
		local var_13_0 = arg_4_0

		var_0.OnClickResetInEndlessBtn(var_13_0)

		return
	end

	SFX_PANEL = var_4_4

	var_2(var_4_25, var_4_26, var_4_27, var_4_4)

	onButton = var_2

	local var_4_28 = arg_4_0
	local var_4_29 = arg_4_0.endlessBtn

	local function var_4_30()
		local var_14_0 = arg_4_0

		var_0.OnClickEndlessBtn(var_14_0)

		return
	end

	SFX_PANEL = var_4_4

	var_2(var_4_28, var_4_29, var_4_30, var_4_4)

	onButton = var_2

	local var_4_31 = arg_4_0
	local var_4_32 = arg_4_0.topicBtn

	local function var_4_33()
		setActive = var_2_10000

		var_2_10000(arg_4_0.topicBtn, false)

		local var_15_0 = arg_4_0.contextData.char
		local var_15_1 = var_0.GetFSM(var_15_0)
		local var_15_2 = var_0.GetState

		NewEducateFSM = var_3

		local var_15_3 = var_15_2(var_15_1, var_3.SYSTEM.TOPIC)

		if var_0.GetTopics(var_15_3)[1] then
			local var_15_4 = arg_4_0
			local var_15_5 = var_1.emit

			NewEducateMainMediator = var_2_10004

			var_15_5(var_15_4, var_2_10004.ON_SELECT_TOPIC, var_0[1])
		end

		return
	end

	SFX_PANEL = var_4_4

	var_2(var_4_31, var_4_32, var_4_33, var_4_4)
	arg_4_0:UpdatePaintingUI()
	arg_4_0:UpdateFavorInfo()
	arg_4_0:UpdateUnlockUI()

	local var_4_34 = arg_4_0.contextData
	local var_4_35

	if not arg_4_0.contextData.scheduleDataTable then
		var_4_35 = {}
	end

	var_4_34.scheduleDataTable = var_4_35
	seriesAsync = var_4_34

	var_4_34({
		function(arg_16_0)
			local var_16_0 = arg_4_0

			var_1.CheckNewChar(var_16_0, arg_16_0)

			return
		end
	}, function()
		if arg_4_0.contextData.scheduleDataTable.OnScheduleDone then
			local var_17_0 = arg_4_0.contextData.scheduleDataTable.OnScheduleDone

			arg_4_0.contextData.scheduleDataTable.OnScheduleDone = nil

			if #var_17_0.drops == 0 then
				existCall = var_1

				var_1(var_17_0.callback)
			else
				local var_17_1 = arg_4_0
				local var_17_2 = var_1.emit

				NewEducateBaseUI = var_2_10004

				var_17_2(var_17_1, var_2_10004.ON_DROP, {
					items = var_17_0.drops,
					removeFunc = var_17_0.callback
				})
			end
		else
			local var_17_3 = arg_4_0

			var_0.SeriesCheck(var_17_3)
		end

		return
	end)

	arg_4_0.newRoundDrops = {}

	return
end

function var_0_1._loadSubViews(arg_18_0)
	local var_18_0 = arg_18_0.topPanel

	var_1.Load(var_18_0)

	local var_18_1 = arg_18_0.infoPanel

	var_1.Load(var_18_1)

	return
end

function var_0_1.SeriesCheck(arg_19_0)
	local var_19_0 = {}

	table = var_1_10002

	var_1_10002.insert(var_19_0, function(arg_20_0)
		local var_20_0 = arg_19_0

		var_1.CheckFavorUpgrade(var_20_0, arg_20_0)

		return
	end)

	seriesAsync = var_2

	var_2(var_19_0, function()
		local var_21_0 = arg_19_0

		var_0.CheckFSM(var_21_0)

		return
	end)

	return
end

function var_0_1.UpdatePaintingUI(arg_22_0)
	local var_22_0 = arg_22_0.contextData.char
	local var_22_1 = var_1.GetRoundData(var_22_0)
	local var_22_2 = var_1.getConfig(var_22_1, "main_background")

	setImageSprite = var_1_10002

	local var_22_3 = arg_22_0.bgTF

	LoadSprite = var_1_10005

	var_1_10002(var_22_3, var_1_10005("bg/" .. var_22_2), false)

	local var_22_4 = arg_22_0.contextData.char

	arg_22_0.paintingName = var_2.GetPaintingName(var_22_4)
	setPaintingPrefab = var_2

	var_2(arg_22_0.paintTF, arg_22_0.paintingName, "yangcheng")

	local var_22_5 = arg_22_0.contextData.char

	arg_22_0.wordList, arg_22_0.faceList = var_2.GetMainDialogueInfo(var_22_5)

	return
end

function var_0_1.HideDialogueUI(arg_23_0)
	local var_23_0 = arg_23_0.infoPanel
	local var_23_2

	if var_1.isShowing(var_23_0) then
		local var_23_1 = arg_23_0.infoPanel

		var_23_2 = var_1.IsShowPanel(var_23_1)
	end

	arg_23_0.isShowInfoPanel = var_23_2

	local var_23_3 = arg_23_0.infoPanel

	var_1.ExecuteAction(var_23_3, "HidePanel")

	local var_23_4 = arg_23_0.topPanel

	var_1.ExecuteAction(var_23_4, "PlayHide")

	local var_23_5 = arg_23_0.mainAnim

	var_1.Play(var_23_5, "anim_educate_mainui_icon_hide")

	return
end

function var_0_1.ShowDialogueUI(arg_24_0)
	if arg_24_0.isShowInfoPanel then
		local var_24_0 = arg_24_0.infoPanel

		var_1.ExecuteAction(var_24_0, "ShowPanel")
	end

	local var_24_1 = arg_24_0.topPanel

	var_1.ExecuteAction(var_24_1, "PlayShow")

	local var_24_2 = arg_24_0.mainAnim

	var_1.Play(var_24_2, "anim_educate_mainui_icon_show")

	return
end

function var_0_1.UpdatePaintingFace(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.paintTF

	if var_2.Find(var_25_0, "fitter").childCount == 0 then
		return
	end

	local var_25_1 = arg_25_0.paintTF
	local var_25_2 = var_2.Find(var_25_1, "fitter")
	local var_25_3 = var_2.GetChild(var_25_2, 0)
	local var_25_4 = var_2.Find(var_25_3, "face")
	local var_25_5

	if arg_25_1 == 0 then
		if var_25_4 then
			setActive = var_1_10003

			var_1_10003(var_25_4, false)
		end

		var_25_5 = arg_25_0

		arg_25_0.ShowDialogueUI(var_25_5)

		return
	end

	pg = var_1_10003

	local var_25_6 = var_1_10003.child2_node[arg_25_1].type

	NewEducateNodePanel = var_25_5

	if var_25_6 == var_25_5.NODE_TYPE.MAIN_TEXT then
		local var_25_7 = var_3.text

		pg = var_5

		if var_5.child2_word[var_25_7].main_character_face == 0 then
			if var_25_4 then
				setActive = var_1_10006

				var_1_10006(var_25_4, false)
			end
		else
			GetSpriteFromAtlas = var_1_10006

			local var_25_8 = var_1_10006("paintingface/" .. arg_25_0.paintingName, var_5)

			if var_25_4 and var_25_8 then
				setImageSprite = var_1_10007

				var_1_10007(var_25_4, var_25_8)

				setActive = var_1_10007

				var_1_10007(var_25_4, true)
			end
		end
	end

	return
end

function var_0_1.ShowDialogue(arg_26_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_26_0.dialogueTF) then
		return
	end

	math = var_1

	local var_26_0 = var_1.random(#arg_26_0.wordList)

	pg = var_1_10002

	local var_26_1 = var_1_10002.child2_word[arg_26_0.wordList[var_26_0]].word

	string = var_3

	local var_26_2 = var_3.gsub
	local var_26_3 = var_26_1
	local var_26_4 = "$1"
	local var_26_5 = arg_26_0.contextData.char
	local var_26_6 = var_26_2(var_26_3, var_26_4, var_7.GetCallName(var_26_5))

	setText = var_3

	var_3(arg_26_0.dialogueContent, var_26_6)

	GetSpriteFromAtlas = var_3

	local var_26_7 = var_3("paintingface/" .. arg_26_0.paintingName, arg_26_0.faceList[var_26_0])
	local var_26_8 = arg_26_0.paintTF
	local var_26_9 = var_4.Find(var_26_8, "fitter")
	local var_26_10 = var_4.GetChild(var_26_9, 0)

	if var_4.Find(var_26_10, "face") and var_26_7 then
		setImageSprite = var_5

		var_5(var_4, var_26_7)

		setActive = var_5

		var_5(var_4, true)
	end

	local var_26_11 = arg_26_0.dialogueTF

	Vector3 = var_26_10
	var_26_11.localScale = var_26_10.zero
	setActive = var_26_11

	var_26_11(arg_26_0.dialogueTF, true)

	LeanTween = var_26_11

	local var_26_12 = var_26_11.scale
	local var_26_13 = arg_26_0.dialogueTF

	Vector3 = var_8

	local var_26_14 = var_26_12(var_26_13, var_8.one, 0.3)
	local var_26_15 = var_5.setEase

	LeanTweenType = var_8

	local var_26_16 = var_26_15(var_26_14, var_8.easeOutBack)
	local var_26_17 = var_5.setOnComplete

	System = var_8

	var_26_17(var_26_16, var_8.Action(function()
		LeanTween = var_2_10000

		local var_27_0 = var_2_10000.scale
		local var_27_1 = arg_26_0.dialogueTF

		Vector3 = var_2_10003

		local var_27_2 = var_27_0(var_27_1, var_2_10003.zero, 0.3)
		local var_27_3 = var_0.setEase

		LeanTweenType = var_3

		local var_27_4 = var_27_3(var_27_2, var_3.easeInBack)
		local var_27_5 = var_0.setDelay(var_27_4, 3)
		local var_27_6 = var_0.setOnComplete

		System = var_3

		var_27_6(var_27_5, var_3.Action(function()
			setActive = var_3_10000

			var_3_10000(arg_26_0.dialogueTF, false)

			if var_0 then
				setActive = var_0

				var_0(var_0, false)
			end

			return
		end))

		return
	end))

	return
end

function var_0_1.UpdataTopicAndMind(arg_29_0)
	local var_29_0 = arg_29_0.contextData.char
	local var_29_1 = var_1.GetFSM(var_29_0)
	local var_29_2 = arg_29_0.contextData.char
	local var_29_3 = var_2.GetRoundData(var_29_2)
	local var_29_4 = var_29_1
	local var_29_5 = var_29_1.GetState

	NewEducateFSM = var_1_10006

	local var_29_6 = var_29_5(var_29_4, var_1_10006.SYSTEM.TOPIC)

	if var_29_3:IsTemp() or var_29_6 and var_29_6:IsFinish() then
		setActive = var_4

		var_4(arg_29_0.topicBtn, false)
	else
		setActive = var_4

		var_4(arg_29_0.topicBtn, true)
	end

	if var_29_3:getConfig("main_event_chat_node_id") ~= "" then
		var_29_4 = #var_4

		if 0 < var_29_4 and not var_29_3:IsTemp() then
			local var_29_7 = var_29_1

			var_29_4 = var_29_1.GetState
			NewEducateFSM = var_1_10008
			var_29_4 = var_29_4(var_29_7, var_1_10008.SYSTEM.MIND)
			setActive = var_6

			var_6(arg_29_0.mindBtn, not var_29_4)

			goto label_29_0
		end
	end

	setActive = var_29_4

	var_29_4(arg_29_0.mindBtn, false)

	::label_29_0::

	return
end

function var_0_1.CheckNewChar(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.contextData.char

	if var_2.GetCallName(var_30_0) == "" then
		setActive = var_2

		var_2(arg_30_0._tf, false)

		local var_30_1 = arg_30_0.contextData.char
		local var_30_2 = var_2.getConfig(var_30_1, "special_memory")
		local var_30_3 = {}

		table = var_30_1

		var_30_1.insert(var_30_3, function(arg_31_0)
			NewEducateHelper = var_2_10001

			var_2_10001.PlaySpecialStoryList(var_30_2.pre_name, arg_31_0, true)

			return
		end)

		table = var_4

		var_4.insert(var_30_3, function(arg_32_0)
			local var_32_0 = arg_30_0
			local var_32_1 = var_1.emit
			local var_32_2 = var_0_1.GO_SUBLAYER

			Context = var_2_10005

			local var_32_3 = var_2_10005.New
			local var_32_4 = {}

			NewEducateSetCallediator = var_2_10008
			var_32_4.mediator = var_2_10008
			NewEducateSetCallLayer = var_2_10008
			var_32_4.viewComponent = var_2_10008
			var_32_4.data = {
				callback = arg_32_0
			}

			var_32_1(var_32_0, var_32_2, var_32_3(var_32_4))

			return
		end)

		table = var_4

		var_4.insert(var_30_3, function(arg_33_0)
			NewEducateHelper = var_2_10001

			var_2_10001.PlaySpecialStoryList(var_30_2.after_name, arg_33_0, true)

			return
		end)

		arg_30_0.lockBackPressed = true
		seriesAsync = var_4

		var_4(var_30_3, function()
			setActive = var_2_10000

			var_2_10000(arg_30_0._tf, true)

			local var_34_0 = arg_30_0

			var_0._loadSubViews(var_34_0)
			arg_30_1()

			arg_30_0.lockBackPressed = false

			return
		end)
	else
		arg_30_0:_loadSubViews()
		arg_30_1()
	end

	return
end

function var_0_1.UpdateFavorInfo(arg_35_0)
	setText = var_1_10001

	local var_35_0 = arg_35_0.favorTF
	local var_35_1 = var_3.Find(var_35_0, "Text")
	local var_35_2 = "Lv"
	local var_35_3 = arg_35_0.contextData.char

	var_1_10001(var_35_1, var_35_2 .. var_5.GetFavorInfo(var_35_3).lv)

	return
end

function var_0_1.CheckFavorUpgrade(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.contextData.char
	local var_36_2

	if var_2.CheckFavor(var_36_0) then
		local var_36_1 = arg_36_0

		var_36_2 = arg_36_0.emit
		NewEducateMainMediator = var_1_10005

		var_36_2(var_36_1, var_1_10005.ON_UPGRADE_FAVOR, arg_36_1)
	else
		existCall = var_36_2

		var_36_2(arg_36_1)
	end

	return
end

function var_0_1.CheckFSM(arg_37_0)
	local var_37_0 = arg_37_0.contextData.char
	local var_37_1 = var_1.GetFSM(var_37_0)

	if var_1.CheckPriorityStystem(var_37_1) then
		arg_37_0:emit(var_0_1.ON_PRIORITY_STATE)
	else
		arg_37_0:CheckGameFSM()
	end

	return
end

function var_0_1.CheckGameFSM(arg_38_0)
	local var_38_0 = arg_38_0.contextData.char
	local var_38_1 = var_1.GetFSM(var_38_0)
	local var_38_2 = var_1.CheckStystem(var_38_1)

	warning = var_38_0

	var_38_0("CheckGameFSM", var_1:GetSystemNo() .. "->" .. var_38_2)
	arg_38_0:UpdateStateUI(var_38_2)

	switch = var_3

	local var_38_3 = var_38_2
	local var_38_4 = {}

	NewEducateFSM = var_7
	var_38_4[var_7.SYSTEM.EVENT] = function()
		local var_39_0 = arg_38_0

		var_0.EventHandler(var_39_0)

		return
	end
	NewEducateFSM = var_7
	var_38_4[var_7.SYSTEM.TALENT] = function()
		local var_40_0 = arg_38_0

		var_0.TalentHandler(var_40_0)

		return
	end
	NewEducateFSM = var_7
	var_38_4[var_7.SYSTEM.TOPIC] = function()
		local var_41_0 = arg_38_0

		var_0.TopicHandler(var_41_0)

		return
	end
	NewEducateFSM = var_7
	var_38_4[var_7.SYSTEM.MAP] = function()
		local var_42_0 = arg_38_0

		var_0.MapHandler(var_42_0)

		return
	end
	NewEducateFSM = var_7
	var_38_4[var_7.SYSTEM.PLAN] = function()
		local var_43_0 = arg_38_0

		var_0.PlanHandler(var_43_0)

		return
	end
	NewEducateFSM = var_7
	var_38_4[var_7.SYSTEM.ASSESS] = function()
		local var_44_0 = arg_38_0

		var_0.AssessHandler(var_44_0)

		return
	end
	NewEducateFSM = var_7
	var_38_4[var_7.SYSTEM.PHASE] = function()
		local var_45_0 = arg_38_0

		var_0.StageHandler(var_45_0)

		return
	end
	NewEducateFSM = var_7
	var_38_4[var_7.SYSTEM.ENDING] = function()
		local var_46_0 = arg_38_0

		var_0.EndingHandler(var_46_0)

		return
	end
	NewEducateFSM = var_7
	var_38_4[var_7.SYSTEM.MIND] = function()
		local var_47_0 = arg_38_0

		var_0.MindHandler(var_47_0)

		return
	end
	NewEducateFSM = var_7
	var_38_4[var_7.SYSTEM.CHOOSE] = function()
		local var_48_0 = arg_38_0

		var_0.ChooseHandler(var_48_0)

		return
	end
	NewEducateFSM = var_7
	var_38_4[var_7.SYSTEM.FAIL] = function()
		local var_49_0 = arg_38_0

		var_0.FailHandler(var_49_0)

		return
	end

	var_3(var_38_3, var_38_4, function()
		assert = var_2_10000

		var_2_10000(false, "不合法FSM状态")

		return
	end)

	return
end

function var_0_1.OnReset(arg_51_0)
	arg_51_0:HideDialogueUI()

	local var_51_0 = arg_51_0.infoPanel

	var_1.ExecuteAction(var_51_0, "Hide")

	local var_51_1 = arg_51_0.contextData

	getProxy = var_1_10002
	NewEducateProxy = var_4

	local var_51_2 = var_1_10002(var_4)

	var_51_1.char = var_2.GetCurChar(var_51_2)
	setActive = var_51_1

	var_51_1(arg_51_0.topicBtn, false)

	setActive = var_51_1

	var_51_1(arg_51_0.mindBtn, false)

	local var_51_3 = arg_51_0.infoPanel

	var_1.ExecuteAction(var_51_3, "Flush")

	local var_51_4 = arg_51_0.topPanel
	local var_51_5 = var_1.ExecuteAction
	local var_51_6 = "Flush"

	NewEducateFSM = var_1_10005

	var_51_5(var_51_4, var_51_6, var_1_10005.SYSTEM.INIT)
	arg_51_0:UpdatePaintingUI()
	arg_51_0:UpdateUnlockUI()

	seriesAsync = var_1

	var_1({
		function(arg_52_0)
			local var_52_0 = arg_51_0

			var_1.CheckNewChar(var_52_0, arg_52_0)

			return
		end
	}, function()
		local var_53_0 = arg_51_0

		var_0.ShowDialogueUI(var_53_0)

		local var_53_1 = arg_51_0.infoPanel

		var_0.ExecuteAction(var_53_1, "Show")

		local var_53_2 = arg_51_0

		var_0.SeriesCheck(var_53_2)

		return
	end)

	return
end

function var_0_1.UpdateStateUI(arg_54_0, arg_54_1)
	arg_54_0:UpdateBtns(arg_54_1)

	local var_54_0 = arg_54_0.topPanel

	var_2.ExecuteAction(var_54_0, "FlushProgress", arg_54_1)

	return
end

function var_0_1.UpdateBtns(arg_55_0, arg_55_1)
	setActive = var_1_10002

	var_1_10002(arg_55_0.endingBtn, false)

	setActive = var_1_10002

	var_1_10002(arg_55_0.resetBtns, false)

	setActive = var_1_10002

	var_1_10002(arg_55_0.endlessBtn, false)

	local var_55_0 = arg_55_0.contextData.char
	local var_55_1 = var_2.GetRoundData(var_55_0)

	setActive = var_1_10003

	var_1_10003(arg_55_0.resetInEndlessBtn, var_55_1:IsEndless())

	setActive = var_1_10003

	local var_55_2 = arg_55_0.normalBtns

	NewEducateFSM = var_6

	var_1_10003(var_55_2, arg_55_1 ~= var_6.SYSTEM.ENDING and not var_55_1:IsEndlessFail())

	local var_55_3 = arg_55_0.contextData.char
	local var_55_4 = var_3.GetFSM(var_55_3)
	local var_55_5 = var_3.GetState

	NewEducateFSM = var_6

	local var_55_6 = var_55_5(var_55_4, var_6.SYSTEM.MAP)

	setActive = var_55_0

	local var_55_7 = arg_55_0.mapBtn

	var_55_0(var_6.Find(var_55_7, "tip"), var_55_6 and var_55_6:IsSpecial())

	return
end

function var_0_1.AddNewRoundDrops(arg_56_0, arg_56_1)
	arg_56_0.newRoundDrops = arg_56_1

	return
end

function var_0_1.ContinuePlayNode(arg_57_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_58_0)
			local var_58_0 = arg_57_0
			local var_58_1 = var_1.emit
			local var_58_2 = var_0_1.ON_BOX
			local var_58_3 = {
				hideClose = true
			}

			i18n = var_2_10006
			var_58_3.content = var_2_10006("child2_replay_tip")
			i18n = var_6
			var_58_3.noText = var_6("child2_replay_clear")
			i18n = var_6
			var_58_3.yesText = var_6("child2_replay_continue")
			var_58_3.onYes = arg_58_0

			function var_58_3.onNo()
				local var_59_0 = arg_57_0
				local var_59_1 = var_0.emit

				NewEducateMainMediator = var_3_10003

				var_59_1(var_59_0, var_3_10003.ON_CLEAR_NODE_CHAIN)

				return
			end

			var_58_1(var_58_0, var_58_2, var_58_3)

			return
		end
	}, function()
		local var_60_0 = arg_57_0
		local var_60_1 = var_0.OnNodeStart
		local var_60_2 = arg_57_0.contextData.char
		local var_60_3 = var_3.GetFSM(var_60_2)

		var_60_1(var_60_0, var_3.GetCurNode(var_60_3))

		return
	end)

	return
end

function var_0_1.EventHandler(arg_61_0)
	local var_61_0 = arg_61_0.contextData.char
	local var_61_1 = var_1.GetFSM(var_61_0)

	if var_1.GetCurNode(var_61_1) ~= 0 then
		arg_61_0:ContinuePlayNode()

		return
	end

	seriesAsync = var_1

	var_1({
		function(arg_62_0)
			local var_62_0 = arg_61_0.roundTipPanel

			var_1.ExecuteAction(var_62_0, "Show", arg_62_0)

			return
		end,
		function(arg_63_0)
			if #arg_61_0.newRoundDrops > 0 then
				local var_63_0 = arg_61_0
				local var_63_1 = var_1.emit

				NewEducateBaseUI = var_2_10004

				var_63_1(var_63_0, var_2_10004.ON_DROP, {
					items = arg_61_0.newRoundDrops,
					removeFunc = arg_63_0
				})
			else
				arg_63_0()
			end

			return
		end
	}, function()
		arg_61_0.newRoundDrops = {}

		local var_64_0 = arg_61_0
		local var_64_1 = var_0.emit

		NewEducateMainMediator = var_2_10003

		var_64_1(var_64_0, var_2_10003.ON_TRIGGER_MAIN_EVENT)

		return
	end)

	return
end

function var_0_1.TalentHandler(arg_65_0)
	local var_65_0 = arg_65_0.contextData.char
	local var_65_1 = var_1.GetFSM(var_65_0)
	local var_65_2 = var_1.GetState

	NewEducateFSM = var_1_10004

	local var_65_3 = var_65_2(var_65_1, var_1_10004.SYSTEM.TALENT)

	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_66_0)
			if not var_65_3 then
				local var_66_0 = arg_65_0
				local var_66_1 = var_1.emit

				NewEducateMainMediator = var_2_10004

				var_66_1(var_66_0, var_2_10004.ON_REQ_TALENTS, arg_66_0)
			else
				arg_66_0()
			end

			return
		end,
		function(arg_67_0)
			local var_67_0 = arg_65_0.contextData.char
			local var_67_1 = var_1.GetRoundData(var_67_0)

			if var_1.IsTalentRound(var_67_1) then
				local var_67_2 = arg_65_0
				local var_67_3 = var_1.emit
				local var_67_4 = var_0_1.GO_SUBLAYER

				Context = var_2_10005

				local var_67_5 = var_2_10005.New
				local var_67_6 = {}

				NewEducateTalentMediator = var_2_10008
				var_67_6.mediator = var_2_10008
				NewEducateTalentLayer = var_2_10008
				var_67_6.viewComponent = var_2_10008
				var_67_6.data = {
					onExit = arg_67_0
				}

				var_67_3(var_67_2, var_67_4, var_67_5(var_67_6))
			else
				arg_67_0()
			end

			return
		end
	}, function()
		local var_68_0 = arg_65_0

		var_0.SeriesCheck(var_68_0)

		return
	end)

	return
end

function var_0_1.ReqParallelData(arg_69_0)
	local var_69_0 = arg_69_0.contextData.char
	local var_69_1 = var_1.GetFSM(var_69_0)

	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_70_0)
			local var_70_0 = arg_69_0.contextData.char
			local var_70_1 = var_1.GetFSM(var_70_0)
			local var_70_2 = var_1.GetState

			NewEducateFSM = var_2_10004

			if not var_70_2(var_70_1, var_2_10004.SYSTEM.TOPIC) then
				local var_70_3 = arg_69_0
				local var_70_4 = var_2.emit

				NewEducateMainMediator = var_2_10005

				var_70_4(var_70_3, var_2_10005.ON_REQ_TOPICS, arg_70_0)
			else
				arg_70_0()
			end

			return
		end,
		function(arg_71_0)
			local var_71_0 = arg_69_0.contextData.char
			local var_71_1 = var_1.GetFSM(var_71_0)
			local var_71_2 = var_1.GetState

			NewEducateFSM = var_2_10004

			if not var_71_2(var_71_1, var_2_10004.SYSTEM.MAP) then
				local var_71_3 = arg_69_0
				local var_71_4 = var_2.emit

				NewEducateMainMediator = var_2_10005

				var_71_4(var_71_3, var_2_10005.ON_REQ_MAP)
			else
				arg_71_0()
			end

			return
		end
	}, function()
		local var_72_0 = arg_69_0

		var_0.UpdataTopicAndMind(var_72_0)

		NewEducateGuideSequence = var_0

		var_0.CheckGuide(arg_69_0.__cname)

		return
	end)

	return
end

function var_0_1.TopicHandler(arg_73_0)
	local var_73_0 = arg_73_0.contextData.char
	local var_73_1 = var_1.GetFSM(var_73_0)

	if var_1.GetCurNode(var_73_1) ~= 0 then
		arg_73_0:ContinuePlayNode()

		return
	end

	arg_73_0:ReqParallelData()

	return
end

function var_0_1.MindHandler(arg_74_0)
	local var_74_0 = arg_74_0.contextData.char
	local var_74_1 = var_1.GetFSM(var_74_0)

	if var_1.GetCurNode(var_74_1) ~= 0 then
		arg_74_0:ContinuePlayNode()

		return
	end

	arg_74_0:ReqParallelData()

	return
end

function var_0_1.MapHandler(arg_75_0)
	local var_75_0 = arg_75_0.contextData.char
	local var_75_1 = var_1.GetFSM(var_75_0)

	if var_1.GetCurNode(var_75_1) ~= 0 then
		local var_75_2 = arg_75_0
		local var_75_3 = arg_75_0.emit
		local var_75_4 = var_0_1.ON_BOX
		local var_75_5 = {
			hideClose = true
		}

		i18n = var_1_10006
		var_75_5.content = var_1_10006("child2_replay_tip")
		i18n = var_6
		var_75_5.noText = var_6("child2_replay_clear")
		i18n = var_6
		var_75_5.yesText = var_6("child2_replay_continue")

		function var_75_5.onYes()
			local var_76_0 = arg_75_0
			local var_76_1 = var_0.emit
			local var_76_2 = var_0_1.GO_SCENE

			SCENE = var_2_10004

			var_76_1(var_76_0, var_76_2, var_2_10004.NEW_EDUCATE_MAP)

			return
		end

		function var_75_5.onNo()
			local var_77_0 = arg_75_0
			local var_77_1 = var_0.emit

			NewEducateMainMediator = var_2_10003

			var_77_1(var_77_0, var_2_10003.ON_CLEAR_NODE_CHAIN)

			return
		end

		var_75_3(var_75_2, var_75_4, var_75_5)

		return
	end

	arg_75_0:ReqParallelData()

	return
end

function var_0_1.PlanHandler(arg_78_0)
	local var_78_0 = arg_78_0.contextData.char
	local var_78_1 = var_1.GetFSM(var_78_0)

	if var_1.GetCurNode(var_78_1) ~= 0 then
		arg_78_0:ContinuePlayNode()

		return
	end

	local var_78_2 = arg_78_0
	local var_78_3 = arg_78_0.emit

	NewEducateMainMediator = var_1_10004

	var_78_3(var_78_2, var_1_10004.ON_NEXT_PLAN, true)

	return
end

function var_0_1.AssessHandler(arg_79_0)
	local var_79_0 = arg_79_0.contextData.char
	local var_79_1 = var_1.GetFSM(var_79_0)

	if var_1.GetCurNode(var_79_1) ~= 0 then
		arg_79_0:ContinuePlayNode()

		return
	end

	local var_79_2 = arg_79_0.contextData.char
	local var_79_3 = var_1.GetAssessPreStory(var_79_2)
	local var_79_4 = arg_79_0.contextData.char
	local var_79_5 = var_2.GetAssessRankIdx(var_79_4)

	seriesAsync = var_79_2

	var_79_2({
		function(arg_80_0)
			local var_80_0 = arg_79_0.contextData.char
			local var_80_1 = var_1.GetFSM(var_80_0)
			local var_80_2 = var_1.GetSystemNo(var_80_1)

			NewEducateFSM = var_2_10002

			if not (var_80_2 == var_2_10002.SYSTEM.ASSESS) then
				local var_80_3 = arg_79_0
				local var_80_4 = var_2.emit

				NewEducateMainMediator = var_2_10005

				var_80_4(var_80_3, var_2_10005.ON_ENTER_ASSESS, arg_80_0)
			else
				arg_80_0()
			end

			return
		end,
		function(arg_81_0)
			if var_79_3 and var_79_3 ~= "" then
				NewEducateHelper = var_1

				var_1.PlaySpecialStory(var_79_3, arg_81_0, true)
			else
				arg_81_0()
			end

			return
		end,
		function(arg_82_0)
			if var_79_5 ~= 0 then
				local var_82_0 = arg_79_0.assessPanel

				var_1.ExecuteAction(var_82_0, "Show", arg_82_0)
			else
				local var_82_1 = arg_79_0.contextData.char
				local var_82_2 = var_1.GetFSM(var_82_1)
				local var_82_3 = var_1.GetState

				NewEducateFSM = var_2_10004

				local var_82_4 = var_82_3(var_82_2, var_2_10004.SYSTEM.ASSESS)

				var_1.MarkFinish(var_82_4)
				arg_82_0()
			end

			return
		end
	}, function(arg_83_0)
		local var_83_0 = arg_79_0

		var_1.SeriesCheck(var_83_0)

		return
	end)

	return
end

function var_0_1.StageHandler(arg_84_0)
	local var_84_0 = arg_84_0.assessPanel

	if var_1.isShowing(var_84_0) then
		local var_84_1 = arg_84_0.assessPanel

		var_1.ExecuteAction(var_84_1, "Hide")
	end

	local var_84_2 = arg_84_0.contextData.char
	local var_84_3 = var_1.GetFSM(var_84_2)

	if var_1.GetCurNode(var_84_3) ~= 0 then
		arg_84_0:ContinuePlayNode()

		return
	end

	local var_84_4 = arg_84_0
	local var_84_5 = arg_84_0.emit

	NewEducateMainMediator = var_1_10004

	var_84_5(var_84_4, var_1_10004.ON_STAGE_CHANGE)

	return
end

function var_0_1.EndingHandler(arg_85_0)
	local var_85_0 = arg_85_0.assessPanel

	if var_1.isShowing(var_85_0) then
		local var_85_1 = arg_85_0.assessPanel

		var_1.ExecuteAction(var_85_1, "Hide")
	end

	local var_85_2 = arg_85_0.contextData.char
	local var_85_3 = var_1.GetFSM(var_85_2)
	local var_85_4 = var_1.GetState

	NewEducateFSM = var_1_10004

	local var_85_5, var_85_6

	if var_85_4(var_85_3, var_1_10004.SYSTEM.ENDING) then
		::label_85_0::

		var_85_5 = var_1
		var_85_6 = var_1.IsFinish(var_85_5)
	end

	setActive = var_85_3

	var_85_3(arg_85_0.resetBtns, var_85_6)

	setActive = var_85_3

	var_85_3(arg_85_0.resetBtn, var_85_6)

	setActive = var_85_3

	local var_85_7 = arg_85_0.endlessBtn
	local var_85_10

	if var_85_6 then
		::label_85_1::

		local var_85_8 = arg_85_0.contextData.char
		local var_85_9 = var_6.GetRoundData(var_85_8)

		var_85_10 = var_6.ExistEndless(var_85_9)
	end

	var_85_3(var_85_7, var_85_10)

	setActive = var_85_3

	var_85_3(arg_85_0.endingBtn, not var_85_6)

	if var_85_6 then
		local var_85_11 = arg_85_0.contextData.char
		local var_85_12 = var_3.getConfig(var_85_11, "special_memory").after_ending

		pg = var_85_5

		local var_85_13 = var_85_5.NewStoryMgr.GetInstance()

		if not var_85_5.IsPlayed(var_85_13, var_85_12) then
			NewEducateHelper = var_85_5

			var_85_5.PlaySpecialStory(var_85_12, function()
				getProxy = var_2_10000
				EducateProxy = var_2_10002

				local var_86_0 = var_2_10000(var_2_10002)

				if var_0.GetSelectInfo(var_86_0).gameCnt == 1 then
					CultivatingPlantTools = var_0

					if var_0.IsPopActivity(arg_85_0.contextData.char.id) then
						local var_86_1 = arg_85_0
						local var_86_2 = var_0.emit
						local var_86_3 = var_0_1.GO_SUBLAYER

						Context = var_2_10004

						local var_86_4 = var_2_10004.New
						local var_86_5 = {}

						CultivatingPlantMediator = var_2_10007
						var_86_5.mediator = var_2_10007
						CultivatingPlantScene = var_2_10007
						var_86_5.viewComponent = var_2_10007
						var_86_5.data = {
							id = arg_85_0.contextData.char.id
						}

						var_86_2(var_86_1, var_86_3, var_86_4(var_86_5))
					end
				end

				return
			end)
		end
	else
		local var_85_14 = arg_85_0.contextData.char

		if var_3.getConfig(var_85_14, "special_memory").pre_ending ~= "" then
			NewEducateHelper = var_85_5

			var_85_5.PlaySpecialStory(var_3, function()
				return
			end)
		end
	end

	return
end

function var_0_1.OnEndingClick(arg_88_0)
	local var_88_0 = arg_88_0.contextData.char
	local var_88_1 = var_1.GetFSM(var_88_0)
	local var_88_2 = var_1.GetState

	NewEducateFSM = var_1_10004

	local var_88_3 = var_88_2(var_88_1, var_1_10004.SYSTEM.ENDING)

	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_89_0)
			if not var_88_3 then
				local var_89_0 = arg_88_0
				local var_89_1 = var_1.emit

				NewEducateMainMediator = var_2_10004

				var_89_1(var_89_0, var_2_10004.ON_REQ_ENDINGS, arg_89_0)
			else
				arg_89_0()
			end

			return
		end
	}, function()
		local var_90_0 = arg_88_0.contextData.char
		local var_90_1 = var_0.GetFSM(var_90_0)
		local var_90_2 = var_0.GetState

		NewEducateFSM = var_2_10003

		local var_90_3 = var_90_2(var_90_1, var_2_10003.SYSTEM.ENDING)

		if #var_0.GetEndings(var_90_3) == 1 then
			local var_90_4 = arg_88_0
			local var_90_5 = var_2.emit

			NewEducateMainMediator = var_2_10005

			var_90_5(var_90_4, var_2_10005.ON_SELECT_ENDING, var_1[1])
		else
			local var_90_6 = arg_88_0
			local var_90_7 = var_2.emit
			local var_90_8 = var_0_1.GO_SUBLAYER

			Context = var_2_10006

			local var_90_9 = var_2_10006.New
			local var_90_10 = {}

			NewEducateSelEndingMediator = var_2_10009
			var_90_10.mediator = var_2_10009
			NewEducateSelEndingLayer = var_2_10009
			var_90_10.viewComponent = var_2_10009
			var_90_10.data = {
				onExit = function()
					local var_91_0 = arg_88_0

					var_0.SeriesCheck(var_91_0)

					return
				end
			}

			var_90_7(var_90_6, var_90_8, var_90_9(var_90_10))
		end

		return
	end)

	return
end

function var_0_1.ChooseHandler(arg_92_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_93_0)
			local var_93_0 = arg_92_0
			local var_93_1 = var_1.emit

			NewEducateMainMediator = var_2_10004

			var_93_1(var_93_0, var_2_10004.ON_REQ_CHOOSE, arg_93_0)

			return
		end
	}, function()
		local var_94_0 = arg_92_0

		var_0.SeriesCheck(var_94_0)

		return
	end)

	return
end

function var_0_1.FailHandler(arg_95_0)
	local var_95_0 = arg_95_0.assessPanel

	if var_1.isShowing(var_95_0) then
		local var_95_1 = arg_95_0.assessPanel

		var_1.ExecuteAction(var_95_1, "Hide")
	end

	setActive = var_1

	var_1(arg_95_0.resetBtns, true)

	setActive = var_1

	var_1(arg_95_0.resetBtn, true)

	setActive = var_1

	var_1(arg_95_0.endlessBtn, false)

	setActive = var_1

	var_1(arg_95_0.resetInEndlessBtn, false)

	return
end

function var_0_1.OnSelDone(arg_96_0, arg_96_1)
	pg = var_1_10002

	local var_96_0 = var_1_10002.child2_ending[arg_96_1].performance

	NewEducateHelper = var_1_10003

	var_1_10003.PlaySpecialStory(var_96_0, function()
		local var_97_0 = arg_96_0

		var_0.SeriesCheck(var_97_0)

		return
	end, true)

	return
end

function var_0_1.OnClickResetBtn(arg_98_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_99_0)
			local var_99_0 = arg_98_0
			local var_99_1 = var_1.emit
			local var_99_2 = var_0_1.ON_BOX
			local var_99_3 = {}

			i18n = var_2_10006
			var_99_3.content = var_2_10006("child2_reset_sure_tip")
			var_99_3.onYes = arg_99_0

			var_99_1(var_99_0, var_99_2, var_99_3)

			return
		end,
		function(arg_100_0)
			local var_100_0 = arg_98_0
			local var_100_1 = var_1.emit

			NewEducateMainMediator = var_2_10004

			var_100_1(var_100_0, var_2_10004.ON_RESET, arg_100_0)

			return
		end
	}, function()
		local var_101_0 = arg_98_0

		var_0.OnReset(var_101_0)

		return
	end)

	return
end

function var_0_1.OnClickResetInEndlessBtn(arg_102_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_103_0)
			local var_103_0 = arg_102_0
			local var_103_1 = var_1.emit
			local var_103_2 = var_0_1.GO_SUBLAYER

			Context = var_2_10005

			local var_103_3 = var_2_10005.New
			local var_103_4 = {}

			NewEducateMsgBoxLayer = var_2_10008
			var_103_4.viewComponent = var_2_10008
			NewEducateMsgBoxMediator = var_2_10008
			var_103_4.mediator = var_2_10008

			local var_103_5 = {}

			NewEducateMsgBoxLayer = var_2_10009
			var_103_5.type = var_2_10009.TYPE.RESET
			var_103_5.onYes = arg_103_0
			var_103_4.data = var_103_5

			var_103_1(var_103_0, var_103_2, var_103_3(var_103_4))

			return
		end,
		function(arg_104_0)
			local var_104_0 = arg_102_0
			local var_104_1 = var_1.emit

			NewEducateMainMediator = var_2_10004

			var_104_1(var_104_0, var_2_10004.ON_RESET, arg_104_0)

			return
		end
	}, function()
		local var_105_0 = arg_102_0

		var_0.OnReset(var_105_0)

		return
	end)

	return
end

function var_0_1.OnClickEndlessBtn(arg_106_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_107_0)
			local var_107_0 = arg_106_0
			local var_107_1 = var_1.emit
			local var_107_2 = var_0_1.ON_BOX
			local var_107_3 = {}

			i18n = var_2_10006
			var_107_3.content = var_2_10006("child2_endless_sure_tip")
			var_107_3.onYes = arg_107_0

			var_107_1(var_107_0, var_107_2, var_107_3)

			return
		end,
		function(arg_108_0)
			local var_108_0 = arg_106_0
			local var_108_1 = var_1.emit

			NewEducateMainMediator = var_2_10004

			var_108_1(var_108_0, var_2_10004.ON_START_ENDLESS, arg_108_0)

			return
		end
	}, function()
		local var_109_0 = arg_106_0

		var_0.CheckFSM(var_109_0)

		return
	end)

	return
end

function var_0_1.OnResUpdate(arg_110_0)
	local var_110_0 = arg_110_0.topPanel

	var_1.ExecuteAction(var_110_0, "FlushRes")
	arg_110_0:CheckFavorUpgrade()

	return
end

function var_0_1.OnAttrUpdate(arg_111_0)
	local var_111_0 = arg_111_0.infoPanel

	var_1.ExecuteAction(var_111_0, "FlushAttrs")

	local var_111_1 = arg_111_0.topPanel

	var_1.ExecuteAction(var_111_1, "FlushProgress")

	return
end

function var_0_1.OnPersonalityUpdate(arg_112_0, arg_112_1, arg_112_2)
	local var_112_0 = arg_112_0.personalityTipPanel

	var_3.ExecuteAction(var_112_0, "FlushPersonality", arg_112_1, arg_112_2)

	local var_112_1 = arg_112_0.contextData.char

	if var_3.GetPersonalityTag(var_112_1) ~= arg_112_2 then
		arg_112_0:UpdatePaintingUI()
		arg_112_0:PlayBGM()
	end

	return
end

function var_0_1.OnTalentUpdate(arg_113_0)
	local var_113_0 = arg_113_0.infoPanel

	var_1.ExecuteAction(var_113_0, "FlushTalents")

	return
end

function var_0_1.OnStatusUpdate(arg_114_0)
	local var_114_0 = arg_114_0.infoPanel

	var_1.ExecuteAction(var_114_0, "FlushStatus")

	return
end

function var_0_1.OnTarotUpdate(arg_115_0)
	local var_115_0 = arg_115_0.infoPanel

	var_1.ExecuteAction(var_115_0, "FlushTarot")

	return
end

function var_0_1.UpdateUnlockUI(arg_116_0)
	setActive = var_1_10001

	local var_116_0 = arg_116_0.mapBtn
	local var_116_1 = var_3.Find(var_116_0, "lock")
	local var_116_2 = arg_116_0.contextData.char

	var_1_10001(var_116_1, not var_4.IsUnlock(var_116_2, "out"))

	return
end

function var_0_1.OnNextRound(arg_117_0)
	local var_117_0 = arg_117_0.topPanel

	var_1.ExecuteAction(var_117_0, "Flush")

	local var_117_1 = arg_117_0.infoPanel

	var_1.ExecuteAction(var_117_1, "Flush")
	arg_117_0:UpdatePaintingUI()
	arg_117_0:UpdateUnlockUI()

	return
end

function var_0_1.OnNodeStart(arg_118_0, arg_118_1)
	if arg_118_1 == 0 then
		return
	end

	assert = var_1_10002
	pg = var_1_10004

	var_1_10002(var_1_10004.child2_node[arg_118_1], "child2_node缺少id:" .. arg_118_1)

	local var_118_0 = arg_118_0.nodePanel

	var_2.ExecuteAction(var_118_0, "StartNode", arg_118_1)

	pg = var_2

	local var_118_1 = var_2.child2_node[arg_118_1].type

	NewEducateNodePanel = var_1_10003

	if var_118_1 == var_1_10003.NODE_TYPE.MAIN_TEXT then
		arg_118_0:HideDialogueUI()
		arg_118_0:UpdatePaintingFace(arg_118_1)
	end

	return
end

function var_0_1.OnNextNode(arg_119_0, arg_119_1)
	local var_119_0 = arg_119_0.nodePanel

	var_2.ExecuteAction(var_119_0, "ProceedNode", arg_119_1.node, arg_119_1.drop, arg_119_1.noNextCb)

	local var_119_1 = arg_119_0.contextData.char
	local var_119_2 = var_2.GetFSM(var_119_1)
	local var_119_3 = var_2.GetSystemNo(var_119_2)

	NewEducateFSM = var_1_10003

	if var_119_3 ~= var_1_10003.SYSTEM.PLAN then
		arg_119_0:UpdatePaintingFace(arg_119_1.node)
	end

	return
end

function var_0_1.UpdateCallName(arg_120_0)
	local var_120_0 = arg_120_0.nodePanel

	var_1.ExecuteAction(var_120_0, "UpdateCallName")

	return
end

function var_0_1.onBackPressed(arg_121_0)
	if arg_121_0.lockBackPressed then
		return
	end

	local var_121_0 = arg_121_0.assessPanel

	if var_1.isShowing(var_121_0) then
		return
	end

	local var_121_1 = arg_121_0.nodePanel

	if var_1.isShowing(var_121_1) then
		return
	end

	local var_121_2 = arg_121_0.roundTipPanel

	if var_1.isShowing(var_121_2) then
		return
	end

	arg_121_0.super.onBackPressed(arg_121_0)

	return
end

function var_0_1.willExit(arg_122_0)
	arg_122_0.contextData.isMainEnter = nil

	if arg_122_0.topPanel then
		local var_122_0 = arg_122_0.topPanel

		var_1.Destroy(var_122_0)

		arg_122_0.topPanel = nil
	end

	if arg_122_0.infoPanel then
		local var_122_1 = arg_122_0.infoPanel

		var_1.Destroy(var_122_1)

		arg_122_0.infoPanel = nil
	end

	if arg_122_0.roundTipPanel then
		local var_122_2 = arg_122_0.roundTipPanel

		var_1.Destroy(var_122_2)

		arg_122_0.roundTipPanel = nil
	end

	if arg_122_0.assessPanel then
		local var_122_3 = arg_122_0.assessPanel

		var_1.Destroy(var_122_3)

		arg_122_0.assessPanel = nil
	end

	if arg_122_0.favorPanel then
		local var_122_4 = arg_122_0.favorPanel

		var_1.Destroy(var_122_4)

		arg_122_0.favorPanel = nil
	end

	if arg_122_0.personalityTipPanel then
		local var_122_5 = arg_122_0.personalityTipPanel

		var_1.Destroy(var_122_5)

		arg_122_0.personalityTipPanel = nil
	end

	if arg_122_0.nodePanel then
		local var_122_6 = arg_122_0.nodePanel

		var_1.Destroy(var_122_6)

		arg_122_0.nodePanel = nil
	end

	LeanTween = var_1

	if var_1.isTweening(arg_122_0.dialogueTF) then
		LeanTween = var_1

		var_1.cancel(arg_122_0.dialogueTF)
	end

	return
end

return var_0_1
