PopCardBuffLayer = class("PopCardBuffLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local activity_return_manager = require("controller.activity_return_manager")
local gamebuff_data = require("data.gamebuff_data")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_data = require("data.item_data")

function PopCardBuffLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopCardBuffLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopCardBuffLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCardBuffLayer.json" or "PopCardBuffLayer.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "bg_img")

	self.rootpanel:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))
	self.rootpanel:setScaleY(0)
	self.rootpanel:setTouchEnabled(false)

	self.Listview = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_3")
	self.no_label = ccui.Helper:seekWidgetByName(self.rootLayer, "no_data")
	self.tile_label = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_26")

	self.tile_label:setString(L_POPCARDBUFFLAYER.title)

	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")

	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.showActions.extendVertical(self)
	activity_return_manager:get_game_buffs(function(arg_6_0)
		if arg_6_0 and arg_6_0.result == 1 then
			self.data = activity_return_manager:get_buffs()

			self:initUI()
		end
	end)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopCardBuffLayer")
		end
	end)
end

local function var_0_8(arg_8_0)
	if not arg_8_0 then
		return
	end

	if arg_8_0 >= 86400 then
		return string.format(L_TIME_FORMAT[1], math.floor(arg_8_0 / 86400), math.floor(arg_8_0 % 86400 / 3600))
	elseif arg_8_0 >= 3600 then
		return string.format(L_TIME_FORMAT[2], math.floor(arg_8_0 / 3600), math.floor(arg_8_0 % 3600 / 60))
	else
		return string.format(L_TIME_FORMAT[3], math.floor(arg_8_0 / 60))
	end
end

function PopCardBuffLayer:initUI()
	self.Listview:removeAllChildren()

	if not self.data then
		print("error:------------> no data")
		self.no_label:setString(L_POPCARDBUFFLAYER.nobuff)

		return
	end

	self.no_label:setString("")
	self.Listview:setItemsMargin(10)

	for iter_9_0, iter_9_1 in pairs(self.data) do
		local var_9_0 = self.items:clone()
		local var_9_1 = time_check_manager:getCurTime()

		var_9_0:getChildByName("Label_dec_time"):setPositionX(var_9_0:getChildByName("Label_dec_time"):getPositionX() - 16)
		var_9_0:getChildByName("Label_dec"):setPositionX(var_9_0:getChildByName("Label_dec"):getPositionX() - 16)
		var_9_0:getChildByName("Label_dec"):setFontSize(24)
		var_9_0:getChildByName("Label_dec_time"):setString(var_0_8(iter_9_1.time - var_9_1))
		var_9_0:getChildByName("Label_dec"):setString(L_POPCARDBUFFLAYER["tips_" .. gamebuff_data[iter_9_1.id].type] .. gamebuff_data[iter_9_1.id].rate * 100 .. "%")
		var_9_0:getChildByName("mage"):loadTexture("activity_return/" .. iter_9_1.id .. ".png", var_0_0)

		local var_9_4 = var_9_0:getChildByName("mage"):getContentSize()

		var_9_0:getChildByName("mage"):setScale(108 / math.min(var_9_4.width, var_9_4.height))
		self.Listview:pushBackCustomItem(var_9_0)
	end
end

function PopCardBuffLayer:exit(arg_10_1)
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback()
		end

		if arg_10_1 then
			arg_10_1()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopCardBuffLayer:initBg(arg_12_1)
	local var_12_0 = ccui.Layout:create()

	var_12_0:setTouchEnabled(true)
	var_12_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_12_0:setAnchorPoint(cc.p(0, 0))
	var_12_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_12_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_12_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_12_0:setOpacity(0)
	var_12_0:setCascadeOpacityEnabled(false)
	self:addChild(var_12_0, -1)

	local var_12_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_12_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_12_1:setPositionX(var_12_0:getContentSize().width / 2)
	var_12_1:setPositionY(var_12_0:getContentSize().height / 2)
	var_12_0:addChild(var_12_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_13_0)
		self:addChild(arg_13_0, -2)
		arg_13_0:setPositionY(arg_13_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_12_1)
		var_12_0:setOpacity(102)
		var_12_0:setTouchEnabled(false)
	end)
end
