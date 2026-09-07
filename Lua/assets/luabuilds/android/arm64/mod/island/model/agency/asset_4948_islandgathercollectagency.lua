local IslandGatherCollectAgency = class("IslandGatherCollectAgency", import(".IslandBaseAgency"))

IslandGatherCollectAgency.AddGatherUnit = "IslandGatherCollectAgency:AddGatherUnit"
IslandGatherCollectAgency.RemoveGatherUnit = "IslandGatherCollectAgency:RemoveGatherUnit"
IslandGatherCollectAgency.ShowTpye = {
	OnlySelf = 1,
	FriendSee = 2,
	FriendSeeAndSign = 3
}

function IslandGatherCollectAgency:OnInit(arg_1_1)
	self.finnishIds = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.finish_list or {}) do
		table.insert(self.finnishIds, iter_1_1)
	end

	return
end

function IslandGatherCollectAgency:InitPrivateData(arg_2_1)
	local var_2_0 = arg_2_1.collect_sys or {}

	self.collectData = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0.collect_item or {}) do
		self.collectData[iter_2_1.id] = IslandCollectItemData.New(iter_2_1)
	end

	self.finish_listCollect = var_2_0.finish_list or {}

	return
end

function IslandGatherCollectAgency:ExistFragment(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self.finish_listCollect) do
		if pg.island_collect_fragment[arg_3_1].collection_id == iter_3_1 then
			return true
		end
	end

	if self.collectData[pg.island_collect_fragment[arg_3_1].collection_id] then
		return self.collectData[pg.island_collect_fragment[arg_3_1].collection_id]:CheckFragment(arg_3_1)
	end

	return false
end

function IslandGatherCollectAgency:AddCollectFragment(arg_4_1)
	self.collectData[pg.island_collect_fragment[arg_4_1].collection_id] = self.collectData[pg.island_collect_fragment[arg_4_1].collection_id] or IslandCollectItemData.New({
		id = pg.island_collect_fragment[arg_4_1].collection_id
	})

	self.collectData[pg.island_collect_fragment[arg_4_1].collection_id]:AddFragment(arg_4_1)
	IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.FRAGMENT)

	return
end

function IslandGatherCollectAgency:AddFinishCollectData(arg_5_1)
	if self.collectData[arg_5_1] then
		self.collectData[arg_5_1]:ResetFragment()
	end

	table.insert(self.finish_listCollect, arg_5_1)

	return
end

function IslandGatherCollectAgency:InitGatherData(arg_6_1, arg_6_2, arg_6_3)
	self.island_id = arg_6_2
	self.gatherDic = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.gather_list) do
		self.gatherDic[iter_6_1.id] = IslandWildGatherData.New(iter_6_1, arg_6_3)
	end

	self.collectDic = {}

	for iter_6_2, iter_6_3 in ipairs(arg_6_1.fragment_list) do
		self.collectDic[iter_6_3.id] = IslandCollectFragmentData.New(iter_6_3, arg_6_3)
	end

	return
end

function IslandGatherCollectAgency:UpdateGatherData(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1.gather_list) do
		local var_7_0
		local var_7_1
		local var_7_2
		local var_7_3

		if iter_7_1.push_type == 1 then
			if self.gatherDic[iter_7_1.id] then
				var_7_0, var_7_1, var_7_2, var_7_3 = self.gatherDic[iter_7_1.id]:UpdateData(iter_7_1)
			end
		elseif iter_7_1.push_type == 2 then
			if not self.gatherDic[iter_7_1.id] then
				self.gatherDic[iter_7_1.id] = IslandWildGatherData.New(iter_7_1)
				var_7_0 = true
				var_7_2 = self.gatherDic[iter_7_1.id].pos
			end
		elseif self.gatherDic[iter_7_1.id] then
			var_7_3 = self.gatherDic[iter_7_1.id].pos
			self.gatherDic[iter_7_1.id] = nil
			var_7_1 = true
		end

		if var_7_1 then
			self:DispatchEvent(IslandGatherCollectAgency.RemoveGatherUnit, {
				unitId = var_7_3
			})
		end

		if var_7_0 then
			self:DispatchEvent(IslandGatherCollectAgency.AddGatherUnit, {
				unitId = var_7_2,
				islandId = arg_7_1.island_id,
				gatherType = IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM
			})
		end
	end

	return
end

function IslandGatherCollectAgency:UpdateCollectFragmentData(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1.gather_list) do
		local var_8_0
		local var_8_1
		local var_8_2
		local var_8_3

		if iter_8_1.push_type == 1 then
			if self.collectDic[iter_8_1.id] then
				var_8_0, var_8_1, var_8_2, var_8_3 = self.collectDic[iter_8_1.id]:UpdateData(iter_8_1)
				unitId = self.collectDic[iter_8_1.id].pos
			end
		elseif iter_8_1.push_type == 2 then
			if not self.collectDic[iter_8_1.id] then
				self.collectDic[iter_8_1.id] = IslandCollectFragmentData.New(iter_8_1)
				var_8_0 = true
				var_8_2 = self.collectDic[iter_8_1.id].pos
			end
		elseif self.collectDic[iter_8_1.id] then
			var_8_1 = true
			var_8_3 = self.collectDic[iter_8_1.id].pos
			self.collectDic[iter_8_1.id] = nil
		end

		if var_8_1 then
			self:DispatchEvent(IslandGatherCollectAgency.RemoveGatherUnit, {
				unitId = var_8_3
			})
		end

		if var_8_0 then
			self:DispatchEvent(IslandGatherCollectAgency.AddGatherUnit, {
				unitId = var_8_2
			})
		end
	end

	return
end

function IslandGatherCollectAgency:GetUnitList()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self.gatherDic) do
		if iter_9_1:IsShow() then
			table.insert(var_9_0, {
				unitId = iter_9_1.pos,
				gatherType = IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM
			})
		end
	end

	for iter_9_2, iter_9_3 in pairs(self.collectDic) do
		if iter_9_3:IsShow() then
			table.insert(var_9_0, {
				unitId = iter_9_3.pos,
				gatherType = IslandConst.UNIT_TYPE_ITEM_WILD_COLLECT_ITEM
			})
		end
	end

	return var_9_0
end

function IslandGatherCollectAgency:GetGatherDataByUnitId(arg_10_1)
	for iter_10_0, iter_10_1 in pairs(self.gatherDic) do
		if iter_10_1.pos == arg_10_1 then
			return iter_10_1
		end
	end

	return nil
end

function IslandGatherCollectAgency:GetCollectDataByUnitId(arg_11_1)
	for iter_11_0, iter_11_1 in pairs(self.collectDic) do
		if iter_11_1.pos == arg_11_1 then
			return iter_11_1
		end
	end

	return nil
end

function IslandGatherCollectAgency:CheckGatherCanSign(arg_12_1)
	local var_12_0 = self:GetGatherDataByUnitId(arg_12_1)

	if not var_12_0 then
		return false
	end

	return var_12_0:CheckGatherCanShow(arg_12_1)
end

function IslandGatherCollectAgency:IsSelf(arg_13_1)
	return getProxy(PlayerProxy):getRawData().id == arg_13_1
end

return IslandGatherCollectAgency
