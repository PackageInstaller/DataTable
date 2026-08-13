class = var_0_10000

local var_0_0 = "MallActivity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.Activity"))

var_0_1.POINT_TYPE = {
	SITE = 1,
	BRANCH_STORY = 3,
	MAIN_STORY = 2,
	INTERACT_STORY = 4
}
var_0_1.MAX_GOLD = 999999999

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.gold = arg_1_1.mall.gold
	arg_1_0.round = var_2.round
	arg_1_0.triggeredPointIds = var_2.story_list
	MallLevel = var_3
	arg_1_0.levelData = var_3.New(var_2.level)
	MallOrder = var_3
	arg_1_0.orderData = var_3.New(var_2.order)
	arg_1_0.lastBalance = var_2.last_round.balance
	arg_1_0.lastIncome = 0

	local var_1_0 = var_2.last_round.floor_income
	local var_1_1 = {}
	local var_1_2 = {}

	ipairs = var_1_10006

	for iter_1_0, iter_1_1 in var_1_10006(var_2.floor_list) do
		var_1_1[iter_1_1.id] = iter_1_1

		local var_1_3 = iter_1_1.id

		if not var_1_0[iter_1_1.id] then
			var_1_10012 = 0
		end

		var_1_2[var_1_3] = var_1_10012
		arg_1_0.lastIncome = arg_1_0.lastIncome + var_1_2[iter_1_1.id]
	end

	arg_1_0.floorData = {}
	ipairs = var_6
	pg = var_8

	for iter_1_2, iter_1_3 in var_6(var_8.activity_mall_template.all) do
		local var_1_4 = var_1_1[iter_1_3]

		MallFloor = var_1_10012

		local var_1_5 = var_1_10012.New(var_1_4 or {
			id = iter_1_3
		}, var_1_4 ~= nil)

		var_1_10012.CheckUnlock(var_1_5, arg_1_0.levelData.level)
		var_1_10012:SetLastIncome(var_1_2[iter_1_3])

		var_1_10013 = arg_1_0.floorData
		var_1_10013[iter_1_3] = var_1_10012
	end

	arg_1_0.lastFloorStaffList = arg_1_0:GetFloorStaffList()
	arg_1_0.staffData = {}
	ipairs = var_6

	for iter_1_4, iter_1_5 in var_6(var_2.employee_list) do
		local var_1_6 = arg_1_0.staffData
		local var_1_7 = iter_1_5.id

		MallStaff = var_1_10013
		var_1_6[var_1_7] = var_1_10013.New(iter_1_5)
	end

	arg_1_0:InitStaffStatus()

	return
end

function var_0_1.GetGold(arg_2_0)
	return arg_2_0.gold
end

function var_0_1.AddGold(arg_3_0, arg_3_1)
	arg_3_0.gold = arg_3_0.gold + arg_3_1
	math = var_2
	arg_3_0.gold = var_2.min(arg_3_0.gold, var_0_1.MAX_GOLD)

	return
end

function var_0_1.ReduceGold(arg_4_0, arg_4_1)
	arg_4_0.gold = arg_4_0.gold - arg_4_1

	return
end

function var_0_1.IsGoldDrop(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.type

	DROP_TYPE_VITEM = var_1_10003

	return var_5_0 == var_1_10003 and arg_5_1.id == arg_5_0:getConfig("config_data")[1]
end

function var_0_1.GetRound(arg_6_0)
	return arg_6_0.round
end

function var_0_1.GetLastIncome(arg_7_0)
	return arg_7_0.lastIncome
end

function var_0_1.GetLastBalance(arg_8_0)
	return arg_8_0.lastBalance
end

function var_0_1.NextRound(arg_9_0, arg_9_1)
	arg_9_0.round = arg_9_0.round + 1

	local var_9_0 = 0

	ipairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(arg_9_1) do
		if iter_9_0 ~= 1 then
			local var_9_1 = iter_9_0 - 1
			local var_9_2 = arg_9_0.floorData[var_9_1]

			var_9.SetLastIncome(var_9_2, iter_9_1)

			var_9_0 = var_9_0 + iter_9_1
		end
	end

	arg_9_0.lastIncome = var_9_0
	math = var_3
	arg_9_0.lastBalance = var_3.min(arg_9_0.gold + var_9_0, var_0_1.MAX_GOLD)

	return
end

function var_0_1.GetLevelData(arg_10_0)
	return arg_10_0.levelData
end

function var_0_1.OnUpgradeDone(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.levelData

	var_2.OnUpgradeDone(var_11_0, arg_11_1)

	pairs = var_2

	for iter_11_0, iter_11_1 in var_2(arg_11_0.floorData) do
		iter_11_1:CheckUnlock(arg_11_1)
	end

	arg_11_0.lastFloorStaffList = arg_11_0:GetFloorStaffList()

	return
end

function var_0_1.GetTriggeredPointIds(arg_12_0)
	return arg_12_0.triggeredPointIds
end

function var_0_1.OnTriggerPointDone(arg_13_0, arg_13_1)
	table = var_1_10002

	var_1_10002.insert(arg_13_0.triggeredPointIds, arg_13_1)

	return
end

function var_0_1.GetStaffData(arg_14_0)
	return arg_14_0.staffData
end

function var_0_1.GetStaffList(arg_15_0)
	underscore = var_1_10001

	local var_15_0 = var_1_10001.values(arg_15_0.staffData)

	table = var_1_10002

	local var_15_1 = var_1_10002.sort
	local var_15_2 = var_15_0

	CompareFuncs = var_1_10005

	var_15_1(var_15_2, var_1_10005({
		function(arg_16_0)
			local var_16_0 = arg_16_0:GetStatusInfos()

			MallStaff = var_2_10002

			return var_16_0 == var_2_10002.STATUS.ORDER and 1 or 0
		end,
		function(arg_17_0)
			return arg_17_0.id
		end
	}))

	return var_15_0
end

function var_0_1.AddStaff(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.staffData

	MallStaff = var_1_10004
	var_18_0[arg_18_2] = var_1_10004.New({
		tid = arg_18_1,
		id = arg_18_2
	})

	return
end

function var_0_1.GetStaff(arg_19_0, arg_19_1)
	return arg_19_0.staffData[arg_19_1]
end

function var_0_1.InitStaffStatus(arg_20_0)
	ipairs = var_1_10001

	local var_20_0 = arg_20_0.orderData

	for iter_20_0, iter_20_1 in var_1_10001(var_3.GetStaffList(var_20_0)) do
		local var_20_1 = arg_20_0.staffData[iter_20_1]

		var_1_10006 = var_1_10006.SetStatus
		MallStaff = var_1_10009

		var_1_10006(var_20_1, var_1_10009.STATUS.ORDER, {
			orderId = arg_20_0.orderData.id
		})
	end

	pairs = var_1

	for iter_20_2, iter_20_3 in var_1(arg_20_0.floorData) do
		ipairs = var_1_10006

		for iter_20_4, iter_20_5 in var_1_10006(iter_20_3:GetStaffList()) do
			if iter_20_5 ~= 0 then
				local var_20_2 = arg_20_0.staffData[iter_20_5]
				local var_20_3 = var_11.SetStatus

				MallStaff = var_1_10014

				var_20_3(var_20_2, var_1_10014.STATUS.FLOOR, {
					floorId = iter_20_3.id,
					floorIdx = iter_20_4
				})
			end
		end
	end

	return
end

function var_0_1.SetStaffExtraData(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.staffData[arg_21_1]

	var_3.SetExtraData(var_21_0, arg_21_2)

	return
end

function var_0_1.GetOrderData(arg_22_0)
	return arg_22_0.orderData
end

function var_0_1.OnStartOrderDone(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_0.orderData

	var_4.StartOrder(var_23_0, arg_23_1, arg_23_2, arg_23_3)

	ipairs = var_4

	for iter_23_0, iter_23_1 in var_4(arg_23_3) do
		local var_23_1 = arg_23_0.staffData[iter_23_1]
		local var_23_2 = var_9.SetStatus

		MallStaff = var_1_10012

		var_23_2(var_23_1, var_1_10012.STATUS.ORDER, {
			orderId = iter_23_1
		})
	end

	local var_23_3 = arg_23_0
	local var_23_4 = arg_23_0.ReduceGold

	MallOrder = iter_23_0

	var_23_4(var_23_3, iter_23_0.GetCostGold(arg_23_1))

	return
end

function var_0_1.OnCompleteOrderDone(arg_24_0, arg_24_1)
	ipairs = var_1_10002

	local var_24_0 = arg_24_0.orderData

	for iter_24_0, iter_24_1 in var_1_10002(var_4.GetStaffList(var_24_0)) do
		local var_24_1 = arg_24_0.staffData[iter_24_1]
		local var_24_2 = var_7.SetStatus

		MallStaff = var_1_10010

		var_24_2(var_24_1, var_1_10010.STATUS.NORMAL, {})
	end

	local var_24_3 = arg_24_0.orderData

	var_2.CompleteOrder(var_24_3, arg_24_1)

	return
end

function var_0_1.GetFloorStaffList(arg_25_0)
	local var_25_0 = {}

	pairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_0.floorData) do
		if iter_25_1:IsUnlock() then
			ipairs = var_7

			for iter_25_2, iter_25_3 in var_7(iter_25_1:GetStaffList()) do
				table = var_1_10012

				var_1_10012.insert(var_25_0, iter_25_3)
			end
		end
	end

	return var_25_0
end

function var_0_1.GetFloorData(arg_26_0)
	return arg_26_0.floorData
end

function var_0_1.GetFloor(arg_27_0, arg_27_1)
	return arg_27_0.floorData[arg_27_1]
end

function var_0_1.GetFloorList(arg_28_0)
	underscore = var_1_10001

	local var_28_0 = var_1_10001.values(arg_28_0.floorData)

	table = var_1_10002

	local var_28_1 = var_1_10002.sort
	local var_28_2 = var_28_0

	CompareFuncs = var_1_10005

	var_28_1(var_28_2, var_1_10005({
		function(arg_29_0)
			return -arg_29_0.id
		end
	}))

	return var_28_0
end

function var_0_1.GetFloorListAsc(arg_30_0)
	underscore = var_1_10001

	local var_30_0 = var_1_10001.values(arg_30_0.floorData)

	table = var_1_10002

	local var_30_1 = var_1_10002.sort
	local var_30_2 = var_30_0

	CompareFuncs = var_1_10005

	var_30_1(var_30_2, var_1_10005({
		function(arg_31_0)
			return arg_31_0.id
		end
	}))

	return var_30_0
end

function var_0_1.NeedUpdateFloorStaff(arg_32_0)
	if #arg_32_0:GetFloorStaffList() ~= #arg_32_0.lastFloorStaffList then
		return true
	end

	ipairs = var_2

	for iter_32_0, iter_32_1 in var_2(var_1) do
		if iter_32_1 ~= arg_32_0.lastFloorStaffList[iter_32_0] then
			return true
		end
	end

	return false
end

function var_0_1.OnUpdateFloorStaffDone(arg_33_0, arg_33_1)
	arg_33_0.lastFloorStaffList = arg_33_1

	return
end

function var_0_1.SetFloorStaff(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	arg_34_0:_RemoveFloorStaff(arg_34_1, arg_34_2)

	if arg_34_3 ~= 0 then
		arg_34_0:_AddFloorStaff(arg_34_1, arg_34_2, arg_34_3)
	else
		local var_34_0 = arg_34_0.floorData[arg_34_1]
		local var_34_1 = var_4.GetStaffList(var_34_0)
		local var_34_2 = {}

		if arg_34_2 ~= #var_34_1 then
			for iter_34_0 = arg_34_2 + 1, #var_34_1 do
				if var_34_1[iter_34_0] ~= 0 then
					table = var_10

					var_10.insert(var_34_2, var_34_1[iter_34_0])
				end

				arg_34_0:_RemoveFloorStaff(arg_34_1, iter_34_0)
			end

			ipairs = var_6

			for iter_34_1, iter_34_2 in var_6(var_34_2) do
				arg_34_0:_AddFloorStaff(arg_34_1, arg_34_2 - 1 + iter_34_1, iter_34_2)
			end
		end
	end

	return
end

function var_0_1._RemoveFloorStaff(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0.floorData[arg_35_1]

	if var_3.GetStaffList(var_35_0)[arg_35_2] == 0 then
		return
	end

	local var_35_1 = arg_35_0.floorData[arg_35_1]

	var_5.SetStaff(var_35_1, arg_35_2, 0)

	local var_35_2 = arg_35_0.staffData[var_4]
	local var_35_3 = var_5.SetStatus

	MallStaff = var_8

	var_35_3(var_35_2, var_8.STATUS.NORMAL, {})

	return
end

function var_0_1._AddFloorStaff(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = arg_36_0.floorData[arg_36_1]
	local var_36_1 = var_4.GetStaffList(var_36_0)[arg_36_2]

	assert = var_1_10005

	local var_36_2 = var_36_1 == 0

	string = var_1_10008

	var_1_10005(var_36_2, var_1_10008.format("%d楼的第%d个位置已有员工%d, 请先移除！", arg_36_1, arg_36_2, arg_36_3))

	local var_36_3 = arg_36_0.staffData[arg_36_3]
	local var_36_4, var_36_5 = var_5.GetStatusInfos(var_36_3)

	assert = var_36_3
	MallStaff = var_1_10009

	local var_36_6 = var_36_4 == var_1_10009.STATUS.NORMAL

	string = var_10

	var_36_3(var_36_6, var_10.format("员工%d处于被占用状态！(%d)", arg_36_3, var_36_4))

	local var_36_7 = arg_36_0.floorData[arg_36_1]

	var_7.SetStaff(var_36_7, arg_36_2, arg_36_3)

	local var_36_8 = arg_36_0.staffData[arg_36_3]
	local var_36_9 = var_7.SetStatus

	MallStaff = var_10

	var_36_9(var_36_8, var_10.STATUS.FLOOR, {
		floorId = arg_36_1,
		floorIdx = arg_36_2
	})

	return
end

function var_0_1.IsStaffDrop(arg_37_0)
	local var_37_0 = arg_37_0.type

	DROP_TYPE_VITEM = var_1_10002

	if var_37_0 ~= var_1_10002 then
		return false
	end

	local var_37_1 = arg_37_0

	if arg_37_0.getConfig(var_37_1, "virtual_type") ~= 103 then
		return false
	end

	getProxy = var_1
	ActivityProxy = var_37_1

	local var_37_2 = var_1(var_37_1)
	local var_37_3 = var_1.getActivityByType

	ActivityConst = var_4

	if not var_37_3(var_37_2, var_4.ACTIVITY_TYPE_MALL) then
		return false
	end

	if arg_37_0:getConfig("link_id") ~= var_1.id then
		return false
	end

	return arg_37_0.id ~= var_1:getConfig("config_data")[1]
end

return var_0_1
