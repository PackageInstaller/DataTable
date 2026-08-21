local var_0_0 = class("ValentineQteGameMsgBox")

var_0_0.EXIT_TXT = 1
var_0_0.PAUSE_TXT = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1

	arg_1_0:OnInit()
	arg_1_0:OnRegister()

	return
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/btns/confirm_btn")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("frame/btns/cancel_btn")

	GetComponent(arg_2_0._tf:Find("frame/exit"), typeof(Image)):SetNativeSize()
	GetComponent(arg_2_0._tf:Find("frame/puase"), typeof(Image)):SetNativeSize()

	arg_2_0.texts = {
		[var_0_0.EXIT_TXT] = arg_2_0._tf:Find("frame/exit"),
		[var_0_0.PAUSE_TXT] = arg_2_0._tf:Find("frame/puase")
	}

	return
end

function var_0_0.OnRegister(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		if arg_3_0.settings.onYes then
			arg_3_0.settings.onYes()
		end

		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		if arg_3_0.settings.onNo then
			arg_3_0.settings.onNo()
		end

		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	arg_6_0.settings = arg_6_1

	setActive(arg_6_0._tf, true)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.texts) do
		setActive(iter_6_1, false)
	end

	if arg_6_0.texts[arg_6_1.content] then
		setActive(arg_6_0.texts[arg_6_1.content], true)
	end

	setActive(arg_6_0.cancelBtn, not arg_6_1.noNo)

	return
end

function var_0_0.Hide(arg_7_0)
	setActive(arg_7_0._tf, false)

	arg_7_0.settings = nil

	return
end

function var_0_0.Destroy(arg_8_0)
	pg.DelegateInfo.Dispose(arg_8_0)
	arg_8_0:Hide()

	return
end

return var_0_0
