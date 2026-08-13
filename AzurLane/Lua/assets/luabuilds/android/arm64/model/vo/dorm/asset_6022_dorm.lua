class = var_0_10000

local var_0_0 = "Dorm"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

var_0_1.MAX_FLOOR = 2
var_0_1.MAX_LEVEL = 4
var_0_1.DORM_2_FLOOR_COMFORTABLE_ADDITION = 20
var_0_1.COMFORTABLE_LEVEL_1 = 1
var_0_1.COMFORTABLE_LEVEL_2 = 2
var_0_1.COMFORTABLE_LEVEL_3 = 3

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.id then
		var_1_0 = arg_1_1.lv
	end

	arg_1_0.configId = var_1_0
	arg_1_0.id = arg_1_0.configId
	arg_1_0.level = arg_1_0.id

	local var_1_1

	if not arg_1_1.food then
		var_1_1 = 0
	end

	arg_1_0.food = var_1_1
	arg_1_0.food_extend_count = arg_1_1.food_max_increase_count
	arg_1_0.foodMax = arg_1_1.food_max_increase

	local var_1_2

	if not arg_1_1.exp_pos then
		var_1_2 = 2
	end

	arg_1_0.exp_pos = var_1_2
	arg_1_0.rest_pos = arg_1_0.exp_pos

	local var_1_3

	if not arg_1_1.load_time then
		var_1_3 = 0
	end

	arg_1_0.lastAddExpTime = var_1_3

	local var_1_4

	if not arg_1_1.next_timestamp then
		var_1_4 = 0
	end

	arg_1_0.nextAddShipExpTime = var_1_4
	arg_1_0.name = arg_1_1.name
	arg_1_0.ships = {}

	local var_1_5

	if not arg_1_1.floor_num then
		var_1_5 = 1
	end

	arg_1_0.floorNum = var_1_5
	arg_1_0.furnitures = {}
	arg_1_0.themes = {}
	arg_1_0.expandIds = {
		50011,
		50012,
		50013
	}
	pg = var_2
	arg_1_0.shopCfg = var_2.shop_template

	return
end

function var_0_1.GetFoodMax(arg_2_0)
	return arg_2_0.foodMax
end

function var_0_1.GetExpandId(arg_3_0)
	local var_3_0 = arg_3_0.level - 1

	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0.expandIds) do
		if arg_3_0.shopCfg[iter_3_1].limit_args[1][2] == var_3_0 then
			return iter_3_1
		end
	end

	return
end

function var_0_1.IsMaxLevel(arg_4_0)
	return arg_4_0.level >= var_0_1.MAX_LEVEL
end

function var_0_1.GetMapSize(arg_5_0)
	return var_0_1.StaticGetMapSize(arg_5_0.level)
end

function var_0_1.StaticGetMapSize(arg_6_0)
	local var_6_0 = 12 - (arg_6_0 - 1) * 4
	local var_6_1 = var_1

	BackYardConst = var_1_10004

	local var_6_2 = var_1_10004.MAX_MAP_SIZE.x
	local var_6_3 = var_4.y

	Vector4 = var_1_10007

	return var_1_10007(var_6_0, var_6_1, var_6_2, var_6_3)
end

function var_0_1.isUnlockFloor(arg_7_0, arg_7_1)
	return arg_7_1 <= arg_7_0.floorNum
end

function var_0_1.setFloorNum(arg_8_0, arg_8_1)
	assert = var_1_10002

	var_1_10002(arg_8_1 <= var_0_1.MAX_FLOOR, "floornum more than max" .. arg_8_1)

	arg_8_0.floorNum = arg_8_1

	return
end

function var_0_1.setName(arg_9_0, arg_9_1)
	arg_9_0.name = arg_9_1

	return
end

function var_0_1.GetName(arg_10_0)
	return arg_10_0.name
end

function var_0_1.getExtendTrainPosShopId(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.shop_template

	pairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002({
		3,
		4,
		18,
		26
	}) do
		local var_11_1 = var_11_0[iter_11_1].effect_args

		ShopArgs = var_1_10008

		if var_11_1 == var_1_10008.EffectDromExpPos then
			local var_11_2 = arg_11_0.exp_pos

			if var_11_0[iter_11_1].limit_args[1][2] <= var_11_2 and arg_11_0.exp_pos <= var_11_0[iter_11_1].limit_args[1][3] then
				return iter_11_1
			end
		end
	end

	return
end

function var_0_1.bindConfigTable(arg_12_0)
	pg = var_1_10001

	return var_1_10001.dorm_data_template
end

function var_0_1.getComfortable(arg_13_0, arg_13_1)
	local var_13_0 = 0
	local var_13_1 = {}

	local function var_13_2(arg_14_0)
		local var_14_0 = arg_14_0:getTypeForComfortable()
		local var_14_1

		if not var_13_1[var_14_0] then
			var_14_1 = var_13_1
			var_14_1[var_14_0] = {}
		end

		table = var_14_1

		var_14_1.insert(var_13_1[var_14_0], arg_14_0:getConfig("comfortable"))

		return
	end

	pairs = var_1_10005

	for iter_13_0, iter_13_1 in var_1_10005(arg_13_0.furnitures) do
		local var_13_3

		if not iter_13_1.count then
			var_13_3 = 1
		end

		for iter_13_2 = 1, var_13_3 do
			var_13_2(iter_13_1)
		end
	end

	pairs = var_5

	for iter_13_3, iter_13_4 in var_5(arg_13_1 or {}) do
		var_13_2(iter_13_4)
	end

	local var_13_4 = arg_13_0:getConfig("comfortable_count")

	pairs = var_6

	for iter_13_5, iter_13_6 in var_6(var_13_4) do
		local var_13_5

		if not var_13_1[iter_13_6[1]] then
			var_13_5 = {}
		end

		table = var_1_10012

		var_1_10012.sort(var_13_5, function(arg_15_0, arg_15_1)
			return arg_15_1 < arg_15_0
		end)

		for iter_13_7 = 1, iter_13_6[2] do
			local var_13_6

			if not var_13_5[iter_13_7] then
				var_13_6 = 0
			end

			var_13_0 = var_13_0 + var_13_6
		end
	end

	local var_13_7 = var_13_0 + arg_13_0:getConfig("comfortable")

	if arg_13_0:isUnlockFloor(2) then
		var_13_7 = var_13_7 + var_0_1.DORM_2_FLOOR_COMFORTABLE_ADDITION
	end

	return var_13_7
end

function var_0_1.GetComfortableLevel(arg_16_0, arg_16_1)
	if arg_16_1 < 30 then
		return var_0_1.COMFORTABLE_LEVEL_1
	elseif arg_16_1 >= 30 and arg_16_1 < 68 then
		return var_0_1.COMFORTABLE_LEVEL_2
	else
		return var_0_1.COMFORTABLE_LEVEL_3
	end

	return
end

function var_0_1._GetComfortableLevel(arg_17_0)
	local var_17_0 = arg_17_0:getComfortable()

	return arg_17_0:GetComfortableLevel(var_17_0)
end

function var_0_1.GetComfortableColor(arg_18_0, arg_18_1)
	local var_18_0 = {}

	Color = var_1_10003
	var_18_0[1] = var_1_10003.New(0.9490196, 0.772549, 0.772549, 1)
	Color = var_3
	var_18_0[2] = var_3.New(0.9882353, 0.9333333, 0.7647059, 1)
	Color = var_3
	var_18_0[3] = var_3.New(0.8588235, 0.9490196, 0.772549, 1)

	return var_18_0[arg_18_1]
end

function var_0_1.increaseTrainPos(arg_19_0)
	arg_19_0.exp_pos = arg_19_0.exp_pos + 1

	return
end

function var_0_1.increaseRestPos(arg_20_0)
	arg_20_0.rest_pos = arg_20_0.rest_pos + 1

	return
end

function var_0_1.increaseFoodExtendCount(arg_21_0)
	arg_21_0.food_extend_count = arg_21_0.food_extend_count + 1

	return
end

function var_0_1.extendFoodCapacity(arg_22_0, arg_22_1)
	arg_22_0.foodMax = arg_22_0.foodMax + arg_22_1

	return
end

function var_0_1.levelUp(arg_23_0)
	arg_23_0.configId = arg_23_0.configId + 1
	arg_23_0.id = arg_23_0.configId
	arg_23_0.level = arg_23_0.configId
	arg_23_0.comfortable = arg_23_0:getConfig("comfortable")

	return
end

function var_0_1.consumeFood(arg_24_0, arg_24_1)
	math = var_1_10002
	arg_24_0.food = var_1_10002.max(arg_24_0.food - arg_24_1, 0)

	return
end

function var_0_1.isMaxFood(arg_25_0)
	local var_25_0 = arg_25_0:bindConfigTable()[arg_25_0.id]

	return arg_25_0.food >= arg_25_0.foodMax + var_25_0.capacity
end

function var_0_1.getFoodLeftTime(arg_26_0)
	local var_26_0 = arg_26_0
	local var_26_1 = arg_26_0.bindConfigTable(var_26_0)[arg_26_0.id]
	local var_26_2 = arg_26_0
	local var_26_3 = arg_26_0.GetFloorShipCnt

	DormShip = var_1_10005

	if var_26_3(var_26_2, var_1_10005.FLOOR_1) == 0 then
		return 0
	end

	pg = var_26_0

	local var_26_4 = var_26_0.gameset["dorm_food_ratio_by_" .. var_2].key_value / 100 * var_26_1.consume
	local var_26_5 = arg_26_0.food - arg_26_0.food % var_26_4

	return arg_26_0.nextAddShipExpTime + (var_26_5 / var_26_4 - 1) * var_26_1.time
end

function var_0_1.GetCapcity(arg_27_0)
	local var_27_0 = arg_27_0.foodMax

	return arg_27_0:getConfig("capacity") + var_27_0
end

function var_0_1.IsLackOfFood(arg_28_0)
	local var_28_0 = arg_28_0
	local var_28_1 = arg_28_0.GetFloorShipCnt

	DormShip = var_1_10004

	if var_28_1(var_28_0, var_1_10004.FLOOR_1) == 0 then
		return false
	end

	if arg_28_0.food <= 0 then
		return true
	end

	local var_28_2 = arg_28_0:getFoodLeftTime()

	pg = var_3

	local var_28_3 = var_3.TimeMgr.GetInstance()

	return var_28_2 - var_3.GetServerTime(var_28_3) <= 0
end

function var_0_1.GetLastAddShipExpTime(arg_29_0)
	return arg_29_0.lastAddExpTime
end

function var_0_1.UpdateLastAddShipExpTime(arg_30_0, arg_30_1)
	arg_30_0.lastAddExpTime = arg_30_1

	return
end

function var_0_1.GetNextSettlementShipExpTime(arg_31_0)
	return arg_31_0.nextAddShipExpTime
end

function var_0_1.UpdateNextSettlementShipExpTime(arg_32_0, arg_32_1)
	pg = var_1_10002

	local var_32_0 = var_1_10002.TimeMgr.GetInstance()

	if arg_32_1 <= var_2.GetServerTime(var_32_0) then
		arg_32_1 = var_2 + 10
	end

	arg_32_0.nextAddShipExpTime = arg_32_1

	return
end

function var_0_1.ShouldRequestShipExp(arg_33_0)
	pg = var_1_10001

	local var_33_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_33_0) >= arg_33_0.nextAddShipExpTime, arg_33_0.nextAddShipExpTime - var_1
end

function var_0_1.AddInimacyAndMoney(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = arg_34_0:GetShip(arg_34_1)

	var_4.AddmoneyAndIntimacy(var_34_0, arg_34_3, arg_34_2)

	return
end

function var_0_1.SetShips(arg_35_0, arg_35_1)
	arg_35_0.ships = arg_35_1

	return
end

function var_0_1.GetShips(arg_36_0)
	return arg_36_0.ships
end

function var_0_1.GetShipIds(arg_37_0)
	_ = var_1_10001

	return var_1_10001.map(arg_37_0.ships, function(arg_38_0)
		return arg_38_0.id
	end)
end

function var_0_1.GetFloorShipCnt(arg_39_0, arg_39_1)
	local var_39_0 = 0

	ipairs = var_1_10003

	for iter_39_0, iter_39_1 in var_1_10003(arg_39_0.ships) do
		if iter_39_1:IsSameFloor(arg_39_1) then
			var_39_0 = var_39_0 + 1
		end
	end

	return var_39_0
end

function var_0_1.InBackYard(arg_40_0, arg_40_1)
	ipairs = var_1_10002

	for iter_40_0, iter_40_1 in var_1_10002(arg_40_0.ships) do
		if iter_40_1:IsSame(arg_40_1) then
			return true, iter_40_1.floor
		end
	end

	return false
end

function var_0_1.AddShip(arg_41_0, arg_41_1, arg_41_2)
	table = var_1_10003

	local var_41_0 = var_1_10003.insert
	local var_41_1 = arg_41_0.ships

	DormShip = var_1_10006

	var_41_0(var_41_1, var_1_10006.New({
		id = arg_41_1,
		floor = arg_41_2
	}))

	return
end

function var_0_1.DeleteShip(arg_42_0, arg_42_1)
	ipairs = var_1_10002

	for iter_42_0, iter_42_1 in var_1_10002(arg_42_0.ships) do
		if iter_42_1:IsSame(arg_42_1) then
			table = var_7

			var_7.remove(arg_42_0.ships, iter_42_0)

			break
		end
	end

	return
end

function var_0_1.GetShip(arg_43_0, arg_43_1)
	ipairs = var_1_10002

	for iter_43_0, iter_43_1 in var_1_10002(arg_43_0.ships) do
		if iter_43_1:IsSame(arg_43_1) then
			return iter_43_1
		end
	end

	return nil
end

function var_0_1.GetHasMoneyOrIntimacyShips(arg_44_0)
	local var_44_0 = {}

	ipairs = var_1_10002

	for iter_44_0, iter_44_1 in var_1_10002(arg_44_0.ships) do
		if iter_44_1:HasMoneyOrIntimacy() then
			table = var_7

			var_7.insert(var_44_0, iter_44_1)
		end
	end

	return var_44_0
end

function var_0_1.AnyShipExistIntimacyOrMoney(arg_45_0)
	return #arg_45_0:GetHasMoneyOrIntimacyShips() > 0
end

function var_0_1.GetShipsMoneyAndIntimacy(arg_46_0)
	local var_46_0 = {}

	ipairs = var_1_10002

	for iter_46_0, iter_46_1 in var_1_10002(arg_46_0.ships) do
		local var_46_1 = iter_46_1:GetMoney()
		local var_46_2 = iter_46_1:GetIntimacy()

		var_46_0[iter_46_1.id] = {
			var_46_1,
			var_46_2
		}
	end

	return var_46_0
end

function var_0_1.GetBayShipOnFloor(arg_47_0, arg_47_1)
	local var_47_0 = {}

	ipairs = var_1_10003

	for iter_47_0, iter_47_1 in var_1_10003(arg_47_0.ships) do
		local var_47_1 = iter_47_1:ToBayShip()

		if iter_47_1:IsSameFloor(arg_47_1) then
			table = var_9

			var_9.insert(var_47_0, var_47_1)
		end
	end

	return var_47_0
end

function var_0_1.GetDicBayShipOnFloor(arg_48_0, arg_48_1)
	local var_48_0 = {}
	local var_48_1 = arg_48_0:GetBayShipOnFloor(arg_48_1)

	ipairs = var_1_10004

	for iter_48_0, iter_48_1 in var_1_10004(var_48_1) do
		var_48_0[iter_48_1.id] = iter_48_1
	end

	return var_48_0
end

function var_0_1.HarvestInimacyAndMoney(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0
	local var_49_1 = arg_49_0.GetShip(var_49_0, arg_49_1)
	local var_49_2 = var_2.ToBayShip(var_49_1)

	isa = var_49_0

	local var_49_3 = var_2

	DormShip = var_1_10007

	if not var_49_0(var_49_3, var_1_10007) or not var_49_2 then
		return
	end

	local var_49_4 = 0
	local var_49_5 = 0

	if var_2:HasIntimacy() then
		var_49_5 = var_2:GetIntimacy()

		local var_49_6 = var_49_2

		var_49_2.addLikability(var_49_6, var_49_5)

		getProxy = var_6
		BayProxy = var_49_6

		local var_49_7 = var_6(var_49_6)

		var_6.updateShip(var_49_7, var_49_2)
		var_2:ClearIntimacy()
	end

	local var_49_8 = var_2

	if var_2.HasMoney(var_49_8) then
		getProxy = var_6
		PlayerProxy = var_49_8

		local var_49_9 = var_6(var_49_8)
		local var_49_10 = var_6.getRawData(var_49_9)

		var_49_4 = var_2:GetMoney()

		var_49_10:addResources({
			dormMoney = var_49_4
		})

		local var_49_11 = var_2

		var_2.ClearMoney(var_49_11)

		getProxy = var_7
		PlayerProxy = var_49_11

		local var_49_12 = var_7(var_49_11)

		var_7.updatePlayer(var_49_12, var_49_10)
	end

	return var_49_4, var_49_5
end

function var_0_1.GetThemeList(arg_50_0, arg_50_1)
	return arg_50_0.themes
end

function var_0_1.SetTheme(arg_51_0, arg_51_1, arg_51_2)
	arg_51_0.themes[arg_51_1] = arg_51_2

	return
end

function var_0_1.GetTheme(arg_52_0, arg_52_1)
	return arg_52_0.themes[arg_52_1]
end

function var_0_1.GetPurchasedFurnitures(arg_53_0)
	return arg_53_0.furnitures
end

function var_0_1.GetOwnFurnitureCount(arg_54_0, arg_54_1)
	if not arg_54_0.furnitures[arg_54_1] then
		return 0
	else
		return var_2.count
	end

	return
end

function var_0_1.SetFurnitures(arg_55_0, arg_55_1)
	arg_55_0.furnitures = arg_55_1

	return
end

function var_0_1.AddFurniture(arg_56_0, arg_56_1)
	if not arg_56_0.furnitures[arg_56_1.id] then
		arg_56_1:MarkNew()

		arg_56_0.furnitures[arg_56_1.id] = arg_56_1
	else
		local var_56_0 = arg_56_0.furnitures[arg_56_1.id]

		var_2.setCount(var_56_0, var_2.count + arg_56_1.count)
	end

	return
end

function var_0_1.AddFurnitrues(arg_57_0, arg_57_1)
	ipairs = var_1_10002

	for iter_57_0, iter_57_1 in var_1_10002(arg_57_1) do
		Furniture = var_1_10007
		var_1_10007 = var_1_10007.New({
			count = 1,
			id = iter_57_1
		})

		arg_57_0:AddFurniture(var_1_10007)
	end

	return
end

function var_0_1.IsPurchasedFurniture(arg_58_0, arg_58_1)
	return arg_58_0.furnitures[arg_58_1] ~= nil and arg_58_0.furnitures[arg_58_1].count > 0
end

function var_0_1.HasFurniture(arg_59_0, arg_59_1)
	return arg_59_0.furnitures[arg_59_1] ~= nil
end

function var_0_1.GetFurniture(arg_60_0, arg_60_1)
	return arg_60_0.furnitures[arg_60_1]
end

function var_0_1.GetPutFurnitureList(arg_61_0, arg_61_1)
	local var_61_0 = {}
	local var_61_1 = arg_61_0
	local var_61_2

	if not arg_61_0.GetTheme(var_61_1, arg_61_1) or not var_3:GetAllFurniture() then
		var_61_2 = {}
	end

	pairs = var_61_1

	for iter_61_0, iter_61_1 in var_61_1(var_61_2) do
		table = var_1_10010

		var_1_10010.insert(var_61_0, iter_61_1)
	end

	table = var_5

	local var_61_3 = var_5.sort
	local var_61_4 = var_61_0

	BackyardThemeFurniture = iter_61_0

	var_61_3(var_61_4, iter_61_0._LoadWeight)

	return var_61_0
end

function var_0_1.ClearNewFlag(arg_62_0)
	local var_62_0 = arg_62_0:GetPurchasedFurnitures()

	pairs = var_1_10002

	for iter_62_0, iter_62_1 in var_1_10002(var_62_0) do
		iter_62_1:ClearNewFlag()
	end

	return
end

function var_0_1.ClearNewFlagById(arg_63_0, arg_63_1)
	if arg_63_0:GetPurchasedFurnitures()[arg_63_1] then
		var_3:ClearNewFlag()
	end

	return
end

return var_0_1
