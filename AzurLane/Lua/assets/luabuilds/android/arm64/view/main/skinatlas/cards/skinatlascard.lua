class = var_0_10000

local var_0_0 = var_0_10000("SkinAtlasCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	findTF = var_2
	arg_1_0.usingTr = var_2(arg_1_0._tf, "using")
	findTF = var_2
	arg_1_0.unavailableTr = var_2(arg_1_0._tf, "unavailable")

	local var_1_0 = arg_1_0._tf

	arg_1_0.have = var_2.Find(var_1_0, "have")
	findTF = var_2
	arg_1_0.icon = var_2(arg_1_0._tf, "mask/icon")
	findTF = var_2

	local var_1_1 = var_2(arg_1_0._tf, "name/Text")
	local var_1_2 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.name = var_1_2(var_1_1, var_5(var_1_10007))
	findTF = var_2

	local var_1_3 = var_2(arg_1_0._tf, "name/en")
	local var_1_4 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.enName = var_1_4(var_1_3, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.tags = var_2(arg_1_0._tf, "tags")
	findTF = var_2
	arg_1_0.changeSkinUI = var_2(arg_1_0._tf, "changeSkin")
	arg_1_0.changeSkinToggle = nil
	setText = var_2

	local var_1_5 = arg_1_0.usingTr
	local var_1_6 = var_4.Find(var_1_5, "Text")

	i18n = var_5

	var_2(var_1_6, var_5("shop_new_in_use"))

	setText = var_2

	local var_1_7 = arg_1_0.unavailableTr
	local var_1_8 = var_4.Find(var_1_7, "Text")

	i18n = var_5

	var_2(var_1_8, var_5("shop_new_unable_to_use"))

	setText = var_2

	local var_1_9 = arg_1_0.have
	local var_1_10 = var_4.Find(var_1_9, "Text")

	i18n = var_5

	var_2(var_1_10, var_5("shop_new_owned"))

	setActive = var_2

	var_2()

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.index = arg_2_2
	arg_2_0.skin = arg_2_1
	GetImageSpriteFromAtlasAsync = var_1_10004

	var_1_10004("shipYardIcon/" .. arg_2_1:getConfig("painting"), "", arg_2_0.icon)

	pg = var_1_10004

	local var_2_0 = var_1_10004.ship_skin_template[arg_2_0.skin.id]
	local var_2_1 = false
	local var_2_2 = false
	local var_2_3 = var_2_0.skin_type

	ShipSkin = var_8

	local var_2_5

	if var_2_3 ~= var_8.SKIN_TYPE_TB then
		var_2_3 = arg_2_1:getConfig("ship_group")
		getProxy = var_2_5
		BayProxy = var_10

		local var_2_4 = var_2_5(var_10)

		var_2_5 = var_2_5.findShipsByGroup(var_2_4, var_2_3)

		local var_2_6 = not arg_2_1:WithoutUse()

		if #var_2_5 ~= 0 then
			getProxy = var_10
			CollectionProxy = var_1_10012

			if var_10(var_1_10012).shipGroups[var_2_3] ~= nil then
				local var_2_7 = false

				goto label_2_0
			end
		end

		local var_2_8 = true
	end

	::label_2_0::

	setActive = var_2_3

	var_2_3(arg_2_0.usingTr, var_2_1)

	setActive = var_2_3

	var_2_3(arg_2_0.unavailableTr, var_2_2)

	if arg_2_3 then
		getProxy = var_2_3
		ShipSkinProxy = var_9

		local var_2_9 = var_2_3(var_9)

		var_2_3 = var_2_3.hasSkin(var_2_9, arg_2_0.skin.id)
		setActive = var_2_5

		var_2_5(arg_2_0.have, var_2_3)
	else
		setActive = var_2_3

		var_2_3(arg_2_0.have, false)
	end

	local var_2_10 = arg_2_1
	local var_2_11 = arg_2_1.getConfig(var_2_10, "name")
	local var_2_12 = arg_2_0.name

	shortenString = var_2_10
	var_2_12.text = var_2_10(var_2_11, 7)

	local var_2_13 = var_2_0.skin_type

	ShipSkin = var_9

	local var_2_14

	if var_2_13 == var_9.SKIN_TYPE_TB then
		var_2_13 = arg_2_0.enName
		NewEducateHelper = var_2_14
		var_2_14 = var_2_14.GetShipNameBySecId
		NewEducateHelper = var_11
		var_2_13.text = var_2_14(var_11.GetSecIdBySkinId(arg_2_0.skinId))
	else
		ShipGroup = var_2_13
		var_2_13 = var_2_13.getDefaultShipConfig(var_2_0.ship_group)
		var_2_14 = arg_2_0.enName
		var_2_14.text = var_2_13.english_name
	end

	ShipSkin = var_2_13

	local var_2_15 = var_2_13.GetChangeSkinData(arg_2_0.skin.id)

	setActive = var_2_14

	var_2_14(arg_2_0.changeSkinUI, var_2_15 and true or false)

	if var_2_15 then
		if not arg_2_0.changeSkinToggle then
			ChangeSkinToggle = var_9

			local var_2_16 = var_9.New

			findTF = var_11
			arg_2_0.changeSkinToggle = var_2_16(var_11(arg_2_0.changeSkinUI, "ChangeSkinToggleUI"))
		end

		local var_2_17 = arg_2_0.changeSkinToggle

		var_9.setSkinData(var_2_17, arg_2_0.skin.id)

		setActive = var_9

		local var_2_18 = arg_2_0.changeSkinUI
		local var_2_19 = arg_2_0.changeSkinToggle

		var_9(var_2_18, not var_12.IsAsmrSkin(var_2_19))
	end

	arg_2_0:FlushTags(arg_2_1:getConfig("tag"))

	return
end

function var_0_0.changeSkinNext(arg_3_0)
	ShipSkin = var_1_10001

	if var_1_10001.GetChangeSkinData(arg_3_0.skin.id) then
		ShipSkin = var_1_10002

		local var_3_0 = var_1_10002.GetChangeSkinNextId(arg_3_0.skin.id)

		ShipSkin = var_3

		local var_3_1 = var_3.New({
			id = var_3_0
		})

		arg_3_0:Update(var_3_1, arg_3_0.index)
	end

	return
end

function var_0_0.FlushTags(arg_4_0, arg_4_1)
	local var_4_0 = -10

	findTF = var_1_10003

	local var_4_1 = var_1_10003(arg_4_0._tf, "tags/icon")

	if #arg_4_1 > arg_4_0.tags.childCount then
		for iter_4_0 = arg_4_0.tags.childCount + 1, #arg_4_1 do
			Object = var_1_10008
			var_1_10008 = var_1_10008.Instantiate(var_4_1, var_4_1.parent)
		end
	end

	for iter_4_1 = 1, #arg_4_1 do
		local var_4_2 = arg_4_0.tags

		var_1_10008 = var_1_10008.GetChild(var_4_2, iter_4_1 - 1)
		setActive = var_1_10009

		var_1_10009(var_1_10008, true)

		LoadSpriteAtlasAsync = var_1_10009

		local var_4_3 = "SkinIcon"
		local var_4_4 = "type_"

		ShipSkin = var_1_10013

		var_1_10009(var_4_3, var_4_4 .. var_1_10013.Tag2Name(arg_4_1[iter_4_1]) .. "_own", function(arg_5_0)
			if arg_4_0.exited then
				return
			end

			local var_5_0 = var_1_10008
			local var_5_1 = var_1.GetComponent

			typeof = var_2_10004
			Image = var_2_10006

			local var_5_2 = var_5_1(var_5_0, var_2_10004(var_2_10006))

			var_5_2.sprite = arg_5_0

			var_5_2:SetNativeSize()

			return
		end)

		var_1_10009 = var_4_1.localPosition.y - (iter_4_1 - 1) * (var_4_1.sizeDelta.y + var_4_0)
		Vector3 = var_10
		var_1_10008.localPosition = var_10(var_1_10008.localPosition.x, var_1_10009, 0)
	end

	if arg_4_0.tags.childCount > #arg_4_1 then
		for iter_4_2 = #arg_4_1 + 1, arg_4_0.tags.childCount do
			setActive = var_1_10008

			local var_4_5 = arg_4_0.tags

			var_1_10008(var_10.GetChild(var_4_5, iter_4_2 - 1), false)
		end
	end

	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.exited = true

	return
end

return var_0_0
