ActivityQuestionPtTaskLayer = class("ActivityQuestionPtTaskLayer", function()
	return cc.Layer:create()
end)

local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local shop_manager = require("controller.shop_manager")
local item_data = require("data.item_data")
local shop_data = require("data.shop_data")
local playermodel = require("model.playermodel")

require("view.Sprite.FilterListSprite")

local var_0_6 = config._DEBUG and 0 or 1
local var_0_7 = 180
local var_0_8 = 1
local var_0_9 = 18
local var_0_10 = 1
local var_0_11 = 2
local var_0_12 = 3
local var_0_13 = 1
local var_0_14 = 2
local var_0_15 = {}

var_0_15[1] = "Activity_lamia/btn_is_getted.png"
var_0_15[2] = "Activity_lamia/can_get.png"
var_0_15[3] = "Activity_lamia/go_to_complete.png"

local function var_0_16(arg_2_0)
	if arg_2_0 >= 86400 then
		return string.format("%02d天%02d小时", math.floor(arg_2_0 / 86400), math.floor(arg_2_0 % 86400 / 3600))
	elseif arg_2_0 >= 3600 then
		return string.format("%02d小时%02d分钟", math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60))
	else
		return string.format("%02d分钟%02d秒", math.floor(arg_2_0 / 60), math.floor(arg_2_0 % 60))
	end
end

function ActivityQuestionPtTaskLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ActivityQuestionPtTaskLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ActivityQuestionPtTaskLayer:init()
	self.rootLayer = cc.Layer:create()

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.showTaskType = 1
	self.showEffect = true

	self:initUI()
	self:registerActivityEventListener()
	self:getActivityTaskData()
	self:getActivityShopItem()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivityQuestionPtTaskLayer")

			if not self:isHasCanCompleteTask() then
				activity_manager:updateActivityAlert("task", var_0_9, false)
			else
				activity_manager:updateActivityAlert("task", var_0_9, true)
			end
		end
	end)
end

function ActivityQuestionPtTaskLayer.registerActivityEventListener(arg_6_0)
	activity_manager:registerEventListener("ActivityQuestionPtTaskLayer", activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_7_0)
		arg_6_0:updateTaskView()
	end)
	activity_manager:registerEventListener("ActivityQuestionPtTaskLayer", activity_manager.activityEventId.WEEK_TASK_NEED_UPDATE, function(arg_8_0)
		arg_6_0:getActivityTaskData()
	end)
	activity_manager:registerEventListener("ActivityQuestionPtTaskLayer", activity_manager.activityEventId.GET_ACTIVITY_SHOP_ITEM, function(arg_9_0)
		arg_6_0.shopitem = arg_9_0.shopitem

		arg_6_0:updatebuyGiftBtn()
	end)
end

function ActivityQuestionPtTaskLayer:initUI()
	self:initTitleAndBg()
	self:initBottomList()
	self:createSwitchBtn()
end

function ActivityQuestionPtTaskLayer:initTitleAndBg()
	self.titleSprite = TitleSprite:create("ActivityQuestionPtLayer/task_title.png", 2)

	self.titleSprite:setPosition(0, 1136 + GameDisplay.fix_y * 2 - self.titleSprite:getContentSize().height)
	self.titleSprite:setName("title_sprite")
	self.rootLayer:addChild(self.titleSprite, 25)

	self.ptBtn = ccui.Button:create("ActivityQuestionPtLayer/btn_pt_num.png", nil, "ActivityQuestionPtLayer/btn_pt_num.png", var_0_6)

	self.ptBtn:setPosition(cc.p(540, self.titleSprite:getContentSize().height / 2 - 1))
	self.titleSprite:addChild(self.ptBtn)

	self.ptTitle = cc.Label:createWithTTF(item_manager:getItemNumber(9000006), FONT_NAME, 23)

	self.ptTitle:setPosition(cc.p(self.ptBtn:getContentSize().width / 2 + 5, self.ptBtn:getContentSize().height / 2 - 1))
	self.ptBtn:addChild(self.ptTitle)
end

function ActivityQuestionPtTaskLayer:updatebuyGiftBtn()
	self.ptBtn:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_manager:getItemNumber(9000006) >= 4000 then
			global_ShowBlockWords(L_ACTIVITY_QUESTION.PT_ENOUGH)

			return
		end

		self:shopByPtLayer()
	end)
end

function ActivityQuestionPtTaskLayer:updateTitleAndbottom()
	self.ptTitle:setString(item_manager:getItemNumber(9000006))

	if self.showTaskType == var_0_13 then
		self.bottomLbl:setString(string.format(L_LESS_TIME_REFISH, var_0_16((global_get_rest_of_the_week()))))
	else
		self.bottomLbl:setString(self:getTaskProgress(self.showTaskType))
	end
end

function ActivityQuestionPtTaskLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer("ActivityQuestionPtLayer")
	end)

	self.bottomList:setName("bottomlist")
	self.rootLayer:addChild(self.bottomList, 1000)

	self.bottomLbl = cc.Label:createWithTTF("aaa", FONT_NAME, 28)

	self.bottomLbl:setAnchorPoint(cc.p(1, 0.5))
	self.bottomLbl:setPosition(cc.p(600, self.bottomList:getContentSize().height / 2))
	self.bottomList:addChild(self.bottomLbl)
end

function ActivityQuestionPtTaskLayer:createSwitchBtn()
	self.btnWeek = ccui.Button:create("ActivityQuestionPtLayer/btn_week_on.png", nil, "ActivityQuestionPtLayer/btn_week_on.png", var_0_6)

	self.btnWeek:setPosition(cc.p(30, self.titleSprite:getPositionY() - 100))
	self.rootLayer:addChild(self.btnWeek)
	self.btnWeek:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.showTaskType == var_0_13 then
			return
		end

		self.showTaskType = var_0_13

		self.btnWeek:loadTextures("ActivityQuestionPtLayer/btn_week_on.png", nil, "ActivityQuestionPtLayer/btn_week_on.png", var_0_6)
		self.btnSpTask:loadTextures("ActivityQuestionPtLayer/btn_sp.png", nil, "ActivityQuestionPtLayer/btn_sp.png", var_0_6)
		self:swithTaskView()
	end)

	self.btnSpTask = ccui.Button:create("ActivityQuestionPtLayer/btn_sp.png", nil, "ActivityQuestionPtLayer/btn_sp.png", var_0_6)

	self.btnSpTask:setPosition(cc.p(30, self.titleSprite:getPositionY() - 280))
	self.rootLayer:addChild(self.btnSpTask)
	self.btnSpTask:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.showTaskType == var_0_14 then
			return
		end

		self.showTaskType = var_0_14

		self.btnWeek:loadTextures("ActivityQuestionPtLayer/btn_week.png", nil, "ActivityQuestionPtLayer/btn_week.png", var_0_6)
		self.btnSpTask:loadTextures("ActivityQuestionPtLayer/btn_ap_on.png", nil, "ActivityQuestionPtLayer/btn_ap_on.png", var_0_6)
		self:swithTaskView()
	end)
end

function ActivityQuestionPtTaskLayer:updateTaskView()
	self.levelListData = self:getTaskDataByType(self.showTaskType) or {}
	self.ListLen = #self.levelListData

	if self.ListLen <= 0 then
		return
	end

	self:updateTitleAndbottom()

	if self.taskView then
		self:updateShowingCells()

		return
	end

	local var_20_0 = self.bottomList:getPositionY() + 65

	self.taskView = cc.TableView:create(cc.size(640, 1000 + GameDisplay.height - 1136))

	self.taskView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskView:setAnchorPoint(cc.p(0, 0))
	self.taskView:setPosition(0, var_20_0)
	self.taskView:setDelegate()
	self.rootLayer:addChild(self.taskView)
	self.taskView:registerScriptHandler(function(arg_21_0, arg_21_1)
		return 640, var_0_7
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskView:registerScriptHandler(function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0:dequeueCell()

		if not var_22_0 then
			var_22_0 = cc.TableViewCell:create()

			local var_22_2 = self:createTaskSprite(self.levelListData[arg_22_1 + 1])

			var_22_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_22_2:setPosition(cc.p(350, var_0_7 / 2))
			var_22_0:addChild(var_22_2)

			if self.showEffect and arg_22_1 < 7 then
				var_22_2:setOpacity(0)
				var_22_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_22_1), cc.FadeIn:create(0.1)))
			end
		else
			local var_22_3 = var_22_0:getChildByTag(100)

			self:updateTaskSprite(var_22_3, self.levelListData[arg_22_1 + 1])

			if self.showEffect and arg_22_1 < 7 then
				var_22_3:setOpacity(0)
				var_22_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_22_1), cc.FadeIn:create(0.1)))
			elseif var_22_3:getOpacity() < 255 then
				var_22_3:setOpacity(255)
			end
		end

		return var_22_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskView:registerScriptHandler(function(arg_23_0, arg_23_1)
		return self.ListLen
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self.showEffect = false
	end)))
	self.taskView:reloadData()
end

function ActivityQuestionPtTaskLayer:swithTaskView()
	self.levelListData = self:getTaskDataByType(self.showTaskType) or {}
	self.ListLen = #self.levelListData

	if self.ListLen <= 0 then
		if self.taskView then
			self.taskView:reloadData()
		end

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
	self:updateTitleAndbottom()
end

function ActivityQuestionPtTaskLayer:createTaskSprite(arg_27_1)
	local var_27_0 = ccui.ImageView:create("Activity_lamia/task_bg.png", var_0_6)

	var_27_0:setName("sprite_bg")
	var_27_0:setTag(100)

	local var_27_1 = ccui.ImageView:create("mainScenebg/task_img/" .. arg_27_1.image .. ".png")

	var_27_1:setScale(0.4)
	var_27_1:setPosition(cc.p(25, var_0_7 / 2 - 70))
	var_27_1:setName("task_img")
	var_27_0:addChild(var_27_1)

	local var_27_2 = ccui.ImageView:create("mainScenebg/task_img/" .. arg_27_1.image .. ".png")

	var_27_2:setScale(var_0_8)
	var_27_2:setPosition(cc.p(53, var_0_7 / 2 - 12))
	var_27_2:setName("ptImg")
	var_27_0:addChild(var_27_2)

	local var_27_3 = cc.Label:createWithTTF("X" .. self:getBattlePassDrop(arg_27_1.drop)[1].dropNum, FONT_DES, 23)

	var_27_3:setName("pt_num")
	var_27_3:setAnchorPoint(cc.p(0, 0.5))
	var_27_3:setColor(cc.c3b(255, 230, 0))
	var_27_3:setPosition(cc.p(43, var_0_7 / 2 - 67 - 5))
	var_27_0:addChild(var_27_3)

	local var_27_4 = cc.Label:createWithTTF(arg_27_1.name, FONT_DES, 24)

	var_27_4:setName("name_lbl")
	var_27_4:setColor(cc.c3b(253, 249, 170))
	var_27_4:setAnchorPoint(0, 0.5)
	var_27_4:setPosition(cc.p(150, 100))
	var_27_0:addChild(var_27_4)

	local var_27_5 = cc.Label:createWithTTF(arg_27_1.task_des, FONT_DES, 20)

	var_27_5:setMaxLineWidth(210)
	var_27_5:setName("desc_lbl")
	var_27_5:setColor(cc.c3b(253, 249, 170))
	var_27_5:setAnchorPoint(0, 1)
	var_27_5:setPosition(cc.p(150, 70))
	var_27_0:addChild(var_27_5)

	local var_27_6 = ccui.Button:create()

	if arg_27_1.status == 1 then
		var_27_6:loadTextures(var_0_15[var_0_10], nil, var_0_15[var_0_10], var_0_6)
	elseif arg_27_1.percent >= 100 then
		var_27_6:loadTextures(var_0_15[var_0_11], nil, var_0_15[var_0_11], var_0_6)
	else
		var_27_6:loadTextures(var_0_15[var_0_12], nil, var_0_15[var_0_12], var_0_6)
	end

	var_27_6:setPosition(cc.p(464, 50))
	var_27_6:setName("get_reward_btn")
	var_27_0:addChild(var_27_6)
	var_27_6:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_27_1.status == 1 then
			return
		end

		if arg_27_1.percent >= 100 then
			self:getTaskReward(arg_27_1.taskid)
		else
			self:taskTumpTo(arg_27_1.jump)
		end
	end)

	local var_27_7 = ccui.Slider:create()

	var_27_7:setAnchorPoint(cc.p(0, 0.5))
	var_27_7:setName("progress_bar")
	var_27_7:loadBarTexture("Activity_lamia/task_percent_bg.png", var_0_6)
	var_27_7:loadProgressBarTexture("Activity_lamia/task_percent.png", var_0_6)
	var_27_7:setPosition(cc.p(0, 125))
	var_27_0:addChild(var_27_7, -100)

	local var_27_9 = arg_27_1.status == 1 and 100 or arg_27_1.percent

	var_27_7:setPercent(arg_27_1.status == 1 and 100 or arg_27_1.percent)

	local var_27_10 = cc.Label:createWithTTF(var_27_9 .. "%", FONT_DES, 20)

	var_27_10:setName("percent_lbl")
	var_27_10:setColor(cc.c3b(255, 222, 0))
	var_27_10:setPosition(cc.p(509, 140))
	var_27_0:addChild(var_27_10)

	return var_27_0
end

function ActivityQuestionPtTaskLayer:updateTaskSprite(arg_29_1, arg_29_2)
	arg_29_1:getChildByName("task_img"):loadTexture("mainScenebg/task_img/" .. arg_29_2.image .. ".png")
	arg_29_1:getChildByName("ptImg"):loadTexture("mainScenebg/task_img/" .. arg_29_2.image .. ".png")
	arg_29_1:getChildByName("pt_num"):setString("X" .. self:getBattlePassDrop(arg_29_2.drop)[1].dropNum)
	arg_29_1:getChildByName("name_lbl"):setString(arg_29_2.name)
	arg_29_1:getChildByName("desc_lbl"):setString(arg_29_2.task_des)

	local var_29_0 = arg_29_1:getChildByName("get_reward_btn")

	if arg_29_2.status == 1 then
		var_29_0:loadTextures(var_0_15[var_0_10], nil, var_0_15[var_0_10], var_0_6)
	elseif arg_29_2.percent >= 100 then
		var_29_0:loadTextures(var_0_15[var_0_11], nil, var_0_15[var_0_11], var_0_6)
	else
		var_29_0:loadTextures(var_0_15[var_0_12], nil, var_0_15[var_0_12], var_0_6)
	end

	var_29_0:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_29_2.status == 1 then
			return
		end

		if arg_29_2.percent >= 100 then
			self:getTaskReward(arg_29_2.taskid)
		else
			self:taskTumpTo(arg_29_2.jump)
		end
	end)

	local var_29_2 = arg_29_2.status == 1 and 100 or arg_29_2.percent

	arg_29_1:getChildByName("progress_bar"):setPercent(arg_29_2.status == 1 and 100 or arg_29_2.percent)
	arg_29_1:getChildByName("percent_lbl"):setString(var_29_2 .. "%")
end

function ActivityQuestionPtTaskLayer:updateShowingCells()
	local var_31_0, var_31_1 = GetTableViewShowCellIdx(self.taskView, {
		maxcount = math.ceil(self.ListLen),
		cellsize = cc.size(640, var_0_7)
	})

	for iter_31_0 = var_31_0, var_31_1 do
		self.taskView:updateCellAtIndex(iter_31_0)
	end
end

function ActivityQuestionPtTaskLayer:taskTumpTo(arg_32_1)
	if arg_32_1 == 130 then
		LayerManager:pushInLayer("SignLayerNew", {
			callback = function()
				self:getActivityTaskData()
			end
		})
	elseif arg_32_1 == 111 then
		require("controller.sign_manager"):createMidasLayer(function()
			self:getActivityTaskData()
		end)
	elseif arg_32_1 == 220 then
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
				self:getActivityTaskData()
			end
		})
	elseif arg_32_1 == 3011 then
		LayerManager:removePopLayer(self.__queueindex)
	elseif arg_32_1 then
		require("controller.goto_system_manager")

		local var_32_0 = {
			jump_to_system = arg_32_1
		}

		var_32_0.config = system_jump_config[SYSTEMID[arg_32_1]] and system_jump_config[SYSTEMID[arg_32_1]].config

		if var_32_0.config then
			if var_32_0.config.exitCallbackType == "function" then
				var_32_0.config.exitCallback = nil
			elseif var_32_0.config.exitCallbackType == "string" then
				var_32_0.config = "MainLayer"
			end
		end

		goto_complete_system(var_32_0)
	end
end

function ActivityQuestionPtTaskLayer.udpateGetAllBtn(arg_38_0)
	return
end

local activity_question_task_data = require("data.activity_question_task_data")
local drop_manager = require("controller.drop_manager")

function ActivityQuestionPtTaskLayer.getActivityTaskData(arg_39_0)
	local var_39_0 = activity_manager:getActivityObj(var_0_9)

	if var_39_0 then
		var_39_0:getActivityTaskList(nil, function(arg_40_0, arg_40_1)
			if arg_40_0 ~= 1 then
				return
			end

			arg_39_0.taskList = {}

			for iter_40_0, iter_40_1 in pairs(arg_40_1.list) do
				arg_39_0.taskList[activity_question_task_data[iter_40_1.taskid].display_type] = arg_39_0.taskList[activity_question_task_data[iter_40_1.taskid].display_type] or {}
				iter_40_1.name = activity_question_task_data[iter_40_1.taskid].name
				iter_40_1.task_des = activity_question_task_data[iter_40_1.taskid].task_des
				iter_40_1.image = activity_question_task_data[iter_40_1.taskid].image
				iter_40_1.drop = activity_question_task_data[iter_40_1.taskid].drop
				iter_40_1.jump = activity_question_task_data[iter_40_1.taskid].jump
				iter_40_1.order = activity_question_task_data[iter_40_1.taskid].order

				if iter_40_1.status == 1 then
					iter_40_1.percent = -1
				end

				table.insert(arg_39_0.taskList[activity_question_task_data[iter_40_1.taskid].display_type], iter_40_1)
			end

			local function var_40_0(arg_41_0, arg_41_1)
				if arg_41_0.percent == arg_41_1.percent then
					return arg_41_0.order < arg_41_1.order
				else
					return arg_41_0.percent > arg_41_1.percent
				end
			end

			for iter_40_2, iter_40_3 in pairs(arg_39_0.taskList) do
				if iter_40_3 and next(iter_40_3) then
					table.sort(iter_40_3, var_40_0)
				end
			end

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE)
		end, false)
	end
end

function ActivityQuestionPtTaskLayer:getTaskDataByType(arg_42_1)
	if not self.taskList or not next(self.taskList) then
		return {}
	end

	return self.taskList[arg_42_1]
end

function ActivityQuestionPtTaskLayer.getBattlePassDrop(arg_43_0, arg_43_1)
	if not arg_43_1 then
		return {}
	end

	local var_43_0 = drop_manager:getAllDrops(arg_43_1)

	if drop_manager:getGold(arg_43_1) > 0 then
		table.insert(var_43_0, {
			dropid = "gold",
			dropNum = drop_manager:getGold(arg_43_1)
		})
	end

	if drop_manager:getDiamond(arg_43_1) > 0 then
		table.insert(var_43_0, {
			dropid = "diamond",
			dropNum = drop_manager:getDiamond(arg_43_1)
		})
	end

	return var_43_0
end

function ActivityQuestionPtTaskLayer.getTaskReward(arg_44_0, arg_44_1)
	local var_44_0 = activity_manager:getActivityObj(var_0_9)

	if var_44_0 then
		var_44_0:getTaskReward(arg_44_1, function(arg_45_0, arg_45_1)
			if arg_45_0 ~= 1 then
				global_ShowBlockWords(L_BATTLE_PASS.FAIL)

				return
			end

			global_gain(arg_45_1)
			arg_44_0:getActivityTaskData()
		end)
	end
end

function ActivityQuestionPtTaskLayer:isHasCanCompleteTask(arg_46_1)
	if not self.taskList then
		return false
	end

	if not arg_46_1 then
		for iter_46_0, iter_46_1 in pairs(self.taskList) do
			if iter_46_1[1].status == 0 and iter_46_1[1].percent == 100 then
				return true
			end
		end

		return false
	end

	if not self.taskList[arg_46_1] then
		return false
	end

	if self.taskList[arg_46_1][1].status == 0 and self.taskList[arg_46_1][1].percent == 100 then
		return true
	end

	return false
end

function ActivityQuestionPtTaskLayer:getCompleteTaskNumber(arg_47_1)
	local var_47_0 = 0

	for iter_47_0, iter_47_1 in pairs((self:getTaskDataByType(arg_47_1))) do
		if iter_47_1.status == 1 then
			var_47_0 = var_47_0 + 1
		elseif iter_47_1.percent >= 100 then
			var_47_0 = var_47_0 + 1
		end
	end

	return var_47_0
end

function ActivityQuestionPtTaskLayer:getTaskProgress(arg_48_1)
	return L_ACTIVITY_TASK_COMPLETE_DATA.Complete_Num .. self:getCompleteTaskNumber(arg_48_1) .. "/" .. #self:getTaskDataByType(arg_48_1)
end

function ActivityQuestionPtTaskLayer:shopByPtLayer()
	local var_49_0 = ccui.Layout:create()

	var_49_0:setTouchEnabled(true)
	var_49_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_49_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_49_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, GameDisplay.height / 2 - GameDisplay.fix_y))
	var_49_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_49_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_49_0:setBackGroundColorOpacity(180)
	self:addChild(var_49_0, 10)

	local var_49_1 = ccui.ImageView:create("mainScenebg/market/" .. item_data[self.shopitem.itemtype].image_id .. ".png")

	var_49_1:setPosition(cc.p(var_49_0:getContentSize().width / 2, var_49_0:getContentSize().height / 2))
	var_49_0:addChild(var_49_1)

	local var_49_2 = ccui.Layout:create()

	var_49_2:setContentSize(cc.size(var_49_1:getContentSize().width, 30))
	var_49_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_49_2:setPosition(cc.p(var_49_1:getContentSize().width / 2, -var_49_2:getContentSize().height / 2))
	var_49_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_49_2:setBackGroundColor(cc.c3b(0, 0, 0))
	var_49_2:setBackGroundColorOpacity(220)
	var_49_1:addChild(var_49_2, 10)

	local var_49_3 = cc.Label:createWithTTF(item_data[self.shopitem.itemtype].name, FONT_DES, 22)

	var_49_3:setPosition(cc.p(var_49_2:getContentSize().width / 2, var_49_2:getContentSize().height / 2))
	var_49_2:addChild(var_49_3)

	local var_49_4 = ccui.ImageView:create("public/currency/UI_battleEnd_diamond.png", var_0_6)

	var_49_4:setPositionX(var_49_1:getContentSize().width / 2 - 20)
	var_49_4:setPositionY(-190)
	var_49_1:addChild(var_49_4)

	local var_49_5 = cc.Label:createWithTTF(self.shopitem.discount, FONT_DES, 23)

	var_49_5:setAnchorPoint(cc.p(0, 0.5))
	var_49_5:setPositionX(var_49_4:getPositionX() + var_49_4:getContentSize().width / 2 + 5)
	var_49_5:setPositionY(var_49_4:getPositionY())
	var_49_1:addChild(var_49_5)

	local var_49_6 = ccui.Button:create("public/button/public_button_big_y.png", nil, "public/button/public_button_big_y.png", var_0_6)
	local var_49_7 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)

	var_49_7:setColor(cc.c3b(12, 12, 12))
	var_49_6:setScale9Enabled(true)
	var_49_6:setCapInsets(cc.rect(90, 30, 20, 20))
	var_49_6:setContentSize(cc.size(500, var_49_6:getContentSize().height))
	var_49_6:setPosition(cc.p(var_49_1:getContentSize().width / 2, -100))
	var_49_7:setPosition(cc.p(var_49_6:getContentSize().width / 2, var_49_6:getContentSize().height / 2))
	var_49_6:addChild(var_49_7)
	var_49_1:addChild(var_49_6)
	var_49_6:addTouchEventListener(function(arg_50_0, arg_50_1)
		if arg_50_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:ShopSlider(arg_50_0, arg_50_1, function()
			var_49_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
				var_49_0:runAction(cc.RemoveSelf:create())
			end)))
		end)
	end)
	var_49_1:setScaleY(0)
	var_49_1:runAction(cc.ScaleTo:create(0.2, 1))
	var_49_0:addTouchEventListener(function(arg_53_0, arg_53_1)
		var_49_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_49_0:runAction(cc.RemoveSelf:create())
		end)))
	end)

	self.countSlider = ccui.Slider:create()

	self.countSlider:loadBarTexture("ActivityQuestionPtLayer/tiao.png", var_0_6)
	self.countSlider:loadSlidBallTextures("ActivityQuestionPtLayer/node.png", "ActivityQuestionPtLayer/node.png", "ActivityQuestionPtLayer/node.png", var_0_6)
	self.countSlider:setPosition(cc.p(70, -160))
	self.countSlider:setPercent(1)
	var_49_1:addChild(self.countSlider)
	self.countSlider:addEventListener(function(arg_55_0, arg_55_1)
		var_49_5:setString(self.countSlider:getPercent())
	end)

	local l2utils = require("controller.l2utils")
	local var_49_9 = ccui.Button:create("ActivityQuestionPtLayer/add.png", nil, "ActivityQuestionPtLayer/add.png", var_0_6)

	var_49_9:setPosition(cc.p(315, -160))
	var_49_1:addChild(var_49_9)
	l2utils:registerDelayPressEvent(var_49_9, 0.3, 0.1, function()
		if self.countSlider:getPercent() >= 100 then
			return
		end

		self.countSlider:setPercent(self.countSlider:getPercent() + 1)
		var_49_5:setString(self.countSlider:getPercent())
	end)
	var_49_9:addTouchEventListener(function(arg_57_0, arg_57_1)
		if arg_57_1 == ccui.TouchEventType.began then
			var_49_9:startDelayPressEvent()
		elseif arg_57_1 == ccui.TouchEventType.moved then
			var_49_9:stopDelayPressEvent()
		elseif arg_57_1 == ccui.TouchEventType.ended then
			var_49_9:stopDelayPressEvent()

			if self.countSlider:getPercent() >= 100 then
				return
			end

			self.countSlider:setPercent(self.countSlider:getPercent() + 1)
			var_49_5:setString(self.countSlider:getPercent())
		end
	end)

	local var_49_10 = ccui.Button:create("ActivityQuestionPtLayer/jian.png", nil, "ActivityQuestionPtLayer/jian.png", var_0_6)

	var_49_10:setPosition(cc.p(-175, -160))
	var_49_1:addChild(var_49_10)
	l2utils:registerDelayPressEvent(var_49_10, 0.3, 0.1, function()
		if self.countSlider:getPercent() <= 1 then
			return
		end

		self.countSlider:setPercent(self.countSlider:getPercent() - 1)
		var_49_5:setString(self.countSlider:getPercent())
	end)
	var_49_10:addTouchEventListener(function(arg_59_0, arg_59_1)
		if arg_59_1 == ccui.TouchEventType.began then
			var_49_10:startDelayPressEvent()
		elseif arg_59_1 == ccui.TouchEventType.moved then
			var_49_10:stopDelayPressEvent()
		elseif arg_59_1 == ccui.TouchEventType.ended then
			var_49_10:stopDelayPressEvent()

			if self.countSlider:getPercent() <= 1 then
				return
			end

			self.countSlider:setPercent(self.countSlider:getPercent() - 1)
			var_49_5:setString(self.countSlider:getPercent())
		end
	end)
end

function ActivityQuestionPtTaskLayer:ShopSlider(arg_60_1, arg_60_2, arg_60_3)
	if arg_60_2 ~= ccui.TouchEventType.ended then
		return
	end

	if self.countSlider:getPercent() + item_manager:getItemNumber(9000006) >= 3000 then
		global_ShowBlockWords(L_ACTIVITY_QUESTION.PT_YICHU)

		return
	end

	arg_60_1:setTouchEnabled(false)
	shop_manager:shop_buy(shop_data[self.shopitem.shopid].shop_type, self.shopitem.shopid, function(arg_61_0)
		if arg_61_0 == 1 then
			self.shopitem.have_bought = self.shopitem.have_bought + 1

			self.ptTitle:setString(item_manager:getItemNumber(9000006))
			self:updatebuyGiftBtn()
		elseif arg_61_0 == 2 then
			global_ShowBlockWords(L_MARKET_BUY_WARNING[2])
		elseif arg_61_0 == 3 then
			global_ShowBlockWords(L_MARKET_BUY_WARNING[3])
		else
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				targetlayer = "PopSupermarketLayer"
			})
		end

		if arg_60_3 then
			arg_60_3()
		end
	end, self.countSlider:getPercent() or 1)
end

function ActivityQuestionPtTaskLayer.getActivityShopItem(arg_62_0)
	local var_62_0 = activity_manager:getActivityObj(var_0_9)

	if var_62_0 then
		var_62_0:get_activity_shopitem(function(arg_63_0, arg_63_1)
			if arg_63_0 == 1 then
				activity_manager:fireEvent(activity_manager.activityEventId.GET_ACTIVITY_SHOP_ITEM, {
					shopitem = arg_63_1
				})
			end
		end)
	end
end
