PopServantAdvanceLayer = class("PopServantAdvanceLayer", function()
	return cc.Layer:create()
end)

local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local servant_advance_data = require("data.servant.servant_advance_data")
local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local souls_manager = require("controller.souls_manager")
local l2utils = require("controller.l2utils")
local LocalEvent = require("common.LocalEvent")
local Utility = require("common.Utility")
local var_0_9 = config._DEBUG and 0 or 1
local var_0_10 = {
	nil,
	"sr",
	"ur",
	"mr"
}

function PopServantAdvanceLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopServantAdvanceLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopServantAdvanceLayer:initBg(arg_3_1)
	local var_3_0 = ccui.Layout:create()

	var_3_0:setTouchEnabled(true)
	var_3_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_0:setAnchorPoint(cc.p(0, 0))
	var_3_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_3_0:setOpacity(0)
	self:addChild(var_3_0, -1)

	self.msg = arg_3_1
	self.surecallback = arg_3_1.surecallback

	require("controller.l2utils"):captureScreenGaussBlur(function(arg_4_0)
		self:addChild(arg_4_0, -2)
		arg_4_0:setPositionY(arg_4_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_3_1)
		var_3_0:setOpacity(102)
		var_3_0:setTouchEnabled(false)
	end)
end

function PopServantAdvanceLayer:init(arg_5_1)
	self.msg = arg_5_1
	self.servantid = arg_5_1.curSoul
	self.materials = arg_5_1.materials
	self.cancelcallback = arg_5_1.cancelcallback

	self:initData()
	self:initBaseUI()
	LocalEvent:registerEvent(self, LocalEvent.EVENT_IDS.COMPOUND_ITEM_ONE_KEY, handler(self, self.handleCompoundOneKey))
	Utility:registerNodeEvent(self)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			LocalEvent:removeEvent(self)
		end
	end)
end

function PopServantAdvanceLayer:initData()
	self.modelid = servant_data[self.servantid].modelid
	self.overclock = 0
	self.curRaity = souls_manager:get_servant_cur_roll_rarity(self.servantid)
	self.curContract = playermodel.soulContract[self.servantid]
	self.curDamage = model_data[self.modelid].damageFactor + souls_manager:get_add_damage_factor(self.servantid) + (servant_data[self.servantid]["damageOverPlus" .. self.overclock] or 0)
	self.curHp = model_data[self.modelid].hpFactor + souls_manager:get_add_hp_factor(self.servantid) + (servant_data[self.servantid]["hpOverPlus" .. self.overclock] or 0)
	self.nextRaity = self.curRaity + 1
	self.nextContract = 0
	self.nextDamage = souls_manager:get_next_roll_rarity_damage_factor(self.servantid)
	self.nextHp = souls_manager:get_next_roll_rarity_hp_factor(self.servantid)
end

function PopServantAdvanceLayer:initBaseUI()
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(cc.size(640, GameDisplay.height))
	self.rootLayer:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.rootLayer)
	self.rootLayer:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.cancelcallback then
			self.cancelcallback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)

	self.bg = ccui.ImageView:create("PopServantAdvanceLayer/bg.png", var_0_9)

	self.bg:setPosition(320, GameDisplay.height / 2)
	self.bg:setTouchEnabled(true)
	self.rootLayer:addChild(self.bg)

	local var_8_0 = cc.Label:createWithTTF(L_ADVANCE_POP.TITLE1 .. ":", FONT_NAME, 24)

	var_8_0:setAnchorPoint(cc.p(0, 0.5))
	var_8_0:setPosition(30, 286)
	var_8_0:setColor(global_c3b_parse("ffc258"))
	self.bg:addChild(var_8_0)

	local var_8_1 = cc.Label:createWithTTF(L_ADVANCE_POP.TITLE2 .. ":", FONT_NAME, 24)

	var_8_1:setAnchorPoint(cc.p(0, 0.5))
	var_8_1:setPosition(30, 150)
	var_8_1:setColor(global_c3b_parse("ffffff"))
	self.bg:addChild(var_8_1)
	self:initAttrPanel()
	self:initCostList()
	self:initSureBtn()
end

function PopServantAdvanceLayer:initAttrPanel()
	local var_10_1 = ccui.ImageView:create("PopServantAdvanceLayer/arrow_yellow.png", var_0_9)

	var_10_1:setPosition(320, 230)
	self.bg:addChild(var_10_1)

	local var_10_2 = ccui.ImageView:create("public/rarity/" .. var_0_10[self.curRaity] .. "_short.png", var_0_9)

	var_10_2:setPosition(210, 230)
	self.bg:addChild(var_10_2)

	local var_10_3 = ccui.ImageView:create("public/rolebg/+" .. self.curContract .. ".png", var_0_9)

	var_10_3:setPosition(260, 230)
	self.bg:addChild(var_10_3)

	local var_10_4 = ccui.ImageView:create("public/rarity/" .. var_0_10[self.nextRaity] .. "_short.png", var_0_9)

	var_10_4:setPosition(380, 230)
	self.bg:addChild(var_10_4)

	local var_10_5 = ccui.ImageView:create("public/rolebg/+" .. self.nextContract .. ".png", var_0_9)

	var_10_5:setPosition(430, 230)
	self.bg:addChild(var_10_5)
end

function PopServantAdvanceLayer:initCostList()
	self.icon = {}

	for iter_11_0, iter_11_1 in pairs(self.materials) do
		local var_11_0 = ItemPurchaseSprite:createPurchaseItem(iter_11_1.id)

		var_11_0:setScale(0.6)
		var_11_0:setPosition(320 + (iter_11_0 - (#self.materials + 1) / 2) * 113, 100)
		var_11_0:updateNeedNum(iter_11_1.neednum)

		var_11_0.needNum = iter_11_1.neednum

		self.bg:addChild(var_11_0)
		var_11_0:setInfoTouchEvent(true)

		self.icon[iter_11_0] = var_11_0
	end
end

function PopServantAdvanceLayer:initSureBtn()
	local var_12_0 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_9)

	var_12_0:setPosition(320, -50)
	self.bg:addChild(var_12_0)

	local var_12_1 = cc.Label:createWithTTF(L_BUTTON_TEXT.Advance, FONT_NAME, 34)

	var_12_1:setPosition(var_12_0:getContentSize().width / 2 - 5, var_12_0:getContentSize().height / 2 - 5)
	var_12_1:setColor(cc.c3b(0, 0, 0))
	var_12_0:addChild(var_12_1)
	var_12_0:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		souls_manager:servant_advance(self.servantid, function(arg_14_0)
			if arg_14_0.result == 1 then
				if self.surecallback then
					self.surecallback(arg_14_0)
				end

				LayerManager:removePopLayer(self.__queueindex)
			end
		end)
	end)
end

function PopServantAdvanceLayer.getOffset(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0
	local var_15_1

	if arg_15_3 then
		var_15_0 = model_data[arg_15_1].shadow_girl_offset_x or 0
		var_15_1 = model_data[arg_15_1].shadow_girl_offset_y or 0
	else
		var_15_0 = model_data[arg_15_1].upgrade_offset_x or model_data[arg_15_1].database_girl_offset_x or 0
		var_15_1 = model_data[arg_15_1].upgrade_offset_y or model_data[arg_15_1].database_girl_offset_y or 0
	end

	return (cc.p(var_15_0 + 320, var_15_1 + GameDisplay.height / 2))
end

function PopServantAdvanceLayer:handleCompoundOneKey()
	for iter_16_0, iter_16_1 in pairs(self.msg.materials or {}) do
		self.icon[iter_16_0]:updateNeedNum(iter_16_1.neednum)
	end
end
