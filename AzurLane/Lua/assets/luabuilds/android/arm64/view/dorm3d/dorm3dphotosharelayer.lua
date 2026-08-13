class = var_0_10000

local var_0_0 = "Dorm3dPhotoShareLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dPhotoShareUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.photoImgTrans = var_1.Find(var_2_0, "PhotoImg")

	local var_2_1 = arg_2_0._tf

	arg_2_0.shareBtnTrans = var_1.Find(var_2_1, "ShareBtn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.confirmBtnTrans = var_1.Find(var_2_2, "ConfirmBtn")

	local var_2_3 = arg_2_0._tf

	arg_2_0.cancelBtnTrans = var_1.Find(var_2_3, "CancelBtn")

	local var_2_4 = arg_2_0._tf

	arg_2_0.frameBtn = var_1.Find(var_2_4, "frameBtn")

	local var_2_5 = arg_2_0._tf

	arg_2_0.photoAdapter = var_1.Find(var_2_5, "photoAdapter")
	arg_2_0.bytes = arg_2_0.contextData.photoData
	arg_2_0.frameDic = {}
	arg_2_0.loadingDic = {}

	arg_2_0:InitFrame()

	return
end

function var_0_1.didEnter(arg_3_0)
	local var_3_0 = false

	onButton = var_1_10002

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.shareBtnTrans

	local function var_3_3()
		if arg_3_0.frameDic[arg_3_0.selectFrameId] then
			pg = var_1

			local var_4_0 = var_1.dorm3d_camera_photo_frame[arg_3_0.selectFrameId]

			pg = var_2

			local var_4_1 = var_2.ShareMgr.GetInstance()
			local var_4_2 = var_2.Share

			pg = var_2_10006

			var_4_2(var_4_1, var_2_10006.ShareMgr.TypeDorm3dPhoto, nil, nil, true, var_0:Find("frame").sizeDelta, var_4_0.watermark_location)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_3_1, var_3_2, var_3_3, var_1_10007)

	onButton = var_1_10002

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.confirmBtnTrans

	local function var_3_6()
		if arg_3_0.frameDic[arg_3_0.selectFrameId] then
			pg = var_1

			local var_5_0 = var_1.ShareMgr.GetInstance()
			local var_5_1 = var_0:Find("frame").sizeDelta

			pg = var_2_10003

			if var_2_10003.dorm3d_camera_photo_frame[arg_3_0.selectFrameId].frameTfName == "WoodFrame" then
				local var_5_2 = var_0:Find("frame")
				local var_5_3 = var_4.GetComponent(var_5_2, "Image").sprite

				var_2_10007 = var_0

				local var_5_4 = var_0.Find(var_2_10007, "mask").sizeDelta

				Object = var_5_2

				local var_5_5 = var_5_2.Instantiate(var_5_3.texture)

				UnityEngine = var_2_10007
				var_2_10007 = var_2_10007.Texture2D.New(var_5_3.rect.width, var_5_3.rect.height)

				local var_5_6 = var_5_5:GetPixels(0, 0, var_5_3.rect.width, var_5_3.rect.height)

				var_2_10007:SetPixels(var_5_6)
				var_2_10007:Apply()

				local var_5_7 = arg_3_0
				local var_5_8 = var_9.TakePhoto

				pg = var_12

				var_5_8(var_5_7, var_12.ShareMgr.TypeDorm3dPhoto, var_5_1, var_2_10007, var_5_4)
			else
				local var_5_9 = arg_3_0
				local var_5_10 = var_4.TakePhoto

				pg = var_2_10007

				var_5_10(var_5_9, var_2_10007.ShareMgr.TypeDorm3dPhoto, var_5_1)
			end
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_3_4, var_3_5, var_3_6, var_1_10007)

	onButton = var_1_10002

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0._tf

	var_1_10002(var_3_7, var_5.Find(var_3_8, "Mask"), function()
		local var_6_0 = arg_3_0

		var_0.closeView(var_6_0)

		return
	end)

	onButton = var_1_10002

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.cancelBtnTrans

	local function var_3_11()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		Dorm3dPhotoShareLayerMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.EXIT_SHARE)

		local var_7_2 = arg_3_0

		var_0.closeView(var_7_2)

		return
	end

	SFX_CANCEL = var_3_8

	var_1_10002(var_3_9, var_3_10, var_3_11, var_3_8)

	onButton = var_1_10002

	var_1_10002(arg_3_0, arg_3_0.frameBtn, function()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		Dorm3dPhotoShareLayerMediator = var_2_10003

		var_8_1(var_8_0, var_2_10003.SELECTFRAME, arg_3_0.contextData.photoTex, arg_3_0.contextData.photoData)

		return
	end)

	pg = var_1_10002

	local var_3_12 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_3_12, arg_3_0._tf, {
		staticBlur = true
	})

	return
end

function var_0_1.willExit(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0._tf)

	return
end

function var_0_1.exit(arg_10_0)
	var_0_1.super.exit(arg_10_0)

	return
end

function var_0_1.AfterSelectFrame(arg_11_0, arg_11_1)
	arg_11_0.selectFrameId = arg_11_1.selectFrameId
	pairs = var_2

	for iter_11_0, iter_11_1 in var_2(arg_11_0.frameDic) do
		setActive = var_1_10007

		var_1_10007(iter_11_1, false)
	end

	arg_11_0:LoadFrame(arg_11_1.imagePos, arg_11_1.imageScale, arg_11_1.specialPosDic)

	return
end

function var_0_1.InitFrame(arg_12_0)
	arg_12_0.selectFrameId = 1001

	arg_12_0:LoadFrame({
		0,
		0
	})

	return
end

function var_0_1.LoadFrame(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	pg = var_1_10004

	local var_13_0 = var_1_10004.dorm3d_camera_photo_frame[arg_13_0.selectFrameId].frameTfName == "FilmFrame"
	local var_13_1 = var_4.frameTfName == "InsFrame"

	local function var_13_2(arg_14_0)
		local var_14_0 = arg_14_0:Find("mask/realImage")
		local var_14_1 = var_1.GetComponent

		typeof = var_2_10005
		RawImage = var_2_10007

		local var_14_2 = var_14_1(var_14_0, var_2_10005(var_2_10007))

		var_14_2.texture = arg_13_0.contextData.photoTex
		GameObject = var_3

		local var_14_3 = var_3.Find("OverlayCamera").transform

		var_1.sizeDelta = var_3.GetChild(var_14_3, 0).sizeDelta
		setAnchoredPosition = var_4

		var_4(var_14_2, {
			x = arg_13_1.x,
			y = arg_13_1.y
		})

		if arg_13_2 then
			var_1.localScale = arg_13_2
		end

		if arg_13_3 then
			local var_14_4 = {
				"mask_up/realImage"
			}

			if var_13_0 then
				table = var_5

				var_5.insert(var_14_4, "mask_down/realImage")
			end

			local var_14_5 = {
				"upPos",
				"downPos"
			}
			local var_14_6 = {
				"upScale",
				"downScale"
			}

			ipairs = var_7

			for iter_14_0, iter_14_1 in var_7(var_14_4) do
				local var_14_7 = arg_14_0:Find(iter_14_1)
				local var_14_8 = var_12.GetComponent

				typeof = var_2_10016
				RawImage = var_2_10018

				local var_14_9 = var_14_8(var_14_7, var_2_10016(var_2_10018))

				var_14_9.texture = arg_13_0.contextData.photoTex
				GameObject = var_14
				var_2_10016 = var_14.Find("OverlayCamera").transform

				local var_14_10 = var_14.GetChild(var_2_10016, 0)

				if var_13_1 and iter_14_1 == "mask_up/realImage" then
					Vector2 = var_15
					var_12.sizeDelta = var_15(var_14_10.sizeDelta.x / 10, var_14_10.sizeDelta.y / 10)
				else
					var_12.sizeDelta = var_14_10.sizeDelta
				end

				local var_14_11 = var_14_5[iter_14_0]

				setAnchoredPosition = var_2_10016

				var_2_10016(var_14_9, {
					x = arg_13_3[var_14_11].x,
					y = arg_13_3[var_14_11].y
				})

				if arg_13_3[var_14_6[iter_14_0]] then
					var_12.localScale = var_2_10016
				end
			end
		end

		return
	end

	if arg_13_0.frameDic[arg_13_0.selectFrameId] then
		setActive = var_9

		var_9(var_8, true)
		var_13_2(var_8)

		return
	end

	if arg_13_0.loadingDic[arg_13_0.selectFrameId] then
		return
	end

	local var_13_3 = arg_13_0.selectFrameId

	ResourceMgr = var_10

	local var_13_4 = var_10.Inst
	local var_13_5 = var_10.getAssetAsync
	local var_13_6 = "ui/" .. var_4.frameTfName
	local var_13_7 = ""

	UnityEngine = var_1_10015

	var_13_5(var_13_4, var_13_6, var_13_7, var_1_10015.Events.UnityAction_UnityEngine_Object(function(arg_15_0)
		local var_15_0 = arg_13_0.loadingDic

		var_15_0[var_13_3] = false
		Object = var_15_0

		local var_15_1 = var_15_0.Instantiate(arg_15_0, arg_13_0.photoAdapter).transform

		arg_13_0.frameDic[var_13_3] = var_15_1

		if arg_13_0.selectFrameId == var_13_3 then
			var_13_2(var_15_1)
		else
			setActive = var_2

			var_2(var_15_1, false)
		end

		local var_15_2 = var_15_1:Find("mask/realImage")
		local var_15_3 = var_2.GetComponent

		typeof = var_5
		ScrollRect = var_2_10007
		var_15_3(var_15_2, var_5(var_2_10007)).enabled = false

		local var_15_4 = var_15_1:Find("mask/realImage")
		local var_15_5 = var_3.GetComponent

		typeof = var_6
		PinchZoom = var_2_10008
		var_15_5(var_15_4, var_6(var_2_10008)).enabled = false

		local var_15_6 = var_15_1:Find("mask_up/realImage")
		local var_15_7 = var_15_1:Find("mask_down/realImage")

		if var_15_6 then
			local var_15_8 = var_15_6
			local var_15_9 = var_15_6.GetComponent

			typeof = var_2_10009
			PinchZoom = var_2_10011
			var_15_9(var_15_8, var_2_10009(var_2_10011)).enabled = false
		end

		if var_15_7 then
			local var_15_10 = var_15_7
			local var_15_11 = var_15_7.GetComponent

			typeof = var_2_10009
			PinchZoom = var_2_10011
			var_15_11(var_15_10, var_2_10009(var_2_10011)).enabled = false
		end

		var_13_2(var_15_1)

		return
	end), true, true)

	return
end

function var_0_1.TakePhoto(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = {}
	local var_16_1 = {}
	local var_16_2 = {}

	pg = var_1_10008

	local var_16_3 = var_1_10008.share_template[arg_16_1]

	assert = var_1_10009

	var_1_10009(var_16_3, "share_template not exist: " .. arg_16_1)

	_ = var_1_10009

	var_1_10009.each(var_16_3.hidden_comps, function(arg_17_0)
		GameObject = var_2_10001

		local var_17_0 = var_2_10001.Find(arg_17_0)

		IsNil = var_2_10002

		if not var_2_10002(var_17_0) and var_17_0.activeSelf then
			table = var_2

			var_2.insert(var_16_0, var_17_0)
			var_17_0:SetActive(false)
		end

		return
	end)

	_ = var_9

	var_9.each(var_16_3.show_comps, function(arg_18_0)
		GameObject = var_2_10001

		local var_18_0 = var_2_10001.Find(arg_18_0)

		IsNil = var_2_10002

		if not var_2_10002(var_18_0) and not var_18_0.activeSelf then
			table = var_2

			var_2.insert(var_16_1, var_18_0)
			var_18_0:SetActive(true)
		end

		return
	end)

	_ = var_9

	var_9.each(var_16_3.move_comps, function(arg_19_0)
		GameObject = var_2_10001

		local var_19_0 = var_2_10001.Find(arg_19_0.path)

		IsNil = var_2_10002

		if not var_2_10002(var_19_0) then
			local var_19_1 = var_19_0.transform.anchoredPosition.x
			local var_19_2 = var_19_0.transform.anchoredPosition.y
			local var_19_3 = arg_19_0.x
			local var_19_4 = arg_19_0.y

			table = var_2_10006

			var_2_10006.insert(var_16_2, {
				var_19_0,
				var_19_1,
				var_19_2
			})

			setAnchoredPosition = var_6

			var_6(var_19_0, {
				x = var_19_3,
				y = var_19_4
			})
		end

		return
	end)

	GameObject = var_9

	local var_16_4 = var_9.Find(var_16_3.camera)
	local var_16_5 = var_9.GetComponent

	typeof = var_12
	Camera = var_1_10014

	local var_16_6 = var_16_5(var_16_4, var_12(var_1_10014)).transform
	local var_16_7 = var_10.GetChild(var_16_6, 0)

	local function var_16_8(arg_20_0)
		_ = var_2_10001

		var_2_10001.each(var_16_0, function(arg_21_0)
			arg_21_0:SetActive(true)

			return
		end)

		var_16_0 = {}
		_ = var_1

		var_1.each(var_16_1, function(arg_22_0)
			arg_22_0:SetActive(false)

			return
		end)

		var_16_1 = {}
		_ = var_1

		var_1.each(var_16_2, function(arg_23_0)
			setAnchoredPosition = var_3_10001

			var_3_10001(arg_23_0[1], {
				x = arg_23_0[2],
				y = arg_23_0[3]
			})

			return
		end)

		var_16_2 = {}

		local var_20_0 = arg_16_2.x / var_16_7.sizeDelta.x

		Screen = var_2

		local var_20_1 = var_20_0 * var_2.width
		local var_20_2 = arg_16_2.y / var_16_7.sizeDelta.y

		Screen = var_3

		local var_20_3 = var_20_2 * var_3.height

		UnityEngine = var_3

		local var_20_4 = var_3.Texture2D.New(var_20_1, var_20_3)

		Screen = var_4

		local var_20_5 = (var_4.width - var_20_1) / 2

		Screen = var_5

		local var_20_6 = (var_5.height - var_20_3) / 2
		local var_20_7 = arg_20_0
		local var_20_8 = arg_20_0.GetPixels(var_20_7, var_20_5, var_20_6, var_20_1, var_20_3)

		var_20_4:SetPixels(var_20_8)
		var_20_4:Apply()

		if not arg_16_4 then
			Tex2DExtension = var_7

			local var_20_9 = var_7.EncodeToPNG(var_20_4)

			YSNormalTool = var_20_7

			var_20_7.MediaTool.SaveImageWithBytes(var_20_9, function(arg_24_0, arg_24_1)
				if arg_24_0 then
					pg = var_3_10002

					local var_24_0 = var_3_10002.TipsMgr.GetInstance()
					local var_24_1 = var_2.ShowTips

					i18n = var_3_10005

					var_24_1(var_24_0, var_3_10005("word_save_ok"))
				end

				return
			end)

			return
		end

		local var_20_10 = arg_16_4.x / var_16_7.sizeDelta.x

		Screen = var_8

		local var_20_11 = var_20_10 * var_8.width
		local var_20_12 = arg_16_4.y / var_16_7.sizeDelta.y

		Screen = var_9

		local var_20_13 = var_20_12 * var_9.height
		local var_20_14 = var_20_1 - var_20_11
		local var_20_15 = var_20_3 - var_20_13
		local var_20_16 = var_20_4
		local var_20_17 = var_20_4.GetPixels(var_20_16, var_20_14 / 2, var_20_15 / 2, var_20_11, var_20_13)
		local var_20_18 = arg_16_3

		var_12.SetPixels(var_20_18, var_20_14 / 2, var_20_15 / 2, var_20_11, var_20_13, var_20_17)

		Tex2DExtension = var_12

		local var_20_19 = var_12.EncodeToPNG(arg_16_3)

		YSNormalTool = var_20_16

		var_20_16.MediaTool.SaveImageWithBytes(var_20_19, function(arg_25_0, arg_25_1)
			if arg_25_0 then
				pg = var_3_10002

				local var_25_0 = var_3_10002.TipsMgr.GetInstance()
				local var_25_1 = var_2.ShowTips

				i18n = var_3_10005

				var_25_1(var_25_0, var_3_10005("word_save_ok"))
			end

			return
		end)

		return
	end

	BLHX = var_16_6

	var_16_6.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(var_9, var_16_8)

	return
end

function var_0_1.TakeTexture(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_1:TakePhoto(arg_26_2)

	return (arg_26_1:EncodeToJPG(var_26_0))
end

return var_0_1
