local var_0_0 = class("MallActivity", import("model.vo.Activity"))

var_0_0.POINT_TYPE = {
	SITE = 1,
	BRANCH_STORY = 3,
	MAIN_STORY = 2,
	INTERACT_STORY = 4
}
var_0_0.MAX_GOLD = 999999999

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.gold = arg_1_1.mall.gold
	arg_1_0.round = arg_1_1.mall.round
	arg_1_0.triggeredPointIds = arg_1_1.mall.story_list
	arg_1_0.levelData = MallLevel.New(arg_1_1.mall.level)
	arg_1_0.orderData = MallOrder.New(arg_1_1.mall.order)
	arg_1_0.lastBalance = arg_1_1.mall.last_round.balance
	arg_1_0.lastIncome = 0

	local var_1_0 = {}
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.mall.floor_list) do
		var_1_0[iter_1_1.id] = iter_1_1
		var_1_1[iter_1_1.id] = arg_1_1.mall.last_round.floor_income[iter_1_1.id] or 0
		arg_1_0.lastIncome = arg_1_0.lastIncome + var_1_1[iter_1_1.id]
	end

	arg_1_0.floorData = {}

	for iter_1_2, iter_1_3 in ipairs(pg.activity_mall_template.all) do
		local var_1_2 = MallFloor.New(var_1_0[iter_1_3] or {
			id = iter_1_3
		}, var_1_0[iter_1_3] ~= nil)

		var_1_2:CheckUnlock(arg_1_0.levelData.level)
		var_1_2:SetLastIncome(var_1_1[iter_1_3])

		arg_1_0.floorData[iter_1_3] = var_1_2
	end

	arg_1_0.lastFloorStaffList = arg_1_0:GetFloorStaffList()
	arg_1_0.staffData = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.mall.employee_list) do
		arg_1_0.staffData[iter_1_5.id] = MallStaff.New(iter_1_5)
	end

	arg_1_0:InitStaffStatus()

	return
end

function var_0_0.GetGold(arg_2_0)
	return arg_2_0.gold
end

function var_0_0.AddGold(arg_3_0, arg_3_1)
	arg_3_0.gold = arg_3_0.gold + arg_3_1
	arg_3_0.gold = math.min(arg_3_0.gold, var_0_0.MAX_GOLD)

	return
end

function var_0_0.ReduceGold(arg_4_0, arg_4_1)
	arg_4_0.gold = arg_4_0.gold - arg_4_1

	return
end

function var_0_0.IsGoldDrop(arg_5_0, arg_5_1)
	return arg_5_1.type == DROP_TYPE_VITEM and arg_5_1.id == arg_5_0:getConfig("config_data")[1]
end

function var_0_0.GetRound(arg_6_0)
	return arg_6_0.round
end

function var_0_0.GetLastIncome(arg_7_0)
	return arg_7_0.lastIncome
end

function var_0_0.GetLastBalance(arg_8_0)
	return arg_8_0.lastBalance
end

function var_0_0.NextRound(arg_9_0, arg_9_1)
	arg_9_0.round = arg_9_0.round + 1

	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if iter_9_0 ~= 1 then
			arg_9_0.floorData[iter_9_0 - 1]:SetLastIncome(iter_9_1)

			var_9_0 = var_9_0 + iter_9_1
		end
	end

	arg_9_0.lastIncome = var_9_0
	arg_9_0.lastBalance = math.min(arg_9_0.gold + var_9_0, var_0_0.MAX_GOLD)

	return
end

function var_0_0.GetLevelData(arg_10_0)
	return arg_10_0.levelData
end

function var_0_0.OnUpgradeDone(arg_11_0, arg_11_1)
	arg_11_0.levelData:OnUpgradeDone(arg_11_1)

	for iter_11_0, iter_11_1 in pairs(arg_11_0.floorData) do
		iter_11_1:CheckUnlock(arg_11_1)
	end

	arg_11_0.lastFloorStaffList = arg_11_0:GetFloorStaffList()

	return
end

function var_0_0.GetTriggeredPointIds(arg_12_0)
	return arg_12_0.triggeredPointIds
end

function var_0_0.OnTriggerPointDone(arg_13_0, arg_13_1)
	table.insert(arg_13_0.triggeredPointIds, arg_13_1)

	return
end

function var_0_0.GetStaffData(arg_14_0)
	return arg_14_0.staffData
end

function var_0_0.GetStaffList(arg_15_0)
	local var_15_0 = underscore.values(arg_15_0.staffData)

	table.sort(var_15_0, CompareFuncs({
		function(arg_16_0)
			return arg_16_0:GetStatusInfos() == MallStaff.STATUS.ORDER and 1 or 0
		end,
		function(arg_17_0)
			return arg_17_0.id
		end
	}))

	return var_15_0
end

function var_0_0.AddStaff(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.staffData[arg_18_2] = MallStaff.New({
		tid = arg_18_1,
		id = arg_18_2
	})

	return
end

function var_0_0.GetStaff(arg_19_0, arg_19_1)
	return arg_19_0.staffData[arg_19_1]
end

function var_0_0.InitStaffStatus(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.orderData:GetStaffList()) do
		arg_20_0.staffData[iter_20_1]:SetStatus(MallStaff.STATUS.ORDER, {
			orderId = arg_20_0.orderData.id
		})
	end

	for iter_20_2, iter_20_3 in pairs(arg_20_0.floorData) do
		for iter_20_4, iter_20_5 in ipairs(iter_20_3:GetStaffList()) do
			if iter_20_5 ~= 0 then
				arg_20_0.staffData[iter_20_5]:SetStatus(MallStaff.STATUS.FLOOR, {
					floorId = iter_20_3.id,
					floorIdx = iter_20_4
				})
			end
		end
	end

	return
end

function var_0_0.SetStaffExtraData(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.staffData[arg_21_1]:SetExtraData(arg_21_2)

	return
end

function var_0_0.GetOrderData(arg_22_0)
	return arg_22_0.orderData
end

function var_0_0.OnStartOrderDone(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0.orderData:StartOrder(arg_23_1, arg_23_2, arg_23_3)

	for iter_23_0, iter_23_1 in ipairs(arg_23_3) do
		arg_23_0.staffData[iter_23_1]:SetStatus(MallStaff.STATUS.ORDER, {
			orderId = iter_23_1
		})
	end

	arg_23_0:ReduceGold(MallOrder.GetCostGold(arg_23_1))

	return
end

function var_0_0.OnCompleteOrderDone(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0.orderData:GetStaffList()) do
		arg_24_0.staffData[iter_24_1]:SetStatus(MallStaff.STATUS.NORMAL, {})
	end

	arg_24_0.orderData:CompleteOrder(arg_24_1)

	return
end

function var_0_0.GetFloorStaffList(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.floorData) do
		if iter_25_1:IsUnlock() then
			for iter_25_2, iter_25_3 in ipairs(iter_25_1:GetStaffList()) do
				table.insert({}, iter_25_3)
			end
		end
	end

	return {}
end

function var_0_0.GetFloorData(arg_26_0)
	return arg_26_0.floorData
end

function var_0_0.GetFloor(arg_27_0, arg_27_1)
	return arg_27_0.floorData[arg_27_1]
end

function var_0_0.GetFloorList(arg_28_0)
	local var_28_0 = underscore.values(arg_28_0.floorData)

	table.sort(var_28_0, CompareFuncs({
		function(arg_29_0)
			return -arg_29_0.id
		end
	}))

	return var_28_0
end

function var_0_0.GetFloorListAsc(arg_30_0)
	local var_30_0 = underscore.values(arg_30_0.floorData)

	table.sort(var_30_0, CompareFuncs({
		function(arg_31_0)
			return arg_31_0.id
		end
	}))

	return var_30_0
end

function var_0_0.NeedUpdateFloorStaff(arg_32_0)
	local var_32_0 = arg_32_0:GetFloorStaffList()

	if #var_32_0 ~= #arg_32_0.lastFloorStaffList then
		return true
	end

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		if iter_32_1 ~= arg_32_0.lastFloorStaffList[iter_32_0] then
			return true
		end
	end

	return false
end

function var_0_0.OnUpdateFloorStaffDone(arg_33_0, arg_33_1)
	arg_33_0.lastFloorStaffList = arg_33_1

	return
end

function var_0_0.SetFloorStaff(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	arg_34_0:_RemoveFloorStaff(arg_34_1, arg_34_2)

	if arg_34_3 ~= 0 then
		arg_34_0:_AddFloorStaff(arg_34_1, arg_34_2, arg_34_3)
	else
		local var_34_0 = arg_34_0.floorData[arg_34_1]:GetStaffList()

		if arg_34_2 ~= #var_34_0 then
			for iter_34_0 = arg_34_2 + 1, #var_34_0 do
				if var_34_0[iter_34_0] ~= 0 then
					table.insert({}, var_34_0[iter_34_0])
				end

				arg_34_0:_RemoveFloorStaff(arg_34_1, iter_34_0)
			end

			for iter_34_1, iter_34_2 in ipairs({}) do
				arg_34_0:_AddFloorStaff(arg_34_1, arg_34_2 - 1 + iter_34_1, iter_34_2)
			end
		end
	end

	return
end

function var_0_0._RemoveFloorStaff(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0.floorData[arg_35_1]:GetStaffList()[arg_35_2]

	if var_35_0 == 0 then
		return
	end

	arg_35_0.floorData[arg_35_1]:SetStaff(arg_35_2, 0)
	arg_35_0.staffData[var_35_0]:SetStatus(MallStaff.STATUS.NORMAL, {})

	return
end

function var_0_0._AddFloorStaff(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	assert(arg_36_0.floorData[arg_36_1]:GetStaffList()[arg_36_2] == 0, string.format("%d楼的第%d个位置已有员工%d, 请先移除！", arg_36_1, arg_36_2, arg_36_3))

	local var_36_0, var_36_1 = arg_36_0.staffData[arg_36_3]:GetStatusInfos()

	assert(var_36_0 == MallStaff.STATUS.NORMAL, string.format("员工%d处于被占用状态！(%d)", arg_36_3, var_36_0))
	arg_36_0.floorData[arg_36_1]:SetStaff(arg_36_2, arg_36_3)
	arg_36_0.staffData[arg_36_3]:SetStatus(MallStaff.STATUS.FLOOR, {
		floorId = arg_36_1,
		floorIdx = arg_36_2
	})

	return
end

function var_0_0.IsStaffDrop(arg_37_0)
	if arg_37_0.type ~= DROP_TYPE_VITEM then
		return false
	end

	if arg_37_0:getConfig("virtual_type") ~= 103 then
		return false
	end

	local var_37_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)

	if not var_37_0 then
		return false
	end

	if arg_37_0:getConfig("link_id") ~= var_37_0.id then
		return false
	end

	return arg_37_0.id ~= var_37_0:getConfig("config_data")[1]
end

return var_0_0
