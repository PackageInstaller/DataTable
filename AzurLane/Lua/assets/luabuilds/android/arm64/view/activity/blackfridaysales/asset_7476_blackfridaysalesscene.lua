class = var_0_10000

local var_0_0 = "BlackFridaySalesScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

var_0_1.TASK_PAGE = 1
var_0_1.SHOP_PAGE = 2
var_0_1.GIFT_PAGE = 3

function var_0_1.getUIName(arg_1_0)
	return "BlackFridaySalesUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	local var_2_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_2_0, function(arg_3_0)
		pg = var_2_10001

		local var_3_0 = var_2_10001.m02
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_3_2 = var_2_10004.GET_NEW_SERVER_SHOP
		local var_3_3 = {}

		ActivityConst = var_2_10006
		var_3_3.actType = var_2_10006.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP

		function var_3_3.callback(arg_4_0)
			local var_4_0 = arg_2_0

			var_1.SetBlackFridayShop(var_4_0, arg_4_0)
			arg_3_0()

			return
		end

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)

	parallelAsync = var_3

	var_3(var_2_0, arg_2_1)

	return
end

function var_0_1.SetBlackFridayShop(arg_5_0, arg_5_1)
	arg_5_0.blackFridayShop = arg_5_1

	return
end

function var_0_1.setData(arg_6_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1

	getProxy = var_1_10003
	ActivityProxy = var_1_10005

	local var_6_2 = var_1_10003(var_1_10005)
	local var_6_3 = var_3.getActivitiesByType

	ActivityConst = var_1_10006

	local var_6_4 = var_6_3(var_6_2, var_1_10006.ACTIVITY_TYPE_TASKS)

	ipairs = var_1_10004

	for iter_6_0, iter_6_1 in var_1_10004(var_6_4) do
		if iter_6_1:getConfig("config_client").blackFriday then
			var_6_1 = iter_6_1

			break
		end
	end

	local var_6_5 = var_6_0
	local var_6_6 = var_6_0.getActivityByType

	ActivityConst = iter_6_0

	local var_6_7 = var_6_6(var_6_5, iter_6_0.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP)
	local var_6_8 = var_6_0
	local var_6_9 = var_6_0.getActivityByType

	ActivityConst = iter_6_1

	local var_6_10 = var_6_9(var_6_8, iter_6_1.ACTIVITY_TYPE_GIFT_UP)
	local var_6_11

	if var_6_1 then
		var_6_11 = var_6_1

		if not var_6_1.isEnd(var_6_11) then
			arg_6_0.taskActivity = var_6_1

			goto label_6_0
		end
	end

	arg_6_0.taskActivity = nil

	::label_6_0::

	if var_6_7 then
		var_6_11 = var_6_7

		if not var_6_7.isEnd(var_6_11) then
			arg_6_0.shopActivity = var_6_7

			goto label_6_1
		end
	end

	arg_6_0.shopActivity = nil

	::label_6_1::

	if var_6_10 then
		var_6_11 = var_6_10

		if not var_6_10.isEnd(var_6_11) then
			arg_6_0.giftActivity = var_6_10

			goto label_6_2
		end
	end

	arg_6_0.giftActivity = nil

	::label_6_2::

	getProxy = var_6_5
	PlayerProxy = var_6_11

	local var_6_12 = var_6_5(var_6_11)

	arg_6_0.player = var_6.getData(var_6_12)

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

	local var_7_7 = arg_7_0.leftPanel
	local var_7_8 = var_1.Find(var_7_7, "frame/toggle_group/task")
	local var_7_9 = arg_7_0.leftPanel
	local var_7_10 = var_2.Find(var_7_9, "frame/toggle_group/shop")
	local var_7_11 = arg_7_0.leftPanel
	local var_7_12 = var_3.Find(var_7_11, "frame/toggle_group/gift")

	setText = var_7_9

	local var_7_13 = var_7_8:Find("Image")

	i18n = var_1_10007

	var_7_9(var_7_13, var_1_10007("blackfriday_task"))

	setText = var_7_9

	local var_7_14 = var_7_10:Find("Image")

	i18n = var_7

	var_7_9(var_7_14, var_7("blackfriday_shop"))

	setText = var_7_9

	local var_7_15 = var_7_12:Find("Image")

	i18n = var_7

	var_7_9(var_7_15, var_7("blackfriday_gift"))

	arg_7_0.toggles = {
		var_7_8,
		var_7_10,
		var_7_12
	}

	local var_7_16 = arg_7_0._tf

	arg_7_0.main = var_4.Find(var_7_16, "main")

	local var_7_17 = {}
	local var_7_18 = arg_7_0.main

	var_7_17[1] = var_5.Find(var_7_18, "task_container")

	local var_7_19 = arg_7_0.main

	var_7_17[2] = var_5.Find(var_7_19, "shop_container")

	local var_7_20 = arg_7_0.main

	var_7_17[3] = var_5.Find(var_7_20, "gift_container")
	arg_7_0.pages = var_7_17
	ChargeTipWindow = var_7_17
	arg_7_0.chargeTipWindow = var_7_17.New(arg_7_0._tf, arg_7_0.event)

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
		var_10_2.helps = var_2_10004.gametip.blackfriday_main_tip.tip

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10006)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.resPanel
	local var_8_8 = var_4.Find(var_8_7, "gem")

	local function var_8_9()
		local function var_11_0()
			pg = var_3_10000

			local var_12_0 = var_3_10000.m02
			local var_12_1 = var_0.hasMediator

			NewShopMainMediator = var_3_10003

			local var_12_3

			if not var_12_1(var_12_0, var_3_10003.__cname) then
				pg = var_12_3

				local var_12_2 = var_12_3.m02

				var_12_3 = var_12_3.sendNotification
				GAME = var_3

				local var_12_4 = var_3.GO_SCENE

				SCENE = var_3_10004

				local var_12_5 = var_3_10004.CHARGE
				local var_12_6 = {}

				ChargeScene = var_3_10006
				var_12_6.wrap = var_3_10006.TYPE_DIAMOND

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

			i18n = var_2_10005

			local var_11_4 = "word_diamond_tip"
			local var_11_5 = arg_8_0.player
			local var_11_6 = var_8.getFreeGem(var_11_5)
			local var_11_7 = arg_8_0.player
			local var_11_8 = var_9.getChargeGem(var_11_7)
			local var_11_9 = arg_8_0.player

			var_11_3.content = var_2_10005(var_11_4, var_11_6, var_11_8, var_10.getTotalGem(var_11_9))
			var_11_3.onYes = var_11_0
			TextAnchor = var_5
			var_11_3.alignment = var_5.UpperLeft

			var_11_2(var_11_1, var_11_3)
		else
			var_11_0()
		end

		return
	end

	SFX_PANEL = var_8_7

	var_1_10001(var_8_6, var_8_8, var_8_9, var_8_7)
	arg_8_0:updatePages()
	arg_8_0:updateTime()

	setText = var_1

	local var_8_10 = arg_8_0.resPanel
	local var_8_11 = var_3.Find(var_8_10, "gem/gem_value")
	local var_8_12 = arg_8_0.player

	var_1(var_8_11, var_4.getTotalGem(var_8_12))

	ipairs = var_1

	for iter_8_0, iter_8_1 in var_1(arg_8_0.toggles) do
		onToggle = var_8_12

		var_8_12(arg_8_0, iter_8_1, function(arg_13_0)
			setActive = var_2_10001

			var_2_10001(arg_8_0.pages[iter_8_0], arg_13_0)

			local var_13_0 = arg_8_0

			var_1.updateLocalRedDotData(var_13_0, iter_8_0)

			local var_13_1 = arg_8_0

			var_1.updatePages(var_13_1)

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

	if not arg_8_0.taskActivity or not var_0_1.TASK_PAGE then
		var_8_13 = var_0_1.SHOP_PAGE
	end

	arg_8_0.page = var_8_13

	local var_8_14

	if not arg_8_0.contextData.page or not arg_8_0.contextData.page then
		var_8_14 = arg_8_0.page
	end

	arg_8_0.page = var_8_14
	triggerToggle = var_8_14

	var_8_14(arg_8_0.toggles[arg_8_0.page], true)

	return
end

function var_0_1.updateShopDedDot(arg_14_0)
	setActive = var_1_10001

	local var_14_0 = arg_14_0.toggles[var_0_1.SHOP_PAGE]
	local var_14_1 = var_3.Find(var_14_0, "tip")
	local var_14_2 = arg_14_0.blackFridaySalesShopPage

	var_1_10001(var_14_1, var_4.isTip(var_14_2))

	return
end

function var_0_1.updatePages(arg_15_0)
	if arg_15_0.taskActivity then
		if not arg_15_0.blackFridayTaskPage then
			BlackFridaySalesTaskPage = var_1
			arg_15_0.blackFridayTaskPage = var_1.New(arg_15_0.pages[var_0_1.TASK_PAGE], arg_15_0.event, arg_15_0.contextData)

			local var_15_0 = arg_15_0.blackFridayTaskPage

			var_1.Reset(var_15_0)

			local var_15_1 = arg_15_0.blackFridayTaskPage

			var_1.Load(var_15_1)
		end

		setActive = var_1

		local var_15_2 = arg_15_0.toggles[var_0_1.TASK_PAGE]
		local var_15_3 = var_3.Find(var_15_2, "tip")
		local var_15_4 = arg_15_0.blackFridayTaskPage

		var_1(var_15_3, var_4.isTip(var_15_4))
	end

	if arg_15_0.shopActivity then
		if not arg_15_0.blackFridaySalesShopPage then
			BlackFridaySalesShopPage = var_1
			arg_15_0.blackFridaySalesShopPage = var_1.New(arg_15_0.pages[var_0_1.SHOP_PAGE], arg_15_0.event, arg_15_0.contextData)

			local var_15_5 = arg_15_0.blackFridaySalesShopPage

			var_1.Reset(var_15_5)

			local var_15_6 = arg_15_0.blackFridaySalesShopPage

			var_1.SetShop(var_15_6, arg_15_0.blackFridayShop)

			local var_15_7 = arg_15_0.blackFridaySalesShopPage

			var_1.Load(var_15_7)
		end

		setActive = var_1

		local var_15_8 = arg_15_0.toggles[var_0_1.SHOP_PAGE]
		local var_15_9 = var_3.Find(var_15_8, "tip")
		local var_15_10 = arg_15_0.blackFridaySalesShopPage

		var_1(var_15_9, var_4.isTip(var_15_10))
	end

	if arg_15_0.giftActivity then
		if not arg_15_0.blackFridaySalesGiftPage then
			BlackFridaySalesGiftPage = var_1
			arg_15_0.blackFridaySalesGiftPage = var_1.New(arg_15_0.pages[var_0_1.GIFT_PAGE], arg_15_0.event, arg_15_0.contextData)

			local var_15_11 = arg_15_0.blackFridaySalesGiftPage

			var_1.Reset(var_15_11)

			local var_15_12 = arg_15_0.blackFridaySalesGiftPage

			var_1.Load(var_15_12)

			local var_15_13 = arg_15_0.blackFridaySalesGiftPage

			var_1.initData(var_15_13)
		end

		setActive = var_1

		local var_15_14 = arg_15_0.toggles[var_0_1.GIFT_PAGE]
		local var_15_15 = var_3.Find(var_15_14, "tip")
		local var_15_16 = arg_15_0.blackFridaySalesGiftPage

		var_1(var_15_15, var_4.isTip(var_15_16))
	end

	return
end

function var_0_1.updateLocalRedDotData(arg_16_0, arg_16_1)
	if arg_16_1 == var_0_1.SHOP_PAGE then
		local var_16_0 = arg_16_0.blackFridaySalesShopPage

		if var_2.isTip(var_16_0) then
			PlayerPrefs = var_2

			if var_2.GetInt("newserver_shop_first_" .. arg_16_0.player.id) == 0 then
				PlayerPrefs = var_2

				var_2.SetInt("newserver_shop_first_" .. arg_16_0.player.id, 1)
			end
		end
	elseif arg_16_1 == var_0_1.GIFT_PAGE then
		local var_16_1 = arg_16_0.blackFridaySalesGiftPage

		if var_2.isTip(var_16_1) then
			PlayerPrefs = var_2

			var_2.SetInt("newserver_gift_first_" .. arg_16_0.player.id, 1)
		end
	end

	return
end

function var_0_1.updateTime(arg_17_0)
	pg = var_1_10001

	local var_17_0 = var_1_10001.TimeMgr.GetInstance()
	local var_17_1

	if not arg_17_0.taskActivity or not arg_17_0.taskActivity.stopTime then
		var_17_1 = arg_17_0.shopActivity.stopTime
	end

	local var_17_2 = var_17_0
	local var_17_3 = var_17_1 - var_17_0.GetServerTime(var_17_2)

	math = var_1_10004

	local var_17_4 = var_1_10004.floor(var_17_3 / 0)

	math = var_17_2

	local var_17_5 = var_17_2.floor((var_17_3 - var_17_4 * 0) / 16)

	setText = var_6

	local var_17_6 = arg_17_0.timeTF

	i18n = var_1_10009

	local var_17_7 = var_1_10009("time_remaining_tip")

	i18n = var_1_10010

	var_6(var_17_6, var_17_7 .. var_1_10010("newserver_time", var_17_4, var_17_5))

	return
end

function var_0_1.onUpdateTask(arg_18_0)
	if arg_18_0.blackFridayTaskPage then
		local var_18_0 = arg_18_0.blackFridayTaskPage

		var_1.onUpdateTask(var_18_0)
	end

	if arg_18_0.blackFridaySalesShopPage then
		local var_18_1 = arg_18_0.blackFridaySalesShopPage

		var_1.UpdateRes(var_18_1)
	end

	arg_18_0:updatePages()

	return
end

function var_0_1.onUpdatePlayer(arg_19_0, arg_19_1)
	arg_19_0.player = arg_19_1
	setText = var_1_10002

	local var_19_0 = arg_19_0.resPanel
	local var_19_1 = var_4.Find(var_19_0, "gem/gem_value")
	local var_19_2 = arg_19_0.player

	var_1_10002(var_19_1, var_5.getTotalGem(var_19_2))

	if arg_19_0.blackFridaySalesGiftPage then
		local var_19_3 = arg_19_0.blackFridaySalesGiftPage

		var_2.onUpdatePlayer(var_19_3, arg_19_1)
	end

	return
end

function var_0_1.onUpdateGift(arg_20_0)
	if arg_20_0.blackFridaySalesGiftPage then
		local var_20_0 = arg_20_0.blackFridaySalesGiftPage

		var_1.onUpdateGift(var_20_0)
	end

	arg_20_0:updatePages()

	return
end

function var_0_1.OnChargeSuccess(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.chargeTipWindow

	var_2.ExecuteAction(var_21_0, "Show", arg_21_1)

	return
end

function var_0_1.willExit(arg_22_0)
	if arg_22_0.chargeTipWindow then
		local var_22_0 = arg_22_0.chargeTipWindow

		var_1.Destroy(var_22_0)

		arg_22_0.chargeTipWindow = nil
	end

	return
end

function var_0_1.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_23_0 = var_1_10000(var_1_10002)
	local var_23_1

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_23_2 = var_1_10002(var_1_10004)
	local var_23_3 = var_2.getActivitiesByType

	ActivityConst = var_1_10005

	local var_23_4 = var_23_3(var_23_2, var_1_10005.ACTIVITY_TYPE_TASKS)

	ipairs = var_1_10003

	for iter_23_0, iter_23_1 in var_1_10003(var_23_4) do
		if iter_23_1:getConfig("config_client").blackFriday then
			var_23_1 = iter_23_1

			break
		end
	end

	local var_23_5 = var_23_0
	local var_23_6 = var_23_0.getActivityByType

	ActivityConst = iter_23_0

	local var_23_7 = var_23_6(var_23_5, iter_23_0.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP)
	local var_23_8 = var_23_0
	local var_23_9 = var_23_0.getActivityByType

	ActivityConst = iter_23_1

	local var_23_10 = var_23_9(var_23_8, iter_23_1.ACTIVITY_TYPE_SKIN_COUPON)

	return var_23_1 and not var_23_1:isEnd() or var_23_7 and not var_23_7:isEnd() or var_23_10 and not var_23_10:isEnd()
end

function var_0_1.isTip()
	local var_24_0

	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_24_1 = var_1_10001(var_1_10003)
	local var_24_2 = var_1.getActivitiesByType

	ActivityConst = var_1_10004

	local var_24_3 = var_24_2(var_24_1, var_1_10004.ACTIVITY_TYPE_TASKS)

	ipairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(var_24_3) do
		var_1_10009 = iter_24_1

		if iter_24_1.getConfig(var_1_10009, "config_client").blackFriday then
			var_24_0 = iter_24_1

			break
		end
	end

	if var_24_0 then
		local var_24_4 = var_24_0

		if not var_24_0.isEnd(var_24_4) then
			getProxy = var_2
			TaskProxy = var_24_4

			local var_24_5 = var_2(var_24_4)
			local var_24_6 = var_24_0:getConfig("config_data")

			ipairs = var_24_4

			for iter_24_2, iter_24_3 in var_24_4(var_24_6) do
				ipairs = var_1_10009

				for iter_24_4, iter_24_5 in var_1_10009(iter_24_3) do
					assert = var_1_10014

					var_1_10014(var_24_5:getTaskVO(iter_24_5), "without this task:" .. iter_24_5)

					local var_24_7 = var_24_5:getTaskVO(iter_24_5)

					if var_1_10014.getTaskStatus(var_24_7) == 1 then
						return true
					end
				end
			end
		end
	end

	return false
end

return var_0_1
