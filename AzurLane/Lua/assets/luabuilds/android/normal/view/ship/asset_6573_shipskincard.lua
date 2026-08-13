class = var_0_10000

local var_0_0 = var_0_10000("ShipSkinCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	findTF = var_2
	arg_1_0.painting = var_2(arg_1_0.tr, "bg/mask/painting")
	arg_1_0.paintingDefaultAngle = arg_1_0.painting.localEulerAngles
	findTF = var_2
	arg_1_0.nameBar = var_2(arg_1_0.tr, "bg/desc/name_bar")
	findTF = var_2
	arg_1_0.name = var_2(arg_1_0.nameBar, "name")
	findTF = var_2
	arg_1_0.effectBar = var_2(arg_1_0.tr, "bg/desc/effect_bar")
	findTF = var_2
	arg_1_0.effect = var_2(arg_1_0.effectBar, "effect")
	findTF = var_2
	arg_1_0.bgUsing = var_2(arg_1_0.tr, "bg/bg_using")
	findTF = var_2
	arg_1_0.bgMark = var_2(arg_1_0.tr, "bg/bg_mark")
	findTF = var_2
	arg_1_0.picNotBuy = var_2(arg_1_0.bgMark, "bg/pic_not_buy")
	findTF = var_2
	arg_1_0.picActivity = var_2(arg_1_0.bgMark, "bg/pic_activity")
	findTF = var_2
	arg_1_0.picPropose = var_2(arg_1_0.bgMark, "bg/pic_propose")
	findTF = var_2
	arg_1_0.picShare = var_2(arg_1_0.bgMark, "bg/pic_share")
	findTF = var_2
	arg_1_0.outline = var_2(arg_1_0.tr, "bg/outline")
	findTF = var_2
	arg_1_0.tags = var_2(arg_1_0.tr, "bg/tags")
	findTF = var_2
	arg_1_0.timelimitTag = var_2(arg_1_0.tr, "bg/timelimit")
	findTF = var_2
	arg_1_0.timelimitTimeTxt = var_2(arg_1_0.tr, "bg/timelimit_time")
	findTF = var_2
	arg_1_0.shareFlag = var_2(arg_1_0.tr, "bg/share")
	findTF = var_2
	arg_1_0.changeSkinTF = var_2(arg_1_0.tr, "bg/change_skin")
	ChangeSkinToggle = var_2

	local var_1_0 = var_2.New

	findTF = var_3
	arg_1_0.changeSkinToggle = var_1_0(var_3(arg_1_0.changeSkinTF, "ToggleUI"))
	setActive = var_2

	var_2(arg_1_0.changeSkinTF, false)

	setActive = var_2

	var_2(arg_1_0.timelimitTag, false)

	setActive = var_2

	var_2(arg_1_0.timelimitTimeTxt, false)

	findTF = var_2
	arg_1_0.hideObjToggleTF = var_2(arg_1_0.tr, "hideObjToggle")
	setActive = var_2

	var_2(arg_1_0.hideObjToggleTF, false)

	GetComponent = var_2

	local var_1_1 = arg_1_0.hideObjToggleTF

	typeof = var_4
	Toggle = var_5
	arg_1_0.hideObjToggle = var_2(var_1_1, var_4(var_5))
	setText = var_2
	findTF = var_1_1

	local var_1_2 = var_1_1(arg_1_0.hideObjToggleTF, "Label")

	i18n = var_4

	var_2(var_1_2, var_4("paint_hide_other_obj_tip"))

	return
end

function var_0_0.updateSkin(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.skin ~= arg_2_1 or arg_2_0.own ~= arg_2_2 then
		arg_2_0.skin = arg_2_1
		arg_2_0.own = arg_2_2
		setActive = var_3

		var_3(arg_2_0.nameBar, true)

		setActive = var_3

		var_3(arg_2_0.effectBar, false)

		setActive = var_3

		var_3(arg_2_0.shareFlag, false)

		setText = var_3

		local var_2_0 = arg_2_0.name

		shortenString = var_5

		var_3(var_2_0, var_5(arg_2_1.name, 7))

		local var_2_1 = not arg_2_2

		setActive = var_2_0

		var_2_0(arg_2_0.bgMark, var_2_1)

		if var_2_1 then
			setActive = var_2_0

			var_2_0(arg_2_0.picNotBuy, false)

			setActive = var_2_0

			var_2_0(arg_2_0.picActivity, false)

			setActive = var_2_0

			var_2_0(arg_2_0.picPropose, false)

			setActive = var_2_0

			var_2_0(arg_2_0.picShare, false)

			var_2_0 = arg_2_1.skin_type
			ShipSkin = var_5

			if var_2_0 == var_5.SKIN_TYPE_PROPOSE then
				setActive = var_2_0

				var_2_0(arg_2_0.picPropose, true)

				goto label_2_0
			end

			var_2_0 = arg_2_0.skin.shop_id

			if 0 < var_2_0 then
				setActive = var_2_0

				var_2_0(arg_2_0.picNotBuy, true)

				goto label_2_0
			end

			_ = var_2_0
			var_2_0 = var_2_0.any
			pg = var_5

			if not var_2_0(var_5.activity_shop_template.all, function(arg_3_0)
				pg = var_2_10001

				local var_3_0 = var_2_10001.activity_shop_template[arg_3_0].commodity_type

				DROP_TYPE_SKIN = var_2_10003

				return var_3_0 == var_2_10003 and var_1.commodity_id == arg_2_0.skin.id
			end) then
				_ = var_2_0
				var_2_0 = var_2_0.any
				pg = var_5

				if var_2_0(var_5.activity_shop_extra.all, function(arg_4_0)
					pg = var_2_10001

					local var_4_0 = var_2_10001.activity_shop_extra[arg_4_0].commodity_type

					DROP_TYPE_SKIN = var_2_10003

					return var_4_0 == var_2_10003 and var_1.commodity_id == arg_2_0.skin.id
				end) then
					setActive = var_2_0

					var_2_0(arg_2_0.picActivity, true)
				else
					setActive = var_2_0

					var_2_0(arg_2_0.picActivity, true)
				end

				::label_2_0::

				setActive = var_2_0

				var_2_0(arg_2_0.tags, true)

				for iter_2_0 = 0, arg_2_0.tags.childCount - 1 do
					setActive = var_1_10008

					local var_2_2 = arg_2_0.tags

					var_1_10008(var_9.GetChild(var_2_2, iter_2_0), false)
				end

				_ = var_4

				var_4.each(arg_2_1.tag, function(arg_5_0)
					setActive = var_2_10001

					local var_5_0 = arg_2_0.tags

					var_2_10001(var_2.Find(var_5_0, "tag" .. arg_5_0), true)

					return
				end)
				arg_2_0:flushSkin()

				return
			end
		end
	end
end

function var_0_0.updateData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_0.ship ~= arg_6_1 or arg_6_0.skin ~= arg_6_2 or arg_6_0.own ~= arg_6_3 or arg_6_0.skinId ~= arg_6_2.id then
		arg_6_0.ship = arg_6_1
		arg_6_0.skin = arg_6_2
		arg_6_0.own = arg_6_3
		arg_6_0.skinId = arg_6_0.skin.id
		ShipSkin = var_4

		local var_6_0 = var_4.GetChangeSkinData(arg_6_0.skin.id)

		if arg_6_3 and var_6_0 then
			setActive = var_6_2

			var_6_2(arg_6_0.changeSkinTF, true)
		else
			setActive = var_6_2

			var_6_2(arg_6_0.changeSkinTF, false)
		end

		local var_6_2

		if var_6_0 then
			local var_6_1 = arg_6_0.changeSkinToggle

			var_6_2 = var_6_2.setShipData

			local var_6_3 = arg_6_0.skin.id
			local var_6_4 = arg_6_0.ship

			var_6_2(var_6_1, var_6_3, var_8.GetShipPhantomMark(var_6_4))

			setActive = var_6_2

			local var_6_5 = arg_6_0.changeSkinTF
			local var_6_6 = arg_6_0.changeSkinToggle

			var_6_2(var_6_5, not var_7.IsAsmrSkin(var_6_6))
		end

		setActive = var_6_2

		var_6_2(arg_6_0.nameBar, true)

		setActive = var_6_2

		var_6_2(arg_6_0.effectBar, false)

		setText = var_6_2

		local var_6_7 = arg_6_0.name

		shortenString = var_7

		var_6_2(var_6_7, var_7(arg_6_2.name, 7))

		local var_6_8 = arg_6_0.skin.id
		local var_6_9 = arg_6_0.ship
		local var_6_10 = var_6_8 == var_6.getConfig(var_6_9, "skin_id")

		ShipSkin = var_6

		local var_6_11 = var_6.IsShareSkin(arg_6_0.ship, arg_6_0.skin.id)
		local var_6_12 = false

		if var_6_11 then
			ShipSkin = var_8
			var_6_12 = var_8.CanUseShareSkinForShip(arg_6_0.ship, arg_6_0.skin.id)
		end

		setActive = var_8

		var_8(arg_6_0.shareFlag, var_6_11)

		local var_6_13 = not var_6_10 and not arg_6_3 or var_6_11 and not var_6_12

		setActive = var_6_14

		var_6_14(arg_6_0.bgMark, var_6_13)

		if var_6_13 then
			setActive = var_6_14

			var_6_14(arg_6_0.picNotBuy, false)

			setActive = var_6_14

			var_6_14(arg_6_0.picActivity, false)

			setActive = var_6_14

			var_6_14(arg_6_0.picPropose, false)

			setActive = var_6_14

			var_6_14(arg_6_0.picShare, false)

			local var_6_14 = arg_6_2.skin_type

			ShipSkin = var_10

			if var_6_14 == var_10.SKIN_TYPE_PROPOSE then
				setActive = var_6_14

				var_6_14(arg_6_0.picPropose, true)

				goto label_6_0
			end

			if not arg_6_3 then
				var_6_14 = arg_6_0.skin.shop_id

				if 0 < var_6_14 then
					setActive = var_6_14

					var_6_14(arg_6_0.picNotBuy, true)

					goto label_6_0
				end
			end

			if not arg_6_3 then
				_ = var_6_14
				var_6_14 = var_6_14.any
				pg = var_10

				if not var_6_14(var_10.activity_shop_template.all, function(arg_7_0)
					pg = var_2_10001

					local var_7_0 = var_2_10001.activity_shop_template[arg_7_0].commodity_type

					DROP_TYPE_SKIN = var_2_10003

					return var_7_0 == var_2_10003 and var_1.commodity_id == arg_6_0.skin.id
				end) then
					_ = var_6_14
					var_6_14 = var_6_14.any
					pg = var_10

					if var_6_14(var_10.activity_shop_extra.all, function(arg_8_0)
						pg = var_2_10001

						local var_8_0 = var_2_10001.activity_shop_extra[arg_8_0].commodity_type

						DROP_TYPE_SKIN = var_2_10003

						return var_8_0 == var_2_10003 and var_1.commodity_id == arg_6_0.skin.id
					end) then
						setActive = var_6_14

						var_6_14(arg_6_0.picActivity, true)

						goto label_6_0
					end

					if var_6_11 and not var_6_12 then
						setActive = var_6_14

						var_6_14(arg_6_0.picShare, true)
					else
						setActive = var_6_14

						var_6_14(arg_6_0.picActivity, true)
					end

					::label_6_0::

					setActive = var_6_14

					var_6_14(arg_6_0.tags, true)

					for iter_6_0 = 0, arg_6_0.tags.childCount - 1 do
						setActive = var_1_10013

						local var_6_15 = arg_6_0.tags

						var_1_10013(var_14.GetChild(var_6_15, iter_6_0), false)
					end

					_ = var_9

					var_9.each(arg_6_2.tag, function(arg_9_0)
						setActive = var_2_10001

						local var_9_0 = arg_6_0.tags

						var_2_10001(var_2.Find(var_9_0, "tag" .. arg_9_0), true)

						return
					end)

					local var_6_16 = arg_6_0

					arg_6_0.flushSkin(var_6_16)

					local var_6_17 = arg_6_0.skin.id

					ShipSkin = var_6_16

					if var_6_16.IsChangeSkin(arg_6_0.skin.id) then
						ShipSkin = var_10
						var_6_17 = var_10.GetChangeSkinMainId(arg_6_0.skin.id)
					end

					getProxy = var_10
					ShipSkinProxy = var_11

					local var_6_18 = var_10(var_11)
					local var_6_19, var_6_20

					if var_10.getSkinById(var_6_18, var_6_17) then
						::label_6_1::

						var_6_19 = var_10

						if var_10.isExpireType(var_6_19) then
							var_6_19 = var_10
							var_6_20 = not var_10.isExpired(var_6_19)
						end
					end

					setActive = var_6_19

					var_6_19(arg_6_0.timelimitTag, var_6_20)

					setActive = var_6_19

					var_6_19(arg_6_0.timelimitTimeTxt, var_6_20)

					if arg_6_0.skinTimer then
						local var_6_21 = arg_6_0.skinTimer

						var_12.Stop(var_6_21)
					end

					if var_6_20 then
						Timer = var_12
						arg_6_0.skinTimer = var_12.New(function()
							skinTimeStamp = var_2_10000

							local var_10_0 = var_0
							local var_10_1 = var_2_10000(var_1.getRemainTime(var_10_0))

							setText = var_1

							local var_10_2 = arg_6_0.timelimitTimeTxt

							var_1(var_2.Find(var_10_2, "Text"), var_10_1)

							return
						end, 1, -1)

						local var_6_22 = arg_6_0.skinTimer

						var_12.Start(var_6_22)
						arg_6_0.skinTimer.func()
					end

					return
				end
			end
		end
	end
end

function var_0_0.updateSelected(arg_11_0, arg_11_1)
	if arg_11_0.selected ~= arg_11_1 then
		arg_11_0.selected = arg_11_1
		setActive = var_2

		local var_11_0 = arg_11_0.outline

		tobool = var_1_10004

		var_2(var_11_0, var_1_10004(arg_11_0.selected))
	end

	return
end

function var_0_0.updateUsing(arg_12_0, arg_12_1)
	if arg_12_0.using ~= arg_12_1 then
		arg_12_0.using = arg_12_1
		setActive = var_2

		var_2(arg_12_0.bgUsing, arg_12_0.using)
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
		retPaintingPrefab = var_1

		var_1(arg_14_0.painting, arg_14_0.paintingName)

		arg_14_0.paintingName = nil
	end

	return
end

function var_0_0.loadPainting(arg_15_0)
	local var_15_0

	if not arg_15_0.skin or not arg_15_0.skin.painting then
		var_15_0 = "unknown"
	end

	arg_15_0.paintingName = var_15_0
	checkABExist = var_15_0

	local var_15_1 = var_15_0("painting/" .. arg_15_0.paintingName .. "_n")

	setActive = var_2

	var_2(arg_15_0.hideObjToggle, var_15_1)

	local var_15_2 = arg_15_0.hideObjToggle

	PlayerPrefs = var_3
	var_15_2.isOn = var_3.GetInt("paint_hide_other_obj_" .. arg_15_0.paintingName, 0) ~= 0
	setPaintingPrefabAsync = var_15_2

	var_15_2(arg_15_0.painting, arg_15_0.paintingName, "pifu", nil, {
		skinID = arg_15_0.skin.id,
		rotateZ = arg_15_0.paintingDefaultAngle
	})

	return
end

function var_0_0.clear(arg_16_0)
	arg_16_0:clearPainting()

	arg_16_0.skin = nil
	arg_16_0.selected = nil
	arg_16_0.using = nil

	if arg_16_0.skinTimer then
		local var_16_0 = arg_16_0.skinTimer

		var_1.Stop(var_16_0)

		arg_16_0.skinTimer = nil
	end

	return
end

return var_0_0
