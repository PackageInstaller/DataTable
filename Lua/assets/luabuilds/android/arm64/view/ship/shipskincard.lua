local var_0_0 = class("ShipSkinCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.painting = findTF(arg_1_0.tr, "bg/mask/painting")
	arg_1_0.paintingDefaultAngle = arg_1_0.painting.localEulerAngles
	arg_1_0.nameBar = findTF(arg_1_0.tr, "bg/desc/name_bar")
	arg_1_0.name = findTF(arg_1_0.nameBar, "name")
	arg_1_0.effectBar = findTF(arg_1_0.tr, "bg/desc/effect_bar")
	arg_1_0.effect = findTF(arg_1_0.effectBar, "effect")
	arg_1_0.bgUsing = findTF(arg_1_0.tr, "bg/bg_using")
	arg_1_0.bgMark = findTF(arg_1_0.tr, "bg/bg_mark")
	arg_1_0.picNotBuy = findTF(arg_1_0.bgMark, "bg/pic_not_buy")
	arg_1_0.picActivity = findTF(arg_1_0.bgMark, "bg/pic_activity")
	arg_1_0.picPropose = findTF(arg_1_0.bgMark, "bg/pic_propose")
	arg_1_0.picShare = findTF(arg_1_0.bgMark, "bg/pic_share")
	arg_1_0.outline = findTF(arg_1_0.tr, "bg/outline")
	arg_1_0.tags = findTF(arg_1_0.tr, "bg/tags")
	arg_1_0.timelimitTag = findTF(arg_1_0.tr, "bg/timelimit")
	arg_1_0.timelimitTimeTxt = findTF(arg_1_0.tr, "bg/timelimit_time")
	arg_1_0.shareFlag = findTF(arg_1_0.tr, "bg/share")
	arg_1_0.changeSkinTF = findTF(arg_1_0.tr, "bg/change_skin")
	arg_1_0.changeSkinToggle = ChangeSkinToggle.New(findTF(arg_1_0.changeSkinTF, "ToggleUI"))

	setActive(arg_1_0.changeSkinTF, false)
	setActive(arg_1_0.timelimitTag, false)
	setActive(arg_1_0.timelimitTimeTxt, false)

	arg_1_0.hideObjToggleTF = findTF(arg_1_0.tr, "hideObjToggle")

	setActive(arg_1_0.hideObjToggleTF, false)

	arg_1_0.hideObjToggle = GetComponent(arg_1_0.hideObjToggleTF, typeof(Toggle))

	setText(findTF(arg_1_0.hideObjToggleTF, "Label"), i18n("paint_hide_other_obj_tip"))

	return
end

function var_0_0.updateSkin(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.skin ~= arg_2_1 or arg_2_0.own ~= arg_2_2 then
		arg_2_0.skin = arg_2_1
		arg_2_0.own = arg_2_2

		setActive(arg_2_0.nameBar, true)
		setActive(arg_2_0.effectBar, false)
		setActive(arg_2_0.shareFlag, false)
		setText(arg_2_0.name, shortenString(arg_2_1.name, 7))
		setActive(arg_2_0.bgMark, not arg_2_2)

		if not arg_2_2 then
			setActive(arg_2_0.picNotBuy, false)
			setActive(arg_2_0.picActivity, false)
			setActive(arg_2_0.picPropose, false)
			setActive(arg_2_0.picShare, false)

			if arg_2_1.skin_type == ShipSkin.SKIN_TYPE_PROPOSE then
				setActive(arg_2_0.picPropose, true)
			elseif arg_2_0.skin.shop_id > 0 then
				setActive(arg_2_0.picNotBuy, true)
			elseif _.any(pg.activity_shop_template.all, function(arg_3_0)
				local var_3_0 = pg.activity_shop_template[arg_3_0]

				return pg.activity_shop_template[arg_3_0].commodity_type == DROP_TYPE_SKIN and var_3_0.commodity_id == arg_2_0.skin.id
			end) or _.any(pg.activity_shop_extra.all, function(arg_4_0)
				local var_4_0 = pg.activity_shop_extra[arg_4_0]

				return pg.activity_shop_extra[arg_4_0].commodity_type == DROP_TYPE_SKIN and var_4_0.commodity_id == arg_2_0.skin.id
			end) then
				setActive(arg_2_0.picActivity, true)
			else
				setActive(arg_2_0.picActivity, true)
			end
		end

		setActive(arg_2_0.tags, true)

		for iter_2_0 = 0, arg_2_0.tags.childCount - 1 do
			setActive(arg_2_0.tags:GetChild(iter_2_0), false)
		end

		_.each(arg_2_1.tag, function(arg_5_0)
			setActive(arg_2_0.tags:Find("tag" .. arg_5_0), true)

			return
		end)
		arg_2_0:flushSkin()
	end

	return
end

function var_0_0.updateData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_0.ship ~= arg_6_1 or arg_6_0.skin ~= arg_6_2 or arg_6_0.own ~= arg_6_3 or arg_6_0.skinId ~= arg_6_2.id then
		arg_6_0.ship = arg_6_1
		arg_6_0.skin = arg_6_2
		arg_6_0.own = arg_6_3
		arg_6_0.skinId = arg_6_0.skin.id

		local var_6_0 = ShipSkin.GetChangeSkinData(arg_6_0.skin.id)

		if arg_6_3 and var_6_0 then
			setActive(arg_6_0.changeSkinTF, true)
		else
			setActive(arg_6_0.changeSkinTF, false)
		end

		if var_6_0 then
			arg_6_0.changeSkinToggle:setShipData(arg_6_0.skin.id, arg_6_0.ship:GetShipPhantomMark())
			setActive(arg_6_0.changeSkinTF, not arg_6_0.changeSkinToggle:IsAsmrSkin())
		end

		setActive(arg_6_0.nameBar, true)
		setActive(arg_6_0.effectBar, false)
		setText(arg_6_0.name, shortenString(arg_6_2.name, 7))

		local var_6_1 = arg_6_0.skin.id == arg_6_0.ship:getConfig("skin_id")
		local var_6_2 = ShipSkin.IsShareSkin(arg_6_0.ship, arg_6_0.skin.id)
		local var_6_3 = false

		if var_6_2 then
			var_6_3 = ShipSkin.CanUseShareSkinForShip(arg_6_0.ship, arg_6_0.skin.id)
		end

		setActive(arg_6_0.shareFlag, var_6_2)

		local var_6_4 = not var_6_1 and not arg_6_3 or var_6_2 and not var_6_3

		setActive(arg_6_0.bgMark, not var_6_1 and not arg_6_3 or var_6_2 and not var_6_3)

		if var_6_4 then
			setActive(arg_6_0.picNotBuy, false)
			setActive(arg_6_0.picActivity, false)
			setActive(arg_6_0.picPropose, false)
			setActive(arg_6_0.picShare, false)

			if arg_6_2.skin_type == ShipSkin.SKIN_TYPE_PROPOSE then
				setActive(arg_6_0.picPropose, true)
			elseif not arg_6_3 and arg_6_0.skin.shop_id > 0 then
				setActive(arg_6_0.picNotBuy, true)
			elseif not arg_6_3 and (_.any(pg.activity_shop_template.all, function(arg_7_0)
				local var_7_0 = pg.activity_shop_template[arg_7_0]

				return pg.activity_shop_template[arg_7_0].commodity_type == DROP_TYPE_SKIN and var_7_0.commodity_id == arg_6_0.skin.id
			end) or _.any(pg.activity_shop_extra.all, function(arg_8_0)
				local var_8_0 = pg.activity_shop_extra[arg_8_0]

				return pg.activity_shop_extra[arg_8_0].commodity_type == DROP_TYPE_SKIN and var_8_0.commodity_id == arg_6_0.skin.id
			end)) then
				setActive(arg_6_0.picActivity, true)
			elseif var_6_2 and not var_6_3 then
				setActive(arg_6_0.picShare, true)
			else
				setActive(arg_6_0.picActivity, true)
			end
		end

		setActive(arg_6_0.tags, true)

		for iter_6_0 = 0, arg_6_0.tags.childCount - 1 do
			setActive(arg_6_0.tags:GetChild(iter_6_0), false)
		end

		_.each(arg_6_2.tag, function(arg_9_0)
			setActive(arg_6_0.tags:Find("tag" .. arg_9_0), true)

			return
		end)
		arg_6_0:flushSkin()

		local var_6_5 = arg_6_0.skin.id

		if ShipSkin.IsChangeSkin(arg_6_0.skin.id) then
			var_6_5 = ShipSkin.GetChangeSkinMainId(arg_6_0.skin.id)
		end

		local var_6_6 = getProxy(ShipSkinProxy):getSkinById(var_6_5)
		local var_6_7 = var_6_6 and var_6_6:isExpireType() and not var_6_6:isExpired()

		setActive(arg_6_0.timelimitTag, var_6_7)
		setActive(arg_6_0.timelimitTimeTxt, var_6_7)

		if arg_6_0.skinTimer then
			arg_6_0.skinTimer:Stop()
		end

		if var_6_7 then
			arg_6_0.skinTimer = Timer.New(function()
				setText(arg_6_0.timelimitTimeTxt:Find("Text"), (skinTimeStamp(var_6_6:getRemainTime())))

				return
			end, 1, -1)

			arg_6_0.skinTimer:Start()
			arg_6_0.skinTimer.func()
		end
	end

	return
end

function var_0_0.updateSelected(arg_11_0, arg_11_1)
	if arg_11_0.selected ~= arg_11_1 then
		arg_11_0.selected = arg_11_1

		setActive(arg_11_0.outline, tobool(arg_11_0.selected))
	end

	return
end

function var_0_0.updateUsing(arg_12_0, arg_12_1)
	if arg_12_0.using ~= arg_12_1 then
		arg_12_0.using = arg_12_1

		setActive(arg_12_0.bgUsing, arg_12_0.using)
	end

	return
end

function var_0_0.flushSkin(arg_13_0)
	arg_13_0:clearPainting()
	arg_13_0:loadPainting()

	return
end

function var_0_0.clearPainting(arg_14_0)
	if arg_14_0.paintingName then
		retPaintingPrefab(arg_14_0.painting, arg_14_0.paintingName)

		arg_14_0.paintingName = nil
	end

	return
end

function var_0_0.loadPainting(arg_15_0)
	if arg_15_0.skin then
		arg_15_0.paintingName = arg_15_0.skin.painting or "unknown"

		setActive(arg_15_0.hideObjToggle, (checkABExist("painting/" .. arg_15_0.paintingName .. "_n")))

		arg_15_0.hideObjToggle.isOn = PlayerPrefs.GetInt("paint_hide_other_obj_" .. arg_15_0.paintingName, 0) ~= 0

		setPaintingPrefabAsync(arg_15_0.painting, arg_15_0.paintingName, "pifu", nil, {
			skinID = arg_15_0.skin.id,
			rotateZ = arg_15_0.paintingDefaultAngle
		})

		return
	end
end

function var_0_0.clear(arg_16_0)
	arg_16_0:clearPainting()

	arg_16_0.skin = nil
	arg_16_0.selected = nil
	arg_16_0.using = nil

	if arg_16_0.skinTimer then
		arg_16_0.skinTimer:Stop()

		arg_16_0.skinTimer = nil
	end

	return
end

return var_0_0
