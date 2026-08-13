class = var_0_10000

local var_0_0 = "CourtYardPlaceableModule"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardBaseModule"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.state = 0
	pg = var_3

	var_3.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_2
	arg_1_0._tf = arg_1_2.transform
	arg_1_0.data = arg_1_1
	arg_1_0.callbacks = {}
	arg_1_0.iconLoaded = false
	arg_1_0.pudding = false
	arg_1_0.completion = false

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.GetComponent

	typeof = var_1_10006
	CanvasGroup = var_1_10008
	arg_1_0.cg = var_1_1(var_1_0, var_1_10006(var_1_10008))

	local var_1_2 = arg_1_0:GetView()

	arg_1_0.rect = var_3.GetRect(var_1_2)

	local var_1_3 = arg_1_0.rect

	arg_1_0.floor = var_3.Find(var_1_3, "floor")

	local var_1_4 = arg_1_0.rect

	arg_1_0.wall = var_3.Find(var_1_4, "wall")

	local var_1_5 = arg_1_0.rect

	arg_1_0.mat = var_3.Find(var_1_5, "carpet")

	local var_1_6 = arg_1_0._tf

	arg_1_0.gridsTF = var_3.Find(var_1_6, "grids")

	local var_1_7 = arg_1_0._tf

	arg_1_0.childsTF = var_3.Find(var_1_7, "childs")

	local var_1_8 = arg_1_0._tf

	arg_1_0.interactionTF = var_3.Find(var_1_8, "interaction")

	local var_1_9 = arg_1_0.mat

	var_3.SetAsFirstSibling(var_1_9)

	arg_1_0.bones = {}

	local var_1_10 = arg_1_0.data
	local var_1_11 = var_3.GetDirection(var_1_10)
	local var_1_12 = arg_1_0._tf

	Vector3 = var_1_10
	var_1_12.localScale = var_1_10(var_1_11 == 1 and 1 or -1, 1, 1)
	setParent = var_1_12

	var_1_12(arg_1_0._tf, arg_1_0:GetParentTF())

	local var_1_13 = arg_1_0
	local var_1_14 = arg_1_0.UpdatePosition
	local var_1_15 = arg_1_0.data
	local var_1_16 = var_7.GetPosition(var_1_15)

	Vector3 = var_8

	var_1_14(var_1_13, var_1_16, var_8.zero)

	return
end

function var_0_1.IsCompletion(arg_2_0)
	local var_2_0

	if arg_2_0.completion then
		var_2_0 = not arg_2_0.doPuddingAniming
	end

	return var_2_0
end

function var_0_1.OnIconLoaed(arg_3_0)
	arg_3_0.iconLoaded = true

	if arg_3_0.pudding then
		arg_3_0:PuddingAnim()
	end

	return
end

function var_0_1.OnInit(arg_4_0)
	CourtYardDragAgent = var_1_10001

	local var_4_0 = var_1_10001.New
	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0:GetView()

	arg_4_0.dragAgent = var_4_0(var_4_1, var_4.GetRect(var_4_2))
	arg_4_0.completion = true

	return
end

function var_0_1.CreateWhenStoreyInit(arg_5_0)
	arg_5_0:PuddingAnim()

	return
end

function var_0_1.BlocksRaycasts(arg_6_0, arg_6_1)
	return
end

local var_0_2 = "follower_"

function var_0_1.NewBoneFollower(arg_7_0, arg_7_1)
	local var_7_0 = var_0_2 .. arg_7_1

	GameObject = var_3

	local var_7_1 = var_3.New
	local var_7_2 = var_7_0

	typeof = var_1_10006
	RectTransform = var_1_10008

	local var_7_3 = var_7_1(var_7_2, var_1_10006(var_1_10008)).transform

	var_4.SetParent(var_7_3, arg_7_0.interactionTF, false)

	GetOrAddComponent = var_5

	local var_7_4 = var_3

	typeof = var_8
	Spine = var_1_10010

	local var_7_5 = var_5(var_7_4, var_8(var_1_10010.Unity.BoneFollowerGraphic))

	var_7_5.followLocalScale = true

	local var_7_6 = arg_7_0:GetSpine()

	var_7_5.skeletonGraphic = var_6.GetComponent(var_7_6, "Spine.Unity.SkeletonGraphic")

	var_7_5:SetBone(arg_7_1)

	arg_7_0.bones[var_7_0] = var_4

	return var_4.transform
end

function var_0_1.FindBoneFollower(arg_8_0, arg_8_1)
	local var_8_0 = var_0_2 .. arg_8_1

	return arg_8_0.bones[var_8_0]
end

function var_0_1.PuddingAnim(arg_9_0)
	if not arg_9_0.iconLoaded then
		arg_9_0.pudding = true

		return
	end

	arg_9_0.doPuddingAniming = true

	local var_9_0 = arg_9_0._tf.localScale.x
	local var_9_1 = arg_9_0._tf.localScale.y
	local var_9_2 = var_9_0

	arg_9_0.normalY = var_9_1
	arg_9_0.normalX = var_9_2
	LeanTween = var_9_2

	local var_9_3 = var_9_2.scale

	rtf = var_1_10005

	local var_9_4 = var_1_10005(arg_9_0._tf)

	Vector3 = var_1_10006

	local var_9_5 = var_9_3(var_9_4, var_1_10006(var_9_0 + 0.2, var_9_1 + 0.2, 1), 0.2)
	local var_9_6 = var_3.setFrom(var_9_5, 0)
	local var_9_7 = var_3.setOnComplete

	System = var_6

	var_9_7(var_9_6, var_6.Action(function()
		LeanTween = var_2_10000

		local var_10_0 = var_2_10000.scale

		rtf = var_2_10002

		local var_10_1 = var_2_10002(arg_9_0._tf)

		Vector3 = var_2_10003

		local var_10_2 = var_10_0(var_10_1, var_2_10003(var_9_0, var_9_1, 1), 0.1)
		local var_10_3 = var_0.setOnComplete

		System = var_3

		var_10_3(var_10_2, var_3.Action(function()
			arg_9_0.doPuddingAniming = false

			return
		end))

		return
	end))

	arg_9_0.pudding = false

	return
end

function var_0_1.CancelPuddingAnim(arg_12_0)
	if arg_12_0.doPuddingAniming then
		LeanTween = var_1

		var_1.cancel(arg_12_0._tf.gameObject)

		local var_12_0 = arg_12_0._tf

		Vector3 = var_1_10002
		var_12_0.localScale = var_1_10002(arg_12_0.normalX, arg_12_0.normalY, 1)
		arg_12_0.doPuddingAniming = nil
	end

	return
end

function var_0_1.GetParentTF(arg_13_0)
	local var_13_0 = arg_13_0.data
	local var_13_1 = var_1.GetDeathType(var_13_0)

	CourtYardConst = var_1_10002

	if var_13_1 == var_1_10002.DEPTH_TYPE_MAT then
		return arg_13_0.mat
	else
		return arg_13_0.floor
	end

	return
end

function var_0_1.GetSpine(arg_14_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetData(arg_15_0)
	return arg_15_0.data
end

function var_0_1.SetSiblingIndex(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._tf

	if arg_16_1 ~= var_2.GetSiblingIndex(var_16_0) then
		local var_16_1 = arg_16_0._tf

		var_2.SetSiblingIndex(var_16_1, arg_16_1)
	end

	arg_16_0._go.name = arg_16_0.data.id .. "_" .. arg_16_1

	return
end

function var_0_1.SetAsLastSibling(arg_17_0)
	arg_17_0._go.name = arg_17_0.data.id

	local var_17_0 = arg_17_0._tf

	var_1.SetAsLastSibling(var_17_0)

	return
end

function var_0_1.SetActive(arg_18_0, arg_18_1)
	setActive = var_1_10002

	var_1_10002(arg_18_0._tf, arg_18_1)

	return
end

function var_0_1.UpdatePosition(arg_19_0, arg_19_1, arg_19_2)
	CourtYardCalcUtil = var_1_10003

	local var_19_0 = var_1_10003.Map2Local(arg_19_1)

	if not arg_19_2 then
		::label_19_0::

		Vector3 = var_1_10004
		var_1_10004 = var_1_10004.zero
	end

	local var_19_1 = var_19_0 + var_1_10004

	CourtYardCalcUtil = var_5

	local var_19_2 = var_5.TrPosition2LocalPos(arg_19_0:GetParentTF(), arg_19_0._tf.parent, var_19_1)

	arg_19_0._tf.localPosition = var_19_2

	return
end

function var_0_1.OnDispose(arg_20_0)
	pairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.bones) do
		IsNil = var_1_10006

		if not var_1_10006(iter_20_1) then
			Object = var_1_10006

			var_1_10006.Destroy(iter_20_1.gameObject)
		end
	end

	arg_20_0.bones = {}

	local var_20_0

	if arg_20_0.dragAgent then
		var_20_0 = arg_20_0.dragAgent

		var_1.Dispose(var_20_0)

		arg_20_0.dragAgent = nil
	end

	LeanTween = var_1

	local var_20_1 = var_1.isTweening

	go = var_20_0

	if var_20_1(var_20_0(arg_20_0._tf)) then
		LeanTween = var_1

		local var_20_2 = var_1.cancel

		go = var_3

		var_20_2(var_3(arg_20_0._tf))
	end

	return
end

function var_0_1.OnDestroy(arg_21_0)
	return
end

function var_0_1.OnBeginDrag(arg_22_0)
	return
end

function var_0_1.OnDragging(arg_23_0, arg_23_1)
	return
end

function var_0_1.OnDragEnd(arg_24_0, arg_24_1)
	return
end

return var_0_1
