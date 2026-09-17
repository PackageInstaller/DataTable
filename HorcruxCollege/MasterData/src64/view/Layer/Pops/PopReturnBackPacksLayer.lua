PopReturnBackPacksLayer = class("PopReturnBackPacksLayer", function()
	return PopBaseLayer:create()
end)

local playermodel = require("model.playermodel")
local time_check_manager = require("controller.time_check_manager")
local network = require("network.network")
local recharge_manager = require("controller.recharge_manager")
local alert_manager = require("controller.alert_manager")
local item_manager = require("controller.item_manager")
local shop_manager = require("controller.shop_manager")
local var_0_8 = require("controller.time_check_manager")
local drop_manager = require("controller.drop_manager")
local supermarket_manager = require("controller.supermarket_manager")
local item_data = require("data.item_data")
local recharge_data = require("data.recharge_data")
local shop_data = require("data.shop_data")
local var_0_14 = config._DEBUG and 0 or 1
local var_0_15 = {
	cc.p(113, 185),
	cc.p(-30, 82),
	cc.p(257, 82),
	[0] = cc.p(113, 185)
}
local var_0_16 = {
	[0] = 90,
	90,
	0,
	180
}

function PopReturnBackPacksLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopReturnBackPacksLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

local function var_0_17(arg_3_0)
	local var_3_0 = -1
	local var_3_1 = require("data.horcrux_data")[arg_3_0].horcruxt

	for iter_3_0, iter_3_1 in pairs((require("data.photofile_HelpGirl_data"))) do
		if arg_3_0 == iter_3_1.item_id then
			var_3_0 = iter_3_0

			break
		end
	end

	if var_3_0 == -1 then
		return
	end

	LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
		id = var_3_0,
		itemid = arg_3_0
	})
end

local function var_0_18(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0
	local var_4_1

	if not arg_4_2 then
		local var_4_3 = drop_manager:getDropMsg(arg_4_0)

		if var_4_3.gold ~= 0 then
			var_4_0 = "gold"
			var_4_1 = var_4_3.gold
		elseif var_4_3.diamond ~= 0 then
			var_4_0 = "diamond"
			var_4_1 = var_4_3.diamond
		elseif var_4_3.equips then
			for iter_4_0, iter_4_1 in pairs(var_4_3.equips) do
				var_4_0 = iter_4_1.dropid
				var_4_1 = iter_4_1.dropNum
			end
		end
	else
		var_4_0 = arg_4_2
		var_4_1 = arg_4_3
	end

	local var_4_4 = ccui.ImageView:create()

	var_4_4:setTouchEnabled(arg_4_1)

	if var_4_0 == "diamond" then
		var_4_4:loadTexture("equipment/1000000.png")
		var_4_4:setTouchEnabled(false)
	elseif var_4_0 == "gold" then
		var_4_4:loadTexture("equipment/1000001.png")
		var_4_4:setTouchEnabled(false)
	elseif item_data[var_4_0].bag_item_type == kITEM_SKIN then
		var_4_4:loadTexture("roleimage/role1/" .. modelData[item_data[var_4_0].model].cute_role .. ".png")
		var_4_4:setScale(0.3)
	elseif item_data[var_4_0].bag_item_type == kITEM_HORCRUX then
		local var_4_5 = drop_manager:getAllDropsNotMerge(arg_4_0)[1].item_attr
		local var_4_6 = ccui.Layout:create()

		var_4_6:setName("starsPanel")
		var_4_6:setScale(1.75)
		var_4_6:setPositionY(58)
		var_4_6:setPositionX(200)
		var_4_4:addChild(var_4_6, 5)

		local var_4_7 = 0

		if var_4_5 then
			for iter_4_2, iter_4_3 in var_4_5:gmatch("([^&]+)=([^&]+)") do
				if iter_4_2 == "star" then
					var_4_7 = tonumber(iter_4_3)
				end
			end
		end

		for iter_4_4 = 1, var_4_7 do
			local var_4_8

			if config._DEBUG then
				var_4_8 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			var_4_8:setPosition(25, (iter_4_4 - 1) * 24 - 30)
			var_4_6:addChild(var_4_8)
		end

		var_4_4:loadTexture("equipment/" .. item_data[var_4_0].image_id .. ".png")
		var_4_4:setScale(0.3)
	elseif item_data[var_4_0].bag_item_type == kITEM_COMPONENT then
		var_4_4:removeFromParent()

		var_4_4 = nil
		var_4_4 = componentManager:create_component_icon(var_4_0)

		;(nil):setPosition(cc.p(self.championBg:getContentSize().width / 2, self.championBg:getContentSize().height / 2 + 20))
		var_4_4:setScale(0.75)
	elseif item_data[var_4_0].image_id then
		var_4_4:loadTexture("equipment/" .. item_data[var_4_0].image_id .. ".png")
		var_4_4:setScale(0.75)
	end

	var_4_4:setSwallowsTouches(false)
	var_4_4:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[var_4_0].bag_item_type == kITEM_HORCRUX then
			var_0_17(var_4_0)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_4_0
			})
		end
	end)

	return var_4_4, var_4_1, name
end

local function var_0_19(arg_6_0, arg_6_1)
	network:rpc("check_recharge", {
		id = arg_6_0,
		client = config.clientmode
	}, function(arg_7_0)
		if arg_6_1 then
			arg_6_1(arg_7_0)
		end
	end)
end

local function var_0_23(arg_14_0, arg_14_1)
	network:rpc("get_free_award", {
		id = arg_14_0
	}, function(arg_15_0)
		if arg_15_0.result == 1 then
			global_gain({
				items = arg_15_0.items,
				diamond = arg_15_0.diamond,
				gold = arg_15_0.gold,
				sp = arg_15_0.sp
			})
		elseif arg_15_0.result == 2 then
			print(L_LAB_RECIPE_WARNING[3])
		elseif arg_15_0.result == 3 then
			print(L_SUPERMARKET_TIME_LIMIT_3)
		elseif arg_15_0.result == 4 then
			print(L_RECHARGE_BUY_LIMIT)
		elseif arg_15_0.result == 5 then
			print(L_SUPERMARKET_TIME_LIMIT_2)
		end

		if arg_14_1 then
			arg_14_1(arg_15_0)
		end
	end)
end

function PopReturnBackPacksLayer:init(arg_16_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2 + GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Layout:create()

	self.rootpanel:setContentSize(GameDisplay.getScreenSize())
	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2)
	self.rootLayer:addChild(self.rootpanel)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_17_0:isBright() then
			return
		end

		arg_17_0:setBright(false)
		self.rechargeView:setVisible(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)

	self.recharging = false

	self:initPurchaseEventListener()
	self:initUI()
	self:registerScriptHandler(function(arg_19_0)
		if arg_19_0 == "exit" then
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
		end
	end)
	self:initData(function()
		if tolua.isnull(self) then
			return
		end

		self.rechargeView:reloadData()
	end)
end

function PopReturnBackPacksLayer:initPurchaseEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("APPENTERFOREGROUND", function(arg_22_0)
		self.recharging = false
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_23_0)
		if not arg_23_0 or not arg_23_0.id then
			return
		end

		for iter_23_0, iter_23_1 in pairs(self.rechargeList) do
			if self.rechargeList[iter_23_0].id == arg_23_0.id then
				self.rechargeList[iter_23_0].have_bought = self.rechargeList[iter_23_0].have_bought + 1
			end
		end

		self.lastrechargeid = nil

		self:updateShowingCells(self.rechargeView, #self.rechargeList)
	end), self)
end

function PopReturnBackPacksLayer.initData(arg_24_0, arg_24_1)
	arg_24_0.rechargeList = {}

	network:rpc("get_recharge_info", {
		client = config.clientmode,
		types = {
			11,
			4
		}
	}, function(arg_25_0)
		if tolua.isnull(arg_24_0) then
			return
		end

		if arg_25_0.result == 1 then
			for iter_25_0, iter_25_1 in ipairs(arg_25_0.products) do
				if iter_25_1.id >= 74900 and iter_25_1.id <= 74909 then
					table.insert(arg_24_0.rechargeList, iter_25_1)
				end
			end

			table.sort(arg_24_0.rechargeList, function(arg_26_0, arg_26_1)
				if not arg_26_0.pre_rechargeid and not arg_26_1.pre_rechargeid then
					return arg_26_0.id < arg_26_1.id
				end

				if not arg_26_0.pre_rechargeid then
					return true
				end

				if not arg_26_1.pre_rechargeid then
					return false
				end

				return arg_26_0.pre_rechargeid < arg_26_1.pre_rechargeid
			end)

			if arg_24_1 then
				arg_24_1()
			end
		else
			KeyCodeManager:onKeyReleasedCallFunc()
		end
	end)
end

function PopReturnBackPacksLayer:initUI()
	local var_27_0 = ccui.ImageView:create("PopReturnBackPacksLayer/bg.png", var_0_14)

	var_27_0:setPosition(cc.p(320, 660 - GameDisplay.fix_y))
	var_27_0:setTouchEnabled(true)
	self.rootpanel:addChild(var_27_0)

	self.rechargeView = cc.TableView:create(cc.size(560, 600))

	self.rechargeView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rechargeView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rechargeView:setAnchorPoint(cc.p(0, 0))
	self.rechargeView:setPosition(40, 60)
	self.rechargeView:setDelegate()
	var_27_0:addChild(self.rechargeView)
	self.rechargeView:registerScriptHandler(function(arg_29_0, arg_29_1)
		return 560, 260
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.rechargeView:registerScriptHandler(function(arg_28_0, arg_28_1)
		local var_28_0 = arg_28_0:dequeueCell()

		if not var_28_0 then
			var_28_0 = cc.TableViewCell:create()

			local var_28_1 = self:createSp()

			var_28_1:setName("sp")
			var_28_0:addChild(var_28_1)
		end

		var_28_0:getChildByName("sp").update(arg_28_1)

		return var_28_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.rechargeView:registerScriptHandler(function(arg_30_0, arg_30_1)
		local var_30_0 = math.floor(#self.rechargeList / 2)

		if #self.rechargeList % 2 == 0 then
			return var_30_0
		else
			return var_30_0 + 1
		end
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)

	self.dont_click = ccui.Layout:create()

	self.dont_click:setTouchEnabled(true)
	self.dont_click:setContentSize(640, var_27_0:getPositionY() - var_27_0:getContentSize().height / 2 - 80 + GameDisplay.fix_y)
	self.dont_click:setPositionY(80 - GameDisplay.fix_y)
	self.dont_click:setAnchorPoint(0, 0)
	self.dont_click:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_31_0:isBright() then
			return
		end

		arg_31_0:setBright(false)
		self.rechargeView:setVisible(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.rootpanel:addChild(self.dont_click)
end

function PopReturnBackPacksLayer.createSp(arg_33_0)
	local var_33_0 = ccui.Layout:create()

	var_33_0:setContentSize(cc.size(560, 260))
	var_33_0:setPosition(cc.p(0, 130))

	for iter_33_0 = 1, 2 do
		local var_33_1 = ccui.ImageView:create("PopReturnBackPacksLayer/pack_bg.png", var_0_14)

		var_33_1:setName("bg" .. iter_33_0)
		var_33_1:setPosition(cc.p(290 * iter_33_0 - 160, 25))
		var_33_0:addChild(var_33_1)

		local var_33_2 = ccui.Button:create("PopReturnBackPacksLayer/buy_btn_on.png", nil, "PopReturnBackPacksLayer/buy_btn_on.png", var_0_14)

		var_33_2:setPosition(cc.p(110, -30))
		var_33_2:setName("btn")
		var_33_1:addChild(var_33_2)

		local var_33_3 = cc.Label:createWithTTF("", FONT_NAME, 21)

		var_33_3:setColor(cc.c3b(64, 44, 20))
		var_33_3:setName("lblBuy")
		var_33_3:setPosition(cc.p(var_33_2:getContentSize().width / 2, var_33_2:getContentSize().height / 2 + 2))
		var_33_2:addChild(var_33_3)

		local var_33_4 = cc.Label:createWithTTF("lblLimit", FONT_NAME, 16)

		var_33_4:setName("lblLimit")
		var_33_4:setColor(cc.c3b(167, 163, 213))
		var_33_4:setPosition(cc.p(115, 25))
		var_33_1:addChild(var_33_4)

		if iter_33_0 == 1 then
			local var_33_5 = ccui.ImageView:create("PopReturnBackPacksLayer/item_bg.png", var_0_14)

			var_33_5:setName("itembg1")
			var_33_5:setPosition(cc.p(113, 90))
			var_33_1:addChild(var_33_5)

			local var_33_6 = ccui.ImageView:create("PopReturnBackPacksLayer/label_bg.png", var_0_14)

			var_33_6:setPosition(34, 49)
			var_33_5:addChild(var_33_6)

			local var_33_7 = cc.Label:createWithTTF("20", FONT_NAME, 18)

			var_33_7:setPosition(cc.p(50, 10))
			var_33_6:addChild(var_33_7)
		else
			local var_33_8 = ccui.ImageView:create("PopReturnBackPacksLayer/item_bg.png", var_0_14)

			var_33_8:setName("itembg1")
			var_33_8:setPosition(cc.p(68, 90))
			var_33_1:addChild(var_33_8)

			local var_33_9 = ccui.ImageView:create("PopReturnBackPacksLayer/item_bg.png", var_0_14)

			var_33_9:setName("itembg2")
			var_33_9:setPosition(cc.p(160, 90))
			var_33_1:addChild(var_33_9)
		end
	end

	function var_33_0.update(arg_34_0)
		for iter_34_0 = 1, 2 do
			local var_34_1 = arg_33_0.rechargeList[((arg_34_0 + 1) % 2 == 0 or nil) and arg_34_0 * 2 + (3 - iter_34_0)]
			local var_34_2 = var_33_0:getChildByName("bg" .. iter_34_0)

			if arg_33_0.rechargeList[((arg_34_0 + 1) % 2 == 0 or nil) and arg_34_0 * 2 + (3 - iter_34_0)] then
				var_34_2:setVisible(true)

				local var_34_3 = var_34_2:getChildByName("btn")
				local var_34_4 = var_34_3:getChildByName("lblBuy")
				local var_34_5 = var_34_2:getChildByName("lblLimit")

				if var_34_1.rmb == 0 then
					var_34_4:setString(L_FREE_FOR_CHARGE)
				else
					var_34_4:setString(recharge_manager:getCommodityPriceStr(var_34_1.id))
				end

				var_34_5:setString(string.format("限购%s/%s", var_34_1.have_bought, var_34_1.buy_limit))

				if var_34_1.buy_limit > var_34_1.have_bought then
					var_34_4:setColor(cc.c3b(64, 44, 20))
					var_34_3:loadTextures("PopReturnBackPacksLayer/buy_btn_on.png", nil, "PopReturnBackPacksLayer/buy_btn_on.png", var_0_14)
				else
					var_34_4:setString(L_BOUGHT)
					var_34_4:setColor(cc.c3b(53, 53, 53))
					var_34_3:loadTextures("PopReturnBackPacksLayer/buy_btn_off.png", nil, "PopReturnBackPacksLayer/buy_btn_off.png", var_0_14)
				end

				var_34_3:addTouchEventListener(function(arg_35_0, arg_35_1)
					if math.abs(arg_35_0:getTouchBeganPosition().y - arg_35_0:getTouchEndPosition().y) > 50 then
						return
					end

					if arg_35_1 ~= ccui.TouchEventType.ended then
						return
					end

					if var_34_1.buy_limit <= var_34_1.have_bought then
						return
					end

					arg_33_0:buyRecharge(var_34_1)
				end)

				while var_34_2:getChildByName("itembg" .. 1) do
					var_34_2:removeChildByName("itembg" .. 1)
				end

				local var_34_7 = drop_manager:getDropMsg(recharge_data[var_34_1.id].dropid or item_data[recharge_data[var_34_1.id].dropitem].mode_id)

				if var_34_7.diamond > 0 then
					table.insert(var_34_7.equips, {
						dropid = "diamond",
						dropNum = var_34_7.diamond
					})
				end

				if var_34_7.gold > 0 then
					table.insert(var_34_7.equips, {
						dropid = "gold",
						dropNum = var_34_7.gold
					})
				end

				local var_34_8 = #var_34_7.equips == 1 and {
					113
				} or {
					68,
					160
				}

				for iter_34_1, iter_34_2 in ipairs(var_34_7.equips) do
					local var_34_9 = ccui.ImageView:create("PopReturnBackPacksLayer/item_bg.png", var_0_14)

					var_34_9:setName("itembg" .. iter_34_1)
					var_34_9:setPosition(cc.p(var_34_8[iter_34_1] or var_34_8[1] + 92 * (iter_34_1 - 1), 90))
					var_34_2:addChild(var_34_9)

					local var_34_10 = ccui.ImageView:create("PopReturnBackPacksLayer/label_bg.png", var_0_14)

					var_34_10:setPosition(34, 49)
					var_34_9:addChild(var_34_10)

					local var_34_11 = cc.Label:createWithTTF("", FONT_NAME, 18)

					var_34_11:setPosition(cc.p(45, 10))
					var_34_10:addChild(var_34_11)

					local var_34_12, var_34_13 = var_0_18(nil, true, iter_34_2.dropid, iter_34_2.dropNum)

					var_34_12:setScale(var_34_12:getScale() * 0.65)
					var_34_12:setPosition(35, 50)
					var_34_9:addChild(var_34_12)
					var_34_11:setString("x" .. global_trans_number(var_34_13))
					var_34_11:setScale((40 / var_34_11:getContentSize().width < 1 and 50 / var_34_11:getContentSize().width or 1) * var_34_11:getScale())
				end

				var_34_2:removeChildByName("pre_icon")

				if var_34_1.pre_rechargeid then
					local var_34_14 = ccui.ImageView:create("PopReturnBackPacksLayer/next_icon.png", var_0_14)

					var_34_2:addChild(var_34_14)
					var_34_14:setName("pre_icon")
					var_34_14:setPosition(var_0_15[(arg_34_0 * 2 + iter_34_0) % 4])
					var_34_14:setRotation(var_0_16[(arg_34_0 * 2 + iter_34_0) % 4])
				end
			else
				var_34_2:setVisible(false)
			end
		end
	end

	return var_33_0
end

function PopReturnBackPacksLayer:initBg(arg_36_1)
	local var_36_0 = ccui.Layout:create()

	var_36_0:setTouchEnabled(true)
	var_36_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_36_0:setAnchorPoint(cc.p(0, 0))
	var_36_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_36_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_36_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_36_0:setOpacity(0)
	self:addChild(var_36_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_37_0)
		self:addChild(arg_37_0, -2)
		arg_37_0:setPositionY(arg_37_0:getPositionY() - GameDisplay.fix_y)

		local var_37_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_37_0:setAnchorPoint(cc.p(0, 0))
		var_37_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_37_0, -1)
		self:init(arg_36_1)
		var_36_0:setOpacity(102)
		var_36_0:setTouchEnabled(false)
	end)
end

function PopReturnBackPacksLayer.updateShowingCells(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0, var_38_1 = GetTableViewShowCellIdx(arg_38_1, {
		maxcount = math.ceil(arg_38_2),
		cellsize = cc.size(640, 260)
	})

	for iter_38_0 = var_38_0, var_38_1 do
		arg_38_1:updateCellAtIndex(iter_38_0)
	end
end

function PopReturnBackPacksLayer:buyRecharge(arg_39_1, arg_39_2)
	if self.recharging then
		return
	end

	if not self:no_pre_recharge(arg_39_1) then
		global_ShowBlockWords("还有前置礼包未购买哦~")

		return
	end

	local var_39_0 = arg_39_1.id

	self.recharging = true

	var_0_19(var_39_0, function(arg_40_0)
		if arg_40_0.result == 1 then
			if arg_39_1.rmb == 0 then
				var_0_23(var_39_0, function(arg_41_0)
					if arg_41_0.result == 1 then
						for iter_41_0, iter_41_1 in pairs(self.rechargeList) do
							if iter_41_1.id == var_39_0 then
								iter_41_1.have_bought = iter_41_1.have_bought + 1
							end
						end
					end

					self:updateShowingCells(self.rechargeView, #self.rechargeList)

					if arg_39_2 then
						arg_39_2(arg_41_0)
					end

					self.recharging = false
				end)
			else
				self.recharging = false
				self.lastrechargeid = var_39_0

				AnalyticManager.clickPurchaseItem({
					product = var_39_0,
					rolenum = playermodel:getOwnedServantNum(),
					grade = playermodel.grade,
					class = playermodel.class
				})
				recharge_manager:confirmPayment(var_39_0)

				if arg_39_2 then
					arg_39_2(arg_40_0)
				end
			end
		elseif arg_40_0.result == 2 then
			print("测试模式")
		elseif arg_40_0.result == 3 then
			global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
		elseif arg_40_0.result == 4 then
			global_ShowBlockWords(L_RECHARGE_OUT_TIME)
		elseif arg_40_0.result == 5 then
			global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
		elseif arg_40_0.result == 6 then
			global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
		elseif arg_40_0.result == 10 then
			self.recharging = false

			global_ShowBlockWords(L_RECHARGE_GRADE_LIMIT)
		end

		if arg_40_0.products then
			for iter_40_0, iter_40_1 in ipairs(arg_40_0.products) do
				if iter_40_1.id >= 74900 and iter_40_1.id <= 74909 then
					table.insert(self.rechargeList, iter_40_1)
				end
			end

			self:updateShowingCells(self.rechargeView, #self.rechargeList)
		end
	end)
end

function PopReturnBackPacksLayer.no_pre_recharge(arg_42_0, arg_42_1)
	if not arg_42_1.pre_rechargeid then
		return true
	end

	return (function(arg_43_0)
		for iter_43_0, iter_43_1 in pairs(arg_42_0.rechargeList) do
			if iter_43_1.id == arg_43_0 and iter_43_1.have_bought > 0 then
				return true
			end
		end

		return false
	end)(arg_42_1.pre_rechargeid)
end
