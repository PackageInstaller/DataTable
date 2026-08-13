class = var_0_10000

local var_0_0 = "IslandOrder"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.TYPE_NORMAL = 1
var_0_1.TYPE_URGENCY = 2
var_0_1.TYPE_FORM = 4

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0:Flush(arg_1_1)

	return
end

function var_0_1.Flush(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.dialog_id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.tendency = arg_2_1.cur_select
	arg_2_0.startTime = arg_2_1.start_time
	arg_2_0.submitTime = arg_2_1.submit_time
	arg_2_0.reduceTime = 0
	arg_2_0.showFlag = arg_2_1.view_flag
	arg_2_0.consumeList = {}
	ipairs = var_2

	local var_2_0

	if not arg_2_1.cost then
		var_2_0 = {}
	end

	for iter_2_0, iter_2_1 in var_2(var_2_0) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_2_1 = arg_2_0.consumeList
		local var_2_2 = {}

		DROP_TYPE_ISLAND_ITEM = var_1_10011
		var_2_2.type = var_1_10011
		var_2_2.id = iter_2_1.id
		var_2_2.count = iter_2_1.num

		var_1_10007(var_2_1, var_2_2)
	end

	local var_2_3

	if not arg_2_1.order_lv then
		var_2_3 = 1
	end

	arg_2_0.orderLevel = var_2_3

	return
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.island_order_publish_random
end

function var_0_1.GetExpValue(arg_4_0)
	pg = var_1_10001

	return var_1_10001.island_set.order_favor.key_value_int
end

function var_0_1.GetTendency(arg_5_0)
	return arg_5_0.tendency
end

function var_0_1.CanFinish(arg_6_0)
	local var_6_0 = arg_6_0:GetConsume()

	_ = var_1_10002

	return var_1_10002.all(var_6_0, function(arg_7_0)
		Drop = var_2_10001

		local var_7_0 = var_2_10001.New({
			type = arg_7_0.type,
			id = arg_7_0.id
		})

		return var_1.getOwnedCount(var_7_0) >= arg_7_0.count
	end)
end

function var_0_1.GetDesc(arg_8_0)
	return arg_8_0:getConfig("desc")
end

function var_0_1.GetConsume(arg_9_0)
	return arg_9_0.consumeList
end

function var_0_1.GetDisplayAwards(arg_10_0)
	local var_10_0, var_10_1 = arg_10_0:GetAwardItemAndExp()

	if 0 < var_10_1 then
		table = var_3

		local var_10_2 = var_3.insert
		local var_10_3 = var_10_0
		local var_10_4 = {
			id = 2
		}

		DROP_TYPE_ISLAND_ITEM = var_1_10007
		var_10_4.type = var_1_10007
		var_10_4.count = var_10_1

		var_10_2(var_10_3, var_10_4)
	end

	return var_10_0
end

function var_0_1.GetAwardConfigByTendency(arg_11_0, arg_11_1)
	pg = var_1_10002

	local var_11_0 = var_1_10002.island_order_price[arg_11_1]

	assert = var_1_10003

	var_1_10003(var_11_0, "order config not found, level: " .. arg_11_1)

	local var_11_1 = arg_11_0:GetTendency()

	if arg_11_0:IsUrgency() then
		return var_11_0.order_award_special
	end

	IslandOrderSlot = var_4

	if var_4.TENDENCY_TYPE_COMMON == var_11_1 then
		return var_11_0.order_award
	else
		IslandOrderSlot = var_4

		if var_4.TENDENCY_TYPE_EASY == var_11_1 then
			return var_11_0.order_easy_award
		else
			IslandOrderSlot = var_4

			if var_4.TENDENCY_TYPE_HARD == var_11_1 then
				return var_11_0.order_award_challenge
			end
		end
	end

	assert = var_4

	local var_11_2 = false
	local var_11_3 = "unknown order tendency: "
	local var_11_4 = arg_11_1

	tostring = var_1_10009

	var_4(var_11_2, var_11_3 .. var_11_4 .. var_1_10009(var_11_1))

	return
end

function var_0_1.GenAwards(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1[1]
	local var_12_1 = {}

	table = var_1_10004

	local var_12_2 = var_1_10004.insert
	local var_12_3 = var_12_1
	local var_12_4 = {
		id = 1
	}

	DROP_TYPE_ISLAND_ITEM = var_1_10008
	var_12_4.type = var_1_10008
	var_12_4.count = arg_12_1[2]

	var_12_2(var_12_3, var_12_4)

	return var_12_1, var_12_0
end

function var_0_1.GetAwardItemAndExp(arg_13_0)
	local var_13_0 = arg_13_0:GetAwardConfigByTendency(arg_13_0.orderLevel)

	return arg_13_0:GenAwards(var_13_0)
end

function var_0_1.GetRoleIcon(arg_14_0)
	local var_14_0 = arg_14_0:getConfig("npc_id")

	pg = var_1_10002

	return var_1_10002.island_unit_character[var_14_0].IslandShipIcon
end

function var_0_1.GetRoleName(arg_15_0)
	local var_15_0 = arg_15_0:getConfig("npc_id")

	pg = var_1_10002

	return var_1_10002.island_unit_character[var_15_0].name
end

function var_0_1.IsUrgency(arg_16_0)
	return false
end

function var_0_1.IsActivity(arg_17_0)
	return false
end

function var_0_1.IsFirm(arg_18_0)
	return false
end

function var_0_1.GetTitle(arg_19_0)
	i18n = var_1_10001

	return var_1_10001("island_order_type_1")
end

function var_0_1.IsEmpty(arg_20_0)
	local var_20_0 = arg_20_0.showFlag

	IslandOrderSlot = var_1_10002

	return var_20_0 == var_1_10002.SHOW_FLAG_TOMORROW and arg_20_0:IsLoading()
end

function var_0_1.IsLoading(arg_21_0)
	pg = var_1_10001

	local var_21_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_21_0) < arg_21_0:GetCanSubmitTime()
end

function var_0_1.CanReplace(arg_22_0)
	return not arg_22_0:IsEmpty() and not arg_22_0:IsLoading()
end

function var_0_1.GetTotalTime(arg_23_0)
	return arg_23_0.submitTime - arg_23_0.startTime
end

function var_0_1.GetDisappearTime(arg_24_0)
	return -1
end

function var_0_1.GetCanSubmitTime(arg_25_0)
	return arg_25_0.submitTime - arg_25_0.reduceTime
end

function var_0_1.SetReduceTime(arg_26_0, arg_26_1)
	arg_26_0.reduceTime = arg_26_1

	return
end

function var_0_1.AddReduceTime(arg_27_0, arg_27_1)
	arg_27_0.reduceTime = arg_27_0.reduceTime + arg_27_1

	return
end

return var_0_1
