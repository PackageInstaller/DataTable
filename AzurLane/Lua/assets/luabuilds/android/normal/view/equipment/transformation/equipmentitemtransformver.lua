class = var_0_10000

local var_0_0 = "EquipmentItemTransformVer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.equipment.EquipmentItem"))

function var_0_1.update(arg_1_0, arg_1_1)
	setActive = var_1_10002

	var_1_10002(arg_1_0.equiped, false)

	setActive = var_1_10002

	var_1_10002(arg_1_0.unloadBtn, not arg_1_1)

	setActive = var_1_10002

	var_1_10002(arg_1_0.bg, arg_1_1)

	TweenItemAlphaAndWhite = var_1_10002

	var_1_10002(arg_1_0.go)

	if not arg_1_1 then
		return
	end

	arg_1_0.sourceVO = arg_1_1
	updateDrop = var_1_10002

	var_1_10002(arg_1_0.bg, arg_1_1)

	local var_1_0 = arg_1_1.template
	local var_1_1 = arg_1_0.bg
	local var_1_2 = arg_1_1.type

	DROP_TYPE_EQUIP = var_1_10005

	if var_1_2 == var_1_10005 then
		findTF = var_1_2
		var_1_2 = var_1_2(var_1_1, "icon_bg/new")
		setActive = var_5

		local var_1_3 = var_1_2

		var_1_10007 = var_1_0.new ~= 0

		var_5(var_1_3, var_1_10007)

		findTF = var_5

		local var_1_4 = var_5(var_1_1, "equip_flag")

		setActive = var_6

		var_6(var_1_4, var_1_0.shipId)

		if var_1_0.shipId then
			getProxy = var_6
			BayProxy = var_1_10007
			var_1_10007 = var_6(var_1_10007)

			local var_1_5 = var_6.getShipById(var_1_10007, var_1_0.shipId)

			setImageSprite = var_1_10007
			findTF = var_8

			local var_1_6 = var_8(var_1_4, "Image")

			LoadSprite = var_9

			var_1_10007(var_1_6, var_9("qicon/" .. var_1_5:getPainting()))
		end
	end

	findTF = var_1_2

	local var_1_7 = var_1_2(var_1_1, "name")
	local var_1_8 = var_4.GetComponent

	typeof = var_6
	Text = var_1_10007

	local var_1_9 = var_1_8(var_1_7, var_6(var_1_10007))

	shortenString = var_1_7
	var_1_9.text = var_1_7(arg_1_1:getConfig("name"), 5)
	IsNil = var_5

	if not var_5(arg_1_0.mask) then
		setActive = var_5

		var_5(arg_1_0.mask, var_1_0.mask)
	end

	local var_1_10 = arg_1_0.bg
	local var_1_11 = var_5.Find(var_1_10, "frameMask")

	setActive = var_1_10

	var_1_10(var_1_11, false)

	local var_1_12 = arg_1_1.type

	DROP_TYPE_ITEM = var_7

	if var_1_12 == var_7 then
		findTF = var_1_12

		local var_1_13 = var_1_12(arg_1_0.bg, "icon_bg/count")

		IsNil = var_7

		if not var_7(var_1_13) then
			local var_1_14 = var_1_0.count
			local var_1_15 = arg_1_1.composeCfg.material_num <= var_1_14

			setColorStr = var_1_10010

			local var_1_16 = var_1_14 .. "/" .. var_8

			if var_1_15 then
				COLOR_WHITE = var_12

				if not var_12 then
					COLOR_RED = var_12
				end

				local var_1_17 = var_1_10010(var_1_16, var_12)

				setText = var_1_16

				var_1_16(var_1_13, var_1_17)

				setActive = var_1_16

				var_1_16(var_1_11, not var_1_15)

				return
			end
		end
	end
end

function var_0_1.updateSelected(arg_2_0, arg_2_1)
	arg_2_0.selected = arg_2_1
	setActive = var_1_10002

	var_1_10002(arg_2_0.selectedMask, arg_2_1)

	return
end

return var_0_1
