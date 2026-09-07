local MallStaffCard = class("MallStaffCard")

function MallStaffCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.iconTF = self._tf:Find("icon")
	self.nameText = self._tf:Find("name"):GetComponent(typeof(Text))
	self.selTF = self._tf:Find("sel")
	self.orderTF = self._tf:Find("mask/order")

	setText(self.orderTF:Find("Text"), i18n("mall_staff_in_order"))

	self.floorTF = self._tf:Find("mask/floor")
	self.attrTextTFs = {
		self._tf:Find("attrs/1/Text"),
		self._tf:Find("attrs/2/Text"),
		self._tf:Find("attrs/3/Text")
	}
	self.attrBgTFs = {
		self._tf:Find("attrs/1"),
		self._tf:Find("attrs/2"),
		self._tf:Find("attrs/3")
	}

	return
end

function MallStaffCard:Update(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.staff = arg_2_1
	self.id = self.staff.id
	self.tid = self.staff.tid
	self.nameText.text = pg.item_virtual_data_statistics[self.tid].name

	MallStaffCard.StaticUpdateIcon(self.iconTF, self.tid)

	self.attrList = self.staff:GetAttrList()

	for iter_2_0, iter_2_1 in ipairs(self.attrList) do
		setText(self.attrTextTFs[iter_2_0], iter_2_1)

		if table.contains(arg_2_4, iter_2_0) then
			GetImageSpriteFromAtlasAsync("ui/mallstafftpl_atlas", "attr_bg2", self.attrBgTFs[iter_2_0], true)
		else
			GetImageSpriteFromAtlasAsync("ui/mallstafftpl_atlas", "attr_bg1", self.attrBgTFs[iter_2_0], true)
		end
	end

	local var_2_1 = table.indexof(arg_2_2, self.id)

	setActive(self.selTF, var_2_1)

	if var_2_1 then
		setText(self.selTF:Find("Text"), var_2_1)
	end

	local var_2_2, var_2_3 = self.staff:GetStatusInfos()

	setActive(self.orderTF, var_2_2 == MallStaff.STATUS.ORDER)
	setActive(self.floorTF, var_2_2 == MallStaff.STATUS.FLOOR and (arg_2_3 and not var_2_1 or not arg_2_3))

	if var_2_2 == MallStaff.STATUS.FLOOR then
		setText(self.floorTF:Find("Text"), i18n("mall_staff_in_floor", var_2_3.floorId))
	end

	return
end

function MallStaffCard:Dispose()
	return
end

function MallStaffCard:StaticUpdateIcon(arg_4_1)
	GetImageSpriteFromAtlasAsync("ui/mallstafftpl_atlas", pg.activity_mall_staff_template[arg_4_1].icon_show[1], self:Find("body"))
	GetImageSpriteFromAtlasAsync("ui/mallstafftpl_atlas", pg.activity_mall_staff_template[arg_4_1].icon_show[2], self:Find("clothes"))
	GetImageSpriteFromAtlasAsync("ui/mallstafftpl_atlas", pg.activity_mall_staff_template[arg_4_1].icon_show[3], self:Find("face"))

	return
end

return MallStaffCard
