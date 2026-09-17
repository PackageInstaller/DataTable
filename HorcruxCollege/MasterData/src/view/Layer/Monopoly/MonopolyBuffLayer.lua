local MonopolyBuffLayer = class("MonopolyBuffLayer", (require("view.Layer.BaseUILayer")))
local var_0_1 = require("controller.monopoly.monopoly_manager"):getInstance()
local texture_manager = require("controller.texture_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_5

function MonopolyBuffLayer:ctor()
	var_0_5 = "Monopoly_" .. var_0_1:getActivityId() .. "/MonopolyBuffLayer/"

	MonopolyBuffLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.monopoly.monopoly_buff_manager"):getInstance()
end

function MonopolyBuffLayer:create(arg_2_1)
	texture_manager:loadPopLayerTextures({
		"Monopoly_" .. var_0_1:getActivityId() .. "_MonopolyBuffLayer"
	})

	local var_2_0 = MonopolyBuffLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function MonopolyBuffLayer:onEnter()
	MonopolyBuffLayer.super.onEnter(self)
end

function MonopolyBuffLayer:onExit()
	MonopolyBuffLayer.super.onExit(self)
end

function MonopolyBuffLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function MonopolyBuffLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:_setBack()
	var_6_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_6_0:setBackGroundColorOpacity(100)
	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	local var_6_1 = TempWidget:CreateTempImg(var_0_5 .. "bg.png", var_6_0)

	var_6_1:align(cc.p(0.5, 0.5), var_6_0:size().w / 2, var_6_0:size().h / 2 + 50)
	var_6_1:_addEvent(function()
		return
	end)

	local var_6_2 = TempWidget:CreateTempListView(var_6_1)

	var_6_2:setContentSize(cc.size(var_6_1:size().w, var_6_1:size().h - 160))
	var_6_2:align(cc.p(0.5, 0), var_6_1:size().w / 2, 20)

	self._listView = var_6_2

	self:updateListView()
end

function MonopolyBuffLayer:initListener()
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function MonopolyBuffLayer:updateListView()
	self._listView:removeAllItems()

	local var_10_0 = cc.size(self._listView:getContentSize().width, 100)
	local var_10_1 = self.manager:getBuffInfo()

	for iter_10_0 = 1, #var_10_1 do
		local var_10_2 = TempWidget:CreateTempLayout()

		var_10_2:setContentSize(var_10_0)

		local var_10_3 = ""
		local var_10_4 = ""
		local var_10_5 = var_0_5 .. "buff_bg.png"

		if var_10_1[iter_10_0].buff_or_debuff == self.manager.BUFF_TYPE.BUFF then
			var_10_5 = var_0_5 .. "buff_bg.png"
			var_10_3 = "605aff"
			var_10_4 = "605aff"
		elseif var_10_1[iter_10_0].buff_or_debuff == self.manager.BUFF_TYPE.DEBUFF then
			var_10_5 = var_0_5 .. "debuff_bg.png"
			var_10_3 = "ed52c3"
			var_10_4 = "ed52c3"
		end

		local var_10_6 = TempWidget:CreateTempImg(var_10_5, var_10_2)

		var_10_6:center()

		local var_10_7 = TempWidget:CreateTempImg("skill_new/skill/" .. var_10_1[iter_10_0].icon .. ".png", var_10_6)

		var_10_7:align(cc.p(0, 0.5), 80, 52)
		var_10_7:setScale(0.24)

		local var_10_8 = TempWidget:CreateTempLabel(var_10_1[iter_10_0].name, FONT_W5, 24, var_10_6)

		var_10_8:_setColor(var_10_4)
		var_10_8:align(cc.p(0, 0.5), 110, var_10_7:pos().y)

		local var_10_9 = TempWidget:CreateTempImg(var_0_5 .. "buff_time_bg.png", var_10_2)

		var_10_9:align(cc.p(0.5, 0.5), var_10_6:size().w + 10, var_10_6:size().h + 5)
		TempWidget:CreateTempLabel(var_10_1[iter_10_0].remain, FONT_NAME, 18, var_10_9):center()

		local var_10_10 = TempWidget:CreateTempLabel(var_10_1[iter_10_0].buff_des, FONT_NAME, 28, var_10_6)

		var_10_10:align(cc.p(0, 0), 80, 10)
		var_10_10:_setColor(var_10_3)
		var_10_10:setMaxLineWidth(var_10_6:size().w - var_10_10:pos().x - 20)
		self._listView:pushBackCustomItem(var_10_2)
	end
end

function MonopolyBuffLayer:updateLayer()
	return
end

function MonopolyBuffLayer:updateRed()
	return
end

function MonopolyBuffLayer:getBuffEvent(arg_13_1)
	self:updateListView()
end

function MonopolyBuffLayer:removeBuffsEvent(arg_14_1)
	self:updateListView()
end

function MonopolyBuffLayer:updateBuff()
	self:updateListView()
end

return MonopolyBuffLayer
