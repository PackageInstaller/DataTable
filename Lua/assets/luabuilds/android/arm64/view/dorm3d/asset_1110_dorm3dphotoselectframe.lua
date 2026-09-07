local Dorm3dPhotoSelectFrame = class("Dorm3dPhotoSelectFrame", import("view.base.BaseUI"))

function Dorm3dPhotoSelectFrame:getUIName()
	return "Dorm3dPhotoSelectfFrameUI"
end

function Dorm3dPhotoSelectFrame:init()
	self.cancelBtnTrans = self._tf:Find("cancelBtn")
	self.confirmBtnTrans = self._tf:Find("selectPage/confirmBtn")
	self.frameAdapter = self._tf:Find("frameAdapter")

	local var_2_0 = self._tf:Find("selectPage/Scroll/Viewport/Content")
	local var_2_1 = pg.dorm3d_camera_photo_frame.all

	local function var_2_2()
		UIItemList.StaticAlign(var_2_0, var_2_0:GetChild(0), #var_2_1, function(arg_4_0, arg_4_1, arg_4_2)
			if arg_4_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_4_1 = arg_4_1 + 1

			setActive(arg_4_2:Find("Selected"), self.selectIndex == arg_4_1)

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

	UIItemList.StaticAlign(var_2_0, var_2_0:GetChild(0), #pg.dorm3d_camera_photo_frame.all, function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_5_1 = arg_5_1 + 1

		local var_5_0 = pg.dorm3d_camera_photo_frame[var_2_1[arg_5_1]]

		GetImageSpriteFromAtlasAsync(string.format("Dorm3DPhoto/%s", pg.dorm3d_camera_photo_frame[var_2_1[arg_5_1]].farme_small_path), "", arg_5_2:Find("Icon"))
		setActive(arg_5_2:Find("Selected"), false)

		local var_5_1, var_5_2 = ApartmentProxy.CheckUnlockConfig(pg.dorm3d_camera_photo_frame[var_2_1[arg_5_1]].unlock)

		setActive(arg_5_2:Find("lock"), not var_5_1)

		if not var_5_1 then
			setText(arg_5_2:Find("lock/Image/Text"), pg.dorm3d_camera_photo_frame[var_2_1[arg_5_1]].unlock_text)
		end

		onButton(self, arg_5_2, function()
			if not var_5_1 then
				pg.TipsMgr.GetInstance():ShowTips(var_5_2)

				return
			end

			if self.selectIndex == arg_5_1 then
				return
			end

			self.selectIndex = arg_5_1

			var_2_2()

			local var_6_0 = var_5_0.frameTfName == "FilmFrame"
			local var_6_1 = var_5_0.frameTfName == "InsFrame"

			for iter_6_0, iter_6_1 in pairs(self.frameDic) do
				setActive(iter_6_1, false)
			end

			local function var_6_2(arg_7_0)
				local var_7_0 = arg_7_0:Find("mask/realImage")

				var_7_0:GetComponent(typeof(RawImage)).texture = self.contextData.photoTex
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

					var_7_2:GetComponent(typeof(RawImage)).texture = self.contextData.photoTex

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

			if self.frameDic[self.selectIndex] then
				setActive(self.frameDic[self.selectIndex], true)
				var_6_2(self.frameDic[self.selectIndex])

				return
			end

			if self.loadingDic[arg_5_1] then
				return
			end

			self.loadingDic[arg_5_1] = true

			ResourceMgr.Inst:getAssetAsync("ui/" .. var_5_0.frameTfName, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_8_0)
				self.loadingDic[arg_5_1] = false

				local var_8_0 = Object.Instantiate(arg_8_0, self.frameAdapter).transform

				self.frameDic[arg_5_1] = var_8_0

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

				if self.selectIndex == arg_5_1 then
					var_6_2(var_8_0)
				else
					setActive(var_8_0, false)
				end

				return
			end), true, true)

			return
		end)

		if arg_5_1 == 1 then
			triggerButton(arg_5_2)
		end

		return
	end)

	return
end

function Dorm3dPhotoSelectFrame:didEnter()
	onButton(self, self.cancelBtnTrans, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.confirmBtnTrans, function()
		self:SelectFrame()
		self:closeView()

		return
	end, SFX_CANCEL)

	return
end

function Dorm3dPhotoSelectFrame:SelectFrame()
	local var_18_0 = pg.dorm3d_camera_photo_frame.all[self.selectIndex]
	local var_18_1 = self.frameDic[self.selectIndex]:Find("mask/realImage").anchoredPosition
	local var_18_2 = self.frameDic[self.selectIndex]:Find("mask/realImage").localScale
	local var_18_3

	if pg.dorm3d_camera_photo_frame[pg.dorm3d_camera_photo_frame.all[self.selectIndex]].frameTfName == "FilmFrame" or pg.dorm3d_camera_photo_frame[pg.dorm3d_camera_photo_frame.all[self.selectIndex]].frameTfName == "InsFrame" then
		var_18_3 = {
			upPos = self.frameDic[self.selectIndex]:Find("mask_up/realImage").anchoredPosition,
			upScale = self.frameDic[self.selectIndex]:Find("mask_up/realImage").localScale
		}

		if self.frameDic[self.selectIndex]:Find("mask_down/realImage") then
			var_18_3.downPos = self.frameDic[self.selectIndex]:Find("mask_down/realImage").anchoredPosition
			var_18_3.downScale = self.frameDic[self.selectIndex]:Find("mask_up/realImage").localScale
		end
	end

	self:emit(Dorm3dPhotoSelectFrameMediator.CONFIRMFRAME, var_18_0, var_18_1, var_18_2, var_18_3)

	return
end

function Dorm3dPhotoSelectFrame:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	for iter_19_0, iter_19_1 in pairs(self.lateFuncDic) do
		LateUpdateBeat:RemoveListener(iter_19_1)
	end

	for iter_19_2, iter_19_3 in ipairs(self.specialLateFuncDic) do
		LateUpdateBeat:RemoveListener(iter_19_3)
	end

	return
end

return Dorm3dPhotoSelectFrame
