ys = ys or {}

local var_0_1 = ys.Battle.BattleConfig
local BattleReisalinAPView = class("BattleReisalinAPView")

ys.Battle.BattleReisalinAPView = BattleReisalinAPView
BattleReisalinAPView.__name = "BattleReisalinAPView"

function BattleReisalinAPView:Ctor(arg_1_1)
	self._tf = arg_1_1

	self:init()

	return
end

function BattleReisalinAPView:init()
	self._apCap = var_0_1.FLEET_ATTR_CAP[self:GetAttrName()]
	self._count = findTF(self._tf, "count")
	self._glow = findTF(self._tf, "glow_gizmos")
	self._countText = self._count:GetComponent(typeof(Text))

	SetActive(self._tf, true)
	self:UpdateAP(0)

	return
end

function BattleReisalinAPView:UpdateAP(arg_3_1)
	self._countText.text = arg_3_1

	if arg_3_1 >= self._apCap then
		self._countText.color = Color.ReisalinGold

		SetActive(self._glow, true)
	else
		self._countText.color = Color.white

		SetActive(self._glow, false)
	end

	return
end

function BattleReisalinAPView:GetAttrName()
	return var_0_1.ALCHEMIST_AP_NAME
end

function BattleReisalinAPView:Dispose()
	self._count = nil
	self._glow = nil
	self._countText = nil
	self._tf = nil

	return
end

return
