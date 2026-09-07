local IslandTechQuickPanel = class("IslandTechQuickPanel", import("view.base.BaseSubView"))

IslandTechQuickPanel.TOGGLE_STATUS = {
	NORMAL = "normal",
	FINISHED = "finished",
	STUDYING = "studying"
}

function IslandTechQuickPanel:getUIName()
	return "IslandTechQuickPanel"
end

function IslandTechQuickPanel:OnLoaded()
	self.toggle = self._tf:Find("adapt/toggle")
	self.panel = self._tf:Find("adapt/panel")

	local var_2_0 = self.panel:Find("content")
	local var_2_1 = var_2_0:Find("tpl")

	setText(var_2_1:Find("lock/content/tip/Text"), i18n("island_tech_lock"))
	setText(var_2_1:Find("empty/content/Text"), i18n("island_tech_empty"))

	self.uiList = UIItemList.New(var_2_0, var_2_1)

	setText(var_2_0:Find("tpl/content/get/Image/Text"), i18n("island_tech_can_get"))
	setText(self.toggle:Find("normal/Text"), i18n("island_tech_nodev"))
	setText(self.toggle:Find("studying/Text"), i18n("island_tech_dev_starting"))
	setText(self.toggle:Find("finished/Text"), i18n("island_tech_dev_finish_1"))

	return
end

function IslandTechQuickPanel:OnInit()
	self.slotIds = IslandTechnologyAgency.GetSlotIds()

	self.uiList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_4_1, arg_4_2)
		end

		return
	end)

	self.timeMgr = pg.TimeMgr.GetInstance()

	onButton(self, self._tf:Find("off"), function()
		triggerToggle(self.toggle, false)

		return
	end, SFX_PANEL)
	onToggle(self, self.toggle, function(arg_6_0)
		if arg_6_0 then
			self:OverlayPanel(self._tf, {
				pbList = {
					self.panel
				}
			})
		else
			self:UnOverlayPanel(self._tf, self._parentTf)
		end

		return
	end, SFX_PANEL)

	return
end

function IslandTechQuickPanel:UpdateItem(arg_7_1, arg_7_2)
	local var_7_0 = self.buildingData:GetDelegationSlotData(self.slotIds[arg_7_1 + 1])
	local var_7_1 = var_7_0 and var_7_0:GetFormulaId()

	setActive(arg_7_2:Find("lock"), not var_7_0)
	setActive(arg_7_2:Find("empty"), var_7_0 and not var_7_1)
	setActive(arg_7_2:Find("content"), var_7_1)

	if var_7_1 then
		local var_7_2 = arg_7_2:Find("content")

		setText(var_7_2:Find("title"), self.technologyAgency:GetTechnologyByFormulaId(var_7_1):getConfig("tech_name"))

		local var_7_3 = var_7_0:GetSlotRoleData()

		setActive(var_7_2:Find("icon_bg"), var_7_3)

		if var_7_3 then
			GetImageSpriteFromAtlasAsync("squareicon/" .. IslandShip.StaticGetPrefab(var_7_3.ship_id), "", var_7_2:Find("icon_bg/mask/icon"))

			local var_7_4 = var_7_3:GetFinishTime() - self.timeMgr:GetServerTime()

			setSlider(var_7_2:Find("silder"), 0, 1, 1 - var_7_4 / var_7_3:GetAllTime())
			setText(var_7_2:Find("silder/Text"), self.timeMgr:DescCDTime(var_7_4))
		end

		local var_7_5 = var_7_0:GetSlotRewardData()

		setActive(var_7_2:Find("get"), var_7_5)
		setActive(var_7_2:Find("silder"), not var_7_5)
	end

	return
end

function IslandTechQuickPanel:Flush()
	self:StopTimer()

	local var_8_0 = getProxy(IslandProxy):GetIsland()

	self.technologyAgency = var_8_0:GetTechnologyAgency()
	self.buildingData = var_8_0:GetBuildingAgency():GetBuilding(IslandTechnologyAgency.PLACE_ID)

	self.uiList:align(#self.slotIds)
	self:StartTimer()
	self:UpdateTime()

	return
end

function IslandTechQuickPanel:GetToggleStatus()
	if underscore.any(self.slotIds, function(arg_10_0)
		local var_10_0 = self.buildingData:GetDelegationSlotData(arg_10_0)

		return var_10_0 and var_10_0:GetSlotRewardData()
	end) then
		return IslandTechQuickPanel.TOGGLE_STATUS.FINISHED
	end

	if underscore.any(self.slotIds, function(arg_11_0)
		local var_11_0 = self.buildingData:GetDelegationSlotData(arg_11_0)

		return var_11_0 and var_11_0:GetSlotRoleData()
	end) then
		return IslandTechQuickPanel.TOGGLE_STATUS.STUDYING
	end

	return IslandTechQuickPanel.TOGGLE_STATUS.NORMAL
end

function IslandTechQuickPanel:UpdateToggleStatus()
	eachChild(self.toggle, function(arg_13_0)
		setActive(arg_13_0, arg_13_0.name == self.status)

		return
	end)

	return
end

function IslandTechQuickPanel:QuickGetAward()
	local var_14_0 = underscore.detect(self.slotIds, function(arg_15_0)
		local var_15_0 = self.buildingData:GetDelegationSlotData(arg_15_0)

		return var_15_0 and var_15_0:GetSlotRewardData()
	end)
	local var_14_1 = self.technologyAgency:GetTechnologyByFormulaId(self.buildingData:GetDelegationSlotData(var_14_0):GetSlotRewardData().formula_id).id

	self:emit(IslandMediator.GET_DELEGATION_AWARD, IslandTechnologyAgency.PLACE_ID, var_14_0, 2, function()
		existCall(self.contextData.onGetAwardDone, var_14_1)

		return
	end)

	return
end

function IslandTechQuickPanel:UpdateTime()
	self.status = self:GetToggleStatus()

	self.uiList:eachActive(function(arg_18_0, arg_18_1)
		local var_18_0 = self.buildingData:GetDelegationSlotData(self.slotIds[arg_18_0 + 1])

		if var_18_0 and var_18_0:GetFormulaId() then
			local var_18_1 = arg_18_1:Find("content")
			local var_18_2 = var_18_0:GetSlotRoleData()

			setActive(var_18_1:Find("icon_bg"), var_18_2)

			if var_18_2 then
				local var_18_3 = var_18_2:GetFinishTime() - self.timeMgr:GetServerTime()

				setSlider(var_18_1:Find("silder"), 0, 1, 1 - var_18_3 / var_18_2:GetAllTime())
				setText(var_18_1:Find("silder/Text"), var_18_3 > 0 and self.timeMgr:DescCDTime(var_18_3) or "00:00:00")
			end

			local var_18_4 = var_18_0:GetSlotRewardData()

			setActive(var_18_1:Find("get"), var_18_4)
			setActive(var_18_1:Find("silder"), not var_18_4)
			onButton(self, arg_18_1, function()
				if not var_18_4 then
					return
				end

				self:QuickGetAward()

				return
			end, SFX_PANEL)
		else
			removeOnButton(arg_18_1)
		end

		return
	end)
	self:UpdateToggleStatus()

	return
end

function IslandTechQuickPanel:StartTimer()
	self.timer = Timer.New(function()
		self:UpdateTime()

		return
	end, 1, -1)

	self.timer:Start()

	return
end

function IslandTechQuickPanel:StopTimer()
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandTechQuickPanel:OffToggle()
	triggerToggle(self.toggle, false)

	return
end

function IslandTechQuickPanel:Hide()
	self:OffToggle()
	IslandTechQuickPanel.super.Hide(self)

	return
end

function IslandTechQuickPanel:OnDestroy()
	self:StopTimer()
	self:UnOverlayPanel(self._tf, self._parentTf)

	return
end

return IslandTechQuickPanel
