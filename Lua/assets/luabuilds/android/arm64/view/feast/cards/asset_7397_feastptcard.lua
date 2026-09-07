local FeastPtCard = class("FeastPtCard")

function FeastPtCard:Ctor(arg_1_1, arg_1_2)
	self.binder = arg_1_2
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.indexTxt = self._tf:Find("Text"):GetComponent(typeof(Text))
	self.lockBtn = self._tf:Find("btns/lock")
	self.getBtn = self._tf:Find("btns/get")
	self.gotBtn = self._tf:Find("btns/got")
	self.award = self._tf:Find("award")

	setText(self.getBtn:Find("Text"), i18n("feast_task_pt_get"))
	setText(self.gotBtn:Find("Text"), i18n("feast_task_pt_got"))

	return
end

function FeastPtCard:Flush(arg_2_1, arg_2_2)
	self.indexTxt.text = i18n("feast_task_pt_level", arg_2_2)

	local var_2_0 = arg_2_1:GetDrop(arg_2_2)

	updateDrop(self.award, var_2_0)
	onButton(self.binder, self.award, function()
		self.binder:emit(BaseUI.ON_DROP, var_2_0)

		return
	end, SFX_PANEL)

	local var_2_1 = arg_2_1:GetDroptItemState(arg_2_2)

	setActive(self.lockBtn, var_2_1 == ActivityPtData.STATE_LOCK)
	setActive(self.getBtn, var_2_1 == ActivityPtData.STATE_CAN_GET)
	setActive(self.gotBtn, var_2_1 == ActivityPtData.STATE_GOT)
	onButton(self.binder, self._tf, function()
		if var_2_1 == ActivityPtData.STATE_CAN_GET then
			self.binder:emit(FeastMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = arg_2_1:GetId(),
				arg1 = arg_2_1:GetPtTarget(arg_2_2)
			})
		end

		return
	end, SFX_PANEL)

	return
end

function FeastPtCard:Dispose()
	return
end

return FeastPtCard
