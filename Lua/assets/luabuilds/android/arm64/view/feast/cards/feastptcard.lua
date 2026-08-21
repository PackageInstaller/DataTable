local var_0_0 = class("FeastPtCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.binder = arg_1_2
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.indexTxt = arg_1_0._tf:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.lockBtn = arg_1_0._tf:Find("btns/lock")
	arg_1_0.getBtn = arg_1_0._tf:Find("btns/get")
	arg_1_0.gotBtn = arg_1_0._tf:Find("btns/got")
	arg_1_0.award = arg_1_0._tf:Find("award")

	setText(arg_1_0.getBtn:Find("Text"), i18n("feast_task_pt_get"))
	setText(arg_1_0.gotBtn:Find("Text"), i18n("feast_task_pt_got"))

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.indexTxt.text = i18n("feast_task_pt_level", arg_2_2)

	updateDrop(arg_2_0.award, (arg_2_1:GetDrop(arg_2_2)))
	onButton(arg_2_0.binder, arg_2_0.award, function()
		arg_2_0.binder:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_2_0 = arg_2_1:GetDroptItemState(arg_2_2)

	setActive(arg_2_0.lockBtn, var_2_0 == ActivityPtData.STATE_LOCK)
	setActive(arg_2_0.getBtn, var_2_0 == ActivityPtData.STATE_CAN_GET)
	setActive(arg_2_0.gotBtn, var_2_0 == ActivityPtData.STATE_GOT)
	onButton(arg_2_0.binder, arg_2_0._tf, function()
		if var_2_0 == ActivityPtData.STATE_CAN_GET then
			arg_2_0.binder:emit(FeastMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = arg_2_1:GetId(),
				arg1 = arg_2_1:GetPtTarget(arg_2_2)
			})
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
