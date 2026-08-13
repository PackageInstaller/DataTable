ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleYumiaManaView")

var_0.Battle.BattleYumiaManaView = var_0_3
var_0_3.__name = "BattleYumiaManaView"
var_0_3.TIPS_DURATION = 5

function var_0_3.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1
	arg_1_0._go = arg_1_1.gameObject

	arg_1_0:init()

	return
end

function var_0_3.init(arg_2_0)
	arg_2_0._apCap = var_0_2.FLEET_ATTR_CAP[arg_2_0:GetAttrName()]
	findTF = var_1
	arg_2_0._count = var_1(arg_2_0._tf, "count")
	findTF = var_1
	arg_2_0._progress = var_1(arg_2_0._tf, "progress")

	local var_2_0 = arg_2_0._count
	local var_2_1 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0._countText = var_2_1(var_2_0, var_4(var_1_10006))
	SetActive = var_1

	var_1(arg_2_0._tf, true)

	rtf = var_1
	arg_2_0._barVector = var_1(arg_2_0._progress).sizeDelta

	local var_2_2 = arg_2_0

	arg_2_0.UpdateMana(var_2_2, 0)

	setText = var_1
	findTF = var_2_2

	local var_2_3 = var_2_2(arg_2_0._tf, "tips/text")

	i18n = var_4

	var_1(var_2_3, var_4("yumia_mana_battle_tip"))

	setText = var_1
	findTF = var_2_3

	local var_2_4 = var_2_3(arg_2_0._tf, "tips/text_shade")

	i18n = var_4

	var_1(var_2_4, var_4("yumia_mana_battle_tip"))

	onButton = var_1

	var_1(arg_2_0, arg_2_0._tf, function()
		local var_3_0 = arg_2_0

		var_0.showTips(var_3_0)

		return
	end)

	return
end

function var_0_3.UpdateMana(arg_4_0, arg_4_1)
	setText = var_1_10002

	var_1_10002(arg_4_0._count, arg_4_1)

	local var_4_0 = arg_4_0._barVector

	var_4_0.x = arg_4_1
	rtf = var_4_0
	var_4_0(arg_4_0._progress).sizeDelta = arg_4_0._barVector

	return
end

function var_0_3.GetAttrName(arg_5_0)
	return var_0_2.YUMIA_MANA_NAME
end

function var_0_3.showTips(arg_6_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_6_0._go) then
		return
	end

	SetActive = var_1

	local var_6_0 = arg_6_0._tf

	var_1(var_3.Find(var_6_0, "tips"), true)

	LeanTween = var_1

	local var_6_1 = var_1.delayedCall
	local var_6_2 = arg_6_0._go
	local var_6_3 = var_0_3.TIPS_DURATION

	System = var_6_0

	var_6_1(var_6_2, var_6_3, var_6_0.Action(function()
		SetActive = var_2_10000

		local var_7_0 = arg_6_0._tf

		var_2_10000(var_2.Find(var_7_0, "tips"), false)

		return
	end))

	return
end

function var_0_3.Dispose(arg_8_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_8_0._go)

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_8_0)

	arg_8_0._count = nil
	arg_8_0._progress = nil
	arg_8_0._countText = nil
	arg_8_0._tf = nil

	return
end

return
