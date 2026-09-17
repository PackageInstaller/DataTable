ActivityFlopSummerLayer = class("ActivityFlopSummerLayer", function()
	return ActivityFlopBaseLayer:create()
end)

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local var_0_5 = config._DEBUG and 0 or 1
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local favorfile_data = require("data.favorfile_data")

function ActivityFlopSummerLayer.create(arg_2_0)
	local var_2_0 = ActivityFlopSummerLayer.new()

	var_2_0:init()

	return var_2_0
end

function ActivityFlopSummerLayer:initDynaticPara()
	self.layerName = "ActivityFlopSummerLayer"
	self.id = 123
	self.bgPath = "mainScenebg/activity/branch" .. self.id .. "/BG.png"
	self.rolebg = "mainScenebg/activity/branch" .. self.id .. "/"
	self.texturePath = "ActivityPreSummer/"
end

function ActivityFlopSummerLayer:initTitle()
	local var_4_0 = ccui.ImageView:create(self.texturePath .. "banner.png", var_0_5)

	var_4_0:setAnchorPoint(cc.p(0, 0.5))
	var_4_0:setPosition(cc.p(0, self.rootLayer:getContentSize().height * 0.93))
	self.rootLayer:addChild(var_4_0, 1)
	var_4_0:setTouchEnabled(true)
	var_4_0:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.clickIllustration()
		LayerManager:pushInLayer("PopActivityDetail", {
			key = "activity_flop_presummer"
		})
	end)

	self.Title = var_4_0
end

function ActivityFlopSummerLayer:initDrawBg()
	local var_6_0 = ccui.ImageView:create(self.texturePath .. "champion_bg.png", var_0_5)

	var_6_0:setAnchorPoint(cc.p(0.5, 0))
	var_6_0:setPosition(cc.p(var_6_0:getContentSize().width / 2 + 40, 740))
	self.rootLayer:addChild(var_6_0, 1)

	local var_6_1 = ccui.ImageView:create(self.texturePath .. "draw_bg.png", var_0_5)

	var_6_1:setAnchorPoint(cc.p(0.5, 1))
	var_6_1:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, var_6_0:getPositionY()))
	self.rootLayer:addChild(var_6_1, 1)

	self.championBg = var_6_0
	self.drawBg = var_6_1

	self.drawBg:setTouchEnabled(true)
end

function ActivityFlopSummerLayer:initAllBtn()
	local var_7_0 = ccui.Button:create(self.texturePath .. "btn_award_list.png", nil, self.texturePath .. "btn_award_list.png", var_0_5)

	var_7_0:setAnchorPoint(cc.p(1, 0))
	var_7_0:setPosition(cc.p(630, self.rootLayer:getContentSize().height * 0.9))
	self.rootLayer:addChild(var_7_0, 5)

	local var_7_1 = ccui.Button:create(self.texturePath .. "btn_get_more.png", nil, self.texturePath .. "btn_return.png", var_0_5)

	var_7_1:setAnchorPoint(cc.p(1, 0))
	var_7_1:setPosition(cc.p(var_7_0:getPositionX(), var_7_0:getPositionY() - var_7_1:getContentSize().height - 10))
	self.rootLayer:addChild(var_7_1, 5)

	self.shopbtn = var_7_1

	var_7_0:addTouchEventListener(function(arg_8_0, arg_8_1)
		local var_8_0

		if arg_8_1 ~= ccui.TouchEventType.ended then
			do return end

			var_8_0 = {
				callback = callback,
				category = {
					activityFlop = 1,
					type = 5
				}
			}
		end

		var_8_0.items_tbl = activity_manager:getDropConf(self.id)
		var_8_0.words_tbl = {
			type_tbl = {}
		}

		LayerManager:pushInLayer("DropDetailsLayer", var_8_0)
	end)
	var_7_1:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:getFlopLimitBag(self.id, function(arg_10_0)
			LayerManager:pushInLayer(self:getBuyLimitLayerName(), arg_10_0)
		end)
	end)
	self:initBottomList()
end

function ActivityFlopSummerLayer:initTicket()
	local var_11_0, var_11_1, var_11_2 = activity_manager:getFlopTicket(self.id)
	local var_11_3 = 10
	local var_11_4 = cc.Label:createWithTTF(L_OWN_TICKET, FONT_NAME, 26)

	var_11_4:setAnchorPoint(cc.p(1, 0.5))
	var_11_4:setName("ticketTitle")
	var_11_4:setColor(cc.c3b(130, 249, 255))
	var_11_4:setPosition(cc.p(self.drawBg:getContentSize().width / 2 - 35 + var_11_3, self.drawBg:getContentSize().height - 23))
	self.drawBg:addChild(var_11_4)

	local var_11_5 = cc.Label:createWithTTF(string.format("%d/%d", var_11_1, var_11_0), FONT_NAME, 26)

	var_11_5:setAnchorPoint(cc.p(0, 0.5))
	var_11_5:setName("ticketNum")
	var_11_5:setColor(var_11_0 <= var_11_1 and cc.c3b(130, 249, 255) or cc.c3b(255, 66, 66))
	var_11_5:setPosition(cc.p(self.drawBg:getContentSize().width / 2 + 35 + var_11_3, var_11_4:getPositionY()))
	self.drawBg:addChild(var_11_5)

	local var_11_6 = ccui.ImageView:create("equipment/" .. item_data[var_11_2].image_id .. ".png")

	var_11_6:setAnchorPoint(cc.p(0.5, 0.5))
	var_11_6:setScale(0.25)
	var_11_6:setPosition(cc.p(self.drawBg:getContentSize().width / 2 + var_11_3, var_11_4:getPositionY()))
	self.drawBg:addChild(var_11_6)

	local var_11_7 = ccui.ImageView:create(self.texturePath .. "plus.png", var_0_5)

	var_11_7:setAnchorPoint(cc.p(1, 0))
	var_11_7:setColor(cc.c3b(255, 255, 255))
	var_11_7:setPosition(cc.p(var_11_6:getContentSize().width + 20, 0))
	var_11_7:setScale(4)
	var_11_6:addChild(var_11_7)

	local var_11_8 = ccui.Layout:create()

	var_11_8:setContentSize(cc.size(220, 40))
	var_11_8:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_11_8:setAnchorPoint(0.5, 0.5)
	var_11_8:setTouchEnabled(true)
	var_11_8:setPosition(cc.p(self.drawBg:getContentSize().width / 2, self.drawBg:getContentSize().height - 23))
	self.drawBg:addChild(var_11_8, 5)
	var_11_6:setTouchEnabled(true)
	var_11_6:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:getFlopLimitBag(self.id, function(arg_13_0)
			LayerManager:pushInLayer(self:getBuyLimitLayerName(), arg_13_0)
		end)
	end)
	var_11_8:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:getFlopLimitBag(self.id, function(arg_15_0)
			LayerManager:pushInLayer(self:getBuyLimitLayerName(), arg_15_0)
		end)
	end)

	self.ticketNum = var_11_5
end

function ActivityFlopSummerLayer:initOther()
	local var_16_0 = cc.Label:createWithTTF(L_FLOP_TIPS, FONT_DES, 20)

	var_16_0:setAnchorPoint(cc.p(1, 1))
	var_16_0:setName("flopTurns")
	var_16_0:setColor(cc.c3b(128, 122, 255))
	var_16_0:setPosition(cc.p(630, self.drawBg:getContentSize().height - 650 - GameDisplay.fix_y))
	self.drawBg:addChild(var_16_0)

	local var_16_1 = ccui.ImageView:create(self.rolebg .. "role_bg_0.png")

	var_16_1:setAnchorPoint(cc.p(0.5, 1))
	var_16_1:setPosition(cc.p(320, self.rootLayer:getContentSize().height * 0.6))
	self.rootLayer:addChild(var_16_1)

	self.bigRole = var_16_1

	self.bigRole:setTouchEnabled(true)
	self.bigRole:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
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

function ActivityFlopSummerLayer:updateTicket()
	local var_18_0, var_18_1 = activity_manager:getFlopTicket(self.id)

	self.ticketNum:setString(string.format("%d/%d", var_18_1, var_18_0))
	self.ticketNum:setColor(var_18_0 <= var_18_1 and cc.c3b(130, 249, 255) or cc.c3b(255, 66, 66))
end

function ActivityFlopSummerLayer:updateOther()
	for iter_19_0, iter_19_1 in pairs(self.cardTbl) do
		local var_19_0 = iter_19_1:getPos()
		local var_19_1 = ccui.ImageView:create(self.texturePath .. "card_background.png", var_0_5)

		var_19_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_19_1:setPosition(cc.p(var_19_0.x, var_19_0.y))
		self.drawBg:addChild(var_19_1, 0)
	end
end

function ActivityFlopSummerLayer.getFlopShop(arg_20_0)
	return {
		"1-18888"
	}
end

function ActivityFlopSummerLayer.getBuyLimitLayerName(arg_21_0)
	return "PopFlopBuyLayer"
end

function ActivityFlopSummerLayer:fullScreen()
	self.championBg:setPositionY(self.championBg:getPositionY() + GameDisplay.fix_y)
	self.drawBg:setPositionY(self.championBg:getPositionY() + 2)
	self.bigRole:setPositionY(GameDisplay.height)

	self.bottomList.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomList:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomList:setPositionY(0)
	self.changeSkinBtn:setPositionY(self.shopbtn:getPositionY() - (self.shopbtn:getPositionY() - self.drawBg:getPositionY() - 50) / 2)
end
