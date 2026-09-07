local Dorm = class("Dorm", import("..BaseVO"))

Dorm.MAX_FLOOR = 2
Dorm.MAX_LEVEL = 4
Dorm.DORM_2_FLOOR_COMFORTABLE_ADDITION = 20
Dorm.COMFORTABLE_LEVEL_1 = 1
Dorm.COMFORTABLE_LEVEL_2 = 2
Dorm.COMFORTABLE_LEVEL_3 = 3

function Dorm:Ctor(arg_1_1)
	self.configId = arg_1_1.id or arg_1_1.lv
	self.id = self.configId
	self.level = self.id
	self.food = arg_1_1.food or 0
	self.food_extend_count = arg_1_1.food_max_increase_count
	self.foodMax = arg_1_1.food_max_increase
	self.exp_pos = arg_1_1.exp_pos or 2
	self.rest_pos = self.exp_pos
	self.lastAddExpTime = arg_1_1.load_time or 0
	self.nextAddShipExpTime = arg_1_1.next_timestamp or 0
	self.name = arg_1_1.name
	self.ships = {}
	self.floorNum = arg_1_1.floor_num or 1
	self.furnitures = {}
	self.themes = {}
	self.expandIds = {
		50011,
		50012,
		50013
	}
	self.shopCfg = pg.shop_template

	return
end

function Dorm:GetFoodMax()
	return self.foodMax
end

function Dorm:GetExpandId()
	for iter_3_0, iter_3_1 in ipairs(self.expandIds) do
		if self.shopCfg[iter_3_1].limit_args[1][2] == self.level - 1 then
			return iter_3_1
		end
	end

	return
end

function Dorm:IsMaxLevel()
	return self.level >= Dorm.MAX_LEVEL
end

function Dorm:GetMapSize()
	return Dorm.StaticGetMapSize(self.level)
end

function Dorm:StaticGetMapSize()
	return Vector4(12 - (self - 1) * 4, 12 - (self - 1) * 4, BackYardConst.MAX_MAP_SIZE.x, BackYardConst.MAX_MAP_SIZE.y)
end

function Dorm:isUnlockFloor(arg_7_1)
	return arg_7_1 <= self.floorNum
end

function Dorm:setFloorNum(arg_8_1)
	assert(arg_8_1 <= Dorm.MAX_FLOOR, "floornum more than max" .. arg_8_1)

	self.floorNum = arg_8_1

	return
end

function Dorm:setName(arg_9_1)
	self.name = arg_9_1

	return
end

function Dorm:GetName()
	return self.name
end

function Dorm:getExtendTrainPosShopId()
	for iter_11_0, iter_11_1 in pairs({
		3,
		4,
		18,
		26
	}) do
		if pg.shop_template[iter_11_1].effect_args == ShopArgs.EffectDromExpPos and self.exp_pos >= pg.shop_template[iter_11_1].limit_args[1][2] and self.exp_pos <= pg.shop_template[iter_11_1].limit_args[1][3] then
			return iter_11_1
		end
	end

	return
end

function Dorm:bindConfigTable()
	return pg.dorm_data_template
end

function Dorm:getComfortable(arg_13_1)
	local var_13_0 = 0
	local var_13_1 = {}

	local function var_13_2(arg_14_0)
		local var_14_0 = arg_14_0:getTypeForComfortable()

		var_13_1[var_14_0] = var_13_1[var_14_0] or {}

		table.insert(var_13_1[var_14_0], arg_14_0:getConfig("comfortable"))

		return
	end

	for iter_13_0, iter_13_1 in pairs(self.furnitures) do
		for iter_13_2 = 1, iter_13_1.count or 1 do
			var_13_2(iter_13_1)
		end
	end

	for iter_13_3, iter_13_4 in pairs(arg_13_1 or {}) do
		var_13_2(iter_13_4)
	end

	for iter_13_5, iter_13_6 in pairs((self:getConfig("comfortable_count"))) do
		local var_13_4 = var_13_1[iter_13_6[1]] or {}

		table.sort(var_13_4, function(arg_15_0, arg_15_1)
			return arg_15_1 < arg_15_0
		end)

		for iter_13_7 = 1, iter_13_6[2] do
			var_13_0 = var_13_0 + (var_13_4[iter_13_7] or 0)
		end
	end

	local var_13_6 = var_13_0 + self:getConfig("comfortable")

	if self:isUnlockFloor(2) then
		var_13_6 = var_13_6 + Dorm.DORM_2_FLOOR_COMFORTABLE_ADDITION
	end

	return var_13_6
end

function Dorm:GetComfortableLevel(arg_16_1)
	if arg_16_1 < 30 then
		return Dorm.COMFORTABLE_LEVEL_1
	elseif arg_16_1 >= 30 and arg_16_1 < 68 then
		return Dorm.COMFORTABLE_LEVEL_2
	else
		return Dorm.COMFORTABLE_LEVEL_3
	end

	return
end

function Dorm:_GetComfortableLevel()
	return self:GetComfortableLevel((self:getComfortable()))
end

function Dorm:GetComfortableColor(arg_18_1)
	return ({
		Color.New(0.9490196, 0.772549, 0.772549, 1),
		Color.New(0.9882353, 0.9333333, 0.7647059, 1),
		Color.New(0.8588235, 0.9490196, 0.772549, 1)
	})[arg_18_1]
end

function Dorm:increaseTrainPos()
	self.exp_pos = self.exp_pos + 1

	return
end

function Dorm:increaseRestPos()
	self.rest_pos = self.rest_pos + 1

	return
end

function Dorm:increaseFoodExtendCount()
	self.food_extend_count = self.food_extend_count + 1

	return
end

function Dorm:extendFoodCapacity(arg_22_1)
	self.foodMax = self.foodMax + arg_22_1

	return
end

function Dorm:levelUp()
	self.configId = self.configId + 1
	self.id = self.configId
	self.level = self.configId
	self.comfortable = self:getConfig("comfortable")

	return
end

function Dorm:consumeFood(arg_24_1)
	self.food = math.max(self.food - arg_24_1, 0)

	return
end

function Dorm:isMaxFood()
	return self.food >= self.foodMax + self:bindConfigTable()[self.id].capacity
end

function Dorm:getFoodLeftTime()
	local var_26_0 = self:bindConfigTable()[self.id]
	local var_26_1 = self:GetFloorShipCnt(DormShip.FLOOR_1)

	if var_26_1 == 0 then
		return 0
	end

	return self.nextAddShipExpTime + ((self.food - self.food % (pg.gameset["dorm_food_ratio_by_" .. var_26_1].key_value / 100 * var_26_0.consume)) / (pg.gameset["dorm_food_ratio_by_" .. var_26_1].key_value / 100 * var_26_0.consume) - 1) * var_26_0.time
end

function Dorm:GetCapcity()
	return self:getConfig("capacity") + self.foodMax
end

function Dorm:IsLackOfFood()
	if self:GetFloorShipCnt(DormShip.FLOOR_1) == 0 then
		return false
	end

	local var_28_0

	if self.food <= 0 then
		do return true end

		var_28_0 = pg.TimeMgr.GetInstance()
	end

	return self:getFoodLeftTime() - var_28_0:GetServerTime() <= 0
end

function Dorm:GetLastAddShipExpTime()
	return self.lastAddExpTime
end

function Dorm:UpdateLastAddShipExpTime(arg_30_1)
	self.lastAddExpTime = arg_30_1

	return
end

function Dorm:GetNextSettlementShipExpTime()
	return self.nextAddShipExpTime
end

function Dorm:UpdateNextSettlementShipExpTime(arg_32_1)
	local var_32_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if arg_32_1 <= var_32_0 then
		arg_32_1 = var_32_0 + 10
	end

	self.nextAddShipExpTime = arg_32_1

	return
end

function Dorm:ShouldRequestShipExp()
	local var_33_0 = pg.TimeMgr.GetInstance():GetServerTime()

	return var_33_0 >= self.nextAddShipExpTime, self.nextAddShipExpTime - var_33_0
end

function Dorm:AddInimacyAndMoney(arg_34_1, arg_34_2, arg_34_3)
	self:GetShip(arg_34_1):AddmoneyAndIntimacy(arg_34_3, arg_34_2)

	return
end

function Dorm:SetShips(arg_35_1)
	self.ships = arg_35_1

	return
end

function Dorm:GetShips()
	return self.ships
end

function Dorm:GetShipIds()
	return _.map(self.ships, function(arg_38_0)
		return arg_38_0.id
	end)
end

function Dorm:GetFloorShipCnt(arg_39_1)
	local var_39_0 = 0

	for iter_39_0, iter_39_1 in ipairs(self.ships) do
		if iter_39_1:IsSameFloor(arg_39_1) then
			var_39_0 = var_39_0 + 1
		end
	end

	return var_39_0
end

function Dorm:InBackYard(arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(self.ships) do
		if iter_40_1:IsSame(arg_40_1) then
			return true, iter_40_1.floor
		end
	end

	return false
end

function Dorm:AddShip(arg_41_1, arg_41_2)
	table.insert(self.ships, DormShip.New({
		id = arg_41_1,
		floor = arg_41_2
	}))

	return
end

function Dorm:DeleteShip(arg_42_1)
	for iter_42_0, iter_42_1 in ipairs(self.ships) do
		if iter_42_1:IsSame(arg_42_1) then
			table.remove(self.ships, iter_42_0)

			break
		end
	end

	return
end

function Dorm:GetShip(arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(self.ships) do
		if iter_43_1:IsSame(arg_43_1) then
			return iter_43_1
		end
	end

	return nil
end

function Dorm:GetHasMoneyOrIntimacyShips()
	local var_44_0 = {}

	for iter_44_0, iter_44_1 in ipairs(self.ships) do
		if iter_44_1:HasMoneyOrIntimacy() then
			table.insert(var_44_0, iter_44_1)
		end
	end

	return var_44_0
end

function Dorm:AnyShipExistIntimacyOrMoney()
	return #self:GetHasMoneyOrIntimacyShips() > 0
end

function Dorm:GetShipsMoneyAndIntimacy()
	local var_46_0 = {}

	for iter_46_0, iter_46_1 in ipairs(self.ships) do
		var_46_0[iter_46_1.id] = {
			iter_46_1:GetMoney(),
			(iter_46_1:GetIntimacy())
		}
	end

	return var_46_0
end

function Dorm:GetBayShipOnFloor(arg_47_1)
	local var_47_0 = {}

	for iter_47_0, iter_47_1 in ipairs(self.ships) do
		if iter_47_1:IsSameFloor(arg_47_1) then
			table.insert(var_47_0, (iter_47_1:ToBayShip()))
		end
	end

	return var_47_0
end

function Dorm:GetDicBayShipOnFloor(arg_48_1)
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in ipairs((self:GetBayShipOnFloor(arg_48_1))) do
		var_48_0[iter_48_1.id] = iter_48_1
	end

	return var_48_0
end

function Dorm:HarvestInimacyAndMoney(arg_49_1)
	local var_49_0 = self:GetShip(arg_49_1)
	local var_49_1 = var_49_0:ToBayShip()

	if not isa(var_49_0, DormShip) or not var_49_1 then
		return
	end

	local var_49_2 = 0
	local var_49_3 = 0

	if var_49_0:HasIntimacy() then
		var_49_3 = var_49_0:GetIntimacy()

		var_49_1:addLikability(var_49_3)
		getProxy(BayProxy):updateShip(var_49_1)
		var_49_0:ClearIntimacy()
	end

	if var_49_0:HasMoney() then
		local var_49_4 = getProxy(PlayerProxy):getRawData()

		var_49_2 = var_49_0:GetMoney()

		var_49_4:addResources({
			dormMoney = var_49_2
		})
		var_49_0:ClearMoney()
		getProxy(PlayerProxy):updatePlayer(var_49_4)
	end

	return var_49_2, var_49_3
end

function Dorm:GetThemeList(arg_50_1)
	return self.themes
end

function Dorm:SetTheme(arg_51_1, arg_51_2)
	self.themes[arg_51_1] = arg_51_2

	return
end

function Dorm:GetTheme(arg_52_1)
	return self.themes[arg_52_1]
end

function Dorm:GetPurchasedFurnitures()
	return self.furnitures
end

function Dorm:GetOwnFurnitureCount(arg_54_1)
	if not self.furnitures[arg_54_1] then
		return 0
	else
		return self.furnitures[arg_54_1].count
	end

	return
end

function Dorm:SetFurnitures(arg_55_1)
	self.furnitures = arg_55_1

	return
end

function Dorm:AddFurniture(arg_56_1)
	if not self.furnitures[arg_56_1.id] then
		arg_56_1:MarkNew()

		self.furnitures[arg_56_1.id] = arg_56_1
	else
		self.furnitures[arg_56_1.id]:setCount(self.furnitures[arg_56_1.id].count + arg_56_1.count)
	end

	return
end

function Dorm:AddFurnitrues(arg_57_1)
	for iter_57_0, iter_57_1 in ipairs(arg_57_1) do
		self:AddFurniture((Furniture.New({
			count = 1,
			id = iter_57_1
		})))
	end

	return
end

function Dorm:IsPurchasedFurniture(arg_58_1)
	return self.furnitures[arg_58_1] ~= nil and self.furnitures[arg_58_1].count > 0
end

function Dorm:HasFurniture(arg_59_1)
	return self.furnitures[arg_59_1] ~= nil
end

function Dorm:GetFurniture(arg_60_1)
	return self.furnitures[arg_60_1]
end

function Dorm:GetPutFurnitureList(arg_61_1)
	local var_61_0 = {}
	local var_61_1 = self:GetTheme(arg_61_1)

	for iter_61_0, iter_61_1 in pairs(var_61_1 and var_61_1:GetAllFurniture() or {}) do
		table.insert(var_61_0, iter_61_1)
	end

	table.sort(var_61_0, BackyardThemeFurniture._LoadWeight)

	return var_61_0
end

function Dorm:ClearNewFlag()
	for iter_62_0, iter_62_1 in pairs((self:GetPurchasedFurnitures())) do
		iter_62_1:ClearNewFlag()
	end

	return
end

function Dorm:ClearNewFlagById(arg_63_1)
	local var_63_0 = self:GetPurchasedFurnitures()[arg_63_1]

	if var_63_0 then
		var_63_0:ClearNewFlag()
	end

	return
end

return Dorm
