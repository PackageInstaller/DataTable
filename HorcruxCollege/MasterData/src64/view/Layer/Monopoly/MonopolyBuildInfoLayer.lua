local MonopolyBuildInfoLayer = class("MonopolyBuildInfoLayer", (require("view.Layer.BaseUILayer")))
local var_0_1 = require("controller.monopoly.monopoly_manager"):getInstance()
local texture_manager = require("controller.texture_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_5

function MonopolyBuildInfoLayer:ctor()
	var_0_5 = "Monopoly_" .. var_0_1:getActivityId() .. "/MonopolyBuildInfoLayer/"

	MonopolyBuildInfoLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/monopoly/monopoly_build_info_manager"):getInstance()
end

function MonopolyBuildInfoLayer:create(arg_2_1)
	texture_manager:loadPopLayerTextures({
		"Monopoly_" .. var_0_1:getActivityId() .. "_MonopolyBuildInfoLayer"
	})

	local var_2_0 = MonopolyBuildInfoLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function MonopolyBuildInfoLayer:onEnter()
	MonopolyBuildInfoLayer.super.onEnter(self)
end

function MonopolyBuildInfoLayer:onExit()
	MonopolyBuildInfoLayer.super.onExit(self)
end

function MonopolyBuildInfoLayer:init(arg_5_1)
	self._data = arg_5_1

	self:initLayer()
	self:initListener()

	return true
end

function MonopolyBuildInfoLayer:initLayer()
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

	local var_6_2 = TempWidget:CreateTempImg(self._data.imgPath, var_6_1)

	var_6_2:align(cc.p(0.5, 0.5), 110, var_6_1:size().h / 2 - 70)

	local var_6_3 = TempWidget:CreateTempLabel(self._data.name, FONT_NAME, 30, var_6_1)

	var_6_3:_setColor("fff45c")
	var_6_3:align(cc.p(0.5, 0.5), var_6_2:pos().x, var_6_2:pos().y + var_6_2:size().h / 2 + 30)

	local var_6_4 = TempWidget:CreateTempImg(var_0_5 .. "img1.png", var_6_1)

	var_6_4:align(cc.p(0, 0.5), 250, var_6_1:size().h / 2 + 40)

	local var_6_5 = TempWidget:CreateTempImg(var_0_5 .. "img3.png", var_6_1)

	var_6_5:align(cc.p(0, 0.5), var_6_4:pos().x, var_6_4:pos().y - var_6_4:size().h - 10)
	TempWidget:CreateTempImg(self._data.incomePath, var_6_5):align(cc.p(0, 0.5), 20, var_6_5:size().h / 2)

	local var_6_6 = TempWidget:CreateTempLabel(self._data.income, FONT_NAME, 30, var_6_5)

	var_6_6:_setColor("fff45c")
	var_6_6:align(cc.p(0.5, 0.5), var_6_5:size().w / 2 + 20, var_6_5:size().h / 2)

	if self._data.incomeState then
		var_6_6:_setColor(self._data.incomeTextColor)
	end

	local var_6_7 = TempWidget:CreateTempImg(var_0_5 .. "img2.png", var_6_1)

	var_6_7:align(cc.p(0, 0.5), var_6_4:pos().x, var_6_4:pos().y - 120)

	local var_6_8 = TempWidget:CreateTempImg(var_0_5 .. "img3.png", var_6_1)

	var_6_8:align(cc.p(0, 0.5), var_6_7:pos().x, var_6_7:pos().y - var_6_7:size().h - 10)
	TempWidget:CreateTempImg(self._data.currencyPath, var_6_8):align(cc.p(0, 0.5), 20, var_6_8:size().h / 2)

	local var_6_9 = TempWidget:CreateTempLabel(self._data.costNum, FONT_NAME, 30, var_6_8)

	var_6_9:_setColor("00ffff")
	var_6_9:align(cc.p(0.5, 0.5), var_6_8:size().w / 2 + 20, var_6_8:size().h / 2)

	if self._data.costState then
		var_6_9:_setColor(self._data.costTextColor)
	end
end

function MonopolyBuildInfoLayer:initListener()
	self._root:_addEvent(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function MonopolyBuildInfoLayer:updateLayer()
	return
end

function MonopolyBuildInfoLayer:updateRed()
	return
end

return MonopolyBuildInfoLayer
