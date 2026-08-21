ys = ys or {}

local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = class("BattleYumiaManaView")

ys.Battle.BattleYumiaManaView = var_0_2
var_0_2.__name = "BattleYumiaManaView"
var_0_2.TIPS_DURATION = 5

function var_0_2.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1
	arg_1_0._go = arg_1_1.gameObject

	arg_1_0:init()

	return
end

function var_0_2.init(arg_2_0)
	arg_2_0._apCap = var_0_1.FLEET_ATTR_CAP[arg_2_0:GetAttrName()]
	arg_2_0._count = findTF(arg_2_0._tf, "count")
	arg_2_0._progress = findTF(arg_2_0._tf, "progress")
	arg_2_0._countText = arg_2_0._count:GetComponent(typeof(Text))

	SetActive(arg_2_0._tf, true)

	arg_2_0._barVector = rtf(arg_2_0._progress).sizeDelta

	arg_2_0:UpdateMana(0)
	setText(findTF(arg_2_0._tf, "tips/text"), i18n("yumia_mana_battle_tip"))
	setText(findTF(arg_2_0._tf, "tips/text_shade"), i18n("yumia_mana_battle_tip"))
	onButton(arg_2_0, arg_2_0._tf, function()
		arg_2_0:showTips()

		return
	end)

	return
end

function var_0_2.UpdateMana(arg_4_0, arg_4_1)
	setText(arg_4_0._count, arg_4_1)

	arg_4_0._barVector.x = arg_4_1
	rtf(arg_4_0._progress).sizeDelta = arg_4_0._barVector

	return
end

function var_0_2.GetAttrName(arg_5_0)
	return var_0_1.YUMIA_MANA_NAME
end

function var_0_2.showTips(arg_6_0)
	if LeanTween.isTweening(arg_6_0._go) then
		return
	end

	SetActive(arg_6_0._tf:Find("tips"), true)
	LeanTween.delayedCall(arg_6_0._go, var_0_2.TIPS_DURATION, System.Action(function()
		SetActive(arg_6_0._tf:Find("tips"), false)

		return
	end))

	return
end

function var_0_2.Dispose(arg_8_0)
	LeanTween.cancel(arg_8_0._go)
	pg.DelegateInfo.Dispose(arg_8_0)

	arg_8_0._count = nil
	arg_8_0._progress = nil
	arg_8_0._countText = nil
	arg_8_0._tf = nil

	return
end

return
