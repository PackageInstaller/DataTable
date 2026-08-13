class = var_0_10000

local var_0_0 = "BackYardDecorationDecBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "BackYardDecorationDescUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "name_bg/Text")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.descTxt = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "icon_bg/icon")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.icon = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "icon_bg/ship")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.shipIcon = var_2_11(var_2_10, var_3(var_1_10004))
	arg_2_0.width = arg_2_0._tf.rect.width
	arg_2_0.prantLeftBound = arg_2_0._tf.parent.rect.width / 2

	return
end

function var_0_1.shortenString(arg_3_0, arg_3_1, arg_3_2)
	string = var_1_10003

	local var_3_0 = var_1_10003.gmatch(arg_3_1, "<color=#%w+>")()

	string = var_4

	local var_3_1, var_3_2 = var_4.find(arg_3_1, "<color=#%w+>")

	if not var_3_1 then
		shortenString = var_6

		return var_6(arg_3_1, arg_3_2)
	end

	string = var_6

	local var_3_3, var_3_4 = var_6.find(arg_3_1, "</color>")

	string = var_8

	local var_3_5 = var_8.sub(arg_3_1, 1, var_3_1 - 1)

	string = var_9

	local var_3_6 = var_9.sub(arg_3_1, var_3_2 + 1, var_3_3 - 1)

	string = var_10

	local var_3_7 = var_10.sub
	local var_3_8 = arg_3_1
	local var_3_9 = var_3_4 + 1

	string = var_1_10013

	local var_3_10 = var_3_7(var_3_8, var_3_9, var_1_10013.len(arg_3_1))
	local var_3_11 = ""
	local var_3_12 = 0

	ipairs = var_13

	for iter_3_0, iter_3_1 in var_13({
		var_3_5,
		var_3_6,
		var_3_10
	}) do
		var_3_11 = var_3_11 .. iter_3_1
		var_3_12 = iter_3_0
		shouldShortenString = var_18

		if var_18(var_3_11, arg_3_2) then
			break
		end
	end

	if var_3_12 <= 1 then
		shortenString = var_13

		return var_13(var_3_11, arg_3_2)
	else
		shortenString = var_13

		local var_3_13 = var_13(var_3_11, arg_3_2)

		if var_3_5 == "" then
			string = var_13

			return var_13.gsub(var_3_13, var_3_6, var_3_0 .. var_3_6) .. "</color>"
		else
			string = var_13

			return var_13.gsub(var_3_13, var_3_5, var_3_5 .. var_3_0) .. "</color>"
		end
	end

	return
end

function var_0_1.SetUp(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0.furniture ~= arg_4_1 then
		local var_4_0 = arg_4_0.nameTxt

		shortenString = var_1_10005
		HXSet = var_1_10006
		var_4_0.text = var_1_10005(var_1_10006.hxLan(arg_4_1:getConfig("name")), 10)

		local var_4_1 = arg_4_0
		local var_4_2 = arg_4_0.shortenString

		HXSet = var_1_10006

		local var_4_3 = var_4_2(var_4_1, var_1_10006.hxLan(arg_4_1:getConfig("describe")), 41)

		arg_4_0.descTxt.text = var_4_3

		local var_4_4 = arg_4_0.icon

		LoadSprite = var_1_10006
		var_4_4.sprite = var_1_10006("furnitureicon/" .. arg_4_1:getConfig("icon"))
		var_1_10006 = arg_4_0.icon

		var_5.SetNativeSize(var_1_10006)
	end

	arg_4_0._tf.position = arg_4_2

	if arg_4_3 then
		local var_4_5 = arg_4_0._tf.localPosition
		local var_4_6 = arg_4_0._tf

		Vector3 = var_1_10006
		var_4_6.localPosition = var_1_10006(var_4_5.x, var_4_5.y - arg_4_0._tf.rect.height, 0)
	end

	if arg_4_0._tf.localPosition.x + arg_4_0.width > arg_4_0.prantLeftBound then
		local var_4_7 = arg_4_0._tf.localPosition
		local var_4_8 = arg_4_0._tf

		Vector3 = var_1_10006
		var_4_8.localPosition = var_1_10006(var_4_7.x - arg_4_0.width, var_4_7.y, var_4_7.z)
	end

	arg_4_0.furniture = arg_4_1

	arg_4_0:UpdateSkinType()
	arg_4_0:Show()

	return
end

function var_0_1.UpdateSkinType(arg_5_0)
	Goods = var_1_10001

	local var_5_0 = var_1_10001.FurnitureId2Id(arg_5_0.furniture.id)

	Goods = var_2

	local var_5_1 = var_2.ExistFurniture(var_5_0)

	setActive = var_3

	var_3(arg_5_0.shipIcon, var_5_1)

	if var_5_1 then
		Goods = var_3

		local var_5_2 = var_3.GetFurnitureConfig(var_5_0)

		Goods = var_4

		local var_5_3 = var_4.Id2ShipSkinId(var_5_2.id)

		pg = var_5

		local var_5_4 = var_5.ship_skin_template[var_5_3].prefab

		GetImageSpriteFromAtlasAsync = var_1_10006

		var_1_10006("QIcon/" .. var_5_4, "", arg_5_0.shipIcon.gameObject)
	end

	return
end

function var_0_1.OnDestroy(arg_6_0)
	return
end

return var_0_1
