local var_0_0 = class("MainEquipmentChangeSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	if not ({
		tip_new = "equipment_info_change_text_after",
		isOpen = false,
		title = "equipment_info_change_tip",
		icon_new = "equips/50860",
		icon_old = "equips/50860",
		name_new = "equipment_info_change_name_b",
		tip_old = "equipment_info_change_text_before",
		equipID = 908601,
		name_old = "equipment_info_change_name_a"
	}).isOpen then
		arg_1_1()

		return
	end

	if PlayerPrefs.GetInt("ItemIconChange_" .. ({
		tip_new = "equipment_info_change_text_after",
		isOpen = false,
		title = "equipment_info_change_tip",
		icon_new = "equips/50860",
		icon_old = "equips/50860",
		name_new = "equipment_info_change_name_b",
		tip_old = "equipment_info_change_text_before",
		equipID = 908601,
		name_old = "equipment_info_change_name_a"
	}).equipID, 0) == 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideClose = true,
			hideNo = true,
			type = MSGBOX_TYPE_JUST_FOR_SHOW,
			title = pg.MsgboxMgr.TITLE_INFORMATION,
			configData = {
				tip_new = "equipment_info_change_text_after",
				isOpen = false,
				title = "equipment_info_change_tip",
				icon_new = "equips/50860",
				icon_old = "equips/50860",
				name_new = "equipment_info_change_name_b",
				tip_old = "equipment_info_change_text_before",
				equipID = 908601,
				name_old = "equipment_info_change_name_a"
			},
			onClose = function()
				arg_1_1()
				PlayerPrefs.SetInt("ItemIconChange_" .. var_0, 1)

				return
			end,
			onYes = function()
				arg_1_1()
				PlayerPrefs.SetInt("ItemIconChange_" .. var_0, 1)

				return
			end
		})
	else
		arg_1_1()
	end

	return
end

return var_0_0
