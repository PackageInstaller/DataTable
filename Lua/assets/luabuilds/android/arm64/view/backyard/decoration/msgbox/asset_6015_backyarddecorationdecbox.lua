local BackYardDecorationDecBox = class("BackYardDecorationDecBox", import("....base.BaseSubView"))

function BackYardDecorationDecBox:getUIName()
	return "BackYardDecorationDescUI"
end

function BackYardDecorationDecBox:OnLoaded()
	self.nameTxt = self._tf:Find("name_bg/Text"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("Text"):GetComponent(typeof(Text))
	self.icon = self._tf:Find("icon_bg/icon"):GetComponent(typeof(Image))
	self.shipIcon = self._tf:Find("icon_bg/ship"):GetComponent(typeof(Image))
	self.width = self._tf.rect.width
	self.prantLeftBound = self._tf.parent.rect.width / 2

	return
end

function BackYardDecorationDecBox:shortenString(arg_3_1, arg_3_2)
	local var_3_0 = string.gmatch(arg_3_1, "<color=#%w+>")()
	local var_3_1, var_3_2 = string.find(arg_3_1, "<color=#%w+>")

	if not var_3_1 then
		return shortenString(arg_3_1, arg_3_2)
	end

	local var_3_3, var_3_4 = string.find(arg_3_1, "</color>")
	local var_3_5 = string.sub(arg_3_1, 1, var_3_1 - 1)
	local var_3_6 = string.sub(arg_3_1, var_3_2 + 1, var_3_3 - 1)
	local var_3_7 = ""
	local var_3_8 = 0

	for iter_3_0, iter_3_1 in ipairs({
		var_3_5,
		var_3_6,
		(string.sub(arg_3_1, var_3_4 + 1, string.len(arg_3_1)))
	}) do
		var_3_7 = var_3_7 .. iter_3_1
		var_3_8 = iter_3_0

		if shouldShortenString(var_3_7, arg_3_2) then
			break
		end
	end

	if var_3_8 <= 1 then
		return shortenString(var_3_7, arg_3_2)
	else
		local var_3_9 = shortenString(var_3_7, arg_3_2)

		if var_3_5 == "" then
			return string.gsub(var_3_9, var_3_6, var_3_0 .. var_3_6) .. "</color>"
		else
			return string.gsub(var_3_9, var_3_5, var_3_5 .. var_3_0) .. "</color>"
		end
	end

	return
end

function BackYardDecorationDecBox:SetUp(arg_4_1, arg_4_2, arg_4_3)
	if self.furniture ~= arg_4_1 then
		self.nameTxt.text = shortenString(HXSet.hxLan(arg_4_1:getConfig("name")), 10)
		self.descTxt.text = self:shortenString(HXSet.hxLan(arg_4_1:getConfig("describe")), 41)
		self.icon.sprite = LoadSprite("furnitureicon/" .. arg_4_1:getConfig("icon"))

		self.icon:SetNativeSize()
	end

	self._tf.position = arg_4_2

	if arg_4_3 then
		self._tf.localPosition = Vector3(self._tf.localPosition.x, self._tf.localPosition.y - self._tf.rect.height, 0)
	end

	if self._tf.localPosition.x + self.width > self.prantLeftBound then
		self._tf.localPosition = Vector3(self._tf.localPosition.x - self.width, self._tf.localPosition.y, self._tf.localPosition.z)
	end

	self.furniture = arg_4_1

	self:UpdateSkinType()
	self:Show()

	return
end

function BackYardDecorationDecBox:UpdateSkinType()
	local var_5_0 = Goods.FurnitureId2Id(self.furniture.id)
	local var_5_1 = Goods.ExistFurniture(var_5_0)

	setActive(self.shipIcon, var_5_1)

	if var_5_1 then
		GetImageSpriteFromAtlasAsync("QIcon/" .. pg.ship_skin_template[Goods.Id2ShipSkinId(Goods.GetFurnitureConfig(var_5_0).id)].prefab, "", self.shipIcon.gameObject)
	end

	return
end

function BackYardDecorationDecBox:OnDestroy()
	return
end

return BackYardDecorationDecBox
