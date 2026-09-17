PatrolFightLayer = class("PatrolFightLayer", function()
	return cc.Layer:create()
end)

local patrol_manager = require("controller.patrol_manager")
local level_manager = require("controller.level_manager")
local array_manager = require("controller.array_manager")
local event_manager = require("controller.event_manager")
local alert_manager = require("controller.alert_manager")
local playermodel = require("model.playermodel")
local levelmode_data = require("data.levelmode_data")
local chapter_data = require("data.chapter_data")
local city_data = require("data.city_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local event_data = require("data.event_data")
local postcard_data = require("data.postcard_data")
local item_data = require("data.item_data")
local Utility = require("common.Utility")
local var_0_15
local var_0_16 = config._DEBUG and 0 or 1
local var_0_18 = 3
local var_0_19 = 2
local var_0_20 = 1
local var_0_21 = 2
local var_0_22 = 3
local var_0_23 = 4
local var_0_25 = false

local function var_0_26(arg_2_0)
	if arg_2_0 >= 3600 then
		return string.format("%02d:%02d:%02d", math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60), arg_2_0 % 60)
	elseif arg_2_0 <= 0 then
		return " "
	else
		return string.format("%02d:%02d", math.floor(arg_2_0 / 60), arg_2_0 % 60)
	end
end

function PatrolFightLayer.create(arg_3_0, ...)
	local var_3_0 = PatrolFightLayer.new()

	var_3_0:init(...)

	return var_3_0
end

function PatrolFightLayer.getInstance()
	return var_0_15
end

function PatrolFightLayer:init(arg_5_1)
	var_0_15 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "patrol_fight.json" or "patrol_fight.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:enterMapAction()
	self:initEventList()
	patrol_manager:getAllPatrolCitys(function(arg_6_0)
		self:initData(arg_6_0)
		self:initPatrolList()
		self:initTimers()
	end)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			self:updateAlert()
			self.patrolBnt:release()

			var_0_15 = nil

			if arg_5_1 and arg_5_1.exitCallback then
				arg_5_1.exitCallback()
			end
		end
	end)
end

function PatrolFightLayer:initData(arg_8_1)
	self.readyCitys = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_1.patrol_citys) do
		self.readyCitys[iter_8_1.cityid .. "-" .. iter_8_1.chapter] = iter_8_1
	end

	self.runningPatrolKeys = patrol_manager:getAllPatrolKey()

	self:updateData()
end

function PatrolFightLayer:updateData(arg_9_1, arg_9_2)
	self.rewardMode = nil
	self.rewardChapter = nil

	local var_9_0 = {
		finish = function(self)
			self.runningPatrolKeys = patrol_manager:getAllPatrolKey()
			self.readyCitys[self.cityid .. "-" .. self.chapter] = nil
		end,
		cancel = function(self)
			self.runningPatrolKeys = patrol_manager:getAllPatrolKey()
			self.readyCitys[self.cityid .. "-" .. self.chapter] = self.readyCitys[self.cityid .. "-" .. self.chapter] or patrol_manager:genReadyPatrolInfo(self)
			self.readyCitys[self.cityid .. "-" .. self.chapter].isLock = nil
		end,
		go = function(self)
			self.runningPatrolKeys = patrol_manager:getAllPatrolKey()
			self.readyCitys[self.cityid .. "-" .. self.chapter].isLock = true
		end
	}

	if var_9_0[arg_9_1] then
		var_9_0[arg_9_1](arg_9_2)
	end

	self.readyCityKeys = {}

	for iter_9_0, iter_9_1 in pairs(self.readyCitys) do
		if not iter_9_1.isLock then
			table.insert(self.readyCityKeys, iter_9_1.cityid .. "-" .. iter_9_1.chapter)
		end
	end

	table.sort(self.readyCityKeys, function(arg_13_0, arg_13_1)
		local var_13_0, var_13_1 = arg_13_0:match("(%d+)-(%d+)")
		local var_13_2, var_13_3 = arg_13_1:match("(%d+)-(%d+)")

		if var_13_0 == var_13_2 then
			return tonumber(var_13_1) < tonumber(var_13_3)
		else
			return tonumber(var_13_0) < tonumber(var_13_2)
		end
	end)
	table.sort(self.runningPatrolKeys, function(arg_14_0, arg_14_1)
		local var_14_0, var_14_1 = arg_14_0:match("(%d+)-(%d+)")
		local var_14_2, var_14_3 = arg_14_1:match("(%d+)-(%d+)")

		if var_14_0 == var_14_2 then
			return tonumber(var_14_1) < tonumber(var_14_3)
		else
			return tonumber(var_14_0) < tonumber(var_14_2)
		end
	end)

	return self:getPatrolListNums() - self:getPatrolListNums()
end

function PatrolFightLayer.updateAlert(arg_15_0)
	local var_15_0
	local var_15_1

	if event_manager.runningEvents and next(event_manager.runningEvents) ~= nil then
		var_15_0 = true
	end

	local var_15_2 = patrol_manager:getAllPatrolKey()

	if var_15_2 and next(var_15_2) ~= nil then
		for iter_15_0, iter_15_1 in pairs(var_15_2) do
			if patrol_manager:getPatrolState(iter_15_1) == 2 then
				var_15_1 = true

				break
			end
		end
	end

	if var_15_0 then
		alert_manager:register_alert(ALERT_NEW_EVENT)
	else
		alert_manager:unregister_alert(ALERT_NEW_EVENT, not var_15_1)
	end

	if var_15_1 then
		alert_manager:register_alert(ALERT_PATROL_FIGHT)
	else
		alert_manager:unregister_alert(ALERT_PATROL_FIGHT, not var_15_0)
	end
end

function PatrolFightLayer:initTimers()
	self:unscheduleUpdate()

	local var_16_0 = 0

	self:scheduleUpdateWithPriorityLua(function(arg_17_0)
		var_16_0 = var_16_0 + arg_17_0

		if var_16_0 >= 1 then
			self:updateShowAndRunCellPanels()

			var_16_0 = 0
		end
	end, 0)
end

function PatrolFightLayer:enterMapAction()
	var_0_25 = true

	self.arrowImg:setFlippedX(true)
	self.Bg:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(0, self.Bg:getPositionY())), cc.CallFunc:create(function()
		var_0_25 = false

		self.arrowImg:setFlippedX(false)
	end)))
end

function PatrolFightLayer:initUI()
	self.Bg = ccui.Helper:seekWidgetByName(self.rootLayer, "Bg")
	self.arrowImg = ccui.Helper:seekWidgetByName(self.rootLayer, "arrow")
	self.arrowBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_arrow")
	self.eventList = ccui.Helper:seekWidgetByName(self.rootLayer, "event_list")
	self.patrolList = ccui.Helper:seekWidgetByName(self.rootLayer, "patrol_list")
	self.patrolBnt = ccui.Helper:seekWidgetByName(self.patrolList, "patrol_bg")

	self.patrolBnt:retain()
	self.patrolBnt:removeFromParent()
	self.rootLayer:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_0_25 then
			return
		end

		var_0_25 = true

		self.Bg:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-self.Bg:getContentSize().width, self.Bg:getPositionY())), cc.CallFunc:create(function()
			LayerManager:removePopLayer(self.__queueindex)
		end)))
	end)
	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setLocalZOrder(1)
	LayerManager:createFullScreenMask(self, 200, function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_0_25 then
			return
		end

		var_0_25 = true

		self.Bg:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-self.Bg:getContentSize().width, self.Bg:getPositionY())), cc.CallFunc:create(function()
			LayerManager:removePopLayer(self.__queueindex)
		end)))
	end)
	self.arrowBnt:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_0_25 then
			return
		end

		var_0_25 = true

		self.Bg:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-self.Bg:getContentSize().width, self.Bg:getPositionY())), cc.CallFunc:create(function()
			LayerManager:removePopLayer(self.__queueindex)
		end)))
	end)
end

function PatrolFightLayer.createEventBnt(arg_27_0, arg_27_1)
	local var_27_0 = event_data[arg_27_1]
	local var_27_1 = event_data[arg_27_1].postcard and "mainScenebg/postcard/" .. postcard_data[event_data[arg_27_1].postcard].image .. ".png" or event_data[arg_27_1].cover and "mainScenebg/postcard/" .. event_data[arg_27_1].cover .. ".png" or "mainScenebg/postcard/1241041.png"
	local var_27_2 = ccui.Button:create(var_27_1, nil, var_27_1)

	var_27_2:setScale(0.26)
	var_27_2:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_27_2.isLock then
			return
		end

		var_27_2.isLock = true

		event_manager:gain_event_award(arg_27_1, function(arg_29_0, arg_29_1, arg_29_2)
			if arg_29_0 == 1 then
				local var_29_0 = {
					labels = L_PATROL_GAIN_EVENT,
					items = arg_29_1
				}

				var_29_0.postcards = arg_29_2 and {
					arg_29_2
				} or nil
				var_29_0.postcardInfo = {
					img = var_27_0.cover,
					des = var_27_0.postcard_data
				}

				LayerManager:pushInLayer("PopGainPostcard", var_29_0)
				arg_27_0:updateEventList()
			end

			var_27_2.isLock = true
		end)
	end)

	local var_27_3 = ccui.ImageView:create("patrol_fight/new_tips.png", var_0_16)

	var_27_3:setAnchorPoint(cc.p(1, 1))
	var_27_3:setPosition(var_27_2:getContentSize().width, var_27_2:getContentSize().height)
	var_27_2:addChild(var_27_3)

	return var_27_2
end

function PatrolFightLayer:initEventList()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_no_event"):setLocalZOrder(2)
	event_manager:reloadInfoByServer(function()
		local var_31_0 = event_manager:getEvents()

		if #var_31_0 > 0 then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_no_event"):setVisible(false)
			self.eventList:setInnerContainerSize(cc.size(#var_31_0 * 140, self.eventList:getContentSize().height))

			for iter_31_0, iter_31_1 in pairs(var_31_0) do
				local var_31_2 = self:createEventBnt(iter_31_1.eventid)

				var_31_2.order = iter_31_1.order

				var_31_2:setPosition(73 + (iter_31_0 - 1) * 140, 44)
				var_31_2:setName("event" .. iter_31_1.eventid)
				self.eventList:addChild(var_31_2)
			end
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_no_event"):setVisible(true)
		end
	end)
end

function PatrolFightLayer:updateEventList()
	self.eventList:removeAllChildren()

	local var_32_0 = event_manager:getEvents()

	if #var_32_0 > 0 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_no_event"):setVisible(false)
		self.eventList:setInnerContainerSize(cc.size(#var_32_0 * 140, self.eventList:getContentSize().height))

		for iter_32_0, iter_32_1 in pairs(var_32_0) do
			local var_32_2 = self:createEventBnt(iter_32_1.eventid)

			var_32_2.order = iter_32_1.order

			var_32_2:setPosition(73 + (iter_32_0 - 1) * 140, 44)
			var_32_2:setName("event" .. iter_32_1.eventid)
			self.eventList:addChild(var_32_2)
		end
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_no_event"):setVisible(true)
	end
end

function PatrolFightLayer:exit()
	self.Bg:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-self.Bg:getContentSize().width, self.Bg:getPositionY())), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PatrolFightLayer:createPatrolPanel(arg_35_1, arg_35_2)
	local var_35_0 = ccui.Layout:create()
	local var_35_1 = self.patrolBnt:clone()

	var_35_1:setSwallowTouches(false)
	var_35_1:setPosition(var_35_1:getContentSize().width / 2, var_35_1:getContentSize().height / 2)
	var_35_1:setName("Bnt")
	var_35_0:addChild(var_35_1)

	local var_35_2 = ccui.ImageView:create("patrol_fight/title_ready.png", var_0_16)

	var_35_2:setAnchorPoint(cc.p(0, 0.5))
	var_35_2:setPosition(0, var_35_1:getContentSize().height / 2)
	var_35_2:setName("title")
	var_35_0:addChild(var_35_2)

	local var_35_3 = ccui.Button:create("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_16)

	var_35_3:setScale(0.6)
	var_35_3:setAnchorPoint(cc.p(1, 0.5))
	var_35_3:setPosition(var_35_1:getContentSize().width - 10, var_35_1:getContentSize().height / 2)
	var_35_3:setTitleText(L_PATROL_ONEKEY[1])
	var_35_3:setTitleFontName(FONT_BUTTON)
	var_35_3:setTitleFontSize(30)
	var_35_3:setTitleColor(cc.c3b(0, 0, 0))
	var_35_3:setName("bnt_onekey")
	var_35_0:addChild(var_35_3)

	local var_35_4 = ccui.Button:create("patrol_fight/btn_whole_get.png", nil, "patrol_fight/btn_whole_get.png", var_0_16)

	var_35_0:addChild(var_35_4)
	var_35_4:setPosition(450, var_35_2:getPositionY())
	var_35_4:setName("btnReward")
	Utility:addClickEventListener(var_35_4, handler(self, self.onBtnReward))

	local var_35_5 = ccui.Button:create("patrol_fight/btn_onkey_patrol.png", nil, "patrol_fight/btn_onkey_patrol.png", var_0_16)

	var_35_0:addChild(var_35_5)
	var_35_5:setPosition(250, var_35_2:getPositionY())
	var_35_5:setName("btnPatrol")
	Utility:addClickEventListener(var_35_5, handler(self, self.onBtnPatrol))
	table.insert(self.cell_panels, var_35_0)
	self:updatePatrolPanel(var_35_0, arg_35_1, arg_35_2)

	return var_35_0
end

function PatrolFightLayer:onBtnReward(arg_36_1)
	local var_36_0, var_36_1 = patrol_manager:get_can_get_reward_num()

	if var_36_1 <= 0 then
		global_ShowBlockWords("没有奖励可以领取")

		return
	end

	if var_36_1 == 1 and self.rewardMode and self.rewardChapter then
		patrol_manager:finishPatrol(self.rewardMode, self.rewardChapter, function(arg_37_0)
			if arg_37_0 == 1 then
				patrol_manager:getAllPatrolCitys(function(arg_38_0)
					self:initData(arg_38_0)
					self:initPatrolList()
					self:initTimers()
				end)
			end
		end)

		return
	end

	patrol_manager:rewardOneKey(function()
		patrol_manager:getAllPatrolCitys(function(arg_40_0)
			self:initData(arg_40_0)
			self:initPatrolList()
			self:initTimers()
		end)
	end)
end

function PatrolFightLayer.onBtnPatrol(arg_41_0, arg_41_1)
	LayerManager:pushInLayer("PopPatrolOneKeyLayer", {
		confirmCallBack = function(arg_42_0)
			patrol_manager:patrolOneKey(arg_42_0, function(arg_43_0)
				if arg_43_0.result == 1 then
					patrol_manager:getAllPatrolCitys(function(arg_44_0)
						arg_41_0:initData(arg_44_0)
						arg_41_0:initPatrolList()
						arg_41_0:initTimers()
					end)
				end
			end)
		end
	})
end

local function var_0_27(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0:getParent().idx
	local var_45_1 = patrol_manager:getPatrolState(arg_45_1.mode .. "-" .. arg_45_1.chapter)

	arg_45_0.chapter_key = arg_45_1.mode .. "-" .. arg_45_1.chapter
	arg_45_0.cityid = levelmode_data[arg_45_1.mode].city
	arg_45_0.mode = arg_45_1.mode
	arg_45_0.chapter = arg_45_1.chapter
	arg_45_0.patrol_state = patrol_manager:getPatrolState(arg_45_1.mode .. "-" .. arg_45_1.chapter)

	arg_45_0:getChildByName("city_cover"):loadTexture("patrol_fight/" .. city_data[levelmode_data[arg_45_1.mode].city].img .. ".png", var_0_16)
	arg_45_0:getChildByName("cover_tips"):loadTexture("patrol_fight/difficult" .. level_manager:getDifficultByMode(arg_45_1.mode) .. "_tips.png", var_0_16)
	arg_45_0:getChildByName("city_name"):setString(city_data[levelmode_data[arg_45_1.mode].city].name)
	arg_45_0:getChildByName("chapter_name"):setString(chapter_data[arg_45_1.mode .. "-" .. arg_45_1.chapter].name)
	arg_45_0:getChildByName("ScrollView_drop"):setVisible(false)
	arg_45_0:getChildByName("Panel_q"):setVisible(true)
	arg_45_0:getChildByName("Label_time"):setVisible(true)
	arg_45_0:getChildByName("cover_tips"):setVisible(true)
	arg_45_0:getChildByName("Label_time"):setString(var_0_26(arg_45_1.time))

	local var_45_2 = arg_45_0:getChildByName("Panel_q")

	for iter_45_0 = 1, 4 do
		if arg_45_1.array[iter_45_0] then
			var_45_2:getChildByName("q_img" .. iter_45_0):loadTexture("role/wuji/" .. model_data[servant_data[arg_45_1.array[iter_45_0]].modelid].head_image .. ".png")
			var_45_2:getChildByName("q_img" .. iter_45_0):setVisible(true)
		else
			var_45_2:getChildByName("q_img" .. iter_45_0):setVisible(false)
		end
	end

	function arg_45_0:updateBntsState()
		local var_46_0 = patrol_manager:getPatrolState(self.chapter_key)
		local var_46_1 = self:getChildByName("Button_sure")
		local var_46_2 = self:getChildByName("Button_quick")

		self:getChildByName("Button_go"):setVisible(false)

		if var_46_0 == var_0_18 then
			var_46_1:setVisible(false)
			var_46_2:setVisible(true)
		elseif var_46_0 == var_0_19 then
			var_46_1:setVisible(true)
			var_46_2:setVisible(false)
		end
	end

	arg_45_0:updateBntsState()
	arg_45_0:getChildByName("Button_sure"):addTouchEventListener(function(arg_47_0, arg_47_1)
		if arg_47_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_0_25 then
			return
		end

		if patrol_manager:getPatrolState(arg_47_0:getParent().chapter_key) ~= var_0_19 then
			return
		end

		if arg_47_0.isLock then
			return
		end

		if math.abs(arg_47_0:getTouchBeganPosition().y - arg_47_0:getTouchEndPosition().y) > 50 then
			return
		end

		arg_47_0.isLock = true

		local var_47_0 = patrol_manager:getPatrolInfo(arg_47_0:getParent().chapter_key)

		patrol_manager:finishPatrol(arg_47_0:getParent().mode, arg_47_0:getParent().chapter, function(arg_48_0)
			if arg_48_0 == 1 then
				arg_45_0.chapter_key = nil

				if PatrolFightLayer.getInstance() then
					PatrolFightLayer.getInstance():updateShowingCells((PatrolFightLayer.getInstance():updateData("finish", {
						cityid = arg_47_0:getParent().cityid,
						mode = arg_47_0:getParent().mode,
						chapter = arg_47_0:getParent().chapter
					})))
					PatrolFightLayer.getInstance():updatePatrolList()
				end
			end

			arg_47_0.isLock = false
		end)
	end)
	arg_45_0:getChildByName("Button_quick"):addTouchEventListener(function(arg_49_0, arg_49_1)
		if arg_49_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_0_25 then
			return
		end

		if arg_49_0.isLock then
			return
		end

		if math.abs(arg_49_0:getTouchBeganPosition().y - arg_49_0:getTouchEndPosition().y) > 50 then
			return
		end

		arg_49_0.isLock = true

		local var_49_0 = patrol_manager:getPatrolState(arg_49_0:getParent().chapter_key)

		local function var_49_1()
			patrol_manager:finishPatrol(arg_49_0:getParent().mode, arg_49_0:getParent().chapter, function(arg_51_0)
				if arg_51_0 == 1 then
					arg_45_0.chapter_key = nil

					if PatrolFightLayer.getInstance() then
						PatrolFightLayer.getInstance():updateShowingCells((PatrolFightLayer.getInstance():updateData("finish", {
							cityid = arg_49_0:getParent().cityid,
							mode = arg_49_0:getParent().mode,
							chapter = arg_49_0:getParent().chapter
						})))
						PatrolFightLayer.getInstance():updatePatrolList()
					end
				end

				arg_49_0.isLock = false
			end)
		end

		if var_49_0 == var_0_19 then
			var_49_1()
		elseif var_49_0 == var_0_18 then
			local var_49_2 = math.ceil(patrol_manager:getPatrolInfo(arg_49_0:getParent().chapter_key).time / 360)

			LayerManager:pushInLayer("PopDoLayer", {
				costtype = "diamond",
				surecallback = var_49_1,
				cancelcallback = function()
					arg_49_0.isLock = false
				end,
				own = playermodel.diamond,
				cost = var_49_2,
				labels = {
					titleNewImage = "public/title/quikc_complete_patrol.png",
					title = L_PATROL_QUICK_MSG.title,
					des = string.format(L_PATROL_QUICK_MSG.des, var_49_2),
					button = L_PATROL_QUICK_MSG.button
				}
			})
		end
	end)
	arg_45_0:addTouchEventListener(function(arg_53_0, arg_53_1)
		if arg_53_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_0_25 then
			return
		end

		if arg_53_0.isLock then
			return
		end

		if math.abs(arg_53_0:getTouchBeganPosition().y - arg_53_0:getTouchEndPosition().y) > 50 then
			return
		end

		local var_53_0 = patrol_manager:getPatrolState(arg_53_0.chapter_key)

		if var_53_0 ~= var_0_18 then
			return
		end

		arg_53_0.isLock = true

		local function var_53_1(arg_54_0)
			arg_45_0.chapter_key = nil

			if PatrolFightLayer.getInstance() then
				PatrolFightLayer.getInstance():updateShowingCells((PatrolFightLayer.getInstance():updateData(arg_54_0, {
					cityid = arg_53_0.cityid,
					mode = arg_53_0.mode,
					chapter = arg_53_0.chapter
				})))
				PatrolFightLayer.getInstance():updatePatrolList()
			end

			arg_53_0.isLock = false
		end

		if var_53_0 == var_0_19 then
			var_53_1()
		elseif var_53_0 == var_0_18 then
			LayerManager:pushInLayer("PatrolPopLayer", {
				inittype = 1,
				cityid = arg_53_0.cityid,
				mode = arg_53_0.mode,
				chapter = arg_53_0.chapter,
				callback = var_53_1,
				exitCallback = function()
					arg_53_0.isLock = false
				end
			})
		end
	end)
end

local function var_0_28(arg_56_0, arg_56_1)
	arg_56_0.chapter_key = arg_56_1.mode .. "-" .. arg_56_1.chapter
	arg_56_0.cityid = levelmode_data[arg_56_1.mode].city
	arg_56_0.mode = arg_56_1.mode
	arg_56_0.chapter = arg_56_1.chapter
	arg_56_0.patrol_state = patrol_manager:getPatrolState(arg_56_1.mode .. "-" .. arg_56_1.chapter)

	arg_56_0:getChildByName("city_cover"):loadTexture("patrol_fight/" .. city_data[levelmode_data[arg_56_1.mode].city].img .. ".png", var_0_16)
	arg_56_0:getChildByName("cover_tips"):loadTexture("patrol_fight/difficult" .. level_manager:getDifficultByMode(arg_56_1.mode) .. "_tips.png", var_0_16)
	arg_56_0:getChildByName("city_name"):setString(city_data[levelmode_data[arg_56_1.mode].city].name)
	arg_56_0:getChildByName("chapter_name"):setString(chapter_data[arg_56_1.mode .. "-" .. arg_56_1.chapter].name)
	arg_56_0:getChildByName("ScrollView_drop"):setVisible(true)
	arg_56_0:getChildByName("Panel_q"):setVisible(false)
	arg_56_0:getChildByName("Button_sure"):setVisible(false)
	arg_56_0:getChildByName("Button_quick"):setVisible(false)
	arg_56_0:getChildByName("Button_go"):setVisible(true)
	arg_56_0:getChildByName("Label_time"):setVisible(false)
	arg_56_0:getChildByName("cover_tips"):setVisible(false)
	arg_56_0:getChildByName("Button_go"):addTouchEventListener(function(arg_57_0, arg_57_1)
		if arg_57_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PatrolPopLayer", {
			inittype = 1,
			cityid = arg_57_0:getParent().cityid,
			mode = arg_57_0:getParent().mode,
			chapter = arg_57_0:getParent().chapter,
			callback = function()
				if PatrolFightLayer.getInstance() then
					PatrolFightLayer.getInstance():updateShowingCells((PatrolFightLayer.getInstance():updateData("go", {
						cityid = arg_57_0:getParent().cityid,
						mode = arg_57_0:getParent().mode,
						chapter = arg_57_0:getParent().chapter
					})))
					PatrolFightLayer.getInstance():updatePatrolList()
				end
			end
		})
	end)

	local var_56_0 = arg_56_0:getChildByName("ScrollView_drop")

	var_56_0:removeAllChildren()
	var_56_0:setInnerContainerSize(cc.size(550, 59))
	var_56_0:setTouchEnabled(false)

	if arg_56_1.dropinfo then
		for iter_56_0, iter_56_1 in pairs(arg_56_1.dropinfo) do
			if iter_56_1.rare == 1 then
				local var_56_1 = iter_56_1.itemid
				local var_56_2 = ccui.ImageView:create("public/box/" .. item_data[iter_56_1.itemid].equip_quality .. ".png", var_0_16)

				var_56_2:setAnchorPoint(cc.p(0, 0))
				var_56_2:setPosition(5 + (iter_56_0 - 1) * 55, 4)
				var_56_2:setScale(50 / var_56_2:getContentSize().width)

				local var_56_3 = item_data[iter_56_1.itemid].bag_item_type == kITEM_COMPONENT and require("controller.component_manager"):create_component_icon(item_data[iter_56_1.itemid].id) or ccui.ImageView:create("equipment/" .. item_data[iter_56_1.itemid].image_id .. ".png")

				var_56_3:setScale(80 / var_56_3:getContentSize().width)
				var_56_3:setPosition(var_56_2:getContentSize().width / 2, var_56_2:getContentSize().height / 2)
				var_56_2:addChild(var_56_3)
				var_56_2:addTouchEventListener(function(arg_59_0, arg_59_1)
					if arg_59_1 ~= ccui.TouchEventType.ended then
						return
					end

					PopLayer:Item({
						itemid = var_56_1,
						removeParentCallback = function()
							self:runAction(cc.RemoveSelf:create())
						end
					})
				end)
				var_56_0:addChild(var_56_2)
			end
		end
	end
end

local function var_0_29()
	return false
end

local function var_0_30()
	for iter_62_0, iter_62_1 in pairs(PatrolFightLayer.getInstance().runningPatrolKeys) do
		if patrol_manager:getPatrolInfo(iter_62_1).time > 0 then
			return 2
		end
	end

	return 1
end

local function var_0_31(arg_63_0)
	arg_63_0:getChildByName("bnt_onekey"):addTouchEventListener(function(arg_64_0, arg_64_1)
		if arg_64_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_64_0.isLock then
			return
		end

		if math.abs(arg_64_0:getTouchBeganPosition().y - arg_64_0:getTouchEndPosition().y) > 50 then
			return
		end

		if not var_0_29() then
			return global_ShowBlockWords(L_PATROL_ONEKEY_ERROR)
		end

		local function var_64_0()
			patrol_manager:finishPatrolOneKey(function(arg_66_0)
				if arg_66_0 == 1 and PatrolFightLayer.getInstance() then
					PatrolFightLayer.getInstance().runningPatrolKeys = patrol_manager:getAllPatrolKey()

					PatrolFightLayer.getInstance():updateData()
					PatrolFightLayer.getInstance().tableview:reloadData()
					PatrolFightLayer.getInstance():updatePatrolList()
				end

				arg_64_0.isLock = false
			end)
		end

		if var_0_30() == 1 then
			var_64_0()
		else
			local var_64_1 = 0

			for iter_64_0, iter_64_1 in pairs(PatrolFightLayer.getInstance().runningPatrolKeys) do
				var_64_1 = var_64_1 + patrol_manager:getPatrolInfo(iter_64_1).time
			end

			local var_64_2 = math.ceil(var_64_1 / 360)

			LayerManager:pushInLayer("PopDoLayer", {
				costtype = "diamond",
				surecallback = var_64_0,
				cancelcallback = function()
					arg_64_0.isLock = false
				end,
				own = playermodel.diamond,
				cost = var_64_2,
				labels = {
					titleNewImage = "public/title/quikc_complete_patrol.png",
					title = L_PATROL_QUICK_MSG.title,
					des = string.format(L_PATROL_QUICK_MSG.des, var_64_2),
					button = L_PATROL_QUICK_MSG.button
				}
			})
		end
	end)
end

function PatrolFightLayer:updatePatrolPanel(arg_68_1, arg_68_2, arg_68_3)
	local var_68_0 = arg_68_2.patrol_info

	arg_68_1.paneltype = arg_68_2.paneltype
	arg_68_1.idx = arg_68_2.idx

	local var_68_1 = arg_68_1:getChildByName("title")
	local var_68_2 = arg_68_1:getChildByName("Bnt")
	local var_68_3 = arg_68_1:getChildByName("bnt_onekey")
	local var_68_4 = arg_68_1:getChildByName("btnReward")
	local var_68_5 = arg_68_1:getChildByName("btnPatrol")
	local var_68_6, var_68_7 = patrol_manager:get_can_get_reward_num()

	var_68_4:setVisible(arg_68_3 == 0 and var_68_7 > 0)
	var_68_5:setVisible(arg_68_3 == 0 and #self.readyCityKeys > 0)

	if var_68_7 == 1 and arg_68_2.patrol_info and patrol_manager:getPatrolState(arg_68_2.patrol_info.mode .. "-" .. arg_68_2.patrol_info.chapter) == var_0_19 then
		self.rewardMode = arg_68_2.patrol_info.mode
		self.rewardChapter = arg_68_2.patrol_info.chapter
	end

	;({
		[var_0_20] = function()
			var_68_2:setVisible(false)
			var_68_1:setVisible(true)
			var_68_3:setVisible(var_0_29())
			var_68_3:setTitleText(L_PATROL_ONEKEY[var_0_30()])
			var_68_1:loadTexture("patrol_fight/title_running.png", var_0_16)
			var_0_31(arg_68_1)
		end,
		[var_0_22] = function()
			var_68_2:setVisible(false)
			var_68_1:setVisible(true)
			var_68_3:setVisible(false)
			var_68_1:loadTexture("patrol_fight/title_ready.png", var_0_16)
		end,
		[var_0_21] = function()
			var_68_2:setVisible(true)
			var_68_1:setVisible(false)
			var_68_3:setVisible(false)
			var_0_27(var_68_2, var_68_0)
		end,
		[var_0_23] = function()
			var_68_2:setVisible(true)
			var_68_1:setVisible(false)
			var_68_3:setVisible(false)
			var_0_28(var_68_2, var_68_0)
		end
	})[arg_68_1.paneltype]()

	local var_68_8 = arg_68_1:getChildByName("bnt_awardup")

	if arg_68_1.paneltype == var_0_22 then
		local var_68_9

		if not var_68_8 then
			var_68_8 = ccui.Button:create("patrol_fight/awardup_btn.png", nil, "patrol_fight/awardup_btn.png", var_0_16)

			var_68_8:setPosition(cc.p(400, 0))
			var_68_8:setName("bnt_awardup")
			arg_68_1:addChild(var_68_8, 100)
			var_68_8:addTouchEventListener(function(arg_73_0, arg_73_1)
				if arg_73_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:pushInLayer("PopActivityDetail", {
					key = "award_up"
				})
			end)

			var_68_9 = playermodel.award_up_info.patrol and playermodel.award_up_info.patrol.rate > 1 and global_is_in_time(playermodel.award_up_info.patrol.starttime, playermodel.award_up_info.patrol.finishtime) or false
		end

		var_68_8:setVisible(var_68_9)
	elseif var_68_8 then
		var_68_8:setVisible(false)
	end
end

local var_0_32 = 530
local var_0_33 = 738
local var_0_34 = 9
local var_0_35 = 90
local var_0_36 = 530
local var_0_37 = 105

function PatrolFightLayer:initPatrolList()
	if self.tableview then
		self.tableview:reloadData()

		return
	end

	self.tableview = cc.TableView:create(cc.size(var_0_32, var_0_33))

	self.tableview:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableview:setPosition(cc.p(var_0_34, var_0_35))
	self.tableview:setDelegate()
	self.tableview:setName("tableview")
	self.Bg:addChild(self.tableview, 0)

	self.cell_panels = {}

	local function var_74_0(arg_75_0)
		arg_75_0 = arg_75_0 + 1

		local var_75_0 = #self.runningPatrolKeys
		local var_75_1 = #self.readyCityKeys
		local var_75_2 = #self.runningPatrolKeys > 0 and 1 or 0

		if #self.readyCityKeys > 0 then
			local var_75_3 = var_75_2 + var_75_0 + 1 or 0

			if var_75_2 > 0 and arg_75_0 == var_75_2 then
				return {
					paneltype = var_0_20,
					idx = arg_75_0 - 1
				}
			end

			if var_75_3 > 0 and arg_75_0 == var_75_3 then
				return {
					paneltype = var_0_22,
					idx = arg_75_0 - 1
				}
			end

			if var_75_2 < arg_75_0 and arg_75_0 <= var_75_2 + var_75_0 then
				return {
					idx = arg_75_0 - 1,
					paneltype = var_0_21,
					patrol_info = patrol_manager:getPatrolInfo(self.runningPatrolKeys[arg_75_0 - var_75_2])
				}
			elseif var_75_3 > 0 and var_75_3 < arg_75_0 and arg_75_0 <= var_75_3 + var_75_1 then
				return {
					idx = arg_75_0 - 1,
					paneltype = var_0_23,
					patrol_info = self.readyCitys[self.readyCityKeys[arg_75_0 - var_75_3]]
				}
			end
		end

		assert(false, (string.format("出问题了@木川 idx:%d, running:%d, ready:%d", arg_75_0, var_75_0, var_75_1)))
	end

	self.tableview:registerScriptHandler(function(arg_77_0, arg_77_1)
		return var_0_36, var_0_37
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableview:registerScriptHandler(function(arg_76_0, arg_76_1)
		local var_76_0 = arg_76_0:dequeueCell()

		if not var_76_0 then
			var_76_0 = cc.TableViewCell:create()

			var_76_0:setName("cell_" .. arg_76_1)

			local var_76_1 = self:createPatrolPanel(var_74_0(arg_76_1), arg_76_1)

			var_76_1:setName("panel")
			var_76_0:addChild(var_76_1)
		else
			self:updatePatrolPanel(var_76_0:getChildByName("panel"), var_74_0(arg_76_1), arg_76_1)
		end

		return var_76_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableview:registerScriptHandler(function(arg_78_0, arg_78_1)
		return self:getPatrolListNums()
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableview:reloadData()
	self:updatePatrolList()
end

function PatrolFightLayer:updatePatrolList()
	if #self.runningPatrolKeys == 0 and #self.readyCityKeys == 0 then
		if not self.Bg:getChildByName("no_patrol_img") then
			local var_79_0 = ccui.ImageView:create("patrol_fight/no_patrol_img.png", var_0_16)

			var_79_0:setAnchorPoint(cc.p(0, 0))
			var_79_0:setPosition(0, 0)
			var_79_0:setName("no_patrol_img")
			self.Bg:addChild(var_79_0)
		else
			self.Bg:getChildByName("no_patrol_img"):setVisible(true)
		end
	elseif self.Bg:getChildByName("no_patrol_img") then
		self.Bg:getChildByName("no_patrol_img"):setVisible(false)
	end
end

function PatrolFightLayer:updateShowingCells(arg_80_1)
	local var_80_0 = self:getPatrolListNums()

	if var_80_0 == 0 or arg_80_1 < 0 then
		self.tableview:reloadData()

		return
	end

	if arg_80_1 and arg_80_1 ~= 0 then
		for iter_80_0 = 1, math.abs(arg_80_1) do
			if arg_80_1 > 0 then
				self.tableview:insertCellAtIndex(0)
			end
		end
	end

	local var_80_1 = {
		cellsize = cc.size(var_0_36, var_0_37),
		maxcount = var_80_0
	}

	if var_80_1.maxcount < math.ceil(var_0_33 / var_0_37) then
		var_80_1.maxcount = math.ceil(var_0_33 / var_0_37)
	end

	local var_80_2, var_80_3 = GetTableViewShowCellIdx(self.tableview, var_80_1)

	if arg_80_1 > 0 then
		var_80_3 = var_80_3 - arg_80_1
		var_80_2 = var_80_2 - arg_80_1
	end

	print(":::::::startidx, endidx", var_80_2, var_80_3)

	if var_80_2 == 0 then
		self.tableview:reloadData()
	else
		for iter_80_1 = var_80_2, var_80_3 do
			self.tableview:updateCellAtIndex(iter_80_1)
		end
	end
end

function PatrolFightLayer:updateShowAndRunCells()
	local var_81_0 = {
		cellsize = cc.size(var_0_36, var_0_37)
	}
	local var_81_1 = #self.runningPatrolKeys
	local var_81_2

	if #self.runningPatrolKeys > 0 then
		var_81_2 = var_81_1 + 1 or 0
	end

	local var_81_3 = #self.readyCityKeys
	local var_81_4

	if #self.readyCityKeys > 0 then
		var_81_4 = var_81_3 + 1 or 0
	end

	local var_81_5 = var_81_1 > 0 and 1 or 0

	if var_81_3 <= 0 or not (var_81_5 + var_81_1 + 1) then
		-- block empty
	end

	var_81_0.maxcount = var_81_2 + var_81_4

	if var_81_0.maxcount < math.ceil(var_0_33 / var_0_37) then
		var_81_0.maxcount = math.ceil(var_0_33 / var_0_37)
	end

	local var_81_7, var_81_8 = GetTableViewShowCellIdx(self.tableview, var_81_0)

	for iter_81_0 = var_81_7 < var_81_5 and var_81_5 or var_81_7, var_81_5 + var_81_1 - 1 < var_81_8 and var_81_5 + var_81_1 - 1 or var_81_8 do
		self.tableview:updateCellAtIndex(iter_81_0)
	end
end

function PatrolFightLayer:updateShowAndRunCellPanels()
	if not self.cell_panels then
		return
	end

	for iter_82_0, iter_82_1 in pairs(self.cell_panels) do
		if iter_82_1.paneltype == var_0_21 then
			local var_82_0 = iter_82_1:getChildByName("Bnt")
			local var_82_1 = patrol_manager:getPatrolInfo(var_82_0.chapter_key)

			if var_82_1 then
				if var_82_1.time > 0 then
					var_82_0:getChildByName("Label_time"):setString(var_0_26(var_82_1.time))
				elseif var_82_0.patrol_state ~= var_0_19 then
					var_82_0.patrol_state = var_0_19

					var_82_0:updateBntsState()
					var_82_0:getChildByName("Label_time"):setString(" ")
				end
			end
		end
	end
end

function PatrolFightLayer:getPatrolListNums()
	if self.runningPatrolKeys then
		local var_83_0 = #self.runningPatrolKeys or 0
		local var_83_1

		if var_83_0 > 0 then
			var_83_1 = var_83_0 + 1 or 0

			if self.readyCityKeys then
				local var_83_2 = #self.readyCityKeys or 0
				local var_83_3

				if var_83_2 > 0 then
					var_83_3 = var_83_2 + 1 or 0
				end
			end
		end
	end

	return var_83_1 + var_83_3
end
