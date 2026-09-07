local TownActivity = class("TownActivity", import("model.vo.Activity"))

TownActivity.Thousand = 1000
TownActivity.Million = 1000000
TownActivity.Billion = 0
TownActivity.MaxGold = 99999999999
TownActivity.OPERATION = {
	CLICK_BUBBLE = 4,
	SETTLE_GOLD = 5,
	UPGRADE_PLACE = 2,
	CHANGE_SHIPS = 3,
	UPGRADE_TOWN = 1
}

function TownActivity:Ctor(arg_1_1)
	TownActivity.super.Ctor(self, arg_1_1)

	self.storyList = pg.activity_template[self:getConfig("config_client").storyActID].config_client.story
	self.levelCfg = pg.activity_town_level
	self.bubbleTipTag = false
	self.placeData, self.slotData = {}, {}
	self.settleGold, self.totalGold = 0, 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.date1_key_value_list) do
		if iter_1_1.key == 1 then
			for iter_1_2, iter_1_3 in ipairs(iter_1_1.value_list) do
				local var_1_0 = TownWorkplace.New(iter_1_3.key, iter_1_3.value)

				if var_1_0:GetLevel() ~= 0 or self.data2 >= var_1_0:GetNeedTownLv() then
					self.placeData[var_1_0:GetGroup()] = var_1_0
				end
			end
		end

		if iter_1_1.key == 2 then
			for iter_1_4, iter_1_5 in ipairs(iter_1_1.value_list) do
				self.slotData[iter_1_4] = TownBubbleSlot.New(iter_1_4, iter_1_5.key, iter_1_5.value)
			end
		end

		if iter_1_1.key == 3 then
			for iter_1_6, iter_1_7 in ipairs(iter_1_1.value_list) do
				if iter_1_7.key == 1 then
					self.settleGold = self.settleGold + iter_1_7.value
				end

				if iter_1_7.key == 2 then
					self.settleGold = self.settleGold + iter_1_7.value * TownActivity.Million
				end

				if iter_1_7.key == 3 then
					self.settleGold = self.settleGold + iter_1_7.value * TownActivity.Billion
				end
			end
		end
	end

	self:UpdateEmptySlots()
	self:UpdateGoldBuff()

	return
end

function TownActivity:GetExp()
	return self.data1
end

function TownActivity:AddExp(arg_3_1)
	self.data1 = self.data1 + arg_3_1

	return
end

function TownActivity:AddGold(arg_4_1)
	self.settleGold = math.min(self.settleGold + arg_4_1, self:GetLimitGold())

	return
end

function TownActivity:GetTownLevel()
	return self.data2
end

function TownActivity:IsMaxTownLevel()
	return not self.levelCfg[self:GetTownLevel() + 1]
end

function TownActivity:UpgradeTownLevel()
	self.data2 = self.data2 + 1

	return
end

function TownActivity:GetUnlockSlotCnt()
	return self.levelCfg[self.data2].unlock_chara
end

function TownActivity:GetGoldOutput()
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in pairs(self.placeData) do
		var_9_0 = var_9_0 + math.floor(iter_9_1:GetGoldUnit() * 16 * (1 + self.buffFactor))
	end

	return var_9_0
end

function TownActivity:GetLimitGold()
	return self.levelCfg[self.data2].gold_max
end

function TownActivity:GetTotalGold()
	return math.min(self.totalGold, self:GetLimitGold())
end

function TownActivity:UpdateGoldBuff()
	self.buffFactor = 0

	for iter_12_0, iter_12_1 in pairs(self.placeData) do
		self.buffFactor = self.buffFactor + iter_12_1:GetGoldRatio()
	end

	self.buffFactor = self.buffFactor / 16

	return
end

function TownActivity:UpdateTime()
	local var_13_0 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_13_0, iter_13_1 in pairs(self.slotData) do
		iter_13_1:OnUpdateTime(var_13_0)
	end

	if self.totalGold >= self:GetLimitGold() or self.totalGold >= TownActivity.MaxGold then
		self.totalGold = self:GetLimitGold()

		return
	end

	self:UpdateTotalGold(var_13_0)

	return
end

function TownActivity:UpdateTotalGold(arg_14_1)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(self.placeData) do
		iter_14_1:OnUpdateTime(arg_14_1)

		var_14_0 = var_14_0 + math.floor(iter_14_1:GetStoredGold() * (1 + self.buffFactor))
	end

	self.totalGold = math.min(self.settleGold + var_14_0, self:GetLimitGold())

	return
end

function TownActivity:GetUnlockStoryCnt()
	return underscore.reduce(underscore.flatten(self.storyList), 0, function(arg_16_0, arg_16_1)
		return arg_16_0 + (pg.NewStoryMgr.GetInstance():IsPlayed(arg_16_1) and 1 or 0)
	end)
end

function TownActivity:CanUpgradeTown()
	if self:IsMaxTownLevel() then
		return false, "max"
	end

	if self.totalGold < self.levelCfg[self:GetTownLevel()].gold then
		return false, "no_exp_or_gold", "no_gold"
	end

	if self:GetExp() < self.levelCfg[self:GetTownLevel()].exp then
		return false, "no_exp_or_gold", "no_exp"
	end

	local var_17_0 = self:GetUnlockStoryCnt()
	local var_17_1 = self.levelCfg[self:GetTownLevel()].story

	if var_17_0 < var_17_1 then
		return false, "no_story", {
			var_17_0,
			var_17_1
		}
	end

	return true, "normal"
end

function TownActivity:GetPlaceList()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(self.placeData) do
		table.insert(var_18_0, iter_18_1)
	end

	return var_18_0
end

function TownActivity:OnUpgradeTown(arg_19_1)
	self:ResetAllPlace(arg_19_1)
	self:UpgradeTownLevel()

	self.settleGold = self.settleGold - self.levelCfg[self:GetTownLevel()].gold

	for iter_19_0, iter_19_1 in ipairs(self.levelCfg[self:GetTownLevel()].unlock_work[1]) do
		local var_19_0 = TownWorkplace.New(iter_19_1, arg_19_1)

		self.placeData[var_19_0:GetGroup()] = var_19_0
	end

	self:UpdateTotalGold(arg_19_1)
	self:UpdateEmptySlots()

	return
end

function TownActivity:ResetAllPlace(arg_20_1)
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in pairs(self.placeData) do
		var_20_0 = var_20_0 + math.floor(iter_20_1:ResetStartTime(arg_20_1) * (1 + self.buffFactor))
	end

	self:AddGold(var_20_0)

	return
end

function TownActivity:CanUpgradePlace(arg_21_1)
	if not self.placeData[pg.activity_town_work_level[arg_21_1].group]:GetNextId() then
		return false, "max"
	end

	if self:GetTownLevel() < self.placeData[pg.activity_town_work_level[arg_21_1].group]:GetNeedTownLv() then
		return false, "no_level"
	end

	if self.totalGold < self.placeData[pg.activity_town_work_level[arg_21_1].group]:GetCostGold() then
		return false, "no_gold"
	end

	return true, "normal"
end

function TownActivity:OnUpgradePlace(arg_22_1, arg_22_2)
	self:ResetAllPlace(arg_22_2)

	self.settleGold = self.settleGold - self.placeData[pg.activity_town_work_level[arg_22_1].group]:GetCostGold()
	self.placeData[pg.activity_town_work_level[arg_22_1].group] = TownWorkplace.New(self.placeData[pg.activity_town_work_level[arg_22_1].group]:GetNextId(), arg_22_2)

	self:UpdateTotalGold(arg_22_2)

	if self.placeData[pg.activity_town_work_level[arg_22_1].group]:GetType() == TownWorkplace.TYPE.RATIO then
		self:UpdateGoldBuff()
	end

	return
end

function TownActivity:UpdateEmptySlots()
	for iter_23_0 = 1, self:GetUnlockSlotCnt() do
		self.slotData[iter_23_0] = self.slotData[iter_23_0] or TownBubbleSlot.New(iter_23_0)
	end

	return
end

function TownActivity:GetShipIds()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(self.slotData) do
		table.insert(var_24_0, iter_24_1:GetShipId())
	end

	return var_24_0
end

function TownActivity:GetBubbleCntByPos(arg_25_1)
	return self.slotData[arg_25_1]:GetPassCnt()
end

function TownActivity:OnChangeShips(arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		self.slotData[iter_26_1.key]:ChangeShip(iter_26_1.value)
	end

	return
end

function TownActivity:OnGetBubbleAward(arg_27_1, arg_27_2)
	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		self.slotData[iter_27_1]:ResetStartTime(arg_27_2[iter_27_0])
	end

	return
end

function TownActivity:OnSettleGold(arg_28_1)
	self:ResetAllPlace(arg_28_1)
	self:UpdateTotalGold(arg_28_1)

	return
end

function TownActivity:SetBubbleTipTag(arg_29_1)
	self.bubbleTipTag = arg_29_1

	return
end

function TownActivity:HasEmptySlot()
	for iter_30_0, iter_30_1 in pairs(self.slotData) do
		if iter_30_1:IsNewEmpty() then
			return true
		end
	end

	return false
end

function TownActivity:HasMaxGold()
	return self.totalGold >= self:GetLimitGold()
end

function TownActivity:IsOverGold(arg_32_1)
	if self.totalGold + arg_32_1 * 1000 <= self:GetLimitGold() then
		return false
	else
		local var_32_1 = math.floor((self:GetLimitGold() - (self.totalGold + arg_32_1 * 1000)) / 1000)

		return
	end

	return
end

function TownActivity:CanCostGold()
	if self:CanUpgradeTown() then
		return true
	end

	for iter_33_0, iter_33_1 in pairs(self.placeData) do
		if self:CanUpgradePlace(iter_33_1.id) then
			return true
		end
	end

	return false
end

function TownActivity:ShowBubbleTip()
	if self.bubbleTipTag then
		return false
	end

	for iter_34_0, iter_34_1 in pairs(self.slotData) do
		if iter_34_1:GetPassCnt() > 0 then
			return true
		end
	end

	return false
end

function TownActivity:GetAllVitems()
	return {}
end

function TownActivity:getVitemNumber(arg_36_1)
	assert(pg.item_virtual_data_statistics[arg_36_1].link_id == self.id)

	return self:GetTotalGold()
end

function TownActivity:subVitemNumber(arg_37_1, arg_37_2)
	assert(pg.item_virtual_data_statistics[arg_37_1].link_id == self.id)

	self.settleGold = math.max(0, self.settleGold - arg_37_2)
	self.totalGold = self.settleGold

	return
end

function TownActivity:addVitemNumber(arg_38_1, arg_38_2)
	return
end

function TownActivity:KeepDecimal(arg_39_1)
	return math.floor(10^arg_39_1 * self) / 10^arg_39_1
end

TownActivity.SHOW_NUM_CNT = 4

function TownActivity:GoldToShow()
	if self >= TownActivity.MaxGold then
		return 99.99 .. "M"
	end

	self = self / 1000

	if self >= TownActivity.Billion then
		if self % TownActivity.Billion == 0 then
			return self / TownActivity.Billion .. "B"
		end

		return TownActivity.KeepDecimal(self / TownActivity.Billion, TownActivity.SHOW_NUM_CNT - #tostring(math.floor(self / TownActivity.Billion))) .. "B"
	elseif self >= TownActivity.Million then
		if self % TownActivity.Million == 0 then
			return self / TownActivity.Million .. "M"
		end

		return TownActivity.KeepDecimal(self / TownActivity.Million, TownActivity.SHOW_NUM_CNT - #tostring(math.floor(self / TownActivity.Million))) .. "M"
	elseif self >= TownActivity.Thousand then
		if self % TownActivity.Thousand == 0 then
			return self / TownActivity.Thousand .. "K"
		end

		return TownActivity.KeepDecimal(self / TownActivity.Thousand, TownActivity.SHOW_NUM_CNT - #tostring(math.floor(self / TownActivity.Thousand))) .. "K"
	end

	return self
end

return TownActivity
