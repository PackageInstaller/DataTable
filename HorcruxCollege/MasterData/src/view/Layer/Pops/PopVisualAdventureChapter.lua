PopVisualAdventureChapter = class("PopVisualAdventureChapter", function()
	return PopBaseLayer:create()
end)

local var_0_1 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")
require("view.Layer.BattleArrayLayerNew")

local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local drop_data = require("data.drop_data")
local levelmode_data = require("data.levelmode_data")
local var_0_12 = {
	off = "adventure_score/award_get_off.png",
	on = "adventure_score/award_get.png"
}

function PopVisualAdventureChapter.create(arg_2_0, arg_2_1)
	local var_2_0 = PopVisualAdventureChapter.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopVisualAdventureChapter:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopVisualAdventureChapter.json" or "PopVisualAdventureChapter.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer)

	self.zhupanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")
	self.label1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_54")
	self.label2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_54_0")
	self.items_pos = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_57")
	self.tips1 = ccui.Helper:seekWidgetByName(self.rootLayer, "tips1")
	self.tips2 = ccui.Helper:seekWidgetByName(self.rootLayer, "tips2")
	self.get_btn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_53")

	if arg_3_1 then
		self.callback = arg_3_1.callback or nil
	end

	if arg_3_1 then
		self.modetype = arg_3_1.modetype or nil
	end

	self.haveaward = false

	self:getListData()
	self:initpanel()
	self:fullScreen(self.rootLayer)
	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(self.zhupanel, function()
			LayerManager:removePopLayer()

			if self.callback then
				self.callback()
			end
		end)
	end)
	global_window_open_action(self.zhupanel)
end

function PopVisualAdventureChapter:initpanel()
	self:updateScore()
	self.tips1:getChildByName("Label_59"):getVirtualRenderer():setMaxLineWidth(430)
	self.tips2:getChildByName("Label_59"):getVirtualRenderer():setMaxLineWidth(430)
	self.tips1:getChildByName("Label_59"):setString(L_AVAON_VISUAL.tips_1)
	self.tips2:getChildByName("Label_59"):setString(L_AVAON_VISUAL.tips_2)

	if self.tips1:getContentSize().height > 26 then
		self.tips2:setPositionY(self.tips1:getPositionY() - 63 - self.tips1:getChildByName("Label_59"):getContentSize().height / 2)
	end

	self.get_btn:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_7_0:isBright() then
			return
		end

		local function var_7_0(arg_8_0)
			if arg_8_0.result == 1 then
				if self.callback then
					self.callback(true)
				end

				self:getListData()
			else
				global_ShowBlockWords(L_AVAON_VISUAL.no_award)
			end

			arg_7_0:isBright(true)
		end

		arg_7_0:isBright(false)
		level_manager:get_adventure_score_awards(nil, self.modetype, nil, var_7_0)
	end)
	self:updateAwardBtnStatus()
end

function PopVisualAdventureChapter:updateScore()
	local var_9_0 = self.usescore

	self.label1:setFontSize(24)

	if self.havescore then
		self.label1:setString("" .. self.havescore)
	else
		self.label1:setString("")
	end

	if var_9_0 then
		self.label2:setString(string.format(L_AVAON_VISUAL.used_score, var_9_0))
	else
		self.label2:setString("")
	end

	if self.items_pos:getChildByName("items_icon") then
		self.items_pos:getChildByName("items_icon"):removeFromParent()
	end

	self.items_pos:setCascadeOpacityEnabled(false)

	if self.award and next(self.award) and self.award[1] then
		local var_9_1 = ItemPurchaseSprite:createPurchaseItem(self.award[1].dropid, self.award[1].dropNum)

		var_9_1:setName("items_icon")
		self.items_pos:addChild(var_9_1, 100)
		var_9_1:setPosition(cc.p(self.items_pos:getContentSize().width / 2, self.items_pos:getContentSize().height / 2))
	end
end

function PopVisualAdventureChapter:getListData()
	level_manager:is_have_adventure_awards(nil, self.modetype, function(arg_11_0)
		if arg_11_0.result == 1 then
			self.havescore = arg_11_0.canexchangescore
			self.usescore = arg_11_0.exchangedscore

			if arg_11_0.items then
				self.award = arg_11_0.items
				self.haveaward = true
			end

			if arg_11_0.gold then
				self.gold = arg_11_0.gold or 0
			end

			if arg_11_0.diamond then
				self.diamond = arg_11_0.diamond or 0
			end

			if arg_11_0.sp then
				self.sp = arg_11_0.sp or 0
			end

			self:updateScore()
		else
			if not arg_11_0.exchangedscore then
				self.usescore = arg_11_0.exchangedscore or 0
			end

			self.havescore = 0
			self.award = nil
			self.gold = 0
			self.diamond = 0
			self.sp = 0
			self.haveaward = false

			self:updateScore()
		end

		self:updateAwardBtnStatus()
	end)
end

function PopVisualAdventureChapter:updateAwardBtnStatus()
	if self.haveaward then
		self.get_btn:loadTextures(var_0_12.on, nil, var_0_12.on, var_0_1)
	else
		self.get_btn:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_1)
	end
end

function PopVisualAdventureChapter:fullScreen(arg_13_1)
	arg_13_1:setContentSize((GameDisplay.getScreenSize()))
	arg_13_1:setPositionY(arg_13_1:getPositionY() - GameDisplay.fix_y)
	self.zhupanel:setPositionY(self.zhupanel:getPositionY() + GameDisplay.fix_y)
end

function PopVisualAdventureChapter:initBg(arg_14_1)
	local var_14_0 = ccui.Layout:create()

	var_14_0:setTouchEnabled(true)
	var_14_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_14_0:setAnchorPoint(cc.p(0, 0))
	var_14_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_14_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_14_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_14_0:setOpacity(0)
	var_14_0:setCascadeOpacityEnabled(false)
	self:addChild(var_14_0, -1)

	local var_14_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_14_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_14_1:setPositionX(var_14_0:getContentSize().width / 2)
	var_14_1:setPositionY(var_14_0:getContentSize().height / 2)
	var_14_0:addChild(var_14_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_15_0)
		self:addChild(arg_15_0, -2)
		arg_15_0:setPositionY(arg_15_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_14_1)
		var_14_0:setOpacity(102)
		var_14_0:setTouchEnabled(false)
	end)
end

function PopVisualAdventureChapter:exit()
	global_window_close_action(self.zhupanel, function()
		LayerManager:removePopLayer()

		if self.callback then
			self.callback()
		end
	end)
end
