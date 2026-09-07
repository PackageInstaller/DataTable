local IslandBookAgency = class("IslandBookAgency", import(".IslandBaseAgency"))

function IslandBookAgency:OnInit(arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.view_book.book_list) do
		table.insert(var_1_0, iter_1_1)
	end

	local var_1_1 = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.view_book.cond_list) do
		var_1_1[iter_1_3.type] = var_1_1[iter_1_3.type] or {}

		for iter_1_4, iter_1_5 in ipairs(iter_1_3.unlock_ids) do
			var_1_1[iter_1_3.type][iter_1_5] = true
		end
	end

	self.dataMap = {}

	for iter_1_6, iter_1_7 in ipairs(pg.island_illustrated_guide.all) do
		local var_1_2, var_1_3 = IslandIllustration.GetTypeAndLinkId(iter_1_7)

		self.dataMap[var_1_2] = self.dataMap[var_1_2] or {}

		local var_1_4 = self:CreateClass(var_1_2, iter_1_7)

		if table.contains(var_1_0, iter_1_7) then
			var_1_4:SetStatus(IslandIllustration.STATUS.UNLOCK)
		elseif var_1_1[var_1_2] and var_1_1[var_1_2][var_1_3] then
			var_1_4:SetStatus(IslandIllustration.STATUS.CAN_UNLOCK)
		end

		self.dataMap[var_1_2][var_1_3] = var_1_4
	end

	self:SetPointDatas(arg_1_1.view_book.book_collects)
	self:SetRecordDatas(arg_1_1.view_book.item_list or {})

	self.pointAwardGotMaps = {}
	self.pointAwardIdsMaps = {}

	for iter_1_8, iter_1_9 in ipairs(pg.island_collection_reward.get_id_list_by_type) do
		self.pointAwardGotMaps[iter_1_8] = {}
		self.pointAwardIdsMaps[iter_1_8] = iter_1_9

		table.sort(self.pointAwardIdsMaps[iter_1_8], CompareFuncs({
			function(arg_2_0)
				return pg.island_collection_reward[arg_2_0].level
			end,
			function(arg_3_0)
				return arg_3_0
			end
		}))
	end

	for iter_1_10, iter_1_11 in ipairs(arg_1_1.view_book.book_awards) do
		table.insert(self.pointAwardGotMaps[pg.island_collection_reward[iter_1_11].type], iter_1_11)
	end

	return
end

function IslandBookAgency:CreateClass(arg_4_1, arg_4_2)
	return switch(arg_4_1, {
		[IslandIllustration.TYPES.CHAR] = function()
			return IslandCharIllustration.New(arg_4_2)
		end,
		[IslandIllustration.TYPES.ITEM] = function()
			return IslandItemIllustration.New(arg_4_2)
		end,
		[IslandIllustration.TYPES.FISH] = function()
			return IslandFishIllustration.New(arg_4_2)
		end
	}, function()
		return IslandIllustration.New(arg_4_2)
	end)
end

function IslandBookAgency:SetRecordDatas(arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		var_9_0[iter_9_1.id] = iter_9_1.num
	end

	for iter_9_2, iter_9_3 in pairs(self.dataMap[IslandIllustration.TYPES.ITEM] or {}) do
		iter_9_3:SetHistoryCnt(var_9_0[iter_9_3:GetLinkConfigID()] or 0)
	end

	return
end

function IslandBookAgency:SetPointDatas(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1 or {}) do
		local var_10_0, var_10_1 = IslandIllustration.GetTypeAndLinkId(iter_10_1.id)

		self.dataMap[var_10_0][var_10_1]:SetPointData(iter_10_1)
	end

	return
end

function IslandBookAgency:InitRuntimeTypesData()
	self:InitShipTypeData()
	self:InitFishTypeData()

	return
end

function IslandBookAgency:InitShipTypeData()
	local var_12_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

	for iter_12_0, iter_12_1 in pairs(self.dataMap[IslandIllustration.TYPES.CHAR] or {}) do
		if var_12_0:GetShipById(iter_12_1:GetLinkConfigID()) then
			local var_12_1 = iter_12_1:GetStatus()

			if var_12_1 == IslandIllustration.STATUS.UNLOCK then
				iter_12_1:CheckTip()
			elseif var_12_1 == IslandIllustration.STATUS.LOCK then
				iter_12_1:SetStatus(IslandIllustration.STATUS.CAN_UNLOCK)
			end
		end
	end

	return
end

function IslandBookAgency:InitFishTypeData()
	local var_13_0 = getProxy(IslandProxy):GetIsland():GetFishingAgency()

	for iter_13_0, iter_13_1 in pairs(self.dataMap[IslandIllustration.TYPES.FISH] or {}) do
		if var_13_0:GetFish(iter_13_1:GetLinkConfigID()) then
			local var_13_1 = iter_13_1:GetStatus()

			if var_13_1 == IslandIllustration.STATUS.UNLOCK then
				iter_13_1:CheckTip()
			elseif var_13_1 == IslandIllustration.STATUS.LOCK then
				iter_13_1:SetStatus(IslandIllustration.STATUS.CAN_UNLOCK)
			end
		end
	end

	return
end

function IslandBookAgency:GetListByType(arg_14_1)
	return underscore.values(self.dataMap[arg_14_1])
end

function IslandBookAgency:GetIllustration(arg_15_1, arg_15_2)
	return self.dataMap[arg_15_1] and self.dataMap[arg_15_1][arg_15_2]
end

function IslandBookAgency:GetTotalPoints()
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in pairs(self.dataMap) do
		for iter_16_2, iter_16_3 in pairs(iter_16_1) do
			var_16_0 = var_16_0 + iter_16_3:GetPoints()
		end
	end

	return var_16_0
end

function IslandBookAgency:GetAllPoints(arg_17_1)
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in pairs(self.dataMap[arg_17_1]) do
		var_17_0 = var_17_0 + iter_17_1:GetPoints()
	end

	return var_17_0
end

function IslandBookAgency:GetPoints(arg_18_1, arg_18_2)
	return self.dataMap[arg_18_1][arg_18_2]:GetPoints()
end

function IslandBookAgency:GetCurLevelPointAwardId(arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(self.pointAwardIdsMaps[arg_19_1]) do
		if not table.contains(self.pointAwardGotMaps[arg_19_1], iter_19_1) then
			return iter_19_1
		end
	end

	return self.pointAwardIdsMaps[arg_19_1][#self.pointAwardIdsMaps[arg_19_1]]
end

function IslandBookAgency:GetPointAwardIds(arg_20_1)
	return self.pointAwardIdsMaps[arg_20_1]
end

function IslandBookAgency:GetPointAwardGotIds(arg_21_1)
	return self.pointAwardGotMaps[arg_21_1]
end

function IslandBookAgency:IsGotAllPointAward(arg_22_1)
	return table.contains(self.pointAwardGotMaps[arg_22_1], self.pointAwardIdsMaps[arg_22_1][#self.pointAwardIdsMaps[arg_22_1]])
end

function IslandBookAgency:GetCurPointInfos(arg_23_1)
	return self:GetAllPoints(arg_23_1), pg.island_collection_reward[self:GetCurLevelPointAwardId(arg_23_1)].need_exp
end

function IslandBookAgency:AddCanUnlock(arg_24_1, arg_24_2)
	self.dataMap[arg_24_1][arg_24_2]:SetStatus(IslandIllustration.STATUS.CAN_UNLOCK)

	return
end

function IslandBookAgency:HandlePushData(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		if self.dataMap[IslandIllustration.TYPES.ITEM][iter_25_1.id] then
			if self.dataMap[IslandIllustration.TYPES.ITEM][iter_25_1.id]:GetStatus() == IslandIllustration.STATUS.LOCK then
				self:AddCanUnlock(IslandIllustration.TYPES.ITEM, iter_25_1.id)
			end

			self.dataMap[IslandIllustration.TYPES.ITEM][iter_25_1.id]:AddHistoryCnt(iter_25_1.num)
			self.dataMap[IslandIllustration.TYPES.ITEM][iter_25_1.id]:CheckTip()
		end
	end

	return
end

function IslandBookAgency:AddUnlock(arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		local var_26_0, var_26_1 = IslandIllustration.GetTypeAndLinkId(iter_26_1)

		self.dataMap[var_26_0][var_26_1]:SetStatus(IslandIllustration.STATUS.UNLOCK)
		self.dataMap[var_26_0][var_26_1]:CheckTip()
	end

	return
end

function IslandBookAgency:AddPointAwardGotId(arg_27_1)
	table.insert(self.pointAwardGotMaps[pg.island_collection_reward[arg_27_1].type], arg_27_1)

	return
end

function IslandBookAgency:OnGetPointDone(arg_28_1)
	self:SetPointDatas(arg_28_1)

	for iter_28_0, iter_28_1 in ipairs(arg_28_1 or {}) do
		local var_28_0, var_28_1 = IslandIllustration.GetTypeAndLinkId(iter_28_1.id)

		self.dataMap[var_28_0][var_28_1]:CheckTip()
	end

	return
end

function IslandBookAgency:OnAddNewShip(arg_29_1)
	if self.dataMap[IslandIllustration.TYPES.CHAR][arg_29_1] then
		self.dataMap[IslandIllustration.TYPES.CHAR][arg_29_1]:SetStatus(IslandIllustration.STATUS.CAN_UNLOCK)
	end

	return
end

function IslandBookAgency:OnShipUpgradeOrBreakOut(arg_30_1)
	if self.dataMap[IslandIllustration.TYPES.CHAR][arg_30_1] then
		self.dataMap[IslandIllustration.TYPES.CHAR][arg_30_1]:CheckTip()
	end

	return
end

function IslandBookAgency:OnFishingEnd(arg_31_1)
	self.dataMap[IslandIllustration.TYPES.FISH] = self.dataMap[IslandIllustration.TYPES.FISH] or {}

	local var_31_0 = self.dataMap[IslandIllustration.TYPES.FISH][arg_31_1]

	if self.dataMap[IslandIllustration.TYPES.FISH][arg_31_1] then
		if var_31_0:GetStatus() == IslandIllustration.STATUS.LOCK then
			self:AddCanUnlock(IslandIllustration.TYPES.FISH, arg_31_1)
		end

		var_31_0:CheckTip()
	end

	return
end

function IslandBookAgency:IsTipFromTypes(arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		if iter_32_1 ~= IslandIllustration.TYPES.FISH or IslandMainBtnTipHelper.IsUnlock("book_fish") then
			local var_32_0, var_32_1 = self:GetCurPointInfos(iter_32_1)

			if not self:IsGotAllPointAward(iter_32_1) and var_32_1 <= var_32_0 then
				return true
			end

			for iter_32_2, iter_32_3 in pairs(self.dataMap[iter_32_1] or {}) do
				if iter_32_3:IsTip() then
					return true
				end
			end
		end
	end

	return false
end

return IslandBookAgency
