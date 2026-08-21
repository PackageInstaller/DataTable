local var_0_0 = class("IslandSceneUnit", import("..IslandBaseUnit"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)
	assert(arg_1_2.id)

	arg_1_0.id = arg_1_2.id
	arg_1_0.modelId = arg_1_2.modelId or 0
	arg_1_0.name = arg_1_2.name or ""
	arg_1_0.position = arg_1_2.position or Vector3.zero
	arg_1_0.rotation = arg_1_2.rotation or Vector3.zero
	arg_1_0.data = arg_1_2
	arg_1_0.active = true
	arg_1_0.unitType = nil

	return
end

function var_0_0.IsSelf(arg_2_0, arg_2_1)
	return arg_2_0:GetUnitType() == arg_2_1:GetUnitType() and arg_2_0.id == arg_2_1.id
end

function var_0_0.GetDataVO(arg_3_0)
	return arg_3_0.data
end

function var_0_0.ResetPosition(arg_4_0)
	arg_4_0._go.transform.position = arg_4_0.position
	arg_4_0._go.transform.eulerAngles = arg_4_0.rotation

	return
end

function var_0_0.GetPosition(arg_5_0)
	return arg_5_0._go.transform.position
end

function var_0_0.OnInit(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._go = arg_6_1
	arg_6_0._tf = arg_6_1.transform
	arg_6_0.builder = arg_6_2

	local var_6_0 = arg_6_0.builder and arg_6_0._go

	assert(var_6_0)
	SetParent(arg_6_0._go, arg_6_0:GetView().root)

	arg_6_0._go.name = arg_6_0.name
	arg_6_0.behaviourTreeOwner = arg_6_0._go:GetComponent(typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner))

	arg_6_0:OnAttach(arg_6_1)
	arg_6_0:ResetPosition()
	arg_6_0:OnLaterAttach(arg_6_1)
	arg_6_0:ResetPosition()

	if arg_6_0:GetView():IsInit() then
		arg_6_0:Start()
	end

	return
end

function var_0_0.OnAnomalyInit(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:Recycle(arg_7_0.data, arg_7_1)

	return
end

function var_0_0.SetUnitType(arg_8_0, arg_8_1)
	arg_8_0.unitType = arg_8_1

	return
end

function var_0_0.GetUnitType(arg_9_0)
	return arg_9_0.unitType
end

function var_0_0.Start(arg_10_0)
	arg_10_0:SetupBt()
	arg_10_0:OnStart()

	return
end

function var_0_0.IsMapTransfer(arg_11_0)
	if not arg_11_0.behaviourTreeOwner then
		return false, {}
	end

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs((IslandHelper.GetAllShowInteractionsTypeValue(arg_11_0.behaviourTreeOwner):ToTable())) do
		local var_11_1 = pg.island_interaction.get_id_list_by_groupId[iter_11_1] or {}

		for iter_11_2, iter_11_3 in ipairs(var_11_1) do
			if pg.island_interaction[iter_11_3].type == IslandInteractionUntil.TYPE_TRANSFER or pg.island_interaction[iter_11_3].type == IslandInteractionUntil.TYPE_SP_TRANSFER then
				table.insert(var_11_0, iter_11_3)
			end
		end
	end

	return #var_11_0 > 0, var_11_0
end

function var_0_0.OnDispose(arg_12_0)
	arg_12_0:OnDetach()
	arg_12_0:ClearBt()
	arg_12_0.builder:Recycle(arg_12_0.data, arg_12_0._go)

	arg_12_0._go = nil

	return
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)

	arg_13_0.builder = nil

	return
end

function var_0_0.SetupBt(arg_14_0)
	if not arg_14_0.behaviourTreeOwner then
		return
	end

	arg_14_0.behaviourTreeOwner:StartBehaviour()

	return
end

function var_0_0.RestartBt(arg_15_0)
	if not arg_15_0.behaviourTreeOwner then
		return
	end

	arg_15_0.behaviourTreeOwner:RestartBehaviour()

	return
end

function var_0_0.PauseBt(arg_16_0)
	if not arg_16_0.behaviourTreeOwner then
		return
	end

	arg_16_0.behaviourTreeOwner:PauseBehaviour()

	return
end

function var_0_0.StopBt(arg_17_0)
	if not arg_17_0.behaviourTreeOwner then
		return
	end

	arg_17_0.behaviourTreeOwner:StopBehaviour()

	return
end

function var_0_0.ClearBt(arg_18_0)
	arg_18_0:StopBt()

	arg_18_0.behaviourTreeOwner = nil

	return
end

function var_0_0.Enable(arg_19_0)
	if not arg_19_0:IsLoaded() then
		return
	end

	setActive(arg_19_0._go, true)
	arg_19_0:ActiveOrDisactive(true)

	return
end

function var_0_0.Disable(arg_20_0)
	if not arg_20_0:IsLoaded() then
		return
	end

	setActive(arg_20_0._go, false)
	arg_20_0:ActiveOrDisactive(false)

	return
end

function var_0_0.ActiveOrDisactive(arg_21_0, arg_21_1)
	arg_21_0.active = arg_21_1

	return
end

function var_0_0.Update(arg_22_0)
	if not arg_22_0.active then
		return
	end

	var_0_0.super.Update(arg_22_0)

	return
end

function var_0_0.IsActive(arg_23_0)
	return arg_23_0.active
end

function var_0_0.OnAttach(arg_24_0, arg_24_1)
	return
end

function var_0_0.OnLaterAttach(arg_25_0, arg_25_1)
	return
end

function var_0_0.OnStart(arg_26_0)
	return
end

function var_0_0.OnDetach(arg_27_0)
	return
end

return var_0_0
