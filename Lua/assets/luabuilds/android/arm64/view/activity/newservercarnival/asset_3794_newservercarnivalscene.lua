local NewServerCarnivalScene = class("NewServerCarnivalScene", import("...base.BaseUI"))

NewServerCarnivalScene.TASK_PAGE = 1
NewServerCarnivalScene.SHOP_PAGE = 2
NewServerCarnivalScene.GIFT_PAGE = 3

function NewServerCarnivalScene:getUIName()
	return "NewServerCarnivalUI"
end

function NewServerCarnivalScene:preload(arg_2_1)
	local var_2_0 = {}

	table.insert(var_2_0, function(arg_3_0)
		pg.m02:sendNotification(GAME.GET_NEW_SERVER_SHOP, {
			callback = function(arg_4_0)
				self:SetNewServerShop(arg_4_0)
				arg_3_0()

				return
			end
		})

		return
	end)
	parallelAsync(var_2_0, arg_2_1)

	return
end

function NewServerCarnivalScene:SetNewServerShop(arg_5_1)
	self.newServerShop = arg_5_1

	return
end

function NewServerCarnivalScene:setData()
	local var_6_0 = getProxy(ActivityProxy)
	local var_6_1 = var_6_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_TASK)
	local var_6_2 = var_6_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_SHOP)
	local var_6_3 = var_6_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_GIFT)

	self.taskActivity = var_6_1 and not var_6_1:isEnd() and var_6_1 or nil
	self.shopActivity = var_6_2 and not var_6_2:isEnd() and var_6_2 or nil
	self.giftActivity = var_6_3 and not var_6_3:isEnd() and var_6_3 or nil
	self.player = getProxy(PlayerProxy):getData()

	return
end

function NewServerCarnivalScene:init()
	self.blurPanel = self._tf:Find("blur_panel")
	self.top = self.blurPanel:Find("adapt/top")
	self.resPanel = self.top:Find("res")
	self.backBtn = self.top:Find("back_btn")
	self.helpBtn = self.top:Find("help_btn")
	self.leftPanel = self._tf:Find("left")
	self.timeTF = self.leftPanel:Find("time")
	self.toggles = {
		self.leftPanel:Find("frame/toggle_group/task"),
		self.leftPanel:Find("frame/toggle_group/shop"),
		self.leftPanel:Find("frame/toggle_group/gift")
	}
	self.main = self._tf:Find("main")
	self.pages = {
		self.main:Find("task_container"),
		self.main:Find("shop_container"),
		self.main:Find("gift_container")
	}
	self.newServerTaskPage = NewServerTaskPage.New(self.pages[NewServerCarnivalScene.TASK_PAGE], self.event, self.contextData)
	self.newServerShopPage = NewServerShopPage.New(self.pages[NewServerCarnivalScene.SHOP_PAGE], self.event, self.contextData)

	self.newServerShopPage:SetShop(self.newServerShop)

	self.newServerGiftPage = NewServerGiftPage.New(self.pages[NewServerCarnivalScene.GIFT_PAGE], self.event, self.contextData)
	self.pageDic = {
		[NewServerCarnivalScene.TASK_PAGE] = self.newServerTaskPage,
		[NewServerCarnivalScene.SHOP_PAGE] = self.newServerShopPage,
		[NewServerCarnivalScene.GIFT_PAGE] = self.newServerGiftPage
	}

	return
end

function NewServerCarnivalScene:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(NewServerCarnivalScene.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.newserver_activity_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.resPanel:Find("gem/add_btn"), function()
		local function var_11_0()
			if not pg.m02:hasMediator(NewShopMainMediator.__cname) then
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
					wrap = ChargeScene.TYPE_DIAMOND
				})
			else
				pg.m02:sendNotification(NewServerCarnivalScene.GO_MALL)
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
	self:updateTime()
	setText(self.resPanel:Find("gem/gem_value"), self.player:getTotalGem())

	for iter_8_0, iter_8_1 in ipairs(self.toggles) do
		onToggle(self, iter_8_1, function(arg_13_0)
			self:updateLocalRedDotData(iter_8_0)
			self:updatePages(iter_8_0, arg_13_0)
			setActive(self.resPanel, arg_13_0 and iter_8_0 == NewServerCarnivalScene.GIFT_PAGE)

			return
		end)
	end

	setActive(self.toggles[NewServerCarnivalScene.TASK_PAGE], self.taskActivity)
	setActive(self.toggles[NewServerCarnivalScene.SHOP_PAGE], self.shopActivity)
	setActive(self.toggles[NewServerCarnivalScene.GIFT_PAGE], self.giftActivity)

	local var_8_0 = self.contextData.page

	if not self.contextData.page then
		if self.taskActivity then
			var_8_0 = NewServerCarnivalScene.TASK_PAGE or NewServerCarnivalScene.SHOP_PAGE
		end
	end

	self.page = var_8_0

	triggerToggle(self.toggles[self.page], true)

	return
end

function NewServerCarnivalScene:updateShopDedDot()
	setActive(self.toggles[NewServerCarnivalScene.SHOP_PAGE]:Find("tip"), self.newServerShopPage:isTip())

	return
end

function NewServerCarnivalScene:updatePages(arg_15_1, arg_15_2)
	if self.pageDic[arg_15_1]:isShowing() ~= arg_15_2 then
		if arg_15_2 then
			if arg_15_1 == NewServerCarnivalScene.SHOP_PAGE then
				self.pageDic[arg_15_1]:ExecuteAction("Flush")
			else
				self.pageDic[arg_15_1]:ExecuteAction("Show")
			end
		else
			self.pageDic[arg_15_1]:ExecuteAction("Hide")
		end
	end

	return
end

function NewServerCarnivalScene:updateTips()
	if self.taskActivity then
		setActive(self.toggles[NewServerCarnivalScene.TASK_PAGE]:Find("tip"), self.newServerTaskPage:isTip())
	end

	if self.shopActivity then
		setActive(self.toggles[NewServerCarnivalScene.SHOP_PAGE]:Find("tip"), self.newServerShopPage:isTip())
	end

	if self.giftActivity then
		setActive(self.toggles[NewServerCarnivalScene.GIFT_PAGE]:Find("tip"), self.newServerGiftPage:isTip())
	end

	return
end

function NewServerCarnivalScene:updateLocalRedDotData(arg_17_1)
	if arg_17_1 == NewServerCarnivalScene.SHOP_PAGE then
		if self.newServerShopPage:isTip() and PlayerPrefs.GetInt("newserver_shop_first_" .. self.player.id) == 0 then
			PlayerPrefs.SetInt("newserver_shop_first_" .. self.player.id, 1)
		end
	elseif arg_17_1 == NewServerCarnivalScene.GIFT_PAGE and self.newServerGiftPage:isTip() then
		PlayerPrefs.SetInt("newserver_gift_first_" .. self.player.id, 1)
	end

	return
end

function NewServerCarnivalScene:updateTime()
	local var_18_1 = ((self.taskActivity or nil) and (self.taskActivity.stopTime or self.shopActivity.stopTime)) - pg.TimeMgr.GetInstance():GetServerTime()
	local var_18_2 = math.floor(var_18_1 / 0)

	setText(self.timeTF, i18n("newserver_time", var_18_2, (math.floor((var_18_1 - var_18_2 * 0) / 16))))
	setActive(self.timeTF:Find("title_activity"), self.taskActivity)
	setActive(self.timeTF:Find("title_shop"), not self.taskActivity)

	return
end

function NewServerCarnivalScene:onUpdateTask()
	self.newServerTaskPage:ActionInvoke("onUpdateTask")
	self.newServerShopPage:ActionInvoke("UpdateRes")
	self:updateTips()

	return
end

function NewServerCarnivalScene:onUpdatePlayer(arg_20_1)
	self.player = arg_20_1

	setText(self.resPanel:Find("gem/gem_value"), self.player:getTotalGem())
	self.newServerGiftPage:onUpdatePlayer(arg_20_1)

	return
end

function NewServerCarnivalScene:onUpdateGift()
	self.newServerGiftPage:ActionInvoke("onUpdateGift")
	self:updateTips()

	return
end

function NewServerCarnivalScene:willExit()
	self.newServerTaskPage:Destroy()
	self.newServerShopPage:Destroy()
	self.newServerGiftPage:Destroy()

	return
end

function NewServerCarnivalScene.isShow()
	local var_23_0 = getProxy(ActivityProxy)
	local var_23_1 = var_23_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_TASK)
	local var_23_2 = var_23_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_SHOP)
	local var_23_3 = var_23_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_GIFT)

	return var_23_1 and not var_23_1:isEnd() or var_23_2 and not var_23_2:isEnd() or var_23_3 and not var_23_3:isEnd()
end

function NewServerCarnivalScene.isTip()
	return false
end

return NewServerCarnivalScene
