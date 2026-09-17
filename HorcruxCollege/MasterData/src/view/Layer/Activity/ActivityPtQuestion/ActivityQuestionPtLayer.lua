ActivityQuestionPtLayer = class("ActivityQuestionPtLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = 0.2
local activity_manager = require("controller.activity_manager")

function ActivityQuestionPtLayer.create(arg_2_0)
	local var_2_0 = ActivityQuestionPtLayer.new()

	var_2_0:init()

	return var_2_0
end

function ActivityQuestionPtLayer:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityQuestionPtLayer.json" or "ActivityQuestionPtLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initTitle()
	self:initBottomList()
	self:initBtnTouchEventListener()
	self:playJoinInEffect()
	self:fullScreen()
	self:updateAllert()
	self:checkFirstJoinInTask()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function ActivityQuestionPtLayer:initTitle()
	require("view.Sprite.TitleSprite")

	self.title = TitleSprite:create("", 1, "ActivityQuestionPtLayer/title.png")

	self.title:setAnchorPoint(cc.p(0, 1))
	self.rootLayer:addChild(self.title, 5)

	local activity_conf_data = require("data.activity_conf_data")
	local var_5_1 = self.rootLayer:getChildByName("lbl_time")

	var_5_1:setAnchorPoint(cc.p(0, 0.5))
	var_5_1:setString(var_5_1:getString() .. string.sub(activity_conf_data[18].starttime, 1, 10) .. " 至 " .. string.sub(activity_conf_data[18].finishtime, 1, 10))
end

function ActivityQuestionPtLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)

	self.bottomList:setName("bottomlist")
	self.rootLayer:addChild(self.bottomList, 2)
end

function ActivityQuestionPtLayer:initBtnTouchEventListener()
	self.btnQuestion = self.rootLayer:getChildByName("btn_question")

	self.btnQuestion:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopAnswerQuestionLayer")
	end)

	self.btnPt = self.rootLayer:getChildByName("btn_pt")

	self.btnPt:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("ActivityQuestionPointLayer")
	end)

	self.btnTask = self.rootLayer:getChildByName("btn_task")

	self.btnTask:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("ActivityQuestionPtTaskLayer")
	end)

	self.btnShop = self.rootLayer:getChildByName("btn_shop")

	self.btnShop:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_12_0 = cc.EventCustom:new("switchShowLayer")

		var_12_0.layerName = "MarketLayer"
		var_12_0.initparam = {
			singleMarket = "1-1801",
			returnLayer = "ActivityQuestionPtLayer"
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_12_0)
	end)
end

function ActivityQuestionPtLayer:fullScreen()
	self.title:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - GameDisplay.fix_y))
	self.rootLayer:getChildByName("lbl_time"):setPosition(cc.p(30, self.title:getPositionY() - 100))
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end

function ActivityQuestionPtLayer:playJoinInEffect()
	self.btnQuestion:setPositionX(self.btnQuestion:getPositionX() - 640)
	self.btnQuestion:runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(640, 0))))
	self.btnTask:setPositionX(self.btnTask:getPositionX() - 640)
	self.btnTask:runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(640, 0))))
	self.btnPt:setPositionX(self.btnPt:getPositionX() + 640)
	self.btnPt:runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(-640, 0))))
	self.btnShop:setPositionX(self.btnShop:getPositionX() + 640)
	self.btnShop:runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(-640, 0))))
end

function ActivityQuestionPtLayer:updateAllert()
	if activity_manager:getAlertStatus(18, "proceed") then
		global_add_alert_tag(self.btnPt, {
			x = 38,
			y = 205
		})
	else
		global_remove_alert_tag(self.btnPt)
	end

	if activity_manager:getAlertStatus(18, "task") then
		global_add_alert_tag(self.btnTask, {
			x = 600,
			y = 230
		})
	else
		global_remove_alert_tag(self.btnTask)
	end
end

function ActivityQuestionPtLayer:playGoOutEffect(arg_16_1)
	self.btnQuestion:runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(-640, 0))))
	self.btnTask:runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(-640, 0))))
	self.btnPt:runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(640, 0))))
	self.btnShop:runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(640, 0))))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(var_0_0 * 0.5), cc.CallFunc:create(function()
		if arg_16_1 then
			arg_16_1()
		end
	end)))
end

function ActivityQuestionPtLayer.checkFirstJoinInTask(arg_18_0)
	if RoleDefault:getInstance():getBoolForKey("isFirstJoinQuestion") ~= true then
		global_basic_scene:addChild(TalkLayer:create(3240001, nil, 1, ""))
		RoleDefault:getInstance():setBoolForKey("isFirstJoinQuestion", true)
	end
end

function ActivityQuestionPtLayer:exit()
	self:playGoOutEffect(function()
		LayerManager:switchReturnLayer("MainLayer")
	end)
end
