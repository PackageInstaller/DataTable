class = var_0_10000

local var_0_0 = "RefluxScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.Sign = 1
var_0_1.Task = 2
var_0_1.PT = 3
var_0_1.Shop = 4

function var_0_1.getUIName(arg_1_0)
	return "RefluxUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	local function var_2_0()
		arg_2_1()

		return
	end

	getProxy = var_1_10003
	ShopsProxy = var_1_10005

	local var_2_1 = var_1_10003(var_1_10005)

	if var_3.ShouldRefreshChargeList(var_2_1) then
		pg = var_3

		local var_2_2 = var_3.m02
		local var_2_3 = var_3.sendNotification

		GAME = var_1_10006

		var_2_3(var_2_2, var_1_10006.GET_CHARGE_LIST, {
			callback = var_2_0
		})
	else
		var_2_0()
	end

	return
end

function var_0_1.init(arg_4_0)
	arg_4_0:findUI()
	arg_4_0:initData()
	arg_4_0:addListener()

	return
end

function var_0_1.didEnter(arg_5_0)
	local var_5_0 = arg_5_0

	arg_5_0.updateRedPotList(var_5_0)

	getProxy = var_1
	RefluxProxy = var_5_0

	local var_5_1 = var_1(var_5_0)

	if not var_1.isInRefluxTime(var_5_1) then
		arg_5_0:closeView()

		return
	end

	if not arg_5_0:tryOpenLetterView() then
		arg_5_0:tryAutoOpenLastView()
	end

	arg_5_0:updateDay()

	return
end

function var_0_1.willExit(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.viewList) do
		if iter_6_1 and iter_6_1:GetLoaded() then
			iter_6_1:Destroy()
		end
	end

	return
end

function var_0_1.onBackPressed(arg_7_0)
	if arg_7_0.letterView then
		local var_7_0 = arg_7_0.letterView

		if var_1.isShowing(var_7_0) then
			local var_7_1 = arg_7_0.letterView

			var_1.OnBackPress(var_7_1)

			return
		end
	end

	arg_7_0:closeView()

	return
end

function var_0_1.findUI(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.letterContainer = var_1.Find(var_8_0, "PanelLetter")

	local var_8_1 = arg_8_0._tf

	arg_8_0.panelContainer = var_1.Find(var_8_1, "PanelContainer")

	local var_8_2 = arg_8_0._tf
	local var_8_3 = var_1.Find(var_8_2, "left/left_bar")

	arg_8_0.letterBtn = var_1.Find(var_8_3, "letter")
	arg_8_0.signToggle = var_1:Find("tabs/sign")
	arg_8_0.taskToggle = var_1:Find("tabs/task")
	arg_8_0.ptToggle = var_1:Find("tabs/pt")
	arg_8_0.shopToggle = var_1:Find("tabs/shop")
	arg_8_0.toggleList = {
		[var_0_1.Sign] = arg_8_0.signToggle,
		[var_0_1.Task] = arg_8_0.taskToggle,
		[var_0_1.PT] = arg_8_0.ptToggle,
		[var_0_1.Shop] = arg_8_0.shopToggle
	}

	local var_8_4 = {}
	local var_8_5 = var_0_1.Sign
	local var_8_6 = arg_8_0.signToggle

	var_8_4[var_8_5] = var_4.Find(var_8_6, "Red")

	local var_8_7 = var_0_1.Task
	local var_8_8 = arg_8_0.taskToggle

	var_8_4[var_8_7] = var_4.Find(var_8_8, "Red")

	local var_8_9 = var_0_1.PT
	local var_8_10 = arg_8_0.ptToggle

	var_8_4[var_8_9] = var_4.Find(var_8_10, "Red")

	local var_8_11 = var_0_1.Shop
	local var_8_12 = arg_8_0.shopToggle

	var_8_4[var_8_11] = var_4.Find(var_8_12, "Red")
	arg_8_0.redPotList = var_8_4
	arg_8_0.backBtn = var_1:Find("back")

	local var_8_13 = arg_8_0._tf

	arg_8_0.dayText = var_2.Find(var_8_13, "time/text")

	local var_8_14 = arg_8_0._tf
	local var_8_15

	var_8_15, setText = var_2.Find(var_8_14, "time/icon"), var_8_11
	i18n = var_8_12

	var_8_11(var_8_15, var_8_12("reflux_word_1"))

	local var_8_16 = arg_8_0._tf
	local var_8_17

	var_8_17, setText = var_3.Find(var_8_16, "time/icon1"), var_8_14
	i18n = var_7

	var_8_14(var_8_17, var_7("word_date"))

	return
end

function var_0_1.initData(arg_9_0)
	arg_9_0.curViewIndex = 0
	RefluxLetterView = var_1
	arg_9_0.letterView = var_1.New(arg_9_0.letterContainer, arg_9_0.event, arg_9_0.contextData)
	RefluxSignView = var_1
	arg_9_0.signView = var_1.New(arg_9_0.panelContainer, arg_9_0.event, arg_9_0.contextData)
	RefluxTaskView = var_1
	arg_9_0.taskView = var_1.New(arg_9_0.panelContainer, arg_9_0.event, arg_9_0.contextData)
	RefluxPTView = var_1
	arg_9_0.ptView = var_1.New(arg_9_0.panelContainer, arg_9_0.event, arg_9_0.contextData)
	RefluxShopView = var_1
	arg_9_0.shopView = var_1.New(arg_9_0.panelContainer, arg_9_0.event, arg_9_0.contextData)
	arg_9_0.viewList = {
		[var_0_1.Sign] = arg_9_0.signView,
		[var_0_1.Task] = arg_9_0.taskView,
		[var_0_1.PT] = arg_9_0.ptView,
		[var_0_1.Shop] = arg_9_0.shopView
	}

	return
end

function var_0_1.addListener(arg_10_0)
	onButton = var_1_10001

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.backBtn

	local function var_10_2()
		local var_11_0 = arg_10_0

		var_0.onBackPressed(var_11_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_10_0, var_10_1, var_10_2, var_1_10006)

	onButton = var_1_10001

	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_0.letterBtn

	local function var_10_5()
		local var_12_0 = arg_10_0

		var_0.switchLetter(var_12_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_3, var_10_4, var_10_5, var_1_10006)

	onToggle = var_1_10001

	local var_10_6 = arg_10_0
	local var_10_7 = arg_10_0.signToggle

	local function var_10_8(arg_13_0)
		if arg_13_0 == true then
			local var_13_0 = arg_10_0

			var_1.switchPage(var_13_0, var_0_1.Sign)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_6, var_10_7, var_10_8, var_1_10006)

	onToggle = var_1_10001

	local var_10_9 = arg_10_0
	local var_10_10 = arg_10_0.taskToggle

	local function var_10_11(arg_14_0)
		if arg_14_0 == true then
			local var_14_0 = arg_10_0

			var_1.switchPage(var_14_0, var_0_1.Task)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_9, var_10_10, var_10_11, var_1_10006)

	onToggle = var_1_10001

	local var_10_12 = arg_10_0
	local var_10_13 = arg_10_0.ptToggle

	local function var_10_14(arg_15_0)
		if arg_15_0 == true then
			local var_15_0 = arg_10_0

			var_1.switchPage(var_15_0, var_0_1.PT)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_12, var_10_13, var_10_14, var_1_10006)

	onToggle = var_1_10001

	local var_10_15 = arg_10_0
	local var_10_16 = arg_10_0.shopToggle

	local function var_10_17(arg_16_0)
		if arg_16_0 == true then
			local var_16_0 = arg_10_0

			var_1.switchPage(var_16_0, var_0_1.Shop)

			local var_16_1 = arg_10_0

			var_1.updateRedPotList(var_16_1)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_15, var_10_16, var_10_17, var_1_10006)

	return
end

function var_0_1.tryOpenLetterView(arg_17_0)
	getProxy = var_1_10001
	RefluxProxy = var_1_10003

	local var_17_0 = var_1_10001(var_1_10003).returnTimestamp

	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_17_1 = var_1_10003(var_1_10005)
	local var_17_2 = var_3.getRawData(var_17_1).id .. "_" .. var_17_0

	PlayerPrefs = var_6

	if var_6.GetInt(var_17_2, 0) ~= 1 then
		PlayerPrefs = var_7

		var_7.SetInt(var_17_2, 1)

		PlayerPrefs = var_7

		var_7.Save()

		local var_17_3 = arg_17_0.letterView

		var_7.ActionInvoke(var_17_3, "setCloseFunc", function()
			triggerToggle = var_2_10000

			var_2_10000(arg_17_0.toggleList[var_0_1.Sign], true)

			return
		end)
		arg_17_0:switchLetter()

		return true
	else
		return false
	end

	return
end

function var_0_1.switchPage(arg_19_0, arg_19_1)
	if arg_19_0.curViewIndex ~= arg_19_1 then
		local var_19_0 = arg_19_0.viewList[arg_19_1]

		var_2.Load(var_19_0)
		var_2:ActionInvoke("Show")
		var_2:ActionInvoke("updateOutline")

		if arg_19_0.curViewIndex > 0 then
			local var_19_1 = arg_19_0.viewList[arg_19_0.curViewIndex]

			var_3.Hide(var_19_1)
		end

		arg_19_0.curViewIndex = arg_19_1
		arg_19_0.contextData.lastViewIndex = arg_19_1
	end

	return
end

function var_0_1.tryAutoOpenLastView(arg_20_0)
	if arg_20_0.contextData.lastViewIndex then
		triggerToggle = var_1

		var_1(arg_20_0.toggleList[arg_20_0.contextData.lastViewIndex], true)
	else
		triggerToggle = var_1

		var_1(arg_20_0.toggleList[var_0_1.Sign], true)
	end

	return
end

function var_0_1.switchLetter(arg_21_0)
	local var_21_0 = arg_21_0.letterView

	var_1.Load(var_21_0)

	local var_21_1 = arg_21_0.letterView

	var_1.ActionInvoke(var_21_1, "Show")

	return
end

function var_0_1.updateRedPotList(arg_22_0)
	RefluxTaskView = var_1_10001

	local var_22_0 = var_1_10001.isAnyTaskCanGetAward()

	RefluxPTView = var_1_10002

	local var_22_1 = var_1_10002.isAnyPTCanGetAward()

	RefluxShopView = var_1_10003

	local var_22_2 = var_1_10003.isShowRedPot()

	setActive = var_1_10004

	var_1_10004(arg_22_0.redPotList[var_0_1.Sign], false)

	setActive = var_1_10004

	var_1_10004(arg_22_0.redPotList[var_0_1.Task], var_22_0)

	setActive = var_1_10004

	var_1_10004(arg_22_0.redPotList[var_0_1.PT], var_22_1)

	setActive = var_1_10004

	var_1_10004(arg_22_0.redPotList[var_0_1.Shop], var_22_2)

	return
end

function var_0_1.updateDay(arg_23_0)
	getProxy = var_1_10001
	RefluxProxy = var_1_10003

	local var_23_0 = var_1_10001(var_1_10003)

	pg = var_1_10002

	local var_23_1 = var_1_10002.TimeMgr.GetInstance()

	pg = var_1_10003

	local var_23_2 = #var_1_10003.return_sign_template.all

	math = var_1_10004

	local var_23_3 = var_1_10004.clamp(var_23_1:DiffDay(var_23_0.returnTimestamp, var_23_1:GetServerTime()), 0, var_23_2 - 1)

	setText = var_1_10005

	var_1_10005(arg_23_0.dayText, var_23_2 - var_23_3)

	return
end

return var_0_1
