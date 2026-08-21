local var_0_0 = class("SkinAtlasCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.usingTr = findTF(arg_1_0._tf, "using")
	arg_1_0.unavailableTr = findTF(arg_1_0._tf, "unavailable")
	arg_1_0.have = arg_1_0._tf:Find("have")
	arg_1_0.icon = findTF(arg_1_0._tf, "mask/icon")
	arg_1_0.name = findTF(arg_1_0._tf, "name/Text"):GetComponent(typeof(Text))
	arg_1_0.enName = findTF(arg_1_0._tf, "name/en"):GetComponent(typeof(Text))
	arg_1_0.tags = findTF(arg_1_0._tf, "tags")
	arg_1_0.changeSkinUI = findTF(arg_1_0._tf, "changeSkin")
	arg_1_0.changeSkinToggle = nil

	setText(arg_1_0.usingTr:Find("Text"), i18n("shop_new_in_use"))
	setText(arg_1_0.unavailableTr:Find("Text"), i18n("shop_new_unable_to_use"))
	setText(arg_1_0.have:Find("Text"), i18n("shop_new_owned"))
	setActive()

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.index = arg_2_2
	arg_2_0.skin = arg_2_1

	GetImageSpriteFromAtlasAsync("shipYardIcon/" .. arg_2_1:getConfig("painting"), "", arg_2_0.icon)

	local var_2_0 = pg.ship_skin_template[arg_2_0.skin.id]

	if pg.ship_skin_template[arg_2_0.skin.id].skin_type ~= ShipSkin.SKIN_TYPE_TB then
		local var_2_1 = arg_2_1:getConfig("ship_group")
		local var_2_2 = not arg_2_1:WithoutUse()
		local var_2_3 = #getProxy(BayProxy):findShipsByGroup(var_2_1) == 0 or getProxy(CollectionProxy).shipGroups[var_2_1] == nil
	end

	setActive(arg_2_0.usingTr, false)
	setActive(arg_2_0.unavailableTr, false)

	if arg_2_3 then
		setActive(arg_2_0.have, (getProxy(ShipSkinProxy):hasSkin(arg_2_0.skin.id)))
	else
		setActive(arg_2_0.have, false)
	end

	arg_2_0.name.text = shortenString(arg_2_1:getConfig("name"), 7)
	arg_2_0.enName.text = var_2_0.skin_type == ShipSkin.SKIN_TYPE_TB and NewEducateHelper.GetShipNameBySecId(NewEducateHelper.GetSecIdBySkinId(arg_2_0.skinId)) or ShipGroup.getDefaultShipConfig(var_2_0.ship_group).english_name

	local var_2_4 = ShipSkin.GetChangeSkinData(arg_2_0.skin.id)

	setActive(arg_2_0.changeSkinUI, var_2_4 and true or false)

	if var_2_4 then
		arg_2_0.changeSkinToggle = arg_2_0.changeSkinToggle or ChangeSkinToggle.New(findTF(arg_2_0.changeSkinUI, "ChangeSkinToggleUI"))

		arg_2_0.changeSkinToggle:setSkinData(arg_2_0.skin.id)
		setActive(arg_2_0.changeSkinUI, not arg_2_0.changeSkinToggle:IsAsmrSkin())
	end

	arg_2_0:FlushTags(arg_2_1:getConfig("tag"))

	return
end

function var_0_0.changeSkinNext(arg_3_0)
	if ShipSkin.GetChangeSkinData(arg_3_0.skin.id) then
		arg_3_0:Update(ShipSkin.New({
			id = ShipSkin.GetChangeSkinNextId(arg_3_0.skin.id)
		}), arg_3_0.index)
	end

	return
end

function var_0_0.FlushTags(arg_4_0, arg_4_1)
	local var_4_0 = findTF(arg_4_0._tf, "tags/icon")

	if #arg_4_1 > arg_4_0.tags.childCount then
		for iter_4_0 = arg_4_0.tags.childCount + 1, #arg_4_1 do
			local var_4_1 = Object.Instantiate(var_4_0, var_4_0.parent)
		end
	end

	for iter_4_1 = 1, #arg_4_1 do
		local var_4_2 = arg_4_0.tags:GetChild(iter_4_1 - 1)

		setActive(var_4_2, true)
		LoadSpriteAtlasAsync("SkinIcon", "type_" .. ShipSkin.Tag2Name(arg_4_1[iter_4_1]) .. "_own", function(arg_5_0)
			if arg_4_0.exited then
				return
			end

			local var_5_0 = var_4_2:GetComponent(typeof(Image))

			var_5_0.sprite = arg_5_0

			var_5_0:SetNativeSize()

			return
		end)

		var_4_2.localPosition = Vector3(var_4_2.localPosition.x, var_4_0.localPosition.y - (iter_4_1 - 1) * (var_4_0.sizeDelta.y + -10), 0)
	end

	if arg_4_0.tags.childCount > #arg_4_1 then
		for iter_4_2 = #arg_4_1 + 1, arg_4_0.tags.childCount do
			setActive(arg_4_0.tags:GetChild(iter_4_2 - 1), false)
		end
	end

	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.exited = true

	return
end

return var_0_0
