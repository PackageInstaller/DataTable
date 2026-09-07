local IslandCollectionPanel = class("IslandCollectionPanel", import("view.base.BaseSubView"))
local var_0_1 = 3
local var_0_2 = "#ff7d36"
local var_0_3 = "#39BFFF"

function IslandCollectionPanel:getUIName()
	return "IslandAutomaticCollectionPanel"
end

function IslandCollectionPanel:OnLoaded()
	self.uiShipList = UIItemList.New(self.uiShipContent, self.uiShipTpl)
	self.uiTipList = UIItemList.New(self.uiTipContent, self.uiTipTpl)

	return
end

function IslandCollectionPanel:ExistHandCollection()
	local var_3_0 = getProxy(IslandProxy):GetIsland():GetBuildingAgency()

	for iter_3_0, iter_3_1 in ipairs({
		IslandProductConst.MinePlaceId,
		IslandProductConst.FellingPlaceId
	}) do
		local var_3_1 = var_3_0:GetBuilding(iter_3_1)
		local var_3_2 = var_3_1 and var_3_1:GetBuildingCollectData() or nil

		if var_3_2 then
			for iter_3_2, iter_3_3 in pairs((var_3_2:GetCollectSlotDatasDic())) do
				if iter_3_3:GetCanCollectTimeStamps() == 0 then
					return true
				end
			end
		end
	end

	return false
end

function IslandCollectionPanel:ExistGather()
	local var_4_0 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_4_0, iter_4_1 in ipairs(self.gatherDataList) do
		if iter_4_1.state == 0 or iter_4_1.state == 1 and var_4_0 > iter_4_1.refresh_time then
			return true
		end
	end

	return false
end

function IslandCollectionPanel:CheckHasCollectData(arg_5_1)
	if arg_5_1 == IslandAutoCollectHelper.SelectType.HandCollection then
		return self:ExistHandCollection()
	elseif arg_5_1 == IslandAutoCollectHelper.SelectType.Gather then
		return self:ExistGather()
	elseif arg_5_1 == IslandAutoCollectHelper.SelectType.Both then
		return self:ExistHandCollection() or self:ExistGather()
	end

	return false
end

function IslandCollectionPanel:OnInit()
	onButton(self, self.uiSelectConfirm, function()
		self.contextData:ShowMsgBox({
			content = i18n("collect_chapter_is_activation"),
			onYes = function(arg_8_0, arg_8_1)
				if self:CheckHasCollectData(arg_8_0) == false then
					pg.TipsMgr.GetInstance():ShowTips(i18n("island_chara_gather_no_target"))

					return
				end

				self:AfterSelectType(arg_8_0)
				arg_8_1()

				return
			end,
			type = IslandMsgBox.TYPE_COMMON_AUTO_CONFIRM
		})

		return
	end)
	onButton(self, self.uiBackBtn, function()
		self.curType = IslandAutoCollectHelper.SelectType.None

		self:Flush()

		return
	end)
	self.uiShipList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventInit then
			self:InitShipItem(arg_10_1, arg_10_2)
		elseif arg_10_0 == UIItemList.EventUpdate then
			self:UpdateShipItem(arg_10_1, arg_10_2)
		end

		return
	end)
	self.uiTipList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventInit then
			self:InitItem(arg_11_1, arg_11_2)
		elseif arg_11_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_11_1, arg_11_2)
		end

		return
	end)
	setText(self.uiSelectConfirmText, i18n("island_chara_gather_range"))
	setText(self.uiConfirmText, i18n("island_chara_gather_start"))
	setText(self.uiBackText, i18n("word_back"))

	return
end

function IslandCollectionPanel:InitShipItem(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1 + 1

	onButton(self, arg_12_2:Find("unlock/btn"), function()
		self:emit(IslandMediator.OPEN_PAGE, "IslandShipSelectPage", {
			{
				attrType = IslandShipAttr.COLLECT_KEY,
				confirmFunc = function(self)
					self:AfterShipSelect(var_12_0, self[1])

					return
				end,
				autoCollectionSelectShip = self.selectShips
			}
		})

		return
	end)
	onButton(self, arg_12_2:Find("unlock/ship/delete"), function()
		self.selectShips[var_12_0] = nil

		self:Flush()

		return
	end)

	return
end

function IslandCollectionPanel:UpdateShipItem(arg_16_1, arg_16_2)
	local var_16_0 = self.curType == IslandAutoCollectHelper.SelectType.None

	setActive(arg_16_2:Find("lock"), self.curType == IslandAutoCollectHelper.SelectType.None)
	setActive(arg_16_2:Find("unlock"), not var_16_0)

	if var_16_0 then
		return
	end

	local var_16_1 = arg_16_1 + 1
	local var_16_2 = self.selectShips[arg_16_1 + 1]
	local var_16_3 = self.selectShips[arg_16_1 + 1] ~= nil

	setActive(arg_16_2:Find("unlock/ship"), self.selectShips[arg_16_1 + 1] ~= nil and true or false)
	setActive(arg_16_2:Find("unlock/add"), not var_16_3)
	setActive(arg_16_2:Find("unlock/add"), not var_16_3)

	if not var_16_2 then
		return
	end

	LoadImageSpriteAsync("squareicon/" .. IslandShip.StaticGetPrefab(var_16_2), arg_16_2:Find("unlock/ship/mask/icon"))

	if not self.expAddlist[var_16_1] then
		setActive(arg_16_2:Find("unlock/ship/exp"), false)

		return
	end

	setActive(arg_16_2:Find("unlock/ship/exp"), true)
	setText(arg_16_2:Find("unlock/ship/exp/addExp"), string.format("EXP+%d", self.expAddlist[var_16_1]))

	return
end

function IslandCollectionPanel:AfterShipSelect(arg_17_1, arg_17_2)
	self.selectShips[arg_17_1] = arg_17_2

	self:Flush()

	return
end

function IslandCollectionPanel:InitItem(arg_18_1, arg_18_2)
	setText(arg_18_2:Find("name"), IslandAutoCollectHelper.CostTipList[arg_18_1 + 1])

	return
end

function IslandCollectionPanel:UpdateItem(arg_19_1, arg_19_2)
	setText(arg_19_2:Find("num"), self.costTipList[arg_19_1 + 1])

	return
end

function IslandCollectionPanel:Flush()
	setActive(self.uiSelectConfirm, self.curType == IslandAutoCollectHelper.SelectType.None)
	setActive(self.uiConfirmBtn, self.curType ~= IslandAutoCollectHelper.SelectType.None)
	setActive(self.uiBackBtn, self.curType ~= IslandAutoCollectHelper.SelectType.None)
	self:RefreshData()

	if self.curType ~= IslandAutoCollectHelper.SelectType.None then
		setActive(self.uiConfirmBtn.transform:Find("blue"), self.cheackEnough)
		setActive(self.uiConfirmBtn.transform:Find("gray"), not self.cheackEnough)

		if self.cheackEnough then
			onButton(self, self.uiConfirmBtn, function()
				local var_21_0 = {}

				for iter_21_0, iter_21_1 in pairs(self.selectShips) do
					table.insert(var_21_0, iter_21_1)
				end

				pg.m02:sendNotification(GAME.ISLAND_TAKE_AUTO_COLLECTION, {
					type = self.curType,
					ship_list = var_21_0,
					gatherData = self.gatherDataList
				})

				return
			end)
		else
			removeOnButton(self.uiConfirmBtn)
		end
	end

	self.uiShipList:align(var_0_1)
	self.uiTipList:align(#IslandAutoCollectHelper.CostTipList)

	return
end

function IslandCollectionPanel:GetCostData()
	local var_22_0 = 0
	local var_22_1 = 0
	local var_22_2 = 0

	self.autoCostList = {}

	if self.curType ~= IslandAutoCollectHelper.SelectType.HandCollection then
		if self.curType == IslandAutoCollectHelper.SelectType.Both then
			local var_22_3 = getProxy(IslandProxy):GetIsland():GetBuildingAgency()

			for iter_22_0, iter_22_1 in ipairs({
				IslandProductConst.MinePlaceId,
				IslandProductConst.FellingPlaceId
			}) do
				local var_22_4 = var_22_3:GetBuilding(iter_22_1)
				local var_22_5 = var_22_4 and var_22_4:GetBuildingCollectData() or nil
				local var_22_6 = self.buildCostDic[iter_22_1]

				if var_22_5 then
					for iter_22_2, iter_22_3 in pairs((var_22_5:GetCollectSlotDatasDic())) do
						if iter_22_3:GetCanCollectTimeStamps() == 0 and self:CheckIsDefauotSlot(iter_22_1, iter_22_3.id) then
							table.insert(self.autoCostList, {
								energyCost = var_22_6.energyCost,
								coinCost = var_22_6.coinCost,
								expAdd = var_22_6.expCost
							})
						end
					end
				end
			end
		end

		if self.curType == IslandAutoCollectHelper.SelectType.Gather or self.curType == IslandAutoCollectHelper.SelectType.Both then
			local var_22_7 = pg.TimeMgr.GetInstance():GetServerTime()

			for iter_22_4, iter_22_5 in ipairs(self.gatherDataList) do
				if iter_22_5.state ~= 0 then
					if iter_22_5.state == 1 and var_22_7 > iter_22_5.refresh_time then
						local var_22_8 = {
							energyCost = pg.island_wild_gather[iter_22_5.id].auto_parameters[2],
							coinCost = pg.island_wild_gather[iter_22_5.id].auto_parameters[1]
						}

						var_22_8.expAdd = pg.island_wild_gather[iter_22_5.id].auto_parameters[3]

						table.insert(self.autoCostList, var_22_8)
					end
				end
			end
		end
	end

	for iter_22_6, iter_22_7 in ipairs(self.autoCostList) do
		var_22_0 = var_22_0 + iter_22_7.energyCost
		var_22_1 = var_22_1 + iter_22_7.coinCost
		var_22_2 = var_22_2 + iter_22_7.expAdd
	end

	return var_22_0, var_22_1, var_22_2
end

function IslandCollectionPanel:GetGatherReducePercent()
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in pairs(self.selectShips) do
		var_23_0 = var_23_0 + IslandAutoCollectHelper.GetAttributeReducePercent(iter_23_1)
	end

	return var_23_0
end

function IslandCollectionPanel:GetShipCount()
	local var_24_0 = 0

	for iter_24_0, iter_24_1 in pairs(self.selectShips) do
		var_24_0 = var_24_0 + 1
	end

	return var_24_0
end

function IslandCollectionPanel:RefreshData()
	self.costTipList = {}
	self.expAddlist = {}
	self.cheackEnough = false

	local var_25_0, var_25_1, var_25_2 = self:GetCostData()
	local var_25_3
	local var_25_4

	if self.curType == IslandAutoCollectHelper.SelectType.None then
		var_25_3 = "/"
		var_25_4 = "/"
	elseif self:GetShipCount() == 0 then
		var_25_3 = var_25_0
		var_25_4 = var_25_1
	else
		local var_25_5 = self:GetGatherReducePercent()
		local var_25_6 = math.floor(var_25_0 * (1 - var_25_5 * 0.01))
		local var_25_7 = var_25_6
		local var_25_8 = 0

		for iter_25_0 = 1, 3 do
			if self.selectShips[iter_25_0] then
				local var_25_9 = getProxy(IslandProxy)
				local var_25_10 = var_25_9:GetIsland():GetCharacterAgency():GetShipById(self.selectShips[iter_25_0]).GetCurrentEnergy(var_25_9)
				local var_25_11 = 0

				var_25_11 = var_25_10 <= var_25_7 and var_25_10 or var_25_7
				var_25_7 = var_25_7 - var_25_11
				var_25_8 = var_25_8 + var_25_10
				self.expAddlist[iter_25_0] = math.floor(var_25_11 / var_25_6 * var_25_2)
			end
		end

		local var_25_12 = var_25_6 <= var_25_8

		var_25_3 = string.format("<color=%s>%d</color>/%d(-%d%%)", (var_25_6 <= var_25_8 or nil) and (var_0_3 or var_0_2), var_25_8, var_25_6, var_25_5)

		local var_25_13 = getProxy(IslandProxy):GetIsland()
		local var_25_14 = var_25_13:GetInventoryAgency():GetItemById(1)
		local var_25_15 = var_25_1 <= var_25_13

		var_25_4 = string.format("<color=%s>%d</color>/%d", (var_25_1 <= var_25_13 or nil) and (var_0_3 or var_0_2), var_25_1, var_25_14 and var_25_14:GetCount() or 0)
		self.cheackEnough = var_25_12 and var_25_15
	end

	table.insert(self.costTipList, var_25_3)
	table.insert(self.costTipList, var_25_4)

	return
end

function IslandCollectionPanel:OnGetCollctionDone(arg_26_1)
	if arg_26_1.selectType == IslandAutoCollectHelper.SelectType.Gather or arg_26_1.selectType == IslandAutoCollectHelper.SelectType.Both then
		self.gatherDataList = {}
	end

	self.curType = IslandAutoCollectHelper.SelectType.None

	self:Flush()

	return
end

function IslandCollectionPanel:AfterSelectType(arg_27_1)
	self.curType = arg_27_1

	self:Flush()

	return
end

function IslandCollectionPanel:OnDestroy()
	return
end

function IslandCollectionPanel:ConfigDataHandle()
	self.buildCostDic = {}

	for iter_29_0, iter_29_1 in ipairs(pg.island_set.mining_auto_parameters.key_value_varchar) do
		self.buildCostDic[iter_29_1[1]] = {}
		self.buildCostDic[iter_29_1[1]].coinCost = iter_29_1[2]
		self.buildCostDic[iter_29_1[1]].energyCost = iter_29_1[3]
		self.buildCostDic[iter_29_1[1]].expCost = iter_29_1[4]
	end

	self.buildDefaultList = {}

	for iter_29_2, iter_29_3 in ipairs(pg.island_set.mining_default_slot.key_value_varchar) do
		self.buildDefaultList[iter_29_3[1]] = {}

		for iter_29_4, iter_29_5 in ipairs(iter_29_3[2]) do
			table.insert(self.buildDefaultList[iter_29_3[1]], iter_29_5)
		end
	end

	return
end

function IslandCollectionPanel:CheckIsDefauotSlot(arg_30_1, arg_30_2)
	for iter_30_0, iter_30_1 in ipairs(self.buildDefaultList[arg_30_1] or {}) do
		if iter_30_1 == arg_30_2 then
			return true
		end
	end

	return false
end

function IslandCollectionPanel:Show(arg_31_1)
	IslandCollectionPanel.super.Show(self)
	self:ConfigDataHandle()

	self.gatherDataList = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_1.gather_list) do
		table.insert(self.gatherDataList, IslandWildGatherData.New(iter_31_1))
	end

	self.curType = IslandAutoCollectHelper.SelectType.None
	self.selectShips = {}
	self.uiItemTipList = {}

	self:Flush()

	return
end

return IslandCollectionPanel
