local ActivityGarrisonTaskLayer = class("ActivityGarrisonTaskLayer", (require("view.Layer.BaseUILayer")))

require("view/Sprite/RichTextPro")

local TempWidget = require("view.Sprite.TempWidget")
local var_0_3 = ""
local texture_manager = require("controller.texture_manager")
local var_0_5 = require("controller.activity_garrison.activity_garrison_manager"):getInstance()
local drop_manager = require("controller/drop_manager")
local task_data = require("data.task_data")

function ActivityGarrisonTaskLayer:ctor()
	ActivityGarrisonTaskLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/activity_garrison/activity_garrison_task_manager"):getInstance()
end

function ActivityGarrisonTaskLayer:create(arg_2_1)
	local var_2_0 = ActivityGarrisonTaskLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function ActivityGarrisonTaskLayer:onEnter()
	ActivityGarrisonTaskLayer.super.onEnter(self)
	self.manager:requestInfo(self._id)
	self.manager:registerNotification("ActivityGarrisonTaskGetReward", function()
		self:onGetReward()
	end)
end

function ActivityGarrisonTaskLayer:onExit()
	ActivityGarrisonTaskLayer.super.onExit(self)

	if not config._DEBUG then
		texture_manager:unloadPopLayerTextures()
	end
end

function ActivityGarrisonTaskLayer:init(arg_6_1)
	self:initData(arg_6_1)
	self:initLayer()
	self:initListener()

	return true
end

function ActivityGarrisonTaskLayer:initData(arg_7_1)
	self._id = arg_7_1.activityId
	var_0_3 = string.format("ActivityGarrisonTaskLayer_%s/", self._id)

	if not config._DEBUG then
		texture_manager:loadPopLayerTextures({
			string.format("ActivityGarrisonTaskLayer_%s", self._id)
		})
	end
end

function ActivityGarrisonTaskLayer:initLayer()
	local var_8_0 = TempWidget:CreateTempLayout(self)

	var_8_0:_setBack()
	var_8_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_8_0

	TempWidget:CreateTempImg(var_0_3 .. "bg.png", var_8_0):center()

	local var_8_1 = TempWidget:CreateTempImg(var_0_3 .. "title_bg.png", var_8_0)

	var_8_1:align(cc.p(0.5, 1), var_8_0:size().w / 2, var_8_0:size().h)

	local var_8_2 = TempWidget:CreateTempImg(var_0_3 .. "title.png", var_8_1)

	var_8_2:align(cc.p(0, 1), 0, var_8_1:size().h - 20)

	local var_8_3 = TempWidget:CreateTempImg(var_0_3 .. "level_bg.png", var_8_1)

	var_8_3:align(cc.p(0, 1), 0, var_8_2:pos().y - var_8_2:size().h - 10)
	TempWidget:CreateTempImg(var_0_3 .. "cur_level.png", var_8_3):align(cc.p(0, 1), 20, var_8_3:size().h - 5)

	local var_8_4 = TempWidget:CreateTempLabel("", FONT_NAME, 16, var_8_3)

	var_8_4:align(cc.p(0, 0), 10, 4)

	self._levelProText = var_8_4

	local var_8_5 = TempWidget:CreateTempLabel("", FONT_W5, 48, var_8_3)

	var_8_5:align(cc.p(1, 0.5), var_8_3:size().w - 20, var_8_3:size().h / 2)
	var_8_5:_setColor("00ffff")

	self._levelText = var_8_5

	local var_8_6 = TempWidget:CreateTempImg(var_0_3 .. "max_level.png", var_8_3)

	var_8_6:align(cc.p(0, 0), 20, 4)
	var_8_6:hide()

	self._maxLevelImg = var_8_6

	local var_8_7 = TempWidget:CreateTempImg(var_0_3 .. "level_pro_bg.png", var_8_3)

	var_8_7:align(cc.p(0, 0), 6, 0)

	local var_8_8 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_0_3 .. "level_pro.png") or cc.Sprite:createWithSpriteFrameName(var_0_3 .. "level_pro.png")))

	var_8_8:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_8_8:setMidpoint(cc.p(0, 0.5))
	var_8_8:setBarChangeRate(cc.p(1, 0))
	var_8_8:setPercentage(50)
	var_8_8:setAnchorPoint(cc.p(0, 0.5))
	var_8_8:setPosition(cc.p(0, var_8_7:size().h / 2))

	self._levelPro = var_8_8

	var_8_7:addChild(var_8_8)

	local var_8_9 = RichTextPro:create()

	var_8_9:setMaxWidth(300)
	var_8_9:setSize(21)
	var_8_9:setColor(cc.c3b(220, 251, 241))
	var_8_9:setLineSpace(0)
	var_8_9:setName("tipsText")
	var_8_9:setPosition(cc.p(10, var_8_3:pos().y - var_8_3:size().h - 10))
	var_8_9:setText(string.format(L_ACTIVITY_GARRISON[20], 5))
	var_8_1:addChild(var_8_9)

	self._tipsText = var_8_9

	local var_8_10 = TempWidget:CreateTempImg(var_0_3 .. "task_pro_bg.png", var_8_1)

	var_8_10:align(cc.p(1, 0), var_8_1:size().w, 10)

	local var_8_11 = TempWidget:CreateTempLabel(L_ACTIVITY_GARRISON[21], FONT_NAME, 28, var_8_10)

	var_8_11:_setColor("00ffff")
	var_8_11:align(cc.p(0, 0.5), 70, var_8_10:size().h / 2)

	local var_8_12 = TempWidget:CreateTempLabel("", FONT_NAME, 28, var_8_10)

	var_8_12:_setColor("00ffff")
	var_8_12:align(cc.p(1, 0.5), var_8_10:size().w - 20, var_8_11:pos().y)

	self._taskProText = var_8_12

	local var_8_13 = TempWidget:CreateTempImg(var_0_3 .. "bottom.png", var_8_0)

	var_8_13:align(cc.p(0, 0), 0, 0)

	local var_8_14 = TempWidget:CreateTempBtn("public/button/bottom_return_btn_archives.png", var_8_13)

	var_8_14:align(cc.p(0, 0.5), 20, var_8_13:size().h / 2)

	self._backBtn = var_8_14

	local var_8_15 = TempWidget:CreateTempBtn(var_0_3 .. "get_all_reward.png", var_8_13)

	var_8_15:align(cc.p(1, 0.5), var_8_13:size().w - 20, var_8_13:size().h / 2)

	self._getAllRewardBtn = var_8_15

	local var_8_16 = TempWidget:CreateTempListView(var_8_0)

	var_8_16:setDirection(ccui.ScrollViewDir.vertical)
	var_8_16:setContentSize(cc.size(var_8_0:size().w, var_8_0:size().h - var_8_1:size().h - var_8_13:size().h))
	var_8_16:align(cc.p(0, 0), 0, var_8_13:size().h)

	self._taskList = var_8_16
end

function ActivityGarrisonTaskLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
	self._getAllRewardBtn:_addEvent(function()
		self.manager:requestGetAllReward(self._id)
	end)
	self._backBtn:_addEvent(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function ActivityGarrisonTaskLayer:initTaskList()
	for iter_13_0 = 1, #self.manager:getTaskInfo(self._id) do
		self._taskList:pushBackCustomItem((self:createTaskLayout()))
	end

	self:updateTaskList()
end

function ActivityGarrisonTaskLayer:createTaskLayout()
	local var_14_0 = TempWidget:CreateTempLayout()

	var_14_0:setContentSize(cc.size(self._root:size().w, 130))

	local var_14_1 = TempWidget:CreateTempImg(var_0_3 .. "task_bg.png", var_14_0)

	var_14_1:center()

	local var_14_2 = TempWidget:CreateTempBtn(var_0_3 .. "task_doing.png", var_14_1)

	var_14_2:align(cc.p(1, 0.5), var_14_1:size().w - 14, var_14_1:size().h / 2)

	local var_14_3 = TempWidget:CreateTempBtn(var_0_3 .. "task_delay.png", var_14_1)

	var_14_3:align(cc.p(1, 0.5), var_14_1:size().w - 14, var_14_1:size().h / 2)

	local var_14_4 = TempWidget:CreateTempBtn(var_0_3 .. "task_complete.png", var_14_1)

	var_14_4:align(cc.p(1, 0.5), var_14_1:size().w - 14, var_14_1:size().h / 2)

	local var_14_5 = TempWidget:CreateTempLabel(L_ACTIVITY_GARRISON[23], FONT_NAME, 20, var_14_1)

	var_14_5:align(cc.p(0, 0), 100, 15)

	local var_14_6 = TempWidget:CreateTempLabel("+1", FONT_NAME, 24, var_14_1)

	var_14_6:_setColor("00ffff")
	var_14_6:align(cc.p(0, 0), var_14_5:pos().x, var_14_5:pos().y + var_14_5:size().h + 5)

	local var_14_7 = TempWidget:CreateTempLabel("7894", FONT_NAME, 28, var_14_1)

	var_14_7:align(cc.p(0, 1), 180, var_14_1:size().h - 10)

	local var_14_8 = TempWidget:CreateTempLabel("你好的飒飒的份未发访问供货合同", FONT_NAME, 20, var_14_1)

	var_14_8:setMaxLineWidth(350)
	var_14_8:align(cc.p(0, 1), var_14_7:pos().x, var_14_7:pos().y - var_14_7:size().h)

	local var_14_9 = TempWidget:CreateTempImg(var_0_3 .. "one_task_pro_bg.png", var_14_1)

	var_14_9:align(cc.p(0, 0.5), var_14_7:pos().x, 20)

	local var_14_10 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_0_3 .. "one_task_pro.png") or cc.Sprite:createWithSpriteFrameName(var_0_3 .. "one_task_pro.png")))

	var_14_10:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_14_10:setMidpoint(cc.p(0, 0.5))
	var_14_10:setBarChangeRate(cc.p(1, 0))
	var_14_10:setPercentage(100)
	var_14_10:setPosition(var_14_9:size().w / 2, var_14_9:size().h / 2)
	var_14_9:addChild(var_14_10)

	local var_14_11 = TempWidget:CreateTempLabel("100%", FONT_NAME, 18, var_14_1)

	var_14_11:align(cc.p(0, 0.5), var_14_9:pos().x + var_14_9:size().w + 5, var_14_9:pos().y)

	function var_14_0:_update()
		local var_15_0 = self.taskid
		local var_15_1 = self.status
		local var_15_2 = task_data[self.taskid]
		local var_15_3 = drop_manager:getAllDrops(task_data[self.taskid].drop)

		var_14_6:setString("+" .. ((var_15_3[1] or nil) and var_15_3[1].dropNum))
		var_14_7:setString(task_data[self.taskid].name)
		var_14_8:setString(task_data[self.taskid].task_des)

		if var_15_1 ~= 0 then
			var_14_10:setPercentage(100)
			var_14_11:setString("100%")
		else
			var_14_10:setPercentage(self.percent)
			var_14_11:setString(self.percent .. "%")
		end

		if var_15_1 == 0 and self.percent < 100 then
			var_14_2:setVisible(true)
		else
			var_14_2:setVisible(false)
		end

		var_14_2:_addEvent(function()
			goto_complete_system({
				jump_to_system = var_15_2.jump
			})
		end)

		if var_15_1 == 0 and self.percent == 100 then
			var_14_3:setVisible(true)
		else
			var_14_3:setVisible(false)
		end

		var_14_3:_addEvent(function()
			self.manager:requestGetReward(self._id, var_15_0)
		end)

		if var_15_1 ~= 0 then
			var_14_4:setVisible(true)
		else
			var_14_4:setVisible(false)
		end

		var_14_4:_addEvent(function()
			global_ShowBlockWords(L_ACTIVITY_GARRISON[24])
		end)
	end

	return var_14_0
end

function ActivityGarrisonTaskLayer:updateLayer()
	self:updateTaskProText()
	self:initTaskList()
	self:updateTipsText()
	self:updateLevelProText()
end

function ActivityGarrisonTaskLayer:updateRed()
	return
end

function ActivityGarrisonTaskLayer:updateTaskList()
	local var_21_0 = self.manager:getTaskInfo(self._id)
	local var_21_1 = self._taskList:getItems()

	for iter_21_0 = 1, #var_21_1 do
		var_21_1[iter_21_0]._update(var_21_0[iter_21_0])
	end
end

function ActivityGarrisonTaskLayer:updateLevelProText()
	self._levelText:setString((var_0_5:getTaskLevel(self._id)))

	if var_0_5:isMaxLevel(self._id) then
		self._maxLevelImg:show()
		self._levelProText:hide()
		self._levelPro:setPercentage(100)
	else
		local var_22_0, var_22_1 = var_0_5:getTsakLevelProgress(self._id)

		self._levelProText:setString((string.format(L_ACTIVITY_GARRISON[19], var_22_0, var_22_1)))
		self._maxLevelImg:hide()
		self._levelProText:show()
		self._levelPro:setPercentage(var_22_0 / var_22_1 * 100)
	end
end

function ActivityGarrisonTaskLayer:updateTipsText()
	self._tipsText:clearText()
	self._tipsText:setText(string.format(L_ACTIVITY_GARRISON[20], var_0_5:getProConfig(self._id)[var_0_5:getTaskLevel(self._id)].go_into_battle_num2))
end

function ActivityGarrisonTaskLayer:updateTaskProText()
	local var_24_0, var_24_1 = self.manager:getTaskProgress(self._id)

	self._taskProText:setString(string.format(L_ACTIVITY_GARRISON[22], var_24_0, var_24_1))
end

function ActivityGarrisonTaskLayer:onGetReward()
	self:updateTaskProText()
	self:updateTaskList()
	self:updateTipsText()
	self:updateLevelProText()
end

return ActivityGarrisonTaskLayer
