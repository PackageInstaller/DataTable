local var_0_0 = class("IslandPhotoSharePage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandPhotoShareUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.photoImgTrans = arg_2_0._tf:Find("PhotoImg")
	arg_2_0.shareBtnTrans = arg_2_0._tf:Find("ShareBtn")
	arg_2_0.confirmBtnTrans = arg_2_0._tf:Find("ConfirmBtn")
	arg_2_0.cancelBtnTrans = arg_2_0._tf:Find("CancelBtn")
	arg_2_0.frameBtn = arg_2_0._tf:Find("frameBtn")
	arg_2_0.photoAdapter = arg_2_0._tf:Find("photoAdapter")

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.frameDic = {}
	arg_3_0.loadingDic = {}

	onButton(arg_3_0, arg_3_0.shareBtnTrans, function()
		if arg_3_0.frameDic[arg_3_0.selectFrameId] then
			pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeDorm3dPhoto, nil, nil, true, arg_3_0.frameDic[arg_3_0.selectFrameId]:Find("frame").sizeDelta, pg.island_camera_photo_frame[arg_3_0.selectFrameId].watermark_location)
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.confirmBtnTrans, function()
		local var_5_9000

		if arg_3_0.frameDic[arg_3_0.selectFrameId] then
			local var_5_0 = pg.ShareMgr.GetInstance()
			local var_5_1 = arg_3_0.frameDic[arg_3_0.selectFrameId]:Find("frame").sizeDelta

			if pg.island_camera_photo_frame[arg_3_0.selectFrameId].frameTfName == "IslandWoodFrame" then
				local var_5_2 = arg_3_0.frameDic[arg_3_0.selectFrameId]:Find("frame")
				local var_5_3 = var_5_2.GetComponent(var_5_9000, "Image").sprite
				local var_5_4 = UnityEngine.Texture2D.New(var_5_3.rect.width, var_5_3.rect.height)

				var_5_4:SetPixels((Object.Instantiate(var_5_3.texture).GetPixels(var_5_2, 0, 0, var_5_3.rect.width, var_5_3.rect.height)))
				var_5_4:Apply()
				arg_3_0:TakePhoto(pg.ShareMgr.TypeDorm3dPhoto, var_5_1, var_5_4, arg_3_0.frameDic[arg_3_0.selectFrameId]:Find("mask").sizeDelta)
			else
				arg_3_0:TakePhoto(pg.ShareMgr.TypeDorm3dPhoto, var_5_1)
			end
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("Mask"), function()
		arg_3_0:Hide()

		return
	end)
	onButton(arg_3_0, arg_3_0.cancelBtnTrans, function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.frameBtn, function()
		arg_3_0:OpenPage(IslandPhotoSelectFramePage, arg_3_0.bytes, arg_3_0.photoTexture, arg_3_0.selectFrameId, function(arg_9_0)
			arg_3_0:AfterSelectFrame(arg_9_0)

			return
		end)

		return
	end)

	arg_3_0.lateFuncDic = {}
	arg_3_0.specialLateFuncDic = {}

	return
end

function var_0_0.OnShow(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.bytes = arg_10_1
	arg_10_0.photoTexture = arg_10_2

	arg_10_0:InitFrame()
	pg.UIMgr.GetInstance():BlurPanel(arg_10_0._tf, {
		staticBlur = true
	})

	return
end

function var_0_0.InitFrame(arg_11_0)
	arg_11_0.selectFrameId = 1001

	for iter_11_0, iter_11_1 in pairs(arg_11_0.frameDic) do
		setActive(iter_11_1, false)
	end

	arg_11_0:LoadFrame({
		0,
		0
	})

	return
end

function var_0_0.AddListeners(arg_12_0)
	return
end

function var_0_0.RemoveListeners(arg_13_0)
	return
end

function var_0_0.AfterSelectFrame(arg_14_0, arg_14_1)
	arg_14_0.selectFrameId = arg_14_1.selectFrameId

	for iter_14_0, iter_14_1 in pairs(arg_14_0.frameDic) do
		setActive(iter_14_1, false)
	end

	arg_14_0:LoadFrame(arg_14_1.imagePos, arg_14_1.imageScale, arg_14_1.specialPosDic)

	return
end

function var_0_0.LoadFrame(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = pg.island_camera_photo_frame[arg_15_0.selectFrameId]
	local var_15_1 = pg.island_camera_photo_frame[arg_15_0.selectFrameId].frameTfName == "IslandFilmFrame"
	local var_15_2 = pg.island_camera_photo_frame[arg_15_0.selectFrameId].frameTfName == "IslandInsFrame"

	local function var_15_3(arg_16_0)
		local var_16_0 = arg_16_0:Find("mask/realImage")
		local var_16_1 = var_16_0:GetComponent(typeof(RawImage))

		var_16_1.texture = arg_15_0.photoTexture
		var_16_0.sizeDelta = GameObject.Find("OverlayCamera").transform:GetChild(0).sizeDelta

		setAnchoredPosition(var_16_1, {
			x = arg_15_1.x,
			y = arg_15_1.y
		})

		if arg_15_2 then
			var_16_0.localScale = arg_15_2
		end

		if arg_15_3 then
			if var_15_1 then
				table.insert({
					"mask_up/realImage"
				}, "mask_down/realImage")
			end

			local var_16_2 = {
				"upPos",
				"downPos"
			}
			local var_16_3 = {
				"upScale",
				"downScale"
			}

			for iter_16_0, iter_16_1 in ipairs({
				"mask_up/realImage"
			}) do
				local var_16_4 = arg_16_0:Find(iter_16_1)
				local var_16_5 = var_16_4:GetComponent(typeof(RawImage))

				var_16_5.texture = arg_15_0.photoTexture

				local var_16_6 = GameObject.Find("OverlayCamera").transform:GetChild(0)
				local var_16_7

				if var_15_2 and iter_16_1 == "mask_up/realImage" then
					var_16_4.sizeDelta = Vector2(var_16_6.sizeDelta.x / 10, var_16_6.sizeDelta.y / 10)
				else
					var_16_4.sizeDelta = var_16_6.sizeDelta
					var_16_7 = var_16_5
				end

				;({
					x = arg_15_3[var_16_2[iter_16_0]].x
				}).y = arg_15_3[var_16_2[iter_16_0]].y

				setAnchoredPosition(var_16_5, {
					x = arg_15_3[var_16_2[iter_16_0]].x
				})

				if arg_15_3[var_16_3[iter_16_0]] then
					var_16_4.localScale = arg_15_3[var_16_3[iter_16_0]]
				end
			end
		end

		return
	end

	if arg_15_0.frameDic[arg_15_0.selectFrameId] then
		setActive(arg_15_0.frameDic[arg_15_0.selectFrameId], true)
		var_15_3(arg_15_0.frameDic[arg_15_0.selectFrameId])

		return
	end

	if arg_15_0.loadingDic[arg_15_0.selectFrameId] then
		return
	end

	local var_15_4 = arg_15_0.selectFrameId
	local var_15_5 = arg_15_0.loadingIdList or {}

	table.insert(var_15_5, (IslandAssetLoadDispatcher.Instance:Enqueue("ui/" .. var_15_0.frameTfName, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_17_0)
		arg_15_0.loadingDic[var_15_4] = false

		local var_17_0 = Object.Instantiate(arg_17_0, arg_15_0.photoAdapter).transform

		arg_15_0.frameDic[var_15_4] = var_17_0
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

		if arg_15_0.selectFrameId == var_15_4 then
			var_15_3(var_17_0)
		else
			setActive(var_17_0, false)
		end

		var_15_3(var_17_0)

		return
	end), true, true)))

	return
end

function var_0_0.TakePhoto(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
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

function var_0_0.OnHide(arg_28_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_28_0._tf)

	return
end

function var_0_0.OnDestroy(arg_29_0)
	arg_29_0:OnHide()

	local var_29_0 = arg_29_0.loadingIdList or {}

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		IslandAssetLoadDispatcher.Instance:Cancel(iter_29_1)
	end

	arg_29_0.loadingIdList = nil

	return
end

return var_0_0
