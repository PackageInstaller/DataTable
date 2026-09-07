local Dorm3dPhotoShareLayer = class("Dorm3dPhotoShareLayer", import("view.base.BaseUI"))

function Dorm3dPhotoShareLayer:getUIName()
	return "Dorm3dPhotoShareUI"
end

function Dorm3dPhotoShareLayer:init()
	self.photoImgTrans = self._tf:Find("PhotoImg")
	self.shareBtnTrans = self._tf:Find("ShareBtn")
	self.confirmBtnTrans = self._tf:Find("ConfirmBtn")
	self.cancelBtnTrans = self._tf:Find("CancelBtn")
	self.frameBtn = self._tf:Find("frameBtn")
	self.photoAdapter = self._tf:Find("photoAdapter")
	self.bytes = self.contextData.photoData
	self.frameDic = {}
	self.loadingDic = {}

	self:InitFrame()

	return
end

function Dorm3dPhotoShareLayer:didEnter()
	onButton(self, self.shareBtnTrans, function()
		if self.frameDic[self.selectFrameId] then
			pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeDorm3dPhoto, nil, nil, true, self.frameDic[self.selectFrameId]:Find("frame").sizeDelta, pg.dorm3d_camera_photo_frame[self.selectFrameId].watermark_location)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtnTrans, function()
		if self.frameDic[self.selectFrameId] then
			local var_5_0 = pg.ShareMgr.GetInstance()
			local var_5_1 = self.frameDic[self.selectFrameId]:Find("frame").sizeDelta

			if pg.dorm3d_camera_photo_frame[self.selectFrameId].frameTfName == "WoodFrame" then
				local var_5_2 = self.frameDic[self.selectFrameId]:Find("frame"):GetComponent("Image").sprite
				local var_5_3 = UnityEngine.Texture2D.New(var_5_2.rect.width, var_5_2.rect.height)

				var_5_3:SetPixels((Object.Instantiate(var_5_2.texture):GetPixels(0, 0, var_5_2.rect.width, var_5_2.rect.height)))
				var_5_3:Apply()
				self:TakePhoto(pg.ShareMgr.TypeDorm3dPhoto, var_5_1, var_5_3, self.frameDic[self.selectFrameId]:Find("mask").sizeDelta)
			else
				self:TakePhoto(pg.ShareMgr.TypeDorm3dPhoto, var_5_1)
			end
		end

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Mask"), function()
		self:closeView()

		return
	end)
	onButton(self, self.cancelBtnTrans, function()
		self:emit(Dorm3dPhotoShareLayerMediator.EXIT_SHARE)
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.frameBtn, function()
		self:emit(Dorm3dPhotoShareLayerMediator.SELECTFRAME, self.contextData.photoTex, self.contextData.photoData)

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		staticBlur = true
	})

	return
end

function Dorm3dPhotoShareLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function Dorm3dPhotoShareLayer:exit()
	Dorm3dPhotoShareLayer.super.exit(self)

	return
end

function Dorm3dPhotoShareLayer:AfterSelectFrame(arg_11_1)
	self.selectFrameId = arg_11_1.selectFrameId

	for iter_11_0, iter_11_1 in pairs(self.frameDic) do
		setActive(iter_11_1, false)
	end

	self:LoadFrame(arg_11_1.imagePos, arg_11_1.imageScale, arg_11_1.specialPosDic)

	return
end

function Dorm3dPhotoShareLayer:InitFrame()
	self.selectFrameId = 1001

	self:LoadFrame({
		0,
		0
	})

	return
end

function Dorm3dPhotoShareLayer:LoadFrame(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = pg.dorm3d_camera_photo_frame[self.selectFrameId]
	local var_13_1 = pg.dorm3d_camera_photo_frame[self.selectFrameId].frameTfName == "FilmFrame"
	local var_13_2 = pg.dorm3d_camera_photo_frame[self.selectFrameId].frameTfName == "InsFrame"

	local function var_13_3(arg_14_0)
		local var_14_0 = arg_14_0:Find("mask/realImage")
		local var_14_1 = var_14_0:GetComponent(typeof(RawImage))

		var_14_1.texture = self.contextData.photoTex
		var_14_0.sizeDelta = GameObject.Find("OverlayCamera").transform:GetChild(0).sizeDelta

		setAnchoredPosition(var_14_1, {
			x = arg_13_1.x,
			y = arg_13_1.y
		})

		if arg_13_2 then
			var_14_0.localScale = arg_13_2
		end

		if arg_13_3 then
			local var_14_2 = {
				"mask_up/realImage"
			}

			if var_13_1 then
				table.insert(var_14_2, "mask_down/realImage")
			end

			local var_14_3 = {
				"upPos",
				"downPos"
			}
			local var_14_4 = {
				"upScale",
				"downScale"
			}

			for iter_14_0, iter_14_1 in ipairs(var_14_2) do
				local var_14_5 = arg_14_0:Find(iter_14_1)
				local var_14_6 = var_14_5:GetComponent(typeof(RawImage))

				var_14_6.texture = self.contextData.photoTex

				local var_14_7 = GameObject.Find("OverlayCamera").transform:GetChild(0)

				if var_13_2 and iter_14_1 == "mask_up/realImage" then
					var_14_5.sizeDelta = Vector2(var_14_7.sizeDelta.x / 10, var_14_7.sizeDelta.y / 10)
				end

				local var_14_9

				do
					var_14_5.sizeDelta = var_14_7.sizeDelta
					var_14_9 = {
						x = arg_13_3[var_14_3[iter_14_0]].x
					}
				end

				var_14_9.y = arg_13_3[var_14_3[iter_14_0]].y

				setAnchoredPosition(var_14_6, var_14_9)

				if arg_13_3[var_14_4[iter_14_0]] then
					var_14_5.localScale = arg_13_3[var_14_4[iter_14_0]]
				end
			end
		end

		return
	end

	if self.frameDic[self.selectFrameId] then
		setActive(self.frameDic[self.selectFrameId], true)
		var_13_3(self.frameDic[self.selectFrameId])

		return
	end

	if self.loadingDic[self.selectFrameId] then
		return
	end

	local var_13_4 = self.selectFrameId

	ResourceMgr.Inst:getAssetAsync("ui/" .. var_13_0.frameTfName, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_15_0)
		self.loadingDic[var_13_4] = false

		local var_15_0 = Object.Instantiate(arg_15_0, self.photoAdapter).transform

		self.frameDic[var_13_4] = var_15_0

		if self.selectFrameId == var_13_4 then
			var_13_3(var_15_0)
		else
			setActive(var_15_0, false)
		end

		var_15_0:Find("mask/realImage"):GetComponent(typeof(ScrollRect)).enabled = false
		var_15_0:Find("mask/realImage"):GetComponent(typeof(PinchZoom)).enabled = false

		local var_15_1 = var_15_0:Find("mask_up/realImage")
		local var_15_2 = var_15_0:Find("mask_down/realImage")

		if var_15_1 then
			var_15_1:GetComponent(typeof(PinchZoom)).enabled = false
		end

		if var_15_2 then
			var_15_2:GetComponent(typeof(PinchZoom)).enabled = false
		end

		var_13_3(var_15_0)

		return
	end), true, true)

	return
end

function Dorm3dPhotoShareLayer:TakePhoto(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = {}
	local var_16_1 = {}
	local var_16_2 = {}

	assert(pg.share_template[arg_16_1], "share_template not exist: " .. arg_16_1)
	_.each(pg.share_template[arg_16_1].hidden_comps, function(arg_17_0)
		local var_17_0 = GameObject.Find(arg_17_0)

		if not IsNil(var_17_0) and var_17_0.activeSelf then
			table.insert(var_16_0, var_17_0)
			var_17_0:SetActive(false)
		end

		return
	end)
	_.each(pg.share_template[arg_16_1].show_comps, function(arg_18_0)
		local var_18_0 = GameObject.Find(arg_18_0)

		if not IsNil(var_18_0) and not var_18_0.activeSelf then
			table.insert(var_16_1, var_18_0)
			var_18_0:SetActive(true)
		end

		return
	end)
	_.each(pg.share_template[arg_16_1].move_comps, function(arg_19_0)
		local var_19_0 = GameObject.Find(arg_19_0.path)

		if not IsNil(var_19_0) then
			table.insert(var_16_2, {
				var_19_0,
				var_19_0.transform.anchoredPosition.x,
				var_19_0.transform.anchoredPosition.y
			})
			setAnchoredPosition(var_19_0, {
				x = arg_19_0.x,
				y = arg_19_0.y
			})
		end

		return
	end)

	local var_16_3 = GameObject.Find(pg.share_template[arg_16_1].camera):GetComponent(typeof(Camera))
	local var_16_4 = var_16_3.transform:GetChild(0)

	BLHX.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(var_16_3, function(arg_20_0)
		_.each(var_16_0, function(arg_21_0)
			arg_21_0:SetActive(true)

			return
		end)

		var_16_0 = {}

		_.each(var_16_1, function(arg_22_0)
			arg_22_0:SetActive(false)

			return
		end)

		var_16_1 = {}

		_.each(var_16_2, function(arg_23_0)
			setAnchoredPosition(arg_23_0[1], {
				x = arg_23_0[2],
				y = arg_23_0[3]
			})

			return
		end)

		var_16_2 = {}

		local var_20_0 = UnityEngine.Texture2D.New(arg_16_2.x / var_16_4.sizeDelta.x * Screen.width, arg_16_2.y / var_16_4.sizeDelta.y * Screen.height)

		var_20_0:SetPixels((arg_20_0:GetPixels((Screen.width - arg_16_2.x / var_16_4.sizeDelta.x * Screen.width) / 2, (Screen.height - arg_16_2.y / var_16_4.sizeDelta.y * Screen.height) / 2, arg_16_2.x / var_16_4.sizeDelta.x * Screen.width, arg_16_2.y / var_16_4.sizeDelta.y * Screen.height)))
		var_20_0:Apply()

		if not arg_16_4 then
			YSNormalTool.MediaTool.SaveImageWithBytes(Tex2DExtension.EncodeToPNG(var_20_0), function(arg_24_0, arg_24_1)
				if arg_24_0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("word_save_ok"))
				end

				return
			end)

			return
		end

		arg_16_3:SetPixels((arg_16_2.x / var_16_4.sizeDelta.x * Screen.width - arg_16_4.x / var_16_4.sizeDelta.x * Screen.width) / 2, (arg_16_2.y / var_16_4.sizeDelta.y * Screen.height - arg_16_4.y / var_16_4.sizeDelta.y * Screen.height) / 2, arg_16_4.x / var_16_4.sizeDelta.x * Screen.width, arg_16_4.y / var_16_4.sizeDelta.y * Screen.height, (var_20_0:GetPixels((arg_16_2.x / var_16_4.sizeDelta.x * Screen.width - arg_16_4.x / var_16_4.sizeDelta.x * Screen.width) / 2, (arg_16_2.y / var_16_4.sizeDelta.y * Screen.height - arg_16_4.y / var_16_4.sizeDelta.y * Screen.height) / 2, arg_16_4.x / var_16_4.sizeDelta.x * Screen.width, arg_16_4.y / var_16_4.sizeDelta.y * Screen.height)))
		YSNormalTool.MediaTool.SaveImageWithBytes(Tex2DExtension.EncodeToPNG(arg_16_3), function(arg_25_0, arg_25_1)
			if arg_25_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_save_ok"))
			end

			return
		end)

		return
	end)

	return
end

function Dorm3dPhotoShareLayer:TakeTexture(arg_26_1, arg_26_2)
	return (arg_26_1:EncodeToJPG((arg_26_1:TakePhoto(arg_26_2))))
end

return Dorm3dPhotoShareLayer
