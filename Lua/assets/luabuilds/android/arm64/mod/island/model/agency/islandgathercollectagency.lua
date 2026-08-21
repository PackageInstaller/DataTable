local var_0_0 = class("IslandGatherCollectAgency", import(".IslandBaseAgency"))

var_0_0.AddGatherUnit = "IslandGatherCollectAgency:AddGatherUnit"
var_0_0.RemoveGatherUnit = "IslandGatherCollectAgency:RemoveGatherUnit"
var_0_0.ShowTpye = {
	OnlySelf = 1,
	FriendSee = 2,
	FriendSeeAndSign = 3
}

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.finnishIds = {}

	local var_1_0 = arg_1_1.finish_list or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		table.insert(arg_1_0.finnishIds, iter_1_1)
	end

	return
end

function var_0_0.InitPrivateData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.collect_sys or {}

	arg_2_0.collectData = {}

	local var_2_1 = var_2_0.collect_item or {}

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		arg_2_0.collectData[iter_2_1.id] = IslandCollectItemData.New(iter_2_1)
	end

	arg_2_0.finish_listCollect = var_2_0.finish_list or {}

	return
end

function var_0_0.ExistFragment(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.finish_listCollect) do
		if pg.island_collect_fragment[arg_3_1].collection_id == iter_3_1 then
			return true
		end
	end

	if arg_3_0.collectData[pg.island_collect_fragment[arg_3_1].collection_id] then
		return arg_3_0.collectData[pg.island_collect_fragment[arg_3_1].collection_id]:CheckFragment(arg_3_1)
	end

	return false
end

function var_0_0.AddCollectFragment(arg_4_0, arg_4_1)
	arg_4_0.collectData[pg.island_collect_fragment[arg_4_1].collection_id] = arg_4_0.collectData[pg.island_collect_fragment[arg_4_1].collection_id] or IslandCollectItemData.New({
		id = pg.island_collect_fragment[arg_4_1].collection_id
	})

	arg_4_0.collectData[pg.island_collect_fragment[arg_4_1].collection_id]:AddFragment(arg_4_1)
	IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.FRAGMENT)

	return
end

function var_0_0.AddFinishCollectData(arg_5_0, arg_5_1)
	if arg_5_0.collectData[arg_5_1] then
		arg_5_0.collectData[arg_5_1]:ResetFragment()
	end

	table.insert(arg_5_0.finish_listCollect, arg_5_1)

	return
end

function var_0_0.InitGatherData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.island_id = arg_6_2
	arg_6_0.gatherDic = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.gather_list) do
		arg_6_0.gatherDic[iter_6_1.id] = IslandWildGatherData.New(iter_6_1, arg_6_3)
	end

	arg_6_0.collectDic = {}

	for iter_6_2, iter_6_3 in ipairs(arg_6_1.fragment_list) do
		arg_6_0.collectDic[iter_6_3.id] = IslandCollectFragmentData.New(iter_6_3, arg_6_3)
	end

	return
end

function var_0_0.UpdateGatherData(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1.gather_list) do
		local var_7_0
		local var_7_1
		local var_7_2
		local var_7_3

		if iter_7_1.push_type == 1 then
			if arg_7_0.gatherDic[iter_7_1.id] then
				var_7_0, var_7_1, var_7_2, var_7_3 = arg_7_0.gatherDic[iter_7_1.id]:UpdateData(iter_7_1)
			end
		elseif iter_7_1.push_type == 2 then
			if not arg_7_0.gatherDic[iter_7_1.id] then
				arg_7_0.gatherDic[iter_7_1.id] = IslandWildGatherData.New(iter_7_1)
				var_7_0 = true
				var_7_2 = arg_7_0.gatherDic[iter_7_1.id].pos
			end
		elseif arg_7_0.gatherDic[iter_7_1.id] then
			var_7_3 = arg_7_0.gatherDic[iter_7_1.id].pos
			arg_7_0.gatherDic[iter_7_1.id] = nil
			var_7_1 = true
		end

		if var_7_1 then
			arg_7_0:DispatchEvent(var_0_0.RemoveGatherUnit, {
				unitId = var_7_3
			})
		end

		if var_7_0 then
			arg_7_0:DispatchEvent(var_0_0.AddGatherUnit, {
				unitId = var_7_2,
				islandId = arg_7_1.island_id,
				gatherType = IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM
			})
		end
	end

	return
end

function var_0_0.UpdateCollectFragmentData(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1.gather_list) do
		local var_8_0
		local var_8_1
		local var_8_2
		local var_8_3

		if iter_8_1.push_type == 1 then
			if arg_8_0.collectDic[iter_8_1.id] then
				var_8_0, var_8_1, var_8_2, var_8_3 = arg_8_0.collectDic[iter_8_1.id]:UpdateData(iter_8_1)
				unitId = arg_8_0.collectDic[iter_8_1.id].pos
			end
		elseif iter_8_1.push_type == 2 then
			if not arg_8_0.collectDic[iter_8_1.id] then
				arg_8_0.collectDic[iter_8_1.id] = IslandCollectFragmentData.New(iter_8_1)
				var_8_0 = true
				var_8_2 = arg_8_0.collectDic[iter_8_1.id].pos
			end
		elseif arg_8_0.collectDic[iter_8_1.id] then
			var_8_1 = true
			var_8_3 = arg_8_0.collectDic[iter_8_1.id].pos
			arg_8_0.collectDic[iter_8_1.id] = nil
		end

		if var_8_1 then
			arg_8_0:DispatchEvent(var_0_0.RemoveGatherUnit, {
				unitId = var_8_3
			})
		end

		if var_8_0 then
			arg_8_0:DispatchEvent(var_0_0.AddGatherUnit, {
				unitId = var_8_2
			})
		end
	end

	return
end

function var_0_0.GetUnitList(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.gatherDic) do
		if iter_9_1:IsShow() then
			table.insert({}, {
				unitId = iter_9_1.pos,
				gatherType = IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM
			})
		end
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0.collectDic) do
		if iter_9_3:IsShow() then
			table.insert({}, {
				unitId = iter_9_3.pos,
				gatherType = IslandConst.UNIT_TYPE_ITEM_WILD_COLLECT_ITEM
			})
		end
	end

	return {}
end

function var_0_0.GetGatherDataByUnitId(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.gatherDic) do
		if iter_10_1.pos == arg_10_1 then
			return iter_10_1
		end
	end

	return nil
end

function var_0_0.GetCollectDataByUnitId(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.collectDic) do
		if iter_11_1.pos == arg_11_1 then
			return iter_11_1
		end
	end

	return nil
end

function var_0_0.CheckGatherCanSign(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:GetGatherDataByUnitId(arg_12_1)

	if not var_12_0 then
		return false
	end

	return var_12_0:CheckGatherCanShow(arg_12_1)
end

function var_0_0.IsSelf(arg_13_0, arg_13_1)
	local var_13_0 = getProxy(PlayerProxy)

	return var_13_0:getRawData().id == arg_13_1
end

return var_0_0
