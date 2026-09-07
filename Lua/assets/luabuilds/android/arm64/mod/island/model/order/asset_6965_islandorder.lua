local IslandOrder = class("IslandOrder", import("model.vo.BaseVO"))

IslandOrder.TYPE_NORMAL = 1
IslandOrder.TYPE_URGENCY = 2
IslandOrder.TYPE_FORM = 4

function IslandOrder:Ctor(arg_1_1)
	self:Flush(arg_1_1)

	return
end

function IslandOrder:Flush(arg_2_1)
	self.id = arg_2_1.dialog_id
	self.configId = self.id
	self.tendency = arg_2_1.cur_select
	self.startTime = arg_2_1.start_time
	self.submitTime = arg_2_1.submit_time
	self.reduceTime = 0
	self.showFlag = arg_2_1.view_flag
	self.consumeList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.cost or {}) do
		table.insert(self.consumeList, {
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_2_1.id,
			count = iter_2_1.num
		})
	end

	self.orderLevel = arg_2_1.order_lv or 1

	return
end

function IslandOrder:bindConfigTable()
	return pg.island_order_publish_random
end

function IslandOrder:GetExpValue()
	return pg.island_set.order_favor.key_value_int
end

function IslandOrder:GetTendency()
	return self.tendency
end

function IslandOrder:CanFinish()
	return _.all(self:GetConsume(), function(arg_7_0)
		return Drop.New({
			type = arg_7_0.type,
			id = arg_7_0.id
		}):getOwnedCount() >= arg_7_0.count
	end)
end

function IslandOrder:GetDesc()
	return self:getConfig("desc")
end

function IslandOrder:GetConsume()
	return self.consumeList
end

function IslandOrder:GetDisplayAwards()
	local var_10_0, var_10_1 = self:GetAwardItemAndExp()

	if var_10_1 > 0 then
		table.insert(var_10_0, {
			id = 2,
			type = DROP_TYPE_ISLAND_ITEM,
			count = var_10_1
		})
	end

	return var_10_0
end

function IslandOrder:GetAwardConfigByTendency(arg_11_1)
	assert(pg.island_order_price[arg_11_1], "order config not found, level: " .. arg_11_1)

	local var_11_0 = self:GetTendency()

	if self:IsUrgency() then
		return pg.island_order_price[arg_11_1].order_award_special
	end

	if IslandOrderSlot.TENDENCY_TYPE_COMMON == var_11_0 then
		return pg.island_order_price[arg_11_1].order_award
	elseif IslandOrderSlot.TENDENCY_TYPE_EASY == var_11_0 then
		return pg.island_order_price[arg_11_1].order_easy_award
	elseif IslandOrderSlot.TENDENCY_TYPE_HARD == var_11_0 then
		return pg.island_order_price[arg_11_1].order_award_challenge
	end

	assert(false, "unknown order tendency: " .. arg_11_1 .. tostring(var_11_0))

	return
end

function IslandOrder:GenAwards(arg_12_1)
	local var_12_0 = {}

	table.insert(var_12_0, {
		id = 1,
		type = DROP_TYPE_ISLAND_ITEM,
		count = arg_12_1[2]
	})

	return var_12_0, arg_12_1[1]
end

function IslandOrder:GetAwardItemAndExp()
	return self:GenAwards((self:GetAwardConfigByTendency(self.orderLevel)))
end

function IslandOrder:GetRoleIcon()
	return pg.island_unit_character[self:getConfig("npc_id")].IslandShipIcon
end

function IslandOrder:GetRoleName()
	return pg.island_unit_character[self:getConfig("npc_id")].name
end

function IslandOrder:IsUrgency()
	return false
end

function IslandOrder:IsActivity()
	return false
end

function IslandOrder:IsFirm()
	return false
end

function IslandOrder:GetTitle()
	return i18n("island_order_type_1")
end

function IslandOrder:IsEmpty()
	return self.showFlag == IslandOrderSlot.SHOW_FLAG_TOMORROW and self:IsLoading()
end

function IslandOrder:IsLoading()
	return pg.TimeMgr.GetInstance():GetServerTime() < self:GetCanSubmitTime()
end

function IslandOrder:CanReplace()
	return not self:IsEmpty() and not self:IsLoading()
end

function IslandOrder:GetTotalTime()
	return self.submitTime - self.startTime
end

function IslandOrder:GetDisappearTime()
	return -1
end

function IslandOrder:GetCanSubmitTime()
	return self.submitTime - self.reduceTime
end

function IslandOrder:SetReduceTime(arg_26_1)
	self.reduceTime = arg_26_1

	return
end

function IslandOrder:AddReduceTime(arg_27_1)
	self.reduceTime = self.reduceTime + arg_27_1

	return
end

return IslandOrder
