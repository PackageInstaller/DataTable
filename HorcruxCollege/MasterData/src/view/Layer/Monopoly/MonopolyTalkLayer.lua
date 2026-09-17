local MonopolyTalkLayer = class("MonopolyTalkLayer", (require("view.Layer.BaseUILayer")))
local var_0_1 = require("controller.monopoly.monopoly_manager"):getInstance()
local texture_manager = require("controller.texture_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_5
local conversation_data = require("data/conversation_data")

function MonopolyTalkLayer:ctor()
	var_0_5 = "Monopoly_" .. var_0_1:getActivityId() .. "/MonopolyTalkLayer/"

	MonopolyTalkLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/monopoly/monopoly_talk_manager"):getInstance()
end

function MonopolyTalkLayer:create(arg_2_1)
	texture_manager:loadPopLayerTextures({
		"Monopoly_" .. var_0_1:getActivityId() .. "_MonopolyTalkLayer"
	})

	local var_2_0 = MonopolyTalkLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function MonopolyTalkLayer:onEnter()
	MonopolyTalkLayer.super.onEnter(self)
end

function MonopolyTalkLayer:onExit()
	MonopolyTalkLayer.super.onExit(self)
end

function MonopolyTalkLayer:init(arg_5_1)
	self._data = arg_5_1

	self:initLayer()
	self:initListener()

	return true
end

function MonopolyTalkLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	for iter_6_0, iter_6_1 in pairs(conversation_data) do
		if iter_6_1.classification == self._data.data.talk then
			self._config = iter_6_1

			break
		end
	end

	if self._config then
		self:initTalk()
	else
		print("error: talk config is nil " .. self._data.data.talk)
	end
end

function MonopolyTalkLayer:initTalk()
	TempWidget:CreateTempImg(var_0_5 .. "bottom_shadow.png", self._root):align(cc.p(0.5, 0), self._root:size().width / 2, 0)
	TempWidget:CreateTempImg("mainScenebg/monopoly/" .. self._config.icon .. ".png", self._root, 0):align(cc.p(0, 0), 0, 150)

	local var_7_0 = TempWidget:CreateTempImg(var_0_5 .. "talk_bg.png", self._root)

	var_7_0:align(cc.p(0.5, 0), self._root:size().width / 2, 50)

	local var_7_1 = TempWidget:CreateTempImg(var_0_5 .. "name_bg.png", self._root)

	var_7_1:align(cc.p(0.5, 0), self._root:size().width / 2, var_7_0:pos().y + var_7_0:size().h)
	TempWidget:CreateTempLabel(self._config.showName, FONT_NAME, 30, var_7_1):align(cc.p(0, 0.5), 10, var_7_1:size().height / 2)

	local var_7_2 = self._config.dec
	local var_7_3 = TempWidget:CreateTempLabel("", FONT_NAME, 24, var_7_0)

	var_7_3:_setColor("d2dafe")

	local var_7_4 = var_0_1:getAttrValue("talk_color")

	if var_7_4 then
		var_7_3:_setColor(var_7_4)
	end

	var_7_3:align(cc.p(0, 1), 35, var_7_0:size().height - 20)
	var_7_3:setMaxLineWidth(var_7_0:size().w - 60)

	self._decText = var_7_3

	local var_7_5 = self:getStringLength(self._config.dec)
	local var_7_6 = 1

	self._isTalking = true

	schedule(var_7_3, function()
		if var_7_6 > var_7_5 then
			var_7_3:stopAllActions()

			self._isTalking = false
		else
			var_7_3:setString((self:getStringByLength(var_7_2, var_7_6)))

			var_7_6 = var_7_6 + 1
		end
	end, 0.05)
end

function MonopolyTalkLayer:initListener()
	self._root:_addEvent(function()
		if self._isTalking then
			self._decText:stopAllActions()
			self._decText:setString(self._config.dec)

			self._isTalking = false
		else
			local var_10_0 = require("controller.monopoly.monopoly_manager"):getInstance()

			if self._data.data.justTalk then
				var_10_0:handleEvents()
			else
				self._data.data.talk = nil

				var_10_0:insertEvent(self._data)
				var_10_0:handleEvents()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end
	end)
	performWithDelay(self._root, function()
		local var_11_0 = require("controller.monopoly.monopoly_manager"):getInstance()

		if var_11_0:isAuto() then
			if self._data.data.justTalk then
				var_11_0:handleEvents()
			else
				self._data.data.talk = nil

				var_11_0:insertEvent(self._data)
				var_11_0:handleEvents()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end
	end, 2)
end

function MonopolyTalkLayer:updateLayer()
	return
end

function MonopolyTalkLayer:updateRed()
	return
end

function MonopolyTalkLayer:getChineseCount(arg_14_1)
	local var_14_0 = 0

	for iter_14_0 = 1, #arg_14_1 do
		if string.byte(arg_14_1, iter_14_0) > 128 then
			var_14_0 = var_14_0 + 1
		end
	end

	return var_14_0
end

function MonopolyTalkLayer:getStringLength(arg_15_1)
	if not arg_15_1 or type(arg_15_1) ~= "string" or #arg_15_1 <= 0 then
		return nil
	end

	local var_15_0 = 0
	local var_15_1 = 1

	repeat
		local var_15_2 = string.byte(arg_15_1, var_15_1)

		var_15_1 = var_15_1 + (var_15_2 > 239 and 4 or var_15_2 > 223 and 3 or var_15_2 > 128 and 2 or 1)
		var_15_0 = var_15_0 + 1
	until var_15_1 > #arg_15_1

	return var_15_0
end

function MonopolyTalkLayer:getStringByLength(arg_16_1, arg_16_2)
	if not arg_16_1 or type(arg_16_1) ~= "string" or #arg_16_1 <= 0 then
		return nil
	end

	local var_16_0 = 1
	local var_16_1 = ""

	while true do
		local var_16_2 = string.byte(arg_16_1, var_16_0)

		var_16_1 = var_16_1 .. string.sub(arg_16_1, var_16_0, var_16_0 + (var_16_2 > 239 and 4 or var_16_2 > 223 and 3 or var_16_2 > 128 and 2 or 1) - 1)
		var_16_0 = var_16_0 + (var_16_2 > 239 and 4 or var_16_2 > 223 and 3 or var_16_2 > 128 and 2 or 1)

		if var_16_0 > #arg_16_1 then
			break
		end

		if arg_16_2 == 1 then
			break
		end

		arg_16_2 = arg_16_2 - 1
	end

	return var_16_1
end

return MonopolyTalkLayer
