class = var_0_10000

local var_0_0 = "MallMapScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))
local var_0_2 = {}

MallActivity = var_2

local var_0_3 = var_2.POINT_TYPE.SITE
local var_0_4 = {
	"name_bg_blue",
	nil,
	"icon_site"
}

i18n = var_0_10004
var_0_4[2] = var_0_10004("mall_point_name_type1")
var_0_2[var_0_3] = var_0_4
MallActivity = var_0_3

local var_0_5 = var_0_3.POINT_TYPE.MAIN_STORY
local var_0_6 = {
	"name_bg_green",
	nil,
	"icon_branch"
}

i18n = var_4
var_0_6[2] = var_4("mall_point_name_type2")
var_0_2[var_0_5] = var_0_6
MallActivity = var_0_5

local var_0_7 = var_0_5.POINT_TYPE.BRANCH_STORY
local var_0_8 = {
	"name_bg_green",
	nil,
	"icon_branch"
}

i18n = var_4
var_0_8[2] = var_4("mall_point_name_type3")
var_0_2[var_0_7] = var_0_8
MallActivity = var_0_7

local var_0_9 = var_0_7.POINT_TYPE.INTERACT_STORY
local var_0_10 = {
	"name_bg_orange",
	nil,
	""
}

i18n = var_4
var_0_10[2] = var_4("mall_point_name_type4")
var_0_2[var_0_9] = var_0_10
var_0_1.TYPE2INFOS = var_0_2

function var_0_1.getUIName(arg_1_0)
	return "MallMapUI"
end

function var_0_1.init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiBackBtn

	local function var_2_2()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.uiHomeBtn

	local function var_2_5()
		local var_4_0 = arg_2_0

		var_0.quickExitFunc(var_4_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)

	onButton = var_1_10001

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.uiHelpBtn

	local function var_2_8()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_5_2.type = var_2_10003
		pg = var_2_10003
		var_5_2.helps = var_2_10003.gametip.mall_help.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_6, var_2_7, var_2_8, var_1_10005)

	onButton = var_1_10001

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.uiMallBtn

	local function var_2_11()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		MallMapMediator = var_2_10002

		local var_6_2 = var_2_10002.CHANGE_SCENE

		SCENE = var_2_10003

		var_6_1(var_6_0, var_6_2, var_2_10003.MALL)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_9, var_2_10, var_2_11, var_1_10005)

	onButton = var_1_10001

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0.uiBookBtn

	local function var_2_14()
		local var_7_0 = arg_2_0
		local var_7_1 = var_0.emit

		MallMapMediator = var_2_10002

		local var_7_2 = var_2_10002.GO_SUBLAYER

		Context = var_2_10003

		local var_7_3 = var_2_10003.New
		local var_7_4 = {}

		MallStoryLineMediator = var_2_10005
		var_7_4.mediator = var_2_10005
		MallStoryLineLayer = var_2_10005
		var_7_4.viewComponent = var_2_10005

		var_7_1(var_7_0, var_7_2, var_7_3(var_7_4))

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_12, var_2_13, var_2_14, var_1_10005)

	onButton = var_1_10001

	local var_2_15 = arg_2_0
	local var_2_16 = arg_2_0.uiOrderBtn

	local function var_2_17()
		local var_8_0 = arg_2_0
		local var_8_1 = var_0.emit

		MallMapMediator = var_2_10002

		local var_8_2 = var_2_10002.GO_SUBLAYER

		Context = var_2_10003

		local var_8_3 = var_2_10003.New
		local var_8_4 = {}

		MallOrderMediator = var_2_10005
		var_8_4.mediator = var_2_10005
		MallOrderLayer = var_2_10005
		var_8_4.viewComponent = var_2_10005
		var_8_4.data = {
			onExit = function()
				local var_9_0 = arg_2_0

				var_0.UpdateOrderTip(var_9_0)

				return
			end
		}

		var_8_1(var_8_0, var_8_2, var_8_3(var_8_4))

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_15, var_2_16, var_2_17, var_1_10005)

	onButton = var_1_10001

	local var_2_18 = arg_2_0
	local var_2_19 = arg_2_0.uiSummaryBtn

	local function var_2_20()
		local var_10_0 = arg_2_0

		var_0.ShowSummaryBox(var_10_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_18, var_2_19, var_2_20, var_1_10005)

	UIItemList = var_1_10001

	local var_2_21 = var_1_10001.New
	local var_2_22 = arg_2_0.uiContentTF
	local var_2_23 = arg_2_0.uiContentTF

	arg_2_0.pointUIList = var_2_21(var_2_22, var_3.Find(var_2_23, "tpl"))

	local var_2_24 = arg_2_0.pointUIList

	var_1.make(var_2_24, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_2_0

			var_3.UpdatePointTpl(var_11_0, arg_11_1, arg_11_2)
		end

		return
	end)

	MallSiteBox = var_1
	arg_2_0.siteBox = var_1.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	MallSummaryBox = var_1
	arg_2_0.summaryBox = var_1.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	setText = var_1

	local var_2_25 = arg_2_0.uiTitleText

	i18n = var_3

	var_1(var_2_25, var_3("mall_title"))

	setText = var_1

	local var_2_26 = arg_2_0.uiTitleEnText

	i18n = var_3

	var_1(var_2_26, var_3("mall_title_en"))

	return
end

function var_0_1.didEnter(arg_12_0)
	arg_12_0:UpdateData()
	arg_12_0:UpdateView()
	arg_12_0:UpdateBg()
	arg_12_0:CheckGuide()
	arg_12_0:CheckOrderStory()

	return
end

function var_0_1.CheckGuide(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.NewStoryMgr.GetInstance()
	local var_13_3

	if not var_1.IsPlayed(var_13_0, "MALL_GUIDE") then
		pg = var_13_3

		local var_13_1 = var_13_3.NewGuideMgr.GetInstance()

		var_13_3.Play(var_13_1, "MALL_GUIDE")

		pg = var_13_3

		local var_13_2 = var_13_3.m02

		var_13_3 = var_13_3.sendNotification
		GAME = var_3

		var_13_3(var_13_2, var_3.STORY_UPDATE, {
			storyId = "MALL_GUIDE"
		})

		return
	end

	pg = var_13_3

	local var_13_4 = var_13_3.NewStoryMgr.GetInstance()

	if not var_1.IsPlayed(var_13_4, "MALL_GUIDE_2") then
		pg = var_1

		local var_13_5 = var_1.NewGuideMgr.GetInstance()

		var_1.Play(var_13_5, "MALL_GUIDE_2")

		pg = var_1

		local var_13_6 = var_1.m02
		local var_13_7 = var_1.sendNotification

		GAME = var_3

		var_13_7(var_13_6, var_3.STORY_UPDATE, {
			storyId = "MALL_GUIDE_2"
		})

		return
	end

	return
end

function var_0_1.CheckOrderStory(arg_14_0)
	local var_14_0 = arg_14_0.activity
	local var_14_1 = var_1.GetOrderData(var_14_0)
	local var_14_2 = var_1.GetFinishedList(var_14_1)
	local var_14_3 = {}

	ipairs = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10003(var_14_2) do
		pg = var_1_10008

		if var_1_10008.activity_mall_custom_order[iter_14_1].story_unlock ~= "" then
			pg = var_1_10010

			local var_14_4 = var_1_10010.NewStoryMgr.GetInstance()

			if not var_1_10010.IsPlayed(var_14_4, var_1_10009) then
				table = var_1_10010

				var_1_10010.insert(var_14_3, var_1_10009)
			end
		end
	end

	local var_14_5 = #var_14_3

	if 0 < var_14_5 then
		local var_14_6 = {}

		ipairs = var_4

		for iter_14_2, iter_14_3 in var_4(var_14_3) do
			table = var_1_10009

			var_1_10009.insert(var_14_6, function(arg_15_0)
				pg = var_2_10001

				local var_15_0 = var_2_10001.NewStoryMgr.GetInstance()

				var_1.Play(var_15_0, iter_14_3, arg_15_0)

				return
			end)
		end

		seriesAsync = var_4

		var_4(var_14_6, function()
			return
		end)
	end

	return
end

function var_0_1.UpdateData(arg_17_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_17_0 = var_1_10001(var_1_10002)
	local var_17_1 = var_1.getActivityByType

	ActivityConst = var_1_10003
	arg_17_0.activity = var_17_1(var_17_0, var_1_10003.ACTIVITY_TYPE_MALL)
	assert = var_1

	local var_17_3

	if arg_17_0.activity then
		local var_17_2 = arg_17_0.activity

		var_17_3 = not var_2.isEnd(var_17_2)
	end

	local var_17_4 = "not exist mall act, type: "

	ActivityConst = var_1_10004

	var_1(var_17_3, var_17_4 .. var_1_10004.ACTIVITY_TYPE_MALL)

	local var_17_5 = arg_17_0.activity

	arg_17_0.triggeredIds = var_1.GetTriggeredPointIds(var_17_5)

	local var_17_6 = arg_17_0.activity
	local var_17_7 = var_1.GetLevelData(var_17_6)
	local var_17_8 = var_1.GetUnlockStoryIdsByType(var_17_7)

	arg_17_0.showPointIds = {}
	pairs = var_2

	for iter_17_0, iter_17_1 in var_2(var_17_8) do
		MallActivity = var_1_10007
		var_1_10007 = iter_17_0 ~= var_1_10007.POINT_TYPE.SITE
		underscore = var_1_10008

		if var_1_10008.detect(iter_17_1, function(arg_18_0)
			pg = var_2_10001

			local var_18_0 = var_2_10001.activity_mall_story[arg_18_0]

			table = var_2_10002

			local var_18_2

			if var_2_10002.contains(arg_17_0.triggeredIds, arg_18_0) then
				if var_1_10007 then
					if var_18_0.lua ~= "" then
						pg = var_18_2

						local var_18_1 = var_18_2.NewStoryMgr.GetInstance()

						var_18_2 = not var_18_2.IsPlayed(var_18_1, var_18_0.lua)
					else
						var_18_2 = false
					end
				end
			else
				var_18_2 = true
			end

			return var_18_2
		end) then
			table = var_9

			var_9.insert(arg_17_0.showPointIds, var_1_10008)
		end
	end

	local var_17_9 = arg_17_0.activity

	arg_17_0.bgConfig = var_2.getConfig(var_17_9, "config_client").bg_switch

	return
end

function var_0_1.UpdateView(arg_19_0)
	local var_19_0 = arg_19_0.pointUIList

	var_1.align(var_19_0, #arg_19_0.showPointIds)
	arg_19_0:UpdateOrderBtn()
	arg_19_0:UpdateTips()

	return
end

function var_0_1.UpdateBg(arg_20_0)
	local var_20_0 = arg_20_0

	if arg_20_0.GetCurBg(var_20_0) then
		setImageSprite = var_20_0

		local var_20_1 = arg_20_0.uiBgTF

		LoadSprite = var_1_10004

		var_20_0(var_20_1, var_1_10004("bg/" .. var_1), false)
	end

	return
end

function var_0_1.GetCurBg(arg_21_0)
	for iter_21_0 = #arg_21_0.bgConfig, 1, -1 do
		local var_21_0 = arg_21_0.bgConfig[iter_21_0]

		pg = var_1_10006

		local var_21_1 = var_1_10006.NewStoryMgr.GetInstance()

		if var_1_10006.IsPlayed(var_21_1, var_21_0[1]) then
			return var_21_0[2]
		end
	end

	return nil
end

function var_0_1.UpdateOrderBtn(arg_22_0)
	setActive = var_1_10001

	var_1_10001(arg_22_0.uiOrderTimeTF, false)

	local var_22_0 = arg_22_0.activity

	arg_22_0.orderData = var_1.GetOrderData(var_22_0)

	if arg_22_0.orderData.id ~= 0 then
		pg = var_1

		local var_22_1 = var_1.TimeMgr.GetInstance()
		local var_22_2 = var_1.GetServerTime(var_22_1)
		local var_22_3 = arg_22_0.orderData

		if var_22_2 < var_2.GetEndTime(var_22_3) then
			setActive = var_22_2

			var_22_2(arg_22_0.uiOrderTimeTF, true)
			arg_22_0:StartTimer()
		end
	else
		arg_22_0:StopTimer()
	end

	return
end

function var_0_1.UpdateTips(arg_23_0)
	setActive = var_1_10001

	var_1_10001(arg_23_0.uiMallTip, var_0_1.IsMallTip())
	arg_23_0:UpdateOrderTip()

	return
end

function var_0_1.UpdateOrderTip(arg_24_0)
	setActive = var_1_10001

	local var_24_0 = arg_24_0.uiOrderTip

	MallScene = var_1_10003

	var_1_10001(var_24_0, var_1_10003.IsOrderTip())

	return
end

function var_0_1.UpdatePointTpl(arg_25_0, arg_25_1, arg_25_2)
	arg_25_2.name = arg_25_0.showPointIds[arg_25_1 + 1]
	pg = var_4

	local var_25_0 = var_4.activity_mall_story[var_3]

	setAnchoredPosition = var_1_10005

	var_1_10005(arg_25_2, {
		x = var_25_0.posion[1],
		y = var_25_0.posion[2]
	})

	local var_25_1 = var_25_0.type
	local var_25_2 = var_0_1.TYPE2INFOS[var_25_1]

	GetImageSpriteFromAtlasAsync = var_7

	var_7("ui/mallmapui_atlas", var_25_2[1], arg_25_2:Find("name"), true)

	setText = var_7

	var_7(arg_25_2:Find("name/Text"), var_25_2[2])

	MallActivity = var_7

	local var_25_3 = var_25_1 == var_7.POINT_TYPE.INTERACT_STORY

	setActive = var_8

	var_8(arg_25_2:Find("ship"), var_25_3)

	setActive = var_8

	var_8(arg_25_2:Find("icon"), not var_25_3)

	local var_25_6

	if var_25_3 then
		GetImageSpriteFromAtlasAsync = var_8

		local var_25_4 = var_25_0.icon
		local var_25_5 = ""

		var_25_6 = arg_25_2

		var_8(var_25_4, var_25_5, arg_25_2.Find(var_25_6, "ship"))
	else
		GetImageSpriteFromAtlasAsync = var_8

		local var_25_7 = "ui/mallmapui_atlas"
		local var_25_8 = var_25_2[3]

		var_25_6 = arg_25_2

		var_8(var_25_7, var_25_8, arg_25_2.Find(var_25_6, "icon"), true)
	end

	onButton = var_8

	local var_25_9 = arg_25_0
	local var_25_10 = arg_25_2

	local function var_25_11()
		table = var_2_10000

		local var_26_0

		if not var_2_10000.contains(arg_25_0.triggeredIds, var_0) then
			var_26_0 = arg_25_0

			local var_26_1 = var_0.emit

			MallMapMediator = var_2

			var_26_1(var_26_0, var_2.TRIGGER_POINT, arg_25_0.activity.id, var_0)
		end

		local var_26_2 = var_25_1

		MallActivity = var_26_0

		if var_26_2 == var_26_0.POINT_TYPE.SITE then
			local var_26_3 = arg_25_0.siteBox

			var_26_2.ExecuteAction(var_26_3, "Show", var_0)
		else
			pg = var_26_2

			local var_26_4 = var_26_2.NewStoryMgr.GetInstance()

			var_0.Play(var_26_4, var_25_0.lua, function()
				local var_27_0 = arg_25_0

				var_0.didEnter(var_27_0)

				return
			end)
		end

		return
	end

	SFX_PANEL = var_25_6

	var_8(var_25_9, var_25_10, var_25_11, var_25_6)

	return
end

function var_0_1.StartTimer(arg_28_0)
	arg_28_0:StopTimer()

	local var_28_0 = arg_28_0.orderData

	arg_28_0.orderEndTime = var_1.GetEndTime(var_28_0)
	Timer = var_1
	arg_28_0.timer = var_1.New(function()
		local var_29_0 = arg_28_0.orderEndTime

		pg = var_2_10001

		local var_29_1 = var_2_10001.TimeMgr.GetInstance()
		local var_29_2 = var_29_0 - var_1.GetServerTime(var_29_1)

		setText = var_1

		local var_29_3 = arg_28_0.uiOrderTimeTF
		local var_29_4 = var_2.Find(var_29_3, "Text")

		pg = var_29_3

		local var_29_5 = var_29_3.TimeMgr.GetInstance()

		var_1(var_29_4, var_3.DescCDTime(var_29_5, var_29_2))

		if var_29_2 <= 0 then
			local var_29_6 = arg_28_0

			var_1.UpdateOrderBtn(var_29_6)

			setActive = var_1

			var_1(arg_28_0.uiOrderTip, true)
		end

		return
	end, 1, -1)

	local var_28_1 = arg_28_0.timer

	var_1.Start(var_28_1)
	arg_28_0.timer.func()

	return
end

function var_0_1.StopTimer(arg_30_0)
	if arg_30_0.timer then
		local var_30_0 = arg_30_0.timer

		var_1.Stop(var_30_0)

		arg_30_0.timer = nil
	end

	return
end

function var_0_1.ShowSummaryBox(arg_31_0)
	local var_31_0 = arg_31_0.summaryBox

	var_1.ExecuteAction(var_31_0, "Show")

	return
end

function var_0_1.onBackPressed(arg_32_0)
	if arg_32_0.siteBox then
		local var_32_0 = arg_32_0.siteBox

		if var_1.isShowing(var_32_0) then
			local var_32_1 = arg_32_0.siteBox

			var_1.ExecuteAction(var_32_1, "Hide")

			return
		end
	end

	if arg_32_0.summaryBox then
		local var_32_2 = arg_32_0.summaryBox

		if var_1.isShowing(var_32_2) then
			local var_32_3 = arg_32_0.summaryBox

			var_1.ExecuteAction(var_32_3, "Hide")

			return
		end
	end

	var_0_1.super.onBackPressed(arg_32_0)

	return
end

function var_0_1.willExit(arg_33_0)
	if arg_33_0.siteBox then
		local var_33_0 = arg_33_0.siteBox

		var_1.Destroy(var_33_0)

		arg_33_0.siteBox = nil
	end

	if arg_33_0.summaryBox then
		local var_33_1 = arg_33_0.summaryBox

		var_1.Destroy(var_33_1)

		arg_33_0.summaryBox = nil
	end

	arg_33_0:StopTimer()

	return
end

function var_0_1.IsMallTip()
	MallScene = var_1_10000

	local var_34_0

	if not var_1_10000.IsAwardTip() then
		MallScene = var_34_0
		var_34_0 = var_34_0.IsOrderTip()
	end

	return var_34_0
end

function var_0_1.IsEntranceTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_35_0 = var_1_10000(var_1_10001)
	local var_35_1 = var_0.getActivityByType

	ActivityConst = var_1_10002

	if not var_35_1(var_35_0, var_1_10002.ACTIVITY_TYPE_MALL) or var_0:isEnd() then
		return false
	end

	MallScene = var_35_0

	local var_35_2

	if not var_35_0.IsMapTip() then
		var_35_2 = var_0_1.IsMallTip()
	end

	return var_35_2
end

return var_0_1
