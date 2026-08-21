local var_0_0 = class("BackYardDecorationDecBox", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "BackYardDecorationDescUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.nameTxt = arg_2_0._tf:Find("name_bg/Text"):GetComponent(typeof(Text))
	arg_2_0.descTxt = arg_2_0._tf:Find("Text"):GetComponent(typeof(Text))
	arg_2_0.icon = arg_2_0._tf:Find("icon_bg/icon"):GetComponent(typeof(Image))
	arg_2_0.shipIcon = arg_2_0._tf:Find("icon_bg/ship"):GetComponent(typeof(Image))
	arg_2_0.width = arg_2_0._tf.rect.width
	arg_2_0.prantLeftBound = arg_2_0._tf.parent.rect.width / 2

	return
end

function var_0_0.shortenString(arg_3_0, arg_3_1, arg_3_2)
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

function var_0_0.SetUp(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0.furniture ~= arg_4_1 then
		arg_4_0.nameTxt.text = shortenString(HXSet.hxLan(arg_4_1:getConfig("name")), 10)
		arg_4_0.descTxt.text = arg_4_0:shortenString(HXSet.hxLan(arg_4_1:getConfig("describe")), 41)
		arg_4_0.icon.sprite = LoadSprite("furnitureicon/" .. arg_4_1:getConfig("icon"))

		arg_4_0.icon:SetNativeSize()
	end

	arg_4_0._tf.position = arg_4_2

	if arg_4_3 then
		arg_4_0._tf.localPosition = Vector3(arg_4_0._tf.localPosition.x, arg_4_0._tf.localPosition.y - arg_4_0._tf.rect.height, 0)
	end

	if arg_4_0._tf.localPosition.x + arg_4_0.width > arg_4_0.prantLeftBound then
		arg_4_0._tf.localPosition = Vector3(arg_4_0._tf.localPosition.x - arg_4_0.width, arg_4_0._tf.localPosition.y, arg_4_0._tf.localPosition.z)
	end

	arg_4_0.furniture = arg_4_1

	arg_4_0:UpdateSkinType()
	arg_4_0:Show()

	return
end

function var_0_0.UpdateSkinType(arg_5_0)
	local var_5_0 = Goods.FurnitureId2Id(arg_5_0.furniture.id)
	local var_5_1 = Goods.ExistFurniture(var_5_0)

	setActive(arg_5_0.shipIcon, var_5_1)

	if var_5_1 then
		GetImageSpriteFromAtlasAsync("QIcon/" .. pg.ship_skin_template[Goods.Id2ShipSkinId(Goods.GetFurnitureConfig(var_5_0).id)].prefab, "", arg_5_0.shipIcon.gameObject)
	end

	return
end

function var_0_0.OnDestroy(arg_6_0)
	return
end

return var_0_0
