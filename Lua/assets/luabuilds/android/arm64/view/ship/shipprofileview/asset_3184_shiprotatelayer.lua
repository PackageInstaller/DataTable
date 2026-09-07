local ShipRotateLayer = class("ShipRotateLayer", import("...base.BaseUI"))

function ShipRotateLayer:getUIName()
	return "ShipRotateUI"
end

function ShipRotateLayer:init()
	self:initData()
	self:findUI()

	return
end

function ShipRotateLayer:didEnter()
	self:SetPainting((self.skin or nil) and (self.skin.id or self.shipGroup:GetSkin(self.showTrans).id), self.showTrans)
	self.paintingView:setBGCallback(function()
		self:closeView()

		return
	end)
	self.paintingView:Start()
	setActive(self._tf:Find("Enc"), true)

	return
end

function ShipRotateLayer:willExit()
	self.paintingView:Dispose()
	self:RecyclePainting()

	return
end

function ShipRotateLayer:initData()
	self.paintingName = nil
	self.shipGroup = self.contextData.shipGroup
	self.showTrans = self.contextData.showTrans
	self.skin = self.contextData.skin

	return
end

function ShipRotateLayer:findUI()
	self.painting = self._tf:Find("paint")
	self.paintingFitter = findTF(self.painting, "fitter")
	self.paintingInitPos = self.painting.transform.localPosition
	self.paintingView = ShipProfilePaintingView.New(self._tf, self.painting, true)

	return
end

function ShipRotateLayer:SetPainting(arg_8_1, arg_8_2)
	self:RecyclePainting()
	setPaintingPrefabAsync(self.painting, pg.ship_skin_template[arg_8_1].painting, "chuanwu")

	self.paintingName = pg.ship_skin_template[arg_8_1].painting

	setLocalEulerAngles(self.painting, {
		z = 90,
		x = self.painting.localEulerAngles.x,
		y = self.painting.localEulerAngles.y
	})

	return
end

function ShipRotateLayer:RecyclePainting()
	if self.paintingName then
		retPaintingPrefab(self.painting, self.paintingName)
	end

	return
end

return ShipRotateLayer
