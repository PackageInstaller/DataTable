local EquipmentItemTransformVer = class("EquipmentItemTransformVer", import("view.equipment.EquipmentItem"))

function EquipmentItemTransformVer:update(arg_1_1)
	setActive(self.equiped, false)
	setActive(self.unloadBtn, not arg_1_1)
	setActive(self.bg, arg_1_1)
	TweenItemAlphaAndWhite(self.go)

	if not arg_1_1 then
		return
	end

	self.sourceVO = arg_1_1

	updateDrop(self.bg, arg_1_1)

	local var_1_0 = arg_1_1.template
	local var_1_1 = self.bg

	if arg_1_1.type == DROP_TYPE_EQUIP then
		setActive(findTF(var_1_1, "icon_bg/new"), var_1_0.new ~= 0)

		local var_1_2 = findTF(var_1_1, "equip_flag")

		setActive(var_1_2, var_1_0.shipId)

		if var_1_0.shipId then
			setImageSprite(findTF(var_1_2, "Image"), LoadSprite("qicon/" .. getProxy(BayProxy):getShipById(var_1_0.shipId):getPainting()))
		end
	end

	findTF(var_1_1, "name"):GetComponent(typeof(Text)).text = shortenString(arg_1_1:getConfig("name"), 5)

	if not IsNil(self.mask) then
		setActive(self.mask, var_1_0.mask)
	end

	local var_1_3 = self.bg:Find("frameMask")

	setActive(var_1_3, false)

	if arg_1_1.type == DROP_TYPE_ITEM then
		local var_1_4 = findTF(self.bg, "icon_bg/count")

		if not IsNil(var_1_4) then
			local var_1_5 = arg_1_1.composeCfg.material_num <= var_1_0.count

			setText(var_1_4, (setColorStr(var_1_0.count .. "/" .. arg_1_1.composeCfg.material_num, (arg_1_1.composeCfg.material_num <= var_1_0.count or nil) and (COLOR_WHITE or COLOR_RED))))
			setActive(var_1_3, not var_1_5)
		end
	end

	return
end

function EquipmentItemTransformVer:updateSelected(arg_2_1)
	self.selected = arg_2_1

	setActive(self.selectedMask, arg_2_1)

	return
end

return EquipmentItemTransformVer
