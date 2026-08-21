local var_0_0 = class("TownActivity2", import("model.vo.Activity"))

var_0_0.Thousand = 1000
var_0_0.Million = 1000000
var_0_0.Billion = 0
var_0_0.MaxGold = 99999999999
var_0_0.OPERATION = {
	CLICK_BUBBLE = 4,
	SETTLE_GOLD = 5,
	UPGRADE_PLACE = 2,
	CHANGE_SHIPS = 3,
	UPGRADE_TOWN = 1,
	ALL_GOLD = 6
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.listLVList = pg.activity_town_2[arg_1_0.id].level_up_gold
	arg_1_0.listLVList2 = {}

	for iter_1_0 = 1, #arg_1_0.listLVList do
		table.insert(arg_1_0.listLVList2, (arg_1_0:OnSettleGold2(iter_1_0)))
	end

	arg_1_0.bubbleTipTag = false
	arg_1_0.placeData, arg_1_0.slotData = {}, {}
	arg_1_0.nextplaceData = {}
	arg_1_0.settleGold, arg_1_0.totalGold = 0, 0
	arg_1_0.totalGold2 = 0
	arg_1_0.AllGold = 0

	for iter_1_1, iter_1_2 in ipairs(arg_1_1.date1_key_value_list) do
		if iter_1_2.key == 1 then
			for iter_1_3, iter_1_4 in ipairs(iter_1_2.value_list) do
				local var_1_0 = TownWorkplace2.New(iter_1_4.key, iter_1_4.value)

				if var_1_0:GetGroup() ~= -1 then
					arg_1_0.placeData[var_1_0:GetGroup()] = var_1_0
				end
			end
		end

		if iter_1_2.key == 2 then
			for iter_1_5, iter_1_6 in ipairs(iter_1_2.value_list) do
				arg_1_0.slotData[iter_1_5] = TownBubbleSlot2.New(iter_1_5, iter_1_6.key, iter_1_6.value)
			end
		end

		if iter_1_2.key == 3 then
			for iter_1_7, iter_1_8 in ipairs(iter_1_2.value_list) do
				if iter_1_8.key == 1 then
					arg_1_0.settleGold = arg_1_0.settleGold + iter_1_8.value
				end

				if iter_1_8.key == 2 then
					arg_1_0.settleGold = arg_1_0.settleGold + iter_1_8.value * var_0_0.Million
				end

				if iter_1_8.key == 3 then
					arg_1_0.settleGold = arg_1_0.settleGold + iter_1_8.value * var_0_0.Billion
				end
			end
		end

		if iter_1_2.key == 4 then
			for iter_1_9, iter_1_10 in ipairs(iter_1_2.value_list) do
				if iter_1_9 == 1 then
					arg_1_0.totalGold2 = arg_1_0.totalGold2 + iter_1_10.value

					break
				end
			end
		end

		if iter_1_2.key == 5 then
			for iter_1_11, iter_1_12 in ipairs(iter_1_2.value_list) do
				if iter_1_12.key == 1 then
					arg_1_0.AllGold = arg_1_0.AllGold + iter_1_12.value
				end

				if iter_1_12.key == 2 then
					arg_1_0.AllGold = arg_1_0.AllGold + iter_1_12.value * var_0_0.Million
				end

				if iter_1_12.key == 3 then
					arg_1_0.AllGold = arg_1_0.AllGold + iter_1_12.value * var_0_0.Billion
				end
			end
		end
	end

	arg_1_0:UpdateTotalGold()
	arg_1_0:UpdateEmptySlots()

	return
end

function var_0_0.GetPtAllGold(arg_2_0)
	return arg_2_0.AllGold or 0
end

function var_0_0.AddAllGold(arg_3_0, arg_3_1)
	arg_3_0.AllGold = arg_3_0.AllGold + arg_3_1

	return
end

function var_0_0.GetTownLevel(arg_4_0)
	return arg_4_0:TownLevel()
end

function var_0_0.GetGold(arg_5_0)
	return arg_5_0.totalGold
end

function var_0_0.GetGold2(arg_6_0)
	return arg_6_0.totalGold2
end

function var_0_0.AddGold(arg_7_0, arg_7_1)
	arg_7_0.settleGold = arg_7_0.settleGold + arg_7_1

	arg_7_0:UpdateTotalGold()

	return
end

function var_0_0.AddGold2(arg_8_0, arg_8_1)
	arg_8_0.totalGold2 = arg_8_0.totalGold2 + arg_8_1

	return
end

function var_0_0.GoldFull(arg_9_0)
	local var_9_0 = arg_9_0:GetLimitGold()

	if var_9_0 <= arg_9_0.settleGold then
		return false
	elseif var_9_0 > arg_9_0.settleGold then
		return true
	end

	return false
end

function var_0_0.UpgradeGold(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.placeData) do
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

function var_0_0.GetplaceUpgrade(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.placeData) do
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

function var_0_0.GetUpgradeGold(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.placeData) do
		if iter_12_1:GetId() == arg_12_1 then
			return iter_12_1:GetUpgrade()
		end
	end

	return
end

function var_0_0.GetLimitGold(arg_13_0)
	local var_13_0

	for iter_13_0 = 1, #arg_13_0.placeData do
		if arg_13_0.placeData[iter_13_0]:GetType() == TownWorkplace2.TYPE.RATIO then
			var_13_0 = arg_13_0.placeData[iter_13_0]
		end
	end

	return var_13_0:GetTypeParam() or 0
end

function var_0_0.TownLevel(arg_14_0)
	local var_14_0 = arg_14_0:GetPtAllGold()
	local var_14_1 = 0

	while true do
		local var_14_2

		if var_14_0 < arg_14_0.listLVList2[1] then
			var_14_1 = 1

			break
		elseif arg_14_0.listLVList2[1 + 1] then
			var_14_2 = 1 + 1
		else
			break
		end
	end

	if var_14_0 > arg_14_0.listLVList2[#arg_14_0.listLVList2] then
		var_14_1 = #arg_14_0.listLVList2 + 1
	end

	return var_14_1
end

function var_0_0.OnSettleGold2(arg_15_0, arg_15_1)
	local var_15_0 = 0

	for iter_15_0 = arg_15_1, 1, -1 do
		var_15_0 = var_15_0 + arg_15_0:OnlistLVList(iter_15_0)
	end

	return var_15_0
end

function var_0_0.OnlistLVList(arg_16_0, arg_16_1)
	return arg_16_0.listLVList[arg_16_1]
end

function var_0_0.GetTotalGold(arg_17_0)
	return math.min(arg_17_0.totalGold, arg_17_0:GetLimitGold())
end

function var_0_0.GetUnlockSlotCnt(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.placeData) do
		if iter_18_1:GetType() == TownWorkplace2.TYPE.ROLE then
			return iter_18_1:GetTypeParam()
		end
	end

	return
end

function var_0_0.GetGoldOutput(arg_19_0)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in pairs(arg_19_0.placeData) do
		var_19_0 = var_19_0 + math.floor(iter_19_1:GetGoldUnit())
	end

	return var_19_0
end

function var_0_0.UpdateGoldBuff(arg_20_0)
	arg_20_0.buffFactor = 0

	for iter_20_0, iter_20_1 in pairs(arg_20_0.placeData) do
		arg_20_0.buffFactor = arg_20_0.buffFactor + iter_20_1:GetGoldRatio()
	end

	arg_20_0.buffFactor = arg_20_0.buffFactor / 16

	return
end

function var_0_0.UpdateTime(arg_21_0)
	local var_21_0 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_21_0, iter_21_1 in pairs(arg_21_0.slotData) do
		iter_21_1:OnUpdateTime(var_21_0)
	end

	if arg_21_0.totalGold >= arg_21_0:GetLimitGold() or arg_21_0.totalGold >= var_0_0.MaxGold then
		arg_21_0.totalGold = arg_21_0:GetLimitGold()

		return
	end

	arg_21_0:UpdateTotalGold()

	return
end

function var_0_0.UpdateTotalGold(arg_22_0)
	arg_22_0.totalGold = math.min(arg_22_0.settleGold, arg_22_0:GetLimitGold())

	return
end

function var_0_0.GetPlaceList(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.placeData) do
		table.insert({}, iter_23_1)
	end

	return {}
end

function var_0_0.CanUpgradePlace(arg_24_0, arg_24_1)
	return
end

function var_0_0.ResetIdPlace(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.placeData) do
		if iter_25_1:GetId() == arg_25_2 then
			local var_25_1 = iter_25_1:ResetStartTime(arg_25_1)
		end
	end

	return
end

function var_0_0.OnUpgradePlace(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0.placeData[pg.activity_town_work_level_2[arg_26_1].group]:GetUpgrade()

	arg_26_0:ResetIdPlace(arg_26_2, arg_26_1)

	for iter_26_0, iter_26_1 in ipairs({
		"settleGold",
		"totalGold2"
	}) do
		if var_26_0[iter_26_0] then
			arg_26_0[iter_26_1] = arg_26_0[iter_26_1] - var_26_0[iter_26_0][3]
		end
	end

	arg_26_0.placeData[pg.activity_town_work_level_2[arg_26_1].group] = TownWorkplace2.New(arg_26_0.placeData[pg.activity_town_work_level_2[arg_26_1].group]:GetNextId(), arg_26_2)

	arg_26_0:UpdateTotalGold(arg_26_2)
	arg_26_0:UpdateEmptySlots()

	return
end

function var_0_0.OnResetIdPlace(arg_27_0, arg_27_1, arg_27_2)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.placeData) do
		local var_27_0

		if iter_27_1:GetId() == arg_27_2 then
			var_27_0 = 0 + math.floor((iter_27_1:ResetStartTime(arg_27_1)))
		end
	end

	return
end

function var_0_0.OnGatherPlaceGold(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0:OnResetIdPlace(arg_28_2, arg_28_1)

	arg_28_0.placeData[pg.activity_town_work_level_2[arg_28_1].group] = TownWorkplace2.New(arg_28_0.placeData[pg.activity_town_work_level_2[arg_28_1].group]:GetId(), arg_28_2)

	arg_28_0:UpdateTotalGold(arg_28_2)

	return
end

function var_0_0.OnAllGatherPlaceGold(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		if iter_29_0 % 2 == 0 then
			table.insert({}, iter_29_1)
		elseif iter_29_0 % 2 ~= 0 then
			table.insert({}, iter_29_1)
		end
	end

	for iter_29_2 = 1, #{} do
		arg_29_0:OnResetIdPlace(({})[iter_29_2], {})

		arg_29_0.placeData[pg.activity_town_work_level_2[({})[iter_29_2]].group] = TownWorkplace2.New(arg_29_0.placeData[pg.activity_town_work_level_2[({})[iter_29_2]].group]:GetId(), ({})[iter_29_2])

		arg_29_0:UpdateTotalGold(({})[iter_29_2])
	end

	return
end

function var_0_0.UpdateEmptySlots(arg_30_0)
	for iter_30_0 = 1, arg_30_0:GetUnlockSlotCnt() do
		arg_30_0.slotData[iter_30_0] = arg_30_0.slotData[iter_30_0] or TownBubbleSlot2.New(iter_30_0)
	end

	return
end

function var_0_0.GetShipIds(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.slotData) do
		table.insert({}, iter_31_1:GetShipId())
	end

	return {}
end

function var_0_0.GetBubbleCntByPos(arg_32_0, arg_32_1)
	return arg_32_0.slotData[arg_32_1]:GetPassCnt()
end

function var_0_0.OnChangeShips(arg_33_0, arg_33_1)
	arg_33_0:UpdateEmptySlots()

	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		arg_33_0.slotData[iter_33_1.key]:ChangeShip(iter_33_1.value)
	end

	return
end

function var_0_0.OnGetBubbleAward(arg_34_0, arg_34_1, arg_34_2)
	for iter_34_0, iter_34_1 in ipairs(arg_34_1) do
		arg_34_0.slotData[iter_34_1]:ResetStartTime(arg_34_2[iter_34_0])
	end

	return
end

function var_0_0.SetBubbleTipTag(arg_35_0, arg_35_1)
	arg_35_0.bubbleTipTag = arg_35_1

	return
end

function var_0_0.HasEmptySlot(arg_36_0)
	for iter_36_0, iter_36_1 in pairs(arg_36_0.slotData) do
		if iter_36_1:IsNewEmpty() then
			return true
		end
	end

	return false
end

function var_0_0.HasMaxGold(arg_37_0)
	return arg_37_0.totalGold >= arg_37_0:GetLimitGold()
end

function var_0_0.CanCostGold(arg_38_0)
	if arg_38_0:CanUpgradeTown() then
		return true
	end

	for iter_38_0, iter_38_1 in pairs(arg_38_0.placeData) do
		if arg_38_0:CanUpgradePlace(iter_38_1.id) then
			return true
		end
	end

	return false
end

function var_0_0.getVitemNumber(arg_39_0, arg_39_1)
	assert(pg.item_virtual_data_statistics[arg_39_1].link_id == arg_39_0.id)

	return arg_39_0:GetTotalGold()
end

function var_0_0.subVitemNumber(arg_40_0, arg_40_1, arg_40_2)
	assert(pg.item_virtual_data_statistics[arg_40_1].link_id == arg_40_0.id)

	arg_40_0.settleGold = math.max(0, arg_40_0.settleGold - arg_40_2)
	arg_40_0.totalGold = arg_40_0.settleGold

	return
end

function var_0_0.addVitemNumber(arg_41_0, arg_41_1, arg_41_2)
	return
end

function var_0_0.KeepDecimal(arg_42_0, arg_42_1)
	return math.floor(10^arg_42_1 * arg_42_0) / 10^arg_42_1
end

var_0_0.SHOW_NUM_CNT = 1

function var_0_0.GoldToShow(arg_43_0)
	if arg_43_0 >= var_0_0.MaxGold then
		return 99.99 .. "M"
	end

	if arg_43_0 >= var_0_0.Billion then
		if arg_43_0 % var_0_0.Billion == 0 then
			return arg_43_0 / var_0_0.Billion .. "B"
		end

		return var_0_0.KeepDecimal(arg_43_0 / var_0_0.Billion, 1) .. "B"
	elseif arg_43_0 >= var_0_0.Million then
		if arg_43_0 % var_0_0.Million == 0 then
			return arg_43_0 / var_0_0.Million .. "M"
		end

		return var_0_0.KeepDecimal(arg_43_0 / var_0_0.Million, 1) .. "M"
	elseif arg_43_0 >= var_0_0.Thousand then
		if arg_43_0 % var_0_0.Thousand == 0 then
			return arg_43_0 / var_0_0.Thousand .. "K"
		end

		return var_0_0.KeepDecimal(arg_43_0 / var_0_0.Thousand, 1) .. "K"
	end

	return arg_43_0
end

return var_0_0
