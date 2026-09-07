local IslandShipOrderDelegateSlot = class("IslandShipOrderDelegateSlot")

function IslandShipOrderDelegateSlot:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.showTime = arg_1_1.view_time
	self.request = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.cost or {}) do
		table.insert(self.request, {
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_1_1.id,
			count = iter_1_1.num
		})
	end

	self.awards = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.reward or {}) do
		table.insert(self.awards, {
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_1_3.id,
			count = iter_1_3.num
		})
	end

	return
end

function IslandShipOrderDelegateSlot:GetShowTime()
	return self.showTime
end

function IslandShipOrderDelegateSlot:CanShow()
	return pg.TimeMgr.GetInstance():GetServerTime() >= self.showTime
end

function IslandShipOrderDelegateSlot:GetRequestList()
	return self.request
end

function IslandShipOrderDelegateSlot:GetAwardList()
	return self.awards
end

return IslandShipOrderDelegateSlot
