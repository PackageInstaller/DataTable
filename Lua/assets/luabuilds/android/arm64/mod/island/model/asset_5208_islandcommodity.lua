local IslandCommodity = class("IslandCommodity", import("model.vo.BaseVO"))

IslandCommodity.TAG = {
	HOT = 4,
	NEW = 3,
	TIME = 2,
	NONE = 1
}

local var_0_1 = pg.pay_data_display

function IslandCommodity:Ctor(arg_1_1, arg_1_2)
	self.configId = arg_1_1.id
	self.id = arg_1_1.id
	self.purchasedNum = arg_1_1.num
	self.shopId = arg_1_2

	return
end

function IslandCommodity:bindConfigTable()
	return pg.island_shop_goods
end

function IslandCommodity:SetCfgSortIdx(arg_3_1)
	self.cfgSortIdx = arg_3_1

	return
end

function IslandCommodity:GetCfgSortIdx()
	return self.cfgSortIdx or self.id
end

function IslandCommodity:GetName()
	return self:getConfig("goods_name")
end

function IslandCommodity:GetDescription()
	return self:getConfig("desc")
end

function IslandCommodity:GetIcon()
	return "island/" .. self:getConfig("icon")
end

function IslandCommodity:GetResourceConsume()
	return self:getConfig("resource_consume")
end

function IslandCommodity:GetItems()
	return self:getConfig("items")
end

function IslandCommodity:GetDisplayItems()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(self:GetItems()) do
		if not IslandCommodity.IsHideCommondity(iter_10_1) then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function IslandCommodity:GetItemsWithPt()
	local var_11_0 = self:getConfig("pt_award")
	local var_11_1 = Clone(self:GetItems())

	if var_11_0 > 0 then
		table.insert(var_11_1, {
			VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT,
			0,
			var_11_0
		})
	end

	return var_11_1
end

function IslandCommodity:GetPayId()
	return self:getConfig("pay_id")
end

function IslandCommodity:GetMaxNum()
	return self:getConfig("limited_num")
end

function IslandCommodity:IsShowPurchaseLimit()
	return self:getConfig("limited_show") == 1
end

function IslandCommodity:IsShowSellOut()
	return self:getConfig("remian_show") == 1
end

function IslandCommodity:IsShowHave()
	return self:getConfig("goods_have") == 1 and #self:GetItems() == 1
end

function IslandCommodity:IsShowHold()
	return self:getConfig("have_show") == 1
end

function IslandCommodity:GetDiscount()
	return (pg.TimeMgr.GetInstance():inTime(self:getConfig("discount_time")) or nil) and self:getConfig("discount")
end

function IslandCommodity:GetCommodityShowType()
	return self:getConfig("goods_detail_type")
end

function IslandCommodity:GetPacketItemsShowTypes()
	return self:getConfig("groups_detail_type")
end

function IslandCommodity:GetModel()
	return self:getConfig("items_model")
end

function IslandCommodity:GetModelParam()
	return self:getConfig("model_param")
end

function IslandCommodity:UpdateNum(arg_23_1)
	self.purchasedNum = arg_23_1

	return
end

function IslandCommodity:AddNum(arg_24_1)
	self.purchasedNum = self.purchasedNum + arg_24_1

	return
end

function IslandCommodity:GetPayConfig()
	return var_0_1[self:GetPayId()]
end

function IslandCommodity:GetTag()
	return switch(self:getConfig("tag") or 0, {
		[0] = function()
			return (self:IsTimeLimitCommodity() or nil) and (IslandCommodity.TAG.TIME or IslandCommodity.TAG.NONE)
		end,
		function()
			return IslandCommodity.TAG.NEW
		end,
		function()
			return IslandCommodity.TAG.HOT
		end
	}, function()
		return IslandCommodity.TAG.NONE
	end)
end

function IslandCommodity:IsTimeLimitCommodity()
	if type((self:getConfig("time"))) == "table" then
		return true
	end

	return false
end

function IslandCommodity:IsCharacterInviteItemHold()
	local var_32_0 = self:GetItems()
	local var_32_1 = {}

	for iter_32_0, iter_32_1 in ipairs(pg.island_chara_template.all) do
		table.insert(var_32_1, pg.island_chara_template[iter_32_1].invite_item)
	end

	if #var_32_0 ~= 1 or not table.contains(var_32_1, var_32_0[1][2]) then
		return false
	end

	return getProxy(IslandProxy):GetIsland():GetCharacterAgency():HasInvite(pg.island_chara_template.all[table.indexof(var_32_1, var_32_0[1][2])])
end

function IslandCommodity:GetDressType()
	local var_33_0 = self:GetItems()

	if not var_33_0[1] or var_33_0[1][1] ~= DROP_TYPE_ISLAND_DRESS then
		return nil
	end

	local var_33_1 = pg.island_dress_template[var_33_0[1][2]]

	if not pg.island_dress_template[var_33_0[1][2]] then
		return nil
	end

	return var_33_1.type
end

function IslandCommodity:IsHideCommondity()
	if (self.type or self[1]) == DROP_TYPE_ISLAND_DRESS then
		if pg.island_dress_template[self.id or self[2]] and pg.island_dress_template[self.id or self[2]].is_hide == 1 then
			return true
		end
	end

	return false
end

return IslandCommodity
