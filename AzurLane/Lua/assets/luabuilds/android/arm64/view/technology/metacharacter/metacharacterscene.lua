class = var_0_10000

local var_0_0 = "MetaCharacterScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

var_0_1.PAGES = {
	REPAIR = 3,
	ENERGY = 1,
	SYN = 4,
	TACTICS = 2
}

local var_0_2 = {}

MetaCharacterMediator = var_0_0
var_0_2[1] = var_0_0.ON_ENERGY
MetaCharacterMediator = var_2
var_0_2[2] = var_2.ON_TACTICS
MetaCharacterMediator = var_2
var_0_2[3] = var_2.ON_REPAIR
MetaCharacterMediator = var_2
var_0_2[4] = var_2.ON_SYN
var_0_1.PAGES_EVENTS = var_0_2
var_0_1.SCALE_ON_PITCH = {
	x = 1.7,
	y = 1.7
}
var_0_1.ON_SKILL = "MetaCharacterScene:ON_SKILL"

function var_0_1.getUIName(arg_1_0)
	return "MetaCharacterUI"
end

function var_0_1.init(arg_2_0)
	Input = var_1_10001
	var_1_10001.multiTouchEnabled = false

	arg_2_0:initUITextTips()
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initMetaProgressList()
	arg_2_0:initBannerList()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:overLayPanel(true)
	arg_3_0:updateStart()
	arg_3_0:autoOpenFunc()

	return
end

function var_0_1.willExit(arg_4_0)
	Input = var_1_10001
	var_1_10001.multiTouchEnabled = true

	arg_4_0:overLayPanel(false)

	return
end

function var_0_1.initUITextTips(arg_5_0)
	local var_5_0 = arg_5_0._tf
	local var_5_1 = var_1.Find(var_5_0, "HidePanel/ScrollPanel/ListPanel/BannerTpl/ForScale")
	local var_5_2 = var_1.Find(var_5_1, "Empty/ActType/TipText")
	local var_5_3 = var_1:Find("Empty/BuildType/TipText")
	local var_5_4 = var_1
	local var_5_5 = var_1.Find(var_5_4, "Active/ActType/Text")
	local var_5_6 = var_1:Find("Active/BuildType/Text")

	setText = var_5_4

	local var_5_7 = var_5_2

	i18n = var_1_10009

	var_5_4(var_5_7, var_1_10009("meta_syn_rate"))

	setText = var_5_4

	local var_5_8 = var_5_3

	i18n = var_9

	var_5_4(var_5_8, var_9("meta_build"))

	setText = var_5_4

	local var_5_9 = var_5_5

	i18n = var_9

	var_5_4(var_5_9, var_9("meta_repair_rate"))

	setText = var_5_4

	local var_5_10 = var_5_6

	i18n = var_9

	var_5_4(var_5_10, var_9("meta_build"))

	local var_5_11 = arg_5_0._tf
	local var_5_12 = var_6.Find(var_5_11, "HidePanel/PTPanel/Progress/Story/TipText1")
	local var_5_13 = arg_5_0._tf
	local var_5_14 = var_7.Find(var_5_13, "HidePanel/PTPanel/Progress/Story/TipText2")

	setText = var_5_11

	local var_5_15 = var_5_12

	i18n = var_11

	var_5_11(var_5_15, var_11("meta_story_tip_1"))

	setText = var_5_11

	local var_5_16 = var_5_14

	i18n = var_11

	var_5_11(var_5_16, var_11("meta_story_tip_2"))

	local var_5_17 = arg_5_0._tf
	local var_5_18

	var_5_18, setText = var_8.Find(var_5_17, "HidePanel/ActTimeTip/Tip"), var_5_13
	i18n = var_1_10012

	var_5_13(var_5_18, var_1_10012("meta_acttime_limit"))

	return
end

function var_0_1.initData(arg_6_0)
	arg_6_0.metaProgressVOList = {}
	arg_6_0.curMetaGroupID = nil
	arg_6_0.curMetaProgress = nil
	arg_6_0.toggleList = {}
	arg_6_0.bannerTFList = {}
	arg_6_0.curPageIndex = nil
	arg_6_0.curMetaIndex = nil
	getProxy = var_1
	MetaCharacterProxy = var_1_10003
	arg_6_0.metaCharacterProxy = var_1(var_1_10003)
	getProxy = var_1
	BayProxy = var_1_10003
	arg_6_0.bayProxy = var_1(var_1_10003)
	arg_6_0.indexDatas = {}

	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.shipImg = var_1.Find(var_7_0, "HidePanel/ShipImg")

	local var_7_1 = arg_7_0._tf

	arg_7_0.shipNameImg = var_1.Find(var_7_1, "HidePanel/NameImg")

	local var_7_2 = arg_7_0._tf

	arg_7_0.noCharTF = var_1.Find(var_7_2, "BG/NoCharacter")

	local var_7_3 = arg_7_0._tf

	arg_7_0.indexBtn = var_1.Find(var_7_3, "blur_panel/adapt/top/index")

	local var_7_4 = arg_7_0._tf

	arg_7_0.hidePanel = var_1.Find(var_7_4, "HidePanel")

	local var_7_5 = arg_7_0.hidePanel

	arg_7_0.scrollPanel = var_1.Find(var_7_5, "ScrollPanel")

	local var_7_6 = arg_7_0.scrollPanel

	arg_7_0.bannerListPanel = var_1.Find(var_7_6, "ListPanel")

	local var_7_7 = arg_7_0.bannerListPanel

	arg_7_0.bannerContainer = var_1.Find(var_7_7, "Container")

	local var_7_8 = arg_7_0.bannerListPanel

	arg_7_0.bannerTpl = var_1.Find(var_7_8, "BannerTpl")

	local var_7_9 = arg_7_0.hidePanel

	arg_7_0.actTimePanel = var_1.Find(var_7_9, "ActTimeTip")

	local var_7_10 = arg_7_0.actTimePanel

	arg_7_0.actTimeText = var_1.Find(var_7_10, "Text")

	local var_7_11 = arg_7_0.hidePanel

	arg_7_0.menuPanel = var_1.Find(var_7_11, "MenuPanel")

	local var_7_12 = arg_7_0.menuPanel

	arg_7_0.energyBtn = var_1.Find(var_7_12, "EnergyBtn")

	local var_7_13 = arg_7_0.menuPanel

	arg_7_0.repairBtn = var_1.Find(var_7_13, "RepairBtn")

	local var_7_14 = arg_7_0.menuPanel

	arg_7_0.tacticsBtn = var_1.Find(var_7_14, "TacticsBtn")

	local var_7_15 = arg_7_0.menuPanel

	arg_7_0.synBtn = var_1.Find(var_7_15, "SynBtn")

	local var_7_16 = arg_7_0.menuPanel

	arg_7_0.synDecorateTF = var_1.Find(var_7_16, "SynDecorate")

	local var_7_17 = arg_7_0.synBtn

	arg_7_0.synBtnLimitTimeTF = var_1.Find(var_7_17, "Limit")

	local var_7_18 = arg_7_0.synBtn

	arg_7_0.synBtnLock = var_1.Find(var_7_18, "LockMask")

	local var_7_19 = arg_7_0.hidePanel

	arg_7_0.ptPanel = var_1.Find(var_7_19, "PTPanel")

	local var_7_20 = arg_7_0.ptPanel

	arg_7_0.ptRedBarImg = var_1.Find(var_7_20, "RedBar")

	local var_7_21 = arg_7_0.ptPanel

	arg_7_0.ptPreviewBtn = var_1.Find(var_7_21, "PreviewBtn")

	local var_7_22 = arg_7_0.ptPanel

	arg_7_0.ptGetBtn = var_1.Find(var_7_22, "SynBtn")

	local var_7_23 = arg_7_0.ptGetBtn

	arg_7_0.ptGetBtnTag = var_1.Find(var_7_23, "Tag")

	local var_7_24 = arg_7_0.ptPanel

	arg_7_0.ptShowWayBtn = var_1.Find(var_7_24, "ShowWayBtn")

	local var_7_25 = arg_7_0.ptPanel
	local var_7_26 = var_1.Find(var_7_25, "Progress")

	arg_7_0.ptProgressImg = var_1.Find(var_7_26, "CircleProgress/ProgressImg")
	arg_7_0.ptProgressScaleLine = var_1:Find("CircleProgress/ScaleLine")
	arg_7_0.ptInfoPanel = var_1:Find("PT")

	local var_7_27 = arg_7_0.ptInfoPanel

	arg_7_0.ptProgressRedRightNumText = var_2.Find(var_7_27, "ProgressTextBG/PointRedText/RightNumText")

	local var_7_28 = arg_7_0.ptInfoPanel

	arg_7_0.ptProgressRedLeftNumText = var_2.Find(var_7_28, "ProgressTextBG/PointRedText/LeftNumText")

	local var_7_29 = arg_7_0.ptInfoPanel

	arg_7_0.ptProgressWhiteRightNumText = var_2.Find(var_7_29, "ProgressTextBG/PointText/RightNumText")

	local var_7_30 = arg_7_0.ptInfoPanel

	arg_7_0.ptProgressWhiteLeftNumText = var_2.Find(var_7_30, "ProgressTextBG/PointText/LeftNumText")

	local var_7_31 = arg_7_0.ptInfoPanel

	arg_7_0.ptIcon = var_2.Find(var_7_31, "PTProgressText/PTIcon")

	local var_7_32 = arg_7_0.ptInfoPanel

	arg_7_0.ptProgressRedText = var_2.Find(var_7_32, "PTProgressRedText")

	local var_7_33 = arg_7_0.ptInfoPanel

	arg_7_0.ptProgressWhiteText = var_2.Find(var_7_33, "PTProgressText")
	arg_7_0.storyInfoPanel = var_1:Find("Story")

	local var_7_34 = arg_7_0.storyInfoPanel
	local var_7_35 = var_2.Find(var_7_34, "TipText1")
	local var_7_36 = arg_7_0.storyInfoPanel
	local var_7_37 = var_3.Find(var_7_36, "TipText2")
	local var_7_38 = arg_7_0.storyInfoPanel

	arg_7_0.storyNameText = var_4.Find(var_7_38, "StroyNameText")
	arg_7_0.getShipBtn = var_1:Find("FinishBtn")

	local var_7_39 = arg_7_0.hidePanel

	arg_7_0.goGetPanel = var_4.Find(var_7_39, "GoGetPanel")

	local var_7_40 = arg_7_0.goGetPanel

	arg_7_0.goGetBtn = var_4.Find(var_7_40, "GoGetBtn")

	local var_7_41 = arg_7_0._tf

	arg_7_0.blurPanel = var_4.Find(var_7_41, "blur_panel")

	local var_7_42 = arg_7_0.blurPanel
	local var_7_43 = var_4.Find(var_7_42, "adapt")

	arg_7_0.backBtn = var_4.Find(var_7_43, "top/back")
	arg_7_0.helpBtn = var_4:Find("top/help")
	arg_7_0.toggleBtnsTF = var_4:Find("left/Btns")
	GetComponent = var_5
	arg_7_0.toggleGroupSC = var_5(arg_7_0.toggleBtnsTF, "ToggleGroup")
	arg_7_0.toggleGroupSC.allowSwitchOff = true

	local var_7_44 = arg_7_0.toggleList
	local var_7_45 = arg_7_0.toggleBtnsTF

	var_7_44[1] = var_6.Find(var_7_45, "Energy")

	local var_7_46 = arg_7_0.toggleList
	local var_7_47 = arg_7_0.toggleBtnsTF

	var_7_46[2] = var_6.Find(var_7_47, "Tactics")

	local var_7_48 = arg_7_0.toggleList
	local var_7_49 = arg_7_0.toggleBtnsTF

	var_7_48[3] = var_6.Find(var_7_49, "Repair")

	local var_7_50 = arg_7_0.toggleList
	local var_7_51 = arg_7_0.toggleBtnsTF

	var_7_50[4] = var_6.Find(var_7_51, "Syn")

	local var_7_52 = arg_7_0.toggleBtnsTF

	arg_7_0.synToggleLock = var_5.Find(var_7_52, "SynLock")

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.backBtn

	local function var_8_2()
		if arg_8_0.curPageIndex then
			local var_9_0 = arg_8_0

			var_1.enterMenuPage(var_9_0, false)

			local var_9_1 = arg_8_0

			var_1.emit(var_9_1, var_0_1.PAGES_EVENTS[arg_8_0.curPageIndex], nil, false)

			if var_0 == var_0_1.PAGES.REPAIR then
				local var_9_2 = arg_8_0

				var_1.backFromRepair(var_9_2)
			else
				local var_9_3 = arg_8_0

				var_1.backFromNotRepair(var_9_3)
			end
		else
			local var_9_4 = arg_8_0

			var_1.closeView(var_9_4)
		end

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.helpBtn

	local function var_8_5()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_10_2.type = var_2_10004
		pg = var_2_10004
		var_10_2.helps = var_2_10004.gametip.meta_help.tip

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10006)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.indexBtn

	local function var_8_8()
		local var_11_0 = arg_8_0

		var_0.openIndexLayer(var_11_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_6, var_8_7, var_8_8, var_1_10006)

	onButton = var_1_10001

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_0.goGetBtn

	local function var_8_11()
		local var_12_0 = arg_8_0
		local var_12_1 = var_0.getCurMetaProgressVO(var_12_0)
		local var_12_2 = var_0.isPassType(var_12_1)
		local var_12_3 = var_0:isBuildType()

		if var_12_2 then
			pg = var_12_1

			local var_12_4 = var_12_1.m02

			var_12_1 = var_12_1.sendNotification
			GAME = var_2_10006
			var_2_10006 = var_2_10006.GO_SCENE
			SCENE = var_2_10007

			var_12_1(var_12_4, var_2_10006, var_2_10007.CRUSING)
		elseif var_12_3 then
			pg = var_12_1

			local var_12_5 = var_12_1.m02
			local var_12_6 = var_3.sendNotification

			GAME = var_2_10006

			local var_12_7 = var_2_10006.GO_SCENE

			SCENE = var_2_10007

			local var_12_8 = var_2_10007.GETBOAT
			local var_12_9 = {}

			BuildShipScene = var_2_10009
			var_12_9.page = var_2_10009.PAGE_BUILD
			BuildShipScene = var_9
			var_12_9.projectName = var_9.PROJECTS.ACTIVITY

			var_12_6(var_12_5, var_12_7, var_12_8, var_12_9)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_9, var_8_10, var_8_11, var_1_10006)

	onButton = var_1_10001

	local var_8_12 = arg_8_0
	local var_8_13 = arg_8_0.ptPreviewBtn

	local function var_8_14()
		local var_13_0 = arg_8_0
		local var_13_1 = var_0.emit

		MetaCharacterMediator = var_2_10003

		local var_13_2 = var_2_10003.OPEN_PT_PREVIEW_LAYER
		local var_13_3 = arg_8_0

		var_13_1(var_13_0, var_13_2, var_4.getCurMetaProgressVO(var_13_3))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_12, var_8_13, var_8_14, var_1_10006)

	onButton = var_1_10001

	local var_8_15 = arg_8_0
	local var_8_16 = arg_8_0.ptGetBtn

	local function var_8_17()
		local var_14_0 = arg_8_0
		local var_14_1 = var_0.getCurMetaProgressVO(var_14_0)
		local var_14_2 = var_0.getMetaProgressPTState(var_14_1)

		MetaProgress = var_14_0

		local var_14_4

		if var_14_2 == var_14_0.STATE_CAN_AWARD then
			local var_14_3 = arg_8_0

			var_14_4, var_14_1 = var_14_4.getOneStepPTAwardLevelAndCount(var_14_3)
			pg = var_14_3

			local var_14_5 = var_14_3.m02
			local var_14_6 = var_4.sendNotification

			GAME = var_2_10007

			var_14_6(var_14_5, var_2_10007.GET_META_PT_AWARD, {
				groupID = var_0.id,
				targetCount = var_14_1
			})
		else
			MetaProgress = var_14_4

			local var_14_7

			if var_14_2 == var_14_4.STATE_LESS_PT then
				var_14_7 = false
				nowWorld = var_14_1

				if var_14_1() then
					local var_14_8 = var_3
					local var_14_9 = var_3.IsSystemOpen

					WorldConst = var_2_10007
					var_14_7 = var_14_9(var_14_8, var_2_10007.SystemWorldBoss)
				end

				local var_14_10 = var_14_7 and "meta_pt_notenough" or "meta_boss_unlock"

				pg = var_2_10005

				local var_14_11 = var_2_10005.TipsMgr.GetInstance()

				var_2_10005 = var_2_10005.ShowTips
				i18n = var_2_10008

				var_2_10005(var_14_11, var_2_10008(var_14_10))
			else
				MetaProgress = var_14_7

				if var_14_2 == var_14_7.STATE_LESS_STORY then
					pg = var_2

					local var_14_12 = var_2.TipsMgr.GetInstance()
					local var_14_13 = var_2.ShowTips

					i18n = var_2_10005

					var_14_13(var_14_12, var_2_10005("meta_story_lock"))
				end
			end
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_15, var_8_16, var_8_17, var_1_10006)

	onButton = var_1_10001

	local var_8_18 = arg_8_0
	local var_8_19 = arg_8_0.ptShowWayBtn

	local function var_8_20()
		local var_15_0 = false

		nowWorld = var_2_10001

		if var_2_10001() then
			local var_15_1 = var_1
			local var_15_2 = var_1.IsSystemOpen

			WorldConst = var_2_10005
			var_15_0 = var_15_2(var_15_1, var_2_10005.SystemWorldBoss)
		end

		local var_15_3 = var_15_0 and "meta_pt_notenough" or "meta_boss_unlock"

		pg = var_2_10003

		local var_15_4 = var_2_10003.TipsMgr.GetInstance()
		local var_15_5 = var_3.ShowTips

		i18n = var_2_10006

		var_15_5(var_15_4, var_2_10006(var_15_3))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_18, var_8_19, var_8_20, var_1_10006)

	onButton = var_1_10001

	local var_8_21 = arg_8_0
	local var_8_22 = arg_8_0.getShipBtn

	local function var_8_23()
		local var_16_0 = arg_8_0
		local var_16_1 = var_0.getCurMetaProgressVO(var_16_0).metaPtData
		local var_16_2, var_16_3 = var_1.GetResProgress(var_16_1)

		pg = var_16_1

		local var_16_4 = var_16_1.m02
		local var_16_5 = var_3.sendNotification

		GAME = var_2_10006

		var_16_5(var_16_4, var_2_10006.GET_META_PT_AWARD, {
			groupID = var_0.id,
			targetCount = var_16_3
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_21, var_8_22, var_8_23, var_1_10006)

	onButton = var_1_10001

	local var_8_24 = arg_8_0
	local var_8_25 = arg_8_0.synToggleLock

	local function var_8_26()
		pg = var_2_10000

		local var_17_0 = var_2_10000.TipsMgr.GetInstance()
		local var_17_1 = var_0.ShowTips

		i18n = var_2_10003

		var_17_1(var_17_0, var_2_10003("common_activity_end"))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_24, var_8_25, var_8_26, var_1_10006)

	onButton = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.synBtnLock, function()
		pg = var_2_10000

		local var_18_0 = var_2_10000.TipsMgr.GetInstance()
		local var_18_1 = var_0.ShowTips

		i18n = var_2_10003

		var_18_1(var_18_0, var_2_10003("common_activity_end"))

		return
	end)

	onButton = var_1_10001

	local var_8_27 = arg_8_0
	local var_8_28 = arg_8_0.repairBtn
	local var_8_29 = var_4.Find(var_8_28, "RepairBtn")

	local function var_8_30()
		local var_19_0 = arg_8_0

		var_0.switchPage(var_19_0, var_0_1.PAGES.REPAIR)

		return
	end

	SFX_PANEL = var_8_28

	var_1_10001(var_8_27, var_8_29, var_8_30, var_8_28)

	onButton = var_1_10001

	local var_8_31 = arg_8_0
	local var_8_32 = arg_8_0.energyBtn

	local function var_8_33()
		arg_8_0.isMainOpenLayerTag = true

		local var_20_0 = arg_8_0

		var_0.switchPage(var_20_0, var_0_1.PAGES.ENERGY)

		return
	end

	SFX_PANEL = var_8_28

	var_1_10001(var_8_31, var_8_32, var_8_33, var_8_28)

	onButton = var_1_10001

	local var_8_34 = arg_8_0
	local var_8_35 = arg_8_0.tacticsBtn

	local function var_8_36()
		arg_8_0.isMainOpenLayerTag = true

		local var_21_0 = arg_8_0

		var_0.switchPage(var_21_0, var_0_1.PAGES.TACTICS)

		return
	end

	SFX_PANEL = var_8_28

	var_1_10001(var_8_34, var_8_35, var_8_36, var_8_28)

	onButton = var_1_10001

	local var_8_37 = arg_8_0
	local var_8_38 = arg_8_0.synBtn

	local function var_8_39()
		isActive = var_2_10000

		if not var_2_10000(arg_8_0.synBtnLock) then
			arg_8_0.isMainOpenLayerTag = true

			local var_22_0 = arg_8_0

			var_0.switchPage(var_22_0, var_0_1.PAGES.SYN)
		end

		return
	end

	SFX_PANEL = var_8_28

	var_1_10001(var_8_37, var_8_38, var_8_39, var_8_28)

	ipairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(arg_8_0.toggleList) do
		onToggle = var_8_28

		var_8_28(arg_8_0, iter_8_1, function(arg_23_0)
			if arg_8_0.curPageIndex == iter_8_0 and arg_23_0 == true then
				return
			end

			local var_23_0 = arg_8_0
			local var_23_1 = var_1.getCurMetaProgressVO(var_23_0)
			local var_23_2 = var_1.getShip(var_23_1)

			if arg_8_0.curPageIndex == iter_8_0 and arg_23_0 == false then
				local var_23_3 = arg_8_0

				var_3.enterMenuPage(var_23_3, false)

				local var_23_4 = arg_8_0

				var_3.emit(var_23_4, var_0_1.PAGES_EVENTS[iter_8_0], var_23_2.id, false)
			end

			if arg_8_0.curPageIndex ~= iter_8_0 and arg_23_0 == true then
				local var_23_5 = arg_8_0

				var_3.enterMenuPage(var_23_5, true)

				arg_8_0.curPageIndex = iter_8_0

				local var_23_6 = arg_8_0

				var_3.emit(var_23_6, var_0_1.PAGES_EVENTS[iter_8_0], var_23_2.id, true)
			end

			return
		end)
	end

	return
end

function var_0_1.resetToggleList(arg_24_0)
	ipairs = var_1_10001

	for iter_24_0, iter_24_1 in var_1_10001(arg_24_0.toggleList) do
		setActive = var_1_10006

		var_1_10006(iter_24_1:Find("On"), false)

		setActive = var_1_10006

		var_1_10006(iter_24_1:Find("Off"), true)
	end

	return
end

function var_0_1.initMetaProgressList(arg_25_0)
	arg_25_0.metaProgressVOList = arg_25_0:getMetaProgressListForShow()

	arg_25_0:fillMetaProgressList()

	return
end

function var_0_1.fillMetaProgressList(arg_26_0)
	if #arg_26_0.metaProgressVOList < 5 then
		for iter_26_0 = #arg_26_0.metaProgressVOList + 1, 5 do
			table = var_1_10005

			var_1_10005.insert(arg_26_0.metaProgressVOList, false)
		end
	end

	return
end

function var_0_1.initBannerList(arg_27_0)
	UIItemList = var_1_10001
	arg_27_0.scrollUIItemList = var_1_10001.New(arg_27_0.bannerContainer, arg_27_0.bannerTpl)

	local var_27_0 = arg_27_0.scrollUIItemList

	var_1.make(var_27_0, function(arg_28_0, arg_28_1, arg_28_2)
		UIItemList = var_2_10003

		if arg_28_0 == var_2_10003.EventUpdate then
			table = var_3

			var_3.insert(arg_27_0.bannerTFList, arg_28_2)

			local var_28_0 = arg_27_0.metaProgressVOList[arg_28_1 + 1]
			local var_28_1 = arg_27_0

			var_4.updateBannerTF(var_28_1, var_28_0, arg_28_2, arg_28_1 + 1)
		end

		return
	end)

	return
end

function var_0_1.updateBannerTF(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_2
	local var_29_1 = arg_29_2:Find("ForScale")
	local var_29_2 = var_5.Find(var_29_1, "WillCome")
	local var_29_3 = var_5
	local var_29_4 = var_5.Find(var_29_3, "Empty")
	local var_29_5 = var_5
	local var_29_6 = var_5.Find(var_29_5, "Active")

	if arg_29_1 then
		var_29_3 = arg_29_1:isInAct()
		var_1_10012 = var_29_4
		var_29_5 = var_29_4.Find(var_1_10012, "ActType/Tag")

		local var_29_7 = var_29_4:Find("BuildType/Tag")

		var_1_10014 = var_29_6
		var_1_10012 = var_29_6.Find(var_1_10014, "ActType/Tag")

		local var_29_8 = var_29_6:Find("BuildType/Tag")

		setActive = var_1_10014

		var_1_10014(var_29_5, var_29_3)

		setActive = var_1_10014

		var_1_10014(var_29_7, var_29_3)

		setActive = var_1_10014

		var_1_10014(var_1_10012, var_29_3)

		setActive = var_1_10014

		var_1_10014(var_29_8, var_29_3)
	end

	if arg_29_1 then
		Ship = var_29_3
		var_29_3 = var_29_3.New

		local var_29_9 = {}

		tonumber = var_1_10012
		var_29_9.configId = var_1_10012(arg_29_1.configId .. 1)

		local var_29_10 = var_29_3(var_29_9)

		var_29_5 = var_29_3.getName(var_29_10)

		local var_29_11

		var_1_10014 = var_5

		local var_29_12 = var_5.Find(var_1_10014, "Empty/ActType/ShipNameMask/ShipNameText")

		setText = var_12

		var_12(var_29_12, var_29_5)

		setScrollText = var_12

		var_12(var_29_12, var_29_5)

		setActive = var_12

		var_12(var_29_12, true)

		var_1_10014 = var_5

		local var_29_13 = var_5.Find(var_1_10014, "Empty/BuildType/ShipNameMask/ShipNameText")

		setText = var_12

		var_12(var_29_13, var_29_5)

		setScrollText = var_12

		var_12(var_29_13, var_29_5)

		setActive = var_12

		var_12(var_29_13, true)

		var_1_10014 = var_5

		local var_29_14 = var_5.Find(var_1_10014, "Empty/PassType/ShipNameMask/ShipNameText")

		setText = var_12

		var_12(var_29_14, var_29_5)

		setScrollText = var_12

		var_12(var_29_14, var_29_5)

		setActive = var_12

		var_12(var_29_14, true)

		var_1_10014 = var_5

		local var_29_15 = var_5.Find(var_1_10014, "Active/ActType/ShipNameMask/ShipNameText")

		setText = var_12

		var_12(var_29_15, var_29_5)

		setScrollText = var_12

		var_12(var_29_15, var_29_5)

		setActive = var_12

		var_12(var_29_15, true)

		var_1_10014 = var_5

		local var_29_16 = var_5.Find(var_1_10014, "Active/BuildType/ShipNameMask/ShipNameText")

		setText = var_12

		var_12(var_29_16, var_29_5)

		setScrollText = var_12

		var_12(var_29_16, var_29_5)

		setActive = var_12

		var_12(var_29_16, true)

		var_1_10014 = var_5

		local var_29_17 = var_5.Find(var_1_10014, "Active/PassType/ShipNameMask/ShipNameText")

		setText = var_12

		var_12(var_29_17, var_29_5)

		setScrollText = var_12

		var_12(var_29_17, var_29_5)

		setActive = var_12

		var_12(var_29_17, true)
	end

	if arg_29_1 == false then
		setActive = var_29_3

		var_29_3(var_29_2, true)

		setActive = var_29_3

		var_29_3(var_29_4, false)

		setActive = var_29_3

		var_29_3(var_29_6, false)
	else
		setActive = var_29_3

		var_29_3(var_29_2, false)

		var_29_3 = arg_29_1:isUnlocked()
		setActive = var_29_5

		var_29_5(var_29_4, not var_29_3)

		setActive = var_29_5

		var_29_5(var_29_6, var_29_3)

		local var_29_18 = arg_29_1:isPtType()
		local var_29_19 = arg_29_1:isPassType()

		var_1_10014 = arg_29_1

		local var_29_20 = arg_29_1.isBuildType(var_1_10014)

		if not var_29_3 then
			local var_29_21 = var_5:Find("Empty/ActType")
			local var_29_22 = var_5

			var_1_10014 = var_5.Find(var_29_22, "Empty/BuildType")

			local var_29_23 = var_5:Find("Empty/PassType")

			setActive = var_29_22

			var_29_22(var_29_21, var_29_18)

			setActive = var_29_22

			var_29_22(var_1_10014, var_29_20)

			setActive = var_29_22

			var_29_22(var_29_23, var_29_19)

			local var_29_24 = arg_29_1
			local var_29_25, var_29_26 = arg_29_1.getBannerPathAndName(var_29_24)

			LoadSprite = var_29_24

			local var_29_27 = var_29_24(var_29_25, var_29_26)

			setImageSprite = var_29_28

			var_29_28(var_29_21, var_29_27)

			setImageSprite = var_29_28

			var_29_28(var_1_10014, var_29_27)

			setImageSprite = var_29_28

			var_29_28(var_29_23, var_29_27)

			local var_29_28

			if var_29_18 then
				var_29_28 = var_29_21:Find("NumText")
				string = var_20

				local var_29_29 = var_20.format("%d", arg_29_1:getSynRate() * 100) .. "%"

				setText = var_21

				var_21(var_29_28, var_29_29)

				local var_29_30 = var_29_21:Find("Slider")

				setSlider = var_1_10022

				var_1_10022(var_29_30, 0, 1, arg_29_1:getSynRate())

				setActive = var_1_10022

				var_1_10022(var_29_30, false)
			end

			pg = var_29_28

			local var_29_31 = var_29_28.ship_strengthen_meta[arg_29_1.configId].ship_id

			Ship = var_20

			local var_29_32 = var_20.New({
				configId = var_29_31
			})
			local var_29_33 = var_20.getMaxStar(var_29_32)

			var_1_10022 = var_20:getStar()

			local var_29_34 = var_5
			local var_29_35 = var_5.Find(var_29_34, "Empty/StarTpl")
			local var_29_36 = var_5:Find("Empty/Stars")

			UIItemList = var_29_34

			local var_29_37 = var_29_34.New(var_29_36, var_29_35)

			var_25.make(var_29_37, function(arg_30_0, arg_30_1, arg_30_2)
				UIItemList = var_2_10003

				if arg_30_0 == var_2_10003.EventUpdate then
					arg_30_1 = arg_30_1 + 1

					local var_30_0 = arg_30_2:Find("On")

					setActive = var_2_10004

					var_2_10004(var_30_0, arg_30_1 <= var_1_10022)
				end

				return
			end)
			var_25:align(var_29_33)
		else
			local var_29_38 = var_5:Find("Active/ActType")
			local var_29_39 = var_5

			var_1_10014 = var_5.Find(var_29_39, "Active/BuildType")

			local var_29_40 = var_5:Find("Active/PassType")

			setActive = var_29_39

			var_29_39(var_29_38, var_29_18)

			setActive = var_29_39

			var_29_39(var_1_10014, var_29_20)

			setActive = var_29_39

			var_29_39(var_29_40, var_29_19)

			local var_29_41 = arg_29_1
			local var_29_42, var_29_43 = arg_29_1.getBannerPathAndName(var_29_41)

			LoadSprite = var_29_41

			local var_29_44 = var_29_41(var_29_42, var_29_43)

			setImageSprite = var_19

			local var_29_45 = var_5:Find("Active")

			LoadSprite = var_1_10022

			var_19(var_29_45, var_1_10022(var_29_42, var_29_43))

			local var_29_46 = arg_29_1:getShip()
			local var_29_47 = var_19.getMetaCharacter(var_29_46)

			if var_29_18 then
				local var_29_48 = var_29_38:Find("NumText")

				string = var_29_46

				local var_29_49 = var_29_46.format("%d", var_29_47:getRepairRate() * 100) .. "%"

				setText = var_23

				var_23(var_29_48, var_29_49)

				local var_29_50 = var_29_38:Find("Slider")

				setSlider = var_24

				var_24(var_29_50, 0, 1, var_29_47:getRepairRate())

				setActive = var_24

				var_24(var_29_50, false)
			end

			local var_29_51 = var_19:getMaxStar()
			local var_29_52 = var_19:getStar()
			local var_29_53 = var_5
			local var_29_54 = var_5.Find(var_29_53, "Active/StarTpl")
			local var_29_55 = var_5:Find("Active/Stars")

			UIItemList = var_29_53

			local var_29_56 = var_29_53.New(var_29_55, var_29_54)

			var_25.make(var_29_56, function(arg_31_0, arg_31_1, arg_31_2)
				UIItemList = var_2_10003

				if arg_31_0 == var_2_10003.EventUpdate then
					arg_31_1 = arg_31_1 + 1

					local var_31_0 = arg_31_2:Find("On")

					setActive = var_2_10004

					var_2_10004(var_31_0, arg_31_1 <= var_29_52)
				end

				return
			end)
			var_25:align(var_29_51)
		end
	end

	onButton = var_29_3

	local var_29_57 = arg_29_0
	local var_29_58 = var_29_0

	local function var_29_59()
		if arg_29_0.curMetaIndex ~= arg_29_3 then
			if arg_29_0.curMetaIndex and arg_29_0.curMetaIndex > 0 then
				local var_32_0 = arg_29_0

				var_0.changeBannerOnClick(var_32_0, arg_29_0.bannerTFList[arg_29_0.curMetaIndex], false)
			end

			arg_29_0.curMetaIndex = arg_29_3

			local var_32_1 = arg_29_0

			var_0.changeBannerOnClick(var_32_1, var_29_0, true)

			local var_32_2 = arg_29_0

			var_0.updateMain(var_32_2)
		end

		return
	end

	SFX_PANEL = var_1_10014

	var_29_3(var_29_57, var_29_58, var_29_59, var_1_10014)

	if arg_29_1 == false then
		setButtonEnabled = var_29_3

		var_29_3(var_29_0, false)
	else
		setButtonEnabled = var_29_3

		var_29_3(var_29_0, true)
	end

	return
end

function var_0_1.changeBannerOnClick(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1
	local var_33_1 = arg_33_1.GetComponent(var_33_0, "LayoutElement")
	local var_33_2 = arg_33_1
	local var_33_3 = arg_33_1.Find(var_33_2, "ForScale")

	if arg_33_2 == true then
		setLocalScale = var_33_0

		var_33_0(var_33_3, var_0_1.SCALE_ON_PITCH)

		var_33_1.preferredWidth = 338.3
		var_33_1.preferredHeight = 102
	else
		setLocalScale = var_33_0

		local var_33_4 = var_33_3

		Vector2 = var_1_10008

		var_33_0(var_33_4, var_1_10008.one)

		var_33_1.preferredWidth = 199
		var_33_1.preferredHeight = 60
	end

	local var_33_5 = var_33_3:Find("SelectedTag")

	setActive = var_33_2

	var_33_2(var_33_5, arg_33_2)

	return
end

function var_0_1.updateBannerShipName(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1
	local var_34_1 = arg_34_1.Find(var_34_0, "ForScale")
	local var_34_2 = var_2.Find(var_34_1, "SelectedTag")

	isActive = var_34_0

	local var_34_3 = var_34_0(var_34_2)
	local var_34_4
	local var_34_5 = var_2:Find("Empty/ActType/ShipNameText")

	setActive = var_6

	var_6(var_34_5, var_34_3)

	local var_34_6 = var_2:Find("Empty/BuildType/ShipNameText")

	setActive = var_6

	var_6(var_34_6, var_34_3)

	local var_34_7 = var_2:Find("Active/ActType/ShipNameText")

	setActive = var_6

	var_6(var_34_7, var_34_3)

	local var_34_8 = var_2:Find("Active/BuildType/ShipNameText")

	setActive = var_6

	var_6(var_34_8, var_34_3)

	local var_34_9
	local var_34_10 = var_2:Find("Empty/ActType/TipText")

	setActive = var_7

	var_7(var_34_10, not var_34_3)

	local var_34_11 = var_2:Find("Empty/BuildType/TipText")

	setActive = var_7

	var_7(var_34_11, not var_34_3)

	local var_34_12 = var_2:Find("Active/ActType/Text")

	setActive = var_7

	var_7(var_34_12, not var_34_3)

	local var_34_13 = var_2:Find("Active/BuildType/Text")

	setActive = var_7

	var_7(var_34_13, not var_34_3)

	return
end

function var_0_1.updateBannerUIList(arg_35_0)
	arg_35_0.bannerTFList = {}

	local var_35_0 = arg_35_0.scrollUIItemList

	var_1.align(var_35_0, #arg_35_0.metaProgressVOList)

	return
end

function var_0_1.updateStart(arg_36_0)
	local var_36_0 = false

	ipairs = var_1_10002

	for iter_36_0, iter_36_1 in var_1_10002(arg_36_0.metaProgressVOList) do
		if iter_36_1 ~= false then
			var_36_0 = true

			break
		end
	end

	local var_36_1 = arg_36_0.indexBtn
	local var_36_2 = var_2.Find(var_36_1, "On")

	setActive = var_3

	var_3(var_36_2, not arg_36_0:isDefaultStatus())

	setActive = var_3

	var_3(arg_36_0.noCharTF, not var_36_0)

	setActive = var_3

	var_3(arg_36_0.hidePanel, var_36_0)

	if not var_36_0 then
		return
	end

	arg_36_0:resetBannerListScale()
	arg_36_0:updateBannerUIList()

	arg_36_0.curMetaIndex = nil

	if var_36_0 then
		triggerButton = var_3

		var_3(arg_36_0.bannerTFList[1])
	end

	return
end

function var_0_1.resetBannerListScale(arg_37_0)
	ipairs = var_1_10001

	for iter_37_0, iter_37_1 in var_1_10001(arg_37_0.bannerTFList) do
		local var_37_0 = iter_37_1
		local var_37_1 = iter_37_1.GetComponent(var_37_0, "LayoutElement")
		local var_37_2

		var_37_2, setLocalScale = iter_37_1:Find("ForScale"), var_37_0
		Vector2 = var_1_10011

		var_37_0(var_37_2, var_1_10011.one)

		var_37_1.preferredWidth = 199
		var_37_1.preferredHeight = 60
	end

	return
end

function var_0_1.updateMain(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0
	local var_38_1 = arg_38_0.getCurMetaProgressVO(var_38_0)
	local var_38_2 = var_2.isUnlocked(var_38_1)

	setActive = var_38_0

	var_38_0(arg_38_0.menuPanel, var_38_2)

	setActive = var_38_0

	var_38_0(arg_38_0.ptPanel, not var_38_2)

	setActive = var_38_0

	var_38_0(arg_38_0.goGetPanel, not var_38_2)
	arg_38_0:updateActTimePanel()

	if not var_38_2 then
		local var_38_3 = var_2:isPtType()
		local var_38_4 = var_2
		local var_38_5 = var_2.isPassType(var_38_4)
		local var_38_6 = var_2:isBuildType()

		setActive = var_38_4

		var_38_4(arg_38_0.ptPanel, var_38_3)

		setActive = var_38_4

		var_38_4(arg_38_0.goGetPanel, var_38_5 or var_38_6)

		if var_38_3 then
			var_1_10009 = arg_38_0

			arg_38_0.updatePTPanel(var_1_10009, arg_38_1)
		end
	else
		arg_38_0:TryPlayGuide()
	end

	arg_38_0:updateRedPoints()

	local var_38_7 = var_2
	local var_38_8, var_38_9 = var_2.getPaintPathAndName(var_38_7)

	setImageSprite = var_38_7

	local var_38_10 = arg_38_0.shipImg

	LoadSprite = var_1_10009

	var_38_7(var_38_10, var_1_10009(var_38_8, var_38_9), true)

	local var_38_11, var_38_12 = var_2:getBGNamePathAndName()
	local var_38_13 = var_38_12
	local var_38_14 = var_38_11

	setImageSprite = var_38_11

	local var_38_15 = arg_38_0.shipNameImg

	LoadSprite = var_9

	var_38_11(var_38_15, var_9(var_38_14, var_38_13), true)

	local var_38_16 = var_2.id

	MetaCharacterConst = var_38_12

	local var_38_17 = var_38_12.UIConfig[var_38_16]

	setLocalPosition = var_38_15

	var_38_15(arg_38_0.shipImg, {
		x = var_38_17[1],
		y = var_38_17[2]
	})

	setLocalScale = var_38_15

	var_38_15(arg_38_0.shipImg, {
		x = var_38_17[3],
		y = var_38_17[4]
	})

	return
end

function var_0_1.TryPlayGuide(arg_39_0)
	pg = var_1_10001

	local var_39_0 = var_1_10001.SystemGuideMgr.GetInstance()

	var_1.PlayByGuideId(var_39_0, "NG0024")

	return
end

function var_0_1.updateActTimePanel(arg_40_0)
	local var_40_0 = arg_40_0:getCurMetaProgressVO()
	local var_40_1 = var_1.isUnlocked(var_40_0)
	local var_40_2 = var_1:isInAct()

	setActive = var_40_0

	var_40_0(arg_40_0.actTimePanel, not var_40_1 and var_40_2)

	setActive = var_40_0

	var_40_0(arg_40_0.synBtnLimitTimeTF, var_40_2)

	if var_40_2 then
		local var_40_3 = var_1.timeConfig[1][1]
		local var_40_4 = var_1.timeConfig[2][1]
		local var_40_5 = "%d.%d.%d-%d.%d.%d"

		string = var_7

		local var_40_6 = var_7.format(var_40_5, var_40_3[1], var_40_3[2], var_40_3[3], var_40_4[1], var_40_4[2], var_40_4[3])

		setText = var_7

		var_7(arg_40_0.actTimeText, var_40_6)

		pg = var_7

		local var_40_7 = var_7.TimeMgr.GetInstance()
		local var_40_8 = var_7.parseTimeFromConfig(var_40_7, var_1.timeConfig[2])

		pg = var_1_10008

		local var_40_9 = var_1_10008.TimeMgr.GetInstance()
		local var_40_10 = var_8.GetServerTime(var_40_9)

		pg = var_40_7

		local var_40_11 = var_40_7.TimeMgr.GetInstance()
		local var_40_12 = var_9.DiffDay(var_40_11, var_40_10, var_40_8)
		local var_40_13 = arg_40_0.synBtnLimitTimeTF
		local var_40_14

		var_40_14, setText = var_10.Find(var_40_13, "Text"), var_40_11
		i18n = var_14

		var_40_11(var_40_14, var_14("meta_pt_left", var_40_12))
	end

	return
end

function var_0_1.updatePTPanel(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:getCurMetaProgressVO()
	local var_41_1 = var_2.getSynRate(var_41_0) * 100

	tonumber = var_41_0
	tostring = var_1_10007

	local var_41_2 = var_41_0(var_1_10007(var_41_1))

	setImageSprite = var_5

	local var_41_3 = arg_41_0.ptIcon

	LoadSprite = var_1_10008

	var_5(var_41_3, var_1_10008(var_2:getPtIconPath()))

	setFillAmount = var_5

	var_5(arg_41_0.ptProgressImg, var_3)

	setActive = var_5

	var_5(arg_41_0.ptProgressScaleLine, var_3 < 1)

	local var_41_4 = arg_41_0.ptProgressScaleLine

	Vector3 = var_1_10006
	var_41_4.localEulerAngles = var_1_10006(0, 0, 24 * var_3)
	string = var_41_4

	local var_41_5 = var_41_4.format("%d", var_41_2)

	math = var_6

	local var_41_6 = (var_41_2 - var_6.floor(var_41_2)) * 100 == 0

	string = var_7

	local var_41_7 = var_7.format
	local var_41_8 = "%2d"

	math = var_10

	local var_41_9 = var_41_7(var_41_8, (var_41_2 - var_10.floor(var_41_2)) * 100)

	var_41_9 = var_41_6 and var_41_9 .. "0%" or var_41_9 .. "%"
	setText = var_8

	var_8(arg_41_0.ptProgressRedLeftNumText, var_41_5)

	setText = var_8

	var_8(arg_41_0.ptProgressWhiteLeftNumText, var_41_5)

	setText = var_8

	var_8(arg_41_0.ptProgressRedRightNumText, var_41_9)

	setText = var_8

	var_8(arg_41_0.ptProgressWhiteRightNumText, var_41_9)

	local var_41_10 = var_2.metaPtData
	local var_41_11, var_41_12, var_41_13 = var_8.GetResProgress(var_41_10)

	setText = var_11

	local var_41_14 = arg_41_0.ptProgressRedText

	if 1 <= var_41_13 then
		setColorStr = var_41_17

		local var_41_15 = var_41_11

		COLOR_GREEN = var_1_10017

		local var_41_17

		if not var_41_17(var_41_15, var_1_10017) then
			setColorStr = var_41_17

			local var_41_16 = var_41_11

			COLOR_RED = var_1_10017
			var_41_17 = var_41_17(var_41_16, var_1_10017)
		end

		var_11(var_41_14, var_41_17 .. "/" .. var_41_12)

		setText = var_11

		local var_41_18 = arg_41_0.ptProgressWhiteText

		if 1 <= var_41_13 then
			setColorStr = var_41_21

			local var_41_19 = var_41_11

			COLOR_GREEN = var_1_10017

			local var_41_21

			if not var_41_21(var_41_19, var_1_10017) then
				setColorStr = var_41_21

				local var_41_20 = var_41_11

				COLOR_RED = var_1_10017
				var_41_21 = var_41_21(var_41_20, var_1_10017)
			end

			var_11(var_41_18, var_41_21 .. "/" .. var_41_12)

			local var_41_22 = var_2
			local var_41_23 = var_2.getMetaProgressPTState(var_41_22)

			MetaProgress = var_12

			if var_41_23 == var_12.STATE_CAN_FINISH then
				setActive = var_12

				var_12(arg_41_0.ptRedBarImg, true)

				setActive = var_12

				var_12(arg_41_0.ptPreviewBtn, false)

				setActive = var_12

				var_12(arg_41_0.ptGetBtn, false)

				setActive = var_12

				var_12(arg_41_0.ptShowWayBtn, false)

				setActive = var_12

				var_12(arg_41_0.ptInfoPanel, false)

				setActive = var_12

				var_12(arg_41_0.storyInfoPanel, false)

				setActive = var_12

				var_12(arg_41_0.getShipBtn, true)
			else
				MetaProgress = var_12

				if var_41_23 == var_12.STATE_CAN_AWARD then
					setActive = var_12

					var_12(arg_41_0.ptRedBarImg, false)

					setActive = var_12

					var_12(arg_41_0.ptPreviewBtn, true)

					setActive = var_12

					var_12(arg_41_0.ptGetBtn, true)

					setActive = var_12

					var_12(arg_41_0.ptShowWayBtn, false)

					setActive = var_12

					var_12(arg_41_0.ptGetBtnTag, true)

					setActive = var_12

					var_12(arg_41_0.ptInfoPanel, true)

					setActive = var_12

					var_12(arg_41_0.storyInfoPanel, false)

					setActive = var_12

					var_12(arg_41_0.getShipBtn, false)

					setImageAlpha = var_12

					var_12(arg_41_0.ptPreviewBtn, 0)

					setImageAlpha = var_12

					var_12(arg_41_0.ptGetBtn, 0)

					setImageAlpha = var_12

					var_12(arg_41_0.ptGetBtnTag, 0)

					setImageAlpha = var_12

					var_12(arg_41_0.ptShowWayBtn, 0)
				else
					MetaProgress = var_12

					local var_41_24

					if var_41_23 == var_12.STATE_LESS_STORY then
						setActive = var_41_24

						var_41_24(arg_41_0.ptRedBarImg, true)

						setActive = var_41_24

						var_41_24(arg_41_0.ptPreviewBtn, true)

						setActive = var_41_24

						var_41_24(arg_41_0.ptGetBtn, true)

						setActive = var_41_24

						var_41_24(arg_41_0.ptShowWayBtn, false)

						setActive = var_41_24

						var_41_24(arg_41_0.ptGetBtnTag, false)

						setActive = var_41_24

						var_41_24(arg_41_0.ptInfoPanel, false)

						setActive = var_41_24

						var_41_24(arg_41_0.storyInfoPanel, true)

						setActive = var_41_24

						var_41_24(arg_41_0.getShipBtn, false)

						var_41_24 = var_2:getCurLevelStoryName()
						setText = var_41_22

						var_41_22(arg_41_0.storyNameText, var_41_24)
					else
						MetaProgress = var_41_24

						if var_41_23 == var_41_24.STATE_LESS_PT then
							setActive = var_12

							var_12(arg_41_0.ptRedBarImg, false)

							setActive = var_12

							var_12(arg_41_0.ptPreviewBtn, true)

							setActive = var_12

							var_12(arg_41_0.ptGetBtn, false)

							setActive = var_12

							var_12(arg_41_0.ptShowWayBtn, true)

							setActive = var_12

							var_12(arg_41_0.ptGetBtnTag, false)

							setActive = var_12

							var_12(arg_41_0.ptInfoPanel, true)

							setActive = var_12

							var_12(arg_41_0.storyInfoPanel, false)

							setActive = var_12

							var_12(arg_41_0.getShipBtn, false)

							setImageAlpha = var_12

							var_12(arg_41_0.ptPreviewBtn, 0)

							setImageAlpha = var_12

							var_12(arg_41_0.ptGetBtn, 0)

							setImageAlpha = var_12

							var_12(arg_41_0.ptShowWayBtn, 0)
						end
					end
				end
			end

			if 0 < var_3 and not arg_41_1 then
				MetaProgress = var_41_25

				if var_41_23 ~= var_41_25.STATE_CAN_AWARD then
					MetaProgress = var_41_25

					if var_41_23 == var_41_25.STATE_LESS_PT then
						math = var_41_25

						local var_41_25 = var_41_25.min(var_3, 1)
						local var_41_26 = arg_41_0
						local var_41_27 = arg_41_0.managedTween

						LeanTween = var_16

						local var_41_28 = var_16.value
						local var_41_29

						go = var_1_10018

						local var_41_30 = var_41_27(var_41_26, var_41_28, var_41_29, var_1_10018(arg_41_0.ptPanel), 0, var_3, var_41_25)
						local var_41_31 = var_13.setOnUpdate

						System = var_41_28

						local var_41_32 = var_41_31(var_41_30, var_41_28.Action_float(function(arg_42_0)
							setFillAmount = var_2_10001

							var_2_10001(arg_41_0.ptProgressImg, arg_42_0)

							setActive = var_2_10001

							var_2_10001(arg_41_0.ptProgressScaleLine, arg_42_0 < 1)

							local var_42_0 = arg_41_0.ptProgressScaleLine

							Vector3 = var_2_10002
							var_42_0.localEulerAngles = var_2_10002(0, 0, 24 * arg_42_0)

							local var_42_1 = arg_42_0 * 100

							string = var_2

							local var_42_2 = var_2.format("%d", var_42_1)

							math = var_3

							local var_42_3 = (var_42_1 - var_3.floor(var_42_1)) * 100 == 0

							string = var_4

							local var_42_4 = var_4.format
							local var_42_5 = "%2d"

							math = var_2_10007

							local var_42_6 = var_42_4(var_42_5, (var_42_1 - var_2_10007.floor(var_42_1)) * 100)

							var_42_6 = var_42_3 and var_42_6 .. "0%" or var_42_6 .. "%"
							setText = var_5

							var_5(arg_41_0.ptProgressRedLeftNumText, var_42_2)

							setText = var_5

							var_5(arg_41_0.ptProgressWhiteLeftNumText, var_42_2)

							setText = var_5

							var_5(arg_41_0.ptProgressRedRightNumText, var_42_6)

							setText = var_5

							var_5(arg_41_0.ptProgressWhiteRightNumText, var_42_6)

							return
						end))
						local var_41_33 = var_13.setOnComplete

						System = var_16

						var_41_33(var_41_32, var_16.Action(function()
							setFillAmount = var_2_10000

							var_2_10000(arg_41_0.ptProgressImg, var_0)

							setActive = var_2_10000

							var_2_10000(arg_41_0.ptProgressScaleLine, var_0 < 1)

							local var_43_0 = arg_41_0.ptProgressScaleLine

							Vector3 = var_2_10001
							var_43_0.localEulerAngles = var_2_10001(0, 0, 24 * var_0)
							string = var_43_0

							local var_43_1 = var_43_0.format("%d", var_41_2)
							local var_43_2 = var_41_2

							math = var_2

							local var_43_3 = (var_43_2 - var_2.floor(var_41_2)) * 100 == 0

							string = var_2

							local var_43_4 = var_2.format
							local var_43_5 = "%2d"
							local var_43_6 = var_41_2

							math = var_2_10006

							local var_43_7 = var_43_4(var_43_5, (var_43_6 - var_2_10006.floor(var_41_2)) * 100)

							var_43_7 = var_43_3 and var_43_7 .. "0%" or var_43_7 .. "%"
							setText = var_3

							var_3(arg_41_0.ptProgressRedLeftNumText, var_43_1)

							setText = var_3

							var_3(arg_41_0.ptProgressWhiteLeftNumText, var_43_1)

							setText = var_3

							var_3(arg_41_0.ptProgressRedRightNumText, var_43_7)

							setText = var_3

							var_3(arg_41_0.ptProgressWhiteRightNumText, var_43_7)

							local var_43_8 = arg_41_0
							local var_43_9 = var_3.managedTween

							LeanTween = var_6

							local var_43_10 = var_6.value
							local var_43_11

							go = var_8

							local var_43_12 = var_43_9(var_43_8, var_43_10, var_43_11, var_8(arg_41_0.ptPanel), 0, 1, var_41_25 / 2)
							local var_43_13 = var_3.setOnUpdate

							System = var_43_10

							local var_43_14 = var_43_13(var_43_12, var_43_10.Action_float(function(arg_44_0)
								setImageAlpha = var_3_10001

								var_3_10001(arg_41_0.ptPreviewBtn, arg_44_0)

								setImageAlpha = var_3_10001

								var_3_10001(arg_41_0.ptGetBtn, arg_44_0)

								setImageAlpha = var_3_10001

								var_3_10001(arg_41_0.ptGetBtnTag, arg_44_0)

								setImageAlpha = var_3_10001

								var_3_10001(arg_41_0.ptShowWayBtn, arg_44_0)

								return
							end))
							local var_43_15 = var_3.setOnComplete

							System = var_6

							var_43_15(var_43_14, var_6.Action(function()
								setImageAlpha = var_3_10000

								var_3_10000(arg_41_0.ptPreviewBtn, 1)

								setImageAlpha = var_3_10000

								var_3_10000(arg_41_0.ptGetBtn, 1)

								setImageAlpha = var_3_10000

								var_3_10000(arg_41_0.ptGetBtnTag, 1)

								setImageAlpha = var_3_10000

								var_3_10000(arg_41_0.ptShowWayBtn, 1)

								return
							end))

							return
						end))

						goto label_41_0

						setImageAlpha = var_41_25

						var_41_25(arg_41_0.ptPreviewBtn, 1)

						setImageAlpha = var_41_25

						var_41_25(arg_41_0.ptGetBtn, 1)

						setImageAlpha = var_41_25

						var_41_25(arg_41_0.ptGetBtnTag, 1)

						setImageAlpha = var_41_25

						var_41_25(arg_41_0.ptShowWayBtn, 1)
					end

					::label_41_0::

					return
				end
			end
		end
	end
end

function var_0_1.updateRedPoints(arg_46_0)
	local var_46_0 = arg_46_0
	local var_46_1 = arg_46_0.getCurMetaProgressVO(var_46_0).id

	MetaCharacterConst = var_46_0

	local var_46_2 = var_46_0.isMetaRepairRedTag(var_46_1)

	setActive = var_1_10004

	local var_46_3 = arg_46_0.repairBtn

	var_1_10004(var_6.Find(var_46_3, "RepairBtn/Tag"), var_46_2)

	MetaCharacterConst = var_1_10004

	local var_46_4 = not var_1_10004.filteMetaRepairAble(var_1)

	setActive = var_5

	local var_46_5 = arg_46_0.repairBtn

	var_5(var_7.Find(var_46_5, "Finish"), var_46_4)

	MetaCharacterConst = var_5

	local var_46_6 = var_5.isMetaEnergyRedTag(var_46_1)

	setActive = var_6

	local var_46_7 = arg_46_0.energyBtn

	var_6(var_8.Find(var_46_7, "Tag"), var_46_6)

	MetaCharacterConst = var_6

	local var_46_8 = not var_6.filteMetaEnergyAble(var_1)

	setActive = var_7

	local var_46_9 = arg_46_0.energyBtn

	var_7(var_9.Find(var_46_9, "Finish"), var_46_8)

	MetaCharacterConst = var_7

	local var_46_10 = not var_7.filteMetaTacticsAble(var_1)

	setActive = var_8

	local var_46_11 = arg_46_0.tacticsBtn

	var_8(var_10.Find(var_46_11, "Finish"), var_46_10)

	MetaCharacterConst = var_8

	local var_46_12 = var_8.isMetaTacticsRedTag(var_46_1)
	local var_46_15

	if var_1.metaShipVO then
		local var_46_13 = arg_46_0.metaCharacterProxy
		local var_46_14 = var_46_15.getMetaTacticsInfoByShipID(var_46_13, var_9.id)

		var_46_15 = var_46_15.getTacticsStateForShow(var_46_14)
		setActive = var_11
		var_1_10015 = arg_46_0.tacticsBtn

		var_11(var_13.Find(var_1_10015, "Tag"), false)

		setActive = var_11
		var_1_10015 = arg_46_0.tacticsBtn

		local var_46_16 = var_13.Find(var_1_10015, "Learnable")

		MetaTacticsInfo = var_14

		var_11(var_46_16, var_46_15 == var_14.States.LearnAble)

		setActive = var_11
		var_1_10015 = arg_46_0.tacticsBtn

		local var_46_17 = var_13.Find(var_1_10015, "Learning")

		MetaTacticsInfo = var_14

		var_11(var_46_17, var_46_15 == var_14.States.Learning)

		setActive = var_11
		var_1_10015 = arg_46_0.tacticsBtn

		local var_46_18 = var_13.Find(var_1_10015, "LearnFinish")

		MetaTacticsInfo = var_14

		var_11(var_46_18, var_46_15 == var_14.States.LearnFinished and var_46_12)
	else
		setActive = var_46_15

		local var_46_19 = arg_46_0.tacticsBtn

		var_46_15(var_12.Find(var_46_19, "Tag"), false)

		setActive = var_46_15

		local var_46_20 = arg_46_0.tacticsBtn

		var_46_15(var_12.Find(var_46_20, "Learnable"), false)

		setActive = var_46_15

		local var_46_21 = arg_46_0.tacticsBtn

		var_46_15(var_12.Find(var_46_21, "Learning"), false)

		setActive = var_46_15

		local var_46_22 = arg_46_0.tacticsBtn

		var_46_15(var_12.Find(var_46_22, "LearnFinish"), false)
	end

	local var_46_23 = var_1:isPtType()
	local var_46_24 = var_1:isInAct()
	local var_46_25 = var_1
	local var_46_26 = var_1.isInArchive(var_46_25)
	local var_46_27 = var_46_23

	setActive = var_46_25

	var_46_25(arg_46_0.synDecorateTF, var_46_27)

	setActive = var_46_25

	var_46_25(arg_46_0.synBtn, var_46_23)

	setActive = var_46_25

	var_46_25(arg_46_0.synBtnLock, var_46_23 and not var_46_24 and not var_46_26)

	setActive = var_46_25

	var_46_25(arg_46_0.toggleList[4], var_46_23)

	setActive = var_46_25

	var_46_25(arg_46_0.synToggleLock, var_46_23 and not var_46_24 and not var_46_26)

	local var_46_28

	if var_46_27 then
		MetaCharacterConst = var_1_10015
		var_46_28 = var_1_10015.isMetaSynRedTag(var_46_1)
		setActive = var_1_10015

		local var_46_29 = arg_46_0.synBtn

		var_1_10015(var_17.Find(var_46_29, "Tag"), var_46_28)
	end

	MetaCharacterConst = var_1_10015

	local var_46_30 = not var_1_10015.filteMetaSynAble(var_1)

	setActive = var_16

	local var_46_31 = arg_46_0.synBtn

	var_16(var_18.Find(var_46_31, "Finish"), var_46_30)

	setActive = var_16

	local var_46_32 = arg_46_0.toggleList[var_0_1.PAGES.REPAIR]

	var_16(var_18.Find(var_46_32, "Tip"), var_46_2)

	setActive = var_16

	local var_46_33 = arg_46_0.toggleList[var_0_1.PAGES.ENERGY]

	var_16(var_18.Find(var_46_33, "Tip"), var_46_6)

	setActive = var_16

	local var_46_34 = arg_46_0.toggleList[var_0_1.PAGES.TACTICS]

	var_16(var_18.Find(var_46_34, "Tip"), var_46_12)

	setActive = var_16

	local var_46_35 = arg_46_0.toggleList[var_0_1.PAGES.SYN]

	var_16(var_18.Find(var_46_35, "Tip"), var_46_28)

	ipairs = var_16

	for iter_46_0, iter_46_1 in var_16(arg_46_0.metaProgressVOList) do
		local var_46_36 = arg_46_0.bannerTFList[iter_46_0]
		local var_46_37 = var_21.Find(var_46_36, "ForScale/RedPoint")

		if iter_46_1 then
			setActive = var_1_10023

			local var_46_38 = var_46_37

			MetaCharacterConst = var_1_10026

			var_1_10023(var_46_38, var_1_10026.isMetaBannerRedPoint(iter_46_1.id))
		else
			setActive = var_1_10023

			var_1_10023(var_46_37, false)
		end
	end

	return
end

function var_0_1.getCurMetaProgressVO(arg_47_0)
	local var_47_0 = arg_47_0.curMetaIndex

	return arg_47_0.metaProgressVOList[var_47_0]
end

function var_0_1.refreshBannerTF(arg_48_0)
	local var_48_0 = arg_48_0:getCurMetaProgressVO()
	local var_48_1 = arg_48_0.bannerTFList[arg_48_0.curMetaIndex]

	arg_48_0:updateBannerTF(var_48_0, var_48_1, arg_48_0.curMetaIndex)

	return
end

function var_0_1.enterMenuPage(arg_49_0, arg_49_1)
	setActive = var_1_10002

	var_1_10002(arg_49_0.hidePanel, not arg_49_1)

	setActive = var_1_10002

	var_1_10002(arg_49_0.indexBtn, not arg_49_1)

	setActive = var_1_10002

	var_1_10002(arg_49_0.toggleBtnsTF, arg_49_1)

	arg_49_0.toggleGroupSC.allowSwitchOff = not arg_49_1

	return
end

function var_0_1.switchPage(arg_50_0, arg_50_1)
	if not arg_50_0.curPageIndex then
		setActive = var_2

		var_2(arg_50_0.toggleBtnsTF, true)

		triggerToggle = var_2

		var_2(arg_50_0.toggleList[arg_50_1], true)
	end

	return
end

function var_0_1.backFromRepair(arg_51_0)
	setActive = var_1_10001

	var_1_10001(arg_51_0.menuPanel, false)

	local var_51_0 = arg_51_0
	local var_51_1 = arg_51_0.managedTween

	LeanTween = var_4

	local var_51_2 = var_51_1(var_51_0, var_4.alpha, nil, arg_51_0.shipImg, 1, 0.3)
	local var_51_3 = var_1.setFrom(var_51_2, 0)
	local var_51_4 = var_1.setOnComplete

	System = var_4

	var_51_4(var_51_3, var_4.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_51_0.menuPanel, true)

		setActive = var_2_10000

		var_2_10000(arg_51_0.hidePanel, true)

		return
	end))

	return
end

function var_0_1.backFromNotRepair(arg_53_0)
	local var_53_0 = arg_53_0
	local var_53_1 = arg_53_0.getCurMetaProgressVO(var_53_0).id

	MetaCharacterConst = var_1_10002

	local var_53_2 = var_1_10002.UIConfig[var_53_1]

	setActive = var_53_0

	var_53_0(arg_53_0.menuPanel, false)

	local var_53_3 = -250
	local var_53_4 = var_53_2[1]
	local var_53_5 = arg_53_0
	local var_53_6 = arg_53_0.managedTween

	LeanTween = var_1_10008

	local var_53_7 = var_1_10008.moveX
	local var_53_8

	rtf = var_1_10010

	local var_53_9 = var_53_6(var_53_5, var_53_7, var_53_8, var_1_10010(arg_53_0.shipImg), var_53_4, 0.3)
	local var_53_10 = var_5.setFrom(var_53_9, var_53_3)
	local var_53_11 = var_5.setOnComplete

	System = var_8

	var_53_11(var_53_10, var_8.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_53_0.menuPanel, true)

		setActive = var_2_10000

		var_2_10000(arg_53_0.hidePanel, true)

		return
	end))

	return
end

function var_0_1.autoOpenFunc(arg_55_0)
	if arg_55_0.contextData.autoOpenShipConfigID then
		MetaCharacterConst = var_1

		local var_55_0 = var_1.GetMetaShipGroupIDByConfigID(arg_55_0.contextData.autoOpenShipConfigID)
		local var_55_1 = arg_55_0
		local var_55_2 = arg_55_0.getMetaProgressListForShow(var_55_1)
		local var_55_3 = 0

		ipairs = var_55_1

		for iter_55_0, iter_55_1 in var_55_1(var_55_2) do
			if iter_55_1 and iter_55_1.id == var_55_0 then
				triggerButton = var_9

				var_9(arg_55_0.bannerTFList[iter_55_0])

				arg_55_0.contextData.autoOpenShipConfigID = nil
			end
		end
	end

	if arg_55_0.contextData.autoOpenTactics then
		triggerButton = var_1

		var_1(arg_55_0.tacticsBtn)

		arg_55_0.contextData.autoOpenTactics = nil
	end

	if arg_55_0.contextData.autoOpenEnergy then
		triggerButton = var_1

		var_1(arg_55_0.energyBtn)

		arg_55_0.contextData.autoOpenEnergy = nil
	end

	if arg_55_0.contextData.autoOpenSyn then
		local var_55_4 = arg_55_0:getCurMetaProgressVO()

		if var_1.isUnlocked(var_55_4) then
			triggerButton = var_1

			var_1(arg_55_0.synBtn)
		end

		arg_55_0.contextData.autoOpenSyn = nil
	end

	if arg_55_0.contextData.lastPageIndex then
		triggerToggle = var_1

		var_1(arg_55_0.toggleList[arg_55_0.contextData.lastPageIndex], true)

		arg_55_0.contextData.lastPageIndex = nil
	end

	return
end

function var_0_1.openIndexLayer(arg_56_0)
	if not arg_56_0.indexDatas then
		arg_56_0.indexDatas = {}
	end

	local var_56_0 = {}

	Clone = var_1_10002
	var_56_0.indexDatas = var_1_10002(arg_56_0.indexDatas)

	local var_56_1 = {
		minHeight = 650
	}
	local var_56_2 = {}

	CustomIndexLayer = var_4
	var_56_2.mode = var_4.Mode.AND
	ShipIndexConst = var_4
	var_56_2.options = var_4.TypeIndexs
	ShipIndexConst = var_4
	var_56_2.names = var_4.TypeNames
	var_56_1.typeIndex = var_56_2

	local var_56_3 = {}

	CustomIndexLayer = var_4
	var_56_3.mode = var_4.Mode.AND
	ShipIndexConst = var_4
	var_56_3.options = var_4.MetaRarityIndexs
	ShipIndexConst = var_4
	var_56_3.names = var_4.MetaRarityNames
	var_56_1.rarityIndex = var_56_3

	local var_56_4 = {}

	CustomIndexLayer = var_4
	var_56_4.mode = var_4.Mode.OR
	ShipIndexConst = var_4
	var_56_4.options = var_4.MetaExtraIndexs
	ShipIndexConst = var_4
	var_56_4.names = var_4.MetaExtraNames
	var_56_1.extraIndex = var_56_4
	var_56_0.customPanels = var_56_1
	var_56_0.groupList = {
		{
			dropdown = false,
			titleENTxt = "indexsort_typeeng",
			titleTxt = "indexsort_type",
			tags = {
				"typeIndex"
			}
		},
		{
			dropdown = false,
			titleENTxt = "indexsort_rarityeng",
			titleTxt = "indexsort_rarity",
			tags = {
				"rarityIndex"
			}
		},
		{
			dropdown = false,
			titleENTxt = "indexsort_indexeng",
			titleTxt = "indexsort_extraindex",
			tags = {
				"extraIndex"
			}
		}
	}

	function var_56_0.callback(arg_57_0)
		isActive = var_2_10001

		if not var_2_10001(arg_56_0._tf) then
			return
		end

		arg_56_0.indexDatas.typeIndex = arg_57_0.typeIndex
		arg_56_0.indexDatas.rarityIndex = arg_57_0.rarityIndex
		arg_56_0.indexDatas.extraIndex = arg_57_0.extraIndex

		local var_57_0 = arg_56_0
		local var_57_1 = arg_56_0

		var_57_0.metaProgressVOList = var_2.getMetaProgressListForShow(var_57_1)

		local var_57_2 = arg_56_0

		var_1.fillMetaProgressList(var_57_2)

		local var_57_3 = arg_56_0

		var_1.updateStart(var_57_3)

		return
	end

	local var_56_5 = arg_56_0
	local var_56_6 = arg_56_0.emit

	MetaCharacterMediator = var_1_10005

	var_56_6(var_56_5, var_1_10005.OPEN_INDEX_LAYER, var_56_0)

	return
end

function var_0_1.isDefaultStatus(arg_58_0)
	if arg_58_0.indexDatas.typeIndex then
		local var_58_0 = arg_58_0.indexDatas.typeIndex

		ShipIndexConst = var_1_10002

		if var_58_0 == var_1_10002.TypeAll then
			if arg_58_0.indexDatas.rarityIndex then
				local var_58_1 = arg_58_0.indexDatas.rarityIndex

				ShipIndexConst = var_1_10002

				if var_58_1 == var_1_10002.RarityAll then
					local var_58_3

					if arg_58_0.indexDatas.extraIndex then
						local var_58_2 = arg_58_0.indexDatas.extraIndex

						ShipIndexConst = var_1_10002

						if var_58_2 ~= var_1_10002.MetaExtraAll then
							var_58_3 = false

							goto label_58_0
						end
					end

					var_58_3 = true

					::label_58_0::

					return var_58_3
				end
			end
		end
	end
end

function var_0_1.overLayPanel(arg_59_0, arg_59_1)
	if arg_59_1 == true then
		arg_59_0:OverlayPanel(arg_59_0.blurPanel)
	elseif arg_59_1 == false then
		arg_59_0:UnOverlayPanel(arg_59_0.blurPanel, arg_59_0._tf)
	end

	return
end

function var_0_1.getMetaProgressListForShow(arg_60_0)
	local var_60_0 = {}
	local var_60_1 = arg_60_0.metaCharacterProxy
	local var_60_2 = var_2.getMetaProgressVOList(var_60_1)
	local var_60_3
	local var_60_4
	local var_60_5

	ipairs = var_1_10006

	for iter_60_0, iter_60_1 in var_1_10006(var_60_2) do
		MetaCharacterConst = var_1_10011
		var_1_10011 = var_1_10011.filteMetaByType(iter_60_1, arg_60_0.indexDatas.typeIndex)
		MetaCharacterConst = var_1_10012
		var_1_10012 = var_1_10012.filteMetaByRarity(iter_60_1, arg_60_0.indexDatas.rarityIndex)
		MetaCharacterConst = var_13

		local var_60_6 = var_13.filteMetaExtra(iter_60_1, arg_60_0.indexDatas.extraIndex)

		if var_1_10011 and var_1_10012 and var_60_6 and iter_60_1:isShow() then
			if iter_60_1:isPtType() and iter_60_1:isInAct() then
				var_60_3 = iter_60_1
			elseif iter_60_1:isPassType() and iter_60_1:isInAct() then
				var_60_4 = iter_60_1
			elseif iter_60_1:isBuildType() and iter_60_1:isInAct() then
				var_60_5 = iter_60_1
			else
				table = var_14

				var_14.insert(var_60_0, iter_60_1)
			end
		end
	end

	if var_60_5 then
		table = var_6

		var_6.insert(var_60_0, 1, var_60_5)
	end

	if var_60_4 then
		table = var_6

		var_6.insert(var_60_0, 1, var_60_4)
	end

	if var_60_3 then
		table = var_6

		var_6.insert(var_60_0, 1, var_60_3)
	end

	return var_60_0
end

function var_0_1.filteMetaProgressList(arg_61_0)
	local var_61_0 = arg_61_0
	local var_61_1 = arg_61_0.getMetaProgressListForShow(var_61_0)
	local var_61_2 = {}

	ipairs = var_61_0

	for iter_61_0, iter_61_1 in var_61_0(var_61_1) do
		MetaCharacterConst = var_1_10008
		var_1_10008 = var_1_10008.filteMetaByType(iter_61_1, arg_61_0.indexDatas.typeIndex)
		MetaCharacterConst = var_1_10009
		var_1_10009 = var_1_10009.filteMetaByRarity(iter_61_1, arg_61_0.indexDatas.rarityIndex)
		MetaCharacterConst = var_10

		local var_61_3 = var_10.filteMetaExtra(iter_61_1, arg_61_0.indexDatas.extraIndex)

		if var_1_10008 and var_1_10009 and var_61_3 then
			table = var_11

			var_11.insert(var_61_2, iter_61_1)
		end
	end

	return var_61_2
end

function var_0_1.getOneStepPTAwardLevelAndCount(arg_62_0)
	local var_62_0 = arg_62_0:getCurMetaProgressVO().metaPtData
	local var_62_1 = var_2.GetResProgress(var_62_0)
	local var_62_2 = var_1.metaPtData.targets
	local var_62_3 = var_1:getStoryIndexList()
	local var_62_4 = var_1.unlockPTLevel
	local var_62_5 = 0

	for iter_62_0 = 1, var_62_4 - 1 do
		local var_62_6 = false
		local var_62_7 = false

		if var_62_1 >= var_62_2[iter_62_0] then
			var_62_6 = true
		end

		if var_62_3[iter_62_0] == 0 then
			var_62_7 = true
		else
			pg = var_1_10015

			local var_62_8 = var_1_10015.NewStoryMgr.GetInstance()

			if var_1_10015.IsPlayed(var_62_8, var_14) then
				var_62_7 = true
			end
		end

		if var_62_6 and var_62_7 then
			var_62_5 = iter_62_0
		else
			break
		end
	end

	return var_62_5, var_62_2[var_62_5]
end

return var_0_1
