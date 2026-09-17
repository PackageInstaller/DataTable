PvPPreviewLayer = class("PvPPreviewLayer", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local arena_manager = require("controller.arena_manager")
local item_data = require("data.item_data")

function PvPPreviewLayer.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = PvPPreviewLayer.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function PvPPreviewLayer:init(arg_3_1, arg_3_2, arg_3_3)
	self:SetupUIReference()
	self:addChild(self.rootLayout)

	self.confirmPanel = ccui.Helper:seekWidgetByName(self.rootLayout, "Panel_confirm_fight")

	self.confirmPanel:setTouchEnabled(true)
	self.confirmPanel:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.RemoveSelf:create()))
	end)
	self.buttonConfirm:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_3_3 then
			arg_3_3()
		end
	end)

	local var_3_0 = ccui.Helper:seekWidgetByName(self.rootLayout, "Panel_confirm_fight"):getChildByName("zhenrong")

	for iter_3_0, iter_3_1 in pairs(arg_3_2.battle_array) do
		local var_3_1 = major_factor_data[iter_3_1.fight_girl]["modelid_" .. iter_3_1.soul_wear]

		if iter_3_1.soul_dress and iter_3_1.soul_dress > 0 then
			var_3_1 = item_data[iter_3_1.soul_dress]["modelid_" .. iter_3_1.soul_wear]
		end

		ccui.Helper:seekWidgetByName(var_3_0, "player" .. iter_3_1.pos):setVisible(true)
		ccui.Helper:seekWidgetByName(var_3_0, "player" .. iter_3_1.pos):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[var_3_1].cute_role .. ".png")
	end
end

function PvPPreviewLayer:SetupUIReference()
	self.rootLayout = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Confirm_fight.json" or "Confirm_fight.ExportJson")

	ccui.Helper:seekWidgetByName(self.rootLayout, "image_fight_finish"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayout, "Panel_awards"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayout, "title"):setString(L_PVP_PREVIEW_WIDGET.Title)

	self.buttonConfirm = ccui.Helper:seekWidgetByName(self.rootLayout, "button_sure")

	local var_6_0 = cc.Label:createWithTTF(L_PVP_PREVIEW_WIDGET.Confirm_btn, "fonts/W5.ttf", 40)

	var_6_0:enableOutline(cc.c4b(184, 76, 56, 255), 2)
	var_6_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_6_0:setPosition(cc.p(self.buttonConfirm:getContentSize().width / 2, self.buttonConfirm:getContentSize().height / 2 + 10))
	self.buttonConfirm:addChild(var_6_0, 1)
	self.buttonConfirm:setPositionX(320)
end
