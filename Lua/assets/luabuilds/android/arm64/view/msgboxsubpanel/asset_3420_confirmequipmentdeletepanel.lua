local ConfirmEquipmentDeletePanel = class("ConfirmEquipmentDeletePanel", import(".MsgboxSubPanel"))

function ConfirmEquipmentDeletePanel:getUIName()
	return "EquipDeleteConfirmBox"
end

function ConfirmEquipmentDeletePanel:UpdateView(arg_2_1)
	arg_2_1.hideYes = true

	ConfirmEquipmentDeletePanel.super.UpdateView(self, arg_2_1)

	return
end

function ConfirmEquipmentDeletePanel:OnRefresh(arg_3_1)
	local var_3_0 = arg_3_1.data

	self:SetWindowSize(Vector2(937, 540))

	local var_3_1 = self._tf:Find("InputField")

	setText(var_3_1:Find("Placeholder"), i18n("box_equipment_del_click"))
	setText(self._tf:Find("intro"), SwitchSpecialChar(i18n("destory_important_equipment_tip", arg_3_1.data.name)))

	local var_3_2 = {
		noQuit = true
	}

	var_3_2.text = arg_3_1.yesText or self.viewParent.TEXT_CONFIRM
	var_3_2.btnType = arg_3_1.yesBtnType or self.viewParent.BUTTON_BLUE

	function var_3_2.onCallback()
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
		self:closeView()

		return
	end

	var_3_2.sound = arg_3_1.yesSound or SFX_CONFIRM
	var_3_2.alignment = arg_3_1.yesSize and TextAnchor.MiddleCenter
	self.yesBtn = self.viewParent:createBtn(var_3_2)

	if arg_3_1.yesSize then
		self.yesBtn.sizeDelta = arg_3_1.yesSize
	end

	setGray(self.yesBtn, arg_3_1.yesGray, true)

	return
end

return ConfirmEquipmentDeletePanel
