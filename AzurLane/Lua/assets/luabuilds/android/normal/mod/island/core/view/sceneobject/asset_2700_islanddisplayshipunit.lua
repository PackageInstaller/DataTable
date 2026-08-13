class = var_0_10000

local var_0_0 = var_0_10000("IslandDisplayShipUnit")
local var_0_1 = 2

function var_0_0.OnAttach(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.toolContainer = arg_1_2
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_0._go.transform

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.GetChild(var_1_0, 0)
	local var_1_2 = var_3.GetComponent

	typeof = var_5
	Animator = var_1_10006
	arg_1_0.animator = var_1_2(var_1_1, var_5(var_1_10006))
	GetOrAddComponent = var_3

	local var_1_3 = arg_1_0._go

	typeof = var_5
	CharacterHandleController = var_1_10006
	arg_1_0.characterHandleController = var_3(var_1_3, var_5(var_1_10006))

	local var_1_4 = arg_1_0.characterHandleController

	var_3.AddStateEnterFunc(var_1_4, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0

		var_2.StateEnterHandle(var_2_0, arg_2_0, arg_2_1)

		return
	end)

	local var_1_5 = arg_1_0.characterHandleController

	var_3.AddStateExitFunc(var_1_5, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0

		var_2.StateExitHandle(var_3_0, arg_3_0, arg_3_1)

		return
	end)

	local var_1_6 = arg_1_0.characterHandleController

	var_3.AddStateEnterFixCompleteFunc(var_1_6, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0

		var_2.StateEnterFixHandle(var_4_0, arg_4_0, arg_4_1)

		return
	end)

	local var_1_7 = arg_1_0.characterHandleController

	var_3.AddStateExitFixCompleteFunc(var_1_7, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0

		var_2.StateExitFixHandle(var_5_0, arg_5_0, arg_5_1)

		return
	end)

	arg_1_0.objTfList = {}
	arg_1_0.toolIdMap = {}

	return
end

function var_0_0.LoadInteractiveTool(arg_6_0, arg_6_1)
	arg_6_0.toolId = arg_6_1
	IslandAnimationAttachmentHelper = var_1_10002
	arg_6_0.currentToolId = var_1_10002.ResolveId(arg_6_0.animator, arg_6_0.toolId)
	arg_6_0.toolIdMap[arg_6_1] = arg_6_0.currentToolId

	local var_6_0 = arg_6_0.objTfList[arg_6_0.currentToolId]

	IsNil = var_3

	local var_6_1

	if not var_3(var_6_0) then
		setActive = var_6_1

		var_6_1(var_6_0, true)

		setParent = var_6_1

		var_6_1(var_6_0, arg_6_0._tf)

		pg = var_6_1
		var_6_1 = var_6_1.ViewUtils.SetLayer

		local var_6_2 = var_6_0

		Layer = var_5

		var_6_1(var_6_2, var_5.Character3D)

		return
	end

	pg = var_6_1

	local var_6_3 = var_6_1.island_animation_attachments[arg_6_0.currentToolId]

	LoadAny = var_4

	local var_6_4 = var_4(var_6_3.model, nil)

	Object = var_5

	local var_6_5 = var_5.Instantiate(var_6_4)
	local var_6_6 = arg_6_0.objTfList

	var_6_6[arg_6_0.currentToolId] = var_6_5.transform
	LoadAny = var_6_6

	local var_6_7 = var_6_3.animator
	local var_6_8

	typeof = var_1_10009
	RuntimeAnimatorController = var_1_10010

	local var_6_9 = var_6_6(var_6_7, var_6_8, var_1_10009(var_1_10010))

	GetOrAddComponent = var_6_7

	local var_6_10 = arg_6_0.objTfList[arg_6_0.currentToolId]

	typeof = var_9
	Animator = var_1_10010
	var_6_7(var_6_10, var_9(var_1_10010)).runtimeAnimatorController = var_6_9
	setParent = var_6_10

	var_6_10(arg_6_0.objTfList[arg_6_0.currentToolId], arg_6_0._tf)

	pg = var_6_10

	local var_6_11 = var_6_10.ViewUtils.SetLayer
	local var_6_12 = arg_6_0.objTfList[arg_6_0.currentToolId]

	Layer = var_10

	var_6_11(var_6_12, var_10.Character3D)

	return
end

function var_0_0.UnLoadInteractiveTool(arg_7_0, arg_7_1)
	local var_7_0

	if not arg_7_0.toolIdMap[arg_7_1] and not arg_7_0.currentToolId then
		IslandAnimationAttachmentHelper = var_7_0
		var_7_0 = var_7_0.ResolveId(arg_7_0.animator, arg_7_1)
	end

	if arg_7_0.objTfList[var_7_0] then
		setActive = var_1_10004

		var_1_10004(var_3, false)

		setParent = var_1_10004

		var_1_10004(var_3, arg_7_0.toolContainer)
	end

	return
end

function var_0_0.StateEnterHandle(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == var_0_1 then
		arg_8_0:LoadInteractiveTool(arg_8_2)
	end

	return
end

function var_0_0.StateEnterFixHandle(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0

	if not arg_9_0.toolIdMap[arg_9_2] then
		var_9_0 = arg_9_0.currentToolId
	end

	if arg_9_1 == var_0_1 and var_9_0 and arg_9_0.objTfList[var_9_0] then
		pg = var_4

		local var_9_1 = var_4.ViewUtils.SetLayer
		local var_9_2 = arg_9_0.objTfList[var_9_0]

		Layer = var_1_10006

		var_9_1(var_9_2, var_1_10006.Character3D)
	end

	return
end

function var_0_0.StateExitFixHandle(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if not arg_10_0.toolIdMap[arg_10_2] then
		var_10_0 = arg_10_0.currentToolId
	end

	if arg_10_1 == var_0_1 and var_10_0 and arg_10_0.objTfList[var_10_0] then
		pg = var_4

		local var_10_1 = var_4.ViewUtils.SetLayer
		local var_10_2 = arg_10_0.objTfList[var_10_0]

		Layer = var_1_10006

		var_10_1(var_10_2, var_1_10006.Default)
	end

	return
end

function var_0_0.StateExitHandle(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == var_0_1 then
		arg_11_0:UnLoadInteractiveTool(arg_11_2)
	end

	return
end

function var_0_0.OnClearItemAnimator(arg_12_0)
	if arg_12_0.toolId then
		arg_12_0:UnLoadInteractiveTool(arg_12_0.toolId)
	end

	return
end

function var_0_0.ClearAnimationTools(arg_13_0)
	pairs = var_1_10001

	local var_13_0

	if not arg_13_0.objTfList then
		var_13_0 = {}
	end

	for iter_13_0, iter_13_1 in var_1_10001(var_13_0) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_13_1.gameObject)
	end

	arg_13_0.objTfList = {}

	return
end

function var_0_0.OnDetach(arg_14_0)
	arg_14_0:ClearAnimationTools()

	local var_14_0 = arg_14_0.characterHandleController

	var_1.AddStateEnterFunc(var_14_0, nil)

	local var_14_1 = arg_14_0.characterHandleController

	var_1.AddStateExitFunc(var_14_1, nil)

	local var_14_2 = arg_14_0.characterHandleController

	var_1.AddStateEnterFixCompleteFunc(var_14_2, nil)

	local var_14_3 = arg_14_0.characterHandleController

	var_1.AddStateExitFixCompleteFunc(var_14_3, nil)

	arg_14_0._go = nil
	arg_14_0._tf = nil
	arg_14_0.objTfList = nil
	arg_14_0.characterHandleController = nil

	return
end

return var_0_0
