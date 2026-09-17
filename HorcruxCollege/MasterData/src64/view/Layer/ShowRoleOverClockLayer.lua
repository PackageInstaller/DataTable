ShowRoleOverClockLayer = class("ShowRoleOverClockLayer", (require("view.Layer.BaseUILayer")))

local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = "ShowRoleOverClockLayer/"
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local Utility = require("common.Utility")

function ShowRoleOverClockLayer:ctor()
	ShowRoleOverClockLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.show_role_over_clock_manager"):getInstance():getInstance()
end

function ShowRoleOverClockLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ShowRoleOverClockLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function ShowRoleOverClockLayer.onEnter(arg_3_0)
	ShowRoleOverClockLayer.super.onEnter(arg_3_0)
end

function ShowRoleOverClockLayer.onExit(arg_4_0)
	ShowRoleOverClockLayer.super.onExit(arg_4_0)
end

function ShowRoleOverClockLayer:init(arg_5_1)
	self._data = arg_5_1

	self:initData(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function ShowRoleOverClockLayer.initData(arg_6_0, arg_6_1)
	arg_6_0.curSoul = arg_6_1.curSoul
	arg_6_0.goto_back_system_id = arg_6_1.goto_back_system_id
	arg_6_0.cancelcallback = arg_6_1.cancelcallback
	arg_6_0.surecallback = arg_6_1.surecallback
end

function ShowRoleOverClockLayer:initLayer()
	local var_7_0 = TempWidget:CreateTempLayout(self)

	var_7_0:_setBack()
	var_7_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_7_0
	self.layout = ccui.Layout:create()

	self.layout:setContentSize(cc.size(640, GameDisplay.height))
	self.layout:setAnchorPoint(cc.p(0.5, 0.5))
	self.layout:setBackGroundImage(DATABASEBG)
	self.layout:setPosition(cc.p(320, GameDisplay.height / 2))
	var_7_0:addChild(self.layout)

	self.mask = ccui.Layout:create()

	self.mask:setContentSize(cc.size(640, GameDisplay.height))
	self.mask:setAnchorPoint(cc.p(0.5, 0.5))
	self.mask:setBackGroundImage("mainScenebg/blur_mask.png", 0)
	self.mask:setPosition(cc.p(320, GameDisplay.height / 2))
	self:addChild(self.mask)
	self:initRoleImg()

	local var_7_1 = TempWidget:CreateTempImg(var_0_2 .. "tips1.png", var_7_0)

	var_7_1:align(cc.p(0.5, 0.5), var_7_0:size().w / 2, var_7_0:size().h - 100)
	var_7_1:setScale(1.2)
	var_7_1:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 100), cc.FadeTo:create(1, 255))))
	self:initValueLayout()
end

function ShowRoleOverClockLayer:initRoleImg()
	if servant_data[self.curSoul].model_oc then
		if model_data[servant_data[self.curSoul].model_oc].role_image then
			local var_8_0 = self:getOffset(servant_data[self.curSoul].model_oc, 1, true)

			if not model_data[servant_data[self.curSoul].model_oc].database_girl_scale then
				-- block empty
			end

			TempWidget:CreateTempImg("role/" .. model_data[servant_data[self.curSoul].model_oc].role_image .. ".png", self._root, 0):setPosition(cc.p(var_8_0.x, var_8_0.y))
		end
	end
end

function ShowRoleOverClockLayer:initListener()
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function ShowRoleOverClockLayer.getOffset(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0
	local var_11_1

	if false then
		var_11_0 = model_data[arg_11_1].shadow_girl_offset_x or 0
		var_11_1 = model_data[arg_11_1].shadow_girl_offset_y or 0
	else
		var_11_0 = model_data[arg_11_1].upgrade_offset_x or model_data[arg_11_1].database_girl_offset_x or 0
		var_11_1 = model_data[arg_11_1].upgrade_offset_y or model_data[arg_11_1].database_girl_offset_y or 0
	end

	return (cc.p(var_11_0 + 320, var_11_1 + GameDisplay.height / 2))
end

function ShowRoleOverClockLayer:initValueLayout()
	local souls_manager = require("controller.souls_manager")
	local playermodel = require("model.playermodel")
	local var_12_2 = TempWidget:CreateTempImg(var_0_2 .. "data_bg.png", self._root)

	var_12_2:align(cc.p(0.5, 0), self._root:size().w / 2, 100)
	TempWidget:CreateTempImg(var_0_2 .. "upgrade_bottom_oc.png", var_12_2):align(cc.p(0.5, 0), var_12_2:size().w - 100, var_12_2:size().h - 140)

	local var_12_3 = cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 100), cc.FadeIn:create(1)))
	local var_12_4 = TempWidget:CreateTempImg(var_0_2 .. "part_purple1.png", var_12_2)

	var_12_4:align(cc.p(0.5, 0), var_12_2:size().w - 100, var_12_2:size().h - 40)
	var_12_4:runAction(var_12_3:clone())

	local var_12_5 = TempWidget:CreateTempImg(var_0_2 .. "part_purple2.png", var_12_2)

	var_12_5:align(cc.p(0.5, 0), var_12_4:pos().x + -15, var_12_4:pos().y + 38)
	var_12_5:runAction(var_12_3:clone())

	local var_12_6 = TempWidget:CreateTempImg(var_0_2 .. "part_purple3.png", var_12_2)

	var_12_6:align(cc.p(0.5, 0), var_12_4:pos().x + -15, var_12_4:pos().y + 10)
	var_12_6:runAction(var_12_3:clone())

	local var_12_7 = TempWidget:CreateTempImg(var_0_2 .. "part_purple4.png", var_12_2)

	var_12_7:align(cc.p(0.5, 0), var_12_4:pos().x + -15 + 43, var_12_4:pos().y + 10)
	var_12_7:runAction(var_12_3:clone())

	local var_12_8 = TempWidget:CreateTempImg(var_0_2 .. "part_purple5.png", var_12_2)

	var_12_8:align(cc.p(0.5, 0), var_12_4:pos().x + -15 + 15, var_12_4:pos().y + 38)
	var_12_8:runAction(var_12_3:clone())

	local var_12_9 = TempWidget:CreateTempImg(var_0_2 .. "ocRankPic.png", var_12_2)

	var_12_9:align(cc.p(0.5, 0.5), var_12_4:pos().x, var_12_4:pos().y - 30)

	local var_12_10 = TempWidget:CreateTempLabel("攻击资质:", FONT_DES, 20, var_12_2)

	var_12_10:align(cc.p(0, 0.5), var_12_2:size().w - 175, var_12_9:pos().y - var_12_9:size().h + 10)

	self.overclock = playermodel.soulOverClock[self.curSoul] or 0

	local var_12_11 = servant_data[self.curSoul].damageOverPlus1
	local var_12_12

	if not servant_data[self.curSoul].damageOverPlus1 then
		var_12_11 = 0
		var_12_12 = servant_data[self.curSoul]["damageFactorPlus5" .. souls_manager:get_roll_rarity_str(self.curSoul)] or 0
	end

	TempWidget:CreateTempLabel(model_data[servant_data[self.curSoul].modelid].damageFactor + var_12_11 + var_12_12, FONT_DES, 20, var_12_2):align(cc.p(0, 0.5), var_12_10:pos().x + var_12_10:size().w + 20, var_12_10:pos().y)

	local var_12_13 = TempWidget:CreateTempLabel("血量资质:", FONT_DES, 20, var_12_2)

	var_12_13:align(cc.p(0, 0.5), var_12_10:pos().x, var_12_10:pos().y - 30)

	local var_12_14 = servant_data[self.curSoul].hpOverPlus1
	local var_12_15

	if not servant_data[self.curSoul].hpOverPlus1 then
		var_12_14 = 0
		var_12_15 = servant_data[self.curSoul]["hpFactorPlus5" .. souls_manager:get_roll_rarity_str(self.curSoul)] or 0
	end

	TempWidget:CreateTempLabel(model_data[servant_data[self.curSoul].modelid].hpFactor + var_12_14 + var_12_15, FONT_DES, 20, var_12_2):align(cc.p(0, 0.5), var_12_13:pos().x + var_12_13:size().w + 20, var_12_13:pos().y)

	if souls_manager:get_soul_contract_strength_science(self.curSoul, Utility:clamp(5, 0, 5)) > 0 then
		local var_12_16 = TempWidget:CreateTempLabel("全员科技值:", FONT_DES, 20, var_12_2)

		var_12_16:align(cc.p(0, 0.5), var_12_10:pos().x - 20, var_12_13:pos().y - 30)
		TempWidget:CreateTempLabel("+" .. 1, FONT_DES, 20, var_12_2):align(cc.p(0, 0.5), var_12_16:pos().x + var_12_16:size().w + 20, var_12_16:pos().y)
	end

	local var_12_17 = TempWidget:CreateTempBtn("public/button/public_button_orange.png", var_12_2)
	local var_12_18 = TempWidget:CreateTempLabel("前往共振", FONT_DES, 30, var_12_17:getVirtualRenderer())

	var_12_18:_setColor("002200")
	var_12_18:center()
	var_12_17:align(cc.p(0.5, 1), var_12_2:size().w / 2, -5)
	var_12_17:_addEvent(function()
		LayerManager:removePopLayer()
		LayerManager:pushInLayer("PopServantUpgradeLayer", self._data)
	end)
end

function ShowRoleOverClockLayer.updateLayer(arg_14_0)
	return
end

function ShowRoleOverClockLayer.updateRed(arg_15_0)
	return
end

return ShowRoleOverClockLayer
