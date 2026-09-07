local IslandPhotoSelectFramePage = class("IslandPhotoSelectFramePage", import("...base.IslandBasePage"))

function IslandPhotoSelectFramePage:getUIName()
	return "IslandPhotoSelectFrameUI"
end

function IslandPhotoSelectFramePage:OnInit()
	self.cancelBtnTrans = self._tf:Find("cancelBtn")
	self.confirmBtnTrans = self._tf:Find("selectPage/confirmBtn")
	self.frameAdapter = self._tf:Find("frameAdapter")

	local var_2_0 = self._tf:Find("selectPage/Scroll/Viewport/Content")

	self.frameDataList = {}

	if IslandConst.OnlyShowOwnedFrame == true then
		for iter_2_0, iter_2_1 in ipairs(pg.island_camera_photo_frame.all) do
			local var_2_1, var_2_2 = ApartmentProxy.CheckUnlockConfig(pg.island_camera_photo_frame[iter_2_1].unlock)

			if var_2_1 then
				table.insert(self.frameDataList, iter_2_1)
			end
		end
	else
		self.frameDataList = pg.island_camera_photo_frame.all
	end

	local function var_2_3()
		UIItemList.StaticAlign(var_2_0, var_2_0:GetChild(0), #self.frameDataList, function(arg_4_0, arg_4_1, arg_4_2)
			if arg_4_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_4_1 = arg_4_1 + 1

			setActive(arg_4_2:Find("Selected"), self.selectId == self.frameDataList[arg_4_1])

			return
		end)

		return
	end

	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		staticBlur = true
	})

	self.frameDic = {}
	self.loadingDic = {}
	self.lateFuncDic = {}
	self.specialLateFuncDic = {}
	self.frameUIList = UIItemList.New(var_2_0, var_2_0:GetChild(0))

	self.frameUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			arg_5_1 = arg_5_1 + 1

			local var_5_0 = pg.island_camera_photo_frame[self.frameDataList[arg_5_1]]
			local var_5_1 = pg.island_camera_photo_frame[self.frameDataList[arg_5_1]].id

			GetImageSpriteFromAtlasAsync(string.format("Island/IslandPhotoFrame/%s", pg.island_camera_photo_frame[self.frameDataList[arg_5_1]].farme_small_path), "", arg_5_2:Find("Icon"))
			setActive(arg_5_2:Find("Selected"), false)
			setActive(arg_5_2:Find("lock"), false)

			local var_5_2, var_5_3 = ApartmentProxy.CheckUnlockConfig(pg.island_camera_photo_frame[self.frameDataList[arg_5_1]].unlock)

			setActive(arg_5_2:Find("lock"), not var_5_2)

			if not var_5_2 then
				setText(arg_5_2:Find("lock/Image/Text"), pg.island_camera_photo_frame[self.frameDataList[arg_5_1]].unlock_text)
			end

			onButton(self, arg_5_2, function()
				if not var_5_2 then
					pg.TipsMgr.GetInstance():ShowTips(var_5_3)

					return
				end

				if self.selectId == var_5_1 then
					return
				end

				self.selectId = var_5_1

				var_2_3()

				local var_6_0 = var_5_0.frameTfName == "IslandFilmFrame"
				local var_6_1 = var_5_0.frameTfName == "IslandInsFrame"

				for iter_6_0, iter_6_1 in pairs(self.frameDic) do
					setActive(iter_6_1, false)
				end

				local function var_6_2(arg_7_0)
					local var_7_0 = arg_7_0:Find("mask/realImage")

					var_7_0:GetComponent(typeof(RawImage)).texture = self.texture
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

						var_7_2:GetComponent(typeof(RawImage)).texture = self.texture

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

				if self.frameDic[self.selectId] then
					setActive(self.frameDic[self.selectId], true)
					var_6_2(self.frameDic[self.selectId])

					return
				end

				if self.loadingDic[arg_5_1] then
					return
				end

				self.loadingDic[arg_5_1] = true

				table.insert(self.loadingIdList or {}, (IslandAssetLoadDispatcher.Instance:Enqueue("ui/" .. var_5_0.frameTfName, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_8_0)
					self.loadingDic[arg_5_1] = false

					local var_8_0 = Object.Instantiate(arg_8_0, self.frameAdapter).transform

					self.frameDic[var_5_1] = var_8_0

					local var_8_1 = {
						"mask/realImage"
					}
					local var_8_2 = {
						"mask"
					}

					if var_6_1 then
						table.insert(var_8_1, "mask_up/realImage")
						table.insert(var_8_2, "mask_up")
					elseif var_6_0 then
						table.insert(var_8_1, "mask_up/realImage")
						table.insert(var_8_1, "mask_down/realImage")
						table.insert(var_8_2, "mask_up")
						table.insert(var_8_2, "mask_down")
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

							local var_9_4 = GameObject.Find("OverlayCamera").transform:GetChild(0).sizeDelta

							if var_6_1 and iter_9_1 == "mask_up/realImage" then
								var_9_4 = Vector2(var_9_4.x / 10, var_9_4.y / 10)
							end

							local var_9_5 = var_8_0:Find(var_8_2[iter_9_0]).sizeDelta

							var_9_2:AddBeginDragFunc(function(arg_12_0, arg_12_1)
								touchOffsetX = arg_12_1.position.x - var_9_0.localPosition.x
								touchOffsetY = arg_12_1.position.y - var_9_0.localPosition.y

								return
							end)

							local var_9_6 = math.max(var_9_5.x / var_9_4.x, var_9_5.y / var_9_4.y)
							local var_9_7 = LateUpdateBeat:CreateListener(function()
								if var_9_1.processing then
									local var_13_0 = var_9_0.localScale

									if var_9_0.localScale.x < var_9_6 then
										var_9_0.localScale = Vector3(var_9_6, var_9_6, var_13_0.z)
										var_13_0 = var_9_0.localScale
									end

									var_9_0.localPosition = Vector3(math.clamp(var_9_0.localPosition.x, -((var_9_4.x * var_13_0.x - var_9_5.x) / 2), (var_9_4.x * var_13_0.x - var_9_5.x) / 2), math.clamp(var_9_0.localPosition.y, -((var_9_4.y * var_13_0.x - var_9_5.y) / 2), (var_9_4.y * var_13_0.x - var_9_5.y) / 2), 1)
								end

								return
							end, self)

							LateUpdateBeat:AddListener(var_9_7)

							if var_6_0 or var_6_1 then
								table.insert(self.specialLateFuncDic, var_9_7)
							else
								self.lateFuncDic[arg_5_1] = var_9_7
							end

							var_9_2:AddDragFunc(function(arg_14_0, arg_14_1)
								if var_9_1.processing then
									return
								end

								if var_9_3 then
									var_9_0.localPosition = Vector3(math.clamp(arg_14_1.position.x - touchOffsetX, -((var_9_4.x * var_9_0.localScale.x - var_9_5.x) / 2), (var_9_4.x * var_9_0.localScale.x - var_9_5.x) / 2), math.clamp(arg_14_1.position.y - touchOffsetY, -((var_9_4.y * var_9_0.localScale.x - var_9_5.y) / 2), (var_9_4.y * var_9_0.localScale.x - var_9_5.y) / 2), 1)
								end

								return
							end)
						end

						return
					end)()

					if self.selectId == var_5_1 then
						var_6_2(var_8_0)
					else
						setActive(var_8_0, false)
					end

					return
				end), true, true)))

				return
			end)

			if pg.island_camera_photo_frame[self.frameDataList[arg_5_1]].id == self.originIndex then
				triggerButton(arg_5_2)
			end
		end

		return
	end)
	onButton(self, self.cancelBtnTrans, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self.confirmBtnTrans, function()
		self:SelectFrame()
		self:Hide()

		return
	end, SFX_CANCEL)

	return
end

function IslandPhotoSelectFramePage:SelectFrame()
	local var_17_0 = self.frameDic[self.selectId]:Find("mask/realImage").anchoredPosition
	local var_17_1 = self.frameDic[self.selectId]:Find("mask/realImage").localScale
	local var_17_2

	if pg.island_camera_photo_frame[self.selectId].frameTfName == "IslandFilmFrame" or pg.island_camera_photo_frame[self.selectId].frameTfName == "IslandInsFrame" then
		var_17_2 = {
			upPos = self.frameDic[self.selectId]:Find("mask_up/realImage").anchoredPosition,
			upScale = self.frameDic[self.selectId]:Find("mask_up/realImage").localScale
		}

		if self.frameDic[self.selectId]:Find("mask_down/realImage") then
			var_17_2.downPos = self.frameDic[self.selectId]:Find("mask_down/realImage").anchoredPosition
			var_17_2.downScale = self.frameDic[self.selectId]:Find("mask_up/realImage").localScale
		end
	end

	existCall(self.selectCallback, {
		selectFrameId = self.selectId,
		imagePos = var_17_0,
		imageScale = var_17_1,
		specialPosDic = var_17_2
	})

	return
end

function IslandPhotoSelectFramePage:OnShow(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	self.photoData = arg_18_1
	self.texture = arg_18_2
	self.selectCallback = arg_18_4
	self.originIndex = arg_18_3

	self.frameUIList:align(#self.frameDataList)
	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		staticBlur = true
	})

	return
end

function IslandPhotoSelectFramePage:OnHide()
	self.selectId = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function IslandPhotoSelectFramePage:OnDestroy()
	self:OnHide()

	for iter_20_0, iter_20_1 in pairs(self.lateFuncDic) do
		LateUpdateBeat:RemoveListener(iter_20_1)
	end

	for iter_20_2, iter_20_3 in ipairs(self.specialLateFuncDic) do
		LateUpdateBeat:RemoveListener(iter_20_3)
	end

	for iter_20_4, iter_20_5 in ipairs(self.loadingIdList or {}) do
		IslandAssetLoadDispatcher.Instance:Cancel(iter_20_5)
	end

	self.loadingIdList = nil

	return
end

return IslandPhotoSelectFramePage
