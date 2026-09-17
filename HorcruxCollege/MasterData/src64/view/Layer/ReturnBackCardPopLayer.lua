ReturnBackCardPopLayer = class("ReturnBackCardPopLayer", (require("view.Layer.BaseUILayer")))

local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = "ReturnBackCardPopLayer/"
local var_0_3 = "activitypop800050:"
local l2utils = require("controller/l2utils")

function ReturnBackCardPopLayer:ctor()
	ReturnBackCardPopLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.activity_return_manager")
end

function ReturnBackCardPopLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ReturnBackCardPopLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function ReturnBackCardPopLayer:onEnter()
	ReturnBackCardPopLayer.super.onEnter(self)
	self._root:runAction(cc.ScaleTo:create(0.3, 1))
end

function ReturnBackCardPopLayer.onExit(arg_4_0)
	ReturnBackCardPopLayer.super.onExit(arg_4_0)
	cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
end

function ReturnBackCardPopLayer:init(arg_5_1)
	self.daystr = arg_5_1.daystr

	print(self.daystr)
	self:initLayer()
	self:initListener()

	return true
end

function ReturnBackCardPopLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:align(cc.p(0.5, 0.5), self:getContentSize().width / 2, self:getContentSize().height / 2)
	var_6_0:setContentSize(GameDisplay.getUiScreenSize())
	var_6_0:setScaleY(0.01)

	self._root = var_6_0

	local var_6_1 = TempWidget:CreateTempImg(var_0_2 .. "bg.png", var_6_0)

	var_6_1:center()

	local var_6_2 = TempWidget:CreateTempBtn(var_0_2 .. "get_btn.png", var_6_1)

	var_6_2:align(cc.p(0.5, 0.5), var_6_1:size().w / 2, var_6_1:size().h / 2 - 150)

	self._getBtn = var_6_2

	local var_6_3 = TempWidget:CreateTempLabel(self:getDay() .. "天", FONT_NAME, 22, var_6_1)

	var_6_3:_setColor("ffd200")
	var_6_3:align(cc.p(0.5, 0.5), var_6_1:size().w / 2, var_6_1:size().h / 2 - 85)

	self._dayText = var_6_3

	l2utils:captureScreenGaussBlur(function(arg_7_0)
		var_6_0:addChild(arg_7_0)
		arg_7_0:setLocalZOrder(-1)
		arg_7_0:setAnchorPoint(cc.p(0.5, 0.5))
		arg_7_0:setPosition(cc.p(var_6_0:size().w / 2, var_6_0:size().h / 2))
	end)
end

function ReturnBackCardPopLayer:getDay()
	if string.find(self.daystr, var_0_3) then
		return tonumber((string.gsub(self.daystr, var_0_3, "")))
	end

	return 0
end

function ReturnBackCardPopLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
	self._getBtn:_addEvent(function()
		self.manager:get_returnback_daily_Reward(function()
			self:exit()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
end

function ReturnBackCardPopLayer.updateLayer(arg_13_0)
	return
end

function ReturnBackCardPopLayer.updateRed(arg_14_0)
	return
end

function ReturnBackCardPopLayer:exit()
	if self.exitcallback then
		self.exitcallback()
	end
end

return ReturnBackCardPopLayer
