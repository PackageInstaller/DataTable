ActivityHitMouseLayer = class("ActivityHitMouseLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local Utility = require("common.Utility")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local hitmouse_conf = require("data.hitmouse_conf")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local hitmouse_gamelogic_manager = require("controller.hitmouse_gamelogic_manager")
local var_0_11 = 10

function ActivityHitMouseLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityHitMouseLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityHitMouseLayer:init(arg_3_1)
	self.activityId = arg_3_1.activityId
	self.layerName = "Activity_HitMouse_" .. self.activityId
	self.respath = "Activity_HitMouse_" .. self.activityId .. "/"

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:fullScreen()
	self:registerActivityEventListener()
	self:initTouchEvent()
	hitmouse_gamelogic_manager:registerUIRef(self)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			hitmouse_gamelogic_manager:exitGame()
			activity_manager:releaseEventListenerByName(self.layerName)
			TextureManager:removeLayerTextures({
				self.layerName
			})
		end
	end)

	if arg_3_1.entercallback then
		arg_3_1.entercallback()
	end

	self:updateItemNum()
	self:showGuideLayer()
end

function ActivityHitMouseLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_6_0)
		self:updateItemNum()
	end)
end

function ActivityHitMouseLayer:initUI()
	self.title = self.rootLayer:getChildByName("title")
	self.bottom = self.rootLayer:getChildByName("bottom")
	self.time_bg = self.rootLayer:getChildByName("time_bg")
	self.time_label = ccui.TextBMFont:create(0, "fonts/hitmouse_time_number.fnt")

	self.time_bg:addChild(self.time_label)
	self.time_label:setPosition(self.time_bg:getContentSize().width / 2, self.time_bg:getContentSize().height / 2 + 14)

	self.keyItemBg = self.rootLayer:getChildByName("keyitem_bg")
	self.keyItemLabel = self.rootLayer:getChildByName("keyitem_bg"):getChildByName("keyitem_num")
	self.keyPointLabel = self.rootLayer:getChildByName("keypoint_bg"):getChildByName("keypoint_num")
	self.score_bg = self.rootLayer:getChildByName("score_bg")
	self.score_label = ccui.TextBMFont:create(0, "fonts/hitmouse_score_number.fnt")

	self.score_bg:addChild(self.score_label)
	self.score_label:setPosition(self.score_bg:getContentSize().width / 2 + 35, self.score_bg:getContentSize().height / 2 + 5)

	self.btn_start = self.rootLayer:getChildByName("btn_start")
	self.btn_return = self.bottom:getChildByName("btn_return")
	self.btn_shop = self.bottom:getChildByName("btn_shop")
	self.btn_task = self.bottom:getChildByName("btn_task")

	for iter_7_0 = 1, var_0_11 do
		self["mouse" .. iter_7_0] = self.rootLayer:getChildByName("mouse" .. iter_7_0)

		self["mouse" .. iter_7_0]:setTouchEnabled(false)
		self["mouse" .. iter_7_0]:addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			hitmouse_gamelogic_manager:hit_mouse(iter_7_0)
		end)

		self["hit_mouse_spine" .. iter_7_0] = sp.SkeletonAnimation:create("spine/bakery/qie.json", "spine/bakery/qie.atlas", 1)

		self.rootLayer:addChild(self["hit_mouse_spine" .. iter_7_0])
		self["hit_mouse_spine" .. iter_7_0]:setPosition(self["mouse" .. iter_7_0]:getPosition())
		self["hit_mouse_spine" .. iter_7_0]:setVisible(false)

		self["hit_mouse_spine_error" .. iter_7_0] = sp.SkeletonAnimation:create("spine/bakery/qiemo.json", "spine/bakery/qiemo.atlas", 1)

		self.rootLayer:addChild(self["hit_mouse_spine_error" .. iter_7_0])
		self["hit_mouse_spine_error" .. iter_7_0]:setPosition(self["mouse" .. iter_7_0]:getPosition())
		self["hit_mouse_spine_error" .. iter_7_0]:setVisible(false)
	end
end

function ActivityHitMouseLayer:updateUI(arg_9_1)
	if arg_9_1.time < arg_9_1.limit_time then
		self.time_bg:setVisible(true)
		self.time_label:setString(math.floor(arg_9_1.limit_time - arg_9_1.time))
	else
		self.time_bg:setVisible(false)
	end

	if arg_9_1.score then
		self.score_label:setString(arg_9_1.score)
	end
end

function ActivityHitMouseLayer:gameEnd(arg_10_1)
	global_ShowBlockWords(string.format("游戏结束, 本局得分%s", arg_10_1.key_point_num))
	self.bottom:setVisible(true)
	self.btn_start:setVisible(true)
	self.keyItemBg:setVisible(true)

	for iter_10_0 = 1, var_0_11 do
		self["mouse" .. iter_10_0]:setTouchEnabled(false)
	end

	activity_manager:activity_smallgame_data_report(self.activityId, {
		key_point_num = arg_10_1.key_point_num,
		score = arg_10_1.score,
		gametype = ACTIVITY_SMALLGAME_TYPE_HITMOUSE
	}, function(arg_11_0)
		self:updateItemNum()
	end)
end

function ActivityHitMouseLayer:createNewMouse(arg_12_1)
	self["mouse" .. arg_12_1.index]:setVisible(true)
	self["mouse" .. arg_12_1.index]:loadTexture(self.respath .. "icon" .. arg_12_1.type .. ".png", var_0_0)
end

function ActivityHitMouseLayer:mouseDisappear(arg_13_1, arg_13_2, arg_13_3)
	self["mouse" .. arg_13_1]:setVisible(false)

	if arg_13_2 then
		if arg_13_3 then
			self["hit_mouse_spine" .. arg_13_1]:setVisible(true)
			self["hit_mouse_spine" .. arg_13_1]:setAnimation(0, "qie", true)
			self["hit_mouse_spine" .. arg_13_1]:registerSpineEventHandler(function()
				self["hit_mouse_spine" .. arg_13_1]:setVisible(false)
			end, SP_ANIMATION_COMPLETE)
		else
			self["hit_mouse_spine_error" .. arg_13_1]:setVisible(true)
			self["hit_mouse_spine_error" .. arg_13_1]:setAnimation(0, "qiemo", true)
			self["hit_mouse_spine_error" .. arg_13_1]:registerSpineEventHandler(function()
				self["hit_mouse_spine_error" .. arg_13_1]:setVisible(false)
			end, SP_ANIMATION_COMPLETE)
		end
	end
end

function ActivityHitMouseLayer:registerGameEvent()
	hitmouse_gamelogic_manager:registerGameEvent("UPDATE_UI", self, self.updateUI)
	hitmouse_gamelogic_manager:registerGameEvent("CREATE_NEW_MOUSE", self, self.createNewMouse)
	hitmouse_gamelogic_manager:registerGameEvent("GAME_END", self, self.gameEnd)
	hitmouse_gamelogic_manager:registerGameEvent("MOUSE_DISAPPEAR", self, self.mouseDisappear)
end

function ActivityHitMouseLayer:initTouchEvent()
	self.btn_return:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.btn_shop:addTouchEventListener(function(arg_19_0, arg_19_1)
		local var_19_0

		if arg_19_1 ~= ccui.TouchEventType.ended then
			do return end

			var_19_0 = {}
		end

		var_19_0[1] = "1-" .. tonumber(hitmouse_conf[self.activityId].shop) % 1500000

		LayerManager:switchShowLayer("MarketLayer", {
			singleMarket = var_19_0,
			showType = var_19_0[1]
		})
	end)
	self.btn_task:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityGameTaskLayer", {
			uiconfmodule = "hitmouse",
			activityId = self.activityId
		})
	end)
	self.btn_start:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:activity_smallgame_startgame(self.activityId, {
			gametype = ACTIVITY_SMALLGAME_TYPE_HITMOUSE
		}, function(arg_22_0)
			if arg_22_0.result ~= 1 then
				return
			end

			for iter_22_0 = 1, var_0_11 do
				self["mouse" .. iter_22_0]:setVisible(false)
				self["mouse" .. iter_22_0]:setTouchEnabled(true)
			end

			hitmouse_gamelogic_manager:gameStart()
			self.btn_start:setVisible(false)
			self.keyItemBg:setVisible(false)
			self.time_bg:setVisible(true)
			self:updateItemNum()
			self.bottom:setVisible(false)
		end)
	end)
	self.title:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityHitMouse_" .. self.activityId
		})
	end)
end

function ActivityHitMouseLayer:updateItemNum()
	self.keyItemLabel:setString(item_manager:getItemNumber(hitmouse_conf[self.activityId].key_item))
	self.keyPointLabel:setString(item_manager:getItemNumber(hitmouse_conf[self.activityId].key_point))
end

function ActivityHitMouseLayer:fullScreen()
	self.rootLayer:setPositionY(self.rootLayer:getPositionY() - GameDisplay.fix_y * 0.4)
	self.title:setPositionY(self.title:getPositionY() - 100 + GameDisplay.fix_y)
	self.bottom:setPositionY(self.bottom:getPositionY() + 110 - 0.6 * GameDisplay.fix_y)
end

function ActivityHitMouseLayer:showGuideLayer()
	if RoleDefault:getInstance():getBoolForKey("HitMouseGuide_" .. self.activityId, false) then
		return
	end

	RoleDefault:getInstance():setBoolForKey("HitMouseGuide_" .. self.activityId, true)

	local var_26_0 = ccui.Layout:create()

	var_26_0:setContentSize(cc.size(640, 1600))
	var_26_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_26_0:setCascadeOpacityEnabled(false)
	var_26_0:setBackGroundColorOpacity(180)
	var_26_0:setAnchorPoint(0.5, 0.5)
	var_26_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_26_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_26_0:setTouchEnabled(true)
	var_26_0:setLocalZOrder(1000)
	var_26_0:setVisible(true)
	self.rootLayer:addChild(var_26_0)

	self.guide_index = 1

	local var_26_1 = 3

	for iter_26_0 = 1, 3 do
		local var_26_2 = ccui.ImageView:create(self.respath .. "tip" .. iter_26_0 .. ".png", var_0_0)

		var_26_0:addChild(var_26_2)
		var_26_2:setPosition(320, 800)
		var_26_2:setName("tip_" .. iter_26_0)
		var_26_2:setVisible(false)
	end

	var_26_0:getChildByName("tip_1"):setVisible(true)
	var_26_0:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.guide_index < var_26_1 then
			var_26_0:getChildByName("tip_" .. self.guide_index):setVisible(false)

			self.guide_index = self.guide_index + 1

			var_26_0:getChildByName("tip_" .. self.guide_index):setVisible(true)
		elseif self.guide_index >= var_26_1 then
			var_26_0:setVisible(false)
		end
	end)
end
