PopReturnBackGuideTaskLayer = class("PopReturnBackGuideTaskLayer", function()
	return PopBaseLayer:create()
end)

local playermodel = require("model.playermodel")
local activity_176_BP_task_data = require("data.activity_bp.activitydata.activity_176_BP_task_data")
local back_guide_data = require("data.back_guide_data")
local activity_manager = require("controller.activity_manager")
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local LocalEvent = require("common.LocalEvent")
local var_0_9 = config._DEBUG and 0 or 1

function PopReturnBackGuideTaskLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopReturnBackGuideTaskLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopReturnBackGuideTaskLayer:init(arg_3_1)
	self:initData(arg_3_1)
	self:initUI()
	self:registerEvents()
	self:show()
end

function PopReturnBackGuideTaskLayer.initData(arg_4_0, arg_4_1)
	arg_4_0.tasks = arg_4_1.tasks
	arg_4_0.type = arg_4_1.type
	arg_4_0.activityId = arg_4_1.activityId
	arg_4_0.layerName = "PopReturnBackGuideTaskLayer"
end

function PopReturnBackGuideTaskLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopReturnBackGuideTaskLayer.json" or "PopReturnBackGuideTaskLayer.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self:addChild(self.rootNode)

	self.rootpanel = self.rootNode:getChildByName("rootPanel")

	self.rootpanel:setAnchorPoint(0.5, 0.5)
	self.rootpanel:setPositionX(GameDisplay.size.width / 2)
	self.rootpanel:setPositionY(GameDisplay.size.height / 2)
	self.rootpanel:setTouchEnabled(false)

	self.panelMain = self.rootpanel:getChildByName("panelMain")

	Utility:alignPanelByParent(self.panelMain, self.rootpanel)

	self.imgBanner = self.panelMain:getChildByName("imgBanner")
	self.labelInfo = self.imgBanner:getChildByName("labelInfo")
	self.imgMask = self.imgBanner:getChildByName("imgMask")

	self.labelInfo:setTextAreaSize(cc.size(self.imgMask:getContentSize().width - 20, 0))

	self.listViewTasks = self.panelMain:getChildByName("listViewTasks")
	self.panelTaskItem = self.listViewTasks:getChildByName("panelTaskItem")

	self.panelTaskItem:retain()
	self.panelTaskItem:removeFromParent()
end

function PopReturnBackGuideTaskLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.rootNode, handler(self, self.hide))
	LocalEvent:registerEvent(self, LocalEvent.EVENT_IDS.LAYER_EXIT_SCENE, handler(self, self.handleLayerExitScene))
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_ACTIVITY_TASK_REWARD, handler(self, self.handleGetActivityTaskReward))
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.RETURNBACK_EXTRA_TASK_LIST, handler(self, self.handleRequestActivityTaskList))
end

function PopReturnBackGuideTaskLayer:onEnter()
	activity_manager:getExtraTaskList(self.activityId, self.type)
end

function PopReturnBackGuideTaskLayer:onExit()
	self.panelTaskItem:release()
	activity_manager:releaseEventListenerByName(self.layerName)
	EventManager:unsubscribe(self)
	LocalEvent:removeEvent(self)
end

function PopReturnBackGuideTaskLayer:show()
	self.showActions.extendVertical(self)
end

function PopReturnBackGuideTaskLayer:hide()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopReturnBackGuideTaskLayer:updateLayout()
	self:updateUpBanner()
	self:updateListView()
end

function PopReturnBackGuideTaskLayer:updateUpBanner()
	self.imgBanner:loadTexture(string.format("gameback/guide/img_%s.png", self.type), var_0_9)

	for iter_13_0, iter_13_1 in ipairs(back_guide_data) do
		if iter_13_1.usemodule == self.type then
			self.labelInfo:setString(iter_13_1.content)
		end
	end

	self.labelInfo:setPositionY(self.imgMask:getPositionY() + ((self.imgMask:getContentSize().height - self.labelInfo:getContentSize().height) / 2 - 20))
end

function PopReturnBackGuideTaskLayer:updateListView()
	self.listViewTasks:removeAllChildren()

	for iter_14_0, iter_14_1 in ipairs(self.tasks) do
		local var_14_2 = activity_176_BP_task_data[iter_14_1.taskid]

		if not activity_176_BP_task_data[iter_14_1.taskid] then
			error("任务未配置，id:", iter_14_1.taskid)
		end

		local var_14_3 = self.panelTaskItem:clone()
		local var_14_4 = Utility:seekChildByName(var_14_3, "labelTitle")

		if iter_14_1.status == 0 then
			var_14_4:setString(string.format(var_14_2.task_des .. "(%d/%d)", math.round(iter_14_1.percent * iter_14_1.need / 100), iter_14_1.need))
		else
			var_14_4:setString(var_14_2.task_des)
		end

		local var_14_5 = var_14_3:getChildByName("imgBg")
		local var_14_6 = var_14_5:getChildByName("imgStatus")
		local var_14_7 = false

		if iter_14_1.status == 0 and iter_14_1.finished >= iter_14_1.need and iter_14_1.percent >= 100 then
			var_14_5:loadTexture("gameback/pop/award_get_bg.png", var_0_9)
			var_14_6:loadTexture("gameback/pop/btn_award.png", var_0_9)
			Utility:addClickEventListener(var_14_6, handler(self, self.onBtnReward), iter_14_1.taskid)

			var_14_7 = true
		else
			var_14_5:loadTexture("gameback/pop/award_normal_bg.png", var_0_9)

			if iter_14_1.status == 1 then
				var_14_6:loadTexture("gameback/pop/btn_complete.png", var_0_9)

				var_14_7 = true
			end
		end

		var_14_6:setVisible(var_14_7)

		local var_14_8 = var_14_5:getChildByName("btnGo")

		var_14_8:setVisible(iter_14_1.status == 0 and iter_14_1.percent < 100)
		Utility:addClickEventListener(var_14_8, handler(self, self.onBtnGo), var_14_2.jump)

		local var_14_9 = Utility:getDropData(var_14_2.drop)

		for iter_14_2 = 1, 3 do
			if not var_14_9[iter_14_2] then
				var_14_5:getChildByName("nodeItem_" .. iter_14_2):setVisible(false)
			else
				require("view.Sprite.ItemSpriteActivityRecharge")

				local var_14_10 = ItemSpriteActivityRecharge:createSignItem(var_14_9[iter_14_2].itemid, var_14_9[iter_14_2].num)

				var_14_10:addClickEventListener(handler(self, self.onBtnItem), var_14_9[iter_14_2].itemid)
				var_14_10:setScale(0.9)
				Utility:replaceNodeByNode(var_14_5, "nodeItem_" .. iter_14_2, var_14_10)
			end
		end

		self.listViewTasks:pushBackCustomItem(var_14_3)
	end
end

function PopReturnBackGuideTaskLayer.onBtnItem(arg_15_0, arg_15_1, arg_15_2)
	LayerManager:pushInLayer("PopItemLayer", {
		itemid = arg_15_2
	})
end

function PopReturnBackGuideTaskLayer:onBtnGo(arg_16_1, arg_16_2)
	print("jump", arg_16_2)

	if not self:judgeModeUnlock(arg_16_2) then
		return
	end

	Utility:executeLayerJump({
		systemid = arg_16_2
	})
end

function PopReturnBackGuideTaskLayer.judgeModeUnlock(arg_17_0, arg_17_1)
	if not LayerManager:layerUnlocked((arg_17_1 == 3401021 or nil) and "TowerDefenceLevelLayer", "switchShowLayer") then
		return false
	end

	return true
end

function PopReturnBackGuideTaskLayer:onBtnReward(arg_18_1, arg_18_2)
	print("reward")
	EventManager:requestActivityTaskReward(self.activityId, arg_18_2, nil)
end

function PopReturnBackGuideTaskLayer:handleRequestActivityTaskList(arg_19_1)
	self.tasks = arg_19_1.list or {}

	self:updateLayout()
end

function PopReturnBackGuideTaskLayer:handleGetActivityTaskReward(arg_20_1)
	if not arg_20_1 then
		return
	end

	if arg_20_1.result == 1 then
		local var_20_0 = arg_20_1.gold or 0
		local var_20_1 = arg_20_1.diamond or 0
		local var_20_2 = arg_20_1.items or {}

		global_gain({
			gold = var_20_0,
			diamond = var_20_1,
			items = var_20_2
		})
		activity_manager:getExtraTaskList(self.activityId, self.type)
	end
end

function PopReturnBackGuideTaskLayer:handleLayerExitScene(arg_21_1)
	if not arg_21_1 or not arg_21_1.name then
		return
	end

	activity_manager:getExtraTaskList(self.activityId, self.type)
end
