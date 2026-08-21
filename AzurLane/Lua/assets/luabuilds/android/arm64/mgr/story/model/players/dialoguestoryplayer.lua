local var_0_0 = class("DialogueStoryPlayer", import(".StoryPlayer"))
local var_0_1 = 159
local var_0_2 = 411
local var_0_3 = 250

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.actorPanel = arg_1_0._tf:Find("actor")
	arg_1_0.actorLeft = arg_1_0.actorPanel:Find("actor_left")
	arg_1_0.initActorLeftPos = arg_1_0.actorLeft.localPosition
	arg_1_0.actorMiddle = arg_1_0.actorPanel:Find("actor_middle")
	arg_1_0.initActorMiddlePos = arg_1_0.actorMiddle.localPosition
	arg_1_0.actorRgiht = arg_1_0.actorPanel:Find("actor_right")
	arg_1_0.initActorRgihtPos = arg_1_0.actorRgiht.localPosition
	arg_1_0.sortingOrder = arg_1_0._go:GetComponent(typeof(Canvas)).sortingOrder
	arg_1_0.subActorMiddle = UIItemList.New(arg_1_0.actorPanel:Find("actor_middle/sub"), arg_1_0.actorPanel:Find("actor_middle/sub/tpl"))
	arg_1_0.subActorRgiht = UIItemList.New(arg_1_0.actorPanel:Find("actor_right/sub"), arg_1_0.actorPanel:Find("actor_right/sub/tpl"))
	arg_1_0.subActorLeft = UIItemList.New(arg_1_0.actorPanel:Find("actor_left/sub"), arg_1_0.actorPanel:Find("actor_left/sub/tpl"))
	arg_1_0.glitchArtMaterial = arg_1_0._tf:Find("resource/material1"):GetComponent(typeof(Image)).material
	arg_1_0.maskMaterial = arg_1_0._tf:Find("resource/material2"):GetComponent(typeof(Image)).material
	arg_1_0.maskMaterialForWithLayer = arg_1_0._tf:Find("resource/material5"):GetComponent(typeof(Image)).material
	arg_1_0.glitchArtMaterialForPainting = arg_1_0._tf:Find("resource/material3"):GetComponent(typeof(Image)).material
	arg_1_0.glitchArtMaterialForPaintingBg = arg_1_0._tf:Find("resource/material4"):GetComponent(typeof(Image)).material
	arg_1_0.headObjectMat = arg_1_0._tf:Find("resource/material6"):GetComponent(typeof(Image)).material
	arg_1_0.headMaskMat = arg_1_0._tf:Find("resource/material7"):GetComponent(typeof(Image)).material
	arg_1_0.typewriterSpeed = 0
	arg_1_0.contentBgAlpha = 1
	arg_1_0.live2dChars = {}
	arg_1_0.spinePainings = {}

	return
end

function var_0_0.OnStart(arg_2_0, arg_2_1)
	arg_2_0.nextTr = arg_2_0.dialogueWin:Find("next")
	arg_2_0.conentTr = arg_2_0.dialogueWin:Find("content")
	arg_2_0.conentTxt = arg_2_0.dialogueWin:Find("content"):GetComponent(typeof(Text))
	arg_2_0.typewriter = arg_2_0.dialogueWin:Find("content"):GetComponent(typeof(Typewriter))
	arg_2_0.nameTr = arg_2_0.dialogueWin:Find("content/name")
	arg_2_0.tag4Dialog2 = arg_2_0.dialogueWin:Find("content/tag")
	arg_2_0.nameTxt = arg_2_0.nameTr:Find("Text"):GetComponent(typeof(Text))
	arg_2_0.portraitTr = arg_2_0.dialogueWin:Find("portrait")
	arg_2_0.conentLineTr = arg_2_0.dialogueWin:Find("line")
	arg_2_0.portraitImg = arg_2_0.portraitTr:GetComponent(typeof(Image))
	arg_2_0.tags = {
		arg_2_0.nameTr:Find("tags/1"),
		arg_2_0.nameTr:Find("tags/2")
	}
	arg_2_0.contentBgs = {
		arg_2_0.nameTr:Find("bg"),
		arg_2_0.dialogueWin:Find("bg")
	}
	arg_2_0.defualtFontSize = arg_2_0.conentTxt.fontSize

	return
end

function var_0_0.OnReset(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0:ResetActorTF(arg_3_1, arg_3_2)
	setActive(arg_3_0.nameTr, false)
	setActive(arg_3_0.nameTr, false)
	setActive(arg_3_0.dialoguePanel, true)
	setActive(arg_3_0.actorPanel, true)
	setActive(arg_3_0.nextTr, false)

	arg_3_0.conentTxt.text = ""

	local var_3_0 = arg_3_2 and arg_3_2:IsDialogueMode() and arg_3_2:ExistPortrait() and arg_3_1:ExistPortrait()

	setActive(arg_3_0.portraitTr, var_3_0)

	if not var_3_0 and arg_3_2 and arg_3_2:IsDialogueMode() and arg_3_2:ShouldGlitchArtForPortrait() then
		arg_3_0:ClearGlitchArtForPortrait()
	end

	arg_3_0:UpdateContentPosition(arg_3_1)
	arg_3_0:SetContentBgAlpha(arg_3_1:GetContentBGAlpha())
	arg_3_3()

	return
end

function var_0_0.UpdateContentPosition(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:IsMiniPortrait()

	if arg_4_1:ExistPortrait() then
		if var_4_0 then
			local var_4_1 = var_0_3 or var_0_2 or var_0_1

			arg_4_0.conentTr.offsetMin = Vector2(var_4_1, arg_4_0.conentTr.offsetMin.y)

			if var_4_0 then
				local var_4_2 = var_0_3 or var_0_1

				arg_4_0.conentLineTr.offsetMin = Vector2(var_4_2, arg_4_0.conentLineTr.offsetMin.y)

				return
			end
		end
	end
end

local function var_0_4(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return false
	end

	local var_5_0 = arg_5_0:IsLive2dPainting() and arg_5_1:Find("live2d") or arg_5_0:IsSpinePainting() and arg_5_1:Find("spine") or arg_5_1:Find("fitter")

	if var_5_0.childCount <= 0 then
		return false
	end

	return var_5_0:GetChild(0).name == arg_5_0:GetPainting()
end

function var_0_0.GetRecycleActorList(arg_6_0, arg_6_1, arg_6_2)
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
		if arg_6_2 and arg_6_2:IsDialogueMode() and arg_6_1:IsDialogueMode() and arg_6_1:IsSameSide(arg_6_2) and arg_6_1:IsSamePainting(arg_6_2) or var_0_4(arg_6_1, var_6_1) then
			-- block empty
		else
			table.insert(var_6_2, var_6_1)
		end

		if var_6_0 == DialogueStep.SIDE_MIDDLE then
			table.insert(var_6_2, arg_6_0.actorLeft)
			table.insert(var_6_2, arg_6_0.actorRgiht)
		end
	end

	return var_6_2
end

function var_0_0.ResetActorTF(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:GetSideTF((arg_7_1:GetSide()))

	if var_7_0 then
		arg_7_0:CancelTween(var_7_0.gameObject)

		var_7_0.localScale = Vector3(1, 1, 1)
		var_7_0.eulerAngles = Vector3(0, 0, 0)

		if var_7_0 == arg_7_0.actorRgiht then
			var_7_0.localPosition = arg_7_0.initActorRgihtPos
		elseif var_7_0 == arg_7_0.actorMiddle then
			var_7_0.localPosition = arg_7_0.initActorMiddlePos
		elseif var_7_0 == arg_7_0.actorLeft then
			var_7_0.localPosition = arg_7_0.initActorLeftPos
		end
	end

	local var_7_1 = arg_7_0:GetRecycleActorList(arg_7_1, arg_7_2)

	if var_7_0 and _.all(var_7_1, function(arg_8_0)
		return arg_8_0 ~= var_7_0
	end) then
		arg_7_0.paintingStay = true

		arg_7_0:ResetMeshPainting(var_7_0)

		if arg_7_1:IsSpinePainting() then
			arg_7_0:HideSpineEffect(var_7_0, arg_7_1)
		end
	end

	arg_7_0:RecyclePaintingList(var_7_1)
	arg_7_0:RecyclesSubPantings(arg_7_0.subActorMiddle)
	arg_7_0:RecyclesSubPantings(arg_7_0.subActorRgiht)
	arg_7_0:RecyclesSubPantings(arg_7_0.subActorLeft)

	for iter_7_0, iter_7_1 in ipairs({
		arg_7_0.actorLeft,
		arg_7_0.actorMiddle,
		arg_7_0.actorRgiht
	}) do
		iter_7_1:GetComponent(typeof(CanvasGroup)).alpha = 1
	end

	return
end

function var_0_0.HideSpineEffect(arg_9_0, arg_9_1)
	arg_9_0.spineEffectOrderCaches = {}

	;(function(arg_10_0)
		for iter_10_0, iter_10_1 in ipairs((arg_10_0:GetComponentsInChildren(typeof("UnityEngine.ParticleSystemRenderer")):ToTable())) do
			local var_10_0 = ReflectionHelp.RefGetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_10_1)

			ReflectionHelp.RefSetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_10_1, -1)

			arg_9_0.spineEffectOrderCaches[iter_10_1] = var_10_0
		end

		return
	end)((arg_9_1:Find("spine")))
	;(function(arg_10_0)
		for iter_10_0, iter_10_1 in ipairs((arg_10_0:GetComponentsInChildren(typeof("UnityEngine.ParticleSystemRenderer")):ToTable())) do
			local var_10_0 = ReflectionHelp.RefGetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_10_1)

			ReflectionHelp.RefSetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_10_1, -1)

			arg_9_0.spineEffectOrderCaches[iter_10_1] = var_10_0
		end

		return
	end)((arg_9_1:Find("spinebg")))

	return
end

function var_0_0.RevertSpineEffect(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_2 then
		return
	end

	;(function(arg_12_0)
		for iter_12_0, iter_12_1 in ipairs((arg_12_0:GetComponentsInChildren(typeof("UnityEngine.ParticleSystemRenderer")):ToTable())) do
			local var_12_0 = arg_11_2[iter_12_1] or 950

			ReflectionHelp.RefSetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_12_1, var_12_0)
		end

		return
	end)((arg_11_1:Find("spine")))
	var_11_0((arg_11_1:Find("spinebg")))

	return
end

function var_0_0.OnInit(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	parallelAsync({
		function(arg_14_0)
			arg_13_0:UpdateContent(arg_13_1, arg_14_0)

			return
		end,
		function(arg_15_0)
			arg_13_0:UpdatePortrait(arg_13_1, arg_15_0)

			return
		end,
		function(arg_16_0)
			arg_13_0:UpdateSubPaintings(arg_13_1, arg_16_0)

			return
		end,
		function(arg_17_0)
			arg_13_0:UpdatePainting(arg_13_1, arg_13_2, arg_17_0)

			return
		end,
		function(arg_18_0)
			arg_13_0:GrayingInPainting(arg_13_1, arg_13_2, arg_18_0)

			return
		end,
		function(arg_19_0)
			arg_13_0:StartMovePrevPaintingToSide(arg_13_1, arg_13_2, arg_19_0)

			return
		end,
		function(arg_20_0)
			arg_13_0:GrayingOutPrevPainting(arg_13_2, arg_13_1, arg_20_0)

			return
		end
	}, arg_13_3)

	return
end

function var_0_0.UpdatePortrait(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_1:ExistPortrait() then
		arg_21_2()

		return
	end

	LoadSpriteAsync("StoryIcon/" .. arg_21_1:GetPortrait(), function(arg_22_0)
		setImageSprite(arg_21_0.portraitTr, arg_22_0, true)
		setActive(arg_21_0.portraitTr, true)
		arg_21_0:AdjustPortraitPosition(arg_21_1)

		if arg_21_1:ShouldGlitchArtForPortrait() then
			arg_21_0:SetGlitchArtForPortrait()
		else
			arg_21_0:ClearGlitchArtForPortrait()
		end

		arg_21_2()

		return
	end)

	return
end

function var_0_0.AdjustPortraitPosition(arg_23_0, arg_23_1)
	if arg_23_1:IsMiniPortrait() then
		setAnchoredPosition3D(arg_23_0.portraitTr, {
			x = 211,
			y = 133
		})

		goto label_23_0
	end

	::label_23_0::

	if arg_23_0.portraitTr.sizeDelta.x < var_0_2 then
		do
			local var_23_0 = var_0_2 or 539

			setAnchoredPosition3D(arg_23_0.portraitTr, {
				y = 0,
				x = var_23_0
			})
		end

		return
	end
end

function var_0_0.SetGlitchArtForPortrait(arg_24_0)
	if arg_24_0.portraitImg.material ~= arg_24_0.glitchArtMaterialForPainting then
		arg_24_0.portraitImg.material = arg_24_0.glitchArtMaterialForPainting
	end

	return
end

function var_0_0.ClearGlitchArtForPortrait(arg_25_0)
	if not arg_25_0.portraitImg then
		return
	end

	if arg_25_0.portraitImg.material ~= arg_25_0.portraitImg.defaultGraphicMaterial then
		arg_25_0.portraitImg.material = arg_25_0.portraitImg.defaultGraphicMaterial
	end

	return
end

function var_0_0.UpdateSubPaintings(arg_26_0, arg_26_1, arg_26_2)
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

function var_0_0.OnStartUIAnimations(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_1:ShouldShakeDailogue() then
		arg_27_2()

		return
	end

	local var_27_0 = arg_27_1:GetShakeDailogueData()

	arg_27_0:TweenMovex(arg_27_0.dialogueWin, var_27_0.x, arg_27_0.dialogueWin.localPosition.x, var_27_0.speed, var_27_0.delay, var_27_0.number, arg_27_2)

	return
end

function var_0_0.OnEnter(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	parallelAsync({
		function(arg_29_0)
			arg_28_0:UpdateCanMarkNode(arg_28_1, arg_29_0)

			return
		end,
		function(arg_30_0)
			arg_28_0:UpdateIcon(arg_28_1, arg_30_0)

			return
		end
	}, arg_28_3)

	return
end

local function var_0_5(arg_31_0, arg_31_1)
	LoadAnyAsync("Story/" .. arg_31_0, "", nil, arg_31_1)

	return
end

local function var_0_6(arg_32_0, arg_32_1)
	if not arg_32_1 then
		return false
	end

	return arg_32_0:GetCanMarkNodeData().name == arg_32_1.name
end

function var_0_0.UpdateCanMarkNode(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1:ExistCanMarkNode()

	if not var_33_0 or not var_0_6(arg_33_1, arg_33_0.canMarkNode) then
		arg_33_0:ClearCanMarkNode(arg_33_0.canMarkNode)
	end

	if not var_33_0 then
		arg_33_2()

		return
	end

	local var_33_1 = arg_33_1:GetCanMarkNodeData()

	local function var_33_2(arg_34_0)
		eachChild(arg_34_0, function(arg_35_0)
			local var_35_0 = table.contains(var_33_1.marks, arg_35_0.gameObject.name)

			if var_35_0 ~= isActive(arg_35_0) then
				setActive(arg_35_0, var_35_0)
			end

			return
		end)

		return
	end

	if not arg_33_0.canMarkNode then
		var_0_5(var_33_1.name, function(arg_36_0)
			if arg_33_0.stop or not arg_36_0 then
				arg_33_2()

				return
			end

			local var_36_0 = Object.Instantiate(arg_36_0, arg_33_0.backPanel)

			arg_33_0.canMarkNode = {
				name = var_33_1.name,
				go = var_36_0
			}

			var_33_2(var_36_0)
			arg_33_2()

			return
		end)
	else
		(function(arg_34_0)
			eachChild(arg_34_0, function(arg_35_0)
				local var_35_0 = table.contains(var_33_1.marks, arg_35_0.gameObject.name)

				if var_35_0 ~= isActive(arg_35_0) then
					setActive(arg_35_0, var_35_0)
				end

				return
			end)

			return
		end)(arg_33_0.canMarkNode.go)
		arg_33_2()
	end

	return
end

function var_0_0.ClearCanMarkNode(arg_37_0)
	if arg_37_0.canMarkNode then
		Destroy(arg_37_0.canMarkNode.go)

		arg_37_0.canMarkNode = nil
	end

	return
end

function var_0_0.GrayingOutPrevPainting(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if not arg_38_1 or not arg_38_1:IsDialogueMode() then
		arg_38_3()

		return
	end

	local var_38_0 = arg_38_0:GetSideTF(arg_38_2:GetPrevSide(arg_38_1))

	if var_38_0 and arg_38_2 and arg_38_2:IsDialogueMode() and arg_38_2:ShouldGrayingOutPainting(arg_38_1) then
		local var_38_1 = arg_38_1:GetPaintingData()
		local var_38_2 = arg_38_1:GetPaintingAlpha() or 1

		arg_38_0:fadeTransform(var_38_0, var_38_2, var_38_1.alpha, var_38_1.time, false, arg_38_3)
	else
		arg_38_3()
	end

	return
end

function var_0_0.GrayingInPainting(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if not arg_39_1:ExistPainting() then
		arg_39_3()

		return
	end

	if arg_39_2 and arg_39_2:IsDialogueMode() and arg_39_1:ShouldGrayingPainting(arg_39_2) then
		local var_39_0 = arg_39_0:GetSideTF(arg_39_1:GetSide())
		local var_39_1 = arg_39_1:GetPaintingData()

		if not IsNil(var_39_0) and not arg_39_1:GetPaintingAlpha() then
			arg_39_0:fadeTransform(var_39_0, var_39_1.alpha, 1, var_39_1.time, false)
		end
	end

	arg_39_3()

	return
end

function var_0_0.UpdateTypeWriter(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_1:GetTypewriter()

	if not var_40_0 then
		arg_40_2()

		return
	end

	function arg_40_0.typewriter.endFunc()
		arg_40_0.typewriterSpeed = 0
		arg_40_0.typewriter.endFunc = nil

		removeOnButton(arg_40_0._tf)
		arg_40_2()

		return
	end

	local var_40_1 = var_40_0.speed or 0.1

	arg_40_0.typewriterSpeed = math.max(var_40_1 * arg_40_0.timeScale, 0.001)

	local var_40_2

	if not var_40_0.speedUp then
		var_40_2 = arg_40_0.typewriterSpeed
	end

	arg_40_0.typewriter:setSpeed(arg_40_0.typewriterSpeed)
	arg_40_0.typewriter:Play()
	onButton(arg_40_0, arg_40_0._tf, function()
		if arg_40_0.puase or arg_40_0.stop then
			return
		end

		arg_40_0.typewriterSpeed = math.min(arg_40_0.typewriterSpeed, var_40_2)

		arg_40_0.typewriter:setSpeed(arg_40_0.typewriterSpeed)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdatePainting(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	if not arg_43_1:ExistPainting() then
		arg_43_3()

		return
	end

	local var_43_0 = not arg_43_0.paintingStay

	if arg_43_0.paintingStay and arg_43_0.spineEffectOrderCaches and arg_43_1:IsSpinePainting() then
		arg_43_0:RevertSpineEffect(arg_43_0:GetSideTF(arg_43_1:GetSide()), arg_43_0.spineEffectOrderCaches)
	end

	arg_43_0.spineEffectOrderCaches = nil
	arg_43_0.paintingStay = nil

	local var_43_1, var_43_2, var_43_3, var_43_4 = arg_43_0:GetSideTF(arg_43_1:GetSide())
	local var_43_5 = arg_43_2 and arg_43_2:IsDialogueMode() and (arg_43_1:ShouldGrayingOutPainting(arg_43_2) or arg_43_1:ShouldGrayingPainting(arg_43_2)) or not arg_43_1:ShouldFadeInPainting() or not var_43_0
	local var_43_6 = arg_43_2 and arg_43_2:IsDialogueMode() and arg_43_1:ShouldGrayingPainting(arg_43_2)

	seriesAsync({
		function(arg_44_0)
			if not var_43_5 then
				var_43_1:GetComponent(typeof(CanvasGroup)).alpha = 0
			end

			arg_43_0:LoadPainting(arg_43_1, var_43_0, arg_44_0)

			if var_43_6 then
				arg_43_0:SetFadeColor(var_43_1, arg_43_1:GetPaintingData().alpha)
			end

			return
		end,
		function(arg_45_0)
			if var_43_5 then
				arg_45_0()

				return
			end

			arg_43_0:FadeInPainting(var_43_1, arg_43_1, arg_45_0)

			return
		end,
		function(arg_46_0)
			arg_43_0:AnimationPainting(arg_43_1, arg_46_0)

			return
		end
	}, arg_43_3)

	return
end

function var_0_0.FadeInPainting(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	if arg_47_2:ShouldAddHeadMaskWhenFade() then
		arg_47_0:AddHeadMask(arg_47_1)
	end

	arg_47_0:TweenValueForcanvasGroup(arg_47_1:GetComponent(typeof(CanvasGroup)), 0, 1, arg_47_2:GetFadeInPaintingTime(), 0, function()
		if var_0 then
			arg_47_0:ClearHeadMask(arg_47_1)
		end

		arg_47_3()

		return
	end)

	return
end

function var_0_0.AddHeadMask(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_1:Find("fitter")

	if not var_49_0 or var_49_0.childCount <= 0 then
		return
	end

	local var_49_1 = var_49_0:GetChild(0)
	local var_49_2 = var_49_1:Find("face")
	local var_49_3 = cloneTplTo(var_49_2, var_49_2.parent, "head_mask")
	local var_49_4 = var_49_1:Find("layers")
	local var_49_5 = arg_49_1:GetComponentsInChildren(typeof(Image)):ToTable()

	if var_49_4 then
		for iter_49_0, iter_49_1 in ipairs(var_49_5) do
			if iter_49_1.gameObject.name == "head_mask" then
				iter_49_1.material = arg_49_0.headMaskMat
			elseif iter_49_1.gameObject.name == "face" then
				-- block empty
			elseif iter_49_1.gameObject.transform.parent == var_49_4 then
				iter_49_1.material = arg_49_0.headObjectMat
			end
		end
	else
		for iter_49_2, iter_49_3 in ipairs(var_49_5) do
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

function var_0_0.ClearHeadMask(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_1:Find("fitter")

	if not var_50_0 or var_50_0.childCount <= 0 then
		return
	end

	local var_50_1 = var_50_0:GetChild(0)

	Destroy(var_50_1:Find("head_mask").gameObject)

	for iter_50_0, iter_50_1 in ipairs((arg_50_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
		iter_50_1.material = iter_50_1.defaultGraphicMaterial
	end

	return
end

function var_0_0.AnimationPainting(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_1:IsLive2dPainting() or arg_51_1:IsSpinePainting() then
		arg_51_2()

		return
	end

	local var_51_0, var_51_1, var_51_2, var_51_3 = arg_51_0:GetSideTF(arg_51_1:GetSide())

	arg_51_0:StartPaintingActions(var_51_0, arg_51_1, arg_51_2)

	return
end

function var_0_0.LoadPainting(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	local var_52_0, var_52_1, var_52_2, var_52_3 = arg_52_0:GetSideTF(arg_52_1:GetSide())
	local var_52_4, var_52_5 = arg_52_1:GetPaintingAndName()

	if arg_52_1:IsLive2dPainting() and checkABExist("live2d/" .. var_52_5) and not Live2dConst.GetLive2DArm32MatchAble() then
		arg_52_0:UpdateLive2dPainting(arg_52_1, var_52_0, arg_52_2, arg_52_3)
	elseif arg_52_1:IsSpinePainting() and checkABExist("spinepainting/" .. var_52_5) then
		arg_52_0:UpdateSpinePainting(arg_52_1, var_52_0, arg_52_2, arg_52_3)
	else
		arg_52_0:UpdateMeshPainting(arg_52_1, var_52_0, var_52_3, arg_52_2, arg_52_3)
	end

	return
end

function var_0_0.UpdateLive2dPainting(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	if not arg_53_3 and arg_53_0.live2dChars[arg_53_2] then
		(function(arg_56_0)
			if arg_56_0 then
				local var_56_0 = arg_53_1:GetLive2dAction()

				if var_56_0 and var_56_0 ~= "" then
					arg_56_0:TriggerAction(var_56_0)
				end

				local var_56_1 = arg_53_1:GetL2dIdleIndex()

				if var_56_1 and var_56_1 ~= "" and var_56_1 > 0 then
					arg_56_0:changeIdleIndex(var_56_1)
				end

				local var_56_2 = arg_53_1:GetL2dParams()

				if var_56_2 then
					arg_56_0:changeDragParameter(var_56_2.name, var_56_2.value)
				end
			end

			arg_53_4()

			return
		end)(arg_53_0.live2dChars[arg_53_2])
	else
		(function(arg_54_0)
			local var_54_0 = arg_53_1:GetVirtualShip()
			local var_54_1 = GetOrAddComponent(arg_53_0._go, typeof(CanvasGroup))

			GetOrAddComponent(arg_53_0._go, typeof(CanvasGroup)).blocksRaycasts = false
			arg_53_0.live2dChars[arg_53_2] = Live2DPainting.New(Live2DPainting.GenerateData({
				ship = var_54_0,
				offset = var_54_0:GetSkinConfig().live2d_offset,
				position = arg_53_1:GetLive2dPos() or Vector3(0, 0, 0),
				parent = arg_53_2:Find("live2d")
			}), function(arg_55_0)
				arg_55_0._go.name = arg_53_1:GetPainting()

				local var_55_0 = arg_55_0._go:GetComponent(typeof(CubismRenderController))

				var_55_0.SortingOrder = arg_53_0.sortingOrder + 1
				var_55_0.SortingMode = CubismSortingMode.BackToFrontOrder

				local var_55_1 = GetOrAddComponent(arg_53_0.front, typeof(Canvas))

				GetOrAddComponent(arg_53_0.front, typeof(GraphicRaycaster))

				var_55_1.overrideSorting = true
				var_55_1.sortingOrder = arg_53_0.sortingOrder + 1 + arg_55_0._tf:Find("Drawables").childCount
				var_54_1.blocksRaycasts = true

				if arg_54_0 then
					arg_54_0(arg_55_0)
				end

				return
			end)

			return
		end)(function(arg_56_0)
			if arg_56_0 then
				local var_56_0 = arg_53_1:GetLive2dAction()

				if var_56_0 and var_56_0 ~= "" then
					arg_56_0:TriggerAction(var_56_0)
				end

				local var_56_1 = arg_53_1:GetL2dIdleIndex()

				if var_56_1 and var_56_1 ~= "" and var_56_1 > 0 then
					arg_56_0:changeIdleIndex(var_56_1)
				end

				local var_56_2 = arg_53_1:GetL2dParams()

				if var_56_2 then
					arg_56_0:changeDragParameter(var_56_2.name, var_56_2.value)
				end
			end

			arg_53_4()

			return
		end)
	end

	return
end

local function var_0_7(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = arg_57_0:GetComponentsInChildren(typeof(Canvas)):ToTable()
	local var_57_1

	for iter_57_0, iter_57_1 in ipairs(var_57_0) do
		var_57_1 = iter_57_1.sortingOrder
	end

	local var_57_2 = math.huge
	local var_57_3 = arg_57_1:GetComponentsInChildren(typeof(Canvas)):ToTable()

	if #var_57_3 == 0 then
		var_57_2 = 0
	else
		for iter_57_2, iter_57_3 in ipairs(var_57_3) do
			if iter_57_3.sortingOrder - var_57_1 < var_57_2 then
				var_57_2 = iter_57_3.sortingOrder - var_57_1
			end
		end
	end

	local var_57_4 = arg_57_1:GetComponentsInChildren(typeof("UnityEngine.ParticleSystemRenderer")):ToTable()

	for iter_57_4, iter_57_5 in ipairs(var_57_4) do
		local var_57_5 = ReflectionHelp.RefGetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_57_5)

		;({})[iter_57_4] = var_57_5

		if var_57_5 - var_57_1 < var_57_2 then
			var_57_2 = var_57_5 - var_57_1
		end
	end

	for iter_57_6, iter_57_7 in ipairs(var_57_0) do
		iter_57_7.sortingOrder = arg_57_2 - var_57_2 + 1 + (iter_57_6 - 1)
	end

	local var_57_6 = arg_57_2 - var_57_2 + 1 + 1

	for iter_57_8, iter_57_9 in ipairs(var_57_3) do
		iter_57_9.sortingOrder = arg_57_2 - var_57_2 + 1 + (iter_57_9.sortingOrder - var_57_1)

		if arg_57_2 - var_57_2 + 1 < arg_57_2 - var_57_2 + 1 + (iter_57_9.sortingOrder - var_57_1) then
			var_57_6 = arg_57_2 - var_57_2 + 1 + (iter_57_9.sortingOrder - var_57_1)
		end
	end

	for iter_57_10, iter_57_11 in ipairs(var_57_4) do
		ReflectionHelp.RefSetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_57_11, arg_57_2 - var_57_2 + 1 + (({})[iter_57_10] - var_57_1))

		if arg_57_2 - var_57_2 + 1 < arg_57_2 - var_57_2 + 1 + (({})[iter_57_10] - var_57_1) then
			var_57_6 = arg_57_2 - var_57_2 + 1 + (({})[iter_57_10] - var_57_1)
		end
	end

	return var_57_6
end

local function var_0_8(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = arg_58_0:GetComponentsInChildren(typeof(Canvas)):ToTable()
	local var_58_1 = arg_58_0:GetComponentsInChildren(typeof("UnityEngine.ParticleSystemRenderer")):ToTable()
	local var_58_2 = math.huge

	if #var_58_0 == 0 then
		var_58_2 = 0
	else
		for iter_58_0, iter_58_1 in ipairs(var_58_0) do
			if iter_58_1.sortingOrder < var_58_2 then
				var_58_2 = iter_58_1.sortingOrder
			end
		end
	end

	local var_58_3 = {}

	for iter_58_2, iter_58_3 in ipairs(var_58_1) do
		local var_58_4 = ReflectionHelp.RefGetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_58_3)

		var_58_3[iter_58_2] = var_58_4

		if var_58_4 < var_58_2 then
			var_58_2 = var_58_4
		end
	end

	local var_58_5 = arg_58_2 + 1

	for iter_58_4, iter_58_5 in ipairs(var_58_0) do
		iter_58_5.sortingOrder = arg_58_2 + 1 - var_58_2 + iter_58_5.sortingOrder

		if var_58_5 < arg_58_2 + 1 - var_58_2 + iter_58_5.sortingOrder then
			var_58_5 = arg_58_2 + 1 - var_58_2 + iter_58_5.sortingOrder
		end
	end

	for iter_58_6, iter_58_7 in ipairs(var_58_1) do
		ReflectionHelp.RefSetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_58_7, arg_58_2 + 1 - var_58_2 + var_58_3[iter_58_6])

		if var_58_5 < arg_58_2 + 1 - var_58_2 + var_58_3[iter_58_6] then
			var_58_5 = arg_58_2 + 1 - var_58_2 + var_58_3[iter_58_6]
		end
	end

	return var_58_5
end

function var_0_0.UpdateSpinePainting(arg_59_0, arg_59_1, arg_59_2, arg_59_3, arg_59_4)
	if not arg_59_3 and arg_59_0.spinePainings[arg_59_2] then
		arg_59_0:UpdateSpineExpression(arg_59_0.spinePainings[arg_59_2], arg_59_1)
		arg_59_4()
	else
		(function(arg_60_0)
			local var_60_0 = arg_59_2:Find("spinebg")

			setActive(var_60_0, not arg_59_1:IsHideSpineBg())

			arg_59_0.spinePainings[arg_59_2] = SpinePainting.New(SpinePainting.GenerateData({
				ship = arg_59_1:GetVirtualShip(),
				position = arg_59_1:GetSpinePosition(),
				parent = arg_59_2:Find("spine"),
				effectParent = var_60_0
			}), function(arg_61_0)
				arg_61_0._go.name = arg_59_1:GetPainting()

				local var_61_0 = arg_59_0.sortingOrder
				local var_61_1 = arg_59_1:GetSpineOrderIndex()

				var_61_0 = not var_61_1 and var_0_7(var_0, var_60_0, arg_59_0.sortingOrder) or var_0_8(var_0, var_61_1, arg_59_0.sortingOrder)

				local var_61_2 = GetOrAddComponent(arg_59_0.front, typeof(Canvas))

				GetOrAddComponent(arg_59_0.front, typeof(GraphicRaycaster))

				var_61_2.overrideSorting = true
				var_61_2.sortingOrder = var_61_0 + 1

				arg_59_0:UpdateSpineExpression(arg_61_0, arg_59_1)

				if arg_60_0 then
					arg_60_0()
				end

				return
			end)

			return
		end)(arg_59_4)
	end

	return
end

function var_0_0.UpdateSpineExpression(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = arg_62_2:GetSpineExPression()

	if var_62_0 then
		arg_62_1:SetAction(var_62_0, 1)
	else
		arg_62_1:SetEmptyAction(1)
	end

	return
end

function var_0_0.UpdateMeshPainting(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4, arg_63_5)
	local var_63_0 = arg_63_1:GetPainting()

	if var_63_0 then
		if arg_63_4 or findTF(arg_63_2, "fitter").childCount <= 0 then
			(function()
				if arg_63_1:IsShowNPainting() and checkABExist("painting/" .. var_63_0 .. "_n") then
					var_63_0 = var_63_0 .. "_n"
				end

				if arg_63_1:IsShowWJZPainting() and checkABExist("painting/" .. var_63_0 .. "_wjz") then
					var_63_0 = var_63_0 .. "_wjz"
				end

				setPaintingPrefab(arg_63_2, var_63_0, "duihua")

				return
			end)()
		end

		local var_63_2 = arg_63_1:GetPaintingDir()
		local var_63_3 = math.abs(var_63_2)

		if arg_63_1:ShouldFlipPaintingY() then
			var_63_3 = -var_63_3
		end

		arg_63_2.localScale = Vector3(var_63_2, var_63_3, 1)

		local var_63_4 = findTF(arg_63_2, "fitter"):GetChild(0)

		var_63_4.name = var_63_0

		arg_63_0:UpdateActorPostion(arg_63_2, arg_63_1)
		arg_63_0:UpdateExpression(var_63_4, arg_63_1)
		arg_63_0:AddGlitchArtEffectForPating(arg_63_2, var_63_4, arg_63_1)
		arg_63_2:SetAsLastSibling()

		if arg_63_1:ShouldGrayPainting() then
			setGray(var_63_4, true, true)
		end

		local var_63_5 = findTF(var_63_4, "shadow")

		if var_63_5 then
			setActive(var_63_5, arg_63_1:ShouldFaceBlack())
		end

		local var_63_6 = arg_63_1:GetPaintingAlpha()

		if var_63_6 then
			arg_63_0:setPaintingAlpha(arg_63_2, var_63_6)
		end
	end

	arg_63_5()

	return
end

local function var_0_9(arg_65_0)
	local var_65_0 = arg_65_0.name

	if arg_65_0.showNPainting and checkABExist("painting/" .. var_65_0 .. "_n") then
		var_65_0 = var_65_0 .. "_n"
	end

	return var_65_0
end

function var_0_0.InitSubPainting(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	local function var_66_0(arg_67_0, arg_67_1)
		setPaintingPrefab(arg_67_1, var_0_9(arg_67_0), "duihua")

		local var_67_0 = findTF(arg_67_1, "fitter"):GetChild(0)
		local var_67_1 = findTF(var_67_0, "face")
		local var_67_2 = arg_67_0.expression

		if not arg_67_0.expression and arg_67_0.name and ShipExpressionHelper.DefaultFaceless(arg_67_0.name) then
			var_67_2 = ShipExpressionHelper.GetDefaultFace(arg_67_0.name)
		end

		if var_67_2 then
			setActive(var_67_1, true)
			setImageSprite(var_67_1, (GetSpriteFromAtlas("paintingface/" .. arg_67_0.name, arg_67_0.expression)))
		end

		if arg_67_0.pos then
			setAnchoredPosition(arg_67_1, arg_67_0.pos)
		end

		if arg_67_0.dir then
			arg_67_1.transform.localScale = Vector3(arg_67_0.dir, 1, 1)
		end

		if arg_67_0.paintingNoise then
			arg_66_0:AddGlitchArtEffectForPating(arg_67_1, var_67_0, arg_66_3)
		end

		return
	end

	arg_66_1:make(function(arg_68_0, arg_68_1, arg_68_2)
		if arg_68_0 == UIItemList.EventUpdate then
			var_66_0(arg_66_2[arg_68_1 + 1], arg_68_2)
		end

		return
	end)
	arg_66_1:align(#arg_66_2)

	return
end

function var_0_0.DisappearSubPainting(arg_69_0, arg_69_1, arg_69_2, arg_69_3)
	local var_69_0, var_69_1 = arg_69_2:GetDisappearTime()
	local var_69_2 = {}
	local var_69_3 = {}

	for iter_69_0, iter_69_1 in ipairs((arg_69_2:GetSubPaintings())) do
		table.insert({}, iter_69_1)
	end

	for iter_69_2, iter_69_3 in ipairs((arg_69_2:GetDisappearSeq())) do
		local var_69_4 = iter_69_3

		table.insert({}, function(arg_70_0)
			for iter_70_0, iter_70_1 in ipairs(var_69_3) do
				if iter_70_1.actor == var_69_4 then
					table.remove(var_69_3, iter_70_0)

					break
				end
			end

			arg_69_0:InitSubPainting(arg_69_1, var_69_3, arg_69_2)
			arg_69_0:DelayCall(var_69_1, arg_70_0)

			return
		end)
	end

	arg_69_1.container:SetAsFirstSibling()
	arg_69_0:DelayCall(var_69_0, function()
		seriesAsync(var_69_2, function()
			arg_69_1.container:SetAsLastSibling()
			arg_69_3()

			return
		end)

		return
	end)

	return
end

function var_0_0.UpdateActorPostion(arg_73_0, arg_73_1, arg_73_2)
	local var_73_0 = arg_73_2:GetPaitingOffst()

	if var_73_0 then
		local var_73_1 = var_73_0.x or 0
		local var_73_2 = arg_73_1.localPosition.x + var_73_1
		local var_73_3 = var_73_0.y or 0
		local var_73_4 = arg_73_1.localPosition.y + var_73_3

		arg_73_1.localPosition = Vector3(var_73_2, var_73_4, 0)
	end

	return
end

function var_0_0.UpdateExpression(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = arg_74_2:GetExPression()
	local var_74_1 = findTF(arg_74_1, "face")

	if var_74_0 then
		setActive(var_74_1, true)
		setImageSprite(var_74_1, (GetSpriteFromAtlas("paintingface/" .. arg_74_2:GetPainting(), var_74_0)))
	else
		setActive(var_74_1, false)
	end

	return
end

function var_0_0.StartPaintingActions(arg_75_0, arg_75_1, arg_75_2, arg_75_3)
	parallelAsync({
		function(arg_76_0)
			arg_75_0:StartPatiningMoveAction(arg_75_1, arg_75_2, arg_76_0)

			return
		end,
		function(arg_77_0)
			arg_75_0:StartPatiningShakeAction(arg_75_1, arg_75_2, arg_77_0)

			return
		end,
		function(arg_78_0)
			arg_75_0:StartPatiningZoomAction(arg_75_1, arg_75_2, arg_78_0)

			return
		end,
		function(arg_79_0)
			arg_75_0:StartPatiningRotateAction(arg_75_1, arg_75_2, arg_79_0)

			return
		end
	}, function()
		if arg_75_3 then
			arg_75_3()
		end

		return
	end)

	return
end

function var_0_0.StartPatiningShakeAction(arg_81_0, arg_81_1, arg_81_2, arg_81_3)
	local var_81_0 = arg_81_2:GetPaintingAction(DialogueStep.PAINTING_ACTION_SHAKE)

	if not var_81_0 then
		arg_81_3()

		return
	end

	local function var_81_1(arg_82_0, arg_82_1)
		local var_82_0 = arg_82_0.x or 0
		local var_82_1 = arg_82_0.y or 10
		local var_82_2 = arg_82_0.dur or 1
		local var_82_3 = arg_82_0.delay or 0
		local var_82_4 = arg_82_0.number or 1
		local var_82_5 = tf(arg_81_1).localPosition

		arg_81_0:TweenMove(arg_81_1, Vector3(var_82_5.x + var_82_0, var_82_5.y + var_82_1, 0), var_82_2, var_82_4, var_82_3, arg_82_1)

		return
	end

	for iter_81_0, iter_81_1 in pairs(var_81_0) do
		table.insert({}, function(arg_83_0)
			var_81_1(iter_81_1, arg_83_0)

			return
		end)
	end

	parallelAsync({}, function()
		if arg_81_3 then
			arg_81_3()
		end

		return
	end)

	return
end

function var_0_0.StartPatiningZoomAction(arg_85_0, arg_85_1, arg_85_2, arg_85_3)
	local var_85_0 = arg_85_2:GetPaintingAction(DialogueStep.PAINTING_ACTION_ZOOM)

	if not var_85_0 then
		arg_85_3()

		return
	end

	local function var_85_1(arg_86_0, arg_86_1)
		if not arg_86_0.from then
			-- block empty
		end

		local var_86_1 = arg_86_0.to or {
			1,
			1,
			1
		}
		local var_86_2 = arg_86_0.dur or 0
		local var_86_3 = arg_86_0.delay or 0

		arg_85_0:TweenScale(arg_85_1, Vector3(var_86_1[1], var_86_1[2], var_86_1[3]), var_86_2, var_86_3, arg_86_1)

		return
	end

	for iter_85_0, iter_85_1 in pairs(var_85_0) do
		table.insert({}, function(arg_87_0)
			var_85_1(iter_85_1, arg_87_0)

			return
		end)
	end

	parallelAsync({}, function()
		if arg_85_3 then
			arg_85_3()
		end

		return
	end)

	return
end

function var_0_0.StartPatiningRotateAction(arg_89_0, arg_89_1, arg_89_2, arg_89_3)
	local var_89_0 = arg_89_2:GetPaintingAction(DialogueStep.PAINTING_ACTION_ROTATE)

	if not var_89_0 then
		arg_89_3()

		return
	end

	local function var_89_1(arg_90_0, arg_90_1)
		local var_90_0 = arg_90_0.dur or 1
		local var_90_1 = arg_90_0.number or 1
		local var_90_2 = arg_90_0.delay or 0

		arg_89_0:TweenRotate(arg_89_1, arg_90_0.value, var_90_0, var_90_1, var_90_2, arg_90_1)

		return
	end

	for iter_89_0, iter_89_1 in pairs(var_89_0) do
		table.insert({}, function(arg_91_0)
			var_89_1(iter_89_1, arg_91_0)

			return
		end)
	end

	parallelAsync({}, function()
		if arg_89_3 then
			arg_89_3()
		end

		return
	end)

	return
end

function var_0_0.StartPatiningMoveAction(arg_93_0, arg_93_1, arg_93_2, arg_93_3)
	local var_93_0 = arg_93_2:GetPaintingAction(DialogueStep.PAINTING_ACTION_MOVE)

	if not var_93_0 then
		arg_93_3()

		return
	end

	local function var_93_1(arg_94_0, arg_94_1)
		local var_94_0 = arg_94_0.x or 0
		local var_94_1 = arg_94_0.y or 0
		local var_94_2 = arg_94_0.dur or 1
		local var_94_3 = arg_94_0.delay or 0
		local var_94_4 = tf(arg_93_1).localPosition

		arg_93_0:TweenMove(arg_93_1, Vector3(var_94_4.x + var_94_0, var_94_4.y + var_94_1, 0), var_94_2, 1, var_94_3, arg_94_1)

		return
	end

	for iter_93_0, iter_93_1 in pairs(var_93_0) do
		table.insert({}, function(arg_95_0)
			var_93_1(iter_93_1, arg_95_0)

			return
		end)
	end

	parallelAsync({}, function()
		if arg_93_3 then
			arg_93_3()
		end

		return
	end)

	return
end

function var_0_0.StartMovePrevPaintingToSide(arg_97_0, arg_97_1, arg_97_2, arg_97_3)
	local var_97_0 = arg_97_1:GetPaintingMoveToSide()

	if not var_97_0 or not arg_97_2 then
		arg_97_3()

		return
	end

	local var_97_1 = arg_97_0:GetSideTF(arg_97_2:GetSide())

	if not var_97_1 then
		arg_97_3()

		return
	end

	local var_97_2 = var_97_0.time
	local var_97_3 = arg_97_0:GetSideTF(var_97_0.side)

	if not var_97_3 then
		arg_97_3()

		return
	end

	if arg_97_1.side ~= arg_97_2.side then
		if var_97_1:Find("fitter").childCount > 0 then
			removeAllChildren(var_97_3:Find("fitter"))
			setParent(var_97_1:Find("fitter"):GetChild(0), var_97_3:Find("fitter"))

			local var_97_4 = arg_97_2:GetPaintingDir()

			var_97_3.localScale = Vector3(var_97_4, math.abs(var_97_4), 1)
		end
	else
		local var_97_5 = arg_97_2:GetPainting()

		if var_97_5 then
			setPaintingPrefab(var_97_3, var_97_5, "duihua")
		end
	end

	arg_97_0:TweenValue(var_97_3, var_97_1.localPosition.x, tf(var_97_3).localPosition.x, var_97_2, 0, function(arg_98_0)
		setAnchoredPosition(var_97_3, {
			x = arg_98_0
		})

		return
	end, arg_97_3)

	var_97_3.localPosition = Vector2(var_97_1.localPosition.x, var_97_3.localPosition.y, 0)

	return
end

local function var_0_10(arg_99_0, arg_99_1, arg_99_2, arg_99_3, arg_99_4)
	for iter_99_0, iter_99_1 in ipairs((arg_99_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
		if iter_99_1.gameObject.name == "temp_mask" then
			if arg_99_4 then
				iter_99_1.material = arg_99_0.maskMaterial or arg_99_0.maskMaterialForWithLayer

				if false then
					iter_99_1.material = iter_99_1.gameObject.name == "face" and arg_99_0.glitchArtMaterial or arg_99_3.hasPaintbg and iter_99_1.gameObject == arg_99_2.gameObject and arg_99_0.glitchArtMaterialForPaintingBg or arg_99_0.glitchArtMaterialForPainting
				end
			end
		end
	end

	return
end

local function var_0_11(arg_100_0, arg_100_1, arg_100_2, arg_100_3, arg_100_4)
	local var_100_9000
	local var_100_0 = arg_100_1:GetComponentsInChildren(typeof(Image))

	if var_100_0 then
		table.insert({}, arg_100_2:GetComponent(typeof(Image)).gameObject)
	end

	for iter_100_0 = 1, arg_100_3 - 1 do
		table.insert({}, arg_100_4:GetChild(iter_100_0 - 1).gameObject)
	end

	for iter_100_1, iter_100_2 in ipairs((var_100_0.ToTable(var_100_9000))) do
		iter_100_2.material = iter_100_2.gameObject.name == "temp_mask" and arg_100_0.maskMaterial or iter_100_2.gameObject.name == "face" and arg_100_0.glitchArtMaterial or table.contains({}, iter_100_2.gameObject) and arg_100_0.glitchArtMaterialForPaintingBg or arg_100_0.glitchArtMaterialForPainting
	end

	return
end

function var_0_0.AddGlitchArtEffectForPating(arg_101_0, arg_101_1, arg_101_2, arg_101_3)
	local var_101_0 = arg_101_3:ShouldAddGlitchArtEffect()

	if var_101_0 and arg_101_3:GetExPression() ~= nil and not arg_101_3:IsNoHeadPainting() then
		local var_101_1 = arg_101_2:Find("face")

		cloneTplTo(var_101_1, var_101_1.parent, "temp_mask"):SetAsFirstSibling()

		local var_101_2 = arg_101_2:Find("layers")
		local var_101_3 = IsNil(var_101_2)

		if not var_101_3 and arg_101_3:GetPaintingRwIndex() > 0 then
			var_0_11(arg_101_0, arg_101_1, arg_101_2, arg_101_3:GetPaintingRwIndex(), var_101_2)
		else
			var_0_10(arg_101_0, arg_101_1, arg_101_2, arg_101_3, var_101_3)
		end
	elseif var_101_0 then
		for iter_101_0, iter_101_1 in ipairs((arg_101_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
			iter_101_1.material = arg_101_0.glitchArtMaterial
		end
	end

	if var_101_0 then
		local var_101_4 = GameObject.Find("/OverlayCamera/Overlay/UIMain/AwardInfoUI(Clone)/items/SpriteMask")

		if var_101_4 and var_101_4.activeInHierarchy then
			setActive(var_101_4, false)

			arg_101_0.spriteMask = var_101_4
		end
	end

	return
end

function var_0_0.UpdateContent(arg_102_0, arg_102_1, arg_102_2)
	setActive(arg_102_0.dialoguePanel, not arg_102_1:ShouldHideDialogue())

	for iter_102_0, iter_102_1 in ipairs(arg_102_0.tags) do
		setActive(iter_102_1, iter_102_0 == arg_102_1:GetTag())
	end

	arg_102_0.conentTxt.fontSize = arg_102_1:GetFontSize() or arg_102_0.defualtFontSize

	local var_102_0 = arg_102_1:GetContent()

	arg_102_0.conentTxt.text = var_102_0
	arg_102_0.conentTxt.color = Color.NewHex(arg_102_1:GetContentColor())

	local var_102_1 = 999

	if var_102_0 and var_102_0 ~= "" then
		var_102_1 = System.String.New(var_102_0).Length
	end

	if var_102_0 and var_102_0 ~= "" and var_102_0 ~= "…" and #var_102_0 > 1 and var_102_1 > 1 then
		arg_102_0:UpdateTypeWriter(arg_102_1, function()
			setActive(arg_102_0.nextTr, true)
			arg_102_2()

			return
		end)
	else
		(function()
			setActive(arg_102_0.nextTr, true)
			arg_102_2()

			return
		end)()
	end

	local var_102_2 = false
	local var_102_3, var_102_4, var_102_5, var_102_6 = arg_102_0:GetSideTF(arg_102_1:GetSide())

	if var_102_4 then
		local var_102_7 = arg_102_1:GetNameWithColor()
		local var_102_8 = var_102_7 and var_102_7 ~= ""

		var_102_2 = var_102_7 and var_102_7 ~= ""

		setActive(var_102_4, var_102_7 and var_102_7 ~= "")

		if var_102_8 then
			var_102_4:Find("Text"):GetComponent(typeof(Outline)).effectColor = Color.NewHex((arg_102_1:GetNameColorCode()))
		end

		var_102_5.text = var_102_7

		setText(var_102_5.gameObject.transform:Find("subText"), arg_102_1:GetSubActorName())
	end

	if arg_102_0.script:IsDialogueStyle2() then
		setActive(arg_102_0.tag4Dialog2, not var_102_2)
	end

	return
end

function var_0_0.SetContentBgAlpha(arg_104_0, arg_104_1)
	if arg_104_0.contentBgAlpha ~= arg_104_1 then
		for iter_104_0, iter_104_1 in ipairs(arg_104_0.contentBgs) do
			GetOrAddComponent(iter_104_1, typeof(CanvasGroup)).alpha = arg_104_1
		end

		arg_104_0.contentBgAlpha = arg_104_1
	end

	return
end

function var_0_0.GetSideTF(arg_105_0, arg_105_1)
	local var_105_0
	local var_105_1
	local var_105_2
	local var_105_3

	if DialogueStep.SIDE_LEFT == arg_105_1 then
		var_105_3 = arg_105_0.subActorLeft
		var_105_2 = arg_105_0.nameTxt
		var_105_1 = arg_105_0.nameTr
		var_105_0 = arg_105_0.actorLeft
	elseif DialogueStep.SIDE_RIGHT == arg_105_1 then
		var_105_3 = arg_105_0.subActorRgiht
		var_105_2 = arg_105_0.nameTxt
		var_105_1 = arg_105_0.nameTr
		var_105_0 = arg_105_0.actorRgiht
	elseif DialogueStep.SIDE_MIDDLE == arg_105_1 then
		var_105_3 = arg_105_0.subActorMiddle
		var_105_2 = arg_105_0.nameTxt
		var_105_1 = arg_105_0.nameTr
		var_105_0 = arg_105_0.actorMiddle
	end

	return var_105_0, var_105_1, var_105_2, var_105_3
end

function var_0_0.RecyclesSubPantings(arg_106_0, arg_106_1)
	arg_106_1:each(function(arg_107_0, arg_107_1)
		arg_106_0:RecyclePainting(arg_107_1)

		return
	end)

	return
end

function var_0_0.ClearMeshPainting(arg_109_0, arg_109_1)
	arg_109_0:ResetMeshPainting(arg_109_1)

	if arg_109_1:Find("fitter").childCount == 0 then
		return
	end

	local var_109_0 = arg_109_1:Find("fitter"):GetChild(0)

	if var_109_0 then
		retPaintingPrefab(arg_109_1, var_109_0.name)
	end

	return
end

function var_0_0.ResetMeshPainting(arg_110_0, arg_110_1)
	if arg_110_1:Find("fitter").childCount == 0 then
		return
	end

	local var_110_0 = arg_110_1:Find("fitter"):GetChild(0)

	if var_110_0 then
		local var_110_1 = findTF(var_110_0, "shadow")

		if var_110_1 then
			setActive(var_110_1, false)
		end

		local var_110_2 = arg_110_1:GetComponentsInChildren(typeof(Image))

		for iter_110_0, iter_110_1 in ipairs((var_110_2:ToTable())) do
			if iter_110_1.material ~= iter_110_1.defaultGraphicMaterial then
				iter_110_1.material = iter_110_1.defaultGraphicMaterial

				iter_110_1.material:SetColor("_Color", Color.white)
			else
				iter_110_1.material = nil
			end
		end

		setGray(var_110_0, false, true)

		local var_110_3 = var_110_0:Find("temp_mask")

		if var_110_3 then
			Destroy(var_110_3.gameObject)
		end
	end

	return
end

local function var_0_13(arg_111_0, arg_111_1)
	local var_111_0 = false

	if arg_111_0.live2dChars[arg_111_1] and arg_111_0.live2dChars[arg_111_1]._go then
		arg_111_0.live2dChars[arg_111_1]._go:GetComponent(typeof(CubismRenderController)).SortingOrder = 0

		arg_111_0.live2dChars[arg_111_1]:Dispose()

		arg_111_0.live2dChars[arg_111_1] = nil
		var_111_0 = true
	end

	local var_111_1 = table.getCount(arg_111_0.live2dChars) <= 0

	if var_111_0 and var_111_1 then
		RemoveComponent(arg_111_0.front, "GraphicRaycaster")
		RemoveComponent(arg_111_0.front, "Canvas")
	end

	return
end

local function var_0_14(arg_112_0, arg_112_1)
	local var_112_0 = false

	if arg_112_0.spinePainings[arg_112_1] then
		arg_112_0.spinePainings[arg_112_1]:Dispose()

		arg_112_0.spinePainings[arg_112_1] = nil
		var_112_0 = true
	end

	local var_112_1 = table.getCount(arg_112_0.spinePainings) <= 0

	if var_112_0 and var_112_1 then
		RemoveComponent(arg_112_0.front, "GraphicRaycaster")
		RemoveComponent(arg_112_0.front, "Canvas")
	end

	return
end

function var_0_0.RecyclePainting(arg_113_0, arg_113_1)
	if type(arg_113_1) == "table" then
		arg_113_0:RecyclePaintingList((_.map(arg_113_1, function(arg_114_0)
			return arg_113_0[arg_114_0]
		end)))
	else
		arg_113_0:ClearMeshPainting(arg_113_1)
		var_0_13(arg_113_0, arg_113_1)
		var_0_14(arg_113_0, arg_113_1)
	end

	return
end

function var_0_0.RecyclePaintingList(arg_115_0, arg_115_1)
	for iter_115_0, iter_115_1 in ipairs(arg_115_1) do
		arg_115_0:ClearMeshPainting(iter_115_1)
		var_0_13(arg_115_0, iter_115_1)
		var_0_14(arg_115_0, iter_115_1)
	end

	return
end

function var_0_0.Resume(arg_116_0)
	var_0_0.super.Resume(arg_116_0)

	if arg_116_0.typewriterSpeed ~= 0 then
		arg_116_0.typewriter:setSpeed(arg_116_0.typewriterSpeed)
	end

	return
end

function var_0_0.Pause(arg_117_0)
	var_0_0.super.Pause(arg_117_0)

	if arg_117_0.typewriterSpeed ~= 0 then
		arg_117_0.typewriter:setSpeed(0)
	end

	return
end

function var_0_0.OnClear(arg_118_0)
	if arg_118_0.spriteMask then
		setActive(arg_118_0.spriteMask, true)

		arg_118_0.spriteMask = nil
	end

	return
end

function var_0_0.FadeOutPainting(arg_119_0, arg_119_1, arg_119_2, arg_119_3)
	local var_119_0 = arg_119_1:GetFadeOutPaintingTime()

	if var_119_0 <= 0 then
		arg_119_3()

		return
	end

	if arg_119_1:ShouldAddHeadMaskWhenFade() then
		arg_119_0:AddHeadMask(arg_119_2)
	end

	arg_119_0:TweenValueForcanvasGroup(arg_119_2:GetComponent(typeof(CanvasGroup)), 1, 0, var_119_0, 0, function()
		if var_0 then
			arg_119_0:ClearHeadMask(arg_119_2)
		end

		arg_119_3()

		return
	end)

	return
end

function var_0_0.OnWillExit(arg_121_0, arg_121_1, arg_121_2, arg_121_3)
	if not arg_121_2 or not arg_121_2:IsDialogueMode() then
		arg_121_3()

		return
	end

	local var_121_0 = arg_121_0:GetRecycleActorList(arg_121_2, arg_121_1)
	local var_121_1

	if arg_121_2:ShouldMoveToSide() then
		var_121_1 = arg_121_0:GetSideTF(arg_121_1:GetSide())
	end

	local var_121_2 = {}

	for iter_121_0, iter_121_1 in pairs(var_121_0) do
		if (not var_121_1 or iter_121_1 ~= var_121_1) and iter_121_1:Find("fitter").childCount > 0 then
			table.insert(var_121_2, function(arg_122_0)
				arg_121_0:FadeOutPainting(arg_121_1, iter_121_1, arg_122_0)

				return
			end)
		end
	end

	parallelAsync(var_121_2, arg_121_3)

	return
end

function var_0_0.OnEnd(arg_123_0)
	if arg_123_0.conentTxt then
		arg_123_0.conentTxt.fontSize = arg_123_0.defualtFontSize
		arg_123_0.conentTxt.text = ""
	end

	if arg_123_0.nameTxt then
		arg_123_0.nameTxt.text = ""
	end

	arg_123_0:ClearGlitchArtForPortrait()
	arg_123_0:ClearCanMarkNode()
	arg_123_0:RecyclePainting({
		"actorLeft",
		"actorMiddle",
		"actorRgiht"
	})

	for iter_123_0, iter_123_1 in ipairs({
		"actorLeft",
		"actorMiddle",
		"actorRgiht"
	}) do
		arg_123_0[iter_123_1]:GetComponent(typeof(CanvasGroup)).alpha = 1
	end

	return
end

return var_0_0
