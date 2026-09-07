local IslandItemCard = class("IslandItemCard")

function IslandItemCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.nameTxt = self._tf:Find("name_bg/name"):GetComponent(typeof(Text))
	self.cntTxt = self._tf:Find("icon_bg/count_bg/count"):GetComponent(typeof(Text))
	self.calcPanel = self._tf:Find("calc")
	self.reduceBtn = self._tf:Find("calc/btn")
	self.valueInput = self.calcPanel:Find("InputField")
	self.mask = self._tf:Find("mask")
	self.maskTxt = self.mask:Find("Text"):GetComponent(typeof(Text))

	return
end

function IslandItemCard:Update(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.item = arg_2_1
	self.nameTxt.text = self:ShortenString(arg_2_1:GetName(), 6)

	updateCustomDrop(self._tf, Drop.New({
		type = DROP_TYPE_ISLAND_ITEM,
		id = arg_2_1.id,
		count = arg_2_1:GetCount()
	}))

	local var_2_0 = arg_2_2 == IslandInventoryPage.MODE_EDIT

	setActive(self.calcPanel, arg_2_2 == IslandInventoryPage.MODE_EDIT)

	if var_2_0 then
		self:UpdateValue(arg_2_3)
	end

	self:UpdateTip(arg_2_1, arg_2_4)

	return
end

function IslandItemCard:UpdateTip(arg_3_1, arg_3_2)
	if arg_3_2 ~= IslandInventoryPage.INVENTORY_TYPE_OVERFLOW then
		setActive(self.mask, false)

		return
	end

	setActive(self.mask, true)

	self.maskTxt.text = getProxy(IslandProxy):GetIsland():GetInventoryAgency():OwnItem() and i18n("island_item_overflow", arg_3_1:GetCount()) or i18n("island_item_no_capacity")

	return
end

function IslandItemCard:UpdateValue(arg_4_1)
	setActive(self.calcPanel, arg_4_1 > 0)
	setInputText(self.valueInput, arg_4_1)

	return
end

function IslandItemCard:Dispose()
	return
end

function IslandItemCard:ShortenString(arg_6_1, arg_6_2)
	local var_6_0 = 1
	local var_6_1 = 0
	local var_6_2 = 0
	local var_6_3 = false

	while var_6_0 <= #arg_6_1 do
		local var_6_4, var_6_5 = GetPerceptualSize((string.byte(arg_6_1, var_6_0)))

		var_6_0 = var_6_0 + var_6_4
		var_6_1 = var_6_1 + var_6_5

		local var_6_6 = math.ceil(var_6_1)

		if var_6_6 == arg_6_2 - 1 then
			var_6_2 = var_6_0
		elseif arg_6_2 < var_6_6 then
			var_6_3 = true

			break
		end
	end

	if var_6_2 == 0 or #arg_6_1 < var_6_2 or not var_6_3 then
		return arg_6_1
	end

	return string.sub(arg_6_1, 1, var_6_2 - 1) .. ".."
end

return IslandItemCard
