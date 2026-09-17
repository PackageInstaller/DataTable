SupermarketPerManentLayer = class("SupermarketPerManentLayer", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local network = require("network.network")
local recharge_manager = require("controller.recharge_manager")
local alert_manager = require("controller.alert_manager")
local item_manager = require("controller.item_manager")
local shop_manager = require("controller.shop_manager")
local time_check_manager = require("controller.time_check_manager")
local drop_manager = require("controller.drop_manager")
local supermarket_manager = require("controller.supermarket_manager")
local item_data = require("data.item_data")
local recharge_data = require("data.recharge_data")
local shop_data = require("data.shop_data")
local var_0_12 = config._DEBUG and 0 or 1

local function var_0_13(arg_2_0, arg_2_1)
	network:rpc("check_recharge", {
		id = arg_2_0,
		client = config.clientmode
	}, function(arg_3_0)
		if arg_2_1 then
			arg_2_1(arg_3_0)
		end
	end)
end

local function var_0_17(arg_10_0, arg_10_1)
	network:rpc("get_free_award", {
		id = arg_10_0
	}, function(arg_11_0)
		if arg_11_0.result == 1 then
			global_gain({
				items = arg_11_0.items,
				diamond = arg_11_0.diamond,
				gold = arg_11_0.gold,
				sp = arg_11_0.sp
			})
		elseif arg_11_0.result == 2 then
			print(L_LAB_RECIPE_WARNING[3])
		elseif arg_11_0.result == 3 then
			print(L_SUPERMARKET_TIME_LIMIT_3)
		elseif arg_11_0.result == 4 then
			print(L_RECHARGE_BUY_LIMIT)
		elseif arg_11_0.result == 5 then
			print(L_SUPERMARKET_TIME_LIMIT_2)
		end

		if arg_10_1 then
			arg_10_1(arg_11_0)
		end
	end)
end

function SupermarketPerManentLayer.recharge_from_card(arg_12_0, arg_12_1, arg_12_2)
	network:rpc("recharge_from_card", {
		id = arg_12_1
	}, function(arg_13_0)
		if arg_13_0.result == 1 then
			for iter_13_0, iter_13_1 in pairs(arg_13_0.cost_items) do
				item_manager:deleteItem(iter_13_1.entityid, iter_13_1.num)
			end

			global_gain({
				items = arg_13_0.items,
				diamond = arg_13_0.diamond,
				gold = arg_13_0.gold,
				sp = arg_13_0.sp
			})
		elseif arg_13_0.result == 2 then
			print("recharge is not price_card")
		elseif arg_13_0.result == 3 then
			global_ShowBlockWords(L_RECHARGE_GRADE_LIMIT)
		elseif arg_13_0.result == 4 then
			print(L_SUPERMARKET_TIME_LIMIT)
		elseif arg_13_0.result == 5 then
			print(L_RECHARGE_BUY_LIMIT)
		elseif arg_13_0.result == 6 then
			global_ShowBlockWords(L_BUY_BATTLEPASS_VIP[5])

			arg_12_0.curSelectType = 15

			LayerManager:removePopLayer()
			arg_12_0:updateUI()
		end

		if arg_12_2 then
			arg_12_2(arg_13_0)
		end
	end)
end

function SupermarketPerManentLayer.create(arg_14_0, arg_14_1)
	local var_14_0 = SupermarketPerManentLayer.new()

	var_14_0:init(arg_14_1)

	return var_14_0
end

function SupermarketPerManentLayer:init(arg_15_1)
	self:setTouchEnabled(true)

	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)

	self.recharging = false

	self:initPurchaseEventListener()
	self:registerScriptHandler(function(arg_16_0)
		if arg_16_0 == "exit" then
			-- block empty
		end
	end)
	self:initUI()
	self:initData(function()
		if tolua.isnull(self) then
			return
		end

		self.rechargeView:reloadData()
	end)
end

function SupermarketPerManentLayer:initPurchaseEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("APPENTERFOREGROUND", function(arg_19_0)
		self.recharging = false
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_20_0)
		if not arg_20_0 or not arg_20_0.id then
			return
		end

		for iter_20_0, iter_20_1 in pairs(self.rechargeList) do
			if self.rechargeList[iter_20_0].id == arg_20_0.id then
				self.rechargeList[iter_20_0].have_bought = self.rechargeList[iter_20_0].have_bought + 1
			end
		end

		self.lastrechargeid = nil

		self:updateShowingCells(self.rechargeView, #self.rechargeList)
	end), self)
end

function SupermarketPerManentLayer:sortRechargeList()
	for iter_21_0, iter_21_1 in pairs(self.rechargeList) do
		table.sort(iter_21_1, function(arg_22_0, arg_22_1)
			local var_22_0 = arg_22_0.type == 21 and 1 or 0
			local var_22_1 = arg_22_1.type == 21 and 1 or 0

			if (arg_22_0.type == 21 and 1 or 0) == (arg_22_1.type == 21 and 1 or 0) then
				return arg_22_0.order < arg_22_1.order
			else
				return var_22_1 < var_22_0
			end
		end)
	end
end

function SupermarketPerManentLayer.initData(arg_23_0, arg_23_1)
	arg_23_0.rechargeList = {}

	network:rpc("get_recharge_info", {
		client = config.clientmode,
		types = {
			11,
			4
		}
	}, function(arg_24_0)
		if arg_24_0.result == 1 then
			for iter_24_0, iter_24_1 in ipairs(arg_24_0.products) do
				if iter_24_1.shop_type == 120 then
					table.insert(arg_23_0.rechargeList, iter_24_1)
				end
			end

			if arg_23_1 then
				arg_23_1()
			end
		else
			KeyCodeManager:onKeyReleasedCallFunc()
		end
	end)
end

function SupermarketPerManentLayer:initUI()
	self.topImg = ccui.ImageView:create("SupermarketPerManentLayer/banner.png", var_0_12)

	self.topImg:setPosition(cc.p(320, 850 + GameDisplay.fix_y * 2))
	self.rootLayer:addChild(self.topImg)

	self.rechargeView = cc.TableView:create(cc.size(640, 720 + GameDisplay.fix_y))

	self.rechargeView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rechargeView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rechargeView:setAnchorPoint(cc.p(0, 0))
	self.rechargeView:setPosition(0, 30)
	self.rechargeView:setDelegate()
	self.rootLayer:addChild(self.rechargeView)
	self.rechargeView:registerScriptHandler(function(arg_27_0, arg_27_1)
		return 640, 260
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.rechargeView:registerScriptHandler(function(arg_26_0, arg_26_1)
		local var_26_0 = arg_26_0:dequeueCell()

		if not var_26_0 then
			var_26_0 = cc.TableViewCell:create()

			local var_26_1 = self:createSp()

			var_26_1:setName("sp")
			var_26_0:addChild(var_26_1)
		end

		var_26_0:getChildByName("sp").update(arg_26_1)

		return var_26_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.rechargeView:registerScriptHandler(function(arg_28_0, arg_28_1)
		local var_28_0 = math.floor(#self.rechargeList / 3)

		if #self.rechargeList % 3 == 0 then
			return var_28_0
		else
			return var_28_0 + 1
		end
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
end

function SupermarketPerManentLayer.createSp(arg_29_0)
	local var_29_0 = ccui.Layout:create()

	var_29_0:setContentSize(cc.size(640, 260))
	var_29_0:setPosition(cc.p(0, 130))

	for iter_29_0 = 1, 3 do
		local var_29_1 = ccui.ImageView:create("SupermarketPerManentLayer/561.png", var_0_12)

		var_29_1:setName("bg" .. iter_29_0)
		var_29_1:setPosition(cc.p(200 * iter_29_0 - 80, 0))
		var_29_0:addChild(var_29_1)

		local var_29_2 = ccui.Button:create("SupermarketPerManentLayer/btn_buy_on.png", nil, "SupermarketPerManentLayer/btn_buy_on.png", var_0_12)

		var_29_2:setPosition(cc.p(93, 30))
		var_29_2:setName("btn")
		var_29_1:addChild(var_29_2)

		local var_29_3 = cc.Label:createWithTTF("", FONT_NAME, 21)

		var_29_3:setColor(cc.c3b(64, 44, 20))
		var_29_3:setName("lblBuy")
		var_29_3:setPosition(cc.p(var_29_2:getContentSize().width / 2, var_29_2:getContentSize().height / 2 + 2))
		var_29_2:addChild(var_29_3)

		local var_29_4 = cc.Label:createWithTTF("", FONT_NAME, 14)

		var_29_4:setName("lblLimit")
		var_29_4:setColor(cc.c3b(167, 163, 213))
		var_29_4:setPosition(cc.p(94, 69))
		var_29_1:addChild(var_29_4)
	end

	function var_29_0.update(arg_30_0)
		for iter_30_0 = 1, 3 do
			local var_30_0 = arg_29_0.rechargeList[arg_30_0 * 3 + iter_30_0]
			local var_30_1 = var_29_0:getChildByName("bg" .. iter_30_0)

			if arg_29_0.rechargeList[arg_30_0 * 3 + iter_30_0] then
				var_30_1:setVisible(true)

				local var_30_2 = var_30_1:getChildByName("btn")
				local var_30_3 = var_30_2:getChildByName("lblBuy")
				local var_30_4 = var_30_1:getChildByName("lblLimit")

				if var_30_0.rmb == 0 then
					var_30_3:setString(L_FREE_FOR_CHARGE)
				else
					var_30_3:setString(recharge_manager:getCommodityPriceStr(var_30_0.id))
				end

				var_30_1:loadTexture("SupermarketPerManentLayer/" .. var_30_0.id .. ".png", var_0_12)
				var_30_4:setString(string.format(L_RECHARGE_PERMANENT_LIM[var_30_0.refreshtype], var_30_0.have_bought, var_30_0.buy_limit))

				if var_30_0.buy_limit > var_30_0.have_bought then
					var_30_3:setColor(cc.c3b(64, 44, 20))
					var_30_2:loadTextures("SupermarketPerManentLayer/btn_buy_on.png", nil, "SupermarketPerManentLayer/btn_buy_on.png", var_0_12)
				else
					var_30_3:setString(L_BOUGHT)
					var_30_3:setColor(cc.c3b(53, 53, 53))
					var_30_2:loadTextures("SupermarketPerManentLayer/btn_buy_off.png", nil, "SupermarketPerManentLayer/btn_buy_off.png", var_0_12)
				end

				var_30_2:addTouchEventListener(function(arg_31_0, arg_31_1)
					if math.abs(arg_31_0:getTouchBeganPosition().y - arg_31_0:getTouchEndPosition().y) > 50 then
						return
					end

					if arg_31_1 ~= ccui.TouchEventType.ended then
						return
					end

					if var_30_0.buy_limit <= var_30_0.have_bought then
						return
					end

					arg_29_0:buyRecharge(var_30_0)
				end)
			else
				var_30_1:setVisible(false)
			end
		end
	end

	return var_29_0
end

function SupermarketPerManentLayer.updateShowingCells(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0, var_32_1 = GetTableViewShowCellIdx(arg_32_1, {
		maxcount = math.ceil(arg_32_2),
		cellsize = cc.size(640, 260)
	})

	for iter_32_0 = var_32_0, var_32_1 do
		arg_32_1:updateCellAtIndex(iter_32_0)
	end
end

function SupermarketPerManentLayer:buyRecharge(arg_33_1, arg_33_2)
	if self.recharging then
		return
	end

	local var_33_0 = arg_33_1.id

	self.recharging = true

	var_0_13(var_33_0, function(arg_34_0)
		if arg_34_0.result == 1 then
			if arg_33_1.rmb == 0 then
				var_0_17(var_33_0, function(arg_35_0)
					if arg_35_0.result == 1 then
						for iter_35_0, iter_35_1 in pairs(self.rechargeList) do
							if iter_35_1.id == var_33_0 then
								iter_35_1.have_bought = iter_35_1.have_bought + 1
							end
						end
					end

					self:updateShowingCells(self.rechargeView, #self.rechargeList)

					if arg_33_2 then
						arg_33_2(arg_35_0)
					end

					self.recharging = false
				end)
			else
				self.recharging = false
				self.lastrechargeid = var_33_0

				AnalyticManager.clickPurchaseItem({
					product = var_33_0,
					rolenum = playermodel:getOwnedServantNum(),
					grade = playermodel.grade,
					class = playermodel.class
				})
				recharge_manager:confirmPayment(var_33_0)

				if arg_33_2 then
					arg_33_2(arg_34_0)
				end
			end
		elseif arg_34_0.result == 2 then
			print("测试模式")
		elseif arg_34_0.result == 3 then
			global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
		elseif arg_34_0.result == 4 then
			global_ShowBlockWords(L_RECHARGE_OUT_TIME)
		elseif arg_34_0.result == 5 then
			global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
		elseif arg_34_0.result == 6 then
			global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
		elseif arg_34_0.result == 10 then
			self.recharging = false

			global_ShowBlockWords(L_RECHARGE_GRADE_LIMIT)
		end

		if arg_34_0.products then
			for iter_34_0, iter_34_1 in ipairs(arg_34_0.products) do
				if iter_34_1.shop_type == 120 then
					table.insert(self.rechargeList, iter_34_1)
				end
			end

			self:updateShowingCells(self.rechargeView, #self.rechargeList)
		end
	end)
end

function SupermarketPerManentLayer:updateBySupermarketLayer()
	self:updateShowingCells(self.rechargeView, #self.rechargeList)
end

return SupermarketPerManentLayer
