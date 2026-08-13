class = var_0_10000

local var_0_0 = "CrusingScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.optionsPath = {
	"top/home"
}
var_0_1.FrameSpeed = 10
var_0_1.PlaySpeed = 1.5

function var_0_1.getUIName(arg_1_0)
	return "CrusingUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_2_0 = var_1_10002(var_1_10003)
	local var_2_1 = var_2.getAliveActivityByType

	ActivityConst = var_1_10004

	local var_2_2 = var_2_1(var_2_0, var_1_10004.ACTIVITY_TYPE_PT_CRUSING)

	PoolMgr = var_2_0

	local var_2_3 = var_2_0.GetInstance()
	local var_2_4 = {}

	table = var_1_10005

	var_1_10005.insert(var_2_4, function(arg_3_0)
		pg = var_2_10001

		local var_3_0 = var_2_10001.battlepass_event_pt[var_2_2.id].crusing_map
		local var_3_1 = var_2_3

		var_2.GetPrefab(var_3_1, "crusingmap/" .. var_3_0, "", true, function(arg_4_0)
			local var_4_0 = arg_2_0

			tf = var_3_10002
			var_4_0.rtMap = var_3_10002(arg_4_0)

			local var_4_1 = arg_2_0
			local var_4_2 = arg_2_0

			CrusingMapInfo = var_3
			var_4_1.PhaseFrame, var_4_2.AllFrameCount = var_3.GetPhaseFrame(var_3_0)

			arg_3_0()

			return
		end)

		return
	end)

	table = var_5

	var_5.insert(var_2_4, function(arg_5_0)
		local var_5_0 = var_2_3
		local var_5_1 = var_1.GetSpineChar

		pg = var_2_10003

		var_5_1(var_5_0, var_2_10003.battlepass_event_pt[var_2_2.id].spine_name, true, function(arg_6_0)
			local var_6_0 = arg_2_0

			tf = var_3_10002
			var_6_0.rtModel = var_3_10002(arg_6_0)

			arg_5_0()

			return
		end)

		return
	end)

	parallelAsync = var_5

	var_5(var_2_4, function()
		setParent = var_2_10000

		local var_7_0 = arg_2_0.rtModel
		local var_7_1 = arg_2_0.rtMap

		var_2_10000(var_7_0, var_2.Find(var_7_1, "icon/model"))

		local var_7_2 = arg_2_0.rtModel

		Vector3 = var_7_0
		var_7_2.localScale = var_7_0.one

		arg_2_1()

		return
	end)

	return
end

function var_0_1.init(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.rtBg = var_1.Find(var_8_0, "bg")

	local var_8_1 = arg_8_0.rtBg

	arg_8_0.scrollMap = var_1.Find(var_8_1, "map_scroll")

	local var_8_2 = arg_8_0.rtBg

	arg_8_0.btnTask = var_1.Find(var_8_2, "task_btn")

	local var_8_3 = arg_8_0.rtBg

	arg_8_0.textTip = var_1.Find(var_8_3, "tip")

	local var_8_4 = arg_8_0._tf

	arg_8_0.rtAward = var_1.Find(var_8_4, "award_panel")

	local var_8_5 = arg_8_0.rtAward

	arg_8_0.textPhase = var_1.Find(var_8_5, "phase/Text")

	local var_8_6 = arg_8_0.rtAward

	arg_8_0.sliderPt = var_1.Find(var_8_6, "Slider")
	GetComponent = var_1

	local var_8_7 = arg_8_0.rtAward

	arg_8_0.comScroll = var_1(var_2.Find(var_8_7, "view/content"), "LScrollRect")

	function arg_8_0.comScroll.onUpdateItem(arg_9_0, arg_9_1)
		local var_9_0 = arg_8_0
		local var_9_1 = var_2.updateAwardInfo

		tf = var_2_10004

		var_9_1(var_9_0, var_2_10004(arg_9_1), arg_8_0.awardList[arg_9_0 + 1])

		return
	end

	local var_8_8 = arg_8_0.rtAward

	arg_8_0.rtNextAward = var_1.Find(var_8_8, "next")

	local var_8_9 = arg_8_0.rtAward

	arg_8_0.btnAll = var_1.Find(var_8_9, "btn_all")

	local var_8_10 = arg_8_0.rtAward

	arg_8_0.btnPay = var_1.Find(var_8_10, "btn_pay")

	local var_8_11 = arg_8_0.rtAward

	arg_8_0.btnAfter = var_1.Find(var_8_11, "btn_after")

	local var_8_12 = arg_8_0.rtAward

	arg_8_0.btnFinish = var_1.Find(var_8_12, "btn_finish")

	local var_8_13 = arg_8_0._tf

	arg_8_0.rtTop = var_1.Find(var_8_13, "top")

	local var_8_14 = arg_8_0.rtTop

	arg_8_0.btnBack = var_1.Find(var_8_14, "back")

	local var_8_15 = arg_8_0.rtTop

	arg_8_0.btnHelp = var_1.Find(var_8_15, "help")

	local var_8_16 = arg_8_0.rtTop

	arg_8_0.textDay = var_1.Find(var_8_16, "day/Text")
	ChargeTipWindow = var_1
	arg_8_0.chargeTipWindow = var_1.New(arg_8_0._tf, arg_8_0.event)
	arg_8_0.LTDic = {}

	return
end

function var_0_1.didEnter(arg_10_0)
	onButton = var_1_10001

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.btnBack

	local function var_10_2()
		local var_11_0 = arg_10_0

		var_0.closeView(var_11_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_10_0, var_10_1, var_10_2, var_1_10005)

	onButton = var_1_10001

	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_0.btnTask

	local function var_10_5()
		local var_12_1

		if arg_10_0.phase < #arg_10_0.awardList then
			local var_12_0 = arg_10_0

			var_12_1 = var_12_1.emit
			CrusingMediator = var_2_10002

			var_12_1(var_12_0, var_2_10002.EVENT_OPEN_TASK)
		else
			pg = var_12_1

			local var_12_2 = var_12_1.TipsMgr.GetInstance()
			local var_12_3 = var_0.ShowTips

			i18n = var_2_10002

			var_12_3(var_12_2, var_2_10002("battlepass_complete"))
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_10_3, var_10_4, var_10_5, var_1_10005)

	onButton = var_1_10001

	local var_10_6 = arg_10_0
	local var_10_7 = arg_10_0.btnAll

	local function var_10_8()
		local var_13_0 = arg_10_0.activity

		if #var_0.GetCrusingUnreceiveAward(var_13_0) > 0 then
			local var_13_1 = {}
			local var_13_2 = arg_10_0

			if var_2.checkLimitMax(var_13_2, var_0) then
				table = var_2

				var_2.insert(var_13_1, function(arg_14_0)
					pg = var_3_10001

					local var_14_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_14_1 = var_1.ShowMsgBox
					local var_14_2 = {}

					i18n = var_3_10004
					var_14_2.content = var_3_10004("player_expResource_mail_fullBag")
					var_14_2.onYes = arg_14_0

					var_14_1(var_14_0, var_14_2)

					return
				end)
			end

			seriesAsync = var_2

			var_2(var_13_1, function()
				local var_15_0 = arg_10_0
				local var_15_1 = var_0.emit

				CrusingMediator = var_3_10002

				var_15_1(var_15_0, var_3_10002.EVENT_GET_AWARD_ALL)

				return
			end)
		end

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1_10001(var_10_6, var_10_7, var_10_8, var_1_10005)

	onButton = var_1_10001

	local var_10_9 = arg_10_0
	local var_10_10 = arg_10_0.btnPay

	local function var_10_11()
		local var_16_0 = arg_10_0

		var_0.openBuyPanel(var_16_0)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1_10001(var_10_9, var_10_10, var_10_11, var_1_10005)

	onButton = var_1_10001

	local var_10_12 = arg_10_0
	local var_10_13 = arg_10_0.btnAfter

	local function var_10_14()
		local var_17_0 = arg_10_0.activity

		if #var_0.GetCrusingUnreceiveAward(var_17_0) > 0 then
			local var_17_1 = {}
			local var_17_2 = arg_10_0

			if var_2.checkLimitMax(var_17_2, var_0) then
				table = var_2

				var_2.insert(var_17_1, function(arg_18_0)
					pg = var_3_10001

					local var_18_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_18_1 = var_1.ShowMsgBox
					local var_18_2 = {}

					i18n = var_3_10004
					var_18_2.content = var_3_10004("player_expResource_mail_fullBag")
					var_18_2.onYes = arg_18_0

					var_18_1(var_18_0, var_18_2)

					return
				end)
			end

			seriesAsync = var_2

			var_2(var_17_1, function()
				local var_19_0 = arg_10_0
				local var_19_1 = var_0.emit

				CrusingMediator = var_3_10002

				var_19_1(var_19_0, var_3_10002.EVENT_GET_AWARD_ALL)

				return
			end)
		end

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1_10001(var_10_12, var_10_13, var_10_14, var_1_10005)

	onButton = var_1_10001

	local var_10_15 = arg_10_0
	local var_10_16 = arg_10_0.btnHelp

	local function var_10_17()
		pg = var_2_10000

		local var_20_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_20_1 = var_0.ShowMsgBox
		local var_20_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_20_2.type = var_2_10003
		i18n = var_2_10003

		local var_20_3 = "battlepass_main_help_"

		pg = var_2_10005
		var_20_2.helps = var_2_10003(var_20_3 .. var_2_10005.battlepass_event_pt[arg_10_0.activity.id].map_name)

		var_20_1(var_20_0, var_20_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_10_15, var_10_16, var_10_17, var_1_10005)

	local function var_10_18(arg_21_0)
		local var_21_0 = {
			_tf = arg_21_0,
			rtLine = arg_21_0:Find("line"),
			rtIcon = arg_21_0:Find("icon"),
			rtSimple = arg_21_0:Find("simple")
		}

		setParent = var_2

		var_2(arg_21_0, arg_10_0.scrollMap)

		SetCompomentEnabled = var_2

		local var_21_1 = arg_21_0

		typeof = var_4
		Image = var_2_10005

		var_2(var_21_1, var_4(var_2_10005), false)

		arg_21_0.name = "map_tpl"
		SetAction = var_2

		local var_21_2 = var_21_0.rtIcon
		local var_21_3 = var_3.Find(var_21_2, "model")

		var_2(var_3.GetChild(var_21_3, 0), "normal")

		return var_21_0
	end

	arg_10_0.maps = {
		var_10_18(arg_10_0.rtMap)
	}

	while #arg_10_0.maps < 3 do
		table = var_10_19

		local var_10_19 = var_10_19.insert
		local var_10_20 = arg_10_0.maps
		local var_10_21 = var_10_18

		tf = var_1_10005
		Instantiate = var_1_10006

		var_10_19(var_10_20, var_10_21(var_1_10005(var_1_10006(arg_10_0.rtMap))))
	end

	Canvas = var_10_19

	var_10_19.ForceUpdateCanvases()

	ipairs = var_2

	for iter_10_0, iter_10_1 in var_2(arg_10_0.maps) do
		setParent = var_1_10007
		var_1_10008 = iter_10_1.rtLine

		local var_10_22 = arg_10_0.scrollMap

		var_1_10007(var_1_10008, var_9.Find(var_10_22, "bg"), true)
	end

	GetComponent = var_2

	local var_10_23 = var_2(arg_10_0.textTip, "RichText")
	local var_10_24 = var_2.AddSprite
	local var_10_25 = "pt"

	GetSpriteFromAtlas = iter_10_0
	Drop = iter_10_1

	local var_10_26 = iter_10_1.New
	local var_10_27 = {}

	DROP_TYPE_VITEM = var_1_10008
	var_10_27.type = var_1_10008
	var_10_27.id = arg_10_0.ptId

	local var_10_28 = var_10_26(var_10_27)

	var_10_24(var_10_23, var_10_25, iter_10_0(var_6.getIcon(var_10_28), ""))

	setText = var_10_24

	local var_10_29 = arg_10_0.textTip

	i18n = var_10_25

	local var_10_30 = "battlepass_main_tip_"

	pg = var_6

	var_10_24(var_10_29, var_10_25(var_10_30 .. var_6.battlepass_event_pt[arg_10_0.activity.id].map_name))

	local var_10_31 = arg_10_0.activity.stopTime

	pg = var_10_29

	local var_10_32 = var_10_29.TimeMgr.GetInstance()
	local var_10_33 = var_10_31 - var_3.GetServerTime(var_10_32)

	setText = var_3

	local var_10_34 = arg_10_0.textDay

	i18n = var_5

	local var_10_35 = "battlepass_main_time"

	math = var_7

	local var_10_36 = var_7.floor(var_10_33 / 0)

	math = var_8

	var_3(var_10_34, var_5(var_10_35, var_10_36, var_8.floor(var_10_33 % 0 / 16)))

	GetComponent = var_3

	local var_10_37 = arg_10_0.scrollMap

	typeof = var_5
	ScrollRect = var_10_35

	local var_10_38 = var_3(var_10_37, var_5(var_10_35)).content.rect.width
	local var_10_39 = var_3.viewport.rect.width
	local var_10_40 = var_10_38 / 3 / (var_10_38 - var_10_39)

	onScroll = var_8

	var_8(arg_10_0, arg_10_0.scrollMap, function(arg_22_0)
		if arg_22_0.x < 0.1 then
			local var_22_0 = var_0.velocity
			local var_22_1 = var_0.normalizedPosition

			var_22_1.x = arg_22_0.x + var_10_40
			var_0.normalizedPosition = var_22_1
			var_0.velocity = var_22_0
		elseif arg_22_0.x > 0.9 then
			local var_22_2 = var_0.velocity
			local var_22_3 = var_0.normalizedPosition

			var_22_3.x = arg_22_0.x - var_10_40
			var_0.normalizedPosition = var_22_3
			var_0.velocity = var_22_2
		end

		return
	end)
	arg_10_0:onScroll(arg_10_0.comScroll, function(arg_23_0)
		local var_23_0 = arg_10_0

		var_1.updateNextAward(var_23_0, arg_23_0.y)

		return
	end)
	arg_10_0:updateAwardPanel()
	arg_10_0:buildPhaseAwardScrollPos()

	if arg_10_0.phase == 0 then
		local var_10_41 = arg_10_0.comScroll

		var_8.ScrollTo(var_10_41, 0)
	elseif arg_10_0.phase == #arg_10_0.awardList then
		local var_10_42 = arg_10_0.comScroll

		var_8.ScrollTo(var_10_42, 1)
	else
		local var_10_43 = arg_10_0.comScroll
		local var_10_44 = var_8.ScrollTo

		math = var_10

		var_10_44(var_10_43, var_10.clamp(arg_10_0.phasePos[arg_10_0.phase], 0, 1))
	end

	local var_10_45 = arg_10_0

	arg_10_0.updateMapStatus(var_10_45)

	LoadImageSpriteAtlasAsync = var_8
	Drop = var_10_45

	local var_10_46 = var_10_45.New
	local var_10_47 = {}

	DROP_TYPE_VITEM = var_11
	var_10_47.type = var_11
	var_10_47.id = arg_10_0.ptId

	local var_10_48 = var_10_46(var_10_47)
	local var_10_49 = var_9.getIcon(var_10_48)
	local var_10_50 = ""
	local var_10_51 = arg_10_0.sliderPt

	var_8(var_10_49, var_10_50, var_11.Find(var_10_51, "Text/icon"), true)
	arg_10_0:updateMapWay()

	return
end

function var_0_1.willExit(arg_24_0)
	pairs = var_1_10001

	for iter_24_0, iter_24_1 in var_1_10001(arg_24_0.LTDic) do
		if iter_24_1 then
			LeanTween = var_1_10006

			var_1_10006.cancel(iter_24_0)
		end
	end

	PoolMgr = var_1

	local var_24_0 = var_1.GetInstance()

	pg = var_2

	local var_24_1 = var_2.battlepass_event_pt[arg_24_0.activity.id].crusing_map

	pg = var_3

	local var_24_2 = var_3.battlepass_event_pt[arg_24_0.activity.id].spine_name

	ipairs = var_4

	for iter_24_2, iter_24_3 in var_4(arg_24_0.maps) do
		setParent = var_1_10009

		var_1_10009(iter_24_3.rtLine, iter_24_3._tf, true)

		local var_24_3 = var_24_0

		var_1_10009 = var_24_0.ReturnSpineChar

		local var_24_4 = var_24_2

		go = var_12

		local var_24_5 = iter_24_3.rtIcon
		local var_24_6 = var_13.Find(var_24_5, "model")

		var_1_10009(var_24_3, var_24_4, var_12(var_13.GetChild(var_24_6, 0)))

		local var_24_7 = var_24_0

		var_1_10009 = var_24_0.ReturnPrefab

		local var_24_8 = "crusingmap/" .. var_24_1
		local var_24_9 = ""

		go = var_13

		var_1_10009(var_24_7, var_24_8, var_24_9, var_13(iter_24_3._tf))
	end

	if arg_24_0.chargeTipWindow then
		local var_24_10 = arg_24_0.chargeTipWindow

		var_4.Destroy(var_24_10)

		arg_24_0.chargeTipWindow = nil
	end

	return
end

function var_0_1.setActivity(arg_25_0, arg_25_1)
	arg_25_0.activity = arg_25_1
	pairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_1:GetCrusingInfo()) do
		arg_25_0[iter_25_0] = iter_25_1
	end

	return
end

function var_0_1.setPlayer(arg_26_0, arg_26_1)
	arg_26_0.player = arg_26_1

	return
end

function var_0_1.updateAwardInfo(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_2.pt <= arg_27_0.pt

	if arg_27_1:Find("mask") then
		setActive = var_4

		var_4(arg_27_1:Find("mask"), not var_27_0)
	end

	setText = var_4

	var_4(arg_27_1:Find("Text"), arg_27_2.id)

	Drop = var_4

	local var_27_1 = var_4.Create(arg_27_2.award)

	updateDrop = var_5

	var_5(arg_27_1:Find("award"), var_27_1)

	setActive = var_5

	var_5(arg_27_1:Find("award/get"), var_27_0 and not arg_27_0.awardDic[arg_27_2.pt])

	setActive = var_5

	var_5(arg_27_1:Find("award/got"), arg_27_0.awardDic[arg_27_2.pt])

	setActive = var_5

	var_5(arg_27_1:Find("award/mask"), arg_27_0.awardDic[arg_27_2.pt])

	onButton = var_5

	local var_27_2 = arg_27_0
	local var_27_3 = arg_27_1:Find("award")

	local function var_27_4()
		local var_28_0 = arg_27_0

		var_0.emit(var_28_0, var_0_1.ON_DROP, var_27_1)

		return
	end

	SFX_CONFIRM = var_9

	var_5(var_27_2, var_27_3, var_27_4, var_9)

	Drop = var_5

	local var_27_5 = var_5.Create(arg_27_2.award_pay)

	updateDrop = var_6

	var_6(arg_27_1:Find("award_pay"), var_27_5)

	setActive = var_6

	var_6(arg_27_1:Find("award_pay/lock"), not arg_27_0.isPay)

	setActive = var_6

	local var_27_6 = arg_27_1:Find("award_pay/get")
	local var_27_7

	if arg_27_0.isPay then
		var_27_7 = var_27_0 and not arg_27_0.awardPayDic[arg_27_2.pt]
	end

	var_6(var_27_6, var_27_7)

	setActive = var_6

	var_6(arg_27_1:Find("award_pay/got"), arg_27_0.awardPayDic[arg_27_2.pt])

	setActive = var_6

	var_6(arg_27_1:Find("award_pay/mask"), not arg_27_0.isPay or arg_27_0.awardPayDic[arg_27_2.pt])

	onButton = var_6

	local var_27_8 = arg_27_0
	local var_27_9 = arg_27_1:Find("award_pay")

	local function var_27_10()
		local var_29_0 = arg_27_0

		var_0.emit(var_29_0, var_0_1.ON_DROP, var_27_5)

		return
	end

	SFX_CONFIRM = var_10

	var_6(var_27_8, var_27_9, var_27_10, var_10)

	return
end

function var_0_1.updateAwardPanel(arg_30_0)
	setText = var_1_10001

	var_1_10001(arg_30_0.textPhase, arg_30_0.phase)

	local var_30_0

	if arg_30_0.phase < #arg_30_0.awardList then
		var_30_0 = arg_30_0.phase == 0 and 0 or arg_30_0.awardList[arg_30_0.phase].pt

		local var_30_1 = arg_30_0.pt - var_30_0
		local var_30_2 = arg_30_0.awardList[arg_30_0.phase + 1].pt - var_30_0

		setSlider = var_4

		var_4(arg_30_0.sliderPt, 0, var_30_2, var_30_1)

		setText = var_4

		local var_30_3 = arg_30_0.sliderPt

		var_4(var_5.Find(var_30_3, "Text"), var_30_1 .. "/" .. var_30_2)
	else
		setSlider = var_30_0

		var_30_0(arg_30_0.sliderPt, 0, 1, 1)

		setText = var_30_0

		local var_30_4 = arg_30_0.sliderPt

		var_30_0(var_2.Find(var_30_4, "Text"), "MAX")
	end

	arg_30_0.nextAward = nil

	local var_30_5 = arg_30_0.comScroll

	var_1.SetTotalCount(var_30_5, #arg_30_0.awardList - 1)
	arg_30_0:updateNextAward(arg_30_0.comScroll.value)

	local var_30_6 = arg_30_0.activity
	local var_30_7 = #var_1.GetCrusingUnreceiveAward(var_30_6)
	local var_30_8 = 0 < var_30_7

	setActive = var_2

	var_2(arg_30_0.btnAll, not arg_30_0.isPay and var_30_8)

	setActive = var_2

	var_2(arg_30_0.btnPay, not arg_30_0.isPay)

	setActive = var_2

	local var_30_9 = arg_30_0.rtAward

	var_2(var_3.Find(var_30_9, "text_image_3"), not arg_30_0.isPay)

	setActive = var_2

	local var_30_10 = arg_30_0.btnFinish
	local var_30_11

	if arg_30_0.isPay then
		var_30_11 = arg_30_0.phase == #arg_30_0.awardList and not var_30_8
	end

	var_2(var_30_10, var_30_11)

	setActive = var_2

	local var_30_12 = arg_30_0.btnAfter
	local var_30_13

	if arg_30_0.isPay then
		isActive = var_30_13
		var_30_13 = not var_30_13(arg_30_0.btnFinish)
	end

	var_2(var_30_12, var_30_13)

	setButtonEnabled = var_2

	var_2(arg_30_0.btnAfter, var_30_8)

	return
end

function var_0_1.updateMapStatus(arg_31_0)
	ipairs = var_1_10001

	for iter_31_0, iter_31_1 in var_1_10001(arg_31_0.maps) do
		local var_31_0
		local var_31_1 = {}

		eachChild = var_1_10008

		var_1_10008(iter_31_1.rtLine, function(arg_32_0)
			tonumber = var_2_10001

			local var_32_0 = var_2_10001(arg_32_0.name)
			local var_32_1

			if arg_31_0.phase < var_32_0 then
				if not var_31_0 then
					var_31_0 = var_32_0
					table = var_32_1

					var_32_1.insert(var_31_1, arg_32_0)

					setActive = var_32_1

					var_32_1(arg_32_0, true)
				elseif var_32_0 < var_31_0 then
					::label_32_0::

					var_32_1 = #var_31_1

					if 0 < var_32_1 then
						repeat
							setActive = var_32_1
							table = var_2_10003

							var_32_1(var_2_10003.remove(var_31_1), false)

							goto label_32_0
						until true
					end

					var_31_0 = var_32_0
					table = var_32_1

					var_32_1.insert(var_31_1, arg_32_0)

					setActive = var_32_1

					var_32_1(arg_32_0, true)
				elseif var_31_0 == var_32_0 then
					table = var_32_1

					var_32_1.insert(var_31_1, arg_32_0)

					setActive = var_32_1

					var_32_1(arg_32_0, true)
				else
					setActive = var_32_1

					var_32_1(arg_32_0, false)
				end
			else
				setActive = var_32_1

				var_32_1(arg_32_0, true)
			end

			local var_32_2 = var_32_0 > arg_31_0.phase

			setGray = var_2_10003

			var_2_10003(arg_32_0, not var_32_2, false)

			setImageAlpha = var_2_10003

			var_2_10003(arg_32_0, var_32_2 and 1 or 0.9)

			isActive = var_2_10003

			if var_2_10003(arg_32_0) then
				local var_32_3

				local function var_32_4(arg_33_0, arg_33_1)
					getImageSprite = var_3_10002

					if var_3_10002(arg_33_0) then
						setImageSprite = var_3

						var_3(arg_33_1, var_2)
					end

					eachChild = var_3

					var_3(arg_33_0, function(arg_34_0)
						local var_34_0 = var_32_4
						local var_34_1 = arg_34_0
						local var_34_2 = arg_33_1

						var_34_0(var_34_1, var_3.Find(var_34_2, arg_34_0.name))

						return
					end)

					return
				end

				local var_32_5 = iter_31_1.rtSimple
				local var_32_6 = var_4.Find(var_32_5, var_32_2 and "active" or "gray")

				eachChild = var_32_5

				var_32_5(arg_32_0, function(arg_35_0)
					local var_35_0 = var_32_4
					local var_35_1 = var_32_6

					var_35_0(var_2.Find(var_35_1, arg_35_0.name), arg_35_0)

					return
				end)
			end

			return
		end)
	end

	return
end

function var_0_1.updateMapWay(arg_36_0)
	if arg_36_0.exited or arg_36_0.contextData.frozenMapUpdate then
		return
	end

	PlayerPrefs = var_1

	local var_36_0 = var_1.GetInt

	string = var_1_10002

	local var_36_1 = var_36_0(var_1_10002.format("crusing_%d_phase_display", arg_36_0.activity.id), 0)

	PlayerPrefs = var_2

	local var_36_2 = var_2.SetInt

	string = var_3

	var_36_2(var_3.format("crusing_%d_phase_display", arg_36_0.activity.id), arg_36_0.phase)

	ipairs = var_36_2

	for iter_36_0, iter_36_1 in var_36_2(arg_36_0.maps) do
		GetComponent = var_1_10007

		local var_36_3 = iter_36_1.rtIcon

		typeof = var_1_10009
		Animator = var_1_10010
		var_1_10007 = var_1_10007(var_36_3, var_1_10009(var_1_10010))

		if var_36_1 < arg_36_0.phase then
			local var_36_4 = arg_36_0.PhaseFrame[var_36_1]

			var_1_10009 = arg_36_0.PhaseFrame[arg_36_0.phase]
			var_1_10007.speed = var_0_1.PlaySpeed

			var_1_10007:Play("empty")
			var_1_10007:Play("mix", 0, var_36_4 / arg_36_0.AllFrameCount)

			local var_36_5 = iter_36_1.rtIcon

			var_1_10010 = var_1_10010.Find(var_36_5, "model").childCount

			if 0 < var_1_10010 then
				SetAction = var_1_10010

				local var_36_6 = iter_36_1.rtIcon
				local var_36_7 = var_11.Find(var_36_6, "model")

				var_1_10010(var_11.GetChild(var_36_7, 0), "move")
			end

			var_1_10010 = nil
			LeanTween = var_11

			local var_36_8 = var_11.delayedCall
			local var_36_9 = (var_1_10009 - var_36_4) / var_0_1.FrameSpeed / var_0_1.PlaySpeed

			System = var_13
			var_1_10010 = var_36_8(var_36_9, var_13.Action(function()
				var_1_10007.speed = 0

				local var_37_0 = var_1_10007

				var_0.Play(var_37_0, "empty")

				local var_37_1 = var_1_10007

				var_0.Play(var_37_1, "mix", 0, var_1_10009 / arg_36_0.AllFrameCount)

				arg_36_0.LTDic[var_1_10010] = false

				local var_37_2 = iter_36_1.rtIcon

				if var_0.Find(var_37_2, "model").childCount > 0 then
					SetAction = var_0

					local var_37_3 = iter_36_1.rtIcon
					local var_37_4 = var_1.Find(var_37_3, "model")

					var_0(var_1.GetChild(var_37_4, 0), "normal")
				end

				return
			end)).uniqueId
			arg_36_0.LTDic[var_1_10010] = true
		else
			var_1_10007.speed = 0
			var_1_10009 = var_1_10007

			var_1_10007.Play(var_1_10009, "empty")

			var_1_10009 = var_1_10007

			var_1_10007.Play(var_1_10009, "mix", 0, arg_36_0.PhaseFrame[arg_36_0.phase] / arg_36_0.AllFrameCount)
		end
	end

	return
end

function var_0_1.buildPhaseAwardScrollPos(arg_38_0)
	arg_38_0.phasePos = {}

	for iter_38_0 = 1, #arg_38_0.awardList - 1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.insert

		local var_38_0 = arg_38_0.phasePos
		local var_38_1 = arg_38_0.comScroll

		var_1_10005(var_38_0, var_7.HeadIndexToValue(var_38_1, iter_38_0 - 1))
	end

	return
end

function var_0_1.onScroll(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_1.onValueChanged

	assert = var_1_10004

	var_1_10004(arg_39_2, "callback should exist")
	var_39_0:RemoveAllListeners()

	pg = var_4

	var_4.DelegateInfo.Add(arg_39_0, var_39_0)
	var_39_0:AddListener(arg_39_2)

	return
end

function var_0_1.updateNextAward(arg_40_0, arg_40_1)
	if not arg_40_0.phasePos then
		return
	end

	local var_40_0 = arg_40_0.phasePos[#arg_40_0.phasePos] - 1

	for iter_40_0 = #arg_40_0.awardList - 1, 1, -1 do
		local var_40_1 = arg_40_0.awardList[iter_40_0]
		local var_40_2

		if arg_40_0.phasePos[iter_40_0] < arg_40_1 + var_40_0 or var_40_1.pt <= arg_40_0.pt then
			break
		elseif var_40_1.isImportent then
			var_40_2 = iter_40_0
		end
	end

	if arg_40_0.nextAward ~= var_40_2 then
		arg_40_0.nextAward = var_40_2

		arg_40_0:updateAwardInfo(arg_40_0.rtNextAward, arg_40_0.awardList[var_40_2])
	end

	return
end

function var_0_1.checkLimitMax(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.player

	ipairs = var_1_10003

	for iter_41_0, iter_41_1 in var_1_10003(arg_41_1) do
		local var_41_1 = iter_41_1.type

		DROP_TYPE_RESOURCE = var_1_10009

		if var_41_1 == var_1_10009 then
			if iter_41_1.id == 1 then
				var_1_10009 = var_41_0

				if var_41_0.GoldMax(var_1_10009, iter_41_1.count) then
					pg = var_8
					var_1_10009 = var_8.TipsMgr.GetInstance()

					local var_41_2 = var_8.ShowTips

					i18n = var_1_10010

					var_41_2(var_1_10009, var_1_10010("gold_max_tip_title"))

					return true
				end
			elseif iter_41_1.id == 2 then
				var_1_10009 = var_41_0

				if var_41_0.OilMax(var_1_10009, iter_41_1.count) then
					pg = var_8
					var_1_10009 = var_8.TipsMgr.GetInstance()

					local var_41_3 = var_8.ShowTips

					i18n = var_1_10010

					var_41_3(var_1_10009, var_1_10010("oil_max_tip_title"))

					return true
				end
			end
		else
			local var_41_4 = iter_41_1.type

			DROP_TYPE_ITEM = var_1_10009

			if var_41_4 == var_1_10009 then
				Item = var_41_4
				var_1_10009 = var_41_4.getConfigData(iter_41_1.id).type
				Item = var_1_10010

				if var_1_10009 == var_1_10010.EXP_BOOK_TYPE then
					getProxy = var_1_10009
					BagProxy = var_1_10010
					var_1_10010 = var_1_10009(var_1_10010)
					var_1_10009 = var_1_10009.getItemCountById(var_1_10010, iter_41_1.id) + iter_41_1.count

					if var_8.max_num < var_1_10009 then
						return true
					end
				end
			end
		end
	end

	return false
end

function var_0_1.openBuyPanel(arg_42_0)
	local var_42_0 = arg_42_0
	local var_42_1 = arg_42_0.getPassID(var_42_0)

	Goods = var_42_0

	local var_42_2 = var_42_0.Create
	local var_42_3 = {
		shop_id = var_42_1
	}

	Goods = var_1_10004

	local var_42_4 = var_42_2(var_42_3, var_1_10004.TYPE_CHARGE)
	local var_42_5 = var_2.getConfig(var_42_4, "tag")
	local var_42_6 = var_2:GetExtraServiceItem()
	local var_42_7 = var_2:GetExtraDrop()
	local var_42_8
	local var_42_9
	local var_42_10

	i18n = var_1_10009

	local var_42_11 = var_1_10009("battlepass_pay_tip")
	local var_42_12 = {
		isChargeType = true,
		commodity = var_2,
		infoTip = var_2:GetInfoTip(),
		icon = "chargeicon/" .. var_2:getConfig("picture"),
		name = var_2:getConfig("name_display"),
		tipExtra = var_42_11,
		extraItems = var_42_6,
		price = var_2:getConfig("money"),
		isLocalPrice = var_2:IsLocalPrice(),
		tagType = var_42_5,
		isMonthCard = var_2:isMonthCard(),
		tipBonus = var_42_10,
		bonusItem = var_42_8,
		extraDrop = var_42_7,
		descExtra = var_2:getConfig("descrip_extra"),
		onYes = function()
			ChargeConst = var_2_10000

			local var_43_1

			if var_2_10000.isNeedSetBirth() then
				local var_43_0 = arg_42_0

				var_43_1 = var_43_1.emit
				CrusingMediator = var_2_10002

				var_43_1(var_43_0, var_2_10002.EVENT_OPEN_BIRTHDAY)
			else
				pg = var_43_1

				local var_43_2 = var_43_1.m02
				local var_43_3 = var_0.sendNotification

				GAME = var_2_10002

				var_43_3(var_43_2, var_2_10002.CHARGE_OPERATION, {
					shopId = var_0.id
				})
			end

			return
		end
	}
	local var_42_13 = arg_42_0
	local var_42_14 = arg_42_0.emit

	CrusingMediator = var_12

	var_42_14(var_42_13, var_12.EVENT_GO_CHARGE, var_42_12)

	return
end

function var_0_1.getPassID(arg_44_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_44_0 = var_1_10001(var_1_10002)
	local var_44_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	if var_44_1(var_44_0, var_1_10004.ACTIVITY_TYPE_PT_CRUSING) then
		local var_44_2 = var_2

		if not var_2.isEnd(var_44_2) then
			ipairs = var_3
			pg = var_44_2

			for iter_44_0, iter_44_1 in var_3(var_44_2.pay_data_display.all) do
				pg = var_1_10008

				if var_1_10008.pay_data_display[iter_44_1].sub_display then
					type = var_9

					if var_9(var_1_10008.sub_display) == "table" and var_1_10008.sub_display[1] == var_2.id then
						return iter_44_1
					end
				end
			end
		end
	end

	return
end

function var_0_1.OnChargeSuccess(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0.chargeTipWindow

	var_2.ExecuteAction(var_45_0, "Show", arg_45_1)

	return
end

return var_0_1
