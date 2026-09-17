require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")

require("view.Layer.PopLayer")

PhotoGoodsPopLayer = class("PhotoGoodsPopLayer", function()
	return cc.Layer:create()
end)

function PhotoGoodsPopLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PhotoGoodsPopLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

local food_photo_data = require("data.food_photo_data")
local food_data = require("data.food_production.eatables.food_data")
local item_data = require("data.item_data")
local medal_data = require("data.medal_data")
local photogoods_component_data = require("data.photogoods_component_data")
local var_0_8 = 1
local var_0_9 = 2
local var_0_10 = 3

function PhotoGoodsPopLayer:init(arg_3_1)
	self.parms = arg_3_1 or {}
	self.id = arg_3_1.id
	self.type = arg_3_1.goodsType or var_0_8
	self.photoSelectIndex = arg_3_1.photoSelectIndex or 1
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PhotoGoodsPop.json" or "PhotoGoodsPop.ExportJson")

	self:addChild(self.rootlayer)

	self.resultFood = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_resultFood")
	self.resultFoodInfo = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_resultFoodInfo")

	self.rootlayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
			ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_showPanel"):runAction(cc.ScaleTo:create(0.2, 1, 0))
		end), cc.DelayTime:create(0.2), cc.RemoveSelf:create()))
	end)

	if self.type == var_0_8 then
		self:showFoodInfo()
	end

	if self.type == var_0_9 then
		self:showMedalInfo()
	end

	if self.type == var_0_10 then
		self:showPartsInfo()
	end

	ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_showPanel"):setPosition(cc.p(320, 568))
	ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_showPanel"):setScaleY(0)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_showPanel"):runAction(cc.ScaleTo:create(0.2, 1))
end

function PhotoGoodsPopLayer:showFoodInfo()
	ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_foodFrame"):setVisible(true)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_foodFrame"):setPosition(cc.p(602, 817))

	local var_6_0 = ItemSprite:createNewWithItemId(self.id, nil, "diamond")

	var_6_0:setScale(0.8)
	self.resultFood:addChild(var_6_0)
	self.resultFoodInfo:setString(food_photo_data[self.id].production)

	for iter_6_0 = 1, 4 do
		if food_photo_data[self.id]["base_food" .. iter_6_0] then
			local var_6_1 = ItemSprite:createNewWithItemId(food_photo_data[self.id]["base_food" .. iter_6_0], nil, "withoutBox", "")

			var_6_1:setScale(0.6)

			local var_6_2 = cc.Label:createWithTTF(item_data[food_photo_data[self.id]["base_food" .. iter_6_0]].name, "fonts/number.ttf", 18)
			local var_6_3 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_food" .. iter_6_0)

			var_6_3:addChild(var_6_1)
			var_6_3:addChild(var_6_2)
			var_6_2:setPosition(cc.p(var_6_1:getPositionX(), var_6_1:getPositionY() - var_6_1:getContentSize().width / 2 * 0.6))
		end
	end

	ccui.Helper:seekWidgetByName(self.rootlayer, "Button_foodGetWays"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopGoGainLayer", {
			goto_back_system_id = 172,
			item = self.id,
			goto_back_system_config = self.parms,
			surecallback = function()
				if require("controller.layerconfig.pop_layer_infos")[layerName] then
					-- block empty
				else
					self:runAction(cc.RemoveSelf:create())
				end
			end
		})
	end)
end

function PhotoGoodsPopLayer:showPartsInfo()
	ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_partsFrame"):setVisible(true)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_partsFrame"):setPosition(cc.p(602, 817))

	local var_9_0 = {
		"bg_white.png",
		"bg_green.png",
		"bg_blue.png",
		"bg_purple.png",
		"bg_orange.png"
	}

	self.partsSp = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_partsSp")

	local var_9_1

	if config._DEBUG then
		var_9_1 = cc.Sprite:create("parts/" .. var_9_0[photogoods_component_data[self.id].equip_quality]) or cc.Sprite:createWithSpriteFrameName("parts/" .. var_9_0[photogoods_component_data[self.id].equip_quality])
	end

	var_9_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_9_1:setScale(0.5)
	var_9_1:setPosition(cc.p(90, 140))

	local var_9_2

	if config._DEBUG then
		var_9_2 = cc.Sprite:create("parts/new/" .. photogoods_component_data[self.id].image_id .. ".png") or cc.Sprite:createWithSpriteFrameName("parts/new/" .. photogoods_component_data[self.id].image_id .. ".png")
	end

	var_9_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_9_2:setPosition(cc.p(var_9_1:getContentSize().width / 2, var_9_1:getContentSize().height / 2))
	var_9_1:addChild(var_9_2, 1)
	self.partsSp:addChild(var_9_1)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Label_partsName"):setString(photogoods_component_data[self.id].name)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Label_attrDes"):setString(photogoods_component_data[self.id].descrip)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Label_describe"):setString(photogoods_component_data[self.id].intro)

	self.partsGetWays = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_partsGetWays")

	self.partsGetWays:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopGoGainLayer", {
			goto_back_system_id = 172,
			item = self.id,
			goto_back_system_config = self.parms,
			surecallback = function()
				if require("controller.layerconfig.pop_layer_infos")[layerName] then
					-- block empty
				else
					self:runAction(cc.RemoveSelf:create())
				end
			end
		})
	end)
end

function PhotoGoodsPopLayer:showMedalInfo()
	ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_medalFrame"):setVisible(true)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_medalFrame"):setPosition(cc.p(602, 817))

	self.medalSpPanel = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_medalSp")
	self.medalTitleLabel = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_titleText")
	self.medalGetWaysButton = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_getWays")
	self.medalGetWaysLabel = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_getWays")
	self.medalDesLabel = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_medalDes")

	local var_12_0 = ItemSprite:createNewWithItemId(self.id, nil, "diamond")

	var_12_0:setScale(0.8)
	self.medalSpPanel:addChild(var_12_0)
	self.medalTitleLabel:setString(medal_data[self.id].name)
	self.medalDesLabel:setString(medal_data[self.id].intro)
	self.medalGetWaysButton:setBright(true)
	self.medalGetWaysButton:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_13_0:isBright() then
			return
		end

		LayerManager:pushInLayer("PopGoGainLayer", {
			goto_back_system_id = 172,
			item = self.id,
			goto_back_system_config = self.parms,
			surecallback = function()
				if require("controller.layerconfig.pop_layer_infos")[layerName] then
					-- block empty
				else
					self:runAction(cc.RemoveSelf:create())
				end
			end
		})
	end)
end
