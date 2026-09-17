local UrbanDefenseAchievementLayer = class("UrbanDefenseAchievementLayer", (require("view.Layer.BaseUILayer")))
local texture_manager = require("controller.texture_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = "UrbanDefenseAchievementLayer_%s/"

function UrbanDefenseAchievementLayer:ctor()
	UrbanDefenseAchievementLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/urban_defense_achievement_manager"):getInstance()

	self.manager:registerNotification("UrbanDefenseAchievementRewardGet", function(arg_2_0)
		self:getReward(arg_2_0)
	end)
end

function UrbanDefenseAchievementLayer:create(arg_3_1)
	local var_3_0 = UrbanDefenseAchievementLayer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function UrbanDefenseAchievementLayer:onEnter()
	UrbanDefenseAchievementLayer.super.onEnter(self)
end

function UrbanDefenseAchievementLayer:onExit()
	UrbanDefenseAchievementLayer.super.onExit(self)

	if not config._DEBUG then
		texture_manager:unloadPopLayerTextures()
	end
end

function UrbanDefenseAchievementLayer:init(arg_6_1)
	self:initData(arg_6_1)
	self:initLayer()
	self:initListener()

	return true
end

function UrbanDefenseAchievementLayer:initData(arg_7_1)
	self._id = arg_7_1.activityId
	var_0_4 = string.format(var_0_4, self._id)

	if not config._DEBUG then
		texture_manager:loadPopLayerTextures({
			"UrbanDefenseAchievementLayer_" .. self._id
		})
	end
end

function UrbanDefenseAchievementLayer:initLayer()
	local var_8_0 = TempWidget:CreateTempLayout(self)

	var_8_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_8_0

	TempWidget:CreateTempImg(var_0_4 .. "bg.png", var_8_0):center()

	local var_8_1 = TempWidget:CreateTempImg(var_0_4 .. "bottom_bg.png", var_8_0)

	var_8_1:align(cc.p(0, 0), 0, 0)

	local var_8_2 = TempWidget:CreateTempBtn(var_0_4 .. "back_btn.png", var_8_1)

	var_8_2:align(cc.p(0, 0.5), 10, var_8_1:size().h / 2)

	self._backBtn = var_8_2

	local var_8_3 = TempWidget:CreateTempListView(var_8_0)

	var_8_3:setContentSize(cc.size(var_8_0:size().w, var_8_0:size().h - var_8_1:size().h - 20))
	var_8_3:align(cc.p(0, 0), 0, var_8_1:size().h)

	self._listView = var_8_3

	self:initListView()
end

function UrbanDefenseAchievementLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
	self._backBtn:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function UrbanDefenseAchievementLayer:initListView()
	local var_12_0 = self.manager:getData()

	for iter_12_0 = 1, #var_12_0 do
		self._listView:pushBackCustomItem((self:createCell(var_12_0[iter_12_0], iter_12_0)))
	end
end

function UrbanDefenseAchievementLayer:createCell(arg_13_1, arg_13_2)
	local var_13_0 = TempWidget:CreateTempLayout()

	var_13_0:setContentSize(cc.size(self._root:size().w, 146))

	var_13_0._taskId = arg_13_1.taskid

	var_13_0:setOpacity(0)
	var_13_0:runAction(cc.FadeIn:create(0.1 + 0.05 * (arg_13_2 - 1)))

	local var_13_1 = ""

	if arg_13_1.status == 0 and arg_13_1.finished == 0 then
		var_13_1 = var_0_4 .. "cell1.png"
	elseif arg_13_1.status == 0 and arg_13_1.finished == 1 then
		var_13_1 = var_0_4 .. "cell2.png"
	elseif arg_13_1.status == 1 then
		var_13_1 = var_0_4 .. "cell3.png"
	end

	local var_13_2 = TempWidget:CreateTempImg(var_13_1, var_13_0)

	var_13_2:center()

	var_13_0._bg = var_13_2

	local var_13_3 = TempWidget:CreateTempLabel(arg_13_1.taskDes, FONT_DES, 20, var_13_0)

	var_13_3:align(cc.p(0, 0.5), 123, var_13_0:size().h / 2 + 35)

	local var_13_4 = TempWidget:CreateTempLabel("x" .. arg_13_1.need, FONT_DES, 18, var_13_0)

	var_13_4:align(cc.p(0, 0.5), var_13_3:pos().x - 30, var_13_0:size().h / 2 - 35)

	local var_13_5 = TempWidget:CreateTempImg(var_0_4 .. "progress_task_bg.png", var_13_0)

	var_13_5:align(cc.p(0, 0.5), var_13_4:pos().x + 90, var_13_0:size().h / 2 - 35)

	local var_13_6 = cc.ProgressTimer:create(cc.Sprite:create(var_0_4 .. "progress_task.png"))

	var_13_6:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_13_6:setMidpoint(cc.p(0, 1))
	var_13_6:setBarChangeRate(cc.p(0, 1))
	var_13_6:setPercentage(arg_13_1.percent)
	var_13_6:setAnchorPoint(cc.p(0, 0.5))
	var_13_6:setPosition(cc.p(var_13_5:pos().x, var_13_5:pos().y))
	var_13_0:addChild(var_13_6)
	TempWidget:CreateTempLabel(arg_13_1.percent .. "%", FONT_DES, 18, var_13_0):align(cc.p(1, 0), var_13_5:pos().x + var_13_5:size().w, var_13_5:pos().y + var_13_5:size().h / 2)

	local var_13_7 = TempWidget:CreateTempLayout(var_13_0)

	var_13_7:setContentSize(cc.size(175, 60))
	var_13_7:align(cc.p(0.5, 0.5), var_13_0:size().w - 100, var_13_0:size().h / 2)
	var_13_7:_addEvent(function()
		local var_14_0 = self.manager:getData()[arg_13_2]

		if var_14_0.status == 0 and var_14_0.finished == 0 then
			goto_complete_system({
				jump_to_system = arg_13_1.jump
			})
		elseif var_14_0.status == 0 and var_14_0.finished == 1 then
			var_13_1 = var_0_4 .. "cell2.png"
		end
	end)

	return var_13_0
end

function UrbanDefenseAchievementLayer:updateLayer()
	return
end

function UrbanDefenseAchievementLayer:updateRed()
	return
end

function UrbanDefenseAchievementLayer:getReward(arg_17_1)
	local var_17_0 = self._listView:getItems()

	for iter_17_0 = 1, #var_17_0 do
		if var_17_0[iter_17_0]._taskId == arg_17_1.taskId then
			var_17_0[iter_17_0]._bg:loadTexture(var_0_4 .. "cell3.png", var_0_3)

			break
		end
	end
end

return UrbanDefenseAchievementLayer
