PopTurnOverItemsLayer = class("PopTurnOverItemsLayer", function()
	return cc.Layer:create()
end)

local activity_recruit_data = require("data.activity_recruit_data")
local var_0_1 = config._DEBUG and 0 or 1
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")

function PopTurnOverItemsLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopTurnOverItemsLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopTurnOverItemsLayer:init(arg_3_1)
	self:initInfo(arg_3_1)
	self:onLoad()
	self:initPanel()
	self:fullscreen()
end

function PopTurnOverItemsLayer:initInfo(arg_4_1)
	self.servantId = arg_4_1.servantId or 0
	self.activityId = arg_4_1.activityId or 0
	self.taskid = arg_4_1.taskid or 0

	assert(activity_recruit_data[self.taskid], string.format("curTaskData is nil , the taskid is %d", self.taskid))

	self.itemid = activity_recruit_data[self.taskid].needs_target
	self.taskindex = activity_recruit_data[self.taskid].index
	self.curItemNum = item_manager:getItemNumber(activity_recruit_data[self.taskid].needs_target)
	self.needTotalNum = activity_recruit_data[self.taskid].needs_num
	self.titleStr = L_TURNOVER_ITEMS[1]
	self.curItemStr = L_TURNOVER_ITEMS[2] .. self.curItemNum
	self.needItemStr = "x" .. self.needTotalNum
end

function PopTurnOverItemsLayer.btnCloseCallback(arg_5_0)
	LayerManager:removePopLayer()
end

function PopTurnOverItemsLayer:onLoad()
	local var_6_0 = ccui.Layout:create()

	var_6_0:setContentSize(cc.size(640, 1136))
	var_6_0:setName("root")

	self.rootNode = var_6_0

	self.rootNode:setTouchEnabled(true)
	self.rootNode:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:btnCloseCallback()
	end)
	self:addChild(var_6_0)

	local var_6_1 = ccui.ImageView:create("mainScenebg/black1.jpg")

	var_6_1:setAnchorPoint(cc.p(0, 0))
	var_6_1:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_6_1:setOpacity(178)
	var_6_1:setName("black_mask")
	var_6_1:isScale9Enabled(true)
	var_6_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_6_0:addChild(var_6_1)

	local var_6_2 = ccui.ImageView:create("PopTurnOverItemsLayer/confirm_bg.png", var_0_1)

	var_6_2:setName("bg")
	var_6_2:setPosition(cc.p(320, 650))
	var_6_0:addChild(var_6_2)

	self.btn_cancel = ccui.Button:create("PopTurnOverItemsLayer/btn_cancel.png", "PopTurnOverItemsLayer/btn_cancel.png", "PopTurnOverItemsLayer/btn_cancel.png", var_0_1)

	self.btn_cancel:setName("btn_cancel")
	self.btn_cancel:setPosition(cc.p(200, 420))
	self.btn_cancel:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:btnCloseCallback()
	end)
	var_6_0:addChild(self.btn_cancel)

	self.btn_sure = ccui.Button:create("PopTurnOverItemsLayer/btn_sure.png", "PopTurnOverItemsLayer/btn_sure.png", "PopTurnOverItemsLayer/btn_sure.png", var_0_1)

	self.btn_sure:setName("btn_sure")
	self.btn_sure:setPosition(cc.p(470, 420))
	self.btn_sure:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curItemNum >= self.needTotalNum then
			activity_manager:complete_recurit_task(self.activityId, self.servantId, self.taskindex)
			self:btnCloseCallback()
		else
			global_ShowBlockWords(L_TURNOVER_ITEMS[3])
		end
	end)
	var_6_0:addChild(self.btn_sure)

	local var_6_3 = ccui.Text:create(self.titleStr, FONT_NAME, 48)

	var_6_3:setName("title")
	var_6_3:setPosition(cc.p(320, 245))
	var_6_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_6_2:addChild(var_6_3)

	local var_6_4 = ccui.Text:create(self.curItemStr, FONT_NAME, 20)

	var_6_4:setName("itemStr")
	var_6_4:setPosition(cc.p(320, 190))
	var_6_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_6_4:setColor(cc.c3b(162, 171, 251))
	var_6_2:addChild(var_6_4)

	local var_6_5 = ccui.Layout:create()

	var_6_5:setName("item")
	var_6_5:setPosition(cc.p(320, 110))
	var_6_5:setContentSize(cc.size(110, 110))
	var_6_2:addChild(var_6_5)

	local var_6_6 = ccui.ImageView:create("PopTurnOverItemsLayer/wupin_bg.png", var_0_1)

	var_6_6:setName("itembg")
	var_6_5:addChild(var_6_6)

	local var_6_7 = ItemNoBgSprite:create(self.itemid, true)

	var_6_7:setName("item")
	var_6_7:setAnchorPoint(cc.p(0, 0))
	var_6_7:setScale(0.7)
	var_6_5:addChild(var_6_7)

	local var_6_8 = ccui.Text:create(self.needItemStr, FONT_NAME, 18)

	var_6_8:setName("itemTitle")
	var_6_8:setAnchorPoint(cc.p(1, 0))
	var_6_8:setPosition(cc.p(50, -50))
	var_6_5:addChild(var_6_8)

	local var_6_9 = ccui.Text:create(L_TURNOVER_ITEMS[3], FONT_NAME, 18)

	var_6_9:setName("itemTip")
	var_6_9:setColor(cc.c3b(255, 45, 89))
	var_6_9:setPosition(cc.p(55, -150))
	var_6_9:setVisible(false)

	self.itemTipNode = var_6_9

	var_6_4:addChild(var_6_9)
end

function PopTurnOverItemsLayer:initPanel()
	if self.curItemNum >= self.needTotalNum then
		self.itemTipNode:setVisible(false)
		self.btn_sure:loadTextures("PopTurnOverItemsLayer/btn_sure.png", "PopTurnOverItemsLayer/btn_sure.png", "PopTurnOverItemsLayer/btn_sure.png", var_0_1)
	else
		self.itemTipNode:setVisible(true)
		self.btn_sure:loadTextures("PopTurnOverItemsLayer/btn_sure_off.png", "PopTurnOverItemsLayer/btn_sure_off.png", "PopTurnOverItemsLayer/btn_sure_off.png", var_0_1)
	end
end

function PopTurnOverItemsLayer:fullscreen()
	self.rootNode:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootNode:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))

	for iter_11_0, iter_11_1 in pairs({}) do
		local var_11_0 = self.rootNode:getChildByName(iter_11_1)

		var_11_0:setLocalZOrder(1)

		var_11_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_11_0:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_11_0:setPositionY(var_11_0.full_posY)
	end

	for iter_11_2, iter_11_3 in pairs({
		"bg",
		"btn_cancel",
		"btn_sure"
	}) do
		local var_11_1 = self.rootNode:getChildByName(iter_11_3)

		var_11_1:setLocalZOrder(1)

		var_11_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_11_1:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_11_1:setPositionY(var_11_1.full_posY)
	end
end
