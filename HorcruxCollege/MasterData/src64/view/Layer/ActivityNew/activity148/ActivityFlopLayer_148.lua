ActivityFlopLayer_148 = class("ActivityFlopLayer_148", function()
	return ActivityFlopBaseNewLayer:create()
end)

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local var_0_5 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSpriteFlop")

local item_data = require("data.item_data")
local model_data = require("data.model_data")
local favorfile_data = require("data.favorfile_data")
local activity_flop_condition_conf = require("data.activity_modules.activity_flop_condition_conf")
local activity_flop_ui_conf_data = require("data.activity_flop.uiconfig.activity_flop_ui_conf_data")

function ActivityFlopLayer_148.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityFlopLayer_148.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityFlopLayer_148:initDynaticPara(arg_3_1)
	self.layerName = "ActivityFlopLayer_" .. arg_3_1.activityid or "ActivityFlopLayer_149"
	self.id = arg_3_1.activityid or 10000
	self.bgPath = "activitiesRes/activity" .. self.id .. "/flop/flop_bg.png"
	self.rolebg = "activitiesRes/activity" .. self.id .. "/flop/"
	self.texturePath = "Activities/activity" .. self.id .. "/flop/"

	self:getParamFromUIConf()
end

function ActivityFlopLayer_148:initDrawBg()
	local var_4_0 = ccui.Layout:create()

	var_4_0:setContentSize(cc.size(0, 0))
	var_4_0:setAnchorPoint(0.5, 0)
	var_4_0:setPosition(cc.p(100, 755))
	self.rootLayer:addChild(var_4_0, 1)

	local var_4_1 = ccui.ImageView:create(self.texturePath .. "draw_bg.png", var_0_5)

	var_4_1:setAnchorPoint(cc.p(0.5, 1))
	var_4_1:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, var_4_0:getPositionY() + 10))
	self.rootLayer:addChild(var_4_1, 1)

	self.championBg = var_4_0
	self.drawBg = var_4_1

	self.drawBg:setTouchEnabled(true)
end

function ActivityFlopLayer_148:initFlopTurns()
	local var_5_0 = ccui.ImageView:create(self.texturePath .. "turns_ bg.png", var_0_5)

	var_5_0:setAnchorPoint(cc.p(1, 1))
	var_5_0:setPosition(cc.p(self.drawBg:getContentSize().width, self.drawBg:getContentSize().height + self:getUIConf().turns_label_offsetY))
	self.drawBg:addChild(var_5_0)

	self.turnsBg = var_5_0

	local var_5_1 = cc.Label:createWithTTF(L_FLOP_TURNS_NOW, FONT_DES, self.turnsLabelSize)

	var_5_1:setAnchorPoint(cc.p(0.5, 0))
	var_5_1:setColor(self.turnsLabelColor)
	var_5_1:setName("flopBgWord")
	var_5_1:setPosition(cc.p(175, var_5_0:getContentSize().height / 2 - 10))
	var_5_0:addChild(var_5_1)

	local var_5_2 = ccui.Layout:create()

	var_5_2:setContentSize(cc.size(60, var_5_1:getContentSize().height))
	var_5_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_5_2:setAnchorPoint(0.5, 0)
	var_5_2:setPosition(cc.p(var_5_1:getPositionX() + 15, var_5_1:getPositionY()))
	var_5_2:setName("numLayer")
	var_5_0:addChild(var_5_2)

	local var_5_3 = cc.Label:createWithTTF("/" .. activity_flop_condition_conf[self.id].flop_limit_turns, FONT_DES, self.turnsLabelSize)

	var_5_3:setAnchorPoint(cc.p(1, 0.5))
	var_5_3:setName("flopTotalTurns")
	var_5_3:setColor(self.turnsLabelColor)
	var_5_3:setPosition(cc.p(var_5_2:getContentSize().width / 2, var_5_2:getContentSize().height / 2))
	var_5_2:addChild(var_5_3)

	local var_5_4 = cc.Label:createWithTTF("", FONT_DES, self.turnsLabelSize)

	var_5_4:setAnchorPoint(cc.p(0, 0.5))
	var_5_4:setName("flopTurns")
	var_5_4:setColor(self.turnsLabelColorOn)
	var_5_4:setPosition(cc.p(var_5_2:getContentSize().width / 2, var_5_2:getContentSize().height / 2))
	var_5_2:addChild(var_5_4)

	self.flopTurns = var_5_4

	var_5_2:setContentSize(cc.size(var_5_3:getContentSize().width + var_5_4:getContentSize().width, var_5_1:getContentSize().height))
	var_5_2:setPositionX(var_5_1:getPositionX() + 20)
	var_5_3:setPositionX(var_5_2:getContentSize().width)
	var_5_4:setPositionX(0)
end

function ActivityFlopLayer_148:updateFlopTurns()
	local var_6_0 = self.turnsBg:getChildByName("flopBgWord")
	local var_6_1 = self.turnsBg:getChildByName("numLayer")
	local var_6_2 = var_6_1:getChildByName("flopTotalTurns")
	local var_6_3 = var_6_1:getChildByName("flopTurns")

	self.flopTurns:setString((activity_manager:getFlopTurns(self.id)))
	var_6_1:setContentSize(cc.size(var_6_2:getContentSize().width + var_6_3:getContentSize().width, var_6_0:getContentSize().height))
	var_6_1:setPositionX(var_6_0:getPositionX() + 20)
	var_6_2:setPositionX(var_6_1:getContentSize().width)
	var_6_3:setPositionX(0)
end

function ActivityFlopLayer_148.updateOther(arg_7_0)
	return
end

function ActivityFlopLayer_148:fullScreen()
	self.championBg:setPositionY(self.championBg:getPositionY() + GameDisplay.fix_y * 0.8)
	self.drawBg:setPositionY(self.championBg:getPositionY() + 22)
	self.bigRole:setPositionY(GameDisplay.height)
	self.Title:setPositionY(self.bigRole:getPositionY() - self.bigRole:getContentSize().height / 2 + 200 - GameDisplay.fix_y)

	self.bottomList.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomList:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomList:setPositionY(0)
	self.changeSkinBtn:setPositionY(self.shopbtn:getPositionY() - (self.shopbtn:getPositionY() - self.drawBg:getPositionY() - 50) / 2)
end

function ActivityFlopLayer_148:initOther()
	local var_9_0 = ccui.ImageView:create(self.rolebg .. "role_bg_0.png")

	var_9_0:setAnchorPoint(cc.p(0.5, 1))
	var_9_0:setPosition(cc.p(320, self.rootLayer:getContentSize().height * 0.6))
	self.rootLayer:addChild(var_9_0)

	self.bigRole = var_9_0

	self.bigRole:setTouchEnabled(true)
	self.bigRole:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.skinItemid then
			return
		end

		self:showSoulGirlPop({
			itemid = self.skinItemid
		})
	end)
end

function ActivityFlopLayer_148:updateChampionTipLabel()
	if not self.itemShade:getChildByName("tip") then
		local var_11_0 = cc.Label:createWithTTF(L_FLOP_CHAMPION_TIP, FONT_BUTTON, 18)

		var_11_0:setAnchorPoint(cc.p(0, 0.5))
		var_11_0:setName("tip")
		var_11_0:setPosition(cc.p(30, self.itemShade:getContentSize().height / 2 - 5))
		self.itemShade:addChild(var_11_0)
	end
end

function ActivityFlopLayer_148:updateFurniture()
	local var_12_0, var_12_1, var_12_2 = activity_manager:getFlopFurniture(self.id)

	print("furnitureturns ===== ", var_12_0, var_12_1, var_12_2)

	if not self.furniture then
		local var_12_3 = ccui.ImageView:create(self.texturePath .. "furniture_shade.png", var_0_5)

		var_12_3:setAnchorPoint(cc.p(0.5, 0))
		var_12_3:setPosition(cc.p(240, self.itemShade:getPositionY()))
		var_12_3:setName("furnitureLabelBg")
		self.championBg:addChild(var_12_3)

		local var_12_4 = cc.Label:createWithTTF(string.format(L_FLOP_FURNITURE_TIP, var_12_1, var_12_2), FONT_BUTTON, 18)

		var_12_4:setAnchorPoint(cc.p(0, 0.5))
		var_12_4:setName("furnitureLabel")
		var_12_4:setPosition(cc.p(30, var_12_4:getContentSize().height / 2 + 5))
		var_12_3:addChild(var_12_4)

		self.furnitureLabel = var_12_4

		local var_12_5 = ccui.ImageView:create(self.rolebg .. "furniture_" .. var_12_0 .. ".png")

		var_12_5:setName("championItem")
		var_12_5:setScale(0.25)
		var_12_5:setAnchorPoint(cc.p(0.5, 0))
		var_12_5:setPosition(cc.p(var_12_3:getContentSize().width / 2, 50))
		var_12_3:addChild(var_12_5)

		self.furnitureIndex = var_12_0
		self.furniture = var_12_5

		var_12_5:setTouchEnabled(true)
		var_12_5:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:createFurniturePanel()
		end)
	elseif self.furnitureIndex ~= var_12_0 then
		self.championBg:getChildByName("furnitureLabelBg"):getChildByName("furnitureLabel"):setString(string.format(L_FLOP_FURNITURE_TIP, var_12_1, var_12_2))
		self.furniture:loadTexture(self.rolebg .. "furniture_" .. var_12_0 .. ".png")

		self.furnitureIndex = var_12_0
	end
end

function ActivityFlopLayer_148:createFurniturePanel()
	if self.rootLayer:getChildByName("furniture_detail") then
		return
	end

	local var_14_0 = ccui.Layout:create()

	var_14_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_14_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_14_0:setAnchorPoint(0, 0)
	var_14_0:setPosition(cc.p(0, 0))
	var_14_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_14_0:setBackGroundColorOpacity(180)
	var_14_0:setName("furniture_detail")
	self.rootLayer:addChild(var_14_0, 99)

	local var_14_1 = ccui.Layout:create()

	var_14_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_14_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_14_1:setAnchorPoint(0.5, 0.5)
	var_14_1:setPosition(var_14_0:getContentSize().width / 2, var_14_0:getContentSize().height / 2)
	var_14_0:addChild(var_14_1, 2)

	local var_14_2 = ccui.ImageView:create("public/panelbg/bg_pop_small.png", var_0_5)

	var_14_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_14_2:setPosition(var_14_0:getContentSize().width / 2, var_14_0:getContentSize().height / 2)

	local var_14_3 = ccui.ImageView:create(self.rolebg .. "furniture_" .. furnitureIndex .. ".png")

	var_14_3:setScale(0.5)
	var_14_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_14_3:setPosition(cc.p(var_14_2:getContentSize().width / 2, var_14_2:getContentSize().height / 2))
	var_14_2:addChild(var_14_3)
	var_14_0:setTouchEnabled(true)
	var_14_1:setTouchEnabled(false)
	var_14_2:setScale(0)
	var_14_0:addChild(var_14_2, 10)
	var_14_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2), cc.ScaleTo:create(0.1, 1), cc.CallFunc:create(function()
		var_14_0:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_14_1:setTouchEnabled(true)
			var_14_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1.2), cc.ScaleTo:create(0.2, 0), cc.CallFunc:create(function()
				var_14_0:runAction(cc.RemoveSelf:create())
			end)))
		end)
	end)))
end
