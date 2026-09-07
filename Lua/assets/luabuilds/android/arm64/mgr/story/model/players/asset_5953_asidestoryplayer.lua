local AsideStoryPlayer = class("AsideStoryPlayer", import(".StoryPlayer"))

function AsideStoryPlayer:Ctor(arg_1_1)
	AsideStoryPlayer.super.Ctor(self, arg_1_1)

	self.hrzList = UIItemList.New(self.asidePanel:Find("aside"), self.asidePanel:Find("aside/aside_txt_tpl"))
	self.vetList = UIItemList.New(self.asidePanel:Find("aside_2"), self.asidePanel:Find("aside_2/aside_txt_tpl_2"))
	self.leftBotomVetList = UIItemList.New(self.asidePanel:Find("aside_3"), self.asidePanel:Find("aside_3/aside_txt_tpl"))
	self.centerWithFrameVetList = UIItemList.New(self.asidePanel:Find("aside_4"), self.asidePanel:Find("aside_4/aside_txt_tpl"))
	self.centerWithFrameVetListMargin = UIItemList.New(self.asidePanel:Find("aside_4_1"), self.asidePanel:Find("aside_4_1/aside_txt_tpl"))
	self.dataTxt = self.asidePanel:Find("aside_sign_date")
	self.meshImagePaintingContainer = self.asidePanel:Find("actor_middle")

	return
end

function AsideStoryPlayer:OnReset(arg_2_1, arg_2_2, arg_2_3)
	setActive(self.asidePanel, true)
	setActive(self.curtain, true)
	setActive(self.hrzList.container, false)
	setActive(self.vetList.container, false)
	setActive(self.leftBotomVetList.container, false)
	setActive(self.centerWithFrameVetList.container, false)
	setActive(self.centerWithFrameVetListMargin.container, false)
	setActive(self.actorPanel, false)

	self.curtainCg.alpha = 1

	setText(self.dataTxt, "")
	arg_2_3()

	return
end

function AsideStoryPlayer:OnInit(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1:ShouldHideBGAlpha() then
		self.color = self.mainImg.color
		self.mainImg.color = Color.New(1, 1, 1, 0)
	end

	seriesAsync({
		function(arg_4_0)
			self:LoadPainting(arg_3_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			if arg_3_1:GetShowMode() == AsideStep.SHOW_MODE_DEFAUT then
				self:PlayAside(arg_3_1, arg_5_0)
			else
				self:PlayBubbleAside(arg_3_1, arg_5_0)
			end

			return
		end,
		function(arg_6_0)
			self:PlayDateSign(arg_3_1, arg_6_0)

			return
		end
	}, arg_3_3)

	return
end

function AsideStoryPlayer:LoadPainting(arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1:GetPainting()

	if not var_7_0 or var_7_0 == "" then
		arg_7_2()

		return
	end

	self.paitingName = var_7_0

	setPaintingPrefabAsync(self.meshImagePaintingContainer, var_7_0, "duihua", function(arg_8_0)
		self.rtPaint = arg_8_0

		if self.paitingName == nil then
			retPaintingPrefab(self.rtPaint, var_7_0)

			return
		end

		arg_7_2()

		return
	end)

	return
end

function AsideStoryPlayer:GetAsideList(arg_9_1, arg_9_2)
	local var_9_0

	if arg_9_1 == AsideStep.ASIDE_TYPE_HRZ then
		var_9_0 = self.hrzList
	elseif arg_9_1 == AsideStep.ASIDE_TYPE_VEC then
		var_9_0 = self.vetList
	elseif arg_9_1 == AsideStep.ASIDE_TYPE_LEFTBOTTOMVEC then
		var_9_0 = self.leftBotomVetList
	elseif arg_9_1 == AsideStep.ASIDE_TYPE_CENTERWITHFRAME then
		var_9_0 = arg_9_2:ShouldUpdateMargin() and self.centerWithFrameVetListMargin or self.centerWithFrameVetList
	end

	return var_9_0
end

function AsideStoryPlayer:PlayAside(arg_10_1, arg_10_2)
	local var_10_0 = {}
	local var_10_1 = self:GetAsideList(arg_10_1:GetAsideType(), arg_10_1)

	self:UpdateLayoutPaddingAndSpacing(arg_10_1, var_10_1.container)

	local var_10_2 = Mathf.Sign(var_10_1.container.localScale.x)

	setActive(var_10_1.container, true)

	local var_10_3 = arg_10_1:GetSequence()

	var_10_1:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = var_10_3[arg_11_1 + 1][2]

			setText(arg_11_2, (HXSet.hxLan(var_10_3[arg_11_1 + 1][1])))

			local var_11_1 = GetOrAddComponent(arg_11_2, typeof(CanvasGroup))

			var_11_1.alpha = 0

			table.insert(var_10_0, function(arg_12_0)
				self:TweenValueForcanvasGroup(var_11_1, 0, 1, arg_10_1.sequenceSpd or 1, var_11_0, arg_12_0)

				return
			end)

			if var_10_2 ~= Mathf.Sign(arg_11_2.localScale.x) then
				arg_11_2.localScale = Vector3(var_10_2 * arg_11_2.localScale.x, arg_11_2.localScale.y, 1)
			end
		end

		return
	end)
	var_10_1:align(#var_10_3)
	parallelAsync(var_10_0, arg_10_2)

	return
end

function AsideStoryPlayer:PlayBubbleAside(arg_13_1, arg_13_2)
	local var_13_0 = self:GetAsideList(arg_13_1:GetAsideType(), arg_13_1)

	self:UpdateLayoutPaddingAndSpacing(arg_13_1, var_13_0.container)

	local var_13_1 = Mathf.Sign(var_13_0.container.localScale.x)
	local var_13_2 = arg_13_1:GetSequence()

	setActive(var_13_0.container, true)

	for iter_13_0 = var_13_0.container.childCount, 1, -1 do
		local var_13_3 = var_13_0.container:GetChild(iter_13_0 - 1)

		if var_13_3 ~= var_13_0.item then
			Object.Destroy(var_13_3.gameObject)
		end
	end

	local var_13_4 = {}

	for iter_13_1 = 1, #var_13_2 do
		table.insert(var_13_4, function(arg_14_0)
			local var_14_0 = cloneTplTo(var_13_0.item, var_13_0.container, iter_13_1)

			setText(var_14_0, HXSet.hxLan(var_13_2[iter_13_1][1]))

			local var_14_1 = GetOrAddComponent(var_14_0, typeof(Typewriter))

			function var_14_1.endFunc()
				arg_14_0()

				return
			end

			var_14_1:setSpeed(arg_13_1:GetTypewriterSpeed())
			var_14_1:Play()

			return
		end)
	end

	seriesAsync(var_13_4, arg_13_2)

	return
end

function AsideStoryPlayer:UpdateLayoutPaddingAndSpacing(arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1:ShouldUpdateSpacing()
	local var_16_1 = arg_16_1:ShouldUpdatePadding()
	local var_16_2 = arg_16_1:ShouldUpdateMargin()

	if (var_16_0 or var_16_1) and not var_16_2 then
		local var_16_3 = arg_16_2:GetComponent(typeof(UnityEngine.UI.HorizontalOrVerticalLayoutGroup))

		if var_16_0 then
			var_16_3.spacing, self.spacing = arg_16_1:GetSpacing(), var_16_3.spacing
		end

		if var_16_1 then
			local var_16_4, var_16_5, var_16_6, var_16_7 = arg_16_1:GetPadding()
			local var_16_8 = UnityEngine.RectOffset.New()

			var_16_8.bottom = var_16_5
			var_16_8.left = var_16_6
			var_16_8.right = var_16_7
			var_16_8.top = var_16_4
			self.padding = var_16_3.padding
			var_16_3.padding = var_16_8
		end
	elseif var_16_2 then
		if var_16_0 then
			arg_16_2:GetComponent(typeof(UnityEngine.UI.HorizontalOrVerticalLayoutGroup)).spacing = arg_16_1:GetSpacing()
		end

		local var_16_10, var_16_11, var_16_12, var_16_13 = arg_16_1:GetMargin()
		local var_16_14 = rtf(arg_16_2)

		var_16_14.offsetMin = Vector2(var_16_12, var_16_11)
		var_16_14.offsetMax = Vector2(-var_16_13, -var_16_10)

		eachChild(arg_16_2, function(arg_17_0)
			GetOrAddComponent(arg_17_0, typeof(LayoutElement)).preferredWidth = var_16_14.rect.width - 50

			return
		end)
	end

	self:UpdateRectAlhpa(arg_16_1, arg_16_2)

	return
end

function AsideStoryPlayer:UpdateRectAlhpa(arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2:GetComponent(typeof(Image))

	if not var_18_0 then
		return
	end

	var_18_0.color = Color.New(1, 1, 1, (arg_18_1:GetRectAlpha()))

	return
end

function AsideStoryPlayer:PlayDateSign(arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1:GetDateSign()

	if not var_19_0 then
		arg_19_2()

		return
	end

	local var_19_1 = var_19_0[3] or {}

	setText(self.dataTxt, (HXSet.hxLan(var_19_0[1])))

	local var_19_2 = GetOrAddComponent(self.dataTxt, typeof(CanvasGroup))

	var_19_2.alpha = 0

	self:TweenValueForcanvasGroup(var_19_2, 1, 0, arg_19_1.sequenceSpd or 1, var_19_0[2], arg_19_2)
	setAnchoredPosition(self.dataTxt, Vector3(var_19_1[1], var_19_1[2], 0))

	return
end

function AsideStoryPlayer:OnWillClear(arg_20_1, arg_20_2, arg_20_3)
	if self.color then
		self.mainImg.color = self.color
	end

	self.color = nil

	if self.padding or self.spacing then
		self:ResetPaddingAndSpacing(self:GetAsideList(arg_20_1:GetAsideType(), arg_20_1).container, self.padding, self.spacing)
	end

	self.padding = nil
	self.spacing = nil

	if self.paitingName and self.rtPaint then
		retPaintingPrefab(self.meshImagePaintingContainer, self.paitingName)
	end

	self.paitingName = nil
	self.rtPaint = nil

	return
end

function AsideStoryPlayer:ResetPaddingAndSpacing(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_1:GetComponent(typeof(UnityEngine.UI.HorizontalOrVerticalLayoutGroup))

	if arg_21_2 then
		var_21_0.padding = arg_21_2
	end

	if arg_21_3 then
		var_21_0.spacing = arg_21_3
	end

	return
end

function AsideStoryPlayer:OnEnd()
	return
end

return AsideStoryPlayer
