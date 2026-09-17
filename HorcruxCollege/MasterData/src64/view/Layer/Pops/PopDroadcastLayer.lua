PopDroadcastLayer = class("PopDroadcastLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")

local activity_doubleholiday_manager = require("controller.activity_doubleholiday_manager")
local var_0_1 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local detail_data = require("data.detail_data")
local activity_plague_message_data = require("data.activity_plague_message_data")
local activity_plague_city_data = require("data.activity_plague_city_data")
local activity_plague_data = require("data.activity_plague_data")
local var_0_8 = {
	"Activity_doubleholiday/bk_xw.png",
	"Activity_doubleholiday/bk_xt.png",
	"Activity_doubleholiday/bk_sl.png"
}

function PopDroadcastLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopDroadcastLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopDroadcastLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "DoubleHoliday_broadcast.json" or "DoubleHoliday_broadcast.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.callback = arg_3_1.callback
	self.noinfo = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_no_gb")

	self:initUI()
	self:getData()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" and self.callback then
			self.callback()
		end
	end)
end

local function var_0_9(arg_5_0)
	if not arg_5_0 then
		return
	end

	if arg_5_0 >= 86400 then
		return string.format(L_TIME_FORMAT[1], math.floor(arg_5_0 / 86400), math.floor(arg_5_0 % 86400 / 3600))
	elseif arg_5_0 >= 3600 then
		return string.format(L_TIME_FORMAT[2], math.floor(arg_5_0 / 3600), math.floor(arg_5_0 % 3600 / 60))
	else
		return string.format(L_TIME_FORMAT[3], math.floor(arg_5_0 / 60))
	end
end

function PopDroadcastLayer.getData(arg_6_0)
	activity_doubleholiday_manager:get_new_info(12, 1, 50, function(arg_7_0)
		if arg_7_0.result ~= 0 then
			arg_6_0.data = arg_6_0:dealWithData(arg_7_0.list)

			arg_6_0:initscrollPanel(arg_6_0.data)
		end
	end)
end

function PopDroadcastLayer.dealWithData(arg_8_0, arg_8_1)
	if not arg_8_1 and not next(arg_8_1) then
		return
	end

	local var_8_0 = {
		cityname = function(arg_9_0)
			return activity_plague_city_data[arg_9_0].name
		end,
		nodename = function(arg_10_0)
			local var_10_0 = ""

			if type(arg_10_0) == "number" then
				var_10_0 = activity_plague_data[arg_10_0].nodename
			elseif type(arg_10_0) == "table" then
				for iter_10_0, iter_10_1 in ipairs(arg_10_0) do
					var_10_0 = var_10_0 .. activity_plague_data[iter_10_1].nodename .. ((iter_10_0 == #arg_10_0 or nil) and "")
				end
			end

			return var_10_0
		end,
		date = function(arg_11_0)
			return (var_0_9(arg_11_0))
		end,
		value = function(arg_12_0)
			return global_trans_number(arg_12_0)
		end
	}
	local var_8_4 = {
		{},
		{},
		{}
	}

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		local var_8_5 = string.gsub(activity_plague_message_data[iter_8_1.id].msg, "(%w+)|(%w+)", function(arg_13_0, arg_13_1)
			return var_8_0[arg_13_0] and iter_8_1[arg_13_1] and var_8_0[arg_13_0](iter_8_1[arg_13_1]) or iter_8_1[arg_13_1]
		end)

		if activity_plague_message_data[iter_8_1.id].type == 1 then
			table.insert(var_8_4[3], var_8_5)
		elseif activity_plague_message_data[iter_8_1.id].type == 2 then
			table.insert(var_8_4[2], var_8_5)
		elseif activity_plague_message_data[iter_8_1.id].type == 3 or activity_plague_message_data[iter_8_1.id].type == 4 then
			table.insert(var_8_4[1], var_8_5)
		end
	end

	return var_8_4
end

function PopDroadcastLayer:initUI()
	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "background")

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 + 64)

	self.scrollpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView")
	self.item1 = ccui.Helper:seekWidgetByName(self.rootLayer, "item1")

	local function var_14_0(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(self.rootpanel, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end

	self.surebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")

	self.surebtn:addTouchEventListener(var_14_0)
	self.rootLayer:addTouchEventListener(var_14_0)
	self:getData()
end

function PopDroadcastLayer:initscrollPanel(arg_17_1)
	if not next(arg_17_1) then
		return self.noinfo:setVisible(true)
	end

	self.scrollpanel:removeAllChildren()
	self.noinfo:setVisible(false)

	local var_17_0 = {}
	local var_17_1 = 0

	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		for iter_17_2, iter_17_3 in pairs(iter_17_1) do
			local var_17_3 = self.item1:clone()

			var_17_3:getChildByName("Image_26"):loadTexture(var_0_8[iter_17_0], var_0_1)

			local var_17_4 = iter_17_3
			local var_17_5 = require("view.Sprite.RichTextPro"):create()

			var_17_5:setMaxWidth(466)
			var_17_5:setSize(20)

			if not string.find(var_17_4, "^%b<>.+%b<>$") then
				var_17_4 = table.concat({
					"<p>",
					var_17_4,
					"</p>"
				})
			end

			var_17_5:setText(var_17_4, nil, true)

			local var_17_6 = var_17_5:getContentHeight()

			var_17_5:setName("richTextWord")
			var_17_3:addChild(var_17_5, 100000)

			local var_17_7 = var_17_6 + var_17_3:getChildByName("Image_26"):getContentSize().height + 30

			var_17_3:setContentSize(cc.size(556, var_17_7))
			var_17_3:getChildByName("Image_24"):setScaleY(var_17_7 / 92)
			var_17_3:getChildByName("Image_24"):setPositionY(var_17_7 / 2)
			var_17_3:getChildByName("Image_26"):setPositionY(var_17_7 - var_17_3:getChildByName("Image_26"):getContentSize().height / 2 - 5)
			var_17_3:getChildByName("richTextWord"):setPosition(cc.p(10, var_17_3:getChildByName("Image_26"):getPositionY() - 25))
			table.insert(var_17_0, var_17_3)

			var_17_1 = var_17_1 + var_17_3:getContentSize().height + 10
		end
	end

	if var_17_1 < self.scrollpanel:getContentSize().height then
		self.scrollpanel:setInnerContainerSize(self.scrollpanel:getContentSize())

		var_17_1 = self.scrollpanel:getContentSize().height
	else
		self.scrollpanel:setInnerContainerSize(cc.size(500, var_17_1))
	end

	for iter_17_4 = 1, #var_17_0 do
		if iter_17_4 == 1 then
			var_17_0[iter_17_4]:setPosition(cc.p(10, var_17_1 - var_17_0[iter_17_4]:getContentSize().height))
		else
			var_17_0[iter_17_4]:setPosition(cc.p(10, var_17_0[iter_17_4 - 1]:getPositionY() - var_17_0[iter_17_4]:getContentSize().height - 10))
		end

		self.scrollpanel:addChild(var_17_0[iter_17_4])
	end
end

function PopDroadcastLayer:initBg(arg_18_1)
	local var_18_0 = ccui.Layout:create()

	var_18_0:setTouchEnabled(true)
	var_18_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_18_0:setAnchorPoint(cc.p(0, 0))
	var_18_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_18_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_18_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_18_0:setOpacity(0)
	var_18_0:setCascadeOpacityEnabled(false)
	self:addChild(var_18_0, -1)

	local var_18_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_18_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_18_1:setPositionX(var_18_0:getContentSize().width / 2)
	var_18_1:setPositionY(var_18_0:getContentSize().height / 2)
	var_18_0:addChild(var_18_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_19_0)
		self:addChild(arg_19_0, -2)
		arg_19_0:setPositionY(arg_19_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_18_1)
		var_18_0:setOpacity(102)
		var_18_0:setTouchEnabled(false)
	end)
end
