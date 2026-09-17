TVTTaskLayer = class("TVTTaskLayer", function()
	return cc.Layer:create()
end)

local var_0_0
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local task_data = require("data.task_data")
local arenatft_manager = require("controller.arenatft_manager")
local var_0_5 = config._DEBUG and 0 or 1

function TVTTaskLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = TVTTaskLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function TVTTaskLayer:init()
	self.rootLayer = cc.Layer:create()

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	var_0_0 = self

	self:initUI()
	self:updateUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_0 = nil
		end
	end)
end

function TVTTaskLayer:initUI()
	self:initTitleAndBg()
	self:initBottomList()
end

function TVTTaskLayer:initTitleAndBg()
	self.titleSprite = TitleSprite:create("Activity_PointActivityLayer/title_activity_task.png", 2)

	self.titleSprite:setPosition(0, 1136 + GameDisplay.fix_y * 2 - self.titleSprite:getContentSize().height)
	self.titleSprite:setName("title_sprite")
	self.rootLayer:addChild(self.titleSprite, 25)

	self.ptBtn = ccui.Button:create("equipment/10100003.png", nil, "equipment/10100003.png")

	self.ptBtn:setScale(0.35)
	self.ptBtn:setPosition(cc.p(500, self.titleSprite:getContentSize().height / 2 - 1))
	self.titleSprite:addChild(self.ptBtn)

	self.ptTitle = cc.Label:createWithTTF(item_manager:getItemNumber(10100003), FONT_NAME, 23)

	self.ptTitle:setAnchorPoint(0, 0.5)
	self.ptTitle:setPosition(cc.p(self.ptBtn:getPositionX() + 35, self.ptBtn:getPositionY()))
	self.titleSprite:addChild(self.ptTitle)
end

function TVTTaskLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer("ThreeVsThreeLayer")
	end)

	self.bottomList:setName("bottomlist")
	self.rootLayer:addChild(self.bottomList, 1000)
end

function TVTTaskLayer:updateUI()
	self.ptTitle:setString(item_manager:getItemNumber(10100003))
	arenatft_manager:get_player_arenatft_task(function(arg_10_0)
		if not var_0_0 then
			return
		end

		self.taskData = arg_10_0

		self:updateTaskList()
	end)
end

function TVTTaskLayer:updateTaskList()
	if not self.taskData or not next(self.taskData) then
		return
	end

	if self.taskList then
		self:updateShowingCells(self.taskList, #self.taskData)

		return
	end

	local var_11_0 = 1010 + GameDisplay.height - 1136

	self.taskList = cc.TableView:create(cc.size(640, 1010 + GameDisplay.height - 1136))

	self.taskList:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskList:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskList:setAnchorPoint(cc.p(0, 0))
	self.taskList:setPosition(0, self.bottomList:getPositionY() + 72)
	self.taskList:setDelegate()
	self.rootLayer:addChild(self.taskList)
	self.taskList:registerScriptHandler(function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0:dequeueCell()

		if not var_12_0 then
			var_12_0 = cc.TableViewCell:create()

			local var_12_2 = self:createTaskSprite(self.taskData[arg_12_1 + 1])

			var_12_2:setAnchorPoint(cc.p(0, 0))
			var_12_2:setPosition(cc.p(45, 0))
			var_12_0:addChild(var_12_2)

			if arg_12_1 < math.ceil(var_11_0 / 150) then
				var_12_2:setOpacity(0)
				var_12_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_12_1), cc.FadeIn:create(0.1)))
			else
				var_12_2:setOpacity(255)
			end
		else
			local var_12_3 = var_12_0:getChildByTag(100)

			var_12_3:setOpacity(255)
			self:updateTaskSprite(var_12_3, self.taskData[arg_12_1 + 1])
		end

		return var_12_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskList:registerScriptHandler(function(arg_13_0, arg_13_1)
		return 569, 150
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskList:registerScriptHandler(function(arg_14_0, arg_14_1)
		return #self.taskData
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taskList:reloadData()
end

function TVTTaskLayer.createTaskSprite(arg_15_0, arg_15_1)
	local var_15_0 = ccui.ImageView:create("Activity_PointActivityLayer/task_bg.png", var_0_5)
	local var_15_1 = ccui.Slider:create()

	var_15_1:loadProgressBarTexture("Activity_PointActivityLayer/progress_bar.png", var_0_5)
	var_15_1:loadBarTexture("Activity_PointActivityLayer/progress_bar_bg.png", var_0_5)
	var_15_1:setPosition(cc.p(272, 132))
	var_15_1:setPercent(arg_15_1.percent or 0)
	var_15_1:setName("slider")
	var_15_0:addChild(var_15_1)

	local var_15_2 = cc.Label:createWithTTF((arg_15_1.percent or 0) .. "%", FONT_NAME, 24)

	var_15_2:setPosition(cc.p(520, 118))
	var_15_2:setName("lbl_percent")
	var_15_2:setColor(cc.c3b(161, 226, 58))
	var_15_2:setVisible(arg_15_1.percent ~= nil)
	var_15_0:addChild(var_15_2)

	local var_15_3 = ccui.ImageView:create("Activity_PointActivityLayer/frame_activity_task.png", var_0_5)

	var_15_3:setPosition(cc.p(60, 70))
	var_15_0:addChild(var_15_3)

	local var_15_4 = cc.Label:createWithTTF(arg_15_1.taskid - 20210000, FONT_NAME, 48)

	var_15_4:setPosition(cc.p(58, 70))
	var_15_4:setColor(cc.c3b(185, 225, 241))
	var_15_4:setName("num")
	var_15_0:addChild(var_15_4)

	local var_15_5 = ccui.ImageView:create("equipment/10100003.png")

	var_15_5:setScale(0.25)
	var_15_5:setPosition(cc.p(30, 20))
	var_15_0:addChild(var_15_5)

	local var_15_6 = cc.Label:createWithTTF("x" .. drop_manager:getAllDrops(task_data[arg_15_1.taskid].drop)[1].dropNum, FONT_NAME, 18)

	var_15_6:setPosition(cc.p(60, 18))
	var_15_6:setColor(cc.c3b(161, 226, 58))
	var_15_6:setName("lbl_drop_num")
	var_15_6:setAnchorPoint(cc.p(0, 0.5))
	var_15_0:addChild(var_15_6)

	local var_15_7 = cc.Label:createWithTTF(task_data[arg_15_1.taskid].name, FONT_NAME, 28)

	var_15_7:setPosition(cc.p(140, 80))
	var_15_7:setName("lbl_title")
	var_15_7:setAnchorPoint(0, 0.5)
	var_15_0:addChild(var_15_7)

	local var_15_8 = cc.Label:createWithTTF(task_data[arg_15_1.taskid].task_des, FONT_NAME, 22)

	var_15_8:setName("lbl_des")
	var_15_8:setAnchorPoint(0, 0.5)
	var_15_8:setColor(cc.c3b(167, 170, 203))
	var_15_8:setPosition(cc.p(140, 48))
	var_15_0:addChild(var_15_8)

	local var_15_9 = "Activity_PointActivityLayer/goto_button.png"

	if arg_15_1.status >= 1 then
		var_15_9 = "Activity_PointActivityLayer/button_accelerate.png"
	elseif arg_15_1.percent >= 100 then
		var_15_9 = "Activity_PointActivityLayer/receive_button.png"
	end

	local var_15_10 = ccui.Button:create(var_15_9, nil, var_15_9, var_0_5)

	var_15_10:setName("btn_get")
	var_15_10:setPosition(cc.p(450, 47))
	var_15_0:addChild(var_15_10)
	var_15_10:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_15_1.status >= 1 then
			return
		end

		if arg_15_1.percent >= 100 then
			arenatft_manager:get_task_reward(arg_15_1.taskid, function()
				if not var_0_0 then
					return
				end

				arg_15_0:updateUI()
			end)
		else
			LayerManager:switchShowLayer("ThreeVsThreeLayer")
		end
	end)
	var_15_0:setTag(100)

	return var_15_0
end

function TVTTaskLayer.updateTaskSprite(arg_18_0, arg_18_1, arg_18_2)
	arg_18_1:setTag(100)
	arg_18_1:getChildByName("slider"):setPercent(arg_18_2.percent or 0)
	arg_18_1:getChildByName("lbl_percent"):setString((arg_18_2.percent or 0) .. "%")
	arg_18_1:getChildByName("num"):setString(arg_18_2.taskid - 20210000)
	arg_18_1:getChildByName("lbl_title"):setString(task_data[arg_18_2.taskid].name)
	arg_18_1:getChildByName("lbl_des"):setString(task_data[arg_18_2.taskid].task_des)
	arg_18_1:getChildByName("lbl_percent"):setVisible(arg_18_2.percent ~= nil)
	arg_18_1:getChildByName("lbl_drop_num"):setString("x" .. drop_manager:getAllDrops(task_data[arg_18_2.taskid].drop)[1].dropNum)

	local var_18_0 = "Activity_PointActivityLayer/goto_button.png"

	if arg_18_2.status >= 1 then
		var_18_0 = "Activity_PointActivityLayer/button_accelerate.png"
	elseif arg_18_2.percent >= 100 then
		var_18_0 = "Activity_PointActivityLayer/receive_button.png"
	end

	local var_18_1 = arg_18_1:getChildByName("btn_get")

	var_18_1:loadTextures(var_18_0, nil, var_18_0, var_0_5)
	var_18_1:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_18_2.status >= 1 then
			return
		end

		if arg_18_2.percent >= 100 then
			arenatft_manager:get_task_reward(arg_18_2.taskid, function()
				if not var_0_0 then
					return
				end

				arg_18_0:updateUI()
			end)
		else
			LayerManager:switchShowLayer("ThreeVsThreeLayer")
		end
	end)
end

function TVTTaskLayer.updateShowingCells(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0, var_21_1 = GetTableViewShowCellIdx(arg_21_1, {
		maxcount = math.ceil(arg_21_2),
		cellsize = cc.size(640, 150)
	})

	for iter_21_0 = var_21_0, var_21_1 do
		arg_21_1:updateCellAtIndex(iter_21_0)
	end
end
