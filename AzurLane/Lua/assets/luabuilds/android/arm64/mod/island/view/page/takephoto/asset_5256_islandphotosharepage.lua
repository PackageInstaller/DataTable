class = var_0_10000

local var_0_0 = "IslandPhotoSharePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandPhotoShareUI"
end

function var_0_1.OnLoaded(arg_2_0)
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

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.frameDic = {}
	arg_3_0.loadingDic = {}
	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.shareBtnTrans

	local function var_3_2()
		if arg_3_0.frameDic[arg_3_0.selectFrameId] then
			pg = var_1

			local var_4_0 = var_1.island_camera_photo_frame[arg_3_0.selectFrameId]

			pg = var_2

			local var_4_1 = var_2.ShareMgr.GetInstance()
			local var_4_2 = var_2.Share

			pg = var_2_10006

			var_4_2(var_4_1, var_2_10006.ShareMgr.TypeDorm3dPhoto, nil, nil, true, var_0:Find("frame").sizeDelta, var_4_0.watermark_location)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.confirmBtnTrans

	local function var_3_5()
		if arg_3_0.frameDic[arg_3_0.selectFrameId] then
			pg = var_1

			local var_5_0 = var_1.ShareMgr.GetInstance()
			local var_5_1 = var_0:Find("frame").sizeDelta

			pg = var_2_10003

			if var_2_10003.island_camera_photo_frame[arg_3_0.selectFrameId].frameTfName == "IslandWoodFrame" then
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

	SFX_PANEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf

	var_1(var_3_6, var_4.Find(var_3_7, "Mask"), function()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end)

	onButton = var_1

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.cancelBtnTrans

	local function var_3_10()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_CANCEL = var_3_7

	var_1(var_3_8, var_3_9, var_3_10, var_3_7)

	onButton = var_1

	var_1(arg_3_0, arg_3_0.frameBtn, function()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.OpenPage

		IslandPhotoSelectFramePage = var_2_10003

		var_8_1(var_8_0, var_2_10003, arg_3_0.bytes, arg_3_0.photoTexture, arg_3_0.selectFrameId, function(arg_9_0)
			local var_9_0 = arg_3_0

			var_1.AfterSelectFrame(var_9_0, arg_9_0)

			return
		end)

		return
	end)

	arg_3_0.lateFuncDic = {}
	arg_3_0.specialLateFuncDic = {}

	return
end

function var_0_1.OnShow(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.bytes = arg_10_1
	arg_10_0.photoTexture = arg_10_2

	arg_10_0:InitFrame()

	pg = var_3

	local var_10_0 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_10_0, arg_10_0._tf, {
		staticBlur = true
	})

	return
end

function var_0_1.InitFrame(arg_11_0)
	arg_11_0.selectFrameId = 1001
	pairs = var_1

	for iter_11_0, iter_11_1 in var_1(arg_11_0.frameDic) do
		setActive = var_1_10006

		var_1_10006(iter_11_1, false)
	end

	arg_11_0:LoadFrame({
		0,
		0
	})

	return
end

function var_0_1.AddListeners(arg_12_0)
	return
end

function var_0_1.RemoveListeners(arg_13_0)
	return
end

function var_0_1.AfterSelectFrame(arg_14_0, arg_14_1)
	arg_14_0.selectFrameId = arg_14_1.selectFrameId
	pairs = var_2

	for iter_14_0, iter_14_1 in var_2(arg_14_0.frameDic) do
		setActive = var_1_10007

		var_1_10007(iter_14_1, false)
	end

	arg_14_0:LoadFrame(arg_14_1.imagePos, arg_14_1.imageScale, arg_14_1.specialPosDic)

	return
end

function var_0_1.LoadFrame(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	pg = var_1_10004

	local var_15_0 = var_1_10004.island_camera_photo_frame[arg_15_0.selectFrameId].frameTfName == "IslandFilmFrame"
	local var_15_1 = var_4.frameTfName == "IslandInsFrame"

	local function var_15_2(arg_16_0)
		local var_16_0 = arg_16_0:Find("mask/realImage")
		local var_16_1 = var_1.GetComponent

		typeof = var_2_10005
		RawImage = var_2_10007

		local var_16_2 = var_16_1(var_16_0, var_2_10005(var_2_10007))

		var_16_2.texture = arg_15_0.photoTexture
		GameObject = var_3

		local var_16_3 = var_3.Find("OverlayCamera").transform

		var_1.sizeDelta = var_3.GetChild(var_16_3, 0).sizeDelta
		setAnchoredPosition = var_4

		var_4(var_16_2, {
			x = arg_15_1.x,
			y = arg_15_1.y
		})

		if arg_15_2 then
			var_1.localScale = arg_15_2
		end

		if arg_15_3 then
			local var_16_4 = {
				"mask_up/realImage"
			}

			if var_15_0 then
				table = var_5

				var_5.insert(var_16_4, "mask_down/realImage")
			end

			local var_16_5 = {
				"upPos",
				"downPos"
			}
			local var_16_6 = {
				"upScale",
				"downScale"
			}

			ipairs = var_7

			for iter_16_0, iter_16_1 in var_7(var_16_4) do
				local var_16_7 = arg_16_0:Find(iter_16_1)
				local var_16_8 = var_12.GetComponent

				typeof = var_2_10016
				RawImage = var_2_10018

				local var_16_9 = var_16_8(var_16_7, var_2_10016(var_2_10018))

				var_16_9.texture = arg_15_0.photoTexture
				GameObject = var_14
				var_2_10016 = var_14.Find("OverlayCamera").transform

				local var_16_10 = var_14.GetChild(var_2_10016, 0)

				if var_15_1 and iter_16_1 == "mask_up/realImage" then
					Vector2 = var_15
					var_12.sizeDelta = var_15(var_16_10.sizeDelta.x / 10, var_16_10.sizeDelta.y / 10)
				else
					var_12.sizeDelta = var_16_10.sizeDelta
				end

				local var_16_11 = var_16_5[iter_16_0]

				setAnchoredPosition = var_2_10016

				var_2_10016(var_16_9, {
					x = arg_15_3[var_16_11].x,
					y = arg_15_3[var_16_11].y
				})

				if arg_15_3[var_16_6[iter_16_0]] then
					var_12.localScale = var_2_10016
				end
			end
		end

		return
	end

	if arg_15_0.frameDic[arg_15_0.selectFrameId] then
		setActive = var_9

		var_9(var_8, true)
		var_15_2(var_8)

		return
	end

	if arg_15_0.loadingDic[arg_15_0.selectFrameId] then
		return
	end

	local var_15_3 = arg_15_0.selectFrameId

	IslandAssetLoadDispatcher = var_10

	local var_15_4 = var_10.Instance
	local var_15_5 = var_10.Enqueue
	local var_15_6 = "ui/" .. var_4.frameTfName
	local var_15_7 = ""

	typeof = var_1_10015
	GameObject = var_1_10017

	local var_15_8 = var_1_10015(var_1_10017)

	UnityEngine = var_1_10016

	local var_15_9 = var_15_5(var_15_4, var_15_6, var_15_7, var_15_8, var_1_10016.Events.UnityAction_UnityEngine_Object(function(arg_17_0)
		local var_17_0 = arg_15_0.loadingDic

		var_17_0[var_15_3] = false
		Object = var_17_0

		local var_17_1 = var_17_0.Instantiate(arg_17_0, arg_15_0.photoAdapter).transform

		arg_15_0.frameDic[var_15_3] = var_17_1

		local var_17_2 = var_17_1:Find("mask/realImage")
		local var_17_3 = var_2.GetComponent

		typeof = var_5
		ScrollRect = var_2_10007
		var_17_3(var_17_2, var_5(var_2_10007)).enabled = false

		local var_17_4 = var_17_1:Find("mask/realImage")
		local var_17_5 = var_3.GetComponent

		typeof = var_6
		PinchZoom = var_2_10008
		var_17_5(var_17_4, var_6(var_2_10008)).enabled = false

		local var_17_6 = var_17_1:Find("mask_up/realImage")
		local var_17_7 = var_17_1:Find("mask_down/realImage")

		if var_17_6 then
			local var_17_8 = var_17_6
			local var_17_9 = var_17_6.GetComponent

			typeof = var_2_10009
			PinchZoom = var_2_10011
			var_17_9(var_17_8, var_2_10009(var_2_10011)).enabled = false
		end

		if var_17_7 then
			local var_17_10 = var_17_7
			local var_17_11 = var_17_7.GetComponent

			typeof = var_2_10009
			PinchZoom = var_2_10011
			var_17_11(var_17_10, var_2_10009(var_2_10011)).enabled = false
		end

		if arg_15_0.selectFrameId == var_15_3 then
			var_15_2(var_17_1)
		else
			setActive = var_6

			var_6(var_17_1, false)
		end

		var_15_2(var_17_1)

		return
	end), true, true)

	table = var_1_10011

	local var_15_10 = var_1_10011.insert
	local var_15_11

	if not arg_15_0.loadingIdList then
		var_15_11 = {}
	end

	var_15_10(var_15_11, var_15_9)

	return
end

function var_0_1.TakePhoto(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = {}
	local var_18_1 = {}
	local var_18_2 = {}

	pg = var_1_10008

	local var_18_3 = var_1_10008.share_template[arg_18_1]

	assert = var_1_10009

	var_1_10009(var_18_3, "share_template not exist: " .. arg_18_1)

	_ = var_1_10009

	var_1_10009.each(var_18_3.hidden_comps, function(arg_19_0)
		GameObject = var_2_10001

		local var_19_0 = var_2_10001.Find(arg_19_0)

		IsNil = var_2_10002

		if not var_2_10002(var_19_0) and var_19_0.activeSelf then
			table = var_2

			var_2.insert(var_18_0, var_19_0)
			var_19_0:SetActive(false)
		end

		return
	end)

	_ = var_9

	var_9.each(var_18_3.show_comps, function(arg_20_0)
		GameObject = var_2_10001

		local var_20_0 = var_2_10001.Find(arg_20_0)

		IsNil = var_2_10002

		if not var_2_10002(var_20_0) and not var_20_0.activeSelf then
			table = var_2

			var_2.insert(var_18_1, var_20_0)
			var_20_0:SetActive(true)
		end

		return
	end)

	_ = var_9

	var_9.each(var_18_3.move_comps, function(arg_21_0)
		GameObject = var_2_10001

		local var_21_0 = var_2_10001.Find(arg_21_0.path)

		IsNil = var_2_10002

		if not var_2_10002(var_21_0) then
			local var_21_1 = var_21_0.transform.anchoredPosition.x
			local var_21_2 = var_21_0.transform.anchoredPosition.y
			local var_21_3 = arg_21_0.x
			local var_21_4 = arg_21_0.y

			table = var_2_10006

			var_2_10006.insert(var_18_2, {
				var_21_0,
				var_21_1,
				var_21_2
			})

			setAnchoredPosition = var_6

			var_6(var_21_0, {
				x = var_21_3,
				y = var_21_4
			})
		end

		return
	end)

	GameObject = var_9

	local var_18_4 = var_9.Find(var_18_3.camera)
	local var_18_5 = var_9.GetComponent

	typeof = var_12
	Camera = var_1_10014

	local var_18_6 = var_18_5(var_18_4, var_12(var_1_10014)).transform
	local var_18_7 = var_10.GetChild(var_18_6, 0)

	local function var_18_8(arg_22_0)
		_ = var_2_10001

		var_2_10001.each(var_18_0, function(arg_23_0)
			arg_23_0:SetActive(true)

			return
		end)

		var_18_0 = {}
		_ = var_1

		var_1.each(var_18_1, function(arg_24_0)
			arg_24_0:SetActive(false)

			return
		end)

		var_18_1 = {}
		_ = var_1

		var_1.each(var_18_2, function(arg_25_0)
			setAnchoredPosition = var_3_10001

			var_3_10001(arg_25_0[1], {
				x = arg_25_0[2],
				y = arg_25_0[3]
			})

			return
		end)

		var_18_2 = {}

		local var_22_0 = arg_18_2.x / var_18_7.sizeDelta.x

		Screen = var_2

		local var_22_1 = var_22_0 * var_2.width
		local var_22_2 = arg_18_2.y / var_18_7.sizeDelta.y

		Screen = var_3

		local var_22_3 = var_22_2 * var_3.height

		UnityEngine = var_3

		local var_22_4 = var_3.Texture2D.New(var_22_1, var_22_3)

		Screen = var_4

		local var_22_5 = (var_4.width - var_22_1) / 2

		Screen = var_5

		local var_22_6 = (var_5.height - var_22_3) / 2
		local var_22_7 = arg_22_0
		local var_22_8 = arg_22_0.GetPixels(var_22_7, var_22_5, var_22_6, var_22_1, var_22_3)

		var_22_4:SetPixels(var_22_8)
		var_22_4:Apply()

		if not arg_18_4 then
			Tex2DExtension = var_7

			local var_22_9 = var_7.EncodeToPNG(var_22_4)

			YSNormalTool = var_22_7

			var_22_7.MediaTool.SaveImageWithBytes(var_22_9, function(arg_26_0, arg_26_1)
				if arg_26_0 then
					pg = var_3_10002

					local var_26_0 = var_3_10002.TipsMgr.GetInstance()
					local var_26_1 = var_2.ShowTips

					i18n = var_3_10005

					var_26_1(var_26_0, var_3_10005("word_save_ok"))
				end

				return
			end)

			return
		end

		local var_22_10 = arg_18_4.x / var_18_7.sizeDelta.x

		Screen = var_8

		local var_22_11 = var_22_10 * var_8.width
		local var_22_12 = arg_18_4.y / var_18_7.sizeDelta.y

		Screen = var_9

		local var_22_13 = var_22_12 * var_9.height
		local var_22_14 = var_22_1 - var_22_11
		local var_22_15 = var_22_3 - var_22_13
		local var_22_16 = var_22_4
		local var_22_17 = var_22_4.GetPixels(var_22_16, var_22_14 / 2, var_22_15 / 2, var_22_11, var_22_13)
		local var_22_18 = arg_18_3

		var_12.SetPixels(var_22_18, var_22_14 / 2, var_22_15 / 2, var_22_11, var_22_13, var_22_17)

		Tex2DExtension = var_12

		local var_22_19 = var_12.EncodeToPNG(arg_18_3)

		YSNormalTool = var_22_16

		var_22_16.MediaTool.SaveImageWithBytes(var_22_19, function(arg_27_0, arg_27_1)
			if arg_27_0 then
				pg = var_3_10002

				local var_27_0 = var_3_10002.TipsMgr.GetInstance()
				local var_27_1 = var_2.ShowTips

				i18n = var_3_10005

				var_27_1(var_27_0, var_3_10005("word_save_ok"))
			end

			return
		end)

		return
	end

	BLHX = var_18_6

	var_18_6.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(var_9, var_18_8)

	return
end

function var_0_1.OnHide(arg_28_0)
	pg = var_1_10001

	local var_28_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_28_0, arg_28_0._tf)

	return
end

function var_0_1.OnDestroy(arg_29_0)
	arg_29_0:OnHide()

	ipairs = var_1

	local var_29_0

	if not arg_29_0.loadingIdList then
		var_29_0 = {}
	end

	for iter_29_0, iter_29_1 in var_1(var_29_0) do
		IslandAssetLoadDispatcher = var_1_10006

		local var_29_1 = var_1_10006.Instance

		var_1_10006.Cancel(var_29_1, iter_29_1)
	end

	arg_29_0.loadingIdList = nil

	return
end

return var_0_1
