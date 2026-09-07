local IslandPostPlaceCard = class("IslandPostPlaceCard")

function IslandPostPlaceCard:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.nameTF = self._tf:Find("name")
	self.lockTF = self._tf:Find("lock")
	self.itemUIList = UIItemList.New(self._tf:Find("items"), self._tf:Find("items/tpl"))

	self.itemUIList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			self:UpdateSlotItem(self.slotIds[arg_2_1 + 1], arg_2_2)
		end

		return
	end)

	self.shipUIList = UIItemList.New(self._tf:Find("ships"), self._tf:Find("ships/tpl"))

	self.shipUIList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			self:UpdateSlotShip(self.slotIds[arg_3_1 + 1], arg_3_2)
		end

		return
	end)

	self.timers = {}

	return
end

function IslandPostPlaceCard:Update(arg_4_1, arg_4_2)
	self:RemoveAllTimer()

	self.id = arg_4_1
	self.onClickCommission = arg_4_2

	setText(self.nameTF, pg.island_production_place[self.id].name)

	self.buildingData = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(self.id)

	setActive(self.lockTF, not self.buildingData)

	self.slotIds = {}
	self.slotId2CommissionId = {}

	for iter_4_0, iter_4_1 in ipairs(pg.island_production_place[self.id].commission_slot) do
		table.insert(self.slotIds, pg.island_production_commission[iter_4_1].slot)

		self.slotId2CommissionId[pg.island_production_commission[iter_4_1].slot] = iter_4_1
	end

	self.itemUIList:align(#self.slotIds)
	self.shipUIList:align(#self.slotIds)

	return
end

function IslandPostPlaceCard:UpdateSlot(arg_5_1)
	local var_5_0 = tostring(arg_5_1)

	self:UpdateSlotItem(arg_5_1, self.itemUIList.container:Find(var_5_0))
	self:UpdateSlotShip(arg_5_1, self.shipUIList.container:Find(var_5_0))

	return
end

function IslandPostPlaceCard:UpdateSlotItem(arg_6_1, arg_6_2)
	arg_6_2.name = arg_6_1

	local var_6_0 = self.buildingData and self.buildingData:GetDelegationSlotData(arg_6_1)

	setActive(arg_6_2:Find("lock"), not var_6_0)
	setActive(arg_6_2:Find("unlock"), var_6_0)
	self:RemoveTimer(arg_6_1)

	if var_6_0 then
		local var_6_1 = var_6_0:GetFormulaId()

		setActive(arg_6_2:Find("unlock/add"), not var_6_1)
		setActive(arg_6_2:Find("unlock/formula"), var_6_1)

		if var_6_1 then
			LoadImageSpriteAsync("island/" .. Drop.New({
				count = 0,
				type = DROP_TYPE_ISLAND_ITEM,
				id = pg.island_formula[var_6_1].commission_product[1][1]
			}):getConfigTable().icon, arg_6_2:Find("unlock/formula/icon"))
		end

		local var_6_2 = var_6_0:GetSlotRoleData()

		setActive(arg_6_2:Find("unlock/formula/get"), not var_6_2)

		if var_6_2 then
			self:AddTimer(arg_6_2, var_6_0)
		else
			arg_6_2:Find("unlock/formula/fill"):GetComponent(typeof(Image)).fillAmount = 1
		end

		onButton(self, arg_6_2, function()
			existCall(self.onClickCommission, self.slotId2CommissionId[arg_6_1])

			return
		end, SFX_PANEL)
	else
		removeAllOnButton(arg_6_2)
	end

	return
end

function IslandPostPlaceCard:UpdateSlotShip(arg_8_1, arg_8_2)
	arg_8_2.name = arg_8_1

	local var_8_0 = self.buildingData and self.buildingData:GetDelegationSlotData(arg_8_1)

	setActive(arg_8_2:Find("lock"), not var_8_0)
	setActive(arg_8_2:Find("unlock"), var_8_0)

	if var_8_0 then
		local var_8_1 = var_8_0:GetSlotRoleData()

		setActive(arg_8_2:Find("unlock/add"), not var_8_1)
		setActive(arg_8_2:Find("unlock/ship"), var_8_1)

		if var_8_1 then
			LoadImageSpriteAsync("squareicon/" .. IslandShip.StaticGetPrefab(var_8_1.ship_id), arg_8_2:Find("unlock/ship/mask/icon"))
		end

		onButton(self, arg_8_2, function()
			existCall(self.onClickCommission, self.slotId2CommissionId[arg_8_1])

			return
		end, SFX_PANEL)
	else
		removeAllOnButton(arg_8_2)
	end

	return
end

function IslandPostPlaceCard:AddTimer(arg_10_1, arg_10_2)
	self:RemoveTimer(arg_10_2.id)

	local var_10_0 = arg_10_1:Find("unlock/formula/fill")
	local var_10_1 = var_10_0:GetComponent(typeof(Image))

	local function var_10_2()
		self:RemoveTimer(arg_10_2.id)
		setActive(arg_10_1:Find("unlock/formula/get"), true)

		var_10_1.fillAmount = 1

		return
	end

	local var_10_3 = Timer.New(function()
		local var_12_0 = arg_10_2:GetSlotRoleData()

		if not var_12_0 then
			var_10_2()
		else
			local var_12_1 = var_12_0:InCurrentTime()

			var_10_1.fillAmount = (pg.TimeMgr.GetInstance():GetServerTime() - var_12_0:InCurrentTimeStart(var_12_1)) / var_12_0:CurrentTimeNeed(var_12_1)
		end

		return
	end, 1, -1)

	var_10_3.Start(var_10_0)
	var_10_3.func()

	self.timers[arg_10_2.id] = var_10_3

	return
end

function IslandPostPlaceCard:RemoveTimer(arg_13_1)
	if self.timers[arg_13_1] then
		self.timers[arg_13_1]:Stop()

		self.timers[arg_13_1] = nil
	end

	return
end

function IslandPostPlaceCard:RemoveAllTimer()
	for iter_14_0, iter_14_1 in pairs(self.timers) do
		iter_14_1:Stop()

		iter_14_1 = nil
	end

	self.timers = {}

	return
end

function IslandPostPlaceCard:Dispose()
	self:RemoveAllTimer()
	pg.DelegateInfo.Dispose(self)

	return
end

return IslandPostPlaceCard
