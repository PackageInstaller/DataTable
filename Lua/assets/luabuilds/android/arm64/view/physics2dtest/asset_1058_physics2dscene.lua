local Physics2dScene = class("Physics2dScene", import("..base.BaseUI"))

function Physics2dScene:getUIName()
	return "PhysicsTest"
end

function Physics2dScene:init()
	self._backBtn = self._tf:Find("back_btn")
	self._box = self._tf:Find("box")
	self._boxRig = GetComponent(self._box, "Rigidbody2D")
	self._boxPhyItem = GetComponent(self._box, "Physics2DItem")

	Physics2DMgr.Inst:AddSimulateItem(self._boxPhyItem)

	self._gizmos = self._tf:Find("res/gizmos")

	return
end

function Physics2dScene:didEnter()
	onButton(self, self._backBtn, function()
		self:emit(Physics2dScene.ON_BACK)

		return
	end)

	self._boxRig.position = self._tf:TransformPoint(Vector3(-578, -390))

	self._boxPhyItem.CollisionEnter:AddListener(function(arg_5_0)
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
		self:simulateDrawPath()

		return
	end, 1)
	onDelayTick(function()
		self:jump()

		return
	end, 3)

	return
end

function Physics2dScene:jump()
	self._boxRig.position = self._tf:TransformPoint(Vector3(-578, -390))
	self._boxRig.velocity = Vector2(10, 10)

	return
end

function Physics2dScene:simulateDrawPath()
	Physics2DMgr.Inst:DoPrediction(0.1, 50, function()
		self:jump()

		return
	end, function()
		local var_11_0 = instantiate(self._gizmos)

		setParent(tf(var_11_0), self._tf, false)
		setAnchoredPosition(var_11_0, self._tf:InverseTransformVector(self._boxRig.position))

		return
	end)

	return
end

function Physics2dScene:willExit()
	Physics2DMgr.Inst:RemoveSimulateItem(self._boxPhyItem)
	self._boxPhyItem.CollisionEnter:RemoveAllListeners()

	return
end

return Physics2dScene
