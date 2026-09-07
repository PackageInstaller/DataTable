local WinterFestival2025ShrineSelectShipView = class("WinterFestival2025ShrineSelectShipView", import(".Shrine2022SelectShipView"))

function WinterFestival2025ShrineSelectShipView:getUIName()
	return "WinterFestival2025ShrineSelectShipUI"
end

function WinterFestival2025ShrineSelectShipView:setUIData()
	local var_2_0 = self._tf:Find("Res")

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
	self.cardPosList = {
		{
			x = -75.5,
			y = 290
		},
		{
			x = -75.5,
			y = 67.5
		},
		{
			x = -75.5,
			y = -155
		},
		{
			x = -75.5,
			y = -377.5
		},
		{
			x = 82,
			y = 290
		},
		{
			x = 82,
			y = 67.5
		},
		{
			x = 82,
			y = -155
		}
	}
	self.confirmPosList = {
		{
			x = -372,
			y = 15
		},
		{
			x = -75,
			y = 15
		},
		{
			x = 226,
			y = 15
		},
		{
			x = 523,
			y = 15
		},
		{
			x = -224,
			y = -350
		},
		{
			x = 80,
			y = -350
		},
		{
			x = 380,
			y = -350
		}
	}

	return
end

function WinterFestival2025ShrineSelectShipView:updateShipCardUI(arg_3_1, arg_3_2)
	setImageSprite(arg_3_1, self.shipCardSpriteList[arg_3_2], true)
	setActive(arg_3_1:Find("Name"), false)

	local var_3_0 = arg_3_1:Find("NameMask/Name_Text")

	setScrollText(var_3_0, self.shipNameTextList[arg_3_2])
	setLocalPosition(arg_3_1, self.cardPosList[arg_3_2])

	local var_3_1 = self:isSelected(arg_3_2)

	setActive(arg_3_1:Find("Selected"), var_3_1)
	setActive(var_3_0, not var_3_1)

	GetComponent(arg_3_1, "Toggle").enabled = not var_3_1

	return
end

return WinterFestival2025ShrineSelectShipView
