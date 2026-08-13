class = var_0_10000

local var_0_0 = var_0_10000("IslandPostPlaceCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.nameTF = var_2.Find(var_1_0, "name")

	local var_1_1 = arg_1_0._tf

	arg_1_0.lockTF = var_2.Find(var_1_1, "lock")
	UIItemList = var_2

	local var_1_2 = var_2.New
	local var_1_3 = arg_1_0._tf
	local var_1_4 = var_3.Find(var_1_3, "items")
	local var_1_5 = arg_1_0._tf

	arg_1_0.itemUIList = var_1_2(var_1_4, var_4.Find(var_1_5, "items/tpl"))

	local var_1_6 = arg_1_0.itemUIList

	var_2.make(var_1_6, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_1_0

			var_3.UpdateSlotItem(var_2_0, arg_1_0.slotIds[arg_2_1 + 1], arg_2_2)
		end

		return
	end)

	UIItemList = var_2

	local var_1_7 = var_2.New
	local var_1_8 = arg_1_0._tf
	local var_1_9 = var_3.Find(var_1_8, "ships")
	local var_1_10 = arg_1_0._tf

	arg_1_0.shipUIList = var_1_7(var_1_9, var_4.Find(var_1_10, "ships/tpl"))

	local var_1_11 = arg_1_0.shipUIList

	var_2.make(var_1_11, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_1_0

			var_3.UpdateSlotShip(var_3_0, arg_1_0.slotIds[arg_3_1 + 1], arg_3_2)
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
	pg = var_3

	local var_4_0 = var_3.island_production_place[arg_4_0.id]

	setText = var_4

	var_4(arg_4_0.nameTF, var_4_0.name)

	getProxy = var_4
	IslandProxy = var_5

	local var_4_1 = var_4(var_5)
	local var_4_2 = var_4.GetIsland(var_4_1)
	local var_4_3 = var_4.GetBuildingAgency(var_4_2)

	arg_4_0.buildingData = var_4.GetBuilding(var_4_3, arg_4_0.id)
	setActive = var_4

	var_4(arg_4_0.lockTF, not arg_4_0.buildingData)

	local var_4_4 = var_4_0.commission_slot

	arg_4_0.slotIds = {}
	arg_4_0.slotId2CommissionId = {}
	ipairs = var_5

	for iter_4_0, iter_4_1 in var_5(var_4_4) do
		pg = var_1_10010
		var_1_10010 = var_1_10010.island_production_commission[iter_4_1].slot
		table = var_1_10011
		var_1_10011 = var_1_10011.insert

		local var_4_5 = arg_4_0.slotIds

		pg = var_1_10013

		var_1_10011(var_4_5, var_1_10013.island_production_commission[iter_4_1].slot)

		var_1_10011 = arg_4_0.slotId2CommissionId
		var_1_10011[var_1_10010] = iter_4_1
	end

	local var_4_6 = arg_4_0.itemUIList

	var_5.align(var_4_6, #arg_4_0.slotIds)

	local var_4_7 = arg_4_0.shipUIList

	var_5.align(var_4_7, #arg_4_0.slotIds)

	return
end

function var_0_0.UpdateSlot(arg_5_0, arg_5_1)
	tostring = var_1_10002

	local var_5_0 = var_1_10002(arg_5_1)
	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.UpdateSlotItem
	local var_5_3 = arg_5_1
	local var_5_4 = arg_5_0.itemUIList.container

	var_5_2(var_5_1, var_5_3, var_6.Find(var_5_4, var_5_0))

	local var_5_5 = arg_5_0
	local var_5_6 = arg_5_0.UpdateSlotShip
	local var_5_7 = arg_5_1
	local var_5_8 = arg_5_0.shipUIList.container

	var_5_6(var_5_5, var_5_7, var_6.Find(var_5_8, var_5_0))

	return
end

function var_0_0.UpdateSlotItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2.name = arg_6_1

	local var_6_0

	if arg_6_0.buildingData then
		var_1_10004 = arg_6_0.buildingData
		var_6_0 = var_3.GetDelegationSlotData(var_1_10004, arg_6_1)
	end

	setActive = var_1_10004

	var_1_10004(arg_6_2:Find("lock"), not var_6_0)

	setActive = var_1_10004

	var_1_10004(arg_6_2:Find("unlock"), var_6_0)
	arg_6_0:RemoveTimer(arg_6_1)

	local var_6_2

	if var_6_0 then
		local var_6_1 = var_6_0

		var_6_2 = var_6_0.GetFormulaId(var_6_1)
		setActive = var_6_1

		var_6_1(arg_6_2:Find("unlock/add"), not var_6_2)

		setActive = var_6_1

		var_6_1(arg_6_2:Find("unlock/formula"), var_6_2)

		if var_6_2 then
			pg = var_6_1

			local var_6_3 = var_6_1.island_formula[var_6_2].commission_product[1][1]

			Drop = var_6

			local var_6_4 = var_6.New
			local var_6_5 = {
				count = 0
			}

			DROP_TYPE_ISLAND_ITEM = var_8
			var_6_5.type = var_8
			var_6_5.id = var_6_3

			local var_6_6 = var_6_4(var_6_5)
			local var_6_7 = var_6.getConfigTable(var_6_6).icon

			LoadImageSpriteAsync = var_6_6

			local var_6_8 = "island/" .. var_6_7

			var_1_10010 = arg_6_2

			var_6_6(var_6_8, arg_6_2.Find(var_1_10010, "unlock/formula/icon"))
		end

		local var_6_9 = var_6_0
		local var_6_10 = var_6_0.GetSlotRoleData(var_6_9)

		setActive = var_6_9

		var_6_9(arg_6_2:Find("unlock/formula/get"), not var_6_10)

		if var_6_10 then
			arg_6_0:AddTimer(arg_6_2, var_6_0)
		else
			local var_6_11 = arg_6_2:Find("unlock/formula/fill")

			var_6_9 = var_6_9.GetComponent
			typeof = var_8
			Image = var_9
			var_6_9 = var_6_9(var_6_11, var_8(var_9))
			var_6_9.fillAmount = 1
		end

		onButton = var_6_9

		local var_6_12 = arg_6_0
		local var_6_13 = arg_6_2

		local function var_6_14()
			existCall = var_2_10000

			var_2_10000(arg_6_0.onClickCommission, arg_6_0.slotId2CommissionId[arg_6_1])

			return
		end

		SFX_PANEL = var_1_10010

		var_6_9(var_6_12, var_6_13, var_6_14, var_1_10010)
	else
		removeAllOnButton = var_6_2

		var_6_2(arg_6_2)
	end

	return
end

function var_0_0.UpdateSlotShip(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2.name = arg_8_1

	local var_8_0

	if arg_8_0.buildingData then
		var_1_10004 = arg_8_0.buildingData
		var_8_0 = var_3.GetDelegationSlotData(var_1_10004, arg_8_1)
	end

	setActive = var_1_10004

	var_1_10004(arg_8_2:Find("lock"), not var_8_0)

	setActive = var_1_10004

	var_1_10004(arg_8_2:Find("unlock"), var_8_0)

	if var_8_0 then
		local var_8_1 = var_8_0

		var_1_10004 = var_8_0.GetSlotRoleData(var_8_1)
		setActive = var_8_1

		var_8_1(arg_8_2:Find("unlock/add"), not var_1_10004)

		setActive = var_8_1

		var_8_1(arg_8_2:Find("unlock/ship"), var_1_10004)

		if var_1_10004 then
			IslandShip = var_8_1
			var_8_1 = var_8_1.StaticGetPrefab(var_1_10004.ship_id)
			LoadImageSpriteAsync = var_6

			local var_8_2 = "squareicon/" .. var_8_1

			var_1_10009 = arg_8_2

			var_6(var_8_2, arg_8_2.Find(var_1_10009, "unlock/ship/mask/icon"))
		end

		onButton = var_8_1

		local var_8_3 = arg_8_0
		local var_8_4 = arg_8_2

		local function var_8_5()
			existCall = var_2_10000

			var_2_10000(arg_8_0.onClickCommission, arg_8_0.slotId2CommissionId[arg_8_1])

			return
		end

		SFX_PANEL = var_1_10009

		var_8_1(var_8_3, var_8_4, var_8_5, var_1_10009)
	else
		removeAllOnButton = var_1_10004

		var_1_10004(arg_8_2)
	end

	return
end

function var_0_0.AddTimer(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:RemoveTimer(arg_10_2.id)

	local var_10_0 = arg_10_1:Find("unlock/formula/fill")
	local var_10_1 = var_3.GetComponent

	typeof = var_5
	Image = var_1_10006

	local var_10_2 = var_10_1(var_10_0, var_5(var_1_10006))

	local function var_10_3()
		local var_11_0 = arg_10_0

		var_0.RemoveTimer(var_11_0, arg_10_2.id)

		setActive = var_0

		local var_11_1 = arg_10_1

		var_0(var_1.Find(var_11_1, "unlock/formula/get"), true)

		var_10_2.fillAmount = 1

		return
	end

	Timer = var_5

	local var_10_4 = var_5.New(function()
		local var_12_0 = arg_10_2

		if not var_0.GetSlotRoleData(var_12_0) then
			var_10_3()
		else
			local var_12_1 = var_0
			local var_12_2 = var_0.InCurrentTime(var_12_1)

			pg = var_12_1

			local var_12_3 = var_12_1.TimeMgr.GetInstance()
			local var_12_4 = var_2.GetServerTime(var_12_3) - var_0:InCurrentTimeStart(var_12_2)

			var_10_2.fillAmount = var_12_4 / var_0:CurrentTimeNeed(var_12_2)
		end

		return
	end, 1, -1)

	var_5.Start(var_10_4)
	var_5.func()

	arg_10_0.timers[arg_10_2.id] = var_5

	return
end

function var_0_0.RemoveTimer(arg_13_0, arg_13_1)
	if arg_13_0.timers[arg_13_1] then
		local var_13_0 = arg_13_0.timers[arg_13_1]

		var_2.Stop(var_13_0)

		arg_13_0.timers[arg_13_1] = nil
	end

	return
end

function var_0_0.RemoveAllTimer(arg_14_0)
	pairs = var_1_10001

	for iter_14_0, iter_14_1 in var_1_10001(arg_14_0.timers) do
		iter_14_1:Stop()

		iter_14_1 = nil
	end

	arg_14_0.timers = {}

	return
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllTimer()

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_15_0)

	return
end

return var_0_0
