class = var_0_10000

local var_0_0 = "IslandGatherCollectAgency"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseAgency"))

var_0_1.AddGatherUnit = "IslandGatherCollectAgency:AddGatherUnit"
var_0_1.RemoveGatherUnit = "IslandGatherCollectAgency:RemoveGatherUnit"
var_0_1.ShowTpye = {
	OnlySelf = 1,
	FriendSee = 2,
	FriendSeeAndSign = 3
}

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.finnishIds = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.finish_list then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.finnishIds, iter_1_1)
	end

	return
end

function var_0_1.InitPrivateData(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_1.collect_sys then
		var_2_0 = {}
	end

	arg_2_0.collectData = {}
	ipairs = var_3

	local var_2_1

	if not var_2_0.collect_item then
		var_2_1 = {}
	end

	for iter_2_0, iter_2_1 in var_3(var_2_1) do
		local var_2_2 = arg_2_0.collectData
		local var_2_3 = iter_2_1.id

		IslandCollectItemData = var_1_10010
		var_2_2[var_2_3] = var_1_10010.New(iter_2_1)
	end

	local var_2_4

	if not var_2_0.finish_list then
		var_2_4 = {}
	end

	arg_2_0.finish_listCollect = var_2_4

	return
end

function var_0_1.ExistFragment(arg_3_0, arg_3_1)
	pg = var_1_10002

	local var_3_0 = var_1_10002.island_collect_fragment[arg_3_1].collection_id

	ipairs = var_1_10004

	for iter_3_0, iter_3_1 in var_1_10004(arg_3_0.finish_listCollect) do
		if var_3_0 == iter_3_1 then
			return true
		end
	end

	if arg_3_0.collectData[var_3_0] then
		return var_4:CheckFragment(arg_3_1)
	end

	return false
end

function var_0_1.AddCollectFragment(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.island_collect_fragment[arg_4_1].collection_id

	if not arg_4_0.collectData[var_4_0] then
		local var_4_1 = arg_4_0.collectData

		IslandCollectItemData = var_1_10005
		var_4_1[var_4_0] = var_1_10005.New({
			id = var_4_0
		})
	end

	local var_4_2 = arg_4_0.collectData[var_4_0]

	var_4.AddFragment(var_4_2, arg_4_1)

	IslandTaskHelper = var_5

	local var_4_3 = var_5.UpdateRuntimeTaskByTargetType

	IslandTaskTargetType = var_4_2

	var_4_3(var_4_2.FRAGMENT)

	return
end

function var_0_1.AddFinishCollectData(arg_5_0, arg_5_1)
	if arg_5_0.collectData[arg_5_1] then
		var_2:ResetFragment()
	end

	table = var_1_10003

	var_1_10003.insert(arg_5_0.finish_listCollect, arg_5_1)

	return
end

function var_0_1.InitGatherData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.island_id = arg_6_2
	arg_6_0.gatherDic = {}
	ipairs = var_4

	for iter_6_0, iter_6_1 in var_4(arg_6_1.gather_list) do
		local var_6_0 = arg_6_0.gatherDic
		local var_6_1 = iter_6_1.id

		IslandWildGatherData = var_1_10011
		var_6_0[var_6_1] = var_1_10011.New(iter_6_1, arg_6_3)
	end

	arg_6_0.collectDic = {}
	ipairs = var_4

	for iter_6_2, iter_6_3 in var_4(arg_6_1.fragment_list) do
		local var_6_2 = arg_6_0.collectDic
		local var_6_3 = iter_6_3.id

		IslandCollectFragmentData = var_1_10011
		var_6_2[var_6_3] = var_1_10011.New(iter_6_3, arg_6_3)
	end

	return
end

function var_0_1.UpdateGatherData(arg_7_0, arg_7_1)
	ipairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_1.gather_list) do
		local var_7_0
		local var_7_1
		local var_7_2
		local var_7_3

		if iter_7_1.push_type == 1 then
			if arg_7_0.gatherDic[iter_7_1.id] then
				var_1_10013 = arg_7_0.gatherDic[iter_7_1.id]

				local var_7_4, var_7_5, var_7_6

				var_7_4, var_7_5, var_1_10013, var_7_6 = var_11.UpdateData(var_1_10013, iter_7_1)
				var_7_3 = var_7_6
				var_7_2 = var_1_10013
				var_7_1 = var_7_5
				var_7_0 = var_7_4
			end
		elseif iter_7_1.push_type == 2 then
			if not arg_7_0.gatherDic[iter_7_1.id] then
				local var_7_7 = arg_7_0.gatherDic
				local var_7_8 = iter_7_1.id

				IslandWildGatherData = var_1_10013
				var_7_7[var_7_8] = var_1_10013.New(iter_7_1)
				var_7_0 = true
				var_7_2 = arg_7_0.gatherDic[iter_7_1.id].pos
			end
		elseif arg_7_0.gatherDic[iter_7_1.id] then
			var_7_3 = arg_7_0.gatherDic[iter_7_1.id].pos
			arg_7_0.gatherDic[iter_7_1.id] = nil
			var_7_1 = true
		end

		if var_7_1 then
			var_1_10013 = arg_7_0

			arg_7_0.DispatchEvent(var_1_10013, var_0_1.RemoveGatherUnit, {
				unitId = var_7_3
			})
		end

		if var_7_0 then
			var_1_10013 = arg_7_0

			local var_7_9 = arg_7_0.DispatchEvent
			local var_7_10 = var_0_1.AddGatherUnit
			local var_7_11 = {
				unitId = var_7_2,
				islandId = arg_7_1.island_id
			}

			IslandConst = var_16
			var_7_11.gatherType = var_16.UNIT_TYPE_ITEM_GATHER_ITEM

			var_7_9(var_1_10013, var_7_10, var_7_11)
		end
	end

	return
end

function var_0_1.UpdateCollectFragmentData(arg_8_0, arg_8_1)
	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_1.gather_list) do
		local var_8_0
		local var_8_1
		local var_8_2
		local var_8_3

		if iter_8_1.push_type == 1 then
			if arg_8_0.collectDic[iter_8_1.id] then
				var_1_10013 = arg_8_0.collectDic[iter_8_1.id]

				local var_8_4, var_8_5, var_8_6

				var_8_4, var_8_5, var_1_10013, var_8_6 = var_11.UpdateData(var_1_10013, iter_8_1)
				var_8_3 = var_8_6
				var_8_2 = var_1_10013
				var_8_1 = var_8_5
				var_8_0 = var_8_4

				local var_8_7 = arg_8_0.collectDic[iter_8_1.id].pos
				local var_8_8 = unitId
			end
		elseif iter_8_1.push_type == 2 then
			if not arg_8_0.collectDic[iter_8_1.id] then
				local var_8_9 = arg_8_0.collectDic
				local var_8_10 = iter_8_1.id

				IslandCollectFragmentData = var_1_10013
				var_8_9[var_8_10] = var_1_10013.New(iter_8_1)
				var_8_0 = true
				var_8_2 = arg_8_0.collectDic[iter_8_1.id].pos
			end
		elseif arg_8_0.collectDic[iter_8_1.id] then
			var_8_1 = true
			var_8_3 = arg_8_0.collectDic[iter_8_1.id].pos
			arg_8_0.collectDic[iter_8_1.id] = nil
		end

		if var_8_1 then
			var_1_10013 = arg_8_0

			arg_8_0.DispatchEvent(var_1_10013, var_0_1.RemoveGatherUnit, {
				unitId = var_8_3
			})
		end

		if var_8_0 then
			var_1_10013 = arg_8_0

			arg_8_0.DispatchEvent(var_1_10013, var_0_1.AddGatherUnit, {
				unitId = var_8_2
			})
		end
	end

	return
end

function var_0_1.GetUnitList(arg_9_0)
	local var_9_0 = {}

	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.gatherDic) do
		if iter_9_1:IsShow() then
			table = var_7

			local var_9_1 = var_7.insert
			local var_9_2 = var_9_0
			local var_9_3 = {
				unitId = iter_9_1.pos
			}

			IslandConst = var_11
			var_9_3.gatherType = var_11.UNIT_TYPE_ITEM_GATHER_ITEM

			var_9_1(var_9_2, var_9_3)
		end
	end

	pairs = var_2

	for iter_9_2, iter_9_3 in var_2(arg_9_0.collectDic) do
		if iter_9_3:IsShow() then
			table = var_7

			local var_9_4 = var_7.insert
			local var_9_5 = var_9_0
			local var_9_6 = {
				unitId = iter_9_3.pos
			}

			IslandConst = var_11
			var_9_6.gatherType = var_11.UNIT_TYPE_ITEM_WILD_COLLECT_ITEM

			var_9_4(var_9_5, var_9_6)
		end
	end

	return var_9_0
end

function var_0_1.GetGatherDataByUnitId(arg_10_0, arg_10_1)
	pairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.gatherDic) do
		if iter_10_1.pos == arg_10_1 then
			return iter_10_1
		end
	end

	return nil
end

function var_0_1.GetCollectDataByUnitId(arg_11_0, arg_11_1)
	pairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0.collectDic) do
		if iter_11_1.pos == arg_11_1 then
			return iter_11_1
		end
	end

	return nil
end

function var_0_1.CheckGatherCanSign(arg_12_0, arg_12_1)
	if not arg_12_0:GetGatherDataByUnitId(arg_12_1) then
		return false
	end

	return var_2:CheckGatherCanShow(arg_12_1)
end

function var_0_1.IsSelf(arg_13_0, arg_13_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_13_0 = var_1_10002(var_1_10004)

	return var_2.getRawData(var_13_0).id == arg_13_1
end

return var_0_1
