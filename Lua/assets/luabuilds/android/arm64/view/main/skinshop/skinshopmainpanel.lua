local var_0_0 = class("SkinShopMainPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0.nameTxt = findTF("name_bg/name", arg_1_0._tf):GetComponent(typeof(Text))
	arg_1_0.skinNameTxt = findTF("name_bg/skin_name", arg_1_0._tf):GetComponent(typeof(Text))
	arg_1_0.charParent = findTF("char/char", arg_1_0._tf)
	arg_1_0.paintingTF = findTF("paint", arg_1_0._tf)
	arg_1_0.charBg = findTF("char/char_info", arg_1_0._tf)
	arg_1_0.tags = findTF("char/char_info/tags", arg_1_0._tf)
	arg_1_0.limitTxt = findTF("name_bg/limit_time/Text", arg_1_0._tf):GetComponent(typeof(Text))
	arg_1_0.commonPanel = findTF("char/common", arg_1_0._tf)
	arg_1_0.buyBtn = findTF("buy_btn", arg_1_0.commonPanel)
	arg_1_0.activityBtn = findTF("activty_btn", arg_1_0.commonPanel)
	arg_1_0.gotBtn = findTF("got_btn", arg_1_0.commonPanel)
	arg_1_0.priceTxt = findTF("consume/Text", arg_1_0.commonPanel):GetComponent(typeof(Text))
	arg_1_0.originalPriceTxt = findTF("consume/originalprice/Text", arg_1_0.commonPanel):GetComponent(typeof(Text))
	arg_1_0.timelimtPanel = findTF("char/timelimt", arg_1_0._tf)
	arg_1_0.timelimitBtn = findTF("timelimit_btn", arg_1_0.timelimtPanel)
	arg_1_0.timelimitPriceTxt = findTF("consume/Text", arg_1_0.timelimtPanel):GetComponent(typeof(Text))
	arg_1_0.bg1 = findTF("bg/bg_1")
	arg_1_0.bg2 = findTF("bg/bg_2")
	arg_1_0.bgType = false
	arg_1_0.defaultBg = arg_1_0.bg1:GetComponent(typeof(Image)).sprite

	return
end

return var_0_0
