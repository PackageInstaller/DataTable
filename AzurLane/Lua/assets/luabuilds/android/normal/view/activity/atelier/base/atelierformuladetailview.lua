class = var_0_10000

local var_0_0 = "AtelierFormulaDetailView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

import = var_0_0

local var_0_2 = var_0_0("Mgr.Pool.PoolPlural")

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0._tf = arg_1_1
	arg_1_0._parentClass = arg_1_2
	arg_1_0.bundleName = arg_1_2.bundleName
	arg_1_0.commonBundleName = arg_1_2.commonBundleName

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()
	arg_1_0:InitStr()

	local var_1_0 = arg_1_0._tf

	arg_1_0.layerFormulaDescriptionPanel = var_3.Find(var_1_0, "Overlay/Description")

	arg_1_0:InitCustom()

	return
end

function var_0_1.InitCustom(arg_2_0)
	AtelierFormulaOverlayView = var_1_10001
	arg_2_0.atelierFormulaOverlayView = var_1_10001.New(arg_2_0.layerFormulaDescriptionPanel, arg_2_0._parentClass)

	return
end

function var_0_1.Init(arg_3_0)
	local var_3_0 = arg_3_0._parentClass.scrollView

	arg_3_0.viewContent = var_1.Find(var_3_0, "Content")
	setActive = var_1

	var_1(arg_3_0._go, false)

	return
end

function var_0_1.SetContextData(arg_4_0, arg_4_1)
	arg_4_0.contextData = arg_4_1

	local var_4_0 = arg_4_0.atelierFormulaOverlayView

	var_2.SetContextData(var_4_0, arg_4_1)

	return
end

function var_0_1.SetActivity(arg_5_0, arg_5_1)
	arg_5_0.activity = arg_5_1

	local var_5_0 = arg_5_0.atelierFormulaOverlayView

	var_2.SetActivity(var_5_0, arg_5_1)

	return
end

function var_0_1.didEnter(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_3.Find(var_6_1, "Composite")

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0.OnClickComposite(var_7_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_6_0, var_6_2, var_6_3, var_5)

	onButton = var_1_10001

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0._tf
	local var_6_6 = var_3.Find(var_6_5, "AutoFill")

	local function var_6_7()
		local var_8_0 = arg_6_0

		var_0.OnClickAutoFill(var_8_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_6_4, var_6_6, var_6_7, var_5)

	local var_6_8 = arg_6_0.atelierFormulaOverlayView

	var_1.didEnter(var_6_8)

	return
end

function var_0_1.Show(arg_9_0, arg_9_1)
	setActive = var_1_10002

	var_1_10002(arg_9_0._go, true)

	local var_9_0 = arg_9_0.atelierFormulaOverlayView

	var_2.RefreshFormulaInfo(var_9_0, arg_9_1)

	arg_9_0.unLockLayerIndex = 1

	if not arg_9_0.nodePools then
		local var_9_1 = {}
		local var_9_2 = var_0_2.New
		local var_9_3 = arg_9_0._tf

		var_9_1.circle = var_9_2(var_4.Find(var_9_3, "CircleNode").gameObject, 100)

		local var_9_4 = var_0_2.New
		local var_9_5 = arg_9_0._tf

		var_9_1.hexagon = var_9_4(var_4.Find(var_9_5, "HexagonNode").gameObject, 100)

		local var_9_6 = var_0_2.New
		local var_9_7 = arg_9_0._tf

		var_9_1.anyHexagon = var_9_6(var_4.Find(var_9_7, "AnyHexagonNode").gameObject, 100)

		local var_9_8 = var_0_2.New
		local var_9_9 = arg_9_0._tf

		var_9_1.doubleHexagon = var_9_8(var_4.Find(var_9_9, "DoubleHexagonNode").gameObject, 100)
		arg_9_0.nodePools = var_9_1
		table = var_9_1

		var_9_1.Foreach(arg_9_0.nodePools, function(arg_10_0, arg_10_1)
			setActive = var_2_10002

			var_2_10002(arg_10_1.prefab, false)

			return
		end)
	end

	local var_9_10

	if not arg_9_0.pluralRoot then
		pg = var_9_10
		var_9_10 = var_9_10.PoolMgr.GetInstance().root
	end

	arg_9_0.pluralRoot = var_9_10

	local var_9_11

	if not arg_9_0.nodeList then
		var_9_11 = {}
	end

	arg_9_0.nodeList = var_9_11
	_ = var_9_11

	var_9_11.each(arg_9_0.nodeList, function(arg_11_0)
		local var_11_0 = arg_9_0.nodePools
		local var_11_1 = arg_9_0.poolNames
		local var_11_2 = arg_11_0.Data
		local var_11_3 = var_11_0[var_11_1[var_3.GetType(var_11_2)]]

		tf = var_2

		local var_11_4 = var_2(arg_11_0.GO)

		SetComponentEnabled = var_3

		local var_11_5 = var_11_4
		local var_11_6 = var_11_4.Find(var_11_5, "Item")

		typeof = var_11_5
		Image = var_6

		var_3(var_11_6, var_11_5(var_6), false)

		local var_11_7 = arg_9_0._parentClass.loader

		var_3.ClearRequest(var_11_7, var_11_4:Find("Ring"))

		local var_11_8 = arg_9_0

		var_3.CleanNodeLinks(var_11_8, arg_11_0)

		local var_11_9 = arg_9_0._parentClass.loader

		var_3.ClearRequest(var_11_9, var_11_4)

		local var_11_10 = var_11_3
		local var_11_11 = var_11_3.Enqueue

		go = var_5

		if not var_11_11(var_11_10, var_5(arg_11_0.GO)) then
			setParent = var_11_10
			go = var_5

			var_11_10(var_5(arg_11_0.GO), arg_9_0.pluralRoot)

			setActive = var_11_10
			go = var_5

			var_11_10(var_5(arg_11_0.GO), false)
		end

		return
	end)

	table = var_2

	var_2.clean(arg_9_0.nodeList)

	setAnchoredPosition = var_2

	local var_9_12 = arg_9_0.viewContent

	Vector2 = var_4

	var_2(var_9_12, var_4.zero)

	local var_9_13 = 0

	_ = var_9_12

	var_9_12.each(arg_9_1:GetCircleList(), function(arg_12_0)
		AtelierFormulaCircle = var_2_10001

		local var_12_0 = var_2_10001.New({
			configId = arg_12_0
		})
		local var_12_1 = arg_9_0.nodePools[arg_9_0.poolNames[var_12_0:GetType()]]
		local var_12_2 = var_2.Dequeue(var_12_1)

		var_12_2.name = arg_12_0
		setActive = var_12_1

		var_12_1(var_12_2, true)

		setParent = var_12_1
		tf = var_4

		var_12_1(var_4(var_12_2), arg_9_0.viewContent)

		var_9_13 = var_9_13 + 1

		local var_12_3 = {
			Change = true,
			ID = var_9_13,
			Data = var_12_0,
			GO = var_12_2
		}

		table = var_4

		var_4.insert(arg_9_0.nodeList, var_12_3)

		return
	end)
	arg_9_0:InitNodeLayer()
	arg_9_0:SetCirclePanel()
	arg_9_0:UpdateFormulaDetail()

	return
end

function var_0_1.OnClickComposite(arg_13_0)
	_ = var_1_10001

	if not var_1_10001.all(arg_13_0.nodeList, function(arg_14_0)
		return arg_14_0.Instance
	end) then
		local var_13_0 = arg_13_0._parentClass

		var_2.ShowMaterialsPreview(var_13_0)

		return
	end

	local var_13_1 = arg_13_0.activity
	local var_13_2 = var_2.GetFormulas(var_13_1)[arg_13_0.contextData.formulaId]

	if not var_2.IsAvaliable(var_13_2) then
		pg = var_3

		local var_13_3 = var_3.TipsMgr.GetInstance()
		local var_13_4 = var_3.ShowTips

		i18n = var_1_10005

		var_13_4(var_13_3, var_1_10005("ryza_tip_composite_invalid"))

		return
	end

	local var_13_5 = arg_13_0._parentClass

	var_3.ShowCompositeConfirmWindow(var_13_5, arg_13_0.nodeList)

	return
end

function var_0_1.OnClickAutoFill(arg_15_0)
	arg_15_0.temps = {}

	local var_15_0 = {}

	_ = var_1_10002

	var_1_10002.each(arg_15_0.nodeList, function(arg_16_0)
		if arg_16_0.Instance then
			local var_16_0 = arg_15_0

			var_2_10002.UseMat(var_16_0, var_1)
		else
			table = var_2_10002

			var_2_10002.insert(var_15_0, arg_16_0)
		end

		return
	end)

	if #var_15_0 <= 0 then
		return
	end

	arg_15_0:AutoFillAllNode(var_15_0)

	return
end

function var_0_1.UseMat(arg_17_0, arg_17_1)
	local var_17_1

	if not arg_17_0.temps[arg_17_1:GetConfigID()] then
		Clone = var_17_1

		local var_17_0 = arg_17_0.activity

		var_17_1 = var_17_1(var_3.GetItems(var_17_0)[arg_17_1:GetConfigID()])
	end

	var_17_1.count = var_17_1.count - 1
	arg_17_0.temps[arg_17_1:GetConfigID()] = var_17_1

	return
end

function var_0_1.FillNode(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = {}

	table = var_1_10004

	var_1_10004.insert(var_18_0, function(arg_19_0)
		local var_19_0 = arg_18_0
		local var_19_1 = var_1.FillNodeAndPlayAnim
		local var_19_2 = arg_18_1

		AtelierMaterial = var_2_10004

		local var_19_3 = var_2_10004.New
		local var_19_4 = {
			count = 1
		}
		local var_19_5 = arg_18_2

		var_19_4.configId = var_6.GetConfigID(var_19_5)

		var_19_1(var_19_0, var_19_2, var_19_3(var_19_4), arg_19_0, true)

		return
	end)

	local var_18_1 = arg_18_0.unLockLayerIndex

	_ = var_5

	local var_18_2 = var_5.select(arg_18_0.nodeLayer[var_18_1], function(arg_20_0)
		return arg_18_0.nodeList[arg_20_0].Instance == nil
	end)

	if var_18_1 < #arg_18_0.nodeLayer and #var_18_2 == 1 and var_18_2[1] == arg_18_1.ID then
		table = var_6

		var_6.insert(var_18_0, function(arg_21_0)
			local var_21_0 = arg_18_0

			var_1.DisPlayUnlockEffect(var_21_0, var_18_1 + 1, arg_21_0)

			return
		end)
	end

	table = var_6

	var_6.insert(var_18_0, function(arg_22_0)
		local var_22_0 = arg_18_0

		var_1.UpdateFormulaDetail(var_22_0)
		arg_22_0()

		return
	end)

	seriesAsync = var_6

	var_6(var_18_0)

	return
end

function var_0_1.AutoFillAllNode(arg_23_0, arg_23_1)
	local var_23_0 = {}
	local var_23_1 = false

	ipairs = var_1_10004

	for iter_23_0, iter_23_1 in var_1_10004(arg_23_0.nodeLayer) do
		local var_23_2 = {}

		ipairs = var_1_10010

		for iter_23_2, iter_23_3 in var_1_10010(iter_23_1) do
			if arg_23_0.nodeList[iter_23_3] and var_15.Instance ~= nil then
				-- block empty
			else
				table = iter_23_10

				iter_23_10.insert(var_23_2, var_15)
			end
		end

		var_1_10010 = #var_23_2

		if 0 < var_1_10010 then
			var_1_10010 = false

			local var_23_10

			if iter_23_0 == 1 then
				ipairs = var_23_10

				for iter_23_4, iter_23_5 in var_23_10(var_23_2) do
					var_1_10018 = iter_23_5.Data

					if iter_23_10.GetLimitItemID(var_1_10018) ~= 0 then
						if not arg_23_0.temps[var_17] then
							local var_23_3 = arg_23_0.activity

							var_1_10018 = var_1_10018.GetItems(var_23_3)[var_17]
						end

						if var_1_10018 and var_1_10018.count > 0 then
							arg_23_0:UseMat(var_1_10018)

							table = var_19

							var_19.insert(var_23_0, function(arg_24_0)
								local var_24_0 = arg_23_0
								local var_24_1 = var_1.FillNodeAndPlayAnim
								local var_24_2 = iter_23_5

								AtelierMaterial = var_2_10004

								var_24_1(var_24_0, var_24_2, var_2_10004.New({
									count = 1,
									configId = var_0
								}), arg_24_0, true)

								return
							end)
						else
							var_1_10010 = true
						end
					else
						local var_23_4 = arg_23_0.activity

						var_1_10018 = var_1_10018.GetFormulas(var_23_4)[arg_23_0.contextData.formulaId]
						ipairs = var_19

						for iter_23_6, iter_23_7 in var_19(arg_23_0.circleTypeList) do
							local var_23_5 = iter_23_10

							if iter_23_10.GetType(var_23_5) == iter_23_7 then
								local var_23_6 = false

								ipairs = var_23_5
								pg = var_1_10026

								for iter_23_8, iter_23_9 in var_23_5(var_1_10026.activity_ryza_item.all) do
									local var_23_8

									if not arg_23_0.temps[iter_23_9] then
										local var_23_7 = arg_23_0.activity

										var_23_8 = var_30.GetItems(var_23_7)[iter_23_9]
									end

									if var_23_8 and var_23_8.count > 0 and var_23_8:IsNormal() and iter_23_10:CanUseMaterial(var_23_8, var_1_10018, arg_23_0.contextData.versionIndex) then
										arg_23_0:UseMat(var_23_8)

										table = var_31

										var_31.insert(var_23_0, function(arg_25_0)
											local var_25_0 = arg_23_0
											local var_25_1 = var_1.FillNodeAndPlayAnim
											local var_25_2 = iter_23_5

											AtelierMaterial = var_2_10004

											local var_25_3 = var_2_10004.New
											local var_25_4 = {
												count = 1
											}
											local var_25_5 = var_23_8

											var_25_4.configId = var_6.GetConfigID(var_25_5)

											var_25_1(var_25_0, var_25_2, var_25_3(var_25_4), arg_25_0, true)

											return
										end)

										var_23_6 = true

										break
									end
								end

								if not var_23_6 then
									var_1_10010 = true
								end
							end
						end
					end
				end
			else
				table = var_23_10

				var_23_10.insert(var_23_0, function(arg_26_0)
					local var_26_0 = arg_23_0._parentClass

					var_1.PlaySoundEffect(var_26_0, arg_23_0._parentClass.soundStr.formulaDetail)
					arg_26_0()

					return
				end)

				local var_23_9 = arg_23_0.activity

				var_23_10 = var_23_10.GetFormulas(var_23_9)[arg_23_0.contextData.formulaId]

				local var_23_11 = {}

				ipairs = var_13

				for iter_23_10, iter_23_11 in var_13(arg_23_0.circleTypeList) do
					_ = var_1_10018

					var_1_10018.each(var_23_2, function(arg_27_0)
						local var_27_0 = arg_27_0.Data

						if var_1.GetType(var_27_0) == iter_23_11 then
							local var_27_1 = false

							ipairs = var_3
							pg = var_2_10004

							for iter_27_0, iter_27_1 in var_3(var_2_10004.activity_ryza_item.all) do
								local var_27_3

								if not arg_23_0.temps[iter_27_1] then
									local var_27_2 = arg_23_0.activity

									var_27_3 = var_8.GetItems(var_27_2)[iter_27_1]
								end

								if var_27_3 and var_27_3.count > 0 and var_27_3:IsNormal() and var_1:CanUseMaterial(var_27_3, var_23_10, arg_23_0.contextData.versionIndex) then
									local var_27_4 = arg_23_0

									var_9.UseMat(var_27_4, var_27_3)

									table = var_9

									var_9.insert(var_23_11, function()
										local var_28_0 = arg_23_0
										local var_28_1 = var_0.FillNodeAndPlayAnim
										local var_28_2 = arg_27_0

										AtelierMaterial = var_3_10003

										local var_28_3 = var_3_10003.New
										local var_28_4 = {
											count = 1
										}
										local var_28_5 = var_27_3

										var_28_4.configId = var_5.GetConfigID(var_28_5)

										var_28_1(var_28_0, var_28_2, var_28_3(var_28_4), true)

										return
									end)

									var_27_1 = true

									break
								end
							end

							if not var_27_1 then
								var_1_10010 = true
							end
						end

						return
					end)
				end

				if #var_23_11 > 0 then
					table = var_13

					var_13.insert(var_23_0, function(arg_29_0)
						ipairs = var_2_10001

						for iter_29_0, iter_29_1 in var_2_10001(var_23_11) do
							iter_29_1()
						end

						local var_29_0 = arg_23_0._parentClass
						local var_29_1 = var_1.managedTween

						LeanTween = var_3

						var_29_1(var_29_0, var_3.delayedCall, function()
							arg_29_0()

							return
						end, 0.7, nil)

						return
					end)
				end
			end

			if var_1_10010 then
				var_23_1 = true
				table = var_23_10

				var_23_10.insert(var_23_0, function(arg_31_0)
					pg = var_2_10001

					local var_31_0 = var_2_10001.TipsMgr.GetInstance()
					local var_31_1 = var_1.ShowTips

					i18n = var_2_10003

					var_31_1(var_31_0, var_2_10003("ryza_material_not_enough"))
					arg_31_0()

					return
				end)

				break
			end

			if iter_23_0 < #arg_23_0.nodeLayer then
				table = var_11

				var_11.insert(var_23_0, function(arg_32_0)
					local var_32_0 = arg_23_0

					var_1.DisPlayUnlockEffect(var_32_0, iter_23_0 + 1, arg_32_0)

					return
				end)
			end
		end
	end

	if #var_23_0 > 0 and (#var_23_0 ~= 1 or not var_23_1) then
		table = var_4

		var_4.insert(var_23_0, 1, function(arg_33_0)
			local var_33_0 = arg_23_0._parentClass

			var_1.DispalyChat(var_33_0, arg_23_0._parentClass.chatText.selectMaterial)
			arg_33_0()

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_23_0)

	return
end

function var_0_1.FillNodeAndPlayAnim(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_0 = arg_34_0._parentClass

	var_5.LoadingOn(var_34_0)

	local var_34_1

	if not arg_34_1.ChangeInstance then
		tobool = var_34_1
		var_34_1 = var_34_1(arg_34_1.Instance)
		tobool = var_6
		var_34_1 = var_34_1 ~= var_6(arg_34_2)
	end

	arg_34_1.ChangeInstance = var_34_1
	arg_34_1.Instance = arg_34_2
	arg_34_1.Change = true

	local var_34_2 = {}
	local var_34_3 = {}

	seriesAsync = var_1_10007

	var_1_10007({
		function(arg_35_0)
			table = var_2_10001

			var_2_10001.ParallelIpairsAsync({
				"ui/laisha_ui_wupinzhiru",
				"ui/laisha_ui_baoshi"
			}, function(arg_36_0, arg_36_1, arg_36_2)
				local var_36_0 = var_34_2
				local var_36_1 = arg_34_0._parentClass.loader

				var_36_0[arg_36_0] = var_4.GetPrefab(var_36_1, arg_36_1, "", function(arg_37_0)
					setParent = var_4_10001

					local var_37_0 = arg_37_0

					tf = var_4_10003

					var_4_10001(var_37_0, var_4_10003(arg_34_1.GO))

					setAnchoredPosition = var_4_10001

					local var_37_1 = arg_37_0

					Vector2 = var_3

					var_4_10001(var_37_1, var_3.zero)

					local var_37_2 = var_34_3

					var_37_2[arg_36_0] = arg_37_0
					setActive = var_37_2

					var_37_2(arg_37_0, false)
					arg_36_2()

					return
				end)

				return
			end, arg_35_0)

			return
		end,
		function(arg_38_0)
			setActive = var_2_10001

			var_2_10001(var_34_3[1], true)

			local var_38_0 = arg_34_0._parentClass
			local var_38_1 = var_1.managedTween

			LeanTween = var_3

			var_38_1(var_38_0, var_3.delayedCall, function()
				if not arg_34_4 then
					ipairs = var_0

					for iter_39_0, iter_39_1 in var_0(arg_34_0.nodeLayer[arg_34_0.unLockLayerIndex]) do
						local var_39_0 = arg_34_0

						var_5.UpdateNodeView(var_39_0, arg_34_0.nodeList[iter_39_1])
					end
				else
					local var_39_1 = arg_34_0

					var_0.UpdateNodeView(var_39_1, arg_34_1)
				end

				local var_39_2 = arg_34_0._parentClass

				var_0.PlaySoundEffect(var_39_2, arg_34_0._parentClass.soundStr.formulaDetailFill)
				arg_38_0()

				return
			end, 0.2, nil)

			return
		end,
		function(arg_40_0)
			setActive = var_2_10001

			var_2_10001(var_34_3[2], true)

			local var_40_0 = arg_34_0._parentClass
			local var_40_1 = var_1.managedTween

			LeanTween = var_3

			var_40_1(var_40_0, var_3.delayedCall, function()
				arg_40_0()

				return
			end, 0.5, nil)

			return
		end,
		function(arg_42_0)
			local var_42_0 = arg_34_0._parentClass.loader

			var_1.ClearRequest(var_42_0, var_34_2[1])

			local var_42_1 = arg_34_0._parentClass.loader

			var_1.ClearRequest(var_42_1, var_34_2[2])

			local var_42_2 = arg_34_0._parentClass

			var_1.LoadingOff(var_42_2)

			local var_42_3 = arg_34_0

			var_1.RefreshBtn(var_42_3)

			existCall = var_1

			var_1(arg_34_3)

			return
		end
	})

	return
end

function var_0_1.DisPlayUnlockEffect(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0._parentClass

	var_3.LoadingOn(var_43_0)

	local var_43_1 = {}

	ipairs = var_43_0

	for iter_43_0, iter_43_1 in var_43_0(arg_43_0.nodeLayer[arg_43_1]) do
		local var_43_2 = arg_43_0.nodeList[iter_43_1]
		local var_43_3 = arg_43_0._parentClass.loader
		local var_43_4 = var_10.GetPrefab(var_43_3, "ui/" .. arg_43_0.unlockEffect, "", function(arg_44_0)
			setParent = var_2_10001

			local var_44_0 = arg_44_0

			tf = var_2_10003

			var_2_10001(var_44_0, var_2_10003(var_43_2.GO))

			setAnchoredPosition = var_2_10001

			local var_44_1 = arg_44_0

			Vector2 = var_3

			var_2_10001(var_44_1, var_3.zero)

			return
		end)

		table = var_43_3

		var_43_3.insert(var_43_1, var_43_4)
	end

	local var_43_5 = arg_43_0._parentClass
	local var_43_6 = var_4.managedTween

	LeanTween = var_6

	var_43_6(var_43_5, var_6.delayedCall, function()
		local var_45_0 = arg_43_0._parentClass

		var_0.PlaySoundEffect(var_45_0, arg_43_0._parentClass.soundStr.formulaDetailUnlock)

		return
	end, 0.7, nil)

	local var_43_7 = arg_43_0._parentClass
	local var_43_8 = var_4.managedTween

	LeanTween = var_6

	var_43_8(var_43_7, var_6.delayedCall, function()
		_ = var_2_10000

		var_2_10000.each(var_43_1, function(arg_47_0)
			local var_47_0 = arg_43_0._parentClass.loader

			var_1.ClearRequest(var_47_0, arg_47_0)

			return
		end)

		local var_46_0 = arg_43_0._parentClass

		var_0.LoadingOff(var_46_0)

		local var_46_1 = arg_43_0

		var_46_1.unLockLayerIndex = arg_43_1
		existCall = var_46_1

		var_46_1(arg_43_2)

		return
	end, 1.7, nil)

	return
end

function var_0_1.UpdateFormulaDetail(arg_48_0)
	_ = var_1_10001

	var_1_10001.each(arg_48_0.nodeList, function(arg_49_0)
		local var_49_0 = arg_48_0

		var_1.UpdateNodeView(var_49_0, arg_49_0)

		return
	end)
	arg_48_0:RefreshBtn()

	return
end

function var_0_1.RefreshBtn(arg_50_0)
	local var_50_0 = #arg_50_0.nodeList

	_ = var_1_10002

	local var_50_1 = #var_1_10002.select(arg_50_0.nodeList, function(arg_51_0)
		return arg_51_0.Instance ~= nil
	end)

	setText = var_3

	local var_50_2 = arg_50_0._tf
	local var_50_3 = var_4.Find(var_50_2, "Bar/Text")

	i18n = var_50_2

	var_3(var_50_3, var_50_2("ryza_tip_put_materials", var_50_1, var_50_0))

	setGray = var_3

	local var_50_4 = arg_50_0._tf
	local var_50_5 = var_4.Find(var_50_4, "AutoFill")
	local var_50_6 = arg_50_0.activity
	local var_50_7 = var_5.GetFormulas(var_50_6)[arg_50_0.contextData.formulaId]

	var_3(var_50_5, not var_5.IsAvaliable(var_50_7))

	setActive = var_3

	local var_50_8 = arg_50_0._tf

	var_3(var_4.Find(var_50_8, "Composite/Disabled"), var_50_1 < var_50_0)

	return
end

function var_0_1.UpdateNodeView(arg_52_0, arg_52_1)
	arg_52_0:RefreshNodeLinks(arg_52_1)

	tf = var_2

	local var_52_0 = var_2(arg_52_1.GO)
	local var_52_1 = arg_52_1.Data
	local var_52_2 = var_3.GetElementName(var_52_1)
	local var_52_3 = arg_52_0
	local var_52_4 = arg_52_0.IsLockNode(var_52_3, arg_52_1)

	setActive = var_52_3

	var_52_3(var_52_0:Find("Lock"), var_52_4)

	if var_52_4 then
		local var_52_5 = var_3
		local var_52_6 = var_3.GetType(var_52_5)

		AtelierFormulaCircle = var_52_5

		if var_52_6 ~= var_52_5.TYPE.ANY then
			local var_52_7 = arg_52_0._parentClass.loader

			var_52_6.GetSpriteQuiet(var_52_7, arg_52_0.commonBundleName, "element_" .. var_52_2, var_52_0:Find("Lock/Require/Icon"))
		end

		setText = var_52_6

		var_52_6(var_52_0:Find("Lock/Require/Text"), "X" .. var_3:GetLevel())
	end

	for iter_52_0 = 3, var_3:GetLevel() + 1, -1 do
		local var_52_8 = var_52_0:Find("Slots")
		local var_52_9 = var_10.GetChild(var_52_8, iter_52_0 - 1)
		local var_52_10 = arg_52_0._parentClass.loader

		var_11.GetSpriteQuiet(var_52_10, arg_52_0.bundleName, "slot_BLOCKED", var_52_9:Find("Image"))
	end

	local var_52_11 = arg_52_1.Instance
	local var_52_12 = var_52_0:Find("Item")

	if not var_52_11 then
		local var_52_13 = var_3
		local var_52_14 = var_3.GetType(var_52_13)

		AtelierFormulaCircle = var_52_13

		if var_52_14 == var_52_13.TYPE.ANY then
			setActive = var_52_14

			var_52_14(var_52_0:Find("All"), true)
		else
			setActive = var_52_14

			var_52_14(var_52_0:Find("Icon"), true)

			local var_52_15 = arg_52_0._parentClass.loader

			var_52_14 = var_52_14.GetSpriteQuiet

			local var_52_16 = arg_52_0.bundleName
			local var_52_17 = "icon_" .. var_52_2

			var_1_10013 = var_52_0

			var_52_14(var_52_15, var_52_16, var_52_17, var_52_0.Find(var_1_10013, "Icon"), true)
		end

		setActive = var_52_14

		var_52_14(var_52_12, false)

		local var_52_18 = var_3
		local var_52_19 = var_3.GetType(var_52_18)

		AtelierFormulaCircle = var_52_18

		if var_52_19 ~= var_52_18.TYPE.BASE then
			local var_52_20 = var_3

			var_52_19 = var_3.GetType(var_52_20)
			AtelierFormulaCircle = var_52_20

			if var_52_19 == var_52_20.TYPE.SAIREN then
				AtelierMaterial = var_52_19
				var_52_19 = var_52_19.New({
					configId = var_3:GetLimitItemID()
				})
				setActive = var_9

				var_9(var_52_0:Find("Name"), true)

				setScrollText = var_9

				var_9(var_52_0:Find("Name/Rect/Text"), var_52_19:GetName())
			else
				setActive = var_52_19

				var_52_19(var_52_0:Find("Name"), false)
			end

			for iter_52_1 = 1, var_3:GetLevel() do
				var_1_10013 = var_52_0
				var_1_10013 = var_52_0.Find(var_1_10013, "Slots")

				local var_52_21 = var_12.GetChild(var_1_10013, iter_52_1 - 1)

				var_1_10014 = arg_52_0._parentClass.loader

				var_1_10013.GetSpriteQuiet(var_1_10014, arg_52_0.bundleName, "slot_NULL", var_52_21:Find("Image"))
			end

			goto label_52_0

			local var_52_22 = var_3
			local var_52_23 = var_3.GetRingElement(var_52_22, var_52_11)

			AtelierFormulaCircle = var_52_22

			local var_52_24 = var_52_22.ELEMENT_NAME[var_52_23]
			local var_52_25 = var_3
			local var_52_26 = var_3.GetType(var_52_25)

			AtelierFormulaCircle = var_52_25

			if var_52_26 == var_52_25.TYPE.ANY then
				setActive = var_52_26

				var_52_26(var_52_0:Find("All"), false)
			else
				setActive = var_52_26

				var_52_26(var_52_0:Find("Icon"), false)
			end

			setActive = var_52_26

			var_52_26(var_52_12, true)

			local var_52_27
			local var_52_28 = var_3
			local var_52_29 = var_3.GetType(var_52_28)

			AtelierFormulaCircle = var_52_28

			if var_52_29 ~= var_52_28.TYPE.BASE then
				do
					local var_52_30 = var_3

					var_52_29 = var_3.GetType(var_52_30)
					AtelierFormulaCircle = var_52_30

					if var_52_29 == var_52_30.TYPE.SAIREN then
						var_52_27 = var_52_11:GetBaseCircleTransform()
					else
						var_52_27 = var_52_11:GetNormalCircleTransform()
					end

					setLocalScale = var_52_29

					local var_52_31 = var_52_12

					Vector3 = var_1_10013

					local var_52_32 = var_1_10013.New

					unpack = var_1_10014

					var_52_29(var_52_31, var_52_32(var_1_10014(var_52_27, 1, 3)))

					setAnchoredPosition = var_52_29

					local var_52_33 = var_52_12

					Vector2 = var_13

					local var_52_34 = var_13.New

					unpack = var_14

					var_52_29(var_52_33, var_52_34(var_14(var_52_27, 4, 5)))

					local var_52_35 = arg_52_0._parentClass.loader

					var_11.GetSpriteQuiet(var_52_35, var_52_11:GetIconPath(), "", var_52_12, true)

					setActive = var_11

					var_11(var_52_0:Find("Name"), true)

					setScrollText = var_11

					var_11(var_52_0:Find("Name/Rect/Text"), var_52_11:GetName())

					for iter_52_2 = 1, var_3:GetLevel() do
						local var_52_36 = var_52_0:Find("Slots")
						local var_52_37 = var_15.GetChild(var_52_36, iter_52_2 - 1)
						local var_52_38 = arg_52_0._parentClass.loader

						var_16.GetSpriteQuiet(var_52_38, arg_52_0.bundleName, "slot_" .. var_52_24, var_52_37:Find("Image"))
					end
				end

				::label_52_0::

				local var_52_39 = var_52_0
				local var_52_40 = var_52_0.Find(var_52_39, "Ring")

				setImageColor = var_52_39

				var_52_39(var_52_40, var_3:GetElementRingColor(var_52_11))

				if arg_52_1.Change then
					local var_52_41 = arg_52_1.Data
					local var_52_42 = var_9.GetRingElement(var_52_41, var_52_11)

					if var_52_4 then
						var_52_42 = nil
					end

					if arg_52_0.ringEffect[var_52_42] then
						local var_52_43 = arg_52_1.Data
						local var_52_44 = var_10.GetType(var_52_43)

						AtelierFormulaCircle = var_52_43

						local var_52_45 = var_52_44 == var_52_43.TYPE.BASE and "_o" or "_6"
						local var_52_46 = arg_52_0._parentClass.loader

						var_11.GetPrefab(var_52_46, "ui/" .. arg_52_0.ringEffect[var_52_42] .. var_52_45, "", function(arg_53_0)
							setParent = var_2_10001

							var_2_10001(arg_53_0, var_52_40)

							setAnchoredPosition = var_2_10001

							local var_53_0 = arg_53_0

							Vector2 = var_3

							var_2_10001(var_53_0, var_3.zero)

							return
						end, var_52_40)
					else
						local var_52_47 = arg_52_0._parentClass.loader

						var_10.ClearRequest(var_52_47, var_52_40)
					end

					arg_52_0:RefreshNodeLinkEffects(var_52_0, arg_52_1, var_52_4)

					arg_52_1.Change = nil
				end

				if arg_52_1.ChangeInstance then
					if var_52_11 then
						local var_52_48 = arg_52_0._parentClass.loader

						var_9.GetPrefab(var_52_48, "ui/" .. arg_52_0.deployEffect, "", function(arg_54_0)
							setParent = var_2_10001

							var_2_10001(arg_54_0, var_52_12)

							setAnchoredPosition = var_2_10001

							local var_54_0 = arg_54_0

							Vector2 = var_3

							var_2_10001(var_54_0, var_3.zero)

							return
						end, var_52_0)
					else
						local var_52_49 = arg_52_0._parentClass.loader

						var_9.ClearRequest(var_52_49, var_52_0)
					end

					arg_52_1.ChangeInstance = nil
				end

				onButton = var_9

				local var_52_50 = arg_52_0
				local var_52_51 = var_52_0

				local function var_52_52()
					if var_52_4 then
						return
					end

					local var_55_0 = arg_52_0._parentClass

					var_0.ShowMaterialSelectWindow(var_55_0, var_52_0, arg_52_1, arg_52_0.nodeList)

					return
				end

				SFX_PANEL = var_13

				var_9(var_52_50, var_52_51, var_52_52, var_13)

				return
			end
		end
	end
end

function var_0_1.IsLockNode(arg_56_0, arg_56_1)
	local var_56_0 = 1

	ipairs = var_1_10003

	for iter_56_0, iter_56_1 in var_1_10003(arg_56_0.nodeLayer) do
		_ = var_1_10008
		var_1_10008 = var_1_10008.detect(iter_56_1, function(arg_57_0)
			return arg_56_0.nodeList[arg_57_0] == arg_56_1
		end)
		ni = var_9

		if var_1_10008 ~= var_9 then
			var_56_0 = iter_56_0

			break
		end
	end

	if var_56_0 > arg_56_0.unLockLayerIndex then
		return true
	end

	return false
end

function var_0_1.willExit(arg_58_0)
	local var_58_0 = arg_58_0.atelierFormulaOverlayView

	var_1.willExit(var_58_0)

	arg_58_0.atelierFormulaOverlayView = nil

	arg_58_0:detach()

	return
end

function var_0_1.InitStr(arg_59_0)
	local var_59_0 = {}

	AtelierFormulaCircle = var_1_10002
	var_59_0[var_1_10002.TYPE.BASE] = "circle"
	AtelierFormulaCircle = var_2
	var_59_0[var_2.TYPE.NORMAL] = "hexagon"
	AtelierFormulaCircle = var_2
	var_59_0[var_2.TYPE.SAIREN] = "doubleHexagon"
	AtelierFormulaCircle = var_2
	var_59_0[var_2.TYPE.ANY] = "anyHexagon"
	AtelierFormulaCircle = var_2
	var_59_0[var_2.TYPE.NONE] = "circle"
	AtelierFormulaCircle = var_2
	var_59_0[var_2.TYPE.ELEMENT] = "hexagon"
	AtelierFormulaCircle = var_2
	var_59_0[var_2.TYPE.CATEGORY] = "doubleHexagon"
	AtelierFormulaCircle = var_2
	var_59_0[var_2.TYPE.ELEMENT_CATEGORY] = "doubleHexagon"
	arg_59_0.poolNames = var_59_0
	arg_59_0.lineEffect = {
		"laisha_ui_lianjie01",
		"laisha_ui_lianjie02",
		"laisha_ui_lianjie_qiehuan"
	}

	local var_59_1 = {}

	AtelierFormulaCircle = var_2
	var_59_1[var_2.ELEMENT_TYPE.PYRO] = "laisha_ui_huo"
	AtelierFormulaCircle = var_2
	var_59_1[var_2.ELEMENT_TYPE.CRYO] = "laisha_ui_bing"
	AtelierFormulaCircle = var_2
	var_59_1[var_2.ELEMENT_TYPE.ELECTRO] = "laisha_ui_lei"
	AtelierFormulaCircle = var_2
	var_59_1[var_2.ELEMENT_TYPE.ANEMO] = "laisha_ui_feng"
	AtelierFormulaCircle = var_2
	var_59_1[var_2.ELEMENT_TYPE.SAIREN] = "laisha_ui_sairen"
	arg_59_0.ringEffect = var_59_1
	arg_59_0.deployEffect = "laisha_ui_wupinshanguang"
	arg_59_0.unlockEffect = "laisha_ui_jiesuo"

	local var_59_2 = {}

	AtelierFormulaCircle = var_2
	var_59_2[1] = var_2.TYPE.BASE
	AtelierFormulaCircle = var_2
	var_59_2[2] = var_2.TYPE.NORMAL
	AtelierFormulaCircle = var_2
	var_59_2[3] = var_2.TYPE.SAIREN
	AtelierFormulaCircle = var_2
	var_59_2[4] = var_2.TYPE.ANY
	arg_59_0.circleTypeList = var_59_2

	return
end

function var_0_1.InitNodeLayer(arg_60_0)
	arg_60_0.nodeLayer = {
		{}
	}
	pairs = var_1

	for iter_60_0, iter_60_1 in var_1(arg_60_0.nodeList) do
		local var_60_0 = iter_60_1.Data
		local var_60_1 = var_6.GetType(var_60_0)

		AtelierFormulaCircle = var_60_0

		if var_60_1 ~= var_60_0.TYPE.BASE then
			AtelierFormulaCircle = var_8

			if var_60_1 == var_8.TYPE.SAIREN then
				local var_60_2 = arg_60_0.nodeLayer
				local var_60_3

				if not arg_60_0.nodeLayer[1] then
					var_60_3 = {}
				end

				var_60_2[1] = var_60_3
				table = var_60_2

				var_60_2.insert(arg_60_0.nodeLayer[1], iter_60_0)
			else
				local var_60_4 = arg_60_0.nodeLayer
				local var_60_5

				if not arg_60_0.nodeLayer[2] then
					var_60_5 = {}
				end

				var_60_4[2] = var_60_5
				table = var_60_4

				var_60_4.insert(arg_60_0.nodeLayer[2], iter_60_0)
			end
		end
	end

	for iter_60_2 = #arg_60_0.nodeLayer, 1, -1 do
		if #arg_60_0.nodeLayer[iter_60_2] == 0 then
			table = var_5

			var_5.remove(arg_60_0.nodeLayer, iter_60_2)
		end
	end

	return
end

function var_0_1.SetCirclePanel(arg_61_0)
	local var_61_0 = 280

	math = var_1_10002

	local var_61_1 = var_1_10002.deg2Rad * 30

	Vector2 = var_1_10003

	local var_61_2 = var_1_10003.New

	math = var_1_10004

	local var_61_3 = var_1_10004.cos(var_61_1)

	math = var_5

	local var_61_4 = var_61_0 * var_61_2(var_61_3, var_5.sin(var_61_1))

	Vector2 = var_61_3
	arg_61_0.axisY = var_61_0 * var_61_3(0, 1)
	arg_61_0.axisX = var_61_4
	Vector2 = var_61_4
	arg_61_0.viewMax = var_61_4.zero

	local var_61_5 = arg_61_0
	local var_61_6 = arg_61_0.SetCirclePosition
	local var_61_7 = arg_61_0.nodeList[1]

	Vector2 = var_6

	var_61_6(var_61_5, var_61_7, var_6.zero)

	setSizeDelta = var_61_6

	local var_61_8 = arg_61_0.viewContent
	local var_61_9 = arg_61_0.viewMax

	Vector2 = var_6

	var_61_6(var_61_8, (var_61_9 + var_6.New(var_61_0, var_61_0)) * 2)

	return
end

local var_0_3 = {
	{
		0,
		1
	},
	{
		-1,
		1
	},
	{
		-1,
		0
	},
	{
		0,
		-1
	},
	{
		1,
		-1
	},
	{
		1,
		0
	}
}

function var_0_1.SetCirclePosition(arg_62_0, arg_62_1, arg_62_2)
	setAnchoredPosition = var_1_10003

	var_1_10003(arg_62_1.GO, arg_62_2)

	local var_62_0 = arg_62_1.Data
	local var_62_1 = var_3.GetNeighbors(var_62_0)

	arg_62_1.links = {}
	_ = var_4

	var_4.each(var_62_1, function(arg_63_0)
		local var_63_0 = arg_63_0[1]
		local var_63_1 = arg_63_0[2]
		local var_63_2 = var_0_3[var_63_0][1] * arg_62_0.axisX + var_3[2] * arg_62_0.axisY

		_ = var_5

		local var_63_3 = var_5.detect(arg_62_0.nodeList, function(arg_64_0)
			local var_64_0 = arg_64_0.Data

			return var_1.GetConfigID(var_64_0) == var_63_1
		end)

		var_63_3.prevLink = {
			(var_63_0 + 2) % 5 + 1,
			arg_62_1
		}
		arg_62_1.links[var_63_0] = var_63_3

		local var_63_4 = arg_62_2 + var_63_2
		local var_63_5 = arg_62_0

		var_7.SetCirclePosition(var_63_5, var_63_3, var_63_4)

		local var_63_6 = arg_62_0

		Vector2 = var_63_5
		var_63_6.viewMax = var_63_5.Max(arg_62_0.viewMax, -var_63_4)

		local var_63_7 = arg_62_0

		Vector2 = var_8
		var_63_7.viewMax = var_8.Max(arg_62_0.viewMax, var_63_4)

		return
	end)

	return
end

function var_0_1.RefreshNodeLinks(arg_65_0, arg_65_1)
	tf = var_1_10002

	local var_65_0 = var_1_10002(arg_65_1.GO)

	for iter_65_0 = 1, 6 do
		setActive = var_1_10007

		local var_65_1 = var_65_0:Find("Links")

		var_1_10007(var_8.GetChild(var_65_1, iter_65_0 - 1), false)
	end

	local var_65_2 = arg_65_1.Data

	_ = var_4

	var_4.each(var_65_2:GetNeighbors(), function(arg_66_0)
		setActive = var_2_10001

		local var_66_0 = var_65_0
		local var_66_1 = var_2.Find(var_66_0, "Links")

		var_2_10001(var_2.GetChild(var_66_1, arg_66_0[1] - 1), true)

		return
	end)

	return
end

function var_0_1.RefreshNodeLinkEffects(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
	table = var_1_10004

	var_1_10004.Foreach(arg_67_2.links, function(arg_68_0, arg_68_1)
		local var_68_0 = arg_67_1
		local var_68_1 = var_2.Find(var_68_0, "Links/" .. arg_68_0)
		local var_68_2 = arg_67_0.lineEffect[3]

		if arg_68_1.Lock and arg_67_3 then
			var_68_2 = arg_67_0.lineEffect[1]
		elseif not arg_68_1.Lock and not arg_67_3 then
			var_68_2 = arg_67_0.lineEffect[2]
		end

		local var_68_3 = arg_67_0._parentClass.loader

		var_4.GetPrefab(var_68_3, "ui/" .. var_68_2, "", function(arg_69_0)
			setParent = var_3_10001

			local var_69_0 = arg_69_0
			local var_69_1 = var_68_1

			var_3_10001(var_69_0, var_3.Find(var_69_1, "Link"))

			setAnchoredPosition = var_3_10001

			local var_69_2 = arg_69_0

			Vector2 = var_3

			var_3_10001(var_69_2, var_3.New(0, -15))

			return
		end, var_68_1)

		return
	end)

	return
end

function var_0_1.CleanNodeLinks(arg_70_0, arg_70_1)
	table = var_1_10002

	var_1_10002.Foreach(arg_70_1.links, function(arg_71_0)
		nodeTF = var_2_10001

		local var_71_0 = var_2_10001:Find("Links/" .. arg_71_0)
		local var_71_1 = arg_70_0._parentClass.loader

		var_2.ClearRequest(var_71_1, var_71_0)

		return
	end)

	return
end

return var_0_1
