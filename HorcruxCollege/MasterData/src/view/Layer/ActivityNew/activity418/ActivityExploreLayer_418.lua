ActivityExploreLayer_418 = class("ActivityExploreLayer_418", function()
	return cc.Layer:create()
end)

local time_check_manager = require("controller.time_check_manager")
local explore_manager = require("controller.explore_manager")
local activity_manager = require("controller.activity_manager")
local var_0_3 = config._DEBUG and 0 or 1

function ActivityExploreLayer_418.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityExploreLayer_418.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityExploreLayer_418:init(arg_3_1)
	arg_3_1 = arg_3_1 or {}
	self.finishtime = arg_3_1.finishtime or global_get_time_by_date("2023-01-31 23:59:59")
	self.activityid = arg_3_1.activityid or 132
	self.activityExploreData = activity_manager:getActivityExploreConfData(self.activityid)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityExplore_418.json" or "ActivityExplore_418.ExportJson")

	self:addChild(self.rootLayer)
	self:initBaseUI()
	self:fullScreen()
	self:playEntranceAni()
	activity_manager:get_activity_explore(self.activityid, function(arg_4_0)
		if arg_4_0.result == 1 then
			self.step_level = arg_4_0.finish_step
		end

		self:updateUI()
	end)
end

function ActivityExploreLayer_418:initBaseUI()
	self.title = ccui.Helper:seekWidgetByName(self.rootLayer, "title")
	self.returnBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_return")
	self.chapterNodes = {}

	for iter_5_0 = 1, 5 do
		self.chapterNodes[iter_5_0] = ccui.Helper:seekWidgetByName(self.rootLayer, "explore_" .. iter_5_0)
		self.chapterNodes[iter_5_0].updateNode = function(arg_6_0, arg_6_1)
			local var_6_0, var_6_1 = self:isChapterUnlock(iter_5_0)
			local var_6_3 = self.chapterNodes[iter_5_0]:getChildByName("time1")
			local var_6_4 = self.chapterNodes[iter_5_0]:getChildByName("time2")
			local var_6_5 = self.chapterNodes[iter_5_0]:getChildByName("name")

			var_6_4:setVisible(false)
			var_6_3:setVisible(false)
			var_6_5:setVisible(false)

			if var_6_0 then
				var_6_5:setVisible(true)
				self.chapterNodes[iter_5_0]:loadTexture("ActivityExplore_418/stage_bg_on.png", var_0_3)
			else
				self.chapterNodes[iter_5_0]:loadTexture("ActivityExplore_418/stage_bg_off.png", var_0_3)
				var_6_3:setVisible(true)
				var_6_4:setVisible(true)

				if var_6_1 == "time" then
					var_6_4:setString(self.activityExploreData[iter_5_0].starttime .. "开启")
				elseif var_6_1 == "level" then
					var_6_4:setString(ANNIVERSARY_EXPLORE_ERROR[var_6_1])
				end
			end
		end
	end

	self.title:setTouchEnabled(true)
	self.title:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "Activity_explore_210"
		})
	end)
	self:registerBtnsTouchEvent()
end

function ActivityExploreLayer_418:fullScreen()
	self.title:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 1136 - self.title:getPositionY(), TRANSFORM_UNIT.PX))
	self.returnBtn:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.returnBtn:getPositionY(), TRANSFORM_UNIT.PX))
end

function ActivityExploreLayer_418:playEntranceAni()
	self.returnBtn:setPositionX(700)
	self.returnBtn:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-20, self.returnBtn:getPositionY())), cc.MoveTo:create(0.1, cc.p(115, self.returnBtn:getPositionY())), cc.MoveTo:create(0.1, cc.p(105, self.returnBtn:getPositionY()))))

	for iter_9_0 = 1, #self.chapterNodes - 1 do
		self.chapterNodes[iter_9_0]:getChildByName("line"):setOpacity(0)
	end

	self.chapterNodes[1]:setPositionX(640 + self.chapterNodes[1]:getPositionY())
	self.chapterNodes[2]:setPositionX(0 - self.chapterNodes[1]:getPositionY())
	self.chapterNodes[3]:setPositionX(640 + self.chapterNodes[1]:getPositionY())
	self.chapterNodes[4]:setPositionX(0 - self.chapterNodes[1]:getPositionY())
	self.chapterNodes[5]:setPositionX(640 + self.chapterNodes[1]:getPositionY())
	self.chapterNodes[1]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(500, self.chapterNodes[1]:getPositionY())), cc.MoveTo:create(0.1, cc.p(480, self.chapterNodes[1]:getPositionY())), cc.MoveTo:create(0.1, cc.p(490, self.chapterNodes[1]:getPositionY()))))
	self.chapterNodes[2]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(143, self.chapterNodes[2]:getPositionY())), cc.MoveTo:create(0.1, cc.p(123, self.chapterNodes[2]:getPositionY())), cc.MoveTo:create(0.1, cc.p(133, self.chapterNodes[2]:getPositionY()))))
	self.chapterNodes[3]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(500, self.chapterNodes[3]:getPositionY())), cc.MoveTo:create(0.1, cc.p(480, self.chapterNodes[3]:getPositionY())), cc.MoveTo:create(0.1, cc.p(490, self.chapterNodes[3]:getPositionY()))))
	self.chapterNodes[4]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(143, self.chapterNodes[4]:getPositionY())), cc.MoveTo:create(0.1, cc.p(123, self.chapterNodes[4]:getPositionY())), cc.MoveTo:create(0.1, cc.p(133, self.chapterNodes[4]:getPositionY()))))
	self.chapterNodes[5]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(500, self.chapterNodes[5]:getPositionY())), cc.MoveTo:create(0.1, cc.p(480, self.chapterNodes[5]:getPositionY())), cc.MoveTo:create(0.1, cc.p(490, self.chapterNodes[5]:getPositionY()))))

	for iter_9_1 = 1, #self.chapterNodes - 1 do
		self.chapterNodes[iter_9_1]:getChildByName("line"):runAction(cc.Sequence:create(cc.DelayTime:create(0.6 + (iter_9_1 - 1) * 0.2), cc.FadeIn:create(0.2)))
	end
end

function ActivityExploreLayer_418:registerBtnsTouchEvent()
	self.title:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityExploreLayer_418"
		})
	end)
	self.returnBtn:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:playExitAni(function()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end)

	for iter_10_0 = 1, 5 do
		self.chapterNodes[iter_10_0]:setTouchEnabled(true)
		self.chapterNodes[iter_10_0]:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_14_0, var_14_1 = self:isChapterUnlock(iter_10_0)

			if var_14_0 then
				self:gotoExplore(iter_10_0, touchcallback)
			else
				global_ShowBlockWords(ANNIVERSARY_EXPLORE_ERROR[var_14_1])
			end
		end)
	end
end

function ActivityExploreLayer_418:getLeftTimeStr()
	local var_15_0 = self.finishtime - time_check_manager:getCurTime()

	if var_15_0 >= 86400 then
		return string.format("%02d天%02d小时", math.floor(var_15_0 / 86400), math.floor(var_15_0 % 86400 / 3600))
	elseif var_15_0 >= 3600 then
		return string.format("%02d小时%02d分钟", math.floor(var_15_0 / 3600), math.floor(var_15_0 % 3600 / 60))
	else
		return string.format("%02d分钟%02d秒", math.floor(var_15_0 / 60), math.floor(var_15_0 % 60))
	end
end

function ActivityExploreLayer_418:updateUI()
	for iter_16_0 = 1, 5 do
		self.chapterNodes[iter_16_0]:updateNode(msg)
	end
end

function ActivityExploreLayer_418:isChapterUnlock(arg_17_1)
	if self.activityExploreData[arg_17_1].starttime and time_check_manager:getCurTime() < global_get_time_by_date(self.activityExploreData[arg_17_1].starttime) then
		return false, "time"
	end

	if self.activityExploreData[arg_17_1].id > self.step_level + 1 then
		return false, "level"
	end

	return true
end

function ActivityExploreLayer_418:gotoExplore(arg_18_1)
	explore_manager:begin_explore({
		type = "activity",
		returnLayer = "ActivityExploreLayer_418",
		activity_explore_id = self.activityExploreData[arg_18_1].id,
		activityid = self.activityid,
		cancelCallback = function(arg_19_0)
			print(dump(arg_19_0))

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

function ActivityExploreLayer_418:playExitAni(arg_20_1)
	self.isShowEffect = true

	self.returnBtn:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(50, 0)), cc.MoveBy:create(0.05, cc.p(-250, 0)), cc.CallFunc:create(function()
		if arg_20_1 then
			arg_20_1()
		end

		self.isShowEffect = nil
	end)))
end
