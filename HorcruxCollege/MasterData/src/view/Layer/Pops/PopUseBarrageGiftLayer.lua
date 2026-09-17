PopUseBarrageGiftLayer = class("PopUseBarrageGiftLayer", function()
	return PopBaseLayer:create()
end)

require("view.Layer.PopLayer")

local audio_manager = require("controller.audio_manager")
local var_0_1 = config._DEBUG and 0 or 1
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local shop_manager = require("controller.shop_manager")
local barrage_manager = require("controller.barrage_manager")
local var_0_7 = 1
local var_0_8 = 2
local var_0_9 = 6800401
local var_0_10 = 6800601
local var_0_11 = 9000004
local var_0_12 = 9000005
local var_0_13 = 28
local var_0_14 = {
	[6800202] = "public/currency/6800202.png",
	[SHOP_CURRENCY_GOLD] = "public/currency/UI_battleEnd_gold.png",
	[SHOP_CURRENCY_DIAMOND] = "public/currency/UI_battleEnd_diamond.png",
	[SHOP_CURRENCY_HORNOR] = "public/currency/arenascene_dot_1.png",
	[SHOP_CURRENCY_EXPLORECOIN] = "public/currency/explorecoin.png",
	[SHOP_CURRENCY_RMB] = "public/currency/rmb_white.png",
	[BLACK_CARD] = "public/currency/1500001_1.png",
	[BLACK_SP_CARD] = "public/currency/1500002_1.png"
}

setmetatable(var_0_14, {
	__index = function(arg_2_0, arg_2_1)
		return "public/currency/" .. item_data[arg_2_1].image_id .. ".png"
	end
})

local var_0_15 = {
	[SHOP_CURRENCY_GOLD] = function()
		return playermodel.gold
	end,
	[SHOP_CURRENCY_DIAMOND] = function()
		return playermodel.diamond
	end,
	[SHOP_CURRENCY_HORNOR] = function()
		return playermodel.honor
	end,
	[SHOP_CURRENCY_EXPLORECOIN] = function()
		return playermodel.explorecoin
	end,
	[SHOP_CURRENCY_RMB] = function()
		return 0
	end
}

setmetatable(var_0_15, {
	__index = function(arg_8_0, arg_8_1)
		return function()
			return item_manager:getItemNumber(arg_8_1)
		end
	end
})

function PopUseBarrageGiftLayer.create(arg_10_0, arg_10_1)
	local var_10_0 = PopUseBarrageGiftLayer.new()

	var_10_0:init(arg_10_1)

	return var_10_0
end

function PopUseBarrageGiftLayer:init(arg_11_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopUseBarrageGiftLayer.json" or "PopUseBarrageGiftLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setTouchEnabled(arg_11_1.type == "birthdayparty")
	self:addChild(self.rootLayer, 2)

	self.callback = arg_11_1.callback
	self.key = arg_11_1.key
	self.msg = arg_11_1

	self.rootLayer:setScaleY(0)
	self.rootLayer:runAction(cc.ScaleTo:create(0.05, 1, 1))
	self:initGain()
	self:initUI()
	self:initData()
	self:createTableview()
	self:updateData(function(...)
		self.listPanel:reloadData()
		self:updateUI()
	end)
	self:registerScriptHandler(function(arg_13_0)
		if arg_13_0 == "exit" and self.callback then
			self.callback()
		end
	end)
end

function PopUseBarrageGiftLayer.initData(arg_14_0)
	arg_14_0.curSelectType = var_0_7
	arg_14_0.showItems = {}
	arg_14_0.bagBarrageGift = {}
	arg_14_0.shopBarrageGift = {}
	arg_14_0.selectnum = 1
	arg_14_0.touchlimit = false
end

function PopUseBarrageGiftLayer:initUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_item"):addTouchEventListener(self:getTouchItemBtnHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_bag"):addTouchEventListener(self:getTouchBagBtnHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_use"):addTouchEventListener(self:getTouchUseBtnHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sub"):addTouchEventListener(self:getTouchSubBtnHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_add"):addTouchEventListener(self:getTouchAddBtnHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return"):addTouchEventListener(self:getTouchReturnBtnHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return"):setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_costicon1"):loadTexture(var_0_14[var_0_9], var_0_1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_costicon2"):loadTexture(var_0_14[var_0_10], var_0_1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_costicon3"):loadTexture(var_0_14[var_0_11], var_0_1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_costicon4"):loadTexture(var_0_14[var_0_12], var_0_1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_costicon1"):setScale(0.8)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_costicon2"):setScale(1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_costicon3"):setScale(0.8)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_costicon4"):setScale(0.8)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cost1").itemid = var_0_9
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cost2").itemid = var_0_10
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cost3").itemid = var_0_11
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cost4").itemid = var_0_12

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cost1"):addTouchEventListener(self:getItemTouchHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cost2"):addTouchEventListener(self:getItemTouchHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cost3"):addTouchEventListener(self:getItemTouchHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cost4"):addTouchEventListener(self:getItemTouchHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return"):setSwallowTouches(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_fireworksTips"):setString(L_FIREWORKS_TIPS)
end

function PopUseBarrageGiftLayer.getItemTouchHandel(arg_16_0)
	return function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_17_0.itemid == var_0_11 or arg_17_0.itemid == var_0_12 then
			local var_17_0 = cc.EventCustom:new("switchShowLayer")

			var_17_0.layerName = "MarketLayer"
			var_17_0.initparam = {
				returnLayer = "FightLayer",
				singleMarket = {}
			}

			local var_17_1 = os.date("*t").month

			var_17_0.initparam.showType = "1-35"

			table.insert(var_17_0.initparam.singleMarket, "1-35")
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_17_0)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = arg_17_0.itemid
			})
		end
	end
end

local var_0_16 = 640
local var_0_17 = 240
local var_0_18 = 0
local var_0_19 = 0
local var_0_20 = 210
local var_0_21 = 220
local var_0_22 = cc.p(210 / 2, 220 / 2)

function PopUseBarrageGiftLayer:createTableview()
	self.clonesp = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_clonesp")

	self.clonesp:setVisible(false)

	self.listPanel = cc.TableView:create(cc.size(var_0_16, var_0_17))

	self.listPanel:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	self.listPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.listPanel:setPosition(cc.p(var_0_18, var_0_19))
	self.listPanel:setDelegate()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_tableview"):addChild(self.listPanel)
	self.listPanel:registerScriptHandler(function(arg_19_0, arg_19_1)
		return var_0_20, var_0_21
	end, cc.TABLECELL_SIZE_FOR_INDEX)

	local function var_18_0()
		local var_20_0 = self.clonesp:clone()
		local var_20_1 = cc.Label:createWithTTF("", FONT_NAME, 18)

		var_20_1:setPositionX(var_20_0:getContentSize().width)
		var_20_1:setPositionY(var_20_0:getContentSize().height)
		var_20_1:setAnchorPoint(cc.p(1, 1))
		var_20_1:setName("limitLabel")
		var_20_0:addChild(var_20_1)
		var_20_0:setVisible(true)
		var_20_0:setSwallowTouches(false)

		local var_20_3
		local var_20_4
		local var_20_5 = 0
		local var_20_6

		var_20_0:addTouchEventListener(function(arg_21_0, arg_21_1)
			var_20_6 = arg_21_0:getTouchMovePosition()
			var_20_3 = arg_21_0:getTouchBeganPosition()
			var_20_4 = arg_21_0:getTouchEndPosition()

			if arg_21_1 == ccui.TouchEventType.began then
				arg_21_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
					if var_20_6.y ~= 0 and math.abs(var_20_3.x - var_20_6.x) > 50 then
						return
					end

					var_20_5 = 0.2

					local var_22_0 = cc.Layer:create()

					PopLayer:Item({
						itemid = arg_21_0.itemid
					})
				end)))
			elseif arg_21_1 == ccui.TouchEventType.canceled then
				arg_21_0:stopAllActions()

				var_20_5 = 0
			elseif arg_21_1 == ccui.TouchEventType.ended then
				arg_21_0:stopAllActions()

				if var_20_5 == 0 then
					self.curSelectItem = arg_21_0.itemid
					self.curShopid = arg_21_0.shopid

					self:updateUI()
				end

				var_20_5 = 0
			end
		end)

		function var_20_0:update(arg_23_1)
			self.index = arg_23_1
			self.itemid = self.showItems[self.index].itemid
			self.shopid = self.showItems[self.index].shopid

			ccui.Helper:seekWidgetByName(self, "Image_icon"):loadTexture("equipment/" .. item_data[self.showItems[self.index].itemid].image_id .. ".png")
			ccui.Helper:seekWidgetByName(self, "Image_costicon"):setScale(0.6)
			ccui.Helper:seekWidgetByName(self, "Label_cost"):setPositionX(100)
			ccui.Helper:seekWidgetByName(self, "Label_name"):setFontName(FONT_NAME)
			ccui.Helper:seekWidgetByName(self, "Label_name"):setString(item_data[self.showItems[self.index].itemid].name)

			if self.curSelectType == var_0_7 then
				ccui.Helper:seekWidgetByName(self, "Image_costicon"):setVisible(true)
				ccui.Helper:seekWidgetByName(self, "Image_costicon"):loadTexture(var_0_14[self.showItems[self.index].currency], var_0_1)
				ccui.Helper:seekWidgetByName(self, "Label_cost"):setString(self.showItems[self.index].cost_num)
			else
				ccui.Helper:seekWidgetByName(self, "Image_costicon"):setVisible(false)
				ccui.Helper:seekWidgetByName(self, "Label_cost"):setString("X" .. item_manager:getItemNumber(self.itemid))
			end

			if self.curSelectType == var_0_7 then
				ccui.Helper:seekWidgetByName(self, "Image_selectframe"):setVisible(self.shopid == self.curShopid)
			else
				ccui.Helper:seekWidgetByName(self, "Image_selectframe"):setVisible(self.itemid == self.curSelectItem)
			end

			local var_23_0 = self:getChildByName("classTypeIcon")

			if var_23_0 == nil then
				var_23_0 = ccui.ImageView:create("PopUseBarrageGiftLayer/tag_bg.png", var_0_1)

				var_23_0:setName("classTypeIcon")
				var_23_0:setPosition(cc.p(38, 170))
				self:addChild(var_23_0)

				local var_23_1 = ccui.Text:create("", FONT_NAME, 20)

				var_23_1:setName("classTypeName")
				var_23_1:setAnchorPoint(cc.p(0, 0))
				var_23_1:setPosition(cc.p(10, 8))
				var_23_0:addChild(var_23_1)
			end

			local var_23_2 = self.showItems[self.index].class_type

			var_23_0:setVisible(self.showItems[self.index].class_type ~= nil)
			var_23_0:getChildByName("classTypeName"):setString(var_23_2)

			if #var_23_2 > 6 then
				var_23_0:getChildByName("classTypeName"):setFontSize(16)
			else
				var_23_0:getChildByName("classTypeName"):setFontSize(20)
			end

			ccui.Helper:seekWidgetByName(self, "Image_selectframe"):stopAllActions()
			ccui.Helper:seekWidgetByName(self, "Image_selectframe"):setScale(0.97)
			ccui.Helper:seekWidgetByName(self, "Image_selectframe"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(1, 1.03, 1.03), cc.ScaleTo:create(1, 0.97, 0.97))))
			ccui.Helper:seekWidgetByName(self, "Image_tag"):setAnchorPoint(cc.p(0, 1))
			ccui.Helper:seekWidgetByName(self, "Image_tag"):setPositionX(0)
			ccui.Helper:seekWidgetByName(self, "Image_tag"):setPositionY(self:getContentSize().height)

			if self.showItems[self.index].tag and self.showItems[self.index].tag == 4 then
				ccui.Helper:seekWidgetByName(self, "Image_tag"):setVisible(true)
			else
				ccui.Helper:seekWidgetByName(self, "Image_tag"):setVisible(false)
			end

			if self.showItems[self.index].buy_limit then
				self:getChildByName("limitLabel"):setVisible(true)
				self:getChildByName("limitLabel"):setString(L_BUY_LIMIT .. "(" .. self.showItems[self.index].have_bought .. "/" .. self.showItems[self.index].buy_limit .. ")")
			else
				self:getChildByName("limitLabel"):setVisible(false)
			end
		end

		return var_20_0
	end

	self.listPanel:registerScriptHandler(function(arg_24_0, arg_24_1)
		local var_24_0 = arg_24_0:dequeueCell()

		if not var_24_0 then
			var_24_0 = cc.TableViewCell:create()

			local var_24_1 = var_18_0()

			var_24_1:setPosition(var_0_22)
			var_24_1:setName("sp")
			var_24_1:update(arg_24_1 + 1)
			var_24_0:addChild(var_24_1)
		else
			var_24_0:getChildByName("sp"):update(arg_24_1 + 1)
		end

		return var_24_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.listPanel:registerScriptHandler(function(arg_25_0, arg_25_1)
		return #self.showItems
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.listPanel:reloadData()
end

function PopUseBarrageGiftLayer:initGain(...)
	self.dumpPopLayerFunc = {
		[SHOP_CURRENCY_GOLD] = function()
			({}).callback = updateCoinLabel

			LayerManager:removePopLayer()
			LayerManager:pushInLayer("PopGoGainLayer", {
				item = "gold",
				callback = updateCoinLabel
			})
		end,
		[SHOP_CURRENCY_DIAMOND] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1,
				callback = updateCoinLabel
			})
		end,
		[SHOP_CURRENCY_HORNOR] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		[SHOP_CURRENCY_EXPLORECOIN] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end,
		[BLACK_CARD] = function()
			LayerManager:pushInLayer("PopGoGainLayer", {
				item = BLACK_CARD
			})
		end,
		[BLACK_SP_CARD] = function()
			LayerManager:pushInLayer("PopGoGainLayer", {
				item = BLACK_SP_CARD
			})
		end,
		[GIFT_TICKET] = function()
			LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
				targetlayer = "PopSupermarketLayer",
				callback = updateCoinLabel
			})
		end
	}

	setmetatable(self.dumpPopLayerFunc, {
		__index = function(arg_34_0, arg_34_1)
			return function(arg_35_0)
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_34_1].name))

				if arg_35_0 then
					LayerManager:pushInLayer("PopGoGainLayer", {
						item = arg_35_0
					})
				end

				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})
end

function PopUseBarrageGiftLayer:updateShowingCells()
	local var_36_0, var_36_1 = GetTableViewShowCellIdx(self.listPanel, {
		maxcount = math.ceil(#self.showItems),
		cellsize = cc.size(var_0_20, var_0_21)
	})

	for iter_36_0 = var_36_0, var_36_1 do
		self.listPanel:updateCellAtIndex(iter_36_0)
	end
end

function PopUseBarrageGiftLayer:updateData(arg_37_1)
	self.showItems = {}

	if self.curSelectType == var_0_7 then
		shop_manager:get_shop_data(var_0_13, function(arg_38_0)
			self.marketlist = arg_38_0

			table.sort(self.marketlist, function(arg_39_0, arg_39_1)
				return arg_39_0.pos > arg_39_1.pos
			end)

			self.shopBarrageGift = {}

			if self.msg and self.msg.type == "birthdayparty" then
				for iter_38_0, iter_38_1 in pairs(arg_38_0) do
					if iter_38_1.itemtype == 101100001 or iter_38_1.itemtype == 101100002 then
						table.insert(self.shopBarrageGift, {
							itemid = iter_38_1.itemtype,
							currency = iter_38_1.currency,
							shopid = iter_38_1.shopid,
							cost_num = iter_38_1.discount,
							tag = iter_38_1.tag,
							have_bought = iter_38_1.have_bought,
							buy_limit = iter_38_1.buy_limit,
							class_type = (item_data[iter_38_1.itemtype] or nil) and (item_data[iter_38_1.itemtype].class_type or "常驻")
						})
					end
				end
			else
				for iter_38_2, iter_38_3 in pairs(arg_38_0) do
					table.insert(self.shopBarrageGift, {
						itemid = iter_38_3.itemtype,
						currency = iter_38_3.currency,
						shopid = iter_38_3.shopid,
						cost_num = iter_38_3.discount,
						tag = iter_38_3.tag,
						have_bought = iter_38_3.have_bought,
						buy_limit = iter_38_3.buy_limit,
						class_type = (item_data[iter_38_3.itemtype] or nil) and (item_data[iter_38_3.itemtype].class_type or "常驻")
					})
				end
			end

			self.showItems = self.shopBarrageGift

			if arg_37_1 then
				arg_37_1()
			end
		end)
	else
		self.bagBarrageGift = {}

		if self.msg and self.msg.type == "birthdayparty" then
			for iter_37_0, iter_37_1 in pairs(playermodel.items) do
				if iter_37_1.itemtype == KITEM_BARRAGE_GIFT and (iter_37_1.itemid == 101100001 or iter_37_1.itemid == 101100002) then
					table.insert(self.bagBarrageGift, {
						itemid = iter_37_1.itemid,
						class_type = (item_data[iter_37_1.itemid] or nil) and (item_data[iter_37_1.itemid].class_type or "常驻")
					})
				end
			end
		else
			for iter_37_2, iter_37_3 in pairs(playermodel.items) do
				if iter_37_3.itemtype == KITEM_BARRAGE_GIFT then
					table.insert(self.bagBarrageGift, {
						itemid = iter_37_3.itemid,
						class_type = (item_data[iter_37_3.itemid] or nil) and (item_data[iter_37_3.itemid].class_type or "常驻")
					})
				end
			end
		end

		self.showItems = self.bagBarrageGift

		if arg_37_1 then
			arg_37_1()
		end
	end
end

function PopUseBarrageGiftLayer:updateUI(...)
	self:updateShowingCells()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_costnum1"):setString(global_trans_number(var_0_15[var_0_9]()))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_costnum2"):setString(var_0_15[var_0_10]())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sub"):setVisible(self.curShopid ~= nil)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_add"):setVisible(self.curShopid ~= nil)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_27"):setVisible(self.curShopid ~= nil)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_selectnum"):setVisible(self.curShopid ~= nil)

	if self.curSelectType == var_0_7 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_item"):loadTextures("PopUseBarrageGiftLayer/item_on.png", nil, "PopUseBarrageGiftLayer/item_on.png", var_0_1)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_bag"):loadTextures("PopUseBarrageGiftLayer/bag_normal.png", nil, "PopUseBarrageGiftLayer/bag_normal.png", var_0_1)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_use"):loadTextures("PopUseBarrageGiftLayer/buy.png", nil, "PopUseBarrageGiftLayer/buy.png", var_0_1)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_item"):loadTextures("PopUseBarrageGiftLayer/item_normal.png", nil, "PopUseBarrageGiftLayer/item_normal.png", var_0_1)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_bag"):loadTextures("PopUseBarrageGiftLayer/bag_on.png", nil, "PopUseBarrageGiftLayer/bag_on.png", var_0_1)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_use"):loadTextures("PopUseBarrageGiftLayer/use.png", nil, "PopUseBarrageGiftLayer/use.png", var_0_1)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_selectnum"):setString(self.selectnum)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_costnum3"):setString(global_trans_number(var_0_15[var_0_11]()))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_costnum4"):setString(global_trans_number(var_0_15[var_0_12]()))
end

function PopUseBarrageGiftLayer.getTouchItemBtnHandel(arg_41_0, ...)
	return function(arg_42_0, arg_42_1)
		if arg_42_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_41_0.curSelectType = var_0_7
		arg_41_0.curSelectItem = nil
		arg_41_0.curShopid = nil
		arg_41_0.selectnum = 1

		arg_41_0:updateData(function(...)
			arg_41_0.listPanel:reloadData()
			arg_41_0:updateUI()
		end)
	end
end

function PopUseBarrageGiftLayer.getTouchBagBtnHandel(arg_44_0, ...)
	return function(arg_45_0, arg_45_1)
		if arg_45_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_44_0.curSelectType = var_0_8
		arg_44_0.curSelectItem = nil
		arg_44_0.curShopid = nil
		arg_44_0.selectnum = 1

		arg_44_0:updateData(function(...)
			arg_44_0.listPanel:reloadData()
			arg_44_0:updateUI()
		end)
	end
end

function PopUseBarrageGiftLayer.getTouchSubBtnHandel(arg_47_0, ...)
	return function(arg_48_0, arg_48_1)
		if arg_48_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_47_0.selectnum = arg_47_0.selectnum - 1
		arg_47_0.selectnum = math.max(1, arg_47_0.selectnum)

		arg_47_0:updateUI()
	end
end

function PopUseBarrageGiftLayer.getTouchUseBtnHandel(arg_49_0, ...)
	return function(arg_50_0, arg_50_1)
		if arg_50_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_49_0.curSelectType == var_0_7 then
			if not arg_49_0.curShopid then
				global_ShowBlockWords(L_NOT_SELECT_BARRAGEGIFT)

				return
			end
		elseif not arg_49_0.curSelectItem then
			global_ShowBlockWords(L_NOT_SELECT_BARRAGEGIFT)

			return
		end

		if arg_49_0.curSelectType == var_0_7 then
			arg_49_0:buyBarrageGift()
		else
			arg_49_0:useBarrageGift()
		end
	end
end

function PopUseBarrageGiftLayer:buyBarrageGift()
	local var_51_0

	for iter_51_0, iter_51_1 in pairs(self.marketlist) do
		if iter_51_1.shopid == self.curShopid then
			var_51_0 = iter_51_0
		end
	end

	if not var_51_0 then
		return
	end

	local var_51_1

	for iter_51_2, iter_51_3 in pairs(self.showItems) do
		if iter_51_3.shopid == self.curShopid then
			var_51_1 = iter_51_2
		end
	end

	if not var_51_1 then
		return
	end

	if self.marketlist[var_51_0].have_bought and self.showItems[var_51_1].buy_limit and self.marketlist[var_51_0].have_bought + self.selectnum > self.showItems[var_51_1].buy_limit then
		global_ShowBlockWords(L_MARKET_MSG.Sold_Out)

		return
	end

	if self.touchlimit then
		return
	end

	self.touchlimit = true

	shop_manager:shop_buy(var_0_13, self.marketlist[var_51_0].shopid, function(arg_52_0)
		self.touchlimit = false

		if arg_52_0 == 1 then
			self.marketlist[var_51_0].have_bought = self.marketlist[var_51_0].have_bought + self.selectnum
			self.showItems[var_51_1].have_bought = self.showItems[var_51_1].have_bought + self.selectnum

			self:useBarrageGift()
			self:updateUI()
		elseif arg_52_0 == 2 then
			global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_52_0 == 3 then
			self.dumpPopLayerFunc[self.marketlist[var_51_0].currency]()
		elseif arg_52_0 == 4 then
			self.dumpPopLayerFunc[self.marketlist[var_51_0].currency]()
		end
	end, self.selectnum, nil, true)
end

function PopUseBarrageGiftLayer.getResidueTime(arg_53_0, arg_53_1)
	if not arg_53_1 then
		return "-1"
	end

	local var_53_5 = global_get_time_by_date(arg_53_1) - playermodel.onlineTime
	local var_53_6 = math.floor(var_53_5 / 24 / 3600)
	local var_53_7 = math.floor((var_53_5 - var_53_6 * 24 * 3600) / 3600)
	local var_53_8 = math.floor((var_53_5 - var_53_6 * 24 * 3600 - var_53_7 * 3600) / 60)

	return var_53_6 ~= 0 and string.format(L_TIME_TEXT[1], var_53_6, var_53_7) or var_53_7 ~= 0 and string.format(L_TIME_TEXT[2], var_53_7, var_53_8) or string.format(L_TIME_TEXT[3], var_53_8)
end

function PopUseBarrageGiftLayer:useBarrageGift()
	if self.touchlimit then
		return
	end

	self.touchlimit = true

	barrage_manager:send_firework_item(self.curSelectItem, self.selectnum, function(arg_55_0, arg_55_1)
		if arg_55_0.result == 1 then
			if item_data[self.curSelectItem].extra_award then
				self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
					barrage_manager:get_next_salute_award_time()
				end)))
			end

			local var_55_0 = {
				itemid = self.curSelectItem,
				num = self.selectnum,
				playerid = playermodel.playerid,
				head_sculpture = playermodel.head_sculpture,
				name = playermodel.nickname,
				chapter = arg_55_1
			}

			barrage_manager:puahSelfBarrageEffect(var_55_0)
			self:updateUI()
			barrage_manager:playRunHourseEffect(var_55_0.itemid, var_55_0.name, nil, var_55_0.playerid, true)
			barrage_manager:playBatchColorfulBarrage(var_55_0)
		end

		self.touchlimit = false
	end)
end

function PopUseBarrageGiftLayer.getTouchAddBtnHandel(arg_57_0, ...)
	return function(arg_58_0, arg_58_1)
		if arg_58_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_57_0.selectnum = arg_57_0.selectnum + 1
		arg_57_0.selectnum = math.min(arg_57_0.selectnum, 99)

		arg_57_0:updateUI()
	end
end

function PopUseBarrageGiftLayer:exitAni()
	self.rootLayer:runAction(cc.Sequence:create(cc.ScaleTo:create(0.05, 1, 0), cc.CallFunc:create(function(...)
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

local var_0_23 = {
	{
		leftdown = {
			x = 0,
			y = 0.28
		},
		rightup = {
			x = 0.15,
			y = 0.36
		}
	},
	{
		leftdown = {
			x = 0.2,
			y = 0.32
		},
		rightup = {
			x = 0.31,
			y = 0.37
		}
	},
	{
		leftdown = {
			x = 0.86,
			y = 0.31
		},
		rightup = {
			x = 1,
			y = 0.4
		}
	},
	{
		leftdown = {
			x = 0,
			y = 0.9
		},
		rightup = {
			x = 1,
			y = 1
		}
	}
}

function PopUseBarrageGiftLayer.getTouchReturnBtnHandel(arg_61_0)
	return function(arg_62_0, arg_62_1)
		if arg_62_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_62_0 = arg_62_0:getTouchEndPosition()

		for iter_62_0, iter_62_1 in pairs(var_0_23) do
			if var_62_0.x / GameDisplay.width > iter_62_1.leftdown.x and var_62_0.x / GameDisplay.width < iter_62_1.rightup.x and var_62_0.y / GameDisplay.height > iter_62_1.leftdown.y and var_62_0.y / GameDisplay.height < iter_62_1.rightup.y then
				return
			end
		end

		arg_61_0:exitAni()
	end
end

function PopUseBarrageGiftLayer:exit()
	self:exitAni()
end
