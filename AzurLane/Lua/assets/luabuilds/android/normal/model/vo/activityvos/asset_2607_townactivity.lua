class = var_0_10000

local var_0_0 = "TownActivity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.Activity"))

var_0_1.Thousand = 1000
var_0_1.Million = 1000000
var_0_1.Billion = 0
var_0_1.MaxGold = 99999999999
var_0_1.OPERATION = {
	CLICK_BUBBLE = 4,
	SETTLE_GOLD = 5,
	UPGRADE_PLACE = 2,
	CHANGE_SHIPS = 3,
	UPGRADE_TOWN = 1
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.getConfig(var_1_0, "config_client").storyActID

	pg = var_1_0
	arg_1_0.storyList = var_1_0.activity_template[var_1_1].config_client.story
	pg = var_3
	arg_1_0.levelCfg = var_3.activity_town_level
	arg_1_0.bubbleTipTag = false
	arg_1_0.placeData, arg_1_0.slotData = {}, {}

	local var_1_2 = 0

	arg_1_0.totalGold = 0
	arg_1_0.settleGold = var_1_2
	ipairs = var_1_2

	for iter_1_0, iter_1_1 in var_1_2(arg_1_1.date1_key_value_list) do
		if iter_1_1.key == 1 then
			ipairs = var_8

			for iter_1_2, iter_1_3 in var_8(iter_1_1.value_list) do
				TownWorkplace = var_1_10013

				local var_1_3 = var_1_10013.New(iter_1_3.key, iter_1_3.value)

				if var_1_10013.GetLevel(var_1_3) ~= 0 or arg_1_0.data2 >= var_1_10013:GetNeedTownLv() then
					var_1_10014 = arg_1_0.placeData
					var_1_10014[var_1_10013:GetGroup()] = var_1_10013
				end
			end
		end

		if iter_1_1.key == 2 then
			ipairs = var_8

			for iter_1_4, iter_1_5 in var_8(iter_1_1.value_list) do
				var_1_10013 = arg_1_0.slotData
				TownBubbleSlot = var_1_10014
				var_1_10013[iter_1_4] = var_1_10014.New(iter_1_4, iter_1_5.key, iter_1_5.value)
			end
		end

		if iter_1_1.key == 3 then
			ipairs = var_8

			for iter_1_6, iter_1_7 in var_8(iter_1_1.value_list) do
				if iter_1_7.key == 1 then
					arg_1_0.settleGold = arg_1_0.settleGold + iter_1_7.value
				end

				if iter_1_7.key == 2 then
					arg_1_0.settleGold = arg_1_0.settleGold + iter_1_7.value * var_0_1.Million
				end

				if iter_1_7.key == 3 then
					arg_1_0.settleGold = arg_1_0.settleGold + iter_1_7.value * var_0_1.Billion
				end
			end
		end
	end

	arg_1_0:UpdateEmptySlots()
	arg_1_0:UpdateGoldBuff()

	return
end

function var_0_1.GetExp(arg_2_0)
	return arg_2_0.data1
end

function var_0_1.AddExp(arg_3_0, arg_3_1)
	arg_3_0.data1 = arg_3_0.data1 + arg_3_1

	return
end

function var_0_1.AddGold(arg_4_0, arg_4_1)
	math = var_1_10002
	arg_4_0.settleGold = var_1_10002.min(arg_4_0.settleGold + arg_4_1, arg_4_0:GetLimitGold())

	return
end

function var_0_1.GetTownLevel(arg_5_0)
	return arg_5_0.data2
end

function var_0_1.IsMaxTownLevel(arg_6_0)
	return not arg_6_0.levelCfg[arg_6_0:GetTownLevel() + 1]
end

function var_0_1.UpgradeTownLevel(arg_7_0)
	arg_7_0.data2 = arg_7_0.data2 + 1

	return
end

function var_0_1.GetUnlockSlotCnt(arg_8_0)
	return arg_8_0.levelCfg[arg_8_0.data2].unlock_chara
end

function var_0_1.GetGoldOutput(arg_9_0)
	local var_9_0 = 0

	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.placeData) do
		math = var_1_10007
		var_9_0 = var_9_0 + var_1_10007.floor(iter_9_1:GetGoldUnit() * 16 * (1 + arg_9_0.buffFactor))
	end

	return var_9_0
end

function var_0_1.GetLimitGold(arg_10_0)
	return arg_10_0.levelCfg[arg_10_0.data2].gold_max
end

function var_0_1.GetTotalGold(arg_11_0)
	math = var_1_10001

	return var_1_10001.min(arg_11_0.totalGold, arg_11_0:GetLimitGold())
end

function var_0_1.UpdateGoldBuff(arg_12_0)
	arg_12_0.buffFactor = 0
	pairs = var_1

	for iter_12_0, iter_12_1 in var_1(arg_12_0.placeData) do
		arg_12_0.buffFactor = arg_12_0.buffFactor + iter_12_1:GetGoldRatio()
	end

	arg_12_0.buffFactor = arg_12_0.buffFactor / 16

	return
end

function var_0_1.UpdateTime(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.TimeMgr.GetInstance()
	local var_13_1 = var_1.GetServerTime(var_13_0)

	pairs = var_13_0

	for iter_13_0, iter_13_1 in var_13_0(arg_13_0.slotData) do
		iter_13_1:OnUpdateTime(var_13_1)
	end

	if arg_13_0.totalGold >= arg_13_0:GetLimitGold() or arg_13_0.totalGold >= var_0_1.MaxGold then
		arg_13_0.totalGold = arg_13_0:GetLimitGold()

		return
	end

	arg_13_0:UpdateTotalGold(var_13_1)

	return
end

function var_0_1.UpdateTotalGold(arg_14_0, arg_14_1)
	local var_14_0 = 0

	pairs = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10003(arg_14_0.placeData) do
		iter_14_1:OnUpdateTime(arg_14_1)

		math = var_8
		var_14_0 = var_14_0 + var_8.floor(iter_14_1:GetStoredGold() * (1 + arg_14_0.buffFactor))
	end

	math = var_3
	arg_14_0.totalGold = var_3.min(arg_14_0.settleGold + var_14_0, arg_14_0:GetLimitGold())

	return
end

function var_0_1.GetUnlockStoryCnt(arg_15_0)
	underscore = var_1_10001

	local var_15_0 = var_1_10001.reduce

	underscore = var_1_10002

	return var_15_0(var_1_10002.flatten(arg_15_0.storyList), 0, function(arg_16_0, arg_16_1)
		pg = var_2_10002

		local var_16_0 = var_2_10002.NewStoryMgr.GetInstance()

		return arg_16_0 + (var_2.IsPlayed(var_16_0, arg_16_1) and 1 or 0)
	end)
end

function var_0_1.CanUpgradeTown(arg_17_0)
	if arg_17_0:IsMaxTownLevel() then
		return false, "max"
	end

	if arg_17_0.totalGold < arg_17_0.levelCfg[arg_17_0:GetTownLevel()].gold then
		return false, "no_exp_or_gold", "no_gold"
	end

	if arg_17_0:GetExp() < arg_17_0.levelCfg[arg_17_0:GetTownLevel()].exp then
		return false, "no_exp_or_gold", "no_exp"
	end

	if arg_17_0:GetUnlockStoryCnt() < arg_17_0.levelCfg[arg_17_0:GetTownLevel()].story then
		return false, "no_story", {
			var_1,
			var_2
		}
	end

	return true, "normal"
end

function var_0_1.GetPlaceList(arg_18_0)
	local var_18_0 = {}

	pairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_0.placeData) do
		table = var_1_10007

		var_1_10007.insert(var_18_0, iter_18_1)
	end

	return var_18_0
end

function var_0_1.OnUpgradeTown(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.levelCfg[arg_19_0:GetTownLevel()].gold

	arg_19_0:ResetAllPlace(arg_19_1)
	arg_19_0:UpgradeTownLevel()

	arg_19_0.settleGold = arg_19_0.settleGold - var_19_0
	ipairs = var_3

	for iter_19_0, iter_19_1 in var_3(arg_19_0.levelCfg[arg_19_0:GetTownLevel()].unlock_work[1]) do
		TownWorkplace = var_1_10008
		var_1_10008 = var_1_10008.New(iter_19_1, arg_19_1)
		arg_19_0.placeData[var_1_10008:GetGroup()] = var_1_10008
	end

	arg_19_0:UpdateTotalGold(arg_19_1)
	arg_19_0:UpdateEmptySlots()

	return
end

function var_0_1.ResetAllPlace(arg_20_0, arg_20_1)
	local var_20_0 = 0

	pairs = var_1_10003

	for iter_20_0, iter_20_1 in var_1_10003(arg_20_0.placeData) do
		local var_20_1 = iter_20_1
		local var_20_2 = iter_20_1.ResetStartTime(var_20_1, arg_20_1)

		math = var_20_1
		var_20_0 = var_20_0 + var_20_1.floor(var_20_2 * (1 + arg_20_0.buffFactor))
	end

	arg_20_0:AddGold(var_20_0)

	return
end

function var_0_1.CanUpgradePlace(arg_21_0, arg_21_1)
	pg = var_1_10002

	local var_21_0 = var_1_10002.activity_town_work_level[arg_21_1].group
	local var_21_1 = arg_21_0.placeData[var_21_0]

	if not var_3.GetNextId(var_21_1) then
		return false, "max"
	end

	if arg_21_0:GetTownLevel() < var_3:GetNeedTownLv() then
		return false, "no_level"
	end

	if arg_21_0.totalGold < var_3:GetCostGold() then
		return false, "no_gold"
	end

	return true, "normal"
end

function var_0_1.OnUpgradePlace(arg_22_0, arg_22_1, arg_22_2)
	pg = var_1_10003

	local var_22_0 = var_1_10003.activity_town_work_level[arg_22_1].group
	local var_22_1 = arg_22_0.placeData[var_22_0]
	local var_22_2 = var_4.GetCostGold(var_22_1)
	local var_22_3 = arg_22_0

	arg_22_0.ResetAllPlace(var_22_3, arg_22_2)

	arg_22_0.settleGold = arg_22_0.settleGold - var_22_2

	local var_22_4 = arg_22_0.placeData

	TownWorkplace = var_22_3
	var_22_4[var_22_0] = var_22_3.New(var_4:GetNextId(), arg_22_2)

	arg_22_0:UpdateTotalGold(arg_22_2)

	local var_22_5 = var_4
	local var_22_6 = var_4.GetType(var_22_5)

	TownWorkplace = var_22_5

	if var_22_6 == var_22_5.TYPE.RATIO then
		arg_22_0:UpdateGoldBuff()
	end

	return
end

function var_0_1.UpdateEmptySlots(arg_23_0)
	for iter_23_0 = 1, arg_23_0:GetUnlockSlotCnt() do
		if not arg_23_0.slotData[iter_23_0] then
			local var_23_0 = arg_23_0.slotData

			TownBubbleSlot = var_1_10006
			var_23_0[iter_23_0] = var_1_10006.New(iter_23_0)
		end
	end

	return
end

function var_0_1.GetShipIds(arg_24_0)
	local var_24_0 = {}

	pairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_0.slotData) do
		table = var_1_10007

		var_1_10007.insert(var_24_0, iter_24_1:GetShipId())
	end

	return var_24_0
end

function var_0_1.GetBubbleCntByPos(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.slotData[arg_25_1]

	return var_2.GetPassCnt(var_25_0)
end

function var_0_1.OnChangeShips(arg_26_0, arg_26_1)
	ipairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_1) do
		local var_26_0 = arg_26_0.slotData[iter_26_1.key]

		var_7.ChangeShip(var_26_0, iter_26_1.value)
	end

	return
end

function var_0_1.OnGetBubbleAward(arg_27_0, arg_27_1, arg_27_2)
	ipairs = var_1_10003

	for iter_27_0, iter_27_1 in var_1_10003(arg_27_1) do
		local var_27_0 = arg_27_0.slotData[iter_27_1]

		var_8.ResetStartTime(var_27_0, arg_27_2[iter_27_0])
	end

	return
end

function var_0_1.OnSettleGold(arg_28_0, arg_28_1)
	arg_28_0:ResetAllPlace(arg_28_1)
	arg_28_0:UpdateTotalGold(arg_28_1)

	return
end

function var_0_1.SetBubbleTipTag(arg_29_0, arg_29_1)
	arg_29_0.bubbleTipTag = arg_29_1

	return
end

function var_0_1.HasEmptySlot(arg_30_0)
	pairs = var_1_10001

	for iter_30_0, iter_30_1 in var_1_10001(arg_30_0.slotData) do
		if iter_30_1:IsNewEmpty() then
			return true
		end
	end

	return false
end

function var_0_1.HasMaxGold(arg_31_0)
	return arg_31_0.totalGold >= arg_31_0:GetLimitGold()
end

function var_0_1.IsOverGold(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1 * 1000
	local var_32_1 = arg_32_0.totalGold + var_32_0
	local var_32_2 = arg_32_0

	if var_32_1 <= arg_32_0.GetLimitGold(var_32_2) then
		return false
	else
		local var_32_3 = arg_32_0:GetLimitGold() - (arg_32_0.totalGold + var_32_0)
		local var_32_4 = true

		math = var_32_2

		local var_32_5 = var_32_2.floor(var_32_3 / 1000)

		return
	end

	return
end

function var_0_1.CanCostGold(arg_33_0)
	if arg_33_0:CanUpgradeTown() then
		return true
	end

	pairs = var_1

	for iter_33_0, iter_33_1 in var_1(arg_33_0.placeData) do
		if arg_33_0:CanUpgradePlace(iter_33_1.id) then
			return true
		end
	end

	return false
end

function var_0_1.ShowBubbleTip(arg_34_0)
	if arg_34_0.bubbleTipTag then
		return false
	end

	pairs = var_1

	for iter_34_0, iter_34_1 in var_1(arg_34_0.slotData) do
		if iter_34_1:GetPassCnt() > 0 then
			return true
		end
	end

	return false
end

function var_0_1.GetAllVitems(arg_35_0)
	return {}
end

function var_0_1.getVitemNumber(arg_36_0, arg_36_1)
	assert = var_1_10002
	pg = var_1_10003

	var_1_10002(var_1_10003.item_virtual_data_statistics[arg_36_1].link_id == arg_36_0.id)

	return arg_36_0:GetTotalGold()
end

function var_0_1.subVitemNumber(arg_37_0, arg_37_1, arg_37_2)
	assert = var_1_10003
	pg = var_1_10004

	var_1_10003(var_1_10004.item_virtual_data_statistics[arg_37_1].link_id == arg_37_0.id)

	math = var_1_10003
	arg_37_0.settleGold = var_1_10003.max(0, arg_37_0.settleGold - arg_37_2)
	arg_37_0.totalGold = arg_37_0.settleGold

	return
end

function var_0_1.addVitemNumber(arg_38_0, arg_38_1, arg_38_2)
	return
end

function var_0_1.KeepDecimal(arg_39_0, arg_39_1)
	math = var_1_10002

	return var_1_10002.floor(10^arg_39_1 * arg_39_0) / 10^arg_39_1
end

var_0_1.SHOW_NUM_CNT = 4

function var_0_1.GoldToShow(arg_40_0)
	if arg_40_0 >= var_0_1.MaxGold then
		return 99.99 .. "M"
	end

	if arg_40_0 / 1000 >= var_0_1.Billion then
		if arg_40_0 % var_0_1.Billion == 0 then
			return arg_40_0 / var_0_1.Billion .. "B"
		end

		local var_40_0 = arg_40_0 / var_0_1.Billion
		local var_40_1 = var_0_1.SHOW_NUM_CNT

		tostring = var_1_10003
		math = var_1_10004

		local var_40_2 = var_40_1 - #var_1_10003(var_1_10004.floor(var_40_0))

		return var_0_1.KeepDecimal(var_40_0, var_40_2) .. "B"
	elseif arg_40_0 >= var_0_1.Million then
		if arg_40_0 % var_0_1.Million == 0 then
			return arg_40_0 / var_0_1.Million .. "M"
		end

		local var_40_3 = arg_40_0 / var_0_1.Million
		local var_40_4 = var_0_1.SHOW_NUM_CNT

		tostring = var_1_10003
		math = var_1_10004

		local var_40_5 = var_40_4 - #var_1_10003(var_1_10004.floor(var_40_3))

		return var_0_1.KeepDecimal(var_40_3, var_40_5) .. "M"
	elseif arg_40_0 >= var_0_1.Thousand then
		if arg_40_0 % var_0_1.Thousand == 0 then
			return arg_40_0 / var_0_1.Thousand .. "K"
		end

		local var_40_6 = arg_40_0 / var_0_1.Thousand
		local var_40_7 = var_0_1.SHOW_NUM_CNT

		tostring = var_1_10003
		math = var_1_10004

		local var_40_8 = var_40_7 - #var_1_10003(var_1_10004.floor(var_40_6))

		return var_0_1.KeepDecimal(var_40_6, var_40_8) .. "K"
	end

	return arg_40_0
end

return var_0_1
