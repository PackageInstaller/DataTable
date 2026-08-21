local var_0_0 = class("MainOverDueEquipmentSequence", import(".MainSublayerSequence"))

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(EquipmentProxy):getTimeLimitShipList()

	if #var_1_0 > 0 then
		arg_1_0:ShowMsgBox({
			item2Row = true,
			itemList = var_1_0,
			content = i18n("time_limit_equip_destroy_on_ship"),
			onYes = arg_1_1,
			onNo = arg_1_1
		})
	else
		arg_1_1()
	end

	return
end

function var_0_0.ShowMsgBox(arg_2_0, arg_2_1)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		hideNo = true,
		type = MSGBOX_TYPE_ITEM_BOX,
		items = arg_2_1.itemList,
		content = arg_2_1.content,
		item2Row = arg_2_1.item2Row,
		itemFunc = function(arg_3_0)
			arg_2_0:ShowItemBox(arg_3_0, function()
				arg_2_0:ShowMsgBox(arg_2_1)

				return
			end)

			return
		end
	})

	return
end

function var_0_0.ShowItemBox(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1.type == DROP_TYPE_EQUIP then
		arg_5_0:AddSubLayers(Context.New({
			mediator = EquipmentInfoMediator,
			viewComponent = EquipmentInfoLayer,
			data = {
				equipmentId = arg_5_1:getConfig("id"),
				type = EquipmentInfoMediator.TYPE_DISPLAY,
				onRemoved = arg_5_2
			}
		}))
	elseif arg_5_1.type == DROP_TYPE_SPWEAPON then
		arg_5_0:AddSubLayers(Context.New({
			mediator = SpWeaponInfoMediator,
			viewComponent = SpWeaponInfoLayer,
			data = {
				spWeaponConfigId = arg_5_1:getConfig("id"),
				type = SpWeaponInfoLayer.TYPE_DISPLAY,
				onRemoved = arg_5_2
			}
		}))
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_SINGLE_ITEM,
			drop = arg_5_1,
			onNo = arg_5_2,
			onYes = arg_5_2
		})
	end

	return
end

return var_0_0
