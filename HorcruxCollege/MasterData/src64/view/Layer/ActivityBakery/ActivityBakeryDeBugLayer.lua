local var_0_0 = config._DEBUG and 0 or 1
local bakeryDebugData = require("data.bakeryDebugData")
local activity_bakery_conf = require("data.activity_bakery_conf")
local activity_bakery_level_conf = require("data.activity_bakery_level_conf")
local activity_bakery_device_data = require("data.activity_bakery_device_data")
local network = require("network.network")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local var_0_8 = {
	activity_get_bakery_cur_data = function(arg_1_0, arg_1_1, arg_1_2)
		return bakeryDebugData
	end,
	activity_get_bakery_level_conf = function(arg_2_0, arg_2_1, arg_2_2)
		return activity_bakery_level_conf[arg_2_1 * 100 + bakeryDebugData.level]
	end,
	activity_get_bakery_conf = function(arg_3_0, arg_3_1, arg_3_2)
		return activity_bakery_conf[arg_3_1]
	end,
	get_activity_bakery_data = function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_2 then
			arg_4_2(bakeryDebugData)
		end
	end
}
local bakery_gamelogic_manager = require("controller.bakery_gamelogic_manager")
local var_0_10 = require("controller.item_manager")
local var_0_11 = 1
local var_0_12 = 2
local var_0_13 = 3

ActivityBakeryDeBugLayer = class("ActivityBakeryDeBugLayer", function()
	return ccui.Layout:create()
end)

function ActivityBakeryDeBugLayer.create(arg_7_0, arg_7_1)
	local var_7_0 = ActivityBakeryDeBugLayer.new()

	var_7_0:init(arg_7_1)

	return var_7_0
end

function ActivityBakeryDeBugLayer:init(arg_8_1)
	global_ShowBlockWords("该场景仅支持策划配置关卡数值\n不能作为功能测试\n数值配置值在data.bakeryDebugData中", nil, nil, 8)

	self.resPath = "ActivityBakeryLayer/"
	self.activityId = arg_8_1.activityId

	bakery_gamelogic_manager:initData()
	bakery_gamelogic_manager:registerUIRef(self)
	self:initUI()

	self.confdata = var_0_8:activity_get_bakery_conf(self.activityId), self.level_bg:setVisible(false)

	self:updateItemNum()
	var_0_8:get_activity_bakery_data(self.activityId, function(arg_9_0)
		self.gold_label:setString(arg_9_0.gold)
		self:initLevelInfoUI(arg_9_0, var_0_8:activity_get_bakery_level_conf(self.activityId).dropid)
		self:registerGameUIEvent()
		self:updateLevelInitGameUI()
	end)
	self:registerScriptHandler(function(arg_10_0)
		if arg_10_0 == "exit" then
			bakery_gamelogic_manager:exitGame()
		end
	end)
	self.btn_start:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_11_0:isBright() then
			return
		end

		self.levelinfo_bg:setVisible(false)
		self.level_bg:setVisible(true)
		self.level_label_1:setString(string.format("第%d关", var_0_8:activity_get_bakery_cur_data(self.activityId).level))
		bakery_gamelogic_manager:initData()
		bakery_gamelogic_manager:registerUIRef(self)
		self:registerGameUIEvent()
		self:addGameTouchListener()
		self:updateLevelInitGameUI()
		bakery_gamelogic_manager:createMainLoop()
		self:updateItemNum()
		arg_11_0:setBright(false)
	end)

	local var_8_0 = ccui.Button:create("public/button/public_button_red.png", nil, "public/button/public_button_red.png", var_0_0)
	local var_8_1 = cc.Label:createWithTTF("重新加载数据", FONT_NAME, 22)

	var_8_1:setPosition(cc.p(var_8_0:getContentSize().width / 2, var_8_0:getContentSize().height / 2))
	var_8_0:addChild(var_8_1)
	var_8_0:setPosition(cc.p(320, 1200))
	self.bg:addChild(var_8_0, 99)
	var_8_0:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		package.loaded["data.bakeryDebugData"] = nil
		bakeryDebugData = require("data.bakeryDebugData")

		bakery_gamelogic_manager:unloop()
		bakery_gamelogic_manager:initData()
		bakery_gamelogic_manager:registerUIRef(self)
		self.level_bg:setVisible(false)

		self.confdata = var_0_8:activity_get_bakery_conf(self.activityId)

		self:updateItemNum()
		self.levelinfo_bg:setVisible(true)
		var_0_8:get_activity_bakery_data(self.activityId, function(arg_13_0)
			self.gold_label:setString(arg_13_0.gold)
			self:initLevelInfoUI(arg_13_0, var_0_8:activity_get_bakery_level_conf(self.activityId).dropid)
			self:registerGameUIEvent()
			self:updateLevelInitGameUI()
		end)
	end)
end

function ActivityBakeryDeBugLayer:initUI()
	self.bg = ccui.ImageView:create("mainScenebg/ActivityBakeryLayerBG.png")

	self.bg:setAnchorPoint(0, 0)
	self.bg:setPosition(0, -60 - GameDisplay.fix_y)
	self:addChild(self.bg)
	self:initLevelInfoUI()
	self:initOrderUI()
	self:initCakeUI()
	self:initMikeTeaUI()
	self:initTaroballsUI()
	self:initBottomUI()
end

function ActivityBakeryDeBugLayer:initLevelInfoUI(arg_15_1, arg_15_2)
	if not self.levelinfo_bg then
		local var_15_0 = ccui.ImageView:create(self.resPath .. "levelInfo_bg.png", var_0_0)

		self.bg:addChild(var_15_0, 3)
		var_15_0:setPosition(320, 1050 + GameDisplay.fix_y)

		self.levelinfo_bg = var_15_0

		local var_15_1 = cc.Label:createWithTTF("第5关", FONT_TITLE, 44)

		var_15_0:addChild(var_15_1)
		var_15_1:setPosition(255, 260)
		var_15_1:setColor(cc.c3b(250, 216, 141))

		self.level_label = var_15_1

		local var_15_2 = cc.Label:createWithTTF("目标: 获得金币10000", FONT_TITLE, 27)

		var_15_0:addChild(var_15_2)
		var_15_2:setPosition(255, 210)
		var_15_2:setColor(cc.c3b(250, 216, 141))

		self.target_label = var_15_2

		local var_15_3 = ccui.Button:create(self.resPath .. "btn_start.png", nil, self.resPath .. "btn_start.png", var_0_0)

		var_15_0:addChild(var_15_3)
		var_15_3:setPosition(255, 140)

		self.btn_start = var_15_3

		local var_15_4 = cc.Label:createWithTTF("完成奖励", FONT_NAME, 22)

		var_15_0:addChild(var_15_4)
		var_15_4:setPosition(110, 60)
		var_15_4:setColor(cc.c3b(250, 216, 141))

		self.dropListView = ccui.ListView:create()

		self.dropListView:setDirection(ccui.ListViewDirection.horizontal)
		self.dropListView:setItemsMargin(20)
		self.dropListView:setAnchorPoint(cc.p(0, 0))
		self.dropListView:setPosition(155, 10)
		self.dropListView:setContentSize(cc.size(320, 100))
		var_15_0:addChild(self.dropListView)
	end

	if arg_15_1 and arg_15_1.target_gold then
		self.target_label:setString("目标: 获得金币" .. arg_15_1.target_gold)
	end

	if arg_15_1 and arg_15_1.level then
		self.level_label:setString(string.format("第%d关", arg_15_1.level))
	end

	if arg_15_2 then
		self.dropListView:removeAllChildren()

		for iter_15_0, iter_15_1 in pairs(require("controller.drop_manager"):getDropMsg(arg_15_2).equips) do
			local var_15_5 = ccui.Layout:create()

			var_15_5:setContentSize(cc.size(60, 80))

			local var_15_6 = ccui.ImageView:create(self.resPath .. "item_bg.png", var_0_0)

			var_15_6:setPosition(cc.p(50, 40))

			local var_15_7, var_15_8 = create_item_icon(nil, true, iter_15_1.dropid, iter_15_1.dropNum, iter_15_1.item_attr)

			var_15_7:setPosition(30, 40)
			var_15_7:setScale(var_15_7:getScale() * 0.4)
			var_15_6:addChild(var_15_7)
			var_15_5:addChild(var_15_6)

			local var_15_9 = ccui.ImageView:create(self.resPath .. "label_bg.png", var_0_0)

			var_15_9:setAnchorPoint(0, 0)
			var_15_6:addChild(var_15_9)

			local var_15_10 = cc.Label:createWithTTF("x" .. var_15_8, FONT_DES, 15)

			var_15_10:setPosition(34, 10)
			var_15_9:addChild(var_15_10)
			self.dropListView:pushBackCustomItem(var_15_5)
		end
	end
end

function ActivityBakeryDeBugLayer:initOrderUI()
	local var_16_0 = ccui.ImageView:create(self.resPath .. "gold_bg.png", var_0_0)

	self.bg:addChild(var_16_0, 5)
	var_16_0:setAnchorPoint(0, 0)
	var_16_0:setPosition(300, 1140 + GameDisplay.fix_y)

	self.keyitem_label = cc.Label:createWithTTF("10/10", FONT_NAME, 27)

	self.keyitem_label:setAnchorPoint(0, 0)
	self.keyitem_label:setPosition(80, 32)
	var_16_0:addChild(self.keyitem_label)

	self.gold_label = cc.Label:createWithTTF("99999", FONT_NAME, 27)

	self.gold_label:setAnchorPoint(0, 0)
	self.gold_label:setPosition(240, 32)
	var_16_0:addChild(self.gold_label)

	self.orderLayout = ccui.Layout:create()

	self.bg:addChild(self.orderLayout)
	self.orderLayout:setPosition(0, 920 + GameDisplay.fix_y)

	local var_16_1 = ccui.ImageView:create(self.resPath .. "level_bg.png", var_0_0)

	self.bg:addChild(var_16_1, 5)
	var_16_1:setAnchorPoint(0, 0)
	var_16_1:setPosition(0, 1120 + GameDisplay.fix_y)

	self.level_bg = var_16_1
	self.level_label_1 = cc.Label:createWithTTF("第100关", FONT_TITLE, 30)

	self.level_label_1:setAnchorPoint(0, 0)
	self.level_label_1:setPosition(10, 60)
	var_16_1:addChild(self.level_label_1)

	local var_16_2 = cc.Label:createWithTTF("剩余时间", FONT_NAME, 22)

	var_16_2:setAnchorPoint(0, 0)
	var_16_2:setPosition(10, 30)
	var_16_1:addChild(var_16_2)

	self.time_label = cc.Label:createWithTTF("02:59", FONT_NAME, 22)

	self.time_label:setAnchorPoint(0, 0)
	self.time_label:setPosition(120, 30)
	var_16_1:addChild(self.time_label)

	self.orders = {}

	for iter_16_0, iter_16_1 in ipairs({
		cc.p(100, 30),
		cc.p(320, 30),
		cc.p(540, 30)
	}) do
		local var_16_3 = ccui.ImageView:create(self.resPath .. "order_bg.png", var_0_0)

		self.orderLayout:addChild(var_16_3)
		var_16_3:setPosition(iter_16_1)
		table.insert(self.orders, var_16_3)
		var_16_3:setVisible(false)

		local var_16_4 = ccui.ImageView:create(self.resPath .. "emoji_bg.png", var_0_0)

		var_16_3:addChild(var_16_4)
		var_16_4:setPosition(96, 245)

		local var_16_5 = ccui.ImageView:create(self.resPath .. "emoji_happy.png", var_0_0)

		var_16_4:addChild(var_16_5)
		var_16_5:setPosition(var_16_4:getContentSize().width / 2, var_16_4:getContentSize().height / 2)

		var_16_3.emoji = var_16_5

		local var_16_6 = ccui.Slider:create()

		var_16_6:loadBarTexture(self.resPath .. "progress_bg.png", var_0_0)
		var_16_6:loadProgressBarTexture(self.resPath .. "progress_on_1.png", var_0_0)
		var_16_6:setPosition(96, 200)
		var_16_6:setPercent(50)
		var_16_3:addChild(var_16_6)

		var_16_3.progressBar = var_16_6
		var_16_3.products = {}

		for iter_16_2, iter_16_3 in ipairs({
			cc.p(60, 150),
			cc.p(135, 150),
			cc.p(60, 80),
			cc.p(135, 80)
		}) do
			local var_16_7 = ccui.ImageView:create(self.resPath .. "product_bg.png", var_0_0)

			var_16_7:setPosition(iter_16_3)
			var_16_3:addChild(var_16_7)
			table.insert(var_16_3.products, var_16_7)

			var_16_7.cake = ccui.ImageView:create(self.resPath .. "cake.png", var_0_0)

			var_16_7:addChild(var_16_7.cake)

			local var_16_8 = ccui.ImageView:create(self.resPath .. "cake_cream_1.png", var_0_0)

			var_16_8:setName("cream")
			var_16_8:setAnchorPoint(0, 0)
			var_16_7.cake:addChild(var_16_8, 2)

			local var_16_9 = ccui.ImageView:create(self.resPath .. "cake_fruit_1.png", var_0_0)

			var_16_9:setName("fruit")
			var_16_9:setAnchorPoint(0, 0)
			var_16_7.cake:addChild(var_16_9, 3)
			var_16_7.cake:setPosition(var_16_7:getContentSize().width / 2, var_16_7:getContentSize().height / 2)
			var_16_7.cake:setScale(0.4)
			var_16_7.cake:setVisible(false)

			var_16_7.milktea = ccui.ImageView:create(self.resPath .. "milktea_pearl0.png", var_0_0)

			var_16_7:addChild(var_16_7.milktea)
			var_16_7.milktea:setPosition(var_16_7:getContentSize().width / 2, var_16_7:getContentSize().height / 2)
			var_16_7.milktea:setScale(0.5)
			var_16_7.milktea:setVisible(false)

			local var_16_10 = ccui.ImageView:create(self.resPath .. "taroball_excipient1.png", var_0_0)

			var_16_10:setName("excipient1")
			var_16_10:setAnchorPoint(0, 0)

			local var_16_11 = ccui.ImageView:create(self.resPath .. "taroball_excipient2.png", var_0_0)

			var_16_11:setName("excipient2")
			var_16_11:setAnchorPoint(0, 0)

			var_16_7.taroball = ccui.ImageView:create(self.resPath .. "taroball_base.png", var_0_0)

			var_16_7:addChild(var_16_7.taroball)
			var_16_7.taroball:addChild(var_16_10)
			var_16_7.taroball:addChild(var_16_11)
			var_16_7.taroball:setPosition(var_16_7:getContentSize().width / 2, var_16_7:getContentSize().height / 2)
			var_16_7.taroball:setScale(0.5)
			var_16_7.taroball:setVisible(false)
		end

		function var_16_3:update()
			if not self or not next(self) then
				return
			end

			local var_17_0 = 1
			local var_17_1 = {}

			while self["product_" .. var_17_0] do
				if not self["product_" .. var_17_0].isfinished then
					table.insert(var_17_1, self["product_" .. var_17_0])
				end

				var_17_0 = var_17_0 + 1
			end

			for iter_17_0, iter_17_1 in ipairs(var_16_3.products) do
				if var_17_1[iter_17_0] then
					iter_17_1:setVisible(true)
					iter_17_1.cake:setVisible(var_17_1[iter_17_0].cake and true or false)
					iter_17_1.milktea:setVisible(var_17_1[iter_17_0].pearl and true or false)
					iter_17_1.taroball:setVisible(var_17_1[iter_17_0].excipient1 and true or false)

					local var_17_2 = iter_17_1.cake:getChildByName("fruit")
					local var_17_3 = iter_17_1.cake:getChildByName("cream")
					local var_17_4 = iter_17_1.taroball:getChildByName("excipient1")
					local var_17_5 = iter_17_1.taroball:getChildByName("excipient2")

					var_17_2:setVisible(false)
					var_17_3:setVisible(false)
					var_17_5:setVisible(false)
					var_17_5:setVisible(false)

					if var_17_1[iter_17_0].fruit and var_17_1[iter_17_0].fruit ~= 0 then
						var_17_2:setVisible(true)
						var_17_2:loadTexture(self.resPath .. "cake_fruit_" .. var_17_1[iter_17_0].fruit .. ".png", var_0_0)
					end

					if var_17_1[iter_17_0].cream and var_17_1[iter_17_0].cream ~= 0 then
						var_17_3:setVisible(true)
						var_17_3:loadTexture(self.resPath .. "cake_cream_" .. var_17_1[iter_17_0].cream .. ".png", var_0_0)
					end

					if var_17_1[iter_17_0].pearl then
						iter_17_1.milktea:loadTexture(self.resPath .. "milktea_pearl" .. var_17_1[iter_17_0].pearl .. ".png", var_0_0)
					end

					if var_17_1[iter_17_0].excipient1 then
						var_17_4:setVisible(var_17_1[iter_17_0].excipient1 == 1)
						var_17_5:setVisible(var_17_1[iter_17_0].excipient2 == 1)
					end
				else
					iter_17_1:setVisible(false)
				end
			end
		end

		var_16_3.ani_success = sp.SkeletonAnimation:create("spine/bakery/order_success.json", "spine/bakery/order_success.atlas", 1)

		self.orderLayout:addChild(var_16_3.ani_success, 2)
		var_16_3.ani_success:setPosition(iter_16_1.x, iter_16_1.y - 120)
		var_16_3.ani_success:setVisible(false)

		var_16_3.ani_fail = sp.SkeletonAnimation:create("spine/bakery/order_fail.json", "spine/bakery/order_fail.atlas", 1)

		self.orderLayout:addChild(var_16_3.ani_fail, 2)
		var_16_3.ani_fail:setPosition(iter_16_1)
		var_16_3.ani_fail:setScale(3)
		var_16_3.ani_fail:setVisible(false)
	end
end

function ActivityBakeryDeBugLayer:initCakeUI()
	self.ovens = {}

	for iter_18_0, iter_18_1 in ipairs({
		cc.p(20, 750),
		cc.p(20, 580),
		cc.p(460, 650)
	}) do
		local var_18_0 = ccui.ImageView:create(self.resPath .. "oven_off.png", var_0_0)

		var_18_0:setPosition(iter_18_1)
		self.bg:addChild(var_18_0, 2)
		var_18_0:setVisible(false)
		table.insert(self.ovens, var_18_0)

		local var_18_1 = ccui.Slider:create()

		var_18_1:loadBarTexture(self.resPath .. "progress_bg_s.png", var_0_0)
		var_18_1:loadProgressBarTexture(self.resPath .. "progress_on_s.png", var_0_0)
		var_18_1:setPosition(160, 160)
		var_18_1:setPercent(50)
		var_18_0:addChild(var_18_1, 2)
		var_18_1:setName("progress")
		var_18_1:setVisible(false)

		var_18_0.ani_on = sp.SkeletonAnimation:create("spine/bakery/oven_on.json", "spine/bakery/oven_on.atlas", 1)

		var_18_0:addChild(var_18_0.ani_on, 1)
		var_18_0.ani_on:setPosition(var_18_0:getContentSize().width / 2, var_18_0:getContentSize().height / 2)
		var_18_0.ani_on:setVisible(false)

		var_18_0.ani_fail = sp.SkeletonAnimation:create("spine/bakery/oven_fail.json", "spine/bakery/oven_fail.atlas", 1)

		var_18_0:addChild(var_18_0.ani_fail, 1)
		var_18_0.ani_fail:setPosition(var_18_0:getContentSize().width / 2, var_18_0:getContentSize().height / 2)
		var_18_0.ani_fail:setVisible(false)

		if iter_18_0 == 1 then
			var_18_0:setVisible(true)
		end
	end

	self.trays = {}

	for iter_18_2, iter_18_3 in ipairs({
		cc.p(265, 640),
		cc.p(265, 560),
		cc.p(260, 400)
	}) do
		local var_18_2 = ccui.ImageView:create(self.resPath .. "tray.png", var_0_0)

		var_18_2:setPosition(iter_18_3)
		self.bg:addChild(var_18_2)
		table.insert(self.trays, var_18_2)
		var_18_2:setVisible(false)

		function var_18_2:update()
			if not self or not next(self) then
				var_18_2:loadTexture(self.resPath .. "tray.png", var_0_0)

				for iter_19_0, iter_19_1 in pairs(var_18_2:getChildren()) do
					iter_19_1:setVisible(false)
				end
			else
				var_18_2:loadTexture(self.resPath .. "cake.png", var_0_0)

				local var_19_0 = var_18_2:getChildByName("fruit")
				local var_19_1 = var_18_2:getChildByName("cream")

				if not var_19_0 then
					var_19_0 = ccui.ImageView:create(self.resPath .. "cake_fruit_1.png", var_0_0)

					var_19_0:setAnchorPoint(0, 0)
					var_19_0:setName("fruit")
					var_18_2:addChild(var_19_0, 3)
				end

				if not var_19_1 then
					var_19_1 = ccui.ImageView:create(self.resPath .. "cake_cream_1.png", var_0_0)

					var_19_1:setAnchorPoint(0, 0)
					var_19_1:setName("cream")
					var_18_2:addChild(var_19_1, 2)
				end

				var_19_0:setVisible(false)
				var_19_1:setVisible(false)

				if self.fruit and self.fruit ~= 0 then
					var_19_0:setVisible(true)
					var_19_0:loadTexture(self.resPath .. "cake_fruit_" .. self.fruit .. ".png", var_0_0)
				end

				if self.cream and self.cream ~= 0 then
					var_19_1:setVisible(true)
					var_19_1:loadTexture(self.resPath .. "cake_cream_" .. self.cream .. ".png", var_0_0)
				end
			end
		end
	end

	self.creams = {}

	for iter_18_4, iter_18_5 in ipairs({
		cc.p(40, 400),
		cc.p(80, 450),
		cc.p(135, 440)
	}) do
		local var_18_3 = ccui.Button:create(self.resPath .. "cream" .. iter_18_4 .. ".png", nil, self.resPath .. "cream" .. iter_18_4 .. ".png", var_0_0)

		var_18_3:setPosition(iter_18_5)
		self.bg:addChild(var_18_3)
		table.insert(self.creams, var_18_3)
	end

	self.fruitpools = {}

	for iter_18_6, iter_18_7 in ipairs({
		cc.p(80, 275),
		cc.p(180, 275),
		cc.p(280, 275)
	}) do
		local var_18_4 = ccui.Button:create(self.resPath .. "fruitpool.png", nil, self.resPath .. "fruitpool.png", var_0_0)

		var_18_4:setPosition(iter_18_7)
		self.bg:addChild(var_18_4)
		table.insert(self.fruitpools, var_18_4)

		function var_18_4.update(arg_20_0)
			if not arg_20_0 or arg_20_0 <= 0 then
				var_18_4:loadTextures(self.resPath .. "fruitpool.png", nil, self.resPath .. "fruitpool.png", var_0_0)
			else
				var_18_4:loadTextures(self.resPath .. "fruitpool_" .. iter_18_6 .. ".png", nil, self.resPath .. "fruitpool_" .. iter_18_6 .. ".png", var_0_0)
			end
		end
	end

	self.choppings = {}

	for iter_18_8, iter_18_9 in ipairs({
		cc.p(250, 430),
		cc.p(420, 430),
		cc.p(320, 600)
	}) do
		local var_18_5 = ccui.ImageView:create(self.resPath .. "chopping.png", var_0_0)

		var_18_5:setPosition(iter_18_9)
		self.bg:addChild(var_18_5)
		table.insert(self.choppings, var_18_5)
		var_18_5:setVisible(false)

		function var_18_5:update()
			if not self or not next(self) then
				for iter_21_0, iter_21_1 in pairs(var_18_5:getChildren()) do
					iter_21_1:setVisible(false)
				end

				var_18_5.ani:setVisible(false)
			else
				local var_21_0 = var_18_5:getChildByName("fruit")

				if not var_21_0 then
					var_21_0 = ccui.ImageView:create(self.resPath .. "chopping_fruit_1.png", var_0_0)

					var_21_0:setPosition(var_18_5:getContentSize().width / 2, var_18_5:getContentSize().height / 2)
					var_21_0:setName("fruit")
					var_18_5:addChild(var_21_0, 3)
				end

				var_21_0:setVisible(false)

				if self.fruit then
					var_21_0:setVisible(true)
					var_21_0:loadTexture(self.resPath .. "chopping_fruit_" .. self.fruit .. ".png", var_0_0)

					if not var_18_5.ani:isVisible() then
						var_18_5.ani:setVisible(true)
						var_18_5.ani:setAnimation(0, "knife_on", true)
					end
				else
					var_18_5.ani:setVisible(false)
				end
			end
		end

		local var_18_6 = ccui.Slider:create()

		var_18_6:loadBarTexture(self.resPath .. "progress_bg_s.png", var_0_0)
		var_18_6:loadProgressBarTexture(self.resPath .. "progress_on_s.png", var_0_0)
		var_18_6:setPosition(75, 115)
		var_18_6:setPercent(50)
		var_18_5:addChild(var_18_6)
		var_18_6:setName("progress")
		var_18_6:setVisible(false)

		var_18_5.ani = sp.SkeletonAnimation:create("spine/bakery/knife_on.json", "spine/bakery/knife_on.atlas", 1)

		self.bg:addChild(var_18_5.ani, 2)
		var_18_5.ani:setPosition(var_18_5:getPosition())
		var_18_5.ani:setVisible(false)
	end

	self.fruits = {}

	for iter_18_10, iter_18_11 in ipairs({
		cc.p(425, 275),
		cc.p(505, 275),
		cc.p(585, 275)
	}) do
		local var_18_7 = ccui.Button:create(self.resPath .. "fruit" .. iter_18_10 .. ".png", nil, self.resPath .. "fruit" .. iter_18_10 .. ".png", var_0_0)

		var_18_7:setPosition(iter_18_11)
		self.bg:addChild(var_18_7)
		table.insert(self.fruits, var_18_7)
	end
end

function ActivityBakeryDeBugLayer:initMikeTeaUI()
	self.milkteaMechine = ccui.ImageView:create(self.resPath .. "milkteaMechine_off.png", var_0_0)

	self.milkteaMechine:setPosition(185, 785)
	self.bg:addChild(self.milkteaMechine)

	local var_22_0 = ccui.ImageView:create(self.resPath .. "milktea_icon.png", nil, self.resPath .. "milktea_icon.png", var_0_0)

	self.milkteaMechine:addChild(var_22_0)
	var_22_0:setName("icon")
	var_22_0:setPosition(60, 50)
	var_22_0:setVisible(false)

	self.milkteas = {}

	for iter_22_0, iter_22_1 in ipairs({
		cc.p(335, 765),
		cc.p(400, 765),
		cc.p(465, 765),
		cc.p(260, 670),
		cc.p(320, 670),
		cc.p(380, 670)
	}) do
		local var_22_1 = ccui.Button:create(self.resPath .. "milktea.png", nil, self.resPath .. "milktea.png", var_0_0)

		var_22_1:setPosition(iter_22_1)
		var_22_1:setVisible(false)
		self.bg:addChild(var_22_1)
		table.insert(self.milkteas, var_22_1)

		function var_22_1:update()
			if not self or not next(self) then
				var_22_1:loadTextures(self.resPath .. "milktea.png", nil, self.resPath .. "milktea.png", var_0_0)
				var_22_1:setVisible(false)
			else
				var_22_1:loadTextures(self.resPath .. "milktea_pearl" .. self.pearl .. ".png", nil, self.resPath .. "milktea_pearl" .. self.pearl .. ".png", var_0_0)
				var_22_1:setVisible(true)
			end
		end
	end

	self.pearl = ccui.Button:create(self.resPath .. "pearl.png", nil, self.resPath .. "pearl.png", var_0_0)

	self.bg:addChild(self.pearl)
	self.pearl:setPosition(277, 750)

	self.milkteaMechine.ani = sp.SkeletonAnimation:create("spine/bakery/milktea_on.json", "spine/bakery/milktea_on.atlas", 1)

	self.bg:addChild(self.milkteaMechine.ani)
	self.milkteaMechine.ani:setPosition(self.milkteaMechine:getPositionX() - 10, self.milkteaMechine:getPositionY() - 55)
	self.milkteaMechine.ani:setVisible(false)
end

function ActivityBakeryDeBugLayer:initTaroballsUI()
	self.taroballsMechine = ccui.ImageView:create(self.resPath .. "taroballsMechine.png", var_0_0)

	self.taroballsMechine:setPosition(420, 600)
	self.bg:addChild(self.taroballsMechine)

	local var_24_0 = ccui.ImageView:create(self.resPath .. "taroballsMechine_icon.png", var_0_0)

	var_24_0:setVisible(false)
	self.taroballsMechine:addChild(var_24_0)
	var_24_0:setAnchorPoint(0, 0)
	var_24_0:setName("taroballsMechine_icon")

	self.taroballs = {}

	for iter_24_0, iter_24_1 in ipairs({
		cc.p(580, 570),
		cc.p(580, 490),
		cc.p(580, 410)
	}) do
		local var_24_1 = ccui.Button:create(self.resPath .. "taroball.png", nil, self.resPath .. "taroball.png", var_0_0)

		var_24_1:setPosition(iter_24_1)
		var_24_1:setVisible(false)
		self.bg:addChild(var_24_1)
		table.insert(self.taroballs, var_24_1)

		local var_24_2 = ccui.ImageView:create(self.resPath .. "taroball_excipient1.png", var_0_0)

		var_24_2:setVisible(false)
		var_24_1:addChild(var_24_2, 2)
		var_24_2:setAnchorPoint(0, 0)

		local var_24_3 = ccui.ImageView:create(self.resPath .. "taroball_excipient2.png", var_0_0)

		var_24_3:setVisible(false)
		var_24_1:addChild(var_24_3, 2)
		var_24_3:setAnchorPoint(0, 0)

		function var_24_1:update()
			if not self or not next(self) then
				var_24_1:loadTextures(self.resPath .. "taroball.png", nil, self.resPath .. "taroball.png", var_0_0)
				var_24_2:setVisible(false)
				var_24_3:setVisible(false)
			else
				var_24_1:loadTextures(self.resPath .. "taroball_base.png", nil, self.resPath .. "taroball_base.png", var_0_0)
				var_24_2:setVisible(self.excipient1 == 1)
				var_24_3:setVisible(self.excipient2 == 1)
			end
		end
	end

	local var_24_4 = ccui.ImageView:create(self.resPath .. "excipient_base.png", var_0_0)

	self.bg:addChild(var_24_4, 2)
	var_24_4:setPosition(550, 670)

	self.excipient_base = var_24_4
	self.excipients = {}

	for iter_24_2, iter_24_3 in ipairs({
		cc.p(0, 0),
		cc.p(0, 0)
	}) do
		local var_24_5 = ccui.ImageView:create(self.resPath .. "excipient" .. iter_24_2 .. ".png", var_0_0)

		var_24_4:addChild(var_24_5)
		var_24_5:setPosition(iter_24_3)
		var_24_5:setAnchorPoint(0, 0)
		table.insert(self.excipients, var_24_5)
	end

	self.taroballsMechine.ani = sp.SkeletonAnimation:create("spine/bakery/dessert_on.json", "spine/bakery/dessert_on.atlas", 1)

	self.bg:addChild(self.taroballsMechine.ani)
	self.taroballsMechine.ani:setPosition(self.taroballsMechine:getPositionX() - 4, self.taroballsMechine:getPositionY() - 20)
	self.taroballsMechine.ani:setVisible(false)
end

function ActivityBakeryDeBugLayer:initBottomUI()
	local var_26_0 = ccui.Button:create(self.resPath .. "btn_return.png", nil, self.resPath .. "btn_return.png", var_0_0)

	self.bg:addChild(var_26_0)
	var_26_0:setPosition(40, 150)
	var_26_0:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if bakery_gamelogic_manager.mainloop then
			LayerManager:pushInLayer("PopDoLayer", {
				surecallback = function()
					LayerManager:switchShowLayer("ActivityFightCollectionLayer", {
						activityId = self.activityId
					})
				end,
				labels = {
					titleImage = "title_warorder.png",
					des = "游戏中途退出无法获得任何奖励, 班长确定要退出吗?"
				}
			})
		else
			KeyCodeManager:onKeyReleasedCallFunc()
		end
	end)

	self.btn_return = var_26_0
end

function ActivityBakeryDeBugLayer:addGameTouchListener()
	for iter_29_0, iter_29_1 in ipairs(self.ovens) do
		iter_29_1:setTouchEnabled(true)
		iter_29_1:addTouchEventListener(function(arg_30_0, arg_30_1)
			if arg_30_1 ~= ccui.TouchEventType.ended then
				return
			end

			bakery_gamelogic_manager:addDough(iter_29_0)
		end)
	end

	for iter_29_2, iter_29_3 in ipairs(self.trays) do
		iter_29_3:setTouchEnabled(true)
		iter_29_3:addTouchEventListener(function(arg_31_0, arg_31_1)
			if arg_31_1 ~= ccui.TouchEventType.ended then
				return
			end

			bakery_gamelogic_manager:commitProduct(var_0_11, iter_29_2)

			if os.time() - (iter_29_3.lastTouchtime or 0) < 0.05 then
				bakery_gamelogic_manager:discardProduct(var_0_11, iter_29_2)

				iter_29_3.lastTouchtime = 0
			else
				iter_29_3.lastTouchtime = os.time()
			end
		end)
	end

	for iter_29_4, iter_29_5 in ipairs(self.creams) do
		iter_29_5:addTouchEventListener(function(arg_32_0, arg_32_1)
			if arg_32_1 ~= ccui.TouchEventType.ended then
				return
			end

			bakery_gamelogic_manager:addCream(iter_29_4)
		end)
	end

	for iter_29_6, iter_29_7 in ipairs(self.fruitpools) do
		iter_29_7:addTouchEventListener(function(arg_33_0, arg_33_1)
			if arg_33_1 ~= ccui.TouchEventType.ended then
				return
			end

			bakery_gamelogic_manager:addFruit(iter_29_6)
		end)
	end

	for iter_29_8, iter_29_9 in ipairs(self.fruits) do
		iter_29_9:addTouchEventListener(function(arg_34_0, arg_34_1)
			if arg_34_1 ~= ccui.TouchEventType.ended then
				return
			end

			bakery_gamelogic_manager:choppingFruit(iter_29_8)
		end)
	end

	self.milkteaMechine:setTouchEnabled(true)
	self.milkteaMechine:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		bakery_gamelogic_manager:milkteaMachineWorking()
	end)

	for iter_29_10, iter_29_11 in ipairs(self.milkteas) do
		iter_29_11:addTouchEventListener(function(arg_36_0, arg_36_1)
			if arg_36_1 ~= ccui.TouchEventType.ended then
				return
			end

			bakery_gamelogic_manager:commitProduct(var_0_12, iter_29_10)

			if os.time() - (iter_29_11.lastTouchtime or 0) < 0.05 then
				bakery_gamelogic_manager:discardProduct(var_0_12, iter_29_10)

				iter_29_11.lastTouchtime = 0
			else
				iter_29_11.lastTouchtime = os.time()
			end
		end)
	end

	self.pearl:addTouchEventListener(function(arg_37_0, arg_37_1)
		if arg_37_1 ~= ccui.TouchEventType.ended then
			return
		end

		bakery_gamelogic_manager:addPearls()
	end)
	self.taroballsMechine:setTouchEnabled(true)
	self.taroballsMechine:addTouchEventListener(function(arg_38_0, arg_38_1)
		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		bakery_gamelogic_manager:taroballsMachineWorking()
	end)

	for iter_29_12, iter_29_13 in ipairs(self.taroballs) do
		iter_29_13:addTouchEventListener(function(arg_39_0, arg_39_1)
			if arg_39_1 ~= ccui.TouchEventType.ended then
				return
			end

			bakery_gamelogic_manager:commitProduct(var_0_13, iter_29_12)

			if os.time() - (iter_29_13.lastTouchtime or 0) < 0.05 then
				bakery_gamelogic_manager:discardProduct(var_0_13, iter_29_12)

				iter_29_13.lastTouchtime = 0
			else
				iter_29_13.lastTouchtime = os.time()
			end
		end)
	end

	self.excipient_base:setTouchEnabled(true)
	self.excipient_base:addTouchEventListener(function(arg_40_0, arg_40_1)
		self.excipients[1]:setScale(1)
		self.excipients[2]:setScale(1)

		if arg_40_1 == ccui.TouchEventType.began then
			local var_40_0 = arg_40_0:getTouchBeganPosition().x
			local var_40_1 = arg_40_0:getTouchBeganPosition().y
			local var_40_2 = arg_40_0:convertToNodeSpace(cc.p(var_40_0, var_40_1)).y

			if arg_40_0:convertToNodeSpace(cc.p(var_40_0, var_40_1)).x < 93 then
				self.excipients[1]:setScale(1.05)
			else
				self.excipients[2]:setScale(1.05)
			end
		elseif arg_40_1 == ccui.TouchEventType.moved then
			local var_40_3 = arg_40_0:getTouchMovePosition().x
			local var_40_4 = arg_40_0:getTouchMovePosition().y
			local var_40_5 = arg_40_0:convertToNodeSpace(cc.p(var_40_3, var_40_4)).y

			if arg_40_0:convertToNodeSpace(cc.p(var_40_3, var_40_4)).x < 93 then
				self.excipients[1]:setScale(1.05)
			else
				self.excipients[2]:setScale(1.05)
			end
		elseif arg_40_1 == ccui.TouchEventType.ended then
			local var_40_6 = arg_40_0:getTouchEndPosition().x
			local var_40_7 = arg_40_0:getTouchEndPosition().y
			local var_40_8 = arg_40_0:convertToNodeSpace(cc.p(var_40_6, var_40_7)).y

			if arg_40_0:convertToNodeSpace(cc.p(var_40_6, var_40_7)).x < 93 then
				bakery_gamelogic_manager:addExcipients(1)
			else
				bakery_gamelogic_manager:addExcipients(2)
			end
		end
	end)
end

function ActivityBakeryDeBugLayer:registerGameUIEvent()
	bakery_gamelogic_manager:registerGameEvent("UPDATE_ORDERS", self, self.updateOrders)
	bakery_gamelogic_manager:registerGameEvent("UPDATE_CAKEMACHINE", self, self.updateCakeMechine)
	bakery_gamelogic_manager:registerGameEvent("UPDATE_MILKTEA", self, self.updateMikeTea)
	bakery_gamelogic_manager:registerGameEvent("UPDATE_TAROBALLS", self, self.updateTaroballs)
	bakery_gamelogic_manager:registerGameEvent("UPDATE_UIPROGRESS", self, self.updateUIProgress)
	bakery_gamelogic_manager:registerGameEvent("GAME_END", self, function(arg_42_0, arg_42_1)
		arg_42_0.levelinfo_bg:setVisible(true)
		global_ShowBlockWords("游戏结束,获得" .. arg_42_1.gold .. "金币")
	end)
	bakery_gamelogic_manager:registerGameEvent("PLAY_ORDER_FAIL_ANI", self, function(arg_43_0, arg_43_1)
		arg_43_0.orders[arg_43_1].ani_fail:setVisible(true)
		arg_43_0.orders[arg_43_1].ani_fail:setAnimation(0, "order_fail", false)
		arg_43_0.orders[arg_43_1].ani_fail:registerSpineEventHandler(function()
			arg_43_0.orders[arg_43_1].ani_fail:setVisible(false)
		end, SP_ANIMATION_COMPLETE)
	end)
	bakery_gamelogic_manager:registerGameEvent("PLAY_ORDER_SUCCESS_ANI", self, function(arg_45_0, arg_45_1)
		arg_45_0.orders[arg_45_1].ani_success:setVisible(true)
		arg_45_0.orders[arg_45_1].ani_success:setAnimation(0, "order_success", false)
		arg_45_0.orders[arg_45_1].ani_success:registerSpineEventHandler(function()
			arg_45_0.orders[arg_45_1].ani_success:setVisible(false)
		end, SP_ANIMATION_COMPLETE)
	end)
end

function ActivityBakeryDeBugLayer:updateOrders(arg_47_1)
	hx_print("updateOrders")
	print(dump(arg_47_1))

	if not next(arg_47_1) then
		for iter_47_0, iter_47_1 in ipairs(self.orders) do
			iter_47_1:setVisible(false)
		end
	end

	for iter_47_2, iter_47_3 in ipairs(arg_47_1) do
		if not iter_47_3 or not next(iter_47_3) then
			self.orders[iter_47_2]:setVisible(false)
		else
			self.orders[iter_47_2]:setVisible(true)
			self.orders[iter_47_2].update(iter_47_3)
		end
	end
end

function ActivityBakeryDeBugLayer:updateCakeMechine(arg_48_1)
	hx_print("updateCakeMechine")
	print(dump(arg_48_1))

	for iter_48_0, iter_48_1 in ipairs(arg_48_1.ovensPool) do
		self.ovens[iter_48_0]:setVisible(true)

		if iter_48_1.cake then
			self.ovens[iter_48_0]:loadTexture(self.resPath .. "oven_on.png", var_0_0)

			if iter_48_1.is_burning then
				if not self.ovens[iter_48_0].ani_fail:isVisible() then
					self.ovens[iter_48_0].ani_fail:setVisible(true)
					self.ovens[iter_48_0].ani_fail:setAnimation(0, "oven_fail", true)
				end

				self.ovens[iter_48_0].ani_on:setVisible(false)
				self.ovens[iter_48_0].ani_fail:setVisible(true)
			else
				if not self.ovens[iter_48_0].ani_on:isVisible() then
					self.ovens[iter_48_0].ani_on:setVisible(true)
					self.ovens[iter_48_0].ani_on:setAnimation(0, "oven_on", true)
				end

				self.ovens[iter_48_0].ani_on:setVisible(true)
				self.ovens[iter_48_0].ani_fail:setVisible(false)
			end
		else
			self.ovens[iter_48_0].ani_on:setVisible(false)
			self.ovens[iter_48_0].ani_fail:setVisible(false)
			self.ovens[iter_48_0]:loadTexture(self.resPath .. "oven_off.png", var_0_0)
		end
	end

	for iter_48_2, iter_48_3 in ipairs(arg_48_1.trays) do
		self.trays[iter_48_2]:setVisible(true)
		self.trays[iter_48_2].update(iter_48_3)
	end

	for iter_48_4, iter_48_5 in ipairs(self.fruitpools) do
		iter_48_5.update(arg_48_1.fruitPool[iter_48_4])
	end

	for iter_48_6, iter_48_7 in ipairs(arg_48_1.choppingPool) do
		self.choppings[iter_48_6]:setVisible(true)
		self.choppings[iter_48_6].update(iter_48_7)
	end
end

function ActivityBakeryDeBugLayer:updateMikeTea(arg_49_1)
	hx_print("updateMikeTea")
	print(dump(arg_49_1))

	if self.confdata.milktea_unlock > var_0_8:activity_get_bakery_cur_data(self.activityId).level then
		self.milkteaMechine:setVisible(false)
		self.pearl:setVisible(false)

		return
	else
		self.milkteaMechine:setVisible(true)
		self.pearl:setVisible(true)
	end

	if arg_49_1.working then
		self.milkteaMechine:loadTexture(self.resPath .. "milkteaMechine_on.png", var_0_0)
		self.milkteaMechine:getChildByName("icon"):setVisible(true)

		if not self.milkteaMechine.ani:isVisible() then
			self.milkteaMechine.ani:setVisible(true)
			self.milkteaMechine.ani:setAnimation(0, "milktea_on", true)
		end
	else
		self.milkteaMechine:loadTexture(self.resPath .. "milkteaMechine_off.png", var_0_0)
		self.milkteaMechine:getChildByName("icon"):setVisible(false)
		self.milkteaMechine.ani:setVisible(false)
	end

	for iter_49_0, iter_49_1 in ipairs(arg_49_1.milkteas) do
		self.milkteas[iter_49_0].update(iter_49_1)
	end
end

function ActivityBakeryDeBugLayer:updateTaroballs(arg_50_1)
	hx_print("updateTaroballs")
	print(dump(arg_50_1))

	if self.confdata.taroballs_unlock > var_0_8:activity_get_bakery_cur_data(self.activityId).level then
		self.taroballsMechine:setVisible(false)
		self.excipient_base:setVisible(false)

		return
	else
		self.taroballsMechine:setVisible(true)
		self.excipient_base:setVisible(true)
	end

	if arg_50_1.working then
		if not self.taroballsMechine.ani:isVisible() then
			self.taroballsMechine.ani:setVisible(true)
			self.taroballsMechine.ani:setAnimation(0, "dessert_on", true)
		end
	else
		self.taroballsMechine.ani:setVisible(false)
	end

	for iter_50_0, iter_50_1 in ipairs(arg_50_1.taroballs) do
		self.taroballs[iter_50_0]:setVisible(true)
		self.taroballs[iter_50_0].update(iter_50_1)
	end
end

function ActivityBakeryDeBugLayer:updateUIProgress(arg_51_1)
	for iter_51_0, iter_51_1 in ipairs(self.orders) do
		if arg_51_1.orderdata[iter_51_0].time then
			iter_51_1.progressBar:setPercent((1 - arg_51_1.orderdata[iter_51_0].time / arg_51_1.max_wait_time) * 100)

			if (1 - arg_51_1.orderdata[iter_51_0].time / arg_51_1.max_wait_time) * 100 > 66 then
				iter_51_1.progressBar:loadProgressBarTexture(self.resPath .. "progress_on_1.png", var_0_0)
				iter_51_1.emoji:loadTexture(self.resPath .. "emoji_happy.png", var_0_0)
			elseif (1 - arg_51_1.orderdata[iter_51_0].time / arg_51_1.max_wait_time) * 100 > 33 then
				iter_51_1.progressBar:loadProgressBarTexture(self.resPath .. "progress_on_2.png", var_0_0)
				iter_51_1.emoji:loadTexture(self.resPath .. "emoji_common.png", var_0_0)
			else
				iter_51_1.progressBar:loadProgressBarTexture(self.resPath .. "progress_on_3.png", var_0_0)
				iter_51_1.emoji:loadTexture(self.resPath .. "emoji_angry.png", var_0_0)
			end
		end
	end

	self.gold_label:setString(arg_51_1.gold)

	if arg_51_1.level_time - arg_51_1.game_time < 0 then
		return
	end

	self.time_label:setString((string.format("%02d:%02d", math.floor((arg_51_1.level_time - arg_51_1.game_time) / 60), (arg_51_1.level_time - arg_51_1.game_time) % 60)))

	for iter_51_2, iter_51_3 in ipairs(arg_51_1.ovendata) do
		if iter_51_3.time and iter_51_3.cake then
			if iter_51_3.time <= arg_51_1.oventime then
				self.ovens[iter_51_2]:getChildByName("progress"):loadProgressBarTexture(self.resPath .. "progress_on_s.png", var_0_0)
			else
				self.ovens[iter_51_2]:getChildByName("progress"):loadProgressBarTexture(self.resPath .. "progress_on_red.png", var_0_0)
			end

			self.ovens[iter_51_2]:getChildByName("progress"):setPercent((iter_51_3.time <= arg_51_1.oventime or nil) and (100 * iter_51_3.time / arg_51_1.oventime or 100 * (iter_51_3.time - arg_51_1.oventime) / arg_51_1.burningtime))
			self.ovens[iter_51_2]:getChildByName("progress"):setVisible(true)
		else
			self.ovens[iter_51_2]:getChildByName("progress"):setVisible(false)
		end
	end

	for iter_51_4, iter_51_5 in ipairs(arg_51_1.choppingdata) do
		if iter_51_5.time and iter_51_5.fruit then
			self.choppings[iter_51_4]:getChildByName("progress"):setPercent(100 * iter_51_5.time / arg_51_1.choptime)
			self.choppings[iter_51_4]:getChildByName("progress"):setVisible(true)
		else
			self.choppings[iter_51_4]:getChildByName("progress"):setVisible(false)
		end
	end
end

function ActivityBakeryDeBugLayer:updateLevelInitGameUI()
	hx_print("updateLevelInitGameUI")

	local var_52_0 = var_0_8:activity_get_bakery_cur_data(self.activityId)
	local activity_bakery_level_conf = require("data.activity_bakery_level_conf")
	local activity_bakery_device_data = require("data.activity_bakery_device_data")
	local var_52_3 = {
		target_gold = var_52_0.target_gold
	}

	var_52_3.max_ongoing_order_num = activity_bakery_level_conf[self.activityId * 100 + var_52_0.level].max_ongoing_order_num or 3
	var_52_3.refresh_order_time = activity_bakery_level_conf[self.activityId * 100 + var_52_0.level].refresh_order_time
	var_52_3.level_time = activity_bakery_level_conf[self.activityId * 100 + var_52_0.level].level_time
	var_52_3.max_wait_time = activity_bakery_level_conf[self.activityId * 100 + var_52_0.level].max_wait_time
	var_52_3.first_order_time = activity_bakery_level_conf[self.activityId * 100 + var_52_0.level].first_order_time or activity_bakery_level_conf[self.activityId * 100 + var_52_0.level].refresh_order_time
	var_52_3.no_order_refresh_time = activity_bakery_level_conf[self.activityId * 100 + var_52_0.level].no_order_refresh_time or activity_bakery_level_conf[self.activityId * 100 + var_52_0.level].refresh_order_time
	var_52_3.order_create = {
		cake_need_max = activity_bakery_level_conf[self.activityId * 100 + var_52_0.level].cake_need_max,
		cake_need_min = activity_bakery_level_conf[self.activityId * 100 + var_52_0.level].cake_need_min,
		milktea_need_max = activity_bakery_level_conf[self.activityId * 100 + var_52_0.level].milktea_need_max,
		milktea_need_min = activity_bakery_level_conf[self.activityId * 100 + var_52_0.level].milktea_need_min,
		taroballs_need_max = activity_bakery_level_conf[self.activityId * 100 + var_52_0.level].taroballs_need_max,
		taroballs_need_min = activity_bakery_level_conf[self.activityId * 100 + var_52_0.level].taroballs_need_min
	}
	var_52_3.oven_num = activity_bakery_device_data.oven_num["levelValue" .. (var_52_0.equipment_level.oven_num or 1)]
	var_52_3.tray_num = activity_bakery_device_data.tray_num["levelValue" .. (var_52_0.equipment_level.tray_num or 1)]
	var_52_3.chopping_num = activity_bakery_device_data.chopping_num["levelValue" .. (var_52_0.equipment_level.chopping_num or 1)]
	var_52_3.milktea_num = activity_bakery_device_data.milktea_num["levelValue" .. (var_52_0.equipment_level.milktea_num or 1)]
	var_52_3.taroballs_num = activity_bakery_device_data.taroballs_num["levelValue" .. (var_52_0.equipment_level.taroballs_num or 1)]
	var_52_3.oventime = activity_bakery_device_data.oventime["levelValue" .. (var_52_0.equipment_level.oventime or 1)]
	var_52_3.burningtime = activity_bakery_device_data.burningtime["levelValue" .. (var_52_0.equipment_level.burningtime or 1)]
	var_52_3.choptime = activity_bakery_device_data.choptime["levelValue" .. (var_52_0.equipment_level.choptime or 1)]
	var_52_3.milkteatime = activity_bakery_device_data.milkteatime["levelValue" .. (var_52_0.equipment_level.milkteatime or 1)]
	var_52_3.taroballstime = activity_bakery_device_data.taroballstime["levelValue" .. (var_52_0.equipment_level.taroballstime or 1)]
	var_52_3.fruitPoolNum = activity_bakery_device_data.fruitPoolNum["levelValue" .. (var_52_0.equipment_level.fruitPoolNum or 1)]

	local var_52_4 = {}

	var_52_4.cake_prize = activity_bakery_device_data.cake_prize["levelValue" .. (var_52_0.equipment_level.cake_prize or 1)]
	var_52_4.cream_prize = activity_bakery_device_data.cream_prize["levelValue" .. (var_52_0.equipment_level.cream_prize or 1)]
	var_52_4.fruit_prize_1 = activity_bakery_device_data.fruit_prize_1["levelValue" .. (var_52_0.equipment_level.fruit_prize_1 or 1)]
	var_52_4.fruit_prize_2 = activity_bakery_device_data.fruit_prize_2["levelValue" .. (var_52_0.equipment_level.fruit_prize_2 or 1)]
	var_52_4.fruit_prize_3 = activity_bakery_device_data.fruit_prize_3["levelValue" .. (var_52_0.equipment_level.fruit_prize_3 or 1)]
	var_52_4.pearl_prize = activity_bakery_device_data.pearl_prize["levelValue" .. (var_52_0.equipment_level.pearl_prize or 1)]
	var_52_4.milktea_prize = activity_bakery_device_data.milktea_prize["levelValue" .. (var_52_0.equipment_level.milktea_prize or 1)]
	var_52_4.taroballs_prize = activity_bakery_device_data.taroballs_prize["levelValue" .. (var_52_0.equipment_level.taroballs_prize or 1)]
	var_52_4.excipients_prize_1 = activity_bakery_device_data.excipients_prize_1["levelValue" .. (var_52_0.equipment_level.excipients_prize_1 or 1)]
	var_52_4.excipients_prize_2 = activity_bakery_device_data.excipients_prize_2["levelValue" .. (var_52_0.equipment_level.excipients_prize_2 or 1)]
	var_52_3.prize = var_52_4
	var_52_3.usingHelpItem = var_52_0.usingHelpItem

	print_lua_table(var_52_3)
	bakery_gamelogic_manager:loadGameData(var_52_3)
end

function ActivityBakeryDeBugLayer:updateItemNum()
	self.keyitem_label:setString(var_0_10:getItemNumber(self.confdata.key_item))
end
