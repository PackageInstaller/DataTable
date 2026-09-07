local Dorm3dDanceGameSubView = class("Dorm3dDanceGameSubView", import("..Dorm3dGameBaseSubView"))

function Dorm3dDanceGameSubView:Init()
	self.gamePanel = self._tf:Find("main")
	self.cameraContainer = self.gamePanel:Find("camera")
	self.gameCucoloris = self.gamePanel:Find("cucoloris")
	self.gamePhotos = self.gamePanel:Find("photos")
	self.btnHide = self.gamePanel:Find("bottom/btn_hide")
	self.btnPhoto = self.gamePanel:Find("bottom/btn_photo")
	self.btnGameEnd = self.gamePanel:Find("bottom/game_end")
	self.photoCountText = self.gamePanel:Find("bottom/count")
	self.photoTpl = self.gamePanel:Find("tpl")
	self.gameHideClickUI = self._tf:Find("hide_click")

	setActive(self.gameHideClickUI, false)
	setText(self.btnGameEnd:Find("Text"), i18n("dorm3d_cafe_minigame3"))
	onButton(self, self.btnHide, function()
		setActive(self.gamePanel, false)
		setActive(self.gameHideClickUI, true)
		self.contextData.onShowOrHideBaseUI(false)

		return
	end, SFX_DORM_CLICK)
	onButton(self, self.gameHideClickUI, function()
		setActive(self.gamePanel, true)
		setActive(self.gameHideClickUI, false)
		self.contextData.onShowOrHideBaseUI(true)

		return
	end, SFX_DORM_CLICK)
	onButton(self, self.btnPhoto, function()
		self.contextData.onTakePhoto()

		return
	end, SFX_DORM_CLICK)
	onButton(self, self.btnGameEnd, function()
		self.contextData.onEndGame()

		return
	end, SFX_DORM_CLICK)
	onButton(self, self.gamePhotos, function()
		if #self.contextData.photoData == 0 then
			return
		end

		self.contextData.onShowPhotoWindow(#self.contextData.photoData)

		return
	end)

	self.gameConfig = pg.dorm3d_dance[self.contextData.groupId]
	self.cameraItemList = UIItemList.New(self.cameraContainer, self.cameraContainer:Find("tpl"))

	self.cameraItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		self:UpdateCameraFunc(arg_7_0, arg_7_1, arg_7_2)

		return
	end)

	self.selectedCameraIndex = 1

	return
end

function Dorm3dDanceGameSubView:UpdateCameraFunc(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_2 + 1
	local var_8_1 = self.gameConfig.camera_tracks[arg_8_2 + 1]

	if arg_8_1 == UIItemList.EventUpdate then
		local var_8_2 = arg_8_2 + 1 == self.selectedCameraIndex

		setActive(arg_8_3:Find("selected"), arg_8_2 + 1 == self.selectedCameraIndex)
		setActive(arg_8_3:Find("normal"), not var_8_2)
	elseif arg_8_1 == UIItemList.EventInit then
		setText(arg_8_3:Find("selected/Text"), self.gameConfig.camera_names[arg_8_2 + 1])
		setText(arg_8_3:Find("normal/Text"), self.gameConfig.camera_names[arg_8_2 + 1])
		onButton(self, arg_8_3, function()
			if self.selectedCameraIndex ~= var_8_0 then
				self.selectedCameraIndex = var_8_0

				self.contextData.onSwitchCamera(var_8_1)
				self:FlushCamera()
			end

			return
		end, SFX_DORM_CLICK)
	end

	return
end

function Dorm3dDanceGameSubView:FlushCamera()
	self.cameraItemList:align(#self.gameConfig.camera_names)

	return
end

function Dorm3dDanceGameSubView:Flush()
	setText(self._tf:Find("main/hint"), i18n("dorm3d_cafe_minigame2", (ShipGroup.getDefaultShipNameByGroupID(self.contextData.groupId))))

	local var_11_0 = #self.contextData.photoData
	local var_11_1 = #self.contextData.photoData >= Dorm3dDanceConst.PHOTO_TIMES

	setActive(self.btnPhoto, not (#self.contextData.photoData >= Dorm3dDanceConst.PHOTO_TIMES))
	setActive(self.photoCountText, not var_11_1)
	setText(self.photoCountText, var_11_0 .. "/" .. Dorm3dDanceConst.PHOTO_TIMES)
	setActive(self.btnGameEnd, var_11_1)
	self:FlushCamera()

	for iter_11_0 = 1, #self.contextData.cucoloris do
		LoadImageSpriteAtlasAsync(self.contextData.cucoloris[iter_11_0]:GetIcon(), "", self.gameCucoloris:GetChild(iter_11_0 - 1):Find("Image"), true)
	end

	if var_11_0 > self.gamePhotos.childCount then
		local var_11_2 = cloneTplTo(self.photoTpl, self.gamePhotos)

		var_11_2.localPosition = Vector3(math.random(Dorm3dDanceConst.GAME_RANDOM_RANGE_POSX[1], Dorm3dDanceConst.GAME_RANDOM_RANGE_POSX[2]), math.random(Dorm3dDanceConst.GAME_RANDOM_RANGE_POSY[1], Dorm3dDanceConst.GAME_RANDOM_RANGE_POSY[2]), 0)
		var_11_2.localEulerAngles = Vector3(0, 0, (math.random(Dorm3dDanceConst.GAME_RANDOM_RANGE_ANGLE[1], Dorm3dDanceConst.GAME_RANDOM_RANGE_ANGLE[2])))

		self.contextData.onShowRealImage(var_11_0, var_11_2:Find("mask/Image"), var_11_2:Find("mask"))
	end

	return
end

function Dorm3dDanceGameSubView:ClearPhoto()
	for iter_12_0 = self.gamePhotos.childCount, 1, -1 do
		Destroy(self.gamePhotos:GetChild(iter_12_0 - 1).gameObject)
	end

	return
end

return Dorm3dDanceGameSubView
