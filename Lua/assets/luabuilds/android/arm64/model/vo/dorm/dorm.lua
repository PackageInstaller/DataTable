local var_0_0 = class("Dorm", import("..BaseVO"))

var_0_0.MAX_FLOOR = 2
var_0_0.MAX_LEVEL = 4
var_0_0.DORM_2_FLOOR_COMFORTABLE_ADDITION = 20
var_0_0.COMFORTABLE_LEVEL_1 = 1
var_0_0.COMFORTABLE_LEVEL_2 = 2
var_0_0.COMFORTABLE_LEVEL_3 = 3

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.configId = arg_1_1.id or arg_1_1.lv
	arg_1_0.id = arg_1_0.configId
	arg_1_0.level = arg_1_0.id
	arg_1_0.food = arg_1_1.food or 0
	arg_1_0.food_extend_count = arg_1_1.food_max_increase_count
	arg_1_0.foodMax = arg_1_1.food_max_increase
	arg_1_0.exp_pos = arg_1_1.exp_pos or 2
	arg_1_0.rest_pos = arg_1_0.exp_pos
	arg_1_0.lastAddExpTime = arg_1_1.load_time or 0
	arg_1_0.nextAddShipExpTime = arg_1_1.next_timestamp or 0
	arg_1_0.name = arg_1_1.name
	arg_1_0.ships = {}
	arg_1_0.floorNum = arg_1_1.floor_num or 1
	arg_1_0.furnitures = {}
	arg_1_0.themes = {}
	arg_1_0.expandIds = {
		50011,
		50012,
		50013
	}
	arg_1_0.shopCfg = pg.shop_template

	return
end

function var_0_0.GetFoodMax(arg_2_0)
	return arg_2_0.foodMax
end

function var_0_0.GetExpandId(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.expandIds) do
		if arg_3_0.shopCfg[iter_3_1].limit_args[1][2] == arg_3_0.level - 1 then
			return iter_3_1
		end
	end

	return
end

function var_0_0.IsMaxLevel(arg_4_0)
	return arg_4_0.level >= var_0_0.MAX_LEVEL
end

function var_0_0.GetMapSize(arg_5_0)
	return var_0_0.StaticGetMapSize(arg_5_0.level)
end

function var_0_0.StaticGetMapSize(arg_6_0)
	return Vector4(12 - (arg_6_0 - 1) * 4, 12 - (arg_6_0 - 1) * 4, BackYardConst.MAX_MAP_SIZE.x, BackYardConst.MAX_MAP_SIZE.y)
end

function var_0_0.isUnlockFloor(arg_7_0, arg_7_1)
	return arg_7_1 <= arg_7_0.floorNum
end

function var_0_0.setFloorNum(arg_8_0, arg_8_1)
	assert(arg_8_1 <= var_0_0.MAX_FLOOR, "floornum more than max" .. arg_8_1)

	arg_8_0.floorNum = arg_8_1

	return
end

function var_0_0.setName(arg_9_0, arg_9_1)
	arg_9_0.name = arg_9_1

	return
end

function var_0_0.GetName(arg_10_0)
	return arg_10_0.name
end

function var_0_0.getExtendTrainPosShopId(arg_11_0)
	for iter_11_0, iter_11_1 in pairs({
		3,
		4,
		18,
		26
	}) do
		if pg.shop_template[iter_11_1].effect_args == ShopArgs.EffectDromExpPos and arg_11_0.exp_pos >= pg.shop_template[iter_11_1].limit_args[1][2] and arg_11_0.exp_pos <= pg.shop_template[iter_11_1].limit_args[1][3] then
			return iter_11_1
		end
	end

	return
end

function var_0_0.bindConfigTable(arg_12_0)
	return pg.dorm_data_template
end

function var_0_0.getComfortable(arg_13_0, arg_13_1)
	local var_13_0 = 0
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0.furnitures) do
		local var_13_2 = iter_13_1.count or 1

		for iter_13_2 = 1, var_13_2 do
			(function(arg_14_0)
				local var_14_0 = arg_14_0:getTypeForComfortable()

				var_13_1[var_14_0] = var_13_1[var_14_0] or {}

				table.insert(var_13_1[var_14_0], arg_14_0:getConfig("comfortable"))

				return
			end)(iter_13_1)
		end
	end

	for iter_13_3, iter_13_4 in pairs(arg_13_1 or {}) do
		(function(arg_14_0)
			local var_14_0 = arg_14_0:getTypeForComfortable()

			var_13_1[var_14_0] = var_13_1[var_14_0] or {}

			table.insert(var_13_1[var_14_0], arg_14_0:getConfig("comfortable"))

			return
		end)(iter_13_4)
	end

	for iter_13_5, iter_13_6 in pairs((arg_13_0:getConfig("comfortable_count"))) do
		local var_13_3 = ({})[iter_13_6[1]]

		if not ({})[iter_13_6[1]] then
			var_13_3 = {}
		end

		table.sort(var_13_3, function(arg_15_0, arg_15_1)
			return arg_15_1 < arg_15_0
		end)

		for iter_13_7 = 1, iter_13_6[2] do
			local var_13_4 = var_13_3[iter_13_7] or 0

			var_13_0 = var_13_0 + var_13_4
		end
	end

	local var_13_5 = var_13_0 + arg_13_0:getConfig("comfortable")

	if arg_13_0:isUnlockFloor(2) then
		var_13_5 = var_13_5 + var_0_0.DORM_2_FLOOR_COMFORTABLE_ADDITION
	end

	return var_13_5
end

function var_0_0.GetComfortableLevel(arg_16_0, arg_16_1)
	if arg_16_1 < 30 then
		return var_0_0.COMFORTABLE_LEVEL_1
	elseif arg_16_1 >= 30 and arg_16_1 < 68 then
		return var_0_0.COMFORTABLE_LEVEL_2
	else
		return var_0_0.COMFORTABLE_LEVEL_3
	end

	return
end

function var_0_0._GetComfortableLevel(arg_17_0)
	return arg_17_0:GetComfortableLevel((arg_17_0:getComfortable()))
end

function var_0_0.GetComfortableColor(arg_18_0, arg_18_1)
	return ({
		Color.New(0.9490196, 0.772549, 0.772549, 1),
		Color.New(0.9882353, 0.9333333, 0.7647059, 1),
		Color.New(0.8588235, 0.9490196, 0.772549, 1)
	})[arg_18_1]
end

function var_0_0.increaseTrainPos(arg_19_0)
	arg_19_0.exp_pos = arg_19_0.exp_pos + 1

	return
end

function var_0_0.increaseRestPos(arg_20_0)
	arg_20_0.rest_pos = arg_20_0.rest_pos + 1

	return
end

function var_0_0.increaseFoodExtendCount(arg_21_0)
	arg_21_0.food_extend_count = arg_21_0.food_extend_count + 1

	return
end

function var_0_0.extendFoodCapacity(arg_22_0, arg_22_1)
	arg_22_0.foodMax = arg_22_0.foodMax + arg_22_1

	return
end

function var_0_0.levelUp(arg_23_0)
	arg_23_0.configId = arg_23_0.configId + 1
	arg_23_0.id = arg_23_0.configId
	arg_23_0.level = arg_23_0.configId
	arg_23_0.comfortable = arg_23_0:getConfig("comfortable")

	return
end

function var_0_0.consumeFood(arg_24_0, arg_24_1)
	arg_24_0.food = math.max(arg_24_0.food - arg_24_1, 0)

	return
end

function var_0_0.isMaxFood(arg_25_0)
	return arg_25_0.food >= arg_25_0.foodMax + arg_25_0:bindConfigTable()[arg_25_0.id].capacity
end

function var_0_0.getFoodLeftTime(arg_26_0)
	local var_26_0 = arg_26_0:bindConfigTable()[arg_26_0.id]
	local var_26_1 = arg_26_0:GetFloorShipCnt(DormShip.FLOOR_1)

	if var_26_1 == 0 then
		return 0
	end

	return arg_26_0.nextAddShipExpTime + ((arg_26_0.food - arg_26_0.food % (pg.gameset["dorm_food_ratio_by_" .. var_26_1].key_value / 100 * var_26_0.consume)) / (pg.gameset["dorm_food_ratio_by_" .. var_26_1].key_value / 100 * var_26_0.consume) - 1) * var_26_0.time
end

function var_0_0.GetCapcity(arg_27_0)
	return arg_27_0:getConfig("capacity") + arg_27_0.foodMax
end

function var_0_0.IsLackOfFood(arg_28_0)
	if arg_28_0:GetFloorShipCnt(DormShip.FLOOR_1) == 0 then
		return false
	end

	local var_28_0

	if arg_28_0.food <= 0 then
		do return true end

		var_28_0 = pg.TimeMgr.GetInstance()
	end

	return arg_28_0:getFoodLeftTime() - var_28_0:GetServerTime() <= 0
end

function var_0_0.GetLastAddShipExpTime(arg_29_0)
	return arg_29_0.lastAddExpTime
end

function var_0_0.UpdateLastAddShipExpTime(arg_30_0, arg_30_1)
	arg_30_0.lastAddExpTime = arg_30_1

	return
end

function var_0_0.GetNextSettlementShipExpTime(arg_31_0)
	return arg_31_0.nextAddShipExpTime
end

function var_0_0.UpdateNextSettlementShipExpTime(arg_32_0, arg_32_1)
	local var_32_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if arg_32_1 <= var_32_0 then
		arg_32_1 = var_32_0 + 10
	end

	arg_32_0.nextAddShipExpTime = arg_32_1

	return
end

function var_0_0.ShouldRequestShipExp(arg_33_0)
	local var_33_0 = pg.TimeMgr.GetInstance():GetServerTime()

	return var_33_0 >= arg_33_0.nextAddShipExpTime, arg_33_0.nextAddShipExpTime - var_33_0
end

function var_0_0.AddInimacyAndMoney(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	arg_34_0:GetShip(arg_34_1):AddmoneyAndIntimacy(arg_34_3, arg_34_2)

	return
end

function var_0_0.SetShips(arg_35_0, arg_35_1)
	arg_35_0.ships = arg_35_1

	return
end

function var_0_0.GetShips(arg_36_0)
	return arg_36_0.ships
end

function var_0_0.GetShipIds(arg_37_0)
	return _.map(arg_37_0.ships, function(arg_38_0)
		return arg_38_0.id
	end)
end

function var_0_0.GetFloorShipCnt(arg_39_0, arg_39_1)
	local var_39_0 = 0

	for iter_39_0, iter_39_1 in ipairs(arg_39_0.ships) do
		if iter_39_1:IsSameFloor(arg_39_1) then
			var_39_0 = var_39_0 + 1
		end
	end

	return var_39_0
end

function var_0_0.InBackYard(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(arg_40_0.ships) do
		if iter_40_1:IsSame(arg_40_1) then
			return true, iter_40_1.floor
		end
	end

	return false
end

function var_0_0.AddShip(arg_41_0, arg_41_1, arg_41_2)
	table.insert(arg_41_0.ships, DormShip.New({
		id = arg_41_1,
		floor = arg_41_2
	}))

	return
end

function var_0_0.DeleteShip(arg_42_0, arg_42_1)
	for iter_42_0, iter_42_1 in ipairs(arg_42_0.ships) do
		if iter_42_1:IsSame(arg_42_1) then
			table.remove(arg_42_0.ships, iter_42_0)

			break
		end
	end

	return
end

function var_0_0.GetShip(arg_43_0, arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(arg_43_0.ships) do
		if iter_43_1:IsSame(arg_43_1) then
			return iter_43_1
		end
	end

	return nil
end

function var_0_0.GetHasMoneyOrIntimacyShips(arg_44_0)
	for iter_44_0, iter_44_1 in ipairs(arg_44_0.ships) do
		if iter_44_1:HasMoneyOrIntimacy() then
			table.insert({}, iter_44_1)
		end
	end

	return {}
end

function var_0_0.AnyShipExistIntimacyOrMoney(arg_45_0)
	return #arg_45_0:GetHasMoneyOrIntimacyShips() > 0
end

function var_0_0.GetShipsMoneyAndIntimacy(arg_46_0)
	for iter_46_0, iter_46_1 in ipairs(arg_46_0.ships) do
		({})[iter_46_1.id] = {
			iter_46_1:GetMoney(),
			(iter_46_1:GetIntimacy())
		}
	end

	return {}
end

function var_0_0.GetBayShipOnFloor(arg_47_0, arg_47_1)
	for iter_47_0, iter_47_1 in ipairs(arg_47_0.ships) do
		local var_47_0 = iter_47_1:ToBayShip()

		if iter_47_1:IsSameFloor(arg_47_1) then
			table.insert({}, var_47_0)
		end
	end

	return {}
end

function var_0_0.GetDicBayShipOnFloor(arg_48_0, arg_48_1)
	for iter_48_0, iter_48_1 in ipairs((arg_48_0:GetBayShipOnFloor(arg_48_1))) do
		({})[iter_48_1.id] = iter_48_1
	end

	return {}
end

function var_0_0.HarvestInimacyAndMoney(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0:GetShip(arg_49_1)
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

function var_0_0.GetThemeList(arg_50_0, arg_50_1)
	return arg_50_0.themes
end

function var_0_0.SetTheme(arg_51_0, arg_51_1, arg_51_2)
	arg_51_0.themes[arg_51_1] = arg_51_2

	return
end

function var_0_0.GetTheme(arg_52_0, arg_52_1)
	return arg_52_0.themes[arg_52_1]
end

function var_0_0.GetPurchasedFurnitures(arg_53_0)
	return arg_53_0.furnitures
end

function var_0_0.GetOwnFurnitureCount(arg_54_0, arg_54_1)
	if not arg_54_0.furnitures[arg_54_1] then
		return 0
	else
		return arg_54_0.furnitures[arg_54_1].count
	end

	return
end

function var_0_0.SetFurnitures(arg_55_0, arg_55_1)
	arg_55_0.furnitures = arg_55_1

	return
end

function var_0_0.AddFurniture(arg_56_0, arg_56_1)
	if not arg_56_0.furnitures[arg_56_1.id] then
		arg_56_1:MarkNew()

		arg_56_0.furnitures[arg_56_1.id] = arg_56_1
	else
		arg_56_0.furnitures[arg_56_1.id]:setCount(arg_56_0.furnitures[arg_56_1.id].count + arg_56_1.count)
	end

	return
end

function var_0_0.AddFurnitrues(arg_57_0, arg_57_1)
	for iter_57_0, iter_57_1 in ipairs(arg_57_1) do
		arg_57_0:AddFurniture((Furniture.New({
			count = 1,
			id = iter_57_1
		})))
	end

	return
end

function var_0_0.IsPurchasedFurniture(arg_58_0, arg_58_1)
	return arg_58_0.furnitures[arg_58_1] ~= nil and arg_58_0.furnitures[arg_58_1].count > 0
end

function var_0_0.HasFurniture(arg_59_0, arg_59_1)
	return arg_59_0.furnitures[arg_59_1] ~= nil
end

function var_0_0.GetFurniture(arg_60_0, arg_60_1)
	return arg_60_0.furnitures[arg_60_1]
end

function var_0_0.GetPutFurnitureList(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0:GetTheme(arg_61_1)
	local var_61_1 = var_61_0 and var_61_0:GetAllFurniture() or {}

	for iter_61_0, iter_61_1 in pairs(var_61_1) do
		table.insert({}, iter_61_1)
	end

	table.sort({}, BackyardThemeFurniture._LoadWeight)

	return {}
end

function var_0_0.ClearNewFlag(arg_62_0)
	for iter_62_0, iter_62_1 in pairs((arg_62_0:GetPurchasedFurnitures())) do
		iter_62_1:ClearNewFlag()
	end

	return
end

function var_0_0.ClearNewFlagById(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_0:GetPurchasedFurnitures()[arg_63_1]

	if var_63_0 then
		var_63_0:ClearNewFlag()
	end

	return
end

return var_0_0
