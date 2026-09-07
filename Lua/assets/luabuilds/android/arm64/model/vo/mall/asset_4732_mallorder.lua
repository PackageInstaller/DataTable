local MallOrder = class("MallOrder")

function MallOrder:Ctor(arg_1_1)
	self.id = arg_1_1.cur_order
	self.startTime = arg_1_1.active_time

	self:UpdateEndTime()

	self.staffList = arg_1_1.employee_list
	self.finishedList = arg_1_1.finish_order_list

	return
end

function MallOrder:GetEndTime()
	return self.endTime
end

function MallOrder:GetFinishedList()
	return self.finishedList
end

function MallOrder:IsFinishedAll()
	return #self.finishedList == #pg.activity_mall_custom_order.all
end

function MallOrder:GetStaffList()
	return self.staffList
end

function MallOrder:UpdateEndTime()
	self.endTime = (self.id == 0 or self.startTime == 0) and 0 or self.startTime + pg.activity_mall_custom_order[self.id].cost_time

	return
end

function MallOrder:StartOrder(arg_7_1, arg_7_2, arg_7_3)
	self.id = arg_7_1
	self.startTime = arg_7_2

	self:UpdateEndTime()

	self.staffList = arg_7_3

	return
end

function MallOrder:CompleteOrder(arg_8_1)
	table.insert(self.finishedList, arg_8_1)

	self.id = 0
	self.startTime = 0
	self.endTime = 0
	self.staffList = {}

	return
end

function MallOrder:GetCostGold()
	return pg.activity_mall_custom_order[self].order_cost_gold
end

function MallOrder:GetCost()
	return underscore.map(pg.activity_mall_custom_order[self].order_cost_show, function(arg_11_0)
		return Drop.Create(arg_11_0)
	end)
end

return MallOrder
