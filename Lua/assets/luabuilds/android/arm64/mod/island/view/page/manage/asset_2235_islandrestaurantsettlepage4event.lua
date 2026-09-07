local IslandRestaurantSettlePage4Event = class("IslandRestaurantSettlePage4Event", import(".IslandRestaurantSettlePage"))

function IslandRestaurantSettlePage4Event:getUIName()
	return "IslandRestaurantSettle4EventUI"
end

function IslandRestaurantSettlePage4Event:OnLoaded()
	IslandRestaurantSettlePage4Event.super.OnLoaded(self)

	self.additionList = UIItemList.New(self._tf:Find("window/event/addition"), self._tf:Find("window/event/addition/tpl"))
	self.priceAdd = self._tf:Find("window/summary/price/info/addition/Text"):GetComponent(typeof(Text))

	setText(self._tf:Find("window/event/Image/Text"), i18n("island_post_event_label"))

	return
end

function IslandRestaurantSettlePage4Event:OnShow(arg_3_1, arg_3_2)
	self:UpdateAddition(arg_3_1)
	self:UpdatePriceAdd(arg_3_1)

	self.itemList = arg_3_1.itemList or {}

	IslandRestaurantSettlePage4Event.super.OnShow(self, arg_3_1, arg_3_2)

	return
end

function IslandRestaurantSettlePage4Event:UpdateAddition(arg_4_1)
	local var_4_0 = self:WarpAdditionInfo(pg.island_manage_event[arg_4_1.spEventID])

	self.additionList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			setText(arg_5_2:Find("Text"), var_4_0[arg_5_1 + 1][1])
			setText(arg_5_2:Find("value"), "+" .. var_4_0[arg_5_1 + 1][2] .. "%")
		end

		return
	end)
	self.additionList:align(#var_4_0)

	return
end

function IslandRestaurantSettlePage4Event:WarpAdditionInfo(arg_6_1)
	local var_6_0 = {}

	table.insert(var_6_0, {
		i18n("island_addition_influence"),
		arg_6_1.influence_bonus
	})
	table.insert(var_6_0, {
		i18n("island_addition_sale"),
		arg_6_1.event_effect[1][1]
	})

	return var_6_0
end

function IslandRestaurantSettlePage4Event:UpdatePriceAdd(arg_7_1)
	self.priceAdd.text = "(+" .. arg_7_1.priceAdd .. ")"

	return
end

function IslandRestaurantSettlePage4Event:UpdateCommonItem(arg_8_1, arg_8_2)
	IslandRestaurantSettlePage4Event.super.UpdateCommonItem(self, arg_8_1, arg_8_2)
	setActive(arg_8_1:Find("event"), table.contains(self.itemList, arg_8_2.id))

	return
end

return IslandRestaurantSettlePage4Event
