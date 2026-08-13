class = var_0_10000

local var_0_0 = "PSSSkinMagazinePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CorSkinMagazineTemplatePage"))

var_0_1.EXPAND_WIDTH = 975
var_0_1.CLOSE_WIDTH = 225
var_0_1.DURATION_PARAMETER = 2500

function var_0_1.OnFirstFlush(arg_1_0)
	arg_1_0.super.OnFirstFlush(arg_1_0)

	setText = var_1

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.Find(var_1_0, "AD/Text")

	i18n = var_1_10004

	var_1(var_1_1, var_1_10004("black5_bundle_desc"))

	setText = var_1

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_3.Find(var_1_2, "AD/btn/name")

	i18n = var_4

	var_1(var_1_3, var_4("black5_bundle_button"))

	onButton = var_1

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_4.Find(var_1_5, "AD/btn")

	local function var_1_7()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_2_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		local var_2_3 = var_2_10004.CHARGE
		local var_2_4 = {}

		ChargeScene = var_2_10006
		var_2_4.wrap = var_2_10006.TYPE_GIFT

		var_2_1(var_2_0, var_2_2, var_2_3, var_2_4)

		return
	end

	SFX_PANEL = var_1_5

	var_1(var_1_4, var_1_6, var_1_7, var_1_5)

	local var_1_8 = arg_1_0.activity

	if not var_1.GetConfigClientSetting(var_1_8, "packageID") then
		return false
	end

	Goods = var_1

	local var_1_9 = var_1.Create
	local var_1_10 = {}
	local var_1_11 = arg_1_0.activity

	var_1_10.shop_id = var_4.GetConfigClientSetting(var_1_11, "packageID")
	Goods = var_4

	local var_1_12 = var_1_9(var_1_10, var_4.TYPE_GIFT_PACKAGE_ACT)

	SetActive = var_1_10002

	local var_1_13 = arg_1_0._tf

	var_1_10002(var_4.Find(var_1_13, "AD/btn/red"), var_1_12:isTip())

	SetActive = var_1_10002

	local var_1_14 = arg_1_0._tf

	var_1_10002(var_4.Find(var_1_14, "AD/btn"), var_1_12:getBuyCount() ~= 1)

	SetActive = var_1_10002

	local var_1_15 = arg_1_0._tf

	var_1_10002(var_4.Find(var_1_15, "AD/Text"), var_1_12:getBuyCount() ~= 1)

	SetActive = var_1_10002

	local var_1_16 = arg_1_0._tf

	var_1_10002(var_4.Find(var_1_16, "AD/Image"), var_1_12:getBuyCount() ~= 1)

	return
end

return var_0_1
