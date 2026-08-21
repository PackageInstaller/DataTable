local var_0_0 = class("IslandPostPlaceCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.nameTF = arg_1_0._tf:Find("name")
	arg_1_0.lockTF = arg_1_0._tf:Find("lock")
	arg_1_0.itemUIList = UIItemList.New(arg_1_0._tf:Find("items"), arg_1_0._tf:Find("items/tpl"))

	arg_1_0.itemUIList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			arg_1_0:UpdateSlotItem(arg_1_0.slotIds[arg_2_1 + 1], arg_2_2)
		end

		return
	end)

	arg_1_0.shipUIList = UIItemList.New(arg_1_0._tf:Find("ships"), arg_1_0._tf:Find("ships/tpl"))

	arg_1_0.shipUIList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			arg_1_0:UpdateSlotShip(arg_1_0.slotIds[arg_3_1 + 1], arg_3_2)
		end

		return
	end)

	arg_1_0.timers = {}

	return
end

function var_0_0.Update(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:RemoveAllTimer()

	arg_4_0.id = arg_4_1
	arg_4_0.onClickCommission = arg_4_2

	setText(arg_4_0.nameTF, pg.island_production_place[arg_4_0.id].name)

	arg_4_0.buildingData = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(arg_4_0.id)

	setActive(arg_4_0.lockTF, not arg_4_0.buildingData)

	arg_4_0.slotIds = {}
	arg_4_0.slotId2CommissionId = {}

	for iter_4_0, iter_4_1 in ipairs(pg.island_production_place[arg_4_0.id].commission_slot) do
		table.insert(arg_4_0.slotIds, pg.island_production_commission[iter_4_1].slot)

		arg_4_0.slotId2CommissionId[pg.island_production_commission[iter_4_1].slot] = iter_4_1
	end

	arg_4_0.itemUIList:align(#arg_4_0.slotIds)
	arg_4_0.shipUIList:align(#arg_4_0.slotIds)

	return
end

function var_0_0.UpdateSlot(arg_5_0, arg_5_1)
	local var_5_0 = tostring(arg_5_1)

	arg_5_0:UpdateSlotItem(arg_5_1, arg_5_0.itemUIList.container:Find(var_5_0))
	arg_5_0:UpdateSlotShip(arg_5_1, arg_5_0.shipUIList.container:Find(var_5_0))

	return
end

function var_0_0.UpdateSlotItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2.name = arg_6_1

	local var_6_0 = arg_6_0.buildingData and arg_6_0.buildingData:GetDelegationSlotData(arg_6_1)

	setActive(arg_6_2:Find("lock"), not var_6_0)
	setActive(arg_6_2:Find("unlock"), var_6_0)
	arg_6_0:RemoveTimer(arg_6_1)

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
			arg_6_0:AddTimer(arg_6_2, var_6_0)
		else
			local var_6_3 = arg_6_2:Find("unlock/formula/fill")

			var_6_3:GetComponent(typeof(Image)).fillAmount = 1
		end

		onButton(arg_6_0, arg_6_2, function()
			existCall(arg_6_0.onClickCommission, arg_6_0.slotId2CommissionId[arg_6_1])

			return
		end, SFX_PANEL)
	else
		removeAllOnButton(arg_6_2)
	end

	return
end

function var_0_0.UpdateSlotShip(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2.name = arg_8_1

	local var_8_0 = arg_8_0.buildingData and arg_8_0.buildingData:GetDelegationSlotData(arg_8_1)

	setActive(arg_8_2:Find("lock"), not var_8_0)
	setActive(arg_8_2:Find("unlock"), var_8_0)

	if var_8_0 then
		local var_8_1 = var_8_0:GetSlotRoleData()

		setActive(arg_8_2:Find("unlock/add"), not var_8_1)
		setActive(arg_8_2:Find("unlock/ship"), var_8_1)

		if var_8_1 then
			LoadImageSpriteAsync("squareicon/" .. IslandShip.StaticGetPrefab(var_8_1.ship_id), arg_8_2:Find("unlock/ship/mask/icon"))
		end

		onButton(arg_8_0, arg_8_2, function()
			existCall(arg_8_0.onClickCommission, arg_8_0.slotId2CommissionId[arg_8_1])

			return
		end, SFX_PANEL)
	else
		removeAllOnButton(arg_8_2)
	end

	return
end

function var_0_0.AddTimer(arg_10_0, arg_10_1, arg_10_2)
	local var_10_9000

	arg_10_0:RemoveTimer(arg_10_2.id)

	local var_10_0 = arg_10_1:Find("unlock/formula/fill")
	local var_10_1 = var_10_0.GetComponent(var_10_9000, typeof(Image))

	local function var_10_2()
		arg_10_0:RemoveTimer(arg_10_2.id)
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

	arg_10_0.timers[arg_10_2.id] = var_10_3

	return
end

function var_0_0.RemoveTimer(arg_13_0, arg_13_1)
	if arg_13_0.timers[arg_13_1] then
		arg_13_0.timers[arg_13_1]:Stop()

		arg_13_0.timers[arg_13_1] = nil
	end

	return
end

function var_0_0.RemoveAllTimer(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.timers) do
		iter_14_1:Stop()

		iter_14_1 = nil
	end

	arg_14_0.timers = {}

	return
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllTimer()
	pg.DelegateInfo.Dispose(arg_15_0)

	return
end

return var_0_0
