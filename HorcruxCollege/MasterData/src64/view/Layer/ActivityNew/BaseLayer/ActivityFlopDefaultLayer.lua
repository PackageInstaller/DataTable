ActivityFlopDefaultLayer = class("ActivityFlopDefaultLayer", function()
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

function ActivityFlopDefaultLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityFlopDefaultLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityFlopDefaultLayer:initDynaticPara(arg_3_1)
	self.layerName = "ActivityFlopLayer_" .. arg_3_1.activityid or "ActivityFlopLayer_149"
	self.id = arg_3_1.activityid or 10000
	self.bgPath = "activitiesRes/activity" .. self.id .. "/flop/flop_bg.png"
	self.rolebg = "activitiesRes/activity" .. self.id .. "/flop/"
	self.texturePath = "Activities/activity" .. self.id .. "/flop/"

	local var_3_0 = "Activities_activity" .. arg_3_1.activityid .. "_flop"

	TextureManager:loadLayerTextures({
		"Activities_activity" .. arg_3_1.activityid .. "_flop"
	})
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			TextureManager:removeLayerTextures({
				var_3_0
			})
		end
	end)
	self:getParamFromUIConf()
end

function ActivityFlopDefaultLayer:updateChampionTipLabel()
	if not self.championBg:getChildByName("tip") then
		local var_5_0 = cc.Label:createWithTTF(L_FLOP_CHAMPION_TIP, FONT_BUTTON, 17)

		var_5_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_5_0:setColor(cc.c3b(255, 255, 255))
		var_5_0:setName("tip")
		var_5_0:setPosition(cc.p(self.championBg:getContentSize().width / 2, 15))
		self.championBg:addChild(var_5_0)
	end
end

function ActivityFlopDefaultLayer:fullScreen()
	self.drawBg:setPositionY(self.championBg:getPositionY() - 10)
	self.bigRole:setPositionY(GameDisplay.height)
	self.Title:setPositionY(self.bigRole:getPositionY() - self.bigRole:getContentSize().height / 2 + 185)

	self.bottomList.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomList:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomList:setPositionY(0)
	self.changeSkinBtn:setPositionY(self.shopbtn:getPositionY() - (self.shopbtn:getPositionY() - self.drawBg:getPositionY() - 50) / 2)
end

function ActivityFlopDefaultLayer:initOther()
	local var_7_0 = ccui.ImageView:create(self.rolebg .. "role_bg_0.png")

	var_7_0:setAnchorPoint(cc.p(0.5, 1))
	var_7_0:setPosition(cc.p(320, self.rootLayer:getContentSize().height * 0.6))
	self.rootLayer:addChild(var_7_0)

	self.bigRole = var_7_0

	self.bigRole:setTouchEnabled(true)
	self.bigRole:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.skinItemid then
			return
		end

		self:showSoulGirlPop({
			itemid = self.skinItemid
		})
	end)

	local var_7_1 = ccui.ImageView:create(self.texturePath .. "champion_detail_2.png", var_0_5)

	self.drawBg:addChild(var_7_1)
	var_7_1:setAnchorPoint(cc.p(1, 0))
	var_7_1:setPosition(cc.p(self.drawBg:getContentSize().width - 10, self.drawBg:getContentSize().height + 7))
end

function ActivityFlopDefaultLayer.updateSkin(arg_9_0, arg_9_1, arg_9_2)
	return
end
