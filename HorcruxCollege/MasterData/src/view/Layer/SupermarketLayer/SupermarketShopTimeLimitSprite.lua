SupermarketShopTimeLimitSprite = class("SupermarketShopTimeLimitSprite", function()
	require("view.Layer.Pops.PopBaseLayer")

	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local network = require("network.network")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local drop_manager = require("controller.drop_manager")
local level_manager = require("controller.level_manager")
local component_manager = require("controller.component_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local recharge_manager = require("controller.recharge_manager")
local item_manager = require("controller.item_manager")
local supermarket_manager = require("controller.supermarket_manager")
local TempWidget = require("view.Sprite.TempWidget")
local item_data = require("data.item_data")
local recharge_data = require("data.recharge_data")
local shop_timelimit_data = require("data.shop.shop_timelimit_data")
local activity_shoptimelimit_uiconfig_data = require("data.activity_template_ui_conf.activity_shoptimelimit_uiconfig_data")
local var_0_19 = 11
local var_0_23 = {
	Day = "%d天",
	Hour = "%d时",
	Minute = "%d分",
	Less = "剩余时间小于1分钟"
}
local var_0_24 = {
	"%d天%d时",
	"%d时%d分",
	"%d分钟",
	"%d分%d秒",
	"%d秒"
}

local function var_0_25(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_0 then
		return ""
	end

	local var_2_0 = global_get_time_by_date(arg_2_0) - arg_2_1

	if var_2_0 < 0 then
		return ""
	end

	local var_2_1 = ""
	local var_2_6 = math.floor(var_2_0 / 24 / 3600)
	local var_2_7 = math.floor((var_2_0 - var_2_6 * 24 * 3600) / 3600)
	local var_2_8 = math.floor((var_2_0 - var_2_6 * 24 * 3600 - var_2_7 * 3600) / 60)

	var_2_1 = arg_2_3 == 1 and (var_2_6 ~= 0 and string.format(var_0_23.Day, var_2_6) or var_2_7 ~= 0 and string.format(var_0_23.Hour, var_2_7) or string.format(var_0_23.Minute, var_2_8)) or var_2_6 ~= 0 and string.format(var_0_24[1], var_2_6, var_2_7) or var_2_7 ~= 0 and string.format(var_0_24[2], var_2_7, var_2_8) or string.format(var_0_24[3], var_2_8)

	return (arg_2_2 or nil) and (arg_2_2 .. var_2_1 or L_TIME_REST2 .. L_TIME .. var_2_1)
end

local function var_0_26(arg_3_0, arg_3_1)
	network:rpc("recharge_from_diamond", {
		id = arg_3_0
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			for iter_4_0, iter_4_1 in pairs(arg_4_0.cost_items) do
				item_manager:deleteItem(iter_4_1.entityid, iter_4_1.num)
			end

			global_gain({
				items = arg_4_0.items,
				diamond = arg_4_0.diamond,
				gold = arg_4_0.gold,
				sp = arg_4_0.sp
			})
		elseif arg_4_0.result == 2 then
			print("recharge is not price_diamond")
		elseif arg_4_0.result == 3 then
			global_ShowBlockWords("班长等级不足")
		elseif arg_4_0.result == 4 then
			print("前置购买未解锁")
		elseif arg_4_0.result == 5 then
			print("购买次数已达上限")
		elseif arg_4_0.result == 6 then
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end

		if arg_3_1 then
			arg_3_1(arg_4_0)
		end
	end)
end

local function var_0_27(arg_5_0, arg_5_1)
	network:rpc("recharge_from_card", {
		id = arg_5_0
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			for iter_6_0, iter_6_1 in pairs(arg_6_0.cost_items) do
				item_manager:deleteItem(iter_6_1.entityid, iter_6_1.num)
			end

			global_gain({
				items = arg_6_0.items,
				diamond = arg_6_0.diamond,
				gold = arg_6_0.gold,
				sp = arg_6_0.sp
			})

			if arg_5_1 then
				arg_5_1(arg_6_0)
			end
		elseif arg_6_0.result == 2 then
			print("recharge is not price_card")
		elseif arg_6_0.result == 3 then
			global_ShowBlockWords("班长等级不足")
		elseif arg_6_0.result == 4 then
			print("前置购买未解锁")
		elseif arg_6_0.result == 5 then
			print("购买次数已达上限")
		elseif arg_6_0.result == 6 then
			LayerManager:pushInLayer("PopSupermarketLayer", {
				initSelectPage = 15,
				callback = arg_5_1
			})
		end
	end)
end

local function var_0_28(arg_7_0, arg_7_1)
	network:rpc("get_free_award", {
		id = arg_7_0
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			global_gain({
				items = arg_8_0.items,
				diamond = arg_8_0.diamond,
				gold = arg_8_0.gold,
				sp = arg_8_0.sp
			})
		elseif arg_8_0.result == 2 then
			print("空id")
		elseif arg_8_0.result == 3 then
			print("类型不为9")
		elseif arg_8_0.result == 4 then
			print("次数已达上限")
		elseif arg_8_0.result == 5 then
			print("充值金额未达到")
		end

		if arg_7_1 then
			arg_7_1(arg_8_0)
		end
	end)
end

function SupermarketShopTimeLimitSprite:getUiPositionConf(arg_9_1, arg_9_2)
	if arg_9_1 == "debug" then
		return activity_shoptimelimit_uiconfig_data.debug
	end

	return activity_shoptimelimit_uiconfig_data["shoptimelimit_" .. self.uitype .. "_" .. arg_9_1] and (activity_shoptimelimit_uiconfig_data["shoptimelimit_" .. self.uitype .. "_" .. arg_9_1][arg_9_2] or activity_shoptimelimit_uiconfig_data["template_" .. self.uitype][arg_9_2]) or activity_shoptimelimit_uiconfig_data["template_" .. self.uitype][arg_9_2]
end

function SupermarketShopTimeLimitSprite.create(arg_10_0, arg_10_1)
	local var_10_0 = SupermarketShopTimeLimitSprite.new()

	var_10_0:init(arg_10_1)

	return var_10_0
end

function SupermarketShopTimeLimitSprite:init(arg_11_1)
	self.initParam = arg_11_1
	self.groupid = arg_11_1.groupid
	self.uitype = 2
	self._obj_activity = true
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(cc.size(640, 950 + GameDisplay.fix_y * 2))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer)

	self.extHeight = activity_shoptimelimit_uiconfig_data["ext_height_" .. self.groupid] or 0
	self.extHeight = math.max(self.extHeight - (GameDisplay.height - 1136), 0)
	self.uniform_distance_enable = activity_shoptimelimit_uiconfig_data["uniform_distance_enable_" .. self.groupid]
	self.uniform_distance = activity_shoptimelimit_uiconfig_data["uniform_distance_" .. self.groupid]
	self.uniform_start_posy = activity_shoptimelimit_uiconfig_data["uniform_start_posy_" .. self.groupid]

	self:initData(function(...)
		supermarket_manager:updateShopTimelimitReddot(self.list)

		if self.uniform_distance_enable then
			self.extHeight = math.max(1136, self.uniform_start_posy + self.uniform_distance * #self.list + 100) - 1136
			self.extHeight = math.max(self.extHeight - (GameDisplay.height - 1136), 0)
		end

		self.rootpanel = ccui.ScrollView:create()

		self.rootpanel:setBounceEnabled(false)
		self.rootpanel:setContentSize(cc.size(640, self.rootLayer:getContentSize().height))
		self.rootpanel:setInnerContainerSize(cc.size(640, self.rootLayer:getContentSize().height + self.extHeight))
		self.rootpanel:setDirection(ccui.ScrollViewDir.vertical)
		self.rootpanel:setTouchEnabled(true)
		self.rootLayer:addChild(self.rootpanel, 3)
		self.rootpanel:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function(...)
			self.rootpanel:getInnerContainer():setPositionY(-self.extHeight)
		end)))

		if not arg_11_1 or not arg_11_1.disabledEnterAni then
			self.showActions.moveFadeIn(self)
		end

		self:initUI()
		self:updateUI()
	end)
	self:registerScriptHandler(function(arg_14_0)
		if arg_14_0 == "exit" then
			if self.initParam and self.initParam.callback then
				self.initParam.callback()
			end

			self._obj_activity = false
		end
	end)
	self:initPurchaseEventListener()
end

function SupermarketShopTimeLimitSprite:initData(arg_15_1)
	self:resetList()

	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(shop_timelimit_data) do
		if iter_15_1.rechargeid then
			var_15_0[iter_15_1.rechargeid] = iter_15_1
		end
	end

	recharge_manager:getRechargeInfo(function(arg_16_0, arg_16_1)
		if not self._obj_activity then
			return
		end

		if arg_16_0 == 1 then
			local var_16_0 = {}

			for iter_16_0, iter_16_1 in pairs(arg_16_1) do
				if var_15_0[iter_16_1.id] and var_15_0[iter_16_1.id].group == self.groupid then
					var_16_0[iter_16_1.id] = iter_16_1
				end
			end

			self.list = {}

			for iter_16_2, iter_16_3 in pairs(var_16_0) do
				local var_16_1 = clone(var_15_0[iter_16_3.id])

				var_16_1.have_bought = iter_16_3.have_bought
				var_16_1.buy_limit = iter_16_3.buy_limit or 99999
				var_16_1.new_tag = iter_16_3.new_tag
				var_16_1.finish_time = iter_16_3.finishtime
				var_16_1.discount = iter_16_3.discount

				table.insert(self.list, var_16_1)
			end

			for iter_16_4, iter_16_5 in pairs(self.list) do
				if iter_16_5.dropid then
					iter_16_5.dropids = drop_manager:getDropMsg(iter_16_5.dropid).equips

					table.sort(iter_16_5.dropids, function(arg_17_0, arg_17_1)
						return arg_17_0._index < arg_17_1._index
					end)
				end
			end

			if arg_15_1 then
				arg_15_1()
			end
		end
	end)
end

function SupermarketShopTimeLimitSprite:initUI()
	local var_18_0 = false
	local var_18_1 = 568
	local var_18_2 = require("controller.activity_return_manager"):getOfflineDay()

	for iter_18_0, iter_18_1 in pairs(self.list) do
		local var_18_3 = 30

		if 30 <= var_18_2 then
			var_18_3 = iter_18_1.id

			if iter_18_1.id == 17601 then
				goto label_18_0
			end
		end

		var_18_3 = 30

		if var_18_2 < 30 then
			var_18_3 = iter_18_1.id

			if iter_18_1.id == 17602 then
				goto label_18_0
			end
		end

		var_18_3 = iter_18_1.dropids
		self.group = supermarket_manager:getShopTimeLimitGroupByID(iter_18_1.id)

		hx_print("group = " .. self.group .. " id = " .. "shoptimelimit_2_" .. iter_18_1.id, CONSOLE_COLOR_GREEN)

		do
			local var_18_4 = self:getUiPositionConf(iter_18_1.id, "bg")
			local var_18_5 = ccui.ImageView:create("mainScenebg/activity/shoptimelimit/" .. self.group .. "/bg_" .. iter_18_1.id .. ".png")

			var_18_5:setAnchorPoint(cc.p(0.5, 0.5))

			var_18_5.id = iter_18_1.id
			var_18_5.rechargeid = iter_18_1.rechargeid

			var_18_5:setPositionX(var_18_4.pos.x)

			if self.uniform_distance_enable then
				var_18_5:setPositionY(1136 + self.extHeight - self.uniform_start_posy - (iter_18_0 - 1) * self.uniform_distance + GameDisplay.fix_y * 2)
			else
				var_18_5:setPositionY(var_18_4.pos.y + GameDisplay.fix_y + self.extHeight)
			end

			var_18_5:setTouchEnabled(true)
			var_18_5:addTouchEventListener(self:getSureBtnHangel())
			self.rootpanel:addChild(var_18_5)

			if self:getUiPositionConf("debug") then
				local var_18_6 = cc.Label:createWithTTF(iter_18_1.id, FONT_DES, 22)

				var_18_6:setPosition(cc.p(var_18_5:getContentSize().width / 2, var_18_5:getContentSize().height / 2))
				var_18_5:addChild(var_18_6)
			end

			local var_18_7 = self:getUiPositionConf(iter_18_1.id, "btn_buy")
			local var_18_8 = ccui.Button:create("mainScenebg/activity/shoptimelimit/" .. self.group .. "/btn_get_" .. iter_18_1.id .. ".png")

			var_18_8:setAnchorPoint(cc.p(0.5, 0.5))
			var_18_8:setName("btn_" .. iter_18_1.id)
			var_18_8:setPosition(var_18_7.pos or cc.p(0, 0))

			var_18_8.id = iter_18_1.id
			var_18_8.rechargeid = iter_18_1.rechargeid

			var_18_8:addTouchEventListener(self:getSureBtnHangel())
			var_18_5:addChild(var_18_8)

			var_18_1 = math.min(var_18_1, var_18_4.pos.y - var_18_5:getContentSize().height / 2)

			if self:getUiPositionConf(iter_18_1.id, "img_reddot") and recharge_data[iter_18_1.rechargeid] and recharge_data[iter_18_1.rechargeid].type == 11 then
				local var_18_9 = self:getUiPositionConf(iter_18_1.id, "img_reddot")
				local var_18_10 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

				var_18_10:setName("img_reddot_" .. iter_18_1.id)
				var_18_10:setPosition(var_18_9.pos)
				var_18_10:setVisible(false)
				var_18_5:addChild(var_18_10)
			end

			local var_18_11 = self:getUiPositionConf(iter_18_1.id, "label_price")
			local var_18_12 = ccui.Text:create("", "fonts/W5.ttf", (var_18_11 or nil) and (var_18_11.size or 24))

			var_18_12:setPositionX(var_18_11.pos.x or var_18_8:getContentSize().width / 2)
			var_18_12:setPositionY(var_18_11.pos.y or var_18_8:getContentSize().height / 2)
			var_18_12:setAnchorPoint(var_18_11.anchorpoint or cc.p(0, 0))
			var_18_12:setColor(var_18_11.color or cc.c3b(113, 54, 10))
			var_18_12:setName("priceLabel_" .. iter_18_1.id)
			var_18_8:addChild(var_18_12)

			local var_18_13 = self:getUiPositionConf(iter_18_1.id, "img_currency")
			local var_18_14 = ccui.ImageView:create("GUI/image.png", var_0_0)

			var_18_14:setPosition(var_18_13.pos)
			var_18_14:setVisible(var_18_13.visible)
			var_18_5:addChild(var_18_14)

			if iter_18_1.currency == 8888888 then
				var_18_14:loadTexture("public/currency/888888.png", var_0_0)
			elseif iter_18_1.currency then
				var_18_14:loadTexture("public/currency/" .. iter_18_1.currency .. ".png", var_0_0)
			elseif iter_18_1.rechargeid then
				var_18_14:loadTexture("public/currency/rmb_white.png", var_0_0)
			end

			if not recharge_manager.getProductDisplayPrice then
				var_18_14:setVisible(false)
			end

			local var_18_15 = self:getUiPositionConf(iter_18_1.id, "label_buycount") or {}
			local var_18_16 = ccui.Text:create("", var_18_15.font or FONT_DES, var_18_15.size or 20)

			var_18_16:setPosition(var_18_15.pos or cc.p(0, 0))
			var_18_16:setAnchorPoint(var_18_15.anchorpoint or cc.p(0.5, 0.5))
			var_18_16:setColor(var_18_15.color or cc.c3b(0, 0, 0))
			var_18_16:setVisible(var_18_15.visible or false)
			var_18_16:setName("buycountLabel_" .. iter_18_1.id)
			var_18_5:addChild(var_18_16)

			local var_18_17 = self:getUiPositionConf(iter_18_1.id, "img_title")

			if var_18_17 then
				local var_18_18 = ccui.ImageView:create("mainScenebg/activity/shoptimelimit/" .. self.group .. "/title_" .. iter_18_1.id .. ".png")

				var_18_18:setAnchorPoint(cc.p(0.5, 0.5))
				var_18_18:setPosition(var_18_17.pos)
				self.rootpanel:addChild(var_18_18)
			end

			for iter_18_2, iter_18_3 in pairs((self:getUiPositionConf(iter_18_1.id, "panel_touch"))) do
				local var_18_19 = ccui.Layout:create()

				var_18_19:setTouchEnabled(true)
				var_18_19:setContentSize(iter_18_3.size)
				var_18_19:setAnchorPoint(cc.p(0.5, 0.5))
				var_18_19:setPosition(iter_18_3.pos)
				var_18_19:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
				var_18_19:addTouchEventListener(function(arg_19_0, arg_19_1)
					if arg_19_1 ~= ccui.TouchEventType.ended then
						return
					end

					local function var_19_0(arg_20_0)
						if item_data[arg_20_0.itemid].bag_item_type == kITEM_SKIN then
							LayerManager:pushInLayer("PopShowGilrPreviewLayer", {
								itemid = arg_20_0.itemid
							})
						elseif item_data[arg_20_0.itemid].bag_item_type == kITEM_CHOOSE_GIFT then
							LayerManager:pushInLayer("PopOpenChoosegiftLayer", {
								itemid = arg_20_0.itemid
							})
						else
							PopLayer:Item(arg_20_0)
						end
					end

					if iter_18_3.itemid then
						if not item_data[iter_18_3.itemid] then
							return
						end

						var_19_0({
							hideGainButton = true,
							itemid = iter_18_3.itemid
						})
					else
						if not var_18_3[iter_18_2] then
							return
						end

						if not item_data[var_18_3[iter_18_2].dropid] then
							return
						end

						var_19_0({
							hideGainButton = true,
							itemid = var_18_3[iter_18_2].dropid
						})
					end
				end)
				var_18_5:addChild(var_18_19, 999)

				if self:getUiPositionConf("debug") then
					var_18_19:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
					var_18_19:setBackGroundColor(cc.c3b(255, 0, 0))
					var_18_19:setOpacity(120)
				end
			end

			local var_18_20 = TempWidget:CreateTempLabel("", FONT_NAME, 22, var_18_5)

			var_18_20:align(cc.p(0, 1), 50, var_18_5:getContentSize().height - 87)
			var_18_20:hide()

			if self.groupid == 70001 then
				var_18_20:show()
			end

			if iter_18_1.finish_time then
				var_18_20:setString((var_0_25(iter_18_1.finish_time, time_check_manager:getCurTime())))
			end

			if recharge_data[iter_18_1.rechargeid].refreshtype == 1 then
				var_18_0 = true
			end

			self.finishTime = supermarket_manager:getShopTimeLimitFinishTime(iter_18_1.id)

			if self.rootpanel:getChildByName("discountBg_" .. iter_18_1.id) then
				self.rootpanel:getChildByName("discountBg_" .. iter_18_1.id):setVisible(false)
			end

			local var_18_21 = self:getUiPositionConf(iter_18_1.id, "discountConf")

			if iter_18_1.discount and var_18_21 then
				local var_18_22 = self.rootpanel:getChildByName("discountBg_" .. iter_18_1.id)

				if not var_18_22 then
					var_18_22 = ccui.ImageView:create("mainScenebg/activity/shoptimelimit/discount.png")

					var_18_22:setName("discountBg_" .. iter_18_1.id)
					self.rootpanel:addChild(var_18_22, var_18_21.zorder or 1)

					local var_18_24 = cc.Label:createWithTTF(iter_18_1.discount, var_18_21.font1 or FONT_W5, var_18_21.font_size1 or 33)

					var_18_24:setName("discountLabel")
					var_18_22:addChild(var_18_24)

					local var_18_25 = cc.Label:createWithTTF("折", var_18_21.font2 or FONT_W5, var_18_21.font_size2 or 22)

					var_18_25:setName("discountDesLabel")
					var_18_22:addChild(var_18_25)
				end

				var_18_22:loadTexture("mainScenebg/activity/shoptimelimit/discount.png")

				local var_18_26 = cc.p(var_18_5:getPositionX(), var_18_5:getPositionY())

				if var_18_21.pos then
					var_18_26.x = var_18_26.x + var_18_21.pos.x
					var_18_26.y = var_18_26.y + var_18_21.pos.y
				end

				var_18_22:setPosition(var_18_26)

				local var_18_27 = var_18_22:getChildByName("discountLabel")
				local var_18_28 = var_18_22:getChildByName("discountDesLabel")

				var_18_22:setVisible(true)
				var_18_27:setPositionX(var_18_22:getContentSize().width / 2 - var_18_28:getContentSize().width / 2 + 6)
				var_18_27:setPositionY(var_18_22:getContentSize().height / 2 + 3)
				var_18_27:setString(iter_18_1.discount % 10 == 0 and iter_18_1.discount / 10 .. ".0" or iter_18_1.discount / 10 or 10)
				var_18_28:setPositionX(var_18_22:getContentSize().width / 2 + var_18_27:getContentSize().width / 2 + 6)
				var_18_28:setPositionY(var_18_22:getContentSize().height / 2)
				var_18_27:setColor(var_18_21.color or cc.c3b(255, 255, 255))
				var_18_28:setColor(var_18_21.color or cc.c3b(255, 255, 255))
			end
		end

		::label_18_0::
	end

	if var_18_0 then
		local var_18_30

		if activity_shoptimelimit_uiconfig_data["refresh_tips_img_" .. self.group] then
			var_18_30 = activity_shoptimelimit_uiconfig_data["refresh_tips_img_" .. self.group].path or "mainScenebg/activity/shoptimelimit/refreshg_tips_img.png"
		end

		if cc.FileUtils:getInstance():isFileExist(var_18_30) then
			local var_18_31 = ccui.ImageView:create(var_18_30)

			var_18_31:setPosition(cc.p(320, var_18_1 - 50))
			var_18_31:setName("refresh_tips_img")
			self.rootpanel:addChild(var_18_31)
		end
	end

	if activity_shoptimelimit_uiconfig_data["refresh_tips_img_" .. self.group] and activity_shoptimelimit_uiconfig_data["refresh_tips_img_" .. self.group].visible ~= nil and ccui.Helper:seekWidgetByName(self.rootLayer, "refresh_tips_img") then
		ccui.Helper:seekWidgetByName(self.rootLayer, "refresh_tips_img"):setVisible(activity_shoptimelimit_uiconfig_data["refresh_tips_img_" .. self.group].visible)
		ccui.Helper:seekWidgetByName(self.rootLayer, "refresh_tips_img"):setPosition(activity_shoptimelimit_uiconfig_data["refresh_tips_img_" .. self.group].pos or cc.p(320, var_18_1 - 50))
	end

	if self.finishTime then
		local var_18_32 = self:getChildByName("count_down_bg")

		if not var_18_32 then
			var_18_32 = ccui.ImageView:create("mainScenebg/activity/shoptimelimit/" .. self.group .. "/count_down_bg.png")

			local var_18_33 = activity_shoptimelimit_uiconfig_data["count_down_" .. self.group] or {
				size = 20,
				pos = cc.p(130, 914),
				label_anchorpoint = cc.p(0, 0.5),
				color = cc.c3b(255, 255, 255)
			}

			var_18_32:setPositionX(var_18_33.pos.x)
			var_18_32:setPositionY(var_18_33.pos.y + GameDisplay.fix_y * 2)
			var_18_32:setName("count_down_bg")
			self:addChild(var_18_32, 10)

			local var_18_34 = cc.Label:createWithTTF("", FONT_NAME, var_18_33.size)

			var_18_34:setAnchorPoint(cc.p(0, 0.5))
			var_18_34:setPositionX(56)
			var_18_34:setPositionY(16)
			var_18_34:setName("count_down_label")
			var_18_32:addChild(var_18_34)
		end

		local var_18_35 = var_0_25(self.finishTime, time_check_manager:getCurTime())

		var_18_32:loadTexture("mainScenebg/activity/shoptimelimit/" .. self.group .. "/count_down_bg.png")
		self:getChildByName("count_down_bg"):setVisible(true)
		var_18_32:getChildByName("count_down_label"):setString(var_18_35)
	elseif self:getChildByName("count_down_bg") then
		self:getChildByName("count_down_bg"):setVisible(false)
	end

	for iter_18_4 = 1, 5 do
		if activity_shoptimelimit_uiconfig_data["otherimg_" .. self.group .. "_" .. iter_18_4] then
			local var_18_36 = ccui.ImageView:create(activity_shoptimelimit_uiconfig_data["otherimg_" .. self.group .. "_" .. iter_18_4].path)

			var_18_36:setPosition(activity_shoptimelimit_uiconfig_data["otherimg_" .. self.group .. "_" .. iter_18_4].pos)
			var_18_36:setName("otherimg_" .. iter_18_4)
			self.rootpanel:addChild(var_18_36, activity_shoptimelimit_uiconfig_data["otherimg_" .. self.group .. "_" .. iter_18_4].zorder or 1)
		end
	end

	if cc.FileUtils:getInstance():isFileExist("mainScenebg/activity/shoptimelimit/btn_close_" .. self.group .. ".png") then
		local var_18_38 = ccui.Button:create("mainScenebg/activity/shoptimelimit/btn_close_" .. self.group .. ".png", nil, "mainScenebg/activity/shoptimelimit/btn_close_" .. self.group .. ".png")

		var_18_38:setPosition((activity_shoptimelimit_uiconfig_data["btn_close_" .. self.group] or nil) and (activity_shoptimelimit_uiconfig_data["btn_close_" .. self.group].pos or cc.p(600, 1100)))
		self.rootpanel:addChild(var_18_38, 100)
		var_18_38:addTouchEventListener(function(arg_21_0, arg_21_1)
			if arg_21_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:exit()
		end)
	end

	if activity_shoptimelimit_uiconfig_data["particle_" .. self.group] then
		self.rootpanel:addChild(cc.ParticleSystemQuad:create("effect/particle/" .. activity_shoptimelimit_uiconfig_data["particle_" .. self.group].path), 1000)
	end
end

function SupermarketShopTimeLimitSprite.getSureBtnHangel(arg_22_0)
	return function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.click_shop_limit_new({
			id = arg_23_0.id
		})

		for iter_23_0, iter_23_1 in pairs(arg_22_0.list) do
			if iter_23_1.id == arg_23_0.id and iter_23_1.have_bought >= iter_23_1.buy_limit then
				if recharge_data[iter_23_1.id].price_card == 0 or recharge_data[iter_23_1.id].price_diamond == 0 then
					global_ShowBlockWords(L_BUTTON_TEXT.Got)
				else
					global_ShowBlockWords(L_BUTTON_TEXT.Bought)
				end

				return
			end
		end

		print("RechargeID: ", arg_23_0.rechargeid, recharge_data[arg_23_0.rechargeid].type)

		if recharge_data[arg_23_0.rechargeid].type == var_0_19 then
			arg_23_0:setBright(false)
			var_0_28(arg_23_0.id, function(arg_24_0)
				if arg_24_0 and arg_24_0.result == 1 then
					for iter_24_0, iter_24_1 in pairs(arg_22_0.list) do
						if iter_24_1.id == arg_23_0.id then
							iter_24_1.have_bought = iter_24_1.have_bought + 1
						end
					end

					supermarket_manager:updateShopTimelimitReddot(arg_22_0.list)
					arg_22_0:updateUI()
				end

				arg_23_0:setBright(true)
			end)
		elseif recharge_data[arg_23_0.rechargeid].rmb then
			arg_22_0:buy(arg_23_0.rechargeid)
		elseif recharge_data[arg_23_0.rechargeid].price_diamond then
			if not arg_23_0:isBright() then
				return
			end

			local var_23_0 = {
				surecallback = function(...)
					arg_23_0:setBright(false)
					var_0_26(arg_23_0.id, function(arg_26_0)
						if arg_26_0.result == 1 then
							for iter_26_0, iter_26_1 in pairs(arg_22_0.list) do
								if iter_26_1.id == arg_23_0.id then
									iter_26_1.have_bought = iter_26_1.have_bought + 1
								end
							end

							supermarket_manager:updateShopTimelimitReddot(arg_22_0.list)
							arg_22_0:updateUI()
						end

						arg_23_0:setBright(true)
					end)
				end
			}

			if recharge_data[arg_23_0.rechargeid].price_diamond == 0 then
				var_23_0.surecallback()
			else
				require("view.Sprite.ConfirmDialogSprite")

				local var_23_1 = ConfirmDialogSprite:create(L_SOULS_CONFIRM_DIALOG[1], string.format(L_SOULS_CONFIRM_DIALOG[3], recharge_data[arg_23_0.rechargeid].price_diamond), var_23_0)

				var_23_1:setPositionY(var_23_1:getPositionY() - GameDisplay.fix_y)
				arg_22_0:addChild(var_23_1, 10)
			end
		elseif recharge_data[arg_23_0.rechargeid].price_card then
			if not arg_23_0:isBright() then
				return
			end

			local var_23_2 = {
				surecallback = function(...)
					arg_23_0:setBright(false)
					var_0_27(arg_23_0.id, function(arg_28_0)
						if arg_28_0 and arg_28_0.result == 1 then
							for iter_28_0, iter_28_1 in pairs(arg_22_0.list) do
								if iter_28_1.id == arg_23_0.id then
									iter_28_1.have_bought = iter_28_1.have_bought + 1
								end
							end

							supermarket_manager:updateShopTimelimitReddot(arg_22_0.list)
							arg_22_0:updateUI()
						end

						arg_23_0:setBright(true)
					end)
				end
			}

			if recharge_data[arg_23_0.rechargeid].price_card == 0 then
				var_23_2.surecallback()
			else
				require("view.Sprite.ConfirmDialogSprite")

				local var_23_3 = ConfirmDialogSprite:create(L_SOULS_CONFIRM_DIALOG[1], string.format(L_SOULS_CONFIRM_DIALOG[4], recharge_data[arg_23_0.rechargeid].price_card), var_23_2)

				var_23_3:setPositionY(var_23_3:getPositionY() - GameDisplay.fix_y)
				arg_22_0:addChild(var_23_3, 10)
			end
		end
	end
end

function SupermarketShopTimeLimitSprite:updateUI()
	local var_29_0 = require("controller.activity_return_manager"):getOfflineDay()

	for iter_29_0, iter_29_1 in pairs(self.list) do
		if var_29_0 >= 30 and iter_29_1.id == 17601 then
			-- block empty
		elseif var_29_0 < 30 and iter_29_1.id == 17602 then
			-- block empty
		else
			if not iter_29_1.have_bought then
				print(dump(iter_29_1))
			end

			if iter_29_1.have_bought >= iter_29_1.buy_limit then
				ccui.Helper:seekWidgetByName(self.rootLayer, "btn_" .. iter_29_1.id):loadTextures("mainScenebg/activity/shoptimelimit/" .. self.group .. "/btn_got_" .. iter_29_1.id .. ".png", "mainScenebg/activity/shoptimelimit/" .. self.group .. "/btn_got_" .. iter_29_1.id .. ".png", "mainScenebg/activity/shoptimelimit/" .. self.group .. "/btn_got_" .. iter_29_1.id .. ".png")

				if ccui.Helper:seekWidgetByName(self.rootLayer, "priceLabel_" .. iter_29_1.id) then
					ccui.Helper:seekWidgetByName(self.rootLayer, "priceLabel_" .. iter_29_1.id):setString(L_BOUGHT)
				end
			else
				ccui.Helper:seekWidgetByName(self.rootLayer, "btn_" .. iter_29_1.id):loadTextures("mainScenebg/activity/shoptimelimit/" .. self.group .. "/btn_get_" .. iter_29_1.id .. ".png", "mainScenebg/activity/shoptimelimit/" .. self.group .. "/btn_get_" .. iter_29_1.id .. ".png", "mainScenebg/activity/shoptimelimit/" .. self.group .. "/btn_get_" .. iter_29_1.id .. ".png")

				if ccui.Helper:seekWidgetByName(self.rootLayer, "priceLabel_" .. iter_29_1.id) then
					ccui.Helper:seekWidgetByName(self.rootLayer, "priceLabel_" .. iter_29_1.id):setString(recharge_manager:getCommodityPriceStr(iter_29_1.id) .. "  " .. L_ACTIVITY_EXPLORE_BUY_TIMES.button)
				end
			end

			local var_29_1 = iter_29_1.rechargeid
			local var_29_2 = self:getUiPositionConf(iter_29_1.id, "label_buycount")

			if recharge_data[iter_29_1.rechargeid].refreshtype == 1 then
				ccui.Helper:seekWidgetByName(self.rootLayer, "buycountLabel_" .. iter_29_1.id):setString("(" .. L_TODAY_BUY_LIMIT .. iter_29_1.have_bought .. "/" .. iter_29_1.buy_limit .. ")")
			elseif recharge_data[var_29_1].refreshtype == 2 then
				ccui.Helper:seekWidgetByName(self.rootLayer, "buycountLabel_" .. iter_29_1.id):setString("(" .. L_TOWEEK_BUY_LIMIT .. iter_29_1.have_bought .. "/" .. iter_29_1.buy_limit .. ")")
			elseif recharge_data[var_29_1].refreshtype == 3 then
				ccui.Helper:seekWidgetByName(self.rootLayer, "buycountLabel_" .. iter_29_1.id):setString("(" .. L_TOMONTH_BUY_LIMIT .. iter_29_1.have_bought .. "/" .. iter_29_1.buy_limit .. ")")
			elseif not recharge_data[var_29_1].refreshtype or recharge_data[var_29_1].refreshtype == 4 then
				ccui.Helper:seekWidgetByName(self.rootLayer, "buycountLabel_" .. iter_29_1.id):setString("(" .. L_BUY_LIMIT .. "：" .. iter_29_1.have_bought .. "/" .. iter_29_1.buy_limit .. ")")
			end

			if var_29_2 and var_29_2.str then
				ccui.Helper:seekWidgetByName(self.rootLayer, "buycountLabel_" .. iter_29_1.id):setVisible(true)
				ccui.Helper:seekWidgetByName(self.rootLayer, "buycountLabel_" .. iter_29_1.id):setString(var_29_2.str)
			end

			if iter_29_1.buy_limit == 99999 then
				ccui.Helper:seekWidgetByName(self.rootLayer, "buycountLabel_" .. iter_29_1.id):setVisible(false)
			end

			if ccui.Helper:seekWidgetByName(self.rootLayer, "img_reddot_" .. iter_29_1.id) then
				ccui.Helper:seekWidgetByName(self.rootLayer, "img_reddot_" .. iter_29_1.id):setVisible(false)

				if recharge_data[var_29_1] and recharge_data[var_29_1].type == 11 and iter_29_1.have_bought == 0 then
					ccui.Helper:seekWidgetByName(self.rootLayer, "img_reddot_" .. iter_29_1.id):setVisible(true)
				end
			end
		end
	end
end

function SupermarketShopTimeLimitSprite:resetList()
	self.list = clone(supermarket_manager:getAllShopTimeLimitList()[self.groupid]) or {}

	for iter_30_0, iter_30_1 in pairs(self.list) do
		if iter_30_1.dropid then
			iter_30_1.dropids = drop_manager:getDropMsg(iter_30_1.dropid).equips

			table.sort(iter_30_1.dropids, function(arg_31_0, arg_31_1)
				return arg_31_0._index < arg_31_1._index
			end)
		end
	end
end

function SupermarketShopTimeLimitSprite:updateBySupermarketLayer(arg_32_1)
	self.groupid = arg_32_1.groupid

	if self.groupid then
		self.extHeight = activity_shoptimelimit_uiconfig_data["ext_height_" .. self.groupid] or 0
	end

	self.extHeight = math.max(self.extHeight - (GameDisplay.height - 1136), 0)
	self.uniform_distance_enable = activity_shoptimelimit_uiconfig_data["uniform_distance_enable_" .. self.groupid]
	self.uniform_distance = activity_shoptimelimit_uiconfig_data["uniform_distance_" .. self.groupid]
	self.uniform_start_posy = activity_shoptimelimit_uiconfig_data["uniform_start_posy_" .. self.groupid]

	self.rootpanel:setVisible(false)
	self:initData(function(...)
		supermarket_manager:updateShopTimelimitReddot(self.list)

		if self.uniform_distance_enable then
			self.extHeight = math.max(1136, self.uniform_start_posy + self.uniform_distance * #self.list + 100) - 1136
			self.extHeight = math.max(self.extHeight - (GameDisplay.height - 1136), 0)
		end

		self.rootpanel:removeAllChildren()

		self.rootpanel = ccui.ScrollView:create()

		self.rootpanel:setBounceEnabled(false)
		self.rootpanel:setContentSize(cc.size(640, self.rootLayer:getContentSize().height))
		self.rootpanel:setInnerContainerSize(cc.size(640, self.rootLayer:getContentSize().height + self.extHeight))
		self.rootpanel:setDirection(ccui.ScrollViewDir.vertical)
		self.rootpanel:setTouchEnabled(true)
		self.rootLayer:addChild(self.rootpanel, 3)
		self.rootpanel:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function(...)
			self.rootpanel:getInnerContainer():setPositionY(-self.extHeight)
		end)))

		if not initParam or not initParam.disabledEnterAni then
			self.showActions.moveFadeIn(self)
		end

		self:initUI()
		self:updateUI()
	end)
	self.showActions.moveFadeIn(self)
end

function SupermarketShopTimeLimitSprite.initBg(arg_35_0, arg_35_1)
	return
end

function SupermarketShopTimeLimitSprite:buy(arg_36_1)
	if self.recharging then
		return
	end

	self.recharging = true

	self.rootpanel:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function(...)
		self.recharging = false
	end)))
	AnalyticManager.clickPurchaseItem({
		product = id,
		rolenum = playermodel:getOwnedServantNum(),
		grade = playermodel.grade,
		class = playermodel.class
	})
	recharge_manager:confirmPayment(arg_36_1)
end

function SupermarketShopTimeLimitSprite:initPurchaseEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("APPENTERFOREGROUND", function(arg_39_0)
		self.recharging = false
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_40_0)
		if not arg_40_0 or not arg_40_0.id then
			return
		end

		for iter_40_0, iter_40_1 in pairs(self.list) do
			if arg_40_0.id == iter_40_1.rechargeid then
				iter_40_1.have_bought = iter_40_1.have_bought + 1
			end
		end

		self.recharging = false

		supermarket_manager:updateShopTimelimitReddot(self.list)
		self:updateUI()
	end), self)
end

function SupermarketShopTimeLimitSprite:exit()
	self.hideActions.moveFadeOut(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function SupermarketShopTimeLimitSprite.test(arg_43_0)
	if not config._DEBUG then
		return
	end
end
