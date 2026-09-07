local ShipExpItemUsageCard = class("ShipExpItemUsageCard")

function ShipExpItemUsageCard:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self.nameTxt = arg_1_1:Find("name"):GetComponent(typeof(Text))
	self.itemTF = arg_1_1:Find("item")
	self.valueTxt = arg_1_1:Find("value/Text"):GetComponent(typeof(Text))
	self.value = 0

	pressPersistTrigger(arg_1_1:Find("m10"), 0.5, function()
		self.value = self.value - 10

		self:UpdateValue(true)

		return
	end, nil, true, true, 0.15, SFX_PANEL)
	pressPersistTrigger(arg_1_1:Find("a10"), 0.5, function()
		self.value = self.value + 10

		self:UpdateValue()

		return
	end, nil, true, true, 0.15, SFX_PANEL)
	pressPersistTrigger(arg_1_1:Find("a1"), 0.5, function()
		self.value = self.value + 1

		self:UpdateValue()

		return
	end, nil, true, true, 0.15, SFX_PANEL)
	pressPersistTrigger(arg_1_1:Find("m1"), 0.5, function()
		self.value = self.value - 1

		self:UpdateValue(true)

		return
	end, nil, true, true, 0.15, SFX_PANEL)

	return
end

function ShipExpItemUsageCard:SetCallBack(arg_6_1)
	self.callback = arg_6_1

	return
end

function ShipExpItemUsageCard:GetItem(arg_7_1)
	local var_7_0 = getProxy(BagProxy):getItemById(arg_7_1)

	var_7_0 = var_7_0 or Drop.New({
		count = 0,
		type = DROP_TYPE_ITEM,
		id = arg_7_1
	})

	return var_7_0
end

function ShipExpItemUsageCard:Update(arg_8_1)
	self.value = 0

	local var_8_0 = self:GetItem(arg_8_1)

	self.item = var_8_0

	updateDrop(self.itemTF, {
		type = DROP_TYPE_ITEM,
		id = arg_8_1,
		count = var_8_0.count
	})

	if var_8_0.count == 0 then
		setText(self.itemTF:Find("icon_bg/count"), 0)
	end

	self.nameTxt.text = string.format("<color=#%s>%s</color>", ItemRarity.Rarity2HexColor(var_8_0:getConfig("rarity")), var_8_0:getConfig("name"))

	self:UpdateValue()

	return
end

function ShipExpItemUsageCard:UpdateValue(arg_9_1)
	self.value = math.min(self.value, self.item.count)
	self.value = math.max(self.value, 0)
	self.valueTxt.text = self.value

	if self.callback then
		self:callback(self.item.id, self.value, arg_9_1)
	end

	return
end

function ShipExpItemUsageCard:ForceUpdateValue(arg_10_1)
	self.value = arg_10_1
	self.valueTxt.text = self.value

	return
end

function ShipExpItemUsageCard:Dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return ShipExpItemUsageCard
