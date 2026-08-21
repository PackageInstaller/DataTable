ys = ys or {}

local var_0_2 = class("BattleArcEffect")

ys.Battle.BattleArcEffect = var_0_2
var_0_2.__name = "BattleArcEffect"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._go = arg_1_1
	arg_1_0._characterA = arg_1_2
	arg_1_0._unitA = arg_1_2:GetUnitData()
	arg_1_0._unitB = arg_1_3
	arg_1_0._boundBone = arg_1_4
	arg_1_0._material = arg_1_0._go.transform:GetComponent(typeof(Renderer)).material

	local var_1_0 = arg_1_0._characterA:GetBonePos(arg_1_0._boundBone)
	local var_1_1 = arg_1_0._unitB:GetPosition()

	arg_1_0._vectorA = Vector4.New(var_1_0.x, 5, var_1_0.z, 1)
	arg_1_0._vectorB = Vector4.New(var_1_1.x, 5, var_1_1.z, 1)

	arg_1_0._material:SetVector("_PosBegin", arg_1_0._vectorA)
	arg_1_0._material:SetVector("_PosEnd", arg_1_0._vectorB)

	return
end

function var_0_2.Update(arg_2_0)
	if arg_2_0._unitA:IsAlive() and arg_2_0._unitB:IsAlive() then
		local var_2_0 = arg_2_0._characterA:GetBonePos(arg_2_0._boundBone)
		local var_2_1 = arg_2_0._unitB:GetPosition()

		arg_2_0._vectorA.x = var_2_0.x
		arg_2_0._vectorA.z = var_2_0.z
		arg_2_0._vectorB.x = var_2_1.x
		arg_2_0._vectorB.z = var_2_1.z

		arg_2_0._material:SetVector("_PosBegin", arg_2_0._vectorA)
		arg_2_0._material:SetVector("_PosEnd", arg_2_0._vectorB)

		arg_2_0._go.transform.position = arg_2_0._vectorA
	else
		arg_2_0._callback()
	end

	return
end

function var_0_2.ConfigCallback(arg_3_0, arg_3_1)
	arg_3_0._callback = arg_3_1

	pg.EffectMgr.GetInstance():PlayBattleEffect(arg_3_0._go, Vector3.zero, true, arg_3_0._callback)

	return
end

function var_0_2.Dispose(arg_4_0)
	arg_4_0._callback = nil
	arg_4_0._material = nil
	arg_4_0._go = nil
	arg_4_0._unitA = nil
	arg_4_0._unitB = nil
	arg_4_0._vectorA = nil
	arg_4_0._vectorB = nil

	return
end

return
