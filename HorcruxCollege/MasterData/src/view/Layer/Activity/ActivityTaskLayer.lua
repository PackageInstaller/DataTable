ActivityTaskLayer = class("ActivityTaskLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Sprite.BottomBtnList")

local task_manager = require("controller.task_manager")
local drop_manager = require("controller.drop_manager")
local activity_manager = require("controller.activity_manager")
local item_data = require("data.item_data")
local task_data = require("data.task_data")
local image_data = require("data.image_data")
local activity_task_stage_data = require("data.activity_task_stage_data")
local activity_conf_data = require("data.activity_conf_data")
local playermodel = require("model.playermodel")
local network = require("network.network")
local var_0_10 = config._DEBUG and 0 or 1
local var_0_11 = {}
local var_0_12
local var_0_13
local var_0_14
local var_0_15 = false
local var_0_16 = 0.3

function ActivityTaskLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityTaskLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityTaskLayer:init(arg_3_1)
	print("#######################################", dump(arg_3_1))

	var_0_12 = self
	self.initconfig = arg_3_1

	if arg_3_1 and arg_3_1.activityID then
		self.taskType = arg_3_1.activityID
	end

	self.id = self.taskType
	self.activity = activity_manager:getActivityObj(self.id)
	self.time = tonumber(os.time())
	self.awardNum = 0
	self.actionCount = 0
	var_0_14 = activity_conf_data[self.id]["item" .. string.match(arg_3_1.activity_type, "task_id(%d+)")]

	if playermodel.items[var_0_14] then
		self.ptPoint = playermodel.items[var_0_14].number or 0
	end

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityTask.json" or "ActivityTask.ExportJson")

	self:addChild(self.rootLayer)
	require("view.Sprite.TitleSprite")

	local var_3_0 = TitleSprite:create("Activity_PointActivityLayer/title_activity_task.png", 2, "Activity_PointActivityLayer/top_bg.png")

	var_3_0:setPosition(0, 1080)
	var_3_0:setName("title_sprite")
	self.rootLayer:addChild(var_3_0, 25)

	local var_3_1 = ccui.ImageView:create("Activity_PointActivityLayer/new_nameBottom.png", var_0_10)

	var_3_1:setPosition(var_3_0:getBackGroundImageTextureSize().width / 2 + 200, var_3_0:getBackGroundImageTextureSize().height / 2)
	var_3_0:addChild(var_3_1, 99)

	local var_3_2 = ccui.ImageView:create("Activity_PointActivityLayer/9000002.png", var_0_10)

	var_3_2:setScale(0.4)
	var_3_2:setPosition(cc.p(var_3_1:getContentSize().width / 2 - 80, var_3_1:getContentSize().height / 2))
	var_3_1:addChild(var_3_2, 99)

	self.labelPt = cc.Label:createWithTTF("", FONT_NAME, 26)

	self.labelPt:setColor(cc.c3b(185, 225, 241))
	self.labelPt:setAnchorPoint(cc.p(0.5, 0.5))
	self.labelPt:setPosition(cc.p(var_3_1:getContentSize().width / 2, var_3_1:getContentSize().height / 2))
	var_3_1:addChild(self.labelPt, 99)

	self.panel_tab = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_tab")
	self.taskPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "label_exp")

	self.panel_tab:removeAllItems()
	self.panel_tab:setContentSize(65, 1070)
	self.panel_tab:setItemsMargin(0)
	self.taskPanel:retain()
	self.taskPanel:removeFromParent()

	self.buttons = {}
	self.buttonStatus = {
		name = {},
		status = {}
	}

	self:getActivityTaskList()

	if initConfig then
		self:initBottomList(initConfig.returnlayer, initConfig.activityid)
	else
		self:initBottomList()
	end

	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_15 = false

			if self.taskPanel then
				self.taskPanel:release()
			end

			local var_4_0 = RoleDefault:getInstance():getIntegerForKey("ActivityPointLayer_NextPoint", 50)

			if var_4_0 ~= 999999 and var_4_0 <= self.ptPoint then
				activity_manager:updateActivityAlert("proceed", self.id)
			end

			if self.alertTag == true then
				AlertManager:unregister_alert(ALERT_ACTIVITY_TASK)
			end

			var_0_12 = nil

			activity_manager:updateActivityAlert("task", self.id, false)
		end
	end)
	self:fullScreen(self.rootLayer)
end

function ActivityTaskLayer:initBottomList(arg_5_1, arg_5_2)
	self.bottomlist = BottomBtnList:create(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()

		if callback then
			callback()
		end
	end, {})

	local var_5_0 = cc.Label:createWithTTF(L_ACTIVITY_TASK_COMPLETE_DATA.Complete_Num, FONT_TITLE, 30)

	var_5_0:setColor(cc.c3b(198, 216, 233))
	var_5_0:setAnchorPoint(cc.p(1, 0.5))
	var_5_0:setPosition(cc.p(self.bottomlist:getContentSize().width / 2 + 200, self.bottomlist:getContentSize().height / 2))
	self.bottomlist:addChild(var_5_0, 99)

	self.labelComNum = cc.Label:createWithTTF("", FONT_DES, 30)

	self.labelComNum:setColor(cc.c3b(171, 239, 58))
	self.labelComNum:setAnchorPoint(cc.p(0, 0.5))
	self.labelComNum:setPosition(cc.p(var_5_0:getPositionX() + 5, var_5_0:getPositionY()))
	self.bottomlist:addChild(self.labelComNum, 99)
	self:addChild(self.bottomlist, 5)
end

function ActivityTaskLayer:createButton(arg_7_1, arg_7_2)
	local var_7_0 = ccui.Button:create()

	var_7_0:setSwallowTouches(false)

	if arg_7_2 == self.curStage then
		var_7_0:loadTextures("public/button/selected_tab_top_on.png", "public/button/selected_tab_top_on.png", "", var_0_10)
	else
		var_7_0:loadTextures("public/button/selected_tab_mid.png", "public/button/selected_tab_mid.png", "", var_0_10)
	end

	var_7_0:setAnchorPoint(cc.p(0.5, 0.5))

	local var_7_1 = cc.Label:createWithTTF(arg_7_1, FONT_BUTTON, 25)

	var_7_1:setName("text")
	var_7_1:setColor(cc.c3b(152, 156, 183))
	var_7_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_7_1:setPosition(var_7_0:getContentSize().width / 2, var_7_0:getContentSize().height / 2 + 10)
	var_7_0:addChild(var_7_1)

	return var_7_0
end

function ActivityTaskLayer:getActivityTaskList()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(activity_task_stage_data) do
		if self.taskType == iter_8_1.activityid then
			var_8_0[tonumber(iter_8_1.stage)] = {
				finishnum = 0,
				tasknum = iter_8_1.tasknum,
				starttime = iter_8_1.starttime,
				finishtime = iter_8_1.finishtime,
				name = iter_8_1.name,
				list = {}
			}
			var_0_11[tonumber(iter_8_1.stage)] = false
		end
	end

	self.ActivityTask = var_8_0
	self.stagenum = activity_conf_data[self.taskType].stagenum
	self.curStage = 1

	self.activity:getActivityTaskList(self.curStage, function(arg_9_0, arg_9_1)
		if arg_9_0 == 0 then
			global_ShowBlockWords("ERROR!!" .. L_ACTIVITY_TASK_LIST)
		elseif arg_9_0 == 1 then
			for iter_9_0 = 1, #arg_9_1.list do
				if arg_9_1.list[iter_9_0].status == 1 then
					table.insert(var_8_0[self.curStage].list, arg_9_1.list[iter_9_0].taskid)

					var_8_0[self.curStage].finishnum = var_8_0[self.curStage].finishnum + 1
				elseif arg_9_1.list[iter_9_0].status == 2 then
					self.awardNum = self.awardNum + 1

					if next(var_8_0[self.curStage].list) ~= nil then
						for iter_9_1 = 1, #var_8_0[self.curStage].list do
							if type(var_8_0[self.curStage].list[iter_9_1]) == "table" and arg_9_1.list[iter_9_0].percent > var_8_0[self.curStage].list[iter_9_1].percent then
								table.insert(var_8_0[self.curStage].list, iter_9_1, arg_9_1.list[iter_9_0])

								break
							elseif type(var_8_0[self.curStage].list[iter_9_1]) == "number" then
								table.insert(var_8_0[self.curStage].list, iter_9_1, arg_9_1.list[iter_9_0])

								break
							elseif iter_9_1 == #var_8_0[self.curStage].list then
								table.insert(var_8_0[self.curStage].list, arg_9_1.list[iter_9_0])
							end
						end
					else
						table.insert(var_8_0[self.curStage].list, arg_9_1.list[iter_9_0])
					end
				elseif arg_9_1.list[iter_9_0].status == 0 then
					if next(var_8_0[self.curStage].list) ~= nil then
						for iter_9_2 = 1, #var_8_0[self.curStage].list do
							if type(var_8_0[self.curStage].list[iter_9_2]) == "table" and arg_9_1.list[iter_9_0].percent > var_8_0[self.curStage].list[iter_9_2].percent then
								table.insert(var_8_0[self.curStage].list, iter_9_2, arg_9_1.list[iter_9_0])

								break
							elseif type(var_8_0[self.curStage].list[iter_9_2]) == "number" then
								table.insert(var_8_0[self.curStage].list, iter_9_2, arg_9_1.list[iter_9_0])

								break
							elseif iter_9_2 == #var_8_0[self.curStage].list then
								table.insert(var_8_0[self.curStage].list, arg_9_1.list[iter_9_0])
							end
						end
					else
						table.insert(var_8_0[self.curStage].list, arg_9_1.list[iter_9_0])
					end
				end
			end

			var_8_0[self.curStage].awards = {
				gold = arg_9_1.gold,
				diamond = arg_9_1.diamond,
				items = arg_9_1.items
			}

			self:addShowTagToList()

			if not self.taskList then
				self:initTaskList()
			end

			self:cellMove()
			self:updateTaskList()
		elseif arg_9_0 == 2 then
			global_ShowBlockWords(L_ACTIVITY_END)
		elseif arg_9_0 == 3 then
			global_ShowBlockWords(L_ACTIVITY_TASK_LIST[3])
		elseif arg_9_0 == 4 then
			global_ShowBlockWords(L_ACTIVITY_TASK_LIST[4])
		end
	end)

	var_0_15 = false
end

function ActivityTaskLayer:updateActivityTaskTbl(arg_10_1, arg_10_2)
	self.ActivityTask[arg_10_1].finishnum = self.ActivityTask[arg_10_1].finishnum + 1
	self.ActivityTask[arg_10_1].list[arg_10_2] = self.ActivityTask[arg_10_1].list[arg_10_2].taskid
end

function ActivityTaskLayer:initSwitchButtons(arg_11_1)
	if self.ActivityTask and next(self.ActivityTask) ~= nil then
		for iter_11_0 = 1, #self.ActivityTask do
			if arg_11_1 >= global_get_time_by_date(self.ActivityTask[iter_11_0].starttime) and arg_11_1 <= global_get_time_by_date(self.ActivityTask[iter_11_0].finishtime) then
				table.insert(self.buttonStatus.name, self.ActivityTask[iter_11_0].name)
				table.insert(self.buttonStatus.status, 1)
			elseif arg_11_1 < global_get_time_by_date(self.ActivityTask[iter_11_0].starttime) then
				table.insert(self.buttonStatus.name, L_ACTIVITY_TASK_SWITCH_BTN_LOCK)
				table.insert(self.buttonStatus.status, 0)
			elseif arg_11_1 > global_get_time_by_date(self.ActivityTask[iter_11_0].finishtime) then
				table.insert(self.buttonStatus.name, self.ActivityTask[iter_11_0].name)
				table.insert(self.buttonStatus.status, 2)
			end
		end
	else
		print("error: the stage not exist")

		return
	end

	for iter_11_1 = 1, #self.buttonStatus.name do
		table.insert(self.buttons, (self:createButton(self.buttonStatus.name[iter_11_1], iter_11_1)))
	end

	for iter_11_2 = 1, #self.buttons do
		self.panel_tab:pushBackCustomItem(self.buttons[iter_11_2])
		self.buttons[iter_11_2]:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_0_15 then
				print("global_button_lock exist")

				return
			end

			if math.abs(arg_12_0:getTouchBeganPosition().y - arg_12_0:getTouchEndPosition().y) > 50 then
				return
			end

			if iter_11_2 == self.curStage then
				print("self.curStage didnt change")

				return
			end

			if self.buttonStatus.status[iter_11_2] == 1 then
				self:switchTaskList(iter_11_2)
			elseif self.buttonStatus.status[iter_11_2] == 0 then
				global_ShowBlockWords(L_ACTIVITY_STAGE_TASK_LIST[0])
			elseif self.buttonStatus.status[iter_11_2] == 2 then
				global_ShowBlockWords(L_ACTIVITY_STAGE_TASK_LIST[2])
			end
		end)
	end

	self:updateTaskAlert()
end

function ActivityTaskLayer.updataSwitchButtons(arg_13_0)
	return
end

function ActivityTaskLayer:updateTaskAlert()
	for iter_14_0, iter_14_1 in pairs(var_0_11) do
		var_0_11[iter_14_0] = type(self.ActivityTask[iter_14_0].list[1]) == "table" and self.ActivityTask[iter_14_0].list[1].percent >= 100

		AlertManager:add_redDot(self.buttons[iter_14_0], var_0_11[iter_14_0], cc.p(20, 140))
	end
end

function ActivityTaskLayer:getListLen()
	return #self.ActivityTask[self.curStage].list
end

function ActivityTaskLayer.updateShowingCells(arg_16_0)
	return function()
		arg_16_0:getActivityTaskList()

		local var_17_0, var_17_1 = GetTableViewShowCellIdx(arg_16_0.taskList, {
			cellsize = cc.size(569, 150),
			maxcount = arg_16_0:getListLen()
		})

		for iter_17_0 = var_17_0, var_17_1 do
			arg_16_0.taskList:updateCellAtIndex(iter_17_0)
		end
	end
end

function ActivityTaskLayer:initTaskList()
	self.taskList = cc.TableView:create(cc.size(640, 1010 + GameDisplay.height - 1136))

	self.taskList:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskList:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskList:setAnchorPoint(cc.p(0, 0))
	self.taskList:setPosition(-10, (GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, GameDisplay.fix_y + self.bottomlist:getContentSize().height, TRANSFORM_UNIT.PX)))
	self.taskList:setDelegate()
	self.rootLayer:addChild(self.taskList)
	self.taskList:registerScriptHandler(function(arg_19_0, arg_19_1)
		return 569, 150
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskList:registerScriptHandler(function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0:dequeueCell()

		if not var_20_0 then
			var_20_0 = cc.TableViewCell:create()

			if type(self.ActivityTask[self.curStage].list[arg_20_1 + 1]) == "table" then
				self.ActivityTask[self.curStage].list[arg_20_1 + 1].index = arg_20_1 + 1
			end

			local var_20_1 = self:createTaskInfoPanel(self.ActivityTask[self.curStage].list[arg_20_1 + 1])

			var_20_1:setName("taskinfo")
			var_20_1:setPosition(cc.p(30, 0))

			if arg_20_0.withaction and arg_20_1 < 7 then
				var_20_1:setOpacity(0)
				var_20_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_20_1), cc.FadeIn:create(0.1)))
			end

			var_20_0:addChild(var_20_1)
		else
			local var_20_2 = self.ActivityTask[self.curStage].list[arg_20_1 + 1]

			if type(self.ActivityTask[self.curStage].list[arg_20_1 + 1]) == "table" then
				var_20_2.index = arg_20_1 + 1
			end

			var_20_0:getChildByName("taskinfo"):updateTaskInfo(var_20_2)

			if arg_20_0.withaction and arg_20_1 < 7 then
				var_20_0:getChildByName("taskinfo"):setOpacity(0)
				var_20_0:getChildByName("taskinfo"):runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_20_1), cc.FadeIn:create(0.1)))
			end
		end

		return var_20_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskList:registerScriptHandler(function(arg_21_0, arg_21_1)
		return self.curtaskListLen
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taskList:reloadData()
end

function ActivityTaskLayer:switchTaskList(arg_22_1)
	self.curStage = arg_22_1
	curStage = self.curStage
	self.taskList.withaction = true
	var_0_15 = true

	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		var_0_15 = false
		self.taskList.withaction = false
	end)))

	if next(self.ActivityTask[self.curStage].list) == nil then
		self.activity:getActivityTaskList(self.curStage, function(arg_24_0, arg_24_1)
			if arg_24_0 == 0 then
				global_ShowBlockWords(L_ACTIVITY_TASK_LIST[0])
			elseif arg_24_0 == 1 then
				for iter_24_0 = 1, #arg_24_1 do
					if arg_24_1[iter_24_0].status == 1 then
						table.insert(self.ActivityTask[self.curStage].list, arg_24_1[iter_24_0].taskid)
					elseif next(self.ActivityTask[self.curStage].list) ~= nil then
						for iter_24_1 = 1, #self.ActivityTask[self.curStage].list do
							if type(self.ActivityTask[self.curStage].list[iter_24_1]) == "table" and arg_24_1[iter_24_0].percent > self.ActivityTask[self.curStage].list[iter_24_1].percent then
								table.insert(self.ActivityTask[self.curStage].list, iter_24_1, arg_24_1[iter_24_0])

								break
							elseif type(self.ActivityTask[self.curStage].list[iter_24_1]) == "number" then
								table.insert(self.ActivityTask[self.curStage].list, iter_24_1, arg_24_1[iter_24_0])

								break
							elseif iter_24_1 == #self.ActivityTask[self.curStage].list then
								table.insert(self.ActivityTask[self.curStage].list, arg_24_1[iter_24_0])
							end
						end
					else
						table.insert(self.ActivityTask[self.curStage].list, arg_24_1[iter_24_0])
					end
				end

				self:updateTaskList()
			elseif arg_24_0 == 2 then
				global_ShowBlockWords(L_ACTIVITY_END)
			elseif arg_24_0 == 3 then
				global_ShowBlockWords(L_ACTIVITY_TASK_LIST[3])
			elseif arg_24_0 == 4 then
				global_ShowBlockWords(L_ACTIVITY_TASK_LIST[4])
			end
		end)
	else
		self:updateTaskList()
	end
end

function ActivityTaskLayer:updateCompletedData()
	self.labelPt:setString(self.ptPoint)
	self.labelComNum:setString(self.ActivityTask[self.curStage].finishnum .. "/" .. self.ActivityTask[self.curStage].tasknum)
end

function ActivityTaskLayer:updateTaskList()
	self:updateCompletedData()
	self.taskList:reloadData()
end

function ActivityTaskLayer:cellMove()
	local var_28_0 = self.awardNum
	local var_28_1

	var_28_1 = cc.RepeatForever:create((cc.Sequence:create(cc.DelayTime:create(var_0_16 / 2), cc.CallFunc:create(function()
		if var_28_0 ~= 0 and self.actionCount >= var_28_0 then
			for iter_29_0 = 1, var_28_0 do
				self:updateActivityTaskTbl(self.curStage, iter_29_0)
			end

			global_gain(self.ActivityTask[self.curStage].awards)

			if playermodel.items[var_0_14] then
				self.ptPoint = playermodel.items[var_0_14].number or 0
			end

			self.taskList:stopAction(var_28_1)
			self:updateCompletedData()
		end
	end))))

	self.taskList:runAction(nil)
	self.taskList:runAction(cc.Sequence:create(cc.DelayTime:create(var_0_16 / 2 * 4), cc.CallFunc:create(function()
		self.taskList:scrollToIndex(var_28_0, true, var_0_16 * var_28_0)
	end)))
end

function ActivityTaskLayer:createTaskInfoPanel(arg_31_1)
	local var_31_0 = self.taskPanel:clone()

	function var_31_0:completeTaskAction()
		self:getChildByName("button_done"):setVisible(true)
		self:getChildByName("button_goto"):setVisible(false)

		local var_32_1 = self:getChildByName("button_done")

		var_32_1:setVisible(false)
		var_32_1:setScale(1.5)
		self.taskList:runAction((cc.Sequence:create(cc.DelayTime:create(self.delayTime), cc.CallFunc:create(function()
			var_32_1:setVisible(true)
			var_32_1:runAction(cc.ScaleTo:create(var_0_16, 1, 1))

			self.actionCount = self.actionCount + 1
		end))))
	end

	function var_31_0:updateTaskInfo(arg_34_1)
		if type(arg_34_1) == "number" then
			self:updateFinishedTask(arg_34_1)
		elseif type(arg_34_1) == "table" then
			self.index = arg_34_1.index
			self.delayTime = var_0_16 / 2 * ((arg_34_1.index - 1) % 7)

			self:updateTriggeredTask(arg_34_1)
		end
	end

	function var_31_0:updateBasicTask(arg_35_1)
		local var_35_2 = drop_manager:getDropMsg(arg_35_1.drop)

		if var_35_2.equips then
			for iter_35_0, iter_35_1 in pairs(var_35_2.equips) do
				self:getChildByName("button_goto"):getChildByName("label_pt"):setString("X" .. iter_35_1.dropNum)
			end
		end

		self:getChildByName("button_done"):setTouchEnabled(false)
		self:getChildByName("task_id"):setString(arg_35_1.order)
		self:getChildByName("name"):setString(arg_35_1.name)
		self:getChildByName("des"):setString(arg_35_1.task_des)

		local var_35_3 = self:getChildByName("progress_bg"):getChildByName("progress_bar")

		var_35_3:setVisible(true)
		var_35_3:setPercent(arg_35_1.percent)
		var_35_3:getChildByName("percentage"):setString(arg_35_1.percent .. "%")

		if arg_35_1.percent == 0 or arg_35_1.percent == 100 then
			var_35_3:setVisible(false)
		end
	end

	function var_31_0:updateFinishedTask(arg_36_1)
		task_data[arg_36_1].percent = 100

		self:updateBasicTask(task_data[arg_36_1])
		self:getChildByName("button_goto"):setVisible(false)
		self:getChildByName("button_done"):setVisible(true)
	end

	function var_31_0:updateTriggeredTask(arg_37_1)
		local var_37_0 = tonumber(arg_37_1.taskid)
		local var_37_2 = task_data[var_37_0]

		if next(task_data[var_37_0]) == nil then
			print("curData is nil, curtask = ", var_37_0)
		end

		task_data[var_37_0].percent = arg_37_1.percent

		self:updateBasicTask(task_data[var_37_0])

		if arg_37_1.percent < 100 then
			self:getChildByName("button_done"):setVisible(false)
			self:getChildByName("button_goto"):setVisible(true)
			self:getChildByName("button_goto"):addTouchEventListener(function(arg_38_0, arg_38_1)
				if arg_38_1 ~= ccui.TouchEventType.ended then
					return
				end

				if var_37_2.jump == 130 then
					LayerManager:pushInLayer("SignLayerNew")
				elseif var_37_2.jump == 111 then
					require("controller.sign_manager"):createMidasLayer((self:updateShowingCells()))
				elseif var_37_2.jump == 220 then
					LayerManager:pushInLayer("FightResultLayerNew", {
						createItemType = "itemid"
					}, {
						exitCallback = self:updateShowingCells()
					})
				else
					var_0_13 = self.curStage

					require("controller.goto_system_manager")

					local var_38_0 = {
						jump_to_system = var_37_2.jump
					}

					var_38_0.config = system_jump_config[SYSTEMID[var_37_2.jump]] and system_jump_config[SYSTEMID[var_37_2.jump]].config

					if var_38_0.config and var_38_0.config.exitCallbackType == "function" then
						var_38_0.config.exitCallback = createExitCallback({
							jump_to_system = 1210
						}, self.initconfig)
					end

					goto_complete_system(var_38_0)
				end
			end)
		else
			self:getChildByName("button_goto"):setVisible(false)
			self:getChildByName("button_done"):setVisible(true)
			self:completeTaskAction()
			self:updateCompletedData()
		end
	end

	var_31_0:updateTaskInfo(arg_31_1)

	return var_31_0
end

function ActivityTaskLayer.confirmAwards(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	arg_39_2:getChildByName("button_done"):setVisible(false)
	;(function(arg_40_0)
		print("result = = = =", arg_40_0)

		if arg_40_0 == 0 then
			global_ShowBlockWords(L_ACTIVITY_TASK_COMFIRM_AWARDS[0])
		elseif arg_40_0 == 1 then
			-- block empty
		elseif arg_40_0 == 2 then
			global_ShowBlockWords(L_ACTIVITY_TASK_COMFIRM_AWARDS[2])
		elseif arg_40_0 == 3 then
			for iter_40_0, iter_40_1 in pairs(arg_39_0.ActivityTask) do
				for iter_40_2, iter_40_3 in pairs(iter_40_1.list) do
					if type(iter_40_3) == "table" and tonumber(iter_40_3.taskid) == tonumber(arg_39_3.pre) and iter_40_3.status == 0 then
						global_ShowBlockWords(L_ACTIVITY_TASK_COMFIRM_AWARDS[3])

						return
					end
				end
			end
		elseif arg_40_0 == 4 then
			global_ShowBlockWords(L_ACTIVITY_TASK_COMFIRM_AWARDS[4])
		end
	end)(1)
end

function ActivityTaskLayer:updateLockButton()
	self.buttonStatus = {
		name = {},
		status = {}
	}

	if time >= global_get_time_by_date(ActivityTask[i].starttime) and time <= global_get_time_by_date(ActivityTask[i].finishtime) then
		table.insert(self.buttonStatus.name, ActivityTask[i].name)
		table.insert(self.buttonStatus.status, 1)
	elseif time < global_get_time_by_date(ActivityTask[i].starttime) then
		table.insert(self.buttonStatus.name, L_ACTIVITY_TASK_SWITCH_BTN_LOCK)
		table.insert(self.buttonStatus.status, 0)
	elseif time > global_get_time_by_date(ActivityTask[i].finishtime) then
		table.insert(self.buttonStatus.name, ActivityTask[i].name)
		table.insert(self.buttonStatus.status, 2)
	end

	for iter_41_0 = 1, #self.buttons do
		self.buttons[iter_41_0]:getChildByName("text"):setString(self.buttonStatus.name[iter_41_0])
	end
end

function ActivityTaskLayer:showSettleAccountWindow()
	self.taskList:stopAllActions()
end

function ActivityTaskLayer:addShowTagToList()
	local var_43_0 = self.ActivityTask[self.curStage].list

	local function var_43_1(arg_44_0, arg_44_1)
		if task_data[arg_44_0].continue_task then
			local var_44_0 = tonumber(task_data[arg_44_0].continue_task)

			for iter_44_0 = arg_44_1 + 1, #var_43_0 do
				if type(var_43_0[iter_44_0]) == "number" then
					break
				end

				if var_43_0[iter_44_0].showTag == false then
					break
				end

				if var_43_0[iter_44_0].taskid == var_44_0 then
					var_43_0[iter_44_0].showTag = false

					table.insert(var_43_0, (table.remove(var_43_0, iter_44_0)))

					self.curtaskListLen = self.curtaskListLen - 1

					var_43_1(var_44_0, iter_44_0 - 1)
				end
			end
		end
	end

	self.curtaskListLen = #self.ActivityTask[self.curStage].list

	for iter_43_0 = 1, #self.ActivityTask[self.curStage].list do
		if type(self.ActivityTask[self.curStage].list[iter_43_0]) == "number" then
			break
		end

		if self.ActivityTask[self.curStage].list[iter_43_0].showTag == false then
			break
		end

		if self.ActivityTask[self.curStage].list[iter_43_0].showTag ~= false then
			self.ActivityTask[self.curStage].list[iter_43_0].showTag = true
		end

		if self.ActivityTask[self.curStage].list[iter_43_0].status == 0 then
			var_43_1(self.ActivityTask[self.curStage].list[iter_43_0].taskid, iter_43_0)
		end
	end
end

function ActivityTaskLayer:fullScreen(arg_45_1)
	arg_45_1:setContentSize((GameDisplay.getScreenSize()))
	arg_45_1:setPositionY(arg_45_1:getPositionY() - GameDisplay.fix_y)
	arg_45_1:getChildByName("title_sprite"):setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56))
	self.bottomlist:setPositionY(self.bottomlist:getPositionY() - GameDisplay.fix_y)
end
