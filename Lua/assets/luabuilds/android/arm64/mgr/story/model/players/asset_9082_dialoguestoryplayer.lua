local DialogueStoryPlayer = class("DialogueStoryPlayer", import(".StoryPlayer"))
local var_0_1 = 159
local var_0_2 = 411
local var_0_3 = 250

function DialogueStoryPlayer:Ctor(arg_1_1)
	DialogueStoryPlayer.super.Ctor(self, arg_1_1)

	self.actorPanel = self._tf:Find("actor")
	self.actorLeft = self.actorPanel:Find("actor_left")
	self.initActorLeftPos = self.actorLeft.localPosition
	self.actorMiddle = self.actorPanel:Find("actor_middle")
	self.initActorMiddlePos = self.actorMiddle.localPosition
	self.actorRgiht = self.actorPanel:Find("actor_right")
	self.initActorRgihtPos = self.actorRgiht.localPosition
	self.sortingOrder = self._go:GetComponent(typeof(Canvas)).sortingOrder
	self.subActorMiddle = UIItemList.New(self.actorPanel:Find("actor_middle/sub"), self.actorPanel:Find("actor_middle/sub/tpl"))
	self.subActorRgiht = UIItemList.New(self.actorPanel:Find("actor_right/sub"), self.actorPanel:Find("actor_right/sub/tpl"))
	self.subActorLeft = UIItemList.New(self.actorPanel:Find("actor_left/sub"), self.actorPanel:Find("actor_left/sub/tpl"))
	self.glitchArtMaterial = self._tf:Find("resource/material1"):GetComponent(typeof(Image)).material
	self.maskMaterial = self._tf:Find("resource/material2"):GetComponent(typeof(Image)).material
	self.maskMaterialForWithLayer = self._tf:Find("resource/material5"):GetComponent(typeof(Image)).material
	self.glitchArtMaterialForPainting = self._tf:Find("resource/material3"):GetComponent(typeof(Image)).material
	self.glitchArtMaterialForPaintingBg = self._tf:Find("resource/material4"):GetComponent(typeof(Image)).material
	self.headObjectMat = self._tf:Find("resource/material6"):GetComponent(typeof(Image)).material
	self.headMaskMat = self._tf:Find("resource/material7"):GetComponent(typeof(Image)).material
	self.typewriterSpeed = 0
	self.contentBgAlpha = 1
	self.live2dChars = {}
	self.spinePainings = {}

	return
end

function DialogueStoryPlayer:OnStart(arg_2_1)
	self.nextTr = self.dialogueWin:Find("next")
	self.conentTr = self.dialogueWin:Find("content")
	self.conentTxt = self.dialogueWin:Find("content"):GetComponent(typeof(Text))
	self.typewriter = self.dialogueWin:Find("content"):GetComponent(typeof(Typewriter))
	self.nameTr = self.dialogueWin:Find("content/name")
	self.tag4Dialog2 = self.dialogueWin:Find("content/tag")
	self.nameTxt = self.nameTr:Find("Text"):GetComponent(typeof(Text))
	self.portraitTr = self.dialogueWin:Find("portrait")
	self.conentLineTr = self.dialogueWin:Find("line")
	self.portraitImg = self.portraitTr:GetComponent(typeof(Image))
	self.tags = {
		self.nameTr:Find("tags/1"),
		self.nameTr:Find("tags/2")
	}
	self.contentBgs = {
		self.nameTr:Find("bg"),
		self.dialogueWin:Find("bg")
	}
	self.defualtFontSize = self.conentTxt.fontSize

	return
end

function DialogueStoryPlayer:OnReset(arg_3_1, arg_3_2, arg_3_3)
	self:ResetActorTF(arg_3_1, arg_3_2)
	setActive(self.nameTr, false)
	setActive(self.nameTr, false)
	setActive(self.dialoguePanel, true)
	setActive(self.actorPanel, true)
	setActive(self.nextTr, false)

	self.conentTxt.text = ""

	local var_3_0 = arg_3_2 and arg_3_2:IsDialogueMode() and arg_3_2:ExistPortrait() and arg_3_1:ExistPortrait()

	setActive(self.portraitTr, var_3_0)

	if not var_3_0 and arg_3_2 and arg_3_2:IsDialogueMode() and arg_3_2:ShouldGlitchArtForPortrait() then
		self:ClearGlitchArtForPortrait()
	end

	self:UpdateContentPosition(arg_3_1)
	self:SetContentBgAlpha(arg_3_1:GetContentBGAlpha())
	arg_3_3()

	return
end

function DialogueStoryPlayer:UpdateContentPosition(arg_4_1)
	local var_4_0 = arg_4_1:IsMiniPortrait()

	if arg_4_1:ExistPortrait() then
		local var_4_1

		if var_4_0 then
			var_4_1 = var_0_3 or var_0_2 or var_0_1
		end
	end

	self.conentTr.offsetMin = Vector2(var_4_1, self.conentTr.offsetMin.y)
	self.conentLineTr.offsetMin = Vector2((var_4_0 or nil) and (var_0_3 or var_0_1), self.conentLineTr.offsetMin.y)

	return
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

function DialogueStoryPlayer:GetRecycleActorList(arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1:GetSide()
	local var_6_1 = self:GetSideTF(var_6_0)
	local var_6_2 = {}

	if arg_6_1:HideOtherPainting() then
		var_6_2 = {
			self.actorLeft,
			self.actorMiddle,
			self.actorRgiht
		}
	else
		if arg_6_2 and arg_6_2:IsDialogueMode() and arg_6_1:IsDialogueMode() and arg_6_1:IsSameSide(arg_6_2) and arg_6_1:IsSamePainting(arg_6_2) or var_0_4(arg_6_1, var_6_1) then
			-- block empty
		else
			table.insert(var_6_2, var_6_1)
		end

		if var_6_0 == DialogueStep.SIDE_MIDDLE then
			table.insert(var_6_2, self.actorLeft)
			table.insert(var_6_2, self.actorRgiht)
		end
	end

	return var_6_2
end

function DialogueStoryPlayer:ResetActorTF(arg_7_1, arg_7_2)
	local var_7_0 = self:GetSideTF((arg_7_1:GetSide()))

	if var_7_0 then
		self:CancelTween(var_7_0.gameObject)

		var_7_0.localScale = Vector3(1, 1, 1)
		var_7_0.eulerAngles = Vector3(0, 0, 0)

		if var_7_0 == self.actorRgiht then
			var_7_0.localPosition = self.initActorRgihtPos
		elseif var_7_0 == self.actorMiddle then
			var_7_0.localPosition = self.initActorMiddlePos
		elseif var_7_0 == self.actorLeft then
			var_7_0.localPosition = self.initActorLeftPos
		end
	end

	local var_7_1 = self:GetRecycleActorList(arg_7_1, arg_7_2)

	if var_7_0 and _.all(var_7_1, function(arg_8_0)
		return arg_8_0 ~= var_7_0
	end) then
		self.paintingStay = true

		self:ResetMeshPainting(var_7_0)

		if arg_7_1:IsSpinePainting() then
			self:HideSpineEffect(var_7_0, arg_7_1)
		end
	end

	self:RecyclePaintingList(var_7_1)
	self:RecyclesSubPantings(self.subActorMiddle)
	self:RecyclesSubPantings(self.subActorRgiht)
	self:RecyclesSubPantings(self.subActorLeft)

	for iter_7_0, iter_7_1 in ipairs({
		self.actorLeft,
		self.actorMiddle,
		self.actorRgiht
	}) do
		iter_7_1:GetComponent(typeof(CanvasGroup)).alpha = 1
	end

	return
end

function DialogueStoryPlayer:HideSpineEffect(arg_9_1)
	self.spineEffectOrderCaches = {}

	local function var_9_0(arg_10_0)
		for iter_10_0, iter_10_1 in ipairs((arg_10_0:GetComponentsInChildren(typeof("UnityEngine.ParticleSystemRenderer")):ToTable())) do
			local var_10_0 = ReflectionHelp.RefGetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_10_1)

			ReflectionHelp.RefSetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_10_1, -1)

			self.spineEffectOrderCaches[iter_10_1] = var_10_0
		end

		return
	end

	var_9_0((arg_9_1:Find("spine")))
	var_9_0((arg_9_1:Find("spinebg")))

	return
end

function DialogueStoryPlayer:RevertSpineEffect(arg_11_1, arg_11_2)
	if not arg_11_2 then
		return
	end

	local function var_11_0(arg_12_0)
		for iter_12_0, iter_12_1 in ipairs((arg_12_0:GetComponentsInChildren(typeof("UnityEngine.ParticleSystemRenderer")):ToTable())) do
			ReflectionHelp.RefSetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_12_1, arg_11_2[iter_12_1] or 950)
		end

		return
	end

	var_11_0((arg_11_1:Find("spine")))
	var_11_0((arg_11_1:Find("spinebg")))

	return
end

function DialogueStoryPlayer:OnInit(arg_13_1, arg_13_2, arg_13_3)
	parallelAsync({
		function(arg_14_0)
			self:UpdateContent(arg_13_1, arg_14_0)

			return
		end,
		function(arg_15_0)
			self:UpdatePortrait(arg_13_1, arg_15_0)

			return
		end,
		function(arg_16_0)
			self:UpdateSubPaintings(arg_13_1, arg_16_0)

			return
		end,
		function(arg_17_0)
			self:UpdatePainting(arg_13_1, arg_13_2, arg_17_0)

			return
		end,
		function(arg_18_0)
			self:GrayingInPainting(arg_13_1, arg_13_2, arg_18_0)

			return
		end,
		function(arg_19_0)
			self:StartMovePrevPaintingToSide(arg_13_1, arg_13_2, arg_19_0)

			return
		end,
		function(arg_20_0)
			self:GrayingOutPrevPainting(arg_13_2, arg_13_1, arg_20_0)

			return
		end
	}, arg_13_3)

	return
end

function DialogueStoryPlayer:UpdatePortrait(arg_21_1, arg_21_2)
	if not arg_21_1:ExistPortrait() then
		arg_21_2()

		return
	end

	LoadSpriteAsync("StoryIcon/" .. arg_21_1:GetPortrait(), function(arg_22_0)
		setImageSprite(self.portraitTr, arg_22_0, true)
		setActive(self.portraitTr, true)
		self:AdjustPortraitPosition(arg_21_1)

		if arg_21_1:ShouldGlitchArtForPortrait() then
			self:SetGlitchArtForPortrait()
		else
			self:ClearGlitchArtForPortrait()
		end

		arg_21_2()

		return
	end)

	return
end

function DialogueStoryPlayer:AdjustPortraitPosition(arg_23_1)
	if arg_23_1:IsMiniPortrait() then
		setAnchoredPosition3D(self.portraitTr, {
			x = 211,
			y = 133
		})
	else
		setAnchoredPosition3D(self.portraitTr, {
			y = 0,
			x = (self.portraitTr.sizeDelta.x < var_0_2 or nil) and (var_0_2 or 539)
		})
	end

	return
end

function DialogueStoryPlayer:SetGlitchArtForPortrait()
	if self.portraitImg.material ~= self.glitchArtMaterialForPainting then
		self.portraitImg.material = self.glitchArtMaterialForPainting
	end

	return
end

function DialogueStoryPlayer:ClearGlitchArtForPortrait()
	if not self.portraitImg then
		return
	end

	if self.portraitImg.material ~= self.portraitImg.defaultGraphicMaterial then
		self.portraitImg.material = self.portraitImg.defaultGraphicMaterial
	end

	return
end

function DialogueStoryPlayer:UpdateSubPaintings(arg_26_1, arg_26_2)
	local var_26_0, var_26_1, var_26_2, var_26_3 = self:GetSideTF(arg_26_1:GetSide())

	if not arg_26_1:ExistPainting() then
		arg_26_2()

		return
	end

	self:InitSubPainting(var_26_3, arg_26_1:GetSubPaintings(), arg_26_1)

	if arg_26_1:NeedDispppearSubPainting() then
		self:DisappearSubPainting(var_26_3, arg_26_1, arg_26_2)
	else
		arg_26_2()
	end

	return
end

function DialogueStoryPlayer:OnStartUIAnimations(arg_27_1, arg_27_2)
	if not arg_27_1:ShouldShakeDailogue() then
		arg_27_2()

		return
	end

	local var_27_0 = arg_27_1:GetShakeDailogueData()

	self:TweenMovex(self.dialogueWin, var_27_0.x, self.dialogueWin.localPosition.x, var_27_0.speed, var_27_0.delay, var_27_0.number, arg_27_2)

	return
end

function DialogueStoryPlayer:OnEnter(arg_28_1, arg_28_2, arg_28_3)
	parallelAsync({
		function(arg_29_0)
			self:UpdateCanMarkNode(arg_28_1, arg_29_0)

			return
		end,
		function(arg_30_0)
			self:UpdateIcon(arg_28_1, arg_30_0)

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

function DialogueStoryPlayer:UpdateCanMarkNode(arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1:ExistCanMarkNode()

	if not var_33_0 or not var_0_6(arg_33_1, self.canMarkNode) then
		self:ClearCanMarkNode(self.canMarkNode)
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

	if not self.canMarkNode then
		var_0_5(var_33_1.name, function(arg_36_0)
			if self.stop or not arg_36_0 then
				arg_33_2()

				return
			end

			local var_36_0 = Object.Instantiate(arg_36_0, self.backPanel)

			self.canMarkNode = {
				name = var_33_1.name,
				go = var_36_0
			}

			var_33_2(var_36_0)
			arg_33_2()

			return
		end)
	else
		var_33_2(self.canMarkNode.go)
		arg_33_2()
	end

	return
end

function DialogueStoryPlayer:ClearCanMarkNode()
	if self.canMarkNode then
		Destroy(self.canMarkNode.go)

		self.canMarkNode = nil
	end

	return
end

function DialogueStoryPlayer:GrayingOutPrevPainting(arg_38_1, arg_38_2, arg_38_3)
	if not arg_38_1 or not arg_38_1:IsDialogueMode() then
		arg_38_3()

		return
	end

	local var_38_0 = self:GetSideTF(arg_38_2:GetPrevSide(arg_38_1))

	if var_38_0 and arg_38_2 and arg_38_2:IsDialogueMode() and arg_38_2:ShouldGrayingOutPainting(arg_38_1) then
		local var_38_1 = arg_38_1:GetPaintingData()

		self:fadeTransform(var_38_0, arg_38_1:GetPaintingAlpha() or 1, var_38_1.alpha, var_38_1.time, false, arg_38_3)
	else
		arg_38_3()
	end

	return
end

function DialogueStoryPlayer:GrayingInPainting(arg_39_1, arg_39_2, arg_39_3)
	if not arg_39_1:ExistPainting() then
		arg_39_3()

		return
	end

	if arg_39_2 and arg_39_2:IsDialogueMode() and arg_39_1:ShouldGrayingPainting(arg_39_2) then
		local var_39_0 = self:GetSideTF(arg_39_1:GetSide())
		local var_39_1 = arg_39_1:GetPaintingData()

		if not IsNil(var_39_0) and not arg_39_1:GetPaintingAlpha() then
			self:fadeTransform(var_39_0, var_39_1.alpha, 1, var_39_1.time, false)
		end
	end

	arg_39_3()

	return
end

function DialogueStoryPlayer:UpdateTypeWriter(arg_40_1, arg_40_2)
	local var_40_0 = arg_40_1:GetTypewriter()

	if not var_40_0 then
		arg_40_2()

		return
	end

	function self.typewriter.endFunc()
		self.typewriterSpeed = 0
		self.typewriter.endFunc = nil

		removeOnButton(self._tf)
		arg_40_2()

		return
	end

	self.typewriterSpeed = math.max((var_40_0.speed or 0.1) * self.timeScale, 0.001)

	local var_40_1 = var_40_0.speedUp or self.typewriterSpeed

	self.typewriter:setSpeed(self.typewriterSpeed)
	self.typewriter:Play()
	onButton(self, self._tf, function()
		if self.puase or self.stop then
			return
		end

		self.typewriterSpeed = math.min(self.typewriterSpeed, var_40_1)

		self.typewriter:setSpeed(self.typewriterSpeed)

		return
	end, SFX_PANEL)

	return
end

function DialogueStoryPlayer:UpdatePainting(arg_43_1, arg_43_2, arg_43_3)
	if not arg_43_1:ExistPainting() then
		arg_43_3()

		return
	end

	local var_43_0 = not self.paintingStay

	if self.paintingStay and self.spineEffectOrderCaches and arg_43_1:IsSpinePainting() then
		self:RevertSpineEffect(self:GetSideTF(arg_43_1:GetSide()), self.spineEffectOrderCaches)
	end

	self.spineEffectOrderCaches = nil
	self.paintingStay = nil

	local var_43_1, var_43_2, var_43_3, var_43_4 = self:GetSideTF(arg_43_1:GetSide())
	local var_43_5 = arg_43_2 and arg_43_2:IsDialogueMode() and (arg_43_1:ShouldGrayingOutPainting(arg_43_2) or arg_43_1:ShouldGrayingPainting(arg_43_2)) or not arg_43_1:ShouldFadeInPainting() or not var_43_0
	local var_43_6 = arg_43_2 and arg_43_2:IsDialogueMode() and arg_43_1:ShouldGrayingPainting(arg_43_2)

	seriesAsync({
		function(arg_44_0)
			if not var_43_5 then
				var_43_1:GetComponent(typeof(CanvasGroup)).alpha = 0
			end

			self:LoadPainting(arg_43_1, var_43_0, arg_44_0)

			if var_43_6 then
				self:SetFadeColor(var_43_1, arg_43_1:GetPaintingData().alpha)
			end

			return
		end,
		function(arg_45_0)
			if var_43_5 then
				arg_45_0()

				return
			end

			self:FadeInPainting(var_43_1, arg_43_1, arg_45_0)

			return
		end,
		function(arg_46_0)
			self:AnimationPainting(arg_43_1, arg_46_0)

			return
		end
	}, arg_43_3)

	return
end

function DialogueStoryPlayer:FadeInPainting(arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = arg_47_2:ShouldAddHeadMaskWhenFade()

	if var_47_0 then
		self:AddHeadMask(arg_47_1)
	end

	self:TweenValueForcanvasGroup(arg_47_1:GetComponent(typeof(CanvasGroup)), 0, 1, arg_47_2:GetFadeInPaintingTime(), 0, function()
		if var_47_0 then
			self:ClearHeadMask(arg_47_1)
		end

		arg_47_3()

		return
	end)

	return
end

function DialogueStoryPlayer:AddHeadMask(arg_49_1)
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
				iter_49_1.material = self.headMaskMat
			elseif iter_49_1.gameObject.name == "face" then
				-- block empty
			elseif iter_49_1.gameObject.transform.parent == var_49_4 then
				iter_49_1.material = self.headObjectMat
			end
		end
	else
		for iter_49_2, iter_49_3 in ipairs(var_49_5) do
			if iter_49_3.gameObject.name == "head_mask" then
				iter_49_3.material = self.headMaskMat
			elseif iter_49_3.gameObject.name == "face" then
				-- block empty
			else
				iter_49_3.material = self.headObjectMat
			end
		end
	end

	return
end

function DialogueStoryPlayer:ClearHeadMask(arg_50_1)
	local var_50_0 = arg_50_1:Find("fitter")

	if not var_50_0 or var_50_0.childCount <= 0 then
		return
	end

	Destroy(var_50_0:GetChild(0):Find("head_mask").gameObject)

	for iter_50_0, iter_50_1 in ipairs((arg_50_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
		iter_50_1.material = iter_50_1.defaultGraphicMaterial
	end

	return
end

function DialogueStoryPlayer:AnimationPainting(arg_51_1, arg_51_2)
	if arg_51_1:IsLive2dPainting() or arg_51_1:IsSpinePainting() then
		arg_51_2()

		return
	end

	local var_51_0, var_51_1, var_51_2, var_51_3 = self:GetSideTF(arg_51_1:GetSide())

	self:StartPaintingActions(var_51_0, arg_51_1, arg_51_2)

	return
end

function DialogueStoryPlayer:LoadPainting(arg_52_1, arg_52_2, arg_52_3)
	local var_52_0, var_52_1, var_52_2, var_52_3 = self:GetSideTF(arg_52_1:GetSide())
	local var_52_4, var_52_5 = arg_52_1:GetPaintingAndName()

	if arg_52_1:IsLive2dPainting() and checkABExist("live2d/" .. var_52_5) and not Live2dConst.GetLive2DArm32MatchAble() then
		self:UpdateLive2dPainting(arg_52_1, var_52_0, arg_52_2, arg_52_3)
	elseif arg_52_1:IsSpinePainting() and checkABExist("spinepainting/" .. var_52_5) then
		self:UpdateSpinePainting(arg_52_1, var_52_0, arg_52_2, arg_52_3)
	else
		self:UpdateMeshPainting(arg_52_1, var_52_0, var_52_3, arg_52_2, arg_52_3)
	end

	return
end

function DialogueStoryPlayer:UpdateLive2dPainting(arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	local function var_53_0(arg_56_0)
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
	end

	if not arg_53_3 and self.live2dChars[arg_53_2] then
		var_53_0(self.live2dChars[arg_53_2])
	else
		(function(arg_54_0)
			local var_54_0 = arg_53_1:GetVirtualShip()
			local var_54_1 = GetOrAddComponent(self._go, typeof(CanvasGroup))

			var_54_1.blocksRaycasts = false
			self.live2dChars[arg_53_2] = Live2DPainting.New(Live2DPainting.GenerateData({
				ship = var_54_0,
				offset = var_54_0:GetSkinConfig().live2d_offset,
				position = arg_53_1:GetLive2dPos() or Vector3(0, 0, 0),
				parent = arg_53_2:Find("live2d")
			}), function(arg_55_0)
				arg_55_0._go.name = arg_53_1:GetPainting()

				local var_55_0 = arg_55_0._go:GetComponent(typeof(CubismRenderController))

				var_55_0.SortingOrder = self.sortingOrder + 1
				var_55_0.SortingMode = CubismSortingMode.BackToFrontOrder

				local var_55_1 = GetOrAddComponent(self.front, typeof(Canvas))

				GetOrAddComponent(self.front, typeof(GraphicRaycaster))

				var_55_1.overrideSorting = true
				var_55_1.sortingOrder = self.sortingOrder + 1 + arg_55_0._tf:Find("Drawables").childCount
				var_54_1.blocksRaycasts = true

				if arg_54_0 then
					arg_54_0(arg_55_0)
				end

				return
			end)

			return
		end)(var_53_0)
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
	local var_57_5 = {}

	for iter_57_4, iter_57_5 in ipairs(var_57_4) do
		local var_57_6 = ReflectionHelp.RefGetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_57_5)

		var_57_5[iter_57_4] = var_57_6

		if var_57_6 - var_57_1 < var_57_2 then
			var_57_2 = var_57_6 - var_57_1
		end
	end

	for iter_57_6, iter_57_7 in ipairs(var_57_0) do
		iter_57_7.sortingOrder = arg_57_2 - var_57_2 + 1 + (iter_57_6 - 1)
	end

	local var_57_7 = arg_57_2 - var_57_2 + 1 + 1

	for iter_57_8, iter_57_9 in ipairs(var_57_3) do
		iter_57_9.sortingOrder = arg_57_2 - var_57_2 + 1 + (iter_57_9.sortingOrder - var_57_1)

		if arg_57_2 - var_57_2 + 1 < arg_57_2 - var_57_2 + 1 + (iter_57_9.sortingOrder - var_57_1) then
			var_57_7 = arg_57_2 - var_57_2 + 1 + (iter_57_9.sortingOrder - var_57_1)
		end
	end

	for iter_57_10, iter_57_11 in ipairs(var_57_4) do
		ReflectionHelp.RefSetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_57_11, arg_57_2 - var_57_2 + 1 + (var_57_5[iter_57_10] - var_57_1))

		if arg_57_2 - var_57_2 + 1 < arg_57_2 - var_57_2 + 1 + (var_57_5[iter_57_10] - var_57_1) then
			var_57_7 = arg_57_2 - var_57_2 + 1 + (var_57_5[iter_57_10] - var_57_1)
		end
	end

	return var_57_7
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

function DialogueStoryPlayer:UpdateSpinePainting(arg_59_1, arg_59_2, arg_59_3, arg_59_4)
	if not arg_59_3 and self.spinePainings[arg_59_2] then
		self:UpdateSpineExpression(self.spinePainings[arg_59_2], arg_59_1)
		arg_59_4()
	else
		(function(arg_60_0)
			local var_60_0 = arg_59_2:Find("spine")
			local var_60_1 = arg_59_2:Find("spinebg")

			setActive(var_60_1, not arg_59_1:IsHideSpineBg())

			self.spinePainings[arg_59_2] = SpinePainting.New(SpinePainting.GenerateData({
				ship = arg_59_1:GetVirtualShip(),
				position = arg_59_1:GetSpinePosition(),
				parent = var_60_0,
				effectParent = var_60_1
			}), function(arg_61_0)
				arg_61_0._go.name = arg_59_1:GetPainting()

				local var_61_0 = self.sortingOrder
				local var_61_1 = arg_59_1:GetSpineOrderIndex()

				var_61_0 = not var_61_1 and var_0_7(var_60_0, var_60_1, self.sortingOrder) or var_0_8(var_60_0, var_61_1, self.sortingOrder)

				local var_61_2 = GetOrAddComponent(self.front, typeof(Canvas))

				GetOrAddComponent(self.front, typeof(GraphicRaycaster))

				var_61_2.overrideSorting = true
				var_61_2.sortingOrder = var_61_0 + 1

				self:UpdateSpineExpression(arg_61_0, arg_59_1)

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

function DialogueStoryPlayer:UpdateSpineExpression(arg_62_1, arg_62_2)
	local var_62_0 = arg_62_2:GetSpineExPression()

	if var_62_0 then
		arg_62_1:SetAction(var_62_0, 1)
	else
		arg_62_1:SetEmptyAction(1)
	end

	return
end

function DialogueStoryPlayer:UpdateMeshPainting(arg_63_1, arg_63_2, arg_63_3, arg_63_4, arg_63_5)
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

		self:UpdateActorPostion(arg_63_2, arg_63_1)
		self:UpdateExpression(var_63_4, arg_63_1)
		self:AddGlitchArtEffectForPating(arg_63_2, var_63_4, arg_63_1)
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
			self:setPaintingAlpha(arg_63_2, var_63_6)
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

function DialogueStoryPlayer:InitSubPainting(arg_66_1, arg_66_2, arg_66_3)
	local function var_66_0(arg_67_0, arg_67_1)
		setPaintingPrefab(arg_67_1, var_0_9(arg_67_0), "duihua")

		local var_67_0 = findTF(arg_67_1, "fitter"):GetChild(0)
		local var_67_1 = findTF(var_67_0, "face")

		if (not arg_67_0.expression and arg_67_0.name and ShipExpressionHelper.DefaultFaceless(arg_67_0.name) or nil) and ShipExpressionHelper.GetDefaultFace(arg_67_0.name) then
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
			self:AddGlitchArtEffectForPating(arg_67_1, var_67_0, arg_66_3)
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

function DialogueStoryPlayer:DisappearSubPainting(arg_69_1, arg_69_2, arg_69_3)
	local var_69_0, var_69_1 = arg_69_2:GetDisappearTime()
	local var_69_2 = {}
	local var_69_3 = {}

	for iter_69_0, iter_69_1 in ipairs((arg_69_2:GetSubPaintings())) do
		table.insert(var_69_3, iter_69_1)
	end

	for iter_69_2, iter_69_3 in ipairs((arg_69_2:GetDisappearSeq())) do
		local var_69_4 = iter_69_3

		table.insert(var_69_2, function(arg_70_0)
			for iter_70_0, iter_70_1 in ipairs(var_69_3) do
				if iter_70_1.actor == var_69_4 then
					table.remove(var_69_3, iter_70_0)

					break
				end
			end

			self:InitSubPainting(arg_69_1, var_69_3, arg_69_2)
			self:DelayCall(var_69_1, arg_70_0)

			return
		end)
	end

	arg_69_1.container:SetAsFirstSibling()
	self:DelayCall(var_69_0, function()
		seriesAsync(var_69_2, function()
			arg_69_1.container:SetAsLastSibling()
			arg_69_3()

			return
		end)

		return
	end)

	return
end

function DialogueStoryPlayer:UpdateActorPostion(arg_73_1, arg_73_2)
	local var_73_0 = arg_73_2:GetPaitingOffst()

	if var_73_0 then
		arg_73_1.localPosition = Vector3(arg_73_1.localPosition.x + (var_73_0.x or 0), arg_73_1.localPosition.y + (var_73_0.y or 0), 0)
	end

	return
end

function DialogueStoryPlayer:UpdateExpression(arg_74_1, arg_74_2)
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

function DialogueStoryPlayer:StartPaintingActions(arg_75_1, arg_75_2, arg_75_3)
	parallelAsync({
		function(arg_76_0)
			self:StartPatiningMoveAction(arg_75_1, arg_75_2, arg_76_0)

			return
		end,
		function(arg_77_0)
			self:StartPatiningShakeAction(arg_75_1, arg_75_2, arg_77_0)

			return
		end,
		function(arg_78_0)
			self:StartPatiningZoomAction(arg_75_1, arg_75_2, arg_78_0)

			return
		end,
		function(arg_79_0)
			self:StartPatiningRotateAction(arg_75_1, arg_75_2, arg_79_0)

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

function DialogueStoryPlayer:StartPatiningShakeAction(arg_81_1, arg_81_2, arg_81_3)
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

		self:TweenMove(arg_81_1, Vector3(var_82_5.x + var_82_0, var_82_5.y + var_82_1, 0), var_82_2, var_82_4, var_82_3, arg_82_1)

		return
	end

	local var_81_2 = {}

	for iter_81_0, iter_81_1 in pairs(var_81_0) do
		table.insert(var_81_2, function(arg_83_0)
			var_81_1(iter_81_1, arg_83_0)

			return
		end)
	end

	parallelAsync(var_81_2, function()
		if arg_81_3 then
			arg_81_3()
		end

		return
	end)

	return
end

function DialogueStoryPlayer:StartPatiningZoomAction(arg_85_1, arg_85_2, arg_85_3)
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

		self:TweenScale(arg_85_1, Vector3(var_86_1[1], var_86_1[2], var_86_1[3]), arg_86_0.dur or 0, arg_86_0.delay or 0, arg_86_1)

		return
	end

	local var_85_2 = {}

	for iter_85_0, iter_85_1 in pairs(var_85_0) do
		table.insert(var_85_2, function(arg_87_0)
			var_85_1(iter_85_1, arg_87_0)

			return
		end)
	end

	parallelAsync(var_85_2, function()
		if arg_85_3 then
			arg_85_3()
		end

		return
	end)

	return
end

function DialogueStoryPlayer:StartPatiningRotateAction(arg_89_1, arg_89_2, arg_89_3)
	local var_89_0 = arg_89_2:GetPaintingAction(DialogueStep.PAINTING_ACTION_ROTATE)

	if not var_89_0 then
		arg_89_3()

		return
	end

	local function var_89_1(arg_90_0, arg_90_1)
		self:TweenRotate(arg_89_1, arg_90_0.value, arg_90_0.dur or 1, arg_90_0.number or 1, arg_90_0.delay or 0, arg_90_1)

		return
	end

	local var_89_2 = {}

	for iter_89_0, iter_89_1 in pairs(var_89_0) do
		table.insert(var_89_2, function(arg_91_0)
			var_89_1(iter_89_1, arg_91_0)

			return
		end)
	end

	parallelAsync(var_89_2, function()
		if arg_89_3 then
			arg_89_3()
		end

		return
	end)

	return
end

function DialogueStoryPlayer:StartPatiningMoveAction(arg_93_1, arg_93_2, arg_93_3)
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

		self:TweenMove(arg_93_1, Vector3(var_94_4.x + var_94_0, var_94_4.y + var_94_1, 0), var_94_2, 1, var_94_3, arg_94_1)

		return
	end

	local var_93_2 = {}

	for iter_93_0, iter_93_1 in pairs(var_93_0) do
		table.insert(var_93_2, function(arg_95_0)
			var_93_1(iter_93_1, arg_95_0)

			return
		end)
	end

	parallelAsync(var_93_2, function()
		if arg_93_3 then
			arg_93_3()
		end

		return
	end)

	return
end

function DialogueStoryPlayer:StartMovePrevPaintingToSide(arg_97_1, arg_97_2, arg_97_3)
	local var_97_0 = arg_97_1:GetPaintingMoveToSide()

	if not var_97_0 or not arg_97_2 then
		arg_97_3()

		return
	end

	local var_97_1 = self:GetSideTF(arg_97_2:GetSide())

	if not var_97_1 then
		arg_97_3()

		return
	end

	local var_97_2 = var_97_0.time
	local var_97_3 = self:GetSideTF(var_97_0.side)

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

	self:TweenValue(var_97_3, var_97_1.localPosition.x, tf(var_97_3).localPosition.x, var_97_2, 0, function(arg_98_0)
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
			end
		else
			iter_99_1.material = iter_99_1.gameObject.name == "face" and arg_99_0.glitchArtMaterial or arg_99_3.hasPaintbg and iter_99_1.gameObject == arg_99_2.gameObject and arg_99_0.glitchArtMaterialForPaintingBg or arg_99_0.glitchArtMaterialForPainting
		end
	end

	return
end

local function var_0_11(arg_100_0, arg_100_1, arg_100_2, arg_100_3, arg_100_4)
	local var_100_0 = arg_100_1:GetComponentsInChildren(typeof(Image))
	local var_100_1 = {}

	if var_100_0 then
		table.insert(var_100_1, arg_100_2:GetComponent(typeof(Image)).gameObject)
	end

	for iter_100_0 = 1, arg_100_3 - 1 do
		table.insert(var_100_1, arg_100_4:GetChild(iter_100_0 - 1).gameObject)
	end

	for iter_100_1, iter_100_2 in ipairs((var_100_0:ToTable())) do
		iter_100_2.material = iter_100_2.gameObject.name == "temp_mask" and arg_100_0.maskMaterial or iter_100_2.gameObject.name == "face" and arg_100_0.glitchArtMaterial or table.contains(var_100_1, iter_100_2.gameObject) and arg_100_0.glitchArtMaterialForPaintingBg or arg_100_0.glitchArtMaterialForPainting
	end

	return
end

function DialogueStoryPlayer:AddGlitchArtEffectForPating(arg_101_1, arg_101_2, arg_101_3)
	local var_101_0 = arg_101_3:ShouldAddGlitchArtEffect()

	if var_101_0 and arg_101_3:GetExPression() ~= nil and not arg_101_3:IsNoHeadPainting() then
		local var_101_1 = arg_101_2:Find("face")

		cloneTplTo(var_101_1, var_101_1.parent, "temp_mask"):SetAsFirstSibling()

		local var_101_2 = arg_101_2:Find("layers")
		local var_101_3 = IsNil(var_101_2)

		if not var_101_3 and arg_101_3:GetPaintingRwIndex() > 0 then
			var_0_11(self, arg_101_1, arg_101_2, arg_101_3:GetPaintingRwIndex(), var_101_2)
		else
			var_0_10(self, arg_101_1, arg_101_2, arg_101_3, var_101_3)
		end
	elseif var_101_0 then
		for iter_101_0, iter_101_1 in ipairs((arg_101_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
			iter_101_1.material = self.glitchArtMaterial
		end
	end

	if var_101_0 then
		local var_101_4 = GameObject.Find("/OverlayCamera/Overlay/UIMain/AwardInfoUI(Clone)/items/SpriteMask")

		if var_101_4 and var_101_4.activeInHierarchy then
			setActive(var_101_4, false)

			self.spriteMask = var_101_4
		end
	end

	return
end

function DialogueStoryPlayer:UpdateContent(arg_102_1, arg_102_2)
	local function var_102_0()
		setActive(self.nextTr, true)
		arg_102_2()

		return
	end

	setActive(self.dialoguePanel, not arg_102_1:ShouldHideDialogue())

	for iter_102_0, iter_102_1 in ipairs(self.tags) do
		setActive(iter_102_1, iter_102_0 == arg_102_1:GetTag())
	end

	self.conentTxt.fontSize = arg_102_1:GetFontSize() or self.defualtFontSize

	local var_102_1 = arg_102_1:GetContent()

	self.conentTxt.text = var_102_1
	self.conentTxt.color = Color.NewHex(arg_102_1:GetContentColor())

	if var_102_1 and var_102_1 ~= "" and var_102_1 ~= "…" and #var_102_1 > 1 and ((var_102_1 and var_102_1 ~= "" or nil) and System.String.New(var_102_1).Length) > 1 then
		self:UpdateTypeWriter(arg_102_1, var_102_0)
	else
		var_102_0()
	end

	local var_102_3 = false
	local var_102_4, var_102_5, var_102_6, var_102_7 = self:GetSideTF(arg_102_1:GetSide())

	if var_102_5 then
		local var_102_8 = arg_102_1:GetNameWithColor()
		local var_102_9 = var_102_8 and var_102_8 ~= ""

		var_102_3 = var_102_8 and var_102_8 ~= ""

		setActive(var_102_5, var_102_8 and var_102_8 ~= "")

		if var_102_9 then
			var_102_5:Find("Text"):GetComponent(typeof(Outline)).effectColor = Color.NewHex((arg_102_1:GetNameColorCode()))
		end

		var_102_6.text = var_102_8

		setText(var_102_6.gameObject.transform:Find("subText"), arg_102_1:GetSubActorName())
	end

	if self.script:IsDialogueStyle2() then
		setActive(self.tag4Dialog2, not var_102_3)
	end

	return
end

function DialogueStoryPlayer:SetContentBgAlpha(arg_104_1)
	if self.contentBgAlpha ~= arg_104_1 then
		for iter_104_0, iter_104_1 in ipairs(self.contentBgs) do
			GetOrAddComponent(iter_104_1, typeof(CanvasGroup)).alpha = arg_104_1
		end

		self.contentBgAlpha = arg_104_1
	end

	return
end

function DialogueStoryPlayer:GetSideTF(arg_105_1)
	local var_105_0
	local var_105_1
	local var_105_2
	local var_105_3

	if DialogueStep.SIDE_LEFT == arg_105_1 then
		var_105_3 = self.subActorLeft
		var_105_2 = self.nameTxt
		var_105_1 = self.nameTr
		var_105_0 = self.actorLeft
	elseif DialogueStep.SIDE_RIGHT == arg_105_1 then
		var_105_3 = self.subActorRgiht
		var_105_2 = self.nameTxt
		var_105_1 = self.nameTr
		var_105_0 = self.actorRgiht
	elseif DialogueStep.SIDE_MIDDLE == arg_105_1 then
		var_105_3 = self.subActorMiddle
		var_105_2 = self.nameTxt
		var_105_1 = self.nameTr
		var_105_0 = self.actorMiddle
	end

	return var_105_0, var_105_1, var_105_2, var_105_3
end

function DialogueStoryPlayer:RecyclesSubPantings(arg_106_1)
	arg_106_1:each(function(arg_107_0, arg_107_1)
		self:RecyclePainting(arg_107_1)

		return
	end)

	return
end

function DialogueStoryPlayer:ClearMeshPainting(arg_109_1)
	self:ResetMeshPainting(arg_109_1)

	if arg_109_1:Find("fitter").childCount == 0 then
		return
	end

	local var_109_0 = arg_109_1:Find("fitter"):GetChild(0)

	if var_109_0 then
		retPaintingPrefab(arg_109_1, var_109_0.name)
	end

	return
end

function DialogueStoryPlayer:ResetMeshPainting(arg_110_1)
	if arg_110_1:Find("fitter").childCount == 0 then
		return
	end

	local var_110_0 = arg_110_1:Find("fitter"):GetChild(0)

	if var_110_0 then
		local var_110_1 = findTF(var_110_0, "shadow")

		if var_110_1 then
			setActive(var_110_1, false)
		end

		for iter_110_0, iter_110_1 in ipairs((arg_110_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
			if iter_110_1.material ~= iter_110_1.defaultGraphicMaterial then
				iter_110_1.material = iter_110_1.defaultGraphicMaterial

				iter_110_1.material:SetColor("_Color", Color.white)
			else
				iter_110_1.material = nil
			end
		end

		setGray(var_110_0, false, true)

		local var_110_2 = var_110_0:Find("temp_mask")

		if var_110_2 then
			Destroy(var_110_2.gameObject)
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

	if var_111_0 and table.getCount(arg_111_0.live2dChars) <= 0 then
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

	if var_112_0 and table.getCount(arg_112_0.spinePainings) <= 0 then
		RemoveComponent(arg_112_0.front, "GraphicRaycaster")
		RemoveComponent(arg_112_0.front, "Canvas")
	end

	return
end

function DialogueStoryPlayer:RecyclePainting(arg_113_1)
	if type(arg_113_1) == "table" then
		self:RecyclePaintingList((_.map(arg_113_1, function(arg_114_0)
			return self[arg_114_0]
		end)))
	else
		self:ClearMeshPainting(arg_113_1)
		var_0_13(self, arg_113_1)
		var_0_14(self, arg_113_1)
	end

	return
end

function DialogueStoryPlayer:RecyclePaintingList(arg_115_1)
	for iter_115_0, iter_115_1 in ipairs(arg_115_1) do
		self:ClearMeshPainting(iter_115_1)
		var_0_13(self, iter_115_1)
		var_0_14(self, iter_115_1)
	end

	return
end

function DialogueStoryPlayer:Resume()
	DialogueStoryPlayer.super.Resume(self)

	if self.typewriterSpeed ~= 0 then
		self.typewriter:setSpeed(self.typewriterSpeed)
	end

	return
end

function DialogueStoryPlayer:Pause()
	DialogueStoryPlayer.super.Pause(self)

	if self.typewriterSpeed ~= 0 then
		self.typewriter:setSpeed(0)
	end

	return
end

function DialogueStoryPlayer:OnClear()
	if self.spriteMask then
		setActive(self.spriteMask, true)

		self.spriteMask = nil
	end

	return
end

function DialogueStoryPlayer:FadeOutPainting(arg_119_1, arg_119_2, arg_119_3)
	local var_119_0 = arg_119_1:GetFadeOutPaintingTime()

	if var_119_0 <= 0 then
		arg_119_3()

		return
	end

	local var_119_1 = arg_119_1:ShouldAddHeadMaskWhenFade()

	if var_119_1 then
		self:AddHeadMask(arg_119_2)
	end

	self:TweenValueForcanvasGroup(arg_119_2:GetComponent(typeof(CanvasGroup)), 1, 0, var_119_0, 0, function()
		if var_119_1 then
			self:ClearHeadMask(arg_119_2)
		end

		arg_119_3()

		return
	end)

	return
end

function DialogueStoryPlayer:OnWillExit(arg_121_1, arg_121_2, arg_121_3)
	if not arg_121_2 or not arg_121_2:IsDialogueMode() then
		arg_121_3()

		return
	end

	local var_121_0 = self:GetRecycleActorList(arg_121_2, arg_121_1)
	local var_121_1

	if arg_121_2:ShouldMoveToSide() then
		var_121_1 = self:GetSideTF(arg_121_1:GetSide())
	end

	local var_121_2 = {}

	for iter_121_0, iter_121_1 in pairs(var_121_0) do
		if (not var_121_1 or iter_121_1 ~= var_121_1) and iter_121_1:Find("fitter").childCount > 0 then
			table.insert(var_121_2, function(arg_122_0)
				self:FadeOutPainting(arg_121_1, iter_121_1, arg_122_0)

				return
			end)
		end
	end

	parallelAsync(var_121_2, arg_121_3)

	return
end

function DialogueStoryPlayer:OnEnd()
	if self.conentTxt then
		self.conentTxt.fontSize = self.defualtFontSize
		self.conentTxt.text = ""
	end

	if self.nameTxt then
		self.nameTxt.text = ""
	end

	self:ClearGlitchArtForPortrait()
	self:ClearCanMarkNode()
	self:RecyclePainting({
		"actorLeft",
		"actorMiddle",
		"actorRgiht"
	})

	for iter_123_0, iter_123_1 in ipairs({
		"actorLeft",
		"actorMiddle",
		"actorRgiht"
	}) do
		self[iter_123_1]:GetComponent(typeof(CanvasGroup)).alpha = 1
	end

	return
end

return DialogueStoryPlayer
