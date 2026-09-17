ActivityCalculateLayer = class("ActivityCalculateLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local Utility = require("common.Utility")
local item_data = require("data.item_data")
local musicialnote_conf = require("data.musicialnote_conf")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local calculate_gamelogic_manager = require("controller.calculate_gamelogic_manager")
local var_0_9 = {
	110,
	320,
	530
}
local var_0_10 = 180
local var_0_11 = 1
local var_0_12 = 2
local var_0_13 = 3
local var_0_14 = 4
local var_0_15 = require("view.Layer.ObjectPool"):new()

function var_0_15:getObjectByMyType(arg_2_1, arg_2_2)
	print("objectPool:getObjectByMyType     ", arg_2_1)

	local var_2_0 = self:getObject(arg_2_1)

	if var_2_0 then
		local var_2_1 = math.random(3)

		if arg_2_1 == var_0_11 then
			var_2_0:loadTexture(arg_2_2 .. "add" .. var_2_1 .. ".png", var_0_0)
		elseif arg_2_1 == var_0_12 then
			var_2_0:loadTexture(arg_2_2 .. "sub" .. var_2_1 .. ".png", var_0_0)
		end

		return var_2_0
	else
		local var_2_2 = math.random(3)

		if arg_2_1 == var_0_11 then
			var_2_0 = ccui.ImageView:create(arg_2_2 .. "add" .. var_2_2 .. ".png", var_0_0)

			local var_2_3 = ccui.ImageView:create(arg_2_2 .. "value_bg.png", var_0_0)

			var_2_3:setAnchorPoint(0.5, 0)
			var_2_0:addChild(var_2_3)
			var_2_3:setPosition(var_2_0:getContentSize().width / 2, var_2_0:getContentSize().height)

			local var_2_4 = cc.Label:createWithTTF("+1", FONT_NAME, 32)

			var_2_3:addChild(var_2_4)
			var_2_4:setPosition(var_2_3:getContentSize().width / 2, var_2_3:getContentSize().height / 2)

			var_2_0.value = var_2_4
		elseif arg_2_1 == var_0_12 then
			var_2_0 = ccui.ImageView:create(arg_2_2 .. "sub" .. var_2_2 .. ".png", var_0_0)

			local var_2_5 = ccui.ImageView:create(arg_2_2 .. "value_bg.png", var_0_0)

			var_2_5:setAnchorPoint(0.5, 0)
			var_2_0:addChild(var_2_5)
			var_2_5:setPosition(var_2_0:getContentSize().width / 2, var_2_0:getContentSize().height)

			local var_2_6 = cc.Label:createWithTTF("-1", FONT_NAME, 32)

			var_2_5:addChild(var_2_6)
			var_2_6:setPosition(var_2_5:getContentSize().width / 2, var_2_5:getContentSize().height / 2)

			var_2_0.value = var_2_6
		elseif arg_2_1 == var_0_13 then
			var_2_0 = ccui.ImageView:create(arg_2_2 .. "mult_bg.png", var_0_0)

			local var_2_7 = cc.Label:createWithTTF("X1", FONT_NAME, 58)

			var_2_0:addChild(var_2_7)
			var_2_7:setPosition(var_2_0:getContentSize().width / 2, var_2_0:getContentSize().height / 2)

			var_2_0.value = var_2_7
		elseif arg_2_1 == var_0_14 then
			var_2_0 = ccui.ImageView:create(arg_2_2 .. "div_bg.png", var_0_0)

			local var_2_8 = cc.Label:createWithTTF("÷1", FONT_NAME, 58)

			var_2_0:addChild(var_2_8)
			var_2_8:setPosition(var_2_0:getContentSize().width / 2, var_2_0:getContentSize().height / 2)

			var_2_0.value = var_2_8
		end

		var_2_0.type = arg_2_1

		self:createObject(var_2_0)
	end

	return self:getObject(arg_2_1)
end

function var_0_15:clearAllActiveObject()
	for iter_3_0, iter_3_1 in pairs(self.activePool) do
		iter_3_1.isActive = false

		iter_3_1:setVisible(false)
	end

	self.activePool = {}
end

function ActivityCalculateLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = ActivityCalculateLayer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function ActivityCalculateLayer:init(arg_5_1)
	self.activityId = arg_5_1.activityId
	self.layerName = "ActivityCalculateLayer_" .. self.activityId
	self.respath = "ActivityCalculateLayer_" .. self.activityId .. "/"

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:initTouchPanel()
	self:registerActivityEventListener()
	self:initTouchEvent()
	calculate_gamelogic_manager:registerUIRef(self)
	self:registerGameEvent()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)
			TextureManager:removeLayerTextures({
				self.layerName
			})
			calculate_gamelogic_manager:exitGame()
		end
	end)
	self:fullScreen()
end

function ActivityCalculateLayer.registerActivityEventListener(arg_7_0)
	return
end

function ActivityCalculateLayer:initTouchEvent()
	self.title:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityCalculateLayer_" .. self.activityId
		})
	end)
	self.return_btn:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.task_btn:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityGameTaskLayer", {
			uiconfmodule = "calculate",
			activityId = self.activityId
		})
	end)
	self.start_btn:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		calculate_gamelogic_manager:gameStart()
		self.start_btn:setVisible(false)
		self.hpline:setVisible(true)
		self.hpLabel:setVisible(true)

		self.mainIconMoving = false

		self.main_icon:stopAllActions()
		self.main_icon:setPositionX(320)
	end)
end

function ActivityCalculateLayer.registerGameEvent(arg_13_0)
	calculate_gamelogic_manager:registerGameEvent("CHANNEL_ADD_OBSTACLE", arg_13_0, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_13_0.objPool:getObjectByMyType(arg_14_1.obstacle.type, arg_13_0.respath)

		if not var_14_0:getParent() then
			arg_13_0.rootLayer:addChild(var_14_0, 2)
		end

		var_14_0:setPosition(var_0_9[arg_14_1.index], arg_14_1.obstacle.height)

		arg_14_1.obstacle.node = var_14_0

		if arg_14_1.obstacle.type == var_0_11 then
			var_14_0.value:setString("+" .. arg_14_1.obstacle.value)
		elseif arg_14_1.obstacle.type == var_0_12 then
			var_14_0.value:setString("-" .. arg_14_1.obstacle.value)
		elseif arg_14_1.obstacle.type == var_0_13 then
			var_14_0.value:setString("X" .. arg_14_1.obstacle.value)
		elseif arg_14_1.obstacle.type == var_0_14 then
			var_14_0.value:setString("÷" .. arg_14_1.obstacle.value)
		end
	end)
	calculate_gamelogic_manager:registerGameEvent("DELETE_OBSTACLE", arg_13_0, function(arg_15_0, arg_15_1)
		arg_13_0.objPool:recycleObject(arg_15_1.node)
	end)
	calculate_gamelogic_manager:registerGameEvent("MAINICON_MOVE", arg_13_0, function(arg_16_0, arg_16_1)
		arg_13_0.mainIconMoving = true

		arg_13_0.main_icon:stopAllActions()
		arg_13_0.main_icon:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(var_0_9[arg_16_1.channel], var_0_10)), cc.CallFunc:create(function()
			arg_13_0.mainIconMoving = false
		end)))
	end)
	calculate_gamelogic_manager:registerGameEvent("GAME_END", arg_13_0, function(arg_18_0, arg_18_1)
		global_ShowBlockWords("游戏结束！前进距离为:" .. math.floor(arg_18_1.distance_score * 10) / 10 .. " m")
		arg_13_0.hpLabel:setString("0")
		arg_13_0.objPool:clearAllActiveObject()
		activity_manager:activity_smallgame_data_report(arg_13_0.activityId, {
			score = math.floor(arg_18_1.distance_score),
			gametype = ACTIVITY_SMALLGAME_TYPE_CALCULATE
		})
		arg_13_0.hpline:setVisible(false)
		arg_13_0.hpLabel:setVisible(false)
		arg_13_0.start_btn:setVisible(true)
	end)
	calculate_gamelogic_manager:registerGameEvent("UPDATE_GAMEDATA", arg_13_0, function(arg_19_0, arg_19_1)
		if arg_19_1.distance_score then
			arg_13_0.score_label:setString(math.floor(arg_19_1.distance_score * 10) / 10 .. " m")
		end

		if arg_19_1.hp_score then
			arg_13_0.hpLabel:setString(math.floor(arg_19_1.hp_score))
		end
	end)
end

function ActivityCalculateLayer:initUI()
	self.title = self.rootLayer:getChildByName("title")
	self.score_bg = self.rootLayer:getChildByName("score_bg")
	self.score_label = self.score_bg:getChildByName("score_label")
	self.task_btn = self.rootLayer:getChildByName("btn_task")
	self.return_btn = self.rootLayer:getChildByName("btn_return")
	self.start_btn = self.rootLayer:getChildByName("btn_start")
	self.hpline = self.rootLayer:getChildByName("hpline")
	self.hpLabel = self.rootLayer:getChildByName("hpLabel")

	self.hpline:setVisible(false)
	self.hpLabel:setVisible(false)

	self.main_icon = ccui.ImageView:create(self.respath .. "main_icon.png", var_0_0)

	self.rootLayer:addChild(self.main_icon, 3)
	self.main_icon:setPosition(320, var_0_10)

	self.objPool = var_0_15:new()
end

function ActivityCalculateLayer:initTouchPanel()
	local var_21_0 = ccui.Layout:create()

	var_21_0:setContentSize(cc.size(640, 800))
	var_21_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_21_0:setCascadeOpacityEnabled(false)
	var_21_0:setBackGroundColorOpacity(0)
	var_21_0:setAnchorPoint(0.5, 0.5)
	var_21_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_21_0:setPosition(320, 500)
	var_21_0:setTouchEnabled(false)
	var_21_0:setVisible(true)

	self.touchPanel = var_21_0

	self.rootLayer:addChild(self.touchPanel, 10)

	local var_21_1 = cc.EventListenerTouchOneByOne:create()

	var_21_1:setSwallowTouches(false)
	var_21_1:registerScriptHandler(function(arg_22_0, arg_22_1)
		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_21_1:registerScriptHandler(function(arg_23_0, arg_23_1)
		return
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_21_1:registerScriptHandler(function(arg_24_0, arg_24_1)
		if self.mainIconMoving then
			print("isMoving!")

			return
		end

		local var_24_0 = arg_24_0:getLocation().x - arg_24_0:getStartLocation().x

		if math.abs(var_24_0) > 100 then
			calculate_gamelogic_manager:TouchMoveEnd(var_24_0)
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_21_1:registerScriptHandler(function(arg_25_0, arg_25_1)
		return
	end, cc.Handler.EVENT_TOUCH_CANCELLED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_21_1, self.touchPanel)
end

function ActivityCalculateLayer:fullScreen()
	self.title:setPositionY(self.title:getPositionY() + 0.8 * GameDisplay.fix_y)
	self.score_bg:setPositionY(self.score_bg:getPositionY() + 0.8 * GameDisplay.fix_y)
	self.return_btn:setPositionY(self.return_btn:getPositionY() - 0.9 * GameDisplay.fix_y)
	self.task_btn:setPositionY(self.task_btn:getPositionY() - 0.9 * GameDisplay.fix_y)
	self.hpline:setPositionY(self.hpline:getPositionY() - 0.8 * GameDisplay.fix_y)
	self.hpLabel:setPositionY(self.hpLabel:getPositionY() - 0.8 * GameDisplay.fix_y)
end

function ActivityCalculateLayer:initTest()
	calculate_gamelogic_manager:registerUIRef(self)
	calculate_gamelogic_manager:gameStart()
	self:registerScriptHandler(function(arg_28_0)
		if arg_28_0 == "exit" then
			calculate_gamelogic_manager:exitGame()
		end
	end)
end
