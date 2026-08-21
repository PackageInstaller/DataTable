local var_0_0 = class("IslandDisplayShipUnit")
local var_0_1 = 2

function var_0_0.OnAttach(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.toolContainer = arg_1_2
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_0._go.transform
	arg_1_0.animator = arg_1_0._tf:GetChild(0):GetComponent(typeof(Animator))
	arg_1_0.characterHandleController = GetOrAddComponent(arg_1_0._go, typeof(CharacterHandleController))

	arg_1_0.characterHandleController:AddStateEnterFunc(function(arg_2_0, arg_2_1)
		arg_1_0:StateEnterHandle(arg_2_0, arg_2_1)

		return
	end)
	arg_1_0.characterHandleController:AddStateExitFunc(function(arg_3_0, arg_3_1)
		arg_1_0:StateExitHandle(arg_3_0, arg_3_1)

		return
	end)
	arg_1_0.characterHandleController:AddStateEnterFixCompleteFunc(function(arg_4_0, arg_4_1)
		arg_1_0:StateEnterFixHandle(arg_4_0, arg_4_1)

		return
	end)
	arg_1_0.characterHandleController:AddStateExitFixCompleteFunc(function(arg_5_0, arg_5_1)
		arg_1_0:StateExitFixHandle(arg_5_0, arg_5_1)

		return
	end)

	arg_1_0.objTfList = {}
	arg_1_0.toolIdMap = {}

	return
end

function var_0_0.LoadInteractiveTool(arg_6_0, arg_6_1)
	arg_6_0.toolId = arg_6_1
	arg_6_0.currentToolId = IslandAnimationAttachmentHelper.ResolveId(arg_6_0.animator, arg_6_0.toolId)
	arg_6_0.toolIdMap[arg_6_1] = arg_6_0.currentToolId

	if not IsNil(arg_6_0.objTfList[arg_6_0.currentToolId]) then
		setActive(arg_6_0.objTfList[arg_6_0.currentToolId], true)
		setParent(arg_6_0.objTfList[arg_6_0.currentToolId], arg_6_0._tf)
		pg.ViewUtils.SetLayer(arg_6_0.objTfList[arg_6_0.currentToolId], Layer.Character3D)

		return
	end

	local var_6_0 = pg.island_animation_attachments[arg_6_0.currentToolId]

	arg_6_0.objTfList[arg_6_0.currentToolId] = Object.Instantiate((LoadAny(pg.island_animation_attachments[arg_6_0.currentToolId].model, nil))).transform
	GetOrAddComponent(arg_6_0.objTfList[arg_6_0.currentToolId], typeof(Animator)).runtimeAnimatorController = LoadAny(var_6_0.animator, nil, typeof(RuntimeAnimatorController))

	setParent(arg_6_0.objTfList[arg_6_0.currentToolId], arg_6_0._tf)
	pg.ViewUtils.SetLayer(arg_6_0.objTfList[arg_6_0.currentToolId], Layer.Character3D)

	return
end

function var_0_0.UnLoadInteractiveTool(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.toolIdMap[arg_7_1] or arg_7_0.currentToolId or IslandAnimationAttachmentHelper.ResolveId(arg_7_0.animator, arg_7_1)
	local var_7_1 = arg_7_0.objTfList[var_7_0]

	if arg_7_0.objTfList[var_7_0] then
		setActive(var_7_1, false)
		setParent(var_7_1, arg_7_0.toolContainer)
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
	local var_9_0 = arg_9_0.toolIdMap[arg_9_2] or arg_9_0.currentToolId

	if arg_9_1 == var_0_1 and var_9_0 and arg_9_0.objTfList[var_9_0] then
		pg.ViewUtils.SetLayer(arg_9_0.objTfList[var_9_0], Layer.Character3D)
	end

	return
end

function var_0_0.StateExitFixHandle(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.toolIdMap[arg_10_2] or arg_10_0.currentToolId

	if arg_10_1 == var_0_1 and var_10_0 and arg_10_0.objTfList[var_10_0] then
		pg.ViewUtils.SetLayer(arg_10_0.objTfList[var_10_0], Layer.Default)
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
	local var_13_0 = arg_13_0.objTfList or {}

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		Object.Destroy(iter_13_1.gameObject)
	end

	arg_13_0.objTfList = {}

	return
end

function var_0_0.OnDetach(arg_14_0)
	arg_14_0:ClearAnimationTools()
	arg_14_0.characterHandleController:AddStateEnterFunc(nil)
	arg_14_0.characterHandleController:AddStateExitFunc(nil)
	arg_14_0.characterHandleController:AddStateEnterFixCompleteFunc(nil)
	arg_14_0.characterHandleController:AddStateExitFixCompleteFunc(nil)

	arg_14_0._go = nil
	arg_14_0._tf = nil
	arg_14_0.objTfList = nil
	arg_14_0.characterHandleController = nil

	return
end

return var_0_0
