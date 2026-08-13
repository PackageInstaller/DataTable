class = var_0_10000

local var_0_0 = var_0_10000("ValentineQteGameMsgBox")

var_0_0.EXIT_TXT = 1
var_0_0.PAUSE_TXT = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1

	arg_1_0:OnInit()
	arg_1_0:OnRegister()

	return
end

function var_0_0.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_0, "frame/btns/confirm_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_1, "frame/btns/cancel_btn")
	GetComponent = var_1

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_3.Find(var_2_2, "frame/exit")

	typeof = var_4
	Image = var_6

	local var_2_4 = var_1(var_2_3, var_4(var_6))

	var_1.SetNativeSize(var_2_4)

	GetComponent = var_1

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_3.Find(var_2_5, "frame/puase")

	typeof = var_4
	Image = var_6

	local var_2_7 = var_1(var_2_6, var_4(var_6))

	var_1.SetNativeSize(var_2_7)

	local var_2_8 = {}
	local var_2_9 = var_0_0.EXIT_TXT
	local var_2_10 = arg_2_0._tf

	var_2_8[var_2_9] = var_3.Find(var_2_10, "frame/exit")

	local var_2_11 = var_0_0.PAUSE_TXT
	local var_2_12 = arg_2_0._tf

	var_2_8[var_2_11] = var_3.Find(var_2_12, "frame/puase")
	arg_2_0.texts = var_2_8

	return
end

function var_0_0.OnRegister(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		if arg_3_0.settings.onYes then
			arg_3_0.settings.onYes()
		end

		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.cancelBtn

	local function var_3_5()
		if arg_3_0.settings.onNo then
			arg_3_0.settings.onNo()
		end

		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	arg_6_0.settings = arg_6_1
	setActive = var_1_10002

	var_1_10002(arg_6_0._tf, true)

	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.texts) do
		setActive = var_1_10007

		var_1_10007(iter_6_1, false)
	end

	if arg_6_0.texts[arg_6_1.content] then
		setActive = var_2

		var_2(arg_6_0.texts[arg_6_1.content], true)
	end

	setActive = var_2

	var_2(arg_6_0.cancelBtn, not arg_6_1.noNo)

	return
end

function var_0_0.Hide(arg_7_0)
	setActive = var_1_10001

	var_1_10001(arg_7_0._tf, false)

	arg_7_0.settings = nil

	return
end

function var_0_0.Destroy(arg_8_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_8_0)
	arg_8_0:Hide()

	return
end

return var_0_0
