class = var_0_10000

local var_0_0 = "Dorm3dDanceGameSubView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..Dorm3dGameBaseSubView"))

function var_0_1.Init(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.gamePanel = var_1.Find(var_1_0, "main")

	local var_1_1 = arg_1_0.gamePanel

	arg_1_0.cameraContainer = var_1.Find(var_1_1, "camera")

	local var_1_2 = arg_1_0.gamePanel

	arg_1_0.gameCucoloris = var_1.Find(var_1_2, "cucoloris")

	local var_1_3 = arg_1_0.gamePanel

	arg_1_0.gamePhotos = var_1.Find(var_1_3, "photos")

	local var_1_4 = arg_1_0.gamePanel

	arg_1_0.btnHide = var_1.Find(var_1_4, "bottom/btn_hide")

	local var_1_5 = arg_1_0.gamePanel

	arg_1_0.btnPhoto = var_1.Find(var_1_5, "bottom/btn_photo")

	local var_1_6 = arg_1_0.gamePanel

	arg_1_0.btnGameEnd = var_1.Find(var_1_6, "bottom/game_end")

	local var_1_7 = arg_1_0.gamePanel

	arg_1_0.photoCountText = var_1.Find(var_1_7, "bottom/count")

	local var_1_8 = arg_1_0.gamePanel

	arg_1_0.photoTpl = var_1.Find(var_1_8, "tpl")

	local var_1_9 = arg_1_0._tf

	arg_1_0.gameHideClickUI = var_1.Find(var_1_9, "hide_click")
	setActive = var_1

	var_1(arg_1_0.gameHideClickUI, false)

	setText = var_1

	local var_1_10 = arg_1_0.btnGameEnd
	local var_1_11 = var_2.Find(var_1_10, "Text")

	i18n = var_1_10

	var_1(var_1_11, var_1_10("dorm3d_cafe_minigame3"))

	onButton = var_1

	local var_1_12 = arg_1_0
	local var_1_13 = arg_1_0.btnHide

	local function var_1_14()
		setActive = var_2_10000

		var_2_10000(arg_1_0.gamePanel, false)

		setActive = var_2_10000

		var_2_10000(arg_1_0.gameHideClickUI, true)
		arg_1_0.contextData.onShowOrHideBaseUI(false)

		return
	end

	SFX_DORM_CLICK = var_1_10005

	var_1(var_1_12, var_1_13, var_1_14, var_1_10005)

	onButton = var_1

	local var_1_15 = arg_1_0
	local var_1_16 = arg_1_0.gameHideClickUI

	local function var_1_17()
		setActive = var_2_10000

		var_2_10000(arg_1_0.gamePanel, true)

		setActive = var_2_10000

		var_2_10000(arg_1_0.gameHideClickUI, false)
		arg_1_0.contextData.onShowOrHideBaseUI(true)

		return
	end

	SFX_DORM_CLICK = var_1_10005

	var_1(var_1_15, var_1_16, var_1_17, var_1_10005)

	onButton = var_1

	local var_1_18 = arg_1_0
	local var_1_19 = arg_1_0.btnPhoto

	local function var_1_20()
		arg_1_0.contextData.onTakePhoto()

		return
	end

	SFX_DORM_CLICK = var_1_10005

	var_1(var_1_18, var_1_19, var_1_20, var_1_10005)

	onButton = var_1

	local var_1_21 = arg_1_0
	local var_1_22 = arg_1_0.btnGameEnd

	local function var_1_23()
		arg_1_0.contextData.onEndGame()

		return
	end

	SFX_DORM_CLICK = var_1_10005

	var_1(var_1_21, var_1_22, var_1_23, var_1_10005)

	onButton = var_1

	var_1(arg_1_0, arg_1_0.gamePhotos, function()
		if #arg_1_0.contextData.photoData == 0 then
			return
		end

		arg_1_0.contextData.onShowPhotoWindow(#arg_1_0.contextData.photoData)

		return
	end)

	pg = var_1
	arg_1_0.gameConfig = var_1.dorm3d_dance[arg_1_0.contextData.groupId]
	UIItemList = var_1

	local var_1_24 = var_1.New
	local var_1_25 = arg_1_0.cameraContainer
	local var_1_26 = arg_1_0.cameraContainer

	arg_1_0.cameraItemList = var_1_24(var_1_25, var_3.Find(var_1_26, "tpl"))

	local var_1_27 = arg_1_0.cameraItemList

	var_1.make(var_1_27, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0

		var_3.UpdateCameraFunc(var_7_0, arg_7_0, arg_7_1, arg_7_2)

		return
	end)

	arg_1_0.selectedCameraIndex = 1

	return
end

function var_0_1.UpdateCameraFunc(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_2 + 1
	local var_8_1 = arg_8_0.gameConfig.camera_names[var_8_0]
	local var_8_2 = arg_8_0.gameConfig.camera_tracks[var_8_0]

	UIItemList = var_1_10007

	local var_8_3

	if arg_8_1 == var_1_10007.EventUpdate then
		var_8_3 = var_8_0 == arg_8_0.selectedCameraIndex
		setActive = var_1_10008

		var_1_10008(arg_8_3:Find("selected"), var_8_3)

		setActive = var_1_10008

		var_1_10008(arg_8_3:Find("normal"), not var_8_3)
	else
		UIItemList = var_8_3

		if arg_8_1 == var_8_3.EventInit then
			setText = var_7

			var_7(arg_8_3:Find("selected/Text"), var_8_1)

			setText = var_7

			var_7(arg_8_3:Find("normal/Text"), var_8_1)

			onButton = var_7

			local var_8_4 = arg_8_0
			local var_8_5 = arg_8_3

			local function var_8_6()
				if arg_8_0.selectedCameraIndex ~= var_8_0 then
					arg_8_0.selectedCameraIndex = var_8_0

					arg_8_0.contextData.onSwitchCamera(var_8_2)

					local var_9_0 = arg_8_0

					var_0.FlushCamera(var_9_0)
				end

				return
			end

			SFX_DORM_CLICK = var_1_10011

			var_7(var_8_4, var_8_5, var_8_6, var_1_10011)
		end
	end

	return
end

function var_0_1.FlushCamera(arg_10_0)
	local var_10_0 = arg_10_0.cameraItemList

	var_1.align(var_10_0, #arg_10_0.gameConfig.camera_names)

	return
end

function var_0_1.Flush(arg_11_0)
	ShipGroup = var_1_10001

	local var_11_0 = var_1_10001.getDefaultShipNameByGroupID(arg_11_0.contextData.groupId)

	setText = var_2

	local var_11_1 = arg_11_0._tf
	local var_11_2 = var_3.Find(var_11_1, "main/hint")

	i18n = var_11_1

	var_2(var_11_2, var_11_1("dorm3d_cafe_minigame2", var_11_0))

	local var_11_3 = #arg_11_0.contextData.photoData

	Dorm3dDanceConst = var_11_2

	local var_11_4 = var_11_3 >= var_11_2.PHOTO_TIMES

	setActive = var_4

	var_4(arg_11_0.btnPhoto, not var_11_4)

	setActive = var_4

	var_4(arg_11_0.photoCountText, not var_11_4)

	setText = var_4

	local var_11_5 = arg_11_0.photoCountText
	local var_11_6 = var_11_3
	local var_11_7 = "/"

	Dorm3dDanceConst = var_1_10008

	var_4(var_11_5, var_11_6 .. var_11_7 .. var_1_10008.PHOTO_TIMES)

	setActive = var_4

	var_4(arg_11_0.btnGameEnd, var_11_4)
	arg_11_0:FlushCamera()

	for iter_11_0 = 1, #arg_11_0.contextData.cucoloris do
		var_1_10009 = arg_11_0.gameCucoloris

		local var_11_8 = var_11_8.GetChild(var_1_10009, iter_11_0 - 1)

		LoadImageSpriteAtlasAsync = var_1_10009

		local var_11_9 = arg_11_0.contextData.cucoloris[iter_11_0]

		var_1_10009(var_10.GetIcon(var_11_9), "", var_11_8:Find("Image"), true)
	end

	if arg_11_0.gamePhotos.childCount < var_11_3 then
		cloneTplTo = var_4

		local var_11_10 = var_4(arg_11_0.photoTpl, arg_11_0.gamePhotos)

		math = var_5

		local var_11_11 = var_5.random

		Dorm3dDanceConst = var_6

		local var_11_12 = var_6.GAME_RANDOM_RANGE_POSX[1]

		Dorm3dDanceConst = iter_11_0

		local var_11_13 = var_11_11(var_11_12, iter_11_0.GAME_RANDOM_RANGE_POSX[2])

		math = var_11_12

		local var_11_14 = var_11_12.random

		Dorm3dDanceConst = var_7

		local var_11_15 = var_7.GAME_RANDOM_RANGE_POSY[1]

		Dorm3dDanceConst = var_11_8

		local var_11_16 = var_11_14(var_11_15, var_11_8.GAME_RANDOM_RANGE_POSY[2])

		math = var_11_15

		local var_11_17 = var_11_15.random

		Dorm3dDanceConst = var_8

		local var_11_18 = var_8.GAME_RANDOM_RANGE_ANGLE[1]

		Dorm3dDanceConst = var_1_10009

		local var_11_19 = var_11_17(var_11_18, var_1_10009.GAME_RANDOM_RANGE_ANGLE[2])

		Vector3 = var_11_18
		var_11_10.localPosition = var_11_18(var_11_13, var_11_16, 0)
		Vector3 = var_8
		var_11_10.localEulerAngles = var_8(0, 0, var_11_19)

		arg_11_0.contextData.onShowRealImage(var_11_3, var_11_10:Find("mask/Image"), var_11_10:Find("mask"))
	end

	return
end

function var_0_1.ClearPhoto(arg_12_0)
	for iter_12_0 = arg_12_0.gamePhotos.childCount, 1, -1 do
		Destroy = var_1_10005

		local var_12_0 = arg_12_0.gamePhotos

		var_1_10005(var_6.GetChild(var_12_0, iter_12_0 - 1).gameObject)
	end

	return
end

return var_0_1
