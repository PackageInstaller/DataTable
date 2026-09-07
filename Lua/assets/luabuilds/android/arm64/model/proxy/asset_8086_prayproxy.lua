local Prayproxy = class("Prayproxy", import(".NetProxy"))

Prayproxy.STATE_HOME = 1
Prayproxy.STATE_SELECT_POOL = 2
Prayproxy.STAGE_SELECT_SHIP = 3
Prayproxy.STAGE_BUILD_SUCCESS = 4

function Prayproxy:register()
	self.selectedPoolType = nil
	self.selectedShipCount = 0
	self.needSelectShipCount = nil
	self.selectedShipIDList = {}
	self.pageState = Prayproxy.STATE_HOME
	self.tagConstructed = false

	return
end

function Prayproxy:setSelectedPoolNum(arg_2_1)
	self.selectedPoolType = arg_2_1

	return
end

function Prayproxy:setSelectedShipList(arg_3_1)
	self.selectedShipIDList = arg_3_1

	return
end

function Prayproxy:updateSelectedPool(arg_4_1)
	self.selectedPoolType = arg_4_1
	self.needSelectShipCount = pg.activity_ship_create[arg_4_1].pickup_num
	self.selectedShipCount = 0
	self.selectedShipIDList = {}

	return
end

function Prayproxy:updatePageState(arg_5_1)
	if arg_5_1 ~= Prayproxy.STATE_HOME and arg_5_1 ~= Prayproxy.STATE_SELECT_POOL and arg_5_1 ~= Prayproxy.STAGE_SELECT_SHIP and arg_5_1 ~= Prayproxy.STAGE_BUILD_SUCCESS then
		assert(false, "没有定义的pageState参数" .. arg_5_1)
	end

	self.pageState = arg_5_1

	return
end

function Prayproxy:insertSelectedShipIDList(arg_6_1)
	if self.selectedShipCount == self.needSelectShipCount then
		assert(false, "已选舰娘已经达到上限,不允许插入")
	end

	self.selectedShipIDList[#self.selectedShipIDList + 1] = arg_6_1
	self.selectedShipCount = self.selectedShipCount + 1

	return
end

function Prayproxy:removeSelectedShipIDList(arg_7_1)
	if self.selectedShipCount == 0 then
		assert(false, "没有已选舰娘,不允许删除")
	end

	local var_7_0

	for iter_7_0, iter_7_1 in ipairs(self.selectedShipIDList) do
		if iter_7_1 == arg_7_1 then
			var_7_0 = iter_7_0

			table.remove(self.selectedShipIDList, iter_7_0)

			self.selectedShipCount = self.selectedShipCount - 1
		end
	end

	if not var_7_0 then
		assert(false, "已选列表不存在该ID的舰娘")
	end

	return
end

function Prayproxy:getPageState()
	return self.pageState
end

function Prayproxy:getSelectedPoolType()
	return self.selectedPoolType
end

function Prayproxy:getSelectedShipIDList()
	return self.selectedShipIDList
end

function Prayproxy:getSelectedShipCount()
	return self.selectedShipCount
end

return Prayproxy
