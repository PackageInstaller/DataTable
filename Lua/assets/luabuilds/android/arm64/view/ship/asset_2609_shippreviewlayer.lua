local ShipPreviewLayer = class("ShipPreviewLayer", import("..base.BaseUI"))
local var_0_3 = Vector3(0, 1, 40)

function ShipPreviewLayer:getUIName()
	return "ShipPreviewUI"
end

function ShipPreviewLayer:init()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.UIMain = pg.UIMgr.GetInstance().UIMain
	self.seaCameraGO = GameObject.Find("BarrageCamera")
	self.leftPanel = self._tf:Find("left_panel")
	self.sea = self.leftPanel:Find("sea")
	self.seaCamera = self.seaCameraGO:GetComponent("Camera")
	self.seaCamera.enabled = true
	self.rawImage = self.sea:GetComponent("RawImage")

	setActive(self.rawImage, false)

	self.seaCamera.targetTexture = self.rawImage.texture
	self.healTF = self._tf:Find("resources/heal")
	self.healTF.transform.localPosition = Vector3(-360, 50, 40)

	setActive(self.healTF, false)
	self.healTF:GetComponent("DftAniEvent"):SetEndEvent(function()
		setActive(self.healTF, false)
		setText(self.healTF:Find("text"), "")

		return
	end)

	self.seaLoading = self.leftPanel:Find("bg/loading")

	self:playLoadingAni()

	return
end

function ShipPreviewLayer:didEnter()
	onButton(self, self.seaLoading, function()
		if not self.previewer then
			self:showBarrage()
		end

		return
	end)
	onButton(self, self._tf, function()
		self:emit(ShipPreviewLayer.ON_CLOSE)

		return
	end)

	return
end

function ShipPreviewLayer:setShip(arg_7_1, arg_7_2, arg_7_3)
	self.shipVO = arg_7_1
	self.weaponIds = arg_7_2
	self.equipSkinId = arg_7_3

	return
end

function ShipPreviewLayer:showBarrage()
	self.previewer = WeaponPreviewer.New(self.rawImage)

	self.previewer:configUI(self.healTF)
	self.previewer:setDisplayWeapon(self.weaponIds, self.equipSkinId, true)
	self.previewer:load(40000, self.shipVO, self.weaponIds, function()
		self:stopLoadingAni()

		return
	end)

	return
end

function ShipPreviewLayer:getWaponIdsById(arg_10_1)
	return self.ship_data_breakout[arg_10_1].weapon_ids
end

function ShipPreviewLayer:playLoadingAni()
	setActive(self.seaLoading, true)

	return
end

function ShipPreviewLayer:stopLoadingAni()
	setActive(self.seaLoading, false)

	return
end

function ShipPreviewLayer:willExit()
	self.seaCamera.enabled = false

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.UIMain)

	if self.previewer then
		self.previewer:clear()

		self.previewer = nil
	end

	return
end

return ShipPreviewLayer
