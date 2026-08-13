class = var_0_10000

local var_0_0 = "AtelierFormulaDetailYumiaView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.Atelier.base.AtelierFormulaDetailView"))

import = var_0_10001

local var_0_2 = var_0_10001("Mgr.Pool.PoolPlural")

function var_0_1.InitCustom(arg_1_0)
	AtelierFormulaOverlayYumiaView = var_1_10001
	arg_1_0.atelierFormulaOverlayView = var_1_10001.New(arg_1_0.layerFormulaDescriptionPanel, arg_1_0._parentClass)

	local var_1_0 = arg_1_0._tf

	arg_1_0.compositePanel = var_1.Find(var_1_0, "Overlay/compositePanel")

	local var_1_1 = arg_1_0._tf

	arg_1_0.tipsText = var_1.Find(var_1_1, "tips/Text")
	setText = var_1

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_3.Find(var_1_2, "Overlay/compositePanel/backBtn/Text")

	i18n = var_4

	var_1(var_1_3, var_4("yumia_atelier_tip9"))

	setText = var_1

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_3.Find(var_1_4, "Overlay/compositePanel/CompositeBtn/Text")

	i18n = var_4

	var_1(var_1_5, var_4("yumia_atelier_tip18"))

	setText = var_1

	local var_1_6 = arg_1_0._tf
	local var_1_7 = var_3.Find(var_1_6, "Overlay/compositePanel/autoBtn/Text")

	i18n = var_4

	var_1(var_1_7, var_4("yumia_atelier_tip23"))

	local var_1_8 = {}
	local var_1_9 = arg_1_0._tf

	var_1_8[1] = var_2.Find(var_1_9, "ScrollView/Content/lineGo1")

	local var_1_10 = arg_1_0._tf

	var_1_8[2] = var_2.Find(var_1_10, "ScrollView/Content/lineGo2")

	local var_1_11 = arg_1_0._tf

	var_1_8[3] = var_2.Find(var_1_11, "ScrollView/Content/lineGo3")
	arg_1_0.lineGoList = var_1_8
	SetComponentEnabled = var_1_8

	local var_1_12 = arg_1_0._parentClass.scrollView

	typeof = var_1_11
	ScrollRect = var_6

	var_1_8(var_1_12, var_1_11(var_6), false)

	return
end

function var_0_1.didEnter(arg_2_0)
	local var_2_0 = arg_2_0.atelierFormulaOverlayView

	var_1.didEnter(var_2_0)

	onButton = var_1

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_4.Find(var_2_2, "Overlay/compositePanel/CompositeBtn")

	local function var_2_4()
		local var_3_0 = arg_2_0

		var_0.OnClickComposite(var_3_0)

		return
	end

	SFX_PANEL = var_2_2

	var_1(var_2_1, var_2_3, var_2_4, var_2_2)

	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_4.Find(var_2_6, "Overlay/compositePanel/backBtn")

	local function var_2_8()
		local var_4_0 = arg_2_0._parentClass

		var_0.OnClickFormulaBack(var_4_0)

		return
	end

	SFX_PANEL = var_2_6

	var_1(var_2_5, var_2_7, var_2_8, var_2_6)

	onButton = var_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_4.Find(var_2_10, "Overlay/compositePanel/autoBtn")

	local function var_2_12()
		local var_5_0 = arg_2_0

		var_0.OnClickAutoFill(var_5_0)

		return
	end

	SFX_PANEL = var_2_10

	var_1(var_2_9, var_2_11, var_2_12, var_2_10)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1)
	setActive = var_1_10002

	var_1_10002(arg_6_0._go, true)

	arg_6_0.unLockLayerIndex = 1

	if not arg_6_0.nodePools then
		local var_6_0 = {}

		var_1_10003 = var_0_2.New

		local var_6_1 = arg_6_0._tf

		var_6_0.core = var_1_10003(var_5.Find(var_6_1, "coreNode").gameObject, 100)
		var_1_10003 = var_0_2.New

		local var_6_2 = arg_6_0._tf

		var_6_0.material = var_1_10003(var_5.Find(var_6_2, "materialNode").gameObject, 100)
		arg_6_0.nodePools = var_6_0
		table = var_6_0

		var_6_0.Foreach(arg_6_0.nodePools, function(arg_7_0, arg_7_1)
			setActive = var_2_10002

			var_2_10002(arg_7_1.prefab, false)

			return
		end)
	end

	local var_6_3

	if not arg_6_0.pluralRoot then
		pg = var_6_3
		var_6_3 = var_6_3.PoolMgr.GetInstance().root
	end

	arg_6_0.pluralRoot = var_6_3

	local var_6_4

	if not arg_6_0.nodeList then
		var_6_4 = {}
	end

	arg_6_0.nodeList = var_6_4
	_ = var_6_4

	var_6_4.each(arg_6_0.nodeList, function(arg_8_0)
		local var_8_0 = arg_6_0.nodePools[arg_8_0.GoType]

		tf = var_2

		local var_8_1 = var_2(arg_8_0.GO)
		local var_8_2 = arg_6_0._parentClass.loader

		var_3.ClearRequest(var_8_2, var_8_1)

		local var_8_3 = var_8_0
		local var_8_4 = var_8_0.Enqueue

		go = var_6

		if not var_8_4(var_8_3, var_6(arg_8_0.GO)) then
			setParent = var_4
			go = var_6

			var_4(var_6(arg_8_0.GO), arg_6_0.pluralRoot)

			setActive = var_4
			go = var_6

			var_4(var_6(arg_8_0.GO), false)
		end

		return
	end)

	table = var_2

	var_2.clean(arg_6_0.nodeList)

	setAnchoredPosition = var_2

	local var_6_5 = arg_6_0.viewContent

	Vector2 = var_5

	var_2(var_6_5, var_5.zero)

	local var_6_6 = 0

	_ = var_1_10003

	var_1_10003.each(arg_6_1:GetCircleList(), function(arg_9_0)
		AtelierFormulaCircle = var_2_10001

		local var_9_0 = var_2_10001.New({
			configId = arg_9_0
		})
		local var_9_1
		local var_9_2 = var_9_0:GetNeighbors()[1] == 1 and "core" or "material"
		local var_9_3 = arg_6_0.nodePools[var_9_2]
		local var_9_4 = var_3.Dequeue(var_9_3)

		var_9_4.name = arg_9_0
		setActive = var_2_10004

		var_2_10004(var_9_4, true)

		setParent = var_2_10004
		tf = var_6

		var_2_10004(var_6(var_9_4), arg_6_0.viewContent)

		var_6_6 = var_6_6 + 1

		local var_9_5 = {
			Change = true,
			ID = var_6_6,
			Data = var_9_0,
			GO = var_9_4,
			GoType = var_9_2
		}

		table = var_5

		var_5.insert(arg_6_0.nodeList, var_9_5)

		if var_9_0:GetNeighbors()[1] ~= 1 then
			local var_9_6 = arg_6_0

			var_5.HideNodeLight(var_9_6, var_9_5)
		end

		setActive = var_5

		var_5(var_9_4:Find("select"), false)

		return
	end)
	arg_6_0:InitNodeLayer()
	arg_6_0:SetCirclePanel()
	arg_6_0:UpdateFormulaDetail()
	arg_6_0:InitLine(arg_6_1)

	local var_6_7 = arg_6_0.atelierFormulaOverlayView

	var_3.RefreshFormulaInfo(var_6_7, arg_6_1)
	arg_6_0:RefreshScrollViewPosition()

	return
end

function var_0_1.UpdateNodeView(arg_10_0, arg_10_1)
	tf = var_1_10002

	local var_10_0 = var_1_10002(arg_10_1.GO)
	local var_10_1 = arg_10_1.Data
	local var_10_2 = var_3.GetElementName(var_10_1)
	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_0.IsLockNode(var_10_3, arg_10_1)

	setActive = var_10_1

	var_10_1(arg_10_1.GO, not var_10_4)

	local var_10_5 = arg_10_1.Instance

	table = var_10_3

	local var_10_6

	if var_10_3.contains(arg_10_0.nodeLayer[1], arg_10_1.ID) then
		-- block empty
	else
		var_10_6 = var_3:GetType()
		AtelierFormulaCircle = var_9

		if var_10_6 == var_9.TYPE.NONE then
			arg_10_0:RefreshElement(arg_10_1)
			arg_10_0:HideCategory(arg_10_1)
		else
			AtelierFormulaCircle = var_9

			if var_10_6 == var_9.TYPE.ELEMENT then
				arg_10_0:RefreshElement(arg_10_1)
				arg_10_0:HideCategory(arg_10_1)
			else
				AtelierFormulaCircle = var_9

				if var_10_6 == var_9.TYPE.CATEGORY then
					arg_10_0:RefreshElement(arg_10_1)
					arg_10_0:RefreshCategory(arg_10_1)
				else
					AtelierFormulaCircle = var_9

					if var_10_6 == var_9.TYPE.ELEMENT_CATEGORY then
						arg_10_0:RefreshElement(arg_10_1)
						arg_10_0:RefreshCategory(arg_10_1)
					end
				end
			end
		end

		if var_10_5 == nil then
			arg_10_0:AddStarList(arg_10_1)
		end
	end

	onButton = var_10_6

	local var_10_7 = arg_10_0
	local var_10_8 = var_10_0

	local function var_10_9()
		if var_10_4 then
			return
		end

		local var_11_0 = arg_10_0._parentClass

		var_0.ShowMaterialSelectWindow(var_11_0, var_10_0, arg_10_1, arg_10_0.nodeList)

		return
	end

	SFX_PANEL = var_1_10013

	var_10_6(var_10_7, var_10_8, var_10_9, var_1_10013)

	return
end

function var_0_1.RefreshElement(arg_12_0, arg_12_1)
	tf = var_1_10002

	local var_12_0 = var_1_10002(arg_12_1.GO)
	local var_12_1 = arg_12_1.Data
	local var_12_2 = var_3.GetProp(var_12_1)

	GetImageSpriteFromAtlasAsync = var_1_10005

	local var_12_3 = "ui/ateliercommonyumiaui_atlas"
	local var_12_4 = "slot_"

	AtelierFormulaCircle = var_1_10009

	var_1_10005(var_12_3, var_12_4 .. var_1_10009.ELEMENT_NAME[var_12_2], var_12_0:Find("icon"))

	local var_12_5

	var_12_5, setImageColor = var_12_0:Find("light"), var_12_1

	local var_12_6 = var_3
	local var_12_7 = var_3.GetElementLightColor

	instance = var_12

	var_12_1(var_12_5, var_12_7(var_12_6, var_12))

	return
end

function var_0_1.RefreshCategory(arg_13_0, arg_13_1)
	tf = var_1_10002

	local var_13_0 = var_1_10002(arg_13_1.GO)
	local var_13_1 = arg_13_1.Data

	if var_3.GetCategory(var_13_1) ~= 0 then
		GetImageSpriteFromAtlasAsync = var_1_10005

		var_1_10005("ui/ateliercommonyumiaui_atlas", "category" .. var_4, var_13_0:Find("categoryBg/category"))
	end

	setActive = var_1_10005

	var_1_10005(var_13_0:Find("categoryBg"), true)

	return
end

function var_0_1.HideCategory(arg_14_0, arg_14_1)
	tf = var_1_10002

	local var_14_0 = var_1_10002(arg_14_1.GO)

	setActive = var_1_10003

	var_1_10003(var_14_0:Find("categoryBg"), false)

	return
end

function var_0_1.DisPlayUnlockEffect(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.unLockLayerIndex = arg_15_1

	arg_15_0:RefreshLine()

	ipairs = var_3

	for iter_15_0, iter_15_1 in var_3(arg_15_0.nodeLayer[arg_15_1]) do
		local var_15_0 = arg_15_0.nodeList[iter_15_1]

		arg_15_0:UpdateNodeView(var_15_0)
	end

	existCall = var_3

	var_3(arg_15_2)

	return
end

function var_0_1.FillNodeAndPlayAnim(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_0._parentClass

	var_5.LoadingOn(var_16_0)

	local var_16_1

	if not arg_16_1.ChangeInstance then
		tobool = var_16_1
		var_16_1 = var_16_1(arg_16_1.Instance)
		tobool = var_1_10006
		var_16_1 = var_16_1 ~= var_1_10006(arg_16_2)
	end

	arg_16_1.ChangeInstance = var_16_1
	arg_16_1.Instance = arg_16_2
	arg_16_1.Change = true

	local var_16_2 = {}
	local var_16_3 = {}

	seriesAsync = var_16_0

	var_16_0({
		function(arg_17_0)
			table = var_2_10001

			var_2_10001.ParallelIpairsAsync({
				"ui/laisha_ui_wupinzhiru",
				"ui/laisha_ui_baoshi"
			}, function(arg_18_0, arg_18_1, arg_18_2)
				local var_18_0 = var_16_2
				local var_18_1 = arg_16_0._parentClass.loader

				var_18_0[arg_18_0] = var_4.GetPrefab(var_18_1, arg_18_1, "", function(arg_19_0)
					setParent = var_4_10001

					local var_19_0 = arg_19_0

					tf = var_4_10004

					var_4_10001(var_19_0, var_4_10004(arg_16_1.GO))

					setAnchoredPosition = var_4_10001

					local var_19_1 = arg_19_0

					Vector2 = var_4

					var_4_10001(var_19_1, var_4.zero)

					local var_19_2 = var_16_3

					var_19_2[arg_18_0] = arg_19_0
					setActive = var_19_2

					var_19_2(arg_19_0, false)
					arg_18_2()

					return
				end)

				return
			end, arg_17_0)

			return
		end,
		function(arg_20_0)
			setActive = var_2_10001

			var_2_10001(var_16_3[1], true)

			local var_20_0 = arg_16_0

			var_1.PlayStarAnimation(var_20_0, arg_16_1)

			local var_20_1 = arg_16_0._parentClass
			local var_20_2 = var_1.managedTween

			LeanTween = var_4

			var_20_2(var_20_1, var_4.delayedCall, function()
				if not arg_16_4 then
					ipairs = var_0

					for iter_21_0, iter_21_1 in var_0(arg_16_0.nodeLayer[arg_16_0.unLockLayerIndex]) do
						local var_21_0 = arg_16_0

						var_5.UpdateNodeView(var_21_0, arg_16_0.nodeList[iter_21_1])
					end
				else
					local var_21_1 = arg_16_0

					var_0.UpdateNodeView(var_21_1, arg_16_1)
				end

				local var_21_2 = arg_16_0._parentClass

				var_0.PlaySoundEffect(var_21_2, arg_16_0._parentClass.soundStr.formulaDetailFill)
				arg_20_0()

				return
			end, 0.2, nil)

			return
		end,
		function(arg_22_0)
			setActive = var_2_10001

			var_2_10001(var_16_3[2], true)

			local var_22_0 = arg_16_0._parentClass
			local var_22_1 = var_1.managedTween

			LeanTween = var_4

			var_22_1(var_22_0, var_4.delayedCall, function()
				arg_22_0()

				return
			end, 0.5, nil)

			return
		end,
		function(arg_24_0)
			local var_24_0 = arg_16_0._parentClass.loader

			var_1.ClearRequest(var_24_0, var_16_2[1])

			local var_24_1 = arg_16_0._parentClass.loader

			var_1.ClearRequest(var_24_1, var_16_2[2])

			local var_24_2 = arg_16_0._parentClass

			var_1.LoadingOff(var_24_2)

			local var_24_3 = arg_16_0

			var_1.RefreshBtn(var_24_3)

			existCall = var_1

			var_1(arg_16_3)

			return
		end
	})

	return
end

function var_0_1.InitLine(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1:GetShapeID()

	ipairs = var_1_10003

	for iter_25_0, iter_25_1 in var_1_10003(arg_25_0.lineGoList) do
		setActive = var_1_10008

		var_1_10008(iter_25_1, iter_25_0 == var_25_0)

		if iter_25_0 == var_25_0 then
			arg_25_0.lineGo = iter_25_1
		end
	end

	arg_25_0:RefreshLine()

	return
end

function var_0_1.RefreshLine(arg_26_0)
	for iter_26_0 = 0, arg_26_0.lineGo.childCount - 1 do
		setActive = var_1_10005

		local var_26_0 = arg_26_0.lineGo

		var_1_10005(var_7.GetChild(var_26_0, iter_26_0), iter_26_0 < arg_26_0.unLockLayerIndex - 1)
	end

	return
end

function var_0_1.RefreshBtn(arg_27_0)
	return
end

function var_0_1.RefreshScrollViewPosition(arg_28_0)
	if arg_28_0.nodeList[1].Instance == nil then
		setAnchoredPosition = var_1

		local var_28_0 = arg_28_0._parentClass.scrollView

		Vector2 = var_1_10004

		var_1(var_28_0, var_1_10004.zero)

		setAnchoredPosition = var_1

		local var_28_1 = arg_28_0.viewContent

		Vector2 = var_1_10004

		var_1(var_28_1, var_1_10004.zero)

		local var_28_2 = arg_28_0.atelierFormulaOverlayView

		var_1.Show(var_28_2, true)

		local var_28_3 = arg_28_0._parentClass

		var_1.ShowTopBar(var_28_3, false)
		arg_28_0:HideCompositePanel()

		setText = var_1

		local var_28_4 = arg_28_0.tipsText

		i18n = var_1_10004

		var_1(var_28_4, var_1_10004("yumia_atelier_tip7"))
	else
		arg_28_0:HideDescriptionView()
		arg_28_0:ShowCompositePanel()

		setText = var_1

		local var_28_5 = arg_28_0.tipsText

		i18n = var_1_10004

		var_1(var_28_5, var_1_10004("yumia_atelier_tip17"))
	end

	return
end

function var_0_1.HideDescriptionView(arg_29_0)
	local var_29_0 = arg_29_0.atelierFormulaOverlayView

	var_1.Show(var_29_0, false)

	local var_29_1 = arg_29_0._parentClass

	var_1.ShowTopBar(var_29_1, true)

	setAnchoredPosition = var_1

	local var_29_2 = arg_29_0._parentClass.scrollView

	Vector2 = var_4

	var_1(var_29_2, var_4(-397, 0))

	return
end

function var_0_1.ShowCompositePanel(arg_30_0)
	setActive = var_1_10001

	var_1_10001(arg_30_0.compositePanel, true)

	return
end

function var_0_1.HideCompositePanel(arg_31_0)
	setActive = var_1_10001

	var_1_10001(arg_31_0.compositePanel, false)

	return
end

function var_0_1.AddStarList(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1.Data
	local var_32_1 = var_2.GetStarList(var_32_0)
	local var_32_2 = arg_32_1.GO
	local var_32_3 = var_4.Find(var_32_2, "starContant")

	arg_32_0:HideStarList(arg_32_1)

	type = var_5

	if var_5(var_32_1) ~= "table" then
		return
	end

	ipairs = var_5

	for iter_32_0, iter_32_1 in var_5(var_2:GetStarList()) do
		local var_32_4

		if not (iter_32_0 <= var_32_3.childCount) or not var_32_3:GetChild(iter_32_0 - 1) then
			cloneTplTo = var_32_4
			var_32_4 = var_32_4(var_32_3:GetChild(0), var_32_3)
		end

		setActive = var_1_10011

		var_1_10011(var_32_4, true)

		setAnchoredPosition = var_1_10011

		local var_32_5 = var_32_4

		Vector2 = var_14
		unpack = var_1_10016

		var_1_10011(var_32_5, var_14(var_1_10016(iter_32_1)))
	end

	return
end

function var_0_1.PlayStarAnimation(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1.Data
	local var_33_1 = var_2.GetStarList(var_33_0)

	arg_33_0:ShowNodeLight(arg_33_1)

	type = var_4

	if var_4(var_33_1) ~= "table" then
		return
	end

	local var_33_2 = arg_33_1.GO
	local var_33_3 = var_4.Find(var_33_2, "starContant")

	for iter_33_0 = 0, var_33_3.childCount - 1 do
		local var_33_4 = arg_33_0._parentClass
		local var_33_5 = var_9.managedTween

		LeanTween = var_1_10012
		var_1_10012 = var_1_10012.moveLocal

		local var_33_6
		local var_33_7 = var_33_3:GetChild(iter_33_0).gameObject

		Vector3 = var_1_10015

		var_33_5(var_33_4, var_1_10012, var_33_6, var_33_7, var_1_10015.zero, 0.5)
	end

	local var_33_8 = arg_33_0._parentClass
	local var_33_9 = var_5.managedTween

	LeanTween = iter_33_0

	var_33_9(var_33_8, iter_33_0.delayedCall, function()
		local var_34_0 = arg_33_0

		var_0.HideStarList(var_34_0, arg_33_1)

		return
	end, 0.5, nil)

	return
end

function var_0_1.HideStarList(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1.GO
	local var_35_1 = var_2.Find(var_35_0, "starContant")

	for iter_35_0 = 0, var_35_1.childCount - 1 do
		setActive = var_1_10007

		var_1_10007(var_35_1:GetChild(iter_35_0), false)
	end

	return
end

function var_0_1.ShowNodeLight(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1.Data

	if var_2.GetNeighbors(var_36_0)[1] == 1 then
		return
	end

	setActive = var_2

	local var_36_1 = arg_36_1.GO

	var_2(var_4.Find(var_36_1, "light"), true)

	return
end

function var_0_1.HideNodeLight(arg_37_0, arg_37_1)
	setActive = var_1_10002

	local var_37_0 = arg_37_1.GO

	var_1_10002(var_4.Find(var_37_0, "light"), false)

	return
end

function var_0_1.InitStr(arg_38_0)
	local var_38_0 = {}

	AtelierFormulaCircle = var_1_10002
	var_38_0[var_1_10002.ELEMENT_TYPE.PYRO] = "laisha_ui_huo"
	AtelierFormulaCircle = var_2
	var_38_0[var_2.ELEMENT_TYPE.CRYO] = "laisha_ui_bing"
	AtelierFormulaCircle = var_2
	var_38_0[var_2.ELEMENT_TYPE.ELECTRO] = "laisha_ui_lei"
	AtelierFormulaCircle = var_2
	var_38_0[var_2.ELEMENT_TYPE.ANEMO] = "laisha_ui_feng"
	AtelierFormulaCircle = var_2
	var_38_0[var_2.ELEMENT_TYPE.SAIREN] = "laisha_ui_sairen"
	arg_38_0.ringEffect = var_38_0
	arg_38_0.deployEffect = "laisha_ui_wupinshanguang"
	arg_38_0.unlockEffect = "laisha_ui_jiesuo"

	local var_38_1 = {}

	AtelierFormulaCircle = var_2
	var_38_1[1] = var_2.TYPE.ELEMENT_CATEGORY
	AtelierFormulaCircle = var_2
	var_38_1[2] = var_2.TYPE.CATEGORY
	AtelierFormulaCircle = var_2
	var_38_1[3] = var_2.TYPE.ELEMENT
	AtelierFormulaCircle = var_2
	var_38_1[4] = var_2.TYPE.NONE
	arg_38_0.circleTypeList = var_38_1

	return
end

function var_0_1.InitNodeLayer(arg_39_0)
	arg_39_0.nodeLayer = {
		{}
	}
	ipairs = var_1

	for iter_39_0, iter_39_1 in var_1(arg_39_0.nodeList) do
		local var_39_0 = iter_39_1.Data
		local var_39_1 = var_6.GetNeighbors(var_39_0)
		local var_39_2 = arg_39_0.nodeLayer
		local var_39_3 = var_39_1[1]
		local var_39_4

		if not arg_39_0.nodeLayer[var_39_1[1]] then
			var_39_4 = {}
		end

		var_39_2[var_39_3] = var_39_4
		table = var_39_2

		var_39_2.insert(arg_39_0.nodeLayer[var_39_1[1]], iter_39_0)
	end

	return
end

function var_0_1.SetCirclePanel(arg_40_0)
	local var_40_0 = 280

	arg_40_0:SetCirclePosition()

	setSizeDelta = var_2

	local var_40_1 = arg_40_0.viewContent
	local var_40_2 = arg_40_0.viewMax

	Vector2 = var_1_10006

	var_2(var_40_1, (var_40_2 + var_1_10006.New(var_40_0, var_40_0)) * 2)

	return
end

function var_0_1.SetCirclePosition(arg_41_0)
	local var_41_0 = 0
	local var_41_1 = 0

	_ = var_1_10003

	var_1_10003.each(arg_41_0.nodeList, function(arg_42_0)
		local var_42_0 = arg_42_0.Data
		local var_42_1 = var_1.GetNeighbors(var_42_0)

		Vector2 = var_2_10003

		local var_42_2 = var_2_10003(var_42_1[2], var_42_1[3])

		setAnchoredPosition = var_42_0

		var_42_0(arg_42_0.GO, var_42_2)

		math = var_42_0

		local var_42_3 = var_42_0.max
		local var_42_4 = var_41_0

		math = var_7
		var_41_0 = var_42_3(var_42_4, var_7.abs(var_42_1[2]))
		math = var_4

		local var_42_5 = var_4.max
		local var_42_6 = var_41_1

		math = var_7
		var_41_1 = var_42_5(var_42_6, var_7.abs(var_42_1[3]))

		return
	end)

	Vector2 = var_3
	arg_41_0.viewMax = var_3(var_41_0, var_41_1)

	return
end

return var_0_1
