class = var_0_10000

local var_0_0 = var_0_10000("CollectionShipCard")

var_0_0.TypeCard = 1
var_0_0.TypeTrans = 2
pg = var_1

local var_0_1 = var_1.ship_data_group

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	GetOrAddComponent = var_2
	arg_1_0.btn = var_2(arg_1_1, "Button")
	findTF = var_2
	arg_1_0.content = var_2(arg_1_0.tr, "content").gameObject
	setActive = var_2
	findTF = var_3

	var_2(var_3(arg_1_0.content, "dockyard"), false)

	setActive = var_2
	findTF = var_3

	var_2(var_3(arg_1_0.content, "collection"), true)

	setActive = var_2
	findTF = var_3

	var_2(var_3(arg_1_0.content, "expbuff"), false)

	findTF = var_2
	arg_1_0.shipFrameImg = var_2(arg_1_0.content, "front/frame")
	findTF = var_2

	local var_1_0 = var_2(arg_1_0.content, "ship_icon")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0.iconShip = var_1_1(var_1_0, var_4(var_5))
	findTF = var_2

	local var_1_2 = var_2(arg_1_0.content, "bg")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0.imageBg = var_1_3(var_1_2, var_4(var_5))
	findTF = var_2
	arg_1_0.labelName = var_2(arg_1_0.content, "info/name_mask/name")
	GetOrAddComponent = var_2
	findTF = var_3

	local var_1_4 = var_3(arg_1_0.content, "info/name_mask")

	typeof = var_4
	RectMask2D = var_5
	arg_1_0.mask2D = var_2(var_1_4, var_4(var_5))
	findTF = var_2

	local var_1_5 = var_2(arg_1_0.content, "info/top/type")
	local var_1_6 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0.iconType = var_1_6(var_1_5, var_4(var_5))
	findTF = var_2
	arg_1_0.ringTF = var_2(arg_1_0.content, "front/ring")
	findTF = var_2
	arg_1_0.ringMetaTF = var_2(arg_1_0.content, "front/ring_meta")
	findTF = var_2
	arg_1_0.maskTF = var_2(arg_1_0.content, "collection/mask")
	findTF = var_2
	arg_1_0.heart = var_2(arg_1_0.content, "collection/heart")
	findTF = var_2

	local var_1_7 = var_2(arg_1_0.heart, "heart")
	local var_1_8 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_1_0.labelHeart = var_1_8(var_1_7, var_4(var_5))
	findTF = var_2

	local var_1_9 = var_2(arg_1_0.heart, "icon")
	local var_1_10 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0.labelHeartIcon = var_1_10(var_1_9, var_4(var_5))
	findTF = var_2

	local var_1_11 = var_2(arg_1_0.heart, "heart+")
	local var_1_12 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_1_0.labelHeartPlus = var_1_12(var_1_11, var_4(var_5))
	findTF = var_2

	local var_1_13 = var_2(arg_1_0.tr, "unknown")
	local var_1_14 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0.imageUnknown = var_1_14(var_1_13, var_4(var_5))
	ClearTweenItemAlphaAndWhite = var_2

	var_2(arg_1_0.go)

	return
end

function var_0_0.getIsInited(arg_2_0)
	return arg_2_0.shipGroup ~= nil
end

function var_0_0.update(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	ShipGroup = var_1_10006

	local var_3_0 = var_1_10006.getState(arg_3_5, arg_3_2, arg_3_3)

	if arg_3_0.code ~= arg_3_1 or arg_3_0.shipGroup ~= arg_3_2 or arg_3_0.showTrans ~= arg_3_3 or arg_3_0.propose ~= arg_3_4 or arg_3_0.state ~= var_3_0 then
		arg_3_0.code = arg_3_1
		arg_3_0.shipGroup = arg_3_2
		arg_3_0.showTrans = arg_3_3
		arg_3_0.propose = arg_3_4
		arg_3_0.state = var_3_0
		arg_3_0.config = var_0_1[arg_3_5]

		arg_3_0:flush()
	end

	TweenItemAlphaAndWhite = var_7

	var_7(arg_3_0.go)

	return
end

function var_0_0.flush(arg_4_0)
	local var_4_0 = arg_4_0.shipGroup

	setActive = var_1_10002

	local var_4_1 = arg_4_0.heart
	local var_4_2 = arg_4_0.state

	ShipGroup = var_1_10005

	var_1_10002(var_4_1, var_4_2 == var_1_10005.STATE_UNLOCK)

	local var_4_3 = arg_4_0.state

	ShipGroup = var_4_1

	if var_4_3 == var_4_1.STATE_UNLOCK then
		var_4_3 = arg_4_0.labelHeart

		local var_4_4

		if var_4_0.hearts > 999 then
			var_4_4 = "999"
		else
			tostring = var_4_4
			var_4_4 = var_4_4(var_4_0.hearts)
		end

		var_4_3.text = var_4_4
		setActive = var_4_3
		var_4_4 = arg_4_0.labelHeartPlus

		local var_4_5 = var_4_0.hearts

		var_4_3(var_4_4, 999 < var_4_5)

		var_4_3 = arg_4_0.labelHeart

		if var_4_0.iheart then
			Color = var_4_4

			if not var_4_4.New(1, 0.6, 0.6) then
				Color = var_4_4
				var_4_4 = var_4_4.New(1, 1, 1)
			end

			var_4_3.color = var_4_4
			var_4_3 = arg_4_0.labelHeartIcon

			if var_4_0.iheart then
				Color = var_4_4

				if not var_4_4.New(1, 0.6, 0.6) then
					Color = var_4_4
					var_4_4 = var_4_4.New(1, 1, 1)
				end

				var_4_3.color = var_4_4
				var_4_3 = arg_4_0.labelHeartPlus

				if var_4_0.iheart then
					Color = var_4_4

					if not var_4_4.New(1, 0.6, 0.6) then
						Color = var_4_4
						var_4_4 = var_4_4.New(1, 1, 1)
					end

					var_4_3.color = var_4_4
					var_4_4 = arg_4_0

					arg_4_0.loadImage(var_4_4, arg_4_0.shipGroup, true)

					goto label_4_0

					var_4_3 = arg_4_0.state
					ShipGroup = var_4_4

					do
						local var_4_6

						if var_4_3 == var_4_4.STATE_NOTGET then
							ShipGroup = var_4_3
							arg_4_0.shipGroup = var_4_3.New({
								id = arg_4_0.config.group_type
							})
							var_4_3 = arg_4_0.shipGroup
							var_4_3.trans = true
							PLATFORM_CODE = var_4_3
							PLATFORM_CH = var_4_6

							if var_4_3 == var_4_6 then
								HXSet = var_4_3

								if var_4_3.isHx() then
									var_4_6 = arg_4_0

									arg_4_0.loadImage(var_4_6, arg_4_0.shipGroup, false)

									goto label_4_0
								end
							end

							var_4_6 = arg_4_0

							arg_4_0.loadImage(var_4_6, arg_4_0.shipGroup, true)
						else
							var_4_3 = arg_4_0.state
							ShipGroup = var_4_6

							if var_4_3 == var_4_6.STATE_LOCK then
								-- block empty
							end
						end
					end

					::label_4_0::

					setActive = var_4_3

					local var_4_7 = arg_4_0.content
					local var_4_8 = arg_4_0.state

					ShipGroup = var_5

					local var_4_10

					if var_4_8 ~= var_5.STATE_NOTGET then
						local var_4_9 = arg_4_0.state

						ShipGroup = var_5

						if var_4_9 ~= var_5.STATE_UNLOCK then
							var_4_10 = false

							goto label_4_1
						end
					end

					var_4_10 = true

					::label_4_1::

					var_4_3(var_4_7, var_4_10)

					setActive = var_4_3

					local var_4_11 = arg_4_0.imageUnknown
					local var_4_12 = arg_4_0.state

					ShipGroup = var_5

					var_4_3(var_4_11, var_4_12 == var_5.STATE_LOCK)

					setActive = var_4_3

					local var_4_13 = arg_4_0.maskTF
					local var_4_14 = arg_4_0.state

					ShipGroup = var_5

					var_4_3(var_4_13, var_4_14 == var_5.STATE_NOTGET)

					if var_4_0 then
						local var_4_15 = var_4_0

						var_4_3 = var_4_0.isMetaGroup(var_4_15)
						setActive = var_4_15

						local var_4_16 = arg_4_0.ringTF
						local var_4_17

						if arg_4_0.propose then
							var_4_17 = not var_4_3
						end

						var_4_15(var_4_16, var_4_17)

						setActive = var_4_15

						local var_4_18 = arg_4_0.ringMetaTF
						local var_4_19

						if arg_4_0.propose then
							var_4_19 = var_4_3
						end

						var_4_15(var_4_18, var_4_19)
					else
						setActive = var_4_3

						var_4_3(arg_4_0.ringTF, false)

						setActive = var_4_3

						var_4_3(arg_4_0.ringMetaTF, false)
					end

					local var_4_20

					if not arg_4_0.mask2D.enabled then
						var_4_20 = arg_4_0.mask2D
						var_4_20.enabled = true
					end

					setActive = var_4_20

					var_4_20(arg_4_0.labelName, false)

					setActive = var_4_20

					var_4_20(arg_4_0.labelName, true)

					return
				end
			end
		end
	end
end

function var_0_0.loadImage(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:rarity2bgPrint(arg_5_0.showTrans)

	if arg_5_2 then
		local var_5_1 = arg_5_1
		local var_5_2

		if not arg_5_1.getPainting(var_5_1, arg_5_0.showTrans) then
			var_5_2 = "unknown"
		end

		GetImageSpriteFromAtlasAsync = var_5_1

		var_5_1("bg/star_level_card_" .. var_5_0, "", arg_5_0.imageBg)

		arg_5_0.loadingPaintingName = var_5_2
		GetSpriteFromAtlasAsync = var_5_1

		var_5_1("shipYardIcon/" .. var_5_2, "", function(arg_6_0)
			IsNil = var_2_10001

			if not var_2_10001(arg_5_0.go) and arg_5_0.loadingPaintingName == var_5_2 then
				arg_5_0.iconShip.sprite = arg_6_0
			end

			return
		end)

		local var_5_3 = arg_5_0.iconType

		GetSpriteFromAtlas = var_6

		local var_5_4 = "shiptype"

		shipType2print = var_8
		var_5_3.sprite = var_6(var_5_4, var_8(arg_5_1:getShipType(arg_5_0.showTrans)))
		setScrollText = var_5_3

		var_5_3(arg_5_0.labelName, arg_5_1:getName(arg_5_0.showTrans))

		setShipCardFrame = var_5_3

		var_5_3(arg_5_0.shipFrameImg, var_5_0)

		return
	end
end

function var_0_0.clear(arg_7_0)
	arg_7_0.shipGroup = nil
	arg_7_0.showTrans = nil
	arg_7_0.propose = nil
	arg_7_0.code = nil
	ClearTweenItemAlphaAndWhite = var_1

	var_1(arg_7_0.go)

	return
end

return var_0_0
