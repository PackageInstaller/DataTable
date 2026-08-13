class = var_0_10000

local var_0_0 = var_0_10000("MainEquipmentChangeSequence")

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

	local var_1_0 = var_2.equipID

	PlayerPrefs = var_1_10004

	if var_1_10004.GetInt("ItemIconChange_" .. var_1_0, 0) == 0 then
		local function var_1_1()
			arg_1_1()

			PlayerPrefs = var_0

			var_0.SetInt("ItemIconChange_" .. var_1_0, 1)

			return
		end

		pg = var_6

		local var_1_2 = var_6.MsgboxMgr.GetInstance()
		local var_1_3 = var_6.ShowMsgBox
		local var_1_4 = {
			modal = true,
			hideClose = true,
			hideNo = true
		}

		MSGBOX_TYPE_JUST_FOR_SHOW = var_1_10010
		var_1_4.type = var_1_10010
		pg = var_1_10010
		var_1_4.title = var_1_10010.MsgboxMgr.TITLE_INFORMATION
		var_1_4.configData = var_2
		var_1_4.onClose = var_1_1
		var_1_4.onYes = var_1_1

		var_1_3(var_1_2, var_1_4)
	else
		arg_1_1()
	end

	return
end

return var_0_0
