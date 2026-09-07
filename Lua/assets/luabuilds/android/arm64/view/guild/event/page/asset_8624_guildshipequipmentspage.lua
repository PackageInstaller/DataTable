local GuildShipEquipmentsPage = class("GuildShipEquipmentsPage", import("....base.BaseSubView"))

function GuildShipEquipmentsPage:getUIName()
	return "GuildShipEquipmentsPage"
end

function GuildShipEquipmentsPage:OnLoaded()
	self.shipNameTxt = self._tf:Find("frame/ship_info/shipname"):GetComponent(typeof(Text))
	self.userNameTxt = self._tf:Find("frame/ship_info/username"):GetComponent(typeof(Text))
	self.shipTypeIcon = self._tf:Find("frame/ship_info/ship_type"):GetComponent(typeof(Image))
	self.shipStarList = UIItemList.New(self._tf:Find("frame/ship_info/stars"), self._tf:Find("frame/ship_info/stars/star_tpl"))
	self.shipLvTxt = self._tf:Find("frame/ship_info/lv/Text"):GetComponent(typeof(Text))
	self.equipmentList = UIItemList.New(self._tf:Find("frame/equipemtns"), self._tf:Find("frame/equipemtns/equipment_tpl"))
	self.playerId = getProxy(PlayerProxy):getRawData().id
	self.nextBtn = self._tf:Find("frame/next")
	self.prevBtn = self._tf:Find("frame/prev")

	return
end

function GuildShipEquipmentsPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.nextBtn, function()
		if self.onNext then
			self.onNext()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.prevBtn, function()
		if self.onPrev then
			self.onPrev()
		end

		return
	end, SFX_PANEL)

	return
end

function GuildShipEquipmentsPage:SetCallBack(arg_7_1, arg_7_2)
	self.onPrev = arg_7_1
	self.onNext = arg_7_2

	return
end

function GuildShipEquipmentsPage:Show(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	GuildShipEquipmentsPage.super.Show(self)

	self.OnHide = arg_8_3

	if arg_8_4 then
		arg_8_4()
	end

	self:Flush(arg_8_1, arg_8_2)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setActive(self.nextBtn, self.onNext ~= nil)
	SetActive(self.prevBtn, self.onPrev ~= nil)

	return
end

function GuildShipEquipmentsPage:Flush(arg_9_1, arg_9_2)
	self.ship = arg_9_1
	self.member = arg_9_2

	self:UpdateShipInfo()
	self:UpdateEquipments()

	return
end

function GuildShipEquipmentsPage:Refresh(arg_10_1, arg_10_2)
	self:Flush(arg_10_1, arg_10_2)

	return
end

function GuildShipEquipmentsPage:UpdateShipInfo()
	local var_11_0 = self.member

	self.shipNameTxt.text = self.ship:getName()
	self.userNameTxt.text = self.playerId == var_11_0.id and "" or i18n("guild_ship_from") .. var_11_0.name
	self.shipTypeIcon.sprite = GetSpriteFromAtlas("shiptype", shipType2print(pg.ship_data_statistics[self.ship.configId].type))

	local var_11_1 = self.ship:getStar()

	self.shipStarList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			setActive(arg_12_2:Find("star_tpl"), arg_12_1 <= var_11_1)
		end

		return
	end)
	self.shipStarList:align((self.ship:getMaxStar()))

	self.shipLvTxt.text = self.ship.level

	return
end

function GuildShipEquipmentsPage:UpdateEquipments()
	local var_13_0 = self.ship:getActiveEquipments()

	self.equipmentList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			setActive(arg_14_2:Find("info"), var_13_0[arg_14_1 + 1])
			setActive(arg_14_2:Find("empty"), not var_13_0[arg_14_1 + 1])

			if var_13_0[arg_14_1 + 1] then
				updateEquipment(arg_14_2:Find("info"), var_13_0[arg_14_1 + 1])
				setText(arg_14_2:Find("info/name_bg/Text"), shortenString(var_13_0[arg_14_1 + 1]:getConfig("name"), 5))
			end
		end

		return
	end)
	self.equipmentList:align(5)

	return
end

function GuildShipEquipmentsPage:Hide()
	GuildShipEquipmentsPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	if self.OnHide then
		self.OnHide()

		self.OnHide = nil
	end

	return
end

function GuildShipEquipmentsPage:OnDestroy()
	self:Hide()

	return
end

return GuildShipEquipmentsPage
