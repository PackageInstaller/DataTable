local IslandTechDetailPanel = class("IslandTechDetailPanel", import("view.base.BaseSubView"))

function IslandTechDetailPanel:getUIName()
	return "IslandTechDetailPanel"
end

function IslandTechDetailPanel:OnLoaded()
	self.selectedTF = self._tf:Find("selected")
	self.panel = self._tf:Find("panel")
	self.iconTF = self.panel:Find("icon_bg/icon")
	self.nameTF = self.panel:Find("title/Text")
	self.descPanel = self.panel:Find("desc")
	self.descTF = self.descPanel:Find("Text")
	self.unlockTF = self.panel:Find("unlock")

	setText(self.unlockTF:Find("title"), i18n("island_tech_unlock_need"))

	self.unlockUIList = UIItemList.New(self.unlockTF:Find("list"), self.unlockTF:Find("list/tpl"))
	self.normalTimeTextTF = self.panel:Find("status/normal/content/time/Text")
	self.timeTextTF = self.panel:Find("status/studying/time/Text")

	local var_2_0 = self.panel:Find("status")

	setText(var_2_0:Find("lock/content/Text"), i18n("island_tech_unlock_dev"))
	setText(var_2_0:Find("unlock/Text"), i18n("island_tech_unlock_dev"))
	setText(var_2_0:Find("normal/content/Text"), i18n("island_tech_dev_start"))
	setText(var_2_0:Find("normal/cost/title"), i18n("island_tech_dev_cost"))
	setText(var_2_0:Find("studying/Text"), i18n("island_tech_dev_starting"))
	setText(var_2_0:Find("receive/Text"), i18n("island_tech_dev_success"))
	setText(var_2_0:Find("finished/normal/Text"), i18n("island_tech_dev_finish"))

	self.noramlFinsh = var_2_0:Find("finished/normal")
	self.mapFinsh = var_2_0:Find("finished/map")
	self.mapFinshIcon = self.mapFinsh:Find("mapicon")
	self.mapFinshName = self.mapFinsh:Find("maptitle/name")
	self.npcTF = self.mapFinsh:Find("npc")
	self.npcIcon = self.npcTF:Find("npcicon")
	self.npcName = self.npcTF:Find("npcName")
	self.statusTFs = {
		[IslandTechnology.STATUS.LOCK] = var_2_0:Find("lock"),
		[IslandTechnology.STATUS.UNLOCK] = var_2_0:Find("unlock"),
		[IslandTechnology.STATUS.NORMAL] = var_2_0:Find("normal"),
		[IslandTechnology.STATUS.STUDYING] = var_2_0:Find("studying"),
		[IslandTechnology.STATUS.RECEIVE] = var_2_0:Find("receive"),
		[IslandTechnology.STATUS.FINISHED] = var_2_0:Find("finished")
	}
	self.costTF = self.panel:Find("status/normal/cost")
	self.costUIList = UIItemList.New(self.costTF:Find("list"), self.costTF:Find("list/tpl"))

	setText(self._tf:Find("panel/unlock/title"), i18n("island_tech_detail_unlocktitle"))

	return
end

function IslandTechDetailPanel:OnInit()
	onButton(self, self._tf:Find("close"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	self.unlockUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			setText(arg_5_2:Find("Text"), IslandTechnology.GetUnlockText(self.unlockCondList[arg_5_1 + 1]))

			local var_5_0 = self.showTechVO:MatchCondition(self.unlockCondList[arg_5_1 + 1]) and "1E90FF" or "F5F5F5"

			setTextColor(arg_5_2:Find("Text"), Color.NewHex(var_5_0))
			setImageColor(arg_5_2:Find("dot"), Color.NewHex(var_5_0))
		end

		return
	end)
	self.costUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = self.costList[arg_6_1 + 1]
			local var_6_1 = self.inventoryAgency:GetOwnCount(self.costList[arg_6_1 + 1].id)

			updateCustomDrop(arg_6_2, self.costList[arg_6_1 + 1])

			local var_6_2 = arg_6_2:Find("icon_bg/count_bg/count")

			if var_6_0.id == IslandItem.GOLD_ID then
				setText(var_6_2, var_6_1 < var_6_0.count and setColorStr(var_6_0.count, "#FF6767"))
			else
				setText(var_6_2, (var_6_1 < var_6_0.count and setColorStr(var_6_1, "#FF6767") or var_6_1) .. "/" .. var_6_0.count)
			end

			onButton(self, arg_6_2, function()
				self.contextData:ShowMsgBox({
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_6_0
				})

				return
			end)
		end

		return
	end)

	self.placeId = IslandTechnologyAgency.PLACE_ID
	self.baseEffectSpeed = pg.island_set.base_efficiency.key_value_int

	return
end

function IslandTechDetailPanel:Flush()
	self:StopTimer()

	local var_8_0 = getProxy(IslandProxy):GetIsland()

	self.buildingAgency = var_8_0:GetBuildingAgency()
	self.techAgency = var_8_0:GetTechnologyAgency()
	self.inventoryAgency = var_8_0:GetInventoryAgency()
	self.showTechVO = self.techAgency:GetTechnology(self.configId)

	LoadImageSpriteAsync("island/IslandTechnology/" .. self.showTechVO:getConfig("tech_icon"), self.iconTF, true)
	setText(self.nameTF, self.showTechVO:getConfig("tech_name"))
	setText(self.descTF, self.showTechVO:getConfig("tech_desc"))
	setText(self.normalTimeTextTF, self.timeMgr:DescCDTime((math.floor(pg.island_formula[self.showTechVO:GetFormulaId()].workload / self.baseEffectSpeed))))

	self.unlockCondList = Clone(self.showTechVO:getConfig("sys_unlock"))

	local var_8_1 = self.showTechVO:getConfig("island_level")

	if var_8_1 ~= 0 then
		table.insert(self.unlockCondList, 1, {
			0,
			var_8_1
		})
	end

	self.unlockUIList:align(#self.unlockCondList)

	local var_8_2 = self.showTechVO:GetStatus()

	for iter_8_0, iter_8_1 in pairs(self.statusTFs) do
		setActive(iter_8_1, iter_8_0 == var_8_2)
	end

	local var_8_3 = var_8_2 == IslandTechnology.STATUS.LOCK or var_8_2 == IslandTechnology.STATUS.UNLOCK

	setActive(self.unlockTF, var_8_2 == IslandTechnology.STATUS.LOCK or var_8_2 == IslandTechnology.STATUS.UNLOCK)
	setActive(self.descPanel, not var_8_3)

	self.costList = self.showTechVO:GetCostItems()

	self.costUIList:align(#self.costList)
	setText(self._tf:Find("panel/desc/name"), self.showTechVO:getConfig("complete_title"))
	switch(var_8_2, {
		[IslandTechnology.STATUS.LOCK] = function()
			onButton(self, self.statusTFs[var_8_2], function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_tech_unlock_tip"))

				return
			end, SFX_PANEL)

			return
		end,
		[IslandTechnology.STATUS.UNLOCK] = function()
			onButton(self, self.statusTFs[var_8_2], function()
				self:emit(IslandMediator.ON_UNLOCK_TECH, self.showTechVO.id)

				return
			end, SFX_PANEL)

			return
		end,
		[IslandTechnology.STATUS.NORMAL] = function()
			setGray(self.statusTFs[var_8_2], not self:CheckCost(), false)
			onButton(self, self.statusTFs[var_8_2], function()
				if not self:CheckCost() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("island_production_cost_notenough"))

					return
				end

				if not self.techAgency:GetEmptySlotId() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("island_tech_no_slot"))

					return
				end

				if self.showTechVO:IsAutoType() then
					existCall(self.contextData.onFinishImmd, self.showTechVO.id)
				else
					existCall(self.contextData.onSelecteShip, self.showTechVO:GetFormulaId())
				end

				return
			end, SFX_PANEL)

			return
		end,
		[IslandTechnology.STATUS.STUDYING] = function()
			onButton(self, self.statusTFs[var_8_2]:Find("ticket"), function()
				existCall(self.contextData.openTicketPage, self.showTechVO:GetSlotId())

				return
			end, SFX_PANEL)

			return
		end,
		[IslandTechnology.STATUS.RECEIVE] = function()
			onButton(self, self.statusTFs[var_8_2], function()
				self:emit(IslandMediator.GET_DELEGATION_AWARD, self.placeId, self.showTechVO:GetSlotId(), 2, function()
					existCall(self.contextData.onGetAwardDone, self.showTechVO.id)

					return
				end)

				return
			end, SFX_PANEL)

			return
		end,
		[IslandTechnology.STATUS.FINISHED] = function()
			local var_20_0 = self.showTechVO:getConfig("complete_map_id")

			if var_20_0 == 0 then
				setActive(self.noramlFinsh, true)
				setActive(self.mapFinsh, false)

				return
			end

			setActive(self.noramlFinsh, false)
			setActive(self.mapFinsh, true)
			LoadImageSpriteAtlasAsync("island/IslandMapIcon/" .. var_20_0, "", self.mapFinshIcon)
			setText(self.mapFinshName, pg.island_map[var_20_0].name)

			local var_20_1 = self.showTechVO:getConfig("complete_character_id")

			if var_20_1 == "" or #var_20_1 == 0 then
				setActive(self.npcTF, false)

				return
			end

			setActive(self.npcTF, true)
			GetImageSpriteFromAtlasAsync("island/IslandShipIcon/" .. pg.island_unit_character[var_20_1[1]].IslandShipIcon, "", self.npcIcon)
			setText(self.npcName, pg.island_unit_character[var_20_1[1]].name)

			return
		end
	}, function()
		return
	end)
	self:StartTimer()
	self:UpdateTime()
	setActive(self.selectedTF, self.selectedItemPos)

	if self.selectedItemPos then
		self:FlushSelectedItem()
	end

	return
end

function IslandTechDetailPanel:CheckCost()
	return underscore.all(self.costList or {}, function(arg_23_0)
		return self.inventoryAgency:GetOwnCount(arg_23_0.id) >= arg_23_0.count
	end)
end

function IslandTechDetailPanel:FlushSelectedItem()
	setAnchoredPosition(self.selectedTF, self.selectedItemPos)
	setActive(self.selectedTF:Find("selected"), true)

	self.selectedTF.name = self.configId

	local var_24_0 = self.techAgency:GetTechnology(self.configId)

	IslandTechTreePanel.SetTechName(self.selectedTF:Find("name"), var_24_0:getConfig("tech_name"))

	local var_24_1 = var_24_0:GetStatus()
	local var_24_2 = var_24_1 == IslandTechnology.STATUS.FINISHED

	setTextColor(self.selectedTF:Find("name/Text"), Color.NewHex(var_24_1 == IslandTechnology.STATUS.FINISHED and "1b3650" or "ffffff"))
	setTextColor(self.selectedTF:Find("name/ScrollText"), Color.NewHex(var_24_2 and "1b3650" or "ffffff"))
	LoadImageSpriteAsync("island/IslandTechnology/" .. var_24_0:getConfig("tech_icon"), self.selectedTF:Find("icon"), true)
	setActive(self.selectedTF:Find("icon"), var_24_1 ~= IslandTechnology.STATUS.STUDYING and var_24_1 ~= IslandTechnology.STATUS.RECEIVE)
	setImageColor(self.selectedTF:Find("icon"), Color.NewHex(var_24_2 and "455a81" or "ffffff"))
	eachChild(self.selectedTF:Find("back"), function(arg_25_0)
		setActive(arg_25_0, arg_25_0.name == var_24_1)

		return
	end)
	setActive(self.selectedTF:Find("back/normal"), not var_24_2 and var_24_1 ~= IslandTechnology.STATUS.STUDYING)
	eachChild(self.selectedTF:Find("front"), function(arg_26_0)
		setActive(arg_26_0, arg_26_0.name == var_24_1)

		return
	end)

	return
end

function IslandTechDetailPanel:Show(arg_27_1, arg_27_2)
	IslandTechDetailPanel.super.Show(self)

	self.configId = arg_27_1
	self.timeMgr = pg.TimeMgr.GetInstance()
	self.selectedItemPos = arg_27_2

	self:Flush()
	self:OverlayPanel(self._tf)

	return
end

function IslandTechDetailPanel:OnShipSelected(arg_28_1)
	local var_28_0 = getProxy(IslandProxy)

	if math.max(math.floor(pg.island_formula[self.showTechVO:GetFormulaId()].stamina_cost * (1 - IslandProductCostHelper.GetReducePercentInPlace(arg_28_1, self.placeId))), 1) > var_28_0:GetIsland():GetCharacterAgency():GetShipById(arg_28_1).GetCurrentEnergy(var_28_0) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_production_cost_notenough"))

		return
	end

	self:emit(IslandMediator.START_DELEGATION, self.placeId, self.techAgency:GetEmptySlotId(), arg_28_1, self.showTechVO:GetFormulaId(), 1)

	return
end

function IslandTechDetailPanel:UpdateTime()
	local var_29_0 = self.showTechVO:GetStatus()
	local var_29_1 = self.buildingAgency:GetDelegationSlotDataByTechId(self.showTechVO.id)

	if var_29_1 then
		if var_29_1:GetSlotRewardData() then
			setText(self.timeTextTF, "00:00:00")
		else
			local var_29_2 = var_29_1:GetSlotRoleData():GetFinishTime() - self.timeMgr:GetServerTime()

			setText(self.timeTextTF, var_29_2 > 0 and self.timeMgr:DescCDTime(var_29_2) or "00:00:00")
		end
	else
		setText(self.timeTextTF, "??:??:??")
	end

	return
end

function IslandTechDetailPanel:StartTimer()
	self.timer = Timer.New(function()
		self:UpdateTime()

		return
	end, 1, -1)

	self.timer:Start()

	return
end

function IslandTechDetailPanel:StopTimer()
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandTechDetailPanel:OnHide()
	self:StopTimer()
	self:UnOverlayPanel(self._tf, self._parentTf)

	return
end

function IslandTechDetailPanel:OnDestroy()
	self:StopTimer()
	self:UnOverlayPanel(self._tf, self._parentTf)

	return
end

return IslandTechDetailPanel
