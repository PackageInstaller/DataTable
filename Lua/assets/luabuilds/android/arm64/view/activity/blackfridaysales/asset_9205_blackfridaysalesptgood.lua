local NewServerPTGood = class("NewServerPTGood", import(".....model.vo.BaseVO"))

NewServerPTGood.GoodType = {
	MultiTotalLimit = 2,
	SingleLimit = 1,
	MultiEachLimit = 4,
	RandomLimit = 3
}

function NewServerPTGood:bindConfigTable()
	return pg.newserver_shop_template
end

function NewServerPTGood:Ctor(arg_2_1)
	self.id = arg_2_1
	self.configId = arg_2_1
	self.configID = arg_2_1
	self.count = -1
	self.multiEachInfoMap = {}
	self.isMultiEachLimit = false

	return
end

function NewServerPTGood:updateAllInfo(arg_3_1)
	self.count = arg_3_1.data2KeyValueList[self.configId].value

	if self:getConfig("goods_type") == NewServerPTGood.GoodType.MultiEachLimit then
		self.isMultiEachLimit = true

		for iter_3_0, iter_3_1 in pairs(arg_3_1.data2KeyValueList[self.configId].dataMap) do
			self.multiEachInfoMap[iter_3_0] = iter_3_1
		end
	end

	return
end

function NewServerPTGood:updateCount(arg_4_1)
	self.count = self.count - arg_4_1

	return
end

function NewServerPTGood:isLeftCount()
	return self.count > 0
end

function NewServerPTGood:getCount()
	return self.count
end

function NewServerPTGood:isSelectable()
	local var_7_0 = self:getConfig("goods_type")

	return var_7_0 == NewServerPTGood.GoodType.MultiTotalLimit or var_7_0 == NewServerPTGood.GoodType.MultiEachLimit
end

function NewServerPTGood:getContainIDList()
	return self:getConfig("goods")
end

function NewServerPTGood:getUnlockIndex()
	return self:getConfig("unlock_time") / 0 + 1
end

return NewServerPTGood
