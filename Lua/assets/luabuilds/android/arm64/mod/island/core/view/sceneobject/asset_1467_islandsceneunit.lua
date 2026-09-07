local IslandSceneUnit = class("IslandSceneUnit", import("..IslandBaseUnit"))

function IslandSceneUnit:Ctor(arg_1_1, arg_1_2)
	IslandSceneUnit.super.Ctor(self, arg_1_1)
	assert(arg_1_2.id)

	self.id = arg_1_2.id
	self.modelId = arg_1_2.modelId or 0
	self.name = arg_1_2.name or ""
	self.position = arg_1_2.position or Vector3.zero
	self.rotation = arg_1_2.rotation or Vector3.zero
	self.data = arg_1_2
	self.active = true
	self.unitType = nil

	return
end

function IslandSceneUnit:IsSelf(arg_2_1)
	return self:GetUnitType() == arg_2_1:GetUnitType() and self.id == arg_2_1.id
end

function IslandSceneUnit:GetDataVO()
	return self.data
end

function IslandSceneUnit:ResetPosition()
	self._go.transform.position = self.position
	self._go.transform.eulerAngles = self.rotation

	return
end

function IslandSceneUnit:GetPosition()
	return self._go.transform.position
end

function IslandSceneUnit:OnInit(arg_6_1, arg_6_2)
	self._go = arg_6_1
	self._tf = arg_6_1.transform
	self.builder = arg_6_2

	assert(self.builder and self._go)
	SetParent(self._go, self:GetView().root)

	self._go.name = self.name
	self.behaviourTreeOwner = self._go:GetComponent(typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner))

	self:OnAttach(arg_6_1)
	self:ResetPosition()
	self:OnLaterAttach(arg_6_1)
	self:ResetPosition()

	if self:GetView():IsInit() then
		self:Start()
	end

	return
end

function IslandSceneUnit:OnAnomalyInit(arg_7_1, arg_7_2)
	arg_7_2:Recycle(self.data, arg_7_1)

	return
end

function IslandSceneUnit:SetUnitType(arg_8_1)
	self.unitType = arg_8_1

	return
end

function IslandSceneUnit:GetUnitType()
	return self.unitType
end

function IslandSceneUnit:Start()
	self:SetupBt()
	self:OnStart()

	return
end

function IslandSceneUnit:IsMapTransfer()
	if not self.behaviourTreeOwner then
		return false, {}
	end

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs((IslandHelper.GetAllShowInteractionsTypeValue(self.behaviourTreeOwner):ToTable())) do
		for iter_11_2, iter_11_3 in ipairs(pg.island_interaction.get_id_list_by_groupId[iter_11_1] or {}) do
			if pg.island_interaction[iter_11_3].type == IslandInteractionUntil.TYPE_TRANSFER or pg.island_interaction[iter_11_3].type == IslandInteractionUntil.TYPE_SP_TRANSFER then
				table.insert(var_11_0, iter_11_3)
			end
		end
	end

	return #var_11_0 > 0, var_11_0
end

function IslandSceneUnit:OnDispose()
	self:OnDetach()
	self:ClearBt()
	self.builder:Recycle(self.data, self._go)

	self._go = nil

	return
end

function IslandSceneUnit:Dispose()
	IslandSceneUnit.super.Dispose(self)

	self.builder = nil

	return
end

function IslandSceneUnit:SetupBt()
	if not self.behaviourTreeOwner then
		return
	end

	self.behaviourTreeOwner:StartBehaviour()

	return
end

function IslandSceneUnit:RestartBt()
	if not self.behaviourTreeOwner then
		return
	end

	self.behaviourTreeOwner:RestartBehaviour()

	return
end

function IslandSceneUnit:PauseBt()
	if not self.behaviourTreeOwner then
		return
	end

	self.behaviourTreeOwner:PauseBehaviour()

	return
end

function IslandSceneUnit:StopBt()
	if not self.behaviourTreeOwner then
		return
	end

	self.behaviourTreeOwner:StopBehaviour()

	return
end

function IslandSceneUnit:ClearBt()
	self:StopBt()

	self.behaviourTreeOwner = nil

	return
end

function IslandSceneUnit:Enable()
	if not self:IsLoaded() then
		return
	end

	setActive(self._go, true)
	self:ActiveOrDisactive(true)

	return
end

function IslandSceneUnit:Disable()
	if not self:IsLoaded() then
		return
	end

	setActive(self._go, false)
	self:ActiveOrDisactive(false)

	return
end

function IslandSceneUnit:ActiveOrDisactive(arg_21_1)
	self.active = arg_21_1

	return
end

function IslandSceneUnit:Update()
	if not self.active then
		return
	end

	IslandSceneUnit.super.Update(self)

	return
end

function IslandSceneUnit:IsActive()
	return self.active
end

function IslandSceneUnit:OnAttach(arg_24_1)
	return
end

function IslandSceneUnit:OnLaterAttach(arg_25_1)
	return
end

function IslandSceneUnit:OnStart()
	return
end

function IslandSceneUnit:OnDetach()
	return
end

return IslandSceneUnit
