local var_0_0 = class("Dorm3dPhotoShareLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dPhotoShareUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.photoImgTrans = arg_2_0._tf:Find("PhotoImg")
	arg_2_0.shareBtnTrans = arg_2_0._tf:Find("ShareBtn")
	arg_2_0.confirmBtnTrans = arg_2_0._tf:Find("ConfirmBtn")
	arg_2_0.cancelBtnTrans = arg_2_0._tf:Find("CancelBtn")
	arg_2_0.frameBtn = arg_2_0._tf:Find("frameBtn")
	arg_2_0.photoAdapter = arg_2_0._tf:Find("photoAdapter")
	arg_2_0.bytes = arg_2_0.contextData.photoData
	arg_2_0.frameDic = {}
	arg_2_0.loadingDic = {}

	arg_2_0:InitFrame()

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.shareBtnTrans, function()
		if arg_3_0.frameDic[arg_3_0.selectFrameId] then
			pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeDorm3dPhoto, nil, nil, true, arg_3_0.frameDic[arg_3_0.selectFrameId]:Find("frame").sizeDelta, pg.dorm3d_camera_photo_frame[arg_3_0.selectFrameId].watermark_location)
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.confirmBtnTrans, function()
		local var_5_9000

		if arg_3_0.frameDic[arg_3_0.selectFrameId] then
			local var_5_0 = pg.ShareMgr.GetInstance()
			local var_5_1 = arg_3_0.frameDic[arg_3_0.selectFrameId]:Find("frame").sizeDelta

			if pg.dorm3d_camera_photo_frame[arg_3_0.selectFrameId].frameTfName == "WoodFrame" then
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
		arg_3_0:closeView()

		return
	end)
	onButton(arg_3_0, arg_3_0.cancelBtnTrans, function()
		arg_3_0:emit(Dorm3dPhotoShareLayerMediator.EXIT_SHARE)
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.frameBtn, function()
		arg_3_0:emit(Dorm3dPhotoShareLayerMediator.SELECTFRAME, arg_3_0.contextData.photoTex, arg_3_0.contextData.photoData)

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf, {
		staticBlur = true
	})

	return
end

function var_0_0.willExit(arg_9_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0._tf)

	return
end

function var_0_0.exit(arg_10_0)
	var_0_0.super.exit(arg_10_0)

	return
end

function var_0_0.AfterSelectFrame(arg_11_0, arg_11_1)
	arg_11_0.selectFrameId = arg_11_1.selectFrameId

	for iter_11_0, iter_11_1 in pairs(arg_11_0.frameDic) do
		setActive(iter_11_1, false)
	end

	arg_11_0:LoadFrame(arg_11_1.imagePos, arg_11_1.imageScale, arg_11_1.specialPosDic)

	return
end

function var_0_0.InitFrame(arg_12_0)
	arg_12_0.selectFrameId = 1001

	arg_12_0:LoadFrame({
		0,
		0
	})

	return
end

function var_0_0.LoadFrame(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = pg.dorm3d_camera_photo_frame[arg_13_0.selectFrameId]
	local var_13_1 = pg.dorm3d_camera_photo_frame[arg_13_0.selectFrameId].frameTfName == "FilmFrame"
	local var_13_2 = pg.dorm3d_camera_photo_frame[arg_13_0.selectFrameId].frameTfName == "InsFrame"

	local function var_13_3(arg_14_0)
		local var_14_0 = arg_14_0:Find("mask/realImage")
		local var_14_1 = var_14_0:GetComponent(typeof(RawImage))

		var_14_1.texture = arg_13_0.contextData.photoTex
		var_14_0.sizeDelta = GameObject.Find("OverlayCamera").transform:GetChild(0).sizeDelta

		setAnchoredPosition(var_14_1, {
			x = arg_13_1.x,
			y = arg_13_1.y
		})

		if arg_13_2 then
			var_14_0.localScale = arg_13_2
		end

		if arg_13_3 then
			if var_13_1 then
				table.insert({
					"mask_up/realImage"
				}, "mask_down/realImage")
			end

			local var_14_2 = {
				"upPos",
				"downPos"
			}
			local var_14_3 = {
				"upScale",
				"downScale"
			}

			for iter_14_0, iter_14_1 in ipairs({
				"mask_up/realImage"
			}) do
				local var_14_4 = arg_14_0:Find(iter_14_1)
				local var_14_5 = var_14_4:GetComponent(typeof(RawImage))

				var_14_5.texture = arg_13_0.contextData.photoTex

				local var_14_6 = GameObject.Find("OverlayCamera").transform:GetChild(0)
				local var_14_7

				if var_13_2 and iter_14_1 == "mask_up/realImage" then
					var_14_4.sizeDelta = Vector2(var_14_6.sizeDelta.x / 10, var_14_6.sizeDelta.y / 10)
				else
					var_14_4.sizeDelta = var_14_6.sizeDelta
					var_14_7 = var_14_5
				end

				;({
					x = arg_13_3[var_14_2[iter_14_0]].x
				}).y = arg_13_3[var_14_2[iter_14_0]].y

				setAnchoredPosition(var_14_5, {
					x = arg_13_3[var_14_2[iter_14_0]].x
				})

				if arg_13_3[var_14_3[iter_14_0]] then
					var_14_4.localScale = arg_13_3[var_14_3[iter_14_0]]
				end
			end
		end

		return
	end

	if arg_13_0.frameDic[arg_13_0.selectFrameId] then
		setActive(arg_13_0.frameDic[arg_13_0.selectFrameId], true)
		var_13_3(arg_13_0.frameDic[arg_13_0.selectFrameId])

		return
	end

	if arg_13_0.loadingDic[arg_13_0.selectFrameId] then
		return
	end

	local var_13_4 = arg_13_0.selectFrameId

	ResourceMgr.Inst:getAssetAsync("ui/" .. var_13_0.frameTfName, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_15_0)
		arg_13_0.loadingDic[var_13_4] = false

		local var_15_0 = Object.Instantiate(arg_15_0, arg_13_0.photoAdapter).transform

		arg_13_0.frameDic[var_13_4] = var_15_0

		if arg_13_0.selectFrameId == var_13_4 then
			var_13_3(var_15_0)
		else
			setActive(var_15_0, false)
		end

		local var_15_1 = var_15_0:Find("mask/realImage")

		var_15_1:GetComponent(typeof(ScrollRect)).enabled = false
		var_15_0:Find("mask/realImage"):GetComponent(typeof(PinchZoom)).enabled = false

		local var_15_2 = var_15_0:Find("mask_up/realImage")
		local var_15_3 = var_15_0:Find("mask_down/realImage")

		if var_15_2 then
			var_15_2:GetComponent(typeof(PinchZoom)).enabled = false
		end

		if var_15_3 then
			var_15_3:GetComponent(typeof(PinchZoom)).enabled = false
		end

		var_13_3(var_15_0)

		return
	end), true, true)

	return
end

function var_0_0.TakePhoto(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
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

function var_0_0.TakeTexture(arg_26_0, arg_26_1, arg_26_2)
	return (arg_26_1:EncodeToJPG((arg_26_1:TakePhoto(arg_26_2))))
end

return var_0_0
