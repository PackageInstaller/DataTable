RulesPacksCollectionLayer = class("RulesPacksCollectionLayer", function()
	return ccui.Layout:create()
end)

local time_check_manager = require("controller.time_check_manager")
local var_0_1 = require("controller.supermarket_limited_time_package_manager"):getInstance()
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local var_0_4 = {}

var_0_4[160] = 5
var_0_4[161] = 1
var_0_4[162] = 4
var_0_4[163] = 3
var_0_4[164] = 2

function RulesPacksCollectionLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = RulesPacksCollectionLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function RulesPacksCollectionLayer:init(arg_3_1)
	self.rootlayer = cc.Layer:create()

	self:addChild(self.rootlayer)

	local var_3_0 = ccui.Layout:create()

	var_3_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(10, 10, 10))
	var_3_0:setBackGroundColorOpacity(120)
	var_3_0:setTouchEnabled(true)
	var_3_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootlayer:addChild(var_3_0)
	var_3_0:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self:initData()
end

function RulesPacksCollectionLayer.initData(arg_5_0)
	require("controller.condition_trigger_packs_manager"):get_condition_packs_active(function(arg_6_0)
		if not arg_6_0.packs_types or #arg_6_0.packs_types == 0 then
			KeyCodeManager:onKeyReleasedCallFunc()

			return
		end

		arg_5_0.listData = arg_6_0.packs_types

		table.sort(arg_5_0.listData, function(arg_7_0, arg_7_1)
			if not var_0_4[arg_7_0] then
				return true
			end

			if not var_0_4[arg_7_1] then
				return false
			end

			return var_0_4[arg_7_0] < var_0_4[arg_7_1]
		end)
		arg_5_0:initList()
	end)
end

function RulesPacksCollectionLayer:initList()
	self.curIndex = 1
	self.curlayout = self:create_layout(self.listData[self.curIndex])

	self.rootlayer:addChild(self.curlayout)

	local function var_8_0(arg_9_0)
		if #self.listData == 1 then
			return
		end

		self.curIndex = arg_9_0 > #self.listData and 1 or arg_9_0 < 1 and #self.listData or arg_9_0

		self.curlayout:removeFromParent()

		self.curlayout = self:create_layout(self.listData[self.curIndex])

		self.rootlayer:addChild(self.curlayout)
		self:updateBottomBar()
	end

	local var_8_1 = ccui.Layout:create()

	var_8_1:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2 - GameDisplay.fix_y - 470))
	var_8_1:setLayoutType(ccui.LayoutType.HORIZONTAL)
	var_8_1:setAnchorPoint(cc.p(0.5, 0.5))
	self:addChild(var_8_1)

	self.bars = {}

	local var_8_2 = ccui.Button:create("mainScenebg/shopRecommendPageView/btn_left.png")

	self:addChild(var_8_2)
	var_8_2:setScale(2.5)

	local var_8_3 = 0

	for iter_8_0 = 1, #self.listData do
		local var_8_4 = ccui.ImageView:create("mainScenebg/shopRecommendPageView/bar_off.png")

		var_8_4:setName("bar" .. iter_8_0)
		var_8_4:setScale(1.8)
		var_8_1:addChild(var_8_4)
		table.insert(self.bars, var_8_4)

		local var_8_5 = ccui.LinearLayoutParameter:create()

		var_8_5:setGravity(ccui.LinearGravity.centerHorizontal)
		var_8_5:setMargin({
			top = 20,
			bottom = 10,
			left = 25,
			right = 25
		})
		var_8_4:setLayoutParameter(var_8_5)

		var_8_3 = var_8_3 + var_8_4:getContentSize().width + 50
	end

	local var_8_6 = ccui.Button:create("mainScenebg/shopRecommendPageView/btn_right.png")

	self:addChild(var_8_6)
	var_8_6:setScale(2.5)
	var_8_1:setPositionX(var_8_1:getPositionX() - var_8_3 / 2)
	self:updateBottomBar()
	var_8_2:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_8_0(self.curIndex - 1)
	end)
	var_8_6:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_8_0(self.curIndex + 1)
	end)
	var_8_2:setPosition(GameDisplay.width / 2 - var_8_3 / 2 - 40, GameDisplay.height / 2 - GameDisplay.fix_y - 495)
	var_8_6:setPosition(GameDisplay.width / 2 + var_8_3 / 2 + 40, GameDisplay.height / 2 - GameDisplay.fix_y - 495)
end

function RulesPacksCollectionLayer:updateBottomBar()
	for iter_12_0, iter_12_1 in ipairs(self.bars) do
		if iter_12_1:getName() == "bar" .. self.curIndex then
			iter_12_1:loadTexture("mainScenebg/shopRecommendPageView/bar_on.png")
		else
			iter_12_1:loadTexture("mainScenebg/shopRecommendPageView/bar_off.png")
		end
	end
end

function RulesPacksCollectionLayer.create_layout(arg_13_0, arg_13_1)
	require("view.Layer.Pops.PopNewRulePacksLayer")

	return (PopNewRulePacksLayer:create({
		shop_type = arg_13_1
	}))
end

return RulesPacksCollectionLayer
