local Item = class("Item", import(".BaseVO"))

Item.REVERT_EQUIPMENT_ID = 15007
Item.COMMANDER_QUICKLY_TOOL_ID = 20010
Item.QUICK_TASK_PASS_TICKET_ID = 15013
Item.DOA_SELECT_CHAR_ID = 0
Item.INVISIBLE_TYPE = {
	[0] = true,
	[true] = 9
}
Item.PUZZLA_TYPE = 0
Item.EQUIPMENT_BOX_TYPE_5 = 5
Item.DESIGN_TYPE = 9
Item.LESSON_TYPE = 10
Item.EQUIPMENT_SKIN_BOX = 11
Item.BLUEPRINT_TYPE = 12
Item.ASSIGNED_TYPE = 13
Item.GOLD_BOX_TYPE = 14
Item.OIL_BOX_TYPE = 15
Item.EQUIPMENT_ASSIGNED_TYPE = 16
Item.GIFT_BOX = 17
Item.TEC_SPEEDUP_TYPE = 18
Item.SPECIAL_OPERATION_TICKET = 19
Item.GUILD_OPENABLE = 20
Item.INVITATION_TYPE = 21
Item.EXP_BOOK_TYPE = 22
Item.LOVE_LETTER_TYPE = 23
Item.SPWEAPON_MATERIAL_TYPE = 24
Item.METALESSON_TYPE = 25
Item.SKIN_ASSIGNED_TYPE = 26
Item.SHIP_GIFT = 50

function Item:Ctor(arg_1_1)
	assert(not arg_1_1.type or arg_1_1.type == DROP_TYPE_VITEM or arg_1_1.type == DROP_TYPE_ITEM)

	self.id = arg_1_1.id
	self.configId = self.id
	self.count = arg_1_1.count
	self.name = arg_1_1.name
	self.extra = arg_1_1.extra

	self:InitConfig()

	return
end

function Item:CanOpen()
	local var_2_0 = self:getConfig("type")

	return var_2_0 == Item.EQUIPMENT_BOX_TYPE_5 or var_2_0 == Item.EQUIPMENT_SKIN_BOX or var_2_0 == Item.GOLD_BOX_TYPE or var_2_0 == Item.OIL_BOX_TYPE or var_2_0 == Item.GIFT_BOX or var_2_0 == Item.GUILD_OPENABLE
end

function Item:IsShipExpType()
	return self:getConfig("type") == Item.EXP_BOOK_TYPE
end

function Item:getConfigData()
	local var_4_0 = {
		pg.item_virtual_data_statistics,
		pg.item_data_statistics
	}

	return (underscore.any(var_4_0, function(arg_5_0)
		return arg_5_0[self] ~= nil
	end) or nil) and setmetatable({}, {
		__index = function(self, arg_6_1)
			for iter_6_0, iter_6_1 in ipairs(var_4_0) do
				if iter_6_1[self] and iter_6_1[self][arg_6_1] ~= nil then
					self[arg_6_1] = iter_6_1[self][arg_6_1]

					return self[arg_6_1]
				end
			end

			return
		end
	})
end

function Item:InitConfig()
	self.cfg = Item.getConfigData(self.configId)

	assert(self.cfg, string.format("without item config from id_%d", self.id))

	return
end

function Item:getConfigTable()
	return self.cfg
end

function Item:CanInBag()
	return tobool(pg.item_data_statistics[self])
end

function Item:couldSell()
	return table.getCount(self:getConfig("price")) > 0
end

function Item:GetPrice()
	if self:couldSell() then
		return self:getConfig("price")
	else
		return nil
	end

	return
end

function Item:isEnough(arg_12_1)
	return arg_12_1 <= self.count
end

function Item:consume(arg_13_1)
	self.count = self.count - arg_13_1

	return
end

function Item:isDesignDrawing()
	return self:getConfig("type") == 9
end

function Item:isVirtualItem()
	return self:getConfig("type") == 0
end

function Item:isEquipmentSkinBox()
	return self:getConfig("type") == Item.EQUIPMENT_SKIN_BOX
end

function Item:isBluePrintType()
	return self:getConfig("type") == Item.BLUEPRINT_TYPE
end

function Item:isTecSpeedUpType()
	return self:getConfig("type") == Item.TEC_SPEEDUP_TYPE
end

function Item:IsMaxCnt()
	return self:getConfig("max_num") <= self.count
end

function Item:IsDoaSelectCharItem()
	return self.id == Item.DOA_SELECT_CHAR_ID
end

function Item:getConfig(arg_21_1)
	if arg_21_1 == "display" then
		local var_21_0 = Item.super.getConfig(self, "combination_display")

		if var_21_0 and #var_21_0 > 0 then
			return self:CombinationDisplay(var_21_0)
		end
	end

	return Item.super.getConfig(self, arg_21_1)
end

function Item:StaticCombinationDisplay()
	return i18n("skin_gift_desc", (table.concat(_.map(self, function(arg_23_0)
		local var_23_0 = string.format("%0.2f", arg_23_0[2] / 100)
		local var_23_1 = ShipSkin.New({
			id = arg_23_0[1]
		})
		local var_23_2 = {}

		for iter_23_0, iter_23_1 in ipairs(getGameset("random_skin_tag")[2]) do
			var_23_2[iter_23_1[1]] = iter_23_1[2]
		end

		local var_23_3 = underscore(var_23_1:getConfig("tag")):chain():filter(function(arg_24_0)
			return var_23_2[arg_24_0]
		end):map(function(arg_25_0)
			return var_23_2[arg_25_0]
		end):value()

		return "\n（<color=#92fc63>" .. var_23_0 .. "%%</color>）" .. var_23_1.shipName .. i18n("random_skin_list_item_desc_label") .. var_23_1.skinName .. (#var_23_3 > 0 and string.format("（<color=#92fc63>%s</color>）", table.concat(var_23_3, " ")) or "") .. ((var_23_1:ExistReward() or nil) and i18n("word_show_extra_reward_at_fudai_dialog", var_23_1:GetRewardListDesc()))
	end), ";")))
end

function Item:CombinationDisplay(arg_26_1)
	return Item.StaticCombinationDisplay(arg_26_1)
end

function Item:InTimeLimitSkinAssigned()
	local var_27_0 = Item.getConfigData(self)

	if var_27_0.type ~= Item.SKIN_ASSIGNED_TYPE then
		return false
	end

	return getProxy(ActivityProxy):IsActivityNotEnd(var_27_0.usage_arg[1])
end

function Item:GetValidSkinList()
	assert(self:getConfig("type") == Item.SKIN_ASSIGNED_TYPE)

	local var_28_0 = self:getConfig("usage_arg")

	if Item.InTimeLimitSkinAssigned(self.id) then
		return table.mergeArray(var_28_0[2], var_28_0[3], true)
	else
		return underscore.rest(var_28_0[3], 1)
	end

	return
end

function Item:IsAllSkinOwner()
	assert(self:getConfig("type") == Item.SKIN_ASSIGNED_TYPE)

	local var_29_0 = getProxy(ShipSkinProxy)

	return underscore.all(self:GetValidSkinList(), function(arg_30_0)
		return var_29_0:hasNonLimitSkin(arg_30_0)
	end)
end

function Item:GetOverflowCheckItems(arg_31_1)
	arg_31_1 = arg_31_1 or 1

	local var_31_0 = {}

	if self:getConfig("usage") == ItemUsage.DROP_TEMPLATE then
		local var_31_1, var_31_2, var_31_3 = unpack(self:getConfig("usage_arg"))

		if var_31_2 > 0 then
			table.insert(var_31_0, {
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResGold,
				count = var_31_2 * arg_31_1
			})
		end

		if var_31_3 > 0 then
			table.insert(var_31_0, {
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResOil,
				count = var_31_3 * arg_31_1
			})
		end
	end

	switch(self:getConfig("type"), {
		[Item.EQUIPMENT_BOX_TYPE_5] = function()
			table.insert(var_31_0, {
				type = DROP_TYPE_EQUIP,
				id = EQUIP_OCCUPATION_ID,
				count = arg_31_1
			})

			return
		end,
		[Item.EQUIPMENT_ASSIGNED_TYPE] = function()
			table.insert(var_31_0, {
				type = DROP_TYPE_EQUIP,
				id = EQUIP_OCCUPATION_ID,
				count = arg_31_1
			})

			return
		end
	})
	underscore.map(var_31_0, function(arg_34_0)
		return Drop.New(arg_34_0)
	end)

	return var_31_0
end

function Item:IsSkinShopDiscountType()
	return self:getConfig("usage") == ItemUsage.SKIN_SHOP_DISCOUNT
end

function Item:IsExclusiveDiscountType()
	return self:getConfig("usage") == ItemUsage.USAGE_SHOP_DISCOUNT
end

function Item:IsSkinExperienceType()
	return self:getConfig("usage") == ItemUsage.USAGE_SKIN_EXP
end

function Item:CanUseForShop(arg_38_1)
	if self:IsSkinShopDiscountType() then
		local var_38_0 = self:getConfig("usage_arg")

		if not var_38_0 or type(var_38_0) ~= "table" then
			return false
		end

		local var_38_1 = var_38_0[1] or {}

		return #var_38_1 == 1 and var_38_1[1] == 0 or table.contains(var_38_1, arg_38_1)
	elseif self:IsSkinExperienceType() then
		local var_38_2 = self:getConfig("usage_arg")

		if not var_38_2 or type(var_38_2) ~= "table" then
			return false
		end

		return (var_38_2[1] or -1) == arg_38_1
	elseif self:IsExclusiveDiscountType() then
		local var_38_3 = self:getConfig("usage_arg")[1]

		if not var_38_3 or type(var_38_3) ~= "table" then
			return false
		end

		return (var_38_3[1] or -1) == arg_38_1
	end

	return false
end

function Item:GetConsumeForSkinShopDiscount(arg_39_1)
	if self:IsSkinShopDiscountType() or self:IsExclusiveDiscountType() and self:CanUseForShop(arg_39_1) then
		local var_39_0 = pg.item_data_statistics[self.configId].usage_arg[2] or 0
		local var_39_1 = Goods.Create({
			shop_id = arg_39_1
		}, Goods.TYPE_SKIN)
		local var_39_2 = math.max(0, var_39_1:GetPrice() - var_39_0)
		local var_39_3 = var_39_1:getConfig("resource_type")

		return
	else
		return 0
	end

	return
end

function Item:getName()
	return self.name or self:getConfig("name")
end

function Item:getIcon()
	return self:getConfig("Icon")
end

local var_0_1

function Item:IsLoveLetterCheckItem()
	if not var_0_1 then
		var_0_1 = {}

		for iter_42_0, iter_42_1 in ipairs(getGameset("loveletter_item_old_year")[2]) do
			local var_42_0, var_42_1 = unpack(iter_42_1)

			var_0_1[var_42_0] = underscore.flatten({
				var_42_1
			})
		end

		for iter_42_2, iter_42_3 in ipairs(pg.loveletter_2018_2021.all) do
			var_0_1[iter_42_3] = {
				pg.loveletter_2018_2021[iter_42_3].year
			}
		end
	end

	return var_0_1[self]
end

function Item:IsRepairLoveLetterItem()
	for iter_43_0, iter_43_1 in ipairs(getGameset("loveletter2018_item")[2]) do
		if self.id == iter_43_1 then
			return true
		end
	end

	return false
end

return Item
