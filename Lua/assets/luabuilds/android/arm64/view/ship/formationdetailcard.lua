local var_0_0 = class("FormationDetailCard")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.lockTF = arg_1_0.tr:Find("lock")
	arg_1_0.addTF = arg_1_0.tr:Find("add")
	arg_1_0.content = arg_1_0.tr:Find("content")
	arg_1_0.bgImage = arg_1_0.content:Find("bg"):GetComponent(typeof(Image))
	arg_1_0.paintingTr = arg_1_0.content:Find("ship_icon/painting")
	arg_1_0.paintingDefaultAngle = arg_1_0.paintingTr.localEulerAngles
	arg_1_0.detailTF = arg_1_0.content:Find("detail")
	arg_1_0.lvTxtTF = arg_1_0.detailTF:Find("top/level")
	arg_1_0.lvTxt = arg_1_0.lvTxtTF:GetComponent(typeof(Text))
	arg_1_0.shipType = arg_1_0.detailTF:Find("top/type")
	arg_1_0.propsTr = arg_1_0.detailTF:Find("info")
	arg_1_0.propsTr1 = arg_1_0.detailTF:Find("info1")
	arg_1_0.nameTxt = arg_1_0.detailTF:Find("name_mask/name")
	arg_1_0.frame = arg_1_0.content:Find("front/frame")
	arg_1_0.UIlist = UIItemList.New(arg_1_0.content:Find("front/stars"), arg_1_0.content:Find("front/stars/star_tpl"))
	arg_1_0.shipState = arg_1_0.content:Find("front/flag")
	arg_1_0.proposeMark = arg_1_0.content:Find("front/propose")
	arg_1_0.otherBg = arg_1_0.content:Find("front/bg_other")

	setActive(arg_1_0.propsTr1, false)
	setActive(arg_1_0.shipState, false)
	setText(arg_1_0.tr:Find("add/Text"), i18n("rect_ship_card_tpl_add"))

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.shipVO = arg_2_1
	arg_2_0.isLocked = arg_2_2

	arg_2_0:flush()

	return
end

function var_0_0.getState(arg_3_0)
	if arg_3_0.isLocked then
		return var_0_1
	elseif arg_3_0.shipVO then
		return var_0_3
	elseif not arg_3_0.isLocked and not arg_3_0.shipVO then
		return var_0_2
	end

	return
end

function var_0_0.flush(arg_4_0)
	local var_4_0 = arg_4_0:getState()

	if arg_4_0.otherBg then
		eachChild(arg_4_0.otherBg, function(arg_5_0)
			setActive(arg_5_0, false)

			return
		end)
	end

	if var_4_0 == var_0_1 then
		-- block empty
	elseif var_4_0 == var_0_3 then
		arg_4_0.lvTxt.text = "Lv." .. arg_4_0.shipVO.level

		local var_4_1 = arg_4_0.shipVO:getStar()

		arg_4_0.UIlist:make(function(arg_6_0, arg_6_1, arg_6_2)
			if arg_6_0 == UIItemList.EventUpdate then
				setActive(arg_6_2:Find("star"), arg_6_1 < var_4_1)
			end

			return
		end)
		arg_4_0.UIlist:align((arg_4_0.shipVO:getMaxStar()))
		setScrollText(arg_4_0.nameTxt, arg_4_0.shipVO:GetColorName())
		arg_4_0:updateProps({})
		setPaintingPrefabAsync(arg_4_0.paintingTr, arg_4_0.shipVO:getPainting(), "biandui", nil, {
			skinID = arg_4_0.shipVO:getSkinId(),
			rotateZ = arg_4_0.paintingDefaultAngle.z
		})

		local var_4_2 = arg_4_0.shipVO:rarity2bgPrint()

		GetImageSpriteFromAtlasAsync("bg/star_level_card_" .. var_4_2, "", arg_4_0.bgImage)

		local var_4_3, var_4_4 = arg_4_0.shipVO:GetFrameAndEffect(true)

		setRectShipCardFrame(arg_4_0.frame, var_4_2, var_4_3)
		setFrameEffect(arg_4_0.otherBg, var_4_4)
		setProposeMarkIcon(arg_4_0.proposeMark, arg_4_0.shipVO)
		setImageSprite(arg_4_0.shipType, GetSpriteFromAtlas("shiptype", shipType2print((arg_4_0.shipVO:getShipType()))))
	elseif var_4_0 == var_0_2 then
		-- block empty
	end

	setActive(arg_4_0.lockTF, var_4_0 == var_0_1)
	setActive(arg_4_0.addTF, var_4_0 == var_0_2)
	setActive(arg_4_0.content, var_4_0 == var_0_3)

	return
end

function var_0_0.updateProps(arg_7_0, arg_7_1)
	for iter_7_0 = 0, 2 do
		local var_7_0 = arg_7_0.propsTr:GetChild(iter_7_0)

		if iter_7_0 < #arg_7_1 then
			var_7_0.gameObject:SetActive(true)

			local var_7_1 = var_7_0:GetChild(0)

			var_7_1:GetComponent("Text").text = arg_7_1[iter_7_0 + 1][1]

			local var_7_2 = var_7_0:GetChild(1)

			var_7_2:GetComponent("Text").text = arg_7_1[iter_7_0 + 1][2]
		else
			var_7_0.gameObject:SetActive(false)
		end
	end

	return
end

function var_0_0.clear(arg_8_0)
	if arg_8_0.shipVO then
		retPaintingPrefab(arg_8_0.paintingTr, arg_8_0.shipVO:getPainting())
	end

	return
end

return var_0_0
