local var_0_0 = config._DEBUG and 0 or 1

function PopBaseLayer:generate_small_info_panel(arg_1_1)
	local var_1_0 = ccui.Helper:seekWidgetByName(self.rootpanel, "button_sure")

	var_1_0:setPressedActionEnabled(true)

	local var_1_1 = arg_1_1.labels or {}

	ccui.Helper:seekWidgetByName(self.rootpanel, "title"):setString(var_1_1.title or "")
	ccui.Helper:seekWidgetByName(self.rootpanel, "title_des"):setString(var_1_1.des or "")
	ccui.Helper:seekWidgetByName(self.rootpanel, "title_more"):setString(var_1_1.more or "")
	var_1_0:getChildByName("label"):setString(var_1_1.button or "")

	if arg_1_1.system_figure then
		if arg_1_1.system_figure:find("role") then
			ccui.Helper:seekWidgetByName(self.rootpanel, "image_system_figure"):loadTexture(arg_1_1.system_figure)
		else
			ccui.Helper:seekWidgetByName(self.rootpanel, "image_system_figure"):loadTexture(arg_1_1.system_figure, var_0_0)
		end
	else
		ccui.Helper:seekWidgetByName(self.rootpanel, "image_system_figure"):setVisible(false)
	end

	local var_1_2 = ccui.Helper:seekWidgetByName(self.rootpanel, "label_cost_num_gold")
	local var_1_3 = ccui.Helper:seekWidgetByName(self.rootpanel, "image_gold")

	if not arg_1_1.cost then
		var_1_2:setVisible(false)
	elseif arg_1_1.cost == 0 then
		var_1_2:setString(L_FREE_FOR_CHARGE)
		var_1_2:setPosition(cc.p(320, var_1_0:getPositionY() - var_1_0:getContentSize().height / 2 - var_1_2:getContentSize().height / 2))
		var_1_3:setVisible(false)
	elseif arg_1_1.costtype == "diamond" then
		var_1_3:loadTexture(IMAGE_DIAMOND, var_0_0)
		var_1_2:setString(arg_1_1.cost)
		var_1_3:setScale(1)
		var_1_3:setPosition(cc.p(-(string.len(arg_1_1.cost) * 12) - 5, 14))
	elseif arg_1_1.costtype == "gold" then
		var_1_3:loadTexture(IMAGE_GOLD, var_0_0)
		var_1_2:setString(arg_1_1.cost)
		var_1_3:setScale(1)
		var_1_3:setPosition(cc.p(-(string.len(arg_1_1.cost) * 12) - 5, 14))
	elseif type(arg_1_1.costtype) == "number" then
		var_1_3:loadTexture("public/" .. arg_1_1.costtype .. ".png", var_0_0)
		var_1_3:setScale(0.3)
		var_1_2:setString(arg_1_1.own .. "/" .. arg_1_1.cost)
		var_1_3:setPosition(cc.p(-(string.len(arg_1_1.cost) * 12) - 5, 14))
	end

	if arg_1_1.remaintimes and arg_1_1.remaintimes <= 0 then
		var_1_0:loadTextures("public/button/public_button_off.png", "public/button/public_button_off.png", "public/button/public_button_off_click.png", var_0_0)
		var_1_2:setVisible(false)
	end
end

PopQuickFightInfo = class("PopQuickFightInfo", function()
	return PopBaseLayer:create()
end)

function PopQuickFightInfo.create(arg_3_0, arg_3_1)
	local var_3_0 = PopQuickFightInfo.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function PopQuickFightInfo:init(arg_4_1)
	local var_4_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Popup_small.json" or "Popup_small.ExportJson")

	self:addChild(var_4_0)

	self.rootpanel = ccui.Helper:seekWidgetByName(var_4_0, "panel_back")

	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setPosition(cc.p(320, 568))
	self:generateQuickFightInfo(arg_4_1)
	self.rootpanel:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_5_0:isBright() then
			return
		end

		arg_5_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)

			if arg_4_1.cancelcallback then
				arg_4_1.cancelcallback()
			end
		end)
	end)
	ccui.Helper:seekWidgetByName(self.rootpanel, "button_sure"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_7_0:isBright() then
			return
		end

		arg_7_0:setBright(false)

		if arg_4_1.remaintimes and arg_4_1.remaintimes <= 0 then
			global_ShowBlockWords(L_NO_TIMES)
		else
			self.hideActions.shrinkVertical(self, function()
				LayerManager:removePopLayer(self.__queueindex)

				if arg_4_1.surecallback then
					arg_4_1.surecallback()
				end
			end)
		end
	end)
	self.showActions.extendBoth(self)
end

function PopQuickFightInfo:generateQuickFightInfo(arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(L_QUICK_FIGHT) do
		var_9_0[iter_9_0] = iter_9_1
	end

	var_9_0.more = string.format(var_9_0.more, arg_9_1.remaintimes, arg_9_1.totaltimes)
	arg_9_1.labels = var_9_0

	self:generate_small_info_panel(arg_9_1)
end
