PopCommunityVlogLayer = class("PopCommunityVlogLayer", function()
	return PopBaseLayer:create()
end)

require("view.Layer.PopLayer")

local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local community_system_manager = require("controller.community_system_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local var_0_7 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local var_0_9 = {
	[100] = COMMUNITY_COMMUNITYVLOGLAYER.tips1,
	[90] = COMMUNITY_COMMUNITYVLOGLAYER.tips2,
	[10] = COMMUNITY_COMMUNITYVLOGLAYER.tips3
}
local family_vlog_data = require("data.family_vlog_data")
local var_0_11 = {
	"community_system/communityMainLayer/vlog_context_bg1.png",
	"community_system/communityMainLayer/vlog_context_bg2.png"
}

function PopCommunityVlogLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopCommunityVlogLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopCommunityVlogLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCommunityVlogLayer.json" or "PopCommunityVlogLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")
	self.items1 = ccui.Helper:seekWidgetByName(self.rootLayer, "img_worldbg")
	self.listview = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_39")
	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")

	self.rootpanel:setCascadeOpacityEnabled(false)
	self.rootpanel:setPositionY(590 + GameDisplay.fix_y)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)
	self:getlistData()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			-- block empty
		end
	end)
end

function PopCommunityVlogLayer.dealWiththeData(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = {}
	local var_7_3 = {
		name = function(arg_8_0)
			return arg_8_0
		end,
		playerid = function(arg_9_0)
			return arg_9_0
		end,
		positon = function(arg_10_0)
			return var_0_9[arg_10_0] or COMMUNITY_COMMUNITYVLOGLAYER.tips3
		end
	}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		table.insert(var_7_0, {
			context = string.gsub(family_vlog_data[iter_7_1.id].msg, "(%w+)|(%w+)", function(arg_11_0, arg_11_1)
				if arg_11_1 == "titleold" then
					arg_11_1 = "title_old"
				end

				local var_11_0 = iter_7_1[arg_11_1]

				return var_7_3[arg_11_0] and var_11_0 and var_7_3[arg_11_0](var_11_0) or var_11_0
			end),
			time = iter_7_1.time
		})
	end

	local function var_7_4(arg_12_0)
		local var_12_0 = os.date("*t", arg_12_0)

		return var_12_0.year .. "-" .. var_12_0.month .. "-" .. var_12_0.day, var_12_0.hour .. ":" .. var_12_0.min .. ":" .. var_12_0.sec
	end

	for iter_7_2, iter_7_3 in pairs(var_7_0) do
		local var_7_5, var_7_6 = var_7_4(iter_7_3.time)

		if var_7_1[var_7_5] then
			table.insert(var_7_1[var_7_5], iter_7_3)
		else
			var_7_1[var_7_5] = {
				iter_7_3
			}
		end
	end

	for iter_7_4, iter_7_5 in pairs(var_7_1) do
		table.sort(iter_7_5, function(arg_13_0, arg_13_1)
			return arg_13_0.time > arg_13_1.time
		end)
	end

	for iter_7_6, iter_7_7 in pairs(var_7_1) do
		table.insert(var_7_2, {
			list = iter_7_7,
			time = iter_7_6
		})
	end

	table.sort(var_7_2, function(arg_14_0, arg_14_1)
		return global_get_time_by_date(arg_14_0.time .. " 00:00:00") > global_get_time_by_date(arg_14_1.time .. " 00:00:00")
	end)

	return var_7_2
end

function PopCommunityVlogLayer.getlistData(arg_15_0)
	community_system_manager:get_family_log(function(arg_16_0)
		if arg_16_0.result == 1 then
			arg_15_0.data = arg_15_0:dealWiththeData(arg_16_0.list)
		end

		arg_15_0:initUI()
	end)
end

function PopCommunityVlogLayer:initUI()
	self.listview:removeAllChildren()
	self.listview:setItemsMargin(2)

	if not self.data or not next(self.data) then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(self.data) do
		local var_17_0 = self.items:clone()

		var_17_0:setName("node_" .. iter_17_0)
		self:updateNode(var_17_0, iter_17_1)
		self.listview:pushBackCustomItem(var_17_0)
	end
end

function PopCommunityVlogLayer:updateNode(arg_18_1, arg_18_2)
	local var_18_0 = ccui.Helper:seekWidgetByName(arg_18_1, "timebg")
	local var_18_1 = ccui.Helper:seekWidgetByName(var_18_0, "Label_44")
	local var_18_2 = 0
	local var_18_3 = {}

	var_18_1:setString(arg_18_2.time)

	local function var_18_4(arg_19_0)
		local var_19_0 = os.date("*t", arg_19_0)

		return var_19_0.year .. "-" .. var_19_0.month .. "-" .. var_19_0.day, var_19_0.hour .. ":" .. var_19_0.min
	end

	var_18_1:setString(arg_18_2.time)

	for iter_18_0, iter_18_1 in ipairs(arg_18_2.list) do
		var_18_2 = var_18_2 + 1

		local var_18_5, var_18_6 = var_18_4(iter_18_1.time)
		local var_18_7 = self.items1:clone()

		var_18_7:setName("context_" .. iter_18_0)
		var_18_7:getChildByName("Label_46"):setString(var_18_6)
		var_18_7:getChildByName("Label_47"):setString(iter_18_1.context)
		var_18_7:getChildByName("Label_47"):getVirtualRenderer():setMaxLineWidth(454)
		table.insert(var_18_3, var_18_7)
	end

	arg_18_1:setContentSize(cc.size(640, 100 * var_18_2))
	var_18_0:setPositionY(arg_18_1:getContentSize().height - var_18_0:getContentSize().height / 2)

	for iter_18_2 = 1, #var_18_3 do
		arg_18_1:addChild(var_18_3[iter_18_2])

		if iter_18_2 % 2 == 0 then
			var_18_3[iter_18_2]:loadTexture(var_0_11[1], var_0_7)
		else
			var_18_3[iter_18_2]:loadTexture(var_0_11[2], var_0_7)
		end

		if iter_18_2 == 1 then
			var_18_3[iter_18_2]:setPosition(cc.p(37, var_18_0:getPositionY() - 14 - 7))
		else
			var_18_3[iter_18_2]:setPosition(cc.p(37, var_18_3[iter_18_2 - 1]:getPositionY() - 70))
		end
	end
end

function PopCommunityVlogLayer:initBg(arg_20_1)
	local var_20_0 = ccui.Layout:create()

	var_20_0:setTouchEnabled(true)
	var_20_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_20_0:setAnchorPoint(cc.p(0, 0))
	var_20_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_20_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_20_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_20_0:setOpacity(0)
	var_20_0:setCascadeOpacityEnabled(false)
	self:addChild(var_20_0, -1)

	local var_20_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_20_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_20_1:setPositionX(var_20_0:getContentSize().width / 2)
	var_20_1:setPositionY(var_20_0:getContentSize().height / 2)
	var_20_0:addChild(var_20_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_21_0)
		self:addChild(arg_21_0, -2)
		arg_21_0:setPositionY(arg_21_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_20_1)
		var_20_0:setOpacity(102)
		var_20_0:setTouchEnabled(false)
	end)
end

function PopCommunityVlogLayer:exit()
	self.hideActions.shrinkBoth(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
