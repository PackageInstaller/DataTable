local MonopolyTipsLayer = class("MonopolyTipsLayer", (require("view.Layer.BaseUILayer")))
local var_0_1 = require("controller.monopoly.monopoly_manager"):getInstance()
local texture_manager = require("controller.texture_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_5
local item_manager = require("controller/item_manager")
local item_data = require("data/item_data")
local playermodel = require("model.playermodel")
local var_0_9 = string.format

function MonopolyTipsLayer:ctor()
	var_0_5 = "Monopoly_" .. var_0_1:getActivityId() .. "/MonopolyTipsLayer/"

	MonopolyTipsLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/monopoly/monopoly_tips_manager"):getInstance()
	self._isBcak = false
end

function MonopolyTipsLayer:create(arg_2_1)
	texture_manager:loadPopLayerTextures({
		"Monopoly_" .. var_0_1:getActivityId() .. "_MonopolyTipsLayer"
	})

	local var_2_0 = MonopolyTipsLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function MonopolyTipsLayer:onEnter()
	MonopolyTipsLayer.super.onEnter(self)
end

function MonopolyTipsLayer:onExit()
	MonopolyTipsLayer.super.onExit(self)
end

function MonopolyTipsLayer:init(arg_5_1)
	self._data = arg_5_1

	self:initLayer()
	self:initListener()

	return true
end

function MonopolyTipsLayer:initLayer()
	local var_6_0 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_6_1 = TempWidget:CreateTempLayout(self)

	var_6_1:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_1

	local var_6_2 = TempWidget:CreateTempImg(var_0_5 .. "bg.png", var_6_1)

	var_6_2:align(cc.p(0.5, 0.5), var_6_1:size().width / 2, var_6_1:size().height / 2)
	var_6_2:setOpacity(0)
	var_6_2:runAction(cc.Sequence:create(cc.FadeIn:create(0.5), cc.DelayTime:create(1), cc.FadeOut:create(0.5), cc.CallFunc:create(function()
		if not self._isBcak then
			self._isBcak = true

			self:exitHandle()
			LayerManager:removePopLayer(self.__queueindex)
		end
	end)))

	local var_6_3 = TempWidget:CreateTempLabel("", FONT_NAME, 30, var_6_2)

	var_6_3:align(cc.p(0.5, 0.5), var_6_2:size().width / 2, var_6_2:size().height / 2 - 30)
	var_6_3:setMaxLineWidth(var_6_2:size().w - 50)

	local var_6_4 = var_6_0:getAttrValue("result_color")

	if var_6_4 then
		var_6_3:_setColor(var_6_4)
	end

	local var_6_5 = self._data.data.target

	if self._data.type == var_6_0.EVENTS_TYPE.ADD_MONEY then
		var_6_3:setString(var_0_9(L_MONOPOLY[42], self._data.data.money))
	elseif self._data.type == var_6_0.EVENTS_TYPE.LOSE_MONEY then
		var_6_3:setString(var_0_9(L_MONOPOLY[43], self._data.data.money))
	elseif self._data.type == var_6_0.EVENTS_TYPE.LEVEL_UP_TILE then
		if var_6_5 == var_6_0.EVENTS_TARGET_TYPE.AI then
			var_6_3:setString(var_0_9(L_MONOPOLY[44], self._data.data.cost_gold, self._data.data.tile_lv))
		elseif var_6_5 == var_6_0.EVENTS_TARGET_TYPE.PLAYER then
			if self._data.data.cost_gold then
				var_6_3:setString(var_0_9(L_MONOPOLY[45], self._data.data.cost_gold, self._data.data.tile_lv))
			elseif self._data.data.cost_diamond then
				var_6_3:setString(var_0_9(L_MONOPOLY[46], self._data.data.cost_diamond, self._data.data.tile_lv))
			end
		end
	elseif self._data.type == var_6_0.EVENTS_TYPE.TRANSFER_MONEY then
		if var_6_5 == var_6_0.EVENTS_TARGET_TYPE.AI then
			var_6_3:setString(var_0_9(L_MONOPOLY[47], self._data.data.money))
		elseif var_6_5 == var_6_0.EVENTS_TARGET_TYPE.PLAYER then
			var_6_3:setString(var_0_9(L_MONOPOLY[48], self._data.data.money))
		end
	elseif self._data.type == var_6_0.EVENTS_TYPE.BUILDING_INCOME then
		if var_6_5 == var_6_0.EVENTS_TARGET_TYPE.AI then
			var_6_3:setString(var_0_9(L_MONOPOLY[49], self._data.data.money))
		elseif var_6_5 == var_6_0.EVENTS_TARGET_TYPE.PLAYER then
			var_6_3:setString(var_0_9(L_MONOPOLY[50], self._data.data.money))
		end
	elseif self._data.type == var_6_0.EVENTS_TYPE.BUILDING_UP then
		if var_6_5 == var_6_0.EVENTS_TARGET_TYPE.AI then
			var_6_3:setString(L_MONOPOLY[51])
		elseif var_6_5 == var_6_0.EVENTS_TARGET_TYPE.PLAYER then
			var_6_3:setString(L_MONOPOLY[52])
		end
	elseif self._data.type == var_6_0.EVENTS_TYPE.BUILDING_DOWN then
		if var_6_5 == var_6_0.EVENTS_TARGET_TYPE.AI then
			var_6_3:setString(L_MONOPOLY[53])
		elseif var_6_5 == var_6_0.EVENTS_TARGET_TYPE.PLAYER then
			var_6_3:setString(L_MONOPOLY[54])
		end
	elseif self._data.type == var_6_0.EVENTS_TYPE.GET_BUFF then
		local var_6_6 = require("controller.monopoly.monopoly_buff_manager"):getInstance()
		local var_6_7 = var_6_6:getConfigById(tostring(self._data.data.buff))

		if var_6_7.buff_or_debuff == var_6_6.BUFF_TYPE.BUFF then
			var_6_3:setString(L_MONOPOLY[55])
		elseif var_6_7.buff_or_debuff == var_6_6.BUFF_TYPE.DEBUFF then
			var_6_3:setString(L_MONOPOLY[56])
		end

		var_6_3:align(cc.p(0.5, 0), var_6_2:size().w / 2, var_6_2:size().h - 140)

		local var_6_8 = TempWidget:CreateTempImg("skill_new/skill/" .. var_6_7.icon .. ".png", var_6_2)

		var_6_8:align(cc.p(0, 0.5), 110, var_6_2:size().h / 2 - 60)
		var_6_8:setScale(0.7)

		local var_6_9 = TempWidget:CreateTempLabel(var_6_7.name, FONT_NAME, 25, var_6_8)

		var_6_9:align(cc.p(0, 1), var_6_8:size().w + 10, var_6_8:size().h - 5)

		local var_6_10 = TempWidget:CreateTempLabel(var_6_7.buff_des, FONT_NAME, 25, var_6_8)

		var_6_10:align(cc.p(0, 0), var_6_8:size().w + 10, 5)

		if var_6_4 then
			var_6_9:_setColor(var_6_4)
			var_6_10:_setColor(var_6_4)
		end
	elseif self._data.type == var_6_0.EVENTS_TYPE.REMOVE_BUFFS then
		var_6_3:setString(L_MONOPOLY[57])
	elseif self._data.type == var_6_0.EVENTS_TYPE.AWARD then
		local var_6_11 = clone(self._data.data.items)
		local var_6_12 = ""

		for iter_6_0 = 1, #var_6_11 do
			local var_6_13 = 0

			if playermodel.items[var_6_11[iter_6_0].entityid] then
				var_6_13 = var_6_11[iter_6_0].itemcount - playermodel.items[var_6_11[iter_6_0].entityid].number
			else
				-- block empty
			end

			var_6_12 = var_6_12 .. var_6_13 .. L_MONOPOLY[58] .. item_data[var_6_11[iter_6_0].itemid].name
			var_6_12 = iter_6_0 == #var_6_11 and var_6_12 .. "。" or var_6_12 .. "，"
		end

		var_6_3:setString(L_MONOPOLY[59] .. var_6_12)
	elseif self._data.type == var_6_0.EVENTS_TYPE.FIGHT then
		if self._data.data.gold > 0 then
			var_6_3:setString(var_0_9(L_MONOPOLY[60], self._data.data.gold))
		else
			var_6_3:setString(var_0_9(L_MONOPOLY[61], -self._data.data.gold))
		end
	end
end

function MonopolyTipsLayer:initListener()
	self._root:_addEvent(function()
		if not self._isBcak then
			self._isBcak = true

			self:exitHandle()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function MonopolyTipsLayer:exitHandle()
	local var_10_0 = require("controller.monopoly.monopoly_manager"):getInstance()

	if self._data.justTips then
		var_10_0:handleEvents()
	else
		self._data.haveTips = true

		var_10_0:insertEvent(self._data)
		var_10_0:handleEvents()
	end
end

function MonopolyTipsLayer:updateLayer()
	return
end

function MonopolyTipsLayer:updateRed()
	return
end

return MonopolyTipsLayer
