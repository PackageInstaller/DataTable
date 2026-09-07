local IslandFormulaSelectPage = class("IslandFormulaSelectPage", import("...base.IslandBasePage"))

function IslandFormulaSelectPage:getUIName()
	return "IslandFormulaSelectNewUI"
end

function IslandFormulaSelectPage:OnLoaded()
	self.backBtn = self._tf:Find("top/back")
	self.title = self._tf:Find("top/title")
	self.rightInfo = self._tf:Find("rightInfo")
	self.rightInfoEmpty = self._tf:Find("rightInfo_empty")
	self.currentformulaIcon = self._tf:Find("rightInfo/formula/currentformula")
	self.sureBtn = self._tf:Find("rightInfo/sure")
	self.formulaItem = self._tf:Find("rightInfo/formula")
	self.curCountTips = self.formulaItem:Find("curCount")
	self.addCountTips = self.formulaItem:Find("addCount")
	self.reduceBtn = self.formulaItem:Find("limit/reduce")
	self.addBtn = self.formulaItem:Find("limit/add")
	self.maxBtn = self.formulaItem:Find("limit/max")
	self.curCountNumSlider = self.formulaItem:Find("limit/num_bg")
	self.extraProduct = self.formulaItem:Find("extra")
	self.extraProductIcon = self.extraProduct:Find("icon")
	self.extraProductNum = self.extraProductIcon:Find("product_count_bg/product_count")
	self.extraProductName = self.extraProduct:Find("Text")
	self.extraProductAddnum = self.extraProduct:Find("Text/addCount")
	self.needTimeText = self.sureBtn:Find("adapt/time/time_text")
	self.barLimit = self.formulaItem:Find("limit/hasLimit")
	self.extraProductList = UIItemList.New(self.extraProduct:Find("process"), self.extraProduct:Find("process/item"))
	self.uiList = UIItemList.New(self._tf:Find("formulaView/content"), self._tf:Find("formulaView/content/tpl"))
	self.costuiList = UIItemList.New(self._tf:Find("rightInfo/formula/needItem/content"), self._tf:Find("rightInfo/formula/needItem/content/IslandItemTpl"))

	setText(self._tf:Find("top/title/Text"), i18n("island_select_product"))
	setText(self.formulaItem:Find("tips"), i18n("island_production_count"))

	self.baseEffectSpeed = pg.island_set.base_efficiency.key_value_int
	self.selectShipTf = self.rightInfo:Find("selectShip")
	self.selectShipName = self.selectShipTf:Find("info/name")
	self.selectShipLv = self.selectShipTf:Find("info/lv")
	self.selectShipIcon = self.selectShipTf:Find("bg/icon")
	self.skillTf = self.selectShipTf:Find("skill")
	self.skillInUse = self.skillTf:Find("skillBg/skillTabBg/skill_bright")
	self.skillUnUse = self.skillTf:Find("skillBg/skillTabBg/skill_dark")
	self.skillName = self.skillTf:Find("skillBg/skillText"):GetComponent(typeof(Text))
	self.energyBarTf = self.selectShipTf:Find("ener_bar")
	self.energyBarUseTf = self.selectShipTf:Find("ener_bar_1")
	self.energy_countTf = self.selectShipTf:Find("energy_count")
	self.enoughSureBg = self.sureBtn:Find("okBg")
	self.notenoughSureBg = self.sureBtn:Find("notBg")
	self.animationPlayer = self.rightInfo:GetComponent(typeof(Animation))
	self.addExpTF = self.selectShipTf:Find("exp")
	self.addExp = self.selectShipTf:Find("exp/addExp")

	return
end

function IslandFormulaSelectPage:AddListeners()
	self:AddListener(GAME.ISLAND_SHOP_OP_DONE, self.RefreshCurrentSelectFormula)

	return
end

function IslandFormulaSelectPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_SHOP_OP_DONE, self.RefreshCurrentSelectFormula)

	return
end

function IslandFormulaSelectPage:OnInit()
	onButton(self, self._tf:Find("top/title/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_commission.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		self:Hide()
		existCall(self.cancelFunc)

		return
	end, SFX_PANEL)
	onButton(self, self.reduceBtn, function()
		self.curSelectCount = self.curSelectCount - 1

		local var_8_0

		if self.addDelegateFormulaTimes then
			var_8_0 = self.addDelegateFormulaTimes + 1 or 1
		end

		self.curSelectCount = var_8_0 > self.curSelectCount and var_8_0 or self.curSelectCount

		self:RefreshCost()

		return
	end, SFX_PANEL)
	onButton(self, self.addBtn, function()
		local var_9_0 = self.curSelectCount + 1

		if self.addDelegateFormulaTimes then
			local var_9_1 = self:CheckCanAddMaxTimes() + self.addDelegateFormulaTimes

			var_9_1 = var_9_1 > self.productMaxTime and self.productMaxTime or var_9_1
			var_9_0 = var_9_1 < var_9_0 and var_9_1 or var_9_0

			if var_9_0 < self.addDelegateFormulaTimes + 1 then
				var_9_0 = self.addDelegateFormulaTimes + 1
			end

			self.curSelectCount = var_9_0
		else
			local var_9_2 = self:CheckCanAddMaxTimes()

			self.curSelectCount = var_9_2 < var_9_0 and var_9_2 or var_9_0

			if self.curSelectCount < 1 then
				self.curSelectCount = 1
			end
		end

		self:RefreshCost()

		return
	end, SFX_PANEL)
	onButton(self, self.maxBtn, function()
		if self.addDelegateFormulaTimes then
			local var_10_0 = self:CheckCanAddMaxTimes() + self.addDelegateFormulaTimes

			if var_10_0 > self.productMaxTime then
				self.curSelectCount = self.productMaxTime or var_10_0
			end

			if self.curSelectCount < 1 then
				self.curSelectCount = 1
			end
		else
			self.curSelectCount = self:CheckCanAddMaxTimes()

			if self.curSelectCount < 1 then
				self.curSelectCount = 1
			end
		end

		self:RefreshCost()

		return
	end, SFX_PANEL)
	onSlider(self, self.curCountNumSlider, function(arg_11_0)
		if self.addDelegateFormulaTimes then
			local var_11_0 = self:CheckCanAddMaxTimes() + self.addDelegateFormulaTimes

			var_11_0 = var_11_0 > self.productMaxTime and self.productMaxTime or var_11_0
			arg_11_0 = var_11_0 < arg_11_0 and var_11_0 or arg_11_0

			if arg_11_0 < self.addDelegateFormulaTimes + 1 then
				arg_11_0 = self.addDelegateFormulaTimes + 1
			end

			self.curSelectCount = arg_11_0
		else
			local var_11_1 = self:CheckCanAddMaxTimes()

			self.curSelectCount = var_11_1 < arg_11_0 and var_11_1 or arg_11_0

			if self.curSelectCount < 1 then
				self.curSelectCount = 1
			end
		end

		self:RefreshCost()

		return
	end)
	onButton(self, self.skillTf, function()
		self:ShowMsgBox({
			type = IslandMsgBox.TYPE_SHIP_SKILL,
			skill = self.selectedShip:GetSkill()
		})

		return
	end, SFX_PANEL)
	self.uiList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventInit then
			self:InitFormulaItem(arg_13_1, arg_13_2)
		elseif arg_13_0 == UIItemList.EventUpdate then
			self:UpdateFormulaItem(arg_13_1, arg_13_2)
		end

		return
	end)
	self.costuiList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventInit then
			self:InitCostItem(arg_14_1, arg_14_2)
		elseif arg_14_0 == UIItemList.EventUpdate then
			self:UpdateCostItem(arg_14_1, arg_14_2)
		end

		return
	end)
	self.extraProductList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventInit then
			-- block empty
		elseif arg_15_0 == UIItemList.EventUpdate then
			setActive(arg_15_2:Find("inprocess"), arg_15_1 < self.extraProcess)
		end

		return
	end)

	return
end

function IslandFormulaSelectPage:InitFormulaItem(arg_16_1, arg_16_2)
	onButton(self, arg_16_2, function()
		self:OnSelectFormulaIndex(arg_16_1 + 1)

		return
	end, SFX_PANEL)

	return
end

function IslandFormulaSelectPage:OnSelectFormulaIndex(arg_18_1)
	self.selectedIdx = arg_18_1
	self.selectFormulaId = self.formulaList[self.selectedIdx]
	self.formulaCfg = pg.island_formula[self.selectFormulaId]
	self.productMaxTime = self.formulaCfg.production_limit

	if self.addDelegateFormulaTimes then
		self.curSelectCount = self.addDelegateFormulaTimes + 1 or 1
	end

	self.uiList:align(#self.formulaList)

	return
end

function IslandFormulaSelectPage:UpdateFormulaItem(arg_19_1, arg_19_2)
	local var_19_0 = pg.island_formula[self.formulaList[arg_19_1 + 1]]
	local var_19_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetItemById(pg.island_formula[self.formulaList[arg_19_1 + 1]].item_id)
	local var_19_2 = var_19_1 and var_19_1:GetCount() or 0

	updateCustomDrop(arg_19_2, Drop.New({
		type = DROP_TYPE_ISLAND_ITEM,
		id = pg.island_formula[self.formulaList[arg_19_1 + 1]].item_id,
		count = var_19_2
	}))
	setActive(arg_19_2:Find("icon_bg/count_bg"), true)
	setScrollTextWithSize(arg_19_2:Find("name"), arg_19_2:Find("scroll_name/name"), var_19_0.name, 6)
	setText(arg_19_2:Find("icon_bg/product_count_bg/product_count"), "×" .. var_19_0.commission_product[1][2])
	setText(arg_19_2:Find("icon_bg/count_bg/count"), i18n("island_production_hold", var_19_2))

	if self.selectedIdx == arg_19_1 + 1 then
		self:RefreshCurrentSelectFormula()
	end

	setActive(arg_19_2:Find("selected"), self.selectedIdx == arg_19_1 + 1)

	return
end

function IslandFormulaSelectPage:InitCostItem(arg_20_1, arg_20_2)
	return
end

function IslandFormulaSelectPage:UpdateCostItem(arg_21_1, arg_21_2)
	local var_21_0 = self.commission_Cost_List[arg_21_1 + 1]

	updateCustomDrop(arg_21_2, self.commission_Cost_List[arg_21_1 + 1])

	local var_21_1 = string.format("%d/%d", self.commission_Cost_List[arg_21_1 + 1].itemCount, self.commission_Cost_List[arg_21_1 + 1].costCount)

	if self.commission_Cost_List[arg_21_1 + 1].extraCostCount and self.commission_Cost_List[arg_21_1 + 1].extraCostCount > 0 then
		var_21_1 = string.format("%d/(%d<color=#ffae22>+%d</color>)", self.commission_Cost_List[arg_21_1 + 1].itemCount, self.commission_Cost_List[arg_21_1 + 1].costCount, self.commission_Cost_List[arg_21_1 + 1].extraCostCount)
	end

	setActive(arg_21_2:Find("icon_bg/count_bg"), true)
	setText(arg_21_2:Find("icon_bg/count_bg/count"), var_21_1)
	onButton(self, arg_21_2:Find("icon_bg/icon"), function()
		self:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_21_0
		})

		return
	end)
	onButton(self, arg_21_2:Find("icon_bg/icon"), function()
		self:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_21_0
		})

		return
	end)

	return
end

function IslandFormulaSelectPage:RefreshCurrentSelectFormula()
	local var_24_0 = Drop.New({
		count = 0,
		type = DROP_TYPE_ISLAND_ITEM,
		id = self.formulaCfg.item_id
	})

	onButton(self, self.currentformulaIcon, function()
		self:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_24_0
		})

		return
	end)
	GetImageSpriteFromAtlasAsync("island/islandframe", IslandItemRarity.Rarity2FrameName(var_24_0:getConfigTable().rarity), self.currentformulaIcon:Find("icon_bg"))
	GetImageSpriteFromAtlasAsync("island/" .. var_24_0:getConfigTable().icon, "", self.currentformulaIcon:Find("icon_bg/icon"))
	self:RefreshCost()

	return
end

function IslandFormulaSelectPage:GetAniExtraGainByConfigName(arg_26_1)
	local var_26_0 = 0

	if self.placeId ~= IslandProductConst.PasturePlaceId then
		return var_26_0
	end

	for iter_26_0, iter_26_1 in ipairs((getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(self.placeId):GetDelegationSlotData(self.slotId):GetPartList())) do
		var_26_0 = var_26_0 + pg.island_ranch_animal[iter_26_1][arg_26_1]
	end

	return var_26_0
end

function IslandFormulaSelectPage:RefreshCost()
	self.commission_Cost_List = {}

	local var_27_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	local var_27_1 = self:GetAniExtraGainByConfigName("efficiency_cost")

	for iter_27_0, iter_27_1 in ipairs(self.formulaCfg.commission_cost) do
		local var_27_2 = var_27_0:GetItemById(iter_27_1[1])
		local var_27_3 = var_27_2 and var_27_2:GetCount() or 0
		local var_27_4

		if self.addDelegateFormulaTimes then
			var_27_4 = self.curSelectCount - self.addDelegateFormulaTimes or self.curSelectCount
		end

		table.insert(self.commission_Cost_List, (Drop.New({
			count = 0,
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_27_1[1],
			itemCount = var_27_3,
			costCount = iter_27_1[2] * var_27_4,
			extraCostCount = var_27_1 * var_27_4
		})))
	end

	self.costuiList:align(#self.commission_Cost_List)
	self:RefreshCurSelectCount()
	self:RefreshShipEnergy()
	self:RefreshCanStart()

	return
end

function IslandFormulaSelectPage:CheckCanAddMaxTimes()
	self.commission_Cost_List = {}

	local var_28_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	local var_28_1 = self.productMaxTime
	local var_28_2 = self:GetAniExtraGainByConfigName("efficiency_cost")

	for iter_28_0, iter_28_1 in ipairs(self.formulaCfg.commission_cost) do
		local var_28_3 = var_28_0:GetItemById(iter_28_1[1])

		var_28_1 = math.min(var_28_1, math.floor((var_28_3 and var_28_3:GetCount() or 0) / (iter_28_1[2] + var_28_2)))
	end

	return (math.min(math.floor(self.selectedShip:GetCurrentEnergy() / self:GetOneFormulaEnergyCost()), var_28_1))
end

function IslandFormulaSelectPage:RefreshCanStart()
	local function var_29_0()
		local var_32_0 = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(self.placeId)
		local var_32_1 = {}
		local var_32_2 = false

		for iter_32_0, iter_32_1 in ipairs(pg.island_production_slot[self.slotId].exclusion_slot == "" and {} or pg.island_production_slot[self.slotId].exclusion_slot) do
			if var_32_0:GetHandPlantSlotData(iter_32_1).state == 1 then
				var_32_2 = true

				table.insert(var_32_1, iter_32_1)
			end
		end

		return var_32_2, var_32_1
	end

	if (function()
		for iter_30_0, iter_30_1 in ipairs(self.commission_Cost_List) do
			if iter_30_1.costCount + iter_30_1.extraCostCount > iter_30_1.itemCount then
				return false
			end
		end

		return true
	end)() and (function()
		if self:GetOneFormulaEnergyCost() * ((self.addDelegateFormulaTimes or nil) and (self.curSelectCount - self.addDelegateFormulaTimes or self.curSelectCount)) > self.selectedShip:GetCurrentEnergy() then
			return false
		end

		return true
	end)() then
		setActive(self.enoughSureBg, true)
		setActive(self.notenoughSureBg, false)
		onButton(self, self.sureBtn, function()
			if self.addDelegateFormula then
				self.placeId = pg.island_production_slot[self.slotId].place

				local var_33_0 = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(self.placeId):GetDelegationSlotData(self.slotId)

				if var_33_0 and not var_33_0:GetSlotRoleData() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("island_additional_production_tip2"))

					return
				end
			end

			if self.formulaToActivityDic[self.selectFormulaId] then
				local var_33_1 = getProxy(ActivityProxy):getActivityById(self.formulaToActivityDic[self.selectFormulaId])

				if not var_33_1 or var_33_1:isEnd() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("island_activity_expired"))

					return
				end
			end

			local var_33_2, var_33_3 = var_29_0()

			if var_33_2 then
				self:ShowMsgBox({
					type = IslandMsgBox.TYPE_COMMON,
					content = i18n("island_production_manually_cancel"),
					onYes = function()
						pg.m02:sendNotification(GAME.ISLAND_STOP_HANDLE_PLANT_HALFWAY, {
							build_id = self.placeId,
							slot_list = var_33_3
						})
						existCall(self.unLoadCharacterFunc)

						local var_34_0 = self:GetAniExtraGainByConfigName("efficiency_cost")

						if self.addDelegateFormula then
							self:emit(IslandMediator.ADD_DELEGATION, self.placeId, self.slotId, self.curSelectCount - self.addDelegateFormulaTimes, var_34_0)
						else
							self:emit(IslandMediator.START_DELEGATION, self.placeId, self.slotId, self.selectedShipId, self.selectFormulaId, self.curSelectCount, var_34_0)
						end

						existCall(self.confirmFunc)
						self:Hide()

						return
					end,
					onNo = function()
						return
					end
				})

				return
			end

			existCall(self.unLoadCharacterFunc)

			local var_33_4 = self:GetAniExtraGainByConfigName("efficiency_cost")

			if self.addDelegateFormula then
				self:emit(IslandMediator.ADD_DELEGATION, self.placeId, self.slotId, self.curSelectCount - self.addDelegateFormulaTimes, var_33_4)
			else
				self:emit(IslandMediator.START_DELEGATION, self.placeId, self.slotId, self.selectedShipId, self.selectFormulaId, self.curSelectCount, var_33_4)
			end

			existCall(self.confirmFunc)
			self:Hide()

			return
		end, SFX_PANEL)
	else
		setActive(self.enoughSureBg, false)
		setActive(self.notenoughSureBg, true)
		onButton(self, self.sureBtn, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_production_cost_notenough"))

			return
		end, SFX_PANEL)
	end

	return
end

function IslandFormulaSelectPage:OnShow(arg_37_1)
	self:BlurPanel()

	self.commissionId = arg_37_1.commissionId
	self.selectedShipId = arg_37_1.selectedShipId
	self.cancelFunc = arg_37_1.cancelFunc
	self.confirmFunc = arg_37_1.confirmFunc
	self.unLoadCharacterFunc = arg_37_1.unLoadCharacterFunc
	self.addDelegateFormula = arg_37_1.addDelegateFormula
	self.addDelegateFormulaTimes = arg_37_1.addDelegateFormulaTimes
	self.canRewardTime = arg_37_1.canRewardTime
	self.selectFormulaId = arg_37_1.selectFormulaId

	setActive(self.addExpTF, self.selectedShipId ~= 1)

	if self.addDelegateFormulaTimes then
		setActive(self.barLimit, true)

		self.barLimit.sizeDelta = Vector2(self.addDelegateFormulaTimes / (pg.island_formula[self.addDelegateFormula].production_limit or 5) * 352.6, 22)

		setActive(self.addCountTips, true)
	else
		setActive(self.barLimit, false)
		setActive(self.addCountTips, false)
	end

	setText(self.sureBtn:Find("adapt/time/Text"), self.addDelegateFormulaTimes and i18n("island_additional_production_tip1") or i18n("island_production_start"))

	self.slotId = pg.island_production_commission[self.commissionId].slot
	self.placeId = pg.island_production_slot[self.slotId].place
	self.selectedShip = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(self.selectedShipId)

	self:InitUnlockedFormulaList()

	if #self.formulaList > 0 then
		local var_37_0 = 1

		if self.selectFormulaId then
			for iter_37_0, iter_37_1 in ipairs(self.formulaList) do
				if iter_37_1 == self.selectFormulaId then
					var_37_0 = iter_37_0

					break
				end
			end
		end

		self:OnSelectFormulaIndex(var_37_0)
		onNextTick(function()
			local var_38_0 = self._tf:Find("formulaView/content")

			setAnchoredPosition(var_38_0, {
				y = math.min((var_37_0 - 1) * self._tf:Find("formulaView/content/tpl").rect.height, var_38_0.sizeDelta.y)
			})

			return
		end)
	else
		self.uiList:align(#self.formulaList)
		setActive(self.rightInfo, false)
		setActive(self.rightInfoEmpty, true)
	end

	self:RefreshShip()

	return
end

function IslandFormulaSelectPage:RefreshShip()
	GetImageSpriteFromAtlasAsync("SquareIcon/" .. IslandShip.StaticGetPrefab(self.selectedShipId), "", self.selectShipIcon)
	setText(self.selectShipName, self.selectedShip:GetName())
	setText(self.selectShipLv, string.format("-Lv.%d", self.selectedShip:GetLevel()))

	local var_39_0 = self.selectedShip:GetSkill()
	local var_39_1 = var_39_0:IsEffectiveInPlace(self.placeId)

	setActive(self.skillInUse, var_39_1)
	setActive(self.skillUnUse, not var_39_1)
	setActive(self.skillUnUse, not var_39_1)

	self.skillName.text = string.format("%s - %s", var_39_0:GetName(), "Lv." .. var_39_0:GetLevel() .. "")

	return
end

function IslandFormulaSelectPage:RefreshShipEnergy()
	local var_40_0

	if self.addDelegateFormulaTimes then
		var_40_0 = self.curSelectCount - self.addDelegateFormulaTimes or self.curSelectCount
	end

	local var_40_1 = self:GetOneFormulaEnergyCost() * var_40_0

	if self.selectedShipId == 1 then
		var_40_1 = 0
	else
		self.animationPlayer:Play("anim_IslandFormulaSelectNewUI_bar_Loop")
	end

	setText(self.addExp, "EXP+" .. self.formulaCfg.ship_exp * var_40_0)

	if self.eneryTimer then
		self.eneryTimer:Stop()
	end

	self.eneryTimer = Timer.New(function()
		local var_41_0 = self.selectedShip:GetCurrentEnergy()
		local var_41_1 = self.selectedShip:GetMaxEnergy()

		setSlider(self.energyBarTf, 0, 1, (var_41_0 - var_40_1) / var_41_1)
		setSlider(self.energyBarUseTf, 0, 1, var_41_0 / var_41_1)
		setText(self.energy_countTf, string.format("%d-<color=#f7c35f>%d</color>/%d", var_41_0, var_40_1, var_41_1))

		return
	end, 1, -1)

	self.eneryTimer:Start()
	self.eneryTimer.func()

	return
end

function IslandFormulaSelectPage:InitUnlockedFormulaList()
	self.formulaList = {}
	self.formulaToActivityDic = {}

	if self.addDelegateFormula then
		table.insert(self.formulaList, self.addDelegateFormula)

		return
	end

	local var_42_0 = getProxy(IslandProxy):GetIsland():GetAblityAgency()

	for iter_42_0, iter_42_1 in ipairs(pg.island_production_slot[self.slotId].activity_formula or {}) do
		local var_42_1 = iter_42_1[1]
		local var_42_2 = getProxy(ActivityProxy):getActivityById(iter_42_1[1])

		if var_42_2 and not var_42_2:isEnd() then
			for iter_42_2, iter_42_3 in ipairs(iter_42_1[2] or {}) do
				if pg.island_formula[iter_42_3].unlock_type == 0 or var_42_0:IsUnlockFormuate(iter_42_3) then
					table.insert(self.formulaList, iter_42_3)

					self.formulaToActivityDic[iter_42_3] = var_42_1
				end
			end
		end
	end

	for iter_42_4, iter_42_5 in ipairs(pg.island_production_slot[self.slotId].formula or {}) do
		local var_42_3 = pg.island_formula[iter_42_5].unlock_type == 0
		local var_42_4 = pg.island_formula[iter_42_5].unlock_type == -1
		local var_42_5 = true

		if pg.island_formula[iter_42_5].unlock_type == -1 then
			local var_42_6 = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetFormulaNums()

			for iter_42_6, iter_42_7 in ipairs(pg.island_combo[iter_42_5].unlock_condition) do
				if not var_42_6[iter_42_7[1]] or iter_42_7[2] > var_42_6[iter_42_7[1]] then
					var_42_5 = false

					break
				end
			end
		end

		if var_42_3 or var_42_0:IsUnlockFormuate(iter_42_5) or var_42_4 and var_42_5 then
			table.insert(self.formulaList, iter_42_5)
		end
	end

	return
end

function IslandFormulaSelectPage:RefreshCurSelectCount()
	setText(self.curCountTips, tostring(self.addDelegateFormulaTimes or self.curSelectCount))
	setText(self.addCountTips, "+" .. ((self.addDelegateFormulaTimes or nil) and (self.curSelectCount - self.addDelegateFormulaTimes or 0)))
	setSlider(self.curCountNumSlider, 1, self.productMaxTime, self.curSelectCount)
	self:RefreshExtraProduct()

	local var_43_2 = self:GetAniExtraGainByConfigName("efficiency_gains_num")

	setText(self.currentformulaIcon:Find("icon_bg/product_count_bg/product_count"), ((var_43_2 > 0 or nil) and string.format("×(%s<color=#7df39f>+%d</color>)", self.formulaCfg.commission_product[1][2], var_43_2)) .. i18n("island_production_tip"))

	local var_43_3, var_43_4 = self:CacaluteProductTime()
	local var_43_5 = 0

	for iter_43_0, iter_43_1 in ipairs(var_43_3) do
		var_43_5 = var_43_5 + iter_43_1
	end

	local var_43_6 = pg.TimeMgr.GetInstance():DescCDTime(var_43_5)

	if var_43_4 - var_43_5 > 0 then
		var_43_6 = string.format("%s(<color=#7df39f>-%s</color>)", var_43_6, pg.TimeMgr.GetInstance():DescCDTime(var_43_4 - var_43_5))
	end

	setText(self.needTimeText, var_43_6)

	return
end

function IslandFormulaSelectPage:RefreshExtraProduct()
	if #self.formulaCfg.second_product == 0 or not getProxy(IslandProxy):GetIsland():GetAblityAgency():IsUnlcokSecondProduct(self.selectFormulaId) then
		setActive(self.extraProduct, false)

		return
	end

	setActive(self.extraProduct, true)

	local var_44_0 = pg.island_item_data_template[self.formulaCfg.second_product_display[1][1]]
	local var_44_1 = Drop.New({
		count = 0,
		type = DROP_TYPE_ISLAND_ITEM,
		id = self.formulaCfg.second_product_display[1][1]
	})

	onButton(self, self.extraProductIcon, function()
		self:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_44_1
		})

		return
	end)
	GetImageSpriteFromAtlasAsync("island/" .. var_44_0.icon, "", self.extraProductIcon)

	local var_44_3 = self:GetAniExtraGainByConfigName("efficiency_gains_bonus_num")

	setText(self.extraProductNum, ((var_44_3 > 0 or nil) and string.format("×(%s<color=#7df39f>+%d</color>)", self.formulaCfg.second_product_display[1][2], var_44_3)) .. i18n("island_production_tip"))

	local var_44_4 = self.formulaCfg.second_product[1]
	local var_44_5 = (getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(pg.island_production_slot[self.slotId].place):GetDelegationSlotData(self.slotId):GetFromulaTatalCount(self.formulaCfg.id) + (self.canRewardTime or 0)) % var_44_4

	self.extraProcess = (var_44_5 + ((self.addDelegateFormulaTimes or nil) and (self.curSelectCount - self.addDelegateFormulaTimes or self.curSelectCount))) % var_44_4

	setText(self.extraProductName, var_44_0.name .. "×" .. math.floor((var_44_5 + ((self.addDelegateFormulaTimes or nil) and (self.curSelectCount - self.addDelegateFormulaTimes or self.curSelectCount))) / var_44_4))

	if self.addDelegateFormulaTimes then
		setActive(self.extraProductAddnum, true)
		setText(self.extraProductAddnum, "+" .. math.floor((var_44_5 + (self.curSelectCount - self.addDelegateFormulaTimes)) / var_44_4))
	else
		setActive(self.extraProductAddnum, false)
	end

	self.extraProductList:align(var_44_4)

	return
end

function IslandFormulaSelectPage:CacaluteProductTime()
	local var_46_0

	if self.addDelegateFormulaTimes then
		var_46_0 = self.curSelectCount - self.addDelegateFormulaTimes or self.curSelectCount
	end

	return IslandProductTimeHelper.CalculateTimeToProductFormula(self.selectedShipId, self.selectFormulaId, var_46_0, self.placeId, self.slotId), math.ceil(self.formulaCfg.workload / pg.island_set.base_efficiency.key_value_int) * var_46_0
end

function IslandFormulaSelectPage:CheckInPlace(arg_47_1, arg_47_2)
	for iter_47_0, iter_47_1 in ipairs(arg_47_2) do
		if iter_47_1 == arg_47_1 then
			return true
		end
	end

	return false
end

function IslandFormulaSelectPage:GetAttrGrade(arg_48_1)
	local var_48_0 = pg.island_chara_att.all[#pg.island_chara_att.all]

	for iter_48_0, iter_48_1 in ipairs(pg.island_chara_att.all) do
		if pg.island_chara_att[iter_48_1].range[1] <= arg_48_1 and arg_48_1 <= pg.island_chara_att[iter_48_1].range[2] then
			var_48_0 = iter_48_1

			break
		end
	end

	return var_48_0
end

function IslandFormulaSelectPage:GetAttrGrowingValueByBuff(arg_49_1, arg_49_2)
	for iter_49_0, iter_49_1 in ipairs(arg_49_2) do
		if iter_49_1[1] == arg_49_1 then
			return iter_49_1[2]
		end
	end

	return 0
end

function IslandFormulaSelectPage:GetOneFormulaEnergyCost()
	return (math.max(math.floor(self.formulaCfg.stamina_cost * (1 - IslandProductCostHelper.GetReducePercentInPlace(self.selectedShipId, self.placeId))), 1))
end

function IslandFormulaSelectPage:OnHide()
	self:UnBlurPanel()

	if self.eneryTimer then
		self.eneryTimer:Stop()
	end

	return
end

function IslandFormulaSelectPage:OnDisable()
	self:OnHide()

	return
end

function IslandFormulaSelectPage:OnDestroy()
	self:OnHide()

	return
end

function IslandFormulaSelectPage:Show(...)
	self:AddListeners()
	self.islandUIController:Show(true)
	self:OnShow(...)

	return
end

function IslandFormulaSelectPage:Hide(arg_55_1, arg_55_2)
	local function var_55_0()
		self.ClosePage(self, self)
		self:RemoveListeners()
		self:OnHide()

		if not arg_55_2 then
			self:OnExit()
		end

		return
	end

	if defaultValue(arg_55_1, true) then
		self.islandUIController:Hide(true, var_55_0)
	else
		var_55_0()
	end

	return
end

return IslandFormulaSelectPage
