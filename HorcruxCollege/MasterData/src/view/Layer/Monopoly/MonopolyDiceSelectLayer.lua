local MonopolyDiceSelectLayer = class("MonopolyDiceSelectLayer", (require("view.Layer.BaseUILayer")))
local var_0_1 = require("controller.monopoly.monopoly_manager"):getInstance()
local texture_manager = require("controller.texture_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_5
local var_0_6

function MonopolyDiceSelectLayer:ctor()
	var_0_5 = "Monopoly_" .. var_0_1:getActivityId() .. "/MonopolyDiceSelectLayer/"

	MonopolyDiceSelectLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/monopoly/monopoly_dice_select_manager"):getInstance()
end

function MonopolyDiceSelectLayer:create(arg_2_1)
	texture_manager:loadPopLayerTextures({
		"Monopoly_" .. var_0_1:getActivityId() .. "_MonopolyDiceSelectLayer"
	})

	local var_2_0 = MonopolyDiceSelectLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function MonopolyDiceSelectLayer:onEnter()
	MonopolyDiceSelectLayer.super.onEnter(self)
end

function MonopolyDiceSelectLayer:onExit()
	MonopolyDiceSelectLayer.super.onExit(self)
end

function MonopolyDiceSelectLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function MonopolyDiceSelectLayer:initLayer()
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

	local var_6_2 = {
		cc.p(var_6_1:size().w / 2 - 200, var_6_1:size().h / 2 + 100 + -50),
		cc.p(var_6_1:size().w / 2, var_6_1:size().h / 2 + 100 + -50),
		cc.p(var_6_1:size().w / 2 + 200, var_6_1:size().h / 2 + 100 + -50),
		cc.p(var_6_1:size().w / 2 - 200, var_6_1:size().h / 2 - 100 + -50),
		cc.p(var_6_1:size().w / 2, var_6_1:size().h / 2 - 100 + -50),
		cc.p(var_6_1:size().w / 2 + 200, var_6_1:size().h / 2 - 100 + -50)
	}
	local var_6_3 = {}

	for iter_6_0 = 1, 6 do
		local var_6_4 = TempWidget:CreateTempImg(var_0_5 .. "dice_bg.png", var_6_1)

		var_6_4:align(cc.p(0.5, 0.5), var_6_2[iter_6_0].x, var_6_2[iter_6_0].y)
		var_6_4:_addEvent(function()
			self:updateSelected(iter_6_0)
		end)
		TempWidget:CreateTempImg(var_0_5 .. "dice_" .. iter_6_0 .. ".png", var_6_4):align(cc.p(0.5, 0.5), var_6_4:size().w / 2, var_6_4:size().h / 2)

		local var_6_5 = TempWidget:CreateTempImg(var_0_5 .. "selected.png", var_6_4)

		var_6_5:align(cc.p(0.5, 0.5), var_6_4:size().w / 2, var_6_4:size().h / 2)
		var_6_5:hide()

		if iter_6_0 == var_0_6 then
			var_6_5:show()
		end

		var_6_3[iter_6_0] = var_6_5
	end

	self._selectedImgTable = var_6_3

	local var_6_6 = TempWidget:CreateTempBtn(var_0_5 .. "select_btn.png", var_6_1)

	var_6_6:align(cc.p(0.5, 0), var_6_1:size().w / 2, -120)

	self._selectBtn = var_6_6
end

function MonopolyDiceSelectLayer:initListener()
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self._selectBtn:_addEvent(function()
		if not var_0_6 then
			global_ShowBlockWords(L_MONOPOLY[37])

			return
		end

		require("controller.monopoly.monopoly_manager"):getInstance():requestThrow(var_0_6)
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function MonopolyDiceSelectLayer:updateLayer()
	return
end

function MonopolyDiceSelectLayer:updateRed()
	return
end

function MonopolyDiceSelectLayer:updateSelected(arg_14_1)
	if var_0_6 == arg_14_1 then
		return
	end

	var_0_6 = arg_14_1

	for iter_14_0 = 1, #self._selectedImgTable do
		if iter_14_0 == arg_14_1 then
			self._selectedImgTable[iter_14_0]:setVisible(true)
		else
			self._selectedImgTable[iter_14_0]:setVisible(false)
		end
	end
end

return MonopolyDiceSelectLayer
