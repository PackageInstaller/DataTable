AvalonStoryLayer = class("AvalonStoryLayer", function()
	return cc.Layer:create()
end)

local city_data = require("data.city_data")
local levelmode_data = require("data.levelmode_data")
local activity_manager = require("controller.activity_manager")
local var_0_3 = require("controller.activity_manager")
local autopop_manager = require("controller.autopop_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_conf_data = require("data.activity_conf_data")
local alert_manager = require("controller.alert_manager")
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local share_manager = require("controller.share_manager")
local explore_manager = require("controller.explore_manager")
local var_0_12 = config._DEBUG and 0 or 1
local var_0_14
local var_0_15 = 115
local var_0_17 = cc.size(328, 58)
local var_0_18 = "2020-08-01 00:00:00"
local var_0_19 = {
	[1] = 614,
	[2] = 663
}
local var_0_21 = {
	289,
	513,
	288
}
local var_0_22 = {
	300,
	0,
	-300
}
local var_0_23 = {
	{
		x = 185,
		y = 845 + 1.6 * GameDisplay.fix_y
	},
	{
		x = 452,
		y = 592 + 0.8 * GameDisplay.fix_y
	},
	{
		x = 187,
		y = 327
	},
	{
		x = 90,
		y = 65
	},
	{
		x = -555,
		y = 86
	},
	{
		x = 663,
		y = 282 - GameDisplay.fix_y
	},
	{
		x = var_0_21[1],
		y = var_0_22[1] + 1.6 * GameDisplay.fix_y
	},
	{
		x = var_0_21[2],
		y = var_0_22[2] + 0.8 * GameDisplay.fix_y
	},
	{
		x = var_0_21[3],
		y = var_0_22[3]
	}
}
local var_0_24 = {
	"Activity_avalon/btn_chapter.png",
	"Activity_avalon/btn_zhixian.png",
	"Activity_avalon/btn_chaoping.png",
	"Activity_avalon/renwu_di.png",
	"Activity_avalon/btn_twist.png",
	"Activity_avalon/btn_shop.png",
	"Activity_avalon/battlepass.png",
	"Activity_avalon/btn_share.png"
}
local var_0_25 = {
	"Activity_avalon/btn_chapter.png",
	"Activity_avalon/btn_zhixian.png",
	"Activity_avalon/btn_chaoping_off.png",
	"Activity_avalon/renwu_di.png",
	"Activity_avalon/btn_twist.png",
	"Activity_avalon/btn_shop.png",
	"Activity_avalon/battlepass.png",
	"Activity_avalon/btn_share.png"
}
local var_0_26 = {
	{
		open = "Activity_avalon/story1_open.png",
		lock = "Activity_avalon/story1_lock.png"
	},
	{
		open = "Activity_avalon/story2_open.png",
		lock = "Activity_avalon/story2_lock.png"
	},
	{
		open = "Activity_avalon/story3_open.png",
		lock = "Activity_avalon/story3_lock.png"
	}
}

function AvalonStoryLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = AvalonStoryLayer.new()

	var_2_0:init(arg_2_1)
	var_0_3:fireEvent(var_0_3.activityEventId.POP_LAYER_OPEMED)

	return var_2_0
end

function AvalonStoryLayer.getInstance()
	return var_0_14
end

function AvalonStoryLayer:init(arg_4_1)
	RoleDefault:getInstance():setBoolForKey("AvalonStoryLayer_first", true)

	var_0_14 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Activity_avalon_enter.json" or "Activity_avalon_enter.ExportJson")

	self:addChild(self.rootLayer)

	self.title_panel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_title")
	self.modle_panel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_midel")
	self.panel_bottom = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_bottom")
	self.btn_info = ccui.Helper:seekWidgetByName(self.title_panel, "btn_info")
	self.btn_info1 = ccui.Helper:seekWidgetByName(self.title_panel, "image_tile")
	self.btn_share = ccui.Helper:seekWidgetByName(self.title_panel, "btn_avlon_share")
	self.btn_zhuxian1 = ccui.Helper:seekWidgetByName(self.modle_panel, "btn_zhuxian1")
	self.btn_zhuxian2 = ccui.Helper:seekWidgetByName(self.modle_panel, "btn_zhuxian2")
	self.btn_zhuxian3 = ccui.Helper:seekWidgetByName(self.modle_panel, "btn_zhuxian3")
	self.btn_renwu = ccui.Helper:seekWidgetByName(self.panel_bottom, "btn_renwu")
	self.btn_shop = ccui.Helper:seekWidgetByName(self.panel_bottom, "btn_heijie")
	self.btn_support = ccui.Helper:seekWidgetByName(self.panel_bottom, "btn_bp")
	self.btn_twist = ccui.Helper:seekWidgetByName(self.panel_bottom, "btn_twist")
	self.btn_juqing = ccui.Helper:seekWidgetByName(self.panel_bottom, "btn_juqing")
	self.storypanel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_story")
	self.story1 = ccui.Helper:seekWidgetByName(self.storypanel, "button_story1")
	self.story2 = ccui.Helper:seekWidgetByName(self.storypanel, "button_story2")
	self.story3 = ccui.Helper:seekWidgetByName(self.storypanel, "button_story3")
	self.storyback = ccui.Helper:seekWidgetByName(self.storypanel, "btn_back2")
	self.storynode = ccui.Helper:seekWidgetByName(self.storypanel, "panel_di")

	self.btn_zhuxian2:setTouchEnabled(true)
	self.panel_bottom:setVisible(false)
	self.btn_share:setVisible(false)

	self.btn_back = ccui.Helper:seekWidgetByName(self.panel_bottom, "btn_back"):clone()

	self.btn_back:setPosition(90, 75 - GameDisplay.fix_y)
	self.rootLayer:addChild(self.btn_back)

	self.buttons = {
		self.btn_zhuxian1,
		self.btn_zhuxian2,
		self.btn_zhuxian3
	}
	self.story_buttons = {
		{
			exit = true,
			ani = "L",
			nodex = self.story1
		},
		{
			exit = true,
			ani = "R",
			nodex = self.story2
		},
		{
			exit = true,
			ani = "L",
			nodex = self.story3
		},
		{
			exit = true,
			ani = "L",
			nodex = self.storyback
		},
		{
			exit = false,
			ani = "R",
			nodex = self.btn_share
		},
		{
			exit = false,
			ani = "L",
			nodex = self.panel_bottom
		},
		{
			exit = false,
			ani = "R",
			nodex = self.btn_zhuxian1
		},
		{
			exit = false,
			ani = "L",
			nodex = self.btn_zhuxian2
		},
		{
			exit = false,
			ani = "R",
			nodex = self.btn_zhuxian3
		}
	}
	self.story_btn = {
		self.story1,
		self.story2,
		self.story3
	}

	if arg_4_1 then
		self.paneltype = arg_4_1.paneltype or nil
	end

	self:distributionBtnId()
	self:registerTimeCheckEvent()

	if not self.paneltype then
		self:palyAinEnterorOut(true)
	else
		self:palyStoryPanel2()
	end

	self.step_level = 0

	self:initUI()
	self:fullScreen()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			if self.callback then
				self.callback()
			end

			var_0_14 = nil

			var_0_3:releaseEventListenerByName("AvalonStoryLayer")

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end
		end
	end)
end

function AvalonStoryLayer:distributionBtnId()
	for iter_6_0, iter_6_1 in ipairs({
		self.btn_zhuxian1,
		self.btn_zhuxian2,
		self.btn_zhuxian3,
		self.btn_renwu,
		self.btn_twist,
		self.btn_shop,
		self.btn_support,
		self.btn_share
	}) do
		iter_6_1.subid = iter_6_0
	end
end

function AvalonStoryLayer:checkShiLianBtn()
	if not activity_conf_data[var_0_15] then
		return false
	end

	local var_7_1 = time_check_manager:getCurTime()
	local var_7_2 = true

	if var_7_1 >= global_get_time_by_date(var_0_18) and var_7_1 <= global_get_time_by_date(activity_conf_data[var_0_15].finishtime) then
		var_7_2 = true
	elseif var_7_1 < global_get_time_by_date(var_0_18) then
		var_7_2 = false
	elseif var_7_1 > global_get_time_by_date(activity_conf_data[var_0_15].finishtime) then
		var_7_2 = true
	end

	if var_7_2 then
		self.btn_zhuxian3:loadTextures(var_0_24[3], nil, var_0_24[3], var_0_12)
		ccui.Helper:seekWidgetByName(self.btn_zhuxian3, "pacent"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.btn_zhuxian3, "ProgressBar"):setVisible(true)
	else
		self.btn_zhuxian3:loadTextures(var_0_25[3], nil, var_0_25[3], var_0_12)
		ccui.Helper:seekWidgetByName(self.btn_zhuxian3, "pacent"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.btn_zhuxian3, "ProgressBar"):setVisible(false)
	end
end

function AvalonStoryLayer:initUI()
	self:updateChapterProgress()
	self:updateRegionalStoryProgress()
	self:updateSubstitutionProgress()
	self:updateTimeLable()
	self:updateBtnStatus()
	self:updateShareBtn()
	self:initExporeStatus()
	self:updateStoryBtnStatus()
	self:checkShiLianBtn()

	local function var_8_0(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end
	end

	self.btn_info:setVisible(false)
	self.btn_info:addTouchEventListener(var_8_0)
	self.btn_info1:addTouchEventListener(var_8_0)
	self.btn_zhuxian1:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_10_0:getTouchBeganPosition().y - arg_10_0:getTouchEndPosition().y) > 50 then
			return
		end

		if self:checkIsTime(arg_10_0.subid) then
			LayerManager:switchShowLayer("ActivityLevelLayer", {
				activityid = var_0_15
			})
		else
			global_ShowBlockWords("活动已结束")
		end
	end)
	self.btn_zhuxian2:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_11_0:getTouchBeganPosition().y - arg_11_0:getTouchEndPosition().y) > 50 then
			return
		end

		if self:checkIsTime(arg_11_0.subid) then
			self:palyStoryAinEnterorOut(true)
		else
			global_ShowBlockWords("活动已结束")
		end
	end)
	self.btn_zhuxian3:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_12_0:getTouchBeganPosition().y - arg_12_0:getTouchEndPosition().y) > 50 then
			return
		end

		if self:checkIsTime(arg_12_0.subid) then
			LayerManager:switchShowLayer("AdventurerVisualLayer", {
				returnbacklayer = "AvalonStoryLayer",
				isStory = true
			})
		end
	end)
	self.btn_renwu:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_13_0:getTouchBeganPosition().y - arg_13_0:getTouchEndPosition().y) > 50 then
			return
		end

		if self:checkIsTime(arg_13_0.subid) then
			LayerManager:switchShowLayer("ActivityAvalonBPLayer")
		else
			global_ShowBlockWords("活动已结束")
		end
	end)
	self.btn_twist:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_14_0:getTouchBeganPosition().y - arg_14_0:getTouchEndPosition().y) > 50 then
			return
		end

		if self:checkIsTime(arg_14_0.subid) then
			local var_14_0 = cc.EventCustom:new("switchShowLayer")

			var_14_0.layerName = "TwisteggLayer"
			var_14_0.initparam = {
				initTwisType = 116,
				returnLayer = "ActivityLayer_LamiaEnterLayer"
			}

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_14_0)
		else
			global_ShowBlockWords("活动已结束")
		end
	end)
	self.btn_shop:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_15_0:getTouchBeganPosition().y - arg_15_0:getTouchEndPosition().y) > 50 then
			return
		end

		if self:checkIsTime(arg_15_0.subid) then
			local var_15_0 = cc.EventCustom:new("switchShowLayer")

			var_15_0.layerName = "TwisteggLayer"
			var_15_0.initparam = {
				initTwisType = 117,
				returnLayer = "ActivityLayer_LamiaEnterLayer"
			}

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_15_0)
		else
			global_ShowBlockWords("活动已结束")
		end
	end)
	self.btn_support:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_16_0:getTouchBeganPosition().y - arg_16_0:getTouchEndPosition().y) > 50 then
			return
		end

		if self:checkIsTime(arg_16_0.subid) then
			local var_16_0 = cc.EventCustom:new("switchShowLayer")

			var_16_0.layerName = "MarketLayer"
			var_16_0.initparam = {
				returnLayer = "AvalonStoryLayer",
				singleMarket = {
					"1-11502",
					"1-11504",
					"1-11505"
				}
			}

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_16_0)
		else
			global_ShowBlockWords("活动已结束")
		end
	end)
	self.btn_juqing:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_17_0:getTouchBeganPosition().y - arg_17_0:getTouchEndPosition().y) > 50 then
			return
		end

		if not arg_17_0:isBright() then
			return
		end

		arg_17_0:setBright(false)
		global_basic_scene:addChild(TalkLayer:create(15000, nil, TALK_TYPE_TRAVEL, "", function()
			arg_17_0:setBright(true)
		end), ZORDER_TALKLAYER)
	end)
	self.btn_back:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_19_0:getTouchBeganPosition().y - arg_19_0:getTouchEndPosition().y) > 50 then
			return
		end

		self:palyAinEnterorOut(false, function()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end)
end

function AvalonStoryLayer:updateStoryLayer()
	self.storyback:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_22_0:getTouchBeganPosition().y - arg_22_0:getTouchEndPosition().y) > 50 then
			return
		end

		self:palyStoryAinEnterorOut(false)
	end)

	for iter_21_0, iter_21_1 in pairs(self.story_btn) do
		iter_21_1:addTouchEventListener(function(arg_23_0, arg_23_1)
			if arg_23_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_23_0:getTouchBeganPosition().y - arg_23_0:getTouchEndPosition().y) > 50 then
				return
			end

			local var_23_0, var_23_1, var_23_2 = self:isUnlockStory(iter_21_0)

			if var_23_0 then
				if self:isCanRepeat(iter_21_0) then
					self:gotoExplore(iter_21_0)
				end
			else
				global_ShowBlockWords(L_CLEAR_CHAPTER .. "【" .. L_MODE_DIFFICULTY_LAMIA[level_manager:getDifficultByMode(var_23_1)] .. "】" .. level_manager:getChapterName(var_23_1, var_23_2) .. L_UNLOCK)
			end
		end)
	end
end

function AvalonStoryLayer:isCanRepeat(arg_24_1)
	if not arg_24_1 then
		return false
	end

	local var_24_0 = self:getActExploreConf(var_0_15)

	if var_24_0 and var_24_0[arg_24_1] and var_24_0[arg_24_1].isrepeat then
		if self.step_level and self.step_level == 0 then
			if arg_24_1 == 1 then
				return true
			else
				global_ShowBlockWords("需要通关上一个章节探险！")
			end
		elseif self.step_level and self.step_level == 1 then
			if arg_24_1 == 3 then
				global_ShowBlockWords("需要通关上一个章节探险！")

				return false
			else
				return true
			end
		elseif self.step_level and self.step_level >= 2 then
			return true
		end
	elseif self.step_level and arg_24_1 <= self.step_level then
		global_ShowBlockWords("已通关")

		return false
	else
		return true
	end
end

function AvalonStoryLayer.getActExploreConf(arg_25_0)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in pairs((require("data.avalon_activity_level_data"))) do
		if iter_25_1.valid == 1 then
			var_25_0[iter_25_1.id] = iter_25_1
		end
	end

	return var_25_0
end

function AvalonStoryLayer:getStoryLockInfo()
	local var_26_0 = {
		{
			unlock = false
		},
		{
			unlock = false
		},
		{
			unlock = false
		}
	}
	local var_26_1 = self:getActExploreConf(var_0_15)

	if var_26_1 and next(var_26_1) then
		local var_26_2 = {}

		for iter_26_0, iter_26_1 in ipairs(var_26_1) do
			if iter_26_1.lockchapter then
				table.insert(var_26_2, iter_26_1.lockchapter)
			end
		end

		for iter_26_2, iter_26_3 in ipairs(var_26_2) do
			local var_26_3 = {}

			for iter_26_4 in iter_26_3:gmatch("%d+") do
				table.insert(var_26_3, tonumber(iter_26_4))
			end

			local var_26_4 = tonumber(var_26_3[1])
			local var_26_5 = tonumber(var_26_3[2])

			var_26_0[iter_26_2].unlock = not not (playermodel.levelmode[var_26_4] and var_26_5 < playermodel.levelmode[var_26_4].status)
			var_26_0[iter_26_2].mode = var_26_4
			var_26_0[iter_26_2].chapter = var_26_5
		end
	end

	return var_26_0
end

function AvalonStoryLayer:isUnlockStory(arg_27_1)
	if not arg_27_1 then
		return true
	end

	local var_27_0 = self:getStoryLockInfo()[arg_27_1]

	if var_27_0 then
		return var_27_0.unlock, var_27_0.mode, var_27_0.chapter
	else
		return true
	end
end

function AvalonStoryLayer.initExporeStatus(arg_28_0)
	explore_manager:getTotalLevelInfoByServer(function()
		arg_28_0.activityExploreData = arg_28_0:getActExploreConf(var_0_15)
		arg_28_0.step_level = explore_manager:getExploreLevelInfo(2).finish_step

		arg_28_0:updateStoryLayer()
		arg_28_0:updateStoryBtnStatus()
		arg_28_0:updateRegionalStoryProgress()
	end)
end

function AvalonStoryLayer.updateStoryStatus(arg_30_0, arg_30_1)
	if arg_30_1 ~= RoleDefault:getInstance():getIntegerForKey("Avalon_activity_finish_level", 0) then
		RoleDefault:getInstance():setBoolForKey("AvalonStory_" .. RoleDefault:getInstance():getIntegerForKey("AvalonStoryIndex", 1) .. "IsComplete", true)
		RoleDefault:getInstance():setIntegerForKey("Avalon_activity_finish_level", arg_30_1)
	end
end

function AvalonStoryLayer:updateStoryBtnStatus()
	local var_31_0 = {
		0,
		0,
		0
	}

	for iter_31_0, iter_31_1 in ipairs((self:getStoryLockInfo())) do
		var_31_0[iter_31_0] = not iter_31_1.unlock and 0 or self.step_level == 0 and 1 or iter_31_0 <= self.step_level and 2 or 1
	end

	for iter_31_2, iter_31_3 in pairs(self.story_btn) do
		if var_31_0[iter_31_2] == 0 then
			iter_31_3:loadTextures(var_0_26[iter_31_2].open, nil, var_0_26[iter_31_2].open, var_0_12)
			iter_31_3:getChildByName("image_lock"):setVisible(true)
			iter_31_3:setTouchEnabled(true)
		elseif var_31_0[iter_31_2] == 1 then
			iter_31_3:loadTextures(var_0_26[iter_31_2].open, nil, var_0_26[iter_31_2].open, var_0_12)
			iter_31_3:getChildByName("image_lock"):setVisible(false)
			iter_31_3:setTouchEnabled(true)
		elseif var_31_0[iter_31_2] == 2 then
			iter_31_3:loadTextures(var_0_26[iter_31_2].lock, nil, var_0_26[iter_31_2].lock, var_0_12)
			iter_31_3:getChildByName("image_lock"):setVisible(false)
			iter_31_3:setTouchEnabled(true)
		end
	end
end

function AvalonStoryLayer.gotoExplore(arg_32_0, arg_32_1)
	explore_manager:begin_explore({
		classid = 2,
		type = "level",
		returnLayer = "AvalonStoryLayer",
		cur_step = arg_32_1,
		cancelCallback = function(arg_33_0)
			if arg_33_0 == 2 then
				global_ShowBlockWords("活动已关闭")
			elseif arg_33_0 == 3 then
				global_ShowBlockWords("活动关卡已全部完成!")
			elseif arg_33_0 == 4 then
				global_ShowBlockWords("需要通关上一个章节探险！")
			elseif arg_33_0 == 5 then
				global_ShowBlockWords("服务端客户端数据不同步！")
			elseif arg_33_0 == 0 then
				global_ShowBlockWords("活动探险未开放")
			end
		end
	})
end

function AvalonStoryLayer:updateTaskLable()
	local var_34_0 = var_0_3:getCompleteTaskNum(115) .. "/" .. #var_0_3:getActivityTaskData(115)
	local var_34_1 = ccui.Helper:seekWidgetByName(self.btn_renwu, "Label_45")

	if var_34_0 then
		var_34_1:setString(var_34_0)
	else
		var_34_1:setString("0/0")
	end
end

function AvalonStoryLayer:updateChapterProgress()
	local var_35_0 = self:getAvalonChapterProgress()
	local var_35_1 = ccui.Helper:seekWidgetByName(self.btn_zhuxian1, "pacent")
	local var_35_2 = ccui.Helper:seekWidgetByName(self.btn_zhuxian1, "ProgressBar")

	if var_35_0 and var_35_0 >= 0 then
		var_35_1:setVisible(true)
		var_35_2:setVisible(true)
		var_35_2:setPercent(var_35_0)
		var_35_1:setString("" .. var_35_0 .. "%")
	else
		var_35_1:setVisible(false)
		var_35_2:setVisible(false)
	end
end

function AvalonStoryLayer:updateRegionalStoryProgress()
	local var_36_0 = math.floor(((self.step_level or nil) and (self.step_level or 0)) / 3 * 100)
	local var_36_1 = ccui.Helper:seekWidgetByName(self.btn_zhuxian2, "pacent")
	local var_36_2 = ccui.Helper:seekWidgetByName(self.btn_zhuxian2, "ProgressBar")

	if var_36_0 and var_36_0 >= 0 then
		var_36_1:setVisible(true)
		var_36_2:setVisible(true)
		var_36_2:setPercent(var_36_0)
		var_36_1:setString("" .. var_36_0 .. "%")
	else
		var_36_1:setVisible(false)
		var_36_2:setVisible(false)
	end
end

function AvalonStoryLayer:updateSubstitutionProgress()
	local var_37_0 = self:getAvalonSubstitutionProgress()
	local var_37_1 = ccui.Helper:seekWidgetByName(self.btn_zhuxian3, "pacent")
	local var_37_2 = ccui.Helper:seekWidgetByName(self.btn_zhuxian3, "ProgressBar")

	if var_37_0 and var_37_0 >= 0 then
		var_37_1:setVisible(true)
		var_37_2:setVisible(true)
		var_37_2:setPercent(var_37_0)
		var_37_1:setString("" .. var_37_0 .. "%")
	else
		var_37_1:setString("")
		var_37_2:setPercent(0)
	end
end

function AvalonStoryLayer:updateShareBtn()
	self.btn_share:setVisible(false)

	if not share_manager:can_share() then
		return
	end

	local function var_38_0()
		self.btn_share:setVisible(false)
		self.btn_share:addTouchEventListener(function(arg_40_0, arg_40_1)
			if arg_40_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_40_0:getTouchBeganPosition().y - arg_40_0:getTouchEndPosition().y) > 50 then
				return
			end

			if self:checkIsTime(arg_40_0.subid) then
				LayerManager:pushInLayer("PopActivityShareLayer", {
					activityid = var_0_15
				})
			else
				global_ShowBlockWords("活动已结束")
			end
		end)
	end

	share_manager:get_activity_share_data(var_0_15, function(arg_41_0, arg_41_1)
		if arg_41_0 == 1 then
			if config.packagechannel == "feiyu" then
				if arg_41_1.url:find(".jpg$") or arg_41_1.url:find(".png$") then
					local var_41_0 = FeiyuManager.getSDKVersion and FeiyuManager.getSDKVersion() or nil

					if var_41_0 and tonumber(var_41_0) >= 2 then
						var_38_0()
					end
				else
					var_38_0()
				end
			else
				var_38_0()
			end
		end
	end)
end

function AvalonStoryLayer.checkIsTime(arg_42_0, arg_42_1)
	return true
end

function AvalonStoryLayer.updateBtnStatus(arg_44_0)
	return
end

function AvalonStoryLayer:updateTimeLable()
	ccui.Helper:seekWidgetByName(self.title_panel, "label_time"):setVisible(false)
end

function AvalonStoryLayer:registerTimeCheckEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_47_0)
		if arg_47_0.eventType == NEXT_DAY then
			playermodel:getServerTime(function()
				self:updateBtnStatus()
				self:checkShiLianBtn()
			end)
		end
	end), self)
end

function AvalonStoryLayer:palyAinEnterorOut(arg_49_1, arg_49_2)
	self:palyStoryPanel()

	if not arg_49_1 then
		for iter_49_0, iter_49_1 in pairs(self.buttons) do
			if iter_49_0 % 2 ~= 0 then
				iter_49_1:runAction(cc.MoveTo:create(0.5, cc.p(1500, iter_49_1:getPositionY())))
			else
				iter_49_1:runAction(cc.MoveTo:create(0.5, cc.p(-1500, iter_49_1:getPositionY())))
			end
		end

		self.title_panel:runAction(cc.MoveTo:create(0.5, cc.p(1500, self.title_panel:getPositionY())))
		self.panel_bottom:runAction(cc.MoveTo:create(0.5, cc.p(-1500, self.panel_bottom:getPositionY())))

		if arg_49_2 then
			arg_49_2()
		end
	else
		for iter_49_2, iter_49_3 in pairs(self.buttons) do
			if iter_49_2 % 2 ~= 0 then
				iter_49_3:setPositionX(1500)
			else
				iter_49_3:setPositionX(-1500)
			end
		end

		for iter_49_4, iter_49_5 in pairs(self.buttons) do
			if iter_49_4 % 2 ~= 0 then
				iter_49_5:runAction(cc.MoveTo:create(0.5, cc.p(var_0_21[iter_49_4], iter_49_5:getPositionY())))
			else
				iter_49_5:runAction(cc.MoveTo:create(0.5, cc.p(var_0_21[iter_49_4], iter_49_5:getPositionY())))
			end
		end

		self.title_panel:setPositionX(1500)
		self.panel_bottom:setPositionX(-1500)
		self.title_panel:runAction(cc.MoveTo:create(0.5, cc.p(var_0_19[1], self.title_panel:getPositionY())))
		self.panel_bottom:runAction(cc.MoveTo:create(0.5, cc.p(var_0_19[2], self.panel_bottom:getPositionY())))
	end
end

function AvalonStoryLayer:palyStoryPanel(arg_50_1)
	for iter_50_0, iter_50_1 in pairs(self.story_buttons) do
		if iter_50_1.exit then
			if iter_50_1.ani == "R" then
				iter_50_1.nodex:setPosition(1500, iter_50_1.nodex:getPositionX())
			elseif iter_50_1.ani == "L" then
				iter_50_1.nodex:setPosition(-1500, iter_50_1.nodex:getPositionX())
			end
		end
	end
end

function AvalonStoryLayer:palyStoryPanel2(arg_51_1)
	self.title_panel:setPositionX(1500)
	self.panel_bottom:setPositionX(-1500)
	self:palyStoryPanel()

	for iter_51_0, iter_51_1 in pairs(self.story_buttons) do
		if not iter_51_1.exit then
			if iter_51_1.ani == "R" then
				iter_51_1.nodex:runAction(cc.MoveTo:create(0, cc.p(1500, iter_51_1.nodex:getPositionX())))
			elseif iter_51_1.ani == "L" then
				iter_51_1.nodex:runAction(cc.MoveTo:create(0, cc.p(-1500, iter_51_1.nodex:getPositionX())))
			end
		else
			iter_51_1.nodex:runAction(cc.MoveTo:create(0.5, cc.p(var_0_23[iter_51_0].x, var_0_23[iter_51_0].y)))
		end
	end

	self.title_panel:runAction(cc.MoveTo:create(0.5, cc.p(var_0_19[1], self.title_panel:getPositionY())))
end

function AvalonStoryLayer:palyStoryAinEnterorOut(arg_52_1)
	if not arg_52_1 then
		for iter_52_0, iter_52_1 in pairs(self.story_buttons) do
			if iter_52_1.exit then
				if iter_52_1.ani == "R" then
					iter_52_1.nodex:runAction(cc.MoveTo:create(0.5, cc.p(1500, iter_52_1.nodex:getPositionX())))
				elseif iter_52_1.ani == "L" then
					iter_52_1.nodex:runAction(cc.MoveTo:create(0.5, cc.p(-1500, iter_52_1.nodex:getPositionX())))
				end
			else
				iter_52_1.nodex:runAction(cc.MoveTo:create(0.5, cc.p(var_0_23[iter_52_0].x, var_0_23[iter_52_0].y)))
			end
		end

		self.btn_back:setVisible(true)
	else
		for iter_52_2, iter_52_3 in pairs(self.story_buttons) do
			if iter_52_3.exit then
				iter_52_3.nodex:runAction(cc.MoveTo:create(0.5, cc.p(var_0_23[iter_52_2].x, var_0_23[iter_52_2].y)))
			elseif iter_52_3.ani == "R" then
				iter_52_3.nodex:runAction(cc.MoveTo:create(0.5, cc.p(1500, iter_52_3.nodex:getPositionY())))
			elseif iter_52_3.ani == "L" then
				iter_52_3.nodex:runAction(cc.MoveTo:create(0.5, cc.p(-1500, iter_52_3.nodex:getPositionY())))
			end
		end

		self.btn_back:setVisible(false)
	end
end

function AvalonStoryLayer:fullScreen()
	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.title_panel:setPositionY(self.title_panel:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
	self.storypanel:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.storynode:setPositionY(-GameDisplay.fix_y)
	self.panel_bottom:setPositionY(282 - GameDisplay.fix_y)
	self.modle_panel:setPositionY(568)

	for iter_53_0 = 1, 3 do
		self.buttons[iter_53_0]:setPositionY(var_0_22[iter_53_0])
	end
end

function AvalonStoryLayer.getAvalonChapterProgress(arg_54_0)
	local var_54_0 = 0
	local var_54_1 = 0
	local var_54_2 = 0
	local var_54_3 = {}

	if activity_conf_data[var_0_15] and activity_conf_data[var_0_15].cityid and type(activity_conf_data[var_0_15].cityid) == "string" then
		local var_54_4 = {}

		for iter_54_0 in activity_conf_data[var_0_15].cityid:gmatch("%d+") do
			table.insert(var_54_4, tonumber(iter_54_0))
		end

		if next(var_54_4) then
			for iter_54_1, iter_54_2 in pairs(var_54_4) do
				for iter_54_3, iter_54_4 in pairs(city_data) do
					if iter_54_4.id == iter_54_2 then
						while iter_54_4["difficulty" .. 1] do
							for iter_54_5, iter_54_6 in pairs(levelmode_data) do
								if iter_54_6.mode == iter_54_4["difficulty" .. 1] then
									var_54_1 = var_54_1 + iter_54_6.totalchapter

									table.insert(var_54_3, iter_54_6.mode)
								end
							end
						end
					end
				end
			end

			if next(var_54_3) then
				for iter_54_7, iter_54_8 in pairs(var_54_3) do
					if playermodel.levelmode[iter_54_8] and playermodel.levelmode[iter_54_8].status then
						var_54_2 = var_54_2 + playermodel.levelmode[iter_54_8].status - 1
					end
				end
			end

			var_54_0 = math.floor(var_54_2 / var_54_1 * 100)
		end
	end

	return var_54_0
end

function AvalonStoryLayer.getAvalonSubstitutionProgress(arg_55_0)
	local var_55_0 = 0
	local var_55_1 = {}

	for iter_55_0, iter_55_1 in pairs(levelmode_data) do
		if iter_55_1.modetype == 1151 then
			table.insert(var_55_1, iter_55_1.mode)
		end
	end

	if next(var_55_1) then
		local var_55_2 = 0
		local var_55_3 = 0

		for iter_55_2, iter_55_3 in pairs(var_55_1) do
			for iter_55_4, iter_55_5 in pairs(levelmode_data) do
				if iter_55_3 == iter_55_5.mode then
					var_55_2 = var_55_2 + iter_55_5.totalchapter
				end
			end

			if playermodel.levelmode[iter_55_3] and playermodel.levelmode[iter_55_3].status then
				var_55_3 = var_55_3 + playermodel.levelmode[iter_55_3].status - 1
			end
		end

		var_55_0 = math.floor(var_55_3 / var_55_2 * 100)
	end

	return var_55_0
end
