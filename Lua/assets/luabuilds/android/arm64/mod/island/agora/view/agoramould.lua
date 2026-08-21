local var_0_0 = class("AgoraMould", import("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_3)

	arg_1_0.callbacks = {}
	arg_1_0.root = arg_1_2.transform
	arg_1_0.selected = arg_1_2.transform:Find("selected")
	arg_1_0.conflict = arg_1_2.transform:Find("conflict")

	arg_1_0:InitArea()

	return
end

function var_0_0.InitArea(arg_2_0)
	local var_2_0 = arg_2_0.data:GetSize()

	arg_2_0.selected.localScale = Vector3(var_2_0.x, 0.01, var_2_0.y)
	arg_2_0.conflict.localScale = Vector3(var_2_0.x, 0.01, var_2_0.y)

	arg_2_0:ShowOrHideArea(false)

	return
end

function var_0_0.ShowOrHideArea(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 then
		setActive(arg_3_0.conflict, arg_3_1)
		setActive(arg_3_0.selected, not arg_3_1)
	else
		setActive(arg_3_0.conflict, false)
		setActive(arg_3_0.selected, false)
	end

	return
end

function var_0_0.IsFullLoaded(arg_4_0)
	return arg_4_0:IsLoaded()
end

function var_0_0.OnInit(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._go = arg_5_1

	UIUtil.SetLayerRecursively(arg_5_0._go, LayerMask.NameToLayer(IslandConst.LAYER_WORLDMAP3D))

	arg_5_0.builder = arg_5_2
	arg_5_0.root.name = arg_5_0.data.id

	setParent(arg_5_0._go, arg_5_0.root)
	arg_5_0:UpdatePosition(arg_5_0.data:GetArea())
	arg_5_0:UpdateRotation(arg_5_0.data:GetRotation())
	arg_5_0:AddListeners()

	arg_5_0.behaviourTreeOwner = arg_5_0.root:GetComponent(typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner))

	arg_5_0:OnAttach(arg_5_0.root)

	return
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddListener(ISLAND_AGORA_EVT.ITEM_POSITION_UPDATE, arg_6_0.UpdatePosition)
	arg_6_0:AddListener(ISLAND_AGORA_EVT.ITEM_DIR_UPDATE, arg_6_0.UpdateRotation)

	return
end

function var_0_0.RemoveListeners(arg_7_0)
	arg_7_0:RemoveListener(ISLAND_AGORA_EVT.ITEM_POSITION_UPDATE, arg_7_0.UpdatePosition)
	arg_7_0:RemoveListener(ISLAND_AGORA_EVT.ITEM_DIR_UPDATE, arg_7_0.UpdateRotation)

	return
end

function var_0_0.UpdatePosition(arg_8_0, arg_8_1)
	local var_8_0 = AgoraCalc.GetAreaCenterPos(arg_8_1)
	local var_8_1 = Vector3(0, 0, 0)

	if arg_8_0.data:IsBuildingType() then
		var_8_1 = IslandConst.AGORA_BUILDING_Y_OFFSET
	elseif arg_8_0.data:IsNewTileType() then
		var_8_1 = Vector3(0, 0.01, 0)
	end

	arg_8_0.root.position = var_8_0 + IslandConst.AGORA_POSITION_OFFSET + var_8_1

	return
end

function var_0_0.UpdateRotation(arg_9_0, arg_9_1)
	arg_9_0.root.eulerAngles = arg_9_1

	return
end

function var_0_0.AddListener(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.callbacks[arg_10_2] = function(arg_11_0, ...)
		arg_10_2(arg_10_0, ...)

		return
	end

	arg_10_0.data:AddListener(arg_10_1, function(arg_11_0, ...)
		arg_10_2(arg_10_0, ...)

		return
	end)

	return
end

function var_0_0.RemoveListener(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.callbacks[arg_12_2] then
		arg_12_0.data:RemoveListener(arg_12_1, arg_12_0.callbacks[arg_12_2])

		arg_12_0.callbacks[arg_12_0.callbacks[arg_12_2]] = nil
	end

	return
end

function var_0_0.Enable(arg_13_0)
	if not arg_13_0:IsLoaded() then
		return
	end

	arg_13_0:SetupBt()

	return
end

function var_0_0.Disable(arg_14_0)
	if not arg_14_0:IsLoaded() then
		return
	end

	arg_14_0:PauseBt()

	return
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveListeners()

	arg_15_0.callbacks = {}

	var_0_0.super.Dispose(arg_15_0)

	return
end

function var_0_0.OnDestroy(arg_16_0)
	arg_16_0.builder:RecycleRoot(arg_16_0.root.gameObject)

	arg_16_0.root = nil

	return
end

return var_0_0
