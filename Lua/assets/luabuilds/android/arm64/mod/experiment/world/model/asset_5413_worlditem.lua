local WorldItem = class("WorldItem", import(".....model.vo.Item"))

WorldItem.UsageBuff = "usage_world_buff"
WorldItem.UsageDrop = "usage_drop"
WorldItem.UsageLoot = "usage_undefined"
WorldItem.UsageHPRegenerate = "usage_world_healing"
WorldItem.UsageHPRegenerateValue = "usage_world_healing_value"
WorldItem.UsageRecoverAp = "usage_world_recoverAP"
WorldItem.UsageWorldMap = "usage_world_map"
WorldItem.UsageWorldItem = "usage_world_item"
WorldItem.UsageWorldClean = "usage_world_clean"
WorldItem.UsageWorldBuff = "usage_worldSLGbuff"
WorldItem.UsageDropAppointed = "usage_drop_appointed"
WorldItem.UsageWorldFlag = "usage_world_flag"
WorldItem.MoneyId = 100
WorldItem.PortMoneyId = 101

function WorldItem:Ctor(arg_1_1)
	self.type = DROP_TYPE_WORLD_ITEM
	self.id = arg_1_1.id
	self.configId = self.id
	self.count = arg_1_1.count

	return
end

function WorldItem:bindConfigTable()
	return pg.world_item_data_template
end

function WorldItem:getConfigTable()
	return BaseVO.getConfigTable(self)
end

function WorldItem:getWorldItemType()
	return self:getConfig("usage")
end

function WorldItem:getWorldItemOpenDisplay()
	return self:getConfig("open_box")
end

function WorldItem:getItemQuota()
	return self:getConfig("usage_arg")[1]
end

function WorldItem:getItemBuffID()
	return self:getConfig("usage_arg")[2]
end

function WorldItem:getItemRegenerate()
	return self:getConfig("usage_arg")[2]
end

function WorldItem:getItemStaminaRecover()
	return self:getConfig("usage_arg")[1]
end

function WorldItem:getItemWorldBuff()
	local var_10_0 = self:getConfig("usage_arg")

	return var_10_0[1], var_10_0[2]
end

function WorldItem:getItemFlagKey()
	return self:getConfig("usage_arg")[1]
end

function WorldItem:isDesignDrawing()
	return false
end

return WorldItem
