local MainEquipmentChangeSequence = class("MainEquipmentChangeSequence")

function MainEquipmentChangeSequence:Execute(arg_1_1)
	local var_1_0 = {
		tip_new = "equipment_info_change_text_after",
		isOpen = false,
		title = "equipment_info_change_tip",
		icon_new = "equips/50860",
		icon_old = "equips/50860",
		name_new = "equipment_info_change_name_b",
		tip_old = "equipment_info_change_text_before",
		equipID = 908601,
		name_old = "equipment_info_change_name_a"
	}

	if not var_1_0.isOpen then
		arg_1_1()

		return
	end

	local var_1_1 = var_1_0.equipID

	if PlayerPrefs.GetInt("ItemIconChange_" .. var_1_0.equipID, 0) == 0 then
		local function var_1_2()
			arg_1_1()
			PlayerPrefs.SetInt("ItemIconChange_" .. var_1_1, 1)

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideClose = true,
			hideNo = true,
			type = MSGBOX_TYPE_JUST_FOR_SHOW,
			title = pg.MsgboxMgr.TITLE_INFORMATION,
			configData = var_1_0,
			onClose = var_1_2,
			onYes = var_1_2
		})
	else
		arg_1_1()
	end

	return
end

return MainEquipmentChangeSequence
