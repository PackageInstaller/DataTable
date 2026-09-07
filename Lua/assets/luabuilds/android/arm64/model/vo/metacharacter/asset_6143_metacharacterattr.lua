local MetaCharacterAttr = class("MetaCharacterAttr", import("..BaseVO"))

function MetaCharacterAttr:Ctor(arg_1_1)
	self.attr = arg_1_1.attr
	self.items = _.map(arg_1_1.items or {}, function(arg_2_0)
		return MetaRepairItem.New({
			id = arg_2_0
		})
	end)
	self.level = arg_1_1.level or 1

	return
end

function MetaCharacterAttr:getLevelByItemId(arg_3_1)
	local var_3_0 = 1

	for iter_3_0, iter_3_1 in pairs(self.items) do
		if iter_3_1.id == arg_3_1 then
			var_3_0 = iter_3_0 + 1

			break
		end
	end

	return var_3_0
end

function MetaCharacterAttr:updateCount(arg_4_1)
	if arg_4_1 > self.level then
		self.level = arg_4_1
	end

	return
end

function MetaCharacterAttr:hasItemId(arg_5_1)
	return _.any(self.items, function(arg_6_0)
		return arg_6_0.id == arg_5_1
	end)
end

function MetaCharacterAttr:getLevel()
	return self.level
end

function MetaCharacterAttr:isMaxLevel()
	return self.level > #self.items
end

function MetaCharacterAttr:getAddition()
	local var_9_0 = 0

	for iter_9_0 = 1, self.level - 1 do
		var_9_0 = var_9_0 + self.items[iter_9_0]:getAdditionValue()
	end

	return var_9_0
end

function MetaCharacterAttr:getMaxAddition()
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(self.items) do
		var_10_0 = var_10_0 + iter_10_1:getAdditionValue()
	end

	return var_10_0
end

function MetaCharacterAttr:getRepairExp()
	local var_11_0 = 0

	for iter_11_0 = 1, self.level - 1 do
		var_11_0 = var_11_0 + self.items[iter_11_0]:getRepairExp()
	end

	return var_11_0
end

function MetaCharacterAttr:getItem()
	assert(self.items[self.level], "level : " .. self.level)

	return self.items[self.level]
end

function MetaCharacterAttr:getItemByLevel(arg_13_1)
	return self.items[arg_13_1]
end

function MetaCharacterAttr:levelUp()
	if not self:isMaxLevel() then
		self.level = self.level + 1
	end

	return
end

function MetaCharacterAttr:isCanRepair()
	if self:isMaxLevel() then
		return false
	end

	local var_15_0 = self:getItem()

	if var_15_0:getTotalCnt() <= getProxy(BagProxy):getItemCountById((var_15_0:getItemId())) then
		return true
	else
		return false
	end

	return
end

function MetaCharacterAttr:getItemCount()
	return #self.items
end

function MetaCharacterAttr:isLock()
	return self:getItemCount() == 0
end

return MetaCharacterAttr
