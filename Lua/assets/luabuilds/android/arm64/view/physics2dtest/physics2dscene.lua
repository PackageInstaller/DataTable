local var_0_0 = class("Physics2dScene", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "PhysicsTest"
end

function var_0_0.init(arg_2_0)
	arg_2_0._backBtn = arg_2_0._tf:Find("back_btn")
	arg_2_0._box = arg_2_0._tf:Find("box")
	arg_2_0._boxRig = GetComponent(arg_2_0._box, "Rigidbody2D")
	arg_2_0._boxPhyItem = GetComponent(arg_2_0._box, "Physics2DItem")

	Physics2DMgr.Inst:AddSimulateItem(arg_2_0._boxPhyItem)

	arg_2_0._gizmos = arg_2_0._tf:Find("res/gizmos")

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._backBtn, function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end)

	arg_3_0._boxRig.position = arg_3_0._tf:TransformPoint(Vector3(-578, -390))

	arg_3_0._boxPhyItem.CollisionEnter:AddListener(function(arg_5_0)
		if Physics2D.autoSimulation then
			print("=========================")
			print(arg_5_0.collider.gameObject.name)
			print(arg_5_0.otherCollider.gameObject.name)

			if arg_5_0.collider.gameObject.name ~= "ground" then
				LeanTween.scale(arg_5_0.collider.gameObject, Vector3(0, 0, 0), 1)
			end
		end

		return
	end)
	onDelayTick(function()
		arg_3_0:simulateDrawPath()

		return
	end, 1)
	onDelayTick(function()
		arg_3_0:jump()

		return
	end, 3)

	return
end

function var_0_0.jump(arg_8_0)
	arg_8_0._boxRig.position = arg_8_0._tf:TransformPoint(Vector3(-578, -390))
	arg_8_0._boxRig.velocity = Vector2(10, 10)

	return
end

function var_0_0.simulateDrawPath(arg_9_0)
	Physics2DMgr.Inst:DoPrediction(0.1, 50, function()
		arg_9_0:jump()

		return
	end, function()
		local var_11_0 = instantiate(arg_9_0._gizmos)

		setParent(tf(var_11_0), arg_9_0._tf, false)
		setAnchoredPosition(var_11_0, arg_9_0._tf:InverseTransformVector(arg_9_0._boxRig.position))

		return
	end)

	return
end

function var_0_0.willExit(arg_12_0)
	Physics2DMgr.Inst:RemoveSimulateItem(arg_12_0._boxPhyItem)
	arg_12_0._boxPhyItem.CollisionEnter:RemoveAllListeners()

	return
end

return var_0_0
