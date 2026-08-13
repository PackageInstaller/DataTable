class = var_0_10000

local var_0_0 = "NewCommanderScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "GetCommanderUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bgTF = var_1.Find(var_2_0, "main/bg")

	local var_2_1 = arg_2_0._tf

	arg_2_0.clickTF = var_1.Find(var_2_1, "click")

	local var_2_2 = arg_2_0._tf

	arg_2_0.paintTF = var_1.Find(var_2_2, "main/paint")

	local var_2_3 = arg_2_0.paintTF
	local var_2_4 = var_1.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10006
	arg_2_0.paintTFCG = var_2_4(var_2_3, var_4(var_1_10006))

	local var_2_5 = arg_2_0._tf

	arg_2_0.infoTF = var_1.Find(var_2_5, "main/info")

	local var_2_6 = arg_2_0._tf

	arg_2_0.leftPanel = var_1.Find(var_2_6, "left_panel")

	local var_2_7 = arg_2_0._tf

	arg_2_0.lockBtn = var_1.Find(var_2_7, "left_panel/btns/lock")

	local var_2_8 = arg_2_0._tf

	arg_2_0.unlockBtn = var_1.Find(var_2_8, "left_panel/btns/unlock")

	local var_2_9 = arg_2_0._tf

	arg_2_0.shareBtn = var_1.Find(var_2_9, "left_panel/btns/share")

	local var_2_10 = arg_2_0.infoTF
	local var_2_11 = var_1.Find(var_2_10, "content/name/value")
	local var_2_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.nameTF = var_2_12(var_2_11, var_4(var_1_10006))

	local var_2_13 = arg_2_0.infoTF
	local var_2_14 = var_1.Find(var_2_13, "content/nation/value")
	local var_2_15 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.nationTF = var_2_15(var_2_14, var_4(var_1_10006))

	local var_2_16 = arg_2_0.infoTF
	local var_2_17 = var_1.Find(var_2_16, "content/rarity/value")
	local var_2_18 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.rarityTF = var_2_18(var_2_17, var_4(var_1_10006))

	local var_2_19 = arg_2_0.infoTF
	local var_2_20 = var_1.Find(var_2_19, "content/skill/value")
	local var_2_21 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.skillTF = var_2_21(var_2_20, var_4(var_1_10006))

	local var_2_22 = arg_2_0.infoTF

	arg_2_0.abilitysTF = var_1.Find(var_2_22, "content/abilitys/attrs")

	local var_2_23 = arg_2_0.infoTF

	arg_2_0.talentsTF = var_1.Find(var_2_23, "content/talents")
	UIItemList = var_1

	local var_2_24 = var_1.New
	local var_2_25 = arg_2_0.talentsTF
	local var_2_26 = arg_2_0.talentsTF

	arg_2_0.talentsList = var_2_24(var_2_25, var_4.Find(var_2_26, "talent"))

	local var_2_27 = arg_2_0.infoTF

	arg_2_0.dateTF = var_1.Find(var_2_27, "content/copyright/Text")
	CommanderTreePage = var_1
	arg_2_0.treePanel = var_1.New(arg_2_0._tf, arg_2_0.event)
	CommanderMsgBoxPage = var_1
	arg_2_0.msgbox = var_1.New(arg_2_0._tf, arg_2_0.event)

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_1.GetComponent

	typeof = var_4
	Animator = var_2_26
	arg_2_0.antor = var_2_29(var_2_28, var_4(var_2_26))

	local var_2_30 = arg_2_0._tf

	arg_2_0.skipBtn = var_1.Find(var_2_30, "skip")

	local var_2_31 = arg_2_0._tf

	arg_2_0.getEffect = var_1.Find(var_2_31, "main/effect")
	arg_2_0.skipAnim = true
	pg = var_1

	local var_2_32 = var_1.NewGuideMgr.GetInstance()

	if var_1.IsBusy(var_2_32) then
		arg_2_0.skipAnim = false
	end

	pg = var_1

	local var_2_33 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_33, arg_2_0._tf)

	setText = var_1

	local var_2_34 = arg_2_0._tf
	local var_2_35 = var_3.Find(var_2_34, "main/info/content/abilitys/attrs/command/name/Text")

	i18n = var_4

	var_1(var_2_35, var_4("commander_command_ability"))

	setText = var_1

	local var_2_36 = arg_2_0._tf
	local var_2_37 = var_3.Find(var_2_36, "main/info/content/abilitys/attrs/tactic/name/Text")

	i18n = var_4

	var_1(var_2_37, var_4("commander_tactical_ability"))

	setText = var_1

	local var_2_38 = arg_2_0._tf
	local var_2_39 = var_3.Find(var_2_38, "main/info/content/abilitys/attrs/support/name/Text")

	i18n = var_4

	var_1(var_2_39, var_4("commander_logistics_ability"))

	setText = var_1

	local var_2_40 = arg_2_0._tf
	local var_2_41 = var_3.Find(var_2_40, "main/info/content/copyright/title")

	i18n = var_4

	var_1(var_2_41, var_4("commander_get_commander_coptyright"))

	return
end

function var_0_1.openTreePanel(arg_3_0, arg_3_1)
	local function var_3_0()
		local var_4_0 = arg_3_0.treePanel

		var_0.ActionInvoke(var_4_0, "Show", arg_3_1)

		return
	end

	local var_3_1 = arg_3_0.treePanel

	if var_3.GetLoaded(var_3_1) then
		var_3_0()
	else
		local var_3_2 = arg_3_0.treePanel

		var_3.Load(var_3_2)

		local var_3_3 = arg_3_0.treePanel

		var_3.CallbackInvoke(var_3_3, var_3_0)
	end

	return
end

function var_0_1.closeTreePanel(arg_5_0)
	local var_5_0 = arg_5_0.treePanel

	var_1.ActionInvoke(var_5_0, "closeTreePanel")

	return
end

function var_0_1.onUIAnimEnd(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.antor

	var_2.SetBool(var_6_0, "play", true)

	arg_6_0.isAnim = true
	setActive = var_2

	var_2(arg_6_0.clickTF, arg_6_0.skipAnim)

	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_2.GetComponent

	typeof = var_5
	DftAniEvent = var_1_10007

	local var_6_3 = var_6_2(var_6_1, var_5(var_1_10007))

	var_2.SetTriggerEvent(var_6_3, function(arg_7_0)
		local var_7_0 = arg_6_0.contextData.commander

		if var_1.isSSR(var_7_0) then
			local var_7_1 = arg_6_0

			var_1.playerEffect(var_7_1)
		end

		local var_7_2 = var_0

		var_1.SetTriggerEvent(var_7_2, nil)

		return
	end)
	var_2:SetEndEvent(function()
		local var_8_0 = arg_6_0

		var_8_0.isAnim = false
		setActive = var_8_0

		var_8_0(arg_6_0.clickTF, true)

		local var_8_1 = var_0

		var_0.SetEndEvent(var_8_1, nil)
		arg_6_1()

		return
	end)

	return
end

function var_0_1.playerEffect(arg_9_0)
	PoolMgr = var_1_10001

	local var_9_0 = var_1_10001.GetInstance()

	var_1.GetUI(var_9_0, "AL_zhihuimiao_zhipian", true, function(arg_10_0)
		local var_10_0 = arg_9_0

		var_10_0.effect = arg_10_0
		SetParent = var_10_0

		var_10_0(arg_10_0, arg_9_0._tf)

		setActive = var_10_0

		var_10_0(arg_10_0, true)

		return
	end)

	return
end

function var_0_1.openMsgBox(arg_11_0, arg_11_1)
	arg_11_0.isShowMsgBox = true

	local function var_11_0()
		local var_12_0 = arg_11_0.msgbox

		var_0.ActionInvoke(var_12_0, "Show", arg_11_1)

		return
	end

	local var_11_1 = arg_11_0.msgbox

	if var_3.GetLoaded(var_11_1) then
		var_11_0()
	else
		local var_11_2 = arg_11_0.msgbox

		var_3.Load(var_11_2)

		local var_11_3 = arg_11_0.msgbox

		var_3.CallbackInvoke(var_11_3, var_11_0)
	end

	return
end

function var_0_1.closeMsgBox(arg_13_0)
	arg_13_0.isShowMsgBox = nil

	local var_13_0 = arg_13_0.msgbox

	var_1.ActionInvoke(var_13_0, "Hide")

	return
end

function var_0_1.didEnter(arg_14_0)
	arg_14_0:updateInfo()

	onButton = var_1

	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.shareBtn

	local function var_14_2()
		pg = var_2_10000

		local var_15_0 = var_2_10000.ShareMgr.GetInstance()
		local var_15_1 = var_0.Share

		pg = var_2_10003

		local var_15_2 = var_2_10003.ShareMgr.TypeCommander

		pg = var_2_10004

		var_15_1(var_15_0, var_15_2, var_2_10004.ShareMgr.PANEL_TYPE_PINK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_14_0, var_14_1, var_14_2, var_1_10006)

	onButton = var_1

	local var_14_3 = arg_14_0
	local var_14_4 = arg_14_0.skipBtn

	local function var_14_5(arg_16_0)
		if arg_14_0.isAnim then
			return
		end

		getProxy = var_1
		CommanderProxy = var_2_10003
		var_1(var_2_10003).hasSkipFlag = true

		local var_16_0 = arg_14_0

		var_1.DoExit(var_16_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_14_3, var_14_4, var_14_5, var_1_10006)

	onButton = var_1

	local var_14_6 = arg_14_0
	local var_14_7 = arg_14_0.lockBtn

	local function var_14_8()
		getProxy = var_2_10000
		CommanderProxy = var_2_10002

		local var_17_0 = var_2_10000(var_2_10002)
		local var_17_1 = var_0.getCommanderById(var_17_0, arg_14_0.contextData.commander.id)
		local var_17_2 = var_0.getLock(var_17_1)
		local var_17_3 = arg_14_0
		local var_17_4 = var_2.emit

		NewCommanderMediator = var_2_10005

		var_17_4(var_17_3, var_2_10005.ON_LOCK, arg_14_0.contextData.commander.id, 1 - var_17_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_14_6, var_14_7, var_14_8, var_1_10006)

	onButton = var_1

	local var_14_9 = arg_14_0
	local var_14_10 = arg_14_0.unlockBtn

	local function var_14_11()
		getProxy = var_2_10000
		CommanderProxy = var_2_10002

		local var_18_0 = var_2_10000(var_2_10002)
		local var_18_1 = var_0.getCommanderById(var_18_0, arg_14_0.contextData.commander.id)
		local var_18_2 = var_0.getLock(var_18_1)
		local var_18_3 = arg_14_0
		local var_18_4 = var_2.emit

		NewCommanderMediator = var_2_10005

		var_18_4(var_18_3, var_2_10005.ON_LOCK, arg_14_0.contextData.commander.id, 1 - var_18_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_14_9, var_14_10, var_14_11, var_1_10006)

	onButton = var_1

	local var_14_12 = arg_14_0
	local var_14_13 = arg_14_0.clickTF

	local function var_14_14()
		if arg_14_0.isAnim then
			local var_19_0 = arg_14_0.antor

			var_0.SetBool(var_19_0, "play", false)

			local var_19_1 = arg_14_0.contextData.commander

			if var_0.isSSR(var_19_1) and not arg_14_0.effect then
				local var_19_2 = arg_14_0

				var_0.playerEffect(var_19_2)
			end

			arg_14_0.isAnim = nil
		else
			local var_19_3 = arg_14_0

			var_0.DoExit(var_19_3)
		end

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_14_12, var_14_13, var_14_14, var_1_10006)

	return
end

function var_0_1.DoExit(arg_20_0)
	local var_20_0 = arg_20_0.contextData.commander

	if var_1.ShouldTipLock(var_20_0) then
		local var_20_1 = arg_20_0
		local var_20_2 = arg_20_0.openMsgBox
		local var_20_3 = {}

		i18n = var_1_10005
		var_20_3.content = var_1_10005("commander_lock_tip")

		function var_20_3.onYes()
			local var_21_0 = arg_20_0
			local var_21_1 = var_0.emit

			NewCommanderMediator = var_2_10003

			var_21_1(var_21_0, var_2_10003.ON_LOCK, arg_20_0.contextData.commander.id, 1)

			local var_21_2 = arg_20_0

			var_0.emit(var_21_2, var_0_1.ON_CLOSE)

			return
		end

		function var_20_3.onNo()
			local var_22_0 = arg_20_0

			var_0.emit(var_22_0, var_0_1.ON_CLOSE)

			return
		end

		var_20_2(var_20_1, var_20_3)
	else
		arg_20_0:emit(var_0_1.ON_CLOSE)
	end

	return
end

function var_0_1.updateLockState(arg_23_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10003

	local var_23_0 = var_1_10001(var_1_10003)
	local var_23_1 = var_1.getCommanderById(var_23_0, arg_23_0.contextData.commander.id)
	local var_23_2 = var_1.getLock(var_23_1)

	setActive = var_23_0

	var_23_0(arg_23_0.lockBtn, var_23_2 ~= 0)

	setActive = var_23_0

	var_23_0(arg_23_0.unlockBtn, var_23_2 == 0)

	return
end

function var_0_1.updateInfo(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.contextData.commander

	arg_24_0:updateLockState(var_24_0:getLock())

	arg_24_0.nameTF.text = var_24_0:getName()

	local var_24_1 = arg_24_0.nationTF

	Nation = var_4
	var_24_1.text = var_4.Nation2Name(var_24_0:getConfig("nationality"))

	local var_24_2 = var_24_0:getSkills()[1]
	local var_24_3 = arg_24_0.skillTF

	var_24_3.text = var_24_2:getConfig("name")
	Commander = var_24_3

	local var_24_4 = var_24_3.rarity2Print(var_24_0:getRarity())

	LoadImageSpriteAsync = var_6

	var_6("CommanderRarity/" .. var_24_4, arg_24_0.rarityTF, true)

	setCommanderPaintingPrefab = var_6

	var_6(arg_24_0.paintTF, var_24_0:getPainting(), "get")

	arg_24_0.painting = var_24_0

	arg_24_0:updateAbilitys()
	arg_24_0:updateTalents()

	setText = var_6

	local var_24_5 = arg_24_0.dateTF

	pg = var_9

	local var_24_6 = var_9.TimeMgr.GetInstance()

	var_6(var_24_5, var_9.CurrentSTimeDesc(var_24_6, "%y%m%d"))

	if arg_24_1 then
		arg_24_1()
	end

	return
end

function var_0_1.updateAbilitys(arg_25_0)
	local var_25_0 = arg_25_0.contextData.commander
	local var_25_1 = var_1.getAbilitys(var_25_0)

	eachChild = var_1_10003

	var_1_10003(arg_25_0.abilitysTF, function(arg_26_0)
		go = var_2_10001

		local var_26_0 = var_2_10001(arg_26_0).name
		local var_26_1 = var_25_1[var_26_0]

		setText = var_3

		var_3(arg_26_0:Find("slider/point"), var_26_1.value)

		local var_26_2 = arg_26_0:Find("slider")
		local var_26_3 = var_3.GetComponent

		typeof = var_6
		Slider = var_8

		local var_26_4 = var_26_3(var_26_2, var_6(var_8))
		local var_26_5 = var_26_1.value

		CommanderConst = var_26_2
		var_26_4.value = var_26_5 / var_26_2.MAX_ABILITY

		return
	end)

	return
end

function var_0_1.updateTalents(arg_27_0)
	local var_27_0 = arg_27_0.contextData.commander
	local var_27_1 = var_1.getTalents(var_27_0)
	local var_27_2 = arg_27_0.talentsList

	var_3.make(var_27_2, function(arg_28_0, arg_28_1, arg_28_2)
		UIItemList = var_2_10003

		if arg_28_0 == var_2_10003.EventUpdate then
			local var_28_0 = var_27_1[arg_28_1 + 1]

			setActive = var_4

			var_4(arg_28_2:Find("empty"), not var_28_0)

			setActive = var_4

			var_4(arg_28_2:Find("icon"), var_28_0)

			local var_28_2

			if var_28_0 then
				GetImageSpriteFromAtlasAsync = var_4

				local var_28_1 = "CommanderTalentIcon/"

				var_28_2 = var_28_0

				var_4(var_28_1 .. var_28_0.getConfig(var_28_2, "icon"), "", arg_28_2:Find("icon"))
			end

			onButton = var_4

			local var_28_3 = arg_27_0
			local var_28_4 = arg_28_2

			local function var_28_5()
				local var_29_0 = arg_27_0

				var_0.openTreePanel(var_29_0, var_28_0)

				return
			end

			SFX_PANEL = var_28_2

			var_4(var_28_3, var_28_4, var_28_5, var_28_2)
		end

		return
	end)

	local var_27_3 = arg_27_0.talentsList

	var_3.align(var_27_3, 3)

	return
end

function var_0_1.onBackPressed(arg_30_0)
	if arg_30_0.isShowMsgBox then
		arg_30_0:closeMsgBox()

		return
	end

	return
end

function var_0_1.willExit(arg_31_0)
	pg = var_1_10001

	local var_31_0 = var_1_10001.UIMgr.GetInstance()
	local var_31_1 = var_1.UnOverlayPanel
	local var_31_2 = arg_31_0._tf

	pg = var_1_10005

	var_31_1(var_31_0, var_31_2, var_1_10005.UIMgr.GetInstance().UIMain)

	local var_31_3 = arg_31_0.treePanel

	var_1.Destroy(var_31_3)

	local var_31_4 = arg_31_0.msgbox

	var_1.Destroy(var_31_4)

	retCommanderPaintingPrefab = var_1

	local var_31_5 = arg_31_0.paintTF
	local var_31_6 = arg_31_0.painting

	var_1(var_31_5, var_4.getPainting(var_31_6))

	if arg_31_0.effect then
		PoolMgr = var_1

		local var_31_7 = var_1.GetInstance()

		var_1.ReturnUI(var_31_7, "AL_zhihuimiao_zhipian", arg_31_0.effect)
	end

	if arg_31_0.contextData.onExit then
		arg_31_0.contextData.onExit()
	end

	return
end

return var_0_1
