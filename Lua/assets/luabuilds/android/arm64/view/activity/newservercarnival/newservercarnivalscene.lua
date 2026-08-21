local var_0_0 = class("NewServerCarnivalScene", import("...base.BaseUI"))

var_0_0.TASK_PAGE = 1
var_0_0.SHOP_PAGE = 2
var_0_0.GIFT_PAGE = 3

function var_0_0.getUIName(arg_1_0)
	return "NewServerCarnivalUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	table.insert({}, function(arg_3_0)
		pg.m02:sendNotification(GAME.GET_NEW_SERVER_SHOP, {
			callback = function(arg_4_0)
				arg_2_0:SetNewServerShop(arg_4_0)
				arg_3_0()

				return
			end
		})

		return
	end)
	parallelAsync({}, arg_2_1)

	return
end

function var_0_0.SetNewServerShop(arg_5_0, arg_5_1)
	arg_5_0.newServerShop = arg_5_1

	return
end

function var_0_0.setData(arg_6_0)
	local var_6_0 = getProxy(ActivityProxy)
	local var_6_1 = var_6_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_TASK)
	local var_6_2 = var_6_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_SHOP)
	local var_6_3 = var_6_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_GIFT)

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
	arg_7_0.toggles = {
		arg_7_0.leftPanel:Find("frame/toggle_group/task"),
		arg_7_0.leftPanel:Find("frame/toggle_group/shop"),
		arg_7_0.leftPanel:Find("frame/toggle_group/gift")
	}
	arg_7_0.main = arg_7_0._tf:Find("main")
	arg_7_0.pages = {
		arg_7_0.main:Find("task_container"),
		arg_7_0.main:Find("shop_container"),
		arg_7_0.main:Find("gift_container")
	}
	arg_7_0.newServerTaskPage = NewServerTaskPage.New(arg_7_0.pages[var_0_0.TASK_PAGE], arg_7_0.event, arg_7_0.contextData)
	arg_7_0.newServerShopPage = NewServerShopPage.New(arg_7_0.pages[var_0_0.SHOP_PAGE], arg_7_0.event, arg_7_0.contextData)

	arg_7_0.newServerShopPage:SetShop(arg_7_0.newServerShop)

	arg_7_0.newServerGiftPage = NewServerGiftPage.New(arg_7_0.pages[var_0_0.GIFT_PAGE], arg_7_0.event, arg_7_0.contextData)
	arg_7_0.pageDic = {
		[var_0_0.TASK_PAGE] = arg_7_0.newServerTaskPage,
		[var_0_0.SHOP_PAGE] = arg_7_0.newServerShopPage,
		[var_0_0.GIFT_PAGE] = arg_7_0.newServerGiftPage
	}

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
			helps = pg.gametip.newserver_activity_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.resPanel:Find("gem/add_btn"), function()
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
	arg_8_0:updateTime()
	setText(arg_8_0.resPanel:Find("gem/gem_value"), arg_8_0.player:getTotalGem())

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.toggles) do
		onToggle(arg_8_0, iter_8_1, function(arg_13_0)
			arg_8_0:updateLocalRedDotData(iter_8_0)
			arg_8_0:updatePages(iter_8_0, arg_13_0)
			setActive(arg_8_0.resPanel, arg_13_0 and iter_8_0 == var_0_0.GIFT_PAGE)

			return
		end)
	end

	setActive(arg_8_0.toggles[var_0_0.TASK_PAGE], arg_8_0.taskActivity)
	setActive(arg_8_0.toggles[var_0_0.SHOP_PAGE], arg_8_0.shopActivity)
	setActive(arg_8_0.toggles[var_0_0.GIFT_PAGE], arg_8_0.giftActivity)

	if not arg_8_0.contextData.page then
		if arg_8_0.taskActivity then
			arg_8_0.page = var_0_0.TASK_PAGE or var_0_0.SHOP_PAGE

			triggerToggle(arg_8_0.toggles[arg_8_0.page], true)

			return
		end
	end
end

function var_0_0.updateShopDedDot(arg_14_0)
	setActive(arg_14_0.toggles[var_0_0.SHOP_PAGE]:Find("tip"), arg_14_0.newServerShopPage:isTip())

	return
end

function var_0_0.updatePages(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.pageDic[arg_15_1]:isShowing() ~= arg_15_2 then
		if arg_15_2 then
			if arg_15_1 == var_0_0.SHOP_PAGE then
				arg_15_0.pageDic[arg_15_1]:ExecuteAction("Flush")
			else
				arg_15_0.pageDic[arg_15_1]:ExecuteAction("Show")
			end
		else
			arg_15_0.pageDic[arg_15_1]:ExecuteAction("Hide")
		end
	end

	return
end

function var_0_0.updateTips(arg_16_0)
	if arg_16_0.taskActivity then
		setActive(arg_16_0.toggles[var_0_0.TASK_PAGE]:Find("tip"), arg_16_0.newServerTaskPage:isTip())
	end

	if arg_16_0.shopActivity then
		setActive(arg_16_0.toggles[var_0_0.SHOP_PAGE]:Find("tip"), arg_16_0.newServerShopPage:isTip())
	end

	if arg_16_0.giftActivity then
		setActive(arg_16_0.toggles[var_0_0.GIFT_PAGE]:Find("tip"), arg_16_0.newServerGiftPage:isTip())
	end

	return
end

function var_0_0.updateLocalRedDotData(arg_17_0, arg_17_1)
	if arg_17_1 == var_0_0.SHOP_PAGE then
		if arg_17_0.newServerShopPage:isTip() and PlayerPrefs.GetInt("newserver_shop_first_" .. arg_17_0.player.id) == 0 then
			PlayerPrefs.SetInt("newserver_shop_first_" .. arg_17_0.player.id, 1)
		end
	elseif arg_17_1 == var_0_0.GIFT_PAGE and arg_17_0.newServerGiftPage:isTip() then
		PlayerPrefs.SetInt("newserver_gift_first_" .. arg_17_0.player.id, 1)
	end

	return
end

function var_0_0.updateTime(arg_18_0)
	local var_18_0 = pg.TimeMgr.GetInstance()

	if arg_18_0.taskActivity then
		local var_18_1 = arg_18_0.taskActivity.stopTime or arg_18_0.shopActivity.stopTime
		local var_18_2 = var_18_1 - var_18_0:GetServerTime()
		local var_18_3 = math.floor(var_18_2 / 0)

		setText(arg_18_0.timeTF, i18n("newserver_time", var_18_3, (math.floor((var_18_2 - var_18_3 * 0) / 16))))
		setActive(arg_18_0.timeTF:Find("title_activity"), arg_18_0.taskActivity)
		setActive(arg_18_0.timeTF:Find("title_shop"), not arg_18_0.taskActivity)

		return
	end
end

function var_0_0.onUpdateTask(arg_19_0)
	arg_19_0.newServerTaskPage:ActionInvoke("onUpdateTask")
	arg_19_0.newServerShopPage:ActionInvoke("UpdateRes")
	arg_19_0:updateTips()

	return
end

function var_0_0.onUpdatePlayer(arg_20_0, arg_20_1)
	arg_20_0.player = arg_20_1

	setText(arg_20_0.resPanel:Find("gem/gem_value"), arg_20_0.player:getTotalGem())
	arg_20_0.newServerGiftPage:onUpdatePlayer(arg_20_1)

	return
end

function var_0_0.onUpdateGift(arg_21_0)
	arg_21_0.newServerGiftPage:ActionInvoke("onUpdateGift")
	arg_21_0:updateTips()

	return
end

function var_0_0.willExit(arg_22_0)
	arg_22_0.newServerTaskPage:Destroy()
	arg_22_0.newServerShopPage:Destroy()
	arg_22_0.newServerGiftPage:Destroy()

	return
end

function var_0_0.isShow()
	local var_23_0 = getProxy(ActivityProxy)
	local var_23_1 = var_23_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_TASK)
	local var_23_2 = var_23_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_SHOP)
	local var_23_3 = var_23_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_GIFT)

	return var_23_1 and not var_23_1:isEnd() or var_23_2 and not var_23_2:isEnd() or var_23_3 and not var_23_3:isEnd()
end

function var_0_0.isTip()
	return false
end

return var_0_0
