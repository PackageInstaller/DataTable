class = var_0_10000

local var_0_0 = "IslandSceneUnit"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..IslandBaseUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	assert = var_3

	var_3(arg_1_2.id)

	arg_1_0.id = arg_1_2.id

	local var_1_0

	if not arg_1_2.modelId then
		var_1_0 = 0
	end

	arg_1_0.modelId = var_1_0

	local var_1_1

	if not arg_1_2.name then
		var_1_1 = ""
	end

	arg_1_0.name = var_1_1

	local var_1_2

	if not arg_1_2.position then
		Vector3 = var_1_2
		var_1_2 = var_1_2.zero
	end

	arg_1_0.position = var_1_2

	local var_1_3

	if not arg_1_2.rotation then
		Vector3 = var_1_3
		var_1_3 = var_1_3.zero
	end

	arg_1_0.rotation = var_1_3
	arg_1_0.data = arg_1_2
	arg_1_0.active = true
	arg_1_0.unitType = nil

	return
end

function var_0_1.IsSelf(arg_2_0, arg_2_1)
	return arg_2_0:GetUnitType() == arg_2_1:GetUnitType() and arg_2_0.id == arg_2_1.id
end

function var_0_1.GetDataVO(arg_3_0)
	return arg_3_0.data
end

function var_0_1.ResetPosition(arg_4_0)
	arg_4_0._go.transform.position = arg_4_0.position
	arg_4_0._go.transform.eulerAngles = arg_4_0.rotation

	return
end

function var_0_1.GetPosition(arg_5_0)
	return arg_5_0._go.transform.position
end

function var_0_1.OnInit(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._go = arg_6_1
	arg_6_0._tf = arg_6_1.transform
	arg_6_0.builder = arg_6_2
	assert = var_3

	local var_6_0

	if arg_6_0.builder then
		var_6_0 = arg_6_0._go
	end

	var_3(var_6_0)

	SetParent = var_3

	local var_6_1 = arg_6_0._go
	local var_6_2 = arg_6_0

	var_3(var_6_1, arg_6_0.GetView(var_6_2).root)

	arg_6_0._go.name = arg_6_0.name

	local var_6_3 = arg_6_0._go
	local var_6_4 = var_3.GetComponent

	typeof = var_6
	NodeCanvas = var_6_2
	arg_6_0.behaviourTreeOwner = var_6_4(var_6_3, var_6(var_6_2.BehaviourTrees.BehaviourTreeOwner))

	arg_6_0:OnAttach(arg_6_1)
	arg_6_0:ResetPosition()
	arg_6_0:OnLaterAttach(arg_6_1)
	arg_6_0:ResetPosition()

	local var_6_5 = arg_6_0:GetView()

	if var_3.IsInit(var_6_5) then
		arg_6_0:Start()
	end

	return
end

function var_0_1.OnAnomalyInit(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:Recycle(arg_7_0.data, arg_7_1)

	return
end

function var_0_1.SetUnitType(arg_8_0, arg_8_1)
	arg_8_0.unitType = arg_8_1

	return
end

function var_0_1.GetUnitType(arg_9_0)
	return arg_9_0.unitType
end

function var_0_1.Start(arg_10_0)
	arg_10_0:SetupBt()
	arg_10_0:OnStart()

	return
end

function var_0_1.IsMapTransfer(arg_11_0)
	if not arg_11_0.behaviourTreeOwner then
		return false, {}
	end

	local var_11_0 = {}

	IslandHelper = var_1_10002

	local var_11_1 = var_1_10002.GetAllShowInteractionsTypeValue(arg_11_0.behaviourTreeOwner)
	local var_11_2 = var_2.ToTable(var_11_1)

	ipairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(var_11_2) do
		pg = var_1_10008

		if not var_1_10008.island_interaction.get_id_list_by_groupId[iter_11_1] then
			var_1_10008 = {}
		end

		ipairs = var_1_10009

		for iter_11_2, iter_11_3 in var_1_10009(var_1_10008) do
			pg = var_1_10014

			local var_11_3 = var_1_10014.island_interaction[iter_11_3].type

			IslandInteractionUntil = var_1_10016

			if var_11_3 ~= var_1_10016.TYPE_TRANSFER then
				var_11_3 = var_1_10014.type
				IslandInteractionUntil = var_1_10016

				if var_11_3 == var_1_10016.TYPE_SP_TRANSFER then
					table = var_11_3

					var_11_3.insert(var_11_0, iter_11_3)
				end
			end
		end
	end

	return #var_11_0 > 0, var_11_0
end

function var_0_1.OnDispose(arg_12_0)
	arg_12_0:OnDetach()
	arg_12_0:ClearBt()

	local var_12_0 = arg_12_0.builder

	var_1.Recycle(var_12_0, arg_12_0.data, arg_12_0._go)

	arg_12_0._go = nil

	return
end

function var_0_1.Dispose(arg_13_0)
	var_0_1.super.Dispose(arg_13_0)

	arg_13_0.builder = nil

	return
end

function var_0_1.SetupBt(arg_14_0)
	if not arg_14_0.behaviourTreeOwner then
		return
	end

	local var_14_0 = arg_14_0.behaviourTreeOwner

	var_1.StartBehaviour(var_14_0)

	return
end

function var_0_1.RestartBt(arg_15_0)
	if not arg_15_0.behaviourTreeOwner then
		return
	end

	local var_15_0 = arg_15_0.behaviourTreeOwner

	var_1.RestartBehaviour(var_15_0)

	return
end

function var_0_1.PauseBt(arg_16_0)
	if not arg_16_0.behaviourTreeOwner then
		return
	end

	local var_16_0 = arg_16_0.behaviourTreeOwner

	var_1.PauseBehaviour(var_16_0)

	return
end

function var_0_1.StopBt(arg_17_0)
	if not arg_17_0.behaviourTreeOwner then
		return
	end

	local var_17_0 = arg_17_0.behaviourTreeOwner

	var_1.StopBehaviour(var_17_0)

	return
end

function var_0_1.ClearBt(arg_18_0)
	arg_18_0:StopBt()

	arg_18_0.behaviourTreeOwner = nil

	return
end

function var_0_1.Enable(arg_19_0)
	if not arg_19_0:IsLoaded() then
		return
	end

	setActive = var_1

	var_1(arg_19_0._go, true)
	arg_19_0:ActiveOrDisactive(true)

	return
end

function var_0_1.Disable(arg_20_0)
	if not arg_20_0:IsLoaded() then
		return
	end

	setActive = var_1

	var_1(arg_20_0._go, false)
	arg_20_0:ActiveOrDisactive(false)

	return
end

function var_0_1.ActiveOrDisactive(arg_21_0, arg_21_1)
	arg_21_0.active = arg_21_1

	return
end

function var_0_1.Update(arg_22_0)
	if not arg_22_0.active then
		return
	end

	var_0_1.super.Update(arg_22_0)

	return
end

function var_0_1.IsActive(arg_23_0)
	return arg_23_0.active
end

function var_0_1.OnAttach(arg_24_0, arg_24_1)
	return
end

function var_0_1.OnLaterAttach(arg_25_0, arg_25_1)
	return
end

function var_0_1.OnStart(arg_26_0)
	return
end

function var_0_1.OnDetach(arg_27_0)
	return
end

return var_0_1
