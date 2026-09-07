local ShipSkinCard = class("ShipSkinCard")

function ShipSkinCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tr = arg_1_1.transform
	self.painting = findTF(self.tr, "bg/mask/painting")
	self.paintingDefaultAngle = self.painting.localEulerAngles
	self.nameBar = findTF(self.tr, "bg/desc/name_bar")
	self.name = findTF(self.nameBar, "name")
	self.effectBar = findTF(self.tr, "bg/desc/effect_bar")
	self.effect = findTF(self.effectBar, "effect")
	self.bgUsing = findTF(self.tr, "bg/bg_using")
	self.bgMark = findTF(self.tr, "bg/bg_mark")
	self.picNotBuy = findTF(self.bgMark, "bg/pic_not_buy")
	self.picActivity = findTF(self.bgMark, "bg/pic_activity")
	self.picPropose = findTF(self.bgMark, "bg/pic_propose")
	self.picShare = findTF(self.bgMark, "bg/pic_share")
	self.outline = findTF(self.tr, "bg/outline")
	self.tags = findTF(self.tr, "bg/tags")
	self.timelimitTag = findTF(self.tr, "bg/timelimit")
	self.timelimitTimeTxt = findTF(self.tr, "bg/timelimit_time")
	self.shareFlag = findTF(self.tr, "bg/share")
	self.changeSkinTF = findTF(self.tr, "bg/change_skin")
	self.changeSkinToggle = ChangeSkinToggle.New(findTF(self.changeSkinTF, "ToggleUI"))

	setActive(self.changeSkinTF, false)
	setActive(self.timelimitTag, false)
	setActive(self.timelimitTimeTxt, false)

	self.hideObjToggleTF = findTF(self.tr, "hideObjToggle")

	setActive(self.hideObjToggleTF, false)

	self.hideObjToggle = GetComponent(self.hideObjToggleTF, typeof(Toggle))

	setText(findTF(self.hideObjToggleTF, "Label"), i18n("paint_hide_other_obj_tip"))

	return
end

function ShipSkinCard:updateSkin(arg_2_1, arg_2_2)
	if self.skin ~= arg_2_1 or self.own ~= arg_2_2 then
		self.skin = arg_2_1
		self.own = arg_2_2

		setActive(self.nameBar, true)
		setActive(self.effectBar, false)
		setActive(self.shareFlag, false)
		setText(self.name, shortenString(arg_2_1.name, 7))
		setActive(self.bgMark, not arg_2_2)

		if not arg_2_2 then
			setActive(self.picNotBuy, false)
			setActive(self.picActivity, false)
			setActive(self.picPropose, false)
			setActive(self.picShare, false)

			if arg_2_1.skin_type == ShipSkin.SKIN_TYPE_PROPOSE then
				setActive(self.picPropose, true)
			elseif self.skin.shop_id > 0 then
				setActive(self.picNotBuy, true)
			elseif _.any(pg.activity_shop_template.all, function(arg_3_0)
				return pg.activity_shop_template[arg_3_0].commodity_type == DROP_TYPE_SKIN and pg.activity_shop_template[arg_3_0].commodity_id == self.skin.id
			end) or _.any(pg.activity_shop_extra.all, function(arg_4_0)
				return pg.activity_shop_extra[arg_4_0].commodity_type == DROP_TYPE_SKIN and pg.activity_shop_extra[arg_4_0].commodity_id == self.skin.id
			end) then
				setActive(self.picActivity, true)
			else
				setActive(self.picActivity, true)
			end
		end

		setActive(self.tags, true)

		for iter_2_0 = 0, self.tags.childCount - 1 do
			setActive(self.tags:GetChild(iter_2_0), false)
		end

		_.each(arg_2_1.tag, function(arg_5_0)
			setActive(self.tags:Find("tag" .. arg_5_0), true)

			return
		end)
		self:flushSkin()
	end

	return
end

function ShipSkinCard:updateData(arg_6_1, arg_6_2, arg_6_3)
	if self.ship ~= arg_6_1 or self.skin ~= arg_6_2 or self.own ~= arg_6_3 or self.skinId ~= arg_6_2.id then
		self.ship = arg_6_1
		self.skin = arg_6_2
		self.own = arg_6_3
		self.skinId = self.skin.id

		local var_6_0 = ShipSkin.GetChangeSkinData(self.skin.id)

		if arg_6_3 and var_6_0 then
			setActive(self.changeSkinTF, true)
		else
			setActive(self.changeSkinTF, false)
		end

		if var_6_0 then
			self.changeSkinToggle:setShipData(self.skin.id, self.ship:GetShipPhantomMark())
			setActive(self.changeSkinTF, not self.changeSkinToggle:IsAsmrSkin())
		end

		setActive(self.nameBar, true)
		setActive(self.effectBar, false)
		setText(self.name, shortenString(arg_6_2.name, 7))

		local var_6_1 = self.skin.id == self.ship:getConfig("skin_id")
		local var_6_2 = ShipSkin.IsShareSkin(self.ship, self.skin.id)
		local var_6_3 = false

		if var_6_2 then
			var_6_3 = ShipSkin.CanUseShareSkinForShip(self.ship, self.skin.id)
		end

		setActive(self.shareFlag, var_6_2)

		local var_6_4 = not var_6_1 and not arg_6_3 or var_6_2 and not var_6_3

		setActive(self.bgMark, not var_6_1 and not arg_6_3 or var_6_2 and not var_6_3)

		if var_6_4 then
			setActive(self.picNotBuy, false)
			setActive(self.picActivity, false)
			setActive(self.picPropose, false)
			setActive(self.picShare, false)

			if arg_6_2.skin_type == ShipSkin.SKIN_TYPE_PROPOSE then
				setActive(self.picPropose, true)
			elseif not arg_6_3 and self.skin.shop_id > 0 then
				setActive(self.picNotBuy, true)
			elseif not arg_6_3 and (_.any(pg.activity_shop_template.all, function(arg_7_0)
				return pg.activity_shop_template[arg_7_0].commodity_type == DROP_TYPE_SKIN and pg.activity_shop_template[arg_7_0].commodity_id == self.skin.id
			end) or _.any(pg.activity_shop_extra.all, function(arg_8_0)
				return pg.activity_shop_extra[arg_8_0].commodity_type == DROP_TYPE_SKIN and pg.activity_shop_extra[arg_8_0].commodity_id == self.skin.id
			end)) then
				setActive(self.picActivity, true)
			elseif var_6_2 and not var_6_3 then
				setActive(self.picShare, true)
			else
				setActive(self.picActivity, true)
			end
		end

		setActive(self.tags, true)

		for iter_6_0 = 0, self.tags.childCount - 1 do
			setActive(self.tags:GetChild(iter_6_0), false)
		end

		_.each(arg_6_2.tag, function(arg_9_0)
			setActive(self.tags:Find("tag" .. arg_9_0), true)

			return
		end)
		self:flushSkin()

		local var_6_6 = getProxy(ShipSkinProxy):getSkinById((ShipSkin.IsChangeSkin(self.skin.id) or nil) and ShipSkin.GetChangeSkinMainId(self.skin.id))
		local var_6_7 = var_6_6 and var_6_6:isExpireType() and not var_6_6:isExpired()

		setActive(self.timelimitTag, var_6_7)
		setActive(self.timelimitTimeTxt, var_6_7)

		if self.skinTimer then
			self.skinTimer:Stop()
		end

		if var_6_7 then
			self.skinTimer = Timer.New(function()
				setText(self.timelimitTimeTxt:Find("Text"), (skinTimeStamp(var_6_6:getRemainTime())))

				return
			end, 1, -1)

			self.skinTimer:Start()
			self.skinTimer.func()
		end
	end

	return
end

function ShipSkinCard:updateSelected(arg_11_1)
	if self.selected ~= arg_11_1 then
		self.selected = arg_11_1

		setActive(self.outline, tobool(self.selected))
	end

	return
end

function ShipSkinCard:updateUsing(arg_12_1)
	if self.using ~= arg_12_1 then
		self.using = arg_12_1

		setActive(self.bgUsing, self.using)
	end

	return
end

function ShipSkinCard:flushSkin()
	self:clearPainting()
	self:loadPainting()

	return
end

function ShipSkinCard:clearPainting()
	if self.paintingName then
		retPaintingPrefab(self.painting, self.paintingName)

		self.paintingName = nil
	end

	return
end

function ShipSkinCard:loadPainting()
	if self.skin then
		self.paintingName = self.skin.painting or "unknown"
	end

	setActive(self.hideObjToggle, (checkABExist("painting/" .. self.paintingName .. "_n")))

	self.hideObjToggle.isOn = PlayerPrefs.GetInt("paint_hide_other_obj_" .. self.paintingName, 0) ~= 0

	setPaintingPrefabAsync(self.painting, self.paintingName, "pifu", nil, {
		skinID = self.skin.id,
		rotateZ = self.paintingDefaultAngle
	})

	return
end

function ShipSkinCard:clear()
	self:clearPainting()

	self.skin = nil
	self.selected = nil
	self.using = nil

	if self.skinTimer then
		self.skinTimer:Stop()

		self.skinTimer = nil
	end

	return
end

return ShipSkinCard
