local var_0_0 = class("BlackFridaySalesScene", import("...base.BaseUI"))

var_0_0.TASK_PAGE = 1
var_0_0.SHOP_PAGE = 2
var_0_0.GIFT_PAGE = 3

function var_0_0.getUIName(arg_1_0)
	return "BlackFridaySalesUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	table.insert({}, function(arg_3_0)
		pg.m02:sendNotification(GAME.GET_NEW_SERVER_SHOP, {
			actType = ActivityConst.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP,
			callback = function(arg_4_0)
				arg_2_0:SetBlackFridayShop(arg_4_0)
				arg_3_0()

				return
			end
		})

		return
	end)
	parallelAsync({}, arg_2_1)

	return
end

function var_0_0.SetBlackFridayShop(arg_5_0, arg_5_1)
	arg_5_0.blackFridayShop = arg_5_1

	return
end

function var_0_0.setData(arg_6_0)
	local var_6_0 = getProxy(ActivityProxy)
	local var_6_1

	for iter_6_0, iter_6_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASKS))) do
		if iter_6_1:getConfig("config_client").blackFriday then
			var_6_1 = iter_6_1

			break
		end
	end

	local var_6_2 = var_6_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP)
	local var_6_3 = var_6_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_GIFT_UP)

	arg_6_0.taskActivity = var_6_1 and not var_6_1:isEnd() and var_6_1 or nil
	arg_6_0.shopActivity = var_6_2 and not var_6_2:isEnd() and var_6_2 or nil
	arg_6_0.giftActivity = var_6_3 and not var_6_3:isEnd() and var_6_3 or nil
	arg_6_0.player = getProxy(PlayerProxy):getData()

	return
end

function var_0_0.init(arg_7_0)
	arg_7_0.blurPanel = arg_7_0._tf:Find("blur_panel")
	arg_7_0.top = arg_7_0.blurPanel:Find("adapt/top")
	arg_7_0.resPanel = arg_7_0.top:Find("res")
	arg_7_0.backBtn = arg_7_0.top:Find("back_btn")
	arg_7_0.helpBtn = arg_7_0.top:Find("help_btn")
	arg_7_0.leftPanel = arg_7_0._tf:Find("left")
	arg_7_0.timeTF = arg_7_0.leftPanel:Find("time")

	local var_7_0 = arg_7_0.leftPanel:Find("frame/toggle_group/task")
	local var_7_1 = arg_7_0.leftPanel:Find("frame/toggle_group/shop")
	local var_7_2 = arg_7_0.leftPanel:Find("frame/toggle_group/gift")

	setText(var_7_0:Find("Image"), i18n("blackfriday_task"))
	setText(var_7_1:Find("Image"), i18n("blackfriday_shop"))
	setText(var_7_2:Find("Image"), i18n("blackfriday_gift"))

	arg_7_0.toggles = {
		var_7_0,
		var_7_1,
		var_7_2
	}
	arg_7_0.main = arg_7_0._tf:Find("main")
	arg_7_0.pages = {
		arg_7_0.main:Find("task_container"),
		arg_7_0.main:Find("shop_container"),
		arg_7_0.main:Find("gift_container")
	}
	arg_7_0.chargeTipWindow = ChargeTipWindow.New(arg_7_0._tf, arg_7_0.event)

	return
end

function var_0_0.didEnter(arg_8_0)
	onButton(arg_8_0, arg_8_0.backBtn, function()
		arg_8_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.blackfriday_main_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.resPanel:Find("gem"), function()
		if PLATFORM_CODE == PLATFORM_JP then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				fontSize = 23,
				yesText = "text_buy",
				content = i18n("word_diamond_tip", arg_8_0.player:getFreeGem(), arg_8_0.player:getChargeGem(), arg_8_0.player:getTotalGem()),
				onYes = function()
					if not pg.m02:hasMediator(NewShopMainMediator.__cname) then
						pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
							wrap = ChargeScene.TYPE_DIAMOND
						})
					else
						pg.m02:sendNotification(var_0_0.GO_MALL)
					end

					return
				end,
				alignment = TextAnchor.UpperLeft
			})
		else
			(function()
				if not pg.m02:hasMediator(NewShopMainMediator.__cname) then
					pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
						wrap = ChargeScene.TYPE_DIAMOND
					})
				else
					pg.m02:sendNotification(var_0_0.GO_MALL)
				end

				return
			end)()
		end

		return
	end, SFX_PANEL)
	arg_8_0:updatePages()
	arg_8_0:updateTime()
	setText(arg_8_0.resPanel:Find("gem/gem_value"), arg_8_0.player:getTotalGem())

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.toggles) do
		onToggle(arg_8_0, iter_8_1, function(arg_13_0)
			setActive(arg_8_0.pages[iter_8_0], arg_13_0)
			arg_8_0:updateLocalRedDotData(iter_8_0)
			arg_8_0:updatePages()
			setActive(arg_8_0.resPanel, arg_13_0 and iter_8_0 == var_0_0.GIFT_PAGE)

			return
		end)
	end

	setActive(arg_8_0.toggles[var_0_0.TASK_PAGE], arg_8_0.taskActivity)
	setActive(arg_8_0.toggles[var_0_0.SHOP_PAGE], arg_8_0.shopActivity)
	setActive(arg_8_0.toggles[var_0_0.GIFT_PAGE], arg_8_0.giftActivity)

	if arg_8_0.taskActivity then
		arg_8_0.page = var_0_0.TASK_PAGE or var_0_0.SHOP_PAGE

		if arg_8_0.contextData.page then
			arg_8_0.page = arg_8_0.contextData.page or arg_8_0.page

			triggerToggle(arg_8_0.toggles[arg_8_0.page], true)

			return
		end
	end
end

function var_0_0.updateShopDedDot(arg_14_0)
	setActive(arg_14_0.toggles[var_0_0.SHOP_PAGE]:Find("tip"), arg_14_0.blackFridaySalesShopPage:isTip())

	return
end

function var_0_0.updatePages(arg_15_0)
	if arg_15_0.taskActivity then
		if not arg_15_0.blackFridayTaskPage then
			arg_15_0.blackFridayTaskPage = BlackFridaySalesTaskPage.New(arg_15_0.pages[var_0_0.TASK_PAGE], arg_15_0.event, arg_15_0.contextData)

			arg_15_0.blackFridayTaskPage:Reset()
			arg_15_0.blackFridayTaskPage:Load()
		end

		setActive(arg_15_0.toggles[var_0_0.TASK_PAGE]:Find("tip"), arg_15_0.blackFridayTaskPage:isTip())
	end

	if arg_15_0.shopActivity then
		if not arg_15_0.blackFridaySalesShopPage then
			arg_15_0.blackFridaySalesShopPage = BlackFridaySalesShopPage.New(arg_15_0.pages[var_0_0.SHOP_PAGE], arg_15_0.event, arg_15_0.contextData)

			arg_15_0.blackFridaySalesShopPage:Reset()
			arg_15_0.blackFridaySalesShopPage:SetShop(arg_15_0.blackFridayShop)
			arg_15_0.blackFridaySalesShopPage:Load()
		end

		setActive(arg_15_0.toggles[var_0_0.SHOP_PAGE]:Find("tip"), arg_15_0.blackFridaySalesShopPage:isTip())
	end

	if arg_15_0.giftActivity then
		if not arg_15_0.blackFridaySalesGiftPage then
			arg_15_0.blackFridaySalesGiftPage = BlackFridaySalesGiftPage.New(arg_15_0.pages[var_0_0.GIFT_PAGE], arg_15_0.event, arg_15_0.contextData)

			arg_15_0.blackFridaySalesGiftPage:Reset()
			arg_15_0.blackFridaySalesGiftPage:Load()
			arg_15_0.blackFridaySalesGiftPage:initData()
		end

		setActive(arg_15_0.toggles[var_0_0.GIFT_PAGE]:Find("tip"), arg_15_0.blackFridaySalesGiftPage:isTip())
	end

	return
end

function var_0_0.updateLocalRedDotData(arg_16_0, arg_16_1)
	if arg_16_1 == var_0_0.SHOP_PAGE then
		if arg_16_0.blackFridaySalesShopPage:isTip() and PlayerPrefs.GetInt("newserver_shop_first_" .. arg_16_0.player.id) == 0 then
			PlayerPrefs.SetInt("newserver_shop_first_" .. arg_16_0.player.id, 1)
		end
	elseif arg_16_1 == var_0_0.GIFT_PAGE and arg_16_0.blackFridaySalesGiftPage:isTip() then
		PlayerPrefs.SetInt("newserver_gift_first_" .. arg_16_0.player.id, 1)
	end

	return
end

function var_0_0.updateTime(arg_17_0)
	local var_17_0 = pg.TimeMgr.GetInstance()

	if arg_17_0.taskActivity then
		local var_17_1 = arg_17_0.taskActivity.stopTime or arg_17_0.shopActivity.stopTime
		local var_17_2 = var_17_1 - var_17_0:GetServerTime()
		local var_17_3 = math.floor(var_17_2 / 0)

		setText(arg_17_0.timeTF, i18n("time_remaining_tip") .. i18n("newserver_time", var_17_3, (math.floor((var_17_2 - var_17_3 * 0) / 16))))

		return
	end
end

function var_0_0.onUpdateTask(arg_18_0)
	if arg_18_0.blackFridayTaskPage then
		arg_18_0.blackFridayTaskPage:onUpdateTask()
	end

	if arg_18_0.blackFridaySalesShopPage then
		arg_18_0.blackFridaySalesShopPage:UpdateRes()
	end

	arg_18_0:updatePages()

	return
end

function var_0_0.onUpdatePlayer(arg_19_0, arg_19_1)
	arg_19_0.player = arg_19_1

	setText(arg_19_0.resPanel:Find("gem/gem_value"), arg_19_0.player:getTotalGem())

	if arg_19_0.blackFridaySalesGiftPage then
		arg_19_0.blackFridaySalesGiftPage:onUpdatePlayer(arg_19_1)
	end

	return
end

function var_0_0.onUpdateGift(arg_20_0)
	if arg_20_0.blackFridaySalesGiftPage then
		arg_20_0.blackFridaySalesGiftPage:onUpdateGift()
	end

	arg_20_0:updatePages()

	return
end

function var_0_0.OnChargeSuccess(arg_21_0, arg_21_1)
	arg_21_0.chargeTipWindow:ExecuteAction("Show", arg_21_1)

	return
end

function var_0_0.willExit(arg_22_0)
	if arg_22_0.chargeTipWindow then
		arg_22_0.chargeTipWindow:Destroy()

		arg_22_0.chargeTipWindow = nil
	end

	return
end

function var_0_0.isShow()
	local var_23_0 = getProxy(ActivityProxy)
	local var_23_1

	for iter_23_0, iter_23_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASKS))) do
		if iter_23_1:getConfig("config_client").blackFriday then
			var_23_1 = iter_23_1

			break
		end
	end

	local var_23_2 = var_23_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP)
	local var_23_3 = var_23_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_SKIN_COUPON)

	return var_23_1 and not var_23_1:isEnd() or var_23_2 and not var_23_2:isEnd() or var_23_3 and not var_23_3:isEnd()
end

function var_0_0.isTip()
	local var_24_0

	for iter_24_0, iter_24_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASKS))) do
		if iter_24_1:getConfig("config_client").blackFriday then
			var_24_0 = iter_24_1

			break
		end
	end

	if var_24_0 and not var_24_0:isEnd() then
		local var_24_1 = getProxy(TaskProxy)

		for iter_24_2, iter_24_3 in ipairs((var_24_0:getConfig("config_data"))) do
			for iter_24_4, iter_24_5 in ipairs(iter_24_3) do
				assert(var_24_1:getTaskVO(iter_24_5), "without this task:" .. iter_24_5)

				local var_24_2 = var_24_1:getTaskVO(iter_24_5)

				if var_24_2:getTaskStatus() == 1 then
					return true
				end
			end
		end
	end

	return false
end

return var_0_0
