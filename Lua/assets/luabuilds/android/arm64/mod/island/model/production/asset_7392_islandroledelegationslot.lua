local IslandRoleDelegationSlot = class("IslandRoleDelegationSlot", import("model.vo.BaseVO"))

function IslandRoleDelegationSlot:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.buildId = arg_1_1
	self.id = arg_1_2.id
	self.part_list = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2.part_list) do
		table.insert(self.part_list, iter_1_1)
	end

	self.formula_dic = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_2.formula_list or {}) do
		self.formula_dic[iter_1_3.id] = iter_1_3.num
	end

	self.isSelf = arg_1_3

	return
end

function IslandRoleDelegationSlot:AddAnimal(arg_2_1)
	table.insert(self.part_list, arg_2_1)

	return
end

function IslandRoleDelegationSlot:GetFormulaId()
	return (self.islandRoleDelegationData or nil) and (self.islandRoleDelegationData.formula_id or self.islandRoleDelegationReward and self.islandRoleDelegationReward.formula_id)
end

function IslandRoleDelegationSlot:AddFormulaNum(arg_4_1)
	self.formula_dic[arg_4_1.formula_id] = (self.formula_dic[arg_4_1.formula_id] or 0) + arg_4_1.num

	return
end

function IslandRoleDelegationSlot:GetFromulaTatalCount(arg_5_1)
	return self.formula_dic[arg_5_1] or 0
end

function IslandRoleDelegationSlot:bindConfigTable()
	return pg.island_production_slot
end

function IslandRoleDelegationSlot:UpdateSlotRoleData(arg_7_1)
	if arg_7_1 then
		if self.islandRoleDelegationData then
			self.islandRoleDelegationData:UpdateData(arg_7_1)
		else
			self.islandRoleDelegationData = IslandRoleDelegationData.New(arg_7_1)
		end
	else
		self.islandRoleDelegationData = nil
	end

	return
end

function IslandRoleDelegationSlot:UpdateSlotRewardData(arg_8_1)
	if arg_8_1 then
		if self.islandRoleDelegationReward then
			self.islandRoleDelegationReward:UpdateData(arg_8_1)
		else
			self.islandRoleDelegationReward = IslandRoleDelegationReward.New(arg_8_1)
		end
	else
		self.islandRoleDelegationReward = nil
	end

	return
end

function IslandRoleDelegationSlot:GetSlotRoleData()
	return self.islandRoleDelegationData
end

function IslandRoleDelegationSlot:GetSlotRewardData()
	return self.islandRoleDelegationReward
end

function IslandRoleDelegationSlot:CanStartDelegation()
	return self.islandRoleDelegationData == nil and self.islandRoleDelegationReward == nil
end

function IslandRoleDelegationSlot:CanStartDelegationTip()
	return self.islandRoleDelegationData == nil and self.islandRoleDelegationReward == nil and not self:CheckChildSlotIsInWork()
end

function IslandRoleDelegationSlot:CheckChildSlotIsInWork()
	local var_13_0 = getProxy(IslandProxy)
	local var_13_1 = var_13_0:GetIsland():GetBuildingAgency():GetBuilding(self.buildId)

	if var_13_0 then
		for iter_13_0, iter_13_1 in ipairs(pg.island_production_slot[self.id].exclusion_slot == "" and {} or pg.island_production_slot[self.id].exclusion_slot) do
			local var_13_2 = var_13_1:GetHandPlantSlotData(iter_13_1)

			if var_13_2 and var_13_2.state == 1 then
				return true
			end
		end
	end

	return false
end

function IslandRoleDelegationSlot:Clear()
	return
end

function IslandRoleDelegationSlot:UpdatePerSecond()
	if not self.islandRoleDelegationData then
		return
	end

	if self.islandRoleDelegationData:CheckDelegationIsEnd() then
		if self.isSelf then
			pg.m02:sendNotification(GAME.ISLAND_FINISH_DELEGATION, {
				build_id = self.buildId,
				area_id = self.id
			})
			self.islandRoleDelegationData:SetIsSend(true)
		else
			local var_15_0 = getProxy(IslandProxy)
			local var_15_1 = var_15_0:GetSharedIsland()
			local var_15_2 = var_15_1:GetBuildingAgency():GetBuilding(self.buildId)

			var_15_2.UpdateDeleationRewardDataBySlotId(var_15_0, self.id, {
				formula_id = self.islandRoleDelegationData.formula_id
			})
			var_15_2:UpdateDeleationRoleDataBySlotId(self.id, nil)
			var_15_1:DispatchEvent(IslandFinishDelegationCommand.END_DELEGATION, {
				remainReward = true,
				build_id = self.buildId,
				ship_id = self.islandRoleDelegationData.ship_id,
				area_id = self.id
			})
		end
	end

	return
end

function IslandRoleDelegationSlot:GetRoleDelegateFinishTime()
	if self.islandRoleDelegationReward then
		return 0
	end

	if self.islandRoleDelegationData then
		return self.islandRoleDelegationData:GetFinishTime()
	end

	return -1
end

function IslandRoleDelegationSlot:GetRoleShipData()
	if self.islandRoleDelegationData then
		return {
			ship_id = self.islandRoleDelegationData.ship_id,
			area_id = self.id
		}
	end

	return nil
end

function IslandRoleDelegationSlot:GetRoleSlotAndFormulaData()
	if self.islandRoleDelegationData then
		return {
			formula_id = self.islandRoleDelegationData.formula_id,
			area_id = self.id
		}
	end

	return nil
end

function IslandRoleDelegationSlot:GetPartList()
	return self.part_list or {}
end

return IslandRoleDelegationSlot
