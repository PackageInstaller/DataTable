PrivilegeFailedTipsLayer = class("PrivilegeFailedTipsLayer", (require("view.Layer.BaseUILayer")))

local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = "PrivilegeFailedTipsLayer/"

function PrivilegeFailedTipsLayer:ctor()
	PrivilegeFailedTipsLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.privilege_failed_tips_manager"):getInstance()
end

function PrivilegeFailedTipsLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PrivilegeFailedTipsLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function PrivilegeFailedTipsLayer.onEnter(arg_3_0)
	PrivilegeFailedTipsLayer.super.onEnter(arg_3_0)
end

function PrivilegeFailedTipsLayer.onExit(arg_4_0)
	PrivilegeFailedTipsLayer.super.onExit(arg_4_0)
end

function PrivilegeFailedTipsLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function PrivilegeFailedTipsLayer.initLayer(arg_6_0)
	local var_6_0 = TempWidget:CreateTempLayout(arg_6_0)

	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	arg_6_0._root = var_6_0

	local var_6_1 = TempWidget:CreateTempImg(var_0_2 .. "deduction_failure_bg.png", var_6_0)

	var_6_1:move(var_6_0:size().w / 2, var_6_0:size().h / 2 + 100)
	TempWidget:CreateTempLabel("扣款失败", FONT_NAME, 52, var_6_1):align(cc.p(0, 0.5), 120, var_6_1:size().h / 2 - 35)
end

function PrivilegeFailedTipsLayer:initListener()
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function PrivilegeFailedTipsLayer.updateLayer(arg_9_0)
	return
end

function PrivilegeFailedTipsLayer.updateRed(arg_10_0)
	return
end

return PrivilegeFailedTipsLayer
