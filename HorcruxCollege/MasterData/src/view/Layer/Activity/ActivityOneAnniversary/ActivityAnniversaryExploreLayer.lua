ActivityAnniversaryExploreLayer = class("ActivityAnniversaryExploreLayer", function()
	return cc.Layer:create()
end)

local time_check_manager = require("controller.time_check_manager")
local explore_manager = require("controller.explore_manager")

function ActivityAnniversaryExploreLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityAnniversaryExploreLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityAnniversaryExploreLayer:init(arg_3_1)
	arg_3_1 = arg_3_1 or {}
	self.finishtime = arg_3_1.finishtime or global_get_time_by_date("2021-09-18 00:00:00")
	self.activityid = arg_3_1.activityid or 132
	self.activityExploreData = ActivityAnniversaryManager:getActivityExploreConfData()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityAnniversaryExploreLayer.json" or "ActivityAnniversaryExploreLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initBaseUI()
	self:fullScreen()
	self:playEntranceAni()
	ActivityAnniversaryManager:get_explore_level_config(self.activityid, function(arg_4_0)
		if arg_4_0.result == 1 then
			self.step_level = arg_4_0.finish_step
		end

		self:updateUI()
	end)
end

function ActivityAnniversaryExploreLayer:initBaseUI()
	self.title = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_title")
	self.timeLabel = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time")
	self.returnBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return")
	self.chapterNodes = {}

	for iter_5_0 = 1, 3 do
		self.chapterNodes[iter_5_0] = ccui.Helper:seekWidgetByName(self.rootLayer, "chapter" .. iter_5_0)
		self.chapterNodes[iter_5_0].updateNode = function(self, arg_6_1)
			local var_6_0, var_6_1 = self:isChapterUnlock(iter_5_0)
			local var_6_2 = self.activityExploreData[iter_5_0].id <= self.step_level
			local var_6_3 = self:getChildByName("mark")
			local var_6_4 = var_6_3:getChildByName("passed")
			local var_6_5 = var_6_3:getChildByName("lock")
			local var_6_6 = var_6_3:getChildByName("Label_des")

			var_6_3:setVisible(false)
			var_6_4:setVisible(false)
			var_6_5:setVisible(false)
			var_6_6:setVisible(false)

			if var_6_0 then
				if var_6_2 then
					var_6_3:setVisible(true)
					var_6_4:setVisible(true)
				end
			else
				var_6_3:setVisible(true)
				var_6_5:setVisible(true)
				var_6_6:setVisible(true)

				if var_6_1 == "time" then
					var_6_6:setString(self.activityExploreData[iter_5_0].starttime .. "开启")
				elseif var_6_1 == "level" then
					var_6_6:setString(ANNIVERSARY_EXPLORE_ERROR[var_6_1])
				end

				if iter_5_0 == 1 or iter_5_0 == 3 then
					var_6_5:setPositionX(var_6_6:getPositionX() - var_6_6:getContentSize().width)
				end
			end
		end
	end

	self.timeLabel:setString(self:getLeftTimeStr())
	self:registerBtnsTouchEvent()
end

function ActivityAnniversaryExploreLayer:fullScreen()
	self.title:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 1136 - self.title:getPositionY(), TRANSFORM_UNIT.PX))
	self.timeLabel:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 1136 - self.timeLabel:getPositionY(), TRANSFORM_UNIT.PX))
	self.returnBtn:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.returnBtn:getPositionY(), TRANSFORM_UNIT.PX))
end

function ActivityAnniversaryExploreLayer:playEntranceAni()
	self.returnBtn:setPositionX(700)
	self.returnBtn:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-10, self.returnBtn:getPositionY())), cc.MoveTo:create(0.1, cc.p(10, self.returnBtn:getPositionY())), cc.MoveTo:create(0.1, cc.p(0, self.returnBtn:getPositionY()))))
	self.chapterNodes[1]:setPositionX(0 - self.chapterNodes[1]:getPositionY())
	self.chapterNodes[2]:setPositionX(640 + self.chapterNodes[1]:getPositionY())
	self.chapterNodes[3]:setPositionX(0 - self.chapterNodes[1]:getPositionY())
	self.chapterNodes[1]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(288, self.chapterNodes[1]:getPositionY())), cc.MoveTo:create(0.1, cc.p(268, self.chapterNodes[1]:getPositionY())), cc.MoveTo:create(0.1, cc.p(278, self.chapterNodes[1]:getPositionY()))))
	self.chapterNodes[2]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(372, self.chapterNodes[2]:getPositionY())), cc.MoveTo:create(0.1, cc.p(352, self.chapterNodes[2]:getPositionY())), cc.MoveTo:create(0.1, cc.p(362, self.chapterNodes[2]:getPositionY()))))
	self.chapterNodes[3]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(288, self.chapterNodes[3]:getPositionY())), cc.MoveTo:create(0.1, cc.p(268, self.chapterNodes[3]:getPositionY())), cc.MoveTo:create(0.1, cc.p(278, self.chapterNodes[3]:getPositionY()))))

	local var_8_0 = self.rootLayer:getChildByName("Image_8")

	var_8_0:setPositionY(2000)
	var_8_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.MoveTo:create(0.3, cc.p(var_8_0:getPositionX(), 510))))
end

function ActivityAnniversaryExploreLayer:registerBtnsTouchEvent()
	self.title:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "Activity_anniversary_explore"
		})
	end)
	self.returnBtn:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:playExitAni(function()
			LayerManager:switchReturnLayer("ActivityAnniversaryMainLayer")
		end)
	end)

	for iter_9_0 = 1, 3 do
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
	end
end

function ActivityAnniversaryExploreLayer:getLeftTimeStr()
	local var_14_0 = self.finishtime - time_check_manager:getCurTime()

	if var_14_0 >= 86400 then
		return string.format("%02d天%02d小时", math.floor(var_14_0 / 86400), math.floor(var_14_0 % 86400 / 3600))
	elseif var_14_0 >= 3600 then
		return string.format("%02d小时%02d分钟", math.floor(var_14_0 / 3600), math.floor(var_14_0 % 3600 / 60))
	else
		return string.format("%02d分钟%02d秒", math.floor(var_14_0 / 60), math.floor(var_14_0 % 60))
	end
end

function ActivityAnniversaryExploreLayer:updateUI()
	for iter_15_0 = 1, 3 do
		self.chapterNodes[iter_15_0]:updateNode(msg)
	end
end

function ActivityAnniversaryExploreLayer:isChapterUnlock(arg_16_1)
	if self.activityExploreData[arg_16_1].starttime and time_check_manager:getCurTime() < global_get_time_by_date(self.activityExploreData[arg_16_1].starttime) then
		return false, "time"
	end

	if self.activityExploreData[arg_16_1].id > self.step_level + 1 then
		return false, "level"
	end

	return true
end

function ActivityAnniversaryExploreLayer:gotoExplore(arg_17_1)
	explore_manager:begin_explore({
		type = "activity",
		returnLayer = "ActivityAnniversaryExploreLayer",
		activity_explore_id = self.activityExploreData[arg_17_1].id,
		activityid = self.activityid,
		cancelCallback = function(arg_18_0)
			print(dump(arg_18_0))

			if arg_18_0 == 2 then
				global_ShowBlockWords("活动已关闭")
			elseif arg_18_0 == 3 then
				global_ShowBlockWords("活动关卡已全部完成!")
			elseif arg_18_0 == 4 then
				global_ShowBlockWords("该活动关卡已完成")
			elseif arg_18_0 == 5 then
				global_ShowBlockWords("服务端客户端数据不同步！")
			elseif arg_18_0 == 0 then
				global_ShowBlockWords("活动探险未开放")
			end
		end
	})
end

function ActivityAnniversaryExploreLayer:playExitAni(arg_19_1)
	self.isShowEffect = true

	self.returnBtn:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(50, 0)), cc.MoveBy:create(0.05, cc.p(-250, 0)), cc.CallFunc:create(function()
		if arg_19_1 then
			arg_19_1()
		end

		self.isShowEffect = nil
	end)))
end
