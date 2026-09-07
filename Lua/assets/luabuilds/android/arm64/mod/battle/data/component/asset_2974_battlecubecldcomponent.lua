ys = ys or {}

local var_0_0 = ys
local BattleCubeCldComponent = class("BattleCubeCldComponent", ys.Battle.BattleCldComponent)

ys.Battle.BattleCubeCldComponent = BattleCubeCldComponent
BattleCubeCldComponent.__name = "BattleCubeCldComponent"

function BattleCubeCldComponent:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	var_0_0.Battle.BattleCubeCldComponent.super.Ctor(self)

	self._offsetX = arg_1_4
	self._offsetZ = arg_1_5
	self._offset = Vector3(arg_1_4, 0, arg_1_5)
	self._boxSize = Vector3.zero
	self._min = Vector3.zero
	self._max = Vector3.zero

	self:ResetSize(arg_1_1, arg_1_2, arg_1_3)

	self._box = pg.CldNode.New()

	return
end

function BattleCubeCldComponent:ResetOffset(arg_2_1, arg_2_2)
	self._offsetX = arg_2_1
	self._offsetZ = arg_2_2
	self._offset.x = arg_2_1
	self._offset.z = arg_2_2

	return
end

function BattleCubeCldComponent:ResetSize(arg_3_1, arg_3_2, arg_3_3)
	self._boxSize.x = arg_3_1 * 0.5
	self._boxSize.y = arg_3_2 * 0.5
	self._boxSize.z = arg_3_3 * 0.5
	self._min.x = self._offsetX - arg_3_1 * 0.5
	self._min.y = -(arg_3_2 * 0.5)
	self._min.z = self._offsetZ - arg_3_3 * 0.5
	self._max.x = self._offsetX + arg_3_1 * 0.5
	self._max.y = arg_3_2 * 0.5
	self._max.z = self._offsetZ + arg_3_3 * 0.5

	return
end

function BattleCubeCldComponent:GetCldBox(arg_4_1)
	if arg_4_1 then
		self._cldData.LeftBound = arg_4_1.x - math.abs(self._min.x)
		self._cldData.RightBound = arg_4_1.x + math.abs(self._max.x)
		self._cldData.LowerBound = arg_4_1.z - math.abs(self._min.z)
		self._cldData.UpperBound = arg_4_1.z + math.abs(self._max.z)
	end

	return self._box:UpdateBox(self._min, self._max, arg_4_1)
end

function BattleCubeCldComponent:GetCldBoxSize()
	return self._boxSize
end

return
