class = var_0_10000

local var_0_0 = "SpWeaponDesignMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_COMPOSITE = "SpWeaponDesignMediator:ON_COMPOSITE"
var_0_1.OPEN_EQUIPMENTDESIGN_INDEX = "SpWeaponDesignMediator:OPEN_EQUIPMENTDESIGN_INDEX"

function var_0_1.register(arg_1_0)
	arg_1_0:BindEvent()

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.setItems

	getProxy = var_1_10004
	BagProxy = var_1_10006

	local var_1_2 = var_1_10004(var_1_10006)

	var_1_1(var_1_0, var_4.getRawData(var_1_2))

	getProxy = var_1_1
	EquipmentProxy = var_1_0

	local var_1_3 = var_1_1(var_1_0)
	local var_1_4 = {}

	_ = var_1_0

	local var_1_5 = var_1_0.each

	SpWeapon = var_1_10005

	var_1_5(var_1_10005.bindConfigTable().all, function(arg_2_0)
		SpWeapon = var_2_10001

		local var_2_0 = var_2_10001.New({
			id = arg_2_0
		})

		if var_1.IsCraftable(var_2_0) then
			table = var_2

			var_2.insert(var_1_4, var_1)
		end

		return
	end)

	local var_1_6 = arg_1_0.viewComponent

	var_3.SetCraftList(var_1_6, var_1_4)

	getProxy = var_3
	PlayerProxy = var_1_6

	local var_1_7 = var_3(var_1_6)
	local var_1_8 = var_3.getRawData(var_1_7)
	local var_1_9 = arg_1_0.viewComponent

	var_4.setPlayer(var_1_9, var_1_8)

	local var_1_10 = arg_1_0:getFacade()
	local var_1_11 = var_4.retrieveMediator

	EquipmentMediator = var_7

	local var_1_12 = var_1_11(var_1_10, var_7.__cname)
	local var_1_13 = var_4.getViewComponent(var_1_12)
	local var_1_14 = arg_1_0.viewComponent

	var_6.SetParentTF(var_1_14, var_1_13._tf)

	local var_1_15 = arg_1_0.viewComponent

	var_6.SetTopContainer(var_1_15, var_1_13.topPanel)

	local var_1_16 = arg_1_0.viewComponent

	var_6.SetTopItems(var_1_16, var_1_13.topItems)
	arg_1_0:UpdateSpWeapons()

	return
end

function var_0_1.BindEvent(arg_3_0)
	arg_3_0:bind(var_0_1.ON_COMPOSITE, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0
		local var_4_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_4_2 = var_2_10005.New
		local var_4_3 = {}

		SpWeaponUpgradeMediator = var_2_10008
		var_4_3.mediator = var_2_10008
		SpWeaponUpgradeLayer = var_2_10008
		var_4_3.viewComponent = var_2_10008
		var_4_3.data = {
			spWeaponConfigId = arg_4_1
		}

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_3_0:bind(var_0_1.OPEN_EQUIPMENTDESIGN_INDEX, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_5_2 = var_2_10005.New
		local var_5_3 = {}

		CustomIndexLayer = var_2_10008
		var_5_3.viewComponent = var_2_10008
		CustomIndexMediator = var_2_10008
		var_5_3.mediator = var_2_10008
		var_5_3.data = arg_5_1

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	return
end

function var_0_1.UpdateSpWeapons(arg_6_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.GetSpWeaponsInShips(var_6_0)

	_ = var_1_10002

	local var_6_2 = var_1_10002.values

	getProxy = var_1_10004
	EquipmentProxy = var_1_10006

	local var_6_3 = var_1_10004(var_1_10006)
	local var_6_4 = var_6_2(var_4.GetSpWeapons(var_6_3))

	ipairs = var_6_0

	for iter_6_0, iter_6_1 in var_6_0(var_6_4) do
		table = var_1_10008

		var_1_10008.insert(var_6_1, iter_6_1)
	end

	local var_6_5 = arg_6_0.viewComponent

	var_3.SetSpWeapons(var_6_5, var_6_1)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	BagProxy = var_1_10002
	var_7_0[1] = var_1_10002.ITEM_UPDATED
	PlayerProxy = var_2
	var_7_0[2] = var_2.UPDATED
	GAME = var_2
	var_7_0[3] = var_2.COMPOSITE_SPWEAPON_DONE
	GAME = var_2
	var_7_0[4] = var_2.EQUIP_SPWEAPON_TO_SHIP_DONE
	EquipmentProxy = var_2
	var_7_0[5] = var_2.SPWEAPONS_UPDATED

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getName(var_8_0)
	local var_8_2 = arg_8_1:getBody()

	BagProxy = var_8_0

	local var_8_3

	if var_8_1 == var_8_0.ITEM_UPDATED then
		var_1_10006 = arg_8_0.viewComponent
		var_8_3 = var_8_3.setItems
		getProxy = var_1_10007
		BagProxy = var_1_10009
		var_1_10009 = var_1_10007(var_1_10009)

		var_8_3(var_1_10006, var_1_10007.getRawData(var_1_10009))

		goto label_8_0
	end

	PlayerProxy = var_8_3

	local var_8_4

	if var_8_1 == var_8_3.UPDATED then
		var_1_10006 = arg_8_0.viewComponent
		var_8_4 = var_8_4.setPlayer
		getProxy = var_1_10007
		PlayerProxy = var_1_10009
		var_1_10009 = var_1_10007(var_1_10009)

		var_8_4(var_1_10006, var_1_10007.getRawData(var_1_10009))

		goto label_8_0
	end

	GAME = var_8_4

	local var_8_6

	if var_8_1 == var_8_4.COMPOSITE_SPWEAPON_DONE then
		getProxy = var_8_6
		ContextProxy = var_1_10006

		local var_8_5 = var_8_6(var_1_10006)

		var_8_6 = var_8_6.getContextByMediator
		EquipmentMediator = var_1_10007

		local var_8_7 = var_8_6(var_8_5, var_1_10007)
		local var_8_8 = var_8_6.getContextByMediator

		SpWeaponUpgradeMediator = var_1_10008

		if var_8_8(var_8_7, var_1_10008) then
			local var_8_9 = arg_8_0
			local var_8_10 = arg_8_0.sendNotification

			GAME = var_1_10009

			var_8_10(var_8_9, var_1_10009.REMOVE_LAYERS, {
				context = var_5
			})
		end

		goto label_8_0
	end

	GAME = var_8_6

	if var_8_1 ~= var_8_6.EQUIP_SPWEAPON_TO_SHIP_DONE then
		EquipmentProxy = var_4

		if var_8_1 == var_4.SPWEAPONS_UPDATED then
			arg_8_0:UpdateSpWeapons()

			local var_8_11 = arg_8_0.viewComponent

			var_4.filter(var_8_11)
		end

		::label_8_0::

		return
	end
end

return var_0_1
