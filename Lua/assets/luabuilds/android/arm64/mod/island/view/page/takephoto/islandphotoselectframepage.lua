local var_0_0 = class("IslandPhotoSelectFramePage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandPhotoSelectFrameUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.cancelBtnTrans = arg_2_0._tf:Find("cancelBtn")
	arg_2_0.confirmBtnTrans = arg_2_0._tf:Find("selectPage/confirmBtn")
	arg_2_0.frameAdapter = arg_2_0._tf:Find("frameAdapter")

	local var_2_0 = arg_2_0._tf:Find("selectPage/Scroll/Viewport/Content")

	arg_2_0.frameDataList = {}

	if IslandConst.OnlyShowOwnedFrame == true then
		for iter_2_0, iter_2_1 in ipairs(pg.island_camera_photo_frame.all) do
			local var_2_1, var_2_2 = ApartmentProxy.CheckUnlockConfig(pg.island_camera_photo_frame[iter_2_1].unlock)

			if var_2_1 then
				table.insert(arg_2_0.frameDataList, iter_2_1)
			end
		end
	else
		arg_2_0.frameDataList = pg.island_camera_photo_frame.all
	end

	local function var_2_3()
		UIItemList.StaticAlign(var_2_0, var_2_0:GetChild(0), #arg_2_0.frameDataList, function(arg_4_0, arg_4_1, arg_4_2)
			if arg_4_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_4_1 = arg_4_1 + 1

			setActive(arg_4_2:Find("Selected"), arg_2_0.selectId == arg_2_0.frameDataList[arg_4_1])

			return
		end)

		return
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf, {
		staticBlur = true
	})

	arg_2_0.frameDic = {}
	arg_2_0.loadingDic = {}
	arg_2_0.lateFuncDic = {}
	arg_2_0.specialLateFuncDic = {}
	arg_2_0.frameUIList = UIItemList.New(var_2_0, var_2_0:GetChild(0))

	arg_2_0.frameUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			arg_5_1 = arg_5_1 + 1

			local var_5_0 = pg.island_camera_photo_frame[arg_2_0.frameDataList[arg_5_1]]
			local var_5_1 = pg.island_camera_photo_frame[arg_2_0.frameDataList[arg_5_1]].id

			GetImageSpriteFromAtlasAsync(string.format("Island/IslandPhotoFrame/%s", pg.island_camera_photo_frame[arg_2_0.frameDataList[arg_5_1]].farme_small_path), "", arg_5_2:Find("Icon"))
			setActive(arg_5_2:Find("Selected"), false)
			setActive(arg_5_2:Find("lock"), false)

			local var_5_2, var_5_3 = ApartmentProxy.CheckUnlockConfig(pg.island_camera_photo_frame[arg_2_0.frameDataList[arg_5_1]].unlock)

			setActive(arg_5_2:Find("lock"), not var_5_2)

			if not var_5_2 then
				setText(arg_5_2:Find("lock/Image/Text"), pg.island_camera_photo_frame[arg_2_0.frameDataList[arg_5_1]].unlock_text)
			end

			onButton(arg_2_0, arg_5_2, function()
				if not var_5_2 then
					pg.TipsMgr.GetInstance():ShowTips(var_5_3)

					return
				end

				if arg_2_0.selectId == var_5_1 then
					return
				end

				arg_2_0.selectId = var_5_1

				var_2_3()

				local var_6_0 = var_5_0.frameTfName == "IslandFilmFrame"
				local var_6_1 = var_5_0.frameTfName == "IslandInsFrame"

				for iter_6_0, iter_6_1 in pairs(arg_2_0.frameDic) do
					setActive(iter_6_1, false)
				end

				local function var_6_2(arg_7_0)
					local var_7_0 = arg_7_0:Find("mask/realImage")

					var_7_0:GetComponent(typeof(RawImage)).texture = arg_2_0.texture
					var_7_0.sizeDelta = GameObject.Find("OverlayCamera").transform:GetChild(0).sizeDelta

					setAnchoredPosition(var_7_0, {
						x = 0,
						y = 0
					})

					var_7_0.localScale = Vector3(1, 1, 1)

					local var_7_1 = {}

					if var_6_1 then
						table.insert(var_7_1, "mask_up/realImage")
					elseif var_6_0 then
						table.insert(var_7_1, "mask_up/realImage")
						table.insert(var_7_1, "mask_down/realImage")
					end

					for iter_7_0, iter_7_1 in ipairs(var_7_1) do
						local var_7_2 = arg_7_0:Find(iter_7_1)

						var_7_2:GetComponent(typeof(RawImage)).texture = arg_2_0.texture

						local var_7_3 = GameObject.Find("OverlayCamera").transform:GetChild(0)

						var_7_2.sizeDelta = var_6_1 and iter_7_1 == "mask_up/realImage" and Vector2(var_7_3.sizeDelta.x / 10, var_7_3.sizeDelta.y / 10) or var_7_3.sizeDelta

						setAnchoredPosition(var_7_2, {
							x = 0,
							y = 0
						})

						var_7_2.localScale = Vector3(1, 1, 1)
					end

					return
				end

				if arg_2_0.frameDic[arg_2_0.selectId] then
					setActive(arg_2_0.frameDic[arg_2_0.selectId], true)
					;(function(arg_7_0)
						local var_7_0 = arg_7_0:Find("mask/realImage")

						var_7_0:GetComponent(typeof(RawImage)).texture = arg_2_0.texture
						var_7_0.sizeDelta = GameObject.Find("OverlayCamera").transform:GetChild(0).sizeDelta

						setAnchoredPosition(var_7_0, {
							x = 0,
							y = 0
						})

						var_7_0.localScale = Vector3(1, 1, 1)

						local var_7_1 = {}

						if var_6_1 then
							table.insert(var_7_1, "mask_up/realImage")
						elseif var_6_0 then
							table.insert(var_7_1, "mask_up/realImage")
							table.insert(var_7_1, "mask_down/realImage")
						end

						for iter_7_0, iter_7_1 in ipairs(var_7_1) do
							local var_7_2 = arg_7_0:Find(iter_7_1)

							var_7_2:GetComponent(typeof(RawImage)).texture = arg_2_0.texture

							local var_7_3 = GameObject.Find("OverlayCamera").transform:GetChild(0)

							var_7_2.sizeDelta = var_6_1 and iter_7_1 == "mask_up/realImage" and Vector2(var_7_3.sizeDelta.x / 10, var_7_3.sizeDelta.y / 10) or var_7_3.sizeDelta

							setAnchoredPosition(var_7_2, {
								x = 0,
								y = 0
							})

							var_7_2.localScale = Vector3(1, 1, 1)
						end

						return
					end)(arg_2_0.frameDic[arg_2_0.selectId])

					return
				end

				if arg_2_0.loadingDic[arg_5_1] then
					return
				end

				arg_2_0.loadingDic[arg_5_1] = true

				local var_6_3 = arg_2_0.loadingIdList or {}

				table.insert(var_6_3, (IslandAssetLoadDispatcher.Instance:Enqueue("ui/" .. var_5_0.frameTfName, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_8_0)
					arg_2_0.loadingDic[arg_5_1] = false

					local var_8_0 = Object.Instantiate(arg_8_0, arg_2_0.frameAdapter).transform

					arg_2_0.frameDic[var_5_1] = var_8_0

					local var_8_1 = {
						"mask/realImage"
					}
					local var_8_2 = {
						"mask"
					}

					if var_6_1 then
						table.insert({
							"mask/realImage"
						}, "mask_up/realImage")
						table.insert({
							"mask"
						}, "mask_up")
					elseif var_6_0 then
						table.insert({
							"mask/realImage"
						}, "mask_up/realImage")
						table.insert({
							"mask/realImage"
						}, "mask_down/realImage")
						table.insert({
							"mask"
						}, "mask_up")
						table.insert({
							"mask"
						}, "mask_down")
					end

					;(function()
						for iter_9_0, iter_9_1 in ipairs(var_8_1) do
							local var_9_0 = var_8_0:Find(iter_9_1)
							local var_9_1 = GetOrAddComponent(var_8_0:Find(iter_9_1), "PinchZoom")
							local var_9_2 = GetOrAddComponent(var_8_0:Find(iter_9_1), "EventTriggerListener")
							local var_9_3 = true

							var_9_2:AddPointDownFunc(function(arg_10_0)
								if Input.touchCount == 1 or IsUnityEditor then
									var_9_3 = true
								elseif Input.touchCount >= 2 then
									var_9_3 = false
								end

								return
							end)
							var_9_2:AddPointUpFunc(function(arg_11_0)
								if Input.touchCount <= 2 then
									var_9_3 = true
								end

								return
							end)

							local var_9_4 = GameObject.Find("OverlayCamera").transform
							local var_9_5 = var_9_4:GetChild(0).sizeDelta

							if var_6_1 and iter_9_1 == "mask_up/realImage" then
								var_9_5 = Vector2(var_9_5.x / 10, var_9_5.y / 10)
							end

							local var_9_6 = var_8_0:Find(var_8_2[iter_9_0]).sizeDelta

							var_9_2:AddBeginDragFunc(function(arg_12_0, arg_12_1)
								touchOffsetX = arg_12_1.position.x - var_9_0.localPosition.x
								touchOffsetY = arg_12_1.position.y - var_9_0.localPosition.y

								return
							end)

							local var_9_7 = math.max(var_9_6.x / var_9_5.x, var_9_6.y / var_9_5.y)
							local var_9_8 = LateUpdateBeat:CreateListener(function()
								if var_9_1.processing then
									local var_13_0 = var_9_0.localScale

									if var_9_0.localScale.x < var_9_7 then
										var_9_0.localScale = Vector3(var_9_7, var_9_7, var_13_0.z)
										var_13_0 = var_9_0.localScale
									end

									var_9_0.localPosition = Vector3(math.clamp(var_9_0.localPosition.x, -((var_9_5.x * var_13_0.x - var_9_6.x) / 2), (var_9_5.x * var_13_0.x - var_9_6.x) / 2), math.clamp(var_9_0.localPosition.y, -((var_9_5.y * var_13_0.x - var_9_6.y) / 2), (var_9_5.y * var_13_0.x - var_9_6.y) / 2), 1)
								end

								return
							end, arg_2_0)

							LateUpdateBeat:AddListener(var_9_8)

							if var_6_0 or var_6_1 then
								table.insert(arg_2_0.specialLateFuncDic, var_9_8)
							else
								arg_2_0.lateFuncDic[arg_5_1] = var_9_8
							end

							var_9_2:AddDragFunc(function(arg_14_0, arg_14_1)
								if var_9_1.processing then
									return
								end

								if var_9_3 then
									var_9_0.localPosition = Vector3(math.clamp(arg_14_1.position.x - touchOffsetX, -((var_9_5.x * var_9_0.localScale.x - var_9_6.x) / 2), (var_9_5.x * var_9_0.localScale.x - var_9_6.x) / 2), math.clamp(arg_14_1.position.y - touchOffsetY, -((var_9_5.y * var_9_0.localScale.x - var_9_6.y) / 2), (var_9_5.y * var_9_0.localScale.x - var_9_6.y) / 2), 1)
								end

								return
							end)
						end

						return
					end)()

					if arg_2_0.selectId == var_5_1 then
						var_6_2(var_8_0)
					else
						setActive(var_8_0, false)
					end

					return
				end), true, true)))

				return
			end)

			if pg.island_camera_photo_frame[arg_2_0.frameDataList[arg_5_1]].id == arg_2_0.originIndex then
				triggerButton(arg_5_2)
			end
		end

		return
	end)
	onButton(arg_2_0, arg_2_0.cancelBtnTrans, function()
		arg_2_0:Hide()

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0.confirmBtnTrans, function()
		arg_2_0:SelectFrame()
		arg_2_0:Hide()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.SelectFrame(arg_17_0)
	local var_17_0 = arg_17_0.frameDic[arg_17_0.selectId]:Find("mask/realImage").anchoredPosition
	local var_17_1 = arg_17_0.frameDic[arg_17_0.selectId]:Find("mask/realImage").localScale
	local var_17_2

	if pg.island_camera_photo_frame[arg_17_0.selectId].frameTfName == "IslandFilmFrame" or pg.island_camera_photo_frame[arg_17_0.selectId].frameTfName == "IslandInsFrame" then
		var_17_2 = {
			upPos = arg_17_0.frameDic[arg_17_0.selectId]:Find("mask_up/realImage").anchoredPosition,
			upScale = arg_17_0.frameDic[arg_17_0.selectId]:Find("mask_up/realImage").localScale
		}

		if arg_17_0.frameDic[arg_17_0.selectId]:Find("mask_down/realImage") then
			var_17_2.downPos = arg_17_0.frameDic[arg_17_0.selectId]:Find("mask_down/realImage").anchoredPosition
			var_17_2.downScale = arg_17_0.frameDic[arg_17_0.selectId]:Find("mask_up/realImage").localScale
		end
	end

	existCall(arg_17_0.selectCallback, {
		selectFrameId = arg_17_0.selectId,
		imagePos = var_17_0,
		imageScale = var_17_1,
		specialPosDic = var_17_2
	})

	return
end

function var_0_0.OnShow(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	arg_18_0.photoData = arg_18_1
	arg_18_0.texture = arg_18_2
	arg_18_0.selectCallback = arg_18_4
	arg_18_0.originIndex = arg_18_3

	arg_18_0.frameUIList:align(#arg_18_0.frameDataList)
	pg.UIMgr.GetInstance():BlurPanel(arg_18_0._tf, {
		staticBlur = true
	})

	return
end

function var_0_0.OnHide(arg_19_0)
	arg_19_0.selectId = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_19_0._tf)

	return
end

function var_0_0.OnDestroy(arg_20_0)
	arg_20_0:OnHide()

	for iter_20_0, iter_20_1 in pairs(arg_20_0.lateFuncDic) do
		LateUpdateBeat:RemoveListener(iter_20_1)
	end

	for iter_20_2, iter_20_3 in ipairs(arg_20_0.specialLateFuncDic) do
		LateUpdateBeat:RemoveListener(iter_20_3)
	end

	local var_20_0 = arg_20_0.loadingIdList or {}

	for iter_20_4, iter_20_5 in ipairs(var_20_0) do
		IslandAssetLoadDispatcher.Instance:Cancel(iter_20_5)
	end

	arg_20_0.loadingIdList = nil

	return
end

return var_0_0
