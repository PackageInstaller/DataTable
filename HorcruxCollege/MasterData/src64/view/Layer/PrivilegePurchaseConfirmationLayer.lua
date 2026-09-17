PrivilegePurchaseConfirmationLayer = class("PrivilegePurchaseConfirmationLayer", (require("view.Layer.BaseUILayer")))

local l2utils = require("controller.l2utils")
local TempWidget = require("view.Sprite.TempWidget")

function PrivilegePurchaseConfirmationLayer:ctor()
	PrivilegePurchaseConfirmationLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.privilege_purchase_confirmation_manager"):getInstance()
end

function PrivilegePurchaseConfirmationLayer.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = PrivilegePurchaseConfirmationLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1, arg_2_2) then
		return var_2_0
	end

	return nil
end

function PrivilegePurchaseConfirmationLayer:onEnter()
	PrivilegePurchaseConfirmationLayer.super.onEnter(self)
	self._root:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1), cc.CallFunc:create(function()
		self._root:setTouchEnabled(true)
	end)))
end

function PrivilegePurchaseConfirmationLayer.onExit(arg_5_0)
	PrivilegePurchaseConfirmationLayer.super.onExit(arg_5_0)
end

function PrivilegePurchaseConfirmationLayer:init(arg_6_1, arg_6_2)
	self._data = arg_6_1
	self._rechargeInfo = arg_6_2

	self:initLayer()
	self:initListener()

	return true
end

function PrivilegePurchaseConfirmationLayer.initLayer(arg_7_0)
	local var_7_0 = TempWidget:CreateTempLayout(arg_7_0)

	var_7_0:setContentSize(GameDisplay.getUiScreenSize())
	var_7_0:align(cc.p(0.5, 0.5), GameDisplay.getUiScreenSize().width / 2, GameDisplay.getUiScreenSize().height / 2)
	var_7_0:setScaleY(0.01)

	arg_7_0._root = var_7_0

	l2utils:captureScreenGaussBlur(function(arg_8_0)
		var_7_0:addChild(arg_8_0)
		arg_8_0:setPosition(var_7_0:size().w / 2, var_7_0:size().h / 2)

		local var_8_0 = TempWidget:CreateTempImg("mainScenebg/recharge/" .. arg_7_0._data.id .. ".png", var_7_0, 0)

		var_8_0:_addEvent(function()
			return
		end)
		var_8_0:center()

		local var_8_1 = TempWidget:CreateTempBtn("public/button/public_button_orange_big.png", var_7_0)

		var_8_1:align(cc.p(0.5, 0.5), var_8_0:pos().x, var_8_0:pos().y - var_8_0:size().h / 2 - var_8_1:size().h / 2 - 20)
		var_8_1:_addEvent(function()
			if arg_7_0._data.sureCallback then
				arg_7_0._data.sureCallback(function(arg_11_0)
					if arg_11_0.result == 1 then
						LayerManager:removePopLayer()
					end
				end)
			end
		end)

		local var_8_2 = TempWidget:CreateTempLabel("购买", FONT_BUTTON, 32, var_8_1)

		var_8_2:align(cc.p(0.5, 0.5), var_8_1:size().w / 2, var_8_1:size().h / 2)
		var_8_2:_setColor("0c0c0c")
		var_8_2:move(var_8_1:size().w / 2, var_8_1:size().h / 2 - 5)

		local var_8_3
		local var_8_4 = ""

		if arg_7_0._rechargeInfo.rmb then
			var_8_3 = "public/currency/rmb_white.png"
			var_8_4 = arg_7_0._rechargeInfo.rmb or var_8_4
		elseif arg_7_0._rechargeInfo.price_diamond then
			var_8_3 = "public/currency/UI_battleEnd_diamond.png"
			var_8_4 = arg_7_0._rechargeInfo.price_diamond or var_8_4
		else
			var_8_3 = "public/currency/6800601.png"
			var_8_4 = arg_7_0._rechargeInfo.price_card or var_8_4
		end

		local var_8_5 = TempWidget:CreateTempImg(var_8_3, var_7_0)

		var_8_5:align(cc.p(0.5, 0.5), var_8_1:pos().x - 30, var_8_1:pos().y - var_8_1:size().h / 2 - var_8_5:size().h / 2 - 10)
		TempWidget:CreateTempLabel(var_8_4, FONT_BUTTON, 24, var_7_0):align(cc.p(0.5, 0.5), var_8_5:pos().x + var_8_5:size().w + 20, var_8_5:pos().y)
	end)
end

function PrivilegePurchaseConfirmationLayer:initListener()
	self._root:_addEvent(function()
		LayerManager:removePopLayer()
	end)
	self._root:setTouchEnabled(false)
end

function PrivilegePurchaseConfirmationLayer.updateLayer(arg_14_0)
	return
end

function PrivilegePurchaseConfirmationLayer.updateRed(arg_15_0)
	return
end

return PrivilegePurchaseConfirmationLayer
