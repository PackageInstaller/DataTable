ys = ys or {}

local var_0_1 = ys.Battle.BattleConfig
local BattleYumiaManaView = class("BattleYumiaManaView")

ys.Battle.BattleYumiaManaView = BattleYumiaManaView
BattleYumiaManaView.__name = "BattleYumiaManaView"
BattleYumiaManaView.TIPS_DURATION = 5

function BattleYumiaManaView:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self._tf = arg_1_1
	self._go = arg_1_1.gameObject

	self:init()

	return
end

function BattleYumiaManaView:init()
	self._apCap = var_0_1.FLEET_ATTR_CAP[self:GetAttrName()]
	self._count = findTF(self._tf, "count")
	self._progress = findTF(self._tf, "progress")
	self._countText = self._count:GetComponent(typeof(Text))

	SetActive(self._tf, true)

	self._barVector = rtf(self._progress).sizeDelta

	self:UpdateMana(0)
	setText(findTF(self._tf, "tips/text"), i18n("yumia_mana_battle_tip"))
	setText(findTF(self._tf, "tips/text_shade"), i18n("yumia_mana_battle_tip"))
	onButton(self, self._tf, function()
		self:showTips()

		return
	end)

	return
end

function BattleYumiaManaView:UpdateMana(arg_4_1)
	setText(self._count, arg_4_1)

	self._barVector.x = arg_4_1
	rtf(self._progress).sizeDelta = self._barVector

	return
end

function BattleYumiaManaView:GetAttrName()
	return var_0_1.YUMIA_MANA_NAME
end

function BattleYumiaManaView:showTips()
	if LeanTween.isTweening(self._go) then
		return
	end

	SetActive(self._tf:Find("tips"), true)
	LeanTween.delayedCall(self._go, BattleYumiaManaView.TIPS_DURATION, System.Action(function()
		SetActive(self._tf:Find("tips"), false)

		return
	end))

	return
end

function BattleYumiaManaView:Dispose()
	LeanTween.cancel(self._go)
	pg.DelegateInfo.Dispose(self)

	self._count = nil
	self._progress = nil
	self._countText = nil
	self._tf = nil

	return
end

return
