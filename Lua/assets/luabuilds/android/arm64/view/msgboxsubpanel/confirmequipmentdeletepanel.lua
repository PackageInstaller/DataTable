local var_0_0 = class("ConfirmEquipmentDeletePanel", import(".MsgboxSubPanel"))

function var_0_0.getUIName(arg_1_0)
	return "EquipDeleteConfirmBox"
end

function var_0_0.UpdateView(arg_2_0, arg_2_1)
	arg_2_1.hideYes = true

	var_0_0.super.UpdateView(arg_2_0, arg_2_1)

	return
end

function var_0_0.OnRefresh(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.data

	arg_3_0:SetWindowSize(Vector2(937, 540))

	local var_3_1 = arg_3_0._tf:Find("InputField")

	setText(arg_3_0._tf:Find("InputField"):Find("Placeholder"), i18n("box_equipment_del_click"))
	setText(arg_3_0._tf:Find("intro"), SwitchSpecialChar(i18n("destory_important_equipment_tip", arg_3_1.data.name)))

	;({
		noQuit = true
	}).text = arg_3_1.yesText or arg_3_0.viewParent.TEXT_CONFIRM
	;({
		noQuit = true
	}).btnType = arg_3_1.yesBtnType or arg_3_0.viewParent.BUTTON_BLUE
	;({
		noQuit = true
	}).onCallback = function()
		local var_4_0 = getInputText(var_3_1)

		if not var_4_0 or var_4_0 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_should_input"))

			return
		end

		if var_4_0 ~= var_3_0.name then
			pg.TipsMgr.GetInstance():ShowTips(i18n("destory_important_equipment_input_erro"))

			return
		end

		existCall(arg_3_1.onYes)
		arg_3_0:closeView()

		return
	end
	;({
		noQuit = true
	}).sound = arg_3_1.yesSound or SFX_CONFIRM
	;({
		noQuit = true
	}).alignment = arg_3_1.yesSize and TextAnchor.MiddleCenter
	arg_3_0.yesBtn = arg_3_0.viewParent:createBtn({
		noQuit = true
	})

	if arg_3_1.yesSize then
		arg_3_0.yesBtn.sizeDelta = arg_3_1.yesSize
	end

	setGray(arg_3_0.yesBtn, arg_3_1.yesGray, true)

	return
end

return var_0_0
