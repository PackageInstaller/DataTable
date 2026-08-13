class = var_0_10000

local var_0_0 = "IslandPhotoSelectFramePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandPhotoSelectFrameUI"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.cancelBtnTrans = var_1.Find(var_2_0, "cancelBtn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.confirmBtnTrans = var_1.Find(var_2_1, "selectPage/confirmBtn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.frameAdapter = var_1.Find(var_2_2, "frameAdapter")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "selectPage/Scroll/Viewport/Content")

	arg_2_0.frameDataList = {}
	IslandConst = var_2

	if var_2.OnlyShowOwnedFrame == true then
		ipairs = var_2
		pg = var_4

		for iter_2_0, iter_2_1 in var_2(var_4.island_camera_photo_frame.all) do
			pg = var_1_10007
			var_1_10007 = var_1_10007.island_camera_photo_frame[iter_2_1]
			ApartmentProxy = var_1_10008

			local var_2_5

			var_1_10008, var_2_5 = var_1_10008.CheckUnlockConfig(var_1_10007.unlock)

			if var_1_10008 then
				table = var_10

				var_10.insert(arg_2_0.frameDataList, iter_2_1)
			end
		end
	else
		pg = var_2
		arg_2_0.frameDataList = var_2.island_camera_photo_frame.all
	end

	local function var_2_6()
		UIItemList = var_2_10000

		local var_3_0 = var_2_10000.StaticAlign
		local var_3_1 = var_2_4
		local var_3_2 = var_2_4

		var_3_0(var_3_1, var_3.GetChild(var_3_2, 0), #arg_2_0.frameDataList, function(arg_4_0, arg_4_1, arg_4_2)
			UIItemList = var_3_10003

			if arg_4_0 ~= var_3_10003.EventUpdate then
				return
			end

			arg_4_1 = arg_4_1 + 1

			local var_4_0 = arg_2_0.frameDataList[arg_4_1]

			setActive = var_3_10004

			var_3_10004(arg_4_2:Find("Selected"), arg_2_0.selectId == var_4_0)

			return
		end)

		return
	end

	pg = var_2_3

	local var_2_7 = var_2_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_2_7, arg_2_0._tf, {
		staticBlur = true
	})

	arg_2_0.frameDic = {}
	arg_2_0.loadingDic = {}
	arg_2_0.lateFuncDic = {}
	arg_2_0.specialLateFuncDic = {}
	UIItemList = var_3

	local var_2_8 = var_3.New
	local var_2_9 = var_2_4
	local var_2_10 = var_2_4

	arg_2_0.frameUIList = var_2_8(var_2_9, var_2_4.GetChild(var_2_10, 0))

	local var_2_11 = arg_2_0.frameUIList

	var_3.make(var_2_11, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			arg_5_1 = arg_5_1 + 1
			pg = var_3

			local var_5_0 = var_3.island_camera_photo_frame[arg_2_0.frameDataList[arg_5_1]].id

			GetImageSpriteFromAtlasAsync = var_2_10005
			string = var_2_10007

			var_2_10005(var_2_10007.format("Island/IslandPhotoFrame/%s", var_3.farme_small_path), "", arg_5_2:Find("Icon"))

			setActive = var_2_10005

			var_2_10005(arg_5_2:Find("Selected"), false)

			setActive = var_2_10005

			var_2_10005(arg_5_2:Find("lock"), false)

			ApartmentProxy = var_2_10005

			local var_5_1, var_5_2 = var_2_10005.CheckUnlockConfig(var_3.unlock)

			setActive = var_7

			var_7(arg_5_2:Find("lock"), not var_5_1)

			if not var_5_1 then
				setText = var_7

				var_7(arg_5_2:Find("lock/Image/Text"), var_3.unlock_text)
			end

			onButton = var_7

			var_7(arg_2_0, arg_5_2, function()
				if not var_5_1 then
					pg = var_0
					var_3_10002 = var_0.TipsMgr.GetInstance()

					var_0.ShowTips(var_3_10002, var_5_2)

					return
				end

				if arg_2_0.selectId == var_5_0 then
					return
				end

				arg_2_0.selectId = var_5_0

				var_2_6()

				local var_6_0 = var_0.frameTfName == "IslandFilmFrame"
				local var_6_1 = var_0.frameTfName == "IslandInsFrame"

				pairs = var_3_10002

				for iter_6_0, iter_6_1 in var_3_10002(arg_2_0.frameDic) do
					setActive = var_3_10007

					var_3_10007(iter_6_1, false)
				end

				local function var_6_2(arg_7_0)
					local var_7_0 = arg_7_0:Find("mask/realImage")
					local var_7_1 = var_1.GetComponent

					typeof = var_4_10005
					RawImage = var_4_10007
					var_7_1(var_7_0, var_4_10005(var_4_10007)).texture = arg_2_0.texture
					GameObject = var_3

					local var_7_2 = var_3.Find("OverlayCamera").transform

					var_1.sizeDelta = var_3.GetChild(var_7_2, 0).sizeDelta
					setAnchoredPosition = var_4

					var_4(var_1, {
						x = 0,
						y = 0
					})

					Vector3 = var_4
					var_1.localScale = var_4(1, 1, 1)

					local var_7_3 = {}

					if var_6_1 then
						table = var_5

						var_5.insert(var_7_3, "mask_up/realImage")
					elseif var_6_0 then
						table = var_5

						var_5.insert(var_7_3, "mask_up/realImage")

						table = var_5

						var_5.insert(var_7_3, "mask_down/realImage")
					end

					ipairs = var_5

					for iter_7_0, iter_7_1 in var_5(var_7_3) do
						local var_7_4 = arg_7_0:Find(iter_7_1)
						local var_7_5 = var_10.GetComponent

						typeof = var_4_10014
						RawImage = var_4_10016
						var_7_5(var_7_4, var_4_10014(var_4_10016)).texture = arg_2_0.texture
						GameObject = var_12
						var_4_10014 = var_12.Find("OverlayCamera").transform

						local var_7_6 = var_12.GetChild(var_4_10014, 0)

						if var_6_1 and iter_7_1 == "mask_up/realImage" then
							Vector2 = var_13
							var_10.sizeDelta = var_13(var_7_6.sizeDelta.x / 10, var_7_6.sizeDelta.y / 10)
						else
							var_10.sizeDelta = var_7_6.sizeDelta
						end

						setAnchoredPosition = var_13

						var_13(var_10, {
							x = 0,
							y = 0
						})

						Vector3 = var_13
						var_10.localScale = var_13(1, 1, 1)
					end

					return
				end

				if arg_2_0.frameDic[arg_2_0.selectId] then
					setActive = var_4

					var_4(var_3, true)
					var_6_2(var_3)

					return
				end

				if arg_2_0.loadingDic[arg_5_1] then
					return
				end

				local var_6_3 = arg_2_0.loadingDic

				var_6_3[arg_5_1] = true
				IslandAssetLoadDispatcher = var_6_3

				local var_6_4 = var_6_3.Instance
				local var_6_5 = var_4.Enqueue
				local var_6_6 = "ui/" .. var_0.frameTfName
				local var_6_7 = ""

				typeof = var_3_10009
				GameObject = var_3_10011

				local var_6_8 = var_3_10009(var_3_10011)

				UnityEngine = var_3_10010

				local var_6_9 = var_6_5(var_6_4, var_6_6, var_6_7, var_6_8, var_3_10010.Events.UnityAction_UnityEngine_Object(function(arg_8_0)
					local var_8_0 = arg_2_0.loadingDic

					var_8_0[arg_5_1] = false
					Object = var_8_0

					local var_8_1 = var_8_0.Instantiate(arg_8_0, arg_2_0.frameAdapter).transform

					arg_2_0.frameDic[var_5_0] = var_8_1

					local var_8_2 = {
						"mask/realImage"
					}
					local var_8_3 = {
						"mask"
					}

					if var_6_1 then
						table = var_4

						var_4.insert(var_8_2, "mask_up/realImage")

						table = var_4

						var_4.insert(var_8_3, "mask_up")
					elseif var_6_0 then
						table = var_4

						var_4.insert(var_8_2, "mask_up/realImage")

						table = var_4

						var_4.insert(var_8_2, "mask_down/realImage")

						table = var_4

						var_4.insert(var_8_3, "mask_up")

						table = var_4

						var_4.insert(var_8_3, "mask_down")
					end

					;(function()
						ipairs = var_5_10000

						for iter_9_0, iter_9_1 in var_5_10000(var_8_2) do
							local var_9_0 = var_8_1
							local var_9_1 = var_5.Find(var_9_0, iter_9_1)

							GetOrAddComponent = var_5_10006

							local var_9_2 = var_8_1

							var_5_10006 = var_5_10006(var_8.Find(var_9_2, iter_9_1), "PinchZoom")
							GetOrAddComponent = var_9_0

							local var_9_3 = var_8_1
							local var_9_4 = var_9_0(var_9.Find(var_9_3, iter_9_1), "EventTriggerListener")
							local var_9_5 = true

							var_9_4:AddPointDownFunc(function(arg_10_0)
								Input = var_6_10001

								if var_6_10001.touchCount ~= 1 then
									IsUnityEditor = var_1

									if var_1 then
										var_9_5 = true
									else
										Input = var_1

										if var_1.touchCount >= 2 then
											var_9_5 = false
										end
									end

									return
								end
							end)
							var_9_4:AddPointUpFunc(function(arg_11_0)
								Input = var_6_10001

								if var_6_10001.touchCount <= 2 then
									var_9_5 = true
								end

								return
							end)

							GameObject = var_9

							local var_9_6 = var_9.Find("OverlayCamera").transform
							local var_9_7 = var_9.GetChild(var_9_6, 0).sizeDelta

							if var_6_1 and iter_9_1 == "mask_up/realImage" then
								Vector2 = var_10
								var_9_7 = var_10(var_9_7.x / 10, var_9_7.y / 10)
							end

							local var_9_8 = var_8_1
							local var_9_9 = var_10.Find(var_9_8, var_8_3[iter_9_0]).sizeDelta

							var_9_4:AddBeginDragFunc(function(arg_12_0, arg_12_1)
								local var_12_0 = arg_12_1.position.x - var_9_1.localPosition.x
								local var_12_1 = touchOffsetX
								local var_12_2 = arg_12_1.position.y - var_9_1.localPosition.y
								local var_12_3 = touchOffsetY

								return
							end)

							math = var_11

							local var_9_10 = var_11.max(var_9_9.x / var_9_7.x, var_9_9.y / var_9_7.y)

							LateUpdateBeat = var_9_8

							local var_9_11 = var_9_8:CreateListener(function()
								if var_5_10006.processing then
									local var_13_1

									if var_9_1.localScale.x < var_9_10 then
										local var_13_0 = var_9_1

										Vector3 = var_2
										var_13_0.localScale = var_2(var_9_10, var_9_10, var_13_1.z)
										var_13_1 = var_9_1.localScale
									end

									local var_13_2 = (var_9_7.x * var_13_1.x - var_9_9.x) / 2
									local var_13_3 = (var_9_7.y * var_13_1.x - var_9_9.y) / 2

									math = var_3

									local var_13_4 = var_3.clamp(var_9_1.localPosition.x, -var_13_2, var_13_2)

									math = var_6_10004

									local var_13_5 = var_6_10004.clamp(var_9_1.localPosition.y, -var_13_3, var_13_3)
									local var_13_6 = var_9_1

									Vector3 = var_6
									var_13_6.localPosition = var_6(var_13_4, var_13_5, 1)
								end

								return
							end, arg_2_0)

							LateUpdateBeat = var_13

							var_13:AddListener(var_9_11)

							if var_6_0 or var_6_1 then
								table = var_13

								var_13.insert(arg_2_0.specialLateFuncDic, var_9_11)
							else
								arg_2_0.lateFuncDic[arg_5_1] = var_9_11
							end

							var_9_4:AddDragFunc(function(arg_14_0, arg_14_1)
								if var_5_10006.processing then
									return
								end

								if var_9_5 then
									local var_14_0 = var_9_1.localScale
									local var_14_1 = (var_9_7.x * var_14_0.x - var_9_9.x) / 2
									local var_14_2 = (var_9_7.y * var_14_0.x - var_9_9.y) / 2

									math = var_5

									local var_14_3 = var_5.clamp
									local var_14_4 = arg_14_1.position.x

									touchOffsetX = var_6_10008

									local var_14_5 = var_14_3(var_14_4 - var_6_10008, -var_14_1, var_14_1)

									math = var_6_10006

									local var_14_6 = var_6_10006.clamp
									local var_14_7 = arg_14_1.position.y

									touchOffsetY = var_9

									local var_14_8 = var_14_6(var_14_7 - var_9, -var_14_2, var_14_2)
									local var_14_9 = var_9_1

									Vector3 = var_8
									var_14_9.localPosition = var_8(var_14_5, var_14_8, 1)
								end

								return
							end)
						end

						return
					end)()

					if arg_2_0.selectId == var_5_0 then
						var_6_2(var_8_1)
					else
						setActive = var_5

						var_5(var_8_1, false)
					end

					return
				end), true, true)

				table = var_5

				local var_6_10 = var_5.insert
				local var_6_11

				if not arg_2_0.loadingIdList then
					var_6_11 = {}
				end

				var_6_10(var_6_11, var_6_9)

				return
			end)

			if var_5_0 == arg_2_0.originIndex then
				triggerButton = var_7

				var_7(arg_5_2)
			end
		end

		return
	end)

	onButton = var_3

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0.cancelBtnTrans

	local function var_2_14()
		local var_15_0 = arg_2_0

		var_0.Hide(var_15_0)

		return
	end

	SFX_CANCEL = var_2_10

	var_3(var_2_12, var_2_13, var_2_14, var_2_10)

	onButton = var_3

	local var_2_15 = arg_2_0
	local var_2_16 = arg_2_0.confirmBtnTrans

	local function var_2_17()
		local var_16_0 = arg_2_0

		var_0.SelectFrame(var_16_0)

		local var_16_1 = arg_2_0

		var_0.Hide(var_16_1)

		return
	end

	SFX_CANCEL = var_2_10

	var_3(var_2_15, var_2_16, var_2_17, var_2_10)

	return
end

function var_0_1.SelectFrame(arg_17_0)
	local var_17_0 = arg_17_0.selectId
	local var_17_1 = arg_17_0.frameDic[arg_17_0.selectId]
	local var_17_2 = var_2.Find(var_17_1, "mask/realImage").anchoredPosition
	local var_17_3 = var_2
	local var_17_4 = var_2.Find(var_17_3, "mask/realImage").localScale
	local var_17_5

	pg = var_17_3

	if var_17_3.island_camera_photo_frame[var_17_0].frameTfName == "IslandFilmFrame" or var_6 == "IslandInsFrame" then
		var_17_5 = {
			upPos = var_2:Find("mask_up/realImage").anchoredPosition,
			upScale = var_2:Find("mask_up/realImage").localScale
		}

		if var_2:Find("mask_down/realImage") then
			var_17_5.downPos = var_2:Find("mask_down/realImage").anchoredPosition
			var_17_5.downScale = var_2:Find("mask_up/realImage").localScale
		end
	end

	existCall = var_7

	var_7(arg_17_0.selectCallback, {
		selectFrameId = var_17_0,
		imagePos = var_17_2,
		imageScale = var_17_4,
		specialPosDic = var_17_5
	})

	return
end

function var_0_1.OnShow(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	arg_18_0.photoData = arg_18_1
	arg_18_0.texture = arg_18_2
	arg_18_0.selectCallback = arg_18_4
	arg_18_0.originIndex = arg_18_3

	local var_18_0 = arg_18_0.frameUIList

	var_5.align(var_18_0, #arg_18_0.frameDataList)

	pg = var_5

	local var_18_1 = var_5.UIMgr.GetInstance()

	var_5.BlurPanel(var_18_1, arg_18_0._tf, {
		staticBlur = true
	})

	return
end

function var_0_1.OnHide(arg_19_0)
	arg_19_0.selectId = nil
	pg = var_1

	local var_19_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_19_0, arg_19_0._tf)

	return
end

function var_0_1.OnDestroy(arg_20_0)
	arg_20_0:OnHide()

	pairs = var_1

	for iter_20_0, iter_20_1 in var_1(arg_20_0.lateFuncDic) do
		LateUpdateBeat = var_1_10006

		var_1_10006:RemoveListener(iter_20_1)
	end

	ipairs = var_1

	for iter_20_2, iter_20_3 in var_1(arg_20_0.specialLateFuncDic) do
		LateUpdateBeat = var_1_10006

		var_1_10006:RemoveListener(iter_20_3)
	end

	ipairs = var_1

	local var_20_0

	if not arg_20_0.loadingIdList then
		var_20_0 = {}
	end

	for iter_20_4, iter_20_5 in var_1(var_20_0) do
		IslandAssetLoadDispatcher = var_1_10006

		local var_20_1 = var_1_10006.Instance

		var_1_10006.Cancel(var_20_1, iter_20_5)
	end

	arg_20_0.loadingIdList = nil

	return
end

return var_0_1
