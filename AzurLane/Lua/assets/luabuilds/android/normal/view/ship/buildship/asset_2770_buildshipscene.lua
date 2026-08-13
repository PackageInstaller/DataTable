class = var_0_10000

local var_0_0 = "BuildShipScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

var_0_1.PAGE_BUILD = 1
var_0_1.PAGE_QUEUE = 2
var_0_1.PAGE_SUPPORT = 3
var_0_1.PAGE_UNSEAM = 4
var_0_1.PAGE_PRAY = 5
var_0_1.PAGE_NEWSERVER = 6
var_0_1.PROJECTS = {
	SPECIAL = "special",
	ACTIVITY = "new",
	HEAVY = "heavy",
	LIGHT = "light"
}

function var_0_1.getUIName(arg_1_0)
	return "BuildShipUI"
end

function var_0_1.ResUISettings(arg_2_0)
	return true
end

function var_0_1.setPools(arg_3_0, arg_3_1)
	arg_3_0.pools = {}
	ipairs = var_2

	for iter_3_0, iter_3_1 in var_2(arg_3_1) do
		table = var_1_10007

		var_1_10007.insert(arg_3_0.pools, iter_3_1)
	end

	return
end

function var_0_1.setPlayer(arg_4_0, arg_4_1)
	arg_4_0.contextData.player = arg_4_1

	return
end

function var_0_1.setUseItem(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.contextData

	if not arg_5_1 then
		::label_5_0::

		Item = var_1_10003
		var_1_10003 = var_1_10003.New

		local var_5_1 = {
			count = 0
		}

		pg = var_1_10005
		var_5_1.id = var_1_10005.ship_data_create_material[1].use_item
		var_1_10003 = var_1_10003(var_5_1)
	end

	var_5_0.itemVO = var_1_10003

	if arg_5_0.poolsPage then
		local var_5_2 = arg_5_0.poolsPage

		if var_2.GetLoaded(var_5_2) then
			local var_5_3 = arg_5_0.poolsPage

			var_2.UpdateItem(var_5_3, arg_5_0.contextData.itemVO.count)
		end
	end

	return
end

function var_0_1.setStartCount(arg_6_0, arg_6_1)
	arg_6_0.contextData.startCount = arg_6_1

	return
end

function var_0_1.setFlagShip(arg_7_0, arg_7_1)
	arg_7_0.contextData.falgShip = arg_7_1

	return
end

function var_0_1.RefreshActivityBuildPool(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.poolsPage

	var_2.RefreshActivityBuildPool(var_8_0, arg_8_1)

	return
end

function var_0_1.RefreshFreeBuildActivity(arg_9_0)
	local var_9_0 = arg_9_0.poolsPage

	var_1.RefreshFreeBuildActivity(var_9_0)

	local var_9_1 = arg_9_0.poolsPage

	var_1.UpdateTicket(var_9_1)

	return
end

function var_0_1.RefreshRegularExchangeCount(arg_10_0)
	local var_10_0 = arg_10_0.poolsPage

	var_1.RefreshRegularExchangeCount(var_10_0)

	return
end

function var_0_1.init(arg_11_0)
	Input = var_1_10001
	var_1_10001.multiTouchEnabled = false

	local var_11_0 = arg_11_0._tf

	arg_11_0.blurPanel = var_1.Find(var_11_0, "blur_panel")

	local var_11_1 = arg_11_0.blurPanel

	arg_11_0.topPanel = var_1.Find(var_11_1, "adapt/top")

	local var_11_2 = arg_11_0.topPanel

	arg_11_0.backBtn = var_1.Find(var_11_2, "back_btn")

	local var_11_3 = {}
	local var_11_4 = arg_11_0.blurPanel

	var_11_3[1] = var_2.Find(var_11_4, "adapt/left_length/frame/tagRoot/build_btn")

	local var_11_5 = arg_11_0.blurPanel

	var_11_3[2] = var_2.Find(var_11_5, "adapt/left_length/frame/tagRoot/queue_btn")

	local var_11_6 = arg_11_0.blurPanel

	var_11_3[3] = var_2.Find(var_11_6, "adapt/left_length/frame/tagRoot/support_btn")

	local var_11_7 = arg_11_0.blurPanel

	var_11_3[4] = var_2.Find(var_11_7, "adapt/left_length/frame/tagRoot/unseam_btn")

	local var_11_8 = arg_11_0.blurPanel

	var_11_3[5] = var_2.Find(var_11_8, "adapt/left_length/frame/tagRoot/pray_btn")

	local var_11_9 = arg_11_0.blurPanel

	var_11_3[6] = var_2.Find(var_11_9, "adapt/left_length/frame/tagRoot/other_build_btn")
	arg_11_0.toggles = var_11_3

	local var_11_10 = arg_11_0.toggles[2]

	arg_11_0.tip = var_1.Find(var_11_10, "tip")

	local var_11_11 = arg_11_0.contextData

	BuildShipMsgBox = var_11_10
	var_11_11.msgbox = var_11_10.New(arg_11_0._tf, arg_11_0.event)

	local var_11_12 = arg_11_0.contextData

	BuildShipHelpWindow = var_2
	var_11_12.helpWindow = var_2.New(arg_11_0._tf, arg_11_0.event)
	BuildShipPoolsPage = var_11_12
	arg_11_0.poolsPage = var_11_12.New(arg_11_0._tf, arg_11_0.event, arg_11_0.contextData)
	SupportShipPoolPage = var_1
	arg_11_0.supportShipPoolPage = var_1.New(arg_11_0._tf, arg_11_0.event, arg_11_0.contextData)

	return
end

function var_0_1.didEnter(arg_12_0)
	arg_12_0:OverlayPanel(arg_12_0.blurPanel)

	onButton = var_1

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.backBtn

	local function var_12_2()
		local var_13_0 = arg_12_0

		var_0.emit(var_13_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_12_0, var_12_1, var_12_2, var_1_10005)

	local var_12_3 = arg_12_0.blurPanel
	local var_12_4 = var_1.Find(var_12_3, "adapt/left_length/stamp")

	setActive = var_12_3

	local var_12_5 = var_12_4

	getProxy = var_12_2
	TaskProxy = var_1_10005

	local var_12_6 = var_12_2(var_1_10005)

	var_12_3(var_12_5, var_4.mingshiTouchFlagEnabled(var_12_6))

	onButton = var_12_3

	local var_12_7 = arg_12_0
	local var_12_8 = var_12_4

	local function var_12_9()
		getProxy = var_2_10000
		TaskProxy = var_2_10001

		local var_14_0 = var_2_10000(var_2_10001)

		var_0.dealMingshiTouchFlag(var_14_0, 11)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_12_3(var_12_7, var_12_8, var_12_9, var_1_10006)

	ipairs = var_12_3

	for iter_12_0, iter_12_1 in var_12_3(arg_12_0.toggles) do
		onToggle = var_1_10007

		local var_12_10 = arg_12_0
		local var_12_11 = iter_12_1

		local function var_12_12(arg_15_0)
			local var_15_0 = arg_12_0

			var_1.switchPage(var_15_0, iter_12_0, arg_15_0)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10007(var_12_10, var_12_11, var_12_12, var_1_10011)
	end

	getProxy = var_2
	ActivityProxy = var_3

	local var_12_13 = var_2(var_3)
	local var_12_14 = var_2.getActivityById

	ActivityConst = iter_12_0

	if var_12_14(var_12_13, iter_12_0.ACTIVITY_PRAY_POOL) and not var_3:isEnd() then
		setActive = var_12_13

		var_12_13(arg_12_0.toggles[var_0_1.PAGE_PRAY], true)
	else
		setActive = var_12_13

		var_12_13(arg_12_0.toggles[var_0_1.PAGE_PRAY], false)
	end

	underscore = var_12_13

	if var_12_13.any(arg_12_0.pools, function(arg_16_0)
		checkExist = var_2_10001

		local var_16_0 = var_0
		local var_16_1 = var_2_10001(var_2.getBuildPoolActivity(var_16_0, arg_16_0), {
			"getConfig",
			{
				"type"
			}
		})

		ActivityConst = var_2

		return var_16_1 == var_2.ACTIVITY_TYPE_NEWSERVER_BUILD
	end) then
		setActive = var_4

		var_4(arg_12_0.toggles[var_0_1.PAGE_NEWSERVER], true)
	else
		setActive = var_4

		var_4(arg_12_0.toggles[var_0_1.PAGE_NEWSERVER], false)
	end

	local var_12_15, var_12_16

	if not arg_12_0.contextData.page then
		pg = var_12_16
		var_12_15 = var_12_16.SeriesGuideMgr.GetInstance()

		if not var_12_16.isRunning(var_12_15) or not var_0_1.PAGE_BUILD then
			var_12_16 = var_0_1.PAGE_NEWSERVER
		end
	end

	isActive = var_12_15

	if not var_12_15(arg_12_0.toggles[var_12_16]) then
		var_12_16 = var_0_1.PAGE_BUILD
	end

	triggerToggle = var_5

	var_5(arg_12_0.toggles[var_12_16], true)

	PoolMgr = var_5

	local var_12_17 = var_5.GetInstance()

	var_5.GetUI(var_12_17, "al_bg01", true, function(arg_17_0)
		arg_17_0:SetActive(true)

		setParent = var_1

		var_1(arg_17_0, arg_12_0._tf)

		local var_17_0 = arg_17_0.transform

		var_1.SetAsFirstSibling(var_17_0)

		return
	end)

	TagTipHelper = var_5

	var_5.SetFreeBuildMark()

	AprilFoolBulinSubView = var_5
	arg_12_0.bulinTip = var_5.ShowAprilFoolBulin(arg_12_0, arg_12_0.blurPanel)

	return
end

function var_0_1.checkPage(arg_18_0)
	if arg_18_0.contextData.msgbox then
		var_1_10002 = arg_18_0.contextData.msgbox

		if var_1.GetLoaded(var_1_10002) then
			var_1_10002 = arg_18_0.contextData.msgbox

			if var_1.isShowing(var_1_10002) then
				var_1_10002 = arg_18_0.contextData.msgbox

				var_1.Hide(var_1_10002)
			end
		end
	end

	if arg_18_0.contextData.helpWindow then
		var_1_10002 = arg_18_0.contextData.helpWindow

		if var_1.GetLoaded(var_1_10002) then
			var_1_10002 = arg_18_0.contextData.helpWindow

			if var_1.isShowing(var_1_10002) then
				var_1_10002 = arg_18_0.contextData.helpWindow

				var_1.Hide(var_1_10002)
			end
		end
	end

	getProxy = var_1
	ActivityProxy = var_1_10002

	local var_18_0 = var_1(var_1_10002)

	underscore = var_1_10002

	if var_1_10002.any(arg_18_0.pools, function(arg_19_0)
		checkExist = var_2_10001

		local var_19_0 = var_18_0
		local var_19_1 = var_2_10001(var_2.getBuildPoolActivity(var_19_0, arg_19_0), {
			"getConfig",
			{
				"type"
			}
		})

		ActivityConst = var_2

		return var_19_1 == var_2.ACTIVITY_TYPE_NEWSERVER_BUILD
	end) then
		setActive = var_2

		var_2(arg_18_0.toggles[var_0_1.PAGE_NEWSERVER], true)
	else
		setActive = var_2

		var_2(arg_18_0.toggles[var_0_1.PAGE_NEWSERVER], false)
	end

	isActive = var_2

	if not var_2(arg_18_0.toggles[var_0_1.PAGE_NEWSERVER]) and arg_18_0.contextData.page == var_0_1.PAGE_NEWSERVER then
		triggerToggle = var_2

		var_2(arg_18_0.toggles[var_0_1.PAGE_BUILD], true)
	else
		local var_18_1 = arg_18_0.poolsPage

		var_2.Flush(var_18_1, arg_18_0.pools)
	end

	return
end

function var_0_1.switchPage(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_2 then
		local var_20_0 = arg_20_0.contextData
		local var_20_1

		if arg_20_1 ~= var_0_1.PAGE_UNSEAM or not var_0_1.PAGE_BUILD then
			var_20_1 = arg_20_1
		end

		var_20_0.page = var_20_1
	end

	if arg_20_1 == var_0_1.PAGE_UNSEAM then
		if arg_20_2 then
			local var_20_2 = arg_20_0
			local var_20_3 = arg_20_0.emit

			BuildShipMediator = var_1_10005

			var_20_3(var_20_2, var_1_10005.OPEN_DESTROY)
		end
	elseif arg_20_1 == var_0_1.PAGE_QUEUE then
		if arg_20_2 then
			local var_20_4 = arg_20_0
			local var_20_5 = arg_20_0.emit

			BuildShipMediator = var_1_10005

			var_20_5(var_20_4, var_1_10005.OPEN_PROJECT_LIST)
		else
			local var_20_6 = arg_20_0
			local var_20_7 = arg_20_0.emit

			BuildShipMediator = var_1_10005

			var_20_7(var_20_6, var_1_10005.REMOVE_PROJECT_LIST)
		end
	elseif arg_20_1 == var_0_1.PAGE_SUPPORT then
		local var_20_8 = arg_20_0.supportShipPoolPage

		var_3.ExecuteAction(var_20_8, "ShowOrHide", arg_20_2)

		if arg_20_2 then
			local var_20_9 = arg_20_0.supportShipPoolPage

			var_3.ExecuteAction(var_20_9, "Flush")
		end
	elseif arg_20_1 == var_0_1.PAGE_BUILD then
		local var_20_10 = arg_20_0.poolsPage

		var_3.ExecuteAction(var_20_10, "ShowOrHide", arg_20_2)

		if arg_20_2 then
			local var_20_11 = arg_20_0.poolsPage

			var_3.ExecuteAction(var_20_11, "Flush", arg_20_0.pools, false)
		end
	elseif arg_20_1 == var_0_1.PAGE_NEWSERVER then
		local var_20_12 = arg_20_0.poolsPage

		var_3.ExecuteAction(var_20_12, "ShowOrHide", arg_20_2)

		if arg_20_2 then
			local var_20_13 = arg_20_0.poolsPage

			var_3.ExecuteAction(var_20_13, "Flush", arg_20_0.pools, true)
		end
	elseif arg_20_1 == var_0_1.PAGE_PRAY then
		if arg_20_2 then
			local var_20_14 = arg_20_0
			local var_20_15 = arg_20_0.emit

			BuildShipMediator = var_1_10005

			var_20_15(var_20_14, var_1_10005.OPEN_PRAY_PAGE)
		else
			local var_20_16 = arg_20_0
			local var_20_17 = arg_20_0.emit

			BuildShipMediator = var_1_10005

			var_20_17(var_20_16, var_1_10005.CLOSE_PRAY_PAGE)
		end
	end

	return
end

function var_0_1.updateQueueTip(arg_21_0, arg_21_1)
	setActive = var_1_10002

	var_1_10002(arg_21_0.tip, arg_21_1 > 0)

	return
end

function var_0_1.onBackPressed(arg_22_0)
	local var_22_0 = arg_22_0.contextData.helpWindow

	if var_1.GetLoaded(var_22_0) then
		local var_22_1 = arg_22_0.contextData.helpWindow

		if var_1.isShowing(var_22_1) then
			local var_22_2 = arg_22_0.contextData.helpWindow

			var_1.Hide(var_22_2)

			return
		end
	end

	local var_22_3 = arg_22_0.contextData.msgbox

	if var_1.GetLoaded(var_22_3) then
		local var_22_4 = arg_22_0.contextData.msgbox

		if var_1.isShowing(var_22_4) then
			local var_22_5 = arg_22_0.contextData.msgbox

			var_1.Hide(var_22_5)

			return
		end
	end

	arg_22_0:emit(var_0_1.ON_BACK_PRESSED)

	return
end

function var_0_1.willExit(arg_23_0)
	Input = var_1_10001
	var_1_10001.multiTouchEnabled = true

	local var_23_0 = arg_23_0.contextData.msgbox

	var_1.Destroy(var_23_0)

	local var_23_1 = arg_23_0.contextData.helpWindow

	var_1.Destroy(var_23_1)

	local var_23_2 = arg_23_0.poolsPage

	var_1.Destroy(var_23_2)

	local var_23_3 = arg_23_0.supportShipPoolPage

	var_1.Destroy(var_23_3)
	arg_23_0:UnOverlayPanel(arg_23_0.blurPanel, arg_23_0._tf)

	return
end

return var_0_1
