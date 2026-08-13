class = var_0_10000

local var_0_0 = var_0_10000("SkinShopMainPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	findTF = var_1_10002

	local var_1_0 = var_1_10002("name_bg/name", arg_1_0._tf)
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.nameTxt = var_1_1(var_1_0, var_5(var_1_10007))
	findTF = var_2

	local var_1_2 = var_2("name_bg/skin_name", arg_1_0._tf)
	local var_1_3 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.skinNameTxt = var_1_3(var_1_2, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.charParent = var_2("char/char", arg_1_0._tf)
	findTF = var_2
	arg_1_0.paintingTF = var_2("paint", arg_1_0._tf)
	findTF = var_2
	arg_1_0.charBg = var_2("char/char_info", arg_1_0._tf)
	findTF = var_2
	arg_1_0.tags = var_2("char/char_info/tags", arg_1_0._tf)
	findTF = var_2

	local var_1_4 = var_2("name_bg/limit_time/Text", arg_1_0._tf)
	local var_1_5 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.limitTxt = var_1_5(var_1_4, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.commonPanel = var_2("char/common", arg_1_0._tf)
	findTF = var_2
	arg_1_0.buyBtn = var_2("buy_btn", arg_1_0.commonPanel)
	findTF = var_2
	arg_1_0.activityBtn = var_2("activty_btn", arg_1_0.commonPanel)
	findTF = var_2
	arg_1_0.gotBtn = var_2("got_btn", arg_1_0.commonPanel)
	findTF = var_2

	local var_1_6 = var_2("consume/Text", arg_1_0.commonPanel)
	local var_1_7 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.priceTxt = var_1_7(var_1_6, var_5(var_1_10007))
	findTF = var_2

	local var_1_8 = var_2("consume/originalprice/Text", arg_1_0.commonPanel)
	local var_1_9 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.originalPriceTxt = var_1_9(var_1_8, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.timelimtPanel = var_2("char/timelimt", arg_1_0._tf)
	findTF = var_2
	arg_1_0.timelimitBtn = var_2("timelimit_btn", arg_1_0.timelimtPanel)
	findTF = var_2

	local var_1_10 = var_2("consume/Text", arg_1_0.timelimtPanel)
	local var_1_11 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.timelimitPriceTxt = var_1_11(var_1_10, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.bg1 = var_2("bg/bg_1")
	findTF = var_2
	arg_1_0.bg2 = var_2("bg/bg_2")
	arg_1_0.bgType = false

	local var_1_12 = arg_1_0.bg1
	local var_1_13 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.defaultBg = var_1_13(var_1_12, var_5(var_1_10007)).sprite

	return
end

return var_0_0
