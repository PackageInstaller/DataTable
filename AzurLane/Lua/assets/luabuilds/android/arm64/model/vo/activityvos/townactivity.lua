local var_0_0 = class("TownActivity", import("model.vo.Activity"))

var_0_0.Thousand = 1000
var_0_0.Million = 1000000
var_0_0.Billion = 0
var_0_0.MaxGold = 99999999999
var_0_0.OPERATION = {
	CLICK_BUBBLE = 4,
	SETTLE_GOLD = 5,
	UPGRADE_PLACE = 2,
	CHANGE_SHIPS = 3,
	UPGRADE_TOWN = 1
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.storyList = pg.activity_template[arg_1_0:getConfig("config_client").storyActID].config_client.story
	arg_1_0.levelCfg = pg.activity_town_level
	arg_1_0.bubbleTipTag = false
	arg_1_0.placeData, arg_1_0.slotData = {}, {}
	arg_1_0.settleGold, arg_1_0.totalGold = 0, 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.date1_key_value_list) do
		if iter_1_1.key == 1 then
			for iter_1_2, iter_1_3 in ipairs(iter_1_1.value_list) do
				local var_1_0 = TownWorkplace.New(iter_1_3.key, iter_1_3.value)

				if var_1_0:GetLevel() ~= 0 or arg_1_0.data2 >= var_1_0:GetNeedTownLv() then
					arg_1_0.placeData[var_1_0:GetGroup()] = var_1_0
				end
			end
		end

		if iter_1_1.key == 2 then
			for iter_1_4, iter_1_5 in ipairs(iter_1_1.value_list) do
				arg_1_0.slotData[iter_1_4] = TownBubbleSlot.New(iter_1_4, iter_1_5.key, iter_1_5.value)
			end
		end

		if iter_1_1.key == 3 then
			for iter_1_6, iter_1_7 in ipairs(iter_1_1.value_list) do
				if iter_1_7.key == 1 then
					arg_1_0.settleGold = arg_1_0.settleGold + iter_1_7.value
				end

				if iter_1_7.key == 2 then
					arg_1_0.settleGold = arg_1_0.settleGold + iter_1_7.value * var_0_0.Million
				end

				if iter_1_7.key == 3 then
					arg_1_0.settleGold = arg_1_0.settleGold + iter_1_7.value * var_0_0.Billion
				end
			end
		end
	end

	arg_1_0:UpdateEmptySlots()
	arg_1_0:UpdateGoldBuff()

	return
end

function var_0_0.GetExp(arg_2_0)
	return arg_2_0.data1
end

function var_0_0.AddExp(arg_3_0, arg_3_1)
	arg_3_0.data1 = arg_3_0.data1 + arg_3_1

	return
end

function var_0_0.AddGold(arg_4_0, arg_4_1)
	arg_4_0.settleGold = math.min(arg_4_0.settleGold + arg_4_1, arg_4_0:GetLimitGold())

	return
end

function var_0_0.GetTownLevel(arg_5_0)
	return arg_5_0.data2
end

function var_0_0.IsMaxTownLevel(arg_6_0)
	return not arg_6_0.levelCfg[arg_6_0:GetTownLevel() + 1]
end

function var_0_0.UpgradeTownLevel(arg_7_0)
	arg_7_0.data2 = arg_7_0.data2 + 1

	return
end

function var_0_0.GetUnlockSlotCnt(arg_8_0)
	return arg_8_0.levelCfg[arg_8_0.data2].unlock_chara
end

function var_0_0.GetGoldOutput(arg_9_0)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in pairs(arg_9_0.placeData) do
		var_9_0 = var_9_0 + math.floor(iter_9_1:GetGoldUnit() * 16 * (1 + arg_9_0.buffFactor))
	end

	return var_9_0
end

function var_0_0.GetLimitGold(arg_10_0)
	return arg_10_0.levelCfg[arg_10_0.data2].gold_max
end

function var_0_0.GetTotalGold(arg_11_0)
	return math.min(arg_11_0.totalGold, arg_11_0:GetLimitGold())
end

function var_0_0.UpdateGoldBuff(arg_12_0)
	arg_12_0.buffFactor = 0

	for iter_12_0, iter_12_1 in pairs(arg_12_0.placeData) do
		arg_12_0.buffFactor = arg_12_0.buffFactor + iter_12_1:GetGoldRatio()
	end

	arg_12_0.buffFactor = arg_12_0.buffFactor / 16

	return
end

function var_0_0.UpdateTime(arg_13_0)
	local var_13_0 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_13_0, iter_13_1 in pairs(arg_13_0.slotData) do
		iter_13_1:OnUpdateTime(var_13_0)
	end

	if arg_13_0.totalGold >= arg_13_0:GetLimitGold() or arg_13_0.totalGold >= var_0_0.MaxGold then
		arg_13_0.totalGold = arg_13_0:GetLimitGold()

		return
	end

	arg_13_0:UpdateTotalGold(var_13_0)

	return
end

function var_0_0.UpdateTotalGold(arg_14_0, arg_14_1)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_0.placeData) do
		iter_14_1:OnUpdateTime(arg_14_1)

		var_14_0 = var_14_0 + math.floor(iter_14_1:GetStoredGold() * (1 + arg_14_0.buffFactor))
	end

	arg_14_0.totalGold = math.min(arg_14_0.settleGold + var_14_0, arg_14_0:GetLimitGold())

	return
end

function var_0_0.GetUnlockStoryCnt(arg_15_0)
	return underscore.reduce(underscore.flatten(arg_15_0.storyList), 0, function(arg_16_0, arg_16_1)
		local var_16_0 = pg.NewStoryMgr.GetInstance()

		return arg_16_0 + (var_16_0:IsPlayed(arg_16_1) and 1 or 0)
	end)
end

function var_0_0.CanUpgradeTown(arg_17_0)
	if arg_17_0:IsMaxTownLevel() then
		return false, "max"
	end

	if arg_17_0.totalGold < arg_17_0.levelCfg[arg_17_0:GetTownLevel()].gold then
		return false, "no_exp_or_gold", "no_gold"
	end

	if arg_17_0:GetExp() < arg_17_0.levelCfg[arg_17_0:GetTownLevel()].exp then
		return false, "no_exp_or_gold", "no_exp"
	end

	local var_17_0 = arg_17_0:GetUnlockStoryCnt()
	local var_17_1 = arg_17_0.levelCfg[arg_17_0:GetTownLevel()].story

	if var_17_0 < var_17_1 then
		return false, "no_story", {
			var_17_0,
			var_17_1
		}
	end

	return true, "normal"
end

function var_0_0.GetPlaceList(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.placeData) do
		table.insert({}, iter_18_1)
	end

	return {}
end

function var_0_0.OnUpgradeTown(arg_19_0, arg_19_1)
	arg_19_0:ResetAllPlace(arg_19_1)
	arg_19_0:UpgradeTownLevel()

	arg_19_0.settleGold = arg_19_0.settleGold - arg_19_0.levelCfg[arg_19_0:GetTownLevel()].gold

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.levelCfg[arg_19_0:GetTownLevel()].unlock_work[1]) do
		local var_19_0 = TownWorkplace.New(iter_19_1, arg_19_1)
		local var_19_1 = var_19_0:GetGroup()

		arg_19_0.placeData[var_19_1] = var_19_0
	end

	arg_19_0:UpdateTotalGold(arg_19_1)
	arg_19_0:UpdateEmptySlots()

	return
end

function var_0_0.ResetAllPlace(arg_20_0, arg_20_1)
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in pairs(arg_20_0.placeData) do
		var_20_0 = var_20_0 + math.floor(iter_20_1:ResetStartTime(arg_20_1) * (1 + arg_20_0.buffFactor))
	end

	arg_20_0:AddGold(var_20_0)

	return
end

function var_0_0.CanUpgradePlace(arg_21_0, arg_21_1)
	if not arg_21_0.placeData[pg.activity_town_work_level[arg_21_1].group]:GetNextId() then
		return false, "max"
	end

	if arg_21_0:GetTownLevel() < arg_21_0.placeData[pg.activity_town_work_level[arg_21_1].group]:GetNeedTownLv() then
		return false, "no_level"
	end

	if arg_21_0.totalGold < arg_21_0.placeData[pg.activity_town_work_level[arg_21_1].group]:GetCostGold() then
		return false, "no_gold"
	end

	return true, "normal"
end

function var_0_0.OnUpgradePlace(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:ResetAllPlace(arg_22_2)

	arg_22_0.settleGold = arg_22_0.settleGold - arg_22_0.placeData[pg.activity_town_work_level[arg_22_1].group]:GetCostGold()
	arg_22_0.placeData[pg.activity_town_work_level[arg_22_1].group] = TownWorkplace.New(arg_22_0.placeData[pg.activity_town_work_level[arg_22_1].group]:GetNextId(), arg_22_2)

	arg_22_0:UpdateTotalGold(arg_22_2)

	if arg_22_0.placeData[pg.activity_town_work_level[arg_22_1].group]:GetType() == TownWorkplace.TYPE.RATIO then
		arg_22_0:UpdateGoldBuff()
	end

	return
end

function var_0_0.UpdateEmptySlots(arg_23_0)
	for iter_23_0 = 1, arg_23_0:GetUnlockSlotCnt() do
		arg_23_0.slotData[iter_23_0] = arg_23_0.slotData[iter_23_0] or TownBubbleSlot.New(iter_23_0)
	end

	return
end

function var_0_0.GetShipIds(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.slotData) do
		table.insert({}, iter_24_1:GetShipId())
	end

	return {}
end

function var_0_0.GetBubbleCntByPos(arg_25_0, arg_25_1)
	return arg_25_0.slotData[arg_25_1]:GetPassCnt()
end

function var_0_0.OnChangeShips(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		arg_26_0.slotData[iter_26_1.key]:ChangeShip(iter_26_1.value)
	end

	return
end

function var_0_0.OnGetBubbleAward(arg_27_0, arg_27_1, arg_27_2)
	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		arg_27_0.slotData[iter_27_1]:ResetStartTime(arg_27_2[iter_27_0])
	end

	return
end

function var_0_0.OnSettleGold(arg_28_0, arg_28_1)
	arg_28_0:ResetAllPlace(arg_28_1)
	arg_28_0:UpdateTotalGold(arg_28_1)

	return
end

function var_0_0.SetBubbleTipTag(arg_29_0, arg_29_1)
	arg_29_0.bubbleTipTag = arg_29_1

	return
end

function var_0_0.HasEmptySlot(arg_30_0)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.slotData) do
		if iter_30_1:IsNewEmpty() then
			return true
		end
	end

	return false
end

function var_0_0.HasMaxGold(arg_31_0)
	return arg_31_0.totalGold >= arg_31_0:GetLimitGold()
end

function var_0_0.IsOverGold(arg_32_0, arg_32_1)
	local var_32_0

	if arg_32_0.totalGold + arg_32_1 * 1000 <= arg_32_0:GetLimitGold() then
		do return false end

		goto label_32_0

		var_32_0 = true
	end

	do
		local var_32_1 = math.floor((arg_32_0:GetLimitGold() - (arg_32_0.totalGold + arg_32_1 * 1000)) / 1000)

		return
	end

	::label_32_0::

	return
end

function var_0_0.CanCostGold(arg_33_0)
	if arg_33_0:CanUpgradeTown() then
		return true
	end

	for iter_33_0, iter_33_1 in pairs(arg_33_0.placeData) do
		if arg_33_0:CanUpgradePlace(iter_33_1.id) then
			return true
		end
	end

	return false
end

function var_0_0.ShowBubbleTip(arg_34_0)
	if arg_34_0.bubbleTipTag then
		return false
	end

	for iter_34_0, iter_34_1 in pairs(arg_34_0.slotData) do
		if iter_34_1:GetPassCnt() > 0 then
			return true
		end
	end

	return false
end

function var_0_0.GetAllVitems(arg_35_0)
	return {}
end

function var_0_0.getVitemNumber(arg_36_0, arg_36_1)
	assert(pg.item_virtual_data_statistics[arg_36_1].link_id == arg_36_0.id)

	return arg_36_0:GetTotalGold()
end

function var_0_0.subVitemNumber(arg_37_0, arg_37_1, arg_37_2)
	assert(pg.item_virtual_data_statistics[arg_37_1].link_id == arg_37_0.id)

	arg_37_0.settleGold = math.max(0, arg_37_0.settleGold - arg_37_2)
	arg_37_0.totalGold = arg_37_0.settleGold

	return
end

function var_0_0.addVitemNumber(arg_38_0, arg_38_1, arg_38_2)
	return
end

function var_0_0.KeepDecimal(arg_39_0, arg_39_1)
	return math.floor(10^arg_39_1 * arg_39_0) / 10^arg_39_1
end

var_0_0.SHOW_NUM_CNT = 4

function var_0_0.GoldToShow(arg_40_0)
	if arg_40_0 >= var_0_0.MaxGold then
		return 99.99 .. "M"
	end

	arg_40_0 = arg_40_0 / 1000

	if arg_40_0 >= var_0_0.Billion then
		if arg_40_0 % var_0_0.Billion == 0 then
			return arg_40_0 / var_0_0.Billion .. "B"
		end

		return var_0_0.KeepDecimal(arg_40_0 / var_0_0.Billion, var_0_0.SHOW_NUM_CNT - #tostring(math.floor(arg_40_0 / var_0_0.Billion))) .. "B"
	elseif arg_40_0 >= var_0_0.Million then
		if arg_40_0 % var_0_0.Million == 0 then
			return arg_40_0 / var_0_0.Million .. "M"
		end

		return var_0_0.KeepDecimal(arg_40_0 / var_0_0.Million, var_0_0.SHOW_NUM_CNT - #tostring(math.floor(arg_40_0 / var_0_0.Million))) .. "M"
	elseif arg_40_0 >= var_0_0.Thousand then
		if arg_40_0 % var_0_0.Thousand == 0 then
			return arg_40_0 / var_0_0.Thousand .. "K"
		end

		return var_0_0.KeepDecimal(arg_40_0 / var_0_0.Thousand, var_0_0.SHOW_NUM_CNT - #tostring(math.floor(arg_40_0 / var_0_0.Thousand))) .. "K"
	end

	return arg_40_0
end

return var_0_0
