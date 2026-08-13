ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleResourceManager
local var_0_2 = var_0.Battle

singletonClass = var_0_10003
var_0_2.BattleCharacterFXContainersPool = var_0_10003("BattleCharacterFXContainersPool")
var_0.Battle.BattleCharacterFXContainersPool.__name = "BattleCharacterFXContainersPool"

local var_0_3 = var_0.Battle.BattleCharacterFXContainersPool

function var_0_3.Ctor(arg_1_0)
	return
end

function var_0_3.Init(arg_2_0)
	arg_2_0._pool = {}
	GameObject = var_1
	arg_2_0._templateContainer = var_1("characterFXContainerPoolParent")
	arg_2_0._templateContainerTf = arg_2_0._templateContainer.transform

	local var_2_0 = arg_2_0._templateContainerTf

	Vector3 = var_1_10002
	var_2_0.position = var_1_10002(-10000, -10000, 0)

	return
end

function var_0_3.Pop(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1.localEulerAngles

	arg_3_2 = arg_3_2 or {
		{
			0,
			0,
			0
		},
		{
			0,
			0,
			0
		},
		{
			0,
			0,
			0
		},
		{
			0,
			0,
			0
		}
	}

	local var_3_1

	if #arg_3_0._pool == 0 then
		var_3_1 = {}
		ipairs = var_5

		for iter_3_0, iter_3_1 in var_5(var_0.Battle.BattleConst.FXContainerIndex) do
			GameObject = var_1_10010

			local var_3_2 = var_1_10010().transform
			local var_3_3 = arg_3_2[iter_3_0]

			var_3_2:SetParent(arg_3_1, false)

			Vector3 = var_13
			var_3_2.localPosition = var_13(var_3_3[1], var_3_3[2], var_3_3[3])
			Vector3 = var_13
			var_3_2.localEulerAngles = var_13(var_3_0.x * -1, var_3_0.y, var_3_0.z)
			var_1_10010.name = "fxContainer_" .. iter_3_1
			var_3_1[iter_3_0] = var_1_10010
		end
	else
		var_3_1 = arg_3_0._pool[#arg_3_0._pool]

		local var_3_4 = arg_3_0._pool

		var_3_4[#arg_3_0._pool] = nil
		ipairs = var_3_4

		for iter_3_2, iter_3_3 in var_3_4(var_3_1) do
			local var_3_5 = arg_3_2[iter_3_2]
			local var_3_6 = iter_3_3.transform

			var_11.SetParent(var_3_6, arg_3_1, false)

			Vector3 = var_12
			var_11.localPosition = var_12(var_3_5[1], var_3_5[2], var_3_5[3])
			Vector3 = var_12
			var_11.localEulerAngles = var_12(var_3_0.x * -1, var_3_0.y, var_3_0.z)
		end
	end

	return var_3_1
end

function var_0_3.Push(arg_4_0, arg_4_1)
	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_1) do
		local var_4_0 = iter_4_1.transform

		var_7.SetParent(var_4_0, arg_4_0._templateContainerTf, false)

		for iter_4_2 = var_7.childCount - 1, 0, -1 do
			local var_4_1 = var_0_1.GetInstance()

			var_13.DestroyOb(var_4_1, var_7:GetChild(iter_4_2).gameObject)
		end
	end

	arg_4_0._pool[#arg_4_0._pool + 1] = arg_4_1

	return
end

function var_0_3.Clear(arg_5_0)
	ipairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0._pool) do
		ipairs = var_1_10006

		for iter_5_2, iter_5_3 in var_1_10006(iter_5_1) do
			Object = var_1_10011

			var_1_10011.Destroy(iter_5_3)
		end
	end

	arg_5_0._pool = nil
	Object = var_1

	var_1.Destroy(arg_5_0._templateContainer)

	arg_5_0._templateContainer = nil
	arg_5_0._templateContainerTf = nil

	return
end

return
