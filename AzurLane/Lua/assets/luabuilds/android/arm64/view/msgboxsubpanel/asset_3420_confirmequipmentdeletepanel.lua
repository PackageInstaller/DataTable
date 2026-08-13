class = var_0_10000

local var_0_0 = "ConfirmEquipmentDeletePanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MsgboxSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "EquipDeleteConfirmBox"
end

function var_0_1.UpdateView(arg_2_0, arg_2_1)
	arg_2_1.hideYes = true

	var_0_1.super.UpdateView(arg_2_0, arg_2_1)

	return
end

function var_0_1.OnRefresh(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.data
	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.SetWindowSize

	Vector2 = var_1_10006

	var_3_2(var_3_1, var_1_10006(937, 540))

	local var_3_3 = arg_3_0._tf
	local var_3_4 = var_3.Find(var_3_3, "intro")
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_4.Find(var_3_5, "InputField")
	local var_3_7

	var_3_7, setText = var_4.Find(var_3_6, "Placeholder"), var_3_5
	i18n = var_9

	var_3_5(var_3_7, var_9("box_equipment_del_click"))

	setText = var_3_5

	local var_3_8 = var_3_4

	SwitchSpecialChar = var_9
	i18n = var_11

	var_3_5(var_3_8, var_9(var_11("destory_important_equipment_tip", var_3_0.name)))

	local function var_3_9()
		getInputText = var_2_10000

		if not var_2_10000(var_0) or var_0 == "" then
			pg = var_2_10001

			local var_4_0 = var_2_10001.TipsMgr.GetInstance()
			local var_4_1 = var_1.ShowTips

			i18n = var_2_10004

			var_4_1(var_4_0, var_2_10004("word_should_input"))

			return
		end

		local var_4_3

		if var_0 ~= var_3_0.name then
			pg = var_4_3

			local var_4_2 = var_4_3.TipsMgr.GetInstance()

			var_4_3 = var_4_3.ShowTips
			i18n = var_2_10004

			var_4_3(var_4_2, var_2_10004("destory_important_equipment_input_erro"))

			return
		end

		existCall = var_4_3

		var_4_3(arg_3_1.onYes)

		local var_4_4 = arg_3_0

		var_1.closeView(var_4_4)

		return
	end

	local var_3_10 = arg_3_0.viewParent
	local var_3_11 = var_7.createBtn
	local var_3_12 = {
		noQuit = true
	}
	local var_3_13

	if not arg_3_1.yesText then
		var_3_13 = arg_3_0.viewParent.TEXT_CONFIRM
	end

	var_3_12.text = var_3_13

	local var_3_14

	if not arg_3_1.yesBtnType then
		var_3_14 = arg_3_0.viewParent.BUTTON_BLUE
	end

	var_3_12.btnType = var_3_14
	var_3_12.onCallback = var_3_9

	if not arg_3_1.yesSound then
		SFX_CONFIRM = var_11
	end

	var_3_12.sound = var_11

	local var_3_15

	if arg_3_1.yesSize then
		TextAnchor = var_3_15
		var_3_15 = var_3_15.MiddleCenter
	end

	var_3_12.alignment = var_3_15
	arg_3_0.yesBtn = var_3_11(var_3_10, var_3_12)

	local var_3_16

	if arg_3_1.yesSize then
		var_3_16 = arg_3_0.yesBtn
		var_3_16.sizeDelta = arg_3_1.yesSize
	end

	setGray = var_3_16

	var_3_16(arg_3_0.yesBtn, arg_3_1.yesGray, true)

	return
end

return var_0_1
