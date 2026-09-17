PopShopTimeLimitNewLayer = class("PopShopTimeLimitNewLayer", function()
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
local item_data = require("data.item_data")
local recharge_data = require("data.recharge_data")
local activity_shoptimelimit_uiconfig_data = require("data.activity_template_ui_conf.activity_shoptimelimit_uiconfig_data")
local var_0_17 = 11

local function var_0_21(arg_2_0, arg_2_1)
	network:rpc("recharge_from_diamond", {
		id = arg_2_0
	}, function(arg_3_0)
		if arg_3_0.result == 1 then
			for iter_3_0, iter_3_1 in pairs(arg_3_0.cost_items) do
				item_manager:deleteItem(iter_3_1.entityid, iter_3_1.num)
			end

			global_gain({
				items = arg_3_0.items,
				diamond = arg_3_0.diamond,
				gold = arg_3_0.gold,
				sp = arg_3_0.sp
			})
		elseif arg_3_0.result == 2 then
			print("recharge is not price_diamond")
		elseif arg_3_0.result == 3 then
			global_ShowBlockWords("班长等级不足")
		elseif arg_3_0.result == 4 then
			print("前置购买未解锁")
		elseif arg_3_0.result == 5 then
			print("购买次数已达上限")
		elseif arg_3_0.result == 6 then
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end

		if arg_2_1 then
			arg_2_1(arg_3_0)
		end
	end)
end

local function var_0_22(arg_4_0, arg_4_1)
	network:rpc("recharge_from_card", {
		id = arg_4_0
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			for iter_5_0, iter_5_1 in pairs(arg_5_0.cost_items) do
				item_manager:deleteItem(iter_5_1.entityid, iter_5_1.num)
			end

			global_gain({
				items = arg_5_0.items,
				diamond = arg_5_0.diamond,
				gold = arg_5_0.gold,
				sp = arg_5_0.sp
			})

			if arg_4_1 then
				arg_4_1(arg_5_0)
			end
		elseif arg_5_0.result == 2 then
			print("recharge is not price_card")
		elseif arg_5_0.result == 3 then
			global_ShowBlockWords("班长等级不足")
		elseif arg_5_0.result == 4 then
			print("前置购买未解锁")
		elseif arg_5_0.result == 5 then
			print("购买次数已达上限")
		elseif arg_5_0.result == 6 then
			LayerManager:pushInLayer("PopSupermarketLayer", {
				initSelectPage = 15,
				callback = arg_4_1
			})
		end
	end)
end

local function var_0_23(arg_6_0, arg_6_1)
	network:rpc("get_free_award", {
		id = arg_6_0
	}, function(arg_7_0)
		if arg_7_0.result == 1 then
			global_gain({
				items = arg_7_0.items,
				diamond = arg_7_0.diamond,
				gold = arg_7_0.gold,
				sp = arg_7_0.sp
			})
		elseif arg_7_0.result == 2 then
			print("空id")
		elseif arg_7_0.result == 3 then
			print("类型不为9")
		elseif arg_7_0.result == 4 then
			print("次数已达上限")
		elseif arg_7_0.result == 5 then
			print("充值金额未达到")
		end

		if arg_6_1 then
			arg_6_1(arg_7_0)
		end
	end)
end

function PopShopTimeLimitNewLayer:getUiPositionConf(arg_8_1, arg_8_2)
	if arg_8_1 == "debug" then
		return activity_shoptimelimit_uiconfig_data.debug
	end

	return activity_shoptimelimit_uiconfig_data["shoptimelimit_" .. self.uitype .. "_" .. arg_8_1] and (activity_shoptimelimit_uiconfig_data["shoptimelimit_" .. self.uitype .. "_" .. arg_8_1][arg_8_2] or activity_shoptimelimit_uiconfig_data["template_" .. self.uitype][arg_8_2]) or activity_shoptimelimit_uiconfig_data["template_" .. self.uitype][arg_8_2]
end

function PopShopTimeLimitNewLayer.create(arg_9_0, arg_9_1)
	local var_9_0 = PopShopTimeLimitNewLayer.new()

	var_9_0:initBg(arg_9_1)

	return var_9_0
end

function PopShopTimeLimitNewLayer:init(arg_10_1)
	self.initParam = arg_10_1
	self.uitype = 2
	self._obj_activity = true

	for iter_10_0, iter_10_1 in pairs(self.initParam.list) do
		if iter_10_1.dropid then
			iter_10_1.dropids = drop_manager:getDropMsg(iter_10_1.dropid).equips

			table.sort(iter_10_1.dropids, function(arg_11_0, arg_11_1)
				return arg_11_0._index < arg_11_1._index
			end)
		end
	end

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(cc.size(640, GameDisplay.height))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer)

	self.rootpanel = ccui.Layout:create()

	self.rootpanel:setContentSize(cc.size(640, GameDisplay.height))
	self.rootpanel:setTouchEnabled(false)
	self.rootLayer:addChild(self.rootpanel, 10)

	local var_10_0 = ccui.Layout:create()

	var_10_0:setContentSize(cc.size(640, GameDisplay.height))
	var_10_0:setTouchEnabled(true)
	var_10_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_10_0:setPositionY(-GameDisplay.fix_y)
	var_10_0:setName("touchLayer")
	self.rootLayer:addChild(var_10_0)
	var_10_0:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_12_0:isBright() then
			return
		end

		arg_12_0:setBright(false)
		self.hideActions.moveFadeOut(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)

	if not arg_10_1 or not arg_10_1.disabledEnterAni then
		self.showActions.moveFadeIn(self)
	end

	self:initData(function(...)
		self:updateUI()
	end)
	self:initUI()
	self:registerScriptHandler(function(arg_15_0)
		if arg_15_0 == "exit" then
			if self.initParam and self.initParam.callback then
				self.initParam.callback()
			end

			self._obj_activity = false
		end
	end)
	self:initPurchaseEventListener()
end

function PopShopTimeLimitNewLayer.initData(arg_16_0, arg_16_1)
	recharge_manager:getRechargeInfo(function(arg_17_0, arg_17_1)
		if not arg_16_0._obj_activity then
			return
		end

		if arg_17_0 == 1 then
			local var_17_0 = {}

			for iter_17_0, iter_17_1 in pairs(arg_17_1) do
				var_17_0[iter_17_1.id] = iter_17_1
			end

			for iter_17_2, iter_17_3 in pairs(arg_16_0.initParam.list) do
				if var_17_0[iter_17_3.rechargeid] then
					iter_17_3.have_bought = var_17_0[iter_17_3.rechargeid].have_bought
					iter_17_3.buy_limit = var_17_0[iter_17_3.rechargeid].buy_limit or 99999
				else
					if config._DEBUG then
						global_ShowBlockWords("兄弟充值表里没有这个吧->>>>>>" .. iter_17_3.rechargeid, cc.c3b(255, 0, 0), nil, 30, 1, 22)
						assert(var_17_0[iter_17_3.rechargeid], "兄弟充值表里没有这个吧->>>>>>" .. iter_17_3.rechargeid)
					end

					print("兄弟充值表里没有这个吧->>>>>>" .. iter_17_3.rechargeid)
				end
			end

			if arg_16_1 then
				arg_16_1()
			end
		end
	end)
end

function PopShopTimeLimitNewLayer:initUI()
	local var_18_0 = false
	local var_18_1 = 568

	for iter_18_0, iter_18_1 in pairs(self.initParam.list) do
		local var_18_2 = iter_18_1.dropids

		self.group = supermarket_manager:getShopTimeLimitGroupByID(iter_18_1.id)

		local var_18_3 = self:getUiPositionConf(iter_18_1.id, "bg")
		local var_18_4 = ccui.ImageView:create("mainScenebg/activity/shoptimelimit/" .. self.group .. "/bg_" .. iter_18_1.id .. ".png")

		var_18_4:setAnchorPoint(cc.p(0.5, 0.5))

		var_18_4.id = iter_18_1.id
		var_18_4.rechargeid = iter_18_1.rechargeid

		var_18_4:setPosition(var_18_3.pos)
		var_18_4:setTouchEnabled(true)
		var_18_4:addTouchEventListener(self:getSureBtnHangel())
		self.rootpanel:addChild(var_18_4)

		if self:getUiPositionConf("debug") then
			local var_18_5 = cc.Label:createWithTTF(iter_18_1.id, FONT_DES, 22)

			var_18_5:setPosition(cc.p(var_18_4:getContentSize().width / 2, var_18_4:getContentSize().height / 2))
			var_18_4:addChild(var_18_5)
		end

		local var_18_6 = self:getUiPositionConf(iter_18_1.id, "btn_buy")
		local var_18_7 = ccui.Button:create("mainScenebg/activity/shoptimelimit/" .. self.group .. "/btn_get_" .. iter_18_1.id .. ".png")

		var_18_7:setAnchorPoint(cc.p(0.5, 0.5))
		var_18_7:setName("btn_" .. iter_18_1.id)
		var_18_7:setPosition(var_18_6.pos or cc.p(0, 0))

		var_18_7.id = iter_18_1.id
		var_18_7.rechargeid = iter_18_1.rechargeid

		var_18_7:addTouchEventListener(self:getSureBtnHangel())
		var_18_4:addChild(var_18_7)

		var_18_1 = math.min(var_18_1, var_18_3.pos.y - var_18_4:getContentSize().height / 2)

		local var_18_8 = iter_18_1.rechargeid and recharge_manager.getProductDisplayPrice and recharge_manager:getProductDisplayPrice(iter_18_1.rechargeid) or iter_18_1.rechargeid and iter_18_1.price and "¥" .. iter_18_1.price or ""
		local var_18_9 = self:getUiPositionConf(iter_18_1.id, "label_price")
		local var_18_10 = ccui.Text:create(var_18_8, "fonts/W5.ttf", (var_18_9 or nil) and (var_18_9.size or 24))

		var_18_10:setPositionX(var_18_9.pos.x or 0)
		var_18_10:setPositionY(var_18_9.pos.y or 0)
		var_18_10:setAnchorPoint(var_18_9.anchorpoint or cc.p(0, 0))
		var_18_10:setColor(var_18_9.color or cc.c3b(113, 54, 10))
		var_18_10:setVisible(var_18_9.visible or false)

		var_18_10.visible = var_18_9.visible or false

		var_18_10:setName("priceLabel_" .. iter_18_1.id)
		var_18_4:addChild(var_18_10)

		local var_18_11 = self:getUiPositionConf(iter_18_1.id, "img_currency")
		local var_18_12 = ccui.ImageView:create("GUI/image.png", var_0_0)

		var_18_12:setPosition(var_18_11.pos)
		var_18_12:setVisible(var_18_11.visible)
		var_18_4:addChild(var_18_12)

		if iter_18_1.currency == 8888888 then
			var_18_12:loadTexture("public/currency/888888.png", var_0_0)
		elseif iter_18_1.currency then
			var_18_12:loadTexture("public/currency/" .. iter_18_1.currency .. ".png", var_0_0)
		elseif iter_18_1.rechargeid then
			var_18_12:loadTexture("public/currency/rmb_white.png", var_0_0)
		end

		if not recharge_manager.getProductDisplayPrice then
			var_18_12:setVisible(false)
		end

		local var_18_13 = self:getUiPositionConf(iter_18_1.id, "label_buycount") or {}
		local var_18_14 = ccui.Text:create("", var_18_13.font or FONT_DES, var_18_13.size or 20)

		var_18_14:setPosition(var_18_13.pos or cc.p(0, 0))
		var_18_14:setAnchorPoint(var_18_13.anchorpoint or cc.p(0.5, 0.5))
		var_18_14:setColor(var_18_13.color or cc.c3b(0, 0, 0))
		var_18_14:setVisible(var_18_13.visible or false)
		var_18_14:setName("buycountLabel_" .. iter_18_1.id)
		var_18_4:addChild(var_18_14)

		local var_18_15 = self:getUiPositionConf(iter_18_1.id, "img_title")

		if var_18_15 then
			local var_18_16 = ccui.ImageView:create("mainScenebg/activity/shoptimelimit/" .. self.group .. "/title_" .. iter_18_1.id .. ".png")

			var_18_16:setAnchorPoint(cc.p(0.5, 0.5))
			var_18_16:setPosition(var_18_15.pos)
			self.rootpanel:addChild(var_18_16)
		end

		for iter_18_2, iter_18_3 in pairs((self:getUiPositionConf(iter_18_1.id, "panel_touch"))) do
			local var_18_17 = ccui.Layout:create()

			var_18_17:setTouchEnabled(true)
			var_18_17:setContentSize(iter_18_3.size)
			var_18_17:setAnchorPoint(cc.p(0.5, 0.5))
			var_18_17:setPosition(iter_18_3.pos)
			var_18_17:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
			var_18_17:addTouchEventListener(function(arg_19_0, arg_19_1)
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
					if not var_18_2[iter_18_2] then
						return
					end

					if not item_data[var_18_2[iter_18_2].dropid] then
						return
					end

					var_19_0({
						hideGainButton = true,
						itemid = var_18_2[iter_18_2].dropid
					})
				end
			end)
			var_18_4:addChild(var_18_17, 999)

			if self:getUiPositionConf("debug") then
				var_18_17:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
				var_18_17:setBackGroundColor(cc.c3b(255, 0, 0))
				var_18_17:setOpacity(120)
			end
		end

		if recharge_data[iter_18_1.rechargeid].refreshtype == 1 then
			var_18_0 = true
		end

		self.finishTime = supermarket_manager:getShopTimeLimitFinishTime(iter_18_1.id)
	end

	print("self.group", self.group)

	if var_18_0 then
		local var_18_18 = ccui.ImageView:create((activity_shoptimelimit_uiconfig_data["refresh_tips_img_" .. self.group] or nil) and (activity_shoptimelimit_uiconfig_data["refresh_tips_img_" .. self.group].path or "mainScenebg/activity/shoptimelimit/refreshg_tips_img.png"))

		var_18_18:setPosition(cc.p(320, var_18_1 - 50))
		var_18_18:setName("refresh_tips_img")
		self.rootpanel:addChild(var_18_18)
	end

	if activity_shoptimelimit_uiconfig_data["refresh_tips_img_" .. self.group] and activity_shoptimelimit_uiconfig_data["refresh_tips_img_" .. self.group].visible ~= nil and ccui.Helper:seekWidgetByName(self.rootLayer, "refresh_tips_img") then
		ccui.Helper:seekWidgetByName(self.rootLayer, "refresh_tips_img"):setVisible(activity_shoptimelimit_uiconfig_data["refresh_tips_img_" .. self.group].visible)
		ccui.Helper:seekWidgetByName(self.rootLayer, "refresh_tips_img"):setPosition(activity_shoptimelimit_uiconfig_data["refresh_tips_img_" .. self.group].pos or cc.p(320, var_18_1 - 50))
	end

	if activity_shoptimelimit_uiconfig_data["scale_" .. self.group] then
		self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
		self.rootpanel:setPosition(cc.p(320, 568))
		self.rootpanel:setScale(activity_shoptimelimit_uiconfig_data["scale_" .. self.group])
	end

	for iter_18_4 = 1, 5 do
		if activity_shoptimelimit_uiconfig_data["otherimg_" .. self.group .. "_" .. iter_18_4] then
			local var_18_19 = ccui.ImageView:create(activity_shoptimelimit_uiconfig_data["otherimg_" .. self.group .. "_" .. iter_18_4].path)

			var_18_19:setPosition(activity_shoptimelimit_uiconfig_data["otherimg_" .. self.group .. "_" .. iter_18_4].pos)
			var_18_19:setName("otherimg_" .. iter_18_4)
			self.rootpanel:addChild(var_18_19, activity_shoptimelimit_uiconfig_data["otherimg_" .. self.group .. "_" .. iter_18_4].zorder or 1)
		end
	end

	if cc.FileUtils:getInstance():isFileExist("mainScenebg/activity/shoptimelimit/btn_close_" .. self.group .. ".png") then
		print(dump(btn_closeconf))

		local var_18_21 = ccui.Button:create("mainScenebg/activity/shoptimelimit/btn_close_" .. self.group .. ".png", nil, "mainScenebg/activity/shoptimelimit/btn_close_" .. self.group .. ".png")

		var_18_21:setPosition((activity_shoptimelimit_uiconfig_data["btn_close_" .. self.group] or nil) and (activity_shoptimelimit_uiconfig_data["btn_close_" .. self.group].pos or cc.p(600, 1100)))
		self.rootpanel:addChild(var_18_21, 100)
		var_18_21:addTouchEventListener(function(arg_21_0, arg_21_1)
			if arg_21_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:exit()
		end)
	end

	if activity_shoptimelimit_uiconfig_data["particle_" .. self.group] then
		self.rootpanel:addChild(cc.ParticleSystemQuad:create("effect/particle/" .. activity_shoptimelimit_uiconfig_data["particle_" .. self.group].path), 1000)
	end

	if activity_shoptimelimit_uiconfig_data["surplus_time_" .. self.group] then
		local var_18_22 = activity_shoptimelimit_uiconfig_data["surplus_time_" .. self.group]
		local var_18_23 = global_get_finishtime_str(self.finishTime, time_check_manager:getCurTime())
		local var_18_24 = cc.Label:createWithTTF(var_18_23, FONT_DES, 22)

		var_18_24:setPositionX(activity_shoptimelimit_uiconfig_data["surplus_time_" .. self.group].pos.x or 0)
		var_18_24:setPositionY(var_18_22.pos.y or 0)
		var_18_24:setScaleX((var_18_22.scale or nil) and (var_18_22.scale.x or 1))
		var_18_24:setScaleY((var_18_22.scale or nil) and (var_18_22.scale.y or 1))
		var_18_24:setAnchorPoint(var_18_22.anchorpoint or cc.p(0, 0))
		var_18_24:setVisible(var_18_22.visible or false)
		var_18_24:setColor(var_18_22.color or cc.c3b(255, 255, 255))
		var_18_24:setName("time_" .. self.group)
		self.rootpanel:addChild(var_18_24, 2)

		if activity_shoptimelimit_uiconfig_data["surplus_time_" .. self.group .. "_shade"] then
			local var_18_25 = activity_shoptimelimit_uiconfig_data["surplus_time_" .. self.group .. "_shade"]
			local var_18_26 = cc.Label:createWithTTF(var_18_23, FONT_DES, 22)

			var_18_26:setPositionX(activity_shoptimelimit_uiconfig_data["surplus_time_" .. self.group .. "_shade"].pos.x or 0)
			var_18_26:setPositionY(var_18_25.pos.y or 0)
			var_18_26:setScaleX((var_18_25.scale or nil) and (var_18_25.scale.x or 1))
			var_18_26:setScaleY((var_18_25.scale or nil) and (var_18_25.scale.y or 1))
			var_18_26:setAnchorPoint(var_18_25.anchorpoint or cc.p(0, 0))
			var_18_26:setVisible(var_18_25.visible or false)
			var_18_26:setColor(var_18_25.color or cc.c3b(255, 255, 255))
			var_18_26:setName("timeshade" .. self.group)
			self.rootpanel:addChild(var_18_26)
		end
	end
end

function PopShopTimeLimitNewLayer.getSureBtnHangel(arg_22_0)
	return function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.click_shop_limit_new({
			id = arg_23_0.id
		})

		for iter_23_0, iter_23_1 in pairs(arg_22_0.initParam.list) do
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

		if recharge_data[arg_23_0.rechargeid].type == var_0_17 then
			arg_23_0:setBright(false)
			var_0_23(arg_23_0.id, function(arg_24_0)
				if arg_24_0 and arg_24_0.result == 1 then
					for iter_24_0, iter_24_1 in pairs(arg_22_0.initParam.list) do
						if iter_24_1.id == arg_23_0.id then
							iter_24_1.have_bought = iter_24_1.have_bought + 1
						end
					end

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
					var_0_21(arg_23_0.id, function(arg_26_0)
						if arg_26_0.result == 1 then
							for iter_26_0, iter_26_1 in pairs(arg_22_0.initParam.list) do
								if iter_26_1.id == arg_23_0.id then
									iter_26_1.have_bought = iter_26_1.have_bought + 1
								end
							end

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
					var_0_22(arg_23_0.id, function(arg_28_0)
						if arg_28_0 and arg_28_0.result == 1 then
							for iter_28_0, iter_28_1 in pairs(arg_22_0.initParam.list) do
								if iter_28_1.id == arg_23_0.id then
									iter_28_1.have_bought = iter_28_1.have_bought + 1
								end
							end

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

function PopShopTimeLimitNewLayer:updateUI()
	for iter_29_0, iter_29_1 in pairs(self.initParam.list) do
		if not iter_29_1.have_bought then
			print(dump(iter_29_1))
		end

		if iter_29_1.have_bought >= iter_29_1.buy_limit then
			ccui.Helper:seekWidgetByName(self.rootLayer, "btn_" .. iter_29_1.id):loadTextures("mainScenebg/activity/shoptimelimit/" .. self.group .. "/btn_got_" .. iter_29_1.id .. ".png", "mainScenebg/activity/shoptimelimit/" .. self.group .. "/btn_got_" .. iter_29_1.id .. ".png", "mainScenebg/activity/shoptimelimit/" .. self.group .. "/btn_got_" .. iter_29_1.id .. ".png")

			if ccui.Helper:seekWidgetByName(self.rootLayer, "priceLabel_" .. iter_29_1.id) then
				ccui.Helper:seekWidgetByName(self.rootLayer, "priceLabel_" .. iter_29_1.id):setVisible(false)
			end
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "btn_" .. iter_29_1.id):loadTextures("mainScenebg/activity/shoptimelimit/" .. self.group .. "/btn_get_" .. iter_29_1.id .. ".png", "mainScenebg/activity/shoptimelimit/" .. self.group .. "/btn_get_" .. iter_29_1.id .. ".png", "mainScenebg/activity/shoptimelimit/" .. self.group .. "/btn_get_" .. iter_29_1.id .. ".png")

			if ccui.Helper:seekWidgetByName(self.rootLayer, "priceLabel_" .. iter_29_1.id).visible == false then
				ccui.Helper:seekWidgetByName(self.rootLayer, "priceLabel_" .. iter_29_1.id):setVisible(false)
			end
		end

		local var_29_0 = iter_29_1.rechargeid
		local var_29_1 = self:getUiPositionConf(iter_29_1.id, "label_buycount")

		if recharge_data[iter_29_1.rechargeid].refreshtype == 1 then
			ccui.Helper:seekWidgetByName(self.rootLayer, "buycountLabel_" .. iter_29_1.id):setString("(" .. L_TODAY_BUY_LIMIT .. iter_29_1.have_bought .. "/" .. iter_29_1.buy_limit .. ")")
		elseif recharge_data[var_29_0].refreshtype == 2 then
			ccui.Helper:seekWidgetByName(self.rootLayer, "buycountLabel_" .. iter_29_1.id):setString("(" .. L_TOWEEK_BUY_LIMIT .. iter_29_1.have_bought .. "/" .. iter_29_1.buy_limit .. ")")
		elseif recharge_data[var_29_0].refreshtype == 3 then
			ccui.Helper:seekWidgetByName(self.rootLayer, "buycountLabel_" .. iter_29_1.id):setString("(" .. L_TOMONTH_BUY_LIMIT .. iter_29_1.have_bought .. "/" .. iter_29_1.buy_limit .. ")")
		elseif not recharge_data[var_29_0].refreshtype then
			ccui.Helper:seekWidgetByName(self.rootLayer, "buycountLabel_" .. iter_29_1.id):setString("(" .. L_BUY_LIMIT .. "：" .. iter_29_1.have_bought .. "/" .. iter_29_1.buy_limit .. ")")
		end

		if var_29_1 and var_29_1.str then
			ccui.Helper:seekWidgetByName(self.rootLayer, "buycountLabel_" .. iter_29_1.id):setVisible(true)
			ccui.Helper:seekWidgetByName(self.rootLayer, "buycountLabel_" .. iter_29_1.id):setString(var_29_1.str)
		end

		if iter_29_1.buy_limit == 99999 then
			ccui.Helper:seekWidgetByName(self.rootLayer, "buycountLabel_" .. iter_29_1.id):setVisible(false)
		end
	end
end

function PopShopTimeLimitNewLayer:initBg(arg_30_1)
	local var_30_0 = ccui.Layout:create()

	var_30_0:setTouchEnabled(false)
	var_30_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_30_0:setAnchorPoint(cc.p(0, 0))
	var_30_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_30_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_30_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_30_0:setOpacity(0)
	self:addChild(var_30_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_31_0)
		self:addChild(arg_31_0, -2)
		arg_31_0:setPositionY(arg_31_0:getPositionY() - GameDisplay.fix_y)

		local var_31_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_31_0:setAnchorPoint(cc.p(0, 0))
		var_31_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_31_0, -1)
		self:init(arg_30_1)
		var_30_0:setOpacity(102)
		var_30_0:setTouchEnabled(false)
	end)
end

function PopShopTimeLimitNewLayer:buy(arg_32_1)
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
	recharge_manager:confirmPayment(arg_32_1)
end

function PopShopTimeLimitNewLayer:initPurchaseEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("APPENTERFOREGROUND", function(arg_35_0)
		self.recharging = false
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_36_0)
		if not arg_36_0 or not arg_36_0.id then
			return
		end

		for iter_36_0, iter_36_1 in pairs(self.initParam.list) do
			if arg_36_0.id == iter_36_1.rechargeid then
				iter_36_1.have_bought = iter_36_1.have_bought + 1
			end
		end

		self.recharging = false

		self:updateUI()
	end), self)
end

function PopShopTimeLimitNewLayer:exit()
	self.hideActions.moveFadeOut(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopShopTimeLimitNewLayer.test(arg_39_0)
	if not config._DEBUG then
		return
	end

	for iter_39_0, iter_39_1 in pairs(recharge_data) do
		if iter_39_1.iosid and iter_39_1.iosid ~= "jieri01" and iter_39_1.iosid ~= "jieri02" and (tonumber(string.match(iter_39_1.iosid, "[0-9]+")) < 14 or tonumber(string.match(iter_39_1.iosid, "[0-9]+")) > 23) then
			if string.find(iter_39_1.iosid, "[a-z]") then
				global_ShowBlockWords("充值表的iosid必须为纯数字字符串\n请联系对应负责人赶快改掉", cc.c3b(255, 0, 0), nil, 10000, 1, 22)
				print("充值表的iosid必须为数字请联系对应负责人赶快改掉")

				return
			end

			if iter_39_1.id ~= 154001 and iter_39_1.id ~= 154002 and iter_39_1.id ~= 154003 and iter_39_1.id ~= 154004 and iter_39_1.id ~= 154005 and iter_39_1.id ~= 154006 and (iter_39_1.id ~= tonumber(string.match(iter_39_1.productid, "[0-9]+")) or iter_39_1.id ~= tonumber(iter_39_1.iosid)) then
				print("充值表的id、iosid、productid数字必须要对应！请联系对应负责人赶快改掉")
				global_ShowBlockWords("充值表的" .. iter_39_1.id .. " id、iosid、productid数字必须要对应！\n请联系对应负责人赶快改掉", cc.c3b(255, 0, 0), nil, 10000, 1, 22)

				return
			end
		end
	end
end

function PopShopTimeLimitNewLayer.createBaseClass(arg_40_0, arg_40_1)
	local var_40_0 = PopShopTimeLimitNewLayer.new()

	var_40_0:init(arg_40_1)
	var_40_0.rootLayer:getChildByName("touchLayer"):setTouchEnabled(false)

	return var_40_0
end

PopShopTimeLimitRechargeIconLayer = class("PopShopTimeLimitRechargeIconLayer", function(...)
	return PopShopTimeLimitNewLayer:createBaseClass(...)
end)

function PopShopTimeLimitRechargeIconLayer.create(arg_42_0, arg_42_1)
	return (PopShopTimeLimitRechargeIconLayer.new(arg_42_1))
end
