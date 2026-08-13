class = var_0_10000

local var_0_0 = "Dorm3dPhotoSelectFrame"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dPhotoSelectfFrameUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.cancelBtnTrans = var_1.Find(var_2_0, "cancelBtn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.confirmBtnTrans = var_1.Find(var_2_1, "selectPage/confirmBtn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.frameAdapter = var_1.Find(var_2_2, "frameAdapter")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "selectPage/Scroll/Viewport/Content")

	pg = var_1_10002

	local var_2_5 = var_1_10002.dorm3d_camera_photo_frame.all

	local function var_2_6()
		UIItemList = var_2_10000

		local var_3_0 = var_2_10000.StaticAlign
		local var_3_1 = var_2_4
		local var_3_2 = var_2_4

		var_3_0(var_3_1, var_3.GetChild(var_3_2, 0), #var_2_5, function(arg_4_0, arg_4_1, arg_4_2)
			UIItemList = var_3_10003

			if arg_4_0 ~= var_3_10003.EventUpdate then
				return
			end

			arg_4_1 = arg_4_1 + 1
			setActive = var_3

			var_3(arg_4_2:Find("Selected"), arg_2_0.selectIndex == arg_4_1)

			return
		end)

		return
	end

	pg = var_4

	local var_2_7 = var_4.UIMgr.GetInstance()

	var_4.BlurPanel(var_2_7, arg_2_0._tf, {
		staticBlur = true
	})

	arg_2_0.frameDic = {}
	arg_2_0.loadingDic = {}
	arg_2_0.lateFuncDic = {}
	arg_2_0.specialLateFuncDic = {}
	UIItemList = var_4

	var_4.StaticAlign(var_2_4, var_2_4:GetChild(0), #var_2_5, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_5_1 = arg_5_1 + 1
		pg = var_3

		local var_5_0 = var_3.dorm3d_camera_photo_frame[var_2_5[arg_5_1]]

		GetImageSpriteFromAtlasAsync = var_4
		string = var_2_10006

		var_4(var_2_10006.format("Dorm3DPhoto/%s", var_5_0.farme_small_path), "", arg_5_2:Find("Icon"))

		setActive = var_4

		var_4(arg_5_2:Find("Selected"), false)

		ApartmentProxy = var_4

		local var_5_1, var_5_2 = var_4.CheckUnlockConfig(var_5_0.unlock)

		setActive = var_6

		var_6(arg_5_2:Find("lock"), not var_5_1)

		if not var_5_1 then
			setText = var_6

			var_6(arg_5_2:Find("lock/Image/Text"), var_5_0.unlock_text)
		end

		onButton = var_6

		var_6(arg_2_0, arg_5_2, function()
			if not var_5_1 then
				pg = var_0
				var_3_10002 = var_0.TipsMgr.GetInstance()

				var_0.ShowTips(var_3_10002, var_5_2)

				return
			end

			if arg_2_0.selectIndex == arg_5_1 then
				return
			end

			arg_2_0.selectIndex = arg_5_1

			var_2_6()

			local var_6_0 = var_5_0.frameTfName == "FilmFrame"
			local var_6_1 = var_5_0.frameTfName == "InsFrame"

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
				var_7_1(var_7_0, var_4_10005(var_4_10007)).texture = arg_2_0.contextData.photoTex
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
					var_7_5(var_7_4, var_4_10014(var_4_10016)).texture = arg_2_0.contextData.photoTex
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

			if arg_2_0.frameDic[arg_2_0.selectIndex] then
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
			ResourceMgr = var_6_3

			local var_6_4 = var_6_3.Inst
			local var_6_5 = var_4.getAssetAsync
			local var_6_6 = "ui/" .. var_5_0.frameTfName
			local var_6_7 = ""

			UnityEngine = var_3_10009

			var_6_5(var_6_4, var_6_6, var_6_7, var_3_10009.Events.UnityAction_UnityEngine_Object(function(arg_8_0)
				local var_8_0 = arg_2_0.loadingDic

				var_8_0[arg_5_1] = false
				Object = var_8_0

				local var_8_1 = var_8_0.Instantiate(arg_8_0, arg_2_0.frameAdapter).transform

				arg_2_0.frameDic[arg_5_1] = var_8_1

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

				if arg_2_0.selectIndex == arg_5_1 then
					var_6_2(var_8_1)
				else
					setActive = var_5

					var_5(var_8_1, false)
				end

				return
			end), true, true)

			return
		end)

		if arg_5_1 == 1 then
			triggerButton = var_6

			var_6(arg_5_2)
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_15_0)
	onButton = var_1_10001

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.cancelBtnTrans

	local function var_15_2()
		local var_16_0 = arg_15_0

		var_0.closeView(var_16_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_15_0, var_15_1, var_15_2, var_1_10006)

	onButton = var_1_10001

	local var_15_3 = arg_15_0
	local var_15_4 = arg_15_0.confirmBtnTrans

	local function var_15_5()
		local var_17_0 = arg_15_0

		var_0.SelectFrame(var_17_0)

		local var_17_1 = arg_15_0

		var_0.closeView(var_17_1)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_15_3, var_15_4, var_15_5, var_1_10006)

	return
end

function var_0_1.SelectFrame(arg_18_0)
	pg = var_1_10001

	local var_18_0 = var_1_10001.dorm3d_camera_photo_frame.all[arg_18_0.selectIndex]
	local var_18_1 = arg_18_0.frameDic[arg_18_0.selectIndex]
	local var_18_2 = var_2.Find(var_18_1, "mask/realImage").anchoredPosition
	local var_18_3 = var_2
	local var_18_4 = var_2.Find(var_18_3, "mask/realImage").localScale
	local var_18_5

	pg = var_18_3

	if var_18_3.dorm3d_camera_photo_frame[var_18_0].frameTfName == "FilmFrame" or var_6 == "InsFrame" then
		var_18_5 = {
			upPos = var_2:Find("mask_up/realImage").anchoredPosition,
			upScale = var_2:Find("mask_up/realImage").localScale
		}

		if var_2:Find("mask_down/realImage") then
			var_18_5.downPos = var_2:Find("mask_down/realImage").anchoredPosition
			var_18_5.downScale = var_2:Find("mask_up/realImage").localScale
		end
	end

	local var_18_6 = arg_18_0
	local var_18_7 = arg_18_0.emit

	Dorm3dPhotoSelectFrameMediator = var_1_10010

	var_18_7(var_18_6, var_1_10010.CONFIRMFRAME, var_18_0, var_18_2, var_18_4, var_18_5)

	return
end

function var_0_1.willExit(arg_19_0)
	pg = var_1_10001

	local var_19_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_19_0, arg_19_0._tf)

	pairs = var_1

	for iter_19_0, iter_19_1 in var_1(arg_19_0.lateFuncDic) do
		LateUpdateBeat = var_1_10006

		var_1_10006:RemoveListener(iter_19_1)
	end

	ipairs = var_1

	for iter_19_2, iter_19_3 in var_1(arg_19_0.specialLateFuncDic) do
		LateUpdateBeat = var_1_10006

		var_1_10006:RemoveListener(iter_19_3)
	end

	return
end

return var_0_1
