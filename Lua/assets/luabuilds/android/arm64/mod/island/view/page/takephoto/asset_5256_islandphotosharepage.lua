local IslandPhotoSharePage = class("IslandPhotoSharePage", import("...base.IslandBasePage"))

function IslandPhotoSharePage:getUIName()
	return "IslandPhotoShareUI"
end

function IslandPhotoSharePage:OnLoaded()
	self.photoImgTrans = self._tf:Find("PhotoImg")
	self.shareBtnTrans = self._tf:Find("ShareBtn")
	self.confirmBtnTrans = self._tf:Find("ConfirmBtn")
	self.cancelBtnTrans = self._tf:Find("CancelBtn")
	self.frameBtn = self._tf:Find("frameBtn")
	self.photoAdapter = self._tf:Find("photoAdapter")

	return
end

function IslandPhotoSharePage:OnInit()
	self.frameDic = {}
	self.loadingDic = {}

	onButton(self, self.shareBtnTrans, function()
		if self.frameDic[self.selectFrameId] then
			pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeDorm3dPhoto, nil, nil, true, self.frameDic[self.selectFrameId]:Find("frame").sizeDelta, pg.island_camera_photo_frame[self.selectFrameId].watermark_location)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtnTrans, function()
		if self.frameDic[self.selectFrameId] then
			local var_5_0 = pg.ShareMgr.GetInstance()
			local var_5_1 = self.frameDic[self.selectFrameId]:Find("frame").sizeDelta

			if pg.island_camera_photo_frame[self.selectFrameId].frameTfName == "IslandWoodFrame" then
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
		self:Hide()

		return
	end)
	onButton(self, self.cancelBtnTrans, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self.frameBtn, function()
		self:OpenPage(IslandPhotoSelectFramePage, self.bytes, self.photoTexture, self.selectFrameId, function(arg_9_0)
			self:AfterSelectFrame(arg_9_0)

			return
		end)

		return
	end)

	self.lateFuncDic = {}
	self.specialLateFuncDic = {}

	return
end

function IslandPhotoSharePage:OnShow(arg_10_1, arg_10_2)
	self.bytes = arg_10_1
	self.photoTexture = arg_10_2

	self:InitFrame()
	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		staticBlur = true
	})

	return
end

function IslandPhotoSharePage:InitFrame()
	self.selectFrameId = 1001

	for iter_11_0, iter_11_1 in pairs(self.frameDic) do
		setActive(iter_11_1, false)
	end

	self:LoadFrame({
		0,
		0
	})

	return
end

function IslandPhotoSharePage:AddListeners()
	return
end

function IslandPhotoSharePage:RemoveListeners()
	return
end

function IslandPhotoSharePage:AfterSelectFrame(arg_14_1)
	self.selectFrameId = arg_14_1.selectFrameId

	for iter_14_0, iter_14_1 in pairs(self.frameDic) do
		setActive(iter_14_1, false)
	end

	self:LoadFrame(arg_14_1.imagePos, arg_14_1.imageScale, arg_14_1.specialPosDic)

	return
end

function IslandPhotoSharePage:LoadFrame(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = pg.island_camera_photo_frame[self.selectFrameId]
	local var_15_1 = pg.island_camera_photo_frame[self.selectFrameId].frameTfName == "IslandFilmFrame"
	local var_15_2 = pg.island_camera_photo_frame[self.selectFrameId].frameTfName == "IslandInsFrame"

	local function var_15_3(arg_16_0)
		local var_16_0 = arg_16_0:Find("mask/realImage")
		local var_16_1 = var_16_0:GetComponent(typeof(RawImage))

		var_16_1.texture = self.photoTexture
		var_16_0.sizeDelta = GameObject.Find("OverlayCamera").transform:GetChild(0).sizeDelta

		setAnchoredPosition(var_16_1, {
			x = arg_15_1.x,
			y = arg_15_1.y
		})

		if arg_15_2 then
			var_16_0.localScale = arg_15_2
		end

		if arg_15_3 then
			local var_16_2 = {
				"mask_up/realImage"
			}

			if var_15_1 then
				table.insert(var_16_2, "mask_down/realImage")
			end

			local var_16_3 = {
				"upPos",
				"downPos"
			}
			local var_16_4 = {
				"upScale",
				"downScale"
			}

			for iter_16_0, iter_16_1 in ipairs(var_16_2) do
				local var_16_5 = arg_16_0:Find(iter_16_1)
				local var_16_6 = var_16_5:GetComponent(typeof(RawImage))

				var_16_6.texture = self.photoTexture

				local var_16_7 = GameObject.Find("OverlayCamera").transform:GetChild(0)

				if var_15_2 and iter_16_1 == "mask_up/realImage" then
					var_16_5.sizeDelta = Vector2(var_16_7.sizeDelta.x / 10, var_16_7.sizeDelta.y / 10)
				end

				local var_16_9

				do
					var_16_5.sizeDelta = var_16_7.sizeDelta
					var_16_9 = {
						x = arg_15_3[var_16_3[iter_16_0]].x
					}
				end

				var_16_9.y = arg_15_3[var_16_3[iter_16_0]].y

				setAnchoredPosition(var_16_6, var_16_9)

				if arg_15_3[var_16_4[iter_16_0]] then
					var_16_5.localScale = arg_15_3[var_16_4[iter_16_0]]
				end
			end
		end

		return
	end

	if self.frameDic[self.selectFrameId] then
		setActive(self.frameDic[self.selectFrameId], true)
		var_15_3(self.frameDic[self.selectFrameId])

		return
	end

	if self.loadingDic[self.selectFrameId] then
		return
	end

	local var_15_4 = self.selectFrameId

	table.insert(self.loadingIdList or {}, (IslandAssetLoadDispatcher.Instance:Enqueue("ui/" .. var_15_0.frameTfName, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_17_0)
		self.loadingDic[var_15_4] = false

		local var_17_0 = Object.Instantiate(arg_17_0, self.photoAdapter).transform

		self.frameDic[var_15_4] = var_17_0
		var_17_0:Find("mask/realImage"):GetComponent(typeof(ScrollRect)).enabled = false
		var_17_0:Find("mask/realImage"):GetComponent(typeof(PinchZoom)).enabled = false

		local var_17_1 = var_17_0:Find("mask_up/realImage")
		local var_17_2 = var_17_0:Find("mask_down/realImage")

		if var_17_1 then
			var_17_1:GetComponent(typeof(PinchZoom)).enabled = false
		end

		if var_17_2 then
			var_17_2:GetComponent(typeof(PinchZoom)).enabled = false
		end

		if self.selectFrameId == var_15_4 then
			var_15_3(var_17_0)
		else
			setActive(var_17_0, false)
		end

		var_15_3(var_17_0)

		return
	end), true, true)))

	return
end

function IslandPhotoSharePage:TakePhoto(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = {}
	local var_18_1 = {}
	local var_18_2 = {}

	assert(pg.share_template[arg_18_1], "share_template not exist: " .. arg_18_1)
	_.each(pg.share_template[arg_18_1].hidden_comps, function(arg_19_0)
		local var_19_0 = GameObject.Find(arg_19_0)

		if not IsNil(var_19_0) and var_19_0.activeSelf then
			table.insert(var_18_0, var_19_0)
			var_19_0:SetActive(false)
		end

		return
	end)
	_.each(pg.share_template[arg_18_1].show_comps, function(arg_20_0)
		local var_20_0 = GameObject.Find(arg_20_0)

		if not IsNil(var_20_0) and not var_20_0.activeSelf then
			table.insert(var_18_1, var_20_0)
			var_20_0:SetActive(true)
		end

		return
	end)
	_.each(pg.share_template[arg_18_1].move_comps, function(arg_21_0)
		local var_21_0 = GameObject.Find(arg_21_0.path)

		if not IsNil(var_21_0) then
			table.insert(var_18_2, {
				var_21_0,
				var_21_0.transform.anchoredPosition.x,
				var_21_0.transform.anchoredPosition.y
			})
			setAnchoredPosition(var_21_0, {
				x = arg_21_0.x,
				y = arg_21_0.y
			})
		end

		return
	end)

	local var_18_3 = GameObject.Find(pg.share_template[arg_18_1].camera):GetComponent(typeof(Camera))
	local var_18_4 = var_18_3.transform:GetChild(0)

	BLHX.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(var_18_3, function(arg_22_0)
		_.each(var_18_0, function(arg_23_0)
			arg_23_0:SetActive(true)

			return
		end)

		var_18_0 = {}

		_.each(var_18_1, function(arg_24_0)
			arg_24_0:SetActive(false)

			return
		end)

		var_18_1 = {}

		_.each(var_18_2, function(arg_25_0)
			setAnchoredPosition(arg_25_0[1], {
				x = arg_25_0[2],
				y = arg_25_0[3]
			})

			return
		end)

		var_18_2 = {}

		local var_22_0 = UnityEngine.Texture2D.New(arg_18_2.x / var_18_4.sizeDelta.x * Screen.width, arg_18_2.y / var_18_4.sizeDelta.y * Screen.height)

		var_22_0:SetPixels((arg_22_0:GetPixels((Screen.width - arg_18_2.x / var_18_4.sizeDelta.x * Screen.width) / 2, (Screen.height - arg_18_2.y / var_18_4.sizeDelta.y * Screen.height) / 2, arg_18_2.x / var_18_4.sizeDelta.x * Screen.width, arg_18_2.y / var_18_4.sizeDelta.y * Screen.height)))
		var_22_0:Apply()

		if not arg_18_4 then
			YSNormalTool.MediaTool.SaveImageWithBytes(Tex2DExtension.EncodeToPNG(var_22_0), function(arg_26_0, arg_26_1)
				if arg_26_0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("word_save_ok"))
				end

				return
			end)

			return
		end

		arg_18_3:SetPixels((arg_18_2.x / var_18_4.sizeDelta.x * Screen.width - arg_18_4.x / var_18_4.sizeDelta.x * Screen.width) / 2, (arg_18_2.y / var_18_4.sizeDelta.y * Screen.height - arg_18_4.y / var_18_4.sizeDelta.y * Screen.height) / 2, arg_18_4.x / var_18_4.sizeDelta.x * Screen.width, arg_18_4.y / var_18_4.sizeDelta.y * Screen.height, (var_22_0:GetPixels((arg_18_2.x / var_18_4.sizeDelta.x * Screen.width - arg_18_4.x / var_18_4.sizeDelta.x * Screen.width) / 2, (arg_18_2.y / var_18_4.sizeDelta.y * Screen.height - arg_18_4.y / var_18_4.sizeDelta.y * Screen.height) / 2, arg_18_4.x / var_18_4.sizeDelta.x * Screen.width, arg_18_4.y / var_18_4.sizeDelta.y * Screen.height)))
		YSNormalTool.MediaTool.SaveImageWithBytes(Tex2DExtension.EncodeToPNG(arg_18_3), function(arg_27_0, arg_27_1)
			if arg_27_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_save_ok"))
			end

			return
		end)

		return
	end)

	return
end

function IslandPhotoSharePage:OnHide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function IslandPhotoSharePage:OnDestroy()
	self:OnHide()

	for iter_29_0, iter_29_1 in ipairs(self.loadingIdList or {}) do
		IslandAssetLoadDispatcher.Instance:Cancel(iter_29_1)
	end

	self.loadingIdList = nil

	return
end

return IslandPhotoSharePage
