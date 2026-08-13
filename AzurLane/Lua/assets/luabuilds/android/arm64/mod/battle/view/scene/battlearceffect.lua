ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleArcEffect")

var_0.Battle.BattleArcEffect = var_0_3
var_0_3.__name = "BattleArcEffect"

function var_0_3.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._go = arg_1_1
	arg_1_0._characterA = arg_1_2
	arg_1_0._unitA = arg_1_2:GetUnitData()
	arg_1_0._unitB = arg_1_3
	arg_1_0._boundBone = arg_1_4

	local var_1_0 = arg_1_0._go.transform
	local var_1_1 = var_5.GetComponent

	typeof = var_1_10008
	Renderer = var_1_10010
	arg_1_0._material = var_1_1(var_1_0, var_1_10008(var_1_10010)).material

	local var_1_2 = arg_1_0._characterA
	local var_1_3 = var_5.GetBonePos(var_1_2, arg_1_0._boundBone)
	local var_1_4 = arg_1_0._unitB
	local var_1_5 = var_6.GetPosition(var_1_4)

	Vector4 = var_1_2
	arg_1_0._vectorA = var_1_2.New(var_1_3.x, 5, var_1_3.z, 1)
	Vector4 = var_7
	arg_1_0._vectorB = var_7.New(var_1_5.x, 5, var_1_5.z, 1)

	local var_1_6 = arg_1_0._material

	var_7.SetVector(var_1_6, "_PosBegin", arg_1_0._vectorA)

	local var_1_7 = arg_1_0._material

	var_7.SetVector(var_1_7, "_PosEnd", arg_1_0._vectorB)

	return
end

function var_0_3.Update(arg_2_0)
	local var_2_0 = arg_2_0._unitA

	if var_1.IsAlive(var_2_0) then
		local var_2_1 = arg_2_0._unitB

		if var_1.IsAlive(var_2_1) then
			local var_2_2 = arg_2_0._characterA
			local var_2_3 = var_1.GetBonePos(var_2_2, arg_2_0._boundBone)
			local var_2_4 = arg_2_0._unitB
			local var_2_5 = var_2.GetPosition(var_2_4)

			arg_2_0._vectorA.x = var_2_3.x
			arg_2_0._vectorA.z = var_2_3.z
			arg_2_0._vectorB.x = var_2_5.x
			arg_2_0._vectorB.z = var_2_5.z

			local var_2_6 = arg_2_0._material

			var_3.SetVector(var_2_6, "_PosBegin", arg_2_0._vectorA)

			local var_2_7 = arg_2_0._material

			var_3.SetVector(var_2_7, "_PosEnd", arg_2_0._vectorB)

			arg_2_0._go.transform.position = arg_2_0._vectorA

			goto label_2_0
		end
	end

	arg_2_0._callback()

	::label_2_0::

	return
end

function var_0_3.ConfigCallback(arg_3_0, arg_3_1)
	arg_3_0._callback = arg_3_1
	pg = var_1_10002

	local var_3_0 = var_1_10002.EffectMgr.GetInstance()
	local var_3_1 = var_2.PlayBattleEffect
	local var_3_2 = arg_3_0._go

	Vector3 = var_1_10006

	var_3_1(var_3_0, var_3_2, var_1_10006.zero, true, arg_3_0._callback)

	return
end

function var_0_3.Dispose(arg_4_0)
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
