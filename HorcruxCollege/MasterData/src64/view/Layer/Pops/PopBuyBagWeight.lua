PopBuyBagWeight = class("PopBuyBagWeight", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local diamond_update_data = require("data.diamond_update_data")
local playermodel = require("model.playermodel")

function PopBuyBagWeight.create(arg_2_0, arg_2_1)
	local var_2_0 = PopBuyBagWeight.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopBuyBagWeight:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Popup_small.json" or "Popup_small.ExportJson")

	self:addChild(self.rootLayer)

	arg_3_1.remaintimes = BAG_MAX_ADD_TIME[arg_3_1.weightid] - arg_3_1.time
	arg_3_1.totaltimes = BAG_MAX_ADD_TIME[arg_3_1.weightid]
	arg_3_1.costtype = "diamond"
	arg_3_1.own = playermodel.diamond
	arg_3_1.cost = diamond_update_data[50000 + arg_3_1.weightid * 1000 + arg_3_1.time + 1].costdiamond
	arg_3_1.labels = L_ADD_BAGLIMIT_COMPONENT(arg_3_1.weightid)
	self.msg = arg_3_1
	self.maxBuy = arg_3_1.remaintimes
	self.curBuy = 1
	self.panel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_back")
	self.panel_all = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_all")
	self.rootpanel = self.panel
	self.panel_bg = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")
	self.title = ccui.Helper:seekWidgetByName(self.rootLayer, "title")
	self.Image_title = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_title")
	self.des = ccui.Helper:seekWidgetByName(self.rootLayer, "title_des")
	self.more = ccui.Helper:seekWidgetByName(self.rootLayer, "title_more")
	self.cost_num = ccui.Helper:seekWidgetByName(self.rootLayer, "label_cost_num_gold")
	self.confirm_button = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")
	self.confirm_button_label = self.confirm_button:getChildByName("label")
	self.system_figure = ccui.Helper:seekWidgetByName(self.rootLayer, "image_system_figure")

	self.confirm_button:loadTextures("public/button/public_button_normal_y.png", nil, "public/button/public_button_normal_y.png", var_0_0)
	self.confirm_button:setPositionX(524)
	self.confirm_button_label:setPositionX(self.confirm_button:getContentSize().width / 2)
	self.confirm_button_label:setPositionY(self.confirm_button:getContentSize().height / 2)
	self.cost_num:setPositionX(self.confirm_button:getPositionX() + 20)
	self.cost_num:setPositionX(self.confirm_button:getPositionX())
	self.des:setTextAreaSize(cc.size(self.des:getParent():getContentSize().width, 0))
	self.des:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	self.des:setAnchorPoint(cc.p(0.5, 1))
	self.des:setPositionY(652)
	self.confirm_button:setPressedActionEnabled(true)
	self.panel:setAnchorPoint(cc.p(0.5, 0.5))
	self.panel:setPosition(cc.p(320, GameDisplay.height / 2))
	self.panel_all:setContentSize(GameDisplay.width, GameDisplay.height)
	self.panel_all:setPositionY(-GameDisplay.fix_y)
	self.showActions.extendVertical(self)
	self:initPop()

	self.cancelcallback = arg_3_1.cancelcallback

	self.panel_all:setTouchEnabled(true)
	self.panel_all:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)

		if arg_3_1.cancelcallback then
			arg_3_1.cancelcallback()
		end
	end)
	self:initProgress()
end

function PopBuyBagWeight:initPop()
	local var_5_0 = self.msg

	if self.msg.labels and self.msg.system_figure then
		if self.msg.system_figure:find("role1") then
			self.system_figure:loadTexture(self.msg.system_figure)
		else
			self.system_figure:loadTexture(self.msg.system_figure, var_0_0)
		end
	else
		self.system_figure:setVisible(false)
	end

	if self.msg.labels and self.msg.labels.titleImage or self.msg.labels.titleNewImage then
		self.Image_title:loadTexture(self.msg.labels.titleNewImage or "public/panelbg/" .. self.msg.labels.titleImage, var_0_0)
		self.Image_title:setPosition(cc.p(self.panel_bg:getPositionX() - self.panel_bg:getContentSize().width / 2 - 5, self.Image_title:getPositionY() - 18))
		self.Image_title:setVisible(true)
		self.title:setVisible(false)
	elseif self.msg.labels and self.msg.labels.title then
		self.title:setString(self.msg.labels.title)
		self.Image_title:setVisible(false)
	else
		self.Image_title:setVisible(false)
		self.title:setVisible(false)
	end

	if self.msg.labels and self.msg.labels.des then
		self.deslabel = cc.Label:createWithTTF(self.msg.labels.des, "fonts/number.ttf", 27)

		self.deslabel:setColor(cc.c3b(243, 249, 255))
		self.deslabel:setAnchorPoint(cc.p(0, 0.5))
		self.deslabel:setMaxLineWidth(480)
		self.deslabel:setPosition(cc.p(90, 100))
		self.panel_bg:addChild(self.deslabel)
		self.des:setVisible(false)
	else
		self.des:setVisible(false)
	end

	if self.msg.labels and self.msg.labels.button then
		self.confirm_button_label:setString(self.msg.labels.button)
	end

	if self.msg.labels and self.msg.labels.more then
		self.more:setString(self.msg.labels.more)
	else
		self.more:setVisible(false)
	end

	if not self.msg.cost then
		self.cost_num:setVisible(false)
		self.confirm_button_label:setFontSize(32)

		local var_5_2, var_5_3 = self.confirm_button_label:getPosition()

		self.confirm_button_label:setPosition(var_5_2, var_5_3)
	elseif self.msg.cost == 0 then
		self.cost_num:setString(L_FREE_FOR_CHARGE)
		self.cost_num:setPosition(320, self.confirm_button:getPositionY() - self.confirm_button:getContentSize().height / 2 - self.cost_num:getContentSize().height / 2)
		self.cost_num:getChildByName("image_gold"):setVisible(false)
	else
		local var_5_4 = self.cost_num:getChildByName("image_gold")
		local var_5_5

		if self.msg.costtype == "diamond" then
			var_5_5 = IMAGE_DIAMOND

			var_5_4:loadTexture(IMAGE_DIAMOND, var_0_0)
			self.cost_num:setString("X" .. self.msg.cost)
			var_5_4:setScale(1)
			var_5_4:setPosition(cc.p(-(string.len(self.msg.cost) * 12) - 5, 14))
		elseif self.msg.costtype == "gold" then
			var_5_5 = IMAGE_GOLD

			var_5_4:loadTexture(IMAGE_GOLD, var_0_0)
			self.cost_num:setString("X" .. self.msg.cost)
			var_5_4:setScale(1)
			var_5_4:setPosition(cc.p(-(string.len(self.msg.cost) * 12) - 5, 14))
		elseif type(self.msg.costtype) == "number" then
			if self.msg.costtype ~= 201912005 then
				var_5_5 = "public/currency/" .. self.msg.costtype .. ".png"

				var_5_4:loadTexture("public/currency/" .. self.msg.costtype .. ".png", var_0_0)
			else
				var_5_5 = "equipment/" .. "2101000" .. ".png"

				var_5_4:loadTexture("equipment/" .. "2101000" .. ".png")
				var_5_4:setScale(0.3)
			end

			self.cost_num:setString(self.msg.own .. "/" .. self.msg.cost)
			var_5_4:setPosition(cc.p(-(string.len(self.msg.cost) * 12) - 5, 14))
		end

		if self.msg.cost_old then
			local var_5_6 = var_5_4:getParent()
			local var_5_7 = cc.p(var_5_4:getPosition())
			local var_5_8

			if config._DEBUG then
				var_5_8 = cc.Sprite:create(var_5_5) or cc.Sprite:createWithSpriteFrameName(var_5_5)
			end

			var_5_8:setScale(var_5_4:getScale())
			var_5_8:setPositionX(var_5_7.x + 15)
			var_5_8:setPositionY(var_5_7.y - var_5_4:getBoundingBox().height - 20)
			var_5_6:addChild(var_5_8, 10)

			local var_5_9 = cc.Label:createWithTTF(self.msg.cost_old, FONT_DES, 23)

			var_5_9:setAnchorPoint(cc.p(0, 0.5))
			var_5_9:setPositionX(var_5_8:getPositionX() + var_5_8:getBoundingBox().width / 2 + 5)
			var_5_9:setPositionY(var_5_8:getPositionY())
			var_5_6:addChild(var_5_9, 10)

			local var_5_10 = ccui.ImageView:create("public/currency/discount_line.png", var_0_0)

			var_5_10:setPositionX((var_5_8:getPositionX() + var_5_9:getPositionX() + var_5_9:getContentSize().width / 2) / 2)
			var_5_10:setPositionY(var_5_8:getPositionY())
			var_5_6:addChild(var_5_10, 11)
		end
	end

	if self.msg.photo then
		local var_5_11 = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")
		local var_5_12 = ccui.ImageView:create(self.msg.photo, var_0_0)

		var_5_12:setAnchorPoint(cc.p(0.5, 0.5))
		var_5_12:setPosition(cc.p(var_5_11:getContentSize().width / 2, var_5_12:getContentSize().height / 2 + 100))
		var_5_11:addChild(var_5_12)
	end

	local var_5_13 = self.confirm_button

	if self.msg.remaintimes and self.msg.remaintimes <= 0 then
		var_5_13:loadTextures("public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", var_0_0)
		self.cost_num:setVisible(false)
		var_5_13:addTouchEventListener(function(arg_6_0, arg_6_1)
			if arg_6_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(L_NO_TIMES)
		end)
	elseif self.msg.cost and self.msg.own < self.msg.cost and not self.msg.ignorecost then
		if self.msg.costtype == "diamond" then
			var_5_13:addTouchEventListener(function(arg_7_0, arg_7_1)
				if arg_7_1 ~= ccui.TouchEventType.ended then
					return
				end

				if var_5_0.cancelcallback then
					var_5_0.cancelcallback()
				end

				LayerManager:removePopLayer(self.__queueindex)

				if var_5_0.is_need_pop_layer == 1 then
					-- block empty
				else
					var_5_0.is_need_pop_layer = 0
				end

				local var_7_1 = {
					is_need_pop_layer = var_5_0.is_need_pop_layer
				}

				LayerManager:removePopLayer()
				LayerManager:pushInLayer("PopGoBuyDiamond", var_7_1)
			end)
		elseif self.msg.costtype == "gold" then
			var_5_13:addTouchEventListener(function(arg_8_0, arg_8_1)
				if arg_8_1 ~= ccui.TouchEventType.ended then
					return
				end

				if var_5_0.cancelcallback then
					var_5_0.cancelcallback()
				end

				LayerManager:removePopLayer()
				LayerManager:pushInLayer("PopGoGainLayer", {
					item = "gold"
				})
			end)
		else
			var_5_13:addTouchEventListener(function(arg_9_0, arg_9_1)
				if arg_9_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_9_0:isBright() then
					return
				end

				if arg_9_1 ~= ccui.TouchEventType.ended and var_5_0.isguide == nil then
					return
				end

				arg_9_0:setBright(false)
				LayerManager:removePopLayer(self.__queueindex)

				if var_5_0.surecallback then
					var_5_0.surecallback(self.curBuy)
				end
			end)
		end
	else
		var_5_13:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_10_0:isBright() then
				return
			end

			if arg_10_1 ~= ccui.TouchEventType.ended and var_5_0.isguide == nil then
				return
			end

			arg_10_0:setBright(false)
			LayerManager:removePopLayer(self.__queueindex)

			if var_5_0.surecallback then
				var_5_0.surecallback(self.curBuy)
			end
		end)
	end

	if self.msg.other_bnt then
		local var_5_14 = var_5_13:clone()

		var_5_14:loadTextures(self.msg.other_bnt, nil, self.msg.other_bnt, var_0_0)
		var_5_14:setPositionX(200)
		var_5_14:setContentSize(cc.size(200, 80))
		var_5_14:getChildByName("label"):setString(L_BUTTON_TEXT.Cancel)
		var_5_14:getChildByName("label"):setPosition(var_5_14:getContentSize().width / 2, var_5_14:getContentSize().height / 2)
		var_5_13:getParent():addChild(var_5_14)
		var_5_14:addTouchEventListener(cb_ExitNotice)
		var_5_13:setContentSize(cc.size(200, 80))
		var_5_13:setPositionX(440)
		confirm_button_label:setPosition(var_5_13:getContentSize().width / 2, var_5_13:getContentSize().height / 2)
	end

	local var_5_15, var_5_16 = self.panel:getPosition()

	self.panel:setPosition(var_5_15, var_5_16 + 10)
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.FadeTo:create(0.2, 255))
	self.panel:runAction(cc.MoveTo:create(0.2, cc.p(var_5_15, var_5_16)))
end

function PopBuyBagWeight:initProgress(...)
	local var_11_0 = ccui.Layout:create()

	var_11_0:setTouchEnabled(true)
	var_11_0:setContentSize(cc.size(640, 160))
	var_11_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_11_0:setPosition(cc.p(320, self.confirm_button:getPositionY()))
	var_11_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_11_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_11_0:setBackGroundColorOpacity(180)
	self.rootpanel:addChild(var_11_0)

	self.progress = ccui.Button:create("public/panelbg/bag_blue_slider_bottom.png", "public/panelbg/bag_blue_slider_bottom.png", "public/panelbg/bag_blue_slider_bottom.png", var_0_0)

	self.progress:setPositionX(200)
	self.progress:setPositionY(self.confirm_button:getPositionY())

	function self.progress.update()
		self.progressbar:setScaleX(self.curBuy / self.maxBuy)
		self.progressPoint:setPositionX(self.progress:getContentSize().width * self.curBuy / self.maxBuy)
		self.curBuyLabel:setString(self.curBuy .. "/" .. self.maxBuy)

		local var_12_0 = 0

		for iter_12_0 = 1, self.curBuy do
			var_12_0 = var_12_0 + diamond_update_data[50000 + self.msg.weightid * 1000 + self.msg.time + iter_12_0].costdiamond
		end

		self.cost_num:setString("X" .. var_12_0)
		self.deslabel:setString((string.gsub(self.msg.labels.des, "%d+", self.curBuy * 20)))
	end

	self.progress:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 == ccui.TouchEventType.moved then
			local var_13_0 = arg_13_0:getTouchBeganPosition()

			self.curBuy = math.floor(self.maxBuy * (arg_13_0:convertToNodeSpace((arg_13_0:getTouchMovePosition())).x / arg_13_0:getContentSize().width))
			self.curBuy = math.max(self.curBuy, 1)
			self.curBuy = math.min(self.curBuy, self.maxBuy)

			self.progress:update()

			return
		elseif arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curBuy = math.floor(self.maxBuy * (arg_13_0:convertToNodeSpace((arg_13_0:getTouchEndPosition())).x / arg_13_0:getContentSize().width))

		self.progress:update()
	end)

	self.progressbar = ccui.Button:create("public/panelbg/bag_blue_slider_bar.png", "public/panelbg/bag_blue_slider_bar.png", "public/panelbg/bag_blue_slider_bar.png", var_0_0)

	self.progressbar:setPositionX(self.progress:getPositionX() - self.progress:getContentSize().width / 2)
	self.progressbar:setPositionY(self.confirm_button:getPositionY())
	self.progressbar:setTouchEnabled(false)
	self.progressbar:setAnchorPoint(cc.p(0, 0.5))
	self.progressbar:setScaleX(self.curBuy / self.maxBuy)
	self.rootpanel:addChild(self.progressbar, 10)

	self.progressPoint = ccui.ImageView:create("public/button/blue_slider_node.png", var_0_0)

	self.progressPoint:setPositionX(self.curBuy / self.maxBuy * self.progress:getContentSize().width)
	self.progressPoint:setPositionY(self.progress:getContentSize().height / 2)
	self.progress:addChild(self.progressPoint, 20)

	self.subbtn = ccui.Button:create("public/button/sub_blue_btn.png", nil, "public/button/sub_blue_btn.png", var_0_0)

	self.subbtn:setPositionX(self.progress:getPositionX() - self.progress:getContentSize().width / 2 - self.subbtn:getContentSize().width)
	self.subbtn:setPositionY(self.progress:getPositionY())
	self.rootpanel:addChild(self.subbtn)

	self.addbtn = ccui.Button:create("public/button/add_blue_btn.png", nil, "public/button/add_blue_btn.png", var_0_0)

	self.addbtn:setPositionX(self.progress:getPositionX() + self.progress:getContentSize().width / 2 + self.addbtn:getContentSize().width)
	self.addbtn:setPositionY(self.progress:getPositionY())
	self.rootpanel:addChild(self.addbtn)

	self.curBuyLabel = cc.Label:createWithTTF("", FONT_DES, 24)

	self.curBuyLabel:setPositionX(self.progress:getPositionX())
	self.curBuyLabel:setPositionY(self.progress:getPositionY() + 20)
	self.rootpanel:addChild(self.curBuyLabel)
	self.curBuyLabel:setString(self.curBuy .. "/" .. self.maxBuy)
	self.subbtn:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curBuy = self.curBuy - 1
		self.curBuy = math.max(1, self.curBuy)

		self.progress:update()
	end)
	self.addbtn:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curBuy = self.curBuy + 1
		self.curBuy = math.min(self.curBuy, self.maxBuy)

		self.progress:update()
	end)
	self.rootpanel:addChild(self.progress)

	local var_11_1 = 0

	for iter_11_0 = 1, self.curBuy do
		var_11_1 = var_11_1 + diamond_update_data[50000 + self.msg.weightid * 1000 + self.msg.time + iter_11_0].costdiamond
	end

	self.cost_num:setString("X" .. var_11_1)
	self.deslabel:setString((string.gsub(self.msg.labels.des, "%d+", self.curBuy * 20)))
end

function PopBuyBagWeight:exit()
	LayerManager:removePopLayer(self.__queueindex)

	if self.cancelcallback then
		self.cancelcallback()
	end
end
