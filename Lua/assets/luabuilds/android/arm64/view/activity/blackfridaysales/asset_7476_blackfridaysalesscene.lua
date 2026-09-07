local BlackFridaySalesScene = class("BlackFridaySalesScene", import("...base.BaseUI"))

BlackFridaySalesScene.TASK_PAGE = 1
BlackFridaySalesScene.SHOP_PAGE = 2
BlackFridaySalesScene.GIFT_PAGE = 3

function BlackFridaySalesScene:getUIName()
	return "BlackFridaySalesUI"
end

function BlackFridaySalesScene:preload(arg_2_1)
	local var_2_0 = {}

	table.insert(var_2_0, function(arg_3_0)
		pg.m02:sendNotification(GAME.GET_NEW_SERVER_SHOP, {
			actType = ActivityConst.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP,
			callback = function(arg_4_0)
				self:SetBlackFridayShop(arg_4_0)
				arg_3_0()

				return
			end
		})

		return
	end)
	parallelAsync(var_2_0, arg_2_1)

	return
end

function BlackFridaySalesScene:SetBlackFridayShop(arg_5_1)
	self.blackFridayShop = arg_5_1

	return
end

function BlackFridaySalesScene:setData()
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

	self.taskActivity = var_6_1 and not var_6_1:isEnd() and var_6_1 or nil
	self.shopActivity = var_6_2 and not var_6_2:isEnd() and var_6_2 or nil
	self.giftActivity = var_6_3 and not var_6_3:isEnd() and var_6_3 or nil
	self.player = getProxy(PlayerProxy):getData()

	return
end

function BlackFridaySalesScene:init()
	self.blurPanel = self._tf:Find("blur_panel")
	self.top = self.blurPanel:Find("adapt/top")
	self.resPanel = self.top:Find("res")
	self.backBtn = self.top:Find("back_btn")
	self.helpBtn = self.top:Find("help_btn")
	self.leftPanel = self._tf:Find("left")
	self.timeTF = self.leftPanel:Find("time")

	local var_7_0 = self.leftPanel:Find("frame/toggle_group/task")
	local var_7_1 = self.leftPanel:Find("frame/toggle_group/shop")
	local var_7_2 = self.leftPanel:Find("frame/toggle_group/gift")

	setText(var_7_0:Find("Image"), i18n("blackfriday_task"))
	setText(var_7_1:Find("Image"), i18n("blackfriday_shop"))
	setText(var_7_2:Find("Image"), i18n("blackfriday_gift"))

	self.toggles = {
		var_7_0,
		var_7_1,
		var_7_2
	}
	self.main = self._tf:Find("main")
	self.pages = {
		self.main:Find("task_container"),
		self.main:Find("shop_container"),
		self.main:Find("gift_container")
	}
	self.chargeTipWindow = ChargeTipWindow.New(self._tf, self.event)

	return
end

function BlackFridaySalesScene:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(BlackFridaySalesScene.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.blackfriday_main_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.resPanel:Find("gem"), function()
		local function var_11_0()
			if not pg.m02:hasMediator(NewShopMainMediator.__cname) then
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
					wrap = ChargeScene.TYPE_DIAMOND
				})
			else
				pg.m02:sendNotification(BlackFridaySalesScene.GO_MALL)
			end

			return
		end

		if PLATFORM_CODE == PLATFORM_JP then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				fontSize = 23,
				yesText = "text_buy",
				content = i18n("word_diamond_tip", self.player:getFreeGem(), self.player:getChargeGem(), self.player:getTotalGem()),
				onYes = var_11_0,
				alignment = TextAnchor.UpperLeft
			})
		else
			var_11_0()
		end

		return
	end, SFX_PANEL)
	self:updatePages()
	self:updateTime()
	setText(self.resPanel:Find("gem/gem_value"), self.player:getTotalGem())

	for iter_8_0, iter_8_1 in ipairs(self.toggles) do
		onToggle(self, iter_8_1, function(arg_13_0)
			setActive(self.pages[iter_8_0], arg_13_0)
			self:updateLocalRedDotData(iter_8_0)
			self:updatePages()
			setActive(self.resPanel, arg_13_0 and iter_8_0 == BlackFridaySalesScene.GIFT_PAGE)

			return
		end)
	end

	setActive(self.toggles[BlackFridaySalesScene.TASK_PAGE], self.taskActivity)
	setActive(self.toggles[BlackFridaySalesScene.SHOP_PAGE], self.shopActivity)
	setActive(self.toggles[BlackFridaySalesScene.GIFT_PAGE], self.giftActivity)

	if self.taskActivity then
		self.page = BlackFridaySalesScene.TASK_PAGE or BlackFridaySalesScene.SHOP_PAGE
	end

	if self.contextData.page then
		self.page = self.contextData.page or self.page
	end

	triggerToggle(self.toggles[self.page], true)

	return
end

function BlackFridaySalesScene:updateShopDedDot()
	setActive(self.toggles[BlackFridaySalesScene.SHOP_PAGE]:Find("tip"), self.blackFridaySalesShopPage:isTip())

	return
end

function BlackFridaySalesScene:updatePages()
	if self.taskActivity then
		if not self.blackFridayTaskPage then
			self.blackFridayTaskPage = BlackFridaySalesTaskPage.New(self.pages[BlackFridaySalesScene.TASK_PAGE], self.event, self.contextData)

			self.blackFridayTaskPage:Reset()
			self.blackFridayTaskPage:Load()
		end

		setActive(self.toggles[BlackFridaySalesScene.TASK_PAGE]:Find("tip"), self.blackFridayTaskPage:isTip())
	end

	if self.shopActivity then
		if not self.blackFridaySalesShopPage then
			self.blackFridaySalesShopPage = BlackFridaySalesShopPage.New(self.pages[BlackFridaySalesScene.SHOP_PAGE], self.event, self.contextData)

			self.blackFridaySalesShopPage:Reset()
			self.blackFridaySalesShopPage:SetShop(self.blackFridayShop)
			self.blackFridaySalesShopPage:Load()
		end

		setActive(self.toggles[BlackFridaySalesScene.SHOP_PAGE]:Find("tip"), self.blackFridaySalesShopPage:isTip())
	end

	if self.giftActivity then
		if not self.blackFridaySalesGiftPage then
			self.blackFridaySalesGiftPage = BlackFridaySalesGiftPage.New(self.pages[BlackFridaySalesScene.GIFT_PAGE], self.event, self.contextData)

			self.blackFridaySalesGiftPage:Reset()
			self.blackFridaySalesGiftPage:Load()
			self.blackFridaySalesGiftPage:initData()
		end

		setActive(self.toggles[BlackFridaySalesScene.GIFT_PAGE]:Find("tip"), self.blackFridaySalesGiftPage:isTip())
	end

	return
end

function BlackFridaySalesScene:updateLocalRedDotData(arg_16_1)
	if arg_16_1 == BlackFridaySalesScene.SHOP_PAGE then
		if self.blackFridaySalesShopPage:isTip() and PlayerPrefs.GetInt("newserver_shop_first_" .. self.player.id) == 0 then
			PlayerPrefs.SetInt("newserver_shop_first_" .. self.player.id, 1)
		end
	elseif arg_16_1 == BlackFridaySalesScene.GIFT_PAGE and self.blackFridaySalesGiftPage:isTip() then
		PlayerPrefs.SetInt("newserver_gift_first_" .. self.player.id, 1)
	end

	return
end

function BlackFridaySalesScene:updateTime()
	local var_17_1 = ((self.taskActivity or nil) and (self.taskActivity.stopTime or self.shopActivity.stopTime)) - pg.TimeMgr.GetInstance():GetServerTime()
	local var_17_2 = math.floor(var_17_1 / 0)

	setText(self.timeTF, i18n("time_remaining_tip") .. i18n("newserver_time", var_17_2, (math.floor((var_17_1 - var_17_2 * 0) / 16))))

	return
end

function BlackFridaySalesScene:onUpdateTask()
	if self.blackFridayTaskPage then
		self.blackFridayTaskPage:onUpdateTask()
	end

	if self.blackFridaySalesShopPage then
		self.blackFridaySalesShopPage:UpdateRes()
	end

	self:updatePages()

	return
end

function BlackFridaySalesScene:onUpdatePlayer(arg_19_1)
	self.player = arg_19_1

	setText(self.resPanel:Find("gem/gem_value"), self.player:getTotalGem())

	if self.blackFridaySalesGiftPage then
		self.blackFridaySalesGiftPage:onUpdatePlayer(arg_19_1)
	end

	return
end

function BlackFridaySalesScene:onUpdateGift()
	if self.blackFridaySalesGiftPage then
		self.blackFridaySalesGiftPage:onUpdateGift()
	end

	self:updatePages()

	return
end

function BlackFridaySalesScene:OnChargeSuccess(arg_21_1)
	self.chargeTipWindow:ExecuteAction("Show", arg_21_1)

	return
end

function BlackFridaySalesScene:willExit()
	if self.chargeTipWindow then
		self.chargeTipWindow:Destroy()

		self.chargeTipWindow = nil
	end

	return
end

function BlackFridaySalesScene.isShow()
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

function BlackFridaySalesScene.isTip()
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

				if var_24_1:getTaskVO(iter_24_5):getTaskStatus() == 1 then
					return true
				end
			end
		end
	end

	return false
end

return BlackFridaySalesScene
