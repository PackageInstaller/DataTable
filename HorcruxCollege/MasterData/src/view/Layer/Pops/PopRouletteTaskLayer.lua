PopRouletteTaskLayer = class("PopRouletteTaskLayer", function()
	return PopBaseLayer:create()
end)

local item_data = require("data.item_data")
local var_0_1 = config._DEBUG and 0 or 1
local drop_manager = require("controller.drop_manager")
local activity_manager = require("controller.activity_manager")
local servant_data = require("data.servant_data")
local playermodel = require("model.playermodel")

function PopRouletteTaskLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopRouletteTaskLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopRouletteTaskLayer:init(arg_3_1)
	print("open poplayer : PopRouletteTaskLayer")

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2 - GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)

	self.initparam = arg_3_1 or {}
	self.activityId = arg_3_1.activityId
	self._imagePath = "ActivityRoulette_" .. self.activityId

	self:initUI()
	self:registerActivityEventListener()
	activity_manager:getRouletteTaskList(self.activityId)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopRouletteTaskLayer")
		end
	end)
end

function PopRouletteTaskLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("PopRouletteTaskLayer", activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_6_0)
		arg_5_0.initparam = arg_6_0
		arg_5_0.taskList = arg_6_0.list

		arg_5_0:updateTask()
	end)
	activity_manager:registerEventListener("PopRouletteTaskLayer", activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_7_0)
		activity_manager:getRouletteTaskList(arg_5_0.activityId)
	end)
end

function PopRouletteTaskLayer:initUI()
	self:initExitTouchEvent()
	self:initTitle()
	self:playJoinInEffect()
end

function PopRouletteTaskLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_10_0:isBright() then
			return
		end

		arg_10_0:setBright(false)
		self:exit()
	end)
end

function PopRouletteTaskLayer:initTitle()
	self.panelBg = ccui.ImageView:create(self._imagePath .. "/task_bg.png", var_0_1)

	self.panelBg:setTouchEnabled(true)
	self.panelBg:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2 + 50))
	self.rootLayer:addChild(self.panelBg)
end

function PopRouletteTaskLayer:updateTask()
	if self.taksView then
		self.taksView:reloadData()

		return
	end

	self.taksView = cc.TableView:create(cc.size(580, 580))

	self.taksView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taksView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taksView:setAnchorPoint(cc.p(0, 0))
	self.taksView:setPosition(25, 13)
	self.taksView:setDelegate()
	self.panelBg:addChild(self.taksView)
	self.taksView:registerScriptHandler(function(arg_14_0, arg_14_1)
		return 563, 130
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taksView:registerScriptHandler(function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:dequeueCell()

		if not var_13_0 then
			var_13_0 = cc.TableViewCell:create()

			local var_13_2 = self:createTaskSprite(self.taskList[arg_13_1 + 1], arg_13_1 + 1)

			var_13_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_13_2:setPosition(cc.p(310, 60))
			var_13_0:addChild(var_13_2)
		else
			self:updateTaskSprite(var_13_0:getChildByTag(100), self.taskList[arg_13_1 + 1], arg_13_1 + 1)
		end

		return var_13_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taksView:registerScriptHandler(function(arg_15_0, arg_15_1)
		return #self.taskList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taksView:reloadData()
end

function PopRouletteTaskLayer:createTaskSprite(arg_16_1, arg_16_2)
	local var_16_0 = ccui.ImageView:create(self._imagePath .. "/task_bottom.png", var_0_1)

	var_16_0:setTag(100)

	local var_16_1 = cc.Label:createWithTTF(arg_16_1.task_des, FONT_NAME, 22)

	var_16_1:setColor(cc.c3b(255, 255, 255))
	var_16_1:setAnchorPoint(cc.p(0, 0.5))
	var_16_1:setPosition(cc.p(130, 92))
	var_16_1:setName("title")
	var_16_0:addChild(var_16_1)

	local var_16_2 = cc.Label:createWithTTF(arg_16_1.task_des, FONT_NAME, 18)

	var_16_2:setColor(cc.c3b(255, 255, 255))
	var_16_2:setAnchorPoint(cc.p(0, 0.5))
	var_16_2:setPosition(cc.p(130, 40))
	var_16_2:setName("des")
	var_16_0:addChild(var_16_2)

	local var_16_3 = drop_manager:getAllDrops(arg_16_1.drop)
	local var_16_4 = ccui.ImageView:create("equipment/" .. item_data[var_16_3[1].dropid].image_id .. ".png")

	var_16_4:setPosition(cc.p(70, 60))
	var_16_4:setName("icon")
	var_16_4:setScale(100 / var_16_4:getContentSize().height)
	var_16_0:addChild(var_16_4)

	local var_16_5 = cc.Label:createWithTTF("X" .. var_16_3[1].dropNum, FONT_NAME, 18)

	var_16_5:setPosition(cc.p(35, 12))
	var_16_5:setName("num")
	var_16_0:addChild(var_16_5)

	local var_16_6 = self._imagePath .. "/btn_goto.png"

	if arg_16_1.status >= 1 then
		var_16_6 = self._imagePath .. "/btn_got.png"
	elseif arg_16_1.percent >= 100 then
		var_16_6 = self._imagePath .. "/btn_get_reward.png"
	end

	local var_16_7 = ccui.Button:create(var_16_6, nil, var_16_6, var_0_1)

	var_16_7:setPosition(cc.p(500, 60))
	var_16_7:setName("btn")
	var_16_0:addChild(var_16_7)
	var_16_7:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_16_1.status >= 1 then
			return
		end

		if arg_16_1.percent >= 100 then
			activity_manager:getRouletteTaskReward(self.activityId, arg_16_1.taskid)
		else
			self:taskTumpTo(arg_16_1.jump)
		end
	end)

	local var_16_8 = ccui.Slider:create()

	var_16_8:loadBarTexture(self._imagePath .. "/progress_bg.png", var_0_1)
	var_16_8:loadProgressBarTexture(self._imagePath .. "/progress_on.png", var_0_1)
	var_16_8:setPosition(cc.p(280, 15))
	var_16_8:setPercent(arg_16_1.percent)
	var_16_8:setName("progressBar")
	var_16_0:addChild(var_16_8)

	local var_16_9 = cc.Label:createWithTTF(arg_16_1.percent .. "%", FONT_NAME, 25)

	var_16_9:setAnchorPoint(cc.p(0, 0.5))
	var_16_9:setPosition(cc.p(420, 16))
	var_16_9:setName("percent")
	var_16_9:setVisible(arg_16_1.percent >= 0)
	var_16_9:setColor(cc.c3b(159, 49, 163))
	var_16_0:addChild(var_16_9)

	return var_16_0
end

function PopRouletteTaskLayer:updateTaskSprite(arg_18_1, arg_18_2, arg_18_3)
	arg_18_1:setTag(100)
	arg_18_1:getChildByName("title"):setString(arg_18_2.task_des)

	local var_18_0 = drop_manager:getAllDrops(arg_18_2.drop)
	local var_18_1 = var_18_0[1].dropid

	arg_18_1:getChildByName("des"):setString(arg_18_2.task_des)

	local var_18_2 = self._imagePath .. "/btn_goto.png"

	if arg_18_2.status >= 1 then
		var_18_2 = self._imagePath .. "/btn_got.png"
	elseif arg_18_2.percent >= 100 then
		var_18_2 = self._imagePath .. "/btn_get_reward.png"
	end

	arg_18_1:getChildByName("btn"):loadTextures(var_18_2, nil, var_18_2, var_0_1)
	arg_18_1:getChildByName("progressBar"):setPercent(arg_18_2.percent)
	arg_18_1:getChildByName("percent"):setString(arg_18_2.percent .. "%")
	arg_18_1:getChildByName("percent"):setVisible(arg_18_2.percent >= 0)
	arg_18_1:getChildByName("num"):setString("X" .. var_18_0[1].dropNum)
	arg_18_1:getChildByName("btn"):addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_18_2.status >= 1 then
			return
		end

		if arg_18_2.percent >= 100 then
			activity_manager:getRouletteTaskReward(self.activityId, arg_18_2.taskid)
		else
			self:taskTumpTo(arg_18_2.jump)
		end
	end)

	local var_18_3 = arg_18_1:getChildByName("icon")

	var_18_3:loadTexture("equipment/" .. item_data[var_18_1].image_id .. ".png")
	var_18_3:setScale(100 / var_18_3:getContentSize().height)
end

function PopRouletteTaskLayer.taskTumpTo(arg_20_0, arg_20_1)
	if arg_20_1 then
		require("controller.goto_system_manager")
		goto_complete_system({
			jump_to_system = arg_20_1
		})
	end
end

function PopRouletteTaskLayer:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopRouletteTaskLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopRouletteTaskLayer:initBg(arg_24_1)
	local var_24_0 = ccui.Layout:create()

	var_24_0:setTouchEnabled(true)
	var_24_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_24_0:setAnchorPoint(cc.p(0, 0))
	var_24_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_24_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_24_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_24_0:setOpacity(0)
	self:addChild(var_24_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_25_0)
		self:addChild(arg_25_0, -2)
		arg_25_0:setPositionY(arg_25_0:getPositionY() - GameDisplay.fix_y)

		local var_25_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_25_0:setAnchorPoint(cc.p(0, 0))
		var_25_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_25_0, -1)
		self:init(arg_24_1)
		var_24_0:setOpacity(102)
		var_24_0:setTouchEnabled(false)
	end)
end
