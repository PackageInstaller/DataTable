class = var_0_10000

local var_0_0 = "IslandBookAgency"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseAgency"))

function var_0_1.OnInit(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.view_book
	local var_1_1 = {}

	ipairs = var_1_10004

	for iter_1_0, iter_1_1 in var_1_10004(var_1_0.book_list) do
		table = var_1_10009

		var_1_10009.insert(var_1_1, iter_1_1)
	end

	local var_1_2 = {}

	ipairs = var_5

	for iter_1_2, iter_1_3 in var_5(var_1_0.cond_list) do
		if not var_1_2[iter_1_3.type] then
			var_1_2[iter_1_3.type] = {}
		end

		ipairs = var_1_10010

		for iter_1_4, iter_1_5 in var_1_10010(iter_1_3.unlock_ids) do
			var_1_2[iter_1_3.type][iter_1_5] = true
		end
	end

	arg_1_0.dataMap = {}
	ipairs = var_5
	pg = var_6

	for iter_1_6, iter_1_7 in var_5(var_6.island_illustrated_guide.all) do
		IslandIllustration = var_1_10010

		local var_1_3

		var_1_10010, var_1_3 = var_1_10010.GetTypeAndLinkId(iter_1_7)

		if not arg_1_0.dataMap[var_1_10010] then
			var_1_10012 = arg_1_0.dataMap
			var_1_10012[var_1_10010] = {}
		end

		local var_1_4 = arg_1_0

		var_1_10012 = arg_1_0.CreateClass(var_1_4, var_1_10010, iter_1_7)
		table = var_1_4

		if var_1_4.contains(var_1_1, iter_1_7) then
			local var_1_5 = var_1_10012
			local var_1_6 = var_1_10012.SetStatus

			IslandIllustration = var_15

			var_1_6(var_1_5, var_15.STATUS.UNLOCK)
		elseif var_1_2[var_1_10010] and var_1_2[var_1_10010][var_1_3] then
			local var_1_7 = var_1_10012
			local var_1_8 = var_1_10012.SetStatus

			IslandIllustration = var_15

			var_1_8(var_1_7, var_15.STATUS.CAN_UNLOCK)
		end

		arg_1_0.dataMap[var_1_10010][var_1_3] = var_1_10012
	end

	arg_1_0:SetPointDatas(var_1_0.book_collects)

	local var_1_9 = arg_1_0
	local var_1_10 = arg_1_0.SetRecordDatas
	local var_1_11

	if not var_1_0.item_list then
		var_1_11 = {}
	end

	var_1_10(var_1_9, var_1_11)

	arg_1_0.pointAwardGotMaps = {}
	arg_1_0.pointAwardIdsMaps = {}
	ipairs = var_5
	pg = var_1_9

	for iter_1_8, iter_1_9 in var_5(var_1_9.island_collection_reward.get_id_list_by_type) do
		arg_1_0.pointAwardGotMaps[iter_1_8] = {}

		local var_1_12 = arg_1_0.pointAwardIdsMaps

		var_1_12[iter_1_8] = iter_1_9
		table = var_1_12

		local var_1_13 = var_1_12.sort
		local var_1_14 = arg_1_0.pointAwardIdsMaps[iter_1_8]

		CompareFuncs = var_1_10012

		var_1_13(var_1_14, var_1_10012({
			function(arg_2_0)
				pg = var_2_10001

				return var_2_10001.island_collection_reward[arg_2_0].level
			end,
			function(arg_3_0)
				return arg_3_0
			end
		}))
	end

	pg = var_5

	local var_1_15 = var_5.island_collection_reward

	ipairs = var_6

	for iter_1_10, iter_1_11 in var_6(var_1_0.book_awards) do
		local var_1_16 = var_1_15[iter_1_11].type

		table = var_1_10012

		var_1_10012.insert(arg_1_0.pointAwardGotMaps[var_1_16], iter_1_11)
	end

	return
end

function var_0_1.CreateClass(arg_4_0, arg_4_1, arg_4_2)
	switch = var_1_10003

	local var_4_0 = arg_4_1
	local var_4_1 = {}

	IslandIllustration = var_1_10006
	var_4_1[var_1_10006.TYPES.CHAR] = function()
		IslandCharIllustration = var_2_10000

		return var_2_10000.New(arg_4_2)
	end
	IslandIllustration = var_6
	var_4_1[var_6.TYPES.ITEM] = function()
		IslandItemIllustration = var_2_10000

		return var_2_10000.New(arg_4_2)
	end
	IslandIllustration = var_6
	var_4_1[var_6.TYPES.FISH] = function()
		IslandFishIllustration = var_2_10000

		return var_2_10000.New(arg_4_2)
	end

	return var_1_10003(var_4_0, var_4_1, function()
		IslandIllustration = var_2_10000

		return var_2_10000.New(arg_4_2)
	end)
end

function var_0_1.SetRecordDatas(arg_9_0, arg_9_1)
	local var_9_0 = {}

	ipairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(arg_9_1) do
		var_9_0[iter_9_1.id] = iter_9_1.num
	end

	pairs = var_3

	local var_9_1 = arg_9_0.dataMap

	IslandIllustration = var_5

	local var_9_2

	if not var_9_1[var_5.TYPES.ITEM] then
		var_9_2 = {}
	end

	for iter_9_2, iter_9_3 in var_3(var_9_2) do
		local var_9_3 = iter_9_3
		local var_9_4 = iter_9_3.SetHistoryCnt
		local var_9_5

		if not var_9_0[iter_9_3:GetLinkConfigID()] then
			var_9_5 = 0
		end

		var_9_4(var_9_3, var_9_5)
	end

	return
end

function var_0_1.SetPointDatas(arg_10_0, arg_10_1)
	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_1 or {}) do
		IslandIllustration = var_1_10007

		local var_10_0

		var_1_10007, var_10_0 = var_1_10007.GetTypeAndLinkId(iter_10_1.id)

		local var_10_1 = arg_10_0.dataMap[var_1_10007][var_10_0]

		var_9.SetPointData(var_10_1, iter_10_1)
	end

	return
end

function var_0_1.InitRuntimeTypesData(arg_11_0)
	arg_11_0:InitShipTypeData()
	arg_11_0:InitFishTypeData()

	return
end

function var_0_1.InitShipTypeData(arg_12_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_12_0 = var_1_10001(var_1_10002)
	local var_12_1 = var_1.GetIsland(var_12_0)
	local var_12_2 = var_1.GetCharacterAgency(var_12_1)

	pairs = var_12_1

	local var_12_3 = arg_12_0.dataMap

	IslandIllustration = var_1_10004

	local var_12_4

	if not var_12_3[var_1_10004.TYPES.CHAR] then
		var_12_4 = {}
	end

	for iter_12_0, iter_12_1 in var_12_1(var_12_4) do
		local var_12_5 = var_12_2
		local var_12_6 = var_12_2.GetShipById
		local var_12_7 = iter_12_1

		if var_12_6(var_12_5, iter_12_1.GetLinkConfigID(var_12_7)) then
			local var_12_8 = iter_12_1
			local var_12_9 = iter_12_1.GetStatus(var_12_8)

			IslandIllustration = var_12_8

			if var_12_9 == var_12_8.STATUS.UNLOCK then
				iter_12_1:CheckTip()
			else
				IslandIllustration = var_8

				if var_12_9 == var_8.STATUS.LOCK then
					local var_12_10 = iter_12_1
					local var_12_11 = iter_12_1.SetStatus

					IslandIllustration = var_12_7

					var_12_11(var_12_10, var_12_7.STATUS.CAN_UNLOCK)
				end
			end
		end
	end

	return
end

function var_0_1.InitFishTypeData(arg_13_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_13_0 = var_1_10001(var_1_10002)
	local var_13_1 = var_1.GetIsland(var_13_0)
	local var_13_2 = var_1.GetFishingAgency(var_13_1)

	pairs = var_13_1

	local var_13_3 = arg_13_0.dataMap

	IslandIllustration = var_1_10004

	local var_13_4

	if not var_13_3[var_1_10004.TYPES.FISH] then
		var_13_4 = {}
	end

	for iter_13_0, iter_13_1 in var_13_1(var_13_4) do
		local var_13_5 = var_13_2
		local var_13_6 = var_13_2.GetFish
		local var_13_7 = iter_13_1

		if var_13_6(var_13_5, iter_13_1.GetLinkConfigID(var_13_7)) then
			local var_13_8 = iter_13_1
			local var_13_9 = iter_13_1.GetStatus(var_13_8)

			IslandIllustration = var_13_8

			if var_13_9 == var_13_8.STATUS.UNLOCK then
				iter_13_1:CheckTip()
			else
				IslandIllustration = var_8

				if var_13_9 == var_8.STATUS.LOCK then
					local var_13_10 = iter_13_1
					local var_13_11 = iter_13_1.SetStatus

					IslandIllustration = var_13_7

					var_13_11(var_13_10, var_13_7.STATUS.CAN_UNLOCK)
				end
			end
		end
	end

	return
end

function var_0_1.GetListByType(arg_14_0, arg_14_1)
	underscore = var_1_10002

	return var_1_10002.values(arg_14_0.dataMap[arg_14_1])
end

function var_0_1.GetIllustration(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0

	if arg_15_0.dataMap[arg_15_1] then
		var_15_0 = arg_15_0.dataMap[arg_15_1][arg_15_2]
	end

	return var_15_0
end

function var_0_1.GetTotalPoints(arg_16_0)
	local var_16_0 = 0

	pairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.dataMap) do
		pairs = var_1_10007

		for iter_16_2, iter_16_3 in var_1_10007(iter_16_1) do
			var_16_0 = var_16_0 + iter_16_3:GetPoints()
		end
	end

	return var_16_0
end

function var_0_1.GetAllPoints(arg_17_0, arg_17_1)
	local var_17_0 = 0

	pairs = var_1_10003

	for iter_17_0, iter_17_1 in var_1_10003(arg_17_0.dataMap[arg_17_1]) do
		var_17_0 = var_17_0 + iter_17_1:GetPoints()
	end

	return var_17_0
end

function var_0_1.GetPoints(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.dataMap[arg_18_1][arg_18_2]

	return var_3.GetPoints(var_18_0)
end

function var_0_1.GetCurLevelPointAwardId(arg_19_0, arg_19_1)
	ipairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(arg_19_0.pointAwardIdsMaps[arg_19_1]) do
		table = var_1_10007

		if not var_1_10007.contains(arg_19_0.pointAwardGotMaps[arg_19_1], iter_19_1) then
			return iter_19_1
		end
	end

	return arg_19_0.pointAwardIdsMaps[arg_19_1][#arg_19_0.pointAwardIdsMaps[arg_19_1]]
end

function var_0_1.GetPointAwardIds(arg_20_0, arg_20_1)
	return arg_20_0.pointAwardIdsMaps[arg_20_1]
end

function var_0_1.GetPointAwardGotIds(arg_21_0, arg_21_1)
	return arg_21_0.pointAwardGotMaps[arg_21_1]
end

function var_0_1.IsGotAllPointAward(arg_22_0, arg_22_1)
	table = var_1_10002

	return var_1_10002.contains(arg_22_0.pointAwardGotMaps[arg_22_1], arg_22_0.pointAwardIdsMaps[arg_22_1][#arg_22_0.pointAwardIdsMaps[arg_22_1]])
end

function var_0_1.GetCurPointInfos(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetCurLevelPointAwardId(arg_23_1)
	local var_23_1 = arg_23_0
	local var_23_2 = arg_23_0.GetAllPoints(var_23_1, arg_23_1)

	pg = var_23_1

	return var_23_2, var_23_1.island_collection_reward[var_23_0].need_exp
end

function var_0_1.AddCanUnlock(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.dataMap[arg_24_1][arg_24_2]
	local var_24_1 = var_3.SetStatus

	IslandIllustration = var_1_10005

	var_24_1(var_24_0, var_1_10005.STATUS.CAN_UNLOCK)

	return
end

function var_0_1.HandlePushData(arg_25_0, arg_25_1)
	IslandIllustration = var_1_10002

	local var_25_0 = var_1_10002.TYPES.ITEM

	ipairs = var_1_10003

	for iter_25_0, iter_25_1 in var_1_10003(arg_25_1) do
		if arg_25_0.dataMap[var_25_0][iter_25_1.id] then
			local var_25_1 = var_8
			local var_25_2 = var_8.GetStatus(var_25_1)

			IslandIllustration = var_25_1

			if var_25_2 == var_25_1.STATUS.LOCK then
				arg_25_0:AddCanUnlock(var_25_0, iter_25_1.id)
			end

			var_8:AddHistoryCnt(iter_25_1.num)
			var_8:CheckTip()
		end
	end

	return
end

function var_0_1.AddUnlock(arg_26_0, arg_26_1)
	ipairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_1) do
		IslandIllustration = var_1_10007

		local var_26_0

		var_1_10007, var_26_0 = var_1_10007.GetTypeAndLinkId(iter_26_1)

		local var_26_1 = arg_26_0.dataMap[var_1_10007][var_26_0]
		local var_26_2 = var_9.SetStatus

		IslandIllustration = var_1_10011

		var_26_2(var_26_1, var_1_10011.STATUS.UNLOCK)

		local var_26_3 = arg_26_0.dataMap[var_1_10007][var_26_0]

		var_9.CheckTip(var_26_3)
	end

	return
end

function var_0_1.AddPointAwardGotId(arg_27_0, arg_27_1)
	pg = var_1_10002

	local var_27_0 = var_1_10002.island_collection_reward[arg_27_1].type

	table = var_1_10003

	var_1_10003.insert(arg_27_0.pointAwardGotMaps[var_27_0], arg_27_1)

	return
end

function var_0_1.OnGetPointDone(arg_28_0, arg_28_1)
	arg_28_0:SetPointDatas(arg_28_1)

	ipairs = var_2

	for iter_28_0, iter_28_1 in var_2(arg_28_1 or {}) do
		IslandIllustration = var_1_10007

		local var_28_0

		var_1_10007, var_28_0 = var_1_10007.GetTypeAndLinkId(iter_28_1.id)

		local var_28_1 = arg_28_0.dataMap[var_1_10007][var_28_0]

		var_9.CheckTip(var_28_1)
	end

	return
end

function var_0_1.OnAddNewShip(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.dataMap

	IslandIllustration = var_1_10003

	if var_29_0[var_1_10003.TYPES.CHAR][arg_29_1] then
		local var_29_1 = var_2
		local var_29_2 = var_2.SetStatus

		IslandIllustration = var_1_10005

		var_29_2(var_29_1, var_1_10005.STATUS.CAN_UNLOCK)
	end

	return
end

function var_0_1.OnShipUpgradeOrBreakOut(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.dataMap

	IslandIllustration = var_1_10003

	if var_30_0[var_1_10003.TYPES.CHAR][arg_30_1] then
		var_2:CheckTip()
	end

	return
end

function var_0_1.OnFishingEnd(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.dataMap

	IslandIllustration = var_1_10003

	if not var_31_0[var_1_10003.TYPES.FISH] then
		local var_31_1 = arg_31_0.dataMap

		IslandIllustration = var_3
		var_31_1[var_3.TYPES.FISH] = {}
	end

	local var_31_2 = arg_31_0.dataMap

	IslandIllustration = var_3

	if var_31_2[var_3.TYPES.FISH][arg_31_1] then
		local var_31_3 = var_2
		local var_31_4 = var_2.GetStatus(var_31_3)

		IslandIllustration = var_31_3

		if var_31_4 == var_31_3.STATUS.LOCK then
			local var_31_5 = arg_31_0
			local var_31_6 = arg_31_0.AddCanUnlock

			IslandIllustration = var_1_10006

			var_31_6(var_31_5, var_1_10006.TYPES.FISH, arg_31_1)
		end

		var_2:CheckTip()
	end

	return
end

function var_0_1.IsTipFromTypes(arg_32_0, arg_32_1)
	ipairs = var_1_10002

	for iter_32_0, iter_32_1 in var_1_10002(arg_32_1) do
		IslandIllustration = var_1_10007

		if iter_32_1 == var_1_10007.TYPES.FISH then
			IslandMainBtnTipHelper = var_1_10007

			if var_1_10007.IsUnlock("book_fish") then
				local var_32_0

				var_1_10007, var_32_0 = arg_32_0:GetCurPointInfos(iter_32_1)

				if not arg_32_0:IsGotAllPointAward(iter_32_1) and var_32_0 <= var_1_10007 then
					return true
				end

				pairs = var_11

				local var_32_1

				if not arg_32_0.dataMap[iter_32_1] then
					var_32_1 = {}
				end

				for iter_32_2, iter_32_3 in var_11(var_32_1) do
					if iter_32_3:IsTip() then
						return true
					end
				end
			end
		end
	end

	return false
end

return var_0_1
