SupermarketRechargeSprite = class("SupermarketRechargeSprite", function()
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

require("view.Sprite.BottomBtnList")
require("view.Sprite.RechargeSprite")

local var_0_13 = {
	returnback_card = 20002,
	newbee_card = 20001,
	gold_quarter_card = 30004,
	quartercard = 90,
	month_card = 1,
	yearcard = 365,
	diamond_quarter_card = 109,
	diamond_year_card = 110,
	gold_card = 20003,
	horcrux_card = 20004,
	diamond_month_card = 108,
	forevercard = 9
}
local var_0_14 = config._DEBUG and 0 or 1

local function var_0_15(arg_2_0, arg_2_1)
	network:rpc("check_recharge", {
		id = arg_2_0,
		client = config.clientmode
	}, function(arg_3_0)
		if arg_2_1 then
			arg_2_1(arg_3_0)
		end
	end)
end

local function var_0_16(arg_4_0, arg_4_1)
	network:rpc("get_recharge_items_drop", {
		id = arg_4_0
	}, function(arg_5_0)
		if arg_4_1 then
			arg_4_1(arg_5_0)
		end
	end)
end

local function var_0_17(arg_6_0, arg_6_1)
	network:rpc("recharge_from_diamond", {
		id = arg_6_0
	}, function(arg_7_0)
		if arg_7_0.result == 1 then
			if arg_7_0.cost_items and next(arg_7_0.cost_items) then
				for iter_7_0, iter_7_1 in pairs(arg_7_0.cost_items) do
					item_manager:deleteItem(iter_7_1.entityid, iter_7_1.num)
				end
			end

			if arg_7_0.cost_diamond then
				playermodel.diamond = playermodel.diamond - arg_7_0.cost_diamond
			end

			global_gain({
				items = arg_7_0.items,
				diamond = arg_7_0.diamond,
				gold = arg_7_0.gold,
				sp = arg_7_0.sp
			})
		elseif arg_7_0.result == 2 then
			print("recharge is not price_diamond")
		elseif arg_7_0.result == 3 then
			global_ShowBlockWords(L_RECHARGE_GRADE_LIMIT)
		elseif arg_7_0.result == 4 then
			print(L_SUPERMARKET_TIME_LIMIT)
		elseif arg_7_0.result == 5 then
			print(L_RECHARGE_BUY_LIMIT)
		elseif arg_7_0.result == 6 then
			global_ShowBlockWords(L_DIAMOND_LACK)
		end

		if arg_6_1 then
			arg_6_1(arg_7_0)
		end
	end)
end

local function var_0_18(arg_8_0, arg_8_1)
	network:rpc("get_totalrecharge_award", {
		id = arg_8_0
	}, function(arg_9_0)
		if arg_9_0.result == 1 then
			global_gain({
				items = arg_9_0.items,
				diamond = arg_9_0.diamond,
				gold = arg_9_0.gold,
				sp = arg_9_0.sp
			})
		elseif arg_9_0.result == 2 then
			print(L_LAB_RECIPE_WARNING[3])
		elseif arg_9_0.result == 3 then
			print(L_SUPERMARKET_TIME_LIMIT_3)
		elseif arg_9_0.result == 4 then
			print(L_RECHARGE_BUY_LIMIT)
		elseif arg_9_0.result == 5 then
			print(L_SUPERMARKET_TIME_LIMIT_2)
		end

		if arg_8_1 then
			arg_8_1(arg_9_0)
		end
	end)
end

local function var_0_19(arg_10_0, arg_10_1)
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

function SupermarketRechargeSprite.recharge_from_card(arg_12_0, arg_12_1, arg_12_2)
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
			arg_12_0:filterBtnTouchEvent()
		end

		if arg_12_2 then
			arg_12_2(arg_13_0)
		end
	end)
end

function SupermarketRechargeSprite.get_other_monthcard_reward(arg_14_0, arg_14_1, arg_14_2)
	network:rpc("get_other_monthcard_reward", {
		rechargeid = arg_14_1
	}, function(arg_15_0)
		if arg_15_0.result == 1 then
			global_gain({
				gold = arg_15_0.gold,
				sp = arg_15_0.sp,
				diamond = arg_15_0.diamond,
				items = arg_15_0.items
			})

			for iter_15_0, iter_15_1 in pairs(arg_14_0.rechargeList) do
				for iter_15_2, iter_15_3 in pairs(iter_15_1) do
					if arg_14_0.rechargeList[iter_15_0][iter_15_2].id == arg_14_1 then
						arg_14_0.rechargeList[iter_15_0][iter_15_2].lastreward = true
					end
				end
			end

			supermarket_manager:updateRechargeReddot(arg_14_0.rechargeList)
			arg_14_0:updateUI()
		elseif arg_15_0.result == 2 then
			global_ShowBlockWords(L_RETURNMANAGER[3])
		elseif arg_15_0.result == 3 then
			global_ShowBlockWords(L_RETURNMANAGER[4])
		end

		if arg_14_2 then
			arg_14_2(arg_15_0)
		end
	end)
end

local var_0_20 = {
	[10] = 10
}
local var_0_21 = {
	[9] = 556
}
local var_0_22 = {
	[9] = 680,
	[14] = 940
}

setmetatable(var_0_21, {
	__index = function(arg_16_0, arg_16_1)
		return 556
	end
})
setmetatable(var_0_22, {
	__index = function(arg_17_0, arg_17_1)
		return 940
	end
})

local var_0_23 = 44
local var_0_24 = -110
local var_0_25 = {
	556,
	556,
	556,
	556,
	556,
	556,
	nil,
	nil,
	nil,
	556
}
local var_0_26 = {
	238,
	320,
	340,
	172,
	420,
	220,
	nil,
	nil,
	nil,
	660
}
local var_0_27 = {
	[5] = cc.p(var_0_25[5] / 2, var_0_26[5] / 2 - 17)
}

setmetatable(var_0_27, {
	__index = function(arg_18_0, arg_18_1)
		return cc.p(var_0_25[arg_18_1] / 2, var_0_26[arg_18_1] / 2)
	end
})

local var_0_29 = 8
local var_0_30 = 9
local var_0_31 = 11
local var_0_32 = 12
local var_0_33 = 13
local var_0_34 = 14
local var_0_35 = {
	[12] = true,
	[102] = true
}

function SupermarketRechargeSprite.create(arg_19_0, arg_19_1)
	local var_19_0 = SupermarketRechargeSprite.new()

	var_19_0:init(arg_19_1)

	return var_19_0
end

function SupermarketRechargeSprite:init(arg_20_1)
	self.instance = self

	self:setTouchEnabled(true)

	if arg_20_1 then
		self.returnLayer = arg_20_1.returnLayer or "FightLayer"
		self.jumpToGiftCard = arg_20_1.jumpToGiftCard
		self.jumpToGiftBox = arg_20_1.jumpToGiftBox
		self.initSelectPage = arg_20_1.initSelectPage
	else
		self.returnLayer = "FightLayer"
	end

	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)

	local var_20_0 = ccui.Layout:create()

	var_20_0:setContentSize(cc.size(640, 910))
	var_20_0:setAnchorPoint(cc.p(0, 0))
	var_20_0:setPosition(cc.p(0, 116))
	var_20_0:setName("Panel_tableview")
	self.rootLayer:addChild(var_20_0)

	self.recharging = false

	self:initPurchaseEventListener()
	AnalyticManager.enterPurchaseLayer()
	self:registerScriptHandler(function(arg_21_0)
		if arg_21_0 == "exit" then
			self.instance = nil

			if arg_20_1 and arg_20_1.callback then
				arg_20_1.callback()
			end
		end
	end)
	self:initUI()
	self:initData(function(...)
		self.tableviewobj = {}

		self:createTableView(self.curSelectType)
		supermarket_manager:updateRechargeReddot(self.rechargeList)
		self:updateUI()
	end)
	self:test()
end

function SupermarketRechargeSprite:updateLevelPackageArr()
	for iter_23_0, iter_23_1 in pairs(self.rechargeList) do
		while iter_23_1[1] do
			local var_23_0

			if iter_23_1[1].type == var_0_29 then
				table.remove(iter_23_1, 1)
			else
				var_23_0 = 1 + 1
			end
		end
	end

	local var_23_1 = {}

	table.sort(self.levelpackage, function(arg_24_0, arg_24_1)
		return arg_24_0.buy_grade_limit < arg_24_1.buy_grade_limit
	end)

	local function var_23_2(arg_25_0)
		for iter_25_0, iter_25_1 in pairs(self.levelpackage) do
			if iter_25_1.id == arg_25_0 and iter_25_1.have_bought > 0 then
				return true
			end
		end

		return false
	end

	for iter_23_2, iter_23_3 in pairs(self.levelpackage) do
		if iter_23_3.have_bought < iter_23_3.buy_limit then
			if not iter_23_3.pre_rechargeid then
				table.insert(var_23_1, iter_23_3)
			elseif var_23_2(iter_23_3.pre_rechargeid) then
				table.insert(var_23_1, iter_23_3)
			end
		end
	end

	for iter_23_4, iter_23_5 in pairs(var_23_1) do
		table.insert(self.rechargeList[iter_23_5.shop_type], iter_23_5)
	end

	self:sortRechargeList()
end

function SupermarketRechargeSprite:sortRechargeList(...)
	for iter_26_0, iter_26_1 in pairs(self.rechargeList) do
		table.sort(iter_26_1, function(arg_27_0, arg_27_1)
			local var_27_0 = arg_27_0.type == 21 and 1 or 0
			local var_27_1 = arg_27_1.type == 21 and 1 or 0

			if (arg_27_0.type == 21 and 1 or 0) == (arg_27_1.type == 21 and 1 or 0) then
				return arg_27_0.order < arg_27_1.order
			else
				return var_27_1 < var_27_0
			end
		end)
	end
end

function SupermarketRechargeSprite:initData(arg_28_1)
	self.curSelectType = 14

	if self.jumpToGiftCard then
		self.curSelectType = 2
	elseif self.jumpToGiftBox then
		self.curSelectType = 1
	end

	if self.initSelectPage then
		self.curSelectType = self.initSelectPage
	end

	self.totalRechargeRank = {}

	for iter_28_0, iter_28_1 in pairs(recharge_data) do
		if iter_28_1.type == var_0_30 then
			table.insert(self.totalRechargeRank, {
				id = iter_28_1.id,
				need_total_recharge = iter_28_1.need_total_recharge
			})
		end
	end

	table.sort(self.totalRechargeRank, function(arg_29_0, arg_29_1)
		return arg_29_0.need_total_recharge < arg_29_1.need_total_recharge
	end)

	local var_28_0 = {}

	for iter_28_2, iter_28_3 in pairs(self.totalRechargeRank) do
		var_28_0[iter_28_3.id] = iter_28_2
	end

	self.rechargeList = {}
	self.levelpackage = {}
	self.lastrechargeid = nil

	recharge_manager:getRechargeInfo(function(arg_30_0, arg_30_1)
		if not self.instance then
			return
		end

		if arg_30_0 == 1 then
			for iter_30_0, iter_30_1 in pairs(arg_30_1) do
				if iter_30_1.type ~= var_0_32 and not var_0_35[iter_30_1.shop_type] then
					self.rechargeList[iter_30_1.shop_type] = self.rechargeList[iter_30_1.shop_type] or {}

					local var_30_0 = iter_30_1.type ~= 21 or iter_30_1.type == 21 and iter_30_1.have_bought < iter_30_1.buy_limit

					if iter_30_1.type == var_0_29 then
						table.insert(self.levelpackage, iter_30_1)
					elseif var_30_0 then
						table.insert(self.rechargeList[iter_30_1.shop_type], iter_30_1)
					end

					if recharge_data[iter_30_1.id].dropid_ext then
						if iter_30_1.buy_limit and iter_30_1.have_bought_ext == iter_30_1.buy_limit and iter_30_1.have_bought == iter_30_1.buy_limit then
							iter_30_1.order = iter_30_1.order + 100
						end
					elseif iter_30_1.buy_limit and iter_30_1.have_bought == iter_30_1.buy_limit and recharge_data[iter_30_1.id].ui_type ~= 2 then
						iter_30_1.order = iter_30_1.order + 100
					end
				end
			end

			self:updateLevelPackageArr()

			if self.rechargeList[var_0_30] then
				for iter_30_2, iter_30_3 in pairs(self.rechargeList[var_0_30]) do
					iter_30_3.no = var_28_0[iter_30_3.id]
				end
			end

			if arg_28_1 then
				arg_28_1()
			end
		else
			KeyCodeManager:onKeyReleasedCallFunc()
		end
	end)
end

function SupermarketRechargeSprite:resetData(arg_31_1)
	self.rechargeList = {}
	self.levelpackage = {}

	for iter_31_0, iter_31_1 in pairs(arg_31_1) do
		if iter_31_1.type ~= var_0_32 and not var_0_35[iter_31_1.shop_type] then
			self.rechargeList[iter_31_1.shop_type] = self.rechargeList[iter_31_1.shop_type] or {}

			if iter_31_1.type ~= var_0_32 then
				local var_31_0 = iter_31_1.type ~= 21 or iter_31_1.type == 21 and iter_31_1.have_bought < iter_31_1.buy_limit

				if iter_31_1.type == var_0_29 then
					table.insert(self.levelpackage, iter_31_1)
				elseif var_31_0 then
					table.insert(self.rechargeList[iter_31_1.shop_type], iter_31_1)
				end
			end
		end
	end

	self:updateLevelPackageArr()
end

function SupermarketRechargeSprite:initUI()
	self:initTopImg()
	self:fullScreen()
end

function SupermarketRechargeSprite:initTopImg()
	self.topImg = ccui.ImageView:create("recharge/top.png", var_0_14)

	self.topImg:setPosition(cc.p(320, 800 + GameDisplay.fix_y * 2))
	self.topImg:setVisible(false)
	self.rootLayer:addChild(self.topImg)

	self.totalRechargeImg = ccui.ImageView:create("recharge/vip_icon.png", var_0_14)

	self.totalRechargeImg:setPosition(cc.p(100, 180))
	self.topImg:addChild(self.totalRechargeImg)

	self.totalVipLevel = cc.Label:createWithTTF("1", FONT_W5, 36)

	self.totalVipLevel:setAnchorPoint(cc.p(0.5, 0.5))
	self.totalVipLevel:setPosition(cc.p(100, 180))
	self.totalVipLevel:setColor(cc.c3b(255, 251, 142))
	self.topImg:addChild(self.totalVipLevel)

	self.expLabel = cc.Label:createWithTTF("0/0", FONT_W5, 16)

	self.expLabel:setAnchorPoint(cc.p(0, 0.5))
	self.expLabel:setPosition(cc.p(46, 64))
	self.topImg:addChild(self.expLabel)

	self.totalRechargeLabel1 = cc.Label:createWithTTF(L_SUPERMARKET_TIME_LIMIT_4, FONT_W5, 20)

	self.totalRechargeLabel1:setAnchorPoint(cc.p(0, 0.5))
	self.totalRechargeLabel1:setPosition(cc.p(60, 100))
	self.totalRechargeLabel1:setColor(cc.c3b(54, 120, 114))
	self.topImg:addChild(self.totalRechargeLabel1)

	self.totalRechargeLabel2 = cc.Label:createWithTTF("6", FONT_W5, 28)

	self.totalRechargeLabel2:setAnchorPoint(cc.p(0, 0.5))
	self.totalRechargeLabel2:setColor(cc.c3b(25, 58, 55))
	self.totalRechargeLabel2:setPosition(cc.p(80, 102))
	self.topImg:addChild(self.totalRechargeLabel2)

	self.totalRechargeLabel3 = cc.Label:createWithTTF(L_SUPERMARKET_TIME_LIMIT_5, FONT_W5, 20)

	self.totalRechargeLabel3:setAnchorPoint(cc.p(0, 0.5))
	self.totalRechargeLabel3:setPosition(cc.p(80, 100))
	self.totalRechargeLabel3:setColor(cc.c3b(54, 120, 114))
	self.topImg:addChild(self.totalRechargeLabel3)

	self.totalRechargeLabel4 = cc.Label:createWithTTF("SVIP1", FONT_W5, 28)

	self.totalRechargeLabel4:setAnchorPoint(cc.p(0, 0.5))
	self.totalRechargeLabel4:setColor(cc.c3b(25, 58, 55))
	self.totalRechargeLabel4:setPosition(cc.p(80, 102))
	self.topImg:addChild(self.totalRechargeLabel4)

	self.expbg = ccui.ImageView:create("recharge/exp_blue.png", var_0_14)

	self.expbg:setScale9Enabled(true)
	self.expbg:setAnchorPoint(cc.p(0, 0.5))
	self.expbg:setPosition(cc.p(38, 80))
	self.topImg:addChild(self.expbg)

	self.expbar = ccui.ImageView:create("recharge/exp_red.png", var_0_14)

	self.expbar:setScale9Enabled(true)
	self.expbar:setAnchorPoint(cc.p(0, 0.5))
	self.expbar:setPositionX(self.expbg:getPositionX() + 1)
	self.expbar:setPositionY(self.expbg:getPositionY())
	self.topImg:addChild(self.expbar)
end

function SupermarketRechargeSprite:updateTopImg()
	if not self.totalRechargeRank[1] then
		return
	end

	local var_34_0 = 0
	local var_34_1 = self.totalRechargeRank[1].need_total_recharge

	for iter_34_0, iter_34_1 in pairs(self.totalRechargeRank) do
		if playermodel.rechargeamount >= iter_34_1.need_total_recharge then
			var_34_0 = iter_34_0

			local var_34_2 = math.max(0, iter_34_1.need_total_recharge)
		end
	end

	if self.totalRechargeRank[var_34_0 + 1] then
		var_34_1 = recharge_data[self.totalRechargeRank[var_34_0 + 1].id] and recharge_data[self.totalRechargeRank[var_34_0 + 1].id].need_total_recharge
	end

	if self.totalRechargeRank[var_34_0 + 1] then
		self.totalRechargeLabel2:setString(var_34_1 - playermodel.rechargeamount .. L_SUPERMARKET_TIME_LIMIT_6)
		self.totalRechargeLabel4:setString(L_SUPERMARKET_TIME_LIMIT_9)
		self.totalVipLevel:setString(var_34_0)
		self.expLabel:setString(playermodel.rechargeamount .. "/" .. var_34_1)
		self.expbar:setScaleX(playermodel.rechargeamount / var_34_1)
	else
		self.totalVipLevel:setString(var_34_0)
		self.totalRechargeLabel1:setString(L_MAX_LEVLE)
		self.totalRechargeLabel2:setVisible(false)
		self.totalRechargeLabel3:setVisible(false)
		self.totalRechargeLabel4:setVisible(false)
		self.expLabel:setString("")
		self.expbar:setScaleX(1)
	end

	self.topImg:setVisible(self.curSelectType == var_0_30)

	for iter_34_2 = 1, 4 do
		self["totalRechargeLabel" .. iter_34_2]:setPositionX(38)

		local var_34_3 = 38 + self["totalRechargeLabel" .. iter_34_2]:getContentSize().width
	end
end

function SupermarketRechargeSprite:filterBtnTouchEvent()
	if not self.tableviewobj then
		return
	end

	if not self.tableviewobj[self.curSelectType] then
		self:createTableView(self.curSelectType)
	end

	for iter_35_0, iter_35_1 in pairs(self.tableviewobj) do
		if self.curSelectType == iter_35_0 then
			self.tableviewobj[self.curSelectType]:setVisible(true)
		else
			self.tableviewobj[self.curSelectType]:setVisible(false)
		end
	end

	for iter_35_2, iter_35_3 in pairs(self.tableviewobj) do
		iter_35_3:setVisible(iter_35_2 == self.curSelectType)
	end

	self:updateUI()
end

function SupermarketRechargeSprite:updateUI()
	table.sort(self.rechargeList[var_0_30], function(arg_37_0, arg_37_1)
		if arg_37_0.have_bought ~= arg_37_1.have_bought then
			return arg_37_0.have_bought < arg_37_1.have_bought
		else
			return arg_37_0.no < arg_37_1.no
		end
	end)
	self:updateShowingCells()
	self:updateTopImg()
end

function SupermarketRechargeSprite:initPurchaseEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("APPENTERFOREGROUND", function(arg_39_0)
		self.recharging = false
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_40_0)
		if not arg_40_0 or not arg_40_0.id then
			return
		end

		for iter_40_0, iter_40_1 in pairs(self.rechargeList) do
			for iter_40_2, iter_40_3 in pairs(iter_40_1) do
				if self.rechargeList[iter_40_0][iter_40_2].id == arg_40_0.id and self.rechargeList[iter_40_0][iter_40_2].remain then
					self.rechargeList[iter_40_0][iter_40_2].remain = arg_40_0.remain
				end
			end
		end

		for iter_40_4, iter_40_5 in pairs(self.levelpackage) do
			if arg_40_0.id == iter_40_5.id then
				iter_40_5.have_bought = iter_40_5.have_bought + 1
			end
		end

		self:updateLevelPackageArr()

		self.lastrechargeid = nil

		supermarket_manager:updateRechargeReddot(self.rechargeList)
		self:updateUI()
	end), self)
end

function SupermarketRechargeSprite.fullScreen(arg_41_0)
	return
end

function SupermarketRechargeSprite:createSp(arg_42_1)
	local var_42_1 = RechargeSprite:create(var_0_20[arg_42_1] or self.rechargeList[arg_42_1][1].ui_type or 1)

	var_42_1:setOpacity(255)

	var_42_1.selectType = arg_42_1

	if arg_42_1 ~= 10 then
		var_42_1:addTouchEventListener(self:getrechargeHanel())

		if var_42_1:getChildByName("Button_dailyAward") then
			var_42_1:getChildByName("Button_dailyAward"):addTouchEventListener(self:getGoldCardAwardHandel())
		end

		if var_42_1.setrechargeBtnHanel then
			var_42_1:setrechargeBtnHanel(self:getrechargeBtnHanel())
		end
	end

	return var_42_1
end

function SupermarketRechargeSprite:createTableView(arg_43_1)
	local var_43_0 = var_0_20[arg_43_1] or self.rechargeList[arg_43_1][1].ui_type or 1
	local var_43_1 = var_0_22[arg_43_1] + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	self.tableviewobj[arg_43_1] = cc.TableView:create(cc.size(var_0_21[arg_43_1], var_43_1))
	self.tableviewobj[arg_43_1].displayheight = var_43_1

	self.tableviewobj[arg_43_1]:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableviewobj[arg_43_1]:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableviewobj[arg_43_1]:setPosition(cc.p(var_0_23, var_0_24))
	self.tableviewobj[arg_43_1]:setDelegate()

	self.tableviewobj[arg_43_1].anchorPoint = cc.p(0, 0)

	self.tableviewobj[arg_43_1]:setName("tableview")

	self.tableviewobj[arg_43_1].selectType = arg_43_1

	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_tableview"):addChild(self.tableviewobj[arg_43_1])

	if var_43_0 == 5 then
		self.tableviewobj[arg_43_1]:setPosition(cc.p(var_0_23, var_0_24 - 20))
	end

	self.tableviewobj[arg_43_1]:registerScriptHandler(function(arg_44_0, arg_44_1)
		if var_43_0 == 5 then
			if not self.rechargeList[arg_43_1][arg_44_1 + 1].remain or self.rechargeList[arg_43_1][arg_44_1 + 1].remain <= 0 then
				return var_0_25[5], 300
			end
		end

		return var_0_25[var_43_0], var_0_26[var_43_0]
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableviewobj[arg_43_1]:registerScriptHandler(function(arg_45_0, arg_45_1)
		local var_45_0 = arg_45_0:dequeueCell()

		if self.lastrechargeid then
			for iter_45_0, iter_45_1 in pairs(self.rechargeList) do
				for iter_45_2, iter_45_3 in pairs(iter_45_1) do
					if iter_45_3.id == self.lastrechargeid and self.rechargeList[iter_45_0][iter_45_2].have_bought then
						self.rechargeList[iter_45_0][iter_45_2].have_bought = self.rechargeList[iter_45_0][iter_45_2].have_bought - 1
					end
				end
			end

			self.lastrechargeid = nil
		end

		if not var_45_0 then
			var_45_0 = cc.TableViewCell:create()

			local var_45_2 = self:createSp(arg_43_1)

			var_45_2:setSwallowTouches(false)
			var_45_2:setPosition(var_0_27[var_43_0])
			var_45_2:setName("sp")

			if var_45_2:getChildByName("Button_dailyAward") then
				var_45_2:getChildByName("Button_dailyAward"):setTouchEnabled(self.rechargeList[arg_43_1][arg_45_1 + 1].id == var_0_13.gold_card or self.rechargeList[arg_43_1][arg_45_1 + 1].id == var_0_13.gold_quarter_card or self.rechargeList[arg_43_1][arg_45_1 + 1].id == var_0_13.horcrux_card)
			end

			var_45_0:addChild(var_45_2)

			if self.rechargeList[arg_43_1][arg_45_1 + 1] then
				var_45_2:setVisible(true)
				var_45_2:update(self.rechargeList[arg_43_1][arg_45_1 + 1])

				var_45_2.info = self.rechargeList[arg_43_1][arg_45_1 + 1]
			else
				var_45_2:setVisible(false)
			end
		else
			local var_45_3 = var_45_0:getChildByName("sp")

			if var_45_3:getChildByName("Button_dailyAward") then
				var_45_3:getChildByName("Button_dailyAward"):setTouchEnabled(self.rechargeList[arg_43_1][arg_45_1 + 1].id == var_0_13.gold_card or self.rechargeList[arg_43_1][arg_45_1 + 1].id == var_0_13.gold_quarter_card or self.rechargeList[arg_43_1][arg_45_1 + 1].id == var_0_13.horcrux_card)
			end

			if self.rechargeList[arg_43_1][arg_45_1 + 1] then
				var_45_3:setVisible(true)
				var_45_3:update(self.rechargeList[arg_43_1][arg_45_1 + 1])

				var_45_3.info = self.rechargeList[arg_43_1][arg_45_1 + 1]
			else
				var_45_3:setVisible(false)
			end
		end

		if var_43_0 == 5 then
			local var_45_4 = var_45_0:getChildByName("sp")

			if not self.rechargeList[arg_43_1][arg_45_1 + 1].remain or self.rechargeList[arg_43_1][arg_45_1 + 1].remain <= 0 then
				var_45_4:setPositionY(150)
			else
				var_45_4:setPositionY(var_0_27[var_43_0].y)
			end
		end

		return var_45_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableviewobj[arg_43_1]:registerScriptHandler(function(arg_46_0, arg_46_1)
		return self:getRechargeLen(arg_43_1)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableviewobj[arg_43_1]:reloadData()
end

function SupermarketRechargeSprite:getRechargeLen(arg_47_1)
	return #self.rechargeList[arg_47_1]
end

function SupermarketRechargeSprite:updateShowingCells()
	local var_48_0 = var_0_20[self.curSelectType] or self.rechargeList[self.curSelectType][1].ui_type or 1
	local var_48_1 = {
		cellsize = cc.size(var_0_25[var_48_0], var_0_26[var_48_0]),
		maxcount = self:getRechargeLen(self.curSelectType)
	}

	if self.curSelectType == var_0_30 or self.curSelectType == var_0_34 then
		self.tableviewobj[self.curSelectType]:reloadData()
	else
		local var_48_2, var_48_3 = GetTableViewShowCellIdx(self.tableviewobj[self.curSelectType], var_48_1)

		for iter_48_0 = var_48_2, var_48_3 do
			self.tableviewobj[self.curSelectType]:updateCellAtIndex(iter_48_0)
		end
	end
end

function SupermarketRechargeSprite.getrechargeHanel(arg_49_0)
	return function(arg_50_0, arg_50_1)
		if math.abs(arg_50_0:getTouchBeganPosition().y - arg_50_0:getTouchEndPosition().y) > 50 then
			return
		end

		if arg_50_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_50_0:isBright() then
			return
		end

		if arg_49_0.lastrechargeid then
			for iter_50_0, iter_50_1 in pairs(arg_49_0.rechargeList) do
				for iter_50_2, iter_50_3 in pairs(iter_50_1) do
					if iter_50_3.id == arg_49_0.lastrechargeid and arg_49_0.rechargeList[iter_50_0][iter_50_2].have_bought then
						arg_49_0.rechargeList[iter_50_0][iter_50_2].have_bought = arg_49_0.rechargeList[iter_50_0][iter_50_2].have_bought - 1
						arg_50_0.info.have_bought = arg_49_0.rechargeList[iter_50_0][iter_50_2].have_bought
					end
				end
			end

			arg_49_0.lastrechargeid = nil
		end

		for iter_50_4, iter_50_5 in pairs(arg_49_0.rechargeList) do
			for iter_50_6, iter_50_7 in pairs(iter_50_5) do
				if iter_50_7.id == arg_50_0.info.id then
					arg_49_0.rechargeList[iter_50_4][iter_50_6].new_tag = nil
				end
			end
		end

		arg_50_0:setBright(false)

		if arg_50_0.info.buy_limit and arg_50_0.info.have_bought == arg_50_0.info.buy_limit and (arg_50_0.info.id == var_0_13.newbee_card or arg_50_0.info.id == var_0_13.returnback_card or arg_50_0.info.id == var_0_13.gold_card or arg_50_0.info.id == var_0_13.gold_quarter_card or arg_50_0.info.id == var_0_13.horcrux_card or arg_50_0.info.id == var_0_13.diamond_month_card or arg_50_0.info.id == var_0_13.diamond_quarter_card or arg_50_0.info.id == var_0_13.diamond_year_card) then
			arg_49_0:get_other_monthcard_reward(arg_50_0.info.id, function(arg_51_0)
				if arg_51_0.result == 1 then
					-- block empty
				end

				arg_50_0:setBright(true)
			end)
		elseif arg_50_0.info.remain and arg_50_0.info.remain > 0 then
			arg_49_0:get_other_monthcard_reward(arg_50_0.info.id, function(arg_52_0)
				if arg_52_0.result == 1 then
					-- block empty
				end

				arg_50_0:setBright(true)
			end)
		else
			arg_49_0:createDropDes(arg_50_0.selectType, arg_50_0.info, function(...)
				arg_50_0:setBright(true)
			end)
		end

		if arg_50_0.hideNew then
			arg_50_0:hideNew()
		end
	end
end

function SupermarketRechargeSprite.getrechargeBtnHanel(arg_54_0)
	return function(arg_55_0, arg_55_1)
		if math.abs(arg_55_0:getTouchBeganPosition().y - arg_55_0:getTouchEndPosition().y) > 50 then
			return
		end

		if arg_55_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_55_0:isBright() then
			return
		end

		local var_55_0 = arg_55_0:getParent()

		arg_54_0:createDropDes(var_55_0.selectType, var_55_0.info)
	end
end

function SupermarketRechargeSprite.getGoldCardAwardHandel(arg_56_0, ...)
	return function(arg_57_0, arg_57_1)
		if arg_57_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_57_0 = arg_57_0:getParent().info

		if not arg_57_0:isBright() then
			return
		end

		arg_57_0:setBright(false)
		arg_56_0:get_other_monthcard_reward(var_57_0.id, function(arg_58_0)
			if arg_58_0.result == 1 then
				-- block empty
			end

			arg_57_0:setBright(true)
		end)
	end
end

local var_0_36 = {
	[6800202] = "public/currency/6800202.png",
	[SHOP_CURRENCY_GOLD] = "public/currency/UI_battleEnd_gold.png",
	[SHOP_CURRENCY_DIAMOND] = "public/currency/UI_battleEnd_diamond.png",
	[SHOP_CURRENCY_HORNOR] = "public/currency/arenascene_dot_1.png",
	[SHOP_CURRENCY_EXPLORECOIN] = "public/currency/explorecoin.png",
	[SHOP_CURRENCY_RMB] = "public/currency/rmb_white.png",
	[BLACK_CARD] = "public/currency/1500001_1.png",
	[BLACK_SP_CARD] = "public/currency/1500002_1.png",
	[85000006] = "equipment/" .. item_data[85000006].image_id .. ".png"
}

setmetatable(var_0_36, {
	__index = function(arg_59_0, arg_59_1)
		return "public/currency/" .. item_data[arg_59_1].image_id .. ".png"
	end
})

function SupermarketRechargeSprite:shopBuyGift(arg_60_1)
	local var_60_0 = ccui.Layout:create()

	var_60_0:setTouchEnabled(true)
	var_60_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_60_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_60_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_60_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_60_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_60_0:setBackGroundColorOpacity(180)
	self:addChild(var_60_0, 10)

	local var_60_1 = ccui.ImageView:create("mainScenebg/market/" .. arg_60_1.itemtype .. ".png")

	var_60_1:setPosition(cc.p(var_60_0:getContentSize().width / 2, var_60_0:getContentSize().height / 2))
	var_60_0:addChild(var_60_1)

	local var_60_2 = ccui.ImageView:create(var_0_36[arg_60_1.currency], var_0_14)

	var_60_2:setPositionX(var_60_1:getContentSize().width / 2 - 20)
	var_60_2:setPositionY(-130)
	var_60_1:addChild(var_60_2)

	local var_60_3 = arg_60_1.discount * arg_60_1.item_number or arg_60_1.price * arg_60_1.item_number
	local var_60_4 = cc.Label:createWithTTF(var_60_3, FONT_DES, 23)

	var_60_4:setAnchorPoint(cc.p(0, 0.5))
	var_60_4:setPositionX(var_60_2:getPositionX() + var_60_2:getContentSize().width / 2 + 5)
	var_60_4:setPositionY(var_60_2:getPositionY())
	var_60_1:addChild(var_60_4)

	local var_60_5 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_14)
	local var_60_6 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)

	var_60_6:setColor(cc.c3b(12, 12, 12))
	var_60_5:setPosition(cc.p(var_60_1:getContentSize().width / 2, -70))
	var_60_6:setPosition(cc.p(var_60_5:getContentSize().width / 2, var_60_5:getContentSize().height / 2 - 5))
	var_60_5:addChild(var_60_6)
	var_60_1:addChild(var_60_5)
	var_60_5:addTouchEventListener(function(arg_61_0, arg_61_1)
		if arg_61_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_60_3 > item_manager:getItemNumber(6800601) then
			global_ShowBlockWords(L_BUY_BATTLEPASS_VIP)

			return
		end

		if not arg_61_0:isBright() then
			return
		end

		arg_61_0:setBright(false)
		shop_manager:shop_buy(10, arg_60_1.shopid, function(arg_62_0)
			if arg_62_0 == 1 then
				self:buySuccess(arg_60_1.shopid)
				var_60_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_60_0:runAction(cc.RemoveSelf:create())
				end)))
				self:updateUI()
			end

			arg_61_0:setBright(true)
		end, 1)
	end)
	var_60_1:setScaleY(0)
	var_60_1:runAction(cc.ScaleTo:create(0.2, 1))
	var_60_0:addTouchEventListener(function(arg_64_0, arg_64_1)
		var_60_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_60_0:runAction(cc.RemoveSelf:create())
		end)))
	end)
	;(function(...)
		local var_66_0 = var_60_1

		while var_66_0:getChildByName("itemsprite_" .. 1) do
			var_66_0:getChildByName("itemsprite_" .. 1):setName("itemsprite_old" .. 1)
			var_66_0:getChildByName("itemsprite_old" .. 1):runAction(cc.RemoveSelf:create())
		end

		if not shop_data[arg_60_1.shopid].shop_ui_type then
			return
		end

		local var_66_2 = drop_manager:getDropMsg(item_data[arg_60_1.itemtype].mode_id)

		table.sort(var_66_2.equips, function(arg_67_0, arg_67_1)
			return arg_67_0._index < arg_67_1._index
		end)

		local var_66_3 = {}

		if var_66_2.diamond > 0 then
			table.insert(var_66_3, {
				itemid = "diamond",
				num = var_66_2.diamond,
				name = L_DIAMOND
			})
		end

		if var_66_2.gold > 0 then
			table.insert(var_66_3, {
				itemid = "gold",
				num = var_66_2.gold,
				name = L_GOLD
			})
		end

		local var_66_4 = {}
		local var_66_5 = false
		local var_66_6 = false

		for iter_66_0, iter_66_1 in pairs(var_66_2.equips) do
			if item_data[iter_66_1.dropid].bag_item_type == kITEM_SKIN then
				return
			end

			if item_data[iter_66_1.dropid].bag_item_type == kITEM_GIFT_FOR_FRIEND then
				var_66_6 = true
			end

			if item_data[iter_66_1.dropid].bag_item_type == kITEM_FURNITURE then
				-- block empty
			end

			table.insert(var_66_4, {
				itemid = iter_66_1.dropid,
				num = iter_66_1.dropNum
			})
		end

		if var_66_6 and var_66_6 then
			var_66_5 = true
		end

		local var_66_9 = false

		while var_66_4[1] do
			local var_66_10 = false

			if item_data[var_66_4[1].itemid].bag_item_type == kITEM_FURNITURE then
				if not var_66_9 then
					var_66_9 = true
					var_66_4[1].path = string.gsub(arg_60_1.icon, ".png", "_furniture.jpg")
				else
					var_66_10 = true
				end
			end

			local var_66_11

			if var_66_10 then
				table.remove(var_66_4, 1)
			else
				var_66_11 = 1 + 1
			end
		end

		for iter_66_2, iter_66_3 in pairs(var_66_4) do
			table.insert(var_66_3, iter_66_3)
		end

		local var_66_12 = {}

		var_66_12 = var_66_5 and {
			cc.p(122, 479),
			cc.p(122, 324),
			cc.p(122, 169)
		} or #var_66_3 == 2 and {
			cc.p(122, 465),
			cc.p(122, 275)
		} or #var_66_3 == 3 and {
			cc.p(122, 211),
			cc.p(122, 352),
			cc.p(122, 494)
		} or {
			cc.p(122, 211),
			cc.p(122, 352),
			cc.p(122, 494)
		}

		for iter_66_4, iter_66_5 in pairs(var_66_3) do
			local var_66_13 = ItemSpriteShop:createSignItem()

			var_66_13:updateSignItemByItemid(iter_66_5.itemid, iter_66_5.num, nil, nil, iter_66_5.path)
			var_66_13:setName("itemsprite_" .. iter_66_4)
			var_66_13:setPosition(var_66_12[iter_66_4])
			var_66_0:addChild(var_66_13)
			var_66_13:setInfoTouchEvent(true)
			var_66_13:setSwallowTouches(true)
		end
	end)()
end

function SupermarketRechargeSprite:buySuccess(arg_68_1)
	for iter_68_0, iter_68_1 in pairs(self.rechargeList[10]) do
		if iter_68_1.shopid == arg_68_1 then
			iter_68_1.have_bought = iter_68_1.have_bought + 1
		end
	end
end

function SupermarketRechargeSprite:buyRecharge(arg_69_1, arg_69_2, arg_69_3, arg_69_4)
	if self.recharging then
		return
	end

	self.recharging = true

	var_0_15(arg_69_2, function(arg_70_0)
		if arg_70_0.result == 1 then
			if arg_69_3 == var_0_29 and not recharge_data[arg_69_2].rmb then
				var_0_17(arg_69_2, function(arg_71_0)
					if arg_71_0.result == 1 then
						for iter_71_0, iter_71_1 in pairs(self.levelpackage) do
							if iter_71_1.id == arg_69_2 then
								iter_71_1.have_bought = iter_71_1.have_bought + 1
							end
						end

						self:updateLevelPackageArr()
						supermarket_manager:updateRechargeReddot(self.rechargeList)
						self:updateUI()

						if arg_69_4 then
							arg_69_4(arg_71_0)
						end
					end

					self.recharging = false
				end)
			elseif arg_69_3 == var_0_30 then
				var_0_18(arg_69_2, function(arg_72_0)
					if arg_72_0.result == 1 then
						for iter_72_0, iter_72_1 in pairs(self.rechargeList[self.curSelectType]) do
							if iter_72_1.id == arg_69_2 then
								if iter_72_1.have_bought == 0 then
									iter_72_1.have_bought = iter_72_1.have_bought + 1
								end

								iter_72_1.have_bought_ext = iter_72_1.have_bought_ext + 1
							end
						end
					end

					supermarket_manager:updateRechargeReddot(self.rechargeList)
					self:updateUI()

					if arg_69_4 then
						arg_69_4(arg_72_0)
					end

					self.recharging = false
				end)
			elseif arg_69_3 == var_0_31 then
				var_0_19(arg_69_2, function(arg_73_0)
					if arg_73_0.result == 1 then
						for iter_73_0, iter_73_1 in pairs(self.rechargeList[self.curSelectType]) do
							if iter_73_1.id == arg_69_2 then
								iter_73_1.have_bought = iter_73_1.have_bought + 1
							end
						end
					end

					supermarket_manager:updateRechargeReddot(self.rechargeList)
					self:updateUI()

					if arg_69_4 then
						arg_69_4(arg_73_0)
					end

					self.recharging = false
				end)
			elseif arg_69_3 == var_0_33 then
				var_0_17(arg_69_2, function(arg_74_0)
					if arg_74_0.result == 1 then
						for iter_74_0, iter_74_1 in pairs(self.rechargeList[self.curSelectType]) do
							if iter_74_1.id == arg_69_2 then
								iter_74_1.have_bought = iter_74_1.have_bought + 1
							end
						end

						supermarket_manager:updateRechargeReddot(self.rechargeList)
						self:updateUI()

						if arg_69_4 then
							arg_69_4(arg_74_0)
						end
					end

					self.recharging = false
				end)
			elseif arg_69_3 == var_0_34 then
				self:recharge_from_card(arg_69_2, function(arg_75_0)
					if arg_75_0.result == 1 then
						for iter_75_0, iter_75_1 in pairs(self.rechargeList[self.curSelectType]) do
							if iter_75_1.id == arg_69_2 then
								iter_75_1.have_bought = iter_75_1.have_bought + 1
							end
						end

						supermarket_manager:updateRechargeReddot(self.rechargeList)
						self:updateUI()

						if arg_69_4 then
							arg_69_4(arg_75_0)
						end
					end

					self.recharging = false
				end)
			else
				for iter_70_0, iter_70_1 in pairs(self.rechargeList) do
					for iter_70_2, iter_70_3 in pairs(iter_70_1) do
						if iter_70_3.id == arg_69_2 and self.rechargeList[iter_70_0][iter_70_2].have_bought then
							self.rechargeList[iter_70_0][iter_70_2].have_bought = self.rechargeList[iter_70_0][iter_70_2].have_bought + 1
						end
					end
				end

				self.recharging = false
				self.lastrechargeid = arg_69_2

				AnalyticManager.clickPurchaseItem({
					product = arg_69_2,
					rolenum = playermodel:getOwnedServantNum(),
					grade = playermodel.grade,
					class = playermodel.class
				})
				recharge_manager:confirmPayment(arg_69_2)

				if arg_69_4 then
					arg_69_4(arg_70_0)
				end
			end
		elseif arg_70_0.result == 2 then
			print("测试模式")
		elseif arg_70_0.result == 3 then
			global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
		elseif arg_70_0.result == 4 then
			global_ShowBlockWords(L_RECHARGE_OUT_TIME)
		elseif arg_70_0.result == 5 then
			global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
		elseif arg_70_0.result == 6 then
			global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
		elseif arg_70_0.result == 10 then
			self.recharging = false

			global_ShowBlockWords(L_RECHARGE_GRADE_LIMIT)
		end

		if arg_70_0.products then
			self:resetData(arg_70_0.products)
			self.tableviewobj[arg_69_1]:reloadData()
			supermarket_manager:updateRechargeReddot(self.rechargeList)
			self:updateUI()
		end
	end)
end

function SupermarketRechargeSprite.createDropDes(arg_76_0, arg_76_1, arg_76_2, arg_76_3)
	local var_76_0 = arg_76_2.id

	var_0_16(arg_76_2.id, function(arg_77_0)
		if arg_76_2.shop_type == 3 then
			if arg_76_3 then
				arg_76_3()
			end

			if arg_76_2.type == 7 and arg_76_2.remain ~= 0 then
				global_ShowBlockWords(L_SUPERMARKET_TIME_LIMIT_7)

				return
			end

			if recharge_data[var_76_0].dropid_ext then
				if arg_76_2.have_bought and arg_76_2.buy_limit and arg_76_2.have_bought >= arg_76_2.buy_limit and arg_76_2.have_bought_ext and arg_76_2.have_bought_ext >= arg_76_2.buy_limit then
					global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)

					return
				end
			elseif arg_76_2.have_bought and arg_76_2.buy_limit and arg_76_2.have_bought >= arg_76_2.buy_limit then
				global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)

				return
			end

			arg_76_0:buyRecharge(arg_76_1, arg_76_2.id, arg_76_2.type)
		else
			arg_77_0.id = arg_76_2.id

			function arg_77_0.sureCallback(arg_78_0)
				if arg_76_2.type == 7 and arg_76_2.remain ~= 0 then
					global_ShowBlockWords(L_SUPERMARKET_TIME_LIMIT_7)

					return
				end

				if recharge_data[var_76_0].dropid_ext then
					if arg_76_2.have_bought and arg_76_2.buy_limit and arg_76_2.have_bought >= arg_76_2.buy_limit and arg_76_2.have_bought_ext and arg_76_2.have_bought_ext >= arg_76_2.buy_limit then
						global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)

						return
					end
				elseif arg_76_2.have_bought and arg_76_2.buy_limit and arg_76_2.have_bought >= arg_76_2.buy_limit then
					global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)

					return
				end

				arg_76_0:buyRecharge(arg_76_1, arg_76_2.id, arg_76_2.type, arg_78_0)

				if arg_76_3 then
					arg_76_3()
				end
			end

			function arg_77_0.exitcallback(...)
				if arg_76_3 then
					arg_76_3()
				end
			end

			LayerManager:pushInLayer("PopBuyRechargeLayer", arg_77_0, arg_76_2)
		end
	end)
end

function SupermarketRechargeSprite.test(arg_80_0)
	if not config._DEBUG then
		return
	end

	for iter_80_0, iter_80_1 in pairs(recharge_data) do
		if iter_80_1.iosid and iter_80_1.iosid ~= "jieri01" and iter_80_1.iosid ~= "jieri02" and (tonumber(string.match(iter_80_1.iosid, "[0-9]+")) < 14 or tonumber(string.match(iter_80_1.iosid, "[0-9]+")) > 23) then
			if string.find(iter_80_1.iosid, "[a-z]") then
				global_ShowBlockWords("充值表的iosid必须为纯数字字符串\n请联系对应负责人赶快改掉", cc.c3b(255, 0, 0), nil, 10000, 1, 22)
				print("充值表的iosid必须为数字请联系对应负责人赶快改掉")

				return
			end

			if iter_80_1.id ~= 154001 and iter_80_1.id ~= 154002 and iter_80_1.id ~= 154003 and iter_80_1.id ~= 154004 and iter_80_1.id ~= 154005 and iter_80_1.id ~= 154006 and (iter_80_1.id ~= tonumber(string.match(iter_80_1.productid, "[0-9]+")) or iter_80_1.id ~= tonumber(iter_80_1.iosid)) then
				print("充值表的id、iosid、productid数字必须要对应！请联系对应负责人赶快改掉")
				global_ShowBlockWords("充值表的" .. iter_80_1.id .. " id、iosid、productid数字必须要对应！\n请联系对应负责人赶快改掉", cc.c3b(255, 0, 0), nil, 10000, 1, 22)

				return
			end
		end
	end
end

function SupermarketRechargeSprite:updateBySupermarketLayer(arg_81_1)
	self.curSelectType = arg_81_1.selectType or self.curSelectType

	self:filterBtnTouchEvent()
end

return SupermarketRechargeSprite
