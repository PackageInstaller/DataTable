ActivityMultiPtLayer = class("ActivityMultiPtLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")

local L2Actor = require("view.Sprite.L2Actor")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local favorfile_data = require("data.favorfile_data")
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local component_manager = require("controller.component_manager")
local activity_return_manager = require("controller.activity_return_manager")
local var_0_9 = config._DEBUG and 0 or 1
local var_0_11 = 1
local var_0_12 = 2
local var_0_14 = 4

local function var_0_15(arg_2_0)
	if arg_2_0 >= 86400 then
		return string.format(L_TIME_TEXT[1], math.floor(arg_2_0 / 86400), math.floor(arg_2_0 % 86400 / 3600))
	elseif arg_2_0 >= 3600 then
		return string.format(L_TIME_TEXT[2], math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60))
	else
		return string.format(L_TIME_TEXT[4], math.floor(arg_2_0 / 60), math.floor(arg_2_0 % 60))
	end
end

function ActivityMultiPtLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ActivityMultiPtLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ActivityMultiPtLayer:initStaticConfig()
	self.IS_GETTED = 1
	self.CAN_GET = 2
	self.UN_ACHIEVE = 3
	self.LEVEL_UNACHIEVE = 0
	self.UNRECEIVE = 1
	self.RECEIVE_ORDINARY = 2
	self.RECEIVE_ALL = 3
	self.QIOGN_B = 4
	self.LEVEL_CELL_HEIGHT = self:get_level_cell_height()
	self.TASK_CELL_HEIGHT = self:get_task_cell_height()
	self.btn_stat_img = {
		[self.IS_GETTED] = self.layerName .. "/btn_yiwancheng.png",
		[self.CAN_GET] = self.layerName .. "/btn_lingqujiangli.png",
		[self.UN_ACHIEVE] = self.layerName .. "/btn_qianwangwancheng.png"
	}
	self.SHOW_TYPE_LEVEL = 1
	self.SHOW_TYPE_TASK = 2
	self.curShowType = self.SHOW_TYPE_LEVEL
end

function ActivityMultiPtLayer:init(arg_5_1)
	self.activityId = arg_5_1.activityId

	ErrorCodeManager:check({
		systemname = "ActivityMultiPtLayer",
		id = self.activityId
	})

	self.layerName = activity_manager:getMultiPTLayerName(self.activityId) or "Activity_multiPt_" .. self.activityId

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.bg = ccui.ImageView:create("mainScenebg/activity/branch" .. self.activityId .. "/multi_pt_bg.png")

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg, -1)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initStaticConfig()
	self:initBaseUI()
	self:initBottomList()
	self:initTimeLabel()
	self:fullScreen()
	self:updateAlert()
	self:registerActivityEventListener()
	activity_manager:getBMultiPtLevelData(self.activityId)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end

			TextureManager:removeLayerTextures({
				self.layerName
			})
		end
	end)
	hx_print("UI文件夹:" .. self.layerName, CONSOLE_COLOR_LIGHT_GOLD)
end

function ActivityMultiPtLayer.get_level_cell_height(arg_7_0)
	return 225
end

function ActivityMultiPtLayer:get_task_cell_height()
	return ccui.Helper:seekWidgetByName(self.rootLayer, "tasknode1"):getPositionY() - ccui.Helper:seekWidgetByName(self.rootLayer, "tasknode2"):getPositionY() + 10
end

function ActivityMultiPtLayer:initBaseUI()
	self.panelUp = self.rootLayer:getChildByName("panel_up")
	self.title = ccui.Helper:seekWidgetByName(self.panelUp, "title_detial")
	self.timeLabel = ccui.Helper:seekWidgetByName(self.panelUp, "lbl_time")
	self.switchBtnLevel = ccui.Helper:seekWidgetByName(self.panelUp, "switch_btn_level")
	self.switchBtnTask = ccui.Helper:seekWidgetByName(self.panelUp, "switch_btn_task")
	self.bottomList = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bottom")
	self.btnReturn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return")
	self.btnAllReward = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure")
	self.levelNode1 = ccui.Helper:seekWidgetByName(self.rootLayer, "levelnode1")
	self.levelNode2 = ccui.Helper:seekWidgetByName(self.rootLayer, "levelnode2")
	self.panelTask = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_task")
	self.taskNode1 = ccui.Helper:seekWidgetByName(self.rootLayer, "tasknode1")
	self.taskNode2 = ccui.Helper:seekWidgetByName(self.rootLayer, "tasknode2")

	self.switchBtnLevel:loadTextures(self.layerName .. "/switch_btn_jiangli_on.png", self.layerName .. "/switch_btn_jiangli_on.png", self.layerName .. "/switch_btn_jiangli_on.png", var_0_9)
	self.switchBtnTask:loadTextures(self.layerName .. "/switch_btn_task_off.png", self.layerName .. "/switch_btn_task_off.png", self.layerName .. "/switch_btn_task_off.png", var_0_9)
	self.panelTask:setVisible(false)
	self.btnAllReward:setVisible(false)
	self:initDynamicUI()
end

function ActivityMultiPtLayer:initDynamicUI()
	for iter_10_0 = 1, 4 do
		local var_10_0 = self.rootLayer:getChildByName("Label_" .. iter_10_0)

		self["color" .. iter_10_0] = var_10_0 and var_10_0:getColor()
	end
end

function ActivityMultiPtLayer:initBottomList()
	self.btnReturn:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.btnAllReward:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curShowType == self.SHOW_TYPE_LEVEL then
			-- block empty
		else
			if not activity_manager:isHasCanCompleteMultiPtTask(self.activityId) then
				global_ShowBlockWords(L_BATTLE_PASS.NOT_REWARD_CAN_GET)

				return
			end

			activity_manager:getMultiPtTaskRewardOneKey(self.activityId)
		end
	end)
	self.title:setTouchEnabled(true)
	self.panelUp:setTouchEnabled(true)
	self.title:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = self.layerName
		})
	end)

	self.btnJifen = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_points ")

	if self.btnJifen then
		self.btnJifen:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopActivityItemGainLayer", {
				type = "multi_pt",
				activityId = self.activityId
			})
		end)
	end
end

function ActivityMultiPtLayer:initTimeLabel()
	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(global_get_time_by_date(self.activityId == 270 and activity_manager:get_module_finishtime(self.activityId, "collect") or activity_manager:get_module_finishtime(self.activityId, "bp")) - time_check_manager:getCurTime(), function(arg_17_0)
		self.timeLabel:setString(L_LEFT_TIME_SPACE .. var_0_15(arg_17_0))

		if arg_17_0 <= 0 and self.activityScheduler then
			self.timeLabel:setVisible(false)
			time_check_manager:removeUpdatePool(self.activityScheduler)

			self.activityScheduler = nil
		end
	end)))
end

function ActivityMultiPtLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.BATTLE_PASS_LIST_UPDATE, function(arg_19_0)
		self:updateHelpView()

		if self.curShowType == self.SHOW_TYPE_LEVEL then
			self:updateLevelView(arg_19_0.list, arg_19_0.listLen)
		end
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_20_0)
		self:updateHelpView()

		if self.curShowType == self.SHOW_TYPE_TASK then
			self:updateTaskView(arg_20_0.list, arg_20_0.listLen)
		end
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.BATTLE_PASS_VIP_UPDATE, function(arg_21_0)
		self:updateHelpView()

		if self.curShowType == self.SHOW_TYPE_LEVEL then
			activity_manager:getBMultiPtLevelData(self.activityId)
		end
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, function(arg_22_0)
		self:updateAlert()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_23_0)
		self:updateHelpView()

		if self.curShowType == self.SHOW_TYPE_LEVEL then
			activity_manager:getBMultiPtLevelData(self.activityId)
		end
	end), self)
end

function ActivityMultiPtLayer:updateHelpView()
	local var_24_0 = self.rootLayer:getChildByName("panel_up")

	ccui.Helper:seekWidgetByName(var_24_0, "lbl_ptnum"):setString(L_ACTIVITY_POINT .. activity_manager:getMultiPTnum(self.activityId))

	local var_24_1 = var_24_0:getChildByName("switch_btn_level")
	local var_24_2 = var_24_0:getChildByName("switch_btn_task")

	var_24_1:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curShowType == self.SHOW_TYPE_LEVEL then
			return
		end

		var_24_1:loadTextures(self.layerName .. "/switch_btn_jiangli_on.png", self.layerName .. "/switch_btn_jiangli_on.png", self.layerName .. "/switch_btn_jiangli_on.png", var_0_9)
		var_24_2:loadTextures(self.layerName .. "/switch_btn_task_off.png", self.layerName .. "/switch_btn_task_off.png", self.layerName .. "/switch_btn_task_off.png", var_0_9)

		self.curShowType = self.SHOW_TYPE_LEVEL

		self:updateUIVisible(true)
		activity_manager:getBMultiPtLevelData(self.activityId)
	end)
	var_24_2:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curShowType == self.SHOW_TYPE_TASK then
			return
		end

		var_24_1:loadTextures(self.layerName .. "/switch_btn_jiangli_off.png", self.layerName .. "/switch_btn_jiangli_off.png", self.layerName .. "/switch_btn_jiangli_off.png", var_0_9)
		var_24_2:loadTextures(self.layerName .. "/switch_btn_task_on.png", self.layerName .. "/switch_btn_task_on.png", self.layerName .. "/switch_btn_task_on.png", var_0_9)

		self.curShowType = self.SHOW_TYPE_TASK

		self:updateUIVisible(false)
		activity_manager:getActivityMultiPtTask(self.activityId)
	end)
end

function ActivityMultiPtLayer:updateUIVisible(arg_27_1)
	self.btnAllReward:setVisible(not arg_27_1)
end

function ActivityMultiPtLayer:updateLevelView(arg_28_1, arg_28_2)
	if self.taskView then
		self.taskView:setVisible(false)
	end

	self.levelListLen = arg_28_2
	self.levelListData = arg_28_1 or {}

	if self.levelView then
		self.levelView:setVisible(true)
		self:updateShowingCells(self.levelView, self.levelListLen, self.LEVEL_CELL_HEIGHT)

		return
	end

	local var_28_0 = self.bottomList:getPositionY() + 38

	self.levelView = cc.TableView:create(cc.size(640, 725 + GameDisplay.fix_y * 2))

	self.levelView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.levelView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.levelView:setAnchorPoint(cc.p(0, 0))
	self.levelView:setPosition(0, var_28_0)
	self.levelView:setDelegate()
	self.rootLayer:addChild(self.levelView)
	self.levelView:registerScriptHandler(function(arg_30_0, arg_30_1)
		return 640, self.LEVEL_CELL_HEIGHT
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.levelView:registerScriptHandler(function(arg_29_0, arg_29_1)
		local var_29_0 = arg_29_0:dequeueCell()

		if not var_29_0 then
			var_29_0 = cc.TableViewCell:create()

			local var_29_2 = self:createLevelSprite(self.levelListData[arg_29_1 + 1], arg_29_1 + 1)

			var_29_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_29_2:setPosition(cc.p(320, self.LEVEL_CELL_HEIGHT / 2))
			var_29_0:addChild(var_29_2)
			var_29_0:setLocalZOrder(999 - 10 * arg_29_1)
		else
			self:updateLevelSprite(var_29_0:getChildByTag(100), self.levelListData[arg_29_1 + 1], arg_29_1 + 1)
			var_29_0:setLocalZOrder(999 - 10 * arg_29_1)
		end

		return var_29_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.levelView:registerScriptHandler(function(arg_31_0, arg_31_1)
		return self.levelListLen
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.levelView:reloadData()
end

function ActivityMultiPtLayer:getItemSpritePosX(arg_32_1, arg_32_2)
	if #self.levelListData[arg_32_1].data == 1 or #self.levelListData[arg_32_1].data == 3 then
		return (arg_32_2 * 2 - 1) / (#self.levelListData[arg_32_1].data * 2) * 600 + 20
	end

	if not self.levelListData[arg_32_1 - 1] or #self.levelListData[arg_32_1 - 1].data ~= 3 then
		return self:getItemSpritePosX(arg_32_1 - 1, arg_32_2)
	end

	if self.levelListData[arg_32_1].data[1].need_condition:find(",") then
		return arg_32_2 == 2 and 520 or 220
	elseif self.levelListData[arg_32_1].data[2].need_condition:find(",") then
		return arg_32_2 == 1 and 120 or 420
	else
		return arg_32_2 == 1 and 120 or 220
	end
end

function ActivityMultiPtLayer:getItemSpriteLineList(arg_33_1, arg_33_2)
	local var_33_0 = self.levelListData[arg_33_1].data
	local var_33_1 = self.levelListData[arg_33_1 - 1].data
	local var_33_2 = {}
	local var_33_3 = self.layerName .. "/line_%s_%s.png"
	local var_33_4 = string.split(self.levelListData[arg_33_1].data[arg_33_2].need_condition, ",")

	if #self.levelListData[arg_33_1].data == 1 then
		for iter_33_0, iter_33_1 in pairs(var_33_4) do
			local var_33_5 = tonumber(iter_33_1)
			local var_33_6 = var_33_1[var_33_5].stat == var_0_14 and 2 or 1

			if #var_33_1 == 1 then
				var_33_2[var_33_5] = string.format(var_33_3, 2, var_33_6)
			elseif #var_33_1 == 2 then
				local var_33_7 = {
					4,
					3
				}

				var_33_2[var_33_7[var_33_5]] = string.format(var_33_3, var_33_7[var_33_5], var_33_6)
			else
				local var_33_8 = {
					4,
					2,
					5
				}

				var_33_2[var_33_8[var_33_5]] = string.format(var_33_3, var_33_8[var_33_5], var_33_6)
			end
		end
	end

	if #var_33_0 == 2 then
		for iter_33_2, iter_33_3 in pairs(var_33_4) do
			local var_33_9 = tonumber(iter_33_3)
			local var_33_10 = var_33_1[var_33_9].stat == var_0_14 and 2 or 1

			if #var_33_1 == 2 then
				var_33_2[2] = string.format(var_33_3, 2, var_33_10)
			elseif #var_33_1 == 1 then
				local var_33_11 = {
					3,
					1
				}

				var_33_2[var_33_11[arg_33_2]] = string.format(var_33_3, var_33_11[arg_33_2], var_33_10)
			elseif #var_33_4 == 2 then
				local var_33_12 = {
					[2] = 1,
					[3] = 3
				}

				if var_33_0[1].need_condition:find(",") then
					var_33_12 = {
						[1] = 1,
						[2] = 3
					}
				end

				if var_33_12[var_33_9] then
					var_33_2[var_33_12[var_33_9]] = string.format(var_33_3, var_33_12[var_33_9], var_33_10)
				end
			else
				var_33_2[2] = string.format(var_33_3, 2, var_33_10)
			end
		end
	end

	if #var_33_0 == 3 then
		for iter_33_4, iter_33_5 in pairs(var_33_4) do
			local var_33_13 = var_33_1[tonumber(iter_33_5)].stat == var_0_14 and 2 or 1

			if #var_33_1 == 1 then
				local var_33_14 = {
					5,
					2,
					4
				}

				var_33_2[var_33_14[arg_33_2]] = string.format(var_33_3, var_33_14[arg_33_2], var_33_13)
			elseif #var_33_1 == 3 then
				var_33_2[2] = string.format(var_33_3, 2, var_33_13)
			else
				local var_33_15 = var_33_0[2].need_condition == "2" and {
					2,
					3,
					1
				} or {
					3,
					1,
					2
				}

				var_33_2[var_33_15[arg_33_2]] = string.format(var_33_3, var_33_15[arg_33_2], var_33_13)
			end
		end
	end

	return var_33_2
end

function ActivityMultiPtLayer:createLevelSprite(arg_34_1, arg_34_2)
	local var_34_0 = ccui.Layout:create()

	var_34_0:setTag(100)
	var_34_0:setContentSize(cc.size(640, 180))
	var_34_0:setPosition(cc.p(0, 0))

	for iter_34_0, iter_34_1 in pairs(arg_34_1.data) do
		local var_34_1 = self:createItemSprite(iter_34_0, iter_34_1, arg_34_2)

		var_34_1:setPositionY(90)
		var_34_1:setPositionX(self:getItemSpritePosX(arg_34_2, iter_34_0))
		var_34_0:addChild(var_34_1)
		var_34_1:setSwallowTouches(false)
		var_34_1:addTouchEventListener(function(arg_35_0, arg_35_1)
			if arg_35_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_35_0:getTouchBeganPosition().y - arg_35_0:getTouchEndPosition().y) > 25 then
				return
			end

			if iter_34_1.stat == var_0_14 then
				return
			end

			if iter_34_1.stat == var_0_12 or iter_34_1.stat == var_0_11 then
				showItemDetails(arg_35_0.itemid, sp.entityid)

				return
			end

			activity_manager:get_multi_pt_reward(self.activityId, arg_34_2, iter_34_0)
		end)
	end

	return var_34_0
end

function ActivityMultiPtLayer:updateLevelSprite(arg_36_1, arg_36_2, arg_36_3)
	arg_36_1:setTag(100)
	arg_36_1:removeAllChildren()

	for iter_36_0, iter_36_1 in pairs(arg_36_2.data) do
		local var_36_0 = self:createItemSprite(iter_36_0, iter_36_1, arg_36_3)

		var_36_0:setPositionY(90)
		var_36_0:setPositionX(self:getItemSpritePosX(arg_36_3, iter_36_0))
		arg_36_1:addChild(var_36_0)
		var_36_0:setSwallowTouches(false)
		var_36_0:addTouchEventListener(function(arg_37_0, arg_37_1)
			if arg_37_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_37_0:getTouchBeganPosition().y - arg_37_0:getTouchEndPosition().y) > 25 then
				return
			end

			if iter_36_1.stat == var_0_14 then
				return
			end

			if iter_36_1.stat == var_0_12 or iter_36_1.stat == var_0_11 then
				showItemDetails(arg_37_0.itemid, sp.entityid)

				return
			end

			activity_manager:get_multi_pt_reward(self.activityId, arg_36_3, iter_36_0)
		end)
	end
end

local var_0_16 = {
	cc.p(1, 0),
	cc.p(0.5, 0),
	cc.p(0, 0),
	cc.p(1, 0),
	(cc.p(0, 0))
}

function ActivityMultiPtLayer:createItemSprite(arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = ccui.Button:create(self.layerName .. "/item_bg.png", self.layerName .. "/item_bg.png", self.layerName .. "/item_bg.png", var_0_9)
	local var_38_2 = 0.6
	local var_38_3 = activity_manager:getBattlePassDrop(self.activityId, arg_38_2.dropid)
	local var_38_4 = var_38_3[1].dropid

	var_38_0.itemid = var_38_3[1].dropid

	local var_38_5

	if var_38_4 == "gold" then
		var_38_5 = "equipment/1000001.png"
	elseif var_38_4 == "diamond" then
		var_38_5 = "equipment/1000000.png"
	elseif item_data[var_38_4].bag_item_type == kITEM_COMPONENT then
		var_38_5 = ""
	else
		if item_data[var_38_4].bag_item_type == kITEM_HORCRUX then
			var_38_2 = var_38_2 * 0.5
		end

		var_38_5 = "equipment/" .. item_data[var_38_4].image_id .. ".png"
	end

	if item_data[var_38_4].bag_item_type == kITEM_COMPONENT then
		local var_38_6 = component_manager:create_component_icon(var_38_4)

		var_38_6:setPosition(cc.p(var_38_0:getContentSize().width / 2, var_38_0:getContentSize().height / 2))
		var_38_6:setScale(var_38_2)
		var_38_0:addChild(var_38_6)
	else
		local var_38_7 = ccui.ImageView:create(var_38_5)

		var_38_7:setPosition(cc.p(var_38_0:getContentSize().width / 2, var_38_0:getContentSize().height / 2))
		var_38_7:setScale(var_38_2)
		var_38_0:addChild(var_38_7)
	end

	if var_38_3[1].item_attr then
		for iter_38_0, iter_38_1 in var_38_3[1].item_attr:gmatch("([^&]+)=([^&]+)") do
			if iter_38_0 == "star" then
				starNum = tonumber(iter_38_1)

				for iter_38_2 = 1, starNum do
					local var_38_8

					if config._DEBUG then
						var_38_8 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
					end

					local var_38_9 = 26

					var_38_8:setScale(0.8)
					var_38_8:setPosition(var_38_9, (iter_38_2 - 1) * 21 + 28)
					var_38_0:addChild(var_38_8)
				end
			end
		end
	end

	local var_38_10 = ccui.ImageView:create(self.layerName .. "/mask.png", var_0_9)

	var_38_10:setPosition(cc.p(var_38_0:getContentSize().width / 2, var_38_0:getContentSize().height / 2))
	var_38_10:setVisible(arg_38_2.stat == var_0_11 or arg_38_2.stat == var_0_14)
	var_38_0:addChild(var_38_10, 5)

	local var_38_11 = ccui.ImageView:create(self.layerName .. "/got_bg.png", var_0_9)

	var_38_11:setPosition(cc.p(var_38_0:getContentSize().width / 2, var_38_0:getContentSize().height / 2))
	var_38_11:setVisible(arg_38_2.stat == var_0_14)
	var_38_0:addChild(var_38_11, 6)

	local var_38_12 = cc.Label:createWithTTF("X" .. var_38_3[1].dropNum, FONT_W5, 18)

	var_38_12:setAnchorPoint(cc.p(1, 0))
	var_38_12:setPosition(cc.p(88, 7))
	var_38_12:setColor(self.color4 or cc.c3b(0, 0, 0))
	var_38_0:addChild(var_38_12, 2)

	local var_38_13 = ccui.ImageView:create(self.layerName .. "/cost_bg.png", var_0_9)

	var_38_13:setPosition(cc.p(var_38_0:getContentSize().width / 2, -25))
	var_38_0:addChild(var_38_13)

	if arg_38_2.stat == var_0_14 then
		var_38_13:loadTexture(self.layerName .. "/got.png", var_0_9)
	end

	local var_38_14 = cc.Label:createWithTTF(arg_38_2.neednum, FONT_W5, 20)

	var_38_14:setPosition(cc.p(var_38_13:getContentSize().width / 2 - 12, var_38_13:getContentSize().height / 2))
	var_38_14:setVisible(arg_38_2.stat ~= var_0_14)
	var_38_14:setAnchorPoint(cc.p(0, 0.5))
	var_38_14:setColor(cc.c3b(255, 255, 255))
	var_38_13:addChild(var_38_14)

	if arg_38_2.stat == var_0_11 then
		var_38_14:setColor(self.color1 or cc.c3b(174, 173, 176))
	elseif activity_manager:getMultiPTnum(self.activityId) >= arg_38_2.neednum then
		var_38_14:setColor(self.color2 or cc.c3b(255, 255, 255))
	else
		var_38_14:setColor(self.color3 or cc.c3b(255, 0, 0))
	end

	local var_38_18 = ccui.ImageView:create(self.layerName .. "/icon.png", var_0_9)

	var_38_18:setPosition(cc.p(28, var_38_13:getContentSize().height / 2 + 5))
	var_38_18:setVisible(arg_38_2.stat ~= var_0_14)
	var_38_13:addChild(var_38_18)

	if arg_38_3 ~= 1 then
		for iter_38_3, iter_38_4 in pairs((self:getItemSpriteLineList(arg_38_3, arg_38_1))) do
			local var_38_19 = ccui.ImageView:create(iter_38_4, var_0_9)

			var_38_19:setAnchorPoint(var_0_16[iter_38_3])
			var_38_19:setPosition(cc.p(var_38_0:getContentSize().width / 2, var_38_0:getContentSize().height - 5))
			var_38_0:addChild(var_38_19, -1)
		end
	end

	return var_38_0
end

function ActivityMultiPtLayer:getNeedJumpToIndex()
	local var_39_0, var_39_1 = GetTableViewShowCellIdx(self.levelView, {
		maxcount = math.ceil(self.levelListLen),
		cellsize = cc.size(640, self.LEVEL_CELL_HEIGHT)
	})

	return (self.curLevel + (var_39_1 - var_39_0 - 2) > self.levelListLen or nil) and self.levelListLen
end

function ActivityMultiPtLayer:updateTaskView(arg_40_1, arg_40_2)
	if self.levelView then
		self.levelView:setVisible(false)
	end

	self.taskListData = activity_manager:getActivityMultiPtTaskData(self.activityId) or {}
	self.taskListLen = #self.taskListData

	if self.taskView then
		self.taskView:setVisible(true)
		self:updateShowingCells(self.taskView, self.taskListLen, self.TASK_CELL_HEIGHT)

		return
	end

	local var_40_0 = self.bottomList:getPositionY() + 38

	self.taskView = cc.TableView:create(cc.size(640, 705 + GameDisplay.fix_y * 2))

	self.taskView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskView:setAnchorPoint(cc.p(0, 0))
	self.taskView:setPosition(0, var_40_0)
	self.taskView:setDelegate()
	self.rootLayer:addChild(self.taskView)
	self.taskView:registerScriptHandler(function(arg_42_0, arg_42_1)
		return 640, self.TASK_CELL_HEIGHT
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskView:registerScriptHandler(function(arg_41_0, arg_41_1)
		local var_41_0 = arg_41_0:dequeueCell()

		if not var_41_0 then
			var_41_0 = cc.TableViewCell:create()

			local var_41_2 = self:createTaskSprite(self.taskListData[arg_41_1 + 1])

			var_41_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_41_2:setPosition(cc.p(320, self.LEVEL_CELL_HEIGHT / 2 - 50))
			var_41_0:addChild(var_41_2)
			var_41_0:setLocalZOrder(999 - 10 * arg_41_1)

			if arg_41_1 < 7 then
				var_41_2:setOpacity(0)
				var_41_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_41_1), cc.FadeIn:create(0.1)))
			end
		else
			local var_41_3 = var_41_0:getChildByTag(100)

			self:updateTaskSprite(var_41_3, self.taskListData[arg_41_1 + 1])
			var_41_0:setLocalZOrder(999 - 10 * arg_41_1)

			if self.showEffect and arg_41_1 < 7 then
				var_41_3:setOpacity(0)
				var_41_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_41_1), cc.FadeIn:create(0.1)))
			elseif var_41_3:getOpacity() < 255 then
				var_41_3:setOpacity(255)
			end
		end

		return var_41_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskView:registerScriptHandler(function(arg_43_0, arg_43_1)
		return self.taskListLen
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self.showEffect = false
	end)))
	self.taskView:reloadData()
end

function ActivityMultiPtLayer:createTaskSprite(arg_45_1)
	local var_45_0 = self.taskNode1:clone()

	var_45_0:setName("sprite_bg")
	var_45_0:setTag(100)
	var_45_0:getChildByName("task_img"):loadTexture(self.layerName .. "/icon_bpdianshu.png", var_0_9)
	var_45_0:getChildByName("pt_num"):setString("X" .. activity_manager:getBattlePassDrop(self.activityId, arg_45_1.drop)[1].dropNum)
	var_45_0:getChildByName("name_lbl"):setString(arg_45_1.name)

	local var_45_1 = var_45_0:getChildByName("get_reward_btn")

	if arg_45_1.status >= 1 then
		var_45_1:loadTextures(self.btn_stat_img[self.IS_GETTED], nil, self.btn_stat_img[self.IS_GETTED], var_0_9)
	elseif arg_45_1.percent >= 100 then
		var_45_1:loadTextures(self.btn_stat_img[self.CAN_GET], nil, self.btn_stat_img[self.CAN_GET], var_0_9)
	else
		var_45_1:loadTextures(self.btn_stat_img[self.UN_ACHIEVE], nil, self.btn_stat_img[self.UN_ACHIEVE], var_0_9)
	end

	var_45_1:addTouchEventListener(function(arg_46_0, arg_46_1)
		if arg_46_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_45_1.status >= 1 then
			return
		end

		if arg_45_1.percent >= 100 then
			activity_manager:getMultiPtTaskReward(self.activityId, arg_45_1.taskid)
		else
			self:taskTumpTo(arg_45_1.jump)
		end
	end)

	local var_45_2 = var_45_0:getChildByName("progress_bg")
	local var_45_3 = var_45_2:getChildByName("ProgressBar_43")
	local var_45_4 = var_45_2:getChildByName("percent_lbl")
	local var_45_6 = arg_45_1.status == 1 and 100 or arg_45_1.percent >= 0 and math.min(arg_45_1.percent, 100) or 100

	var_45_3:setPercent(0)
	var_45_4:setString(var_45_6 .. "%")

	return var_45_0
end

function ActivityMultiPtLayer:updateTaskSprite(arg_47_1, arg_47_2)
	arg_47_1:getChildByName("pt_num"):setString("X" .. activity_manager:getBattlePassDrop(self.activityId, arg_47_2.drop)[1].dropNum)
	arg_47_1:getChildByName("name_lbl"):setString(arg_47_2.name)

	local var_47_0 = arg_47_1:getChildByName("get_reward_btn")

	if arg_47_2.status >= 1 then
		var_47_0:loadTextures(self.btn_stat_img[self.IS_GETTED], nil, self.btn_stat_img[self.IS_GETTED], var_0_9)
	elseif arg_47_2.percent >= 100 then
		var_47_0:loadTextures(self.btn_stat_img[self.CAN_GET], nil, self.btn_stat_img[self.CAN_GET], var_0_9)
	else
		var_47_0:loadTextures(self.btn_stat_img[self.UN_ACHIEVE], nil, self.btn_stat_img[self.UN_ACHIEVE], var_0_9)
	end

	var_47_0:addTouchEventListener(function(arg_48_0, arg_48_1)
		if arg_48_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_47_2.status >= 1 then
			return
		end

		if arg_47_2.percent >= 100 then
			activity_manager:getMultiPtTaskReward(self.activityId, arg_47_2.taskid)
		else
			self:taskTumpTo(arg_47_2.jump)
		end
	end)

	local var_47_1 = arg_47_1:getChildByName("progress_bg"):getChildByName("ProgressBar_43")
	local var_47_3 = arg_47_2.status == 1 and 100 or arg_47_2.percent >= 0 and math.min(arg_47_2.percent, 100) or 100

	var_47_1:setPercent(0)
	arg_47_1:getChildByName("progress_bg"):getChildByName("percent_lbl"):setString(var_47_3 .. "%")
end

function ActivityMultiPtLayer.taskTumpTo(arg_49_0, arg_49_1)
	if arg_49_1 == 130 then
		LayerManager:pushInLayer("SignLayerNew", {
			callback = function()
				activity_manager:getActivityMultiPtTask(arg_49_0.activityId)
			end
		})
	elseif arg_49_1 == 111 then
		require("controller.sign_manager"):createMidasLayer(function()
			activity_manager:getActivityMultiPtTask(arg_49_0.activityId)
		end)
	elseif arg_49_1 == 220 then
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
				activity_manager:getActivityMultiPtTask(arg_49_0.activityId)
			end
		})
	elseif arg_49_1 == 300 then
		LayerManager:pushInLayer("EquipLayer", {
			exitCallback = function()
				activity_manager:getActivityMultiPtTask(arg_49_0.activityId)
			end
		})
	elseif arg_49_1 then
		require("controller.goto_system_manager")

		local var_49_0 = {
			jump_to_system = arg_49_1
		}

		var_49_0.config = system_jump_config[SYSTEMID[arg_49_1]] and system_jump_config[SYSTEMID[arg_49_1]].config

		if var_49_0.config then
			if var_49_0.config.exitCallbackType == "function" then
				var_49_0.config.exitCallback = nil
			elseif var_49_0.config.exitCallbackType == "string" then
				var_49_0.config = "MainLayer"
			end
		end

		goto_complete_system(var_49_0)
	end
end

function ActivityMultiPtLayer.updateShowingCells(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	local var_56_0, var_56_1 = GetTableViewShowCellIdx(arg_56_1, {
		maxcount = math.ceil(arg_56_2),
		cellsize = cc.size(640, arg_56_3)
	})

	for iter_56_0 = var_56_0, var_56_1 do
		arg_56_1:updateCellAtIndex(iter_56_0)
	end
end

function ActivityMultiPtLayer:fullScreen()
	local var_57_0 = self.rootLayer:getChildByName("panel_up")

	var_57_0:setAnchorPoint(cc.p(0.5, 1))
	var_57_0:setPositionY(GameDisplay.getUiScreenSize().height - GameDisplay.fix_y)

	local var_57_1 = self.rootLayer:getChildByName("Image_bottom")

	var_57_1:setPositionY(var_57_1:getPositionY() - GameDisplay.fix_y)
	var_57_0:setLocalZOrder(51)
	var_57_1:setLocalZOrder(51)

	if self.btn_sign then
		self.btn_sign:setPositionY(self.btn_sign:getPositionY() + GameDisplay.fix_y)
	end
end

function ActivityMultiPtLayer:updateAlert()
	local var_58_0 = self.rootLayer:getChildByName("panel_up")
	local var_58_1 = var_58_0:getChildByName("switch_btn_level")
	local var_58_2 = var_58_0:getChildByName("switch_btn_task")
	local var_58_3 = {
		x = 335,
		y = 70
	}

	if activity_manager:getAlertStatus(self.activityId, "multi_proceed") then
		global_add_alert_tag(var_58_1, var_58_3)
	else
		global_remove_alert_tag(var_58_1)
	end

	if activity_manager:getAlertStatus(self.activityId, "multi_pt") then
		global_add_alert_tag(var_58_2, var_58_3)
	else
		global_remove_alert_tag(var_58_2)
	end
end
