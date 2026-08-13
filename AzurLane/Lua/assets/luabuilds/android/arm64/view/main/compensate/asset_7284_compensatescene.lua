class = var_0_10000

local var_0_0 = "CompensateScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "CompensateUI"
end

function var_0_1.ResUISettings(arg_2_0)
	return false
end

var_0_1.optionsPath = {
	"adapt/top/option"
}

function var_0_1.quickExitFunc(arg_3_0)
	arg_3_0:emit(var_0_1.ON_HOME)

	return
end

function var_0_1.init(arg_4_0)
	getProxy = var_1_10001
	CompensateProxy = var_1_10003
	arg_4_0.proxy = var_1_10001(var_1_10003)

	local var_4_0 = arg_4_0._tf

	arg_4_0.rtAdapt = var_1.Find(var_4_0, "adapt")
	setText = var_1

	local var_4_1 = arg_4_0.rtAdapt
	local var_4_2 = var_3.Find(var_4_1, "top/title")

	i18n = var_4

	var_1(var_4_2, var_4("compensate_ui_title1"))

	setText = var_1

	local var_4_3 = arg_4_0.rtAdapt
	local var_4_4 = var_3.Find(var_4_3, "top/title/Text")

	i18n = var_4

	var_1(var_4_4, var_4("compensate_ui_title2"))

	onButton = var_1

	local var_4_5 = arg_4_0
	local var_4_6 = arg_4_0.rtAdapt
	local var_4_7 = var_4.Find(var_4_6, "top/back_btn")

	local function var_4_8()
		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_4_6

	var_1(var_4_5, var_4_7, var_4_8, var_4_6)

	local var_4_9 = arg_4_0.rtAdapt

	arg_4_0.rtLabels = var_1.Find(var_4_9, "left_length/frame/tagRoot")
	eachChild = var_1

	var_1(arg_4_0.rtLabels, function(arg_6_0)
		local var_6_0
		local var_6_1

		if arg_6_0.name == "mail" then
			i18n = var_6_1
			var_6_1 = var_6_1("compensate_ui_title1")
			var_6_1 = toggleName
		end

		setText = var_6_1

		local var_6_2 = arg_6_0:Find("unSelect/Text")

		toggleName = var_2_10005

		var_6_1(var_6_2, var_2_10005)

		setText = var_6_1

		local var_6_3 = arg_6_0:Find("selected/Text")

		toggleName = var_2_10005

		var_6_1(var_6_3, var_2_10005)

		onToggle = var_6_1

		local var_6_4 = arg_4_0
		local var_6_5 = arg_6_0

		local function var_6_6(arg_7_0)
			if arg_7_0 then
				local var_7_0 = arg_4_0

				var_1.SetPage(var_7_0)
			end

			return
		end

		SFX_PANEL = var_7

		var_6_1(var_6_4, var_6_5, var_6_6, var_7)

		return
	end)

	local var_4_10 = arg_4_0.rtAdapt
	local var_4_11 = var_1.Find(var_4_10, "main/content")

	arg_4_0.rtMailLeft = var_1.Find(var_4_11, "left/left_content")

	local var_4_12 = arg_4_0.rtMailLeft
	local var_4_13 = var_2.Find(var_4_12, "middle/container")

	arg_4_0.lsrMailList = var_2.GetComponent(var_4_13, "LScrollRect")

	function arg_4_0.lsrMailList.onUpdateItem(arg_8_0, arg_8_1)
		arg_8_0 = arg_8_0 + 1
		tf = var_2_10002

		local var_8_0 = var_2_10002(arg_8_1)
		local var_8_1 = arg_4_0.filterMails[arg_8_0]

		onToggle = var_4

		local var_8_2 = arg_4_0
		local var_8_3 = var_8_0

		local function var_8_4(arg_9_0)
			if arg_9_0 then
				if arg_4_0.selectMailId ~= var_8_1.id then
					local var_9_0 = arg_4_0

					var_1.UpdateMailContent(var_9_0, var_8_1)
				end
			elseif var_8_1.id == arg_4_0.selectMailId then
				local var_9_1 = arg_4_0

				var_1.UpdateMailContent(var_9_1, nil)
			end

			return
		end

		SFX_PANEL = var_2_10009

		var_4(var_8_2, var_8_3, var_8_4, var_2_10009)

		local var_8_5 = arg_4_0

		var_4.UpdateMailTpl(var_8_5, var_8_0, var_8_1)

		return
	end

	arg_4_0.rtMailRight = var_1:Find("right")

	local var_4_14 = arg_4_0.rtMailRight

	arg_4_0.rtBtnRightGet = var_2.Find(var_4_14, "bottom/btn_get")
	onButton = var_2

	local var_4_15 = arg_4_0
	local var_4_16 = arg_4_0.rtBtnRightGet

	local function var_4_17()
		assert = var_2_10000

		var_2_10000(arg_4_0.selectMailId)

		local var_10_0 = arg_4_0
		local var_10_1 = var_0.emit

		CompensateMediator = var_2_10003

		var_10_1(var_10_0, var_2_10003.ON_GET_REWARD, {
			reward_id = arg_4_0.selectMailId
		})

		return
	end

	SFX_PANEL = var_7

	var_2(var_4_15, var_4_16, var_4_17, var_7)

	arg_4_0.rtMailEmpty = var_1:Find("empty")
	setText = var_2

	local var_4_18 = arg_4_0.rtBtnRightGet
	local var_4_19 = var_4.Find(var_4_18, "Text")

	i18n = var_5

	var_2(var_4_19, var_5("mail_getone_button"))
	arg_4_0:InitResBar()

	return
end

function var_0_1.SetPage(arg_11_0)
	arg_11_0:UpdateMailList()

	return
end

function var_0_1.didEnter(arg_12_0)
	onNextTick = var_1_10001

	var_1_10001(function()
		local var_13_0 = arg_12_0.lsrMailList

		var_13_0.enabled = true
		triggerToggle = var_13_0

		local var_13_1 = arg_12_0.rtLabels

		var_13_0(var_2.Find(var_13_1, "mail"), true)

		return
	end)

	return
end

function var_0_1.UpdateMailList(arg_14_0)
	local var_14_0 = arg_14_0.proxy

	arg_14_0.filterMails = var_1.GetAllRewardList(var_14_0)
	table = var_1

	local var_14_1 = var_1.sort
	local var_14_2 = arg_14_0.filterMails

	CompareFuncs = var_1_10004

	var_14_1(var_14_2, var_1_10004({
		function(arg_15_0)
			return -arg_15_0.date
		end,
		function(arg_16_0)
			return -arg_16_0.id
		end
	}))

	if #arg_14_0.filterMails == 0 then
		setActive = var_1

		var_1(arg_14_0.rtMailLeft, false)

		setActive = var_1

		var_1(arg_14_0.rtMailRight, false)

		setActive = var_1

		var_1(arg_14_0.rtMailEmpty, true)

		setText = var_1
		var_1_10005 = arg_14_0.rtMailEmpty

		local var_14_3 = var_3.Find(var_1_10005, "Text")

		i18n = var_4

		var_1(var_14_3, var_4("compensate_ui_nothing1"))

		setText = var_1
		var_1_10005 = arg_14_0.rtMailEmpty

		local var_14_4 = var_3.Find(var_1_10005, "Text_en")

		i18n = var_4

		var_1(var_14_4, var_4("compensate_ui_nothing2"))
	else
		setActive = var_1

		var_1(arg_14_0.rtMailLeft, true)

		setActive = var_1

		var_1(arg_14_0.rtMailRight, true)

		setActive = var_1

		var_1(arg_14_0.rtMailEmpty, false)

		if not arg_14_0.selectMailId then
			arg_14_0:UpdateMailContent(arg_14_0.filterMails[1])
		end

		local var_14_5 = arg_14_0.lsrMailList
		local var_14_6 = var_1.SetTotalCount
		local var_14_7 = #arg_14_0.filterMails

		delta = var_1_10005
		var_1_10005 = var_1_10005 or -1

		var_14_6(var_14_5, var_14_7, var_1_10005)
	end

	return
end

function var_0_1.UpdateMailTpl(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1:Find("content")

	setActive = var_1_10004

	var_1_10004(var_17_0:Find("icon/no_attachment"), #arg_17_2.attachments == 0)

	setActive = var_1_10004

	var_1_10004(var_17_0:Find("icon/IconTpl"), #arg_17_2.attachments > 0)

	local var_17_1 = #arg_17_2.attachments

	if 0 < var_17_1 then
		updateDrop = var_17_1

		var_17_1(var_17_0:Find("icon/IconTpl"), arg_17_2.attachments[1])
	end

	setText = var_17_1

	local var_17_2 = var_17_0:Find("info/title/Text")

	shortenString = var_7

	var_17_1(var_17_2, var_7(arg_17_2.title, 10))

	setText = var_17_1

	local var_17_3 = var_17_0
	local var_17_4 = var_17_0.Find(var_17_3, "info/time/Text")

	os = var_7

	var_17_1(var_17_4, var_7.date("%Y-%m-%d", arg_17_2.date))

	local var_17_5 = arg_17_2.timestamp

	pg = var_5

	local var_17_6 = var_5.TimeMgr.GetInstance()
	local var_17_7 = var_17_5 - var_5.GetServerTime(var_17_6)

	math = var_5

	local var_17_8 = var_5.floor(var_17_7 / 0)
	local var_17_9

	if 1 <= var_17_8 then
		setText = var_17_8
		var_17_9 = var_17_0:Find("info/time/out_time/Text")
		i18n = var_17_3

		local var_17_10 = "compensate_ui_expiration_day"

		math = var_1_10011

		var_17_8(var_17_9, var_17_3(var_17_10, var_1_10011.floor(var_17_7 / 0)))
	else
		setText = var_17_8
		var_17_9 = var_17_0:Find("info/time/out_time/Text")
		i18n = var_17_3

		local var_17_11 = "compensate_ui_expiration_hour"

		math = var_1_10011

		var_17_8(var_17_9, var_17_3(var_17_11, var_1_10011.floor(var_17_7 / 16)))
	end

	local var_17_12 = arg_17_2.attachFlag

	setActive = var_6

	var_6(arg_17_1:Find("got_mark"), var_17_12)

	setText = var_6

	local var_17_13 = arg_17_1:Find("got_mark/got_text")

	i18n = var_9

	var_6(var_17_13, var_9("mail_reward_got"))

	setActive = var_6

	var_6(arg_17_1:Find("hasread_bg"), true)

	setActive = var_6

	var_6(arg_17_1:Find("noread_bg"), false)

	SummerFeastScene = var_6

	local var_17_14 = var_6.TransformColor("FFFFFF")

	setTextColor = var_17_9

	var_17_9(var_17_0:Find("info/title/Text"), var_17_14)

	setTextColor = var_17_9

	var_17_9(var_17_0:Find("info/time/Text"), var_17_14)

	triggerToggle = var_17_9

	var_17_9(arg_17_1, arg_17_0.selectMailId == arg_17_2.id)

	return
end

function var_0_1.UpdateMailContent(arg_18_0, arg_18_1)
	eachChild = var_1_10002

	var_1_10002(arg_18_0.rtMailRight, function(arg_19_0)
		setActive = var_2_10001

		local var_19_0 = arg_19_0

		tobool = var_2_10004

		var_2_10001(var_19_0, var_2_10004(arg_18_1))

		return
	end)

	if not arg_18_1 then
		arg_18_0.selectMailId = nil

		return
	end

	arg_18_0.selectMailId = arg_18_1.id
	changeToScrollText = var_2

	local var_18_0 = arg_18_0.rtMailRight
	local var_18_1 = var_4.Find(var_18_0, "main/title/info/Text")

	i18n2 = var_5

	var_2(var_18_1, var_5(arg_18_1.title))

	setText = var_2

	local var_18_2 = arg_18_0.rtMailRight

	var_2(var_4.Find(var_18_2, "main/from/Text"), arg_18_1.sender)

	setText = var_2

	local var_18_3 = arg_18_0.rtMailRight
	local var_18_4 = var_4.Find(var_18_3, "main/time/Text")

	os = var_5

	var_2(var_18_4, var_5.date("%Y-%m-%d", arg_18_1.date))

	setText = var_2

	local var_18_5 = arg_18_0.rtMailRight

	var_2(var_4.Find(var_18_5, "main/view/content/text/Text"), arg_18_1.text)

	local var_18_6 = arg_18_0.rtMailRight
	local var_18_7 = var_2.Find(var_18_6, "main/view/content/attachment")

	setText = var_1_10003

	local var_18_8 = var_18_7:Find("got/Text")

	i18n = var_18_5

	var_1_10003(var_18_8, var_18_5("main_mailLayer_attachTaken"))

	setActive = var_1_10003

	var_1_10003(arg_18_0.rtBtnRightGet, not arg_18_1.attachFlag)

	setActive = var_1_10003

	var_1_10003(var_18_7, #arg_18_1.attachments > 0)

	local var_18_9 = #arg_18_1.attachments

	if 0 < var_18_9 then
		local var_18_10 = var_18_7
		local var_18_11 = var_18_7.Find(var_18_10, "content")

		UIItemList = var_4

		var_4.StaticAlign(var_18_11, var_18_11:Find("IconTpl"), #arg_18_1.attachments, function(arg_20_0, arg_20_1, arg_20_2)
			arg_20_1 = arg_20_1 + 1
			UIItemList = var_2_10003

			if arg_20_0 == var_2_10003.EventUpdate then
				local var_20_0 = arg_18_1.attachments[arg_20_1]

				updateDrop = var_2_10004

				var_2_10004(arg_20_2, var_20_0)

				onButton = var_2_10004

				local var_20_1 = arg_18_0
				local var_20_2 = arg_20_2

				local function var_20_3()
					local var_21_0 = arg_18_0

					var_0.emit(var_21_0, var_0_1.ON_DROP, var_20_0)

					return
				end

				SFX_PANEL = var_2_10009

				var_2_10004(var_20_1, var_20_2, var_20_3, var_2_10009)
			end

			return
		end)

		local var_18_12 = arg_18_1.attachFlag

		setCanvasGroupAlpha = var_18_10

		var_18_10(var_18_11, var_18_12 and 0.5 or 1)

		setActive = var_18_10

		var_18_10(var_18_7:Find("got"), var_18_12)
	end

	return
end

function var_0_1.onBackPressed(arg_22_0)
	triggerButton = var_1_10001

	local var_22_0 = arg_22_0.rtAdapt

	var_1_10001(var_3.Find(var_22_0, "top/back_btn"))

	return
end

function var_0_1.willExit(arg_23_0)
	return
end

function var_0_1.UpdateOperationDeal(arg_24_0)
	arg_24_0:UpdateMailList()

	if arg_24_0.selectMailId then
		local var_24_0 = arg_24_0
		local var_24_1 = arg_24_0.UpdateMailContent

		underscore = var_1_10004

		var_24_1(var_24_0, var_1_10004.detect(arg_24_0.filterMails, function(arg_25_0)
			return arg_25_0.id == arg_24_0.selectMailId
		end))
	end

	return
end

function var_0_1.InitResBar(arg_26_0)
	local var_26_0 = arg_26_0._tf

	arg_26_0.resBar = var_1.Find(var_26_0, "adapt/top/res")

	local var_26_1 = arg_26_0.resBar
	local var_26_2 = var_1.Find(var_26_1, "gold/max")
	local var_26_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_26_0.goldMax = var_26_3(var_26_2, var_4(var_1_10006))

	local var_26_4 = arg_26_0.resBar
	local var_26_5 = var_1.Find(var_26_4, "gold/Text")
	local var_26_6 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_26_0.goldValue = var_26_6(var_26_5, var_4(var_1_10006))

	local var_26_7 = arg_26_0.resBar
	local var_26_8 = var_1.Find(var_26_7, "oil/max")
	local var_26_9 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_26_0.oilMax = var_26_9(var_26_8, var_4(var_1_10006))

	local var_26_10 = arg_26_0.resBar
	local var_26_11 = var_1.Find(var_26_10, "oil/Text")
	local var_26_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_26_0.oilValue = var_26_12(var_26_11, var_4(var_1_10006))

	local var_26_13 = arg_26_0.resBar
	local var_26_14 = var_1.Find(var_26_13, "gem/Text")
	local var_26_15 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_26_0.gemValue = var_26_15(var_26_14, var_4(var_1_10006))
	onButton = var_1

	local var_26_16 = arg_26_0
	local var_26_17 = arg_26_0.resBar
	local var_26_18 = var_4.Find(var_26_17, "gold")

	local function var_26_19()
		pg = var_2_10000

		local var_27_0 = var_2_10000.playerResUI

		var_0.ClickGold(var_27_0)

		return
	end

	SFX_PANEL = var_26_17

	var_1(var_26_16, var_26_18, var_26_19, var_26_17)

	onButton = var_1

	local var_26_20 = arg_26_0
	local var_26_21 = arg_26_0.resBar
	local var_26_22 = var_4.Find(var_26_21, "oil")

	local function var_26_23()
		pg = var_2_10000

		local var_28_0 = var_2_10000.playerResUI

		var_0.ClickOil(var_28_0)

		return
	end

	SFX_PANEL = var_26_21

	var_1(var_26_20, var_26_22, var_26_23, var_26_21)

	onButton = var_1

	local var_26_24 = arg_26_0
	local var_26_25 = arg_26_0.resBar
	local var_26_26 = var_4.Find(var_26_25, "gem")

	local function var_26_27()
		pg = var_2_10000

		local var_29_0 = var_2_10000.playerResUI

		var_0.ClickGem(var_29_0)

		return
	end

	SFX_PANEL = var_26_25

	var_1(var_26_24, var_26_26, var_26_27, var_26_25)
	arg_26_0:UpdateRes()

	return
end

function var_0_1.UpdateRes(arg_30_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_30_0 = var_1_10001(var_1_10003)
	local var_30_1 = var_1.getRawData(var_30_0)

	PlayerResUI = var_1_10002

	var_1_10002.StaticFlush(var_30_1, arg_30_0.goldMax, arg_30_0.goldValue, arg_30_0.oilMax, arg_30_0.oilValue, arg_30_0.gemValue)

	return
end

return var_0_1
