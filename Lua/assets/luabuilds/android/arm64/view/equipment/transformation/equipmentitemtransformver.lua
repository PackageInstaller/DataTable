local var_0_0 = class("EquipmentItemTransformVer", import("view.equipment.EquipmentItem"))

function var_0_0.update(arg_1_0, arg_1_1)
	setActive(arg_1_0.equiped, false)
	setActive(arg_1_0.unloadBtn, not arg_1_1)
	setActive(arg_1_0.bg, arg_1_1)
	TweenItemAlphaAndWhite(arg_1_0.go)

	if not arg_1_1 then
		return
	end

	arg_1_0.sourceVO = arg_1_1

	updateDrop(arg_1_0.bg, arg_1_1)

	local var_1_0 = arg_1_1.template
	local var_1_1 = arg_1_0.bg

	if arg_1_1.type == DROP_TYPE_EQUIP then
		setActive(findTF(var_1_1, "icon_bg/new"), var_1_0.new ~= 0)

		local var_1_2 = findTF(var_1_1, "equip_flag")

		setActive(var_1_2, var_1_0.shipId)

		if var_1_0.shipId then
			setImageSprite(findTF(var_1_2, "Image"), LoadSprite("qicon/" .. getProxy(BayProxy):getShipById(var_1_0.shipId):getPainting()))
		end
	end

	local var_1_3 = findTF(var_1_1, "name")

	var_1_3:GetComponent(typeof(Text)).text = shortenString(arg_1_1:getConfig("name"), 5)

	if not IsNil(arg_1_0.mask) then
		setActive(arg_1_0.mask, var_1_0.mask)
	end

	local var_1_4 = arg_1_0.bg:Find("frameMask")

	setActive(var_1_4, false)

	if arg_1_1.type == DROP_TYPE_ITEM then
		local var_1_5 = findTF(arg_1_0.bg, "icon_bg/count")

		if not IsNil(var_1_5) then
			local var_1_6 = arg_1_1.composeCfg.material_num <= var_1_0.count
			local var_1_8 = var_1_0.count .. "/" .. arg_1_1.composeCfg.material_num

			if arg_1_1.composeCfg.material_num <= var_1_0.count then
				local var_1_9 = COLOR_WHITE or COLOR_RED

				setText(var_1_5, (var_1_7(var_1_8, var_1_9)))
				setActive(var_1_4, not var_1_6)

				return
			end
		end
	end
end

function var_0_0.updateSelected(arg_2_0, arg_2_1)
	arg_2_0.selected = arg_2_1

	setActive(arg_2_0.selectedMask, arg_2_1)

	return
end

return var_0_0
