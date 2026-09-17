PopDoLayer = class("PopDoLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

function PopDoLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopDoLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopDoLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Popup_small.json" or "Popup_small.ExportJson")

	self:addChild(self.rootLayer)

	self.msg = arg_3_1
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

	if arg_3_1.confirm_button_path then
		self.confirm_button:loadTextures(arg_3_1.confirm_button_path, arg_3_1.confirm_button_path, arg_3_1.confirm_button_path, var_0_0)
	end

	if arg_3_1.labels.break_remake_bg then
		self.panel_bg:loadTexture(arg_3_1.labels.break_remake_bg, var_0_0)
		self.confirm_button:setPositionY(self.confirm_button:getPositionY() - 30)
	end

	self.confirm_button_label = self.confirm_button:getChildByName("label")
	self.system_figure = ccui.Helper:seekWidgetByName(self.rootLayer, "image_system_figure")

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
end

function PopDoLayer:initPop()
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
		local var_5_2 = cc.Label:createWithTTF(self.msg.labels.des, "fonts/number.ttf", 27)

		var_5_2:setColor(cc.c3b(243, 249, 255))

		if self.msg.labels.isHorizonalCenter then
			var_5_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_5_2:setPosition(cc.p(self.panel_bg:getContentSize().width / 2, 100))
		else
			var_5_2:setAnchorPoint(cc.p(0, 0.5))
			var_5_2:setPosition(cc.p(90, 100))
		end

		var_5_2:setMaxLineWidth(480)
		var_5_2:setName("label1")
		self.panel_bg:addChild(var_5_2)
		self.des:setVisible(false)
	else
		self.des:setVisible(false)
	end

	if self.msg.labels and self.msg.labels.des2 then
		local var_5_3 = cc.Label:createWithTTF(self.msg.labels.des2, "fonts/number.ttf", 27)

		var_5_3:setColor(cc.c3b(243, 249, 255))

		if self.msg.labels.isHorizonalCenter then
			var_5_3:setAnchorPoint(cc.p(0.5, 0.5))
			var_5_3:setPosition(cc.p(self.panel_bg:getContentSize().width / 2, 85))
			self.panel_bg:getChildByName("label1"):setPosition(cc.p(self.panel_bg:getContentSize().width / 2, 115))
		else
			var_5_3:setAnchorPoint(cc.p(0, 0.5))
			var_5_3:setPosition(cc.p(90, 85))
			self.panel_bg:getChildByName("label1"):setPosition(cc.p(90, 115))
		end

		var_5_3:setMaxLineWidth(480)
		self.panel_bg:addChild(var_5_3)
	end

	if self.msg.labels and self.msg.labels.button then
		self.confirm_button_label:setString(self.msg.labels.button)
	end

	if self.msg.labels and self.msg.labels.more then
		self.more:setString(self.msg.labels.more)
	else
		self.more:setVisible(false)
	end

	if self.msg.costitem then
		local var_5_4 = self.cost_num:getChildByName("image_gold")

		var_5_4:loadTexture(IMAGE_SIGN_TICK, var_0_0)
		self.cost_num:setString("X" .. 1)
		var_5_4:setScale(0.3)
		var_5_4:setPosition(cc.p(-(string.len(20) * 12) - 5, 14))
	elseif not self.msg.cost then
		self.cost_num:setVisible(false)
		self.confirm_button_label:setFontSize(32)

		local var_5_5, var_5_6 = self.confirm_button_label:getPosition()

		self.confirm_button_label:setPosition(var_5_5, var_5_6)
	elseif self.msg.cost == 0 then
		self.cost_num:setString(L_FREE_FOR_CHARGE)
		self.cost_num:setPosition(320, self.confirm_button:getPositionY() - self.confirm_button:getContentSize().height / 2 - self.cost_num:getContentSize().height / 2)
		self.cost_num:getChildByName("image_gold"):setVisible(false)
	else
		print(self.msg.costtype)

		local var_5_7 = self.cost_num:getChildByName("image_gold")
		local var_5_8

		if self.msg.costtype == "diamond" then
			var_5_8 = IMAGE_DIAMOND

			var_5_7:loadTexture(IMAGE_DIAMOND, var_0_0)
			self.cost_num:setString("X" .. self.msg.cost)
			var_5_7:setScale(1)
			var_5_7:setPosition(cc.p(-(string.len(self.msg.cost) * 12) - 5, 14))
		elseif self.msg.costtype == "gold" then
			var_5_8 = IMAGE_GOLD

			var_5_7:loadTexture(IMAGE_GOLD, var_0_0)
			self.cost_num:setString("X" .. self.msg.cost)
			var_5_7:setScale(1)
			var_5_7:setPosition(cc.p(-(string.len(self.msg.cost) * 12) - 5, 14))
		elseif type(self.msg.costtype) == "number" then
			if self.msg.costtype ~= 201912005 then
				var_5_8 = "public/currency/" .. self.msg.costtype .. ".png"

				var_5_7:loadTexture("public/currency/" .. self.msg.costtype .. ".png", var_0_0)
			else
				var_5_8 = "equipment/" .. "2101000" .. ".png"

				var_5_7:loadTexture("equipment/" .. "2101000" .. ".png")
				var_5_7:setScale(0.3)
			end

			if not self.msg.hideown then
				self.cost_num:setString(self.msg.own .. "/" .. self.msg.cost)
			else
				self.cost_num:setString("X" .. self.msg.cost)
			end

			var_5_7:setPosition(cc.p(-(string.len(self.msg.cost) * 12) - 5, 14))
		end

		if self.msg.cost_old then
			local var_5_9 = var_5_7:getParent()
			local var_5_10 = cc.p(var_5_7:getPosition())
			local var_5_11

			if config._DEBUG then
				var_5_11 = cc.Sprite:create(var_5_8) or cc.Sprite:createWithSpriteFrameName(var_5_8)
			end

			var_5_11:setScale(var_5_7:getScale())
			var_5_11:setPositionX(var_5_10.x + 15)
			var_5_11:setPositionY(var_5_10.y - var_5_7:getBoundingBox().height - 20)
			var_5_9:addChild(var_5_11, 10)

			local var_5_12 = cc.Label:createWithTTF(self.msg.cost_old, FONT_DES, 23)

			var_5_12:setAnchorPoint(cc.p(0, 0.5))
			var_5_12:setPositionX(var_5_11:getPositionX() + var_5_11:getBoundingBox().width / 2 + 5)
			var_5_12:setPositionY(var_5_11:getPositionY())
			var_5_9:addChild(var_5_12, 10)

			local var_5_13 = ccui.ImageView:create("public/currency/discount_line.png", var_0_0)

			var_5_13:setPositionX((var_5_11:getPositionX() + var_5_12:getPositionX() + var_5_12:getContentSize().width / 2) / 2)
			var_5_13:setPositionY(var_5_11:getPositionY())
			var_5_9:addChild(var_5_13, 11)
		end
	end

	if self.msg.photo then
		local var_5_14 = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")
		local var_5_15 = ccui.ImageView:create(self.msg.photo, var_0_0)

		var_5_15:setAnchorPoint(cc.p(0.5, 0.5))
		var_5_15:setPosition(cc.p(var_5_14:getContentSize().width / 2, var_5_15:getContentSize().height / 2 + 100))
		var_5_14:addChild(var_5_15)
	end

	local var_5_16 = self.confirm_button

	if self.msg.remaintimes and self.msg.remaintimes <= 0 then
		var_5_16:loadTextures("public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", var_0_0)
		self.cost_num:setVisible(false)
		var_5_16:addTouchEventListener(function(arg_6_0, arg_6_1)
			if arg_6_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(L_NO_TIMES)
		end)
	elseif self.msg.cost and self.msg.own < self.msg.cost and not self.msg.ignorecost then
		if self.msg.costtype == "diamond" then
			var_5_16:addTouchEventListener(function(arg_7_0, arg_7_1)
				if arg_7_1 ~= ccui.TouchEventType.ended then
					return
				end

				if var_5_0.cancelcallback then
					var_5_0.cancelcallback({
						issure = true
					})
				end

				LayerManager:removePopLayer(self.__queueindex)

				if var_5_0.is_need_pop_layer == 1 then
					-- block empty
				else
					var_5_0.is_need_pop_layer = 0
				end

				LayerManager:pushInLayer("PopGoBuyDiamond", {
					is_need_pop_layer = var_5_0.is_need_pop_layer
				})
			end)
		elseif self.msg.costtype == "gold" then
			var_5_16:addTouchEventListener(function(arg_8_0, arg_8_1)
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
		elseif self.msg.costtype == 6800601 then
			var_5_16:addTouchEventListener(function(arg_9_0, arg_9_1)
				if arg_9_1 ~= ccui.TouchEventType.ended then
					return
				end

				if var_5_0.cancelcallback then
					var_5_0.cancelcallback({
						issure = true
					})
				end

				var_5_0.targetlayer = "PopSupermarketLayer"

				LayerManager:removePopLayer(self.__queueindex)
				LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", var_5_0)
			end)
		else
			var_5_16:addTouchEventListener(function(arg_10_0, arg_10_1)
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
					var_5_0.surecallback()
				end
			end)
		end
	else
		var_5_16:addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_11_0:isBright() then
				return
			end

			if arg_11_1 ~= ccui.TouchEventType.ended and var_5_0.isguide == nil then
				return
			end

			arg_11_0:setBright(false)
			LayerManager:removePopLayer(self.__queueindex)

			if var_5_0.surecallback then
				var_5_0.surecallback()
			end
		end)
	end

	if self.msg.other_bnt then
		local var_5_17 = var_5_16:clone()

		var_5_17:loadTextures(self.msg.other_bnt, self.msg.other_bnt, self.msg.other_bnt, var_0_0)
		var_5_17:setPositionX(200)
		var_5_17:setContentSize(cc.size(200, 80))
		var_5_17:getChildByName("label"):setString(L_BUTTON_TEXT.Cancel)
		var_5_17:getChildByName("label"):setPosition(var_5_17:getContentSize().width / 2, var_5_17:getContentSize().height / 2)
		var_5_16:getParent():addChild(var_5_17)
		var_5_17:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:removePopLayer(self.__queueindex)

			if var_5_0.cancelcallback then
				var_5_0.cancelcallback()
			end
		end)
		var_5_16:setContentSize(cc.size(200, 80))
		var_5_16:setPositionX(440)
		self.confirm_button_label:setPosition(var_5_16:getContentSize().width / 2, var_5_16:getContentSize().height / 2)
	end

	if self.msg.other_bnt2 then
		local var_5_18 = var_5_16:clone()

		var_5_18:setPositionX(50)
		var_5_18:setContentSize(cc.size(100, 80))
		var_5_18:getChildByName("label"):setString(self.msg.other_bnt2_label or L_BUTTON_TEXT.Cancel)
		var_5_18:getChildByName("label"):setPosition(var_5_18:getContentSize().width / 2, var_5_18:getContentSize().height / 2)
		var_5_16:getParent():addChild(var_5_18)
		var_5_18:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:removePopLayer(self.__queueindex)

			if var_5_0.other_bnt2_callback then
				var_5_0.other_bnt2_callback()
			end
		end)
		var_5_16:setContentSize(cc.size(100, 80))
		var_5_16:setPositionX(360)
		self.confirm_button_label:setPosition(var_5_16:getContentSize().width / 2, var_5_16:getContentSize().height / 2)
	end

	local var_5_19, var_5_20 = self.panel:getPosition()

	self.panel:setPosition(var_5_19, var_5_20 + 10)
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.FadeTo:create(0.2, 255))
	self.panel:runAction(cc.MoveTo:create(0.2, cc.p(var_5_19, var_5_20)))
	self:showRichText()
end

function PopDoLayer:exit()
	LayerManager:removePopLayer(self.__queueindex)

	if self.cancelcallback then
		self.cancelcallback()
	end
end

function PopDoLayer:showRichText()
	if not self.msg.desRichTexts or not next(self.msg.desRichTexts) then
		return
	end

	self.des:setVisible(false)

	local var_15_0 = ccui.ListView:create()

	var_15_0:setContentSize(cc.size(480, 320))
	var_15_0:setGravity(2)
	var_15_0:setItemsMargin(10)

	local var_15_1 = 0

	for iter_15_0, iter_15_1 in ipairs(self.msg.desRichTexts) do
		local var_15_2 = self:createOneText(iter_15_1)

		var_15_0:pushBackCustomItem(var_15_2)

		var_15_1 = var_15_1 + var_15_2:getContentSize().height
	end

	var_15_0:setContentSize(cc.size(480, var_15_1 + (#self.msg.desRichTexts - 1) * 10))
	var_15_0:setPosition(self.panel_bg:getContentSize().width / 2 - 240, self.panel_bg:getContentSize().height / 2 - (var_15_1 + (#self.msg.desRichTexts - 1) * 10) / 2)
	var_15_0:doLayout()
	self.panel_bg:addChild(var_15_0)
end

function PopDoLayer.createOneText(arg_16_0, arg_16_1)
	local var_16_0 = ccui.RichText:create()

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		var_16_0:pushBackElement((ccui.RichElementText:create(iter_16_0, iter_16_1.color or cc.c3b(255, 255, 255), iter_16_1.opacity or 255, iter_16_1.str or "", iter_16_1.font or "fonts/number.ttf", iter_16_1.fontSize or 25)))
	end

	var_16_0:formatText()

	return var_16_0
end
