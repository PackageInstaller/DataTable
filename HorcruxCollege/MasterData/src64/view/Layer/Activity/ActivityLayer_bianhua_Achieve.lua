ActivityLayer_bianhua_Achieve = class("ActivityLayer_bianhua_Achieve", function()
	return cc.Layer:create()
end)

require("view.Sprite.TitleSprite")
require("view.Sprite.BottomBtnList")

local activity_manager = require("controller.activity_manager")
local activity_bianhua_manager = require("controller.activity_bianhua_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local task_data = require("data.task_data")
local var_0_5 = config._DEBUG and 0 or 1
local var_0_6
local var_0_7 = 2093

function ActivityLayer_bianhua_Achieve.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityLayer_bianhua_Achieve.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityLayer_bianhua_Achieve.getInstance()
	return var_0_6
end

function ActivityLayer_bianhua_Achieve:init()
	var_0_6 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Activity_bianhua_achievement.json" or "Activity_bianhua_achievement.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:initData()
	self:fullScreen()
	self:registerEventListenerAll()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			if self.callback then
				self.callback()
			end

			var_0_6 = nil

			activity_manager:releaseEventListenerByName("ActivityLayer_bianhua_Achieve")
		end
	end)
end

function ActivityLayer_bianhua_Achieve:initData(arg_6_1)
	self.id = activity_bianhua_manager:getActivityId()
	self.flowerNum = item_manager:getItemNumber(85000007)
	self.activity = activity_manager:getActivityObj(self.id)
	self.purchaseStatus = false

	self.activity:getActivityTaskList(nil, function(arg_7_0, arg_7_1)
		print("ActivityLayer_bianhua_Achieve:initData")

		if arg_7_0 == 1 then
			print("result:", arg_7_0, dump(arg_7_1))
			self:sortTaskList(arg_7_1)
			self:initTaskList(arg_7_1)
		end
	end, false)
	self:initFlower()
end

function ActivityLayer_bianhua_Achieve:initUI()
	self.achiPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "achi_bg")
	self.flowerBg = ccui.Helper:seekWidgetByName(self.rootLayer, "flowerbg"):clone()

	self:initTitle()
	self:initBottomBtnList()
end

function ActivityLayer_bianhua_Achieve:initTitle()
	local var_9_0 = TitleSprite:create("public/title/title_activity_achievement.png", 2)

	var_9_0.title:setPositionX(0)
	var_9_0:setAnchorPoint(cc.p(0, 1))
	var_9_0:setPosition(0, SCREEN_HEIGHT)
	var_9_0:setName("titleBg")
	var_9_0:addChild(self.flowerBg)
	self.flowerBg:setPosition(cc.p(500, var_9_0:getContentSize().height / 2))
	self.flowerBg:setVisible(true)

	local var_9_1 = ccui.Button:create("Activity_bianhua_Achievement/infoBtn.png", "Activity_bianhua_Achievement/infoBtn.png", "Activity_bianhua_Achievement/infoBtn.png", var_0_5)

	var_9_1:setPosition(240, var_9_0:getContentSize().height / 2)
	var_9_0:addChild(var_9_1)
	var_9_1:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("显示活动信息")
		LayerManager:pushInLayer("PopActivityDetail", {
			key = string.format("activity_%d_%d", activity_bianhua_manager:getActivityId(), var_0_7)
		})
	end)
	self.rootLayer:addChild(var_9_0, 5)
end

function ActivityLayer_bianhua_Achieve:initBottomBtnList()
	self.bottomlist = BottomBtnList:create(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end, {})

	self:addChild(self.bottomlist, 5)
end

function ActivityLayer_bianhua_Achieve:initTaskList(arg_13_1)
	self.taskListData = arg_13_1
	self.taskList = cc.TableView:create(cc.size(640, GameDisplay.height - self.bottomlist:getContentSize().height - 60))

	self.taskList:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskList:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskList:setAnchorPoint(cc.p(0, 0))
	self.taskList:setPosition(0, (GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomlist:getContentSize().height + 10, TRANSFORM_UNIT.PX)))
	self.taskList:setDelegate()
	self.rootLayer:addChild(self.taskList)

	self.taskList.withaction = true

	self.taskList:registerScriptHandler(function(arg_14_0, arg_14_1)
		return self:getTaskNum(arg_13_1)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taskList:registerScriptHandler(function(arg_15_0)
		if arg_15_0:getContentOffset().y > -1 then
			self:updateScrollSign(false)
		else
			self:updateScrollSign(true)
		end
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	self.taskList:registerScriptHandler(function(arg_16_0)
		return
	end, cc.SCROLLVIEW_SCRIPT_ZOOM)
	self.taskList:registerScriptHandler(function(arg_17_0, arg_17_1)
		print("cell touched at index: " .. arg_17_1:getIdx())
	end, cc.TABLECELL_TOUCHED)
	self.taskList:registerScriptHandler(function(arg_18_0, arg_18_1)
		return 600, 160
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskList:registerScriptHandler(function(arg_19_0, arg_19_1)
		local var_19_0 = arg_19_0:dequeueCell()

		if not var_19_0 then
			var_19_0 = cc.TableViewCell:create()

			if type(arg_13_1.list[arg_19_1 + 1]) == "table" then
				arg_13_1.list[arg_19_1 + 1].index = arg_19_1 + 1
			end

			local var_19_1 = self:createAchievementInfoPanel(arg_13_1.list[arg_19_1 + 1], arg_19_1 + 1)

			var_19_1:setName("achievement_info")
			var_19_1:setVisible(true)
			var_19_1:setPosition(cc.p(30, 0))

			if arg_19_0.withaction and arg_19_1 < 8 then
				var_19_1:setOpacity(0)
				var_19_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_19_1), cc.FadeIn:create(0.1)))
			elseif var_19_1:getOpacity() < 255 then
				var_19_1:setOpacity(255)
			end

			var_19_0:addChild(var_19_1)
		else
			local var_19_2 = arg_13_1.list[arg_19_1 + 1]

			var_19_0:getChildByName("achievement_info"):setOpacity(255)
			var_19_0:getChildByName("achievement_info"):updateTaskInfo(var_19_2)
		end

		return var_19_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskList:reloadData()
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self.taskList.withaction = false
	end)))
end

function ActivityLayer_bianhua_Achieve:initFlower()
	self.flowerBg:getChildByName("flower_total_num"):setString(self:getFlowerNum())
end

function ActivityLayer_bianhua_Achieve.sortTaskList(arg_22_0, arg_22_1)
	local function var_22_0(arg_23_0)
		if arg_23_0 then
			return arg_23_0 >= 100
		else
			return false
		end
	end

	function getStatus(arg_26_0)
		if arg_26_0.status == 0 and var_22_0(arg_26_0.percent) then
			return 1
		end

		if not activity_bianhua_manager:checkHideTask(arg_26_0.taskid) and arg_26_0.status == 0 and not var_22_0(arg_26_0.percent) then
			return 2
		end

		if not activity_bianhua_manager:checkHideTask(arg_26_0.taskid) and arg_26_0.status ~= 0 then
			return 3
		end

		if activity_bianhua_manager:checkHideTask(arg_26_0.taskid) and arg_26_0.status ~= 0 then
			return 4
		end

		if activity_bianhua_manager:checkHideTask(arg_26_0.taskid) and arg_26_0.status == 0 then
			return 5
		end
	end

	local var_22_3 = {
		{
			weight = 10,
			func = function(arg_27_0, arg_27_1)
				if getStatus(arg_27_0) == getStatus(arg_27_1) then
					return "=="
				else
					return getStatus(arg_27_0) < getStatus(arg_27_1)
				end
			end
		},
		{
			weight = 1,
			func = function(self, arg_28_1)
				if not self.taskid or not arg_28_1.taskid then
					return "=="
				end

				if self.taskid == arg_28_1.taskid then
					return "=="
				else
					return self.taskid < arg_28_1.taskid
				end
			end
		}
	}

	table.sort(var_22_3, function(arg_29_0, arg_29_1)
		return arg_29_0.weight > arg_29_1.weight
	end)
	table.sort(arg_22_1.list, function(arg_30_0, arg_30_1)
		for iter_30_0 = 1, #var_22_3 do
			if var_22_3[iter_30_0].func(arg_30_0, arg_30_1) ~= "==" then
				return var_22_3[iter_30_0].func(arg_30_0, arg_30_1)
			end
		end
	end)
	print("mmmmmmmmmmmmm", dump(arg_22_1.list))
end

function ActivityLayer_bianhua_Achieve.getTaskNum(arg_31_0, arg_31_1)
	return #arg_31_1.list
end

function ActivityLayer_bianhua_Achieve:createAchievementInfoPanel(arg_32_1, arg_32_2)
	local var_32_0 = self.achiPanel:clone()

	var_32_0.index = arg_32_2

	var_32_0:getChildByName("btn_goto"):setName("btn_goto" .. var_32_0.index)

	function var_32_0:updateTaskInfo(arg_33_1)
		if type(arg_33_1) == "table" then
			self:updateTriggeredTask(arg_33_1)
		elseif type(arg_33_1) == "number" then
			self:updateFinishedTask(arg_33_1)
		end
	end

	function var_32_0:updateFinishedTask(arg_34_1)
		local var_34_0 = task_data[arg_34_1]
		local var_34_1

		if task_data[arg_34_1] and var_34_0.medal_id then
			local var_34_3 = self:getChildByName("medal")

			if not var_34_3 then
				var_34_3 = createMedal()

				var_34_3:setPosition(self:getChildByName("Image_task"):getPosition())
				self:addChild(var_34_3)
			end

			var_34_3:setVisible(true)

			local var_34_4 = itemData[tonumber(var_34_0.medal_id)]

			var_34_3:setTexture(medal_frame[var_34_4.equip_quality])
			var_34_3:setString(var_34_4.name)
			var_34_3:enableOutline(medal_colors[var_34_4.equip_quality], 1)
			var_34_3:enableShadow(medal_colors[var_34_4.equip_quality], cc.size(0, 0))

			var_34_1 = medal_frame[var_34_4.equip_quality]
		else
			var_34_1 = TASK_IMG_PATH .. ((not var_34_0.image or nil) and 1) .. ".png"

			if self:getChildByName("medal") then
				self:getChildByName("medal"):removeFromParent()
			end
		end

		self:getChildByName("name"):setString(var_34_0.name)
		self:getChildByName("des"):setString(var_34_0.task_des)
		self:getChildByName("Image_task"):loadTexture(var_34_1)
		self:getChildByName("button_goto_" .. self.index):setVisible(false)
		self:getChildByName("button_getAwards"):setVisible(false)
		self:getChildByName("button_done"):setVisible(true)
		self:updateAwardList(var_34_0.drop)
	end

	function var_32_0:updateTriggeredTask(arg_35_1)
		local var_35_1 = activity_bianhua_manager:getAchieveData(arg_35_1.taskid)
		local var_35_2 = arg_35_1.percent or -1
		local var_35_3 = activity_bianhua_manager:getFlowerNum(arg_35_1.taskid)

		local function var_35_4(arg_36_0)
			arg_35_1.percent = -1

			arg_36_0:getChildByName("btn_get"):setVisible(false)
			arg_36_0:getChildByName("btn_finish"):setVisible(true)
		end

		self:getChildByName("achi_title"):setString(var_35_1.name)
		self:getChildByName("achi_des"):setString(var_35_1.task_des)
		self:getChildByName("btn_finish"):setVisible(false)
		self:getChildByName("progress_bg"):setVisible(true)
		self:getChildByName("flower_num"):setString("X" .. tostring(var_35_3))

		if activity_bianhua_manager:checkHideTask(arg_35_1.taskid) and var_35_2 < 100 and var_35_2 ~= -1 then
			self:loadTexture("Activity_bianhua_Achievement/hide_task.png", var_0_5)
			self:getChildByName("btn_goto" .. self.index):setVisible(false)
			self:getChildByName("btn_finish"):setVisible(false)
			self:getChildByName("achi_title"):setVisible(false)
			self:getChildByName("achi_des"):setVisible(false)
			self:getChildByName("progress_bg"):setVisible(false)
			self:getChildByName("Panel_16"):setVisible(false)
			self:getChildByName("flower_num"):setVisible(false)
		elseif var_35_2 < 100 and var_35_2 ~= -1 then
			self:loadTexture("Activity_bianhua_Achievement/task_bg_normal.png", var_0_5)
			self:getChildByName("btn_goto" .. self.index):setVisible(true)
			self:getChildByName("btn_finish"):setVisible(false)
			self:getChildByName("btn_get"):setVisible(false)
			self:getChildByName("achi_title"):setVisible(true)
			self:getChildByName("achi_des"):setVisible(true)
			self:getChildByName("progress_bg"):setVisible(true)
			self:getChildByName("Panel_16"):setVisible(true)
			self:getChildByName("flower_num"):setVisible(true)
			self:getChildByName("progress_bg"):getChildByName("ProgressBar"):setPercent(var_35_2)
			self:getChildByName("progress_bg"):getChildByName("ProgressBar"):getChildByName("Label_percent"):setString(var_35_2 .. "%")
			self:getChildByName("btn_goto" .. self.index):addTouchEventListener(function(arg_37_0, arg_37_1)
				if arg_37_1 ~= ccui.TouchEventType.ended then
					return
				end

				if var_35_1.jump then
					require("controller.goto_system_manager")

					local var_37_0 = {
						jump_to_system = var_35_1.jump
					}

					var_37_0.config = system_jump_config[SYSTEMID[var_35_1.jump]] and system_jump_config[SYSTEMID[var_35_1.jump]].config

					if var_37_0.config and var_37_0.config.exitCallbackType == "function" then
						var_37_0.config.exitCallback = createExitCallback({
							jump_to_system = 2093
						}, self.initconfig)
					end

					goto_complete_system(var_37_0)
				end
			end)
			self:getChildByName("btn_get"):setVisible(false)
		elseif var_35_2 >= 100 then
			self:loadTexture("Activity_bianhua_Achievement/task_bg_normal.png", var_0_5)
			self:getChildByName("btn_goto" .. self.index):setVisible(false)
			self:getChildByName("btn_finish"):setVisible(false)
			self:getChildByName("btn_get"):setVisible(true)
			self:getChildByName("achi_title"):setVisible(true)
			self:getChildByName("achi_des"):setVisible(true)
			self:getChildByName("progress_bg"):setVisible(true)
			self:getChildByName("Panel_16"):setVisible(true)
			self:getChildByName("flower_num"):setVisible(true)
			self:getChildByName("progress_bg"):getChildByName("ProgressBar"):setPercent(var_35_2)
			self:getChildByName("progress_bg"):getChildByName("ProgressBar"):getChildByName("Label_percent"):setString(var_35_2 .. "%")
			self:getChildByName("btn_get"):setBright(true)
			self:getChildByName("btn_get"):addTouchEventListener(function(arg_38_0, arg_38_1)
				if arg_38_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_38_0:isBright() then
					return
				end

				arg_38_0:setBright(false)
				self.activity:getTaskReward(arg_35_1.taskid, function(arg_39_0, arg_39_1)
					if arg_39_0 == 1 then
						print("已领取成就奖励===", dump(arg_39_1))
						self:getTaskAward(arg_39_1)
						var_35_4(self)
					else
						print("result不为1")
					end
				end)
			end)
		else
			self:loadTexture("Activity_bianhua_Achievement/task_bg_normal.png", var_0_5)
			self:getChildByName("btn_goto" .. self.index):setVisible(false)
			self:getChildByName("btn_finish"):setVisible(true)
			self:getChildByName("btn_get"):setVisible(false)
			self:getChildByName("achi_title"):setVisible(true)
			self:getChildByName("achi_des"):setVisible(true)
			self:getChildByName("progress_bg"):setVisible(true)
			self:getChildByName("Panel_16"):setVisible(true)
			self:getChildByName("flower_num"):setVisible(true)
			self:getChildByName("progress_bg"):getChildByName("ProgressBar"):setPercent(100)
			self:getChildByName("progress_bg"):getChildByName("ProgressBar"):getChildByName("Label_percent"):setString("100%")
		end
	end

	function var_32_0:updateAwardList(arg_40_1)
		local var_40_0 = self:getChildByName("reward_list")
		local var_40_1 = drop_manager:getDropMsg(arg_40_1)

		var_40_0:setItemsMargin(10)
		var_40_0:removeAllItems()

		if var_40_1.diamond and var_40_1.diamond > 0 then
			var_40_0:pushBackCustomItem(createMoneyItem(IMAGE_DIAMOND, "X" .. var_40_1.diamond))
		end

		if var_40_1.gold and var_40_1.gold > 0 then
			var_40_0:pushBackCustomItem(createMoneyItem(IMAGE_GOLD, "X" .. var_40_1.gold, cc.size(43, 30)))
		end

		if var_40_1.equips then
			for iter_40_0, iter_40_1 in pairs(var_40_1.equips) do
				assert(itemData[iter_40_1.dropid], "itemid: " .. iter_40_1.dropid .. " is nil")
				var_40_0:pushBackCustomItem(createLabel(itemData[iter_40_1.dropid].name, "X" .. iter_40_1.dropNum))
			end
		end
	end

	var_32_0:updateTaskInfo(arg_32_1)

	return var_32_0
end

function ActivityLayer_bianhua_Achieve.getTaskAward(arg_41_0, arg_41_1)
	local var_41_0 = {
		gold = arg_41_1.gold,
		diamond = arg_41_1.diamond,
		items = arg_41_1.items
	}

	print("ddddddddddd", dump(var_41_0))
	global_gain(var_41_0)
end

function ActivityLayer_bianhua_Achieve:updateFlowerNum()
	self:setFlowerNum()
end

function ActivityLayer_bianhua_Achieve:updateUI()
	self:updateFlowerNum()
	self.flowerBg:getChildByName("flower_total_num"):setString(self:getFlowerNum())
	print("updateUI")
end

function ActivityLayer_bianhua_Achieve:cellMove()
	local var_44_0 = self.awardNum
	local var_44_1

	var_44_1 = cc.RepeatForever:create((cc.Sequence:create(cc.DelayTime:create(actionTime / 2), cc.CallFunc:create(function()
		if var_44_0 ~= 0 and self.actionCount >= var_44_0 then
			for iter_45_0 = 1, var_44_0 do
				self:updateActivityTaskTbl(self.curStage, iter_45_0)
			end

			global_gain(self.ActivityTask[self.curStage].awards)

			if playerModel.items[point] then
				self.ptPoint = playerModel.items[point].number or 0
			end

			self.taskList:stopAction(var_44_1)
			self:updateCompletedData()
		end
	end))))

	self.taskList:runAction(nil)
	self.taskList:runAction(cc.Sequence:create(cc.DelayTime:create(actionTime / 2 * 4), cc.CallFunc:create(function()
		self.taskList:scrollToIndex(var_44_0, true, actionTime * var_44_0)
	end)))
end

function ActivityLayer_bianhua_Achieve.updateScrollSign(arg_47_0, arg_47_1)
	return
end

function ActivityLayer_bianhua_Achieve.registerEventListenerAll(arg_48_0)
	activity_manager:registerEventListener("ActivityLayer_bianhua_Achieve", activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_49_0)
		arg_48_0.updateUI(arg_48_0, arg_48_0)
	end)
end

function ActivityLayer_bianhua_Achieve:fullScreen()
	local var_50_0 = self.rootLayer:getChildByName("titleBg")

	var_50_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 0, TRANSFORM_UNIT.PX)

	var_50_0:setPositionY(var_50_0.full_posY)

	self.bottomlist.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomlist:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomlist:setPositionY(self.bottomlist.full_posY)
end

function ActivityLayer_bianhua_Achieve.setPurchase(arg_51_0, arg_51_1)
	arg_51_0.purchaseStatus = arg_51_1
end

function ActivityLayer_bianhua_Achieve:getPurchase()
	return self.purchaseStatus
end

function ActivityLayer_bianhua_Achieve.setFlowerNum(arg_53_0)
	arg_53_0.flowerNum = item_manager:getItemNumber(85000007)
end

function ActivityLayer_bianhua_Achieve:getFlowerNum()
	return self.flowerNum
end
