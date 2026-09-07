local CourtyardInteractionPreview = class("CourtyardInteractionPreview", import("view.base.BaseSubView"))

function CourtyardInteractionPreview:getUIName()
	return "BackYardInterActionPreview"
end

function CourtyardInteractionPreview:OnLoaded()
	self.closeBtn = self._tf:Find("frame/close")
	self.mask = self._tf:Find("frame/mask")

	return
end

function CourtyardInteractionPreview:OnInit()
	onButton(self, self._tf, function()
		self:Destroy()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Destroy()

		return
	end, SFX_PANEL)
	setText(self._tf:Find("frame/title"), i18n("word_preview"))

	return
end

function CourtyardInteractionPreview:Show(arg_6_1, arg_6_2)
	CourtyardInteractionPreview.super.Show(self)

	self.storeyId = 999
	self.furnitureId = arg_6_1
	self.shipId = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[arg_6_2].ship_group).id
	self.shipSkinId = arg_6_2
	self.furniturePosition = Vector2(0, 0)
	self.step = 0
	self.instance = nil

	self:SetUp()

	return
end

function CourtyardInteractionPreview:SetUp()
	setActive(self.mask, false)

	self.instance = CourtYardBridge.New(self:GenCourtYardData(id))

	local var_7_0 = self.instance:GetController()
	local var_7_1 = self.instance:GetView()
	local var_7_2 = self:GetPutFurniture()

	self.timer = Timer.New(function()
		if self.step == 2 then
			local var_8_0 = var_7_0:GetStorey():GetFurniture(var_7_2.id)

			if var_8_0 and not var_8_0:AnySlotIsLoop() and not var_8_0:IsInteractionState() then
				GetOrAddComponent(var_7_1:GetRect(), typeof(CanvasGroup)).alpha = 0

				setActive(self.mask, true)
				onButton(self, self.mask, function()
					self.step = 1

					setActive(self.mask, false)

					return
				end, SFX_PANEL)

				self.step = 3
			end
		end

		if self.step == 1 then
			if var_7_1:GetCurrStorey():ItemsIsLoaded() then
				self:StartInteraction(var_7_0)

				GetOrAddComponent(var_7_1:GetRect(), typeof(CanvasGroup)).alpha = 1
				self.step = 2
			end
		end

		if var_7_1:IsInit() and var_7_0:IsLoaed() and self.step == 0 then
			self.step = 1
			GetOrAddComponent(var_7_1:GetRect(), typeof(CanvasGroup)).alpha = 0

			var_7_0:AddFurniture(var_7_2)
			var_7_0:AddShip(self:GetPutShip())
		end

		return
	end, 0.01, -1)

	self.timer:Start()

	return
end

function CourtyardInteractionPreview:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CourtyardInteractionPreview:StartInteraction(arg_11_1)
	if self.shipId then
		arg_11_1:DragShip(self.shipId)
		arg_11_1:DragShipEnd(self.shipId, self.furniturePosition)
	end

	return
end

function CourtyardInteractionPreview:Hide()
	CourtyardInteractionPreview.super.Hide(self)
	self:RemoveTimer()

	if self.instance then
		self.instance:Dispose()
	end

	self.instance = nil

	return
end

function CourtyardInteractionPreview:GenCourtYardData()
	local var_13_0 = {}
	local var_13_1 = {
		id = self.storeyId
	}

	var_13_1.level = 4
	var_13_1.furnitures = {}
	var_13_1.ships = {}
	var_13_0[self.storeyId] = var_13_1

	return {
		system = CourtYardConst.SYSTEM_VISIT,
		storeys = var_13_0,
		storeyId = self.storeyId,
		style = CourtYardConst.STYLE_PREVIEW,
		mapSize = Dorm.StaticGetMapSize(4),
		name = self:getUIName()
	}
end

function CourtyardInteractionPreview:GetPutFurniture()
	return (BackyardThemeFurniture.New({
		id = 9999,
		isNewStyle = true,
		configId = self.furnitureId,
		position = self.furniturePosition
	}))
end

function CourtyardInteractionPreview:GetPutShip()
	if not self.shipId or self.shipId <= 0 then
		return {}
	end

	return (Ship.New({
		id = self.shipId,
		template_id = self.shipId,
		skin_id = self.shipSkinId
	}))
end

function CourtyardInteractionPreview:OnDestroy()
	self:Hide()

	return
end

return CourtyardInteractionPreview
