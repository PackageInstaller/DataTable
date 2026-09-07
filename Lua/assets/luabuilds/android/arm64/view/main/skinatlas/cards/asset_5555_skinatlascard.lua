local SkinAtlasCard = class("SkinAtlasCard")

function SkinAtlasCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.usingTr = findTF(self._tf, "using")
	self.unavailableTr = findTF(self._tf, "unavailable")
	self.have = self._tf:Find("have")
	self.icon = findTF(self._tf, "mask/icon")
	self.name = findTF(self._tf, "name/Text"):GetComponent(typeof(Text))
	self.enName = findTF(self._tf, "name/en"):GetComponent(typeof(Text))
	self.tags = findTF(self._tf, "tags")
	self.changeSkinUI = findTF(self._tf, "changeSkin")
	self.changeSkinToggle = nil

	setText(self.usingTr:Find("Text"), i18n("shop_new_in_use"))
	setText(self.unavailableTr:Find("Text"), i18n("shop_new_unable_to_use"))
	setText(self.have:Find("Text"), i18n("shop_new_owned"))
	setActive()

	return
end

function SkinAtlasCard:Update(arg_2_1, arg_2_2, arg_2_3)
	self.index = arg_2_2
	self.skin = arg_2_1

	GetImageSpriteFromAtlasAsync("shipYardIcon/" .. arg_2_1:getConfig("painting"), "", self.icon)

	local var_2_0 = pg.ship_skin_template[self.skin.id]

	if pg.ship_skin_template[self.skin.id].skin_type ~= ShipSkin.SKIN_TYPE_TB then
		local var_2_1 = arg_2_1:getConfig("ship_group")
		local var_2_2 = not arg_2_1:WithoutUse()
		local var_2_3 = #getProxy(BayProxy):findShipsByGroup(var_2_1) == 0 or getProxy(CollectionProxy).shipGroups[var_2_1] == nil
	end

	setActive(self.usingTr, false)
	setActive(self.unavailableTr, false)

	if arg_2_3 then
		setActive(self.have, (getProxy(ShipSkinProxy):hasSkin(self.skin.id)))
	else
		setActive(self.have, false)
	end

	self.name.text = shortenString(arg_2_1:getConfig("name"), 7)
	self.enName.text = var_2_0.skin_type == ShipSkin.SKIN_TYPE_TB and NewEducateHelper.GetShipNameBySecId(NewEducateHelper.GetSecIdBySkinId(self.skinId)) or ShipGroup.getDefaultShipConfig(var_2_0.ship_group).english_name

	local var_2_4 = ShipSkin.GetChangeSkinData(self.skin.id)

	setActive(self.changeSkinUI, var_2_4 and true or false)

	if var_2_4 then
		self.changeSkinToggle = self.changeSkinToggle or ChangeSkinToggle.New(findTF(self.changeSkinUI, "ChangeSkinToggleUI"))

		self.changeSkinToggle:setSkinData(self.skin.id)
		setActive(self.changeSkinUI, not self.changeSkinToggle:IsAsmrSkin())
	end

	self:FlushTags(arg_2_1:getConfig("tag"))

	return
end

function SkinAtlasCard:changeSkinNext()
	if ShipSkin.GetChangeSkinData(self.skin.id) then
		self:Update(ShipSkin.New({
			id = ShipSkin.GetChangeSkinNextId(self.skin.id)
		}), self.index)
	end

	return
end

function SkinAtlasCard:FlushTags(arg_4_1)
	local var_4_0 = findTF(self._tf, "tags/icon")

	if #arg_4_1 > self.tags.childCount then
		for iter_4_0 = self.tags.childCount + 1, #arg_4_1 do
			local var_4_1 = Object.Instantiate(var_4_0, var_4_0.parent)
		end
	end

	for iter_4_1 = 1, #arg_4_1 do
		local var_4_2 = self.tags:GetChild(iter_4_1 - 1)

		setActive(var_4_2, true)
		LoadSpriteAtlasAsync("SkinIcon", "type_" .. ShipSkin.Tag2Name(arg_4_1[iter_4_1]) .. "_own", function(arg_5_0)
			if self.exited then
				return
			end

			local var_5_0 = var_4_2:GetComponent(typeof(Image))

			var_5_0.sprite = arg_5_0

			var_5_0:SetNativeSize()

			return
		end)

		var_4_2.localPosition = Vector3(var_4_2.localPosition.x, var_4_0.localPosition.y - (iter_4_1 - 1) * (var_4_0.sizeDelta.y + -10), 0)
	end

	if self.tags.childCount > #arg_4_1 then
		for iter_4_2 = #arg_4_1 + 1, self.tags.childCount do
			setActive(self.tags:GetChild(iter_4_2 - 1), false)
		end
	end

	return
end

function SkinAtlasCard:Dispose()
	self.exited = true

	return
end

return SkinAtlasCard
