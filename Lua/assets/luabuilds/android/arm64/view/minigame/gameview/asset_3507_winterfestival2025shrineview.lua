local WinterFestival2025ShrineView = class("WinterFestival2025ShrineView", import(".Shrine2022View"))

WinterFestival2025ShrineView.SHRINE_SELECT_SHIP_VIEW_CLS = WinterFestival2025ShrineSelectShipView
WinterFestival2025ShrineView.SHRINE_SHIP_WORD_VIEW_CLS = WinterFestival2025ShrineShipWordView
WinterFestival2025ShrineView.SHRINE_SELECT_BUFF_VIEW_CLS = WinterFestival2025ShrineSelectBuffView

function WinterFestival2025ShrineView:getUIName()
	return "WinterFestival2025ShrineUI"
end

function WinterFestival2025ShrineView:setUIData()
	local var_2_0 = self._tf:Find("Res")

	self.curBuffSpriteList = {
		getImageSprite(var_2_0:Find("CurBuff1")),
		getImageSprite(var_2_0:Find("CurBuff2")),
		(getImageSprite(var_2_0:Find("CurBuff3")))
	}
	self.shipCardSpriteList = {}

	for iter_2_0 = 1, 7 do
		table.insert(self.shipCardSpriteList, (getImageSprite(var_2_0:Find("ShipCard" .. iter_2_0))))
	end

	self.shipNameSpriteList = {}

	for iter_2_1 = 1, 7 do
		table.insert(self.shipNameSpriteList, (getImageSprite(var_2_0:Find("ShipName" .. iter_2_1))))
	end

	self.shipNameTextList = {
		Ship.getShipName(19),
		Ship.getShipName(105141),
		Ship.getShipName(702051),
		Ship.getShipName(607021),
		Ship.getShipName(9),
		Ship.getShipName(19),
		Ship.getShipName(407011)
	}
	self.curBuffPosStart = 217
	self.curBuffPosEnd = -130

	setText(self._tf:Find("Data/Count2"), i18n("winterwish_20251225_tip1"))
	setText(self._tf:Find("Data/Count/Tip"), i18n("winterwish_20251225_tip2"))

	self.countText = self._tf:Find("Data/Count/Text")
	self.countText2 = self._tf:Find("Data/Count2/BG/Text")

	return
end

function WinterFestival2025ShrineView:updateShipCardUI(arg_3_1, arg_3_2)
	WinterFestival2025ShrineView.super.updateShipCardUI(self, arg_3_1, arg_3_2)
	setScrollText(arg_3_1:Find("NameMask/NameText"), self.shipNameTextList[arg_3_2])

	return
end

return WinterFestival2025ShrineView
