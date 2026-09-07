local IslandAblityAgency = class("IslandAblityAgency", import(".IslandBaseAgency"))

IslandAblityAgency.UNLOCK_SYSTEM = "IslandAblityAgency:UNLOCK_SYSTEM"
IslandAblityAgency.TYPE_SYSTEM = 1
IslandAblityAgency.TYPE_PLACE = 2
IslandAblityAgency.TYPE_FORMULA = 3
IslandAblityAgency.TYPE_SHOP_NORMAL = 4
IslandAblityAgency.TYPE_INVENTORY_MAXCNT = 6
IslandAblityAgency.TYPE_SHOP_TEMPORARY = 7
IslandAblityAgency.TYPE_ORDER = 8
IslandAblityAgency.TYPE_SLOT = 9
IslandAblityAgency.TYPE_MAP = 11
IslandAblityAgency.TYPE_ANIMAL = 15
IslandAblityAgency.TYPE_RESTAURANT = 17
IslandAblityAgency.TYPE_ASSISTANT = 18
IslandAblityAgency.TYPE_COLLECT_TOOL = 19
IslandAblityAgency.TYPE_ORDER_DAILY_CNT = 20
IslandAblityAgency.TYPE_SIGN_GIFT_CNT = 21
IslandAblityAgency.TYPE_RECOVER_CAMP = 22
IslandAblityAgency.TYPE_RECOVER_ORE = 23
IslandAblityAgency.TYPE_SECOND_PRODUCT = 24
IslandAblityAgency.TYPE_PRODUCT_FELLING = 26
IslandAblityAgency.TYPE_PRODUCT_MINING = 27
IslandAblityAgency.TYPE_ORDER_EXP = 31
IslandAblityAgency.TYPE_POST_MANAGE = 37
IslandAblityAgency.TYPE_PRODUCT_FARM = 38
IslandAblityAgency.TYPE_PRODUCT_ORCHARD = 39
IslandAblityAgency.TYPE_PRODUCT_GARDEN = 40
IslandAblityAgency.TYPE_FISHING_ROD = 41
IslandAblityAgency.TYPE_PRODUCT_FISH = 42
IslandAblityAgency.ANIMATION_OP_ID = 40
IslandAblityAgency.SET_MEAL_ID = 29001

function IslandAblityAgency:OnInit(arg_1_1)
	self.abilitys = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.ability_list or {}) do
		table.insert(self.abilitys, iter_1_1)
	end

	return
end

function IslandAblityAgency:AddAblity(arg_2_1)
	table.insert(self.abilitys, arg_2_1)

	if IslandAblityAgency.GetAblityType(arg_2_1) == IslandAblityAgency.TYPE_SYSTEM then
		self:DispatchEvent(IslandAblityAgency.UNLOCK_SYSTEM, arg_2_1)
	end

	if IslandAblityAgency.IsMapType(arg_2_1) then
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandUnlockMap(IslandAblityAgency.GetEffect(arg_2_1)))
		getProxy(IslandProxy):GetIsland():GetTechnologyAgency():TryAutoUnlock()
	end

	return
end

function IslandAblityAgency:IsUnlockOrderExp()
	return _.any(self.abilitys, function(arg_4_0)
		return IslandAblityAgency.IsOrderExpType(arg_4_0)
	end)
end

function IslandAblityAgency:IsUnlockPostManage()
	return _.any(self.abilitys, function(arg_6_0)
		return IslandAblityAgency.GetAblityType(arg_6_0) == IslandAblityAgency.TYPE_POST_MANAGE
	end)
end

function IslandAblityAgency:IsUnlockMap(arg_7_1)
	return _.any(self.abilitys, function(arg_8_0)
		return IslandAblityAgency.IsMapType(arg_8_0) and IslandAblityAgency.GetEffect(arg_8_0) == arg_7_1
	end)
end

function IslandAblityAgency:IsUnlockShipOrder(arg_9_1)
	return _.any(self.abilitys, function(arg_10_0)
		return IslandAblityAgency.IsOrderType(arg_10_0) and IslandAblityAgency.GetEffect(arg_10_0) == arg_9_1
	end)
end

function IslandAblityAgency:IsUnlockFormuate(arg_11_1)
	return _.any(self.abilitys, function(arg_12_0)
		return IslandAblityAgency.IsFormuateType(arg_12_0) and IslandAblityAgency.GetEffect(arg_12_0) == arg_11_1
	end)
end

function IslandAblityAgency:IsUnlcokSecondProduct(arg_13_1)
	return _.any(self.abilitys, function(arg_14_0)
		return IslandAblityAgency.IsSecondProductType(arg_14_0) and IslandAblityAgency.GetEffect(arg_14_0) == arg_13_1
	end)
end

function IslandAblityAgency:IsUnlockCollectTool(arg_15_1)
	return _.any(self.abilitys, function(arg_16_0)
		return IslandAblityAgency.IsCollectToolType(arg_16_0) and IslandAblityAgency.GetEffect(arg_16_0) == arg_15_1
	end)
end

function IslandAblityAgency:IsUnlockAreaPlant()
	return _.any(self.abilitys, function(arg_18_0)
		return IslandAblityAgency.GetAblityType(arg_18_0) == IslandAblityAgency.TYPE_SYSTEM and IslandAblityAgency.GetEffect(arg_18_0) == 17
	end)
end

function IslandAblityAgency:IsUnlockFishing()
	return _.any(self.abilitys, function(arg_20_0)
		return IslandAblityAgency.GetAblityType(arg_20_0) == IslandAblityAgency.TYPE_SYSTEM and IslandAblityAgency.GetEffect(arg_20_0) == 25
	end)
end

function IslandAblityAgency:HasAbility(arg_21_1)
	if arg_21_1 == 0 then
		return true
	end

	return _.any(self.abilitys, function(arg_22_0)
		return arg_21_1 == arg_22_0
	end)
end

function IslandAblityAgency:GetOrderDailyCntAddition()
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in ipairs(self.abilitys) do
		if IslandAblityAgency.IsOrderDailyCntType(iter_23_1) then
			var_23_0 = var_23_0 + pg.island_ability_template[iter_23_1].effect
		end
	end

	return var_23_0
end

function IslandAblityAgency:GetProductAdditionSpeedByAblityType(arg_24_1)
	local var_24_0 = 0

	for iter_24_0, iter_24_1 in ipairs(self.abilitys) do
		if pg.island_ability_template[iter_24_1].type == arg_24_1 then
			var_24_0 = var_24_0 + pg.island_ability_template[iter_24_1].effect
		end
	end

	return var_24_0
end

function IslandAblityAgency:GetAdditionEffectByAblityType(arg_25_1)
	local var_25_0 = 0

	for iter_25_0, iter_25_1 in ipairs(self.abilitys) do
		if pg.island_ability_template[iter_25_1].type == arg_25_1 then
			var_25_0 = var_25_0 + pg.island_ability_template[iter_25_1].effect
		end
	end

	return var_25_0
end

function IslandAblityAgency:GetSignInGiftAddition()
	local var_26_0 = 0

	for iter_26_0, iter_26_1 in ipairs(self.abilitys) do
		if IslandAblityAgency.IsSignInGiftType(iter_26_1) then
			var_26_0 = var_26_0 + pg.island_ability_template[iter_26_1].effect
		end
	end

	return var_26_0
end

function IslandAblityAgency:GetInventoryMaxCntAddition()
	local var_27_0 = 0

	for iter_27_0, iter_27_1 in ipairs(self.abilitys) do
		if IslandAblityAgency.IsInventoryMaxCntType(iter_27_1) then
			var_27_0 = var_27_0 + pg.island_ability_template[iter_27_1].effect
		end
	end

	return var_27_0
end

function IslandAblityAgency:IsInventoryMaxCntType()
	return pg.island_ability_template[self].type == IslandAblityAgency.TYPE_INVENTORY_MAXCNT
end

function IslandAblityAgency:IsSignInGiftType()
	local var_29_0 = pg.island_ability_template[self]

	assert(pg.island_ability_template[self], "island_ability_template" .. self)

	return var_29_0.type == IslandAblityAgency.TYPE_SIGN_GIFT_CNT
end

function IslandAblityAgency:IsOrderDailyCntType()
	return pg.island_ability_template[self].type == IslandAblityAgency.TYPE_ORDER_DAILY_CNT
end

function IslandAblityAgency:IsMapType()
	local var_31_0 = pg.island_ability_template[self]

	assert(pg.island_ability_template[self], "island_ability_template >>>>" .. self)

	return var_31_0.type == IslandAblityAgency.TYPE_MAP
end

function IslandAblityAgency:IsOrderType()
	return pg.island_ability_template[self].type == IslandAblityAgency.TYPE_ORDER
end

function IslandAblityAgency:IsShopTypeNormal()
	return pg.island_ability_template[self].type == IslandAblityAgency.TYPE_SHOP_NORMAL
end

function IslandAblityAgency:IsShopTypeTemporary()
	return pg.island_ability_template[self].type == IslandAblityAgency.TYPE_SHOP_TEMPORARY
end

function IslandAblityAgency:IsCommodityType()
	return pg.island_ability_template[self].type == IslandAblityAgency.TYPE_COMMODITY
end

function IslandAblityAgency:IsFormuateType()
	return pg.island_ability_template[self].type == IslandAblityAgency.TYPE_FORMULA
end

function IslandAblityAgency:IsSecondProductType()
	return pg.island_ability_template[self].type == IslandAblityAgency.TYPE_SECOND_PRODUCT
end

function IslandAblityAgency:IsCollectToolType()
	return pg.island_ability_template[self].type == IslandAblityAgency.TYPE_COLLECT_TOOL
end

function IslandAblityAgency:GetAblityType()
	return pg.island_ability_template[self].type
end

function IslandAblityAgency:GetEffect()
	return pg.island_ability_template[self].effect
end

function IslandAblityAgency:IsOrderExpType()
	return pg.island_ability_template[self].type == IslandAblityAgency.TYPE_ORDER_EXP
end

return IslandAblityAgency
