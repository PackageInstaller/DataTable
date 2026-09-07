ys = ys or {}

local var_0_0 = ys
local BattleColumnCldComponent = class("BattleColumnCldComponent", ys.Battle.BattleCldComponent)

ys.Battle.BattleColumnCldComponent = BattleColumnCldComponent
BattleColumnCldComponent.__name = "BattleColumnCldComponent"

function BattleColumnCldComponent:Ctor(arg_1_1, arg_1_2)
	var_0_0.Battle.BattleColumnCldComponent.super.Ctor(self)

	self._range = arg_1_1 * 0.5
	self._tickness = arg_1_2 * 0.5
	self._box = pg.CldNode.New()

	return
end

function BattleColumnCldComponent:GetCldBox(arg_2_1)
	return self._box:UpdateCylinder(arg_2_1, self._tickness, self._range)
end

function BattleColumnCldComponent:GetCldBoxSize()
	return {
		range = self._range,
		tickness = self._tickness
	}
end

return
