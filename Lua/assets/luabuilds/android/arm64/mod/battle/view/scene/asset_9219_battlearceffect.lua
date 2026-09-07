ys = ys or {}

local BattleArcEffect = class("BattleArcEffect")

ys.Battle.BattleArcEffect = BattleArcEffect
BattleArcEffect.__name = "BattleArcEffect"

function BattleArcEffect:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._go = arg_1_1
	self._characterA = arg_1_2
	self._unitA = arg_1_2:GetUnitData()
	self._unitB = arg_1_3
	self._boundBone = arg_1_4
	self._material = self._go.transform:GetComponent(typeof(Renderer)).material

	local var_1_0 = self._characterA:GetBonePos(self._boundBone)
	local var_1_1 = self._unitB:GetPosition()

	self._vectorA = Vector4.New(var_1_0.x, 5, var_1_0.z, 1)
	self._vectorB = Vector4.New(var_1_1.x, 5, var_1_1.z, 1)

	self._material:SetVector("_PosBegin", self._vectorA)
	self._material:SetVector("_PosEnd", self._vectorB)

	return
end

function BattleArcEffect:Update()
	if self._unitA:IsAlive() and self._unitB:IsAlive() then
		local var_2_0 = self._characterA:GetBonePos(self._boundBone)
		local var_2_1 = self._unitB:GetPosition()

		self._vectorA.x = var_2_0.x
		self._vectorA.z = var_2_0.z
		self._vectorB.x = var_2_1.x
		self._vectorB.z = var_2_1.z

		self._material:SetVector("_PosBegin", self._vectorA)
		self._material:SetVector("_PosEnd", self._vectorB)

		self._go.transform.position = self._vectorA
	else
		self._callback()
	end

	return
end

function BattleArcEffect:ConfigCallback(arg_3_1)
	self._callback = arg_3_1

	pg.EffectMgr.GetInstance():PlayBattleEffect(self._go, Vector3.zero, true, self._callback)

	return
end

function BattleArcEffect:Dispose()
	self._callback = nil
	self._material = nil
	self._go = nil
	self._unitA = nil
	self._unitB = nil
	self._vectorA = nil
	self._vectorB = nil

	return
end

return
