class = var_0_10000

local var_0_0 = "IslandNpcUnit"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandNavigableUnit"))
local var_0_2 = {
	JumpHandle = 1,
	LoadToolHandle = 2
}

function var_0_1.OnAttach(arg_1_0, arg_1_1)
	var_0_1.super.OnAttach(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0._go
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	CharacterHandleController = var_1_10007
	arg_1_0.characterHandleController = var_1_1(var_1_0, var_5(var_1_10007))

	local var_1_2 = arg_1_0.characterHandleController

	var_2.AddStateEnterFunc(var_1_2, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0

		var_2.StateEnterHandle(var_2_0, arg_2_0, arg_2_1)

		return
	end)

	local var_1_3 = arg_1_0.characterHandleController

	var_2.AddStateExitFunc(var_1_3, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0

		var_2.StateExitHandle(var_3_0, arg_3_0, arg_3_1)

		return
	end)

	local var_1_4 = arg_1_0.characterHandleController

	var_2.AddStateEnterFixCompleteFunc(var_1_4, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0

		var_2.StateEnterFixHandle(var_4_0, arg_4_0, arg_4_1)

		return
	end)

	local var_1_5 = arg_1_0.characterHandleController

	var_2.AddStateExitFixCompleteFunc(var_1_5, function(arg_5_0, arg_5_1)
		return
	end)

	arg_1_0.objTfList = {}
	arg_1_0.toolIdMap = {}

	if arg_1_0.behaviourTreeOwner then
		local var_1_6 = arg_1_0:GetDataVO()
		local var_1_7, var_1_8 = var_2.GetPersonality(var_1_6)

		LuaHelper = var_1_6

		var_1_6.NodeCanvasSetIntVariableValue(arg_1_0.behaviourTreeOwner, "personality", var_1_7)

		LuaHelper = var_4

		var_4.NodeCanvasSetIntVariableValue(arg_1_0.behaviourTreeOwner, "proactive", var_1_8)
	end

	return
end

function var_0_1.StateEnterHandle(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == var_0_2.LoadToolHandle then
		arg_6_0:LoadInteractiveTool(arg_6_2)
	end

	return
end

function var_0_1.StateEnterFixHandle(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == var_0_2.LoadToolHandle then
		local var_7_0

		if not arg_7_0.toolIdMap[arg_7_2] and not arg_7_0.currentToolId then
			var_7_0 = arg_7_0:GetToolId(arg_7_2)
		end

		if var_7_0 and arg_7_0.objTfList[var_7_0] then
			pg = var_4

			local var_7_1 = var_4.ViewUtils.SetLayer
			local var_7_2 = arg_7_0.objTfList[var_7_0]

			Layer = var_1_10007

			var_7_1(var_7_2, var_1_10007.Default)
		end
	end

	return
end

function var_0_1.StateExitHandle(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == var_0_2.LoadToolHandle then
		arg_8_0:UnLoadInteractiveTool(arg_8_2)
	end

	return
end

function var_0_1.GetToolId(arg_9_0, arg_9_1)
	if arg_9_1 ~= 0 then
		return arg_9_1
	end

	return
end

function var_0_1.LoadInteractiveTool(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1

	IslandAnimationAttachmentHelper = var_1_10003

	local var_10_1 = var_1_10003.ResolveId
	local var_10_2 = arg_10_0

	arg_10_0.currentToolId = var_10_1(arg_10_0.GetAnimator(var_10_2), arg_10_1)
	arg_10_0.toolIdMap[var_10_0] = arg_10_1

	local var_10_3

	if arg_10_0.objTfList[arg_10_1] then
		setActive = var_1_10004

		var_1_10004(var_3, true)

		setParent = var_1_10004

		var_1_10004(var_3, arg_10_0._tf)

		pg = var_1_10004
		var_1_10004 = var_1_10004.ViewUtils.SetLayer
		var_10_3 = var_3
		Layer = var_10_2

		var_1_10004(var_10_3, var_10_2.UIHidden)

		return
	end

	pg = var_1_10004

	local var_10_4 = var_1_10004.island_animation_attachments[arg_10_1].model

	pg = var_10_3

	if arg_10_1 ~= var_10_3.island_set.island_manage_animation_extroversion.key_value_int then
		pg = var_6

		if arg_10_1 == var_6.island_set.island_manage_animation_introverted.key_value_int then
			local var_10_5 = arg_10_0.behaviourTreeOwner.graph.blackboard

			if var_6.GetVariable(var_10_5, "systemId").value ~= 0 then
				pg = var_10_2
				var_10_4 = var_10_2.island_manage_restaurant[var_6].performance_param
			end
		end

		LoadAny = var_6

		local var_10_6 = var_6(var_10_4, nil)

		Object = var_10_2

		local var_10_7 = var_10_2.Instantiate(var_10_6)
		local var_10_8 = arg_10_0.objTfList

		var_10_8[arg_10_1] = var_10_7.transform
		LoadAny = var_10_8

		local var_10_9 = var_4.animator
		local var_10_10

		typeof = var_1_10012
		RuntimeAnimatorController = var_1_10014

		local var_10_11 = var_10_8(var_10_9, var_10_10, var_1_10012(var_1_10014))

		GetOrAddComponent = var_9

		local var_10_12 = arg_10_0.objTfList[arg_10_1]

		typeof = var_12
		Animator = var_1_10014
		var_9(var_10_12, var_12(var_1_10014)).runtimeAnimatorController = var_10_11
		setParent = var_10_9

		var_10_9(arg_10_0.objTfList[arg_10_1], arg_10_0._tf)

		pg = var_10_9

		local var_10_13 = var_10_9.ViewUtils.SetLayer
		local var_10_14 = arg_10_0.objTfList[arg_10_1]

		Layer = var_13

		var_10_13(var_10_14, var_13.UIHidden)

		return
	end
end

function var_0_1.UnLoadInteractiveTool(arg_11_0, arg_11_1)
	if not arg_11_0.toolIdMap[arg_11_1] then
		::label_11_0::

		IslandAnimationAttachmentHelper = var_2
		arg_11_1 = var_2.ResolveId(arg_11_0:GetAnimator(), arg_11_1)
	end

	if arg_11_0.objTfList[arg_11_1] then
		setActive = var_2

		var_2(arg_11_0.objTfList[arg_11_1], false)
	end

	return
end

function var_0_1.DestroyInteractiveTools(arg_12_0)
	pairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0.objTfList) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_12_1.gameObject)
	end

	arg_12_0.objTfList = {}

	return
end

return var_0_1
