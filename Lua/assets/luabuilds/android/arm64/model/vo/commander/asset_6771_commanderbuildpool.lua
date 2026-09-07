local CommanderBuildPool = class("CommanderBuildPool", import("..BaseVO"))

function CommanderBuildPool:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id

	return
end

function CommanderBuildPool:bindConfigTable()
	return pg.commander_data_create_material
end

function CommanderBuildPool:getName()
	return self:getConfig("name") or Item.New({
		id = self:getConfig("use_item")
	}):getConfig("name") or ""
end

function CommanderBuildPool:getConsume()
	return {
		{
			2,
			self:getConfig("use_item"),
			(self:getConfig("number_1"))
		}
	}
end

function CommanderBuildPool:getConsumeDesc()
	local var_5_0 = self:getConfig("use_gold")

	return i18n("commander_build_pool_tip", Item.New({
		id = self:getConfig("use_item")
	}):getConfig("name"), (self:getConfig("number_1")))
end

function CommanderBuildPool:getPrint()
	return Commander.rarity2Print(self.id + 2)
end

function CommanderBuildPool:getItemCount()
	return getProxy(BagProxy):getItemCountById((self:getConfig("use_item")))
end

function CommanderBuildPool:getRarity()
	return self.id
end

return CommanderBuildPool
