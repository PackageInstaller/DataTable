local MallActivity = class("MallActivity", import("model.vo.Activity"))

MallActivity.POINT_TYPE = {
	SITE = 1,
	BRANCH_STORY = 3,
	MAIN_STORY = 2,
	INTERACT_STORY = 4
}
MallActivity.MAX_GOLD = 999999999

function MallActivity:Ctor(arg_1_1)
	MallActivity.super.Ctor(self, arg_1_1)

	self.gold = arg_1_1.mall.gold
	self.round = arg_1_1.mall.round
	self.triggeredPointIds = arg_1_1.mall.story_list
	self.levelData = MallLevel.New(arg_1_1.mall.level)
	self.orderData = MallOrder.New(arg_1_1.mall.order)
	self.lastBalance = arg_1_1.mall.last_round.balance
	self.lastIncome = 0

	local var_1_0 = {}
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.mall.floor_list) do
		var_1_0[iter_1_1.id] = iter_1_1
		var_1_1[iter_1_1.id] = arg_1_1.mall.last_round.floor_income[iter_1_1.id] or 0
		self.lastIncome = self.lastIncome + var_1_1[iter_1_1.id]
	end

	self.floorData = {}

	for iter_1_2, iter_1_3 in ipairs(pg.activity_mall_template.all) do
		local var_1_2 = MallFloor.New(var_1_0[iter_1_3] or {
			id = iter_1_3
		}, var_1_0[iter_1_3] ~= nil)

		var_1_2:CheckUnlock(self.levelData.level)
		var_1_2:SetLastIncome(var_1_1[iter_1_3])

		self.floorData[iter_1_3] = var_1_2
	end

	self.lastFloorStaffList = self:GetFloorStaffList()
	self.staffData = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.mall.employee_list) do
		self.staffData[iter_1_5.id] = MallStaff.New(iter_1_5)
	end

	self:InitStaffStatus()

	return
end

function MallActivity:GetGold()
	return self.gold
end

function MallActivity:AddGold(arg_3_1)
	self.gold = self.gold + arg_3_1
	self.gold = math.min(self.gold, MallActivity.MAX_GOLD)

	return
end

function MallActivity:ReduceGold(arg_4_1)
	self.gold = self.gold - arg_4_1

	return
end

function MallActivity:IsGoldDrop(arg_5_1)
	return arg_5_1.type == DROP_TYPE_VITEM and arg_5_1.id == self:getConfig("config_data")[1]
end

function MallActivity:GetRound()
	return self.round
end

function MallActivity:GetLastIncome()
	return self.lastIncome
end

function MallActivity:GetLastBalance()
	return self.lastBalance
end

function MallActivity:NextRound(arg_9_1)
	self.round = self.round + 1

	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if iter_9_0 ~= 1 then
			self.floorData[iter_9_0 - 1]:SetLastIncome(iter_9_1)

			var_9_0 = var_9_0 + iter_9_1
		end
	end

	self.lastIncome = var_9_0
	self.lastBalance = math.min(self.gold + var_9_0, MallActivity.MAX_GOLD)

	return
end

function MallActivity:GetLevelData()
	return self.levelData
end

function MallActivity:OnUpgradeDone(arg_11_1)
	self.levelData:OnUpgradeDone(arg_11_1)

	for iter_11_0, iter_11_1 in pairs(self.floorData) do
		iter_11_1:CheckUnlock(arg_11_1)
	end

	self.lastFloorStaffList = self:GetFloorStaffList()

	return
end

function MallActivity:GetTriggeredPointIds()
	return self.triggeredPointIds
end

function MallActivity:OnTriggerPointDone(arg_13_1)
	table.insert(self.triggeredPointIds, arg_13_1)

	return
end

function MallActivity:GetStaffData()
	return self.staffData
end

function MallActivity:GetStaffList()
	local var_15_0 = underscore.values(self.staffData)

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

function MallActivity:AddStaff(arg_18_1, arg_18_2)
	self.staffData[arg_18_2] = MallStaff.New({
		tid = arg_18_1,
		id = arg_18_2
	})

	return
end

function MallActivity:GetStaff(arg_19_1)
	return self.staffData[arg_19_1]
end

function MallActivity:InitStaffStatus()
	for iter_20_0, iter_20_1 in ipairs(self.orderData:GetStaffList()) do
		self.staffData[iter_20_1]:SetStatus(MallStaff.STATUS.ORDER, {
			orderId = self.orderData.id
		})
	end

	for iter_20_2, iter_20_3 in pairs(self.floorData) do
		for iter_20_4, iter_20_5 in ipairs(iter_20_3:GetStaffList()) do
			if iter_20_5 ~= 0 then
				self.staffData[iter_20_5]:SetStatus(MallStaff.STATUS.FLOOR, {
					floorId = iter_20_3.id,
					floorIdx = iter_20_4
				})
			end
		end
	end

	return
end

function MallActivity:SetStaffExtraData(arg_21_1, arg_21_2)
	self.staffData[arg_21_1]:SetExtraData(arg_21_2)

	return
end

function MallActivity:GetOrderData()
	return self.orderData
end

function MallActivity:OnStartOrderDone(arg_23_1, arg_23_2, arg_23_3)
	self.orderData:StartOrder(arg_23_1, arg_23_2, arg_23_3)

	for iter_23_0, iter_23_1 in ipairs(arg_23_3) do
		self.staffData[iter_23_1]:SetStatus(MallStaff.STATUS.ORDER, {
			orderId = iter_23_1
		})
	end

	self:ReduceGold(MallOrder.GetCostGold(arg_23_1))

	return
end

function MallActivity:OnCompleteOrderDone(arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(self.orderData:GetStaffList()) do
		self.staffData[iter_24_1]:SetStatus(MallStaff.STATUS.NORMAL, {})
	end

	self.orderData:CompleteOrder(arg_24_1)

	return
end

function MallActivity:GetFloorStaffList()
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in pairs(self.floorData) do
		if iter_25_1:IsUnlock() then
			for iter_25_2, iter_25_3 in ipairs(iter_25_1:GetStaffList()) do
				table.insert(var_25_0, iter_25_3)
			end
		end
	end

	return var_25_0
end

function MallActivity:GetFloorData()
	return self.floorData
end

function MallActivity:GetFloor(arg_27_1)
	return self.floorData[arg_27_1]
end

function MallActivity:GetFloorList()
	local var_28_0 = underscore.values(self.floorData)

	table.sort(var_28_0, CompareFuncs({
		function(arg_29_0)
			return -arg_29_0.id
		end
	}))

	return var_28_0
end

function MallActivity:GetFloorListAsc()
	local var_30_0 = underscore.values(self.floorData)

	table.sort(var_30_0, CompareFuncs({
		function(arg_31_0)
			return arg_31_0.id
		end
	}))

	return var_30_0
end

function MallActivity:NeedUpdateFloorStaff()
	local var_32_0 = self:GetFloorStaffList()

	if #var_32_0 ~= #self.lastFloorStaffList then
		return true
	end

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		if iter_32_1 ~= self.lastFloorStaffList[iter_32_0] then
			return true
		end
	end

	return false
end

function MallActivity:OnUpdateFloorStaffDone(arg_33_1)
	self.lastFloorStaffList = arg_33_1

	return
end

function MallActivity:SetFloorStaff(arg_34_1, arg_34_2, arg_34_3)
	self:_RemoveFloorStaff(arg_34_1, arg_34_2)

	if arg_34_3 ~= 0 then
		self:_AddFloorStaff(arg_34_1, arg_34_2, arg_34_3)
	else
		local var_34_0 = self.floorData[arg_34_1]:GetStaffList()
		local var_34_1 = {}

		if arg_34_2 ~= #var_34_0 then
			for iter_34_0 = arg_34_2 + 1, #var_34_0 do
				if var_34_0[iter_34_0] ~= 0 then
					table.insert(var_34_1, var_34_0[iter_34_0])
				end

				self:_RemoveFloorStaff(arg_34_1, iter_34_0)
			end

			for iter_34_1, iter_34_2 in ipairs(var_34_1) do
				self:_AddFloorStaff(arg_34_1, arg_34_2 - 1 + iter_34_1, iter_34_2)
			end
		end
	end

	return
end

function MallActivity:_RemoveFloorStaff(arg_35_1, arg_35_2)
	local var_35_0 = self.floorData[arg_35_1]:GetStaffList()[arg_35_2]

	if var_35_0 == 0 then
		return
	end

	self.floorData[arg_35_1]:SetStaff(arg_35_2, 0)
	self.staffData[var_35_0]:SetStatus(MallStaff.STATUS.NORMAL, {})

	return
end

function MallActivity:_AddFloorStaff(arg_36_1, arg_36_2, arg_36_3)
	assert(self.floorData[arg_36_1]:GetStaffList()[arg_36_2] == 0, string.format("%d楼的第%d个位置已有员工%d, 请先移除！", arg_36_1, arg_36_2, arg_36_3))

	local var_36_0, var_36_1 = self.staffData[arg_36_3]:GetStatusInfos()

	assert(var_36_0 == MallStaff.STATUS.NORMAL, string.format("员工%d处于被占用状态！(%d)", arg_36_3, var_36_0))
	self.floorData[arg_36_1]:SetStaff(arg_36_2, arg_36_3)
	self.staffData[arg_36_3]:SetStatus(MallStaff.STATUS.FLOOR, {
		floorId = arg_36_1,
		floorIdx = arg_36_2
	})

	return
end

function MallActivity:IsStaffDrop()
	if self.type ~= DROP_TYPE_VITEM then
		return false
	end

	if self:getConfig("virtual_type") ~= 103 then
		return false
	end

	local var_37_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)

	if not var_37_0 then
		return false
	end

	if self:getConfig("link_id") ~= var_37_0.id then
		return false
	end

	return self.id ~= var_37_0:getConfig("config_data")[1]
end

return MallActivity
