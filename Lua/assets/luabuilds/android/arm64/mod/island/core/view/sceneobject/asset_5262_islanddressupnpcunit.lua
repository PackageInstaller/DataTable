local IslandDressupNpcUnit = class("IslandDressupNpcUnit", import(".IslandNpcUnit"))

function IslandDressupNpcUnit:Ctor(arg_1_1, arg_1_2)
	IslandDressupNpcUnit.super.Ctor(self, arg_1_1, arg_1_2)

	return
end

function IslandDressupNpcUnit:SetShipDressHelper(arg_2_1)
	self.shipDressHelper = arg_2_1

	return
end

function IslandDressupNpcUnit:OnDetach()
	if self.shipDressHelper then
		self.shipDressHelper:Destroy()
	end

	return
end

function IslandDressupNpcUnit:OnCharacterChangeDress(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 then
		local var_4_0 = {}

		local function var_4_1()
			self._animator = self._tf:GetChild(0):GetComponent(typeof(Animator))

			for iter_5_0, iter_5_1 in ipairs(var_4_0) do
				self._animator:Play(iter_5_1.shortNameHash, iter_5_0 - 1, iter_5_1.normalizedTime)
			end

			self._tf:GetComponent(typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner)):StartBehaviour()

			return
		end

		self._tf:GetComponent(typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner)):PauseBehaviour()

		normalizedTime = self._animator:GetCurrentAnimatorStateInfo(0).normalizedTime % 1

		for iter_4_0 = 1, self._animator.layerCount do
			local var_4_2 = self._animator:GetCurrentAnimatorStateInfo(iter_4_0 - 1)

			table.insert(var_4_0, {
				shortNameHash = var_4_2.shortNameHash,
				normalizedTime = var_4_2.normalizedTime
			})
		end

		self:DestroyInteractiveTools()

		self._animator = nil

		if #arg_4_2 == 0 and #arg_4_3 == 0 then
			self.shipDressHelper:ChangeModelTransfromByUnitId(arg_4_1, var_4_1)
		else
			self.shipDressHelper:ChangeModelTransfromByUnitIdAndChangeDress(arg_4_1, arg_4_2, arg_4_3, var_4_1)
		end
	else
		for iter_4_1, iter_4_2 in ipairs(arg_4_2) do
			self.shipDressHelper:ChangeDressByType(pg.island_dress_template[iter_4_2].type, {
				id = 0,
				colorId = 0
			})
		end

		for iter_4_3, iter_4_4 in ipairs(arg_4_3) do
			self.shipDressHelper:ChangeDressByType(pg.island_dress_template[iter_4_4].type, {
				colorId = 0,
				id = iter_4_4
			})
		end
	end

	return
end

return IslandDressupNpcUnit
