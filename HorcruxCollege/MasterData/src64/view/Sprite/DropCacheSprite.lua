local DropCacheSP = class("DropCacheSP", function()
	return ccui.Layout:create()
end)
local var_0_1 = config._DEBUG and 0 or 1
local dropcache_manager = require("controller.dropcache_manager")
local component_manager = require("controller.component_manager")
local level_manager = require("controller.level_manager")
local item_data = require("data.item_data")
local novice_pass_level_data = require("data.novice_pass_level_data")
local playermodel = require("model.playermodel")

function DropCacheSP:create()
	local var_2_0 = DropCacheSP.new()

	var_2_0:init()

	return var_2_0
end

function DropCacheSP:ctor()
	self:setContentSize(cc.size(100, 120))
	self:setTouchEnabled(true)
end

function DropCacheSP:init()
	self:initBOX()
	self:checkPlayerDropCache()
	self:initFreeQuickFightReddot()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("syncDropCache", function(arg_5_0)
		if arg_5_0.item then
			self:insertNewItemToDropCache(arg_5_0.item)
		end
	end), self)
end

function DropCacheSP:initBOX()
	self.box = L2Skeleton:create("spine/ui/baoxiang.json", "spine/ui/baoxiang.atlas")

	self.box:refreshSkeleton()
	self.box:setPosition(cc.p(40, 40))
	self.box:setScale(1.4, 1.4)
	self:addChild(self.box)

	self.light = L2Skeleton:create("spine/ui/baodian.json", "spine/ui/baodian.atlas")

	self.light:refreshSkeleton()
	self.light:setPosition(cc.p(40, 0))
	self.light:setScale(1.5, 1.5)
	self.light:setVisible(false)
	self:addChild(self.light, 1)
	self.light:registerListener(SP_ANIMATION_COMPLETE, function(arg_7_0)
		if arg_7_0.animation == "baodian" then
			self.light:setVisible(false)
		end
	end)
	self:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		GuideListener.lockGuideTrigger(true)
		GuideListener.cleanCurGuides()
		self:showCacheItems()
	end)
end

function DropCacheSP:checkPlayerDropCache()
	if dropcache_manager:isDropCacheEmpty() then
		self:playEmpty()
	elseif dropcache_manager:isDropCacheFull() then
		self:playFull()
	else
		self:playHave()
	end
end

function DropCacheSP:updatePlayerDropCacheTime()
	return
end

function DropCacheSP:playEmpty()
	if self.box.lastAniName == "baoxiang1" then
		return
	end

	self.box:play("baoxiang1")
end

function DropCacheSP:playHave()
	if self.box.lastAniName == "baoxiang2" then
		return
	end

	self.box:play("baoxiang2")
end

function DropCacheSP:playFull()
	if self.box.lastAniName == "baoxiang3" then
		return
	end

	self.box:play("baoxiang3")
end

local var_0_15 = {
	"FightLayer/anim_quality_equipment_lv1.png",
	"FightLayer/anim_quality_equipment_lv2.png",
	"FightLayer/anim_quality_equipment_lv3.png",
	"FightLayer/anim_quality_equipment_lv4.png",
	"FightLayer/anim_quality_equipment_lv5.png",
	"FightLayer/anim_quality_equipment_lv5.png"
}

local function var_0_16(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getChildByName("item")
	local var_14_1 = arg_14_0:getPositionX()

	arg_14_0:runAction(cc.Sequence:create(cc.MoveTo:create(0.3333333333333333, cc.p(arg_14_0:getPositionX(), 467)), cc.DelayTime:create(0.8333333333333334), cc.BezierTo:create(0.3333333333333333, {
		cc.p(var_14_1, 467),
		cc.p((var_14_1 - 55) / 2 + 55 + 50, (467 - 70) / 2 + 70 + 400),
		cc.p(55, 100)
	}), cc.CallFunc:create(arg_14_1), cc.DelayTime:create(0.16666666666666666), cc.RemoveSelf:create()))
	arg_14_0:getChildByName("light"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.3333333333333333, 1), cc.RotateTo:create(0.16666666666666666, 44), cc.RotateTo:create(0.6666666666666666, 164), cc.ScaleTo:create(0.3333333333333333, 0.6), cc.FadeOut:create(0.16666666666666666)))
	var_14_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.3333333333333333, 168 / var_14_0:getContentSize().width), cc.DelayTime:create(0.8333333333333334), cc.ScaleTo:create(0.3333333333333333, 168 / var_14_0:getContentSize().width * 0.4), cc.FadeOut:create(0.16666666666666666)))
end

local function var_0_17(arg_15_0)
	local var_15_0 = item_data[arg_15_0].word_color or "255,255,255"
	local var_15_1 = cc.c3b(string.split(var_15_0, ",")[1], string.split(var_15_0, ",")[2], string.split(var_15_0, ",")[3])
	local var_15_2 = ccui.ImageView:create(item_data[arg_15_0].word_bg and "equipment/" .. item_data[arg_15_0].word_bg .. ".png")
	local var_15_3 = cc.Label:createWithTTF(item_data[arg_15_0].name, item_data[arg_15_0].word_font or FONT_NAME, item_data[arg_15_0].word_font_size or 40)

	var_15_3:setName("word")
	var_15_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_15_3:setPosition(cc.p(var_15_2:getContentSize().width / 2 + (item_data[arg_15_0].word_offset_x or 0), var_15_2:getContentSize().height / 2 + (item_data[arg_15_0].word_offset_y or 0)))
	var_15_3:setColor(var_15_1)

	if item_data[arg_15_0].word_shadow ~= 0 then
		var_15_3:enableShadow(cc.c4b(0, 0, 0, 150), cc.size(1, -1))
	end

	var_15_2:addChild(var_15_3)

	return var_15_2
end

local function var_0_18(arg_16_0)
	local var_16_0 = cc.Node:create()
	local var_16_1 = item_data[arg_16_0]
	local var_16_2

	if item_data[arg_16_0].bag_item_type == kITEM_COMPONENT then
		var_16_2 = component_manager:create_component_icon(arg_16_0)

		if not var_16_2 then
			if var_16_1.bag_item_type == KITEM_SPRING_FESTIVAL_WORD and var_16_1.word_bg then
				var_16_2 = var_0_17(arg_16_0) or cc.Sprite:create("equipment/" .. var_16_1.image_id .. ".png")
			end
		end
	end

	var_16_2:setScale(168 / var_16_2:getContentSize().width * 0.4)
	var_16_2:setName("item")
	var_16_0:addChild(var_16_2, 2)

	local var_16_3

	if config._DEBUG then
		var_16_3 = cc.Sprite:create(var_0_15[var_16_1.equip_quality]) or cc.Sprite:createWithSpriteFrameName(var_0_15[var_16_1.equip_quality])
	end

	var_16_3:setScale(0.4)
	var_16_3:setName("light")
	var_16_0:addChild(var_16_3, 1)

	var_16_0.playAction = var_0_16

	return var_16_0
end

function DropCacheSP:insertNewItemToDropCache(arg_17_1)
	local var_17_0 = var_0_18(arg_17_1)

	var_17_0:setPosition(cc.p(250 - math.random(1, 100), 200 + math.random(1, 100)))
	self:addChild(var_17_0, 10)
	var_17_0:playAction(function()
		self.light:setVisible(true)
		self.light:play("baodian", false)
	end)
end

function DropCacheSP:showCacheItems()
	AnalyticManager.click_cachbag_guji()
	LayerManager:pushInLayer("FightResultLayerNew", {
		createItemType = "itemid",
		items = require("model.playermodel").dropcache,
		surecallback = function()
			self:checkPlayerDropCache()
			AnalyticManager.collectDropcache()
		end,
		cancelcallback = function()
			return
		end
	})
end

function DropCacheSP:initFreeQuickFightReddot()
	local var_22_0 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_1)

	var_22_0:setPosition(cc.p(100, 100))
	self:addChild(var_22_0)

	function var_22_0:update()
		self:setVisible(level_manager:isDailyFreeFightTime())
	end

	var_22_0:update()

	local var_22_1 = ccui.ImageView:create("public/reddot/redot_levelpass_award.png", var_0_1)

	var_22_1:setAnchorPoint(0.5, 0)
	var_22_1:setPosition(self:getContentSize().width / 2 - 5, self:getContentSize().width - 22)
	self:addChild(var_22_1, 20)

	function var_22_1:update()
		if not level_manager:isPlayerPassLevel(3006) then
			self:setVisible(false)

			return
		end

		self:setVisible(self:CheckHasAward())
	end

	var_22_1:update()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("onQuickFight", function(arg_25_0)
		var_22_0:update()
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("passLevel", function(arg_26_0)
		var_22_1:update()
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("getPassLevelAward", function(arg_27_0)
		var_22_1:update()
	end), self)
end

function DropCacheSP:CheckHasAward()
	local var_28_0 = {}
	local var_28_1 = {}

	for iter_28_0, iter_28_1 in pairs(playermodel.novice_pass_level_award) do
		var_28_1[iter_28_1] = true
	end

	for iter_28_2, iter_28_3 in pairs(novice_pass_level_data) do
		table.insert(var_28_0, {
			id = iter_28_3.id,
			state = var_28_1[iter_28_3.id]
		})
	end

	table.sort(var_28_0, function(arg_29_0, arg_29_1)
		local var_29_0 = arg_29_0.state and 1 or 0
		local var_29_1 = arg_29_1.state and 1 or 0

		if (arg_29_0.state and 1 or 0) == (arg_29_1.state and 1 or 0) then
			return arg_29_0.id < arg_29_1.id
		else
			return var_29_0 < var_29_1
		end
	end)

	if not var_28_0[1].state then
		return novice_pass_level_data[var_28_0[1].id].limit_level and level_manager:isPlayerPassLevel(novice_pass_level_data[var_28_0[1].id].limit_level)
	end

	return false
end

return DropCacheSP
