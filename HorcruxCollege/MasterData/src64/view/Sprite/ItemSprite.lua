local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local var_0_2 = require("data.item_data")
local model_data = require("data.model_data")
local food_photo_data = require("data.food_photo_data")
local servant_data = require("data.servant_data")
local component_data = require("data.component_data")
local total_skill_data = require("data.total_skill_data")
local postcard_data = require("data.postcard_data")
local major_factor_data = require("data.major_factor_data")
local component_manager = require("controller.component_manager")
local cook_manager = require("controller.cook_manager")
local horcrux_manager = require("controller.horcrux_manager")
local dormitory_manager = require("controller.dormitory_manager")
local weapon_manager = require("controller.weapon_manager")
local utf8 = require("controller.utf8")
local var_0_16 = config._DEBUG and 0 or 1
local var_0_17 = 0.7
local var_0_18 = cc.c3b(255, 255, 255)

require("view.Sprite.AvatarSprite")
require("view.Sprite.ItemSpriteSign")
require("view.Sprite.ItemSpriteActivityRecharge")
require("view.Sprite.ItemSpriteShop")

local var_0_20 = L_COMPONENT_RANK

local function var_0_21(arg_1_0)
	if ({
		[3050014] = true,
		[3050061] = true,
		[3050013] = true,
		[3050012] = true,
		[3050072] = true,
		[3050075] = true,
		[3050071] = true,
		[3050074] = true,
		[3050011] = true,
		[3050073] = true
	})[arg_1_0] then
		return false
	end

	local var_1_0 = var_0_2[arg_1_0].bag_item_type

	return var_0_2[arg_1_0].bag_item_type ~= kITEM_COMPONENT and var_1_0 ~= kITEM_HORCRUX and var_1_0 ~= kITEM_WEAPON and var_1_0 ~= kITEM_SCULTURE
end

require("view.Sprite.ChatEmotionSprite")

ItemSprite = class("ItemSprite", function()
	return cc.Sprite:create()
end)

local var_0_22 = 68

function ItemSprite.create(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = ItemSprite.new()

	if type(arg_3_1) == "table" then
		var_3_0:initWithEntityId(arg_3_1[1], arg_3_1[2], arg_3_1[3])
	else
		var_3_0:initWithEntityId(arg_3_1, arg_3_2, arg_3_3)
	end

	return var_3_0
end

function ItemSprite.createWithItemId(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = ItemSprite.new()

	if type(arg_4_1) == "table" then
		var_4_0:initWithItemId(arg_4_1[1], arg_4_1[2], arg_4_1[3], arg_4_1[4])
	else
		var_4_0:initWithItemId(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	end

	return var_4_0
end

function ItemSprite.createNewWithItemId(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7, arg_5_8)
	local var_5_0 = ItemSprite.new()

	var_5_0:initNewWithItemId(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7, arg_5_8)

	return var_5_0
end

function ItemSprite.createSignNewWithItemId(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	local var_6_0 = ItemSprite.new()

	var_6_0:initSignNewWithItemId(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)

	return var_6_0
end

function ItemSprite.createBigWithEntityId(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = ItemSprite.new()

	var_7_0:initBigWithEntityId(arg_7_1, arg_7_2, arg_7_3, arg_7_4)

	return var_7_0
end

function ItemSprite:setNameVisible(arg_8_1)
	if self.nameLabel then
		self.nameLabel:setVisible(arg_8_1)
	end
end

function ItemSprite:initWithEntityId(arg_9_1, arg_9_2, arg_9_3)
	self.equipId = arg_9_1
	self.itemtype = nil
	self.iteminfo = nil

	if type(self.equipId) == "number" then
		self.itemtype = playermodel.items[arg_9_1].itemtype
		self.itemid = playermodel.items[arg_9_1].itemid
		self.iteminfo = var_0_2[self.itemid]

		if self.itemtype == kITEM_COMPONENT then
			self:initComponentInfo()
		end
	end

	self:init(arg_9_2, arg_9_3)
end

function ItemSprite:initWithItemId(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self.equipId = arg_10_1
	self.itemtype = nil
	self.iteminfo = nil

	if type(self.equipId) == "number" then
		self.itemtype = var_0_2[arg_10_1].bag_item_type
		self.iteminfo = var_0_2[arg_10_1]
		self.itemattr = arg_10_4
	end

	self:init(arg_10_2, arg_10_3, "itemid")
end

function ItemSprite:initItemData(arg_11_1, arg_11_2, arg_11_3)
	self.equipId = nil
	self.order = nil
	self.itemtype = nil
	self.iteminfo = nil

	if type(arg_11_1) == "string" then
		self.equipId, self.order = arg_11_1:match("([^-]+)-(.+)")

		if self.order then
			self.equipId = tonumber(self.equipId)

			if self.order:find("^[+-]?%d+$") then
				self.order = tonumber(self.order)
			end
		else
			self.equipId = arg_11_1
		end
	else
		self.equipId = arg_11_1
	end

	if type(self.equipId) == "number" then
		if item_data[self.equipId] then
			self.itemtype = item_data[self.equipId].bag_item_type
			self.iteminfo = item_data[self.equipId]
		elseif var_0_2[self.equipId] then
			self.itemtype = var_0_2[self.equipId].bag_item_type
			self.iteminfo = var_0_2[self.equipId]
		elseif component_data[self.equipId] then
			self.itemtype = component_data[self.equipId].bag_item_type
			self.iteminfo = component_data[self.equipId]
		end

		if self.itemtype == kITEM_COMPONENT and self.order then
			self:initComponentInfo()
		end
	end

	self:init(arg_11_2, arg_11_3)
end

function ItemSprite:initComponentInfo()
	if self.itemtype ~= kITEM_COMPONENT then
		return
	end

	if not self.componentLabel then
		self.componentLabel = cc.Label:createWithTTF("", FONT_DES, 16)

		self.componentLabel:enableOutline(cc.c4b(0, 0, 0, 255), 1)
		self.componentLabel:setAnchorPoint(cc.p(0, 0.5))
		self.componentLabel:setPosition(cc.p(8, 85))
		self:addChild(self.componentLabel, 1)
	end

	local var_12_0 = component_manager:getExtraPoint(self.equipId)

	self.componentLabel:setString((var_12_0 > 0 or nil) and ("+" .. var_12_0 or ""))

	if not self.componentlevelLabel then
		self.componentlevelLabel = cc.Label:createWithTTF("", FONT_DES, 16)

		self.componentlevelLabel:enableOutline(cc.c4b(0, 0, 0, 255), 1)
		self.componentlevelLabel:setAnchorPoint(cc.p(1, 0.5))
		self.componentlevelLabel:setPosition(cc.p(90, 85))
		self:addChild(self.componentlevelLabel, 2)
	end

	self.componentlevelLabel:setString(var_0_20[component_manager:getComponentLevel(self.itemid)])
end

function ItemSprite:updateComponentInfo(arg_13_1)
	if self.itemtype ~= kITEM_COMPONENT then
		return
	end

	local var_13_0 = component_manager:getExtraPoint(self.equipId)

	self.componentLabel:setString((var_13_0 > 0 or nil) and ("+" .. var_13_0 or ""))

	if arg_13_1 then
		self.componentLabel:setColor(cc.c3b(132, 239, 55))
		self.componentLabel:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2), cc.ScaleTo:create(0.2, 1), cc.CallFunc:create(function()
			self.componentLabel:setColor(cc.c3b(255, 255, 255))
		end)))
	end
end

local var_0_25 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_26 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 84, 0, 150)
}

function ItemSprite.create_medal_icon(arg_15_0, arg_15_1)
	local var_15_0 = var_0_2[arg_15_1]
	local var_15_1 = cc.Sprite:create((var_0_2[arg_15_1].bg or nil) and ("equipment/" .. var_0_2[arg_15_1].bg .. ".png" or var_0_25[var_15_0.equip_quality]))
	local var_15_2 = cc.Label:createWithTTF(var_15_0.name, FONT_DES, 54)

	var_15_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_15_2:setPosition(cc.p(49, 39))
	var_15_2:enableOutline(var_0_26[var_15_0.equip_quality], 1)
	var_15_2:enableShadow(var_0_26[var_15_0.equip_quality], cc.size(0, 0))
	var_15_2:setName("medalLabel")
	var_15_1:addChild(var_15_2)
	var_15_2:setVisible(var_0_2[arg_15_1].only_bg ~= 1)

	return var_15_1
end

function ItemSprite:update_medal_icon(arg_16_1)
	local var_16_0 = self:getChildByName("layout")

	if not var_16_0 then
		return
	end

	local var_16_1 = var_16_0:getChildByName("icon")

	if not var_16_1 then
		return
	end

	local var_16_2 = var_0_2[arg_16_1]
	local var_16_3

	if var_0_2[arg_16_1].bg then
		var_16_3 = "equipment/" .. var_0_2[arg_16_1].bg .. ".png" or var_0_25[var_16_2.equip_quality]
	end

	local var_16_4 = var_16_1:getChildByName("medalLabel")

	var_16_1:setTexture(var_16_3)
	var_16_1:setScale(global_get_item_scale(var_16_1, self.itemtype))
	var_16_4:setString(var_16_2.name)
	var_16_4:setPosition(cc.p(49, 39))
	var_16_4:enableOutline(var_0_26[var_16_2.equip_quality], 1)
	var_16_4:enableShadow(var_0_26[var_16_2.equip_quality], cc.size(0, 0))
	self:getChildByName("itemName"):setString(var_16_2.name)
end

function ItemSprite.create_word_collect_icon(arg_17_0, arg_17_1)
	local var_17_0 = var_0_2[arg_17_1].word_color or "255,255,255"
	local var_17_1 = cc.c3b(string.split(var_17_0, ",")[1], string.split(var_17_0, ",")[2], string.split(var_17_0, ",")[3])
	local var_17_2 = ccui.ImageView:create(var_0_2[arg_17_1].word_bg and "equipment/" .. var_0_2[arg_17_1].word_bg .. ".png")
	local var_17_3 = cc.Label:createWithTTF(var_0_2[arg_17_1].name, var_0_2[arg_17_1].word_font or FONT_NAME, var_0_2[arg_17_1].word_font_size or 40)

	var_17_3:setName("word")
	var_17_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_17_3:setPosition(cc.p(var_17_2:getContentSize().width / 2 + (var_0_2[arg_17_1].word_offset_x or 0), var_17_2:getContentSize().height / 2 + (var_0_2[arg_17_1].word_offset_y or 0)))
	var_17_3:setColor(var_17_1)

	if var_0_2[arg_17_1].word_shadow ~= 0 then
		var_17_3:enableShadow(cc.c4b(0, 0, 0, 150), cc.size(1, -1))
	end

	var_17_2:addChild(var_17_3)

	return var_17_2
end

function ItemSprite:afterLoadSuccess(arg_18_1)
	local var_18_0 = ccui.Helper:seekWidgetByName(self, "icon")

	if not var_18_0 then
		return
	end

	if self._standardSize then
		var_18_0:setScale(self._standardSize / var_18_0:getContentSize().width)
	else
		var_18_0:setScale(global_get_item_scale(var_18_0, self.itemtype))
	end
end

local var_0_27 = 168
local var_0_28 = 170

function ItemSprite:init(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = {
		"UI_smeltScene_equipBox1",
		"UI_smeltScene_equipBox2",
		"UI_smeltScene_equipBox3",
		"UI_smeltScene_equipBox4",
		"UI_smeltScene_equipBox5",
		"UI_smeltScene_equipBox6"
	}

	self:setCascadeOpacityEnabled(true)

	local var_19_1

	self.nameLabel = nil

	if self.itemtype then
		if config._DEBUG then
			self:setTexture(ITEM_BOX_UI .. var_19_0[self.iteminfo.equip_quality] .. ".png")
		else
			self:setSpriteFrame(ITEM_BOX_UI .. var_19_0[self.iteminfo.equip_quality] .. ".png")
		end

		var_19_1 = self.itemtype == kITEM_COMPONENT and component_manager:create_component_icon(self.equipId, nil, self.itemattr) or self.itemtype == kITEM_EATABLES and (arg_19_3 and arg_19_3 == "itemid" and cc.Sprite:create("equipment/" .. self.iteminfo.image_id .. ".png") or cook_manager:create_eatable_icon(self.equipId)) or self.itemtype == kITEM_HORCRUX and cc.Sprite:create("equipment/" .. horcrux_manager:getHorcruxRoleImageByItemSprite(self.equipId) .. ".png") or self.itemtype == kITEM_MEDAL and self:create_medal_icon(self.equipId) or cc.Sprite:create("equipment/" .. self.iteminfo.image_id .. ".png")
	elseif self.equipId == "gold" then
		if config._DEBUG then
			self:setTexture(ITEM_BOX_UI .. var_19_0[1] .. ".png")
		else
			self:setSpriteFrame(ITEM_BOX_UI .. var_19_0[1] .. ".png")
		end

		var_19_1 = cc.Sprite:create("equipment/1000001.png")
	elseif self.equipId == "diamond" then
		if config._DEBUG then
			self:setTexture(ITEM_BOX_UI .. var_19_0[4] .. ".png")
		else
			self:setSpriteFrame(ITEM_BOX_UI .. var_19_0[4] .. ".png")
		end

		var_19_1 = cc.Sprite:create("equipment/1000000.png")
	elseif self.equipId == "honor" then
		if config._DEBUG then
			self:setTexture(ITEM_BOX_UI .. var_19_0[3] .. ".png")
		else
			self:setSpriteFrame(ITEM_BOX_UI .. var_19_0[3] .. ".png")
		end

		var_19_1 = cc.Sprite:create("equipment/1000002.png")
	elseif self.equipId == "explorecoin" then
		if config._DEBUG then
			self:setTexture(ITEM_BOX_UI .. var_19_0[4] .. ".png")
		else
			self:setSpriteFrame(ITEM_BOX_UI .. var_19_0[4] .. ".png")
		end

		var_19_1 = cc.Sprite:create("equipment/1000003.png")
	elseif self.equipId == "strengthpoint" then
		if config._DEBUG then
			self:setTexture(ITEM_BOX_UI .. var_19_0[1] .. ".png")
		else
			self:setSpriteFrame(ITEM_BOX_UI .. var_19_0[1] .. ".png")
		end

		var_19_1 = cc.Sprite:create("equipment/1000004.png")
	elseif self.equipId == "energy" then
		if config._DEBUG then
			self:setTexture(ITEM_BOX_UI .. var_19_0[1] .. ".png")
		else
			self:setSpriteFrame(ITEM_BOX_UI .. var_19_0[1] .. ".png")
		end

		var_19_1 = cc.Sprite:create("equipment/1000005.png")
	end

	var_19_1:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)
	var_19_1:setScale(86 / var_19_1:getContentSize().width)
	self:addChild(var_19_1)
	var_19_1:setName("icon")

	function var_19_1:afterLoadSuccess(...)
		self:setScale(86 / self:getContentSize().width)
	end

	self._spriteIcon = var_19_1
	self._standardSize = 86

	if arg_19_1 then
		local var_19_3 = cc.Label:createWithTTF("x" .. arg_19_1, "fonts/W5.ttf", 30)

		var_19_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_19_3:enableOutline(cc.c4b(70, 60, 50, 255), 1)
		var_19_3:setPosition(self:getContentSize().width / 2, 25)
		var_19_3:setName("number")
		self:addChild(var_19_3)
	else
		local var_19_4 = cc.Label:createWithTTF("x1", "fonts/W5.ttf", 30)

		var_19_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_19_4:enableOutline(cc.c4b(70, 60, 50, 255), 1)
		var_19_4:setName("number")
		var_19_4:setPosition(self:getContentSize().width / 2, 25)
		self:addChild(var_19_4)
	end

	return true
end

function ItemSprite:initSignNewWithItemId(arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6, arg_21_7)
	self:setCascadeOpacityEnabled(true)

	self.equipId = arg_21_1

	if self.equipId and tonumber(arg_21_1) ~= nil then
		self.iteminfo = var_0_2[self.equipId]
		self.itemtype = self.iteminfo.bag_item_type
	end

	if type(arg_21_1) == "number" and var_0_2[arg_21_1].bag_item_type == 91 then
		if require("controller.item_manager"):getItemNumber(arg_21_1) == 0 and var_0_2[self.equipId].lock_image_id then
			self.iteminfo.image_id = var_0_2[self.equipId].lock_image_id
		end
	end

	local var_21_0 = ccui.Layout:create()

	var_21_0:setContentSize(cc.size(var_0_27, var_0_28))
	var_21_0:setPosition(cc.p(1, 58))
	var_21_0:setClippingEnabled(true)
	var_21_0:setCascadeOpacityEnabled(true)
	var_21_0:setName("layout")
	self:addChild(var_21_0)

	local var_21_1 = ccui.ImageView:create("equipment/draw.png")

	var_21_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_21_1:setName("draw_img")
	var_21_1:setPosition(cc.p(var_21_0:getContentSize().width / 2, var_21_0:getContentSize().height / 2 - 5))
	var_21_1:setVisible(false)
	var_21_0:addChild(var_21_1)

	local var_21_2
	local var_21_3

	if self.itemtype then
		if arg_21_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg" .. self.iteminfo.equip_quality .. ".png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg" .. self.iteminfo.equip_quality .. ".png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		if self.itemtype == kITEM_COMPONENT then
			var_21_2 = component_manager:create_component_icon(self.equipId, nil, arg_21_5)

			var_21_2:setScale(0.5)
		elseif self.itemtype == kITEM_WEAPON then
			var_21_2 = cc.Sprite:create("equipment/" .. self.iteminfo.image_id .. ".png")

			var_21_2:setScale(var_0_27 / 256)
		elseif self.itemtype == kITEM_SCULTURE then
			var_21_2 = cc.Sprite:create("roleimage/role/wuji/" .. self.iteminfo.image_id .. ".png")
		elseif self.itemtype == kITEM_HORCRUX then
			var_21_2 = cc.Sprite:create("equipment/" .. horcrux_manager:getHorcruxRoleImageByItemSprite(arg_21_1) .. ".png")

			var_21_2:setScale(var_0_27 / 400)
		elseif self.itemtype == kITEM_HERO then
			var_21_2 = cc.Sprite:create("equipment/" .. self.iteminfo.image_id .. ".png")

			var_21_2:setScale(var_0_27 / 170)
		elseif self.itemtype == kITEM_SCULTURE then
			var_21_2 = cc.Sprite:create("role/wuji/" .. self.iteminfo.image_id .. ".png")

			var_21_2:setScale(var_0_27 / 170)
		elseif self.itemtype == kITEM_DRAWING or self.itemtype == kITEM_HORCRUX_DRAWING then
			if self.iteminfo.equip_quality and self.iteminfo.equip_quality == 6 then
				var_21_0:getChildByName("draw_img"):setVisible(true)
			end

			var_21_2 = cc.Sprite:create("equipment/" .. self.iteminfo.image_id .. ".png")
		elseif self.itemtype == kITEM_MEDAL then
			var_21_2 = self:create_medal_icon(self.equipId)
		else
			var_21_2 = cc.Sprite:create("equipment/" .. self.iteminfo.image_id .. ".png")

			var_21_2:setScale(var_0_27 / 128)
		end
	elseif self.equipId == "gold" then
		if arg_21_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg1.png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg1.png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		var_21_2 = cc.Sprite:create("equipment/1000001.png")
		var_21_3 = L_GOLD
	elseif self.equipId == "diamond" then
		if arg_21_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg5.png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg5.png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		var_21_2 = cc.Sprite:create("equipment/1000000.png")
		var_21_3 = L_DIAMOND
	elseif self.equipId == "honor" then
		if arg_21_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg3.png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg3.png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		var_21_2 = cc.Sprite:create("equipment/1000002.png")
		var_21_3 = L_PLAYER_DATA_TYPE.Honor
	elseif self.equipId == "explorecoin" then
		if arg_21_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg4.png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg4.png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		var_21_2 = cc.Sprite:create("equipment/1000003.png")
	elseif self.equipId == "postcard" then
		if arg_21_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg6.png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg6.png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		var_21_2 = cc.Sprite:create("mainScenebg/postcard/" .. postcard_data[arg_21_2].image .. ".png")
		var_21_3 = L_PLAYER_DATA_TYPE.Postcard
	elseif self.equipId == "strengthpoint" then
		if arg_21_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg1.png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg1.png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		var_21_2 = cc.Sprite:create("equipment/1000004.png")
		var_21_3 = L_PLAYER_DATA_TYPE.Tech
	elseif self.equipId == "energy" then
		if arg_21_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg1.png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg1.png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		var_21_2 = cc.Sprite:create("equipment/1000005.png")
		var_21_3 = L_PLAYER_DATA_TYPE.Energy
	end

	if self.itemtype and self.itemtype == kITEM_WEAPON then
		local var_21_5 = ccui.Layout:create()

		var_21_5:setName("starsPanel")
		var_21_5:setPositionY(54)
		self:addChild(var_21_5, 5)

		local var_21_6 = 0

		if not arg_21_5 then
			if not arg_21_6 then
				var_21_6 = 0
			end
		else
			var_21_6 = weapon_manager:decode_component_config(arg_21_5).nowStars
		end

		for iter_21_0 = 1, var_21_6 do
			local var_21_13

			if config._DEBUG then
				var_21_13 = cc.Sprite:create(var_21_11) or cc.Sprite:createWithSpriteFrameName(var_21_11)
			end

			var_21_13:setName("star" .. iter_21_0)
			var_21_13:setPosition(14, (iter_21_0 - 1) * 24 + 20)
			var_21_13:setName("star")
			var_21_13:setVisible(iter_21_0 <= var_21_6)
			var_21_5:addChild(var_21_13)
		end
	end

	if self.itemtype and self.itemtype == kITEM_HORCRUX and arg_21_5 then
		local var_21_14 = 1

		for iter_21_1, iter_21_2 in arg_21_5:gmatch("([^&]+)=([^&]+)") do
			if iter_21_1 == "star" then
				var_21_14 = tonumber(iter_21_2)
			end
		end

		local var_21_15 = ccui.Layout:create()

		var_21_15:setName("starsPanel")
		var_21_15:setPositionY(54)
		self:addChild(var_21_15, 5)
		global_add_star(var_21_15, var_21_14, function(arg_22_0)
			for iter_22_0, iter_22_1 in pairs(arg_22_0) do
				iter_22_1:setPosition(150, (iter_22_0 - 1) * 24 + 20)
			end
		end)
	end

	if self.itemtype and self.itemtype == kITEM_HERO then
		local var_21_16 = ccui.ImageView:create(SHOT_RARITY_CION[servant_data[var_0_2[arg_21_1].servant].roll_rarity], var_0_16)

		var_21_16:setPositionX(140)
		var_21_16:setPositionY(150)
		var_21_16:setName("rarityIcon")
		var_21_0:addChild(var_21_16, 100)
	end

	if var_21_0:getChildByName("rarityIcon") then
		if self.itemtype and self.itemtype == kITEM_HERO then
			var_21_0:getChildByName("rarityIcon"):setVisible(true)
		else
			var_21_0:getChildByName("rarityIcon"):setVisible(false)
		end
	end

	if self.itemtype and self.itemtype == kITEM_SKIN then
		local var_21_17 = ccui.ImageView:create("public/box/skin_icon.png", var_0_16)

		var_21_17:setAnchorPoint(cc.p(0, 1))
		var_21_17:setPositionX(-4)
		var_21_17:setPositionY(var_21_0:getContentSize().height + 4)
		var_21_17:setName("skinIcon")
		var_21_0:addChild(var_21_17, 100)
	end

	if var_21_0:getChildByName("skinIcon") then
		if self.itemtype and self.itemtype == kITEM_SKIN then
			var_21_0:getChildByName("skinIcon"):setVisible(true)
		else
			var_21_0:getChildByName("skinIcon"):setVisible(false)
		end
	end

	var_21_2:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - 29)

	local var_21_18 = var_21_2:getContentSize()

	var_21_2:setName("icon")
	var_21_2:setCascadeOpacityEnabled(true)
	var_21_2:setScale(global_get_item_scale(var_21_2, self.itemtype))
	var_21_0:addChild(var_21_2)

	function var_21_2:afterLoadSuccess(...)
		self:setScale(global_get_item_scale(self, self.itemtype))
	end

	self._spriteIcon = var_21_2

	if arg_21_3 ~= "withoutBox" then
		if arg_21_2 and self.itemtype ~= kITEM_SCULTURE and self.itemtype ~= CHAT_EMOTION_VALUE then
			local var_21_20 = cc.Label:createWithTTF(arg_21_7 and arg_21_2 .. "/" .. arg_21_7 or arg_21_2 == 1 and "X" .. arg_21_2 or "X" .. arg_21_2, FONT_BUTTON, 30)

			var_21_20:setName("number")
			var_21_20:setAnchorPoint(cc.p(0.5, 0.5))
			var_21_20:setColor(cc.c3b(242, 242, 242))
			var_21_20:setPosition(self:getContentSize().width / 2, 25)
			self:addChild(var_21_20)

			if arg_21_7 and arg_21_2 < arg_21_7 then
				var_21_20:setColor(cc.c3b(214, 77, 82))
			end
		else
			arg_21_4 = arg_21_4 or tonumber(arg_21_1) ~= nil and var_0_2[arg_21_1].name or var_21_3

			local var_21_21 = cc.Label:createWithTTF("", FONT_BUTTON, 22)

			var_21_21:setAnchorPoint(cc.p(0.5, 0.5))
			var_21_21:setPosition(cc.p(self:getContentSize().width / 2, 25))
			var_21_21:setString(arg_21_4)
			var_21_21:setName("name")
			var_21_21:setColor(var_0_18)
			self:addChild(var_21_21)
		end
	end
end

function ItemSprite:initNewWithItemId(arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5, arg_24_6, arg_24_7, arg_24_8)
	self:setCascadeOpacityEnabled(true)

	self.equipId = arg_24_1

	if self.equipId and tonumber(arg_24_1) ~= nil then
		self.iteminfo = var_0_2[self.equipId]
		self.itemtype = self.iteminfo.bag_item_type
	end

	if type(arg_24_1) == "number" and var_0_2[arg_24_1].bag_item_type == 91 then
		if require("controller.item_manager"):getItemNumber(arg_24_1) == 0 and var_0_2[self.equipId].lock_image_id then
			self.iteminfo.image_id = var_0_2[self.equipId].lock_image_id
		end
	end

	local var_24_0 = ccui.Layout:create()

	var_24_0:setContentSize(cc.size(var_0_27, var_0_28))
	var_24_0:setPosition(cc.p(1, 58))
	var_24_0:setClippingEnabled(true)
	var_24_0:setCascadeOpacityEnabled(true)
	var_24_0:setName("layout")
	self:addChild(var_24_0)

	local var_24_1 = ccui.ImageView:create("equipment/draw.png")

	var_24_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_24_1:setName("draw_img")
	var_24_1:setPosition(cc.p(var_24_0:getContentSize().width / 2, var_24_0:getContentSize().height / 2 - 5))
	var_24_1:setVisible(false)
	var_24_0:addChild(var_24_1)

	local var_24_2
	local var_24_3

	if self.itemtype then
		if arg_24_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg" .. self.iteminfo.equip_quality .. ".png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg" .. self.iteminfo.equip_quality .. ".png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		if self.itemtype == kITEM_COMPONENT then
			var_24_2 = component_manager:create_component_icon(self.equipId, nil, arg_24_5)

			var_24_2:setScale(0.5)
		elseif self.itemtype == kITEM_WEAPON then
			var_24_2 = cc.Sprite:create("equipment/" .. self.iteminfo.image_id .. ".png")

			var_24_2:setScale(var_0_27 / 256)
		elseif self.itemtype == kITEM_SCULTURE then
			var_24_2 = AvatarSprite:create(self.iteminfo.id)
		elseif self.itemtype == kITEM_HORCRUX then
			var_24_2 = cc.Sprite:create("equipment/" .. horcrux_manager:getHorcruxRoleImageByItemSprite(arg_24_1) .. ".png")

			var_24_2:setScale(var_0_27 / 400)
		elseif self.itemtype == kITEM_HERO then
			var_24_2 = cc.Sprite:create("equipment/" .. self.iteminfo.image_id .. ".png")

			var_24_2:setScale(var_0_27 / 170)
		elseif self.itemtype == kITEM_DRAWING or self.itemtype == kITEM_HORCRUX_DRAWING then
			if self.iteminfo.equip_quality and self.iteminfo.equip_quality == 6 then
				var_24_0:getChildByName("draw_img"):setVisible(true)
			end

			var_24_2 = cc.Sprite:create("equipment/" .. self.iteminfo.image_id .. ".png")
		elseif self.itemtype == kITEM_MEDAL then
			var_24_2 = self:create_medal_icon(self.equipId)
		elseif self.itemtype == KITEM_SPRING_FESTIVAL_WORD and self.iteminfo.word_bg then
			var_24_2 = self:create_word_collect_icon(self.equipId)
		elseif self.itemtype == CHAT_EMOTION_VALUE then
			var_24_2 = ChatEmotionSprite:create(self.iteminfo.id)

			var_24_2:setScale(var_0_27 / 300)
		else
			var_24_2 = cc.Sprite:create("equipment/" .. self.iteminfo.image_id .. ".png")

			var_24_2:setScale(var_0_27 / 128)
		end
	elseif self.equipId == "gold" then
		if arg_24_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg1.png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg1.png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		var_24_2 = cc.Sprite:create("equipment/1000001.png")
		var_24_3 = L_GOLD
	elseif self.equipId == "diamond" then
		if arg_24_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg5.png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg5.png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		var_24_2 = cc.Sprite:create("equipment/1000000.png")
		var_24_3 = L_DIAMOND
	elseif self.equipId == "honor" then
		if arg_24_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg3.png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg3.png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		var_24_2 = cc.Sprite:create("equipment/1000002.png")
		var_24_3 = L_PLAYER_DATA_TYPE.Honor
	elseif self.equipId == "explorecoin" then
		if arg_24_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg4.png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg4.png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		var_24_2 = cc.Sprite:create("equipment/1000003.png")
	elseif self.equipId == "postcard" then
		if arg_24_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg6.png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg6.png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		var_24_2 = cc.Sprite:create("mainScenebg/postcard/" .. postcard_data[arg_24_2].image .. ".png")
		var_24_3 = L_PLAYER_DATA_TYPE.Postcard
	elseif self.equipId == "strengthpoint" then
		if arg_24_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg1.png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg1.png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		var_24_2 = cc.Sprite:create("equipment/1000004.png")
		var_24_3 = L_PLAYER_DATA_TYPE.Tech
	elseif self.equipId == "energy" then
		if arg_24_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg1.png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg1.png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		var_24_2 = cc.Sprite:create("equipment/1000005.png")
		var_24_3 = L_PLAYER_DATA_TYPE.Energy
	elseif self.equipId == "active" then
		if arg_24_3 ~= "withoutBox" then
			if config._DEBUG then
				self:setTexture(ITEM_BOX_UI .. "new_item_bg1.png")
			else
				self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg1.png")
			end
		else
			self:setContentSize(cc.size(var_0_27, 228))
		end

		var_24_2 = cc.Sprite:create("equipment/active_num.png")
		var_24_3 = L_PLAYER_DATA_TYPE.Active
	end

	if self.itemtype and self.itemtype == kITEM_WEAPON then
		local var_24_5 = ccui.Layout:create()

		var_24_5:setName("starsPanel")
		var_24_5:setPositionY(54)
		self:addChild(var_24_5, 5)

		local var_24_6 = 0

		if not arg_24_5 then
			if not arg_24_6 then
				var_24_6 = 0
			end
		else
			var_24_6 = weapon_manager:decode_component_config(arg_24_5).nowStars
		end

		for iter_24_0 = 1, (var_24_6 > 5 == true or nil) and var_24_6 % 5 do
			local var_24_15

			if config._DEBUG then
				var_24_15 = cc.Sprite:create(var_24_13) or cc.Sprite:createWithSpriteFrameName(var_24_13)
			end

			var_24_15:setName("star" .. iter_24_0)
			var_24_15:setPosition(14, (iter_24_0 - 1) * 24 + 20)
			var_24_15:setName("star")
			var_24_15:setVisible(iter_24_0 <= var_24_6)
			var_24_5:addChild(var_24_15)
		end
	end

	if self.itemtype and self.itemtype == kITEM_HORCRUX and arg_24_5 then
		local var_24_16 = 1

		for iter_24_1, iter_24_2 in arg_24_5:gmatch("([^&]+)=([^&]+)") do
			if iter_24_1 == "star" then
				var_24_16 = tonumber(iter_24_2)
			end
		end

		local var_24_17 = ccui.Layout:create()

		var_24_17:setName("starsPanel")
		var_24_17:setPositionY(54)
		self:addChild(var_24_17, 5)
		global_add_star(var_24_17, var_24_16, function(arg_25_0)
			for iter_25_0, iter_25_1 in pairs(arg_25_0) do
				iter_25_1:setPosition(150, (iter_25_0 - 1) * 24 + 20)
			end
		end)
	end

	if self.itemtype and self.itemtype == kITEM_HERO then
		local var_24_18 = ccui.ImageView:create(SHOT_RARITY_CION[servant_data[var_0_2[arg_24_1].servant].roll_rarity], var_0_16)

		var_24_18:setPositionX(140)
		var_24_18:setPositionY(150)
		var_24_18:setName("rarityIcon")
		var_24_0:addChild(var_24_18, 100)
	end

	if var_24_0:getChildByName("rarityIcon") then
		if self.itemtype and self.itemtype == kITEM_HERO then
			var_24_0:getChildByName("rarityIcon"):setVisible(true)
		else
			var_24_0:getChildByName("rarityIcon"):setVisible(false)
		end
	end

	if self.itemtype and self.itemtype == kITEM_SKIN then
		local var_24_19 = ccui.ImageView:create("public/box/skin_icon.png", var_0_16)

		var_24_19:setAnchorPoint(cc.p(0, 1))
		var_24_19:setPositionX(-4)
		var_24_19:setPositionY(var_24_0:getContentSize().height + 4)
		var_24_19:setName("skinIcon")
		var_24_0:addChild(var_24_19, 100)
	end

	if var_24_0:getChildByName("skinIcon") then
		if self.itemtype and self.itemtype == kITEM_SKIN then
			var_24_0:getChildByName("skinIcon"):setVisible(true)
		else
			var_24_0:getChildByName("skinIcon"):setVisible(false)
		end
	end

	var_24_2:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - 29)

	if self.itemtype == kITEM_SCULTURE or self.itemtype == CHAT_EMOTION_VALUE then
		var_24_2:setPosition(0, 0)
	end

	local var_24_20 = var_24_2:getContentSize()

	var_24_2:setName("icon")
	var_24_2:setCascadeOpacityEnabled(true)
	var_24_2:setScale(global_get_item_scale(var_24_2, self.itemtype))
	var_24_0:addChild(var_24_2)

	function var_24_2:afterLoadSuccess(...)
		self:setScale(global_get_item_scale(self, self.itemtype))
	end

	self._spriteIcon = var_24_2

	if arg_24_3 ~= "withoutBox" then
		if arg_24_2 and self.itemtype ~= kITEM_SCULTURE and self.itemtype ~= CHAT_EMOTION_VALUE then
			local var_24_22 = cc.Label:createWithTTF(arg_24_7 and arg_24_2 .. "/" .. arg_24_7 or "X" .. arg_24_2, FONT_BUTTON, 30)

			var_24_22:setName("number")
			var_24_22:setAnchorPoint(cc.p(0.5, 0.5))
			var_24_22:setColor(cc.c3b(242, 242, 242))
			var_24_22:setPosition(self:getContentSize().width / 2, 25)
			self:addChild(var_24_22)

			if arg_24_7 and arg_24_2 < arg_24_7 then
				var_24_22:setColor(cc.c3b(214, 77, 82))
			end
		else
			arg_24_4 = arg_24_4 or tonumber(arg_24_1) ~= nil and var_0_2[arg_24_1].name or var_24_3

			if self.itemtype and self.itemtype == kITEM_HERO and arg_24_8 then
				local var_24_23 = ccui.ImageView:create(CAREER_ICON[servant_data[var_0_2[arg_24_1].servant].career .. "_" .. global_get_all_model_attrs_img_path(servant_data[var_0_2[arg_24_1].servant].modelid)], var_0_16)

				var_24_23:setAnchorPoint(cc.p(0, 0.5))
				var_24_23:setPosition(cc.p(8, 25))
				var_24_23:setScale(0.5)
				self:addChild(var_24_23)

				local var_24_24 = cc.Label:createWithTTF("", FONT_BUTTON, 24)

				var_24_24:setName("itemName")
				var_24_24:setString(major_factor_data[servant_data[var_0_2[arg_24_1].servant].major].easy_name)
				var_24_24:setPositionX(self:getContentSize().width / 2 + 15)
				var_24_24:setPositionY(23)
				self:addChild(var_24_24)
			elseif self.itemtype and self.itemtype == kITEM_HORCRUX and arg_24_8 then
				local var_24_25 = ccui.ImageView:create(ATTRICONPATH[var_0_2[arg_24_1].attr], var_0_16)

				var_24_25:setAnchorPoint(cc.p(0, 0.5))
				var_24_25:setPosition(cc.p(8, 25))
				var_24_25:setScale(0.5)
				self:addChild(var_24_25)

				local var_24_26 = cc.Label:createWithTTF("", FONT_BUTTON, 24)

				var_24_26:setName("itemName")
				var_24_26:setString(arg_24_4)
				var_24_26:setPositionX(self:getContentSize().width / 2 + 15)
				var_24_26:setPositionY(23)
				self:addChild(var_24_26)
			else
				local var_24_27 = cc.Label:createWithTTF("", FONT_BUTTON, 22)

				var_24_27:setAnchorPoint(cc.p(0.5, 0.5))
				var_24_27:setPosition(cc.p(self:getContentSize().width / 2, 25))
				var_24_27:setString(arg_24_4)
				var_24_27:setName("itemName")
				var_24_27:setColor(var_0_18)
				self:addChild(var_24_27)
			end
		end
	end
end

function ItemSprite:initBigWithEntityId(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	self:setCascadeOpacityEnabled(true)

	self.equipId = arg_27_1
	self.oldItemAttr = global_deepCopy(playermodel.items[arg_27_1])

	local var_27_0

	if type(arg_27_1) == "number" then
		self.itemid = not playermodel.items[arg_27_1] and var_0_2[arg_27_1] and var_0_2[arg_27_1].bag_item_type == kITEM_MEDAL and arg_27_1 or playermodel.items[arg_27_1].itemid
		self.iteminfo = var_0_2[self.itemid]
		self.itemtype = self.iteminfo.bag_item_type
	end

	if arg_27_3 then
		self.servantid = arg_27_3
	end

	local var_27_1 = ccui.Layout:create()

	var_27_1:setContentSize(cc.size(var_0_27, var_0_28))
	var_27_1:setPosition(1, 58)
	var_27_1:setName("clip")
	var_27_1:setClippingEnabled(true)
	var_27_1:setCascadeOpacityEnabled(true)
	self:addChild(var_27_1, 0)

	local var_27_2 = ccui.ImageView:create("equipment/draw.png")

	var_27_2:setPosition(cc.p(var_27_1:getContentSize().width / 2, var_27_1:getContentSize().height / 2 - 5))
	var_27_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_27_2:setVisible(false)
	var_27_2:setName("draw_img")
	var_27_1:addChild(var_27_2)

	if self.itemtype then
		if config._DEBUG then
			self:setTexture(ITEM_BOX_UI .. "new_item_bg" .. self.iteminfo.equip_quality .. ".png")
		else
			self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg" .. self.iteminfo.equip_quality .. ".png")
		end

		if self.itemtype == kITEM_COMPONENT then
			var_27_0 = component_manager:create_component_icon(self.equipId)

			var_27_0:setScale(0.5)

			if playermodel.items[self.equipId].component_attr.attr2 then
				local var_27_3 = ccui.ImageView:create("public/box/rainbow_bg.png", var_0_16)

				var_27_3:setAnchorPoint(1, 1)
				var_27_3:setPosition(self:getContentSize().width, self:getContentSize().height)
				var_27_3:setName("rainbowBg")
				self:addChild(var_27_3, 100)
				self:getChildByName("rainbowBg"):setVisible(true)
			end
		elseif self.itemtype == kITEM_WEAPON then
			var_27_0 = cc.Sprite:create("equipment/" .. self.iteminfo.image_id .. ".png")

			var_27_0:setScale(var_0_27 / 256)
		elseif self.itemtype == kITEM_HORCRUX then
			var_27_0 = cc.Sprite:create("equipment/" .. horcrux_manager:getHorcruxRoleImageByItemSprite(self.itemid) .. ".png")

			var_27_0:setScale(var_0_27 / 400)
		elseif self.itemtype == kITEM_SCULTURE then
			var_27_0 = AvatarSprite:create(self.iteminfo.id)

			var_27_0:setScale(var_0_27 / 170)
		elseif self.itemtype == kITEM_DRAWING or self.itemtype == kITEM_HORCRUX_DRAWING then
			if self.iteminfo.equip_quality and self.iteminfo.equip_quality == 6 then
				var_27_1:getChildByName("draw_img"):setVisible(true)
			end

			var_27_0 = cc.Sprite:create("equipment/" .. self.iteminfo.image_id .. ".png")
		elseif self.itemtype == kITEM_MEDAL then
			var_27_0 = self:create_medal_icon(self.itemid)

			var_27_0:setScale(var_0_27 / var_27_0:getContentSize().width)
		elseif self.itemtype == KITEM_SPRING_FESTIVAL_WORD and self.iteminfo.word_bg then
			var_27_0 = self:create_word_collect_icon(self.equipId)
		elseif self.itemtype == CHAT_EMOTION_VALUE then
			var_27_0 = ChatEmotionSprite:create(self.iteminfo.id)

			var_27_0:setScale(var_0_27 / 170)
		else
			var_27_0 = cc.Sprite:create("equipment/" .. self.iteminfo.image_id .. ".png")

			var_27_0:setScale(var_0_27 / 128)
		end
	elseif self.equipId == "gold" then
		self.name = L_GOLD

		if config._DEBUG then
			self:setTexture(ITEM_BOX_UI .. "new_item_bg1.png")
		else
			self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg1.png")
		end

		var_27_0 = cc.Sprite:create("equipment/1000001.png")
	elseif self.equipId == "diamond" then
		self.name = L_DIAMOND

		if config._DEBUG then
			self:setTexture(ITEM_BOX_UI .. "new_item_bg5.png")
		else
			self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg5.png")
		end

		var_27_0 = cc.Sprite:create("equipment/1000000.png")
	elseif self.equipId == "honor" then
		self.name = L_PLAYER_DATA_TYPE.Honor

		if config._DEBUG then
			self:setTexture(ITEM_BOX_UI .. "new_item_bg3.png")
		else
			self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg3.png")
		end

		var_27_0 = cc.Sprite:create("equipment/1000002.png")
	elseif self.equipId == "explorecoin" then
		self.name = L_PLAYER_DATA_TYPE.Explorecoin

		if config._DEBUG then
			self:setTexture(ITEM_BOX_UI .. "new_item_bg4.png")
		else
			self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg4.png")
		end

		var_27_0 = cc.Sprite:create("equipment/1000003.png")
	elseif self.equipId == "postcard" then
		self.name = L_PLAYER_DATA_TYPE.Postcard

		if config._DEBUG then
			self:setTexture(ITEM_BOX_UI .. "new_item_bg6.png")
		else
			self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg6.png")
		end

		var_27_0 = cc.Sprite:create("mainScenebg/postcard/" .. postcard_data[arg_27_2].image .. ".png")
	elseif self.equipId == "strengthpoint" then
		self.name = L_PLAYER_DATA_TYPE.Tech

		if config._DEBUG then
			self:setTexture(ITEM_BOX_UI .. "new_item_bg1.png")
		else
			self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg1.png")
		end

		var_27_0 = cc.Sprite:create("equipment/1000004.png")
	elseif self.equipId == "energy" then
		self.name = L_PLAYER_DATA_TYPE.Energy

		if config._DEBUG then
			self:setTexture(ITEM_BOX_UI .. "new_item_bg1.png")
		else
			self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg1.png")
		end

		var_27_0 = cc.Sprite:create("equipment/1000005.png")
	end

	var_27_0:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - 36)
	var_27_0:setName("icon")
	var_27_0:setCascadeOpacityEnabled(true)
	var_27_0:setScale(global_get_item_scale(var_27_0, self.itemtype))
	var_27_1:addChild(var_27_0)

	function var_27_0:afterLoadSuccess(...)
		self:setScale(global_get_item_scale(self, self.itemtype))
	end

	self._spriteIcon = var_27_0

	if self.itemtype == kITEM_SCULTURE or self.itemtype == CHAT_EMOTION_VALUE then
		var_27_0:setPosition(0, 0)
	end

	if self.itemtype and self.itemtype == kITEM_HERO then
		local var_27_4 = ccui.ImageView:create(SHOT_RARITY_CION[servant_data[var_0_2[self.itemid].servant].roll_rarity], var_0_16)

		var_27_4:setPositionX(140)
		var_27_4:setPositionY(150)
		var_27_4:setName("rarityIcon")
		var_27_1:addChild(var_27_4, 100)
	end

	if var_27_1:getChildByName("rarityIcon") then
		if self.itemtype and self.itemtype == kITEM_HERO then
			var_27_1:getChildByName("rarityIcon"):setVisible(true)
		else
			var_27_1:getChildByName("rarityIcon"):setVisible(false)
		end
	end

	if self.itemtype and self.itemtype == kITEM_SKIN then
		local var_27_5 = ccui.ImageView:create("public/box/skin_icon.png", var_0_16)

		var_27_5:setAnchorPoint(cc.p(0, 1))
		var_27_5:setPositionX(-4)
		var_27_5:setPositionY(var_27_1:getContentSize().height + 4)
		var_27_5:setName("skinIcon")
		var_27_1:addChild(var_27_5, 100)
	end

	if var_27_1:getChildByName("skinIcon") then
		if self.itemtype and self.itemtype == kITEM_SKIN then
			var_27_1:getChildByName("skinIcon"):setVisible(true)
		else
			var_27_1:getChildByName("skinIcon"):setVisible(false)
		end
	end

	arg_27_2 = arg_27_2 or type(self.equipId) == "number" and (type(self.equipId) == "number" and self.itemtype ~= kITEM_WEAPON and self.itemtype ~= kITEM_COMPONENT or nil) and (self.itemtype == kITEM_MEDAL and 1 or self.itemtype == kITEM_FURNITURE and dormitory_manager:getLeftoverFurniture(self.equipId) or playermodel.items[self.equipId].number)

	if arg_27_2 and self.itemtype ~= kITEM_WEAPON and self.itemtype ~= kITEM_COMPONENT and self.itemtype ~= kITEM_SCULTURE and self.itemtype ~= CHAT_EMOTION_VALUE and not arg_27_4 then
		local var_27_7 = cc.Label:createWithTTF("X" .. arg_27_2, FONT_BUTTON, 26)

		var_27_7:setAnchorPoint(cc.p(0.5, 0.5))
		var_27_7:setName("number")
		var_27_7:setColor(cc.c3b(242, 242, 242))
		var_27_7:setPosition(var_27_1:getContentSize().width / 2, 25)
		self:addChild(var_27_7)
	end

	if arg_27_4 or self.itemtype == kITEM_SCULTURE or self.itemtype == CHAT_EMOTION_VALUE then
		local var_27_8 = cc.Label:createWithTTF("", FONT_NAME, 26)

		var_27_8:setAnchorPoint(cc.p(0.5, 0.5))
		var_27_8:setName("number")
		var_27_8:setColor(cc.c3b(242, 242, 242))
		var_27_8:setPosition(var_27_1:getContentSize().width / 2, 25)
		var_27_8:setString(var_0_2[self.itemid].name)
		self:addChild(var_27_8)
	end

	if self.itemtype == kITEM_COMPONENT and component_manager:hadAdjustComponent(self.equipId) then
		self:createAdjustIcon()
	end

	if self.itemtype then
		self:initBigIconInfo()
	end
end

function ItemSprite:createAdjustIcon()
	if self:getChildByName("imgAdjust") then
		return
	end

	local var_29_0 = ccui.ImageView:create("public/button/img_adjust.png", var_0_16)

	var_29_0:setName("imgAdjust")
	self:addChild(var_29_0, 5)
	var_29_0:setScale(0.7)
	var_29_0:setPosition(10, self:getContentSize().height - 10)
end

function ItemSprite:updateAdjustVisible()
	local var_30_0 = self:getChildByName("imgAdjust")

	if self.itemtype == kITEM_COMPONENT and component_manager:hadAdjustComponent(self.equipId) then
		if var_30_0 then
			var_30_0:setVisible(true)
		else
			self:createAdjustIcon()
		end
	elseif var_30_0 then
		var_30_0:setVisible(false)
	end
end

function ItemSprite:setAdjustPosition(arg_31_1)
	local var_31_0 = self:getChildByName("imgAdjust")

	if not var_31_0 then
		return
	end

	var_31_0:setPosition(arg_31_1)
end

function ItemSprite:setItemCount(arg_32_1, arg_32_2)
	local var_32_0 = self:getChildByName("itemName")

	if not var_32_0 then
		return
	end

	var_32_0:setString("X" .. arg_32_1)

	if arg_32_2 then
		var_32_0:setColor(arg_32_2)
	else
		var_32_0:setColor(var_0_18)
	end
end

function ItemSprite:initBigIconInfo()
	local var_33_0 = {
		[kITEM_COMPONENT] = function()
			local var_34_0

			if config._DEBUG then
				var_34_0 = cc.Sprite:create("public/box/new_item_attr_bg.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_attr_bg.png")
			end

			var_34_0:setAnchorPoint(cc.p(0, 1))
			var_34_0:setPosition(0, self:getContentSize().height)
			var_34_0:setName("attr")
			var_34_0:setVisible(false)
			self:addChild(var_34_0, 99)

			local var_34_1 = component_manager:initComponentIntro(self.equipId, true, true)
			local var_34_2 = cc.Label:createWithTTF(var_34_1[1], FONT_DES, 20)

			var_34_2:setName("main_attr_label")
			var_34_2:setColor(cc.c3b(170, 196, 229))
			var_34_2:setAnchorPoint(cc.p(0, 1))
			var_34_2:setMaxLineWidth(var_34_0:getContentSize().width)
			var_34_2:setPosition(4, var_34_0:getContentSize().height - 20)
			var_34_0:addChild(var_34_2)

			local var_34_3 = cc.Label:createWithTTF("[" .. var_34_1[#var_34_1] .. "]", FONT_DES, 20)

			var_34_3:setName("effect_label")
			var_34_3:setColor(cc.c3b(255, 169, 12))
			var_34_3:setAnchorPoint(cc.p(0, 1))
			var_34_3:setMaxLineWidth(var_34_0:getContentSize().width)
			var_34_3:setPosition(4, var_34_2:getPositionY() - var_34_2:getContentSize().height - 30)
			var_34_0:addChild(var_34_3)

			local var_34_4 = cc.Label:createWithTTF(L_COMPONENT_TEXT.Component_Score .. component_manager:getPotential(self.equipId) .. "(" .. (component_manager:getMaxLevel(playermodel.items[self.equipId].itemid) + 1) * 20 .. ")", FONT_DES, 20)

			var_34_4:setName("score_label")
			var_34_4:setColor(cc.c3b(255, 169, 12))
			var_34_4:setAnchorPoint(cc.p(0, 1))
			var_34_4:setMaxLineWidth(var_34_0:getContentSize().width)
			var_34_4:setPosition(4, var_34_3:getPositionY() - var_34_3:getContentSize().height - 2)
			var_34_0:addChild(var_34_4)
		end,
		[kITEM_WEAPON] = function()
			local var_35_0

			if config._DEBUG then
				var_35_0 = cc.Sprite:create("public/box/new_item_attr_bg.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_attr_bg.png")
			end

			var_35_0:setAnchorPoint(cc.p(0, 1))
			var_35_0:setPosition(0, self:getContentSize().height)
			var_35_0:setName("attr")
			var_35_0:setVisible(false)
			self:addChild(var_35_0, 99)

			local var_35_1 = cc.Label:createWithTTF("", FONT_DES, 20)

			var_35_1:setName("main")
			var_35_1:setColor(cc.c3b(170, 196, 229))
			var_35_1:setAnchorPoint(cc.p(0, 1))
			var_35_1:setPosition(0, var_35_0:getContentSize().height - 20)
			var_35_0:addChild(var_35_1)

			local var_35_2 = cc.Label:createWithTTF("", FONT_DES, 20)

			var_35_2:setName("sub")
			var_35_2:setColor(cc.c3b(170, 196, 229))
			var_35_2:setAnchorPoint(cc.p(0, 1))
			var_35_2:setPosition(0, var_35_1:getPositionY() - var_35_1:getContentSize().height - 5)
			var_35_0:addChild(var_35_2)
		end,
		[kITEM_WEAPON_EXP] = function()
			local var_36_0

			if config._DEBUG then
				var_36_0 = cc.Sprite:create("public/box/new_item_attr_bg.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_attr_bg.png")
			end

			var_36_0:setAnchorPoint(cc.p(0, 1))
			var_36_0:setPosition(0, self:getContentSize().height)
			var_36_0:setName("attr")
			var_36_0:setVisible(false)
			self:addChild(var_36_0, 99)

			local var_36_1 = cc.Label:createWithTTF(L_WEAPON_EXP_STR .. self.iteminfo.gain_exp, FONT_DES, 20)

			var_36_1:setName("label")
			var_36_1:setMaxLineWidth(var_36_0:getContentSize().width)
			var_36_1:setLineBreakWithoutSpace(true)
			var_36_1:setColor(cc.c3b(170, 196, 229))
			var_36_1:setAnchorPoint(cc.p(0, 1))
			var_36_1:setPosition(0, var_36_0:getContentSize().height - 20)
			var_36_0:addChild(var_36_1)
		end
	}
	local var_33_1 = {
		[kITEM_COMPONENT] = function()
			local var_37_0 = component_manager:getExtraPoint(self.equipId)
			local var_37_1 = cc.Label:createWithTTF("", "fonts/newkj.ttf", 26)

			var_37_1:setAnchorPoint(cc.p(0.5, 0.5))
			var_37_1:setPosition(cc.p(self:getContentSize().width / 2, 25))
			var_37_1:setString((var_37_0 > 0 or nil) and (L_EQUIPLAYER[6] .. var_37_0 or L_EQUIPLAYER[6] .. "0"))
			var_37_1:setName("strengthen")
			self:addChild(var_37_1)

			if playermodel.items[self.equipId].component_attr.lock then
				local var_37_2 = ccui.Button:create("public/button/unlock.png", nil, "public/button/unlock.png", var_0_16)

				var_37_2:setPosition(cc.p(self:getContentSize().width - 20, self:getContentSize().height - 20))
				var_37_2:setName("lock")
				var_37_2:setScale(var_0_17)
				self:addChild(var_37_2, 100)
				var_37_2:setVisible(playermodel.items[self.equipId].component_attr.lock)
			end

			if playermodel.items[self.equipId].component_attr.use then
				local var_37_3

				if config._DEBUG then
					var_37_3 = cc.Sprite:create("public/box/used_on.png") or cc.Sprite:createWithSpriteFrameName("public/box/used_on.png")
				end

				var_37_3:setPosition(cc.p(87, 120))
				var_37_3:setName("use")
				var_37_3:setCascadeOpacityEnabled(true)
				self:addChild(var_37_3, 90)

				local var_37_4 = cc.Label:createWithTTF(servant_data[playermodel.items[self.equipId].component_attr.use].name, "fonts/newkj.ttf", 22)

				var_37_4:setPosition(cc.p(var_37_3:getContentSize().width / 2, var_37_3:getContentSize().height / 2))
				var_37_4:setColor(cc.c3b(255, 100, 0))
				var_37_4:setName("titleLabel")
				var_37_3:addChild(var_37_4)

				if playermodel.items[self.equipId].component_attr.use then
					self:getChildByName("use"):setVisible(true)
				else
					self:getChildByName("use"):setVisible(false)
				end
			end
		end,
		[kITEM_WEAPON] = function()
			local var_38_0 = cc.Label:createWithTTF(L_EQUIPLAYER[6] .. tostring(playermodel.items[self.equipId].weapon_attr.level), "fonts/newkj.ttf", 26)

			var_38_0:setColor(cc.c3b(225, 226, 229))
			var_38_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_38_0:setPosition(self:getContentSize().width / 2, 25)
			var_38_0:setName("lv")
			self:addChild(var_38_0)

			local var_38_1 = ccui.Layout:create()

			var_38_1:setName("starsPanel")
			self:addChild(var_38_1, 1)

			if playermodel.items[self.equipId].weapon_attr.nowStars > 0 then
				for iter_38_0 = 1, playermodel.items[self.equipId].weapon_attr.nowStars or TOTAL_WEAPON_MAXSTARS do
					local var_38_5

					if config._DEBUG then
						var_38_5 = cc.Sprite:create(var_38_3) or cc.Sprite:createWithSpriteFrameName(var_38_3)
					end

					var_38_5:setName("star" .. iter_38_0)
					var_38_5:setPosition(14, (iter_38_0 - 1) * 24 + 72)
					var_38_5:setVisible(iter_38_0 <= playermodel.items[self.equipId].weapon_attr.nowStars)
					var_38_1:addChild(var_38_5)
				end
			end

			if playermodel.items[self.equipId].weapon_attr.lock then
				local var_38_6 = ccui.Button:create("public/button/unlock.png", nil, "public/button/unlock.png", var_0_16)

				var_38_6:setPosition(cc.p(self:getContentSize().width - 20, self:getContentSize().height - 20))
				var_38_6:setName("lock")
				var_38_6:setScale(var_0_17)
				var_38_6:setVisible(playermodel.items[self.equipId].weapon_attr.lock)
				self:addChild(var_38_6, 100)
			end

			if playermodel.items[self.equipId].weapon_attr.use then
				local var_38_7

				if config._DEBUG then
					var_38_7 = cc.Sprite:create("public/box/used_on.png") or cc.Sprite:createWithSpriteFrameName("public/box/used_on.png")
				end

				var_38_7:setPosition(cc.p(87, 120))
				var_38_7:setName("use")
				self:addChild(var_38_7, 90)

				local var_38_8 = cc.Label:createWithTTF(servant_data[playermodel.items[self.equipId].weapon_attr.use].name, "fonts/newkj.ttf", 22)

				var_38_8:setPosition(cc.p(var_38_7:getContentSize().width / 2, var_38_7:getContentSize().height / 2))
				var_38_8:setColor(cc.c3b(255, 100, 0))
				var_38_8:setName("titleLabel")
				var_38_7:addChild(var_38_8)

				if playermodel.items[self.equipId].weapon_attr.use then
					self:getChildByName("use"):setVisible(true)
				else
					self:getChildByName("use"):setVisible(false)
				end
			end
		end,
		[kITEM_WEAPON_EXP] = function()
			return
		end
	}

	setmetatable(var_33_0, {
		__index = function(arg_40_0, arg_40_1)
			return function()
				local var_41_0

				if config._DEBUG then
					var_41_0 = cc.Sprite:create("public/box/new_item_attr_bg.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_attr_bg.png")
				end

				var_41_0:setAnchorPoint(cc.p(0, 1))
				var_41_0:setPosition(0, self:getContentSize().height)
				var_41_0:setName("attr")
				var_41_0:setVisible(false)
				self:addChild(var_41_0, 99)

				local var_41_1 = self.iteminfo.intro or "这里没填intro 找振辉！"
				local var_41_2 = math.min(string.utf8len(var_41_1), var_0_22)
				local var_41_3 = utf8.sub(var_41_1, 1, var_41_2)

				if var_41_2 == var_0_22 then
					var_41_3 = var_41_3 .. "..."
				end

				local var_41_4 = cc.Label:createWithTTF(var_41_3, FONT_DES, 20)

				var_41_4:setMaxLineWidth(var_41_0:getContentSize().width)
				var_41_4:setLineBreakWithoutSpace(true)
				var_41_4:setName("label")
				var_41_4:setColor(cc.c3b(170, 196, 229))
				var_41_4:setAnchorPoint(cc.p(0, 1))
				var_41_4:setPosition(0, var_41_0:getContentSize().height - 5)
				var_41_0:addChild(var_41_4)
			end
		end
	})
	setmetatable(var_33_1, {
		__index = function(arg_42_0, arg_42_1)
			return function()
				return
			end
		end
	})
	var_33_1[self.itemtype]()
	var_33_0[self.itemtype]()

	self.isTouchEnabled = false
end

function ItemSprite:updateBigInfo(arg_44_1, arg_44_2)
	local function var_44_0(arg_45_0)
		self.equipId = arg_45_0
		self.itemid = playermodel.items[arg_45_0].itemid
		self.iteminfo = var_0_2[self.itemid]
		self.itemtype = self.iteminfo.bag_item_type
	end

	local var_44_1 = {
		[kITEM_COMPONENT] = function()
			local var_46_0 = component_manager:initComponentIntro(self.equipId, true, true)

			self:getChildByName("attr"):getChildByName("main_attr_label"):setString(var_46_0[1])

			if playermodel.items[self.equipId].component_attr.attr2 then
				local var_46_1 = cc.Label:createWithTTF(var_46_0[2], FONT_DES, 20)

				var_46_1:setName("main_attr_label2")
				var_46_1:setColor(cc.c3b(170, 196, 229))
				var_46_1:setAnchorPoint(cc.p(0, 1))
				var_46_1:setMaxLineWidth(self:getChildByName("attr"):getContentSize().width)

				local var_46_2 = self:getChildByName("attr")

				var_46_1:setPosition(4, var_46_2:getChildByName("main_attr_label"):getPositionY() - self:getChildByName("attr"):getChildByName("main_attr_label").getContentSize(var_46_2).height - 5)
				self:getChildByName("attr"):addChild(var_46_1)
			end

			self:getChildByName("attr"):getChildByName("effect_label"):setString(var_46_0[#var_46_0])
			self:getChildByName("attr"):getChildByName("score_label"):setString(L_COMPONENT_TEXT.Component_Score .. component_manager:getPotential(self.equipId) .. "(" .. (component_manager:getMaxLevel(self.itemid) + 1) * 20 .. ")")
		end,
		[kITEM_WEAPON] = function()
			self:getChildByName("attr"):getChildByName("main"):setString("")
			self:getChildByName("attr"):getChildByName("sub"):setString("")
		end,
		[kITEM_WEAPON_EXP] = function()
			self:getChildByName("attr"):getChildByName("label"):setString(L_WEAPON_EXP_STR .. self.iteminfo.gain_exp)
		end
	}
	local var_44_2 = {
		[kITEM_COMPONENT] = function()
			if arg_44_2 then
				var_44_0(arg_44_2)

				if config._DEBUG then
					self:setTexture(ITEM_BOX_UI .. "new_item_bg" .. self.iteminfo.equip_quality .. ".png")
				else
					self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg" .. self.iteminfo.equip_quality .. ".png")
				end

				self:getChildByName("clip"):removeChildByName("icon")

				local var_49_0 = component_manager:create_component_icon(self.equipId)

				var_49_0:setName("icon")
				var_49_0:setCascadeOpacityEnabled(true)
				var_49_0:setScale(global_get_item_scale(var_49_0, self.itemtype))
				var_49_0:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - 36)
				self:getChildByName("clip"):addChild(var_49_0)
			end

			if playermodel.items[arg_44_2].component_attr.attr2 then
				if self:getChildByName("rainbowBg") then
					self:getChildByName("rainbowBg"):setVisible(true)
				else
					local var_49_1 = ccui.ImageView:create("public/box/rainbow_bg.png", var_0_16)

					var_49_1:setAnchorPoint(1, 1)
					var_49_1:setPosition(self:getContentSize().width, self:getContentSize().height)
					var_49_1:setName("rainbowBg")
					self:addChild(var_49_1, 100)
					self:getChildByName("rainbowBg"):setVisible(true)
				end
			elseif self:getChildByName("rainbowBg") then
				self:getChildByName("rainbowBg"):setVisible(false)
			end

			local var_49_2 = component_manager:getExtraPoint(self.equipId)

			if var_49_2 > 0 then
				self:getChildByName("strengthen"):setString(L_EQUIPLAYER[6] .. var_49_2)
			else
				self:getChildByName("strengthen"):setString(L_EQUIPLAYER[6] .. "0")
			end

			if not self:getChildByName("lock") then
				local var_49_4 = ccui.Button:create("public/button/unlock.png", nil, "public/button/unlock.png", var_0_16)

				var_49_4:setPosition(cc.p(self:getContentSize().width - 20, self:getContentSize().height - 20))
				var_49_4:setName("lock")
				var_49_4:setScale(var_0_17)
				self:addChild(var_49_4, 100)
			end

			self:getChildByName("lock"):setVisible(playermodel.items[self.equipId].component_attr.lock)

			if not self:getChildByName("use") then
				local var_49_5

				if config._DEBUG then
					var_49_5 = cc.Sprite:create("public/box/used_on.png") or cc.Sprite:createWithSpriteFrameName("public/box/used_on.png")
				end

				var_49_5:setPosition(cc.p(87, 120))
				var_49_5:setName("use")
				self:addChild(var_49_5, 90)

				local var_49_6 = cc.Label:createWithTTF("", "fonts/newkj.ttf", 22)

				var_49_6:setPosition(cc.p(var_49_5:getContentSize().width / 2, var_49_5:getContentSize().height / 2))
				var_49_6:setName("titleLabel")
				var_49_6:setColor(cc.c3b(255, 100, 0))
				var_49_5:addChild(var_49_6)
			end

			if playermodel.items[self.equipId].component_attr.use then
				self:getChildByName("use"):getChildByName("titleLabel"):setString(servant_data[playermodel.items[self.equipId].component_attr.use].name)
				self:getChildByName("use"):setVisible(true)
			else
				self:getChildByName("use"):setVisible(false)
			end
		end,
		[kITEM_WEAPON] = function()
			local function var_50_0()
				if config._DEBUG then
					self:setTexture(ITEM_BOX_UI .. "new_item_bg" .. self.iteminfo.equip_quality .. ".png")
				else
					self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg" .. self.iteminfo.equip_quality .. ".png")
				end

				self:getChildByName("clip"):getChildByName("icon"):setTexture("equipment/" .. self.iteminfo.image_id .. ".png")
			end

			if arg_44_2 and arg_44_2 ~= self.equipId then
				var_44_0(arg_44_2)
				var_50_0()

				self.equipId = arg_44_2
			end

			if arg_44_2 and self.oldItemAttr.itemid ~= playermodel.items[arg_44_2].itemid then
				self.oldItemAttr = global_deepCopy(playermodel.items[arg_44_2])

				var_44_0(arg_44_2)
				var_50_0()
			end

			;(function()
				self:getChildByName("lv"):setString(L_EQUIPLAYER[6] .. tostring(playermodel.items[self.equipId].weapon_attr.level))
			end)()
			;(function()
				local var_52_0 = self:getChildByName("starsPanel")

				var_52_0:removeAllChildren()

				if playermodel.items[self.equipId].weapon_attr.nowStars > 0 then
					for iter_52_0 = 1, playermodel.items[self.equipId].weapon_attr.nowStars or TOTAL_WEAPON_MAXSTARS do
						local var_52_4

						if config._DEBUG then
							var_52_4 = cc.Sprite:create(var_52_2) or cc.Sprite:createWithSpriteFrameName(var_52_2)
						end

						var_52_4:setName("star" .. iter_52_0)
						var_52_4:setVisible(iter_52_0 <= playermodel.items[self.equipId].weapon_attr.nowStars)
						var_52_4:setPosition(14, (iter_52_0 - 1) * 24 + 72)
						var_52_0:addChild(var_52_4)
					end
				end
			end)()
			;(function()
				if not self:getChildByName("lock") then
					local var_53_0 = ccui.Button:create("public/button/unlock.png", nil, "public/button/unlock.png", var_0_16)

					var_53_0:setPosition(cc.p(self:getContentSize().width - 20, self:getContentSize().height - 20))
					var_53_0:setName("lock")
					var_53_0:setScale(var_0_17)
					self:addChild(var_53_0, 100)
				end

				self:getChildByName("lock"):setVisible(playermodel.items[self.equipId].weapon_attr.lock)
			end)()
			;(function()
				if not self:getChildByName("use") then
					local var_54_0

					if config._DEBUG then
						var_54_0 = cc.Sprite:create("public/box/used_on.png") or cc.Sprite:createWithSpriteFrameName("public/box/used_on.png")
					end

					var_54_0:setPosition(cc.p(87, 120))
					var_54_0:setName("use")
					self:addChild(var_54_0, 90)

					local var_54_1 = cc.Label:createWithTTF(L_COMMON_WARNING.Using, "fonts/newkj.ttf", 22)

					if playermodel.items[self.equipId].weapon_attr.use then
						var_54_1:setString(servant_data[playermodel.items[self.equipId].weapon_attr.use].name)
					end

					var_54_1:setPosition(cc.p(var_54_0:getContentSize().width / 2, var_54_0:getContentSize().height / 2))
					var_54_1:setName("titleLabel")
					var_54_1:setColor(cc.c3b(255, 100, 0))
					var_54_0:addChild(var_54_1)
				end

				if playermodel.items[self.equipId].weapon_attr.use then
					self:getChildByName("use"):getChildByName("titleLabel"):setString(servant_data[playermodel.items[self.equipId].weapon_attr.use].name)
					self:getChildByName("use"):setVisible(true)
				else
					self:getChildByName("use"):setVisible(false)
				end
			end)()
		end
	}

	setmetatable(var_44_2, {
		__index = function()
			return function()
				if arg_44_2 and arg_44_2 ~= self.equipId then
					var_44_0(arg_44_2)
				end

				self:getChildByName("number"):setString("X" .. (self.itemtype == kITEM_FURNITURE and dormitory_manager:getLeftoverFurniture(self.equipId) or playermodel.items[self.equipId].number))
				self:getChildByName("clip"):getChildByName("icon"):setTexture("equipment/" .. self.iteminfo.image_id .. ".png")
				self:getChildByName("clip"):getChildByName("icon"):setScale(global_get_item_scale(self:getChildByName("clip"):getChildByName("icon"), self.itemtype))

				if config._DEBUG then
					self:setTexture(ITEM_BOX_UI .. "new_item_bg" .. self.iteminfo.equip_quality .. ".png")
				else
					self:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg" .. self.iteminfo.equip_quality .. ".png")
				end

				if self.itemtype and self.itemtype == kITEM_HERO then
					if not self:getChildByName("clip"):getChildByName("rarityIcon") then
						local var_57_0 = ccui.ImageView:create(SHOT_RARITY_CION[servant_data[var_0_2[self.itemid].servant].roll_rarity], var_0_16)

						var_57_0:setPositionX(140)
						var_57_0:setPositionY(150)
						var_57_0:setName("rarityIcon")
						self:getChildByName("clip"):addChild(var_57_0, 100)
					end
				end

				if self:getChildByName("clip"):getChildByName("rarityIcon") then
					if self.itemtype and self.itemtype == kITEM_HERO then
						self:getChildByName("clip"):getChildByName("rarityIcon"):setVisible(true)
					else
						self:getChildByName("clip"):getChildByName("rarityIcon"):setVisible(false)
					end
				end

				if self.itemtype and self.itemtype == kITEM_SKIN then
					if not self:getChildByName("clip"):getChildByName("skinIcon") then
						local var_57_1 = ccui.ImageView:create("public/box/skin_icon.png", var_0_16)

						var_57_1:setAnchorPoint(cc.p(0, 1))
						var_57_1:setPositionX(-4)
						var_57_1:setPositionY(self:getChildByName("clip"):getContentSize().height + 4)
						var_57_1:setName("skinIcon")
						self:getChildByName("clip"):addChild(var_57_1, 100)
					end
				end

				if self:getChildByName("clip"):getChildByName("skinIcon") then
					if self.itemtype and self.itemtype == kITEM_SKIN then
						self:getChildByName("clip"):getChildByName("skinIcon"):setVisible(true)
					else
						self:getChildByName("clip"):getChildByName("skinIcon"):setVisible(false)
					end
				end
			end
		end
	})
	setmetatable(var_44_1, {
		__index = function()
			return function()
				local var_59_0 = self.iteminfo.intro or "这里没填intro,call 振辉！"
				local var_59_1 = math.min(string.utf8len(var_59_0), var_0_22)
				local var_59_2 = utf8.sub(var_59_0, 1, var_59_1)

				if var_59_1 == var_0_22 then
					var_59_2 = var_59_2 .. "..."
				end

				self:getChildByName("attr"):getChildByName("label"):setString(var_59_2)
			end
		end
	})

	if (function(arg_60_0)
		local function var_60_0(arg_61_0)
			if ({
				[kITEM_WEAPON] = 1,
				[kITEM_COMPONENT] = 1,
				[kITEM_HORCRUX] = 1,
				[kITEM_DRAWING] = 1,
				[kITEM_HORCRUX_DRAWING] = 1
			})[arg_61_0] then
				return false
			else
				return true
			end
		end

		if not arg_60_0 then
			return false
		end

		if var_0_2[playermodel.items[arg_60_0].itemid].bag_item_type ~= self.itemtype then
			if var_60_0(var_0_2[playermodel.items[arg_60_0].itemid].bag_item_type) and var_60_0(self.itemtype) then
				return false
			else
				return true
			end
		else
			return false
		end
	end)(arg_44_2) then
		self:refreshItemSprite(arg_44_2)
	else
		arg_44_1 = arg_44_1 or false

		var_44_2[self.itemtype]()

		if var_44_1[self.itemtype] then
			var_44_1[self.itemtype]()
		end

		self:getChildByName("attr"):setVisible(arg_44_1)
	end

	local function var_44_3()
		self:getChildByName("clip"):getChildByName("draw_img"):setVisible(self.itemtype == kITEM_DRAWING or self.itemtype == kITEM_HORCRUX_DRAWING)
	end

	self:updateAdjustVisible()
	var_44_3()
end

function ItemSprite:refreshItemSprite(arg_63_1)
	self:removeAllChildren()
	self:initBigWithEntityId(arg_63_1)
end

function ItemSprite:addSpriteTouchEventListener(arg_64_1)
	local var_64_0 = self:getEventDispatcher()

	if self.listener then
		var_64_0:removeEventListener(self.listener)

		self.listener = nil
	end

	self.listener = cc.EventListenerTouchOneByOne:create()

	self.listener:setSwallowTouches(self.isSwallowTouches or false)

	local var_64_1 = self:getContentSize()
	local var_64_2 = cc.rect(0, 0, var_64_1.width, var_64_1.height)

	self.listener:registerScriptHandler(function(arg_65_0, arg_65_1)
		if self.isTouchEnabled then
			if cc.rectContainsPoint(var_64_2, (self:convertToNodeSpace(arg_65_0:getLocation()))) then
				if arg_64_1 then
					local var_65_0 = arg_64_1(arg_65_0, ccui.TouchEventType.began)

					if var_65_0 == nil then
						return true
					else
						return var_65_0
					end
				else
					return true
				end
			else
				return false
			end
		else
			return false
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	self.listener:registerScriptHandler(function(arg_66_0, arg_66_1)
		if cc.rectContainsPoint(var_64_2, (self:convertToNodeSpace(arg_66_0:getLocation()))) then
			if arg_64_1 then
				arg_64_1(arg_66_0, ccui.TouchEventType.ended)
			end

			return true
		else
			return false
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_64_0:addEventListenerWithSceneGraphPriority(self.listener, self)
end

function ItemSprite.setTouchEnabled(arg_67_0, arg_67_1)
	arg_67_1 = arg_67_1 or false
	arg_67_0.isTouchEnabled = arg_67_1
end

function ItemSprite:isTouchEnabled()
	return self.isTouchEnabled
end

function ItemSprite:setSwallowTouches(arg_69_1)
	self.isSwallowTouches = arg_69_1

	if self.listener then
		self.listener:setSwallowTouches(self.isSwallowTouches)
	end
end

function ItemSprite:isSwallowTouchesEnable()
	return self.isSwallowTouches or false
end

function ItemSprite.createItemIconWithItemid(arg_71_0, arg_71_1, arg_71_2, arg_71_3, arg_71_4)
	local var_71_0 = arg_71_3 and (arg_71_4 and "public/box/" .. arg_71_4 .. ".png" or "public/box/" .. var_0_2[arg_71_1].equip_quality .. ".png") or "public/box/UI_touming.png"
	local var_71_1 = ccui.Button:create(var_71_0, var_71_0, var_71_0, var_0_16)
	local var_71_2 = ccui.Layout:create()

	var_71_2:setName("cut_panel")

	local var_71_3 = ccui.ImageView:create("equipment/draw.png")

	var_71_3:setPosition(cc.p(42, 45))
	var_71_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_71_3:setScale(0.5859375)
	var_71_3:setVisible(false)
	var_71_3:setName("draw_img")
	var_71_1:addChild(var_71_3)
	var_71_2:setClippingEnabled(true)

	local var_71_4

	if var_0_2[arg_71_1].bag_item_type == kITEM_HORCRUX then
		var_71_4 = "equipment/" .. horcrux_manager:getHorcruxRoleImageByItemSprite(arg_71_1) .. ".png"

		var_71_2:setContentSize(var_71_1:getContentSize())
		var_71_1:addChild(var_71_2)
	elseif var_0_2[arg_71_1].bag_item_type == kITEM_DRAWING or var_0_2[arg_71_1].bag_item_type == kITEM_HORCRUX_DRAWING then
		var_71_4 = "equipment/" .. var_0_2[arg_71_1].image_id .. ".png"

		local var_71_6 = var_71_1:getChildByName("draw_img")

		var_71_6:setVisible(true)
		var_71_2:setContentSize(var_71_6:getContentSize())
		var_71_1:addChild(var_71_2)
	else
		assert(var_0_2[arg_71_1].image_id, arg_71_1)

		var_71_4 = "equipment/" .. var_0_2[arg_71_1].image_id .. ".png"

		var_71_2:setContentSize(var_71_1:getContentSize())
		var_71_1:addChild(var_71_2)
	end

	local var_71_7 = ccui.ImageView:create(var_71_4)

	var_71_7:setName("itemSp")
	var_71_7:setPosition(var_71_1:getContentSize().width / 2, var_71_1:getContentSize().height / 2)

	local var_71_8 = var_0_2[arg_71_1].bag_item_type

	var_71_7:setScale((global_get_item_scale(var_71_7, var_0_2[arg_71_1].bag_item_type)))
	var_71_2:addChild(var_71_7)

	function var_71_7:afterLoadSuccess()
		self.setScale(self, self, var_71_8)
	end

	if arg_71_2 then
		local var_71_9 = ccui.Text:create(((playermodel.items[arg_71_1] or nil) and (playermodel.items[arg_71_1].number or 0)) .. "/" .. arg_71_2, FONT_DES, 20)

		var_71_9:setName("label_num")
		var_71_9:setAnchorPoint(cc.p(1, 0))
		var_71_9:setPosition(var_71_1:getContentSize().width - 5, 5)
		var_71_2:addChild(var_71_9)
	end

	return var_71_1
end

function ItemSprite.createRechageItemsIcon(arg_73_0, arg_73_1, arg_73_2, arg_73_3, arg_73_4)
	local var_73_0 = ccui.ImageView:create("public/box/new_item_bg5.png", var_0_16)
	local var_73_1 = ccui.Layout:create()

	var_73_1:setClippingEnabled(true)
	var_73_1:setContentSize(var_73_0:getContentSize().width, var_73_0:getContentSize().height)
	var_73_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_73_1:setPosition(cc.p(var_73_0:getContentSize().width / 2, var_73_0:getContentSize().height - var_73_0:getContentSize().width / 2))
	var_73_1:setCascadeOpacityEnabled(true)
	var_73_1:setName("clip")
	var_73_0:addChild(var_73_1)

	local recharge_data = require("data.recharge_data")
	local var_73_3

	if config._DEBUG then
		var_73_3 = cc.Sprite:create("recharge/" .. recharge_data[arg_73_1].image .. ".png") or cc.Sprite:createWithSpriteFrameName("recharge/" .. recharge_data[arg_73_1].image .. ".png")

		if recharge_data[arg_73_1].type == 3 or recharge_data[arg_73_1].type == 2 then
			if arg_73_3 then
				if config._DEBUG then
					var_73_3:setTexture("recharge/" .. recharge_data[2].image .. ".png")
				else
					var_73_3:setSpriteFrame("recharge/" .. recharge_data[2].image .. ".png")
				end

				local var_73_4

				if config._DEBUG then
					var_73_4 = cc.Sprite:create("recharge/firsttag.png") or cc.Sprite:createWithSpriteFrameName("recharge/firsttag.png")
				end

				var_73_4:setAnchorPoint(cc.p(1, 1))
				var_73_4:setPosition(cc.p(var_73_0:getContentSize().width, var_73_0:getContentSize().height))
				var_73_0:addChild(var_73_4, 2)
			else
				var_73_3:setScale(0.7916666666666666)
			end
		end
	end

	var_73_3:setPosition(cc.p(var_73_1:getContentSize().width / 2, var_73_1:getContentSize().height / 2))
	var_73_1:addChild(var_73_3)

	if arg_73_4 then
		local var_73_5

		if config._DEBUG then
			var_73_5 = cc.Sprite:create("recharge/awardtag.png") or cc.Sprite:createWithSpriteFrameName("recharge/awardtag.png")
		end

		var_73_5:setAnchorPoint(cc.p(1, 1))
		var_73_5:setPosition(cc.p(var_73_0:getContentSize().width, var_73_0:getContentSize().height))
		var_73_0:addChild(var_73_5, 2)
	end

	local var_73_6 = cc.Label:createWithTTF("", "fonts/number.ttf", 25)

	var_73_6:setString(string.format("x%d", arg_73_2))
	var_73_6:setAnchorPoint(cc.p(0.5, 0.5))
	var_73_6:setPosition(cc.p(var_73_0:getContentSize().width / 2, var_73_0:getContentSize().height / 2 - 90))
	var_73_0:addChild(var_73_6, 1)

	return var_73_0
end

ItemSmallSprite = class("ItemSmallSprite", function()
	return ccui.Button:create(WEAPON_BG_QUALITY_PATH[1], WEAPON_BG_QUALITY_PATH[1], WEAPON_BG_QUALITY_PATH[1], var_0_16)
end)

function ItemSmallSprite:createSmallItemByEntityid(arg_75_1, arg_75_2, arg_75_3, arg_75_4)
	local var_75_0 = self:createSmallItem()

	var_75_0:updateSmallItemByEntityid(arg_75_1, arg_75_2 or playermodel.items[arg_75_1].number, arg_75_3, arg_75_4)

	return var_75_0
end

function ItemSmallSprite.setAttr(arg_76_0, arg_76_1, arg_76_2)
	arg_76_0.font = arg_76_1 or FONT_DES
	arg_76_0.fontsize = arg_76_2 or 24
end

function ItemSmallSprite:createSmallItem(arg_77_1, arg_77_2, arg_77_3, arg_77_4, arg_77_5)
	self = ItemSmallSprite.new()
	self.font = FONT_DES
	self.fontsize = 24
	self.scale = 1
	self.goto_back_system_id = arg_77_4

	self:setTouchEnabled(false)
	self:setScale(self.scale)

	self.iconScale = 1

	local var_77_0 = ccui.ImageView:create("GUI/image.png", var_0_16)

	var_77_0:setPositionX(self:getContentSize().width / 2)
	var_77_0:setPositionY(self:getContentSize().height / 2)
	var_77_0:setName("icon")
	self:addChild(var_77_0, 1)

	local var_77_1 = ccui.ImageView:create("public/box/word_black_bg.png", var_0_16)

	var_77_1:setPositionX(self:getContentSize().width / 2)
	var_77_1:setPositionY(self:getContentSize().height / 2 - 60)
	var_77_1:setName("wordBg")
	self:addChild(var_77_1, 2)

	local var_77_2 = ccui.Text:create("x/y", self.font, self.fontsize)

	var_77_2:setPositionX(var_77_1:getPositionX())
	var_77_2:setPositionY(var_77_1:getPositionY())
	var_77_2:setName("numLabel")
	self:addChild(var_77_2, 3)

	if arg_77_1 then
		self:updateSmallItemByItemid(arg_77_1, arg_77_2, arg_77_3, arg_77_4, arg_77_5)
	end

	return self
end

function ItemSmallSprite:updateSmallItemByEntityid(arg_78_1, arg_78_2, arg_78_3, arg_78_4)
	self:updateSmallItemByItemid(playermodel.items[arg_78_1].itemid, arg_78_2 or playermodel.items[arg_78_1].number, arg_78_3, arg_78_4)
end

function ItemSmallSprite:updateSmallItemByItemid(arg_79_1, arg_79_2, arg_79_3, arg_79_4, arg_79_5)
	self.ownNum = arg_79_2
	self.needNum = arg_79_3
	self.itemid = arg_79_1
	self.goto_back_system_id = arg_79_4 or self.goto_back_system_id

	if self.itemid == "gold" then
		self.quality = 1
		self.imageid = 1000001
		self.bagType = 88
	elseif self.itemid == "diamond" then
		self.quality = 1
		self.imageid = 1000000
		self.bagType = 88
	else
		self.quality = var_0_2[self.itemid].equip_quality
		self.imageid = var_0_2[self.itemid].image_id
		self.bagType = var_0_2[self.itemid].bag_item_type
	end

	self:loadTextures(WEAPON_BG_QUALITY_PATH[self.quality], WEAPON_BG_QUALITY_PATH[self.quality], WEAPON_BG_QUALITY_PATH[self.quality], var_0_16)

	if arg_79_5 then
		self:getChildByName("icon"):loadTexture(arg_79_5)
	else
		self:getChildByName("icon"):loadTexture("equipment/" .. self.imageid .. ".png")
	end

	self:getChildByName("icon"):setScale(global_get_item_scale(self:getChildByName("icon"), self.bagType) * self.iconScale)

	self:getChildByName("icon").afterLoadSuccess = function(self, arg_80_1)
		self:setScale(global_get_item_scale(self, self.bagType) * self.iconScale)
	end

	self:getChildByName("numLabel"):setColor(cc.c3b(255, 255, 255))

	if arg_79_3 and arg_79_2 then
		self:getChildByName("wordBg"):setVisible(true)
		self:getChildByName("numLabel"):setVisible(true)
		self:getChildByName("numLabel"):setString(global_trans_number(arg_79_2) .. "/" .. global_trans_number(arg_79_3))

		if arg_79_2 < arg_79_3 then
			self:getChildByName("numLabel"):setColor(cc.c3b(255, 55, 55))
		else
			self:getChildByName("numLabel"):setColor(cc.c3b(61, 255, 107))
		end
	elseif not arg_79_3 and arg_79_2 then
		self:getChildByName("wordBg"):setVisible(true)
		self:getChildByName("numLabel"):setVisible(true)
		self:getChildByName("numLabel"):setString("X" .. global_trans_number(arg_79_2))
	else
		self:getChildByName("wordBg"):setVisible(false)
		self:getChildByName("numLabel"):setVisible(false)
	end
end

function ItemSmallSprite:setInfoTouchEvent(arg_81_1)
	self:setTouchEnabled(arg_81_1)
	self:addTouchEventListener((function()
		return function(arg_83_0, arg_83_1)
			if arg_83_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_83_0:getTouchBeganPosition().y - arg_83_0:getTouchEndPosition().y) > 50 then
				return
			end

			if not arg_83_0.itemid then
				return
			end

			if type(arg_83_0.itemid) ~= "number" then
				return
			end

			local var_83_0 = {
				backSysId = self.goto_back_system_id,
				itemId = arg_83_0.itemid
			}

			var_83_0.mainNeed = arg_83_0.needNum or 0

			LayerManager:pushInLayer("PopGameCompoundLayer", var_83_0)

			if self.register_touch_callback then
				self.register_touch_callback()
			end

			do return end

			if arg_83_0.ownNum and arg_83_0.needNum then
				if arg_83_0.ownNum < arg_83_0.needNum then
					local var_83_1 = {
						item = arg_83_0.itemid,
						goto_back_system_id = self.goto_back_system_id,
						layer = cc.Layer:create()
					}

					if self.gotoSystemCallback then
						self.gotoSystemCallback(arg_83_0.itemid)
					end

					LayerManager:pushInLayer("PopGoGainLayer", var_83_1)
				else
					local var_83_2 = {
						itemid = arg_83_0.itemid,
						goto_back_system_id = self.goto_back_system_id
					}

					var_83_2.layer = cc.Layer:create()

					local var_83_3 = PopLayer:Item(var_83_2)
				end
			else
				local var_83_4 = {
					itemid = arg_83_0.itemid,
					goto_back_system_id = self.goto_back_system_id
				}

				var_83_4.layer = cc.Layer:create()

				local var_83_5 = PopLayer:Item(var_83_4)
			end

			if self.register_touch_callback then
				self.register_touch_callback()
			end
		end
	end)())
end

function ItemSmallSprite.registerTouchCallback(arg_84_0, arg_84_1)
	arg_84_0.register_touch_callback = arg_84_1
end

function ItemSmallSprite.registerGotoSystemCallback(arg_85_0, arg_85_1)
	arg_85_0.gotoSystemCallback = arg_85_1
end

function ItemSmallSprite:setLockIconVisible(arg_86_1)
	if not self.imgLock then
		self.imgLock = ccui.ImageView:create("public/currency/lock.png", var_0_16)

		self:addChild(self.imgLock)
		self.imgLock:setPosition(30, self:getContentSize().height - 30)
	end

	self.imgLock:setVisible(arg_86_1)
end

ItemPurchaseSprite = class("ItemPurchaseSprite", function()
	return ccui.Button:create(WEAPON_BG_QUALITY_PATH[1], WEAPON_BG_QUALITY_PATH[1], WEAPON_BG_QUALITY_PATH[1], var_0_16)
end)

function ItemPurchaseSprite:createPurchaseItemByEntityid(arg_88_1, arg_88_2, arg_88_3, arg_88_4)
	local var_88_0 = self:createPurchaseItem()

	var_88_0:updatePurchaseItemByEntityid(arg_88_1, arg_88_2 or playermodel.items[arg_88_1].number, arg_88_3, arg_88_4)

	return var_88_0
end

function ItemPurchaseSprite:createPurchaseItem(arg_89_1, arg_89_2, arg_89_3, arg_89_4, arg_89_5)
	self = ItemPurchaseSprite.new()
	self.scale = 1
	self.goto_back_system_id = goto_back_system_id

	self:setInfoTouchEvent(arg_89_4)
	self:setScale(self.scale)

	self.iconScale = 1

	local var_89_0 = ccui.ImageView:create("GUI/image.png", var_0_16)

	var_89_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_89_0:setPositionX(self:getContentSize().width / 2)
	var_89_0:setPositionY(self:getContentSize().height / 2)
	var_89_0:setName("icon")
	self:addChild(var_89_0, 1)

	local var_89_1 = ccui.ImageView:create("public/box/word_black_bg.png", var_0_16)

	var_89_1:setPositionX(self:getContentSize().width / 2)
	var_89_1:setPositionY(self:getContentSize().height / 2 - 70)
	var_89_1:setName("wordBg")
	self:addChild(var_89_1, 2)

	local var_89_2 = ccui.Text:create("X", FONT_DES, 24)

	var_89_2:setPositionX(var_89_1:getPositionX())
	var_89_2:setPositionY(var_89_1:getPositionY())
	var_89_2:setName("numLabel")
	self:addChild(var_89_2, 3)

	if arg_89_1 then
		self:updatePurchaseItemByItemid(arg_89_1, arg_89_2, arg_89_3, arg_89_5)
	end

	return self
end

function ItemPurchaseSprite:setInfoTouchEvent(arg_90_1)
	arg_90_1 = arg_90_1 == true or false

	self:setTouchEnabled(arg_90_1)
	self:addTouchEventListener((function()
		return function(arg_92_0, arg_92_1)
			if arg_92_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_92_0:getTouchBeganPosition().y - arg_92_0:getTouchEndPosition().y) > 50 then
				return
			end

			if not arg_92_0.itemid then
				return
			end

			if type(arg_92_0.itemid) ~= "number" then
				return
			end

			if arg_92_0.ownNum and arg_92_0.needNum then
				if arg_92_0.ownNum < arg_92_0.needNum then
					if self.gotoSystemCallback then
						self.gotoSystemCallback(arg_92_0.itemid)
					end

					LayerManager:pushInLayer("PopGoGainLayer", {
						item = arg_92_0.itemid,
						goto_back_system_id = self.goto_back_system_id,
						layer = cc.Layer:create()
					})
				else
					local var_92_0 = {
						itemid = arg_92_0.itemid,
						goto_back_system_id = self.goto_back_system_id
					}

					var_92_0.layer = cc.Layer:create()

					local var_92_1 = PopLayer:Item(var_92_0)
				end
			else
				local var_92_2 = {
					itemid = arg_92_0.itemid,
					goto_back_system_id = self.goto_back_system_id
				}

				var_92_2.layer = cc.Layer:create()

				local var_92_3 = PopLayer:Item(var_92_2)
			end

			if self.register_touch_callback then
				self.register_touch_callback()
			end
		end
	end)())
end

function ItemPurchaseSprite:updatePurchaseItemByEntityid(arg_93_1, arg_93_2, arg_93_3, arg_93_4)
	local var_93_0 = arg_93_1

	self.entityid = arg_93_1

	local var_93_1 = arg_93_2

	if playermodel.items[arg_93_1] and next(playermodel.items[arg_93_1]) then
		var_93_0 = playermodel.items[arg_93_1].itemid
		var_93_1 = var_93_1 or playermodel.items[arg_93_1].number
	end

	self:updatePurchaseItemByItemid(var_93_0, var_93_1, arg_93_3, arg_93_4)
end

function ItemPurchaseSprite:updatePurchaseItemByItemid(arg_94_1, arg_94_2, arg_94_3, arg_94_4)
	self.addNum = arg_94_2
	self.itemid = arg_94_1

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
	elseif self.itemid == "active" then
		self.quality = 5
		self.imageid = "active_num"
		self.bagType = 88
	elseif var_0_2[arg_94_1].bag_item_type == kITEM_HORCRUX then
		self.quality = var_0_2[self.itemid].equip_quality
		self.imageid = model_data[var_0_2[self.itemid].model].cute_role
		self.bagType = var_0_2[self.itemid].bag_item_type
	else
		self.quality = var_0_2[self.itemid].equip_quality
		self.imageid = var_0_2[self.itemid].image_id
		self.bagType = var_0_2[self.itemid].bag_item_type
	end

	if self:getChildByName("spine_sculture") then
		self:getChildByName("spine_sculture"):removeFromParent()
	end

	if self.starsPanel then
		self.starsPanel:removeFromParent()

		self.starsPanel = nil
	end

	if self.bagType then
		if self.bagType == kITEM_COMPONENT then
			self:getChildByName("icon"):removeFromParent()

			local var_94_0 = component_manager:create_component_icon(self.entityid)

			var_94_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_94_0:setPositionX(self:getContentSize().width / 2)
			var_94_0:setPositionY(self:getContentSize().height / 2)
			var_94_0:setName("icon")
			self:addChild(var_94_0, 1)
		elseif self.bagType == kITEM_MEDAL then
			self:create_medal_icon(self.itemid)
		elseif self.bagType == KITEM_SPRING_FESTIVAL_WORD and var_0_2[self.itemid].word_bg then
			self:getChildByName("icon"):removeFromParent()

			local var_94_1 = self:create_word_collect_icon(self.itemid)

			var_94_1:setAnchorPoint(cc.p(0.5, 0.5))
			var_94_1:setPositionX(self:getContentSize().width / 2)
			var_94_1:setPositionY(self:getContentSize().height / 2)
			var_94_1:setName("icon")
			self:addChild(var_94_1, 1)
		elseif self.bagType == kITEM_SCULTURE and var_0_2[arg_94_1].spine then
			self:addChild(AvatarSprite:create(self.itemid), 1)
		elseif self.bagType == CHAT_EMOTION_VALUE then
			local var_94_2 = ChatEmotionSprite:create(self.itemid)

			var_94_2:setScale(0.6)
			var_94_2:setName("emotionsp")
			self:addChild(var_94_2, 1)
		else
			self:getChildByName("icon"):loadTexture((PURCHASE_RESULT_ICON_PATH[self.bagType] or "equipment/") .. self.imageid .. ".png")
			self:getChildByName("icon"):setScale(global_get_item_scale(self:getChildByName("icon"), self.bagType) * self.iconScale)

			self:getChildByName("icon").afterLoadSuccess = function(self, arg_95_1)
				self:setScale(global_get_item_scale(self, self.bagType) * self.iconScale)
			end

			if self.bagType == kITEM_HORCRUX then
				self:getChildByName("icon"):setPositionY(self:getChildByName("icon"):getPositionY() + 30)

				self.starsPanel = ccui.Layout:create()

				self.starsPanel:setName("starsPanel")
				self.starsPanel:setScale(0.75)
				self.starsPanel:setPositionY(54)
				self:addChild(self.starsPanel, 5)

				if arg_94_4 then
					global_add_star(self.starsPanel, arg_94_4.star, function(arg_96_0)
						for iter_96_0, iter_96_1 in pairs(arg_96_0) do
							iter_96_1:setPosition(25, (iter_96_0 - 1) * 24 - 30)
						end
					end)
				end
			end
		end

		if self.bagType == kITEM_SCULTURE and var_0_2[arg_94_1].spine or self.bagType == CHAT_EMOTION_VALUE and var_0_2[arg_94_1].spine then
			self:getChildByName("icon"):setVisible(false)
			self:getChildByName("wordBg"):setVisible(false)
		else
			self:getChildByName("icon"):setVisible(true)
			self:getChildByName("wordBg"):setVisible(true)
		end
	end

	self:loadTextures(WEAPON_BG_QUALITY_PATH[self.quality], WEAPON_BG_QUALITY_PATH[self.quality], WEAPON_BG_QUALITY_PATH[self.quality], var_0_16)
	self:getChildByName("numLabel"):setColor(cc.c3b(255, 255, 255))

	if arg_94_2 then
		self:getChildByName("wordBg"):setVisible(true)
		self:getChildByName("numLabel"):setVisible(true)
		self:getChildByName("numLabel"):setString("X" .. global_trans_number(arg_94_2))

		if arg_94_2 == 1 then
			-- block empty
		end
	else
		self:getChildByName("wordBg"):setVisible(false)
		self:getChildByName("numLabel"):setVisible(false)
	end

	if not var_0_21(self.itemid) then
		self:getChildByName("numLabel"):setString(var_0_2[self.itemid].name)
		self:getChildByName("wordBg"):setVisible(true)
		self:getChildByName("numLabel"):setVisible(true)
	end

	if not self.addNum and arg_94_3 and var_0_2[self.itemid].name then
		self:getChildByName("numLabel"):setString(var_0_2[self.itemid].name)
		self:getChildByName("wordBg"):setVisible(true)
		self:getChildByName("numLabel"):setVisible(true)
	end

	if self.bagType == CHAT_EMOTION_VALUE then
		self:adjustEmationPos(self.itemid)
		self:getChildByName("numLabel"):setFontSize(18)
	end
end

function ItemPurchaseSprite:create_medal_icon(arg_97_1)
	local var_97_0 = var_0_2[arg_97_1]
	local var_97_1 = self:getChildByName("icon")

	var_97_1:loadTexture((var_0_2[arg_97_1].bg or nil) and ("equipment/" .. var_0_2[arg_97_1].bg .. ".png" or var_0_25[var_97_0.equip_quality]))

	local var_97_2 = cc.Label:createWithTTF(var_97_0.name, FONT_DES, 54)

	var_97_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_97_2:setPosition(cc.p(var_97_1:getContentSize().width / 2 + 5, var_97_1:getContentSize().height / 2 - 5))
	var_97_2:enableOutline(var_0_26[var_97_0.equip_quality], 1)
	var_97_2:enableShadow(var_0_26[var_97_0.equip_quality], cc.size(0, 0))
	var_97_1:addChild(var_97_2)
	var_97_2:setVisible(var_0_2[arg_97_1].only_bg ~= 1)
end

function ItemPurchaseSprite.create_word_collect_icon(arg_98_0, arg_98_1)
	local var_98_0 = var_0_2[arg_98_1].word_color or "255,255,255"
	local var_98_1 = cc.c3b(string.split(var_98_0, ",")[1], string.split(var_98_0, ",")[2], string.split(var_98_0, ",")[3])
	local var_98_2 = ccui.ImageView:create(var_0_2[arg_98_1].word_bg and "equipment/" .. var_0_2[arg_98_1].word_bg .. ".png")
	local var_98_3 = cc.Label:createWithTTF(var_0_2[arg_98_1].name, var_0_2[arg_98_1].word_font or FONT_NAME, var_0_2[arg_98_1].word_font_size or 40)

	var_98_3:setName("word")
	var_98_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_98_3:setPosition(cc.p(var_98_2:getContentSize().width / 2 + (var_0_2[arg_98_1].word_offset_x or 0), var_98_2:getContentSize().height / 2 + (var_0_2[arg_98_1].word_offset_y or 0)))
	var_98_3:setColor(var_98_1)

	if var_0_2[arg_98_1].word_shadow ~= 0 then
		var_98_3:enableShadow(cc.c4b(0, 0, 0, 150), cc.size(1, -1))
	end

	var_98_2:addChild(var_98_3)

	return var_98_2
end

function ItemPurchaseSprite:createIllustrateItem(arg_99_1, arg_99_2)
	local var_99_0 = self:createPurchaseItem(arg_99_1)

	if arg_99_2 then
		var_99_0:getChildByName("icon"):setScale(1.3)
		var_99_0:getChildByName("icon"):loadTexture("equipment/unkonw.png")
	end

	return var_99_0
end

function ItemPurchaseSprite:setInfoTouchEvent(arg_100_1)
	arg_100_1 = arg_100_1 == true or false

	self:setTouchEnabled(arg_100_1)
	self:addTouchEventListener((function()
		return function(arg_102_0, arg_102_1)
			if arg_102_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_102_0:getTouchBeganPosition().y - arg_102_0:getTouchEndPosition().y) > 50 then
				return
			end

			if not arg_102_0.itemid then
				return
			end

			if type(arg_102_0.itemid) ~= "number" then
				return
			end

			local var_102_0 = {
				backSysId = self.goto_back_system_id,
				itemId = arg_102_0.itemid
			}

			var_102_0.mainNeed = arg_102_0.needNum or 0

			LayerManager:pushInLayer("PopGameCompoundLayer", var_102_0)

			if self.register_touch_callback then
				self.register_touch_callback()
			end

			do return end

			if arg_102_0.ownNum and arg_102_0.needNum then
				if arg_102_0.ownNum < arg_102_0.needNum then
					local var_102_1 = {
						item = arg_102_0.itemid,
						goto_back_system_id = self.goto_back_system_id,
						layer = cc.Layer:create()
					}

					if self.gotoSystemCallback then
						self.gotoSystemCallback(arg_102_0.itemid)
					end

					LayerManager:pushInLayer("PopGoGainLayer", var_102_1)
				else
					local var_102_2 = {
						itemid = arg_102_0.itemid,
						goto_back_system_id = self.goto_back_system_id
					}

					var_102_2.layer = cc.Layer:create()

					local var_102_3 = PopLayer:Item(var_102_2)
				end
			else
				local var_102_4 = {
					itemid = arg_102_0.itemid,
					goto_back_system_id = self.goto_back_system_id
				}

				var_102_4.layer = cc.Layer:create()

				local var_102_5 = PopLayer:Item(var_102_4)
			end

			if self.register_touch_callback then
				self.register_touch_callback()
			end
		end
	end)())
end

function ItemPurchaseSprite:updateIllustrateItem(arg_103_1, arg_103_2)
	self:updatePurchaseItemByItemid(arg_103_1)

	if arg_103_2 then
		self:getChildByName("icon"):setScale(1.3)
		self:getChildByName("icon"):loadTexture("equipment/unkonw.png")
	end
end

function ItemPurchaseSprite:switchToBpItem(arg_104_1, arg_104_2, arg_104_3, arg_104_4, arg_104_5)
	local var_104_0

	if arg_104_5 then
		var_104_0 = arg_104_5 .. "/Panel_suo.png" or "public/button/horcrux_lock.png"

		local var_104_1

		if arg_104_5 then
			var_104_1 = arg_104_5 .. "/button_accelerate.png" or "public/box/button_accelerate.png"
		end
	end

	local var_104_2 = ccui.ImageView:create(var_104_1, var_0_16)

	var_104_2:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
	var_104_2:setLocalZOrder(999)
	var_104_2:setVisible(false)
	self:addChild(var_104_2)

	if arg_104_1 then
		var_104_2:setVisible(true)
	end

	if arg_104_2 then
		self:setColor(cc.c3b(255, 255, 255))
	else
		self:setColor(cc.c3b(255, 255, 255))
	end

	local var_104_3 = ccui.ImageView:create(var_104_0, var_0_16)

	var_104_3:setPosition(cc.p(self:getContentSize().width / 2 - 60, self:getContentSize().height / 2 + 60))
	var_104_3:setLocalZOrder(10000)
	self:addChild(var_104_3)
	var_104_3:setVisible(arg_104_3 == true)
	self:getChildByName("wordBg"):loadTexture(arg_104_4 or "public/box/word_pink_bg.png", var_0_16)

	if arg_104_5 then
		var_104_3:setScale(1.6)
		self:getChildByName("wordBg"):setScale(1.5)
		self:getChildByName("numLabel"):setScale(1.2)
		self:getChildByName("numLabel"):setColor(cc.c3b(28, 14, 66))
	end
end

function ItemPurchaseSprite:updateNeedNum(arg_105_1)
	local item_manager = require("controller.item_manager")

	self:getChildByName("numLabel"):setString(item_manager:getItemNumber(self.itemid) .. "/" .. arg_105_1)

	if arg_105_1 > item_manager:getItemNumber(self.itemid) then
		self:getChildByName("numLabel"):setColor(cc.c3b(255, 0, 0))
	else
		self:getChildByName("numLabel"):setColor(cc.c3b(255, 255, 255))
	end

	self:getChildByName("wordBg"):setVisible(true)
	self:getChildByName("numLabel"):setVisible(true)
end

ItemNoBgSprite = class("ItemNoBgSprite", function()
	return cc.Node:create()
end)

function ItemNoBgSprite:create(arg_107_1, arg_107_2)
	self = ItemNoBgSprite.new()
	self.scale = 1
	self.itemid = arg_107_1

	self:setScale(self.scale)

	self.iconScale = 1

	local var_107_0 = ccui.ImageView:create("GUI/image.png", var_0_16)

	var_107_0:setPositionX(self:getContentSize().width / 2)
	var_107_0:setPositionY(self:getContentSize().height / 2)
	var_107_0:setName("icon")
	self:addChild(var_107_0, 1)
	self:initIcon()
	self:setInfoTouchEvent(arg_107_2)

	return self
end

function ItemNoBgSprite:setTouchEnabled(...)
	self:getChildByName("icon"):setTouchEnabled(...)
end

function ItemNoBgSprite:addTouchEventListener(...)
	self:getChildByName("icon"):addTouchEventListener(...)
end

function ItemNoBgSprite:setInfoTouchEvent(arg_110_1)
	self:setTouchEnabled(arg_110_1)
	self:addTouchEventListener((function()
		return function(arg_112_0, arg_112_1)
			if arg_112_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_112_0:getTouchBeganPosition().y - arg_112_0:getTouchEndPosition().y) > 50 then
				return
			end

			if not self.itemid then
				return
			end

			if type(self.itemid) ~= "number" then
				return
			end

			local var_112_0 = {
				backSysId = self.goto_back_system_id,
				itemId = self.itemid
			}

			var_112_0.mainNeed = self.needNum or 0

			LayerManager:pushInLayer("PopGameCompoundLayer", var_112_0)

			if self.register_touch_callback then
				self.register_touch_callback()
			end

			do return end

			if self.ownNum and self.needNum then
				if self.ownNum < self.needNum then
					local var_112_1 = {
						item = self.itemid,
						goto_back_system_id = self.goto_back_system_id,
						layer = cc.Layer:create()
					}

					if self.gotoSystemCallback then
						self.gotoSystemCallback(self.itemid)
					end

					LayerManager:pushInLayer("PopGoGainLayer", var_112_1)
				else
					local var_112_2 = {
						itemid = self.itemid,
						goto_back_system_id = self.goto_back_system_id
					}

					var_112_2.layer = cc.Layer:create()

					local var_112_3 = PopLayer:Item(var_112_2)
				end
			else
				local var_112_4 = {
					itemid = self.itemid,
					goto_back_system_id = self.goto_back_system_id
				}

				var_112_4.layer = cc.Layer:create()

				local var_112_5 = PopLayer:Item(var_112_4)
			end

			if self.register_touch_callback then
				self.register_touch_callback()
			end
		end
	end)())
end

function ItemNoBgSprite:initIcon()
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
	elseif var_0_2[self.itemid].bag_item_type == kITEM_HORCRUX then
		self.quality = var_0_2[self.itemid].equip_quality
		self.imageid = horcrux_manager:getHorcruxRoleImageByItemSprite(self.itemid)
		self.bagType = var_0_2[self.itemid].bag_item_type
	else
		self.quality = var_0_2[self.itemid].equip_quality
		self.imageid = var_0_2[self.itemid].image_id
		self.bagType = var_0_2[self.itemid].bag_item_type
	end

	if self.bagType == kITEM_COMPONENT then
		self:getChildByName("icon"):removeFromParent()

		local var_113_0 = component_manager:create_component_icon(self.itemid)

		var_113_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_113_0:setPositionX(self:getContentSize().width / 2)
		var_113_0:setPositionY(self:getContentSize().height / 2)
		var_113_0:setName("icon")
		self:addChild(var_113_0, 1)
	elseif self.bagType == kITEM_MEDAL then
		self:create_medal_icon(self.itemid)
	elseif self.bagType == KITEM_SPRING_FESTIVAL_WORD and var_0_2[self.itemid].word_bg then
		self:getChildByName("icon"):removeFromParent()

		local var_113_1 = self:create_word_collect_icon(self.itemid)

		var_113_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_113_1:setPositionX(self:getContentSize().width / 2)
		var_113_1:setPositionY(self:getContentSize().height / 2)
		var_113_1:setName("icon")
		self:addChild(var_113_1, 1)
	elseif self.bagType == kITEM_SCULTURE and var_0_2[itemid].spine then
		local var_113_2 = AvatarSprite:create(self.itemid)

		var_113_2:setName("icon")
		self:addChild(var_113_2, 1)
	elseif self.bagType == kITEM_HORCRUX then
		self:getChildByName("icon"):loadTexture("equipment/" .. self.imageid .. ".png")
		self:getChildByName("icon"):setScale(global_get_item_scale(self:getChildByName("icon"), self.bagType) * self.iconScale)

		self:getChildByName("icon").afterLoadSuccess = function(self, arg_114_1)
			self:setScale(global_get_item_scale(self, self.bagType) * self.iconScale)
		end
	else
		self:getChildByName("icon"):loadTexture((PURCHASE_RESULT_ICON_PATH[self.bagType] or "equipment/") .. self.imageid .. ".png")
		self:getChildByName("icon"):setScale(global_get_item_scale(self:getChildByName("icon"), self.bagType) * self.iconScale)

		self:getChildByName("icon").afterLoadSuccess = function(self, arg_115_1)
			self:setScale(global_get_item_scale(self, self.bagType) * self.iconScale)
		end
	end
end

function ItemNoBgSprite:updateIcon(arg_116_1)
	self.itemid = arg_116_1

	self:getChildByName("icon"):removeFromParent()

	local var_116_0 = ccui.ImageView:create("GUI/image.png", var_0_16)

	var_116_0:setPositionX(self:getContentSize().width / 2)
	var_116_0:setPositionY(self:getContentSize().height / 2)
	var_116_0:setName("icon")
	self:addChild(var_116_0, 1)
	self:initIcon()
end

function ItemPurchaseSprite:adjustEmationPos(arg_117_1)
	local var_117_0 = self:getChildByName("emotionsp")

	if not var_117_0 then
		return
	end

	local var_117_1 = {
		[123201005] = function()
			var_117_0:setPositionX(30)
			var_117_0:setPositionY(0)
		end
	}

	if arg_117_1 and var_117_1[arg_117_1] then
		var_117_1[arg_117_1]()
	else
		var_117_0:setPositionX(30)
		var_117_0:setPositionY(30)
	end
end
