local MetaCharacterBreakout = class("MetaCharacterBreakout", import("..BaseVO"))

function MetaCharacterBreakout:bindConfigTable()
	return pg.ship_meta_breakout
end

function MetaCharacterBreakout:Ctor(arg_2_1)
	self.id = arg_2_1.id
	self.configId = self.id
	self.needLevel = self:getConfig("level")
	self.needRepairRate = self:getConfig("repair")
	self.needItems = {}

	table.insert(self.needItems, {
		itemId = self:getConfig("item1"),
		count = self:getConfig("item1_num")
	})

	self.needGold = self:getConfig("gold")
	self.weaponIds = self:getConfig("weapon_ids")
	self.breakoutView = self:getConfig("breakout_view")

	local var_2_0 = self:getConfig("breakout_id")

	if var_2_0 ~= 0 then
		self.nextBreakInfo = MetaCharacterBreakout.New({
			id = var_2_0
		})
	end

	return
end

function MetaCharacterBreakout:getConsume()
	return self.needGold, self.needItems
end

function MetaCharacterBreakout:getLimited()
	return self.needLevel, self.needRepairRate
end

function MetaCharacterBreakout:hasNextInfo()
	return self.nextBreakInfo ~= nil
end

function MetaCharacterBreakout:getNextInfo()
	return self.nextBreakInfo
end

function MetaCharacterBreakout:getWeaponIds()
	return self.weaponIds
end

return MetaCharacterBreakout
