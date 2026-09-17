local MonopolyAutoDiceSettingLayer = class("MonopolyAutoDiceSettingLayer", (require("view.Layer.BaseUILayer")))
local var_0_1 = require("controller.monopoly.monopoly_manager"):getInstance()
local texture_manager = require("controller.texture_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_5

function MonopolyAutoDiceSettingLayer:ctor()
	var_0_5 = "Monopoly_" .. var_0_1:getActivityId() .. "/MonopolyAutoDiceSettingLayer/"

	MonopolyAutoDiceSettingLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/monopoly/monopoly_auto_dice_setting_manager"):getInstance()
end

function MonopolyAutoDiceSettingLayer:create(arg_2_1)
	texture_manager:loadPopLayerTextures({
		"Monopoly_" .. var_0_1:getActivityId() .. "_MonopolyAutoDiceSettingLayer"
	})

	local var_2_0 = MonopolyAutoDiceSettingLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function MonopolyAutoDiceSettingLayer:onEnter()
	MonopolyAutoDiceSettingLayer.super.onEnter(self)
end

function MonopolyAutoDiceSettingLayer:onExit()
	MonopolyAutoDiceSettingLayer.super.onExit(self)
end

function MonopolyAutoDiceSettingLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function MonopolyAutoDiceSettingLayer:initLayer()
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

	local var_6_2 = TempWidget:CreateTempLayout(var_6_1)

	var_6_2:setContentSize(cc.size(var_6_1:size().w - 50, 80))
	var_6_2:align(cc.p(0.5, 0.5), var_6_1:size().w / 2, var_6_1:size().h / 2)

	self._costGoldLayout = var_6_2

	local var_6_3 = TempWidget:CreateTempImg(var_0_5 .. "cost_gold.png", var_6_2)

	var_6_3:align(cc.p(1, 0.5), var_6_2:size().w - 150, var_6_2:size().h / 2)

	local var_6_4 = TempWidget:CreateTempImg(var_0_5 .. "check_box.png", var_6_2)

	var_6_4:align(cc.p(0, 0.5), var_6_3:pos().x + 30, var_6_3:pos().y)

	local var_6_5 = TempWidget:CreateTempImg(var_0_5 .. "check.png", var_6_4)

	var_6_5:center()

	self._isCheckGold = var_6_5

	local var_6_6 = TempWidget:CreateTempLayout(var_6_1)

	var_6_6:setContentSize(var_6_2:size())
	var_6_6:align(cc.p(0.5, 0.5), var_6_1:size().w / 2, var_6_2:pos().y - var_6_2:size().h - 30)

	self._costDiamondLayout = var_6_6

	local var_6_7 = TempWidget:CreateTempImg(var_0_5 .. "cost_diamond.png", var_6_6)

	var_6_7:align(cc.p(1, 0.5), var_6_6:size().w - 150, var_6_6:size().h / 2)

	local var_6_8 = TempWidget:CreateTempImg(var_0_5 .. "check_box.png", var_6_6)

	var_6_8:align(cc.p(0, 0.5), var_6_7:pos().x + 30, var_6_7:pos().y)

	local var_6_9 = TempWidget:CreateTempImg(var_0_5 .. "check.png", var_6_8)

	var_6_9:center()

	self._isCheckDiamond = var_6_9

	local var_6_10 = TempWidget:CreateTempBtn(var_0_5 .. "start_btn.png", var_6_1)

	var_6_10:align(cc.p(0.5, 0.5), var_6_1:size().w / 2, -70)

	self._startBtn = var_6_10

	self:updateCostLayout()
end

function MonopolyAutoDiceSettingLayer:initListener()
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self._startBtn:_addEvent(function()
		local var_10_0 = require("controller.monopoly.monopoly_manager"):getInstance()

		var_10_0:setAuto(not var_10_0:isAuto())
		LayerManager:removePopLayer(self.__queueindex)
	end)
	self._costGoldLayout:_addEvent(function()
		self.manager:switchAutoCostGoldBuild()
	end)
	self._costDiamondLayout:_addEvent(function()
		self.manager:switchAutoCostDiamondBuild()
	end)
end

function MonopolyAutoDiceSettingLayer:updateLayer()
	return
end

function MonopolyAutoDiceSettingLayer:updateRed()
	return
end

function MonopolyAutoDiceSettingLayer:updateCostLayout()
	self._isCheckGold:setVisible(self.manager:isAutoCostGoldBuild())
	self._isCheckDiamond:setVisible(self.manager:isAutoCostDiamondBuild())
end

return MonopolyAutoDiceSettingLayer
