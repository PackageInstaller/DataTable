local item_data = require("data.item_data")
local model_data = require("data.model_data")
local activity_manager = require("controller.activity_manager")
local armature_manager = require("controller.armature_manager")
local component_manager = require("controller.component_manager")
local var_0_5 = config._DEBUG and 0 or 1

ItemSpriteFlip = class("ItemSpriteFlip", function()
	return cc.Node:create()
end)

local var_0_6 = {
	"public/box/flop_bg_1.png",
	"public/box/flop_bg_2.png",
	"public/box/flop_bg_3.png",
	"public/box/flop_bg_4.png",
	"public/box/flop_bg_5.png",
	"public/box/flop_bg_6.png"
}

local function var_0_7(arg_2_0)
	local var_2_0 = -1
	local var_2_1 = require("data.horcrux_data")[arg_2_0].horcruxt

	for iter_2_0, iter_2_1 in pairs((require("data.photofile_HelpGirl_data"))) do
		if arg_2_0 == iter_2_1.item_id then
			var_2_0 = iter_2_0

			break
		end
	end

	if var_2_0 == -1 then
		print("did not find id")

		return
	end

	LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
		id = var_2_0,
		itemid = arg_2_0
	})
end

function ItemSpriteFlip.create(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = ItemSpriteFlip.new()

	var_3_0:init(arg_3_1, arg_3_2)

	return var_3_0
end

function ItemSpriteFlip:init(arg_4_1, arg_4_2)
	self.order = arg_4_2
	self.activityId = arg_4_1
	self.backImage = ccui.ImageView:create(string.format("Activities/activity%s/flop", self.activityId) .. "/card_back.png", var_0_5)

	self.backImage:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)
	self:addChild(self.backImage, 3)

	self.fontImage = ccui.ImageView:create("public/box/flop_bg_1.png", var_0_5)

	self.fontImage:setAnchorPoint(cc.p(0.5, 0.5))
	self.fontImage:setPositionX(self:getContentSize().width / 2)
	self.fontImage:setPositionY(self:getContentSize().height / 2)
	self.fontImage:setName("icon")
	self.fontImage:setVisible(false)
	self:addChild(self.fontImage, 0)

	self.itemIcon = ccui.ImageView:create("GUI/image.png", var_0_5)

	self.itemIcon:setAnchorPoint(cc.p(0.5, 0.5))
	self.itemIcon:setPositionX(self:getContentSize().width / 2)
	self.itemIcon:setPositionY(self:getContentSize().height / 2)
	self.itemIcon:setName("item_icon")
	self.itemIcon:setVisible(false)
	self:addChild(self.itemIcon, 1)

	self.numLabel = ccui.Text:create("X", FONT_NAME, 24)

	self.numLabel:setAnchorPoint(cc.p(1, 0))
	self.numLabel:setName("numLabel")
	self.numLabel:setVisible(false)
	self.itemIcon:addChild(self.numLabel, 1)

	self.animation = armature_manager:createAndPlayArmature("flop")

	self.animation:setPositionX(self:getContentSize().width / 2)
	self.animation:setPositionY(self:getContentSize().height / 2)
	self.animation:setVisible(false)
	self:addChild(self.animation, 2)
	self:initTouchEvent()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			activity_manager:releaseEventListenerByName("ItemSpriteFlip_" .. self.order)
		end
	end)
end

function ItemSpriteFlip:initTouchEvent()
	local function var_6_0(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.itemid then
			if item_data[self.itemid].bag_item_type == kITEM_HORCRUX then
				var_0_7(self.itemid)
			else
				LayerManager:pushInLayer("PopItemLayer", {
					itemid = self.itemid
				})
			end

			return
		end

		local var_7_0, var_7_1 = activity_manager:getFlopTicket(self.activityId)

		if var_7_1 < var_7_0 then
			activity_manager:getFlopLimitBag(self.activityId, 1)

			return
		end

		activity_manager:setActivityFlopResult(self.activityId, self.order)
	end

	self.fontImage:setTouchEnabled(true)
	self.fontImage:addTouchEventListener(var_6_0)
	self.backImage:setTouchEnabled(true)
	self.backImage:addTouchEventListener(var_6_0)
end

function ItemSpriteFlip:registerActivityEventListener()
	activity_manager:registerEventListener("ItemSpriteFlip_" .. self.order, activity_manager.activityEventId.ACTIVITY_FLOP_CONF_UPDATE, function(arg_9_0)
		if arg_9_0["pos_" .. self.order] then
			self:update(arg_9_0["pos_" .. self.order])
		elseif not arg_9_0.update then
			self:reset()
		end
	end)
	activity_manager:registerEventListener("ItemSpriteFlip_" .. self.order, activity_manager.activityEventId.ACTIVITY_FLOP_SET_RESULT, function(arg_10_0)
		if arg_10_0.pos ~= self.order then
			return
		end

		self:playTurnAni(arg_10_0)
	end)
end

function ItemSpriteFlip:update(arg_11_1)
	self.itemid = arg_11_1.itemid

	self.itemIcon:setVisible(true)
	self.fontImage:setVisible(true)
	self.backImage:setVisible(false)
	self.fontImage:loadTexture(var_0_6[item_data[self.itemid].equip_quality], var_0_5)
	self.numLabel:setVisible(arg_11_1.itemNum > 1)
	self.numLabel:setString("X" .. arg_11_1.itemNum)
	self.numLabel:setPosition(125, 5)

	if item_data[self.itemid].bag_item_type == kITEM_COMPONENT then
		self.itemIcon:setVisible(false)

		self.itemIcon = component_manager:create_component_icon(self.itemid)

		self.itemIcon:setName("component_icon")
		self.itemIcon:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
		self:addChild(self.itemIcon)
	else
		if self.itemIcon:getName() == "component_icon" then
			self.itemIcon:removeFromParent()
		end

		self.itemIcon = self:getChildByName("item_icon")

		self.itemIcon:setVisible(true)
		self.itemIcon:loadTexture("equipment/" .. item_data[self.itemid].image_id .. ".png")
	end

	function self.itemIcon:afterLoadSuccess()
		self:setScale(140 / self:getContentSize().height)
	end

	self.itemIcon:setScale((self.fontImage:getContentSize().height - 15) / self.itemIcon:getContentSize().height)

	if self.starsPanel then
		self.starsPanel:removeFromParent()

		self.starsPanel = nil
	end

	if item_data[self.itemid].bag_item_type == kITEM_HORCRUX and arg_11_1.item_attr then
		self.starsPanel = ccui.Layout:create()

		self.starsPanel:setName("starsPanel")
		self.starsPanel:setScale(0.75)
		self.starsPanel:setPosition(cc.p(-64, -24))
		self:addChild(self.starsPanel, 5)

		local var_11_0 = 0

		for iter_11_0, iter_11_1 in arg_11_1.item_attr:gmatch("([^&]+)=([^&]+)") do
			if iter_11_0 == "star" then
				var_11_0 = tonumber(iter_11_1)
			end
		end

		for iter_11_2 = 1, var_11_0 do
			local var_11_1

			if config._DEBUG then
				var_11_1 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			var_11_1:setPosition(25, (iter_11_2 - 1) * 24 - 30)
			self.starsPanel:addChild(var_11_1)
		end
	end

	self.animation:setVisible(self.order == activity_manager:getChampionCardPos(self.activityId))
end

function ItemSpriteFlip:playTurnAni(arg_13_1)
	self.backImage:runAction(cc.Sequence:create(cc.OrbitCamera:create(0.1, 1, 0, 0, 90, 0, 0), cc.Hide:create(), cc.CallFunc:create(function()
		self.fontImage:runAction(cc.Sequence:create(cc.Show:create(), cc.OrbitCamera:create(0.1, 1, 0, 270, 90, 0, 0), cc.CallFunc:create(function()
			self:update(arg_13_1.drawConf)

			if arg_13_1.isChampion then
				global_gain(arg_13_1.itemGain)
			else
				global_get(arg_13_1.itemGain)
			end
		end)))
	end)))
end

function ItemSpriteFlip:reset()
	if not self.itemid then
		return
	end

	self.fontImage:runAction(cc.Sequence:create(cc.Hide:create(), cc.CallFunc:create(function()
		self.backImage:runAction(cc.Sequence:create(cc.Show:create(), cc.OrbitCamera:create(0.05, 1, 0, 270, 90, 0, 0)))

		self.itemid = nil

		self.itemIcon:setVisible(false)
		self.animation:setVisible(false)

		if self.starsPanel then
			self.starsPanel:setVisible(false)

			return
		end
	end)))
end
