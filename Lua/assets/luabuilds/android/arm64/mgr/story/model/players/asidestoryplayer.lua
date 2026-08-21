local var_0_0 = class("AsideStoryPlayer", import(".StoryPlayer"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.hrzList = UIItemList.New(arg_1_0.asidePanel:Find("aside"), arg_1_0.asidePanel:Find("aside/aside_txt_tpl"))
	arg_1_0.vetList = UIItemList.New(arg_1_0.asidePanel:Find("aside_2"), arg_1_0.asidePanel:Find("aside_2/aside_txt_tpl_2"))
	arg_1_0.leftBotomVetList = UIItemList.New(arg_1_0.asidePanel:Find("aside_3"), arg_1_0.asidePanel:Find("aside_3/aside_txt_tpl"))
	arg_1_0.centerWithFrameVetList = UIItemList.New(arg_1_0.asidePanel:Find("aside_4"), arg_1_0.asidePanel:Find("aside_4/aside_txt_tpl"))
	arg_1_0.centerWithFrameVetListMargin = UIItemList.New(arg_1_0.asidePanel:Find("aside_4_1"), arg_1_0.asidePanel:Find("aside_4_1/aside_txt_tpl"))
	arg_1_0.dataTxt = arg_1_0.asidePanel:Find("aside_sign_date")
	arg_1_0.meshImagePaintingContainer = arg_1_0.asidePanel:Find("actor_middle")

	return
end

function var_0_0.OnReset(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	setActive(arg_2_0.asidePanel, true)
	setActive(arg_2_0.curtain, true)
	setActive(arg_2_0.hrzList.container, false)
	setActive(arg_2_0.vetList.container, false)
	setActive(arg_2_0.leftBotomVetList.container, false)
	setActive(arg_2_0.centerWithFrameVetList.container, false)
	setActive(arg_2_0.centerWithFrameVetListMargin.container, false)
	setActive(arg_2_0.actorPanel, false)

	arg_2_0.curtainCg.alpha = 1

	setText(arg_2_0.dataTxt, "")
	arg_2_3()

	return
end

function var_0_0.OnInit(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1:ShouldHideBGAlpha() then
		arg_3_0.color = arg_3_0.mainImg.color
		arg_3_0.mainImg.color = Color.New(1, 1, 1, 0)
	end

	seriesAsync({
		function(arg_4_0)
			arg_3_0:LoadPainting(arg_3_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			if arg_3_1:GetShowMode() == AsideStep.SHOW_MODE_DEFAUT then
				arg_3_0:PlayAside(arg_3_1, arg_5_0)
			else
				arg_3_0:PlayBubbleAside(arg_3_1, arg_5_0)
			end

			return
		end,
		function(arg_6_0)
			arg_3_0:PlayDateSign(arg_3_1, arg_6_0)

			return
		end
	}, arg_3_3)

	return
end

function var_0_0.LoadPainting(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1:GetPainting()

	if not var_7_0 or var_7_0 == "" then
		arg_7_2()

		return
	end

	arg_7_0.paitingName = var_7_0

	setPaintingPrefabAsync(arg_7_0.meshImagePaintingContainer, var_7_0, "duihua", function(arg_8_0)
		arg_7_0.rtPaint = arg_8_0

		if arg_7_0.paitingName == nil then
			retPaintingPrefab(arg_7_0.rtPaint, var_7_0)

			return
		end

		arg_7_2()

		return
	end)

	return
end

function var_0_0.GetAsideList(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0

	if arg_9_1 == AsideStep.ASIDE_TYPE_HRZ then
		var_9_0 = arg_9_0.hrzList
	elseif arg_9_1 == AsideStep.ASIDE_TYPE_VEC then
		var_9_0 = arg_9_0.vetList
	elseif arg_9_1 == AsideStep.ASIDE_TYPE_LEFTBOTTOMVEC then
		var_9_0 = arg_9_0.leftBotomVetList
	elseif arg_9_1 == AsideStep.ASIDE_TYPE_CENTERWITHFRAME then
		var_9_0 = arg_9_2:ShouldUpdateMargin() and arg_9_0.centerWithFrameVetListMargin or arg_9_0.centerWithFrameVetList
	end

	return var_9_0
end

function var_0_0.PlayAside(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}
	local var_10_1 = arg_10_0:GetAsideList(arg_10_1:GetAsideType(), arg_10_1)

	arg_10_0:UpdateLayoutPaddingAndSpacing(arg_10_1, var_10_1.container)

	local var_10_2 = Mathf.Sign(var_10_1.container.localScale.x)

	setActive(var_10_1.container, true)

	local var_10_3 = arg_10_1:GetSequence()

	var_10_1:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = var_10_3[arg_11_1 + 1][2]

			setText(arg_11_2, (HXSet.hxLan(var_10_3[arg_11_1 + 1][1])))

			local var_11_1 = GetOrAddComponent(arg_11_2, typeof(CanvasGroup))

			GetOrAddComponent(arg_11_2, typeof(CanvasGroup)).alpha = 0

			table.insert(var_10_0, function(arg_12_0)
				local var_12_0 = arg_10_1.sequenceSpd or 1

				arg_10_0:TweenValueForcanvasGroup(var_11_1, 0, 1, var_12_0, var_11_0, arg_12_0)

				return
			end)

			if var_10_2 ~= Mathf.Sign(arg_11_2.localScale.x) then
				arg_11_2.localScale = Vector3(var_10_2 * arg_11_2.localScale.x, arg_11_2.localScale.y, 1)
			end
		end

		return
	end)
	var_10_1:align(#arg_10_1:GetSequence())
	parallelAsync({}, arg_10_2)

	return
end

function var_0_0.PlayBubbleAside(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:GetAsideList(arg_13_1:GetAsideType(), arg_13_1)

	arg_13_0:UpdateLayoutPaddingAndSpacing(arg_13_1, var_13_0.container)

	local var_13_1 = Mathf.Sign(var_13_0.container.localScale.x)
	local var_13_2 = arg_13_1:GetSequence()

	setActive(var_13_0.container, true)

	for iter_13_0 = var_13_0.container.childCount, 1, -1 do
		local var_13_3 = var_13_0.container:GetChild(iter_13_0 - 1)

		if var_13_3 ~= var_13_0.item then
			Object.Destroy(var_13_3.gameObject)
		end
	end

	for iter_13_1 = 1, #arg_13_1:GetSequence() do
		table.insert({}, function(arg_14_0)
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

	seriesAsync({}, arg_13_2)

	return
end

function var_0_0.UpdateLayoutPaddingAndSpacing(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1:ShouldUpdateSpacing()
	local var_16_1 = arg_16_1:ShouldUpdatePadding()
	local var_16_2 = arg_16_1:ShouldUpdateMargin()

	if (var_16_0 or var_16_1) and not var_16_2 then
		local var_16_3 = arg_16_2:GetComponent(typeof(UnityEngine.UI.HorizontalOrVerticalLayoutGroup))

		if var_16_0 then
			var_16_3.spacing, arg_16_0.spacing = arg_16_1:GetSpacing(), var_16_3.spacing
		end

		if var_16_1 then
			local var_16_4, var_16_5, var_16_6, var_16_7 = arg_16_1:GetPadding()
			local var_16_8 = UnityEngine.RectOffset.New()

			var_16_8.bottom = var_16_5
			var_16_8.left = var_16_6
			var_16_8.right = var_16_7
			var_16_8.top = var_16_4
			arg_16_0.padding = var_16_3.padding
			var_16_3.padding = var_16_8
		end
	elseif var_16_2 then
		local var_16_9 = 0

		if var_16_0 then
			var_16_9 = arg_16_1:GetSpacing()
		end

		arg_16_2:GetComponent(typeof(UnityEngine.UI.HorizontalOrVerticalLayoutGroup)).spacing = var_16_9

		local var_16_10, var_16_11, var_16_12, var_16_13 = arg_16_1:GetMargin()
		local var_16_14 = rtf(arg_16_2)

		var_16_14.offsetMin = Vector2(var_16_12, var_16_11)
		var_16_14.offsetMax = Vector2(-var_16_13, -var_16_10)

		eachChild(arg_16_2, function(arg_17_0)
			GetOrAddComponent(arg_17_0, typeof(LayoutElement)).preferredWidth = var_16_14.rect.width - 50

			return
		end)
	end

	arg_16_0:UpdateRectAlhpa(arg_16_1, arg_16_2)

	return
end

function var_0_0.UpdateRectAlhpa(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2:GetComponent(typeof(Image))

	if not var_18_0 then
		return
	end

	var_18_0.color = Color.New(1, 1, 1, (arg_18_1:GetRectAlpha()))

	return
end

function var_0_0.PlayDateSign(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1:GetDateSign()

	if not var_19_0 then
		arg_19_2()

		return
	end

	local var_19_1 = HXSet.hxLan(var_19_0[1])

	setText(arg_19_0.dataTxt, var_19_1)

	local var_19_3 = GetOrAddComponent(arg_19_0.dataTxt, typeof(CanvasGroup))

	var_19_3.alpha = 0

	local var_19_4 = arg_19_1.sequenceSpd or 1

	arg_19_0:TweenValueForcanvasGroup(var_19_3, 1, 0, var_19_4, var_19_0[2], arg_19_2)
	setAnchoredPosition(arg_19_0.dataTxt, Vector3(var_19_2[1], var_19_2[2], 0))

	return
end

function var_0_0.OnWillClear(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_0.color then
		arg_20_0.mainImg.color = arg_20_0.color
	end

	arg_20_0.color = nil

	if not arg_20_0.padding then
		if arg_20_0.spacing then
			arg_20_0:ResetPaddingAndSpacing(arg_20_0:GetAsideList(arg_20_1:GetAsideType(), arg_20_1).container, arg_20_0.padding, arg_20_0.spacing)
		end

		arg_20_0.padding = nil
		arg_20_0.spacing = nil

		if arg_20_0.paitingName and arg_20_0.rtPaint then
			retPaintingPrefab(arg_20_0.meshImagePaintingContainer, arg_20_0.paitingName)
		end

		arg_20_0.paitingName = nil
		arg_20_0.rtPaint = nil

		return
	end
end

function var_0_0.ResetPaddingAndSpacing(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_1:GetComponent(typeof(UnityEngine.UI.HorizontalOrVerticalLayoutGroup))

	if arg_21_2 then
		var_21_0.padding = arg_21_2
	end

	if arg_21_3 then
		var_21_0.spacing = arg_21_3
	end

	return
end

function var_0_0.OnEnd(arg_22_0)
	return
end

return var_0_0
