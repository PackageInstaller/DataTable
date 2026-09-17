local var_0_0 = config._DEBUG and 0 or 1
local item_data = require("data.item_data")

ItemSpriteSign = class("ItemSpriteSign", function()
	return ccui.Button:create("public/box/sign_1.png", "public/box/sign_1.png", "public/box/sign_1.png", var_0_0)
end)

local var_0_2 = {
	"public/box/sign_1.png",
	"public/box/sign_2.png",
	"public/box/sign_3.png",
	"public/box/sign_4.png",
	"public/box/sign_5.png",
	"public/box/sign_6.png"
}
local var_0_3 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_4 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 84, 0, 150)
}

function ItemSpriteSign:createSignItemByEntityid(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = self:createSignItem()

	var_2_0:updateSignItemByEntityid(arg_2_1, arg_2_2 or playerModel.items[arg_2_1].number, arg_2_3, arg_2_4)

	return var_2_0
end

function ItemSpriteSign:setItemUIConf(arg_3_1)
	self.bgpath = arg_3_1.bgpath or self.bgpath
	self.labelSize = arg_3_1.labelSize or self.labelSize
	self.labelColor = arg_3_1.labelColor or self.labelColor
end

function ItemSpriteSign:createSignItem(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	self.bgpath = global_deepCopy(var_0_2)
	self.labelSize = 18
	self.labelColor = cc.c3b(255, 55, 55)
	self = ItemSpriteSign.new()
	self.scale = 1
	self.goto_back_system_id = arg_4_4

	self:setTouchEnabled(false)
	self:setScale(self.scale)

	self.iconScale = 0.55

	local var_4_0 = ccui.Layout:create()

	var_4_0:setName("cliplayer")
	var_4_0:setContentSize(cc.size(self:getContentSize().width, 88))
	var_4_0:setAnchorPoint(cc.p(0, 0))
	var_4_0:setPosition(cc.p(0, 18))
	var_4_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_4_0:setClippingEnabled(true)
	self:addChild(var_4_0, 1)

	local var_4_1 = ccui.ImageView:create("GUI/image.png", var_0_0)

	var_4_1:setPositionX(var_4_0:getContentSize().width / 2)
	var_4_1:setPositionY(var_4_0:getContentSize().height / 2)
	var_4_1:setName("icon")
	var_4_0:addChild(var_4_1, 1)

	local var_4_2 = ccui.Text:create("x/y", FONT_DES, self.labelSize)

	var_4_2:setPositionX(self:getContentSize().width / 2)
	var_4_2:setPositionY(12)
	var_4_2:setColor(self.labelColor)
	var_4_2:setName("numLabel")
	self:addChild(var_4_2, 3)

	local var_4_3 = ccui.ImageView:create("public/panelbg/head_tag.png", var_0_0)

	var_4_3:setName("head_tag")
	var_4_3:setScale(0.8)
	var_4_3:setAnchorPoint(cc.p(0, 1))
	var_4_3:setPositionX(-4)
	var_4_3:setPositionY(var_4_0:getContentSize().height + 4)
	var_4_0:addChild(var_4_3, 2)

	if arg_4_1 then
		self:updateSignItemByItemid(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	end

	return self
end

function ItemSpriteSign:updateSignItemByEntityid(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self:updateSignItemByItemid(playerModel.items[arg_5_1].itemid, arg_5_2 or playerModel.items[arg_5_1].number, arg_5_3, arg_5_4)
end

function ItemSpriteSign:updateSignItemByItemid(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	self.ownNum = arg_6_2
	self.needNum = arg_6_3
	self.itemid = arg_6_1
	self.goto_back_system_id = arg_6_4 or self.goto_back_system_id

	if self.itemid == "gold" then
		self.quality = 1
		self.path = "equipment/1000001.png"
		self.bagType = 88
	elseif self.itemid == "diamond" then
		self.quality = 6
		self.path = "equipment/1000000.png"
		self.bagType = 88
	elseif item_data[self.itemid].bag_item_type == kITEM_SCULTURE then
		self.quality = item_data[self.itemid].equip_quality
		self.path = "roleimage/role/wuji/" .. item_data[self.itemid].image_id .. ".png"
		self.bagType = item_data[self.itemid].bag_item_type
	elseif item_data[self.itemid].bag_item_type == kITEM_MEDAL or item_data[self.itemid].bag_item_type == KITEM_SPRING_FESTIVAL_WORD then
		self.quality = item_data[self.itemid].equip_quality
		self.bagType = item_data[self.itemid].bag_item_type
	else
		self.quality = item_data[self.itemid].equip_quality
		self.path = "equipment/" .. item_data[self.itemid].image_id .. ".png"
		self.bagType = item_data[self.itemid].bag_item_type
	end

	if self.bgpath[self.quality]:find("mainScenebg") then
		self:loadTextures(self.bgpath[self.quality], self.bgpath[self.quality], self.bgpath[self.quality])
	else
		self:loadTextures(self.bgpath[self.quality], self.bgpath[self.quality], self.bgpath[self.quality], var_0_0)
	end

	if ccui.Helper:seekWidgetByName(self, "medalbg") then
		ccui.Helper:seekWidgetByName(self, "medalbg"):setVisible(false)
	end

	if ccui.Helper:seekWidgetByName(self, "icon") then
		ccui.Helper:seekWidgetByName(self, "icon"):setVisible(true)
	end

	if ccui.Helper:seekWidgetByName(self, "cliplayer"):getChildByName("avatarsp") then
		ccui.Helper:seekWidgetByName(self, "cliplayer"):removeChildByName("avatarsp")
	end

	if arg_6_5 then
		ccui.Helper:seekWidgetByName(self, "icon"):loadTexture(arg_6_5)
	elseif item_data[arg_6_1].bag_item_type == kITEM_MEDAL or item_data[arg_6_1].bag_item_type == KITEM_SPRING_FESTIVAL_WORD then
		if not ccui.Helper:seekWidgetByName(self, "medalbg") then
			local var_6_0 = ccui.ImageView:create((item_data[arg_6_1].bg or nil) and ("equipment/" .. item_data[arg_6_1].bg .. ".png" or var_0_3[self.quality]))

			var_6_0:setPosition(ccui.Helper:seekWidgetByName(self, "icon"):getPosition())
			var_6_0:setName("medalbg")
			ccui.Helper:seekWidgetByName(self, "cliplayer"):addChild(var_6_0)

			if item_data[arg_6_1].bag_item_type == kITEM_MEDAL then
				local var_6_1 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_6_1:setName("medal")
				var_6_0:addChild(var_6_1, 1)
			else
				local var_6_3 = cc.Label:createWithTTF("", item_data[arg_6_1].word_font or FONT_DES, item_data[arg_6_1].word_font_size or 54)

				var_6_3:setName("medal")
				var_6_0:addChild(var_6_3, 1)
			end

			var_6_0:getChildByName("medal"):setVisible(item_data[arg_6_1].only_bg ~= 1)
		end

		ccui.Helper:seekWidgetByName(self, "medalbg"):setVisible(true)

		local var_6_4

		if item_data[arg_6_1].bg then
			var_6_4 = "equipment/" .. item_data[arg_6_1].bg .. ".png"

			if not ("equipment/" .. item_data[arg_6_1].bg .. ".png") then
				if item_data[arg_6_1].word_bg and item_data[arg_6_1].word_bg .. ".png" then
					var_6_4 = "equipment/" .. item_data[arg_6_1].word_bg .. ".png" or var_0_3[self.quality]
				end
			end
		end

		ccui.Helper:seekWidgetByName(self, "medalbg"):loadTexture(var_6_4)
		ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):setString(item_data[arg_6_1].name)
		ccui.Helper:seekWidgetByName(self, "icon"):setVisible(false)
		ccui.Helper:seekWidgetByName(self, "medalbg"):setScale(0.64)

		local var_6_5 = item_data[arg_6_1].word_offset_x or 0
		local var_6_6 = item_data[arg_6_1].word_offset_y or 0
		local var_6_7 = item_data[arg_6_1].word_color or "255,255,255"
		local var_6_8 = cc.c3b(string.split(var_6_7, ",")[1], string.split(var_6_7, ",")[2], string.split(var_6_7, ",")[3])

		if item_data[arg_6_1].bag_item_type == kITEM_MEDAL then
			local var_6_9 = ccui.Helper:seekWidgetByName(self, "medalbg")

			ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):setAnchorPoint(cc.p(0.5, 0.5))
			ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):setPosition(cc.p(var_6_9:getContentSize().width / 2 + 5, var_6_9:getContentSize().height / 2 - 5))
			ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):enableOutline(var_0_4[self.quality], 1)
			ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):enableShadow(var_0_4[self.quality], cc.size(0, 0))
		else
			local var_6_10 = ccui.Helper:seekWidgetByName(self, "medalbg")

			ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):setAnchorPoint(cc.p(0.5, 0.5))
			ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):setPosition(cc.p(var_6_10:getContentSize().width / 2 + var_6_5, var_6_10:getContentSize().height / 2 + var_6_6))
			ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):enableShadow(cc.c4b(0, 0, 0, 150), cc.size(1, -1))
		end

		ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):setColor(var_6_8)
	else
		ccui.Helper:seekWidgetByName(self, "icon"):loadTexture(self.path)
	end

	ccui.Helper:seekWidgetByName(self, "icon"):setScale(global_get_item_scale(ccui.Helper:seekWidgetByName(self, "icon"), self.bagType) * self.iconScale)

	ccui.Helper:seekWidgetByName(self, "icon").afterLoadSuccess = function(self, arg_7_1)
		self:setScale(global_get_item_scale(self, self.bagType) * self.iconScale)
	end

	self:getChildByName("numLabel"):setScaleX(1)

	if arg_6_3 and arg_6_2 then
		self:getChildByName("numLabel"):setVisible(true)
		self:getChildByName("numLabel"):setString(global_trans_number(arg_6_2) .. "/" .. global_trans_number(arg_6_3))
	elseif not arg_6_3 and arg_6_2 then
		self:getChildByName("numLabel"):setVisible(true)
		self:getChildByName("numLabel"):setString("x" .. global_trans_number(arg_6_2))

		if arg_6_2 == 1 then
			self:getChildByName("numLabel"):setScaleX((self:getChildByName("numLabel"):getContentSize().width > 90 or nil) and (90 / self:getChildByName("numLabel"):getContentSize().width or 1))
		end
	else
		self:getChildByName("numLabel"):setVisible(false)
	end

	self:getChildByName("numLabel"):setColor(self.labelColor)
	self:getChildByName("numLabel"):setFontSize(self.labelSize)
	ccui.Helper:seekWidgetByName(self, "head_tag"):setVisible(false)

	if item_data[arg_6_1].bag_item_type == kITEM_SCULTURE then
		ccui.Helper:seekWidgetByName(self, "head_tag"):setVisible(true)

		local var_6_12 = AvatarSprite:create(self.itemid)

		var_6_12:setScale(0.5294117647058824)
		var_6_12:setName("avatarsp")
		ccui.Helper:seekWidgetByName(self, "cliplayer"):addChild(var_6_12)
		ccui.Helper:seekWidgetByName(self, "icon"):setVisible(false)
	end
end

function ItemSpriteSign:setInfoTouchEvent(arg_8_1)
	self:setTouchEnabled(arg_8_1)
	self:addTouchEventListener((function()
		return function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_10_0:getTouchBeganPosition().y - arg_10_0:getTouchEndPosition().y) > 50 then
				return
			end

			if not arg_10_0.itemid then
				return
			end

			if type(arg_10_0.itemid) ~= "number" then
				return
			end

			if arg_10_0.ownNum and arg_10_0.needNum then
				if arg_10_0.ownNum < arg_10_0.needNum then
					if self.gotoSystemCallback then
						self.gotoSystemCallback(arg_10_0.itemid)
					end

					LayerManager:pushInLayer("PopGoGainLayer", {
						item = arg_10_0.itemid,
						goto_back_system_id = self.goto_back_system_id,
						layer = cc.Layer:create()
					})
				else
					local var_10_0 = {
						itemid = arg_10_0.itemid,
						goto_back_system_id = self.goto_back_system_id
					}

					var_10_0.layer = cc.Layer:create()

					local var_10_1 = PopLayer:Item(var_10_0)
				end
			else
				local var_10_2 = {
					itemid = arg_10_0.itemid,
					goto_back_system_id = self.goto_back_system_id
				}

				var_10_2.layer = cc.Layer:create()

				local var_10_3 = PopLayer:Item(var_10_2)
			end

			if self.register_touch_callback then
				self.register_touch_callback()
			end
		end
	end)())
end

function ItemSpriteSign.registerTouchCallback(arg_11_0, arg_11_1)
	arg_11_0.register_touch_callback = arg_11_1
end

function ItemSpriteSign.registerGotoSystemCallback(arg_12_0, arg_12_1)
	arg_12_0.gotoSystemCallback = arg_12_1
end
