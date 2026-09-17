flychessTaskLayer = class("flychessTaskLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local drop_manager = require("controller.drop_manager")
local activity_manager = require("controller.activity_manager")
local servant_data = require("data.servant_data")
local playermodel = require("model.playermodel")
local task_data = require("data.task_data")
local item_data = require("data.item_data")
local var_0_7 = {
	fix_y = 0,
	taskviewSize = cc.size(600, 630),
	taskviewPos = cc.p(50, -12),
	taskspriteSize = {
		width = 486,
		height = 180
	},
	taskspriteSpPos = cc.p(245, 85),
	taskspriteBtnPos = cc.p(450, 80),
	taskspriteColor = cc.c3b(201, 209, 247),
	progressPos = cc.p(155, 30),
	percentPos = cc.p(390, 34)
}
local var_0_8 = {
	fix_y = 25,
	taskviewSize = cc.size(600, 640),
	taskviewPos = cc.p(30, 120),
	taskspriteSize = {
		width = 486,
		height = 180
	},
	taskspriteSpPos = cc.p(450, 102),
	taskspriteBtnPos = cc.p(450, 30),
	taskspriteColor = cc.c3b(126, 95, 74),
	progressPos = cc.p(160, 25),
	percentPos = cc.p(360, 30)
}

local function var_0_9(arg_2_0, arg_2_1)
	local var_2_0 = drop_manager:getDropMsg(arg_2_0)
	local var_2_1
	local var_2_2

	if var_2_0.gold ~= 0 then
		var_2_1 = "gold"
		var_2_2 = var_2_0.gold
	elseif var_2_0.diamond ~= 0 then
		var_2_1 = "diamond"
		var_2_2 = var_2_0.diamond
	elseif var_2_0.equips then
		for iter_2_0, iter_2_1 in pairs(var_2_0.equips) do
			var_2_1 = iter_2_1.dropid
			var_2_2 = iter_2_1.dropNum
		end
	end

	local var_2_4 = ccui.ImageView:create()

	if item_data[var_2_1].bag_item_type == kITEM_SKIN then
		var_2_4:loadTexture("roleimage/role1/" .. modelData[item_data[var_2_1].model].cute_role .. ".png")
		var_2_4:setScale(0.3)
	elseif item_data[var_2_1].bag_item_type == kITEM_HORCRUX then
		local var_2_5 = drop_manager:getAllDropsNotMerge(arg_2_0)[1].item_attr
		local var_2_6 = ccui.Layout:create()

		var_2_6:setName("starsPanel")
		var_2_6:setScale(1.75)
		var_2_6:setPositionY(58)
		var_2_6:setPositionX(200)
		var_2_4:addChild(var_2_6, 5)

		local var_2_7 = 0

		if var_2_5 then
			for iter_2_2, iter_2_3 in var_2_5:gmatch("([^&]+)=([^&]+)") do
				if iter_2_2 == "star" then
					var_2_7 = tonumber(iter_2_3)
				end
			end
		end

		for iter_2_4 = 1, var_2_7 do
			local var_2_8

			if config._DEBUG then
				var_2_8 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			var_2_8:setPosition(25, (iter_2_4 - 1) * 24 - 30)
			var_2_6:addChild(var_2_8)
		end

		var_2_4:loadTexture("equipment/" .. item_data[var_2_1].image_id .. ".png")
		var_2_4:setScale(0.3)
	elseif item_data[var_2_1].bag_item_type == kITEM_COMPONENT then
		var_2_4:removeFromParent()

		var_2_4 = nil
		var_2_4 = componentManager:create_component_icon(var_2_1)

		;(nil):setPosition(cc.p(self.championBg:getContentSize().width / 2, self.championBg:getContentSize().height / 2 + 20))
		var_2_4:setScale(0.75)
	else
		var_2_4:loadTexture("equipment/" .. item_data[var_2_1].image_id .. ".png")
		var_2_4:setScale(0.75)
	end

	local var_2_9 = cc.Label:createWithTTF("", FONT_DES, 70)

	var_2_9:setString("x" .. var_2_2)
	var_2_9:setPosition(80, 0)
	var_2_9:setName("num")
	var_2_4:addChild(var_2_9)
	var_2_4:setTouchEnabled(arg_2_1)
	var_2_4:addTouchEventListener(function(arg_3_0, arg_3_1)
		if arg_3_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[var_2_1].bag_item_type == kITEM_HORCRUX then
			showHorcruxDetails(var_2_1)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_2_1
			})
		end
	end)

	return var_2_4, var_2_2
end

function flychessTaskLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = flychessTaskLayer.new()

	var_4_0:initBg(arg_4_1)

	return var_4_0
end

function flychessTaskLayer:init(arg_5_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2 - GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)

	self.initparam = arg_5_1 or {}
	self.activityId = arg_5_1.activityId
	arg_5_1.usemodule = "flychess_daily"
	self._imagePath = "activity_flyChess_" .. self.activityId
	self.ui_conf = var_0_7

	self:initUI()
	self:registerActivityEventListener()

	self.usemodule = "flychess_daily"

	local var_5_0 = activity_manager:getActivityObj(self.activityId)

	function self.getTaskListCallback(arg_6_0, arg_6_1)
		if arg_6_0 ~= 1 then
			return
		end

		self.taskList = {}

		for iter_6_0, iter_6_1 in pairs(arg_6_1.list) do
			iter_6_1.name = task_data[iter_6_1.taskid].name
			iter_6_1.task_des = task_data[iter_6_1.taskid].task_des
			iter_6_1.image = task_data[iter_6_1.taskid].image
			iter_6_1.drop = task_data[iter_6_1.taskid].drop
			iter_6_1.jump = task_data[iter_6_1.taskid].jump
			iter_6_1.order = task_data[iter_6_1.taskid].order

			if iter_6_1.status == 1 then
				iter_6_1.percent = -1
			end

			table.insert(self.taskList, iter_6_1)
		end

		table.sort(self.taskList, function(arg_7_0, arg_7_1)
			if arg_7_0.percent == arg_7_1.percent then
				return arg_7_0.order < arg_7_1.order
			else
				return arg_7_0.percent > arg_7_1.percent
			end
		end)
		self:updateTask()
		activity_manager:update_alert(self.activityId, self.usemodule, self.taskList)
	end

	if var_5_0 then
		var_5_0:getActivityTaskList(nil, self.getTaskListCallback, false, nil, self.usemodule)
	end

	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			activity_manager:releaseEventListenerByName("flychessTaskLayer")
		end
	end)

	local var_5_1 = ccui.Button:create(self._imagePath .. "/daily_task_btn.png", nil, self._imagePath .. "/daily_task_btn.png", var_0_0)

	var_5_1:setPosition(330, 60)
	self.panelBg:addChild(var_5_1, 999)
	var_5_1:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.usemodule == "flychess_daily" then
			return
		end

		self.usemodule = "flychess_daily"

		activity_manager:getActivityObj(self.activityId):getActivityTaskList(nil, self.getTaskListCallback, false, nil, self.usemodule)
	end)

	local var_5_2 = ccui.Button:create(self._imagePath .. "/activity_task_btn.png", nil, self._imagePath .. "/activity_task_btn.png", var_0_0)

	var_5_2:setPosition(500, 60)
	self.panelBg:addChild(var_5_2, 999)
	var_5_2:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.usemodule == "flychess" then
			return
		end

		self.usemodule = "flychess"

		activity_manager:getActivityObj(self.activityId):getActivityTaskList(nil, self.getTaskListCallback, false, nil, self.usemodule)
	end)
end

function flychessTaskLayer.registerActivityEventListener(arg_11_0)
	activity_manager:registerEventListener("flychessTaskLayer", activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_12_0)
		arg_11_0.initparam = arg_12_0

		activity_manager:getActivityObj(arg_11_0.activityId):getActivityTaskList(nil, arg_11_0.getTaskListCallback, false, nil, arg_11_0.usemodule)
	end)
end

function flychessTaskLayer:initUI()
	self:initExitTouchEvent()
	self:initTitle()
	self:playJoinInEffect()
end

function flychessTaskLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_15_0:isBright() then
			return
		end

		arg_15_0:setBright(false)
		self:exit()
	end)
end

function flychessTaskLayer:initTitle()
	self.panelBg = ccui.ImageView:create(self._imagePath .. "/task_bg.png", var_0_0)

	self.panelBg:setTouchEnabled(true)
	self.panelBg:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2 + 50))
	self.rootLayer:addChild(self.panelBg)
end

function flychessTaskLayer:updateTask()
	if self.taksView then
		self.taksView:reloadData()

		return
	end

	self.taksView = cc.TableView:create(self.ui_conf.taskviewSize)

	self.taksView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taksView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taksView:setAnchorPoint(cc.p(0, 0))
	self.taksView:setPosition(self.ui_conf.taskviewPos)
	self.taksView:setPositionY(105)
	self.taksView:setDelegate()
	self.panelBg:addChild(self.taksView)
	self.taksView:registerScriptHandler(function(arg_19_0, arg_19_1)
		return self.ui_conf.taskspriteSize.width, self.ui_conf.taskspriteSize.height
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taksView:registerScriptHandler(function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_0:dequeueCell()

		if not var_18_0 then
			var_18_0 = cc.TableViewCell:create()

			local var_18_2 = self:createTaskSprite(self.taskList[arg_18_1 + 1], arg_18_1 + 1)

			var_18_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_18_2:setPosition(cc.p(275, 65))
			var_18_0:addChild(var_18_2)
		else
			self:updateTaskSprite(var_18_0:getChildByTag(100), self.taskList[arg_18_1 + 1], arg_18_1 + 1)
		end

		return var_18_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taksView:registerScriptHandler(function(arg_20_0, arg_20_1)
		return #self.taskList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taksView:reloadData()
end

function flychessTaskLayer:createTaskSprite(arg_21_1, arg_21_2)
	local var_21_0 = ccui.ImageView:create(self._imagePath .. "/task_bottom.png", var_0_0)

	var_21_0:setTag(100)

	local var_21_1 = cc.Label:createWithTTF(arg_21_1.name, FONT_NAME, 24)

	var_21_1:setColor(self.ui_conf.taskspriteColor)
	var_21_1:setAnchorPoint(cc.p(0, 0.5))
	var_21_1:setPosition(cc.p(15, 95 + self.ui_conf.fix_y))
	var_21_1:setName("title")
	var_21_0:addChild(var_21_1)

	local var_21_2 = cc.Label:createWithTTF(arg_21_1.task_des, FONT_NAME, 20)

	var_21_2:setColor(self.ui_conf.taskspriteColor)
	var_21_2:setAnchorPoint(cc.p(0, 0.5))
	var_21_2:setPosition(cc.p(15, 60 + self.ui_conf.fix_y))
	var_21_2:setName("des")
	var_21_0:addChild(var_21_2)

	local var_21_3 = ccui.ImageView:create(self._imagePath .. "/task_reward_bg.png", var_0_0)

	var_21_0:addChild(var_21_3)
	var_21_3:setPosition(self.ui_conf.taskspriteSpPos)
	var_21_3:setName("icon_bg")

	local var_21_4 = drop_manager:getDropMsg(arg_21_1.drop)
	local var_21_5 = var_0_9(arg_21_1.drop, true)

	var_21_3:addChild(var_21_5)
	var_21_5:setScale(0.3)
	var_21_5:setName("sp")
	var_21_5:setPosition(cc.p(30, 40))

	local var_21_6 = self._imagePath .. "/btn_goto.png"

	if arg_21_1.status >= 1 then
		var_21_6 = self._imagePath .. "/btn_got.png"
	elseif arg_21_1.percent >= 100 then
		var_21_6 = self._imagePath .. "/btn_get_reward.png"
	end

	local var_21_7 = ccui.Button:create(var_21_6, nil, var_21_6, var_0_0)

	var_21_7:setPosition(self.ui_conf.taskspriteBtnPos)
	var_21_7:setName("btn")
	var_21_0:addChild(var_21_7)
	var_21_7:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_21_1.status >= 1 then
			return
		end

		if arg_21_1.percent >= 100 then
			activity_manager:getArtTaskReward(self.activityId, arg_21_1.taskid)
		else
			self:taskTumpTo(arg_21_1.jump)
		end
	end)

	local var_21_8 = ccui.Slider:create()

	var_21_8:loadBarTexture(self._imagePath .. "/progress_bg.png", var_0_0)
	var_21_8:loadProgressBarTexture(self._imagePath .. "/progress_on.png", var_0_0)
	var_21_8:setPosition(self.ui_conf.progressPos)
	var_21_8:setPercent(arg_21_1.percent)
	var_21_8:setName("progressBar")

	if arg_21_1.status == 1 then
		var_21_8:setPercent(100)
	end

	var_21_0:addChild(var_21_8)

	local var_21_10 = cc.Label:createWithTTF((arg_21_1.percent >= 0 or nil) and (arg_21_1.finished > arg_21_1.need and string.format("%s/%s", arg_21_1.need, arg_21_1.need) or string.format("%s/%s", arg_21_1.finished, arg_21_1.need)), FONT_NAME, 20)

	var_21_10:setAnchorPoint(0, 0.5)
	var_21_10:setAnchorPoint(cc.p(1, 0.5))
	var_21_10:setPosition(self.ui_conf.percentPos)
	var_21_10:setName("percent")
	var_21_10:setVisible(arg_21_1.percent >= 0)
	var_21_10:setColor(self.ui_conf.taskspriteColor)
	var_21_0:addChild(var_21_10)

	if self._imagePath == "CommonTaskAirPlane" then
		local var_21_11 = ccui.ImageView:create(self._imagePath .. "/label_bg.png", var_0_0)

		var_21_11:setAnchorPoint(0, 0)
		var_21_3:addChild(var_21_11)

		local var_21_12 = var_21_5:getChildByName("num")

		var_21_12:setPosition(60, -40)
		var_21_12:setScale(0.6)
	end

	return var_21_0
end

function flychessTaskLayer:updateTaskSprite(arg_23_1, arg_23_2, arg_23_3)
	arg_23_1:setTag(100)
	arg_23_1:getChildByName("title"):setString(arg_23_2.task_des)

	local var_23_0 = drop_manager:getAllDrops(arg_23_2.drop)

	arg_23_1:getChildByName("des"):setString(arg_23_2.task_des)

	local var_23_1 = self._imagePath .. "/btn_goto.png"

	if arg_23_2.status >= 1 then
		var_23_1 = self._imagePath .. "/btn_got.png"
	elseif arg_23_2.percent >= 100 then
		var_23_1 = self._imagePath .. "/btn_get_reward.png"
	end

	arg_23_1:getChildByName("btn"):loadTextures(var_23_1, nil, var_23_1, var_0_0)
	arg_23_1:getChildByName("progressBar"):setPercent(arg_23_2.percent)

	if arg_23_2.status == 1 then
		arg_23_1:getChildByName("progressBar"):setPercent(100)
	end

	if arg_23_2.percent >= 0 then
		arg_23_1:getChildByName("percent"):setString(arg_23_2.finished > arg_23_2.need and string.format("%s/%s", arg_23_2.need, arg_23_2.need) or string.format("%s/%s", arg_23_2.finished, arg_23_2.need))
	end

	arg_23_1:getChildByName("percent"):setVisible(arg_23_2.percent >= 0)
	arg_23_1:getChildByName("btn"):addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_23_2.status >= 1 then
			return
		end

		if arg_23_2.percent >= 100 then
			activity_manager:getArtTaskReward(self.activityId, arg_23_2.taskid)
		else
			self:taskTumpTo(arg_23_2.jump)
		end
	end)

	local var_23_3 = drop_manager:getDropMsg(arg_23_2.drop)

	arg_23_1:getChildByName("icon_bg"):removeAllChildren()

	local var_23_4 = var_0_9(arg_23_2.drop, true)

	arg_23_1:getChildByName("icon_bg"):addChild(var_23_4)
	var_23_4:setScale(0.3)
	var_23_4:setPosition(cc.p(30, 40))
	var_23_4:setName("sp")

	if self._imagePath == "CommonTaskAirPlane" then
		local var_23_5 = ccui.ImageView:create(self._imagePath .. "/label_bg.png", var_0_0)

		var_23_5:setAnchorPoint(0, 0)
		arg_23_1:getChildByName("icon_bg"):addChild(var_23_5)

		local var_23_6 = var_23_4:getChildByName("num")

		var_23_6:setPosition(60, -40)
		var_23_6:setScale(0.6)
	end
end

function flychessTaskLayer.taskTumpTo(arg_25_0, arg_25_1)
	if arg_25_1 then
		require("controller.goto_system_manager")
		goto_complete_system({
			jump_to_system = arg_25_1
		})
	end
end

function flychessTaskLayer:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function flychessTaskLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function flychessTaskLayer:initBg(arg_29_1)
	local var_29_0 = ccui.Layout:create()

	var_29_0:setTouchEnabled(true)
	var_29_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_29_0:setAnchorPoint(cc.p(0, 0))
	var_29_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_29_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_29_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_29_0:setOpacity(0)
	self:addChild(var_29_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_30_0)
		self:addChild(arg_30_0, -2)
		arg_30_0:setPositionY(arg_30_0:getPositionY() - GameDisplay.fix_y)

		local var_30_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_30_0:setAnchorPoint(cc.p(0, 0))
		var_30_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_30_0, -1)
		self:init(arg_29_1)
		var_29_0:setOpacity(102)
		var_29_0:setTouchEnabled(false)
	end)
end
