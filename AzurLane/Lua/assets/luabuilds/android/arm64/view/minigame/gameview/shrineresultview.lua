class = var_0_10000

local var_0_0 = "ShrineResultView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ShrineResult"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:Show()
	arg_2_0:initData()
	arg_2_0:initUI()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	if arg_3_0.closeFunc then
		arg_3_0.closeFunc()

		arg_3_0.closeFunc = nil
	end

	return
end

function var_0_1.initData(arg_4_0)
	return
end

function var_0_1.initUI(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.bg = var_1.Find(var_5_0, "BGImg")
	GetComponent = var_1
	arg_5_0.dft = var_1(arg_5_0._tf, "DftAniEvent")

	local var_5_1 = arg_5_0._tf

	arg_5_0.text_buff = var_1.Find(var_5_1, "Main/MainBox/Text_Buff")

	local var_5_2 = arg_5_0._tf

	arg_5_0.text_nobuff = var_1.Find(var_5_2, "Main/MainBox/Text_NoBuff")

	local var_5_3 = arg_5_0._tf

	arg_5_0.buffImg_1 = var_1.Find(var_5_3, "Main/MainBox/Buff_1")

	local var_5_4 = arg_5_0._tf

	arg_5_0.buffImg_2 = var_1.Find(var_5_4, "Main/MainBox/Buff_2")

	local var_5_5 = arg_5_0._tf

	arg_5_0.buffImg_3 = var_1.Find(var_5_5, "Main/MainBox/Buff_3")
	onButton = var_1

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.bg

	local function var_5_8()
		local var_6_0 = arg_5_0

		var_0.Destroy(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_5_6, var_5_7, var_5_8, var_1_10006)

	local var_5_9 = arg_5_0.dft

	var_1.SetStartEvent(var_5_9, function()
		setButtonEnabled = var_2_10000

		var_2_10000(arg_5_0.bg, false)

		return
	end)

	local var_5_10 = arg_5_0.dft

	var_1.SetEndEvent(var_5_10, function()
		setButtonEnabled = var_2_10000

		var_2_10000(arg_5_0.bg, true)

		return
	end)

	return
end

function var_0_1.updateView(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 then
		setText = var_1_10003

		var_1_10003(arg_9_0.text_buff, arg_9_1)
	else
		setText = var_1_10003

		var_1_10003(arg_9_0.text_nobuff, arg_9_1)
	end

	setActive = var_1_10003

	var_1_10003(arg_9_0.text_buff, arg_9_2)

	setActive = var_1_10003

	var_1_10003(arg_9_0.text_nobuff, not arg_9_2)

	setActive = var_1_10003

	var_1_10003(arg_9_0.buffImg_1, arg_9_2 == 1)

	setActive = var_1_10003

	var_1_10003(arg_9_0.buffImg_2, arg_9_2 == 2)

	setActive = var_1_10003

	var_1_10003(arg_9_0.buffImg_3, arg_9_2 == 3)

	return
end

function var_0_1.setCloseFunc(arg_10_0, arg_10_1)
	arg_10_0.closeFunc = arg_10_1

	return
end

return var_0_1
