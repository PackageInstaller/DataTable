class = var_0_10000

local var_0_0 = "EducateMapScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.EducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EducateMapUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	EducateProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)

	if var_2.NeedRequestOptsData(var_2_0) then
		pg = var_2

		local var_2_1 = var_2.m02
		local var_2_2 = var_2.sendNotification

		GAME = var_1_10005

		var_2_2(var_2_1, var_1_10005.EDUCATE_REQUEST_OPTION, {
			callback = arg_2_1
		})
	else
		arg_2_1()
	end

	return
end

function var_0_1.init(arg_3_0)
	arg_3_0:initData()
	arg_3_0:findUI()
	arg_3_0:addListener()

	return
end

function var_0_1.initData(arg_4_0)
	pg = var_1_10001
	arg_4_0.config = var_1_10001.child_site
	getProxy = var_1
	EducateProxy = var_1_10003

	local var_4_0 = var_1(var_1_10003)

	arg_4_0.siteIdList = var_1.GetShowSiteIds(var_4_0)

	return
end

function var_0_1.findUI(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.topTF = var_1.Find(var_5_0, "ui/top")

	local var_5_1 = arg_5_0._tf

	arg_5_0.homeBtn = var_1.Find(var_5_1, "ui/home_btn/home_btn")
	setText = var_1

	local var_5_2 = arg_5_0.homeBtn
	local var_5_3 = var_3.Find(var_5_2, "Text")

	i18n = var_4

	var_1(var_5_3, var_4("child_btn_home"))

	setActive = var_1

	var_1(arg_5_0.homeBtn, false)

	local var_5_4 = arg_5_0._tf

	arg_5_0.mapTF = var_1.Find(var_5_4, "map")

	local var_5_5 = arg_5_0.mapTF

	arg_5_0.mapContent = var_1.Find(var_5_5, "content")

	local var_5_6 = arg_5_0.mapTF

	arg_5_0.mapSiteTpl = var_1.Find(var_5_6, "site_tpl")
	setText = var_1

	local var_5_7 = arg_5_0.mapSiteTpl
	local var_5_8 = var_3.Find(var_5_7, "limit/Text")

	i18n = var_4

	var_1(var_5_8, var_4("child_option_limit"))

	setActive = var_1

	var_1(arg_5_0.mapSiteTpl, false)

	UIItemList = var_1
	arg_5_0.siteUIList = var_1.New(arg_5_0.mapContent, arg_5_0.mapSiteTpl)
	EducateDatePanel = var_1

	local var_5_9 = var_1.New
	local var_5_10 = arg_5_0.topTF

	arg_5_0.datePanel = var_5_9(var_3.Find(var_5_10, "date"), arg_5_0.event)

	local var_5_11 = arg_5_0.datePanel

	var_1.RegisterView(var_5_11, arg_5_0)

	local var_5_12 = arg_5_0.datePanel

	var_1.Load(var_5_12)

	EducateResPanel = var_1

	local var_5_13 = var_1.New
	local var_5_14 = arg_5_0.topTF

	arg_5_0.resPanel = var_5_13(var_3.Find(var_5_14, "res"), arg_5_0.event, {
		showBg = true
	})

	local var_5_15 = arg_5_0.resPanel

	var_1.RegisterView(var_5_15, arg_5_0)

	local var_5_16 = arg_5_0.resPanel

	var_1.Load(var_5_16)

	EducateTopPanel = var_1

	local var_5_17 = var_1.New
	local var_5_18 = arg_5_0.topTF

	arg_5_0.topPanel = var_5_17(var_3.Find(var_5_18, "top_right"), arg_5_0.event)

	local var_5_19 = arg_5_0.topPanel

	var_1.RegisterView(var_5_19, arg_5_0)

	local var_5_20 = arg_5_0.topPanel

	var_1.Load(var_5_20)

	EducateTargetPanel = var_1

	local var_5_21 = var_1.New
	local var_5_22 = arg_5_0._tf

	arg_5_0.targetPanel = var_5_21(var_3.Find(var_5_22, "ui/target"), arg_5_0.event)

	local var_5_23 = arg_5_0.targetPanel

	var_1.RegisterView(var_5_23, arg_5_0)

	local var_5_24 = arg_5_0.targetPanel

	var_1.Load(var_5_24)

	EducateArchivePanel = var_1

	local var_5_25 = var_1.New
	local var_5_26 = arg_5_0._tf

	arg_5_0.archivePanel = var_5_25(var_3.Find(var_5_26, "ui/archive_panel"), arg_5_0.event)

	local var_5_27 = arg_5_0.archivePanel

	var_1.RegisterView(var_5_27, arg_5_0)

	local var_5_28 = arg_5_0.archivePanel

	var_1.Load(var_5_28)

	EducateSiteDetailPanel = var_1

	local var_5_29 = var_1.New
	local var_5_30 = arg_5_0._tf

	arg_5_0.detailPanel = var_5_29(var_3.Find(var_5_30, "ui/detail_panel"), arg_5_0.event, {
		onEnter = function()
			local var_6_0 = arg_5_0

			var_0.MoveTargetPanelLeft(var_6_0)

			return
		end,
		onExit = function()
			local var_7_0 = arg_5_0

			var_0.MoveTargetPanelRight(var_7_0)

			return
		end
	})

	local var_5_31 = arg_5_0.detailPanel

	var_1.RegisterView(var_5_31, arg_5_0)

	local var_5_32 = arg_5_0.detailPanel

	var_1.Load(var_5_32)

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.homeBtn

	local function var_8_2()
		local var_9_0 = arg_8_0
		local var_9_1 = var_0.emit

		EducateBaseUI = var_2_10003

		local var_9_2 = var_2_10003.EDUCATE_CHANGE_SCENE

		SCENE = var_2_10004

		var_9_1(var_9_0, var_9_2, var_2_10004.EDUCATE)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	return
end

function var_0_1.didEnter(arg_10_0)
	arg_10_0:OverlayPanel(arg_10_0.topTF)

	local var_10_0 = arg_10_0.siteUIList

	var_1.make(var_10_0, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_10_0

			var_3.updateSiteItem(var_11_0, arg_11_1, arg_11_2)
		end

		return
	end)

	local var_10_1 = arg_10_0.siteUIList

	var_1.align(var_10_1, #arg_10_0.siteIdList)
	arg_10_0:playAnim()
	arg_10_0:CheckTips(function()
		local var_12_0 = arg_10_0.siteUIList

		var_0.align(var_12_0, #arg_10_0.siteIdList)

		return
	end)

	return
end

function var_0_1.playAnim(arg_13_0)
	local var_13_0 = arg_13_0.siteUIList

	var_1.each(var_13_0, function(arg_14_0, arg_14_1)
		setActive = var_2_10002

		var_2_10002(arg_14_1, false)

		return
	end)

	local var_13_1 = {}

	table = var_1_10002

	var_1_10002.insert(var_13_1, function(arg_15_0)
		local var_15_0 = arg_13_0
		local var_15_1 = var_1.managedTween

		LeanTween = var_2_10004

		var_15_1(var_15_0, var_2_10004.delayedCall, function()
			arg_15_0()

			return
		end, 0.165, nil)

		return
	end)

	for iter_13_0 = 1, #arg_13_0.siteIdList do
		table = var_1_10006

		var_1_10006.insert(var_13_1, function(arg_17_0)
			setActive = var_2_10001

			local var_17_0 = arg_13_0.siteUIList.container

			var_2_10001(var_3.GetChild(var_17_0, iter_13_0 - 1), true)

			local var_17_1 = arg_13_0
			local var_17_2 = var_1.managedTween

			LeanTween = var_4

			var_17_2(var_17_1, var_4.delayedCall, function()
				arg_17_0()

				return
			end, 0.033, nil)

			return
		end)
	end

	seriesAsync = var_2

	var_2(var_13_1, function()
		return
	end)

	return
end

function var_0_1.CheckTips(arg_20_0, arg_20_1)
	local var_20_0 = {}

	EducateTipHelper = var_1_10003

	if #var_1_10003.GetSiteUnlockTipIds() > 0 then
		local var_20_1 = arg_20_0
		local var_20_2 = arg_20_0.emit
		local var_20_3 = var_0_1.EDUCATE_ON_UNLOCK_TIP
		local var_20_4 = {}

		EducateUnlockTipLayer = var_1_10009
		var_20_4.type = var_1_10009.UNLOCK_TYPE_SITE
		var_20_4.list = var_3
		var_20_4.onExit = arg_20_1

		var_20_2(var_20_1, var_20_3, var_20_4)
	end

	return
end

function var_0_1.updateSiteItem(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2.name = arg_21_0.config[arg_21_0.siteIdList[arg_21_1 + 1]].id
	LoadImageSpriteAsync = var_4

	var_4("educatesite/" .. var_3.icon, arg_21_2:Find("icon"), true)

	LoadImageSpriteAsync = var_4

	var_4("educatesite/" .. var_3.name_pic, arg_21_2:Find("name"), true)

	getProxy = var_4
	EducateProxy = var_6

	local var_21_0 = var_4(var_6)
	local var_21_1 = var_4.GetOptionsBySiteId(var_21_0, var_3.id)

	underscore = var_5

	local var_21_2 = var_5.any(var_21_1, function(arg_22_0)
		return arg_22_0:IsShowLimit()
	end)

	setActive = var_21_0

	var_21_0(arg_21_2:Find("limit"), var_21_2)

	setActive = var_21_0

	local var_21_3 = arg_21_2:Find("new")

	EducateTipHelper = var_9

	local var_21_4 = var_9.IsShowNewTip

	EducateTipHelper = var_11

	var_21_0(var_21_3, var_21_4(var_11.NEW_SITE, var_3.id))

	setAnchoredPosition = var_21_0

	var_21_0(arg_21_2, {
		x = var_3.coordinate[1],
		y = var_3.coordinate[2]
	})

	onButton = var_21_0

	local var_21_5 = arg_21_0
	local var_21_6 = arg_21_2

	local function var_21_7()
		local var_23_0 = arg_21_0.detailPanel

		var_0.Show(var_23_0, var_0.id)

		return
	end

	SFX_PANEL = var_11

	var_21_0(var_21_5, var_21_6, var_21_7, var_11)

	return
end

function var_0_1.clearNewTip(arg_24_0, arg_24_1)
	eachChild = var_1_10002

	var_1_10002(arg_24_0.mapContent, function(arg_25_0)
		tonumber = var_2_10001

		if var_2_10001(arg_25_0.name) == arg_24_1 then
			setActive = var_1

			var_1(arg_25_0:Find("new"), false)
		end

		return
	end)

	return
end

function var_0_1.updateRes(arg_26_0)
	local var_26_0 = arg_26_0.resPanel

	var_1.Flush(var_26_0)

	return
end

function var_0_1.updateAttrs(arg_27_0)
	local var_27_0 = arg_27_0.archivePanel

	var_1.Flush(var_27_0)

	return
end

function var_0_1.updateTime(arg_28_0)
	local var_28_0 = arg_28_0.siteUIList

	var_1.align(var_28_0, #arg_28_0.siteIdList)

	local var_28_1 = arg_28_0.datePanel

	var_1.Flush(var_28_1)

	return
end

function var_0_1.updateTarget(arg_29_0)
	local var_29_0 = arg_29_0.targetPanel

	var_1.Flush(var_29_0)

	return
end

function var_0_1.updateTimeWeekDay(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.datePanel

	var_2.UpdateWeekDay(var_30_0, arg_30_1)

	return
end

function var_0_1.MoveTargetPanelLeft(arg_31_0)
	local var_31_0 = arg_31_0.targetPanel

	var_1.SetPosLeft(var_31_0)

	return
end

function var_0_1.MoveTargetPanelRight(arg_32_0)
	local var_32_0 = arg_32_0.targetPanel

	var_1.SetPosRight(var_32_0)

	return
end

function var_0_1.ShowSpecEvent(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = arg_33_0.detailPanel

	var_5.showSpecEvent(var_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)

	return
end

function var_0_1.ShowSitePerform(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
	local var_34_0 = arg_34_0.detailPanel

	var_6.showSitePerform(var_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)

	return
end

function var_0_1.onBackPressed(arg_35_0)
	local var_35_0 = arg_35_0.detailPanel

	if var_1.isShowing(var_35_0) then
		local var_35_1 = arg_35_0.detailPanel

		var_1.onClose(var_35_1)
	else
		arg_35_0:emit(var_0_1.ON_BACK_PRESSED)
	end

	return
end

function var_0_1.willExit(arg_36_0)
	local var_36_0 = arg_36_0
	local var_36_1 = arg_36_0.UnOverlayPanel
	local var_36_2 = arg_36_0.topTF
	local var_36_3 = arg_36_0._tf

	var_36_1(var_36_0, var_36_2, var_5.Find(var_36_3, "ui"))

	local var_36_4 = arg_36_0.datePanel

	var_1.Destroy(var_36_4)

	arg_36_0.datePanel = nil

	local var_36_5 = arg_36_0.resPanel

	var_1.Destroy(var_36_5)

	arg_36_0.resPanel = nil

	local var_36_6 = arg_36_0.topPanel

	var_1.Destroy(var_36_6)

	arg_36_0.topPanel = nil

	local var_36_7 = arg_36_0.targetPanel

	var_1.Destroy(var_36_7)

	arg_36_0.targetPanel = nil

	local var_36_8 = arg_36_0.archivePanel

	var_1.Destroy(var_36_8)

	arg_36_0.archivePanel = nil

	local var_36_9 = arg_36_0.detailPanel

	var_1.Destroy(var_36_9)

	arg_36_0.detailPanel = nil

	return
end

return var_0_1
