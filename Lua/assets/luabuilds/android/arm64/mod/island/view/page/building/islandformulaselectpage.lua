local var_0_0 = class("IslandFormulaSelectPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandFormulaSelectNewUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("top/back")
	arg_2_0.title = arg_2_0._tf:Find("top/title")
	arg_2_0.rightInfo = arg_2_0._tf:Find("rightInfo")
	arg_2_0.rightInfoEmpty = arg_2_0._tf:Find("rightInfo_empty")
	arg_2_0.currentformulaIcon = arg_2_0._tf:Find("rightInfo/formula/currentformula")
	arg_2_0.sureBtn = arg_2_0._tf:Find("rightInfo/sure")
	arg_2_0.formulaItem = arg_2_0._tf:Find("rightInfo/formula")
	arg_2_0.curCountTips = arg_2_0.formulaItem:Find("curCount")
	arg_2_0.addCountTips = arg_2_0.formulaItem:Find("addCount")
	arg_2_0.reduceBtn = arg_2_0.formulaItem:Find("limit/reduce")
	arg_2_0.addBtn = arg_2_0.formulaItem:Find("limit/add")
	arg_2_0.maxBtn = arg_2_0.formulaItem:Find("limit/max")
	arg_2_0.curCountNumSlider = arg_2_0.formulaItem:Find("limit/num_bg")
	arg_2_0.extraProduct = arg_2_0.formulaItem:Find("extra")
	arg_2_0.extraProductIcon = arg_2_0.extraProduct:Find("icon")
	arg_2_0.extraProductNum = arg_2_0.extraProductIcon:Find("product_count_bg/product_count")
	arg_2_0.extraProductName = arg_2_0.extraProduct:Find("Text")
	arg_2_0.extraProductAddnum = arg_2_0.extraProduct:Find("Text/addCount")
	arg_2_0.needTimeText = arg_2_0.sureBtn:Find("adapt/time/time_text")
	arg_2_0.barLimit = arg_2_0.formulaItem:Find("limit/hasLimit")
	arg_2_0.extraProductList = UIItemList.New(arg_2_0.extraProduct:Find("process"), arg_2_0.extraProduct:Find("process/item"))
	arg_2_0.uiList = UIItemList.New(arg_2_0._tf:Find("formulaView/content"), arg_2_0._tf:Find("formulaView/content/tpl"))
	arg_2_0.costuiList = UIItemList.New(arg_2_0._tf:Find("rightInfo/formula/needItem/content"), arg_2_0._tf:Find("rightInfo/formula/needItem/content/IslandItemTpl"))

	setText(arg_2_0._tf:Find("top/title/Text"), i18n("island_select_product"))
	setText(arg_2_0.formulaItem:Find("tips"), i18n("island_production_count"))

	arg_2_0.baseEffectSpeed = pg.island_set.base_efficiency.key_value_int
	arg_2_0.selectShipTf = arg_2_0.rightInfo:Find("selectShip")
	arg_2_0.selectShipName = arg_2_0.selectShipTf:Find("info/name")
	arg_2_0.selectShipLv = arg_2_0.selectShipTf:Find("info/lv")
	arg_2_0.selectShipIcon = arg_2_0.selectShipTf:Find("bg/icon")
	arg_2_0.skillTf = arg_2_0.selectShipTf:Find("skill")
	arg_2_0.skillInUse = arg_2_0.skillTf:Find("skillBg/skillTabBg/skill_bright")
	arg_2_0.skillUnUse = arg_2_0.skillTf:Find("skillBg/skillTabBg/skill_dark")
	arg_2_0.skillName = arg_2_0.skillTf:Find("skillBg/skillText"):GetComponent(typeof(Text))
	arg_2_0.energyBarTf = arg_2_0.selectShipTf:Find("ener_bar")
	arg_2_0.energyBarUseTf = arg_2_0.selectShipTf:Find("ener_bar_1")
	arg_2_0.energy_countTf = arg_2_0.selectShipTf:Find("energy_count")
	arg_2_0.enoughSureBg = arg_2_0.sureBtn:Find("okBg")
	arg_2_0.notenoughSureBg = arg_2_0.sureBtn:Find("notBg")
	arg_2_0.animationPlayer = arg_2_0.rightInfo:GetComponent(typeof(Animation))
	arg_2_0.addExpTF = arg_2_0.selectShipTf:Find("exp")
	arg_2_0.addExp = arg_2_0.selectShipTf:Find("exp/addExp")

	return
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddListener(GAME.ISLAND_SHOP_OP_DONE, arg_3_0.RefreshCurrentSelectFormula)

	return
end

function var_0_0.RemoveListeners(arg_4_0)
	arg_4_0:RemoveListener(GAME.ISLAND_SHOP_OP_DONE, arg_4_0.RefreshCurrentSelectFormula)

	return
end

function var_0_0.OnInit(arg_5_0)
	onButton(arg_5_0, arg_5_0._tf:Find("top/title/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_commission.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.backBtn, function()
		arg_5_0:Hide()
		existCall(arg_5_0.cancelFunc)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.reduceBtn, function()
		arg_5_0.curSelectCount = arg_5_0.curSelectCount - 1

		if arg_5_0.addDelegateFormulaTimes then
			local var_8_0 = arg_5_0.addDelegateFormulaTimes + 1 or 1

			arg_5_0.curSelectCount = var_8_0 > arg_5_0.curSelectCount and var_8_0 or arg_5_0.curSelectCount

			arg_5_0:RefreshCost()

			return
		end
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.addBtn, function()
		local var_9_0 = arg_5_0.curSelectCount + 1

		if arg_5_0.addDelegateFormulaTimes then
			local var_9_1 = arg_5_0:CheckCanAddMaxTimes() + arg_5_0.addDelegateFormulaTimes

			var_9_1 = var_9_1 > arg_5_0.productMaxTime and arg_5_0.productMaxTime or var_9_1
			var_9_0 = var_9_1 < var_9_0 and var_9_1 or var_9_0

			if var_9_0 < arg_5_0.addDelegateFormulaTimes + 1 then
				var_9_0 = arg_5_0.addDelegateFormulaTimes + 1
			end

			arg_5_0.curSelectCount = var_9_0
		else
			local var_9_2 = arg_5_0:CheckCanAddMaxTimes()

			arg_5_0.curSelectCount = var_9_2 < var_9_0 and var_9_2 or var_9_0

			if arg_5_0.curSelectCount < 1 then
				arg_5_0.curSelectCount = 1
			end
		end

		arg_5_0:RefreshCost()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.maxBtn, function()
		if arg_5_0.addDelegateFormulaTimes then
			local var_10_0 = arg_5_0:CheckCanAddMaxTimes() + arg_5_0.addDelegateFormulaTimes
			local var_10_1 = arg_5_0

			if var_10_0 > arg_5_0.productMaxTime then
				var_10_1.curSelectCount = arg_5_0.productMaxTime or var_10_0

				if arg_5_0.curSelectCount < 1 then
					arg_5_0.curSelectCount = 1
				end

				if false then
					arg_5_0.curSelectCount = arg_5_0:CheckCanAddMaxTimes()

					if arg_5_0.curSelectCount < 1 then
						arg_5_0.curSelectCount = 1
					end
				end

				arg_5_0:RefreshCost()

				return
			end
		end
	end, SFX_PANEL)
	onSlider(arg_5_0, arg_5_0.curCountNumSlider, function(arg_11_0)
		if arg_5_0.addDelegateFormulaTimes then
			local var_11_0 = arg_5_0:CheckCanAddMaxTimes() + arg_5_0.addDelegateFormulaTimes

			var_11_0 = var_11_0 > arg_5_0.productMaxTime and arg_5_0.productMaxTime or var_11_0
			arg_11_0 = var_11_0 < arg_11_0 and var_11_0 or arg_11_0

			if arg_11_0 < arg_5_0.addDelegateFormulaTimes + 1 then
				arg_11_0 = arg_5_0.addDelegateFormulaTimes + 1
			end

			arg_5_0.curSelectCount = arg_11_0
		else
			local var_11_1 = arg_5_0:CheckCanAddMaxTimes()

			arg_5_0.curSelectCount = var_11_1 < arg_11_0 and var_11_1 or arg_11_0

			if arg_5_0.curSelectCount < 1 then
				arg_5_0.curSelectCount = 1
			end
		end

		arg_5_0:RefreshCost()

		return
	end)
	onButton(arg_5_0, arg_5_0.skillTf, function()
		arg_5_0:ShowMsgBox({
			type = IslandMsgBox.TYPE_SHIP_SKILL,
			skill = arg_5_0.selectedShip:GetSkill()
		})

		return
	end, SFX_PANEL)
	arg_5_0.uiList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventInit then
			arg_5_0:InitFormulaItem(arg_13_1, arg_13_2)
		elseif arg_13_0 == UIItemList.EventUpdate then
			arg_5_0:UpdateFormulaItem(arg_13_1, arg_13_2)
		end

		return
	end)
	arg_5_0.costuiList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventInit then
			arg_5_0:InitCostItem(arg_14_1, arg_14_2)
		elseif arg_14_0 == UIItemList.EventUpdate then
			arg_5_0:UpdateCostItem(arg_14_1, arg_14_2)
		end

		return
	end)
	arg_5_0.extraProductList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventInit then
			-- block empty
		elseif arg_15_0 == UIItemList.EventUpdate then
			setActive(arg_15_2:Find("inprocess"), arg_15_1 < arg_5_0.extraProcess)
		end

		return
	end)

	return
end

function var_0_0.InitFormulaItem(arg_16_0, arg_16_1, arg_16_2)
	onButton(arg_16_0, arg_16_2, function()
		arg_16_0:OnSelectFormulaIndex(arg_16_1 + 1)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnSelectFormulaIndex(arg_18_0, arg_18_1)
	arg_18_0.selectedIdx = arg_18_1
	arg_18_0.selectFormulaId = arg_18_0.formulaList[arg_18_0.selectedIdx]
	arg_18_0.formulaCfg = pg.island_formula[arg_18_0.selectFormulaId]
	arg_18_0.productMaxTime = arg_18_0.formulaCfg.production_limit

	if arg_18_0.addDelegateFormulaTimes then
		arg_18_0.curSelectCount = arg_18_0.addDelegateFormulaTimes + 1 or 1

		arg_18_0.uiList:align(#arg_18_0.formulaList)

		return
	end
end

function var_0_0.UpdateFormulaItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = pg.island_formula[arg_19_0.formulaList[arg_19_1 + 1]]
	local var_19_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetItemById(pg.island_formula[arg_19_0.formulaList[arg_19_1 + 1]].item_id)
	local var_19_2 = var_19_1 and var_19_1:GetCount() or 0

	updateCustomDrop(arg_19_2, Drop.New({
		type = DROP_TYPE_ISLAND_ITEM,
		id = pg.island_formula[arg_19_0.formulaList[arg_19_1 + 1]].item_id,
		count = var_19_2
	}))
	setActive(arg_19_2:Find("icon_bg/count_bg"), true)
	setScrollTextWithSize(arg_19_2:Find("name"), arg_19_2:Find("scroll_name/name"), var_19_0.name, 6)
	setText(arg_19_2:Find("icon_bg/product_count_bg/product_count"), "×" .. var_19_0.commission_product[1][2])
	setText(arg_19_2:Find("icon_bg/count_bg/count"), i18n("island_production_hold", var_19_2))

	if arg_19_0.selectedIdx == arg_19_1 + 1 then
		arg_19_0:RefreshCurrentSelectFormula()
	end

	setActive(arg_19_2:Find("selected"), arg_19_0.selectedIdx == arg_19_1 + 1)

	return
end

function var_0_0.InitCostItem(arg_20_0, arg_20_1, arg_20_2)
	return
end

function var_0_0.UpdateCostItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.commission_Cost_List[arg_21_1 + 1]

	updateCustomDrop(arg_21_2, arg_21_0.commission_Cost_List[arg_21_1 + 1])

	local var_21_1 = string.format("%d/%d", arg_21_0.commission_Cost_List[arg_21_1 + 1].itemCount, arg_21_0.commission_Cost_List[arg_21_1 + 1].costCount)

	if arg_21_0.commission_Cost_List[arg_21_1 + 1].extraCostCount and arg_21_0.commission_Cost_List[arg_21_1 + 1].extraCostCount > 0 then
		var_21_1 = string.format("%d/(%d<color=#ffae22>+%d</color>)", arg_21_0.commission_Cost_List[arg_21_1 + 1].itemCount, arg_21_0.commission_Cost_List[arg_21_1 + 1].costCount, arg_21_0.commission_Cost_List[arg_21_1 + 1].extraCostCount)
	end

	setActive(arg_21_2:Find("icon_bg/count_bg"), true)
	setText(arg_21_2:Find("icon_bg/count_bg/count"), var_21_1)
	onButton(arg_21_0, arg_21_2:Find("icon_bg/icon"), function()
		arg_21_0:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_21_0
		})

		return
	end)
	onButton(arg_21_0, arg_21_2:Find("icon_bg/icon"), function()
		arg_21_0:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_21_0
		})

		return
	end)

	return
end

function var_0_0.RefreshCurrentSelectFormula(arg_24_0)
	local var_24_0 = Drop.New({
		count = 0,
		type = DROP_TYPE_ISLAND_ITEM,
		id = arg_24_0.formulaCfg.item_id
	})

	onButton(arg_24_0, arg_24_0.currentformulaIcon, function()
		arg_24_0:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_24_0
		})

		return
	end)
	GetImageSpriteFromAtlasAsync("island/islandframe", IslandItemRarity.Rarity2FrameName(var_24_0:getConfigTable().rarity), arg_24_0.currentformulaIcon:Find("icon_bg"))
	GetImageSpriteFromAtlasAsync("island/" .. var_24_0:getConfigTable().icon, "", arg_24_0.currentformulaIcon:Find("icon_bg/icon"))
	arg_24_0:RefreshCost()

	return
end

function var_0_0.GetAniExtraGainByConfigName(arg_26_0, arg_26_1)
	local var_26_0 = 0

	if arg_26_0.placeId ~= IslandProductConst.PasturePlaceId then
		return var_26_0
	end

	local var_26_1 = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(arg_26_0.placeId):GetDelegationSlotData(arg_26_0.slotId)

	for iter_26_0, iter_26_1 in ipairs((var_26_1:GetPartList())) do
		var_26_0 = var_26_0 + pg.island_ranch_animal[iter_26_1][arg_26_1]
	end

	return var_26_0
end

function var_0_0.RefreshCost(arg_27_0)
	arg_27_0.commission_Cost_List = {}

	local var_27_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	local var_27_1 = arg_27_0:GetAniExtraGainByConfigName("efficiency_cost")

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.formulaCfg.commission_cost) do
		local var_27_2 = var_27_0:GetItemById(iter_27_1[1])
		local var_27_3 = var_27_2 and var_27_2:GetCount() or 0

		if arg_27_0.addDelegateFormulaTimes then
			local var_27_4 = arg_27_0.curSelectCount - arg_27_0.addDelegateFormulaTimes or arg_27_0.curSelectCount

			table.insert(arg_27_0.commission_Cost_List, (Drop.New({
				count = 0,
				type = DROP_TYPE_ISLAND_ITEM,
				id = iter_27_1[1],
				itemCount = var_27_3,
				costCount = iter_27_1[2] * var_27_4,
				extraCostCount = var_27_1 * var_27_4
			})))
		end
	end

	arg_27_0.costuiList:align(#arg_27_0.commission_Cost_List)
	arg_27_0:RefreshCurSelectCount()
	arg_27_0:RefreshShipEnergy()
	arg_27_0:RefreshCanStart()

	return
end

function var_0_0.CheckCanAddMaxTimes(arg_28_0)
	arg_28_0.commission_Cost_List = {}

	local var_28_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	local var_28_1 = arg_28_0.productMaxTime
	local var_28_2 = arg_28_0:GetAniExtraGainByConfigName("efficiency_cost")

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.formulaCfg.commission_cost) do
		local var_28_3 = var_28_0:GetItemById(iter_28_1[1])
		local var_28_4 = var_28_3 and var_28_3:GetCount() or 0

		var_28_1 = math.min(var_28_1, math.floor(var_28_4 / (iter_28_1[2] + var_28_2)))
	end

	return (math.min(math.floor(arg_28_0.selectedShip:GetCurrentEnergy() / arg_28_0:GetOneFormulaEnergyCost()), var_28_1))
end

function var_0_0.RefreshCanStart(arg_29_0)
	local function var_29_0()
		local var_32_0 = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(arg_29_0.placeId)

		if pg.island_production_slot[arg_29_0.slotId].exclusion_slot == "" then
			local var_32_1 = {}

			if not {} then
				var_32_1 = pg.island_production_slot[arg_29_0.slotId].exclusion_slot
			end

			local var_32_2 = {}
			local var_32_3 = false

			for iter_32_0, iter_32_1 in ipairs(var_32_1) do
				if var_32_0:GetHandPlantSlotData(iter_32_1).state == 1 then
					var_32_3 = true

					table.insert(var_32_2, iter_32_1)
				end
			end

			return var_32_3, var_32_2
		end
	end

	if (function()
		for iter_30_0, iter_30_1 in ipairs(arg_29_0.commission_Cost_List) do
			if iter_30_1.costCount + iter_30_1.extraCostCount > iter_30_1.itemCount then
				return false
			end
		end

		return true
	end)() and (function()
		if arg_29_0.addDelegateFormulaTimes then
			local var_31_0 = arg_29_0.curSelectCount - arg_29_0.addDelegateFormulaTimes or arg_29_0.curSelectCount
			local var_31_1 = arg_29_0:GetOneFormulaEnergyCost() * var_31_0

			if var_31_1 > arg_29_0.selectedShip:GetCurrentEnergy() then
				return false
			end

			return true
		end
	end)() then
		setActive(arg_29_0.enoughSureBg, true)
		setActive(arg_29_0.notenoughSureBg, false)
		onButton(arg_29_0, arg_29_0.sureBtn, function()
			if arg_29_0.addDelegateFormula then
				arg_29_0.placeId = pg.island_production_slot[arg_29_0.slotId].place

				local var_33_0 = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(arg_29_0.placeId):GetDelegationSlotData(arg_29_0.slotId)

				if var_33_0 and not var_33_0:GetSlotRoleData() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("island_additional_production_tip2"))

					return
				end
			end

			local var_33_1 = arg_29_0.formulaToActivityDic[arg_29_0.selectFormulaId]

			if arg_29_0.formulaToActivityDic[arg_29_0.selectFormulaId] then
				local var_33_2 = getProxy(ActivityProxy):getActivityById(var_33_1)

				if not var_33_2 or var_33_2:isEnd() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("island_activity_expired"))

					return
				end
			end

			local var_33_3, var_33_4 = var_29_0()

			if var_33_3 then
				arg_29_0:ShowMsgBox({
					type = IslandMsgBox.TYPE_COMMON,
					content = i18n("island_production_manually_cancel"),
					onYes = function()
						pg.m02:sendNotification(GAME.ISLAND_STOP_HANDLE_PLANT_HALFWAY, {
							build_id = arg_29_0.placeId,
							slot_list = var_33_4
						})
						existCall(arg_29_0.unLoadCharacterFunc)

						local var_34_0 = arg_29_0:GetAniExtraGainByConfigName("efficiency_cost")

						if arg_29_0.addDelegateFormula then
							arg_29_0:emit(IslandMediator.ADD_DELEGATION, arg_29_0.placeId, arg_29_0.slotId, arg_29_0.curSelectCount - arg_29_0.addDelegateFormulaTimes, var_34_0)
						else
							arg_29_0:emit(IslandMediator.START_DELEGATION, arg_29_0.placeId, arg_29_0.slotId, arg_29_0.selectedShipId, arg_29_0.selectFormulaId, arg_29_0.curSelectCount, var_34_0)
						end

						existCall(arg_29_0.confirmFunc)
						arg_29_0:Hide()

						return
					end,
					onNo = function()
						return
					end
				})

				return
			end

			existCall(arg_29_0.unLoadCharacterFunc)

			local var_33_5 = arg_29_0:GetAniExtraGainByConfigName("efficiency_cost")

			if arg_29_0.addDelegateFormula then
				arg_29_0:emit(IslandMediator.ADD_DELEGATION, arg_29_0.placeId, arg_29_0.slotId, arg_29_0.curSelectCount - arg_29_0.addDelegateFormulaTimes, var_33_5)
			else
				arg_29_0:emit(IslandMediator.START_DELEGATION, arg_29_0.placeId, arg_29_0.slotId, arg_29_0.selectedShipId, arg_29_0.selectFormulaId, arg_29_0.curSelectCount, var_33_5)
			end

			existCall(arg_29_0.confirmFunc)
			arg_29_0:Hide()

			return
		end, SFX_PANEL)
	else
		setActive(arg_29_0.enoughSureBg, false)
		setActive(arg_29_0.notenoughSureBg, true)
		onButton(arg_29_0, arg_29_0.sureBtn, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_production_cost_notenough"))

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.OnShow(arg_37_0, arg_37_1)
	arg_37_0:BlurPanel()

	arg_37_0.commissionId = arg_37_1.commissionId
	arg_37_0.selectedShipId = arg_37_1.selectedShipId
	arg_37_0.cancelFunc = arg_37_1.cancelFunc
	arg_37_0.confirmFunc = arg_37_1.confirmFunc
	arg_37_0.unLoadCharacterFunc = arg_37_1.unLoadCharacterFunc
	arg_37_0.addDelegateFormula = arg_37_1.addDelegateFormula
	arg_37_0.addDelegateFormulaTimes = arg_37_1.addDelegateFormulaTimes
	arg_37_0.canRewardTime = arg_37_1.canRewardTime
	arg_37_0.selectFormulaId = arg_37_1.selectFormulaId

	setActive(arg_37_0.addExpTF, arg_37_0.selectedShipId ~= 1)

	if arg_37_0.addDelegateFormulaTimes then
		setActive(arg_37_0.barLimit, true)

		local var_37_0 = pg.island_formula[arg_37_0.addDelegateFormula].production_limit or 5

		arg_37_0.barLimit.sizeDelta = Vector2(arg_37_0.addDelegateFormulaTimes / var_37_0 * 352.6, 22)

		setActive(arg_37_0.addCountTips, true)
	else
		setActive(arg_37_0.barLimit, false)
		setActive(arg_37_0.addCountTips, false)
	end

	local var_37_1 = arg_37_0.addDelegateFormulaTimes and i18n("island_additional_production_tip1") or i18n("island_production_start")

	setText(arg_37_0.sureBtn:Find("adapt/time/Text"), var_37_1)

	arg_37_0.slotId = pg.island_production_commission[arg_37_0.commissionId].slot
	arg_37_0.placeId = pg.island_production_slot[arg_37_0.slotId].place
	arg_37_0.selectedShip = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_37_0.selectedShipId)

	arg_37_0:InitUnlockedFormulaList()

	if #arg_37_0.formulaList > 0 then
		local var_37_2 = 1

		if arg_37_0.selectFormulaId then
			for iter_37_0, iter_37_1 in ipairs(arg_37_0.formulaList) do
				if iter_37_1 == arg_37_0.selectFormulaId then
					var_37_2 = iter_37_0

					break
				end
			end
		end

		arg_37_0:OnSelectFormulaIndex(var_37_2)
		onNextTick(function()
			local var_38_0 = arg_37_0._tf:Find("formulaView/content")

			setAnchoredPosition(var_38_0, {
				y = math.min((var_37_2 - 1) * arg_37_0._tf:Find("formulaView/content/tpl").rect.height, var_38_0.sizeDelta.y)
			})

			return
		end)
	else
		arg_37_0.uiList:align(#arg_37_0.formulaList)
		setActive(arg_37_0.rightInfo, false)
		setActive(arg_37_0.rightInfoEmpty, true)
	end

	arg_37_0:RefreshShip()

	return
end

function var_0_0.RefreshShip(arg_39_0)
	GetImageSpriteFromAtlasAsync("SquareIcon/" .. IslandShip.StaticGetPrefab(arg_39_0.selectedShipId), "", arg_39_0.selectShipIcon)
	setText(arg_39_0.selectShipName, arg_39_0.selectedShip:GetName())
	setText(arg_39_0.selectShipLv, string.format("-Lv.%d", arg_39_0.selectedShip:GetLevel()))

	local var_39_0 = arg_39_0.selectedShip:GetSkill()
	local var_39_1 = var_39_0:IsEffectiveInPlace(arg_39_0.placeId)

	setActive(arg_39_0.skillInUse, var_39_1)
	setActive(arg_39_0.skillUnUse, not var_39_1)
	setActive(arg_39_0.skillUnUse, not var_39_1)

	arg_39_0.skillName.text = string.format("%s - %s", var_39_0:GetName(), "Lv." .. var_39_0:GetLevel() .. "")

	return
end

function var_0_0.RefreshShipEnergy(arg_40_0)
	if arg_40_0.addDelegateFormulaTimes then
		local var_40_0 = arg_40_0.curSelectCount - arg_40_0.addDelegateFormulaTimes or arg_40_0.curSelectCount
		local var_40_1 = arg_40_0:GetOneFormulaEnergyCost() * var_40_0

		if arg_40_0.selectedShipId == 1 then
			var_40_1 = 0
		else
			arg_40_0.animationPlayer:Play("anim_IslandFormulaSelectNewUI_bar_Loop")
		end

		setText(arg_40_0.addExp, "EXP+" .. arg_40_0.formulaCfg.ship_exp * var_40_0)

		if arg_40_0.eneryTimer then
			arg_40_0.eneryTimer:Stop()
		end

		arg_40_0.eneryTimer = Timer.New(function()
			local var_41_0 = arg_40_0.selectedShip:GetCurrentEnergy()
			local var_41_1 = arg_40_0.selectedShip:GetMaxEnergy()

			setSlider(arg_40_0.energyBarTf, 0, 1, (var_41_0 - var_40_1) / var_41_1)
			setSlider(arg_40_0.energyBarUseTf, 0, 1, var_41_0 / var_41_1)
			setText(arg_40_0.energy_countTf, string.format("%d-<color=#f7c35f>%d</color>/%d", var_41_0, var_40_1, var_41_1))

			return
		end, 1, -1)

		arg_40_0.eneryTimer:Start()
		arg_40_0.eneryTimer.func()

		return
	end
end

function var_0_0.InitUnlockedFormulaList(arg_42_0)
	arg_42_0.formulaList = {}
	arg_42_0.formulaToActivityDic = {}

	if arg_42_0.addDelegateFormula then
		table.insert(arg_42_0.formulaList, arg_42_0.addDelegateFormula)

		return
	end

	local var_42_0 = getProxy(IslandProxy):GetIsland():GetAblityAgency()
	local var_42_1 = pg.island_production_slot[arg_42_0.slotId].activity_formula or {}

	for iter_42_0, iter_42_1 in ipairs(var_42_1) do
		local var_42_2 = iter_42_1[1]
		local var_42_3 = getProxy(ActivityProxy):getActivityById(iter_42_1[1])

		if var_42_3 and not var_42_3:isEnd() then
			for iter_42_2, iter_42_3 in ipairs(iter_42_1[2] or {}) do
				if pg.island_formula[iter_42_3].unlock_type == 0 or var_42_0:IsUnlockFormuate(iter_42_3) then
					table.insert(arg_42_0.formulaList, iter_42_3)

					arg_42_0.formulaToActivityDic[iter_42_3] = var_42_2
				end
			end
		end
	end

	local var_42_4 = pg.island_production_slot[arg_42_0.slotId].formula or {}

	for iter_42_4, iter_42_5 in ipairs(var_42_4) do
		local var_42_5 = pg.island_formula[iter_42_5].unlock_type == 0
		local var_42_6 = pg.island_formula[iter_42_5].unlock_type == -1
		local var_42_7 = true

		if pg.island_formula[iter_42_5].unlock_type == -1 then
			local var_42_8 = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetFormulaNums()

			for iter_42_6, iter_42_7 in ipairs(pg.island_combo[iter_42_5].unlock_condition) do
				if not var_42_8[iter_42_7[1]] or iter_42_7[2] > var_42_8[iter_42_7[1]] then
					var_42_7 = false

					break
				end
			end
		end

		local var_42_9 = var_42_5 or var_42_0:IsUnlockFormuate(iter_42_5) or var_42_6 and var_42_7

		if var_42_9 then
			table.insert(arg_42_0.formulaList, iter_42_5)
		end
	end

	return
end

function var_0_0.RefreshCurSelectCount(arg_43_0)
	setText(arg_43_0.curCountTips, tostring(var_43_0))

	if arg_43_0.addDelegateFormulaTimes then
		local var_43_1 = arg_43_0.curSelectCount - arg_43_0.addDelegateFormulaTimes or 0

		setText(arg_43_0.addCountTips, "+" .. var_43_1)
		setSlider(arg_43_0.curCountNumSlider, 1, arg_43_0.productMaxTime, arg_43_0.curSelectCount)
		arg_43_0:RefreshExtraProduct()

		local var_43_2 = "×" .. arg_43_0.formulaCfg.commission_product[1][2]
		local var_43_3 = arg_43_0:GetAniExtraGainByConfigName("efficiency_gains_num")

		if var_43_3 > 0 then
			var_43_2 = string.format("×(%s<color=#7df39f>+%d</color>)", arg_43_0.formulaCfg.commission_product[1][2], var_43_3)
		end

		setText(arg_43_0.currentformulaIcon:Find("icon_bg/product_count_bg/product_count"), var_43_2 .. i18n("island_production_tip"))

		local var_43_4, var_43_5 = arg_43_0:CacaluteProductTime()
		local var_43_6 = 0

		for iter_43_0, iter_43_1 in ipairs(var_43_4) do
			var_43_6 = var_43_6 + iter_43_1
		end

		local var_43_7 = pg.TimeMgr.GetInstance():DescCDTime(var_43_6)

		if var_43_5 - var_43_6 > 0 then
			var_43_7 = string.format("%s(<color=#7df39f>-%s</color>)", var_43_7, pg.TimeMgr.GetInstance():DescCDTime(var_43_5 - var_43_6))
		end

		setText(arg_43_0.needTimeText, var_43_7)

		return
	end
end

function var_0_0.RefreshExtraProduct(arg_44_0)
	local var_44_9000

	if #arg_44_0.formulaCfg.second_product == 0 or not getProxy(IslandProxy):GetIsland():GetAblityAgency():IsUnlcokSecondProduct(arg_44_0.selectFormulaId) then
		setActive(arg_44_0.extraProduct, false)

		return
	end

	setActive(arg_44_0.extraProduct, true)

	local var_44_0 = pg.island_item_data_template[arg_44_0.formulaCfg.second_product_display[1][1]]
	local var_44_1 = Drop.New({
		count = 0,
		type = DROP_TYPE_ISLAND_ITEM,
		id = arg_44_0.formulaCfg.second_product_display[1][1]
	})

	onButton(arg_44_0, arg_44_0.extraProductIcon, function()
		arg_44_0:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_44_1
		})

		return
	end)
	GetImageSpriteFromAtlasAsync("island/" .. var_44_0.icon, "", arg_44_0.extraProductIcon)

	local var_44_2 = "×" .. arg_44_0.formulaCfg.second_product_display[1][2]
	local var_44_3 = arg_44_0:GetAniExtraGainByConfigName("efficiency_gains_bonus_num")

	if var_44_3 > 0 then
		var_44_2 = string.format("×(%s<color=#7df39f>+%d</color>)", arg_44_0.formulaCfg.second_product_display[1][2], var_44_3)
	end

	setText(arg_44_0.extraProductNum, var_44_2 .. i18n("island_production_tip"))

	local var_44_4 = getProxy(IslandProxy)
	local var_44_5 = arg_44_0.formulaCfg.second_product[1]
	local var_44_6 = arg_44_0.canRewardTime or 0
	local var_44_7 = (var_44_4.GetIsland(var_44_9000):GetBuildingAgency():GetBuilding(pg.island_production_slot[arg_44_0.slotId].place):GetDelegationSlotData(arg_44_0.slotId).GetFromulaTatalCount(var_44_4, arg_44_0.formulaCfg.id) + var_44_6) % var_44_5

	if arg_44_0.addDelegateFormulaTimes then
		local var_44_8 = arg_44_0.curSelectCount - arg_44_0.addDelegateFormulaTimes or arg_44_0.curSelectCount

		arg_44_0.extraProcess = (var_44_7 + var_44_8) % var_44_5

		setText(arg_44_0.extraProductName, var_44_0.name .. "×" .. math.floor((var_44_7 + var_44_8) / var_44_5))

		if arg_44_0.addDelegateFormulaTimes then
			setActive(arg_44_0.extraProductAddnum, true)
			setText(arg_44_0.extraProductAddnum, "+" .. math.floor((var_44_7 + (arg_44_0.curSelectCount - arg_44_0.addDelegateFormulaTimes)) / var_44_5))
		else
			setActive(arg_44_0.extraProductAddnum, false)
		end

		arg_44_0.extraProductList:align(var_44_5)

		return
	end
end

function var_0_0.CacaluteProductTime(arg_46_0)
	if arg_46_0.addDelegateFormulaTimes then
		local var_46_0 = arg_46_0.curSelectCount - arg_46_0.addDelegateFormulaTimes or arg_46_0.curSelectCount

		return IslandProductTimeHelper.CalculateTimeToProductFormula(arg_46_0.selectedShipId, arg_46_0.selectFormulaId, var_46_0, arg_46_0.placeId, arg_46_0.slotId), math.ceil(arg_46_0.formulaCfg.workload / pg.island_set.base_efficiency.key_value_int) * var_46_0
	end
end

function var_0_0.CheckInPlace(arg_47_0, arg_47_1, arg_47_2)
	for iter_47_0, iter_47_1 in ipairs(arg_47_2) do
		if iter_47_1 == arg_47_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetAttrGrade(arg_48_0, arg_48_1)
	local var_48_0 = pg.island_chara_att.all[#pg.island_chara_att.all]

	for iter_48_0, iter_48_1 in ipairs(pg.island_chara_att.all) do
		if pg.island_chara_att[iter_48_1].range[1] <= arg_48_1 and arg_48_1 <= pg.island_chara_att[iter_48_1].range[2] then
			var_48_0 = iter_48_1

			break
		end
	end

	return var_48_0
end

function var_0_0.GetAttrGrowingValueByBuff(arg_49_0, arg_49_1, arg_49_2)
	for iter_49_0, iter_49_1 in ipairs(arg_49_2) do
		if iter_49_1[1] == arg_49_1 then
			return iter_49_1[2]
		end
	end

	return 0
end

function var_0_0.GetOneFormulaEnergyCost(arg_50_0)
	return (math.max(math.floor(arg_50_0.formulaCfg.stamina_cost * (1 - IslandProductCostHelper.GetReducePercentInPlace(arg_50_0.selectedShipId, arg_50_0.placeId))), 1))
end

function var_0_0.OnHide(arg_51_0)
	arg_51_0:UnBlurPanel()

	if arg_51_0.eneryTimer then
		arg_51_0.eneryTimer:Stop()
	end

	return
end

function var_0_0.OnDisable(arg_52_0)
	arg_52_0:OnHide()

	return
end

function var_0_0.OnDestroy(arg_53_0)
	arg_53_0:OnHide()

	return
end

function var_0_0.Show(arg_54_0, ...)
	arg_54_0:AddListeners()
	arg_54_0.islandUIController:Show(true)
	arg_54_0:OnShow(...)

	return
end

function var_0_0.Hide(arg_55_0, arg_55_1, arg_55_2)
	if defaultValue(arg_55_1, true) then
		arg_55_0.islandUIController:Hide(true, function()
			arg_55_0.ClosePage(arg_55_0, arg_55_0)
			arg_55_0:RemoveListeners()
			arg_55_0:OnHide()

			if not arg_55_2 then
				arg_55_0:OnExit()
			end

			return
		end)
	else
		(function()
			arg_55_0.ClosePage(arg_55_0, arg_55_0)
			arg_55_0:RemoveListeners()
			arg_55_0:OnHide()

			if not arg_55_2 then
				arg_55_0:OnExit()
			end

			return
		end)()
	end

	return
end

return var_0_0
