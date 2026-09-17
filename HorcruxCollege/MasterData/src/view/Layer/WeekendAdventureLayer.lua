WeekendAdventureLayer = class("WeekendAdventureLayer", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local item_manager = require("controller.item_manager")
local network = require("network.network")
local var_0_4 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local shop_data = require("data.shop_data")
local shop_manager = require("controller.shop_manager")
local discount_manager = require("controller.discount_manager")
local account_manager = require("controller.account_manager")
local ItemSprite = require("view.Sprite.ItemSprite")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local levelmode_data = require("data.levelmode_data")
local alert_manager = require("controller.alert_manager")

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")

local var_0_17 = {
	"weekendadventure/xinpian.png",
	"weekendadventure/kayan.png",
	"weekendadventure/ziyuan.png",
	"weekendadventure/component.png"
}
local var_0_18 = {
	"weekendadventure/xinpian_icon.png",
	"weekendadventure/keyan_icon.png",
	"weekendadventure/tongying_icon.png",
	"weekendadventure/component_icon.png"
}
local var_0_19 = cc.c3b(255, 210, 0)
local var_0_21
local var_0_22 = 600
local var_0_23 = 280 + (GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT) / 3

function add_new_tag(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0:getChildByName("reddot") then
		arg_2_0:getChildByName("reddot"):setVisible(true)

		return
	end

	local var_2_0 = arg_2_2 or 999
	local var_2_1 = arg_2_1 or {
		x = arg_2_0:getContentSize().width,
		y = arg_2_0:getContentSize().height
	}
	local var_2_2 = ccui.ImageView:create("public/reddot/reddot0.png", config._DEBUG and 0 or 1)

	var_2_2:setName("reddot")
	var_2_2:setAnchorPoint(cc.p(1, 1))
	var_2_2:setPosition(cc.p(var_2_1.x, var_2_1.y))
	arg_2_0:addChild(var_2_2, var_2_0)
end

function remove_alert_tag(arg_3_0)
	if not arg_3_0:getChildByName("reddot") then
		return
	end

	arg_3_0:getChildByName("reddot"):runAction(cc.RemoveSelf:create())
end

function WeekendAdventureLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = WeekendAdventureLayer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function WeekendAdventureLayer:init(arg_5_1)
	var_0_21 = self

	if arg_5_1 then
		self.returnbacklayer = arg_5_1.returnbacklayer or "AdventureLayer"
	end

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "WeekendAdventureLayer.json" or "WeekendAdventureLayer.ExportJson")

	self:addChild(self.rootLayer)
	self.rootLayer:setBackGroundColorOpacity(0)

	local var_5_0 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	self.roleTableView = cc.TableView:create(cc.size(640, 1050 + var_5_0))

	self.roleTableView:setPosition(cc.p(0, 90))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.roleTableView)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rootLayer:setName("self.roleTableView")

	self.roleTableViewhight = 1050 + var_5_0

	self:initBottomList()
	self:getListData()
	self:createTitleSprite()
	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_21 = nil
		end
	end)
end

function WeekendAdventureLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer(self.returnbacklayer)
	end)

	self:addChild(self.bottomList, 10)
end

function WeekendAdventureLayer:createTimesBtn(...)
	if not var_0_21 then
		return
	end

	local var_9_0

	for iter_9_0, iter_9_1 in pairs(self.data) do
		if iter_9_1.info.modetype == 2 then
			var_9_0 = iter_9_1.info.modetype
		elseif iter_9_1.info.modetype ~= 2 then
			var_9_0 = false

			break
		end
	end

	if var_9_0 then
		local var_9_1 = cc.Label:createWithTTF("剩余挑战次数：", FONT_DES, 20)

		var_9_1:setPositionX(self.bottomList:getContentSize().width / 2 + 143)
		var_9_1:setPositionY(self.bottomList:getContentSize().height / 2 - 7)
		var_9_1:setColor(cc.c3b(14, 185, 255))
		self.bottomList:addChild(var_9_1)

		local var_9_2 = ccui.ImageView:create("adventurenewlayer/new_changtimesdi.png", var_0_4)

		var_9_2:setPositionX(self.bottomList:getContentSize().width / 2 + 243)
		var_9_2:setPositionY(self.bottomList:getContentSize().height / 2 - 5)
		self.bottomList:addChild(var_9_2)

		self.label_times = cc.Label:createWithTTF("", FONT_DES, 24)

		self.label_times:setPositionX(var_9_2:getContentSize().width / 2)
		self.label_times:setPositionY(var_9_2:getContentSize().height / 2)
		self.label_times:setColor(cc.c3b(14, 225, 252))
		var_9_2:addChild(self.label_times)

		self.buybtn = ccui.Button:create("adventurenewlayer/add.png", nil, "adventurenewlayer/add.png", var_0_4)

		self.buybtn:setPositionX(self.bottomList:getContentSize().width / 2 + 297)
		self.buybtn:setPositionY(self.bottomList:getContentSize().height / 2 - 5)
		self.bottomList:addChild(self.buybtn)
		self.buybtn:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_10_0:isBright() then
				return
			end

			arg_10_0:setBright(false)

			local function var_10_0()
				arg_10_0:setBright(true)
			end

			local function var_10_1()
				level_manager:buyAdventureDailyTime(2, function(arg_13_0, arg_13_1, arg_13_2)
					if arg_13_0 == 1 then
						if not AdventureNewItemLayerInstance then
							return
						end

						global_ShowBlockWords(L_BUY_TIMES_SUCCESS)
						self.label_times:setString(arg_13_2)
					elseif arg_13_0 == 2 then
						global_ShowBlockWords(L_DIAMOND_LACK)
					elseif arg_13_0 == 3 then
						global_ShowBlockWords(L_BUY_TIMES_LIMITED)
					end

					if var_10_0 then
						var_10_0()
					end
				end)
			end

			level_manager:getBuyAdventureDailyTimeInfo(var_9_0, function(arg_14_0, arg_14_1, arg_14_2)
				if arg_14_0 == 1 then
					LayerManager:pushInLayer("PopDoLayer", {
						costtype = "diamond",
						surecallback = var_10_1,
						cancelcallback = function()
							if var_10_0 then
								var_10_0()
							end
						end,
						cost = arg_14_1,
						own = playermodel.diamond,
						labels = {
							titleImage = "title_more_adventure_times.png",
							button = L_BUY_TIMES_MSG.button,
							des = string.format(L_BUY_TIMES_MSG.des, arg_14_1),
							more = string.format(L_BUY_TIMES_MSG.more, arg_14_1)
						}
					})
				else
					global_ShowBlockWords(L_BUY_TIMES_LIMITED)

					if var_10_0 then
						var_10_0()
					end
				end
			end)
		end)
	end
end

function WeekendAdventureLayer:createNode()
	local var_16_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "items"):clone()

	var_16_0:setTouchEnabled(false)

	return var_16_0
end

function WeekendAdventureLayer:getShopData()
	local function var_17_0(arg_18_0)
		self.shopinfo = arg_18_0
	end

	self.shop_type = nil

	local var_17_1

	for iter_17_0, iter_17_1 in pairs(levelmode_data) do
		if iter_17_1.modetype == 8 or iter_17_1.modetype == 9 and iter_17_1.modetype == 7 then
			var_17_1 = iter_17_1.shop_id
		end
	end

	if not var_17_1 then
		print("error:-----------> shop_id is nil")

		return
	end

	for iter_17_2, iter_17_3 in pairs(shop_data) do
		if iter_17_3.id == var_17_1 then
			self.shop_type = iter_17_3.shop_type
		end
	end

	if not self.shop_type then
		print("error:-----------> shop_type is nil")

		return
	end

	network:rpc("get_shop_data", {
		shoptype = self.shop_type,
		channelid = account_manager:getChannel()
	}, function(arg_19_0)
		if var_17_0 then
			var_17_0(arg_19_0.shoplist)
		end
	end)
end

function WeekendAdventureLayer:createTitleSprite()
	self.title = TitleSprite:create("weekendadventure/title.png", 2)

	self.title:setName("title")
	self.title:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56))
	self.rootLayer:addChild(self.title, 5)
end

function WeekendAdventureLayer:updateNode(arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1:getChildByName("change_btn")
	local var_21_1 = ccui.Helper:seekWidgetByName(arg_21_1, "add")

	ccui.Helper:seekWidgetByName(arg_21_1, "Label_11"):setString("")
	ccui.Helper:seekWidgetByName(arg_21_1, "num"):setString("")
	var_21_1:setVisible(false)
	var_21_0:loadTextures(var_0_17[arg_21_2.id], nil, var_0_17[arg_21_2.id], var_0_4)

	local var_21_2 = ccui.Helper:seekWidgetByName(arg_21_1, "ticket")

	var_21_2:loadTexture(var_0_18[arg_21_2.id], var_0_4)
	var_21_2:setVisible(false)
	var_21_0:setSwallowTouches(false)
	var_21_1:setSwallowTouches(true)
	var_21_0:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_22_0:getTouchBeganPosition().y - arg_22_0:getTouchEndPosition().y) > 50 then
			return
		end

		if self:canChange(left_time, ticket_num) then
			RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", arg_21_2.info.modetype)
			RoleDefault:getInstance():setIntegerForKey("AdventureEnterTrialtype", arg_21_2.info.trialtype or 1)
			LayerManager:switchShowLayer("AdventureNewItemLayer", {
				layer = arg_21_2.info.modetype,
				trialtype = arg_21_2.info.trialtype
			})
		end
	end)
	var_21_1:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.shopinfo then
			local var_23_0

			for iter_23_0, iter_23_1 in pairs(self.shopinfo) do
				if iter_23_1.shopid == arg_21_2.info.shop_id then
					var_23_0 = iter_23_1

					break
				end
			end

			if var_23_0 and self.shop_type then
				self:shopPop(var_23_0, self.shop_type, function()
					if var_0_21 then
						self:getListData()
					end
				end)
			else
				print("error:——————————————————> no shop data or shoptype is nil!!!!!!!", arg_21_2.info.shop_id)
			end
		end
	end)
	self:updateNewAlertStatus(arg_21_1, arg_21_2.id)
	self:updateWeekedTimes(arg_21_1, arg_21_2.info.modetype)
end

function WeekendAdventureLayer.getTicketNum(arg_25_0, arg_25_1)
	local var_25_0

	if levelmode_data[arg_25_1] then
		var_25_0 = levelmode_data[arg_25_1].cost_item or nil

		if not var_25_0 then
			return 0
		end
	end

	return item_manager:getItemNumber(var_25_0)
end

function WeekendAdventureLayer:getModeTypeTimes(arg_26_1)
	if not arg_26_1 or not self.modetimes then
		return 0
	end

	for iter_26_0, iter_26_1 in pairs(self.modetimes) do
		if iter_26_1.modetype == arg_26_1 then
			return iter_26_1.time
		end
	end

	return 0
end

function WeekendAdventureLayer.updataImage(arg_27_0, arg_27_1, arg_27_2)
	return
end

function WeekendAdventureLayer:initTableView()
	self.roleTableView:registerScriptHandler(function(arg_30_0, arg_30_1)
		return var_0_22, var_0_23
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_29_0, arg_29_1)
		local var_29_0 = arg_29_0:dequeueCell()

		if not var_29_0 then
			var_29_0 = cc.TableViewCell:create()

			var_29_0:setName("btn_node_" .. arg_29_1 + 1)

			local var_29_1 = self:createNode()

			var_29_1:setName("btn_node")
			var_29_1:setPosition(cc.p(20, -85))
			self:updateNode(var_29_1, self.data[arg_29_1 + 1])

			if arg_29_1 <= math.floor(self.roleTableViewhight / var_0_23) then
				var_29_1:setOpacity(0)
				var_29_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_29_1), cc.FadeIn:create(0.1)))
			else
				var_29_1:setOpacity(255)
			end

			var_29_0:addChild(var_29_1)
		else
			local var_29_2 = var_29_0:getChildByName("btn_node")

			var_29_2:setOpacity(255)
			self:updateNode(var_29_2, self.data[arg_29_1 + 1])
		end

		if arg_29_1 + 1 == #self.data then
			var_29_0:setVisible(false)
		else
			var_29_0:setVisible(true)
		end

		return var_29_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_31_0, arg_31_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()
end

function WeekendAdventureLayer:getListData()
	local var_32_0 = {}
	local var_32_1
	local var_32_2
	local var_32_3
	local var_32_4

	for iter_32_0, iter_32_1 in pairs(levelmode_data) do
		if iter_32_1.modetype == 2 then
			if iter_32_1.trialtype == 1 then
				var_32_1 = iter_32_1
			elseif iter_32_1.trialtype == 2 then
				var_32_2 = iter_32_1
			elseif iter_32_1.trialtype == 3 then
				var_32_3 = iter_32_1
			else
				var_32_4 = iter_32_1
			end
		end
	end

	if var_32_1 then
		table.insert(var_32_0, {
			id = 1,
			info = var_32_1
		})
	end

	if var_32_2 then
		table.insert(var_32_0, {
			id = 2,
			info = var_32_2
		})
	end

	if var_32_3 then
		table.insert(var_32_0, {
			id = 3,
			info = var_32_3
		})
	end

	if var_32_4 then
		table.insert(var_32_0, {
			id = 4,
			info = var_32_4
		})
	end

	if not next(var_32_0) then
		print("waring no data can use")

		return
	end

	table.insert(var_32_0, var_32_0[#var_32_0])

	self.data = var_32_0

	self:getLeftTimes()
	self:initTableView()
	self:createTimesBtn()
end

function WeekendAdventureLayer.getLeftTimes(arg_33_0)
	level_manager:getAdventureDailytimeByModeType(2, function(arg_34_0, arg_34_1)
		if not var_0_21 then
			return
		end

		arg_33_0.label_times:setString(arg_34_1)
	end)
end

function WeekendAdventureLayer.sortByOrder(arg_35_0, arg_35_1)
	if arg_35_1 and #arg_35_1 > 1 then
		table.sort(arg_35_1, function(arg_36_0, arg_36_1)
			return arg_36_0.order < arg_36_1.order
		end)
	end
end

function WeekendAdventureLayer.showBossInfo(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = {
		fight_type = "ADVENTURE",
		level = 1,
		mode = arg_37_1,
		chapter = arg_37_2,
		callback = arg_37_3
	}

	var_37_0.initindex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)

	LayerManager:pushInLayer("LevelDetailLayer", var_37_0)
end

function WeekendAdventureLayer.canChange(arg_38_0, arg_38_1, arg_38_2)
	return true
end

function WeekendAdventureLayer.updateNewAlertStatus(arg_39_0, arg_39_1, arg_39_2)
	return
end

function WeekendAdventureLayer.getResidueTime(arg_40_0, arg_40_1)
	if not arg_40_1 then
		return "-1"
	end

	local var_40_5 = global_get_time_by_date(arg_40_1) - playermodel.onlineTime
	local var_40_6 = math.floor(var_40_5 / 24 / 3600)
	local var_40_7 = math.floor((var_40_5 - var_40_6 * 24 * 3600) / 3600)
	local var_40_8 = math.floor((var_40_5 - var_40_6 * 24 * 3600 - var_40_7 * 3600) / 60)

	return var_40_6 ~= 0 and string.format(L_TIME_TEXT[1], var_40_6, var_40_7) or var_40_7 ~= 0 and string.format(L_TIME_TEXT[2], var_40_7, var_40_8) or string.format(L_TIME_TEXT[3], var_40_8)
end

function WeekendAdventureLayer.shopPop(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_1 = {
		function()
			return playermodel.gold
		end,
		[0] = function()
			return item_manager:getItemNumber(CURRENCY_DIAMOND)
		end,
		function()
			return playermodel.honor
		end,
		function()
			return playermodel.explorecoin
		end,
		[100] = function()
			return 0
		end
	}

	setmetatable(var_41_1, {
		__index = function(arg_47_0, arg_47_1)
			return function()
				return item_manager:getItemNumber(arg_47_1)
			end
		end
	})

	local var_41_2 = {
		"public/currency/UI_battleEnd_gold.png",
		[0] = "public/currency/UI_battleEnd_diamond.png",
		"public/currency/arenascene_dot_1.png",
		"public/currency/explorecoin.png",
		[1500001] = "public/currency/1500001_1.png",
		[100] = "public/currency/rmb_white.png"
	}

	setmetatable(var_41_2, {
		__index = function(arg_49_0, arg_49_1)
			return "public/currency/" .. item_data[arg_49_1].image_id .. ".png"
		end
	})

	local var_41_3 = {
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "HandOfMidasLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_GOLD
			})
		end,
		[0] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end
	}

	setmetatable(var_41_3, {
		__index = function(arg_54_0, arg_54_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_54_1].name))
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	local var_41_4 = {}

	local function var_41_5(arg_56_0)
		local var_56_0 = var_41_4

		if arg_56_0.result == 1 and not arg_56_0.selectCoupon then
			shop_manager:shop_buy(var_41_4.shoptype, var_41_4.shopitem.shopid, function(arg_57_0)
				if arg_57_0 == 1 then
					arg_41_1.have_bought = arg_41_1.have_bought + var_56_0.curbuyTime
					arg_41_1.sell_out = arg_41_1.buy_limit and arg_41_1.buy_limit <= arg_41_1.have_bought

					local var_57_0

					var_57_0 = (var_56_0.shopitem.bag_item_type == kITEM_SKIN or var_56_0.shopitem.bag_item_type == kITEM_SKIN_GIFT) and item_data[var_56_0.shopitem.itemid].model or var_57_0

					if item_data[var_56_0.itemid].bag_item_type == kITEM_SKIN then
						require("view.Layer.GetRoleAnimationLayer")
						cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_56_0.itemid), 1000)
					end

					if var_56_0.callback then
						var_56_0.callback()
					end
				elseif arg_57_0 == 2 then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_57_0 == 3 then
					var_41_3[var_56_0.shopitem.currency]()
				end
			end, var_41_4.curbuyTime, function()
				LayerManager:removePopLayer()
			end)
		end
	end

	local function var_41_6(arg_59_0)
		if not arg_59_0.currency2 or discount_manager:getLastPriceByItem(arg_59_0.itemid, arg_59_0.currency2, arg_59_0.discount2) < arg_59_0.discount2 then
			return true
		end

		return false
	end

	local function var_41_7(arg_66_0)
		local var_66_0 = {}

		if arg_66_0.currency2 then
			var_66_0.currency2 = arg_66_0.currency2
			var_66_0.costIcon2 = var_41_2[arg_66_0.currency2]
			var_66_0.cost2 = arg_66_0.discount2 or arg_66_0.price2
			var_66_0.cost_old2 = arg_66_0.price2
			var_66_0.discount2 = arg_66_0.discount2
		end

		var_66_0.name = item_data[arg_66_0.itemtype].name
		var_66_0.itemid = arg_66_0.itemtype
		var_66_0.shopid = arg_66_0.shopid
		var_66_0.costIcon = var_41_2[arg_66_0.currency]
		var_66_0.currency = arg_66_0.currency
		var_66_0.isnewitem = arg_66_0.isnewitem
		var_66_0.discountfinish = arg_66_0.discountfinish
		var_66_0.cost = arg_66_0.discount or arg_66_0.price
		var_66_0.quality = item_data[arg_66_0.itemtype].equip_quality or 1
		var_66_0.cost_old = arg_66_0.price
		var_66_0.bag_item_type = item_data[arg_66_0.itemtype].bag_item_type
		var_66_0.item_attr = arg_66_0.item_attr
		var_66_0.finish_time = arg_66_0.finish_time
		var_66_0.discount = arg_66_0.discount
		var_66_0.buy_limit = arg_66_0.buy_limit or 1000000
		var_66_0.have_bought = arg_66_0.have_bought or 0
		var_66_0.sell_out = arg_66_0.buy_limit and arg_66_0.buy_limit <= arg_66_0.have_bought
		var_66_0.tag = arg_66_0.tag or 0
		var_66_0.pos = arg_66_0.pos
		var_66_0.purchaseid = arg_66_0.productid

		return var_66_0
	end

	if arg_41_1.currency == 100 then
		(function(arg_62_0)
			local var_62_0 = {
				itemid = arg_62_0.itemid,
				item_attr = arg_62_0.item_attr
			}
			local var_62_1 = {
				costtype = arg_62_0.costIcon
			}

			var_62_1.costnum = arg_62_0.discount or arg_62_0.cost
			var_62_0.slidecost = var_62_1

			function var_62_0:ShopSliderCallback(arg_63_1, arg_63_2)
				if arg_63_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_62_0.have_bought >= arg_62_0.buy_limit then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end

				self:setTouchEnabled(false)
				shop_manager:shop_purchase(arg_62_0.shopid, arg_62_0.purchaseid, function(arg_64_0)
					if arg_64_0 == 1 then
						arg_41_1.have_bought = arg_41_1.have_bought + curbuyTime
						arg_41_1.sell_out = arg_41_1.buy_limit and arg_41_1.buy_limit <= arg_41_1.have_bought

						if arg_62_0.bag_item_type == kITEM_SKIN or arg_62_0.bag_item_type == kITEM_SKIN_GIFT then
							arg_41_0.dressPanel:getChildByName("ScrollView"):getChildByName(item_data[arg_62_0.itemid].model):setOpacity(255)
							arg_41_0.roleBnt:setTalkEnabled(true)
						else
							arg_41_0.giftPanel:getChildByName("ScrollView"):removeAllChildren()

							arg_41_0.giftPanel.selectOrder = nil

							arg_41_0:initGiftList()
						end

						LayerManager:removePopLayer(arg_41_0.__queueindex)

						if item_data[var_62_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_62_0.itemid), 1000)
						end

						if arg_41_2 == 6 then
							for iter_64_0, iter_64_1 in pairs({
								{
									entityid = var_62_0.itemid
								}
							}) do
								network:rpc("use_gift_bag", {
									num = 1,
									entityid = iter_64_1.entityid
								}, function(arg_65_0)
									if arg_65_0.result == 1 then
										global_gain(arg_65_0)
										item_manager:deleteItem(iter_64_1.entityid, 1)
									else
										global_ShowBlockWords(L_MARKET_MSG.Gift_Bag_Lack)
									end
								end)
							end
						else
							LayerManager:pushInLayer("PopPurchaseResultLayer", {
								items = {
									{
										dropNum = 1,
										dropid = var_62_0.itemid,
										entityid = var_62_0.itemid
									}
								}
							})
						end
					elseif arg_64_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Goods_Sended)
						audio_manager:playeffectMusicTest("sound/invalid")
					end

					if arg_63_2 then
						arg_63_2(arg_64_0)
					end
				end)
			end

			if arg_41_2 == 4 or arg_41_2 == 6 then
				arg_41_0:showBuyPop(var_62_0)
			end

			arg_62_0.isnewitem = false
		end)(var_41_7(arg_41_1))
	else
		(function(arg_60_0, arg_60_1)
			local var_60_0 = {
				itemid = arg_60_0.itemid,
				item_attr = arg_60_0.item_attr
			}

			var_60_0.limitNum = arg_60_0.buy_limit and (arg_60_0.buy_limit - arg_60_0.have_bought >= SHOP_NORMAL_BUY_LIMIT_NUM and SHOP_NORMAL_BUY_LIMIT_NUM or arg_60_0.buy_limit - arg_60_0.have_bought) or SHOP_NORMAL_BUY_LIMIT_NUM

			if var_41_6(arg_60_0) then
				local var_60_2 = math.floor(var_41_1[arg_60_0.currency]() / arg_60_0.cost)

				var_60_0.currency = arg_60_0.currency
			else
				local var_60_3 = math.floor(var_41_1[arg_60_0.currency2]() / arg_60_0.cost2)

				var_60_0.currency = arg_60_0.currency2
			end

			local var_60_4 = arg_41_0:getResidueTime(arg_60_0.finish_time)

			if var_60_4 ~= "-1" then
				var_60_0.limit_time = L_MARKET_MSG.Rest_Time .. var_60_4
			end

			var_60_0.slidecost = {}

			if var_41_6(arg_60_0) then
				var_60_0.slidecost.costtype = arg_60_0.costIcon
				var_60_0.slidecost.costnum = arg_60_0.discount or arg_60_0.cost
				var_60_0.slidecost.nowHave = var_41_1[arg_60_0.currency]()
			else
				var_60_0.slidecost.costtype = arg_60_0.costIcon2
				var_60_0.slidecost.costnum = arg_60_0.discount2 or arg_60_0.cost2
				var_60_0.slidecost.nowHave = var_41_1[arg_60_0.currency2]()
			end

			function var_60_0:ShopSliderCallback(arg_61_1, arg_61_2, arg_61_3)
				if arg_61_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not self:isBright() then
					return
				end

				local var_61_0 = self.nowNum or 1

				var_41_4 = {
					curbuyTime = var_61_0,
					shoptype = arg_41_2,
					itemid = var_60_0.itemid,
					callback = arg_61_2,
					shopitem = arg_60_0
				}

				if var_41_6(arg_60_0) and arg_60_0.cost > var_41_1[arg_60_0.currency]() then
					LayerManager:removePopLayer()
					var_41_3[arg_60_0.currency]()

					return
				end

				self:setTouchEnabled(false)
				var_41_5({
					result = 1,
					selectCoupon = arg_61_3
				})

				if arg_60_1 then
					arg_60_1()
				end
			end

			var_60_0.hideGainButton = true

			if arg_60_0.have_bought and arg_60_0.buy_limit then
				var_60_0.limit_buy_num = arg_60_0.buy_limit - arg_60_0.have_bought
				var_60_0.have_bought_num = arg_60_0.have_bought
			end

			local var_60_5 = discount_manager:getCanUseCoupin(var_60_0.itemid, var_60_0.currency, var_60_0.costnum or var_60_0.slidecost.costnum, arg_41_2, arg_41_2)

			if var_60_5 and next(var_60_5) then
				var_60_0.couponList = var_60_5
			end

			arg_41_0:showBuyPop(var_60_0)

			arg_60_0.isnewitem = false
		end)(var_41_7(arg_41_1), arg_41_3)
	end
end

function WeekendAdventureLayer.showBuyPop(arg_67_0, arg_67_1)
	LayerManager:pushInLayer("PopGoodsLayer", arg_67_1)
end

function WeekendAdventureLayer.createTimeString(arg_68_0, arg_68_1)
	return
end

function WeekendAdventureLayer.checkIsVaild(arg_69_0, arg_69_1)
	return
end

function WeekendAdventureLayer.checkTimeIsOverVaild(arg_70_0, arg_70_1)
	return
end

function WeekendAdventureLayer.dealString(arg_71_0, arg_71_1)
	return
end

function WeekendAdventureLayer:fullScreen(arg_72_1)
	arg_72_1:setContentSize((GameDisplay.getScreenSize()))
	arg_72_1:setPositionY(arg_72_1:getPositionY() - GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end

function WeekendAdventureLayer.updateWeekedTimes(arg_73_0, arg_73_1, arg_73_2)
	local var_73_0 = 3

	if arg_73_1:getChildByName("wzcbl") then
		arg_73_1:getChildByName("wzcbl"):removeFromParent()
	end

	local var_73_1 = cc.Label:createWithTTF("", "fonts/number.ttf", 23)

	var_73_1:setAnchorPoint(cc.p(0, 0))
	var_73_1:setName("wzcbl")
	var_73_1:setColor(var_0_19)
	arg_73_1:addChild(var_73_1)

	for iter_73_0, iter_73_1 in pairs(levelmode_data) do
		if iter_73_1.modetype == arg_73_2 then
			var_73_0 = iter_73_1.dailytimes
		end
	end

	level_manager:getAdventureDailytimeByModeType(arg_73_2, function(arg_74_0, arg_74_1)
		if var_0_21 and arg_74_0 == 1 then
			if arg_74_1 then
				arg_73_1:getChildByName("wzcbl"):setString(string.format(L_QUICK_FIGHT.more, arg_74_1, var_73_0))
				arg_73_1:getChildByName("wzcbl"):setPosition(cc.p(5, 2))
			else
				arg_73_1:getChildByName("wzcbl"):setString("")
			end
		end
	end)
end
