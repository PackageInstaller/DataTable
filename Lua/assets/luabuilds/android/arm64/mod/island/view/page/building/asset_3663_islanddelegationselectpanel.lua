local IslandDelegationSelectPanel = class("IslandDelegationSelectPanel", import("view.base.BaseSubView"))

function IslandDelegationSelectPanel:getUIName()
	return "IslandDelegationSelectPanel"
end

function IslandDelegationSelectPanel:OnLoaded()
	self.closeBtn = self._tf:Find("close")
	self.layoutTF = self._tf:Find("layout")

	local var_2_0 = self._tf:Find("layout/select_container/selectInfo")

	self.slotNameTF = var_2_0:Find("slotName")
	self.unlockSlot = var_2_0:Find("unlock")
	self.lockSlot = var_2_0:Find("lock")
	self.emptyAddShipTF = self.unlockSlot:Find("empty")
	self.quickBtn = self.unlockSlot:Find("emptyBtn")
	self.contentTF = self.unlockSlot:Find("content")
	self.processTF = self.contentTF:Find("process")
	self.selectShipTF = self.processTF:Find("ship/selectShip")
	self.selectShipBtn = self.selectShipTF:Find("selectShipButton")
	self.energySliderTF = self.selectShipTF:Find("energy/energy_bar")
	self.energyTFText = self.selectShipTF:Find("energy/Text")
	self.seletShipName = self.selectShipTF:Find("name")
	self.shipIconTF = self.selectShipTF:Find("icon_mask/icon")
	self.expGetTF = self.selectShipTF:Find("exp_get")

	setActive(self.expGetTF, false)

	self.selectFormulaBtn = self.processTF:Find("selectFormula")
	self.inprocessFormulaTF = self.processTF:Find("inprocess")
	self.inproduction = self.inprocessFormulaTF:Find("inproduction")
	self.speedupBtn = self.inproduction:Find("quick")
	self.timeTF = self.inproduction:Find("time/Text")
	self.roleDelegationSliderTF = self.inproduction:Find("time/time_bar")
	self.currentFormula = self.inprocessFormulaTF:Find("formulalayout/formula")
	self.currentFormulaIcon = self.currentFormula:Find("curformula")
	self.currentFormulaNum = self.currentFormulaIcon:Find("product_count_bg/product_count")
	self.currentFormulaLastNum = self.currentFormula:Find("tips_num")
	self.formulaProcess = self.currentFormula:Find("process"):GetComponent(typeof(Image))
	self.extraProduct = self.inprocessFormulaTF:Find("formulalayout/second_formula")
	self.extraProductIcon = self.extraProduct:Find("bg/icon")
	self.extraProductName = self.extraProduct:Find("name")
	self.extraProductNum = self.extraProductIcon:Find("product_count_bg/product_count")
	self.extraProductLastNum = self.extraProduct:Find("name/num")
	self.currentExtroFormula = self.inprocessFormulaTF:Find("formulalayout/second_formula")
	self.finishTF = self.contentTF:Find("finish")
	self.finishFurmalaIcon = self.finishTF:Find("formulalayout/formula/curformula")

	setText(self.finishTF:Find("formulalayout/formula/tips"), i18n("island_production_finish"))

	self.stopBtn = self.contentTF:Find("btns/stop")
	self.getBtn = self.contentTF:Find("btns/get")
	self.addBtn = self.contentTF:Find("btns/add")
	self.canRewardIcon = self.getBtn:Find("hasicon")
	self.canRewardNum = self.getBtn:Find("num")
	self.canExtraRewardIcon = self.getBtn:Find("extraIcon")
	self.canExtraRewardNum = self.getBtn:Find("extraNum")
	self.shipDetailsBtn = self.processTF:Find("ship/details")
	self.shipDetailsPanel = self._tf:Find("layout/ship_container")
	self.shipDetailBack = self.shipDetailsPanel:Find("back")
	self.shipSkillEmp = self.shipDetailsPanel:Find("skillEmp")
	self.shipSkillEmpDes = self.shipDetailsPanel:Find("skillEmp/Text")
	self.shipSkillDetails = self.shipDetailsPanel:Find("skill")
	self.shipDetailsIcon = self.shipSkillDetails:Find("icon")
	self.shipDetailsName = self.shipSkillDetails:Find("name"):GetComponent(typeof(Text))
	self.shipDetailsDes = self.shipSkillDetails:Find("desc/Text"):GetComponent(typeof(Text))

	setText(self.shipDetailsPanel:Find("title"), i18n("island_production_character_info"))
	setText(self.getBtn:Find("Text"), i18n("island_production_collect"))
	setText(self.addBtn:Find("num"), i18n("island_additional_production_tip1"))
	setText(self.currentFormula:Find("tips"), i18n("island_production_count"))
	setText(self.quickBtn:Find("Text"), i18n("island_quick_delegation"))
	self:ApplyDiff()

	self.extraProductList = UIItemList.New(self.extraProduct:Find("process"), self.extraProduct:Find("process/item"))

	return
end

function IslandDelegationSelectPanel:ApplyDiff()
	if self.contextData and self.contextData.isPermanent then
		setActive(self.closeBtn, false)
	end

	if self.contextData and self.contextData.alignRight then
		self.layoutTF.anchorMin = Vector2(1, 0.5)
		self.layoutTF.anchorMax = Vector2(1, 0.5)
		self.layoutTF.pivot = Vector2(1, 0.5)

		setAnchoredPosition(self.layoutTF, {
			x = -35,
			y = 0
		})
	end

	return
end

function IslandDelegationSelectPanel:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.shipDetailsBtn, function()
		self:ShowDetailPanel()

		return
	end)
	onButton(self, self.shipDetailBack, function()
		self:HideDetailPanel()

		return
	end)
	onButton(self, self.emptyAddShipTF, function()
		self:OpenShipSelectPage()

		return
	end, SFX_PANEL)
	onButton(self, self.selectShipBtn, function()
		self:OpenShipSelectPage()

		return
	end, SFX_PANEL)
	onButton(self, self.selectFormulaBtn, function()
		self:OpenFormulaSelectPage()

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		local var_11_0 = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(self.placeId):GetDelegationSlotData(self.slotId)

		if not var_11_0 then
			return
		end

		self:emit(IslandMediator.GET_DELEGATION_AWARD, self.placeId, self.slotId, not var_11_0:GetSlotRoleData() and var_11_0:GetSlotRewardData() and 2 or 1, nil, self.contextData.isPost)

		return
	end, SFX_PANEL)
	onButton(self, self.stopBtn, function()
		self:emit(IslandMediator.STOP_DELEGATION, self.placeId, self.slotId)

		return
	end, SFX_PANEL)
	onButton(self, self.speedupBtn, function()
		self:emit(IslandMediator.OPEN_PAGE, "IslandTicketUsePage", {
			IslandUseTicketCommand.TYPES.APPOINT,
			self.slotId
		})

		return
	end, SFX_PANEL)
	self.extraProductList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventInit then
			-- block empty
		elseif arg_14_0 == UIItemList.EventUpdate then
			setActive(arg_14_2:Find("inprocess"), arg_14_1 < self.extraProcess)
		end

		return
	end)
	onButton(self, self.quickBtn, function()
		local var_15_0, var_15_1 = (function()
			return UnpackIntFromString((PlayerPrefs.GetString(IslandStartDelegationCommand.GetLocalKeyForLastData(self.slotId), "")))
		end)()
		local var_15_2 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(var_15_0)

		if not var_15_2:IsDelegable() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_quick_delegation_notenough_onduty", var_15_2:GetName()))

			self.selectedShipId = 1
		elseif math.max(math.floor(pg.island_formula[var_15_1].stamina_cost * (1 - IslandProductCostHelper.GetReducePercentInPlace(var_15_0, self.placeId))), 1) > var_15_2:GetCurrentEnergy() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_quick_delegation_notenough_encourage", var_15_2:GetName()))

			self.selectedShipId = 1
		else
			self.selectedShipId = var_15_0
		end

		self:OpenFormulaSelectPage(nil, nil, nil, nil, var_15_1)

		return
	end, SFX_PANEL)

	return
end

function IslandDelegationSelectPanel:ShowDetailPanel()
	setActive(self.shipDetailsPanel, true)

	local var_17_0 = self.showShip:GetSkill()
	local var_17_1 = var_17_0:IsUnlock()

	setActive(self.shipSkillDetails, var_17_1)
	setActive(self.shipSkillEmp, not var_17_1)
	setText(self.shipSkillEmpDes, i18n("island_need_star", self.showShip:GetSkillUnlockLevel()))
	GetImageSpriteFromAtlasAsync("island/IslandSkillIcon/" .. var_17_0:GetIcon(), "", self.shipDetailsIcon)

	self.shipDetailsName.text = string.format("%s - %s", var_17_0:GetName(), "[Lv." .. var_17_0:GetLevel() .. "]")
	self.shipDetailsDes.text = var_17_0:GetEffectDesc()

	return
end

function IslandDelegationSelectPanel:HideDetailPanel()
	setActive(self.shipDetailsPanel, false)

	return
end

function IslandDelegationSelectPanel:Show(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	self.super.Show(self)

	self.loadCharacterFunc = arg_19_3
	self.unLoadCharacterFunc = arg_19_4
	self.selectedShipId = arg_19_2
	self.commissionId = arg_19_1 or self.commissionId
	self.slotId = pg.island_production_commission[self.commissionId].slot
	self.placeId = pg.island_production_slot[self.slotId].place

	if self.placeId == IslandProductConst.PasturePlaceId then
		IslandGuideChecker.CheckGuide("ISLAND_GUIDE_24")
	end

	self.timeMgr = pg.TimeMgr.GetInstance()

	self:HideDetailPanel()
	self:Flush()

	return
end

function IslandDelegationSelectPanel:Flush()
	self:FlushInfos()
	self:StopTimer()
	self:StartTimer()

	return
end

function IslandDelegationSelectPanel:FlushInfos()
	self.slotData = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(self.placeId):GetDelegationSlotData(self.slotId)

	setText(self.slotNameTF, pg.island_production_place[self.placeId].name .. "-" .. pg.island_production_commission[self.commissionId].name)
	setActive(self.lockSlot, not self.slotData)
	setActive(self.unlockSlot, self.slotData)
	setActive(self.addBtn, false)
	setActive(self.canExtraRewardIcon, false)
	setActive(self.canExtraRewardNum, false)

	if not self.slotData then
		return
	end

	if self.slotData:CanStartDelegation() then
		setActive(self.finishTF, false)
		setActive(self.emptyAddShipTF, not self.selectedShipId)
		setActive(self.contentTF, self.selectedShipId)

		if PlayerPrefs.GetString(IslandStartDelegationCommand.GetLocalKeyForLastData(self.slotId), "") ~= "" then
			setActive(self.quickBtn, true)
		else
			setActive(self.quickBtn, false)
		end

		setActive(self.processTF, self.selectedShipId)
		setActive(self.selectShipBtn, self.selectedShipId)
		setActive(self.selectFormulaBtn, self.selectedShipId)
		setActive(self.inprocessFormulaTF, false)

		if self.selectedShipId then
			self.showShip = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(self.selectedShipId)

			local var_21_0 = self.showShip:GetCurrentEnergy()
			local var_21_1 = self.showShip:GetMaxEnergy()

			setText(self.energyTFText, var_21_0 .. "/" .. var_21_1)
			setSlider(self.energySliderTF, 0, 1, var_21_0 / var_21_1)
			setText(self.seletShipName, self.showShip:GetName())
			GetImageSpriteFromAtlasAsync("ShipYardIcon/" .. IslandShip.StaticGetPrefab(self.selectedShipId), "", self.shipIconTF)
		end

		setActive(self.stopBtn, false)
		setActive(self.getBtn, false)
	else
		setActive(self.contentTF, true)
		setActive(self.emptyAddShipTF, false)
		setActive(self.quickBtn, false)
		setActive(self.selectShipBtn, false)
		setActive(self.selectFormulaBtn, false)

		local var_21_2 = self.slotData:GetSlotRoleData()
		local var_21_3 = self.slotData:GetSlotRewardData()
		local var_21_4 = not var_21_2 and var_21_3

		setActive(self.processTF, not (not var_21_2 and var_21_3))
		setActive(self.finishTF, var_21_4)
		setActive(self.getBtn, var_21_4)
		setActive(self.stopBtn, not var_21_4)
		setActive(self.inprocessFormulaTF, not var_21_4)

		if var_21_4 then
			local var_21_5 = var_21_3.formula_id

			GetImageSpriteFromAtlasAsync("island/" .. Drop.New({
				count = 0,
				type = DROP_TYPE_ISLAND_ITEM,
				id = pg.island_formula[var_21_3.formula_id].commission_product[1][1]
			}):getConfigTable().icon, "", self.canRewardIcon)

			local var_21_6 = var_21_3.main_num or 0
			local var_21_7 = "×" .. var_21_3.formula_drop_list[1].num * pg.island_formula[var_21_3.formula_id].commission_product[1][2] + var_21_6

			if var_21_6 > 0 then
				setTextColor(self.canRewardNum, Color.NewHex("#7df39f"))
			else
				setTextColor(self.canRewardNum, Color.NewHex("#FFFFFF"))
			end

			setText(self.canRewardNum, var_21_7)
			GetImageSpriteFromAtlasAsync("island/" .. pg.island_item_data_template[pg.island_formula[var_21_5].item_id].icon, "", self.finishFurmalaIcon)

			if var_21_3.formula_drop_list[2] then
				setActive(self.canExtraRewardIcon, true)
				setActive(self.canExtraRewardNum, true)
				GetImageSpriteFromAtlasAsync("island/" .. Drop.New({
					count = 0,
					type = DROP_TYPE_ISLAND_ITEM,
					id = pg.island_formula[var_21_5].second_product_display[1][1]
				}):getConfigTable().icon, "", self.canExtraRewardIcon)

				local var_21_8 = var_21_3.other_num or 0
				local var_21_9 = "×" .. var_21_3.formula_drop_list[2].num * pg.island_formula[var_21_5].second_product_display[1][2] + var_21_8

				if var_21_8 > 0 then
					setTextColor(self.canExtraRewardNum, Color.NewHex("#7df39f"))
				else
					setTextColor(self.canExtraRewardNum, Color.NewHex("#FFFFFF"))
				end

				setText(self.canExtraRewardNum, var_21_9)
			end
		end

		if var_21_2 then
			self.showShip = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(var_21_2.ship_id)

			local var_21_10 = self.showShip:GetCurrentEnergy()
			local var_21_11 = self.showShip:GetMaxEnergy()

			setText(self.energyTFText, var_21_10 .. "/" .. var_21_11)
			setSlider(self.energySliderTF, 0, 1, var_21_10 / var_21_11)
			setText(self.seletShipName, self.showShip:GetName())
			GetImageSpriteFromAtlasAsync("ShipYardIcon/" .. IslandShip.StaticGetPrefab(var_21_2.ship_id), "", self.shipIconTF)

			local var_21_12 = Drop.New({
				count = 0,
				type = DROP_TYPE_ISLAND_ITEM,
				id = pg.island_formula[var_21_2.formula_id].commission_product[1][1]
			})

			onButton(self, self.currentFormulaIcon, function()
				self.contextData:ShowMsgBox({
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_21_12
				})

				return
			end)
			GetImageSpriteFromAtlasAsync("island/" .. pg.island_item_data_template[pg.island_formula[var_21_2.formula_id].commission_product[1][1]].icon, "", self.currentFormulaIcon)
			setText(self.currentFormulaNum, "×" .. pg.island_formula[var_21_2.formula_id].commission_product[1][2])
			GetImageSpriteFromAtlasAsync("island/" .. pg.island_item_data_template[pg.island_formula[var_21_2.formula_id].commission_product[1][1]].icon, "", self.canRewardIcon)

			if #pg.island_formula[var_21_2.formula_id].second_product == 0 or not getProxy(IslandProxy):GetIsland():GetAblityAgency():IsUnlcokSecondProduct(var_21_2.formula_id) then
				setActive(self.extraProduct, false)
				setActive(self.canExtraRewardIcon, false)
				setActive(self.canExtraRewardNum, false)
			else
				setActive(self.extraProduct, true)
				GetImageSpriteFromAtlasAsync("island/" .. pg.island_item_data_template[pg.island_formula[var_21_2.formula_id].second_product_display[1][1]].icon, "", self.extraProductIcon)
				GetImageSpriteFromAtlasAsync("island/" .. pg.island_item_data_template[pg.island_formula[var_21_2.formula_id].second_product_display[1][1]].icon, "", self.canExtraRewardIcon)
				setText(self.extraProductName, pg.island_item_data_template[pg.island_formula[var_21_2.formula_id].second_product_display[1][1]].name)
				setText(self.extraProductNum, "×" .. pg.island_formula[var_21_2.formula_id].second_product_display[1][2])

				local var_21_13 = Drop.New({
					count = 0,
					type = DROP_TYPE_ISLAND_ITEM,
					id = pg.island_formula[var_21_2.formula_id].second_product_display[1][1]
				})

				onButton(self, self.extraProductIcon, function()
					self.contextData:ShowMsgBox({
						title = i18n("island_word_desc"),
						type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
						dropData = var_21_13
					})

					return
				end)
			end
		end
	end

	return
end

function IslandDelegationSelectPanel:AfterShipSelect(arg_24_1)
	self.selectedShipId = arg_24_1

	self:Flush()
	existCall(self.loadCharacterFunc, self.selectedShipId)
	self:OpenFormulaSelectPage()

	return
end

function IslandDelegationSelectPanel:OpenShipSelectPage()
	self:emit(IslandMediator.OPEN_PAGE, "IslandShipSelectPage", {
		{
			needWorkSpeed = true,
			showType = IslandSelectShipCard.SHOW_TYPE.PLACE,
			attrType = pg.island_production_slot[self.slotId].attribute,
			confirmFunc = function(self)
				self:AfterShipSelect(self[1])

				return
			end,
			placeId = self.placeId
		}
	})

	return
end

function IslandDelegationSelectPanel:OpenFormulaSelectPage(arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	self:emit(IslandMediator.OPEN_PAGE, "IslandFormulaSelectPage", {
		{
			commissionId = self.commissionId,
			selectedShipId = arg_27_4 or self.selectedShipId,
			unLoadCharacterFunc = self.unLoadCharacterFunc,
			addDelegateFormula = arg_27_1,
			addDelegateFormulaTimes = arg_27_2,
			canRewardTime = arg_27_3,
			selectFormulaId = arg_27_5,
			confirmFunc = function()
				if self.contextData and self.contextData.isPermanent then
					return
				end

				self:Hide()

				return
			end
		}
	})
	self:HideDetailPanel()

	return
end

function IslandDelegationSelectPanel:UpdateTime()
	local var_29_0 = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(self.placeId):GetDelegationSlotData(self.slotId)

	if not var_29_0 then
		self:FlushInfos()

		return
	end

	local var_29_1 = var_29_0:GetSlotRoleData()

	if not var_29_1 then
		self:FlushInfos()

		return
	end

	local var_29_2 = var_29_1:GetFinishTime() - self.timeMgr:GetServerTime()

	setText(self.timeTF, self.timeMgr:DescCDTime(var_29_2))
	setSlider(self.roleDelegationSliderTF, 0, 1, 1 - var_29_2 / var_29_1:GetAllTime())

	local var_29_3 = var_29_1:CanRewardTimes()
	local var_29_4 = var_29_1.formula_id
	local var_29_5 = pg.island_formula[var_29_1.formula_id]
	local var_29_6 = var_29_1:GetCurrentCanRewardExtraMainNum()
	local var_29_7 = "×" .. tostring(pg.island_formula[var_29_1.formula_id].commission_product[1][2] * var_29_3 + var_29_6)

	if var_29_6 and var_29_6 > 0 then
		setTextColor(self.canRewardNum, Color.NewHex("#7df39f"))
	else
		setTextColor(self.canRewardNum, Color.NewHex("#FFFFFF"))
	end

	setText(self.canRewardNum, var_29_7)

	local var_29_8 = var_29_1:InCurrentTime()

	self.formulaProcess.fillAmount = (self.timeMgr:GetServerTime() - var_29_1:InCurrentTimeStart(var_29_8)) / var_29_1:CurrentTimeNeed(var_29_8)

	local var_29_9 = var_29_1:LastTimes()

	setText(self.currentFormulaLastNum, var_29_9)

	local var_29_10 = var_29_1:GetExtraMainProduct(var_29_8)

	setText(self.currentFormulaNum, ((var_29_10 > 0 or nil) and string.format("×(%s<color=#7df39f>+%d</color>)", var_29_5.commission_product[1][2], var_29_10)) .. i18n("island_production_tip"))

	if var_29_3 > 0 then
		setActive(self.getBtn, true)
		setActive(self.addBtn, false)
	else
		setActive(self.addBtn, var_29_9 < (var_29_5.production_limit or 5))
		onButton(self, self.addBtn, function()
			self:OpenFormulaSelectPage(var_29_4, var_29_9, var_29_3, var_29_1.ship_id)

			return
		end, SFX_PANEL)
	end

	if #var_29_5.second_product ~= 0 then
		if not getProxy(IslandProxy):GetIsland():GetAblityAgency():IsUnlcokSecondProduct(var_29_4) then
			return
		end
	end

	local var_29_13 = var_29_1:GetExtraExtraProduct(var_29_8)

	setText(self.extraProductNum, ((var_29_13 > 0 or nil) and string.format("×(%s<color=#7df39f>+%d</color>)", var_29_5.second_product_display[1][2], var_29_13)) .. i18n("island_production_tip"))

	local var_29_15 = var_29_0:GetFromulaTatalCount(var_29_5.id)
	local var_29_16 = var_29_5.second_product[1]

	if (var_29_15 + var_29_3) % var_29_5.second_product[1] ~= self.extraProcess then
		self.extraProcess = (var_29_15 + var_29_3) % var_29_5.second_product[1]

		self.extraProductList:align(var_29_16)
	end

	setText(self.extraProductLastNum, "×" .. math.floor((var_29_9 + (var_29_15 + var_29_3) % var_29_5.second_product[1]) / var_29_16))

	local var_29_17 = math.floor((var_29_15 + var_29_3) / var_29_16) - math.floor(var_29_15 / var_29_16)

	setActive(self.canExtraRewardIcon, var_29_17 > 0)
	setActive(self.canExtraRewardNum, var_29_17 > 0)

	if var_29_17 > 0 then
		local var_29_18 = 0

		for iter_29_0 = 1, var_29_17 do
			var_29_18 = var_29_18 + var_29_1:GetExtraExtraProduct(math.floor((var_29_8 - (iter_29_0 - 1) * var_29_16 + var_29_15 % var_29_16) / var_29_16) * var_29_16 - var_29_15 % var_29_16)
		end

		local var_29_19 = "×" .. var_29_5.second_product_display[1][2] * var_29_17 + var_29_18

		if var_29_18 > 0 then
			setTextColor(self.canExtraRewardNum, Color.NewHex("#7df39f"))
		else
			setTextColor(self.canExtraRewardNum, Color.NewHex("#FFFFFF"))
		end

		setText(self.canExtraRewardNum, var_29_19)
	end

	return
end

function IslandDelegationSelectPanel:StartTimer()
	self.timer = Timer.New(function()
		self:UpdateTime()

		return
	end, 1, -1)

	self.timer:Start()
	self:UpdateTime()

	return
end

function IslandDelegationSelectPanel:StopTimer()
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandDelegationSelectPanel:Hide()
	self.super.Hide(self)
	self:OnHide()

	return
end

function IslandDelegationSelectPanel:OnHide()
	self:StopTimer()

	return
end

function IslandDelegationSelectPanel:OnDestroy()
	self:OnHide()

	return
end

return IslandDelegationSelectPanel
