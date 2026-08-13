class = var_0_10000

local var_0_0 = "NewServerCarnivalScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

var_0_1.TASK_PAGE = 1
var_0_1.SHOP_PAGE = 2
var_0_1.GIFT_PAGE = 3

function var_0_1.getUIName(arg_1_0)
	return "NewServerCarnivalUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	local var_2_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_2_0, function(arg_3_0)
		pg = var_2_10001

		local var_3_0 = var_2_10001.m02
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10003

		var_3_1(var_3_0, var_2_10003.GET_NEW_SERVER_SHOP, {
			callback = function(arg_4_0)
				local var_4_0 = arg_2_0

				var_1.SetNewServerShop(var_4_0, arg_4_0)
				arg_3_0()

				return
			end
		})

		return
	end)

	parallelAsync = var_3

	var_3(var_2_0, arg_2_1)

	return
end

function var_0_1.SetNewServerShop(arg_5_0, arg_5_1)
	arg_5_0.newServerShop = arg_5_1

	return
end

function var_0_1.setData(arg_6_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)
	local var_6_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_6_2 = var_6_1(var_6_0, var_1_10004.ACTIVITY_TYPE_NEWSERVER_TASK)
	local var_6_3 = var_1
	local var_6_4 = var_1.getActivityByType

	ActivityConst = var_1_10005

	local var_6_5 = var_6_4(var_6_3, var_1_10005.ACTIVITY_TYPE_NEWSERVER_SHOP)
	local var_6_6 = var_1
	local var_6_7 = var_1.getActivityByType

	ActivityConst = var_1_10006

	local var_6_8 = var_6_7(var_6_6, var_1_10006.ACTIVITY_TYPE_NEWSERVER_GIFT)
	local var_6_9

	if var_6_2 then
		var_6_9 = var_6_2

		if not var_6_2.isEnd(var_6_9) then
			arg_6_0.taskActivity = var_6_2

			goto label_6_0
		end
	end

	arg_6_0.taskActivity = nil

	::label_6_0::

	if var_6_5 then
		var_6_9 = var_6_5

		if not var_6_5.isEnd(var_6_9) then
			arg_6_0.shopActivity = var_6_5

			goto label_6_1
		end
	end

	arg_6_0.shopActivity = nil

	::label_6_1::

	if var_6_8 then
		var_6_9 = var_6_8

		if not var_6_8.isEnd(var_6_9) then
			arg_6_0.giftActivity = var_6_8

			goto label_6_2
		end
	end

	arg_6_0.giftActivity = nil

	::label_6_2::

	getProxy = var_6_6
	PlayerProxy = var_6_9

	local var_6_10 = var_6_6(var_6_9)

	arg_6_0.player = var_5.getData(var_6_10)

	return
end

function var_0_1.init(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.blurPanel = var_1.Find(var_7_0, "blur_panel")

	local var_7_1 = arg_7_0.blurPanel

	arg_7_0.top = var_1.Find(var_7_1, "adapt/top")

	local var_7_2 = arg_7_0.top

	arg_7_0.resPanel = var_1.Find(var_7_2, "res")

	local var_7_3 = arg_7_0.top

	arg_7_0.backBtn = var_1.Find(var_7_3, "back_btn")

	local var_7_4 = arg_7_0.top

	arg_7_0.helpBtn = var_1.Find(var_7_4, "help_btn")

	local var_7_5 = arg_7_0._tf

	arg_7_0.leftPanel = var_1.Find(var_7_5, "left")

	local var_7_6 = arg_7_0.leftPanel

	arg_7_0.timeTF = var_1.Find(var_7_6, "time")

	local var_7_7 = {}
	local var_7_8 = arg_7_0.leftPanel

	var_7_7[1] = var_2.Find(var_7_8, "frame/toggle_group/task")

	local var_7_9 = arg_7_0.leftPanel

	var_7_7[2] = var_2.Find(var_7_9, "frame/toggle_group/shop")

	local var_7_10 = arg_7_0.leftPanel

	var_7_7[3] = var_2.Find(var_7_10, "frame/toggle_group/gift")
	arg_7_0.toggles = var_7_7

	local var_7_11 = arg_7_0._tf

	arg_7_0.main = var_1.Find(var_7_11, "main")

	local var_7_12 = {}
	local var_7_13 = arg_7_0.main

	var_7_12[1] = var_2.Find(var_7_13, "task_container")

	local var_7_14 = arg_7_0.main

	var_7_12[2] = var_2.Find(var_7_14, "shop_container")

	local var_7_15 = arg_7_0.main

	var_7_12[3] = var_2.Find(var_7_15, "gift_container")
	arg_7_0.pages = var_7_12
	NewServerTaskPage = var_7_12
	arg_7_0.newServerTaskPage = var_7_12.New(arg_7_0.pages[var_0_1.TASK_PAGE], arg_7_0.event, arg_7_0.contextData)
	NewServerShopPage = var_1
	arg_7_0.newServerShopPage = var_1.New(arg_7_0.pages[var_0_1.SHOP_PAGE], arg_7_0.event, arg_7_0.contextData)

	local var_7_16 = arg_7_0.newServerShopPage

	var_1.SetShop(var_7_16, arg_7_0.newServerShop)

	NewServerGiftPage = var_1
	arg_7_0.newServerGiftPage = var_1.New(arg_7_0.pages[var_0_1.GIFT_PAGE], arg_7_0.event, arg_7_0.contextData)
	arg_7_0.pageDic = {
		[var_0_1.TASK_PAGE] = arg_7_0.newServerTaskPage,
		[var_0_1.SHOP_PAGE] = arg_7_0.newServerShopPage,
		[var_0_1.GIFT_PAGE] = arg_7_0.newServerGiftPage
	}

	return
end

function var_0_1.didEnter(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.backBtn

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.emit(var_9_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.helpBtn

	local function var_8_5()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_10_2.type = var_2_10003
		pg = var_2_10003
		var_10_2.helps = var_2_10003.gametip.newserver_activity_tip.tip

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10005)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.resPanel
	local var_8_8 = var_3.Find(var_8_7, "gem/add_btn")

	local function var_8_9()
		local function var_11_0()
			pg = var_3_10000

			local var_12_0 = var_3_10000.m02
			local var_12_1 = var_0.hasMediator

			NewShopMainMediator = var_3_10002

			local var_12_3

			if not var_12_1(var_12_0, var_3_10002.__cname) then
				pg = var_12_3

				local var_12_2 = var_12_3.m02

				var_12_3 = var_12_3.sendNotification
				GAME = var_2

				local var_12_4 = var_2.GO_SCENE

				SCENE = var_3_10003

				local var_12_5 = var_3_10003.CHARGE
				local var_12_6 = {}

				ChargeScene = var_3_10005
				var_12_6.wrap = var_3_10005.TYPE_DIAMOND

				var_12_3(var_12_2, var_12_4, var_12_5, var_12_6)
			else
				pg = var_12_3

				local var_12_7 = var_12_3.m02

				var_0.sendNotification(var_12_7, var_0_1.GO_MALL)
			end

			return
		end

		PLATFORM_CODE = var_2_10001
		PLATFORM_JP = var_2_10002

		if var_2_10001 == var_2_10002 then
			pg = var_2_10001

			local var_11_1 = var_2_10001.MsgboxMgr.GetInstance()
			local var_11_2 = var_1.ShowMsgBox
			local var_11_3 = {
				fontSize = 23,
				yesText = "text_buy"
			}

			i18n = var_2_10004

			local var_11_4 = "word_diamond_tip"
			local var_11_5 = arg_8_0.player
			local var_11_6 = var_6.getFreeGem(var_11_5)
			local var_11_7 = arg_8_0.player
			local var_11_8 = var_7.getChargeGem(var_11_7)
			local var_11_9 = arg_8_0.player

			var_11_3.content = var_2_10004(var_11_4, var_11_6, var_11_8, var_8.getTotalGem(var_11_9))
			var_11_3.onYes = var_11_0
			TextAnchor = var_4
			var_11_3.alignment = var_4.UpperLeft

			var_11_2(var_11_1, var_11_3)
		else
			var_11_0()
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_6, var_8_8, var_8_9, var_5)
	arg_8_0:updateTime()

	setText = var_1

	local var_8_10 = arg_8_0.resPanel
	local var_8_11 = var_2.Find(var_8_10, "gem/gem_value")
	local var_8_12 = arg_8_0.player

	var_1(var_8_11, var_3.getTotalGem(var_8_12))

	ipairs = var_1

	for iter_8_0, iter_8_1 in var_1(arg_8_0.toggles) do
		onToggle = var_1_10006

		var_1_10006(arg_8_0, iter_8_1, function(arg_13_0)
			local var_13_0 = arg_8_0

			var_1.updateLocalRedDotData(var_13_0, iter_8_0)

			local var_13_1 = arg_8_0

			var_1.updatePages(var_13_1, iter_8_0, arg_13_0)

			setActive = var_1

			var_1(arg_8_0.resPanel, arg_13_0 and iter_8_0 == var_0_1.GIFT_PAGE)

			return
		end)
	end

	setActive = var_1

	var_1(arg_8_0.toggles[var_0_1.TASK_PAGE], arg_8_0.taskActivity)

	setActive = var_1

	var_1(arg_8_0.toggles[var_0_1.SHOP_PAGE], arg_8_0.shopActivity)

	setActive = var_1

	var_1(arg_8_0.toggles[var_0_1.GIFT_PAGE], arg_8_0.giftActivity)

	local var_8_13

	if not arg_8_0.contextData.page and (not arg_8_0.taskActivity or not var_0_1.TASK_PAGE) then
		var_8_13 = var_0_1.SHOP_PAGE
	end

	arg_8_0.page = var_8_13
	triggerToggle = var_8_13

	var_8_13(arg_8_0.toggles[arg_8_0.page], true)

	return
end

function var_0_1.updateShopDedDot(arg_14_0)
	setActive = var_1_10001

	local var_14_0 = arg_14_0.toggles[var_0_1.SHOP_PAGE]
	local var_14_1 = var_2.Find(var_14_0, "tip")
	local var_14_2 = arg_14_0.newServerShopPage

	var_1_10001(var_14_1, var_3.isTip(var_14_2))

	return
end

function var_0_1.updatePages(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.pageDic[arg_15_1]

	if var_3.isShowing(var_15_0) ~= arg_15_2 then
		if arg_15_2 then
			if arg_15_1 == var_0_1.SHOP_PAGE then
				local var_15_1 = arg_15_0.pageDic[arg_15_1]

				var_3.ExecuteAction(var_15_1, "Flush")
			else
				local var_15_2 = arg_15_0.pageDic[arg_15_1]

				var_3.ExecuteAction(var_15_2, "Show")
			end
		else
			local var_15_3 = arg_15_0.pageDic[arg_15_1]

			var_3.ExecuteAction(var_15_3, "Hide")
		end
	end

	return
end

function var_0_1.updateTips(arg_16_0)
	if arg_16_0.taskActivity then
		setActive = var_1

		local var_16_0 = arg_16_0.toggles[var_0_1.TASK_PAGE]
		local var_16_1 = var_2.Find(var_16_0, "tip")
		local var_16_2 = arg_16_0.newServerTaskPage

		var_1(var_16_1, var_3.isTip(var_16_2))
	end

	if arg_16_0.shopActivity then
		setActive = var_1

		local var_16_3 = arg_16_0.toggles[var_0_1.SHOP_PAGE]
		local var_16_4 = var_2.Find(var_16_3, "tip")
		local var_16_5 = arg_16_0.newServerShopPage

		var_1(var_16_4, var_3.isTip(var_16_5))
	end

	if arg_16_0.giftActivity then
		setActive = var_1

		local var_16_6 = arg_16_0.toggles[var_0_1.GIFT_PAGE]
		local var_16_7 = var_2.Find(var_16_6, "tip")
		local var_16_8 = arg_16_0.newServerGiftPage

		var_1(var_16_7, var_3.isTip(var_16_8))
	end

	return
end

function var_0_1.updateLocalRedDotData(arg_17_0, arg_17_1)
	if arg_17_1 == var_0_1.SHOP_PAGE then
		local var_17_0 = arg_17_0.newServerShopPage

		if var_2.isTip(var_17_0) then
			PlayerPrefs = var_2

			if var_2.GetInt("newserver_shop_first_" .. arg_17_0.player.id) == 0 then
				PlayerPrefs = var_2

				var_2.SetInt("newserver_shop_first_" .. arg_17_0.player.id, 1)
			end
		end
	elseif arg_17_1 == var_0_1.GIFT_PAGE then
		local var_17_1 = arg_17_0.newServerGiftPage

		if var_2.isTip(var_17_1) then
			PlayerPrefs = var_2

			var_2.SetInt("newserver_gift_first_" .. arg_17_0.player.id, 1)
		end
	end

	return
end

function var_0_1.updateTime(arg_18_0)
	pg = var_1_10001

	local var_18_0 = var_1_10001.TimeMgr.GetInstance()
	local var_18_1

	if not arg_18_0.taskActivity or not arg_18_0.taskActivity.stopTime then
		var_18_1 = arg_18_0.shopActivity.stopTime
	end

	local var_18_2 = var_18_0
	local var_18_3 = var_18_1 - var_18_0.GetServerTime(var_18_2)

	math = var_18_2

	local var_18_4 = var_18_2.floor(var_18_3 / 0)

	math = var_5

	local var_18_5 = var_5.floor((var_18_3 - var_18_4 * 0) / 16)

	setText = var_6

	local var_18_6 = arg_18_0.timeTF

	i18n = var_1_10008

	var_6(var_18_6, var_1_10008("newserver_time", var_18_4, var_18_5))

	setActive = var_6

	local var_18_7 = arg_18_0.timeTF

	var_6(var_7.Find(var_18_7, "title_activity"), arg_18_0.taskActivity)

	setActive = var_6

	local var_18_8 = arg_18_0.timeTF

	var_6(var_7.Find(var_18_8, "title_shop"), not arg_18_0.taskActivity)

	return
end

function var_0_1.onUpdateTask(arg_19_0)
	local var_19_0 = arg_19_0.newServerTaskPage

	var_1.ActionInvoke(var_19_0, "onUpdateTask")

	local var_19_1 = arg_19_0.newServerShopPage

	var_1.ActionInvoke(var_19_1, "UpdateRes")
	arg_19_0:updateTips()

	return
end

function var_0_1.onUpdatePlayer(arg_20_0, arg_20_1)
	arg_20_0.player = arg_20_1
	setText = var_1_10002

	local var_20_0 = arg_20_0.resPanel
	local var_20_1 = var_3.Find(var_20_0, "gem/gem_value")
	local var_20_2 = arg_20_0.player

	var_1_10002(var_20_1, var_4.getTotalGem(var_20_2))

	local var_20_3 = arg_20_0.newServerGiftPage

	var_2.onUpdatePlayer(var_20_3, arg_20_1)

	return
end

function var_0_1.onUpdateGift(arg_21_0)
	local var_21_0 = arg_21_0.newServerGiftPage

	var_1.ActionInvoke(var_21_0, "onUpdateGift")
	arg_21_0:updateTips()

	return
end

function var_0_1.willExit(arg_22_0)
	local var_22_0 = arg_22_0.newServerTaskPage

	var_1.Destroy(var_22_0)

	local var_22_1 = arg_22_0.newServerShopPage

	var_1.Destroy(var_22_1)

	local var_22_2 = arg_22_0.newServerGiftPage

	var_1.Destroy(var_22_2)

	return
end

function var_0_1.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_23_0 = var_1_10000(var_1_10001)
	local var_23_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	local var_23_2 = var_23_1(var_23_0, var_1_10003.ACTIVITY_TYPE_NEWSERVER_TASK)
	local var_23_3 = var_0
	local var_23_4 = var_0.getActivityByType

	ActivityConst = var_1_10004

	local var_23_5 = var_23_4(var_23_3, var_1_10004.ACTIVITY_TYPE_NEWSERVER_SHOP)
	local var_23_6 = var_0
	local var_23_7 = var_0.getActivityByType

	ActivityConst = var_1_10005

	local var_23_8 = var_23_7(var_23_6, var_1_10005.ACTIVITY_TYPE_NEWSERVER_GIFT)

	return var_23_2 and not var_23_2:isEnd() or var_23_5 and not var_23_5:isEnd() or var_23_8 and not var_23_8:isEnd()
end

function var_0_1.isTip()
	return false
end

return var_0_1
