local var_0_0 = class("FormationCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.content = arg_1_0.tr:Find("content")
	arg_1_0.bgImage = arg_1_0.content:Find("bg"):GetComponent(typeof(Image))
	arg_1_0.paintingTr = arg_1_0.content:Find("ship_icon/painting")
	arg_1_0.paintingDefaultAngle = arg_1_0.paintingTr.localEulerAngles
	arg_1_0.detailTF = arg_1_0.content:Find("detail")
	arg_1_0.lvTxt = arg_1_0.detailTF:Find("top/level"):GetComponent(typeof(Text))
	arg_1_0.shipType = arg_1_0.detailTF:Find("top/type")
	arg_1_0.propsTr = arg_1_0.detailTF:Find("info")
	arg_1_0.propsTr1 = arg_1_0.detailTF:Find("info1")
	arg_1_0.nameTxt = arg_1_0.detailTF:Find("name_mask/name")
	arg_1_0.frame = arg_1_0.content:Find("front/frame")
	arg_1_0.UIlist = UIItemList.New(arg_1_0.content:Find("front/stars"), arg_1_0.content:Find("front/stars/star_tpl"))
	arg_1_0.shipState = arg_1_0.content:Find("front/flag")
	arg_1_0.otherBg = arg_1_0.content:Find("front/bg_other")

	setActive(arg_1_0.propsTr1, false)
	setActive(arg_1_0.shipState, false)

	arg_1_0.loader = AutoLoader.New()

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	if arg_2_1 then
		setActive(arg_2_0.content, true)

		arg_2_0.shipVO = arg_2_1

		arg_2_0:flush()
	else
		setActive(arg_2_0.content, false)
	end

	return
end

function var_0_0.flush(arg_3_0)
	arg_3_0.lvTxt.text = "Lv." .. arg_3_0.shipVO.level

	local var_3_0 = arg_3_0.shipVO:getStar()

	arg_3_0.UIlist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			setActive(arg_4_2:Find("star"), arg_4_1 < var_3_0)
		end

		return
	end)
	arg_3_0.UIlist:align((arg_3_0.shipVO:getMaxStar()))
	setScrollText(arg_3_0.nameTxt, arg_3_0.shipVO:getName())
	arg_3_0:updateProps({})
	setPaintingPrefabAsync(arg_3_0.paintingTr, arg_3_0.shipVO:getPainting(), "biandui", nil, {
		skinID = arg_3_0.shipVO:getSkinId(),
		rotateZ = arg_3_0.paintingDefaultAngle.z
	})

	local var_3_1 = arg_3_0.shipVO:rarity2bgPrint()

	GetImageSpriteFromAtlasAsync("bg/star_level_card_" .. var_3_1, "", arg_3_0.bgImage)

	local var_3_2, var_3_3 = arg_3_0.shipVO:GetFrameAndEffect(true)

	setRectShipCardFrame(arg_3_0.frame, var_3_1, var_3_2)
	setFrameEffect(arg_3_0.otherBg, var_3_3)
	setImageSprite(arg_3_0.shipType, GetSpriteFromAtlas("shiptype", shipType2print((arg_3_0.shipVO:getShipType()))))

	return
end

function var_0_0.updateProps(arg_5_0, arg_5_1)
	for iter_5_0 = 0, 2 do
		local var_5_0 = arg_5_0.propsTr:GetChild(iter_5_0)

		if iter_5_0 < #arg_5_1 then
			var_5_0.gameObject:SetActive(true)

			local var_5_1 = var_5_0:GetChild(0)

			var_5_1:GetComponent("Text").text = arg_5_1[iter_5_0 + 1][1]

			local var_5_2 = var_5_0:GetChild(1)

			var_5_2:GetComponent("Text").text = arg_5_1[iter_5_0 + 1][2]
		else
			var_5_0.gameObject:SetActive(false)
		end
	end

	return
end

function var_0_0.updateProps1(arg_6_0, arg_6_1)
	for iter_6_0 = 0, 2 do
		local var_6_0 = arg_6_0.propsTr1:GetChild(iter_6_0)

		if iter_6_0 < #arg_6_1 then
			var_6_0.gameObject:SetActive(true)

			local var_6_1 = var_6_0:GetChild(0)

			var_6_1:GetComponent("Text").text = arg_6_1[iter_6_0 + 1][1]

			local var_6_2 = var_6_0:GetChild(1)

			var_6_2:GetComponent("Text").text = arg_6_1[iter_6_0 + 1][2]
		else
			var_6_0.gameObject:SetActive(false)
		end
	end

	return
end

function var_0_0.clear(arg_7_0)
	if arg_7_0.shipVO then
		retPaintingPrefab(arg_7_0.paintingTr, arg_7_0.shipVO:getPainting())
	end

	arg_7_0.loader:Clear()

	return
end

return var_0_0
