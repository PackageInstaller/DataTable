local PopActivityComboResultLayer = class("PopActivityComboResultLayer", (require("view.Layer.BaseUILayer")))
local texture_manager = require("controller.texture_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_3 = config._DEBUG and 0 or 1
local component_manager = require("controller.component_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local activity_manager = require("controller.activity_manager")

require("view.Sprite.ItemSprite")

local var_0_13 = {
	"normal_award",
	"sp_award",
	"best_award"
}
local var_0_14 = {
	"title_normal.png",
	"title_sp.png",
	"title_best.png"
}

function PopActivityComboResultLayer:ctor()
	PopActivityComboResultLayer.super.ctor(self)
	self:setAutoAdapt(true)
end

function PopActivityComboResultLayer:create(arg_2_1)
	self.activityId = arg_2_1.activityId
	self.resPath = "PopActivityComboResultLayer_" .. self.activityId .. "/"

	local var_2_0 = PopActivityComboResultLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function PopActivityComboResultLayer:onEnter()
	PopActivityComboResultLayer.super.onEnter(self)
end

function PopActivityComboResultLayer:onExit()
	PopActivityComboResultLayer.super.onExit(self)
end

function PopActivityComboResultLayer:init(arg_5_1)
	TextureManager:loadLayerTextures({
		"PopActivityComboResultLayer_" .. self.activityId
	})
	self:initLayer(arg_5_1)
	self:initListener(arg_5_1)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopActivityComboResultLayer_" .. self.activityId)
			TextureManager:removeLayerTextures({
				self._imagePath
			})
		end
	end)

	return true
end

function PopActivityComboResultLayer:initLayer(arg_7_1)
	local var_7_0 = TempWidget:CreateTempLayout(self)

	var_7_0:_setBack()
	var_7_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_7_0:setBackGroundColorOpacity(100)
	var_7_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_7_0

	var_7_0:_addEvent(function()
		return
	end)

	local var_7_1 = ccui.ImageView:create(self.resPath .. "bg.png", var_0_3)

	var_7_0:addChild(var_7_1)
	var_7_1:setPosition(320, 700)

	local var_7_2 = ccui.ImageView:create(self.resPath .. var_0_14[arg_7_1.msg.award_type], var_0_3)

	var_7_1:addChild(var_7_2)
	var_7_2:setPosition(245, 500)

	if arg_7_1.msg.items then
		local var_7_3 = activity_manager:get_bestcombo_conf(self.activityId)
		local var_7_5 = ccui.Layout:create()

		var_7_5:setContentSize(cc.size(80, 80))

		local var_7_6 = ccui.ImageView:create(self.resPath .. "item_bg.png", var_0_3)

		var_7_6:setPosition(cc.p(50, 40))

		local var_7_7, var_7_8 = create_item_icon(nil, true, var_7_3.key_point, var_7_3[var_0_13[arg_7_1.msg.award_type]])

		var_7_7:setPosition(40, 45)
		var_7_7:setScale(var_7_7:getScale() * 0.5)
		var_7_6:addChild(var_7_7)
		var_7_5:addChild(var_7_6)

		local var_7_9 = ccui.ImageView:create(self.resPath .. "label_bg.png", var_0_3)

		var_7_9:setAnchorPoint(0, 0)
		var_7_6:addChild(var_7_9)

		local var_7_10 = cc.Label:createWithTTF("x" .. var_7_8, FONT_DES, 14)

		var_7_10:setPosition(42, 10)
		var_7_9:addChild(var_7_10)
		var_7_5:setPosition(195, 280)
		var_7_1:addChild(var_7_5)
	end

	local var_7_11 = ccui.Button:create(self.resPath .. "btn_sure.png", nil, self.resPath .. "btn_sure.png", var_0_3)

	var_7_11:setPosition(245, 180)
	var_7_1:addChild(var_7_11)

	self.btn_sure = var_7_11
end

function PopActivityComboResultLayer:initListener(arg_9_1)
	if self.btn_sure then
		self.btn_sure:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			KeyCodeManager:onKeyReleasedCallFunc()

			if arg_9_1.callback then
				arg_9_1.callback()
			end
		end)
	end
end

return PopActivityComboResultLayer
