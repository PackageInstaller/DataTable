class = var_0_10000

local var_0_0 = "Physics2dScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "PhysicsTest"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0._backBtn = var_1.Find(var_2_0, "back_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0._box = var_1.Find(var_2_1, "box")
	GetComponent = var_1
	arg_2_0._boxRig = var_1(arg_2_0._box, "Rigidbody2D")
	GetComponent = var_1
	arg_2_0._boxPhyItem = var_1(arg_2_0._box, "Physics2DItem")
	Physics2DMgr = var_1

	local var_2_2 = var_1.Inst

	var_1.AddSimulateItem(var_2_2, arg_2_0._boxPhyItem)

	local var_2_3 = arg_2_0._tf

	arg_2_0._gizmos = var_1.Find(var_2_3, "res/gizmos")

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0._backBtn, function()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK)

		return
	end)

	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.TransformPoint

	Vector3 = var_3

	local var_3_2 = var_3_1(var_3_0, var_3(-578, -390))

	arg_3_0._boxRig.position = var_3_2

	local var_3_3 = arg_3_0._boxPhyItem.CollisionEnter

	var_2.AddListener(var_3_3, function(arg_5_0)
		Physics2D = var_2_10001

		if var_2_10001.autoSimulation then
			print = var_1

			var_1("=========================")

			print = var_1

			var_1(arg_5_0.collider.gameObject.name)

			print = var_1

			var_1(arg_5_0.otherCollider.gameObject.name)

			if arg_5_0.collider.gameObject.name ~= "ground" then
				LeanTween = var_1

				local var_5_0 = var_1.scale
				local var_5_1 = arg_5_0.collider.gameObject

				Vector3 = var_2_10003

				var_5_0(var_5_1, var_2_10003(0, 0, 0), 1)
			end
		end

		return
	end)

	onDelayTick = var_2

	var_2(function()
		local var_6_0 = arg_3_0

		var_0.simulateDrawPath(var_6_0)

		return
	end, 1)

	onDelayTick = var_2

	var_2(function()
		local var_7_0 = arg_3_0

		var_0.jump(var_7_0)

		return
	end, 3)

	return
end

function var_0_1.jump(arg_8_0)
	local var_8_0 = arg_8_0._tf
	local var_8_1 = var_1.TransformPoint

	Vector3 = var_1_10003

	local var_8_2 = var_8_1(var_8_0, var_1_10003(-578, -390))

	arg_8_0._boxRig.position = var_8_2

	local var_8_3 = arg_8_0._boxRig

	Vector2 = var_3
	var_8_3.velocity = var_3(10, 10)

	return
end

function var_0_1.simulateDrawPath(arg_9_0)
	Physics2DMgr = var_1_10001

	local var_9_0 = var_1_10001.Inst

	var_1.DoPrediction(var_9_0, 0.1, 50, function()
		local var_10_0 = arg_9_0

		var_0.jump(var_10_0)

		return
	end, function()
		instantiate = var_2_10000

		local var_11_0 = var_2_10000(arg_9_0._gizmos)

		setParent = var_1
		tf = var_2_10002

		var_1(var_2_10002(var_11_0), arg_9_0._tf, false)

		setAnchoredPosition = var_1

		local var_11_1 = var_11_0
		local var_11_2 = arg_9_0._tf

		var_1(var_11_1, var_3.InverseTransformVector(var_11_2, arg_9_0._boxRig.position))

		return
	end)

	return
end

function var_0_1.willExit(arg_12_0)
	Physics2DMgr = var_1_10001

	local var_12_0 = var_1_10001.Inst

	var_1.RemoveSimulateItem(var_12_0, arg_12_0._boxPhyItem)

	local var_12_1 = arg_12_0._boxPhyItem.CollisionEnter

	var_1.RemoveAllListeners(var_12_1)

	return
end

return var_0_1
