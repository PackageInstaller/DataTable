ActivityExploreDefaultLayer = class("ActivityExploreDefaultLayer", function()
	return cc.Layer:create()
end)

local var_0_0
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local explore_manager = require("controller.explore_manager")
local var_0_4 = config._DEBUG and 0 or 1

function ActivityExploreDefaultLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityExploreDefaultLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityExploreDefaultLayer:init(arg_3_1)
	arg_3_1 = arg_3_1 or {}
	self.activityid = arg_3_1.activityid or 132
	self.finishtime = activity_manager:getExploreFinishTime(self.activityid)

	TextureManager:loadLayerTextures({
		"ActivityExplore_" .. self.activityid
	})

	self.bg = ccui.ImageView:create("mainScenebg/activity/branch" .. self.activityid .. "/Activity_Explore.png")

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg, -1)

	self.activityExploreData = activity_manager:getActivityExploreConfData(self.activityid)

	print(self.activityid)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and ("ActivityExplore_" .. self.activityid .. ".json" or "ActivityExplore_" .. self.activityid .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initBaseUI()
	self:playEntranceAni()
	activity_manager:get_activity_explore(self.activityid, function(arg_4_0)
		if arg_4_0.result == 1 then
			self.step_level = arg_4_0.finish_step
		end

		activity_manager:update_alert(self.activityid, "freeexplorer", arg_4_0)
		self:updateUI()
	end)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_0 = self.activityid

			TextureManager:removeLayerTextures({
				self.layerName
			})
		end
	end)
end

function ActivityExploreDefaultLayer:initBaseUI()
	self.title = ccui.Helper:seekWidgetByName(self.rootLayer, "title")
	self.timeLabel = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time")
	self.returnBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_return")
	self.chapterNodes = {}

	while ccui.Helper:seekWidgetByName(self.rootLayer, "explore_" .. 1) do
		self.chapterNodes[1] = ccui.Helper:seekWidgetByName(self.rootLayer, "explore_" .. 1)
		self.chapterNodes[1].updateNode = function(arg_7_0, arg_7_1, arg_7_2)
			local var_7_0, var_7_1 = self:isChapterUnlock(arg_7_2)
			local var_7_3 = self.chapterNodes[arg_7_2]:getChildByName("time1")
			local var_7_4 = self.chapterNodes[arg_7_2]:getChildByName("time2")
			local var_7_5 = self.chapterNodes[arg_7_2]:getChildByName("name")
			local var_7_6 = self.chapterNodes[arg_7_2]:getChildByName("line")

			if var_7_6 then
				var_7_6:setLocalZOrder(-1)
			end

			var_7_4:setVisible(false)
			var_7_3:setVisible(false)
			var_7_5:setVisible(false)

			if var_7_0 then
				var_7_5:setVisible(true)
				self.chapterNodes[arg_7_2]:loadTexture("ActivityExplore_" .. self.activityid .. "/stage_bg_on.png", var_0_4)
			else
				self.chapterNodes[arg_7_2]:loadTexture("ActivityExplore_" .. self.activityid .. "/stage_bg_off.png", var_0_4)
				var_7_3:setVisible(true)
				var_7_4:setVisible(true)

				if var_7_1 == "time" then
					var_7_4:setString(split(self.activityExploreData[arg_7_2].starttime, " ")[1] .. "开启")
				elseif var_7_1 == "level" then
					var_7_4:setString(ANNIVERSARY_EXPLORE_ERROR[var_7_1])
				end
			end
		end
	end

	if self.timeLabel then
		self.timeLabel:setString(self:getLeftTimeStr())
		self.timeLabel:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 1136 - self.timeLabel:getPositionY(), TRANSFORM_UNIT.PX))
	end

	self:registerBtnsTouchEvent()
	self.title:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 1136 - self.title:getPositionY(), TRANSFORM_UNIT.PX))
	self.returnBtn:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.returnBtn:getPositionY(), TRANSFORM_UNIT.PX))
end

function ActivityExploreDefaultLayer:playEntranceAni()
	self.returnBtn:setPositionX(700)
	self.returnBtn:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-20, self.returnBtn:getPositionY())), cc.MoveTo:create(0.1, cc.p(115, self.returnBtn:getPositionY())), cc.MoveTo:create(0.1, cc.p(105, self.returnBtn:getPositionY()))))

	local var_8_0 = 1

	while self.chapterNodes[var_8_0] do
		local var_8_1 = var_8_0 % 2 == 0 and -2 * self.chapterNodes[var_8_0]:getPositionY() or 640
		local var_8_2 = self.chapterNodes[var_8_0]:getPositionX()

		self.chapterNodes[var_8_0]:setPositionX(var_8_1 + self.chapterNodes[var_8_0]:getPositionX())
		self.chapterNodes[var_8_0]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(var_8_2 + 10, self.chapterNodes[var_8_0]:getPositionY())), cc.MoveTo:create(0.1, cc.p(var_8_2 - 10, self.chapterNodes[var_8_0]:getPositionY())), cc.MoveTo:create(0.1, cc.p(var_8_2, self.chapterNodes[var_8_0]:getPositionY()))))

		var_8_0 = var_8_0 + 1
	end
end

function ActivityExploreDefaultLayer:registerBtnsTouchEvent()
	self.title:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityExplore_" .. self.activityid
		})
	end)
	self.returnBtn:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:playExitAni(function()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end)

	for iter_9_0 = 1, 100 do
		if not self.chapterNodes[iter_9_0] then
			break
		end

		self.chapterNodes[iter_9_0]:setTouchEnabled(true)
		self.chapterNodes[iter_9_0]:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_13_0, var_13_1 = self:isChapterUnlock(iter_9_0)

			if var_13_0 then
				self:gotoExplore(iter_9_0, touchcallback)
			else
				global_ShowBlockWords(ANNIVERSARY_EXPLORE_ERROR[var_13_1])
			end
		end)
		self.chapterNodes[iter_9_0]:getChildByName("name"):setTouchEnabled(true)
		self.chapterNodes[iter_9_0]:getChildByName("name"):addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_14_0, var_14_1 = self:isChapterUnlock(iter_9_0)

			if var_14_0 then
				self:gotoExplore(iter_9_0, touchcallback)
			else
				global_ShowBlockWords(ANNIVERSARY_EXPLORE_ERROR[var_14_1])
			end
		end)
	end
end

function ActivityExploreDefaultLayer:getLeftTimeStr()
	local var_15_0 = self.finishtime - time_check_manager:getCurTime()

	if var_15_0 >= 86400 then
		return string.format("%02d天%02d小时", math.floor(var_15_0 / 86400), math.floor(var_15_0 % 86400 / 3600))
	elseif var_15_0 >= 3600 then
		return string.format("%02d小时%02d分钟", math.floor(var_15_0 / 3600), math.floor(var_15_0 % 3600 / 60))
	else
		return string.format("%02d分钟%02d秒", math.floor(var_15_0 / 60), math.floor(var_15_0 % 60))
	end
end

function ActivityExploreDefaultLayer:updateUI()
	while self.chapterNodes[1] do
		self.chapterNodes[1]:updateNode(msg, 1)
	end
end

function ActivityExploreDefaultLayer:isChapterUnlock(arg_17_1)
	print(arg_17_1)

	if self.activityExploreData[arg_17_1].starttime and time_check_manager:getCurTime() < global_get_time_by_date(self.activityExploreData[arg_17_1].starttime) then
		return false, "time"
	end

	if self.activityExploreData[arg_17_1].id > self.step_level + 1 then
		return false, "level"
	end

	return true
end

function ActivityExploreDefaultLayer:gotoExplore(arg_18_1)
	explore_manager:begin_explore({
		type = "activity",
		returnLayer = "ActivityExploreDefaultLayer",
		activity_explore_id = self.activityExploreData[arg_18_1].id,
		activityid = self.activityid,
		cancelCallback = function(arg_19_0)
			if arg_19_0 == 2 then
				global_ShowBlockWords("活动已关闭")
			elseif arg_19_0 == 3 then
				global_ShowBlockWords("活动关卡已全部完成!")
			elseif arg_19_0 == 4 then
				global_ShowBlockWords("该活动关卡已完成")
			elseif arg_19_0 == 5 then
				global_ShowBlockWords("服务端客户端数据不同步！")
			elseif arg_19_0 == 0 then
				global_ShowBlockWords("活动探险未开放")
			end
		end
	})
end

function ActivityExploreDefaultLayer:playExitAni(arg_20_1)
	self.isShowEffect = true

	self.returnBtn:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(50, 0)), cc.MoveBy:create(0.05, cc.p(-250, 0)), cc.CallFunc:create(function()
		if arg_20_1 then
			arg_20_1()
		end

		self.isShowEffect = nil
	end)))
end
