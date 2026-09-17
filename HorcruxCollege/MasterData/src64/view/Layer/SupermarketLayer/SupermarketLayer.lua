SupermarketLayer = class("SupermarketLayer", function()
	return cc.Layer:create()
end)

local supermarket_manager = require("controller.supermarket_manager")
local texture_manager = require("controller.texture_manager")
local item_data = require("data.item_data")
local supermarket_tab_data = require("data.supermarket_tab_data")
local playermodel = require("model.playermodel")
local var_0_5 = 1
local var_0_6 = 2
local var_0_7 = 3
local var_0_8 = 4
local var_0_9 = 5
local var_0_10 = 105
local var_0_11 = 106
local var_0_12 = 107
local var_0_13 = 108
local var_0_14 = 120
local var_0_15
local var_0_16 = config._DEBUG and 0 or 1
local var_0_17 = {
	"public/reddot/reddot2.png",
	"public/reddot/new.png",
	"public/reddot/reddot2.png"
}

function SupermarketLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = SupermarketLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function SupermarketLayer:init(arg_3_1)
	var_0_15 = self

	supermarket_manager:registerUIRef(self)
	self:initUI()
	supermarket_manager:initData(function()
		if not var_0_15 then
			return
		end

		supermarket_manager:setReddotTouchStat()

		if arg_3_1 and arg_3_1.showtab then
			supermarket_manager:setCurSelectTab(arg_3_1.showtab)
		elseif arg_3_1 and arg_3_1.tab then
			supermarket_manager:setCurSelectTab(arg_3_1.tab)
		elseif arg_3_1 and arg_3_1.group then
			supermarket_manager:setCurSelectGroup(arg_3_1.group)
		else
			local var_4_0 = supermarket_manager:getReddotTab()

			if playermodel.class < 2 then
				supermarket_manager:setCurSelectTab(5, var_4_0)
			elseif var_4_0 then
				supermarket_manager:setCurSelectTab(var_4_0)
			end
		end

		self:pushAnalytic()
		self:updateUI()
	end, arg_3_1)
	self:initEventListener()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_15 = nil

			supermarket_manager:unregisterUIRef()

			if arg_3_1 and arg_3_1.callback then
				arg_3_1.callback()
			end
		end
	end)
end

function SupermarketLayer:initUI()
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.rootLayer:setAnchorPoint(cc.p(0, 0))
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)

	self.mainViewLayer = ccui.Layout:create()

	self.mainViewLayer:setTouchEnabled(true)
	self.mainViewLayer:setContentSize(640, 950 + GameDisplay.fix_y * 2)
	self.mainViewLayer:setAnchorPoint(cc.p(0, 0))
	self.mainViewLayer:setPosition(cc.p(0, 124))
	self.mainViewLayer:setClippingEnabled(true)
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootLayer:addChild(self.mainViewLayer)

	self.bottomBg = ccui.ImageView:create("SupermarketLayer/bottom_bg.png", var_0_16)

	self.bottomBg:setPositionX(320)
	self.bottomBg:setPositionY(self.bottomBg:getContentSize().height / 2)
	self.bottomBg:setTouchEnabled(true)
	self.rootLayer:addChild(self.bottomBg, 2)

	self.returnBtn = ccui.Button:create("SupermarketLayer/btn_return.png", nil, "SupermarketLayer/btn_return.png", var_0_16)

	self.returnBtn:setPosition(cc.p(50, 38))
	self.returnBtn:addTouchEventListener(self:getReturnBtnHandel())
	self.rootLayer:addChild(self.returnBtn, 5)

	self.groupScorllView = ccui.ScrollView:create()

	self.groupScorllView:setBounceEnabled(false)
	self.groupScorllView:setPosition(cc.p(100, 0))
	self.groupScorllView:setContentSize(cc.size(540, 200))
	self.groupScorllView:setInnerContainerSize(cc.size(640, 200))
	self.groupScorllView:setDirection(ccui.ScrollViewDir.horizontal)
	self.groupScorllView:setTouchEnabled(false)
	self.rootLayer:addChild(self.groupScorllView, 4)

	self.tabScorllView = ccui.ScrollView:create()

	self.tabScorllView:setBounceEnabled(false)
	self.tabScorllView:setPosition(cc.p(0, 105))
	self.tabScorllView:setContentSize(cc.size(640, 100))
	self.tabScorllView:setInnerContainerSize(cc.size(640, 100))
	self.tabScorllView:setDirection(ccui.ScrollViewDir.horizontal)
	self.tabScorllView:setTouchEnabled(false)
	self.rootLayer:addChild(self.tabScorllView, 3)
end

function SupermarketLayer.getReturnBtnHandel(arg_7_0, ...)
	return function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_7_0.__cname == "PopSupermarketLayer" then
			LayerManager:removePopLayer(arg_7_0.__queueindex)
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("popSupermarketLayerReturn"))
		else
			KeyCodeManager:onKeyReleasedCallFunc()
		end
	end
end

function SupermarketLayer.getGroupBtnHandel(arg_9_0, ...)
	return function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if supermarket_manager:getCurSelectGroup() == arg_10_0.group then
			return
		end

		supermarket_manager:setCurSelectGroup(arg_10_0.group)
		supermarket_manager:setCurSelectTab()
		supermarket_manager:setReddotTouchStat()
		arg_9_0:pushAnalytic()
		hx_print("grouptab:" .. supermarket_manager:getCurSelectTab(), CONSOLE_COLOR_GREEN)
		arg_9_0:updateUI()
	end
end

function SupermarketLayer.getTabBtnHandel(arg_11_0, ...)
	return function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if supermarket_manager:getCurSelectTab() == arg_12_0.tab then
			return
		end

		supermarket_manager:setCurSelectTab(arg_12_0.tab)
		supermarket_manager:setReddotTouchStat()
		arg_11_0:pushAnalytic()
		hx_print("tab:" .. supermarket_manager:getCurSelectTab(), CONSOLE_COLOR_GREEN)
		arg_11_0:updateUI()
	end
end

function SupermarketLayer.getCurrencyTouchHandel(arg_13_0, ...)
	local var_13_0 = {
		[SHOP_CURRENCY_GOLD] = function()
			return
		end,
		[SHOP_CURRENCY_DIAMOND] = function()
			hx_print("切换到充值钻石", CONSOLE_COLOR_RED)
		end,
		[SHOP_CURRENCY_HORNOR] = function()
			return
		end,
		[SHOP_CURRENCY_EXPLORECOIN] = function()
			return
		end,
		[BLACK_CARD] = function()
			return
		end,
		[BLACK_SP_CARD] = function()
			return
		end,
		[GIFT_TICKET] = function()
			hx_print("切换到充值礼品卡", CONSOLE_COLOR_RED)
		end
	}

	setmetatable(var_13_0, {
		__index = function(arg_21_0, arg_21_1)
			return function(arg_22_0)
				if arg_22_0 then
					LayerManager:pushInLayer("PopItemLayer", {
						itemid = arg_22_0
					})
				end
			end
		end
	})

	return function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_13_0[arg_23_0.itemid]()
		print(arg_23_0.itemid)
		hx_print("getCurrencyTouchHandel" .. arg_23_0.itemid, CONSOLE_COLOR_GREEN)
	end
end

function SupermarketLayer:updateUI(...)
	if supermarket_manager:getCurSelectTab() ~= 9999 then
		supermarket_manager:updateCurrencyList()
	end

	;(function(...)
		local var_25_0 = supermarket_manager:getCurMainViewSpriteType()

		self.mainViewList = self.mainViewList or {}

		local var_25_1 = self.mainViewList[var_25_0]

		if not self.mainViewList[var_25_0] then
			var_25_1 = self:createMainViewSprite(var_25_0)
			self.mainViewList[var_25_0] = var_25_1

			self.mainViewLayer:addChild(var_25_1)
		elseif var_25_0 == var_0_11 or var_25_0 == var_0_12 or var_25_0 == var_0_13 then
			var_25_1:removeFromParent()

			self.mainViewList[var_25_0] = nil
			var_25_1 = self:createMainViewSprite(var_25_0)
			self.mainViewList[var_25_0] = var_25_1

			self.mainViewLayer:addChild(var_25_1)
		else
			var_25_1:updateBySupermarketLayer((supermarket_manager:getCurMainViewSpriteParam()))
		end

		for iter_25_0, iter_25_1 in pairs(self.mainViewList) do
			iter_25_1:setVisible(iter_25_0 == var_25_0)

			if iter_25_1.updateTouch then
				iter_25_1:updateTouch(iter_25_0 == var_25_0)
			end
		end
	end)()
	self:updateSelectGroupBtn()
	self:updateTabBtn()
	self:updateTitle()
end

function SupermarketLayer:createTitle(...)
	self.title = ccui.ImageView:create("SupermarketLayer/1_title.png", var_0_16)

	self.title:setPosition(cc.p(320, self.rootLayer:getContentSize().height - self.title:getContentSize().height / 2))
	self.rootLayer:addChild(self.title, 3)

	local function var_26_0()
		local var_27_0 = ccui.Layout:create()

		var_27_0:setTouchEnabled(true)
		var_27_0:setContentSize(cc.size(150, 60))
		var_27_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		var_27_0:addTouchEventListener(self:getCurrencyTouchHandel())

		local var_27_1 = ccui.ImageView:create("GUI/image.png", var_0_16)

		var_27_1:setPositionX(var_27_0:getContentSize().width / 2)
		var_27_1:setPositionY(var_27_0:getContentSize().height / 2)
		var_27_1:setName("currencyImg")
		var_27_0:addChild(var_27_1)

		local var_27_2 = ccui.Text:create("", FONT_DES, 22)

		var_27_2:setPositionX(var_27_0:getContentSize().width / 2)
		var_27_2:setPositionY(var_27_0:getContentSize().height / 2)
		var_27_2:setName("currencyNumLabel")
		var_27_0:addChild(var_27_2)

		function var_27_0:update(arg_28_1)
			self.itemid = arg_28_1

			local var_28_0 = self:getContentSize().width / 2
			local var_28_1 = supermarket_manager:getCurrencyPath(arg_28_1)

			if var_28_1:find("equipment") then
				ccui.Helper:seekWidgetByName(self, "currencyImg"):loadTexture(var_28_1, var_0_16)
			else
				ccui.Helper:seekWidgetByName(self, "currencyImg"):loadTexture(var_28_1, var_0_16)
			end

			ccui.Helper:seekWidgetByName(self, "currencyNumLabel"):setString(global_trans_number(supermarket_manager:getCurrencyNum(arg_28_1)))

			local var_28_2 = ccui.Helper:seekWidgetByName(self, "currencyImg")

			var_27_1:setPositionX(var_28_0 - ccui.Helper:seekWidgetByName(self, "currencyNumLabel").getContentSize(var_28_2).width / 2)
			var_27_2:setPositionX(var_28_0 + (var_28_2:getContentSize().width + 10) / 2)
		end

		return var_27_0
	end

	function self.title:update()
		while ccui.Helper:seekWidgetByName(self, "currency_panel_" .. 1) do
			ccui.Helper:seekWidgetByName(self, "currency_panel_" .. 1):setVisible(false)
		end

		for iter_29_0, iter_29_1 in pairs((supermarket_manager:getCurrencyList())) do
			local var_29_1 = ccui.Helper:seekWidgetByName(self, "currency_panel_" .. iter_29_0)

			if not var_29_1 then
				var_29_1 = var_26_0()

				var_29_1:setName("currency_panel_" .. iter_29_0)
				self:addChild(var_29_1)
			end

			var_29_1:setPositionX(640 - var_29_1:getContentSize().width * iter_29_0)
			var_29_1:setVisible(true)
			var_29_1:update(iter_29_1)
		end

		self:loadTexture("SupermarketLayer/" .. supermarket_manager:getCurSelectGroup() .. "_title.png", var_0_16)
	end
end

function SupermarketLayer:updateTitle(...)
	if not self.title then
		self:createTitle()
	end

	self.title:update()
end

function SupermarketLayer:updateReddot(...)
	self:updateSelectGroupBtn()
	self:updateTabBtn()
end

function SupermarketLayer:updateSelectGroupBtn(...)
	while ccui.Helper:seekWidgetByName(self.groupScorllView, "groupbtn_" .. 1) do
		ccui.Helper:seekWidgetByName(self.groupScorllView, "groupbtn_" .. 1):setVisible(false)

		if ccui.Helper:seekWidgetByName(self.groupScorllView, "imgReddot_" .. 1) then
			ccui.Helper:seekWidgetByName(self.groupScorllView, "imgReddot_" .. 1):setVisible(false)
		end
	end

	local var_32_1 = supermarket_manager:getCurSelectGroup()
	local var_32_2 = 0

	for iter_32_0, iter_32_1 in pairs((supermarket_manager:getGroupList())) do
		local var_32_3 = iter_32_1.id
		local var_32_4 = ccui.Helper:seekWidgetByName(self.groupScorllView, "groupbtn_" .. iter_32_0)

		if not var_32_4 then
			var_32_4 = ccui.Button:create("SupermarketLayer/" .. iter_32_1.id .. "_off.png", nil, "SupermarketLayer/" .. iter_32_1.id .. "_off.png", var_0_16)

			var_32_4:setName("groupbtn_" .. iter_32_0)
			var_32_4:setPosition(cc.p(62 + (iter_32_0 - 1) * var_32_4:getContentSize().width, 64))
			var_32_4:setTouchEnabled(false)
			self.groupScorllView:addChild(var_32_4)

			local var_32_5 = ccui.Layout:create()

			var_32_5:setTouchEnabled(true)
			var_32_5:setContentSize(cc.size(var_32_4:getContentSize().width, 80))
			var_32_5:setPosition(cc.p(62 + (iter_32_0 - 1.5) * var_32_4:getContentSize().width, 0))
			var_32_5:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
			var_32_5:setName("groupbtn_touchlayer_" .. iter_32_0)
			var_32_5:addTouchEventListener(self:getGroupBtnHandel())
			self.groupScorllView:addChild(var_32_5)
		end

		var_32_4:setVisible(true)

		ccui.Helper:seekWidgetByName(self.groupScorllView, "groupbtn_touchlayer_" .. iter_32_0).group = var_32_3

		if var_32_1 == var_32_3 then
			var_32_4:loadTextures("SupermarketLayer/" .. iter_32_1.id .. "_on.png", nil, "SupermarketLayer/" .. iter_32_1.id .. "_on.png", var_0_16)
		else
			var_32_4:loadTextures("SupermarketLayer/" .. iter_32_1.id .. "_off.png", nil, "SupermarketLayer/" .. iter_32_1.id .. "_off.png", var_0_16)
		end

		var_32_2 = var_32_2 + var_32_4:getContentSize().width

		local var_32_6 = supermarket_manager:is_show_reddot_by_group(var_32_3)

		if var_32_6 then
			local var_32_7 = ccui.Helper:seekWidgetByName(self.groupScorllView, "imgReddot_" .. iter_32_0)

			if not var_32_7 then
				var_32_7 = ccui.ImageView:create("GUI/image.png", var_0_16)

				var_32_7:setPositionX(var_32_4:getPositionX() + var_32_4:getContentSize().width / 2 - 15)
				var_32_7:setPositionY(var_32_4:getPositionY() + var_32_4:getContentSize().height / 2 - 50)
				var_32_7:setName("imgReddot_" .. iter_32_0)
				self.groupScorllView:addChild(var_32_7, 2)
			end

			var_32_7:setVisible(true)
			var_32_7:loadTexture(var_0_17[var_32_6], var_0_16)
		end
	end

	self.groupScorllView:setInnerContainerSize(cc.size(var_32_2, 90))
end

function SupermarketLayer:updateTabBtn(...)
	while ccui.Helper:seekWidgetByName(self.tabScorllView, "tabbtn_" .. 1) do
		ccui.Helper:seekWidgetByName(self.tabScorllView, "tabbtn_" .. 1):setVisible(false)

		if ccui.Helper:seekWidgetByName(self.tabScorllView, "imgReddot_" .. 1) then
			ccui.Helper:seekWidgetByName(self.tabScorllView, "imgReddot_" .. 1):setVisible(false)
		end
	end

	local var_33_1 = supermarket_manager:getCurSelectTab()
	local var_33_2 = 0

	for iter_33_0, iter_33_1 in pairs((supermarket_manager:getCurTabList())) do
		local var_33_3 = iter_33_1.id
		local var_33_4 = ccui.Helper:seekWidgetByName(self.tabScorllView, "tabbtn_" .. iter_33_0)

		if not var_33_4 then
			var_33_4 = ccui.Button:create("mainScenebg/supermarket_tab/" .. iter_33_1.id .. "_off.png", nil, "mainScenebg/supermarket_tab/" .. iter_33_1.id .. "_off.png")

			var_33_4:setName("tabbtn_" .. iter_33_0)
			var_33_4:setPosition(cc.p(67 + (iter_33_0 - 1) * 134, 23))
			var_33_4:addTouchEventListener(self:getTabBtnHandel())
			self.tabScorllView:addChild(var_33_4)
		end

		var_33_4:setVisible(true)

		var_33_4.tab = var_33_3

		if var_33_1 == var_33_3 then
			var_33_4:loadTextures("mainScenebg/supermarket_tab/" .. iter_33_1.id .. "_on.png", nil, "mainScenebg/supermarket_tab/" .. iter_33_1.id .. "_on.png")
		else
			var_33_4:loadTextures("mainScenebg/supermarket_tab/" .. iter_33_1.id .. "_off.png", nil, "mainScenebg/supermarket_tab/" .. iter_33_1.id .. "_off.png")
		end

		var_33_2 = var_33_2 + var_33_4:getContentSize().width

		local var_33_5 = supermarket_manager:is_show_reddot_by_tab(var_33_3)

		if var_33_5 then
			local var_33_6 = ccui.Helper:seekWidgetByName(self.tabScorllView, "imgReddot_" .. iter_33_0)

			if not var_33_6 then
				var_33_6 = ccui.ImageView:create("GUI/image.png", var_0_16)

				var_33_6:setPositionX(var_33_4:getPositionX() + var_33_4:getContentSize().width / 2 - 5)
				var_33_6:setPositionY(var_33_4:getPositionY() + var_33_4:getContentSize().height / 2 - 5)
				var_33_6:setName("imgReddot_" .. iter_33_0)
				self.tabScorllView:addChild(var_33_6, 2)
			end

			var_33_6:setVisible(true)
			var_33_6:loadTexture(var_0_17[var_33_5], var_0_16)
		end
	end

	self.tabScorllView:setInnerContainerSize(cc.size(var_33_2, 46))
end

function SupermarketLayer.createMainViewSprite(arg_34_0, arg_34_1)
	local var_34_0 = supermarket_manager:getCurMainViewSpriteParam()

	print(arg_34_1, "aaaaaaaaaaaaaaaaaaaaaa")

	return (({
		[var_0_5] = function(arg_35_0)
			require("view.Layer.SupermarketLayer.SupermarketRechargeSprite")
			texture_manager:loadPopLayerTextures({
				"recharge"
			})

			return SupermarketRechargeSprite:create({
				initSelectPage = var_34_0.selectType
			})
		end,
		[var_0_6] = function(arg_36_0)
			require("view.Layer.SupermarketLayer.SupermarketMarketSprite")

			return SupermarketMarketSprite:create(arg_36_0)
		end,
		[var_0_7] = function(...)
			require("view.Layer.SupermarketLayer.SupermarketRouletteSprite")

			return SupermarketRouletteSprite:create(...)
		end,
		[var_0_8] = function(arg_38_0)
			require("view.Layer.SupermarketLayer.SupermarketTotalRechargeSprite")

			return SupermarketTotalRechargeSprite:create(arg_38_0)
		end,
		[var_0_9] = function(arg_39_0)
			require("view.Layer.SupermarketLayer.SupermarketShopTimeLimitSprite")

			return SupermarketShopTimeLimitSprite:create(arg_39_0)
		end,
		[var_0_11] = function(arg_40_0)
			return require("view.Layer.SupermarketLayer.SupermarketLimitedTimePackageLayer"):create(arg_40_0)
		end,
		[var_0_10] = function(arg_41_0)
			texture_manager:loadPopLayerTextures({
				"SupermarketPrivilegeLayer"
			})

			return require("view.Layer.SupermarketLayer.SupermarketPrivilegeLayer"):create(arg_41_0)
		end,
		[var_0_12] = function(arg_42_0)
			texture_manager:loadPopLayerTextures({
				"SupermarketPrivilegeRechargeLayer"
			})

			return require("view.Layer.SupermarketLayer.SupermarketPrivilegeRechargeLayer"):create(arg_42_0)
		end,
		[var_0_13] = function(arg_43_0)
			require("view.Layer.SupermarketLayer.SupermarketRecommendPageView")

			return (SupermarketRecommendPageView:create(arg_43_0, arg_34_0.recommendJumpTo))
		end,
		[var_0_14] = function(arg_44_0)
			require("view.Layer.SupermarketLayer.SupermarketPerManentLayer")
			texture_manager:loadPopLayerTextures({
				"SupermarketPerManentLayer"
			})

			return (SupermarketPerManentLayer:create(arg_44_0))
		end
	})[arg_34_1](var_34_0))
end

function SupermarketLayer:initEventListener()
	local var_45_0 = self:getEventDispatcher()

	var_45_0:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("on_gain_item", function(arg_46_0)
		self:updateTitle()
	end), self)
	var_45_0:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("marketRecommendJumpTo", function(arg_47_0)
		self:recommendJumpTo(arg_47_0.tab)
	end), self)
	var_45_0:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("popSupermarketLayerReturn", function(arg_48_0)
		self:PopSupermarketLayerReturn()
	end), self)
end

function SupermarketLayer.pushAnalytic(arg_49_0, ...)
	local var_49_0 = supermarket_manager:getCurSelectTab()

	if var_49_0 == 9999 then
		AnalyticManager.clickSupermarketLayer({
			tab = 9999,
			type = var_0_13
		})

		return
	end

	local var_49_1 = supermarket_tab_data[var_49_0].type
	local var_49_2 = supermarket_tab_data[var_49_0].param or supermarket_tab_data[var_49_0].param_str

	AnalyticManager.clickSupermarketLayer({
		tab = var_49_0,
		type = var_49_1,
		param = var_49_2
	})
end

function SupermarketLayer:recommendJumpTo(arg_50_1)
	local var_50_0 = supermarket_manager:getGroupByTab(arg_50_1)

	if not var_50_0 then
		return
	end

	if supermarket_manager:getCurSelectGroup() ~= var_50_0 then
		supermarket_manager:setCurSelectGroup(var_50_0)
		supermarket_manager:setCurSelectTab()
		supermarket_manager:setReddotTouchStat()
		self:updateUI()
	end

	if supermarket_manager:getCurSelectTab() ~= arg_50_1 then
		supermarket_manager:setCurSelectTab(arg_50_1)
		supermarket_manager:setReddotTouchStat()
		self:updateUI()

		return
	end
end

function SupermarketLayer.PopSupermarketLayerReturn(arg_51_0)
	supermarket_manager:initData(nil, {
		registerUIRefCallback = function()
			supermarket_manager:registerUIRef(arg_51_0)
		end
	})
end

PopSupermarketLayer = class("PopSupermarketLayer", function(arg_53_0)
	return SupermarketLayer:create(arg_53_0)
end)

function PopSupermarketLayer.create(arg_54_0, arg_54_1)
	if arg_54_1 then
		if arg_54_1.initSelectPage == 2 then
			arg_54_1.group = 1
			arg_54_1.tab = 1
		elseif arg_54_1.initSelectPage == 15 then
			arg_54_1.group = 1
			arg_54_1.tab = 2
		elseif arg_54_1.jumpToGiftTicket then
			arg_54_1.group = 1
			arg_54_1.tab = 2
		end
	end

	return (PopSupermarketLayer.new(arg_54_1))
end

return SupermarketLayer
