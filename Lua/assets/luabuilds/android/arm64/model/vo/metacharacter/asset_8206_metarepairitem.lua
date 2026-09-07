local MetaRepairItem = class("MetaRepairItem", import("..BaseVO"))

function MetaRepairItem:bindConfigTable()
	return pg.ship_meta_repair
end

function MetaRepairItem:Ctor(arg_2_1)
	self.id = arg_2_1.id
	self.configId = self.id
	self.itemId = self:getConfig("item_id")
	self.totalCnt = self:getConfig("item_num")
	self.repairExp = self:getConfig("repair_exp")

	local var_2_0 = self:getConfig("effect_attr")

	self.addition = {
		attr = var_2_0[1],
		value = var_2_0[2]
	}

	return
end

function MetaRepairItem:getItemId()
	return self.itemId
end

function MetaRepairItem:getTotalCnt()
	return self.totalCnt or 0
end

function MetaRepairItem:getRepairExp()
	return self.repairExp
end

function MetaRepairItem:getAdditionValue()
	return self.addition.value
end

return MetaRepairItem
