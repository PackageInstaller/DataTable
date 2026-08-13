class = var_0_10000

local var_0_0 = "AgoraMould"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_3)

	arg_1_0.callbacks = {}
	arg_1_0.root = arg_1_2.transform

	local var_1_0 = arg_1_2.transform

	arg_1_0.selected = var_4.Find(var_1_0, "selected")

	local var_1_1 = arg_1_2.transform

	arg_1_0.conflict = var_4.Find(var_1_1, "conflict")

	arg_1_0:InitArea()

	return
end

function var_0_1.InitArea(arg_2_0)
	local var_2_0 = arg_2_0.data
	local var_2_1 = var_1.GetSize(var_2_0)
	local var_2_2 = arg_2_0.selected

	Vector3 = var_2_0
	var_2_2.localScale = var_2_0(var_2_1.x, 0.01, var_2_1.y)

	local var_2_3 = arg_2_0.conflict

	Vector3 = var_3
	var_2_3.localScale = var_3(var_2_1.x, 0.01, var_2_1.y)

	arg_2_0:ShowOrHideArea(false)

	return
end

function var_0_1.ShowOrHideArea(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 then
		setActive = var_1_10003

		var_1_10003(arg_3_0.conflict, arg_3_1)

		setActive = var_1_10003

		var_1_10003(arg_3_0.selected, not arg_3_1)
	else
		setActive = var_1_10003

		var_1_10003(arg_3_0.conflict, false)

		setActive = var_1_10003

		var_1_10003(arg_3_0.selected, false)
	end

	return
end

function var_0_1.IsFullLoaded(arg_4_0)
	return arg_4_0:IsLoaded()
end

function var_0_1.OnInit(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._go = arg_5_1
	UIUtil = var_1_10003

	local var_5_0 = var_1_10003.SetLayerRecursively
	local var_5_1 = arg_5_0._go

	LayerMask = var_1_10006

	local var_5_2 = var_1_10006.NameToLayer

	IslandConst = var_1_10008

	var_5_0(var_5_1, var_5_2(var_1_10008.LAYER_WORLDMAP3D))

	arg_5_0.builder = arg_5_2

	local var_5_3 = arg_5_0.root

	var_5_3.name = arg_5_0.data.id
	setParent = var_5_3

	var_5_3(arg_5_0._go, arg_5_0.root)

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.UpdatePosition
	local var_5_6 = arg_5_0.data

	var_5_5(var_5_4, var_6.GetArea(var_5_6))

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0.UpdateRotation
	local var_5_9 = arg_5_0.data

	var_5_8(var_5_7, var_6.GetRotation(var_5_9))
	arg_5_0:AddListeners()

	local var_5_10 = arg_5_0.root
	local var_5_11 = var_3.GetComponent

	typeof = var_6
	NodeCanvas = var_5_9
	arg_5_0.behaviourTreeOwner = var_5_11(var_5_10, var_6(var_5_9.BehaviourTrees.BehaviourTreeOwner))

	arg_5_0:OnAttach(arg_5_0.root)

	return
end

function var_0_1.AddListeners(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.AddListener

	ISLAND_AGORA_EVT = var_1_10004

	var_6_1(var_6_0, var_1_10004.ITEM_POSITION_UPDATE, arg_6_0.UpdatePosition)

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.AddListener

	ISLAND_AGORA_EVT = var_4

	var_6_3(var_6_2, var_4.ITEM_DIR_UPDATE, arg_6_0.UpdateRotation)

	return
end

function var_0_1.RemoveListeners(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.RemoveListener

	ISLAND_AGORA_EVT = var_1_10004

	var_7_1(var_7_0, var_1_10004.ITEM_POSITION_UPDATE, arg_7_0.UpdatePosition)

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.RemoveListener

	ISLAND_AGORA_EVT = var_4

	var_7_3(var_7_2, var_4.ITEM_DIR_UPDATE, arg_7_0.UpdateRotation)

	return
end

function var_0_1.UpdatePosition(arg_8_0, arg_8_1)
	AgoraCalc = var_1_10002

	local var_8_0 = var_1_10002.GetAreaCenterPos(arg_8_1)

	Vector3 = var_1_10003

	local var_8_1 = var_1_10003(0, 0, 0)
	local var_8_2 = arg_8_0.data

	if var_4.IsBuildingType(var_8_2) then
		IslandConst = var_4
		var_8_1 = var_4.AGORA_BUILDING_Y_OFFSET
	else
		local var_8_3 = arg_8_0.data

		if var_4.IsNewTileType(var_8_3) then
			Vector3 = var_4
			var_8_1 = var_4(0, 0.01, 0)
		end
	end

	local var_8_4 = arg_8_0.root

	IslandConst = var_5
	var_8_4.position = var_8_0 + var_5.AGORA_POSITION_OFFSET + var_8_1

	return
end

function var_0_1.UpdateRotation(arg_9_0, arg_9_1)
	arg_9_0.root.eulerAngles = arg_9_1

	return
end

function var_0_1.AddListener(arg_10_0, arg_10_1, arg_10_2)
	local function var_10_0(arg_11_0, ...)
		arg_10_2(arg_10_0, ...)

		return
	end

	arg_10_0.callbacks[arg_10_2] = var_10_0

	local var_10_1 = arg_10_0.data

	var_4.AddListener(var_10_1, arg_10_1, var_10_0)

	return
end

function var_0_1.RemoveListener(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.callbacks[arg_12_2] then
		local var_12_0 = arg_12_0.data

		var_4.RemoveListener(var_12_0, arg_12_1, var_3)

		arg_12_0.callbacks[var_3] = nil
	end

	return
end

function var_0_1.Enable(arg_13_0)
	if not arg_13_0:IsLoaded() then
		return
	end

	arg_13_0:SetupBt()

	return
end

function var_0_1.Disable(arg_14_0)
	if not arg_14_0:IsLoaded() then
		return
	end

	arg_14_0:PauseBt()

	return
end

function var_0_1.Dispose(arg_15_0)
	arg_15_0:RemoveListeners()

	arg_15_0.callbacks = {}

	var_0_1.super.Dispose(arg_15_0)

	return
end

function var_0_1.OnDestroy(arg_16_0)
	local var_16_0 = arg_16_0.builder

	var_1.RecycleRoot(var_16_0, arg_16_0.root.gameObject)

	arg_16_0.root = nil

	return
end

return var_0_1
