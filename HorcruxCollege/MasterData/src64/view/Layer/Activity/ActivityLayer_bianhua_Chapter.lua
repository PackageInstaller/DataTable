ActivityLayer_bianhua_Chapter = class("ActivityLayer_bianhua_Chapter", function()
	return cc.Layer:create()
end)

local activity_bianhua_manager = require("controller.activity_bianhua_manager")
local explore_manager = require("controller.explore_manager")
local bianhua_activity_level_data = require("data.bianhua_activity_level_data")
local item_manager = require("controller.item_manager")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local time_check_manager = require("controller.time_check_manager")
local l2utils = require("controller.l2utils")
local playermodel = require("model.playermodel")
local var_0_9 = config._DEBUG and 0 or 1
local var_0_10
local var_0_11 = 2092
local var_0_12 = 0
local var_0_13 = 1
local var_0_14 = 2
local var_0_15 = {
	"序章",
	"彼岸花初现",
	"饿狼的邀约",
	"各自的选择",
	"尾\n声"
}
local var_0_16 = {
	[2] = {
		angle = -3,
		x = 0,
		y = 20
	},
	[3] = {
		angle = 2.07,
		x = 10,
		y = 20
	},
	[4] = {
		angle = -8.54,
		x = -5,
		y = 20
	}
}

function ActivityLayer_bianhua_Chapter.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityLayer_bianhua_Chapter.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityLayer_bianhua_Chapter.getInstance()
	return var_0_10
end

function ActivityLayer_bianhua_Chapter:init(arg_4_1)
	var_0_10 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Activity_bianhua_chapter.json" or "Activity_bianhua_chapter.ExportJson")

	self:addChild(self.rootLayer)
	self:initData()
	self:initUI()
	self:fullScreen()
	self:updateData()
end

function ActivityLayer_bianhua_Chapter:initData()
	self.levelId = 0
	self.dailyCount = 0
	self.buyCount = 0
	self.aniState = var_0_12
	self.finish = false
	self.levelModeid = activity_bianhua_manager:getLevelModeid()
	self.levelModeType = activity_bianhua_manager:getLevelModelModetype()
	self.extraLevelData = activity_bianhua_manager:getExtraData()
	self.ActivityID = activity_bianhua_manager:getActivityId()
	self.unlockTime = activity_bianhua_manager:getUnlockTime()
	self.freeDailyCount = activity_bianhua_manager:get_explore_daily_times()
	self.buyDailyLimit = activity_bianhua_manager:get_explore_daily_buy_times()
	self.hideTaskDes = activity_bianhua_manager:getHideTaskDes()

	self:setTicketNum()
end

function ActivityLayer_bianhua_Chapter:initUI()
	self.imgBg = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_bg")
	self.chapterShade = ccui.Helper:seekWidgetByName(self.rootLayer, "chapter_shade")
	self.ticketPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_ticket"):clone()
	self.chapterUI = {}

	self:initTitle()
	self:initChapterUI()
	self:initPhoneUI()
	self:initBottomBtnList()
	self:initBottomAddPanel()
end

function ActivityLayer_bianhua_Chapter:initTitle()
	local var_7_0 = TitleSprite:create("public/title/title_activity_chapter.png", 2)

	var_7_0.title:setPositionX(0)
	var_7_0:setAnchorPoint(cc.p(0, 1))
	var_7_0:setPosition(0, SCREEN_HEIGHT)
	var_7_0:setName("titleBg")
	var_7_0:addChild(self.ticketPanel)
	self.ticketPanel:setPosition(cc.p(560, var_7_0:getContentSize().height / 2))
	self.ticketPanel:setVisible(true)
	self.ticketPanel:getChildByName("ticket_num"):setString(self.ticketNum)

	local var_7_1 = ccui.Button:create("Activity_bianhua_Chapter/infoBtn.png", "Activity_bianhua_Chapter/infoBtn.png", "Activity_bianhua_Chapter/infoBtn.png", var_0_9)

	var_7_1:setPosition(240, var_7_0:getContentSize().height / 2)
	var_7_0:addChild(var_7_1)
	var_7_1:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("显示活动信息")
		LayerManager:pushInLayer("PopActivityDetail", {
			key = string.format("activity_%d_%d", activity_bianhua_manager:getActivityId(), var_0_11)
		})
	end)
	self.rootLayer:addChild(var_7_0, 5)
end

function ActivityLayer_bianhua_Chapter:initBottomBtnList()
	self.bottomlist = BottomBtnList:create(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()

		if callback then
			callback()
		end
	end, {})

	self:addChild(self.bottomlist, 5)
end

function ActivityLayer_bianhua_Chapter:initBottomAddPanel()
	local var_11_0 = ccui.Layout:create()

	var_11_0:setTouchEnabled(true)
	var_11_0:setContentSize(cc.size(320, 62))
	var_11_0:setAnchorPoint(cc.p(0, 0))
	var_11_0:setPosition(cc.p(320, 0))
	var_11_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_11_0:setName("bottomAddPanel")
	self.bottomlist:addChild(var_11_0)

	local var_11_1 = ccui.ImageView:create("Activity_bianhua_Chapter/new_changtimesdi.png", var_0_9)

	var_11_1:setPositionX(235)
	var_11_1:setPositionY(31)
	var_11_0:addChild(var_11_1)

	local var_11_2 = cc.Label:createWithTTF("剩余挑战次数：   2", FONT_DES, 20)

	var_11_2:setPositionX(150)
	var_11_2:setPositionY(31)
	var_11_2:setName("surplusLabel")
	var_11_2:setColor(cc.c3b(14, 185, 255))
	var_11_0:addChild(var_11_2)
end

function ActivityLayer_bianhua_Chapter:updateBottomAddPanel()
	self.bottomlist:getChildByName("bottomAddPanel"):getChildByName("surplusLabel"):setString("剩余挑战次数：   " .. self.freeDailyCount - self:getTotalDailyTimes() + self:getBuyTimes())
end

function ActivityLayer_bianhua_Chapter.getBuyDailyhandel(arg_13_0, ...)
	return function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_14_1
		local var_14_0

		if arg_13_0:getBuyTimes() == arg_13_0.buyDailyLimit then
			global_ShowBlockWords("购买已达上限")

			do return end

			var_14_0 = activity_bianhua_manager:get_buy_times_cost(arg_13_0:getBuyTimes() + 1)
			var_14_1 = {
				costtype = "diamond"
			}
		end

		function var_14_1.surecallback()
			activity_bianhua_manager:activity_buy_explore_times(function(arg_16_0, arg_16_1)
				if arg_16_0 == 1 then
					arg_13_0:setBuyTimes(arg_16_1)
					arg_13_0:updateUI()
					AnalyticManager.BAH_buy_explore_times({
						buy_times = arg_16_1
					})
				elseif arg_16_0 == 3 then
					global_ShowBlockWords("购买已达上限")
				elseif arg_16_0 == 4 then
					global_ShowBlockWords("钻石不足")
				end
			end)
		end

		function var_14_1.cancelcallback()
			arg_14_0.bright = true
		end

		var_14_1.cost = var_14_0
		var_14_1.own = playermodel.diamond
		var_14_1.labels = {
			button = "确认购买",
			titleImage = "title_more_adventure_times.png",
			des = string.format("花费%d" .. L_DIAMOND .. "购买1次随机副本次数", var_14_0),
			more = string.format("%d" .. L_DIAMOND .. "回复1次~~~~", var_14_0)
		}

		LayerManager:pushInLayer("PopDoLayer", var_14_1)
	end
end

function ActivityLayer_bianhua_Chapter:initChapterUI()
	for iter_18_0 = 1, 5 do
		local var_18_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "chapter_" .. tostring(iter_18_0))

		self.chapterUI[iter_18_0] = {}
		self.chapterUI[iter_18_0].main = var_18_0
		self.chapterUI[iter_18_0].level = var_18_0:getChildByName("chapter_" .. tostring(iter_18_0) .. "_level")
		self.chapterUI[iter_18_0].name = var_18_0:getChildByName("chapter_" .. tostring(iter_18_0) .. "_name")
		self.chapterUI[iter_18_0].clear = var_18_0:getChildByName("chapter_" .. tostring(iter_18_0) .. "_clear")
		self.chapterUI[iter_18_0].outline = var_18_0:getChildByName("chapter_" .. tostring(iter_18_0) .. "_outline")
		self.chapterUI[iter_18_0].restart = var_18_0:getChildByName("chapter_" .. tostring(iter_18_0) .. "_restart")
		self.chapterUI[iter_18_0].active = var_18_0:getChildByName("chapter_" .. tostring(iter_18_0) .. "_active")
		self.chapterUI[iter_18_0].hide = var_18_0:getChildByName("chapter_" .. tostring(iter_18_0) .. "_hide")
	end

	self.chapterUI[5].name:setFontSize(35)
	self.chapterUI[2].name:setString(var_0_15[2])
	self.chapterUI[3].name:setString(var_0_15[3])
	self.chapterUI[4].name:setString(var_0_15[4])
	self.chapterUI[5].name:setString(var_0_15[5])
end

function ActivityLayer_bianhua_Chapter:initPhoneUI()
	self.phone = {}
	self.phone.main = ccui.Helper:seekWidgetByName(self.rootLayer, "phone")
	self.phone.active = ccui.Helper:seekWidgetByName(self.rootLayer, "phone_active")
	self.phone.outline = ccui.Helper:seekWidgetByName(self.rootLayer, "phone_outline")
	self.phone.shade = ccui.Helper:seekWidgetByName(self.rootLayer, "phone_shade")
end

function ActivityLayer_bianhua_Chapter:updateData()
	activity_bianhua_manager:get_swim_level_config(function(arg_21_0)
		print("updateDataupdateDataupdateData", dump(arg_21_0))
		self:setTotalDailyTimes(arg_21_0.total_daily_times)
		self:setBuyTimes(arg_21_0.buy_times)
		self:setLevelId(arg_21_0.finish_step)
		self:setIfChapterFinish(arg_21_0)
		self:updateUI()
	end)
	level_manager:getAdventureDailytimeByModeType(self.levelModeType, function(arg_22_0, arg_22_1)
		self:updatePhone()
	end)
	self:setTicketNum()
end

function ActivityLayer_bianhua_Chapter:updateUI()
	self.ChapterMsg = activity_bianhua_manager:getChapterMsg(self.levelId, function(arg_24_0)
		self:setChapterUnlock(arg_24_0)
	end)

	self:updateTicketNum()
	self:updateChapterInactive(self.ChapterMsg)
	self:updateChapterActive(self.ChapterMsg)
	self:updateChapterTitle(self.ChapterMsg)
	self:updateChapterRepeat(self.ChapterMsg)
	self:updateHideTaskInfo(self.ChapterMsg)
	self:updatePhone()
	self:updateBottomAddPanel()
end

function ActivityLayer_bianhua_Chapter:updateTicketNum()
	self.ticketPanel:getChildByName("ticket_num"):setString(self.ticketNum)
end

function ActivityLayer_bianhua_Chapter:updateChapterActive(arg_26_1)
	local var_26_0 = 1

	print("????????", arg_26_1.nowChapter.id)

	while var_26_0 < arg_26_1.nowChapter.id do
		self.chapterUI[var_26_0].main:setTouchEnabled(false)
		self.chapterUI[var_26_0].outline:setVisible(false)

		if self.chapterUI[var_26_0].active then
			self.chapterUI[var_26_0].active:setVisible(true)
		end

		if self.chapterUI[var_26_0].name then
			self.chapterUI[var_26_0].name:setVisible(true)
		end

		if self.chapterUI[var_26_0].decoration then
			self.chapterUI[var_26_0].decoration:setVisible(true)
		end

		if self.chapterUI[var_26_0].clear then
			self.chapterUI[var_26_0].clear:setVisible(true)
		end

		if self.chapterUI[var_26_0].unlock then
			self.chapterUI[var_26_0].unlock:setVisible(false)
		end

		var_26_0 = var_26_0 + 1
	end

	if not self.chapterUI[arg_26_1.nowChapter.id].unlocktag then
		if self.chapterUI[arg_26_1.nowChapter.id].active then
			self.chapterUI[var_26_0].active:setVisible(true)
		end

		if self.chapterUI[arg_26_1.nowChapter.id].name then
			self.chapterUI[var_26_0].name:setVisible(true)
		end

		if self.chapterUI[arg_26_1.nowChapter.id].decoration then
			self.chapterUI[var_26_0].decoration:setVisible(true)
		end

		if self.chapterUI[arg_26_1.nowChapter.id].unlock then
			self.chapterUI[var_26_0].unlock:setVisible(false)
		end

		if self.chapterUI[arg_26_1.nowChapter.id].clear then
			self.chapterUI[var_26_0].clear:setVisible(false)
		end
	end

	self.chapterUI[arg_26_1.nowChapter.id].main:setVisible(true)
	self.chapterUI[arg_26_1.nowChapter.id].main:setTouchEnabled(false)
	self.chapterUI[arg_26_1.nowChapter.id].main:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_26_1.nowChapter.finishType == "talk" then
			self:gotoTalk(arg_26_1)
		elseif arg_26_1.nowChapter.finishType == "explore" then
			self:gotoExplore(arg_26_1)
		end
	end)

	if not self:getIfChapterFinish() and not self.chapterUI[var_26_0].unlocktag then
		self.chapterUI[arg_26_1.nowChapter.id].main:setTouchEnabled(true)
		self.chapterUI[arg_26_1.nowChapter.id].outline:setVisible(true)
		self.chapterUI[arg_26_1.nowChapter.id].outline:setOpacity(0)
		self.chapterUI[arg_26_1.nowChapter.id].outline:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 255), cc.DelayTime:create(0.2), cc.FadeTo:create(1, 0))))
	elseif self:getIfChapterFinish() then
		self.chapterUI[arg_26_1.nowChapter.id].clear:setVisible(true)
		self.chapterUI[arg_26_1.nowChapter.id].outline:setVisible(false)
	end
end

function ActivityLayer_bianhua_Chapter:updateChapterInactive(arg_28_1)
	local var_28_0 = self:getUnlockTime()

	while 2 <= 4 do
		local var_28_1 = global_get_time_by_date(var_28_0[2])
		local var_28_2 = ""

		print("---------", 2, var_28_1, time_check_manager:getCurTime(), self.chapterUI[2].unlock)

		if var_28_1 > time_check_manager:getCurTime() then
			self.chapterUI[2].unlocktag = true
			var_28_2 = global_format_time_by_date(var_28_0[2], 1)
			var_28_2 = var_28_2 .. "\n" .. string.format("通关%s后解锁", var_0_15[2 - 1])
		else
			self.chapterUI[2].unlocktag = false
			var_28_2 = string.format("通关%s后解锁", var_0_15[2 - 1])
		end

		if not self.chapterUI[2].unlock then
			self.chapterUI[2].unlock = cc.Label:createWithTTF("", "fonts/name.ttf", 19)

			self.chapterUI[2].unlock:setColor(cc.c3b(255, 255, 255))
			self.chapterUI[2].unlock:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
			self.chapterUI[2].unlock:setString(var_28_2)
			self.chapterUI[2].unlock:setAnchorPoint(cc.p(0.5, 0.5))
			self.chapterUI[2].unlock:setPosition(self.chapterUI[2].main:getContentSize().width / 2 + var_0_16[2].x, self.chapterUI[2].main:getContentSize().height / 2 + var_0_16[2].y)
			self.chapterUI[2].unlock:setRotation(var_0_16[2].angle)
			self.chapterUI[2].main:addChild(self.chapterUI[2].unlock, 6)
		else
			self.chapterUI[2].unlock:setString(var_28_2)
		end
	end
end

function ActivityLayer_bianhua_Chapter:updateChapterTitle(arg_29_1)
	for iter_29_0 = 1, arg_29_1.nowChapter.id - 1 do
		if self.chapterUI[iter_29_0].level then
			self.chapterUI[iter_29_0].level:setVisible(true)
			self.chapterUI[iter_29_0].level:setString(arg_29_1.chapterTitle[iter_29_0])
		end
	end

	if self.chapterUI[arg_29_1.nowChapter.id].level and not self.chapterUI[arg_29_1.nowChapter.id].unlocktag then
		self.chapterUI[arg_29_1.nowChapter.id].level:setVisible(true)
		self.chapterUI[arg_29_1.nowChapter.id].level:setString(arg_29_1.chapterTitle[arg_29_1.nowChapter.id])
	end
end

function ActivityLayer_bianhua_Chapter:updateChapterRepeat(arg_30_1)
	local var_30_0 = arg_30_1.repeatLevel

	while 2 <= #arg_30_1.repeatLevel and 2 <= 4 do
		local var_30_1 = self.chapterUI[2]

		self.chapterUI[2].restart:setVisible(true)

		self.chapterUI[2].flag = 2

		self.chapterUI[2].restart:addTouchEventListener(function(arg_31_0, arg_31_1)
			if arg_31_1 ~= ccui.TouchEventType.ended then
				return
			end

			print("进入无限本")
			explore_manager:begin_explore({
				frameType = "bianhua",
				type = "activity",
				returnLayer = "ActivityLayer_bianhua_Chapter",
				activity_explore_id = var_30_0[var_30_1.flag].id,
				activityid = self.ActivityID,
				cancelCallback = function(arg_32_0)
					if arg_32_0 == 2 then
						global_ShowBlockWords("活动已关闭")
					elseif arg_32_0 == 3 then
						global_ShowBlockWords("活动关卡已全部完成!")
					elseif arg_32_0 == 4 then
						global_ShowBlockWords("服务端客户端数据不同步！")
					elseif arg_32_0 == 5 then
						global_ShowBlockWords("服务端客户端数据不同步！")
					elseif arg_32_0 == 7 then
						global_ShowBlockWords("探险次数已用完")
					elseif arg_32_0 == 0 then
						global_ShowBlockWords("活动探险未开放")
					end
				end
			})
		end)
		self.chapterUI[2].main:setTouchEnabled(true)
		self.chapterUI[2].main:addTouchEventListener(function(arg_33_0, arg_33_1)
			if arg_33_1 ~= ccui.TouchEventType.ended then
				return
			end

			print("进入无限本")
			explore_manager:begin_explore({
				frameType = "bianhua",
				type = "activity",
				returnLayer = "ActivityLayer_bianhua_Chapter",
				activity_explore_id = var_30_0[var_30_1.flag].id,
				activityid = self.ActivityID,
				cancelCallback = function(arg_34_0)
					if arg_34_0 == 2 then
						global_ShowBlockWords("活动已关闭")
					elseif arg_34_0 == 3 then
						global_ShowBlockWords("活动关卡已全部完成!")
					elseif arg_34_0 == 4 then
						global_ShowBlockWords("服务端客户端数据不同步！")
					elseif arg_34_0 == 5 then
						global_ShowBlockWords("服务端客户端数据不同步！")
					elseif arg_34_0 == 7 then
						global_ShowBlockWords("探险次数已用完")
					elseif arg_34_0 == 0 then
						global_ShowBlockWords("活动探险未开放")
					end
				end
			})
		end)
	end
end

function ActivityLayer_bianhua_Chapter:updateHideTaskInfo(arg_35_1)
	while 2 <= #arg_35_1.repeatLevel and 2 <= 4 do
		local var_35_0 = self.chapterUI[2]

		self.chapterUI[2].hide:setVisible(true)
		self.chapterUI[2].hide:addTouchEventListener(function(arg_36_0, arg_36_1)
			if arg_36_1 ~= ccui.TouchEventType.ended then
				return
			end

			print("弹出隐藏成就tips")
			self:createHidePanel(var_35_0.flag)
		end)
	end
end

function ActivityLayer_bianhua_Chapter:updatePhone()
	local var_37_0 = self:getExtraLevelData()

	if activity_bianhua_manager:isPhoneLight(self:getLevelId()) then
		self.phone.active:setVisible(true)

		if not self.phone.levelDetail then
			self.phone.levelTitle = cc.Label:createWithTTF("", "fonts/yanwenzi.ttf", 29)

			self.phone.levelTitle:setColor(cc.c3b(77, 127, 150))
			self.phone.levelTitle:setString("特别篇")
			self.phone.levelTitle:setAnchorPoint(cc.p(0.5, 0.5))
			self.phone.levelTitle:setPosition(self.phone.main:getContentSize().width / 2 + 2, self.phone.main:getContentSize().height / 2)
			self.phone.levelTitle:setRotation(5)
			self.phone.main:addChild(self.phone.levelTitle, 6)
		end

		local var_37_1, var_37_2 = activity_bianhua_manager:getTicketData()

		if var_37_2 < self:getTicketNum() then
			self.phone.outline:setVisible(true)
			self.phone.outline:setOpacity(0)
			self.phone.outline:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 255), cc.DelayTime:create(0.2), cc.FadeTo:create(1, 0))))
		else
			self.phone.outline:setVisible(false)
		end
	end

	self.phone.main:setTouchEnabled(true)
	self.phone.main:addTouchEventListener(function(arg_38_0, arg_38_1)
		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		print(dump(self.ChapterMsg))

		if self.ChapterMsg.nowChapter.id == 1 then
			global_ShowBlockWords("通关序章开启")
		else
			RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", self.levelModeid)
			LayerManager:pushInLayer("AdventureNewDetailLayer", {
				name = "bianhua",
				data = var_37_0,
				times = times
			})
		end
	end)
end

function ActivityLayer_bianhua_Chapter:updateChangeAni(arg_39_1)
	if self:getAniState() == var_0_13 then
		self.chapterUI[arg_39_1.nowChapter.id - 1].clear:setScale(5)

		if self.chapterUI[arg_39_1.nowChapter.id - 1].restart then
			self.chapterUI[arg_39_1.nowChapter.id - 1].restart:setOpacity(0)
		end

		self.chapterUI[arg_39_1.nowChapter.id - 1].clear:runAction(cc.Sequence:create(cc.ScaleTo:create(0.5, 1)))

		if self.chapterUI[arg_39_1.nowChapter.id - 1].restart then
			self.chapterUI[arg_39_1.nowChapter.id - 1].restart:runAction(cc.Sequence:create(cc.FadeTo:create(150, 255)))
		end
	end
end

function ActivityLayer_bianhua_Chapter.gotoTalk(arg_40_0, arg_40_1)
	local var_40_0 = activity_bianhua_manager:getTalkConfig(arg_40_1.chapterTitle[arg_40_1.nowChapter.id])

	print("对话——————————————————————————————", dump(var_40_0))

	local function var_40_1()
		print("刷新UI回调")
		arg_40_0:updateData()
	end

	global_basic_scene:addChild(TalkLayer:create(var_40_0.talkid, nil, 1, "", function()
		activity_bianhua_manager:finishLevelTalkById(var_40_0.levelid, var_40_1)
	end))
end

function ActivityLayer_bianhua_Chapter:gotoExplore(arg_43_1)
	local var_43_0 = activity_bianhua_manager:getExploreConfig(arg_43_1.chapterTitle[arg_43_1.nowChapter.id])

	print("探险——————————————————————————————", dump(var_43_0))
	explore_manager:begin_explore({
		frameType = "bianhua",
		type = "activity",
		returnLayer = "ActivityLayer_bianhua_Chapter",
		activity_explore_id = var_43_0.levelid,
		activityid = self.ActivityID,
		cancelCallback = function(arg_44_0)
			if arg_44_0 == 2 then
				global_ShowBlockWords("活动已关闭")
			elseif arg_44_0 == 3 then
				global_ShowBlockWords("活动关卡已全部完成!")
			elseif arg_44_0 == 4 then
				global_ShowBlockWords("服务端客户端数据不同步！")
			elseif arg_44_0 == 5 then
				global_ShowBlockWords("服务端客户端数据不同步！")
			elseif arg_44_0 == 0 then
				global_ShowBlockWords("活动探险未开放")
			end
		end
	})
end

function ActivityLayer_bianhua_Chapter:createHidePanel(arg_45_1)
	local var_45_0 = ccui.Layout:create()

	var_45_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_45_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_45_0:setAnchorPoint(0, 0)
	var_45_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_45_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_45_0:setBackGroundColorOpacity(180)
	self.rootLayer:addChild(var_45_0, 99)

	local var_45_1 = ccui.Layout:create()

	var_45_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_45_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_45_1:setAnchorPoint(0.5, 0.5)
	var_45_1:setPosition(var_45_0:getContentSize().width / 2, var_45_0:getContentSize().height / 2)
	var_45_0:addChild(var_45_1, 2)

	local var_45_2 = ccui.ImageView:create("Activity_bianhua_Chapter/hide_panel.png", var_0_9)

	var_45_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_45_2:setPosition(var_45_0:getContentSize().width / 2, var_45_0:getContentSize().height / 2)

	local var_45_3 = cc.Label:createWithTTF("", "fonts/name.ttf", 22)

	var_45_3:setDimensions(240, 100)
	var_45_3:setAnchorPoint(cc.p(0, 0.5))
	var_45_3:setColor(cc.c3b(0, 0, 0))
	var_45_3:setPosition(140, var_45_2:getContentSize().height / 2 + 10)
	var_45_3:setString(self.hideTaskDes[arg_45_1][1])
	var_45_2:addChild(var_45_3)

	local var_45_4 = cc.Label:createWithTTF("", "fonts/name.ttf", 22)

	var_45_4:setDimensions(240, 100)
	var_45_4:setAnchorPoint(cc.p(0, 0.5))
	var_45_4:setColor(cc.c3b(0, 0, 0))
	var_45_4:setPosition(140, var_45_2:getContentSize().height / 2 - 105)
	var_45_4:setString(self.hideTaskDes[arg_45_1][2])
	var_45_2:addChild(var_45_4)
	var_45_0:setTouchEnabled(true)
	var_45_1:setTouchEnabled(false)
	var_45_2:setScale(0)
	var_45_0:addChild(var_45_2, 10)
	var_45_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2), cc.ScaleTo:create(0.1, 1), cc.CallFunc:create(function()
		var_45_0:addTouchEventListener(function(arg_47_0, arg_47_1)
			if arg_47_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_45_1:setTouchEnabled(true)
			var_45_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1.2), cc.ScaleTo:create(0.2, 0), cc.CallFunc:create(function()
				var_45_0:runAction(cc.RemoveSelf:create())
			end)))
		end)
	end)))
end

function ActivityLayer_bianhua_Chapter:fullScreen()
	local var_49_0 = self.rootLayer:getChildByName("titleBg")

	var_49_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 0, TRANSFORM_UNIT.PX)

	var_49_0:setPositionY(var_49_0.full_posY)

	self.imgBg.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, GameDisplay.height * 0.48, TRANSFORM_UNIT.PX)

	self.imgBg:setPositionY(self.imgBg.full_posY)

	self.bottomlist.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomlist:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomlist:setPositionY(self.bottomlist.full_posY)
end

function ActivityLayer_bianhua_Chapter.setLevelId(arg_50_0, arg_50_1)
	arg_50_0.levelId = arg_50_1
end

function ActivityLayer_bianhua_Chapter:getLevelId()
	return self.levelId
end

function ActivityLayer_bianhua_Chapter.setTotalDailyTimes(arg_52_0, arg_52_1)
	arg_52_0.dailyCount = arg_52_1
end

function ActivityLayer_bianhua_Chapter:getTotalDailyTimes()
	return self.dailyCount
end

function ActivityLayer_bianhua_Chapter.setBuyTimes(arg_54_0, arg_54_1)
	arg_54_0.buyCount = arg_54_1
end

function ActivityLayer_bianhua_Chapter:getBuyTimes()
	return self.buyCount
end

function ActivityLayer_bianhua_Chapter.setAniState(arg_56_0, arg_56_1)
	arg_56_0.aniState = arg_56_1
end

function ActivityLayer_bianhua_Chapter:getAniState()
	return self.aniState
end

function ActivityLayer_bianhua_Chapter:getExtraLevelData()
	return self.extraLevelData
end

function ActivityLayer_bianhua_Chapter:setChapterUnlock(arg_59_1)
	local var_59_0 = self:getLevelId()
	local var_59_1 = RoleDefault:getInstance():getIntegerForKey("ActivityBianhuaChapter", arg_59_1.nowChapter.id)

	if var_59_1 then
		if var_59_1 < arg_59_1.nowChapter.id then
			RoleDefault:getInstance():setIntegerForKey("ActivityBianhuaChapter", arg_59_1.nowChapter.id)
			self:setAniState(var_0_13)
		elseif RoleDefault:getInstance():getIntegerForKey("ActivityBianhuaLevel", var_59_0) < var_59_0 then
			RoleDefault:getInstance():setIntegerForKey("ActivityBianhuaLevel", var_59_0)
			self:setAniState(var_0_14)
		else
			self:setAniState(var_0_12)
		end
	end
end

function ActivityLayer_bianhua_Chapter.setIfChapterFinish(arg_60_0, arg_60_1)
	if arg_60_1.finish_step == activity_bianhua_manager:getDataLength() then
		arg_60_0.finish = true
	end
end

function ActivityLayer_bianhua_Chapter:getIfChapterFinish()
	return self.finish
end

function ActivityLayer_bianhua_Chapter:getUnlockTime()
	return self.unlockTime
end

function ActivityLayer_bianhua_Chapter.setTicketNum(arg_63_0)
	arg_63_0.ticketNum = item_manager:getItemNumber((activity_bianhua_manager:getTicketData()))
end

function ActivityLayer_bianhua_Chapter:getTicketNum()
	return self.ticketNum
end
