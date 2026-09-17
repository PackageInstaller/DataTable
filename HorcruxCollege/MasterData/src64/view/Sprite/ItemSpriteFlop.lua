local item_data = require("data.item_data")
local model_data = require("data.model_data")
local component_manager = require("controller.component_manager")
local var_0_3 = config._DEBUG and 0 or 1

ItemSpriteFlop = class("ItemSpriteFlop", function()
	return ccui.ImageView:create("public/box/flop_bg_1.png", var_0_3)
end)

local var_0_4 = {
	"public/box/flop_bg_1.png",
	"public/box/flop_bg_2.png",
	"public/box/flop_bg_3.png",
	"public/box/flop_bg_4.png",
	"public/box/flop_bg_5.png",
	"public/box/flop_bg_6.png"
}

function ItemSpriteFlop:createPurchaseItemByItemid(arg_2_1, arg_2_2)
	local var_2_0 = self:createFlopItem()

	var_2_0:updateFlopItemByItemid(arg_2_1, arg_2_2)

	return var_2_0
end

function ItemSpriteFlop:createFlopItem(arg_3_1, arg_3_2, arg_3_3)
	self = ItemSpriteFlop.new()
	self.scale = 1
	self.goto_back_system_id = goto_back_system_id

	self:setTouchEnabled(false)
	self:setScale(self.scale)

	self.iconScale = 1

	local var_3_0 = ccui.Layout:create()

	var_3_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_0:setContentSize(cc.size(self:getContentSize().width, self:getContentSize().height))
	var_3_0:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
	var_3_0:setClippingEnabled(true)
	var_3_0:setCascadeOpacityEnabled(true)
	var_3_0:setName("bg")
	self:addChild(var_3_0)

	local var_3_1 = ccui.ImageView:create("GUI/image.png", var_0_3)

	var_3_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_1:setPositionX(self:getContentSize().width / 2)
	var_3_1:setPositionY(self:getContentSize().height / 2)
	var_3_1:setName("icon")
	var_3_0:addChild(var_3_1, 1)

	local var_3_2 = ccui.Text:create("X", FONT_NAME, 26)

	var_3_2:setPositionX(self:getContentSize().width)
	var_3_2:setPositionY(5)
	var_3_2:setAnchorPoint(cc.p(1, 0))
	var_3_2:setName("numLabel")
	var_3_0:addChild(var_3_2, 3)

	if arg_3_1 then
		self:updateFlopItemByItemid(arg_3_1, arg_3_2, arg_3_3)
	end

	return self
end

function ItemSpriteFlop:updateFlopItemByItemid(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	self.itemNum = arg_4_2
	self.itemid = arg_4_1
	self.itemScale = 0.65

	local var_4_0 = self:getChildByName("bg")

	if self.itemid == "gold" then
		self.quality = 6
		self.imageid = 1000001
		self.bagType = 88
	elseif self.itemid == "diamond" then
		self.quality = 6
		self.imageid = 1000000
		self.bagType = 88
	elseif self.itemid == "honor" then
		self.quality = 3
		self.imageid = 1000002
		self.bagType = 88
	elseif self.itemid == "explorecoin" then
		self.quality = 4
		self.imageid = 1000003
		self.bagType = 88
	elseif self.itemid == "strengthpoint" then
		self.quality = 6
		self.imageid = 1000004
		self.bagType = 88
	elseif self.itemid == "energy" then
		self.quality = 1
		self.imageid = 1000005
		self.bagType = 88
	elseif item_data[arg_4_1].bag_item_type == kITEM_HORCRUX then
		self.quality = item_data[self.itemid].equip_quality
		self.imageid = model_data[item_data[self.itemid].model].cute_role
		self.bagType = item_data[self.itemid].bag_item_type
	else
		self.quality = item_data[self.itemid].equip_quality
		self.imageid = item_data[self.itemid].image_id
		self.bagType = item_data[self.itemid].bag_item_type
	end

	if var_4_0:getChildByName("spine_sculture") then
		var_4_0:getChildByName("spine_sculture"):removeFromParent()
	end

	if var_4_0:getChildByName("AvatarSprite") then
		var_4_0:getChildByName("AvatarSprite"):removeFromParent()
	end

	if self.starsPanel then
		self.starsPanel:removeFromParent()

		self.starsPanel = nil
	end

	if self.bagType then
		if self.bagType == kITEM_COMPONENT then
			var_4_0:getChildByName("icon"):removeFromParent()

			local var_4_1 = component_manager:create_component_icon(self.itemid)

			var_4_1:setAnchorPoint(cc.p(0.5, 0.5))
			var_4_1:setScale(self.itemScale)
			var_4_1:setPositionX(self:getContentSize().width / 2)
			var_4_1:setPositionY(self:getContentSize().height / 2)
			var_4_1:setName("icon")
			var_4_0:addChild(var_4_1, 1)
		elseif self.bagType == kITEM_MEDAL then
			self:create_medal_icon(self.itemid)
		elseif self.bagType == KITEM_SPRING_FESTIVAL_WORD and item_data[self.itemid].word_bg then
			var_4_0:getChildByName("icon"):removeFromParent()

			local var_4_2 = self:create_word_collect_icon(self.itemid)

			var_4_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_4_2:setPositionX(self:getContentSize().width / 2)
			var_4_2:setPositionY(self:getContentSize().height / 2)
			var_4_2:setName("icon")
			var_4_0:addChild(var_4_2, 1)
		elseif self.bagType == kITEM_SCULTURE and item_data[arg_4_1].spine then
			if var_4_0:getChildByName("icon") then
				var_4_0:getChildByName("icon"):setVisible(false)
			end

			local var_4_3 = AvatarSprite:create(self.itemid)

			var_4_3:setName("AvatarSprite")
			var_4_3:setScale(self.itemScale)
			var_4_0:addChild(var_4_3, 1)
		elseif self.bagType == kITEM_HORCRUX then
			var_4_0:getChildByName("icon"):removeFromParent()

			local var_4_4 = ccui.ImageView:create("roleimage/role1/" .. self.imageid .. ".png")

			var_4_4:setAnchorPoint(cc.p(0.5, 0.5))
			var_4_4:setPositionX(var_4_0:getContentSize().width / 2)
			var_4_4:setPositionY(var_4_0:getContentSize().height / 2 + 15)
			var_4_4:setName("icon")
			var_4_0:addChild(var_4_4, 1)
			var_4_4:setScale(140 / var_4_4:getContentSize().height)

			function var_4_4:afterLoadSuccess(...)
				self:setScale(140 / self:getContentSize().height)
			end

			self.starsPanel = ccui.Layout:create()

			self.starsPanel:setName("starsPanel")
			self.starsPanel:setScale(0.75)
			self.starsPanel:setPositionY(54)
			self:addChild(self.starsPanel, 5)

			local var_4_5 = 0

			if arg_4_5 then
				for iter_4_0, iter_4_1 in arg_4_5:gmatch("([^&]+)=([^&]+)") do
					if iter_4_0 == "star" then
						var_4_5 = tonumber(iter_4_1)
					end
				end
			end

			for iter_4_2 = 1, var_4_5 do
				local var_4_6

				if config._DEBUG then
					var_4_6 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
				end

				var_4_6:setPosition(25, (iter_4_2 - 1) * 24 - 30)
				self.starsPanel:addChild(var_4_6)
			end
		else
			var_4_0:getChildByName("icon"):removeFromParent()

			local var_4_7 = ccui.ImageView:create("equipment/" .. self.imageid .. ".png")

			var_4_7:setAnchorPoint(cc.p(0.5, 0.5))
			var_4_7:setPositionX(var_4_0:getContentSize().width / 2)
			var_4_7:setPositionY(var_4_0:getContentSize().height / 2)
			var_4_7:setName("icon")
			var_4_0:addChild(var_4_7, 1)
			var_4_7:setScale(self.itemScale / global_get_item_scale_by_size(120, self.bagType))
		end
	end

	self:loadTexture(arg_4_4 or var_0_4[self.quality], var_0_3)
	var_4_0:getChildByName("numLabel"):setColor(cc.c3b(255, 255, 255))

	if arg_4_2 and arg_4_2 ~= 1 then
		var_4_0:getChildByName("numLabel"):setVisible(true)
		var_4_0:getChildByName("numLabel"):setString("X" .. global_trans_number(arg_4_2))
	else
		var_4_0:getChildByName("numLabel"):setVisible(false)
	end

	if not self.addNum and arg_4_3 and item_data[self.itemid].name then
		var_4_0:getChildByName("numLabel"):setString(item_data[self.itemid].name)
		var_4_0:getChildByName("numLabel"):setVisible(true)
	end
end
