class = var_0_10000

local var_0_0 = "DialogueStoryPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".StoryPlayer"))
local var_0_2 = 159
local var_0_3 = 411
local var_0_4 = 250

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0._tf

	arg_1_0.actorPanel = var_2.Find(var_1_0, "actor")

	local var_1_1 = arg_1_0.actorPanel

	arg_1_0.actorLeft = var_2.Find(var_1_1, "actor_left")
	arg_1_0.initActorLeftPos = arg_1_0.actorLeft.localPosition

	local var_1_2 = arg_1_0.actorPanel

	arg_1_0.actorMiddle = var_2.Find(var_1_2, "actor_middle")
	arg_1_0.initActorMiddlePos = arg_1_0.actorMiddle.localPosition

	local var_1_3 = arg_1_0.actorPanel

	arg_1_0.actorRgiht = var_2.Find(var_1_3, "actor_right")
	arg_1_0.initActorRgihtPos = arg_1_0.actorRgiht.localPosition

	local var_1_4 = arg_1_0._go
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Canvas = var_1_10005
	arg_1_0.sortingOrder = var_1_5(var_1_4, var_4(var_1_10005)).sortingOrder
	UIItemList = var_2

	local var_1_6 = var_2.New
	local var_1_7 = arg_1_0.actorPanel
	local var_1_8 = var_3.Find(var_1_7, "actor_middle/sub")
	local var_1_9 = arg_1_0.actorPanel

	arg_1_0.subActorMiddle = var_1_6(var_1_8, var_4.Find(var_1_9, "actor_middle/sub/tpl"))
	UIItemList = var_2

	local var_1_10 = var_2.New
	local var_1_11 = arg_1_0.actorPanel
	local var_1_12 = var_3.Find(var_1_11, "actor_right/sub")
	local var_1_13 = arg_1_0.actorPanel

	arg_1_0.subActorRgiht = var_1_10(var_1_12, var_4.Find(var_1_13, "actor_right/sub/tpl"))
	UIItemList = var_2

	local var_1_14 = var_2.New
	local var_1_15 = arg_1_0.actorPanel
	local var_1_16 = var_3.Find(var_1_15, "actor_left/sub")
	local var_1_17 = arg_1_0.actorPanel

	arg_1_0.subActorLeft = var_1_14(var_1_16, var_4.Find(var_1_17, "actor_left/sub/tpl"))

	local var_1_18 = arg_1_0._tf
	local var_1_19 = var_2.Find(var_1_18, "resource/material1")
	local var_1_20 = var_2.GetComponent

	typeof = var_4
	Image = var_1_17
	arg_1_0.glitchArtMaterial = var_1_20(var_1_19, var_4(var_1_17)).material

	local var_1_21 = arg_1_0._tf
	local var_1_22 = var_2.Find(var_1_21, "resource/material2")
	local var_1_23 = var_2.GetComponent

	typeof = var_4
	Image = var_1_17
	arg_1_0.maskMaterial = var_1_23(var_1_22, var_4(var_1_17)).material

	local var_1_24 = arg_1_0._tf
	local var_1_25 = var_2.Find(var_1_24, "resource/material5")
	local var_1_26 = var_2.GetComponent

	typeof = var_4
	Image = var_1_17
	arg_1_0.maskMaterialForWithLayer = var_1_26(var_1_25, var_4(var_1_17)).material

	local var_1_27 = arg_1_0._tf
	local var_1_28 = var_2.Find(var_1_27, "resource/material3")
	local var_1_29 = var_2.GetComponent

	typeof = var_4
	Image = var_1_17
	arg_1_0.glitchArtMaterialForPainting = var_1_29(var_1_28, var_4(var_1_17)).material

	local var_1_30 = arg_1_0._tf
	local var_1_31 = var_2.Find(var_1_30, "resource/material4")
	local var_1_32 = var_2.GetComponent

	typeof = var_4
	Image = var_1_17
	arg_1_0.glitchArtMaterialForPaintingBg = var_1_32(var_1_31, var_4(var_1_17)).material

	local var_1_33 = arg_1_0._tf
	local var_1_34 = var_2.Find(var_1_33, "resource/material6")
	local var_1_35 = var_2.GetComponent

	typeof = var_4
	Image = var_1_17
	arg_1_0.headObjectMat = var_1_35(var_1_34, var_4(var_1_17)).material

	local var_1_36 = arg_1_0._tf
	local var_1_37 = var_2.Find(var_1_36, "resource/material7")
	local var_1_38 = var_2.GetComponent

	typeof = var_4
	Image = var_1_17
	arg_1_0.headMaskMat = var_1_38(var_1_37, var_4(var_1_17)).material
	arg_1_0.typewriterSpeed = 0
	arg_1_0.contentBgAlpha = 1
	arg_1_0.live2dChars = {}
	arg_1_0.spinePainings = {}

	return
end

function var_0_1.OnStart(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.dialogueWin

	arg_2_0.nextTr = var_2.Find(var_2_0, "next")

	local var_2_1 = arg_2_0.dialogueWin

	arg_2_0.conentTr = var_2.Find(var_2_1, "content")

	local var_2_2 = arg_2_0.dialogueWin
	local var_2_3 = var_2.Find(var_2_2, "content")
	local var_2_4 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_2_0.conentTxt = var_2_4(var_2_3, var_4(var_1_10005))

	local var_2_5 = arg_2_0.dialogueWin
	local var_2_6 = var_2.Find(var_2_5, "content")
	local var_2_7 = var_2.GetComponent

	typeof = var_4
	Typewriter = var_1_10005
	arg_2_0.typewriter = var_2_7(var_2_6, var_4(var_1_10005))

	local var_2_8 = arg_2_0.dialogueWin

	arg_2_0.nameTr = var_2.Find(var_2_8, "content/name")

	local var_2_9 = arg_2_0.dialogueWin

	arg_2_0.tag4Dialog2 = var_2.Find(var_2_9, "content/tag")

	local var_2_10 = arg_2_0.nameTr
	local var_2_11 = var_2.Find(var_2_10, "Text")
	local var_2_12 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_2_0.nameTxt = var_2_12(var_2_11, var_4(var_1_10005))

	local var_2_13 = arg_2_0.dialogueWin

	arg_2_0.portraitTr = var_2.Find(var_2_13, "portrait")

	local var_2_14 = arg_2_0.dialogueWin

	arg_2_0.conentLineTr = var_2.Find(var_2_14, "line")

	local var_2_15 = arg_2_0.portraitTr
	local var_2_16 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_2_0.portraitImg = var_2_16(var_2_15, var_4(var_1_10005))

	local var_2_17 = {}
	local var_2_18 = arg_2_0.nameTr

	var_2_17[1] = var_3.Find(var_2_18, "tags/1")

	local var_2_19 = arg_2_0.nameTr

	var_2_17[2] = var_3.Find(var_2_19, "tags/2")
	arg_2_0.tags = var_2_17

	local var_2_20 = {}
	local var_2_21 = arg_2_0.nameTr

	var_2_20[1] = var_3.Find(var_2_21, "bg")

	local var_2_22 = arg_2_0.dialogueWin

	var_2_20[2] = var_3.Find(var_2_22, "bg")
	arg_2_0.contentBgs = var_2_20
	arg_2_0.defualtFontSize = arg_2_0.conentTxt.fontSize

	return
end

function var_0_1.OnReset(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0:ResetActorTF(arg_3_1, arg_3_2)

	setActive = var_4

	var_4(arg_3_0.nameTr, false)

	setActive = var_4

	var_4(arg_3_0.nameTr, false)

	setActive = var_4

	var_4(arg_3_0.dialoguePanel, true)

	setActive = var_4

	var_4(arg_3_0.actorPanel, true)

	setActive = var_4

	var_4(arg_3_0.nextTr, false)

	arg_3_0.conentTxt.text = ""

	local var_3_0 = arg_3_1:ExistPortrait()
	local var_3_1, var_3_2

	if arg_3_2 then
		::label_3_0::

		var_3_1 = arg_3_2

		if arg_3_2.IsDialogueMode(var_3_1) then
			var_3_1 = arg_3_2

			if arg_3_2.ExistPortrait(var_3_1) then
				var_3_2 = var_3_0
			end
		end
	end

	setActive = var_3_1

	var_3_1(arg_3_0.portraitTr, var_3_2)

	if not var_3_2 and arg_3_2 and arg_3_2:IsDialogueMode() and arg_3_2:ShouldGlitchArtForPortrait() then
		arg_3_0:ClearGlitchArtForPortrait()
	end

	arg_3_0:UpdateContentPosition(arg_3_1)
	arg_3_0:SetContentBgAlpha(arg_3_1:GetContentBGAlpha())
	arg_3_3()

	return
end

function var_0_1.UpdateContentPosition(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:ExistPortrait()
	local var_4_1 = arg_4_1:IsMiniPortrait()
	local var_4_2

	if not var_4_0 or (not var_4_1 or not var_0_4) and not var_0_3 then
		var_4_2 = var_0_2
	end

	local var_4_3 = arg_4_0.conentTr

	Vector2 = var_1_10006
	var_4_3.offsetMin = var_1_10006(var_4_2, arg_4_0.conentTr.offsetMin.y)

	local var_4_4

	if not var_4_1 or not var_0_4 then
		var_4_4 = var_0_2
	end

	local var_4_5 = arg_4_0.conentLineTr

	Vector2 = var_7
	var_4_5.offsetMin = var_7(var_4_4, arg_4_0.conentLineTr.offsetMin.y)

	return
end

local function var_0_5(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return false
	end

	local var_5_0

	if arg_5_0:IsLive2dPainting() then
		var_5_0 = arg_5_1:Find("live2d")
	elseif arg_5_0:IsSpinePainting() then
		var_5_0 = arg_5_1:Find("spine")
	else
		var_5_0 = arg_5_1:Find("fitter")
	end

	if var_5_0.childCount <= 0 then
		return false
	end

	return var_5_0:GetChild(0).name == arg_5_0:GetPainting()
end

function var_0_1.GetRecycleActorList(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1:GetSide()
	local var_6_1 = arg_6_0:GetSideTF(var_6_0)
	local var_6_2 = {}

	if arg_6_1:HideOtherPainting() then
		var_6_2 = {
			arg_6_0.actorLeft,
			arg_6_0.actorMiddle,
			arg_6_0.actorRgiht
		}
	else
		if arg_6_2 and arg_6_2:IsDialogueMode() and arg_6_1:IsDialogueMode() and arg_6_1:IsSameSide(arg_6_2) and arg_6_1:IsSamePainting(arg_6_2) or var_0_5(arg_6_1, var_6_1) then
			-- block empty
		else
			table = var_6

			var_6.insert(var_6_2, var_6_1)
		end

		DialogueStep = var_6

		if var_6_0 == var_6.SIDE_MIDDLE then
			table = var_6

			var_6.insert(var_6_2, arg_6_0.actorLeft)

			table = var_6

			var_6.insert(var_6_2, arg_6_0.actorRgiht)
		end
	end

	return var_6_2
end

function var_0_1.ResetActorTF(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1:GetSide()

	if arg_7_0:GetSideTF(var_7_0) then
		arg_7_0:CancelTween(var_4.gameObject)

		Vector3 = var_5
		var_4.localScale = var_5(1, 1, 1)
		Vector3 = var_5
		var_4.eulerAngles = var_5(0, 0, 0)

		if var_4 == arg_7_0.actorRgiht then
			var_4.localPosition = arg_7_0.initActorRgihtPos
		elseif var_4 == arg_7_0.actorMiddle then
			var_4.localPosition = arg_7_0.initActorMiddlePos
		elseif var_4 == arg_7_0.actorLeft then
			var_4.localPosition = arg_7_0.initActorLeftPos
		end
	end

	local var_7_1 = arg_7_0
	local var_7_2 = arg_7_0.GetRecycleActorList(var_7_1, arg_7_1, arg_7_2)

	if var_4 then
		_ = var_7_1

		if var_7_1.all(var_7_2, function(arg_8_0)
			return arg_8_0 ~= var_0
		end) then
			arg_7_0.paintingStay = true

			arg_7_0:ResetMeshPainting(var_4)

			if arg_7_1:IsSpinePainting() then
				arg_7_0:HideSpineEffect(var_4, arg_7_1)
			end
		end
	end

	arg_7_0:RecyclePaintingList(var_7_2)
	arg_7_0:RecyclesSubPantings(arg_7_0.subActorMiddle)
	arg_7_0:RecyclesSubPantings(arg_7_0.subActorRgiht)
	arg_7_0:RecyclesSubPantings(arg_7_0.subActorLeft)

	ipairs = var_6

	for iter_7_0, iter_7_1 in var_6({
		arg_7_0.actorLeft,
		arg_7_0.actorMiddle,
		arg_7_0.actorRgiht
	}) do
		local var_7_3 = iter_7_1
		local var_7_4 = iter_7_1.GetComponent

		typeof = var_1_10013
		CanvasGroup = var_1_10014
		var_7_4(var_7_3, var_1_10013(var_1_10014)).alpha = 1
	end

	return
end

function var_0_1.HideSpineEffect(arg_9_0, arg_9_1)
	arg_9_0.spineEffectOrderCaches = {}

	local function var_9_0(arg_10_0)
		local var_10_0 = arg_10_0
		local var_10_1 = arg_10_0.GetComponentsInChildren

		typeof = var_2_10003

		local var_10_2 = var_10_1(var_10_0, var_2_10003("UnityEngine.ParticleSystemRenderer"))
		local var_10_3 = var_1.ToTable(var_10_2)

		ipairs = var_10_2

		for iter_10_0, iter_10_1 in var_10_2(var_10_3) do
			ReflectionHelp = var_2_10007
			var_2_10007 = var_2_10007.RefGetProperty
			typeof = var_2_10008
			var_2_10007 = var_2_10007(var_2_10008("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_10_1)
			ReflectionHelp = var_2_10008
			var_2_10008 = var_2_10008.RefSetProperty
			typeof = var_9

			var_2_10008(var_9("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_10_1, -1)

			var_2_10008 = arg_9_0.spineEffectOrderCaches
			var_2_10008[iter_10_1] = var_2_10007
		end

		return
	end

	local var_9_1 = arg_9_1:Find("spine")
	local var_9_2 = arg_9_1:Find("spinebg")

	var_9_0(var_9_1)
	var_9_0(var_9_2)

	return
end

function var_0_1.RevertSpineEffect(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_2 then
		return
	end

	local function var_11_0(arg_12_0)
		local var_12_0 = arg_12_0
		local var_12_1 = arg_12_0.GetComponentsInChildren

		typeof = var_2_10003

		local var_12_2 = var_12_1(var_12_0, var_2_10003("UnityEngine.ParticleSystemRenderer"))
		local var_12_3 = var_1.ToTable(var_12_2)

		ipairs = var_12_2

		for iter_12_0, iter_12_1 in var_12_2(var_12_3) do
			local var_12_4

			if not arg_11_2[iter_12_1] then
				var_12_4 = 950
			end

			ReflectionHelp = var_2_10008
			var_2_10008 = var_2_10008.RefSetProperty
			typeof = var_2_10009

			var_2_10008(var_2_10009("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_12_1, var_12_4)
		end

		return
	end

	local var_11_1 = arg_11_1:Find("spine")
	local var_11_2 = arg_11_1:Find("spinebg")

	var_11_0(var_11_1)
	var_11_0(var_11_2)

	return
end

function var_0_1.OnInit(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {
		function(arg_14_0)
			local var_14_0 = arg_13_0

			var_1.UpdateContent(var_14_0, arg_13_1, arg_14_0)

			return
		end,
		function(arg_15_0)
			local var_15_0 = arg_13_0

			var_1.UpdatePortrait(var_15_0, arg_13_1, arg_15_0)

			return
		end,
		function(arg_16_0)
			local var_16_0 = arg_13_0

			var_1.UpdateSubPaintings(var_16_0, arg_13_1, arg_16_0)

			return
		end,
		function(arg_17_0)
			local var_17_0 = arg_13_0

			var_1.UpdatePainting(var_17_0, arg_13_1, arg_13_2, arg_17_0)

			return
		end,
		function(arg_18_0)
			local var_18_0 = arg_13_0

			var_1.GrayingInPainting(var_18_0, arg_13_1, arg_13_2, arg_18_0)

			return
		end,
		function(arg_19_0)
			local var_19_0 = arg_13_0

			var_1.StartMovePrevPaintingToSide(var_19_0, arg_13_1, arg_13_2, arg_19_0)

			return
		end,
		function(arg_20_0)
			local var_20_0 = arg_13_0

			var_1.GrayingOutPrevPainting(var_20_0, arg_13_2, arg_13_1, arg_20_0)

			return
		end
	}

	parallelAsync = var_5

	var_5(var_13_0, arg_13_3)

	return
end

function var_0_1.UpdatePortrait(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_1:ExistPortrait() then
		arg_21_2()

		return
	end

	local var_21_0 = arg_21_1
	local var_21_1 = arg_21_1.GetPortrait(var_21_0)

	LoadSpriteAsync = var_21_0

	var_21_0("StoryIcon/" .. var_21_1, function(arg_22_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_21_0.portraitTr, arg_22_0, true)

		setActive = var_2_10001

		var_2_10001(arg_21_0.portraitTr, true)

		local var_22_0 = arg_21_0

		var_1.AdjustPortraitPosition(var_22_0, arg_21_1)

		local var_22_1 = arg_21_1

		if var_1.ShouldGlitchArtForPortrait(var_22_1) then
			local var_22_2 = arg_21_0

			var_1.SetGlitchArtForPortrait(var_22_2)
		else
			local var_22_3 = arg_21_0

			var_1.ClearGlitchArtForPortrait(var_22_3)
		end

		arg_21_2()

		return
	end)

	return
end

function var_0_1.AdjustPortraitPosition(arg_23_0, arg_23_1)
	if arg_23_1:IsMiniPortrait() then
		setAnchoredPosition3D = var_2

		var_2(arg_23_0.portraitTr, {
			x = 211,
			y = 133
		})
	else
		local var_23_0

		if not (arg_23_0.portraitTr.sizeDelta.x < var_0_3) or not var_0_3 then
			var_23_0 = 539
		end

		setAnchoredPosition3D = var_4

		var_4(arg_23_0.portraitTr, {
			y = 0,
			x = var_23_0
		})
	end

	return
end

function var_0_1.SetGlitchArtForPortrait(arg_24_0)
	if arg_24_0.portraitImg.material ~= arg_24_0.glitchArtMaterialForPainting then
		arg_24_0.portraitImg.material = arg_24_0.glitchArtMaterialForPainting
	end

	return
end

function var_0_1.ClearGlitchArtForPortrait(arg_25_0)
	if not arg_25_0.portraitImg then
		return
	end

	if arg_25_0.portraitImg.material ~= arg_25_0.portraitImg.defaultGraphicMaterial then
		arg_25_0.portraitImg.material = arg_25_0.portraitImg.defaultGraphicMaterial
	end

	return
end

function var_0_1.UpdateSubPaintings(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0, var_26_1, var_26_2, var_26_3 = arg_26_0:GetSideTF(arg_26_1:GetSide())

	if not arg_26_1:ExistPainting() then
		arg_26_2()

		return
	end

	arg_26_0:InitSubPainting(var_26_3, arg_26_1:GetSubPaintings(), arg_26_1)

	if arg_26_1:NeedDispppearSubPainting() then
		arg_26_0:DisappearSubPainting(var_26_3, arg_26_1, arg_26_2)
	else
		arg_26_2()
	end

	return
end

function var_0_1.OnStartUIAnimations(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_1:ShouldShakeDailogue() then
		arg_27_2()

		return
	end

	local var_27_0 = arg_27_1:GetShakeDailogueData().x
	local var_27_1 = var_3.number
	local var_27_2 = var_3.delay
	local var_27_3 = var_3.speed
	local var_27_4 = arg_27_0.dialogueWin.localPosition.x

	arg_27_0:TweenMovex(arg_27_0.dialogueWin, var_27_0, var_27_4, var_27_3, var_27_2, var_27_1, arg_27_2)

	return
end

function var_0_1.OnEnter(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	parallelAsync = var_1_10004

	var_1_10004({
		function(arg_29_0)
			local var_29_0 = arg_28_0

			var_1.UpdateCanMarkNode(var_29_0, arg_28_1, arg_29_0)

			return
		end,
		function(arg_30_0)
			local var_30_0 = arg_28_0

			var_1.UpdateIcon(var_30_0, arg_28_1, arg_30_0)

			return
		end
	}, arg_28_3)

	return
end

local function var_0_6(arg_31_0, arg_31_1)
	LoadAnyAsync = var_1_10002

	var_1_10002("Story/" .. arg_31_0, "", nil, arg_31_1)

	return
end

local function var_0_7(arg_32_0, arg_32_1)
	if not arg_32_1 then
		return false
	end

	return arg_32_0:GetCanMarkNodeData().name == arg_32_1.name
end

function var_0_1.UpdateCanMarkNode(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_1:ExistCanMarkNode() or not var_0_7(arg_33_1, arg_33_0.canMarkNode) then
		arg_33_0:ClearCanMarkNode(arg_33_0.canMarkNode)
	end

	if not var_3 then
		arg_33_2()

		return
	end

	local var_33_0 = arg_33_1:GetCanMarkNodeData()

	local function var_33_1(arg_34_0)
		eachChild = var_2_10001

		var_2_10001(arg_34_0, function(arg_35_0)
			table = var_3_10001

			local var_35_0 = var_3_10001.contains(var_33_0.marks, arg_35_0.gameObject.name)

			isActive = var_2

			if var_35_0 ~= var_2(arg_35_0) then
				setActive = var_3_10004

				var_3_10004(arg_35_0, var_35_0)
			end

			return
		end)

		return
	end

	if not arg_33_0.canMarkNode then
		var_0_6(var_33_0.name, function(arg_36_0)
			if arg_33_0.stop or not arg_36_0 then
				arg_33_2()

				return
			end

			Object = var_1

			local var_36_0 = var_1.Instantiate(arg_36_0, arg_33_0.backPanel)

			arg_33_0.canMarkNode = {
				name = var_33_0.name,
				go = var_36_0
			}

			var_33_1(var_36_0)
			arg_33_2()

			return
		end)
	else
		var_33_1(arg_33_0.canMarkNode.go)
		arg_33_2()
	end

	return
end

function var_0_1.ClearCanMarkNode(arg_37_0)
	if arg_37_0.canMarkNode then
		Destroy = var_1

		var_1(arg_37_0.canMarkNode.go)

		arg_37_0.canMarkNode = nil
	end

	return
end

function var_0_1.GrayingOutPrevPainting(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if not arg_38_1 or not arg_38_1:IsDialogueMode() then
		arg_38_3()

		return
	end

	if arg_38_0:GetSideTF(arg_38_2:GetPrevSide(arg_38_1)) and arg_38_2 and arg_38_2:IsDialogueMode() and arg_38_2:ShouldGrayingOutPainting(arg_38_1) then
		local var_38_0 = arg_38_1:GetPaintingData()
		local var_38_1

		if not arg_38_1:GetPaintingAlpha() then
			var_38_1 = 1
		end

		arg_38_0:fadeTransform(var_4, var_38_1, var_38_0.alpha, var_38_0.time, false, arg_38_3)
	else
		arg_38_3()
	end

	return
end

function var_0_1.GrayingInPainting(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if not arg_39_1:ExistPainting() then
		arg_39_3()

		return
	end

	if arg_39_2 and arg_39_2:IsDialogueMode() and arg_39_1:ShouldGrayingPainting(arg_39_2) then
		local var_39_0 = arg_39_0:GetSideTF(arg_39_1:GetSide())
		local var_39_1 = arg_39_1
		local var_39_2 = arg_39_1.GetPaintingData(var_39_1)

		IsNil = var_39_1

		if not var_39_1(var_39_0) and not arg_39_1:GetPaintingAlpha() then
			arg_39_0:fadeTransform(var_39_0, var_39_2.alpha, 1, var_39_2.time, false)
		end
	end

	arg_39_3()

	return
end

function var_0_1.UpdateTypeWriter(arg_40_0, arg_40_1, arg_40_2)
	if not arg_40_1:GetTypewriter() then
		arg_40_2()

		return
	end

	local var_40_0 = arg_40_0.typewriter

	function var_40_0.endFunc()
		arg_40_0.typewriterSpeed = 0

		local var_41_0 = arg_40_0.typewriter

		var_41_0.endFunc = nil
		removeOnButton = var_41_0

		var_41_0(arg_40_0._tf)
		arg_40_2()

		return
	end

	math = var_40_0

	local var_40_1 = var_40_0.max
	local var_40_2

	if not var_3.speed then
		var_40_2 = 0.1
	end

	arg_40_0.typewriterSpeed = var_40_1(var_40_2 * arg_40_0.timeScale, 0.001)

	local var_40_3

	if not var_3.speedUp then
		var_40_3 = arg_40_0.typewriterSpeed
	end

	local var_40_4 = arg_40_0.typewriter

	var_5.setSpeed(var_40_4, arg_40_0.typewriterSpeed)

	local var_40_5 = arg_40_0.typewriter

	var_5.Play(var_40_5)

	onButton = var_5

	local var_40_6 = arg_40_0
	local var_40_7 = arg_40_0._tf

	local function var_40_8()
		if arg_40_0.puase or arg_40_0.stop then
			return
		end

		local var_42_0 = arg_40_0

		math = var_2_10001
		var_42_0.typewriterSpeed = var_2_10001.min(arg_40_0.typewriterSpeed, var_40_3)

		local var_42_1 = arg_40_0.typewriter

		var_0.setSpeed(var_42_1, arg_40_0.typewriterSpeed)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_40_6, var_40_7, var_40_8, var_1_10009)

	return
end

function var_0_1.UpdatePainting(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	if not arg_43_1:ExistPainting() then
		arg_43_3()

		return
	end

	local var_43_0 = not arg_43_0.paintingStay

	if arg_43_0.paintingStay and arg_43_0.spineEffectOrderCaches and arg_43_1:IsSpinePainting() then
		local var_43_1 = arg_43_0:GetSideTF(arg_43_1:GetSide())

		arg_43_0:RevertSpineEffect(var_43_1, arg_43_0.spineEffectOrderCaches)
	end

	arg_43_0.spineEffectOrderCaches = nil
	arg_43_0.paintingStay = nil

	local var_43_2, var_43_3, var_43_4, var_43_5 = arg_43_0:GetSideTF(arg_43_1:GetSide())
	local var_43_6

	if not arg_43_2 or not arg_43_2:IsDialogueMode() or not arg_43_1:ShouldGrayingOutPainting(arg_43_2) and not arg_43_1:ShouldGrayingPainting(arg_43_2) then
		var_43_6 = not arg_43_1:ShouldFadeInPainting() or not var_43_0
	end

	local var_43_7

	if arg_43_2 then
		::label_43_0::

		var_1_10011 = arg_43_2

		if arg_43_2.IsDialogueMode(var_1_10011) then
			var_1_10011 = arg_43_1
			var_43_7 = arg_43_1.ShouldGrayingPainting(var_1_10011, arg_43_2)
		end
	end

	seriesAsync = var_1_10011

	var_1_10011({
		function(arg_44_0)
			if not var_43_6 then
				local var_44_0 = var_43_2
				local var_44_1 = var_1.GetComponent

				typeof = var_2_10003
				CanvasGroup = var_2_10004
				var_44_1(var_44_0, var_2_10003(var_2_10004)).alpha = 0
			end

			local var_44_2 = arg_43_0

			var_1.LoadPainting(var_44_2, arg_43_1, var_43_0, arg_44_0)

			if var_43_7 then
				local var_44_3 = arg_43_1
				local var_44_4 = var_1.GetPaintingData(var_44_3)
				local var_44_5 = arg_43_0

				var_2.SetFadeColor(var_44_5, var_43_2, var_44_4.alpha)
			end

			return
		end,
		function(arg_45_0)
			if var_43_6 then
				arg_45_0()

				return
			end

			local var_45_0 = arg_43_0

			var_1.FadeInPainting(var_45_0, var_43_2, arg_43_1, arg_45_0)

			return
		end,
		function(arg_46_0)
			local var_46_0 = arg_43_0

			var_1.AnimationPainting(var_46_0, arg_43_1, arg_46_0)

			return
		end
	}, arg_43_3)

	return
end

function var_0_1.FadeInPainting(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = arg_47_1
	local var_47_1 = arg_47_1.GetComponent

	typeof = var_1_10006
	CanvasGroup = var_1_10007

	local var_47_2 = var_47_1(var_47_0, var_1_10006(var_1_10007))
	local var_47_3 = arg_47_2:GetFadeInPaintingTime()

	if arg_47_2:ShouldAddHeadMaskWhenFade() then
		arg_47_0:AddHeadMask(arg_47_1)
	end

	arg_47_0:TweenValueForcanvasGroup(var_47_2, 0, 1, var_47_3, 0, function()
		if var_0 then
			local var_48_0 = arg_47_0

			var_0.ClearHeadMask(var_48_0, arg_47_1)
		end

		arg_47_3()

		return
	end)

	return
end

function var_0_1.AddHeadMask(arg_49_0, arg_49_1)
	if not arg_49_1:Find("fitter") or var_2.childCount <= 0 then
		return
	end

	local var_49_0 = var_2:GetChild(0)
	local var_49_1 = var_3.Find(var_49_0, "face")

	cloneTplTo = var_49_0

	local var_49_2 = var_49_0(var_49_1, var_49_1.parent, "head_mask")
	local var_49_3 = var_3:Find("layers")
	local var_49_4 = arg_49_1
	local var_49_5 = arg_49_1.GetComponentsInChildren

	typeof = var_1_10009
	Image = var_1_10010

	local var_49_6 = var_49_5(var_49_4, var_1_10009(var_1_10010))
	local var_49_7 = var_7.ToTable(var_49_6)

	if var_49_3 then
		ipairs = var_49_6

		for iter_49_0, iter_49_1 in var_49_6(var_49_7) do
			if iter_49_1.gameObject.name == "head_mask" then
				iter_49_1.material = arg_49_0.headMaskMat
			elseif iter_49_1.gameObject.name == "face" then
				-- block empty
			elseif iter_49_1.gameObject.transform.parent == var_49_3 then
				iter_49_1.material = arg_49_0.headObjectMat
			end
		end
	else
		ipairs = var_49_6

		for iter_49_2, iter_49_3 in var_49_6(var_49_7) do
			if iter_49_3.gameObject.name == "head_mask" then
				iter_49_3.material = arg_49_0.headMaskMat
			elseif iter_49_3.gameObject.name == "face" then
				-- block empty
			else
				iter_49_3.material = arg_49_0.headObjectMat
			end
		end
	end

	return
end

function var_0_1.ClearHeadMask(arg_50_0, arg_50_1)
	if not arg_50_1:Find("fitter") or var_2.childCount <= 0 then
		return
	end

	local var_50_0 = var_2:GetChild(0)
	local var_50_1 = var_3.Find(var_50_0, "head_mask")

	Destroy = var_50_0

	var_50_0(var_50_1.gameObject)

	local var_50_2 = arg_50_1
	local var_50_3 = arg_50_1.GetComponentsInChildren

	typeof = var_1_10007
	Image = var_1_10008

	local var_50_4 = var_50_3(var_50_2, var_1_10007(var_1_10008))
	local var_50_5 = var_5.ToTable(var_50_4)

	ipairs = var_50_4

	for iter_50_0, iter_50_1 in var_50_4(var_50_5) do
		iter_50_1.material = iter_50_1.defaultGraphicMaterial
	end

	return
end

function var_0_1.AnimationPainting(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_1:IsLive2dPainting() or arg_51_1:IsSpinePainting() then
		arg_51_2()

		return
	end

	local var_51_0, var_51_1, var_51_2, var_51_3 = arg_51_0:GetSideTF(arg_51_1:GetSide())

	arg_51_0:StartPaintingActions(var_51_0, arg_51_1, arg_51_2)

	return
end

function var_0_1.LoadPainting(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	local var_52_0, var_52_1, var_52_2, var_52_3 = arg_52_0:GetSideTF(arg_52_1:GetSide())
	local var_52_4, var_52_5 = arg_52_1:GetPaintingAndName()

	if arg_52_1:IsLive2dPainting() then
		checkABExist = var_10

		if var_10("live2d/" .. var_52_5) then
			Live2dConst = var_10

			if not var_10.GetLive2DArm32MatchAble() then
				arg_52_0:UpdateLive2dPainting(arg_52_1, var_52_0, arg_52_2, arg_52_3)

				goto label_52_0
			end
		end
	end

	if arg_52_1:IsSpinePainting() then
		checkABExist = var_10

		if var_10("spinepainting/" .. var_52_5) then
			arg_52_0:UpdateSpinePainting(arg_52_1, var_52_0, arg_52_2, arg_52_3)

			goto label_52_0
		end
	end

	arg_52_0:UpdateMeshPainting(arg_52_1, var_52_0, var_52_3, arg_52_2, arg_52_3)

	::label_52_0::

	return
end

function var_0_1.UpdateLive2dPainting(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	local function var_53_0(arg_54_0)
		local var_54_0 = arg_53_1
		local var_54_1 = var_1.GetVirtualShip(var_54_0)
		local var_54_2 = arg_53_1
		local var_54_3 = var_2.GetLive2dPos(var_54_2)

		Live2DPainting = var_54_2

		local var_54_4 = var_54_2.GenerateData
		local var_54_5 = {
			ship = var_54_1,
			offset = var_54_1:GetSkinConfig().live2d_offset
		}
		local var_54_6

		if not var_54_3 then
			::label_54_0::

			Vector3 = var_54_6
			var_54_6 = var_54_6(0, 0, 0)
		end

		var_54_5.position = var_54_6

		local var_54_7 = arg_53_2

		var_54_5.parent = var_5.Find(var_54_7, "live2d")

		local var_54_8 = var_54_4(var_54_5)

		GetOrAddComponent = var_54_5

		local var_54_9 = arg_53_0._go

		typeof = var_54_7
		CanvasGroup = var_7

		local var_54_10 = var_54_5(var_54_9, var_54_7(var_7))

		var_54_10.blocksRaycasts = false
		Live2DPainting = var_5

		local var_54_11 = var_5.New(var_54_8, function(arg_55_0)
			local var_55_0 = arg_55_0._go
			local var_55_1 = arg_53_1

			var_55_0.name = var_2.GetPainting(var_55_1)

			local var_55_2 = arg_55_0._go
			local var_55_3 = var_1.GetComponent

			typeof = var_55_1
			CubismRenderController = var_3_10004

			local var_55_4 = var_55_3(var_55_2, var_55_1(var_3_10004))

			var_55_4.SortingOrder = arg_53_0.sortingOrder + 1
			CubismSortingMode = var_3
			var_55_4.SortingMode = var_3.BackToFrontOrder
			GetOrAddComponent = var_3

			local var_55_5 = arg_53_0.front

			typeof = var_3_10005
			Canvas = var_3_10006

			local var_55_6 = var_3(var_55_5, var_3_10005(var_3_10006))

			GetOrAddComponent = var_55_5

			local var_55_7 = arg_53_0.front

			typeof = var_3_10006
			GraphicRaycaster = var_3_10007

			var_55_5(var_55_7, var_3_10006(var_3_10007))

			var_55_6.overrideSorting = true

			local var_55_8 = arg_55_0._tf

			var_55_6.sortingOrder = var_2 + var_4.Find(var_55_8, "Drawables").childCount
			var_54_10.blocksRaycasts = true

			if arg_54_0 then
				arg_54_0(arg_55_0)
			end

			return
		end)

		arg_53_0.live2dChars[arg_53_2] = var_54_11

		return
	end

	local function var_53_1(arg_56_0)
		if arg_56_0 then
			local var_56_0 = arg_53_1

			if var_1.GetLive2dAction(var_56_0) and var_1 ~= "" then
				arg_56_0:TriggerAction(var_1)
			end

			local var_56_1 = arg_53_1

			if var_2.GetL2dIdleIndex(var_56_1) and var_2 ~= "" and var_2 > 0 then
				arg_56_0:changeIdleIndex(var_2)
			end

			local var_56_2 = arg_53_1

			if var_3.GetL2dParams(var_56_2) then
				arg_56_0:changeDragParameter(var_3.name, var_3.value)
			end
		end

		arg_53_4()

		return
	end

	if not arg_53_3 and arg_53_0.live2dChars[arg_53_2] then
		local var_53_2 = arg_53_0.live2dChars[arg_53_2]

		var_53_1(var_53_2)
	else
		var_53_0(var_53_1)
	end

	return
end

local function var_0_8(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = arg_57_0
	local var_57_1 = arg_57_0.GetComponentsInChildren

	typeof = var_1_10005
	Canvas = var_1_10006

	local var_57_2 = var_57_1(var_57_0, var_1_10005(var_1_10006))
	local var_57_3 = var_3.ToTable(var_57_2)
	local var_57_4

	ipairs = var_5

	for iter_57_0, iter_57_1 in var_5(var_57_3) do
		var_57_4 = iter_57_1.sortingOrder
	end

	math = var_5

	local var_57_5 = var_5.huge
	local var_57_6 = arg_57_1
	local var_57_7 = arg_57_1.GetComponentsInChildren

	typeof = iter_57_0
	Canvas = iter_57_1

	local var_57_8 = var_57_7(var_57_6, iter_57_0(iter_57_1))

	if #var_6.ToTable(var_57_8) == 0 then
		var_57_5 = 0
	else
		ipairs = var_7

		for iter_57_2, iter_57_3 in var_7(var_6) do
			if iter_57_3.sortingOrder - var_57_4 < var_57_5 then
				var_57_5 = var_12
			end
		end
	end

	local var_57_9 = arg_57_1
	local var_57_10 = arg_57_1.GetComponentsInChildren

	typeof = iter_57_1

	local var_57_11 = var_57_10(var_57_9, iter_57_1("UnityEngine.ParticleSystemRenderer"))
	local var_57_12 = var_7.ToTable(var_57_11)
	local var_57_13 = {}

	ipairs = var_9

	for iter_57_4, iter_57_5 in var_9(var_57_12) do
		ReflectionHelp = var_1_10014
		var_1_10014 = var_1_10014.RefGetProperty
		typeof = var_1_10015
		var_57_13[iter_57_4] = var_1_10014(var_1_10015("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_57_5)

		if var_1_10014 - var_57_4 < var_57_5 then
			var_57_5 = var_1_10015
		end
	end

	local var_57_14 = arg_57_2 - var_57_5 + 1

	ipairs = var_10

	for iter_57_6, iter_57_7 in var_10(var_57_3) do
		iter_57_7.sortingOrder = var_57_14 + (iter_57_6 - 1)
	end

	local var_57_15 = var_57_14 + 1

	ipairs = var_11

	for iter_57_8, iter_57_9 in var_11(var_6) do
		iter_57_9.sortingOrder = var_57_14 + (iter_57_9.sortingOrder - var_57_4)

		if var_57_14 < var_16 then
			var_57_15 = var_16
		end
	end

	ipairs = var_11

	for iter_57_10, iter_57_11 in var_11(var_57_12) do
		local var_57_16 = var_57_14 + (var_57_13[iter_57_10] - var_57_4)

		ReflectionHelp = var_1_10018
		var_1_10018 = var_1_10018.RefSetProperty
		typeof = var_1_10019

		var_1_10018(var_1_10019("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_57_11, var_57_16)

		if var_57_14 < var_57_16 then
			var_57_15 = var_57_16
		end
	end

	return var_57_15
end

local function var_0_9(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = arg_58_0
	local var_58_1 = arg_58_0.GetComponentsInChildren

	typeof = var_1_10005
	Canvas = var_1_10006

	local var_58_2 = var_58_1(var_58_0, var_1_10005(var_1_10006))
	local var_58_3 = var_3.ToTable(var_58_2)
	local var_58_4 = arg_58_0
	local var_58_5 = arg_58_0.GetComponentsInChildren

	typeof = var_1_10006

	local var_58_6 = var_58_5(var_58_4, var_1_10006("UnityEngine.ParticleSystemRenderer"))
	local var_58_7 = var_4.ToTable(var_58_6)

	math = var_58_6

	local var_58_8 = var_58_6.huge

	if #var_58_3 == 0 then
		var_58_8 = 0
	else
		ipairs = var_6

		for iter_58_0, iter_58_1 in var_6(var_58_3) do
			if iter_58_1.sortingOrder < var_58_8 then
				var_58_8 = var_11
			end
		end
	end

	local var_58_9 = {}

	ipairs = var_7

	for iter_58_2, iter_58_3 in var_7(var_58_7) do
		ReflectionHelp = var_1_10012
		var_1_10012 = var_1_10012.RefGetProperty
		typeof = var_1_10013
		var_58_9[iter_58_2] = var_1_10012(var_1_10013("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_58_3)

		if var_1_10012 < var_58_8 then
			var_58_8 = var_1_10012
		end
	end

	local var_58_10 = arg_58_2 + 1 - var_58_8

	ipairs = var_9

	for iter_58_4, iter_58_5 in var_9(var_58_3) do
		iter_58_5.sortingOrder = var_58_10 + iter_58_5.sortingOrder

		local var_58_11

		if var_58_11 < var_14 then
			var_58_11 = var_14
		end
	end

	ipairs = var_9

	for iter_58_6, iter_58_7 in var_9(var_58_7) do
		local var_58_12 = var_58_10 + var_58_9[iter_58_6]

		ReflectionHelp = var_1_10016
		var_1_10016 = var_1_10016.RefSetProperty
		typeof = var_1_10017

		var_1_10016(var_1_10017("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_58_7, var_58_12)

		if var_58_11 < var_58_12 then
			var_58_11 = var_58_12
		end
	end

	return var_58_11
end

function var_0_1.UpdateSpinePainting(arg_59_0, arg_59_1, arg_59_2, arg_59_3, arg_59_4)
	local function var_59_0(arg_60_0)
		local var_60_0 = arg_59_2
		local var_60_1 = var_1.Find(var_60_0, "spine")
		local var_60_2 = arg_59_2
		local var_60_3 = var_2.Find(var_60_2, "spinebg")
		local var_60_4 = arg_59_1
		local var_60_5 = var_3.GetVirtualShip(var_60_4)

		SpinePainting = var_60_4

		local var_60_6 = var_60_4.GenerateData
		local var_60_7 = {
			ship = var_60_5
		}
		local var_60_8 = arg_59_1

		var_60_7.position = var_6.GetSpinePosition(var_60_8)
		var_60_7.parent = var_60_1
		var_60_7.effectParent = var_60_3

		local var_60_9 = var_60_6(var_60_7)

		setActive = var_60_7

		local var_60_10 = var_60_3
		local var_60_11 = arg_59_1

		var_60_7(var_60_10, not var_7.IsHideSpineBg(var_60_11))

		SpinePainting = var_60_7

		local var_60_12 = var_60_7.New(var_60_9, function(arg_61_0)
			local var_61_0 = arg_61_0._go
			local var_61_1 = arg_59_1

			var_61_0.name = var_2.GetPainting(var_61_1)

			local var_61_2 = arg_59_0.sortingOrder
			local var_61_3 = arg_59_1

			if not var_2.GetSpineOrderIndex(var_61_3) then
				var_61_2 = var_0_8(var_60_1, var_60_3, arg_59_0.sortingOrder)
			else
				var_61_2 = var_0_9(var_60_1, var_2, arg_59_0.sortingOrder)
			end

			GetOrAddComponent = var_61_3

			local var_61_4 = arg_59_0.front

			typeof = var_3_10005
			Canvas = var_3_10006

			local var_61_5 = var_61_3(var_61_4, var_3_10005(var_3_10006))

			GetOrAddComponent = var_61_4

			local var_61_6 = arg_59_0.front

			typeof = var_3_10006
			GraphicRaycaster = var_3_10007

			var_61_4(var_61_6, var_3_10006(var_3_10007))

			var_61_5.overrideSorting = true
			var_61_5.sortingOrder = var_61_2 + 1

			local var_61_7 = arg_59_0

			var_4.UpdateSpineExpression(var_61_7, arg_61_0, arg_59_1)

			if arg_60_0 then
				arg_60_0()
			end

			return
		end)

		arg_59_0.spinePainings[arg_59_2] = var_60_12

		return
	end

	if not arg_59_3 and arg_59_0.spinePainings[arg_59_2] then
		arg_59_0:UpdateSpineExpression(arg_59_0.spinePainings[arg_59_2], arg_59_1)
		arg_59_4()
	else
		var_59_0(arg_59_4)
	end

	return
end

function var_0_1.UpdateSpineExpression(arg_62_0, arg_62_1, arg_62_2)
	if arg_62_2:GetSpineExPression() then
		arg_62_1:SetAction(var_3, 1)
	else
		arg_62_1:SetEmptyAction(1)
	end

	return
end

function var_0_1.UpdateMeshPainting(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4, arg_63_5)
	local var_63_0 = arg_63_1:GetPainting()
	local var_63_1 = false

	local function var_63_2()
		local var_64_0 = arg_63_1

		if var_0.IsShowNPainting(var_64_0) then
			checkABExist = var_0

			if var_0("painting/" .. var_63_0 .. "_n") then
				var_63_0 = var_63_0 .. "_n"
			end
		end

		local var_64_1 = arg_63_1

		if var_0.IsShowWJZPainting(var_64_1) then
			checkABExist = var_0

			if var_0("painting/" .. var_63_0 .. "_wjz") then
				var_63_0 = var_63_0 .. "_wjz"
			end
		end

		setPaintingPrefab = var_0

		var_0(arg_63_2, var_63_0, "duihua")

		return
	end

	if var_63_0 then
		findTF = var_1_10009

		local var_63_3 = var_1_10009(arg_63_2, "fitter").childCount

		if arg_63_4 or var_63_3 <= 0 then
			var_63_2()
		end

		local var_63_4 = arg_63_1
		local var_63_5 = arg_63_1.GetPaintingDir(var_63_4)

		math = var_63_4

		local var_63_6 = var_63_4.abs(var_63_5)

		if arg_63_1:ShouldFlipPaintingY() then
			var_63_6 = -var_63_6
		end

		Vector3 = var_12
		arg_63_2.localScale = var_12(var_63_5, var_63_6, 1)
		findTF = var_12

		local var_63_7 = var_12(arg_63_2, "fitter")
		local var_63_8 = var_12.GetChild(var_63_7, 0)

		var_63_8.name = var_63_0

		arg_63_0:UpdateActorPostion(arg_63_2, arg_63_1)
		arg_63_0:UpdateExpression(var_63_8, arg_63_1)
		arg_63_0:AddGlitchArtEffectForPating(arg_63_2, var_63_8, arg_63_1)
		arg_63_2:SetAsLastSibling()

		if arg_63_1:ShouldGrayPainting() then
			setGray = var_13

			var_13(var_63_8, true, true)
		end

		findTF = var_13

		if var_13(var_63_8, "shadow") then
			setActive = var_14

			var_14(var_13, arg_63_1:ShouldFaceBlack())
		end

		if arg_63_1:GetPaintingAlpha() then
			arg_63_0:setPaintingAlpha(arg_63_2, var_14)
		end
	end

	arg_63_5()

	return
end

local function var_0_10(arg_65_0)
	local var_65_0 = arg_65_0.name

	if arg_65_0.showNPainting then
		checkABExist = var_2

		if var_2("painting/" .. var_65_0 .. "_n") then
			var_65_0 = var_65_0 .. "_n"
		end
	end

	return var_65_0
end

function var_0_1.InitSubPainting(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	local function var_66_0(arg_67_0, arg_67_1)
		local var_67_0 = var_0_10(arg_67_0)

		setPaintingPrefab = var_3

		var_3(arg_67_1, var_67_0, "duihua")

		findTF = var_3

		local var_67_1 = var_3(arg_67_1, "fitter")
		local var_67_2 = var_3.GetChild(var_67_1, 0)

		findTF = var_67_1

		local var_67_3 = var_67_1(var_67_2, "face")
		local var_67_4 = arg_67_0.expression

		if not arg_67_0.expression and arg_67_0.name then
			ShipExpressionHelper = var_6

			if var_6.DefaultFaceless(arg_67_0.name) then
				ShipExpressionHelper = var_6
				var_67_4 = var_6.GetDefaultFace(arg_67_0.name)
			end
		end

		if var_67_4 then
			setActive = var_6

			var_6(var_67_3, true)

			GetSpriteFromAtlas = var_6

			local var_67_5 = var_6("paintingface/" .. arg_67_0.name, arg_67_0.expression)

			setImageSprite = var_2_10007

			var_2_10007(var_67_3, var_67_5)
		end

		if arg_67_0.pos then
			setAnchoredPosition = var_6

			var_6(arg_67_1, arg_67_0.pos)
		end

		if arg_67_0.dir then
			local var_67_6 = arg_67_1.transform

			Vector3 = var_2_10007
			var_67_6.localScale = var_2_10007(arg_67_0.dir, 1, 1)
		end

		if arg_67_0.paintingNoise then
			local var_67_7 = arg_66_0

			var_6.AddGlitchArtEffectForPating(var_67_7, arg_67_1, var_67_2, arg_66_3)
		end

		return
	end

	arg_66_1:make(function(arg_68_0, arg_68_1, arg_68_2)
		UIItemList = var_2_10003

		if arg_68_0 == var_2_10003.EventUpdate then
			var_66_0(arg_66_2[arg_68_1 + 1], arg_68_2)
		end

		return
	end)
	arg_66_1:align(#arg_66_2)

	return
end

function var_0_1.DisappearSubPainting(arg_69_0, arg_69_1, arg_69_2, arg_69_3)
	local var_69_0 = arg_69_2:GetSubPaintings()
	local var_69_1, var_69_2 = arg_69_2:GetDisappearTime()
	local var_69_3 = arg_69_2:GetDisappearSeq()
	local var_69_4 = {}
	local var_69_5 = {}

	ipairs = var_1_10010

	for iter_69_0, iter_69_1 in var_1_10010(var_69_0) do
		table = var_1_10015

		var_1_10015.insert(var_69_5, iter_69_1)
	end

	ipairs = var_10

	for iter_69_2, iter_69_3 in var_10(var_69_3) do
		local var_69_6 = iter_69_3

		table = var_1_10016

		var_1_10016.insert(var_69_4, function(arg_70_0)
			ipairs = var_2_10001

			for iter_70_0, iter_70_1 in var_2_10001(var_69_5) do
				if iter_70_1.actor == var_69_6 then
					table = var_6

					var_6.remove(var_69_5, iter_70_0)

					break
				end
			end

			local var_70_0 = arg_69_0

			var_1.InitSubPainting(var_70_0, arg_69_1, var_69_5, arg_69_2)

			local var_70_1 = arg_69_0

			var_1.DelayCall(var_70_1, var_69_2, arg_70_0)

			return
		end)
	end

	local var_69_7 = arg_69_1.container

	var_10.SetAsFirstSibling(var_69_7)
	arg_69_0:DelayCall(var_69_1, function()
		seriesAsync = var_2_10000

		var_2_10000(var_69_4, function()
			local var_72_0 = arg_69_1.container

			var_0.SetAsLastSibling(var_72_0)
			arg_69_3()

			return
		end)

		return
	end)

	return
end

function var_0_1.UpdateActorPostion(arg_73_0, arg_73_1, arg_73_2)
	if arg_73_2:GetPaitingOffst() then
		local var_73_0 = arg_73_1.localPosition

		Vector3 = var_1_10005

		local var_73_1 = var_73_0.x
		local var_73_2

		if not var_3.x then
			var_73_2 = 0
		end

		local var_73_3 = var_73_1 + var_73_2
		local var_73_4 = var_73_0.y
		local var_73_5

		if not var_3.y then
			var_73_5 = 0
		end

		arg_73_1.localPosition = var_1_10005(var_73_3, var_73_4 + var_73_5, 0)
	end

	return
end

function var_0_1.UpdateExpression(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = arg_74_2
	local var_74_1 = arg_74_2.GetExPression(var_74_0)

	findTF = var_74_0

	local var_74_2 = var_74_0(arg_74_1, "face")
	local var_74_4

	if var_74_1 then
		local var_74_3 = arg_74_2

		var_74_4 = arg_74_2.GetPainting(var_74_3)
		GetSpriteFromAtlas = var_74_3

		local var_74_5 = var_74_3("paintingface/" .. var_74_4, var_74_1)

		setActive = var_7

		var_7(var_74_2, true)

		setImageSprite = var_7

		var_7(var_74_2, var_74_5)
	else
		setActive = var_74_4

		var_74_4(var_74_2, false)
	end

	return
end

function var_0_1.StartPaintingActions(arg_75_0, arg_75_1, arg_75_2, arg_75_3)
	local var_75_0 = {
		function(arg_76_0)
			local var_76_0 = arg_75_0

			var_1.StartPatiningMoveAction(var_76_0, arg_75_1, arg_75_2, arg_76_0)

			return
		end,
		function(arg_77_0)
			local var_77_0 = arg_75_0

			var_1.StartPatiningShakeAction(var_77_0, arg_75_1, arg_75_2, arg_77_0)

			return
		end,
		function(arg_78_0)
			local var_78_0 = arg_75_0

			var_1.StartPatiningZoomAction(var_78_0, arg_75_1, arg_75_2, arg_78_0)

			return
		end,
		function(arg_79_0)
			local var_79_0 = arg_75_0

			var_1.StartPatiningRotateAction(var_79_0, arg_75_1, arg_75_2, arg_79_0)

			return
		end
	}

	parallelAsync = var_5

	var_5(var_75_0, function()
		if arg_75_3 then
			arg_75_3()
		end

		return
	end)

	return
end

function var_0_1.StartPatiningShakeAction(arg_81_0, arg_81_1, arg_81_2, arg_81_3)
	local var_81_0 = arg_81_2
	local var_81_1 = arg_81_2.GetPaintingAction

	DialogueStep = var_1_10006

	if not var_81_1(var_81_0, var_1_10006.PAINTING_ACTION_SHAKE) then
		arg_81_3()

		return
	end

	local function var_81_2(arg_82_0, arg_82_1)
		local var_82_0

		if not arg_82_0.x then
			var_82_0 = 0
		end

		local var_82_1

		if not arg_82_0.y then
			var_82_1 = 10
		end

		local var_82_2

		if not arg_82_0.dur then
			var_82_2 = 1
		end

		local var_82_3

		if not arg_82_0.delay then
			var_82_3 = 0
		end

		local var_82_4

		if not arg_82_0.number then
			var_82_4 = 1
		end

		tf = var_2_10007

		local var_82_5 = var_2_10007(arg_81_1).localPosition
		local var_82_6 = arg_81_0
		local var_82_7 = var_8.TweenMove
		local var_82_8 = arg_81_1

		Vector3 = var_2_10011

		var_82_7(var_82_6, var_82_8, var_2_10011(var_82_5.x + var_82_0, var_82_5.y + var_82_1, 0), var_82_2, var_82_4, var_82_3, arg_82_1)

		return
	end

	local var_81_3 = {}

	pairs = var_1_10007

	for iter_81_0, iter_81_1 in var_1_10007(var_4) do
		table = var_1_10012

		var_1_10012.insert(var_81_3, function(arg_83_0)
			var_81_2(iter_81_1, arg_83_0)

			return
		end)
	end

	parallelAsync = var_7

	var_7(var_81_3, function()
		if arg_81_3 then
			arg_81_3()
		end

		return
	end)

	return
end

function var_0_1.StartPatiningZoomAction(arg_85_0, arg_85_1, arg_85_2, arg_85_3)
	local var_85_0 = arg_85_2
	local var_85_1 = arg_85_2.GetPaintingAction

	DialogueStep = var_1_10006

	if not var_85_1(var_85_0, var_1_10006.PAINTING_ACTION_ZOOM) then
		arg_85_3()

		return
	end

	local function var_85_2(arg_86_0, arg_86_1)
		if not arg_86_0.from then
			local var_86_0 = {
				0,
				0,
				0
			}
		end

		local var_86_1

		if not arg_86_0.to then
			var_86_1 = {
				1,
				1,
				1
			}
		end

		local var_86_2

		if not arg_86_0.dur then
			var_86_2 = 0
		end

		local var_86_3

		if not arg_86_0.delay then
			var_86_3 = 0
		end

		local var_86_4 = arg_85_0
		local var_86_5 = var_6.TweenScale
		local var_86_6 = arg_85_1

		Vector3 = var_2_10009

		var_86_5(var_86_4, var_86_6, var_2_10009(var_86_1[1], var_86_1[2], var_86_1[3]), var_86_2, var_86_3, arg_86_1)

		return
	end

	local var_85_3 = {}

	pairs = var_1_10007

	for iter_85_0, iter_85_1 in var_1_10007(var_4) do
		table = var_1_10012

		var_1_10012.insert(var_85_3, function(arg_87_0)
			var_85_2(iter_85_1, arg_87_0)

			return
		end)
	end

	parallelAsync = var_7

	var_7(var_85_3, function()
		if arg_85_3 then
			arg_85_3()
		end

		return
	end)

	return
end

function var_0_1.StartPatiningRotateAction(arg_89_0, arg_89_1, arg_89_2, arg_89_3)
	local var_89_0 = arg_89_2
	local var_89_1 = arg_89_2.GetPaintingAction

	DialogueStep = var_1_10006

	if not var_89_1(var_89_0, var_1_10006.PAINTING_ACTION_ROTATE) then
		arg_89_3()

		return
	end

	local function var_89_2(arg_90_0, arg_90_1)
		local var_90_0 = arg_90_0.value
		local var_90_1

		if not arg_90_0.dur then
			var_90_1 = 1
		end

		local var_90_2

		if not arg_90_0.number then
			var_90_2 = 1
		end

		local var_90_3

		if not arg_90_0.delay then
			var_90_3 = 0
		end

		local var_90_4 = arg_89_0

		var_6.TweenRotate(var_90_4, arg_89_1, var_90_0, var_90_1, var_90_2, var_90_3, arg_90_1)

		return
	end

	local var_89_3 = {}

	pairs = var_1_10007

	for iter_89_0, iter_89_1 in var_1_10007(var_4) do
		table = var_1_10012

		var_1_10012.insert(var_89_3, function(arg_91_0)
			var_89_2(iter_89_1, arg_91_0)

			return
		end)
	end

	parallelAsync = var_7

	var_7(var_89_3, function()
		if arg_89_3 then
			arg_89_3()
		end

		return
	end)

	return
end

function var_0_1.StartPatiningMoveAction(arg_93_0, arg_93_1, arg_93_2, arg_93_3)
	local var_93_0 = arg_93_2
	local var_93_1 = arg_93_2.GetPaintingAction

	DialogueStep = var_1_10006

	if not var_93_1(var_93_0, var_1_10006.PAINTING_ACTION_MOVE) then
		arg_93_3()

		return
	end

	local function var_93_2(arg_94_0, arg_94_1)
		local var_94_0

		if not arg_94_0.x then
			var_94_0 = 0
		end

		local var_94_1

		if not arg_94_0.y then
			var_94_1 = 0
		end

		local var_94_2

		if not arg_94_0.dur then
			var_94_2 = 1
		end

		local var_94_3

		if not arg_94_0.delay then
			var_94_3 = 0
		end

		tf = var_2_10006

		local var_94_4 = var_2_10006(arg_93_1).localPosition
		local var_94_5 = arg_93_0
		local var_94_6 = var_7.TweenMove
		local var_94_7 = arg_93_1

		Vector3 = var_2_10010

		var_94_6(var_94_5, var_94_7, var_2_10010(var_94_4.x + var_94_0, var_94_4.y + var_94_1, 0), var_94_2, 1, var_94_3, arg_94_1)

		return
	end

	local var_93_3 = {}

	pairs = var_1_10007

	for iter_93_0, iter_93_1 in var_1_10007(var_4) do
		table = var_1_10012

		var_1_10012.insert(var_93_3, function(arg_95_0)
			var_93_2(iter_93_1, arg_95_0)

			return
		end)
	end

	parallelAsync = var_7

	var_7(var_93_3, function()
		if arg_93_3 then
			arg_93_3()
		end

		return
	end)

	return
end

function var_0_1.StartMovePrevPaintingToSide(arg_97_0, arg_97_1, arg_97_2, arg_97_3)
	if not arg_97_1:GetPaintingMoveToSide() or not arg_97_2 then
		arg_97_3()

		return
	end

	if not arg_97_0:GetSideTF(arg_97_2:GetSide()) then
		arg_97_3()

		return
	end

	local var_97_0 = var_4.time
	local var_97_1 = var_4.side

	if not arg_97_0:GetSideTF(var_97_1) then
		arg_97_3()

		return
	end

	local var_97_3

	if arg_97_1.side ~= arg_97_2.side then
		if var_5:Find("fitter").childCount > 0 then
			local var_97_2 = var_5:Find("fitter")

			var_97_3 = var_97_3.GetChild(var_97_2, 0)
			removeAllChildren = var_97_2

			var_97_2(var_8:Find("fitter"))

			setParent = var_97_2

			local var_97_4 = var_97_3
			local var_97_5 = var_8

			var_97_2(var_97_4, var_8.Find(var_97_5, "fitter"))

			local var_97_6 = arg_97_2
			local var_97_7 = arg_97_2.GetPaintingDir(var_97_6)

			Vector3 = var_97_6

			local var_97_8 = var_97_7

			math = var_97_5
			var_8.localScale = var_97_6(var_97_8, var_97_5.abs(var_97_7), 1)
		end
	else
		local var_97_9 = arg_97_2

		if arg_97_2.GetPainting(var_97_9) then
			setPaintingPrefab = var_97_9

			var_97_9(var_8, var_97_3, "duihua")
		end
	end

	tf = var_97_3

	local var_97_10 = var_97_3(var_8).localPosition

	arg_97_0:TweenValue(var_8, var_5.localPosition.x, var_97_10.x, var_97_0, 0, function(arg_98_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(var_0, {
			x = arg_98_0
		})

		return
	end, arg_97_3)

	Vector2 = var_10
	var_8.localPosition = var_10(var_5.localPosition.x, var_8.localPosition.y, 0)

	return
end

local function var_0_11(arg_99_0, arg_99_1, arg_99_2, arg_99_3, arg_99_4)
	local var_99_0 = arg_99_1
	local var_99_1 = arg_99_1.GetComponentsInChildren

	typeof = var_1_10007
	Image = var_1_10008

	local var_99_2 = var_99_1(var_99_0, var_1_10007(var_1_10008))
	local var_99_3 = var_5.ToTable(var_99_2)

	ipairs = var_99_2

	for iter_99_0, iter_99_1 in var_99_2(var_99_3) do
		if iter_99_1.gameObject.name == "temp_mask" then
			local var_99_4

			if not arg_99_4 or not arg_99_0.maskMaterial then
				var_99_4 = arg_99_0.maskMaterialForWithLayer
			end

			iter_99_1.material = var_99_4
		elseif iter_99_1.gameObject.name == "face" then
			iter_99_1.material = arg_99_0.glitchArtMaterial
		elseif arg_99_3.hasPaintbg and iter_99_1.gameObject == arg_99_2.gameObject then
			iter_99_1.material = arg_99_0.glitchArtMaterialForPaintingBg
		else
			iter_99_1.material = arg_99_0.glitchArtMaterialForPainting
		end
	end

	return
end

local function var_0_12(arg_100_0, arg_100_1, arg_100_2, arg_100_3, arg_100_4)
	local var_100_0 = arg_100_1
	local var_100_1 = arg_100_1.GetComponentsInChildren

	typeof = var_1_10007
	Image = var_1_10008

	local var_100_2 = var_100_1(var_100_0, var_1_10007(var_1_10008))
	local var_100_3 = var_5.ToTable(var_100_2)
	local var_100_4 = {}
	local var_100_5 = arg_100_2
	local var_100_6 = arg_100_2.GetComponent

	typeof = var_1_10009
	Image = var_1_10010

	if var_100_6(var_100_5, var_1_10009(var_1_10010)) then
		table = var_100_5

		var_100_5.insert(var_100_4, var_7.gameObject)
	end

	for iter_100_0 = 1, arg_100_3 - 1 do
		local var_100_7 = arg_100_4
		local var_100_8 = arg_100_4.GetChild(var_100_7, iter_100_0 - 1)

		table = var_100_7

		var_100_7.insert(var_100_4, var_100_8.gameObject)
	end

	ipairs = var_8

	for iter_100_1, iter_100_2 in var_8(var_100_3) do
		if iter_100_2.gameObject.name == "temp_mask" then
			iter_100_2.material = arg_100_0.maskMaterial
		elseif iter_100_2.gameObject.name == "face" then
			iter_100_2.material = arg_100_0.glitchArtMaterial
		else
			table = var_13

			if var_13.contains(var_100_4, iter_100_2.gameObject) then
				iter_100_2.material = arg_100_0.glitchArtMaterialForPaintingBg
			else
				iter_100_2.material = arg_100_0.glitchArtMaterialForPainting
			end
		end
	end

	return
end

function var_0_1.AddGlitchArtEffectForPating(arg_101_0, arg_101_1, arg_101_2, arg_101_3)
	local var_101_0 = arg_101_3:ShouldAddGlitchArtEffect()
	local var_101_1 = arg_101_3
	local var_101_2 = arg_101_3.IsNoHeadPainting(var_101_1)

	if var_101_0 and arg_101_3:GetExPression() ~= nil and not var_101_2 then
		local var_101_3 = arg_101_2

		var_101_1 = arg_101_2.Find(var_101_3, "face")
		cloneTplTo = var_101_3
		var_1_10009 = var_101_3(var_101_1, var_101_1.parent, "temp_mask")

		var_7.SetAsFirstSibling(var_1_10009)

		var_1_10009 = arg_101_2
		var_1_10008 = arg_101_2.Find(var_1_10009, "layers")
		IsNil = var_1_10009

		if not var_1_10009(var_1_10008) and arg_101_3:GetPaintingRwIndex() > 0 then
			var_0_12(arg_101_0, arg_101_1, arg_101_2, arg_101_3:GetPaintingRwIndex(), var_1_10008)
		else
			var_0_11(arg_101_0, arg_101_1, arg_101_2, arg_101_3, var_1_10009)
		end
	elseif var_101_0 then
		local var_101_4 = arg_101_1

		var_101_1 = arg_101_1.GetComponentsInChildren
		typeof = var_1_10008
		Image = var_1_10009

		local var_101_5 = var_101_1(var_101_4, var_1_10008(var_1_10009))

		var_101_1 = var_101_1.ToTable(var_101_5)
		ipairs = var_101_5

		for iter_101_0, iter_101_1 in var_101_5(var_101_1) do
			iter_101_1.material = arg_101_0.glitchArtMaterial
		end
	end

	if var_101_0 then
		GameObject = var_101_1

		if var_101_1.Find("/OverlayCamera/Overlay/UIMain/AwardInfoUI(Clone)/items/SpriteMask") and var_6.activeInHierarchy then
			setActive = var_7

			var_7(var_6, false)

			arg_101_0.spriteMask = var_6
		end
	end

	return
end

function var_0_1.UpdateContent(arg_102_0, arg_102_1, arg_102_2)
	local function var_102_0()
		setActive = var_2_10000

		var_2_10000(arg_102_0.nextTr, true)
		arg_102_2()

		return
	end

	setActive = var_1_10004

	var_1_10004(arg_102_0.dialoguePanel, not arg_102_1:ShouldHideDialogue())

	ipairs = var_1_10004

	for iter_102_0, iter_102_1 in var_1_10004(arg_102_0.tags) do
		setActive = var_1_10009

		var_1_10009(iter_102_1, iter_102_0 == arg_102_1:GetTag())
	end

	local var_102_1 = arg_102_0.conentTxt
	local var_102_2 = arg_102_1
	local var_102_3

	if not arg_102_1.GetFontSize(var_102_2) then
		var_102_3 = arg_102_0.defualtFontSize
	end

	var_102_1.fontSize = var_102_3

	local var_102_4 = arg_102_1:GetContent()

	arg_102_0.conentTxt.text = var_102_4

	local var_102_5 = arg_102_0.conentTxt

	Color = var_102_2
	var_102_5.color = var_102_2.NewHex(arg_102_1:GetContentColor())

	local var_102_6 = 999

	if var_102_4 and var_102_4 ~= "" then
		System = var_6
		var_102_6 = var_6.String.New(var_102_4).Length
	end

	if var_102_4 and var_102_4 ~= "" and var_102_4 ~= "…" and #var_102_4 > 1 and var_102_6 > 1 then
		arg_102_0:UpdateTypeWriter(arg_102_1, var_102_0)
	else
		var_102_0()
	end

	local var_102_7 = false
	local var_102_8, var_102_9, var_102_10, var_102_11 = arg_102_0:GetSideTF(arg_102_1:GetSide())

	if var_102_9 then
		var_102_7 = arg_102_1:GetNameWithColor() and var_11 ~= ""
		setActive = var_1_10013

		var_1_10013(var_102_9, var_12)

		if var_12 then
			var_1_10013 = arg_102_1:GetNameColorCode()

			local var_102_12 = var_102_9:Find("Text")
			local var_102_13 = var_14.GetComponent

			typeof = var_16
			Outline = var_1_10017

			local var_102_14 = var_102_13(var_102_12, var_16(var_1_10017))

			Color = var_102_12
			var_102_14.effectColor = var_102_12.NewHex(var_1_10013)
		end

		var_102_10.text = var_11
		setText = var_1_10013

		local var_102_15 = var_102_10.gameObject.transform

		var_1_10013(var_14.Find(var_102_15, "subText"), arg_102_1:GetSubActorName())
	end

	local var_102_16 = arg_102_0.script

	if var_11.IsDialogueStyle2(var_102_16) then
		setActive = var_11

		var_11(arg_102_0.tag4Dialog2, not var_102_7)
	end

	return
end

function var_0_1.SetContentBgAlpha(arg_104_0, arg_104_1)
	if arg_104_0.contentBgAlpha ~= arg_104_1 then
		ipairs = var_2

		for iter_104_0, iter_104_1 in var_2(arg_104_0.contentBgs) do
			GetOrAddComponent = var_1_10007

			local var_104_0 = iter_104_1

			typeof = var_1_10009
			CanvasGroup = var_1_10010
			var_1_10007 = var_1_10007(var_104_0, var_1_10009(var_1_10010))
			var_1_10007.alpha = arg_104_1
		end

		arg_104_0.contentBgAlpha = arg_104_1
	end

	return
end

function var_0_1.GetSideTF(arg_105_0, arg_105_1)
	local var_105_0
	local var_105_1
	local var_105_2
	local var_105_3

	DialogueStep = var_1_10006

	local var_105_4

	if var_1_10006.SIDE_LEFT == arg_105_1 then
		var_105_4 = arg_105_0.actorLeft
		var_105_1, var_105_2, var_105_3 = arg_105_0.nameTr, arg_105_0.nameTxt, arg_105_0.subActorLeft
		var_105_0 = var_105_4
	else
		DialogueStep = var_105_4

		local var_105_5

		if var_105_4.SIDE_RIGHT == arg_105_1 then
			var_105_5 = arg_105_0.actorRgiht
			var_105_1, var_105_2, var_105_3 = arg_105_0.nameTr, arg_105_0.nameTxt, arg_105_0.subActorRgiht
			var_105_0 = var_105_5
		else
			DialogueStep = var_105_5

			if var_105_5.SIDE_MIDDLE == arg_105_1 then
				var_105_0, var_105_1, var_105_2, var_105_3 = arg_105_0.actorMiddle, arg_105_0.nameTr, arg_105_0.nameTxt, arg_105_0.subActorMiddle
			end
		end
	end

	return var_105_0, var_105_1, var_105_2, var_105_3
end

function var_0_1.RecyclesSubPantings(arg_106_0, arg_106_1)
	arg_106_1:each(function(arg_107_0, arg_107_1)
		local var_107_0 = arg_106_0

		var_2.RecyclePainting(var_107_0, arg_107_1)

		return
	end)

	return
end

local function var_0_13(arg_108_0)
	if arg_108_0:Find("fitter").childCount == 0 then
		return
	end

	local var_108_0 = arg_108_0:Find("fitter")

	if var_1.GetChild(var_108_0, 0) then
		findTF = var_108_0

		if var_108_0(var_1, "shadow") then
			setActive = var_3

			var_3(var_2, false)
		end

		local var_108_1 = arg_108_0
		local var_108_2 = arg_108_0.GetComponentsInChildren

		typeof = var_1_10005
		Image = var_1_10006

		local var_108_3 = var_108_2(var_108_1, var_1_10005(var_1_10006))
		local var_108_4 = var_3.ToTable(var_108_3)

		ipairs = var_108_3

		for iter_108_0, iter_108_1 in var_108_3(var_108_4) do
			Color = var_1_10009
			var_1_10009 = var_1_10009.white

			if iter_108_1.material ~= iter_108_1.defaultGraphicMaterial then
				iter_108_1.material = iter_108_1.defaultGraphicMaterial
			end

			local var_108_5 = iter_108_1.material

			var_10.SetColor(var_108_5, "_Color", var_1_10009)
		end

		setGray = var_4

		var_4(var_1, false, true)

		retPaintingPrefab = var_4

		var_4(arg_108_0, var_1.name)

		local var_108_6 = var_1

		if var_1.Find(var_108_6, "temp_mask") then
			Destroy = var_108_6

			var_108_6(var_4.gameObject)
		end
	end

	return
end

function var_0_1.ClearMeshPainting(arg_109_0, arg_109_1)
	arg_109_0:ResetMeshPainting(arg_109_1)

	if arg_109_1:Find("fitter").childCount == 0 then
		return
	end

	local var_109_0 = arg_109_1:Find("fitter")

	if var_2.GetChild(var_109_0, 0) then
		retPaintingPrefab = var_109_0

		var_109_0(arg_109_1, var_2.name)
	end

	return
end

function var_0_1.ResetMeshPainting(arg_110_0, arg_110_1)
	if arg_110_1:Find("fitter").childCount == 0 then
		return
	end

	local var_110_0 = arg_110_1:Find("fitter")

	if var_2.GetChild(var_110_0, 0) then
		findTF = var_110_0

		if var_110_0(var_2, "shadow") then
			setActive = var_4

			var_4(var_3, false)
		end

		local var_110_1 = arg_110_1
		local var_110_2 = arg_110_1.GetComponentsInChildren

		typeof = var_1_10006
		Image = var_1_10007

		local var_110_3 = var_110_2(var_110_1, var_1_10006(var_1_10007))
		local var_110_4 = var_4.ToTable(var_110_3)

		ipairs = var_110_3

		for iter_110_0, iter_110_1 in var_110_3(var_110_4) do
			Color = var_1_10010
			var_1_10010 = var_1_10010.white

			if iter_110_1.material ~= iter_110_1.defaultGraphicMaterial then
				iter_110_1.material = iter_110_1.defaultGraphicMaterial

				local var_110_5 = iter_110_1.material

				var_11.SetColor(var_110_5, "_Color", var_1_10010)
			else
				iter_110_1.material = nil
			end
		end

		setGray = var_5

		var_5(var_2, false, true)

		local var_110_6 = var_2

		if var_2.Find(var_110_6, "temp_mask") then
			Destroy = var_110_6

			var_110_6(var_5.gameObject)
		end
	end

	return
end

local function var_0_14(arg_111_0, arg_111_1)
	local var_111_0 = arg_111_0.live2dChars[arg_111_1]
	local var_111_1 = false

	if var_111_0 and var_111_0._go then
		local var_111_2 = var_111_0._go

		var_1_10004 = var_1_10004.GetComponent
		typeof = var_1_10006
		CubismRenderController = var_1_10007
		var_1_10004 = var_1_10004(var_111_2, var_1_10006(var_1_10007))
		var_1_10004.SortingOrder = 0

		var_111_0:Dispose()

		arg_111_0.live2dChars[arg_111_1] = nil
		var_111_1 = true
	end

	table = var_1_10004

	local var_111_3 = var_1_10004.getCount(arg_111_0.live2dChars) <= 0

	if var_111_1 and var_111_3 then
		RemoveComponent = var_5

		var_5(arg_111_0.front, "GraphicRaycaster")

		RemoveComponent = var_5

		var_5(arg_111_0.front, "Canvas")
	end

	return
end

local function var_0_15(arg_112_0, arg_112_1)
	local var_112_0 = arg_112_0.spinePainings[arg_112_1]
	local var_112_1 = false

	if var_112_0 then
		var_112_0:Dispose()

		var_1_10004 = arg_112_0.spinePainings
		var_1_10004[arg_112_1] = nil
		var_112_1 = true
	end

	table = var_1_10004

	local var_112_2 = var_1_10004.getCount(arg_112_0.spinePainings) <= 0

	if var_112_1 and var_112_2 then
		RemoveComponent = var_5

		var_5(arg_112_0.front, "GraphicRaycaster")

		RemoveComponent = var_5

		var_5(arg_112_0.front, "Canvas")
	end

	return
end

function var_0_1.RecyclePainting(arg_113_0, arg_113_1)
	type = var_1_10002

	if var_1_10002(arg_113_1) == "table" then
		_ = var_2

		local var_113_0 = var_2.map(arg_113_1, function(arg_114_0)
			return arg_113_0[arg_114_0]
		end)

		arg_113_0:RecyclePaintingList(var_113_0)
	else
		arg_113_0:ClearMeshPainting(arg_113_1)
		var_0_14(arg_113_0, arg_113_1)
		var_0_15(arg_113_0, arg_113_1)
	end

	return
end

function var_0_1.RecyclePaintingList(arg_115_0, arg_115_1)
	ipairs = var_1_10002

	for iter_115_0, iter_115_1 in var_1_10002(arg_115_1) do
		arg_115_0:ClearMeshPainting(iter_115_1)
		var_0_14(arg_115_0, iter_115_1)
		var_0_15(arg_115_0, iter_115_1)
	end

	return
end

function var_0_1.Resume(arg_116_0)
	var_0_1.super.Resume(arg_116_0)

	if arg_116_0.typewriterSpeed ~= 0 then
		local var_116_0 = arg_116_0.typewriter

		var_1.setSpeed(var_116_0, arg_116_0.typewriterSpeed)
	end

	return
end

function var_0_1.Pause(arg_117_0)
	var_0_1.super.Pause(arg_117_0)

	if arg_117_0.typewriterSpeed ~= 0 then
		local var_117_0 = arg_117_0.typewriter

		var_1.setSpeed(var_117_0, 0)
	end

	return
end

function var_0_1.OnClear(arg_118_0)
	if arg_118_0.spriteMask then
		setActive = var_1

		var_1(arg_118_0.spriteMask, true)

		arg_118_0.spriteMask = nil
	end

	return
end

function var_0_1.FadeOutPainting(arg_119_0, arg_119_1, arg_119_2, arg_119_3)
	local var_119_0 = arg_119_2
	local var_119_1 = arg_119_2.GetComponent

	typeof = var_1_10006
	CanvasGroup = var_1_10007

	local var_119_2 = var_119_1(var_119_0, var_1_10006(var_1_10007))

	if arg_119_1:GetFadeOutPaintingTime() <= 0 then
		arg_119_3()

		return
	end

	if arg_119_1:ShouldAddHeadMaskWhenFade() then
		arg_119_0:AddHeadMask(arg_119_2)
	end

	arg_119_0:TweenValueForcanvasGroup(var_119_2, 1, 0, var_5, 0, function()
		if var_0 then
			local var_120_0 = arg_119_0

			var_0.ClearHeadMask(var_120_0, arg_119_2)
		end

		arg_119_3()

		return
	end)

	return
end

function var_0_1.OnWillExit(arg_121_0, arg_121_1, arg_121_2, arg_121_3)
	if not arg_121_2 or not arg_121_2:IsDialogueMode() then
		arg_121_3()

		return
	end

	local var_121_0 = arg_121_0:GetRecycleActorList(arg_121_2, arg_121_1)
	local var_121_1
	local var_121_2 = arg_121_2

	if arg_121_2.ShouldMoveToSide(var_121_2) then
		var_121_2 = arg_121_0
		var_121_1 = arg_121_0.GetSideTF(var_121_2, arg_121_1:GetSide())
	end

	local var_121_3 = {}

	pairs = var_121_2

	for iter_121_0, iter_121_1 in var_121_2(var_121_0) do
		if (not var_121_1 or iter_121_1 ~= var_121_1) and iter_121_1:Find("fitter").childCount > 0 then
			table = var_12

			var_12.insert(var_121_3, function(arg_122_0)
				local var_122_0 = arg_121_0

				var_1.FadeOutPainting(var_122_0, arg_121_1, iter_121_1, arg_122_0)

				return
			end)
		end
	end

	parallelAsync = var_7

	var_7(var_121_3, arg_121_3)

	return
end

function var_0_1.OnEnd(arg_123_0)
	if arg_123_0.conentTxt then
		arg_123_0.conentTxt.fontSize = arg_123_0.defualtFontSize
		arg_123_0.conentTxt.text = ""
	end

	if arg_123_0.nameTxt then
		arg_123_0.nameTxt.text = ""
	end

	arg_123_0:ClearGlitchArtForPortrait()
	arg_123_0:ClearCanMarkNode()

	local var_123_0 = {
		"actorLeft",
		"actorMiddle",
		"actorRgiht"
	}

	arg_123_0:RecyclePainting(var_123_0)

	ipairs = var_2

	for iter_123_0, iter_123_1 in var_2({
		"actorLeft",
		"actorMiddle",
		"actorRgiht"
	}) do
		local var_123_1 = arg_123_0[iter_123_1]
		local var_123_2 = var_7.GetComponent

		typeof = var_1_10010
		CanvasGroup = var_1_10011
		var_123_2(var_123_1, var_1_10010(var_1_10011)).alpha = 1
	end

	return
end

return var_0_1
