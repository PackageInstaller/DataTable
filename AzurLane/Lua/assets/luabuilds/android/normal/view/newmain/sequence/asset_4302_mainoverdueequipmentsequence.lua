class = var_0_10000

local var_0_0 = "MainOverDueEquipmentSequence"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainSublayerSequence"))

function var_0_1.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	EquipmentProxy = var_1_10003

	local var_1_0 = var_1_10002(var_1_10003)

	if #var_2.getTimeLimitShipList(var_1_0) > 0 then
		local var_1_1 = arg_1_0
		local var_1_2 = arg_1_0.ShowMsgBox
		local var_1_3 = {
			item2Row = true,
			itemList = var_2
		}

		i18n = var_1_10006
		var_1_3.content = var_1_10006("time_limit_equip_destroy_on_ship")
		var_1_3.onYes = arg_1_1
		var_1_3.onNo = arg_1_1

		var_1_2(var_1_1, var_1_3)
	else
		arg_1_1()
	end

	return
end

function var_0_1.ShowMsgBox(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.MsgboxMgr.GetInstance()
	local var_2_1 = var_2.ShowMsgBox
	local var_2_2 = {
		hideNo = true
	}

	MSGBOX_TYPE_ITEM_BOX = var_1_10005
	var_2_2.type = var_1_10005
	var_2_2.items = arg_2_1.itemList
	var_2_2.content = arg_2_1.content
	var_2_2.item2Row = arg_2_1.item2Row

	function var_2_2.itemFunc(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.ShowItemBox(var_3_0, arg_3_0, function()
			local var_4_0 = arg_2_0

			var_0.ShowMsgBox(var_4_0, arg_2_1)

			return
		end)

		return
	end

	var_2_1(var_2_0, var_2_2)

	return
end

function var_0_1.ShowItemBox(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1.type

	DROP_TYPE_EQUIP = var_1_10004

	if var_5_0 == var_1_10004 then
		var_1_10004 = arg_5_0

		local var_5_1 = arg_5_0.AddSubLayers

		Context = var_1_10005
		var_1_10005 = var_1_10005.New
		var_1_10006 = {}
		EquipmentInfoMediator = var_1_10007
		var_1_10006.mediator = var_1_10007
		EquipmentInfoLayer = var_1_10007
		var_1_10006.viewComponent = var_1_10007
		var_1_10007 = {
			equipmentId = arg_5_1:getConfig("id")
		}
		EquipmentInfoMediator = var_8
		var_1_10007.type = var_8.TYPE_DISPLAY
		var_1_10007.onRemoved = arg_5_2
		var_1_10006.data = var_1_10007

		var_5_1(var_1_10004, var_1_10005(var_1_10006))
	else
		local var_5_2 = arg_5_1.type

		DROP_TYPE_SPWEAPON = var_1_10004

		if var_5_2 == var_1_10004 then
			local var_5_3 = arg_5_0

			var_5_2 = arg_5_0.AddSubLayers
			Context = var_1_10005

			local var_5_4 = var_1_10005.New

			var_1_10006 = {}
			SpWeaponInfoMediator = var_1_10007
			var_1_10006.mediator = var_1_10007
			SpWeaponInfoLayer = var_1_10007
			var_1_10006.viewComponent = var_1_10007

			local var_5_5 = {
				spWeaponConfigId = arg_5_1:getConfig("id")
			}

			SpWeaponInfoLayer = var_8
			var_5_5.type = var_8.TYPE_DISPLAY
			var_5_5.onRemoved = arg_5_2
			var_1_10006.data = var_5_5

			var_5_2(var_5_3, var_5_4(var_1_10006))
		else
			pg = var_5_2

			local var_5_6 = var_5_2.MsgboxMgr.GetInstance()
			local var_5_7 = var_3.ShowMsgBox
			local var_5_8 = {}

			MSGBOX_TYPE_SINGLE_ITEM = var_1_10006
			var_5_8.type = var_1_10006
			var_5_8.drop = arg_5_1
			var_5_8.onNo = arg_5_2
			var_5_8.onYes = arg_5_2

			var_5_7(var_5_6, var_5_8)
		end
	end

	return
end

return var_0_1
