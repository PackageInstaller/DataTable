PopLimitTimePackageLayer = class("PopLimitTimePackageLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")

local playermodel = require("model.playermodel")
local time_check_manager = require("controller.time_check_manager")
local item_data = require("data.item_data")
local Utility = require("common.Utility")
local LocalEvent = require("common.LocalEvent")
local var_0_5 = config._DEBUG and 0 or 1
local var_0_6 = "newcomerpackages/pops/"
local var_0_7 = {
	BOUGHT = 3,
	BUY = 2,
	LOCK = 1
}
local var_0_8 = {
	[var_0_7.LOCK] = {
		img = "newcomerpackages/pops/" .. "btn_lock.png"
	},
	[var_0_7.BUY] = {
		img = "newcomerpackages/pops/" .. "btn_buy.png"
	},
	[var_0_7.BOUGHT] = {
		img = "newcomerpackages/pops/" .. "btn_bought.png"
	}
}

function PopLimitTimePackageLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopLimitTimePackageLayer.new()

	var_2_0:initGaussBg(arg_2_1)

	return var_2_0
end

function PopLimitTimePackageLayer:init(arg_3_1)
	self:initData(arg_3_1)
	self:initUI()
	self:registerEvents()
	self:show()
end

function PopLimitTimePackageLayer:initData(arg_4_1)
	if arg_4_1 then
		self.packages = arg_4_1.packages or {}
	end

	if arg_4_1 then
		self.addPackage = arg_4_1.addPackage or nil
	end

	self.curPackage = self.packages[#self.packages] or {}
	self.buyStatus = var_0_7.LOCK
	self.packageCount = #self.packages
	self.packageIndex = 0
	self.btnSwitchs = {}

	if arg_4_1 then
		self.exitCallBack = arg_4_1.exitCallBack or nil
	end

	RoleDefault:getInstance():setBoolForKey("isClickLimit", true)
end

function PopLimitTimePackageLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopLimitTimePackageLayer.json" or "PopLimitTimePackageLayer.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootNode)

	self.rootpanel = self.rootNode:getChildByName("panelRoot")

	self.rootpanel:setAnchorPoint(0.5, 0.5)
	self.rootpanel:setPositionX(GameDisplay.size.width / 2)
	self.rootpanel:setPositionY(GameDisplay.size.height / 2)
	self.rootpanel:setTouchEnabled(false)

	self.panelMain = self.rootpanel:getChildByName("panelMain")

	Utility:alignPanelByParent(self.panelMain, self.rootpanel)

	self.listViewItems = self.panelMain:getChildByName("listViewItems")
	self.panelItem = self.listViewItems:getChildByName("panelItem")

	self.panelItem:retain()

	self.listViewSwitch = self.panelMain:getChildByName("listViewSwitch")
	self.btnSwitch = self.listViewSwitch:getChildByName("btnSwitch")

	self.btnSwitch:retain()

	self.imgRemainTime = self.panelMain:getChildByName("imgRemainTime")
	self.labelRemainTime = self.imgRemainTime:getChildByName("labelRemainTime")
	self.labelChapter = self.panelMain:getChildByName("labelChapter")
	self.imgRole = self.panelMain:getChildByName("imgRole")
	self.btnLeft = self.panelMain:getChildByName("btnLeft")
	self.btnRight = self.panelMain:getChildByName("btnRight")
	self.btnStatus = self.panelMain:getChildByName("btnStatus")
	self.labelPrice = self.btnStatus:getChildByName("labelPrice")

	self:initListViewSwitch()

	if self.packageCount > 0 then
		if self.addPackage then
			local var_5_0 = Utility:indexOf(self.packages, function(arg_6_0)
				return arg_6_0.id == self.addPackage.rechargeid
			end)

			if var_5_0 > 0 then
				self:onBtnSwitch(self.btnSwitchs[var_5_0], var_5_0)
			else
				self:onBtnSwitch(self.btnSwitchs[1], 1)
			end
		else
			self:onBtnSwitch(self.btnSwitchs[1], 1)
		end
	end
end

function PopLimitTimePackageLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.rootNode, handler(self, self.hide))
	Utility:addClickEventListener(self.btnStatus, handler(self, self.onBtnStatus))
	Utility:addClickEventListener(self.btnLeft, handler(self, self.onBtnLeft))
	Utility:addClickEventListener(self.btnRight, handler(self, self.onBtnRight))
	self.panelMain:setTouchEnabled(false)

	self.listener = Utility:registerTouchEventListener(self.panelMain, cc.Handler.EVENT_TOUCH_BEGAN, handler(self, self.onTouchBegan))

	Utility:registerTouchEventListener(self.panelMain, cc.Handler.EVENT_TOUCH_ENDED, handler(self, self.onTouchEnded))
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", handler(self, self.handlePurchaseSuccess)), self)
end

function PopLimitTimePackageLayer:onTouchBegan(arg_8_1, arg_8_2)
	if cc.rectContainsPoint(self.panelMain:getBoundingBox(), (self.rootpanel:convertToNodeSpace(arg_8_1:getLocation()))) then
		self.listener:setSwallowTouches(true)

		return true
	else
		self.listener:setSwallowTouches(false)

		return false
	end
end

function PopLimitTimePackageLayer:onTouchEnded(arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1:getStartLocation()
	local var_9_1 = arg_9_1:getLocation()

	if math.abs(var_9_0.x - var_9_1.x) > 50 then
		if var_9_0.x > var_9_1.x then
			self:onBtnRight()
		else
			self:onBtnLeft()
		end
	end
end

function PopLimitTimePackageLayer:initListViewSwitch()
	self.listViewSwitch:removeAllChildren()
	self.btnSwitch:setContentSize((self.listViewSwitch:getContentSize().width - (self.packageCount - 1) * self.listViewSwitch:getItemsMargin()) / self.packageCount, self.btnSwitch:getContentSize().height)
	self.btnSwitch:ignoreContentAdaptWithSize(false)

	for iter_10_0 = 1, self.packageCount do
		local var_10_0 = self.btnSwitch:clone()

		Utility:addClickEventListener(var_10_0, handler(self, self.onBtnSwitch), iter_10_0)
		self.listViewSwitch:pushBackCustomItem(var_10_0)

		self.btnSwitchs[#self.btnSwitchs + 1] = var_10_0
	end

	self.listViewSwitch:setVisible(self.packageCount > 1)
end

function PopLimitTimePackageLayer:onBtnSwitch(arg_11_1, arg_11_2)
	if arg_11_2 == self.packageIndex then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(self.btnSwitchs) do
		iter_11_1:setTouchEnabled(iter_11_0 ~= arg_11_2)
		iter_11_1:setBright(iter_11_0 ~= arg_11_2)
	end

	self.curPackage = self.packages[arg_11_2]
	self.packageIndex = arg_11_2

	self:updateLayout()
end

function PopLimitTimePackageLayer:updateLayout()
	local var_12_1 = (self.curPackage.have_bought or 0) < (self.curPackage.buy_limit or 0)
	local var_12_2 = false

	self.labelPrice:setVisible((self.curPackage.have_bought or 0) < (self.curPackage.buy_limit or 0))
	self.labelPrice:setString(string.format("￥%d  购买", self.curPackage.rmb or 0))
	self.imgRole:loadTexture(var_0_6 .. "role_" .. self.curPackage.order .. ".png", var_0_5)
	self.labelChapter:setString(self.curPackage.name)

	self.buyStatus = var_12_2 and var_0_7.LOCK or var_12_1 and var_0_7.BUY or var_0_7.BOUGHT

	self.btnStatus:loadTextures(var_0_8[self.buyStatus].img, nil, var_0_8[self.buyStatus].img, var_0_5)

	local var_12_3 = math.max(0, global_get_time_by_date(self.curPackage.finishtime or 0) - time_check_manager:getCurTime())

	self.labelRemainTime:setString("剩余时间: " .. Utility:formatTimeStr(var_12_3))
	self.labelRemainTime:stopAllActions()
	self.labelRemainTime:runAction((Utility:createClockTimerAction(self.labelRemainTime, 1, var_12_3, function(arg_13_0)
		self.labelRemainTime:setString("剩余时间: " .. Utility:formatTimeStr(arg_13_0))
	end)))
	self.btnLeft:setVisible(self.packageIndex ~= 1)
	self.btnRight:setVisible(self.packageIndex ~= self.packageCount)
	self:updateRewards()
end

function PopLimitTimePackageLayer:updateRewards()
	self.listViewItems:removeAllChildren()

	if self.curPackage.dropid then
		local var_14_0 = Utility:getDropData(self.curPackage.dropid)

		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			local var_14_1 = self.panelItem:clone()
			local var_14_2 = var_14_1:getChildByName("imgItem")
			local var_14_3 = var_14_1:getChildByName("labelCount")
			local var_14_4 = 0
			local var_14_6

			if iter_14_1.itemid == "gold" then
				var_14_4 = 1000001
				var_14_6 = 88
			elseif self.itemid == "diamond" then
				var_14_4 = 1000000
				var_14_6 = 88
			else
				var_14_4 = item_data[iter_14_1.itemid].image_id
				var_14_6 = item_data[iter_14_1.itemid].bag_item_type
			end

			var_14_2:loadTexture("equipment/" .. var_14_4 .. ".png")
			var_14_2:setScale(global_get_item_scale(var_14_2, var_14_6) * 0.6)
			var_14_3:setString("x" .. iter_14_1.num)
			Utility:addClickEventListener(var_14_1, function()
				LayerManager:pushInLayer("PopItemLayer", {
					itemid = iter_14_1.itemid
				})
			end)
			self.listViewItems:pushBackCustomItem(var_14_1)
		end

		local var_14_7 = self.panelItem:getContentSize().width * #var_14_0 + self.listViewItems:getItemsMargin() * (#var_14_0 - 1)
		local var_14_8 = var_14_7 - self.listViewItems:getContentSize().width

		self.listViewItems:setInnerContainerSize(cc.size(var_14_7, self.listViewItems:getContentSize().height))
		self.listViewItems:setContentSize(cc.size(var_14_7, self.listViewItems:getContentSize().height))
		self.listViewItems:setAnchorPoint(0.5, 0)
		self.listViewItems:setPosition(420, 160)
	end
end

function PopLimitTimePackageLayer:onBtnStatus()
	if self.buyStatus ~= var_0_7.BUY then
		return
	end

	self:rechargeById(self.curPackage.id)
end

function PopLimitTimePackageLayer:onBtnLeft()
	self.packageIndex = Utility:clamp(self.packageIndex - 1, 1, self.packageCount)
	self.curPackage = self.packages[self.packageIndex]

	for iter_17_0, iter_17_1 in ipairs(self.btnSwitchs) do
		iter_17_1:setTouchEnabled(iter_17_0 ~= self.packageIndex)
		iter_17_1:setBright(iter_17_0 ~= self.packageIndex)
	end

	self:updateLayout()
end

function PopLimitTimePackageLayer:onBtnRight()
	self.packageIndex = Utility:clamp(self.packageIndex + 1, 1, self.packageCount)
	self.curPackage = self.packages[self.packageIndex]

	for iter_18_0, iter_18_1 in ipairs(self.btnSwitchs) do
		iter_18_1:setTouchEnabled(iter_18_0 ~= self.packageIndex)
		iter_18_1:setBright(iter_18_0 ~= self.packageIndex)
	end

	self:updateLayout()
end

function PopLimitTimePackageLayer.onEnter(arg_19_0)
	RoleDefault:getInstance():setBoolForKey("isClickLimit", true)
end

function PopLimitTimePackageLayer:onExit()
	self.panelItem:release()
	self.btnSwitch:release()
end

function PopLimitTimePackageLayer:show()
	self.showActions.extendVertical(self)
end

function PopLimitTimePackageLayer:hide()
	self.hideActions.shrinkVertical(self, function()
		if self.exitCallBack then
			self.exitCallBack()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopLimitTimePackageLayer.rechargeById(arg_24_0, arg_24_1, arg_24_2)
	local network = require("network.network")
	local recharge_manager = require("controller.recharge_manager")

	;(function(arg_25_0, arg_25_1)
		network:rpc("check_recharge", {
			id = arg_25_0,
			client = config.clientmode
		}, function(arg_26_0)
			if arg_25_1 then
				arg_25_1(arg_26_0)
			end
		end)
	end)(arg_24_1, function(arg_27_0)
		if arg_27_0.result == 1 then
			AnalyticManager.clickPurchaseItem({
				product = arg_24_1,
				rolenum = playermodel:getOwnedServantNum(),
				grade = playermodel.grade,
				class = playermodel.class
			})
			recharge_manager:confirmPayment(arg_24_1)

			if arg_24_2 then
				arg_24_2(arg_27_0)
			end
		elseif arg_27_0.result == 2 then
			print("测试模式")
		elseif arg_27_0.result == 3 then
			global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
		elseif arg_27_0.result == 4 then
			global_ShowBlockWords(L_RECHARGE_OUT_TIME)
		elseif arg_27_0.result == 5 then
			global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
		elseif arg_27_0.result == 6 then
			global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
		end
	end)
end

function PopLimitTimePackageLayer:handlePurchaseSuccess()
	self.curPackage.have_bought = self.curPackage.have_bought + 1

	self:updateLayout()
end
