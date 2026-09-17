local ActivityGarrisonLayer = class("ActivityGarrisonLayer", (require("view.Layer.BaseUILayer")))
local TableViewEx = require("view.Sprite.TableViewEx")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = ""
local texture_manager = require("controller.texture_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_conf_data = require("data/activity_conf_data")
local var_0_9 = 0
local var_0_10 = 0
local var_0_11 = 150
local var_0_12 = 220

function ActivityGarrisonLayer:ctor()
	ActivityGarrisonLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/activity_garrison/activity_garrison_manager"):getInstance()
end

function ActivityGarrisonLayer:create(arg_2_1)
	local var_2_0 = ActivityGarrisonLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function ActivityGarrisonLayer:onEnter()
	ActivityGarrisonLayer.super.onEnter(self)
	self.manager:requestInfo(self._id)
	self.manager:registerNotification("ActivityGarrisonStart", function()
		self:updateTableView()
	end)
	self.manager:registerNotification("ActivityGarrisonFinish", function()
		self:updateTableView()
	end)
	self.manager:registerNotification("ActivityGarrisonTaskGetReward", function()
		self:updateTableView()
		self:updateTaskLevelText()
	end)
end

function ActivityGarrisonLayer:onExit()
	ActivityGarrisonLayer.super.onExit(self)

	if not config._DEBUG then
		texture_manager:removeLayerTextures({
			string.format("ActivityGarrisonLayer_%s", self._id)
		})
		texture_manager:unloadPopLayerTextures()
	end
end

function ActivityGarrisonLayer:init(arg_8_1)
	self:initData(arg_8_1)
	self:initLayer()
	self:initListener()

	return true
end

function ActivityGarrisonLayer:initData(arg_9_1)
	self._id = arg_9_1.activityId
	var_0_4 = string.format("ActivityGarrisonLayer_%s/", self._id)

	if not config._DEBUG then
		texture_manager:loadLayerTextures({
			string.format("ActivityGarrisonLayer_%s", self._id)
		})
	end
end

function ActivityGarrisonLayer:initLayer()
	local var_10_0 = TempWidget:CreateTempLayout(self)

	var_10_0:_setBack()
	var_10_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_10_0
	var_0_9 = var_10_0:size().w

	TempWidget:CreateTempImg(var_0_4 .. "bg.png", var_10_0):center()

	local var_10_1 = TempWidget:CreateTempImg(var_0_4 .. "title.png", var_10_0)

	var_10_1:align(cc.p(0, 1), 0, var_10_0:size().h - 40)

	self._title = var_10_1

	local var_10_2 = TempWidget:CreateTempLabel(L_ACTIVITY_GARRISON[25], FONT_NAME, 19, var_10_1)

	var_10_2:align(cc.p(0, 0.5), 60, var_10_1:size().h / 2 - 33.5)

	self._remainText = var_10_2

	self:updateRemainText()

	local var_10_3 = TempWidget:CreateTempImg(var_0_4 .. "bottom.png", var_10_0)

	var_10_3:align(cc.p(0.5, 0), var_10_0:size().w / 2, 0)

	self._bottom = var_10_3
	var_0_10 = var_10_1:pos().y - var_10_1:size().h - 40 - var_10_3:size().h - 50

	local var_10_4 = TempWidget:CreateTempBtn(var_0_4 .. "task_btn.png", var_10_0)

	var_10_4:align(cc.p(0, 1), 0, var_10_1:pos().y - var_10_1:size().h - 10)
	var_10_4:setLocalZOrder(989)

	self._taskBtn = var_10_4

	local var_10_5 = TempWidget:CreateTempLabel("0", FONT_W5, 40, var_10_4:getVirtualRenderer())

	var_10_5:_setColor("00ffff")
	var_10_5:align(cc.p(0, 0.5), 75, var_10_4:getVirtualRenderer():getContentSize().height / 2 + 15)

	self._taskLevelText = var_10_5

	self:updateTaskLevelText()

	local var_10_6 = TempWidget:CreateTempBtn("public/button/bottom_return_btn_archives.png", var_10_3)

	var_10_6:align(cc.p(0, 0.5), 20, var_10_3:size().h / 2)

	self._backBtn = var_10_6

	local var_10_7 = TempWidget:CreateTempBtn(var_0_4 .. "get_all_reward.png", var_10_3)

	var_10_7:align(cc.p(1, 0.5), var_10_3:size().w - 20, var_10_3:size().h / 2)

	self._getAllRewardBtn = var_10_7
end

function ActivityGarrisonLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
	self._backBtn:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self._getAllRewardBtn:_addEvent(function()
		self.manager:requestFinish(self._id)
	end)
	self._bottom:_addEvent(function()
		return
	end)
	self._taskBtn:_addEvent(function()
		LayerManager:pushInLayer("ActivityGarrisonTaskLayer", {
			activityId = self._id
		})
	end)
	self._title:_addEvent(function()
		LayerManager:pushInLayer("PopActivityDetail", {
			key = "activity_garrison_" .. self._id
		})
	end)
end

function ActivityGarrisonLayer:getRealTableViewHeight()
	return var_0_11 + var_0_12 * (self.manager:getGarrisonNum(self._id) - 1)
end

function ActivityGarrisonLayer:getTableView()
	local var_19_0 = self.manager:getGarrisonNum(self._id)
	local var_19_1 = self:getRealTableViewHeight()

	var_0_10 = var_19_1 < var_0_10 and var_19_1 or var_19_1

	local var_19_2 = cc.TableView:create(cc.size(var_0_9, var_0_10))

	var_19_2:setVerticalFillOrder(cc.TABLEVIEW_FILL_BOTTOMUP)
	var_19_2:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_19_2:setDelegate()
	var_19_2:registerScriptHandler(function()
		return var_19_0
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_19_2:registerScriptHandler(function(arg_21_0, arg_21_1)
		return var_0_9, (arg_21_1 + 1 < var_19_0 or nil) and (var_0_12 or var_0_11)
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_19_2:registerScriptHandler(function(arg_22_0, arg_22_1)
		return self:getCellLayout(arg_22_0, arg_22_1)
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_19_2:reloadData()
	var_19_2:scrollToPercent(0, 0, false)

	return var_19_2
end

function ActivityGarrisonLayer:getCellLayout(arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1:dequeueCell()

	if not var_23_0 then
		var_23_0 = cc.TableViewCell:new()
	else
		var_23_0:removeAllChildren()
	end

	if (arg_23_2 + 1) % 2 == 0 then
		if arg_23_2 + 1 == #self._levelInfo then
			var_23_0:addChild((self:createLeftCellNoLine(arg_23_1, arg_23_2)))
		else
			var_23_0:addChild((self:createLeftCell(arg_23_1, arg_23_2)))
		end
	elseif arg_23_2 + 1 == #self._levelInfo then
		var_23_0:addChild((self:createRightCellNoLine(arg_23_1, arg_23_2)))
	else
		var_23_0:addChild((self:createRightCell(arg_23_1, arg_23_2)))
	end

	return var_23_0
end

function ActivityGarrisonLayer:createLeftCell(arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2 + 1
	local var_24_1 = TempWidget:CreateTempLayout()

	var_24_1:setContentSize(var_0_9, var_0_12)

	local var_24_2 = self:createCellInfo(arg_24_1, arg_24_2)

	var_24_2:setLocalZOrder(10)
	var_24_1:addChild(var_24_2)
	var_24_2:align(cc.p(0, 0), 30, -14)

	local var_24_3 = TempWidget:CreateTempImg(var_0_4 .. "left_line.png", var_24_1)

	var_24_3:align(cc.p(0, 0), var_24_2:pos().x + var_24_2:size().w - 60, var_24_2:pos().y + var_24_2:size().h - 48)
	var_24_3:setLocalZOrder(var_24_2:getLocalZOrder() - 1)

	function var_24_1._update()
		var_24_2._update(var_24_0)
	end

	var_24_1._update()

	return var_24_1
end

function ActivityGarrisonLayer:createLeftCellNoLine(arg_26_1, arg_26_2)
	local var_26_0 = arg_26_2 + 1
	local var_26_1 = TempWidget:CreateTempLayout()

	var_26_1:setContentSize(var_0_9, var_0_11)

	local var_26_2 = self:createCellInfo(arg_26_1, arg_26_2)

	var_26_1:addChild(var_26_2)
	var_26_2:align(cc.p(0, 0), 30, -14)

	function var_26_1._update()
		var_26_2._update(var_26_0)
	end

	var_26_1._update()

	return var_26_1
end

function ActivityGarrisonLayer:createRightCell(arg_28_1, arg_28_2)
	local var_28_0 = arg_28_2 + 1
	local var_28_1 = TempWidget:CreateTempLayout()

	var_28_1:setContentSize(var_0_9, var_0_12)

	local var_28_2 = self:createCellInfo(arg_28_1, arg_28_2)

	var_28_2:setLocalZOrder(10)
	var_28_1:addChild(var_28_2)
	var_28_2:align(cc.p(1, 0), var_28_1:size().w - 30, -14)

	local var_28_3 = TempWidget:CreateTempImg(var_0_4 .. "right_line.png", var_28_1)

	var_28_3:align(cc.p(1, 0), var_28_2:pos().x - var_28_2:size().w + 29, var_28_2:pos().y + var_28_2:size().h - 30)
	var_28_3:setLocalZOrder(var_28_2:getLocalZOrder() - 1)

	function var_28_1._update()
		var_28_2._update(var_28_0)
	end

	var_28_1._update()

	return var_28_1
end

function ActivityGarrisonLayer:createRightCellNoLine(arg_30_1, arg_30_2)
	local var_30_0 = arg_30_2 + 1
	local var_30_1 = TempWidget:CreateTempLayout()

	var_30_1:setContentSize(var_0_9, var_0_11)

	local var_30_2 = self:createCellInfo(arg_30_1, arg_30_2)

	var_30_1:addChild(var_30_2)
	var_30_2:align(cc.p(1, 0), var_30_1:size().w - 30, -14)

	function var_30_1._update()
		var_30_2._update(var_30_0)
	end

	var_30_1._update()

	return var_30_1
end

function ActivityGarrisonLayer:createCellInfo(arg_32_1, arg_32_2)
	local var_32_0 = arg_32_2 + 1
	local var_32_1 = TempWidget:CreateTempBtn(var_0_4 .. "garrison_lock.png")

	var_32_1:_addEvent(function()
		local var_33_0 = self._levelInfo[var_32_0].getSataus()

		if var_33_0 == self.manager.STATUS.LOCK then
			global_ShowBlockWords(L_ACTIVITY_GARRISON[13])
		elseif var_33_0 == self.manager.STATUS.DELAY then
			LayerManager:pushInLayer("ActivityGarrisonSelectLayer", {
				activityId = self._id,
				index = var_32_0
			})
		elseif var_33_0 == self.manager.STATUS.DOING then
			LayerManager:pushInLayer("PopDoLayer", {
				labels = {
					isHorizonalCenter = true,
					title = L_ACTIVITY_GARRISON[16],
					des = L_ACTIVITY_GARRISON[15],
					button = L_BATTLEPASS_BUY.button
				},
				surecallback = function()
					self.manager:requestFinish(self._id, var_32_0)
				end
			})
		elseif var_33_0 == self.manager.STATUS.COMPLETE then
			self.manager:requestFinish(self._id, var_32_0)
		end
	end)
	var_32_1:setSwallowTouches(false)

	local var_32_2 = TempWidget:CreateTempLabel("", FONT_NAME, 30, var_32_1:getVirtualRenderer())

	var_32_2:align(cc.p(0, 0.5), 65, var_32_1:size().h - 23)

	local var_32_3 = TempWidget:CreateTempLayout(var_32_1:getVirtualRenderer())

	var_32_3:setContentSize(cc.size(var_32_1:size().w - 50, var_32_1:size().h - 55))
	var_32_3:align(cc.p(0.5, 0.5), var_32_1:size().w / 2 + 10, var_32_1:size().h / 2 - 10)
	var_32_3:setBackGroundColorOpacity(200)

	local var_32_4 = TempWidget:CreateTempLayout(var_32_3)

	var_32_4:setContentSize(var_32_3:size())

	local var_32_5 = TempWidget:CreateTempLabel(L_ACTIVITY_GARRISON[1], FONT_NAME, 30, var_32_4)

	var_32_5:align(cc.p(0.5, 0.5), var_32_4:size().w / 2, var_32_4:size().h / 2 + 15)
	var_32_5:_setColor("aeb0ce")

	local var_32_6 = TempWidget:CreateTempLabel(string.format(L_ACTIVITY_GARRISON[2], self._levelInfo[arg_32_2 + 1].unlock_level), FONT_NAME, 24, var_32_4)

	var_32_6:align(cc.p(0.5, 0.5), var_32_4:size().w / 2, var_32_4:size().h / 2 - 20)
	var_32_6:_setColor("aeb0ce")

	local var_32_7 = TempWidget:CreateTempLayout(var_32_3)

	var_32_7:setContentSize(var_32_3:size())

	local var_32_8 = TempWidget:CreateTempLabel(L_ACTIVITY_GARRISON[3], FONT_NAME, 30, var_32_7)

	var_32_8:align(cc.p(0.5, 0.5), var_32_7:size().w / 2, var_32_7:size().h / 2)
	var_32_8:_setColor("00ffff")

	local var_32_9 = TempWidget:CreateTempLayout(var_32_3)

	var_32_9:setContentSize(var_32_3:size())

	local var_32_10 = TempWidget:CreateTempLabel(L_ACTIVITY_GARRISON[4], FONT_NAME, 24, var_32_9)

	var_32_10:align(cc.p(0.5, 0.5), var_32_9:size().w / 2, var_32_9:size().h / 2 + 20)
	var_32_10:_setColor("b085ff")

	local var_32_11 = TempWidget:CreateTempLabel("99:99:99", FONT_NAME, 30, var_32_9)

	var_32_11:align(cc.p(0.5, 0.5), var_32_9:size().w / 2, var_32_9:size().h / 2 - 15)
	var_32_11:_setColor("f9f6ff")

	local var_32_12 = TempWidget:CreateTempLayout(var_32_3)

	var_32_12:setContentSize(var_32_3:size())

	local var_32_13 = TempWidget:CreateTempLabel(L_ACTIVITY_GARRISON[5], FONT_NAME, 30, var_32_12)

	var_32_13:align(cc.p(0.5, 0.5), var_32_12:size().w / 2, var_32_12:size().h / 2)
	var_32_13:_setColor("f9f6ff")

	function var_32_1._update(arg_35_0)
		var_32_2:setString(self._levelInfo[arg_35_0].name_garrison)

		local var_35_0 = self._levelInfo[arg_35_0].getSataus()
		local var_35_1 = ""

		if var_35_0 == self.manager.STATUS.LOCK then
			var_35_1 = var_0_4 .. "garrison_lock.png"
		elseif var_35_0 == self.manager.STATUS.DELAY then
			var_35_1 = var_0_4 .. "garrison_delay.png"
		elseif var_35_0 == self.manager.STATUS.DOING then
			var_35_1 = var_0_4 .. "garrison_doing.png"
		elseif var_35_0 == self.manager.STATUS.COMPLETE then
			var_35_1 = var_0_4 .. "garrison_complete.png"
		end

		var_32_1:loadTextureNormal(var_35_1, var_0_3)
		var_32_4:setVisible(var_35_0 == self.manager.STATUS.LOCK)
		var_32_7:setVisible(var_35_0 == self.manager.STATUS.DELAY)
		var_32_9:setVisible(var_35_0 == self.manager.STATUS.DOING)
		var_32_12:setVisible(var_35_0 == self.manager.STATUS.COMPLETE)
		var_32_11:stopAllActions()

		if var_35_0 == self.manager.STATUS.DOING then
			var_32_11:setString(self._levelInfo[arg_35_0].getReaminTimeStr())
			schedule(var_32_11, function()
				if self._levelInfo[arg_35_0].getSataus() == self.manager.STATUS.COMPLETE then
					var_32_1._update(arg_35_0)
				else
					var_32_11:setString(self._levelInfo[arg_35_0].getReaminTimeStr())
				end
			end, 1)
		end
	end

	var_32_1._update(arg_32_2 + 1)

	return var_32_1
end

function ActivityGarrisonLayer:updateLayer()
	self._levelInfo = self.manager:getLevelInfo(self._id)

	local var_37_0 = self:getTableView()

	self._root:addChild(var_37_0)
	var_37_0:setPosition(0, self._bottom:pos().y + self._bottom:size().h + 50)
	self._bottom:setLocalZOrder(var_37_0:getLocalZOrder() + 1)
	self._title:setLocalZOrder(var_37_0:getLocalZOrder() + 1)

	self._tableView = var_37_0
end

function ActivityGarrisonLayer:updateRed()
	return
end

function ActivityGarrisonLayer:updateTableView()
	self._tableView:reloadData()
end

function ActivityGarrisonLayer:updateTaskLevelText()
	self._taskLevelText:setString(self.manager:getTaskLevel(self._id))
end

function ActivityGarrisonLayer:updateRemainText()
	self._remainText:setString(string.format(L_ACTIVITY_GARRISON[25], (Global_format_time_str(global_get_time_by_date(activity_conf_data[self._id].finishtime) - time_check_manager:getCurTime()))))
end

return ActivityGarrisonLayer
