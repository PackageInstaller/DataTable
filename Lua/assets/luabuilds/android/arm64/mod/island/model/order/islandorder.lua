local var_0_0 = class("IslandOrder", import("model.vo.BaseVO"))

var_0_0.TYPE_NORMAL = 1
var_0_0.TYPE_URGENCY = 2
var_0_0.TYPE_FORM = 4

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0:Flush(arg_1_1)

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.dialog_id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.tendency = arg_2_1.cur_select
	arg_2_0.startTime = arg_2_1.start_time
	arg_2_0.submitTime = arg_2_1.submit_time
	arg_2_0.reduceTime = 0
	arg_2_0.showFlag = arg_2_1.view_flag
	arg_2_0.consumeList = {}

	local var_2_0 = arg_2_1.cost or {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insert(arg_2_0.consumeList, {
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_2_1.id,
			count = iter_2_1.num
		})
	end

	arg_2_0.orderLevel = arg_2_1.order_lv or 1

	return
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.island_order_publish_random
end

function var_0_0.GetExpValue(arg_4_0)
	return pg.island_set.order_favor.key_value_int
end

function var_0_0.GetTendency(arg_5_0)
	return arg_5_0.tendency
end

function var_0_0.CanFinish(arg_6_0)
	return _.all(arg_6_0:GetConsume(), function(arg_7_0)
		local var_7_0 = Drop.New({
			type = arg_7_0.type,
			id = arg_7_0.id
		})

		return var_7_0:getOwnedCount() >= arg_7_0.count
	end)
end

function var_0_0.GetDesc(arg_8_0)
	return arg_8_0:getConfig("desc")
end

function var_0_0.GetConsume(arg_9_0)
	return arg_9_0.consumeList
end

function var_0_0.GetDisplayAwards(arg_10_0)
	local var_10_0, var_10_1 = arg_10_0:GetAwardItemAndExp()

	if var_10_1 > 0 then
		table.insert(var_10_0, {
			id = 2,
			type = DROP_TYPE_ISLAND_ITEM,
			count = var_10_1
		})
	end

	return var_10_0
end

function var_0_0.GetAwardConfigByTendency(arg_11_0, arg_11_1)
	assert(pg.island_order_price[arg_11_1], "order config not found, level: " .. arg_11_1)

	local var_11_0 = arg_11_0:GetTendency()

	if arg_11_0:IsUrgency() then
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

function var_0_0.GenAwards(arg_12_0, arg_12_1)
	table.insert({}, {
		id = 1,
		type = DROP_TYPE_ISLAND_ITEM,
		count = arg_12_1[2]
	})

	return {}, arg_12_1[1]
end

function var_0_0.GetAwardItemAndExp(arg_13_0)
	return arg_13_0:GenAwards((arg_13_0:GetAwardConfigByTendency(arg_13_0.orderLevel)))
end

function var_0_0.GetRoleIcon(arg_14_0)
	return pg.island_unit_character[arg_14_0:getConfig("npc_id")].IslandShipIcon
end

function var_0_0.GetRoleName(arg_15_0)
	return pg.island_unit_character[arg_15_0:getConfig("npc_id")].name
end

function var_0_0.IsUrgency(arg_16_0)
	return false
end

function var_0_0.IsActivity(arg_17_0)
	return false
end

function var_0_0.IsFirm(arg_18_0)
	return false
end

function var_0_0.GetTitle(arg_19_0)
	return i18n("island_order_type_1")
end

function var_0_0.IsEmpty(arg_20_0)
	return arg_20_0.showFlag == IslandOrderSlot.SHOW_FLAG_TOMORROW and arg_20_0:IsLoading()
end

function var_0_0.IsLoading(arg_21_0)
	local var_21_0 = pg.TimeMgr.GetInstance()

	return var_21_0:GetServerTime() < arg_21_0:GetCanSubmitTime()
end

function var_0_0.CanReplace(arg_22_0)
	return not arg_22_0:IsEmpty() and not arg_22_0:IsLoading()
end

function var_0_0.GetTotalTime(arg_23_0)
	return arg_23_0.submitTime - arg_23_0.startTime
end

function var_0_0.GetDisappearTime(arg_24_0)
	return -1
end

function var_0_0.GetCanSubmitTime(arg_25_0)
	return arg_25_0.submitTime - arg_25_0.reduceTime
end

function var_0_0.SetReduceTime(arg_26_0, arg_26_1)
	arg_26_0.reduceTime = arg_26_1

	return
end

function var_0_0.AddReduceTime(arg_27_0, arg_27_1)
	arg_27_0.reduceTime = arg_27_0.reduceTime + arg_27_1

	return
end

return var_0_0
