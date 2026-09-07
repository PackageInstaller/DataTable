local TownActivity2 = class("TownActivity2", import("model.vo.Activity"))

TownActivity2.Thousand = 1000
TownActivity2.Million = 1000000
TownActivity2.Billion = 0
TownActivity2.MaxGold = 99999999999
TownActivity2.OPERATION = {
	CLICK_BUBBLE = 4,
	SETTLE_GOLD = 5,
	UPGRADE_PLACE = 2,
	CHANGE_SHIPS = 3,
	UPGRADE_TOWN = 1,
	ALL_GOLD = 6
}

function TownActivity2:Ctor(arg_1_1)
	TownActivity2.super.Ctor(self, arg_1_1)

	self.listLVList = pg.activity_town_2[self.id].level_up_gold
	self.listLVList2 = {}

	for iter_1_0 = 1, #self.listLVList do
		table.insert(self.listLVList2, (self:OnSettleGold2(iter_1_0)))
	end

	self.bubbleTipTag = false
	self.placeData, self.slotData = {}, {}
	self.nextplaceData = {}
	self.settleGold, self.totalGold = 0, 0
	self.totalGold2 = 0
	self.AllGold = 0

	for iter_1_1, iter_1_2 in ipairs(arg_1_1.date1_key_value_list) do
		if iter_1_2.key == 1 then
			for iter_1_3, iter_1_4 in ipairs(iter_1_2.value_list) do
				local var_1_0 = TownWorkplace2.New(iter_1_4.key, iter_1_4.value)

				if var_1_0:GetGroup() ~= -1 then
					self.placeData[var_1_0:GetGroup()] = var_1_0
				end
			end
		end

		if iter_1_2.key == 2 then
			for iter_1_5, iter_1_6 in ipairs(iter_1_2.value_list) do
				self.slotData[iter_1_5] = TownBubbleSlot2.New(iter_1_5, iter_1_6.key, iter_1_6.value)
			end
		end

		if iter_1_2.key == 3 then
			for iter_1_7, iter_1_8 in ipairs(iter_1_2.value_list) do
				if iter_1_8.key == 1 then
					self.settleGold = self.settleGold + iter_1_8.value
				end

				if iter_1_8.key == 2 then
					self.settleGold = self.settleGold + iter_1_8.value * TownActivity2.Million
				end

				if iter_1_8.key == 3 then
					self.settleGold = self.settleGold + iter_1_8.value * TownActivity2.Billion
				end
			end
		end

		if iter_1_2.key == 4 then
			for iter_1_9, iter_1_10 in ipairs(iter_1_2.value_list) do
				if iter_1_9 == 1 then
					self.totalGold2 = self.totalGold2 + iter_1_10.value

					break
				end
			end
		end

		if iter_1_2.key == 5 then
			for iter_1_11, iter_1_12 in ipairs(iter_1_2.value_list) do
				if iter_1_12.key == 1 then
					self.AllGold = self.AllGold + iter_1_12.value
				end

				if iter_1_12.key == 2 then
					self.AllGold = self.AllGold + iter_1_12.value * TownActivity2.Million
				end

				if iter_1_12.key == 3 then
					self.AllGold = self.AllGold + iter_1_12.value * TownActivity2.Billion
				end
			end
		end
	end

	self:UpdateTotalGold()
	self:UpdateEmptySlots()

	return
end

function TownActivity2:GetPtAllGold()
	return self.AllGold or 0
end

function TownActivity2:AddAllGold(arg_3_1)
	self.AllGold = self.AllGold + arg_3_1

	return
end

function TownActivity2:GetTownLevel()
	return self:TownLevel()
end

function TownActivity2:GetGold()
	return self.totalGold
end

function TownActivity2:GetGold2()
	return self.totalGold2
end

function TownActivity2:AddGold(arg_7_1)
	self.settleGold = self.settleGold + arg_7_1

	self:UpdateTotalGold()

	return
end

function TownActivity2:AddGold2(arg_8_1)
	self.totalGold2 = self.totalGold2 + arg_8_1

	return
end

function TownActivity2:GoldFull()
	local var_9_0 = self:GetLimitGold()

	if var_9_0 <= self.settleGold then
		return false
	elseif var_9_0 > self.settleGold then
		return true
	end

	return false
end

function TownActivity2:UpgradeGold(arg_10_1)
	for iter_10_0, iter_10_1 in pairs(self.placeData) do
		if iter_10_1:GetId() == arg_10_1 then
			if #iter_10_1:GetUpgrade() == 1 then
				if self:GetGold() >= iter_10_1:GetUpgrade()[1][3] then
					return true
				end
			elseif #iter_10_1:GetUpgrade() == 2 and self:GetGold() >= iter_10_1:GetUpgrade()[1][3] and self:GetGold2() >= iter_10_1:GetUpgrade()[2][3] then
				return true
			end
		end
	end

	return false
end

function TownActivity2:GetplaceUpgrade(arg_11_1)
	for iter_11_0, iter_11_1 in pairs(self.placeData) do
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

function TownActivity2:GetUpgradeGold(arg_12_1)
	for iter_12_0, iter_12_1 in pairs(self.placeData) do
		if iter_12_1:GetId() == arg_12_1 then
			return iter_12_1:GetUpgrade()
		end
	end

	return
end

function TownActivity2:GetLimitGold()
	local var_13_0

	for iter_13_0 = 1, #self.placeData do
		if self.placeData[iter_13_0]:GetType() == TownWorkplace2.TYPE.RATIO then
			var_13_0 = self.placeData[iter_13_0]
		end
	end

	return var_13_0:GetTypeParam() or 0
end

function TownActivity2:TownLevel()
	local var_14_0 = self:GetPtAllGold()
	local var_14_1 = 0

	while true do
		local var_14_2

		if var_14_0 < self.listLVList2[1] then
			var_14_1 = 1

			break
		elseif self.listLVList2[1 + 1] then
			var_14_2 = 1 + 1
		else
			break
		end
	end

	return (var_14_0 > self.listLVList2[#self.listLVList2] or nil) and #self.listLVList2 + 1
end

function TownActivity2:OnSettleGold2(arg_15_1)
	local var_15_0 = 0

	for iter_15_0 = arg_15_1, 1, -1 do
		var_15_0 = var_15_0 + self:OnlistLVList(iter_15_0)
	end

	return var_15_0
end

function TownActivity2:OnlistLVList(arg_16_1)
	return self.listLVList[arg_16_1]
end

function TownActivity2:GetTotalGold()
	return math.min(self.totalGold, self:GetLimitGold())
end

function TownActivity2:GetUnlockSlotCnt()
	for iter_18_0, iter_18_1 in pairs(self.placeData) do
		if iter_18_1:GetType() == TownWorkplace2.TYPE.ROLE then
			return iter_18_1:GetTypeParam()
		end
	end

	return
end

function TownActivity2:GetGoldOutput()
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in pairs(self.placeData) do
		var_19_0 = var_19_0 + math.floor(iter_19_1:GetGoldUnit())
	end

	return var_19_0
end

function TownActivity2:UpdateGoldBuff()
	self.buffFactor = 0

	for iter_20_0, iter_20_1 in pairs(self.placeData) do
		self.buffFactor = self.buffFactor + iter_20_1:GetGoldRatio()
	end

	self.buffFactor = self.buffFactor / 16

	return
end

function TownActivity2:UpdateTime()
	local var_21_0 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_21_0, iter_21_1 in pairs(self.slotData) do
		iter_21_1:OnUpdateTime(var_21_0)
	end

	if self.totalGold >= self:GetLimitGold() or self.totalGold >= TownActivity2.MaxGold then
		self.totalGold = self:GetLimitGold()

		return
	end

	self:UpdateTotalGold()

	return
end

function TownActivity2:UpdateTotalGold()
	self.totalGold = math.min(self.settleGold, self:GetLimitGold())

	return
end

function TownActivity2:GetPlaceList()
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(self.placeData) do
		table.insert(var_23_0, iter_23_1)
	end

	return var_23_0
end

function TownActivity2:CanUpgradePlace(arg_24_1)
	return
end

function TownActivity2:ResetIdPlace(arg_25_1, arg_25_2)
	for iter_25_0, iter_25_1 in pairs(self.placeData) do
		if iter_25_1:GetId() == arg_25_2 then
			local var_25_1 = iter_25_1:ResetStartTime(arg_25_1)
		end
	end

	return
end

function TownActivity2:OnUpgradePlace(arg_26_1, arg_26_2)
	local var_26_0 = self.placeData[pg.activity_town_work_level_2[arg_26_1].group]:GetUpgrade()

	self:ResetIdPlace(arg_26_2, arg_26_1)

	for iter_26_0, iter_26_1 in ipairs({
		"settleGold",
		"totalGold2"
	}) do
		if var_26_0[iter_26_0] then
			self[iter_26_1] = self[iter_26_1] - var_26_0[iter_26_0][3]
		end
	end

	self.placeData[pg.activity_town_work_level_2[arg_26_1].group] = TownWorkplace2.New(self.placeData[pg.activity_town_work_level_2[arg_26_1].group]:GetNextId(), arg_26_2)

	self:UpdateTotalGold(arg_26_2)
	self:UpdateEmptySlots()

	return
end

function TownActivity2:OnResetIdPlace(arg_27_1, arg_27_2)
	for iter_27_0, iter_27_1 in pairs(self.placeData) do
		if iter_27_1:GetId() == arg_27_2 then
			local var_27_0 = 0 + math.floor((iter_27_1:ResetStartTime(arg_27_1)))
		end
	end

	return
end

function TownActivity2:OnGatherPlaceGold(arg_28_1, arg_28_2)
	self:OnResetIdPlace(arg_28_2, arg_28_1)

	self.placeData[pg.activity_town_work_level_2[arg_28_1].group] = TownWorkplace2.New(self.placeData[pg.activity_town_work_level_2[arg_28_1].group]:GetId(), arg_28_2)

	self:UpdateTotalGold(arg_28_2)

	return
end

function TownActivity2:OnAllGatherPlaceGold(arg_29_1)
	local var_29_0 = {}
	local var_29_1 = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		if iter_29_0 % 2 == 0 then
			table.insert(var_29_1, iter_29_1)
		elseif iter_29_0 % 2 ~= 0 then
			table.insert(var_29_0, iter_29_1)
		end
	end

	for iter_29_2 = 1, #var_29_0 do
		self:OnResetIdPlace(var_29_1[iter_29_2], var_29_0)

		self.placeData[pg.activity_town_work_level_2[var_29_0[iter_29_2]].group] = TownWorkplace2.New(self.placeData[pg.activity_town_work_level_2[var_29_0[iter_29_2]].group]:GetId(), var_29_1[iter_29_2])

		self:UpdateTotalGold(var_29_1[iter_29_2])
	end

	return
end

function TownActivity2:UpdateEmptySlots()
	for iter_30_0 = 1, self:GetUnlockSlotCnt() do
		self.slotData[iter_30_0] = self.slotData[iter_30_0] or TownBubbleSlot2.New(iter_30_0)
	end

	return
end

function TownActivity2:GetShipIds()
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in pairs(self.slotData) do
		table.insert(var_31_0, iter_31_1:GetShipId())
	end

	return var_31_0
end

function TownActivity2:GetBubbleCntByPos(arg_32_1)
	return self.slotData[arg_32_1]:GetPassCnt()
end

function TownActivity2:OnChangeShips(arg_33_1)
	self:UpdateEmptySlots()

	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		self.slotData[iter_33_1.key]:ChangeShip(iter_33_1.value)
	end

	return
end

function TownActivity2:OnGetBubbleAward(arg_34_1, arg_34_2)
	for iter_34_0, iter_34_1 in ipairs(arg_34_1) do
		self.slotData[iter_34_1]:ResetStartTime(arg_34_2[iter_34_0])
	end

	return
end

function TownActivity2:SetBubbleTipTag(arg_35_1)
	self.bubbleTipTag = arg_35_1

	return
end

function TownActivity2:HasEmptySlot()
	for iter_36_0, iter_36_1 in pairs(self.slotData) do
		if iter_36_1:IsNewEmpty() then
			return true
		end
	end

	return false
end

function TownActivity2:HasMaxGold()
	return self.totalGold >= self:GetLimitGold()
end

function TownActivity2:CanCostGold()
	if self:CanUpgradeTown() then
		return true
	end

	for iter_38_0, iter_38_1 in pairs(self.placeData) do
		if self:CanUpgradePlace(iter_38_1.id) then
			return true
		end
	end

	return false
end

function TownActivity2:getVitemNumber(arg_39_1)
	assert(pg.item_virtual_data_statistics[arg_39_1].link_id == self.id)

	return self:GetTotalGold()
end

function TownActivity2:subVitemNumber(arg_40_1, arg_40_2)
	assert(pg.item_virtual_data_statistics[arg_40_1].link_id == self.id)

	self.settleGold = math.max(0, self.settleGold - arg_40_2)
	self.totalGold = self.settleGold

	return
end

function TownActivity2:addVitemNumber(arg_41_1, arg_41_2)
	return
end

function TownActivity2:KeepDecimal(arg_42_1)
	return math.floor(10^arg_42_1 * self) / 10^arg_42_1
end

TownActivity2.SHOW_NUM_CNT = 1

function TownActivity2:GoldToShow()
	if self >= TownActivity2.MaxGold then
		return 99.99 .. "M"
	end

	if self >= TownActivity2.Billion then
		if self % TownActivity2.Billion == 0 then
			return self / TownActivity2.Billion .. "B"
		end

		return TownActivity2.KeepDecimal(self / TownActivity2.Billion, 1) .. "B"
	elseif self >= TownActivity2.Million then
		if self % TownActivity2.Million == 0 then
			return self / TownActivity2.Million .. "M"
		end

		return TownActivity2.KeepDecimal(self / TownActivity2.Million, 1) .. "M"
	elseif self >= TownActivity2.Thousand then
		if self % TownActivity2.Thousand == 0 then
			return self / TownActivity2.Thousand .. "K"
		end

		return TownActivity2.KeepDecimal(self / TownActivity2.Thousand, 1) .. "K"
	end

	return self
end

return TownActivity2
