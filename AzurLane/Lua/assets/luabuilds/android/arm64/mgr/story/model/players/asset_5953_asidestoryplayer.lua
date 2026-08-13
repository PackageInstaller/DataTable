class = var_0_10000

local var_0_0 = "AsideStoryPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".StoryPlayer"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	UIItemList = var_2

	local var_1_0 = var_2.New
	local var_1_1 = arg_1_0.asidePanel
	local var_1_2 = var_4.Find(var_1_1, "aside")
	local var_1_3 = arg_1_0.asidePanel

	arg_1_0.hrzList = var_1_0(var_1_2, var_5.Find(var_1_3, "aside/aside_txt_tpl"))
	UIItemList = var_2

	local var_1_4 = var_2.New
	local var_1_5 = arg_1_0.asidePanel
	local var_1_6 = var_4.Find(var_1_5, "aside_2")
	local var_1_7 = arg_1_0.asidePanel

	arg_1_0.vetList = var_1_4(var_1_6, var_5.Find(var_1_7, "aside_2/aside_txt_tpl_2"))
	UIItemList = var_2

	local var_1_8 = var_2.New
	local var_1_9 = arg_1_0.asidePanel
	local var_1_10 = var_4.Find(var_1_9, "aside_3")
	local var_1_11 = arg_1_0.asidePanel

	arg_1_0.leftBotomVetList = var_1_8(var_1_10, var_5.Find(var_1_11, "aside_3/aside_txt_tpl"))
	UIItemList = var_2

	local var_1_12 = var_2.New
	local var_1_13 = arg_1_0.asidePanel
	local var_1_14 = var_4.Find(var_1_13, "aside_4")
	local var_1_15 = arg_1_0.asidePanel

	arg_1_0.centerWithFrameVetList = var_1_12(var_1_14, var_5.Find(var_1_15, "aside_4/aside_txt_tpl"))
	UIItemList = var_2

	local var_1_16 = var_2.New
	local var_1_17 = arg_1_0.asidePanel
	local var_1_18 = var_4.Find(var_1_17, "aside_4_1")
	local var_1_19 = arg_1_0.asidePanel

	arg_1_0.centerWithFrameVetListMargin = var_1_16(var_1_18, var_5.Find(var_1_19, "aside_4_1/aside_txt_tpl"))

	local var_1_20 = arg_1_0.asidePanel

	arg_1_0.dataTxt = var_2.Find(var_1_20, "aside_sign_date")

	local var_1_21 = arg_1_0.asidePanel

	arg_1_0.meshImagePaintingContainer = var_2.Find(var_1_21, "actor_middle")

	return
end

function var_0_1.OnReset(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	setActive = var_1_10004

	var_1_10004(arg_2_0.asidePanel, true)

	setActive = var_1_10004

	var_1_10004(arg_2_0.curtain, true)

	setActive = var_1_10004

	var_1_10004(arg_2_0.hrzList.container, false)

	setActive = var_1_10004

	var_1_10004(arg_2_0.vetList.container, false)

	setActive = var_1_10004

	var_1_10004(arg_2_0.leftBotomVetList.container, false)

	setActive = var_1_10004

	var_1_10004(arg_2_0.centerWithFrameVetList.container, false)

	setActive = var_1_10004

	var_1_10004(arg_2_0.centerWithFrameVetListMargin.container, false)

	setActive = var_1_10004

	var_1_10004(arg_2_0.actorPanel, false)

	local var_2_0 = arg_2_0.curtainCg

	var_2_0.alpha = 1
	setText = var_2_0

	var_2_0(arg_2_0.dataTxt, "")
	arg_2_3()

	return
end

function var_0_1.OnInit(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1:ShouldHideBGAlpha() then
		arg_3_0.color = arg_3_0.mainImg.color

		local var_3_0 = arg_3_0.mainImg

		Color = var_1_10005
		var_3_0.color = var_1_10005.New(1, 1, 1, 0)
	end

	local var_3_1 = {
		function(arg_4_0)
			local var_4_0 = arg_3_0

			var_1.LoadPainting(var_4_0, arg_3_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_3_1
			local var_5_1 = var_1.GetShowMode(var_5_0)

			AsideStep = var_2_10002

			if var_5_1 == var_2_10002.SHOW_MODE_DEFAUT then
				local var_5_2 = arg_3_0

				var_1.PlayAside(var_5_2, arg_3_1, arg_5_0)
			else
				local var_5_3 = arg_3_0

				var_1.PlayBubbleAside(var_5_3, arg_3_1, arg_5_0)
			end

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_3_0

			var_1.PlayDateSign(var_6_0, arg_3_1, arg_6_0)

			return
		end
	}

	seriesAsync = var_5

	var_5(var_3_1, arg_3_3)

	return
end

function var_0_1.LoadPainting(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1:GetPainting() or var_3 == "" then
		arg_7_2()

		return
	end

	arg_7_0.paitingName = var_3
	setPaintingPrefabAsync = var_1_10004

	var_1_10004(arg_7_0.meshImagePaintingContainer, var_3, "duihua", function(arg_8_0)
		arg_7_0.rtPaint = arg_8_0

		if arg_7_0.paitingName == nil then
			retPaintingPrefab = var_1

			var_1(arg_7_0.rtPaint, var_0)

			return
		end

		arg_7_2()

		return
	end)

	return
end

function var_0_1.GetAsideList(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0

	AsideStep = var_1_10004

	if arg_9_1 == var_1_10004.ASIDE_TYPE_HRZ then
		var_9_0 = arg_9_0.hrzList
	else
		AsideStep = var_4

		if arg_9_1 == var_4.ASIDE_TYPE_VEC then
			var_9_0 = arg_9_0.vetList
		else
			AsideStep = var_4

			if arg_9_1 == var_4.ASIDE_TYPE_LEFTBOTTOMVEC then
				var_9_0 = arg_9_0.leftBotomVetList
			else
				AsideStep = var_4

				if arg_9_1 == var_4.ASIDE_TYPE_CENTERWITHFRAME then
					if arg_9_2:ShouldUpdateMargin() then
						var_9_0 = arg_9_0.centerWithFrameVetListMargin
					else
						var_9_0 = arg_9_0.centerWithFrameVetList
					end
				end
			end
		end
	end

	return var_9_0
end

function var_0_1.PlayAside(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}
	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_0.GetAsideList(var_10_1, arg_10_1:GetAsideType(), arg_10_1)

	arg_10_0:UpdateLayoutPaddingAndSpacing(arg_10_1, var_10_2.container)

	Mathf = var_5

	local var_10_3 = var_5.Sign(var_10_2.container.localScale.x)

	setActive = var_10_1

	var_10_1(var_10_2.container, true)

	local var_10_4 = arg_10_1:GetSequence()

	var_10_2:make(function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = var_10_4[arg_11_1 + 1]

			HXSet = var_4

			local var_11_1 = var_4.hxLan(var_11_0[1])
			local var_11_2 = var_11_0[2]

			setText = var_6

			var_6(arg_11_2, var_11_1)

			GetOrAddComponent = var_6

			local var_11_3 = arg_11_2

			typeof = var_9
			CanvasGroup = var_2_10011

			local var_11_4 = var_6(var_11_3, var_9(var_2_10011))

			var_11_4.alpha = 0
			table = var_7

			var_7.insert(var_10_0, function(arg_12_0)
				local var_12_0 = arg_10_0
				local var_12_1 = var_1.TweenValueForcanvasGroup
				local var_12_2 = var_11_4
				local var_12_3 = 0
				local var_12_4 = 1
				local var_12_5

				if not arg_10_1.sequenceSpd then
					var_12_5 = 1
				end

				var_12_1(var_12_0, var_12_2, var_12_3, var_12_4, var_12_5, var_11_2, arg_12_0)

				return
			end)

			local var_11_5 = var_10_3

			Mathf = var_11_3

			if var_11_5 ~= var_11_3.Sign(arg_11_2.localScale.x) then
				Vector3 = var_11_5
				arg_11_2.localScale = var_11_5(var_10_3 * arg_11_2.localScale.x, arg_11_2.localScale.y, 1)
			end
		end

		return
	end)
	var_10_2:align(#var_10_4)

	parallelAsync = var_7

	var_7(var_10_0, arg_10_2)

	return
end

function var_0_1.PlayBubbleAside(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:GetAsideList(arg_13_1:GetAsideType(), arg_13_1)

	arg_13_0:UpdateLayoutPaddingAndSpacing(arg_13_1, var_13_0.container)

	Mathf = var_4

	local var_13_1 = var_4.Sign(var_13_0.container.localScale.x)
	local var_13_2 = arg_13_1:GetSequence()

	setActive = var_6

	var_6(var_13_0.container, true)

	for iter_13_0 = var_13_0.container.childCount, 1, -1 do
		var_1_10012 = var_13_0.container

		if var_10.GetChild(var_1_10012, iter_13_0 - 1) ~= var_13_0.item then
			Object = var_11

			var_11.Destroy(var_10.gameObject)
		end
	end

	local var_13_3 = {}
	local var_13_4 = 0

	for iter_13_1 = 1, #var_13_2 do
		table = var_1_10012

		var_1_10012.insert(var_13_3, function(arg_14_0)
			cloneTplTo = var_2_10001

			local var_14_0 = var_2_10001(var_13_0.item, var_13_0.container, iter_13_1)

			setText = var_2_10002

			local var_14_1 = var_14_0

			HXSet = var_5

			var_2_10002(var_14_1, var_5.hxLan(var_13_2[iter_13_1][1]))

			GetOrAddComponent = var_2_10002

			local var_14_2 = var_14_0

			typeof = var_5
			Typewriter = var_7

			local var_14_3 = var_2_10002(var_14_2, var_5(var_7))

			function var_14_3.endFunc()
				arg_14_0()

				return
			end

			local var_14_4 = var_14_3
			local var_14_5 = var_14_3.setSpeed
			local var_14_6 = arg_13_1

			var_14_5(var_14_4, var_6.GetTypewriterSpeed(var_14_6))
			var_14_3:Play()

			return
		end)
	end

	seriesAsync = var_8

	var_8(var_13_3, arg_13_2)

	return
end

function var_0_1.UpdateLayoutPaddingAndSpacing(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1:ShouldUpdateSpacing()
	local var_16_1 = arg_16_1:ShouldUpdatePadding()
	local var_16_2 = arg_16_1:ShouldUpdateMargin()

	if (var_16_0 or var_16_1) and not var_16_2 then
		local var_16_3 = arg_16_2
		local var_16_4 = arg_16_2.GetComponent

		typeof = var_1_10009
		UnityEngine = var_1_10011

		local var_16_5 = var_16_4(var_16_3, var_1_10009(var_1_10011.UI.HorizontalOrVerticalLayoutGroup))

		if var_16_0 then
			var_16_5.spacing, arg_16_0.spacing = arg_16_1:GetSpacing(), var_16_5.spacing
		end

		if var_16_1 then
			local var_16_6, var_16_7, var_16_8

			var_16_6, var_16_7, var_16_8, var_1_10010 = arg_16_1:GetPadding()
			UnityEngine = var_11

			local var_16_9 = var_11.RectOffset.New()

			var_16_9.bottom = var_16_7
			var_16_9.left = var_16_8
			var_16_9.right = var_1_10010
			var_16_9.top = var_16_6
			arg_16_0.padding = var_16_5.padding
			var_16_5.padding = var_16_9
		end
	elseif var_16_2 then
		local var_16_10 = 0
		local var_16_11 = arg_16_2
		local var_16_12 = arg_16_2.GetComponent

		typeof = var_1_10010
		UnityEngine = var_1_10012

		local var_16_13 = var_16_12(var_16_11, var_1_10010(var_1_10012.UI.HorizontalOrVerticalLayoutGroup))

		if var_16_0 then
			var_16_10 = arg_16_1:GetSpacing()
		end

		var_16_13.spacing = var_16_10

		local var_16_14, var_16_15, var_16_16, var_16_17 = arg_16_1:GetMargin()

		rtf = var_12

		local var_16_18 = var_12(arg_16_2)

		Vector2 = var_1_10013
		var_16_18.offsetMin = var_1_10013(var_16_16, var_16_15)
		Vector2 = var_13
		var_16_18.offsetMax = var_13(-var_16_17, -var_16_14)
		eachChild = var_13

		var_13(arg_16_2, function(arg_17_0)
			GetOrAddComponent = var_2_10001

			local var_17_0 = arg_17_0

			typeof = var_2_10004
			LayoutElement = var_2_10006
			var_2_10001(var_17_0, var_2_10004(var_2_10006)).preferredWidth = var_16_18.rect.width - 50

			return
		end)
	end

	arg_16_0:UpdateRectAlhpa(arg_16_1, arg_16_2)

	return
end

function var_0_1.UpdateRectAlhpa(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2
	local var_18_1 = arg_18_2.GetComponent

	typeof = var_1_10006
	Image = var_1_10008

	if not var_18_1(var_18_0, var_1_10006(var_1_10008)) then
		return
	end

	local var_18_2 = arg_18_1:GetRectAlpha()

	Color = var_18_0
	var_3.color = var_18_0.New(1, 1, 1, var_18_2)

	return
end

function var_0_1.PlayDateSign(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_1:GetDateSign() then
		arg_19_2()

		return
	end

	HXSet = var_1_10004

	local var_19_0 = var_1_10004.hxLan(var_3[1])
	local var_19_1 = var_3[2]
	local var_19_2

	if not var_3[3] then
		var_19_2 = {}
	end

	setText = var_1_10007

	var_1_10007(arg_19_0.dataTxt, var_19_0)

	GetOrAddComponent = var_1_10007

	local var_19_3 = arg_19_0.dataTxt

	typeof = var_10
	CanvasGroup = var_1_10012

	local var_19_4 = var_1_10007(var_19_3, var_10(var_1_10012))

	var_19_4.alpha = 0

	local var_19_5 = arg_19_0
	local var_19_6 = arg_19_0.TweenValueForcanvasGroup
	local var_19_7 = var_19_4
	local var_19_8 = 1
	local var_19_9 = 0
	local var_19_10

	if not arg_19_1.sequenceSpd then
		var_19_10 = 1
	end

	var_19_6(var_19_5, var_19_7, var_19_8, var_19_9, var_19_10, var_19_1, arg_19_2)

	setAnchoredPosition = var_19_6

	local var_19_11 = arg_19_0.dataTxt

	Vector3 = var_19_7

	var_19_6(var_19_11, var_19_7(var_19_2[1], var_19_2[2], 0))

	return
end

function var_0_1.OnWillClear(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_0.color then
		arg_20_0.mainImg.color = arg_20_0.color
	end

	arg_20_0.color = nil

	if arg_20_0.padding or arg_20_0.spacing then
		local var_20_0 = arg_20_0:GetAsideList(arg_20_1:GetAsideType(), arg_20_1)

		arg_20_0:ResetPaddingAndSpacing(var_20_0.container, arg_20_0.padding, arg_20_0.spacing)
	end

	arg_20_0.padding = nil
	arg_20_0.spacing = nil

	if arg_20_0.paitingName and arg_20_0.rtPaint then
		retPaintingPrefab = var_4

		var_4(arg_20_0.meshImagePaintingContainer, arg_20_0.paitingName)
	end

	arg_20_0.paitingName = nil
	arg_20_0.rtPaint = nil

	return
end

function var_0_1.ResetPaddingAndSpacing(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_1
	local var_21_1 = arg_21_1.GetComponent

	typeof = var_1_10007
	UnityEngine = var_1_10009

	local var_21_2 = var_21_1(var_21_0, var_1_10007(var_1_10009.UI.HorizontalOrVerticalLayoutGroup))

	if arg_21_2 then
		var_21_2.padding = arg_21_2
	end

	if arg_21_3 then
		var_21_2.spacing = arg_21_3
	end

	return
end

function var_0_1.OnEnd(arg_22_0)
	return
end

return var_0_1
