local MonopolyEventHistoryLayer = class("MonopolyEventHistoryLayer", (require("view.Layer.BaseUILayer")))
local var_0_1 = require("controller.monopoly.monopoly_manager"):getInstance()
local texture_manager = require("controller.texture_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_5
local RichTextPro = require("view.Sprite.RichTextPro")

function MonopolyEventHistoryLayer:ctor()
	var_0_5 = "Monopoly_" .. var_0_1:getActivityId() .. "/MonopolyEventHistoryLayer/"

	MonopolyEventHistoryLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/monopoly/monopoly_event_history_manager"):getInstance()
end

function MonopolyEventHistoryLayer:create(arg_2_1)
	texture_manager:loadPopLayerTextures({
		"Monopoly_" .. var_0_1:getActivityId() .. "_MonopolyEventHistoryLayer"
	})

	local var_2_0 = MonopolyEventHistoryLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function MonopolyEventHistoryLayer:onEnter()
	MonopolyEventHistoryLayer.super.onEnter(self)
end

function MonopolyEventHistoryLayer:onExit()
	MonopolyEventHistoryLayer.super.onExit(self)
end

function MonopolyEventHistoryLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function MonopolyEventHistoryLayer:initLayer()
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

	var_6_2:setContentSize(cc.size(var_6_1:size().w - 40, var_6_1:size().h - (var_0_1:getActivityId() == 865 and 290 or 170)))
	var_6_2:align(cc.p(0.5, 0), var_6_1:size().w / 2, 20)

	self._listView = var_6_2

	local var_6_3 = self.manager:getShowInfo()

	self:initListView()
end

function MonopolyEventHistoryLayer:initListener()
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function MonopolyEventHistoryLayer:initListView()
	local var_10_0 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_10_1 = self._listView
	local var_10_2 = cc.size(self._listView:size().w, 70)
	local var_10_3 = self.manager:getShowInfo()

	for iter_10_0 = 1, #var_10_3 do
		local var_10_5 = TempWidget:CreateTempLayout()

		var_10_5:setContentSize(var_10_2)

		local var_10_6 = var_10_3[iter_10_0]
		local var_10_7 = ""

		if var_10_3[iter_10_0].target == var_10_0.EVENTS_TARGET_TYPE.AI then
			var_10_7 = var_0_5 .. "ai.png"
		elseif var_10_3[iter_10_0].target == var_10_0.EVENTS_TARGET_TYPE.PLAYER then
			var_10_7 = var_0_5 .. "player.png"
		end

		local var_10_8 = TempWidget:CreateTempImg(var_10_7, var_10_5)

		var_10_8:center()

		local var_10_9 = RichTextPro:create()

		var_10_9:setMaxWidth(var_10_8:size().w - 120)
		var_10_9:setSize(21)
		var_10_9:setText(var_10_6.str)
		var_10_8:addChild(var_10_9)
		var_10_9:setPosition(90, var_10_8:size().h - 20)
		var_10_1:pushBackCustomItem(var_10_5)
	end

	performWithDelay(var_10_1, function()
		var_10_1:jumpToBottom()
	end, 0.016666666666666666)
end

function MonopolyEventHistoryLayer:updateLayer()
	return
end

function MonopolyEventHistoryLayer:updateRed()
	return
end

return MonopolyEventHistoryLayer
