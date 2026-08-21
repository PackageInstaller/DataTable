local var_0_0 = class("ShrineResultView", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "ShrineResult"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:Show()
	arg_2_0:initData()
	arg_2_0:initUI()

	return
end

function var_0_0.OnDestroy(arg_3_0)
	if arg_3_0.closeFunc then
		arg_3_0.closeFunc()

		arg_3_0.closeFunc = nil
	end

	return
end

function var_0_0.initData(arg_4_0)
	return
end

function var_0_0.initUI(arg_5_0)
	arg_5_0.bg = arg_5_0._tf:Find("BGImg")
	arg_5_0.dft = GetComponent(arg_5_0._tf, "DftAniEvent")
	arg_5_0.text_buff = arg_5_0._tf:Find("Main/MainBox/Text_Buff")
	arg_5_0.text_nobuff = arg_5_0._tf:Find("Main/MainBox/Text_NoBuff")
	arg_5_0.buffImg_1 = arg_5_0._tf:Find("Main/MainBox/Buff_1")
	arg_5_0.buffImg_2 = arg_5_0._tf:Find("Main/MainBox/Buff_2")
	arg_5_0.buffImg_3 = arg_5_0._tf:Find("Main/MainBox/Buff_3")

	onButton(arg_5_0, arg_5_0.bg, function()
		arg_5_0:Destroy()

		return
	end, SFX_CANCEL)
	arg_5_0.dft:SetStartEvent(function()
		setButtonEnabled(arg_5_0.bg, false)

		return
	end)
	arg_5_0.dft:SetEndEvent(function()
		setButtonEnabled(arg_5_0.bg, true)

		return
	end)

	return
end

function var_0_0.updateView(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 then
		setText(arg_9_0.text_buff, arg_9_1)
	else
		setText(arg_9_0.text_nobuff, arg_9_1)
	end

	setActive(arg_9_0.text_buff, arg_9_2)
	setActive(arg_9_0.text_nobuff, not arg_9_2)
	setActive(arg_9_0.buffImg_1, arg_9_2 == 1)
	setActive(arg_9_0.buffImg_2, arg_9_2 == 2)
	setActive(arg_9_0.buffImg_3, arg_9_2 == 3)

	return
end

function var_0_0.setCloseFunc(arg_10_0, arg_10_1)
	arg_10_0.closeFunc = arg_10_1

	return
end

return var_0_0
