ResidentActicityEntranceLayer = class("ResidentActicityEntranceLayer", function()
	return ccui.Layout:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Layer.Activity.ActivityWarOrderLayer")
require("view.Layer.Activity.ActivityRouletteBaseLayer")
require("view.Layer.ActivityNew.BaseLayer.ActivityFlipBaseLayer")

local activity_manager = require("controller.activity_manager")

function ResidentActicityEntranceLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ResidentActicityEntranceLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ResidentActicityEntranceLayer:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)

	self.selectTab = 1

	self:initUI()
	self:initLayer()
end

function ResidentActicityEntranceLayer:initUI()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs({
		"后勤支援",
		"幸运翻牌",
		"幸运转盘"
	}) do
		local var_4_1 = ccui.Button:create("public/button/btn_off.png", "public/button/btn_on.png", "public/button/btn_on.png", var_0_0)
		local var_4_2 = cc.Label:createWithTTF(iter_4_1, FONT_BUTTON, 20)

		var_4_2:setPosition(var_4_1:getContentSize().width / 2, var_4_1:getContentSize().height / 2)
		var_4_2:setColor(cc.c3b(0, 0, 0))
		var_4_2:setScaleX(-1)
		var_4_2:setName("label")
		var_4_1:addChild(var_4_2)
		var_4_1:setName(iter_4_0)
		var_4_1:setPosition(290 + var_4_1:getContentSize().width * (iter_4_0 - 1), 940)
		var_4_1:setScaleX(-1)
		var_4_1:addTouchEventListener(self:changBtn())
		var_4_1:setSwallowTouches(true)
		self.rootLayer:addChild(var_4_1, 5)
		table.insert(var_4_0, var_4_1)
	end

	self.actBtn = var_4_0
end

function ResidentActicityEntranceLayer:initLayer()
	local var_5_0 = {}

	var_5_0.parentlayer = self.rootLayer

	local var_5_2 = ActivityWarOrderLayer:create(var_5_0)

	var_5_2:setVisible(true)
	var_5_2:setName("layer1")
	self.rootLayer:addChild(var_5_2)

	var_5_0.activityId = FLIPANDROULETTE

	local var_5_3 = ActivityFlipBaseLayer:create(var_5_0)

	var_5_3:setVisible(false)
	var_5_3:setName("layer2")
	var_5_3.championPanel:removeFromParent()
	self:addChild(var_5_3.championPanel, 100)
	self.rootLayer:addChild(var_5_3)

	var_5_0.activityId = FLIPANDROULETTE

	local var_5_4 = ActivityRouletteBaseLayer:create(var_5_0)

	var_5_4:setVisible(false)
	var_5_4:setName("layer3")
	self.rootLayer:addChild(var_5_4)
	self:updateBtn()
end

function ResidentActicityEntranceLayer.changBtn(arg_6_0)
	return function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_7_0 = {}

		var_7_0.is_reset = false
		var_7_0.update = true

		if arg_7_0:getName() == "1" then
			arg_6_0.selectTab = 1

			arg_6_0.rootLayer:getChildByName("layer1"):setVisible(true)
			arg_6_0.rootLayer:getChildByName("layer2"):setVisible(false)
			arg_6_0.rootLayer:getChildByName("layer3"):setVisible(false)
		elseif arg_7_0:getName() == "2" then
			arg_6_0.selectTab = 2

			arg_6_0.rootLayer:getChildByName("layer1"):setVisible(false)
			arg_6_0.rootLayer:getChildByName("layer2"):setVisible(true)
			arg_6_0.rootLayer:getChildByName("layer3"):setVisible(false)
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLOP_CONF_UPDATE, var_7_0)
		else
			arg_6_0.selectTab = 3

			arg_6_0.rootLayer:getChildByName("layer1"):setVisible(false)
			arg_6_0.rootLayer:getChildByName("layer2"):setVisible(false)
			arg_6_0.rootLayer:getChildByName("layer3"):setVisible(true)
		end

		arg_6_0:updateBtn()
	end
end

function ResidentActicityEntranceLayer:updateBtn()
	local var_8_0 = {
		848 + GameDisplay.fix_y,
		841,
		1030
	}

	for iter_8_0, iter_8_1 in pairs(self.actBtn) do
		if self.selectTab == iter_8_0 then
			iter_8_1:setTouchEnabled(false)
			iter_8_1:setBright(false)
			iter_8_1:getChildByName("label"):setColor(cc.c3b(0, 0, 0))
		else
			iter_8_1:setTouchEnabled(true)
			iter_8_1:setBright(true)
			iter_8_1:getChildByName("label"):setColor(cc.c3b(255, 255, 255))
		end

		iter_8_1:setPositionY(var_8_0[self.selectTab])
	end
end
