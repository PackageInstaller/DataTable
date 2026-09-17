SpringTaskListLayer = class("SpringTaskListLayer", function()
	return PopBaseLayer:create()
end)

local filter_config_manager = require("controller.filter_config_manager")
local spring_manager = require("controller.spring_manager")
local activity_manager = require("controller.activity_manager")
local playermodel = require("model.playermodel")

require("view.Sprite.FilterListSprite")

local var_0_4 = config._DEBUG and 0 or 1
local var_0_5 = 180
local var_0_6 = 1
local var_0_7 = 2
local var_0_8 = 3
local var_0_9 = {}

var_0_9[1] = "Activity_Spring_Festival/BattlePassSpring/btn_is_getted.png"
var_0_9[2] = "Activity_Spring_Festival/BattlePassSpring/can_get.png"
var_0_9[3] = "Activity_Spring_Festival/BattlePassSpring/go_to_complete.png"

function SpringTaskListLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = SpringTaskListLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function SpringTaskListLayer:init()
	self.rootLayer = cc.Layer:create()

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.showTaskType = 1
	self.showEffect = true

	self:initUI()
	self:registerActivityEventListener()
	spring_manager:getActivityTaskData()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("SpringTaskListLayer")

			if not spring_manager:isHasCanCompleteTask() then
				activity_manager:updateActivityAlert("task", 100, false)
			end

			spring_manager:deleteTaskData()
		end
	end)
end

function SpringTaskListLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("SpringTaskListLayer", activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_6_0)
		arg_5_0:updateTaskView()
		arg_5_0:udpateGetAllBtn()
	end)
end

function SpringTaskListLayer:initUI()
	self:initTitleAndBg()
	self:initBottomList()
	self:createFilterList()
end

function SpringTaskListLayer:initTitleAndBg()
	self.titleSprite = TitleSprite:create("Activity_Spring_Festival/BattlePassSpring/task_title.png", 2, "Activity_Spring_Festival/BattlePassSpring/task_title_bg.png")

	self.titleSprite:setPosition(0, 1136 + GameDisplay.fix_y * 2 - self.titleSprite:getContentSize().height)
	self.titleSprite:setName("title_sprite")
	self.rootLayer:addChild(self.titleSprite, 25)

	self.rootpanel = ccui.ImageView:create("mainScenebg/spring_task_bg.jpg")

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2)
	self.rootpanel:setName("bottom_bg")
	self.rootpanel:setTouchEnabled(true)
	self.rootLayer:addChild(self.rootpanel)
end

function SpringTaskListLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end, {
		{
			texture = "public/button/public_button_orange.png",
			name = "get_all_reward",
			word = L_BATTLE_PASS.GET_ALL_REWARD,
			handler = function(arg_11_0, arg_11_1)
				if arg_11_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not spring_manager:isHasCanCompleteTask(self.showTaskType) then
					global_ShowBlockWords(L_BATTLE_PASS.NOT_REWARD_CAN_GET)

					return
				end

				spring_manager:getTaskRewardByType(self.showTaskType)
			end
		}
	}, "public/panelbg/under_bottom_spring.png", {
		img = "public/button/bottom_return_btn_spring.png"
	})

	self.bottomList:setName("bottomlist")
	self.rootLayer:addChild(self.bottomList, 1000)
end

function SpringTaskListLayer:createFilterList()
	self.filterList = FilterListSprite:create({
		defaultSelected = 1,
		style = "style_spring_task",
		hideAll = true,
		bagLayerType = filter_config_manager.SPRINGTASKLISTLAYER,
		filterCallback = function(self)
			if self.showTaskType == self.filterValue then
				return
			end

			self.showTaskType = self.filterValue or 1

			self:swithTaskView()
		end
	})

	self.filterList:setName("filterList")
	self.filterList:setAnchorPoint(cc.p(0, 1))
	self.filterList:setPositionX(0)
	self.filterList:setPositionY(self.titleSprite:getPositionY() - 15)
	self.rootLayer:addChild(self.filterList)
end

function SpringTaskListLayer:updateTaskView()
	self.levelListData = spring_manager:getTaskDataByType(self.showTaskType) or {}
	self.ListLen = #self.levelListData

	if self.ListLen <= 0 then
		return
	end

	if self.taskView then
		self:updateShowingCells()

		return
	end

	local var_14_0 = self.bottomList:getPositionY() + 65

	self.taskView = cc.TableView:create(cc.size(640, 1000 + GameDisplay.height - 1136))

	self.taskView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskView:setAnchorPoint(cc.p(0, 0))
	self.taskView:setPosition(0, var_14_0)
	self.taskView:setDelegate()
	self.rootLayer:addChild(self.taskView)
	self.taskView:registerScriptHandler(function(arg_15_0, arg_15_1)
		return 640, var_0_5
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskView:registerScriptHandler(function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_0:dequeueCell()

		if not var_16_0 then
			var_16_0 = cc.TableViewCell:create()

			local var_16_2 = self:createTaskSprite(self.levelListData[arg_16_1 + 1])

			var_16_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_16_2:setPosition(cc.p(320, var_0_5 / 2))
			var_16_0:addChild(var_16_2)

			if self.showEffect and arg_16_1 < 7 then
				var_16_2:setOpacity(0)
				var_16_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_16_1), cc.FadeIn:create(0.1)))
			end
		else
			local var_16_3 = var_16_0:getChildByTag(100)

			self:updateTaskSprite(var_16_3, self.levelListData[arg_16_1 + 1])

			if self.showEffect and arg_16_1 < 7 then
				var_16_3:setOpacity(0)
				var_16_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_16_1), cc.FadeIn:create(0.1)))
			elseif var_16_3:getOpacity() < 255 then
				var_16_3:setOpacity(255)
			end
		end

		return var_16_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskView:registerScriptHandler(function(arg_17_0, arg_17_1)
		return self.ListLen
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self.showEffect = false
	end)))
	self.taskView:reloadData()
end

function SpringTaskListLayer:swithTaskView()
	self.levelListData = spring_manager:getTaskDataByType(self.showTaskType) or {}
	self.ListLen = #self.levelListData

	if self.ListLen <= 0 then
		return
	end

	if not self.taskView then
		return
	end

	self.showEffect = true

	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self.showEffect = false
	end)))
	self.taskView:reloadData()
	self:udpateGetAllBtn()
end

function SpringTaskListLayer.createTaskSprite(arg_21_0, arg_21_1)
	local var_21_0 = ccui.ImageView:create("Activity_Spring_Festival/BattlePassSpring/task_bg_light.png", var_0_4)

	var_21_0:setName("sprite_bg")
	var_21_0:setTag(100)

	local var_21_1 = ccui.ImageView:create("mainScenebg/task_img/" .. arg_21_1.image .. ".png")

	var_21_1:setPosition(cc.p(130, var_0_5 / 2 - 8))
	var_21_1:setName("task_img")
	var_21_0:addChild(var_21_1)

	local var_21_2 = ccui.ImageView:create("Activity_Spring_Festival/BattlePassSpring/level_icon.png", var_0_4)

	var_21_2:setPosition(cc.p(103, var_0_5 / 2 - 65))
	var_21_0:addChild(var_21_2)

	local var_21_3 = cc.Label:createWithTTF("X" .. spring_manager:getBattlePassDrop(arg_21_1.drop)[1].dropNum, FONT_DES, 23)

	var_21_3:setName("pt_num")
	var_21_3:setColor(cc.c3b(255, 222, 0))
	var_21_3:setPosition(cc.p(153, var_0_5 / 2 - 67))
	var_21_0:addChild(var_21_3)

	local var_21_4 = cc.Label:createWithTTF(arg_21_1.name, FONT_DES, 24)

	var_21_4:setName("name_lbl")
	var_21_4:setColor(cc.c3b(253, 249, 170))
	var_21_4:setAnchorPoint(0, 0.5)
	var_21_4:setPosition(cc.p(200, 100))
	var_21_0:addChild(var_21_4)

	local var_21_5 = cc.Label:createWithTTF(arg_21_1.task_des, FONT_DES, 18)

	var_21_5:setName("desc_lbl")
	var_21_5:setColor(cc.c3b(253, 249, 170))
	var_21_5:setAnchorPoint(0, 0.5)
	var_21_5:setPosition(cc.p(200, 60))
	var_21_0:addChild(var_21_5)

	local var_21_6 = ccui.Button:create()

	if arg_21_1.status == 1 then
		var_21_6:loadTextures(var_0_9[var_0_6], nil, var_0_9[var_0_6], var_0_4)
	elseif arg_21_1.percent >= 100 then
		var_21_6:loadTextures(var_0_9[var_0_7], nil, var_0_9[var_0_7], var_0_4)
	else
		var_21_6:loadTextures(var_0_9[var_0_8], nil, var_0_9[var_0_8], var_0_4)
	end

	var_21_6:setPosition(cc.p(540, 60))
	var_21_6:setName("get_reward_btn")
	var_21_0:addChild(var_21_6)
	var_21_6:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_21_1.status == 1 then
			return
		end

		if arg_21_1.percent >= 100 then
			spring_manager:getTaskReward(arg_21_1.taskid)
		else
			arg_21_0:taskTumpTo(arg_21_1.jump)
		end
	end)

	local var_21_7 = ccui.Slider:create()

	var_21_7:setAnchorPoint(cc.p(0, 0.5))
	var_21_7:setName("progress_bar")
	var_21_7:loadBarTexture("Activity_Spring_Festival/BattlePassSpring/task_percent_bg.png", var_0_4)
	var_21_7:loadProgressBarTexture("Activity_Spring_Festival/BattlePassSpring/task_percent.png", var_0_4)
	var_21_7:setPosition(cc.p(86, 145))
	var_21_0:addChild(var_21_7, -100)

	local var_21_9 = arg_21_1.status == 1 and 100 or arg_21_1.percent

	var_21_7:setPercent(arg_21_1.status == 1 and 100 or arg_21_1.percent)

	local var_21_10 = cc.Label:createWithTTF(var_21_9 .. "%", FONT_DES, 20)

	var_21_10:setName("percent_lbl")
	var_21_10:setColor(cc.c3b(255, 222, 0))
	var_21_10:setPosition(cc.p(585, 130))
	var_21_0:addChild(var_21_10)

	return var_21_0
end

function SpringTaskListLayer.updateTaskSprite(arg_23_0, arg_23_1, arg_23_2)
	arg_23_1:getChildByName("task_img"):loadTexture("mainScenebg/task_img/" .. arg_23_2.image .. ".png")
	arg_23_1:getChildByName("pt_num"):setString("X" .. spring_manager:getBattlePassDrop(arg_23_2.drop)[1].dropNum)
	arg_23_1:getChildByName("name_lbl"):setString(arg_23_2.name)
	arg_23_1:getChildByName("desc_lbl"):setString(arg_23_2.task_des)

	local var_23_0 = arg_23_1:getChildByName("get_reward_btn")

	if arg_23_2.status == 1 then
		var_23_0:loadTextures(var_0_9[var_0_6], nil, var_0_9[var_0_6], var_0_4)
	elseif arg_23_2.percent >= 100 then
		var_23_0:loadTextures(var_0_9[var_0_7], nil, var_0_9[var_0_7], var_0_4)
	else
		var_23_0:loadTextures(var_0_9[var_0_8], nil, var_0_9[var_0_8], var_0_4)
	end

	var_23_0:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_23_2.status == 1 then
			return
		end

		if arg_23_2.percent >= 100 then
			spring_manager:getTaskReward(arg_23_2.taskid)
		else
			arg_23_0:taskTumpTo(arg_23_2.jump)
		end
	end)

	local var_23_2 = arg_23_2.status == 1 and 100 or arg_23_2.percent

	arg_23_1:getChildByName("progress_bar"):setPercent(arg_23_2.status == 1 and 100 or arg_23_2.percent)
	arg_23_1:getChildByName("percent_lbl"):setString(var_23_2 .. "%")
end

function SpringTaskListLayer:updateShowingCells()
	local var_25_0, var_25_1 = GetTableViewShowCellIdx(self.taskView, {
		maxcount = math.ceil(self.ListLen),
		cellsize = cc.size(640, var_0_5)
	})

	for iter_25_0 = var_25_0, var_25_1 do
		self.taskView:updateCellAtIndex(iter_25_0)
	end
end

function SpringTaskListLayer.taskTumpTo(arg_26_0, arg_26_1)
	if arg_26_1 == 130 then
		LayerManager:pushInLayer("SignLayerNew", {
			callback = function()
				spring_manager:getActivityTaskData()
			end
		})
	elseif arg_26_1 == 111 then
		require("controller.sign_manager"):createMidasLayer(function()
			spring_manager:getActivityTaskData()
		end)
	elseif arg_26_1 == 220 then
		LayerManager:pushInLayer("FightResultLayerNew", {
			createItemType = "itemid",
			items = playermodel.dropcache,
			surecallback = function()
				if FightLayer and FightLayer.getInstance() then
					ccui.Helper:seekWidgetByName(FightLayer.getInstance().rootLayer, "dropcache"):checkPlayerDropCache()
					AnalyticManager.collectDropcache()
				end
			end,
			cancelcallback = function()
				return
			end
		}, {
			exitCallback = function()
				spring_manager:getActivityTaskData()
			end
		})
	elseif arg_26_1 then
		require("controller.goto_system_manager")

		local var_26_0 = {
			jump_to_system = arg_26_1
		}

		var_26_0.config = system_jump_config[SYSTEMID[arg_26_1]] and system_jump_config[SYSTEMID[arg_26_1]].config

		if var_26_0.config then
			if var_26_0.config.exitCallbackType == "function" then
				var_26_0.config.exitCallback = nil
			elseif var_26_0.config.exitCallbackType == "string" then
				var_26_0.config = "MainLayer"
			end
		end

		goto_complete_system(var_26_0)
	end
end

function SpringTaskListLayer:udpateGetAllBtn()
	local var_32_0 = self.bottomList:getChildByName("get_all_reward")

	if spring_manager:isHasCanCompleteTask(self.showTaskType) then
		var_32_0:setColor(cc.c3b(255, 255, 255))
	else
		var_32_0:setColor(cc.c3b(74, 74, 74))
	end
end
