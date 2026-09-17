PrivilegeSuccessTipsLayer = class("PrivilegeSuccessTipsLayer", (require("view.Layer.BaseUILayer")))

local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = "PrivilegeSuccessTipsLayer/"

function PrivilegeSuccessTipsLayer:ctor()
	PrivilegeSuccessTipsLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.privilege_success_tips_manager"):getInstance()
end

function PrivilegeSuccessTipsLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PrivilegeSuccessTipsLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function PrivilegeSuccessTipsLayer.onEnter(arg_3_0)
	PrivilegeSuccessTipsLayer.super.onEnter(arg_3_0)
end

function PrivilegeSuccessTipsLayer.onExit(arg_4_0)
	PrivilegeSuccessTipsLayer.super.onExit(arg_4_0)
end

function PrivilegeSuccessTipsLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function PrivilegeSuccessTipsLayer.initLayer(arg_6_0)
	local var_6_0 = TempWidget:CreateTempLayout(arg_6_0)

	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	arg_6_0._root = var_6_0

	local var_6_1 = TempWidget:CreateTempImg(var_0_2 .. "bg.png", var_6_0)

	var_6_1:move(var_6_0:size().w / 2, var_6_0:size().h / 2 + 100)
	TempWidget:CreateTempLabel("订阅成功", FONT_NAME, 52, var_6_1):align(cc.p(0, 0.5), 120, var_6_1:size().h / 2 - 35)
end

function PrivilegeSuccessTipsLayer:initListener()
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function PrivilegeSuccessTipsLayer.updateLayer(arg_9_0)
	return
end

function PrivilegeSuccessTipsLayer.updateRed(arg_10_0)
	return
end

return PrivilegeSuccessTipsLayer
