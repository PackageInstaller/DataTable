class = var_0_10000

local var_0_0 = "TownActivity2"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.Activity"))

var_0_1.Thousand = 1000
var_0_1.Million = 1000000
var_0_1.Billion = 0
var_0_1.MaxGold = 99999999999
var_0_1.OPERATION = {
	CLICK_BUBBLE = 4,
	SETTLE_GOLD = 5,
	UPGRADE_PLACE = 2,
	CHANGE_SHIPS = 3,
	UPGRADE_TOWN = 1,
	ALL_GOLD = 6
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	pg = var_2
	arg_1_0.listLVList = var_2.activity_town_2[arg_1_0.id].level_up_gold
	arg_1_0.listLVList2 = {}

	for iter_1_0 = 1, #arg_1_0.listLVList do
		local var_1_0 = arg_1_0:OnSettleGold2(iter_1_0)

		table = var_1_10007

		var_1_10007.insert(arg_1_0.listLVList2, var_1_0)
	end

	arg_1_0.bubbleTipTag = false
	arg_1_0.placeData, arg_1_0.slotData = {}, {}
	arg_1_0.nextplaceData = {}
	arg_1_0.settleGold, arg_1_0.totalGold = 0, 0
	arg_1_0.totalGold2 = 0
	arg_1_0.AllGold = 0
	ipairs = var_2

	for iter_1_1, iter_1_2 in var_2(arg_1_1.date1_key_value_list) do
		if iter_1_2.key == 1 then
			ipairs = var_7

			for iter_1_3, iter_1_4 in var_7(iter_1_2.value_list) do
				TownWorkplace2 = var_1_10012

				local var_1_1 = var_1_10012.New(iter_1_4.key, iter_1_4.value)

				if var_1_10012.GetGroup(var_1_1) ~= -1 then
					var_1_10013 = arg_1_0.placeData
					var_1_10013[var_1_10012:GetGroup()] = var_1_10012
				end
			end
		end

		if iter_1_2.key == 2 then
			ipairs = var_7

			for iter_1_5, iter_1_6 in var_7(iter_1_2.value_list) do
				var_1_10012 = arg_1_0.slotData
				TownBubbleSlot2 = var_1_10013
				var_1_10012[iter_1_5] = var_1_10013.New(iter_1_5, iter_1_6.key, iter_1_6.value)
			end
		end

		if iter_1_2.key == 3 then
			ipairs = var_7

			for iter_1_7, iter_1_8 in var_7(iter_1_2.value_list) do
				if iter_1_8.key == 1 then
					arg_1_0.settleGold = arg_1_0.settleGold + iter_1_8.value
				end

				if iter_1_8.key == 2 then
					arg_1_0.settleGold = arg_1_0.settleGold + iter_1_8.value * var_0_1.Million
				end

				if iter_1_8.key == 3 then
					arg_1_0.settleGold = arg_1_0.settleGold + iter_1_8.value * var_0_1.Billion
				end
			end
		end

		if iter_1_2.key == 4 then
			ipairs = var_7

			for iter_1_9, iter_1_10 in var_7(iter_1_2.value_list) do
				if iter_1_9 == 1 then
					arg_1_0.totalGold2 = arg_1_0.totalGold2 + iter_1_10.value

					break
				end
			end
		end

		if iter_1_2.key == 5 then
			ipairs = var_7

			for iter_1_11, iter_1_12 in var_7(iter_1_2.value_list) do
				if iter_1_12.key == 1 then
					arg_1_0.AllGold = arg_1_0.AllGold + iter_1_12.value
				end

				if iter_1_12.key == 2 then
					arg_1_0.AllGold = arg_1_0.AllGold + iter_1_12.value * var_0_1.Million
				end

				if iter_1_12.key == 3 then
					arg_1_0.AllGold = arg_1_0.AllGold + iter_1_12.value * var_0_1.Billion
				end
			end
		end
	end

	arg_1_0:UpdateTotalGold()
	arg_1_0:UpdateEmptySlots()

	return
end

function var_0_1.GetPtAllGold(arg_2_0)
	local var_2_0

	if not arg_2_0.AllGold then
		var_2_0 = 0
	end

	return var_2_0
end

function var_0_1.AddAllGold(arg_3_0, arg_3_1)
	arg_3_0.AllGold = arg_3_0.AllGold + arg_3_1

	return
end

function var_0_1.GetTownLevel(arg_4_0)
	return arg_4_0:TownLevel()
end

function var_0_1.GetGold(arg_5_0)
	return arg_5_0.totalGold
end

function var_0_1.GetGold2(arg_6_0)
	return arg_6_0.totalGold2
end

function var_0_1.AddGold(arg_7_0, arg_7_1)
	arg_7_0.settleGold = arg_7_0.settleGold + arg_7_1

	arg_7_0:UpdateTotalGold()

	return
end

function var_0_1.AddGold2(arg_8_0, arg_8_1)
	arg_8_0.totalGold2 = arg_8_0.totalGold2 + arg_8_1

	return
end

function var_0_1.GoldFull(arg_9_0)
	if arg_9_0:GetLimitGold() <= arg_9_0.settleGold then
		return false
	elseif var_1 > arg_9_0.settleGold then
		return true
	end

	return false
end

function var_0_1.UpgradeGold(arg_10_0, arg_10_1)
	pairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.placeData) do
		if iter_10_1:GetId() == arg_10_1 then
			if #iter_10_1:GetUpgrade() == 1 then
				if arg_10_0:GetGold() >= iter_10_1:GetUpgrade()[1][3] then
					return true
				end
			elseif #iter_10_1:GetUpgrade() == 2 and arg_10_0:GetGold() >= iter_10_1:GetUpgrade()[1][3] and arg_10_0:GetGold2() >= iter_10_1:GetUpgrade()[2][3] then
				return true
			end
		end
	end

	return false
end

function var_0_1.GetplaceUpgrade(arg_11_0, arg_11_1)
	pairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0.placeData) do
		if iter_11_1:GetId() == arg_11_1 and iter_11_1:GetType() == 1 then
			if iter_11_1:GetTypeParam() == 0 then
				return false
			elseif iter_11_1:GetTypeParam() > 0 and iter_11_1:GetType() == 1 then
				return true
			end
		end
	end

	return
end

function var_0_1.GetUpgradeGold(arg_12_0, arg_12_1)
	pairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0.placeData) do
		if iter_12_1:GetId() == arg_12_1 then
			return iter_12_1:GetUpgrade()
		end
	end

	return
end

function var_0_1.GetLimitGold(arg_13_0)
	local var_13_0

	for iter_13_0 = 1, #arg_13_0.placeData do
		local var_13_1 = arg_13_0.placeData[iter_13_0]
		local var_13_2 = var_6.GetType(var_13_1)

		TownWorkplace2 = var_1_10007

		if var_13_2 == var_1_10007.TYPE.RATIO then
			var_13_0 = arg_13_0.placeData[iter_13_0]
		end
	end

	local var_13_3

	if not var_13_0:GetTypeParam() then
		var_13_3 = 0
	end

	return var_13_3
end

function var_0_1.TownLevel(arg_14_0)
	local var_14_0 = arg_14_0:GetPtAllGold()
	local var_14_1 = 0
	local var_14_2 = 1

	while true do
		if var_14_0 < arg_14_0.listLVList2[var_14_2] then
			var_14_1 = var_14_2

			break
		elseif arg_14_0.listLVList2[var_14_2 + 1] then
			var_14_2 = var_14_2 + 1
		else
			break
		end
	end

	if var_14_0 > arg_14_0.listLVList2[#arg_14_0.listLVList2] then
		var_14_1 = #arg_14_0.listLVList2 + 1
	end

	return var_14_1
end

function var_0_1.OnSettleGold2(arg_15_0, arg_15_1)
	local var_15_0 = 0

	for iter_15_0 = arg_15_1, 1, -1 do
		var_15_0 = var_15_0 + arg_15_0:OnlistLVList(iter_15_0)
	end

	return var_15_0
end

function var_0_1.OnlistLVList(arg_16_0, arg_16_1)
	return arg_16_0.listLVList[arg_16_1]
end

function var_0_1.GetTotalGold(arg_17_0)
	math = var_1_10001

	return var_1_10001.min(arg_17_0.totalGold, arg_17_0:GetLimitGold())
end

function var_0_1.GetUnlockSlotCnt(arg_18_0)
	pairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0.placeData) do
		local var_18_0 = iter_18_1:GetType()

		TownWorkplace2 = var_1_10007

		if var_18_0 == var_1_10007.TYPE.ROLE then
			return iter_18_1:GetTypeParam()
		end
	end

	return
end

function var_0_1.GetGoldOutput(arg_19_0)
	local var_19_0 = 0

	pairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(arg_19_0.placeData) do
		math = var_1_10007
		var_19_0 = var_19_0 + var_1_10007.floor(iter_19_1:GetGoldUnit())
	end

	return var_19_0
end

function var_0_1.UpdateGoldBuff(arg_20_0)
	arg_20_0.buffFactor = 0
	pairs = var_1

	for iter_20_0, iter_20_1 in var_1(arg_20_0.placeData) do
		arg_20_0.buffFactor = arg_20_0.buffFactor + iter_20_1:GetGoldRatio()
	end

	arg_20_0.buffFactor = arg_20_0.buffFactor / 16

	return
end

function var_0_1.UpdateTime(arg_21_0)
	pg = var_1_10001

	local var_21_0 = var_1_10001.TimeMgr.GetInstance()
	local var_21_1 = var_1.GetServerTime(var_21_0)

	pairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_0.slotData) do
		iter_21_1:OnUpdateTime(var_21_1)
	end

	if arg_21_0.totalGold >= arg_21_0:GetLimitGold() or arg_21_0.totalGold >= var_0_1.MaxGold then
		arg_21_0.totalGold = arg_21_0:GetLimitGold()

		return
	end

	arg_21_0:UpdateTotalGold()

	return
end

function var_0_1.UpdateTotalGold(arg_22_0)
	math = var_1_10001
	arg_22_0.totalGold = var_1_10001.min(arg_22_0.settleGold, arg_22_0:GetLimitGold())

	return
end

function var_0_1.GetPlaceList(arg_23_0)
	local var_23_0 = {}

	pairs = var_1_10002

	for iter_23_0, iter_23_1 in var_1_10002(arg_23_0.placeData) do
		table = var_1_10007

		var_1_10007.insert(var_23_0, iter_23_1)
	end

	return var_23_0
end

function var_0_1.CanUpgradePlace(arg_24_0, arg_24_1)
	return
end

function var_0_1.ResetIdPlace(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = 0

	pairs = var_1_10004

	for iter_25_0, iter_25_1 in var_1_10004(arg_25_0.placeData) do
		if iter_25_1:GetId() == arg_25_2 then
			local var_25_1 = iter_25_1:ResetStartTime(arg_25_1)
		end
	end

	return
end

function var_0_1.OnUpgradePlace(arg_26_0, arg_26_1, arg_26_2)
	pg = var_1_10003

	local var_26_0 = var_1_10003.activity_town_work_level_2[arg_26_1].group
	local var_26_1 = arg_26_0.placeData[var_26_0]
	local var_26_2 = var_4.GetUpgrade(var_26_1)

	arg_26_0:ResetIdPlace(arg_26_2, arg_26_1)

	ipairs = var_6

	for iter_26_0, iter_26_1 in var_6({
		"settleGold",
		"totalGold2"
	}) do
		if var_26_2[iter_26_0] then
			arg_26_0[iter_26_1] = arg_26_0[iter_26_1] - var_26_2[iter_26_0][3]
		end
	end

	local var_26_3 = arg_26_0.placeData

	TownWorkplace2 = var_7
	var_26_3[var_26_0] = var_7.New(var_4:GetNextId(), arg_26_2)

	arg_26_0:UpdateTotalGold(arg_26_2)
	arg_26_0:UpdateEmptySlots()

	return
end

function var_0_1.OnResetIdPlace(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = 0

	pairs = var_1_10004

	for iter_27_0, iter_27_1 in var_1_10004(arg_27_0.placeData) do
		if iter_27_1:GetId() == arg_27_2 then
			local var_27_1 = iter_27_1:ResetStartTime(arg_27_1)

			math = var_1_10010
			var_27_0 = var_27_0 + var_1_10010.floor(var_27_1)
		end
	end

	return
end

function var_0_1.OnGatherPlaceGold(arg_28_0, arg_28_1, arg_28_2)
	pg = var_1_10003

	local var_28_0 = var_1_10003.activity_town_work_level_2[arg_28_1].group
	local var_28_1 = arg_28_0.placeData[var_28_0]

	arg_28_0:OnResetIdPlace(arg_28_2, arg_28_1)

	local var_28_2 = arg_28_0.placeData

	TownWorkplace2 = var_1_10006
	var_28_2[var_28_0] = var_1_10006.New(var_28_1:GetId(), arg_28_2)

	arg_28_0:UpdateTotalGold(arg_28_2)

	return
end

function var_0_1.OnAllGatherPlaceGold(arg_29_0, arg_29_1)
	local var_29_0 = {}
	local var_29_1 = {}

	ipairs = var_1_10004

	for iter_29_0, iter_29_1 in var_1_10004(arg_29_1) do
		if iter_29_0 % 2 == 0 then
			table = var_9

			var_9.insert(var_29_1, iter_29_1)
		elseif iter_29_0 % 2 ~= 0 then
			table = var_9

			var_9.insert(var_29_0, iter_29_1)
		end
	end

	for iter_29_2 = 1, #var_29_0 do
		pg = iter_29_1
		iter_29_1 = iter_29_1.activity_town_work_level_2[var_29_0[iter_29_2]].group

		local var_29_2 = arg_29_0.placeData[iter_29_1]

		arg_29_0:OnResetIdPlace(var_29_1[iter_29_2], var_29_0)

		local var_29_3 = arg_29_0.placeData

		TownWorkplace2 = var_1_10011
		var_29_3[iter_29_1] = var_1_10011.New(var_29_2:GetId(), var_29_1[iter_29_2])

		arg_29_0:UpdateTotalGold(var_29_1[iter_29_2])
	end

	return
end

function var_0_1.UpdateEmptySlots(arg_30_0)
	for iter_30_0 = 1, arg_30_0:GetUnlockSlotCnt() do
		if not arg_30_0.slotData[iter_30_0] then
			local var_30_0 = arg_30_0.slotData

			TownBubbleSlot2 = var_1_10006
			var_30_0[iter_30_0] = var_1_10006.New(iter_30_0)
		end
	end

	return
end

function var_0_1.GetShipIds(arg_31_0)
	local var_31_0 = {}

	pairs = var_1_10002

	for iter_31_0, iter_31_1 in var_1_10002(arg_31_0.slotData) do
		table = var_1_10007

		var_1_10007.insert(var_31_0, iter_31_1:GetShipId())
	end

	return var_31_0
end

function var_0_1.GetBubbleCntByPos(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.slotData[arg_32_1]

	return var_2.GetPassCnt(var_32_0)
end

function var_0_1.OnChangeShips(arg_33_0, arg_33_1)
	arg_33_0:UpdateEmptySlots()

	ipairs = var_2

	for iter_33_0, iter_33_1 in var_2(arg_33_1) do
		local var_33_0 = arg_33_0.slotData[iter_33_1.key]

		var_7.ChangeShip(var_33_0, iter_33_1.value)
	end

	return
end

function var_0_1.OnGetBubbleAward(arg_34_0, arg_34_1, arg_34_2)
	ipairs = var_1_10003

	for iter_34_0, iter_34_1 in var_1_10003(arg_34_1) do
		local var_34_0 = arg_34_0.slotData[iter_34_1]

		var_8.ResetStartTime(var_34_0, arg_34_2[iter_34_0])
	end

	return
end

function var_0_1.SetBubbleTipTag(arg_35_0, arg_35_1)
	arg_35_0.bubbleTipTag = arg_35_1

	return
end

function var_0_1.HasEmptySlot(arg_36_0)
	pairs = var_1_10001

	for iter_36_0, iter_36_1 in var_1_10001(arg_36_0.slotData) do
		if iter_36_1:IsNewEmpty() then
			return true
		end
	end

	return false
end

function var_0_1.HasMaxGold(arg_37_0)
	return arg_37_0.totalGold >= arg_37_0:GetLimitGold()
end

function var_0_1.CanCostGold(arg_38_0)
	if arg_38_0:CanUpgradeTown() then
		return true
	end

	pairs = var_1

	for iter_38_0, iter_38_1 in var_1(arg_38_0.placeData) do
		if arg_38_0:CanUpgradePlace(iter_38_1.id) then
			return true
		end
	end

	return false
end

function var_0_1.getVitemNumber(arg_39_0, arg_39_1)
	assert = var_1_10002
	pg = var_1_10004

	var_1_10002(var_1_10004.item_virtual_data_statistics[arg_39_1].link_id == arg_39_0.id)

	return arg_39_0:GetTotalGold()
end

function var_0_1.subVitemNumber(arg_40_0, arg_40_1, arg_40_2)
	assert = var_1_10003
	pg = var_1_10005

	var_1_10003(var_1_10005.item_virtual_data_statistics[arg_40_1].link_id == arg_40_0.id)

	math = var_1_10003
	arg_40_0.settleGold = var_1_10003.max(0, arg_40_0.settleGold - arg_40_2)
	arg_40_0.totalGold = arg_40_0.settleGold

	return
end

function var_0_1.addVitemNumber(arg_41_0, arg_41_1, arg_41_2)
	return
end

function var_0_1.KeepDecimal(arg_42_0, arg_42_1)
	math = var_1_10002

	return var_1_10002.floor(10^arg_42_1 * arg_42_0) / 10^arg_42_1
end

var_0_1.SHOW_NUM_CNT = 1

function var_0_1.GoldToShow(arg_43_0)
	if arg_43_0 >= var_0_1.MaxGold then
		return 99.99 .. "M"
	end

	if arg_43_0 >= var_0_1.Billion then
		if arg_43_0 % var_0_1.Billion == 0 then
			return arg_43_0 / var_0_1.Billion .. "B"
		end

		local var_43_0 = arg_43_0 / var_0_1.Billion

		return var_0_1.KeepDecimal(var_43_0, 1) .. "B"
	elseif arg_43_0 >= var_0_1.Million then
		if arg_43_0 % var_0_1.Million == 0 then
			return arg_43_0 / var_0_1.Million .. "M"
		end

		local var_43_1 = arg_43_0 / var_0_1.Million

		return var_0_1.KeepDecimal(var_43_1, 1) .. "M"
	elseif arg_43_0 >= var_0_1.Thousand then
		if arg_43_0 % var_0_1.Thousand == 0 then
			return arg_43_0 / var_0_1.Thousand .. "K"
		end

		local var_43_2 = arg_43_0 / var_0_1.Thousand

		return var_0_1.KeepDecimal(var_43_2, 1) .. "K"
	end

	return arg_43_0
end

return var_0_1
