class = var_0_10000

local var_0_0 = "EventInfo"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

var_0_1.StateExpire = -1
var_0_1.StateNone = 0
var_0_1.StateActive = 1
var_0_1.StateFinish = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	pg = var_2
	arg_1_0.template = var_2.collection_template[arg_1_0.id]
	assert = var_2

	var_2(arg_1_0.template, "pg.collection_template>>>" .. arg_1_0.id)

	local var_1_0

	if not arg_1_1.finish_time then
		var_1_0 = 0
	end

	arg_1_0.finishTime = var_1_0

	local var_1_1

	if not arg_1_1.over_time then
		var_1_1 = 0
	end

	arg_1_0.overTime = var_1_1
	underscore = var_1_1

	local var_1_2

	if not var_1_1.to_array(arg_1_1.ship_id_list) then
		var_1_2 = {}
	end

	arg_1_0.shipIds = var_1_2

	local var_1_3

	if not arg_1_1.activity_id then
		var_1_3 = 0
	end

	arg_1_0.activityId = var_1_3

	if arg_1_0:IsActivityType() and arg_1_0.overTime == 0 then
		GetZeroTime = var_2
		arg_1_0.overTime = var_2()
	end

	return
end

function var_0_1.IsActivityType(arg_2_0)
	return arg_2_0.activityId > 0
end

function var_0_1.GetState(arg_3_0)
	if arg_3_0.finishTime == 0 then
		if arg_3_0.overTime ~= 0 then
			pg = var_1
			var_1_10002 = var_1.TimeMgr.GetInstance()

			if var_1.GetServerTime(var_1_10002) < arg_3_0.overTime then
				return var_0_1.StateNone
			else
				return var_0_1.StateExpire
			end

			if false then
				local var_3_0 = arg_3_0.finishTime

				pg = var_1_10002

				local var_3_1 = var_1_10002.TimeMgr.GetInstance()

				if var_3_0 < var_2.GetServerTime(var_3_1) then
					return var_0_1.StateFinish
				else
					return var_0_1.StateActive
				end
			end

			return
		end
	end
end

function var_0_1.IsStarting(arg_4_0)
	return arg_4_0:GetState() ~= var_0_1.StateNone
end

function var_0_1.SetActivityId(arg_5_0, arg_5_1)
	arg_5_0.activityId = arg_5_1

	return
end

function var_0_1.BelongActivity(arg_6_0, arg_6_1)
	return arg_6_0.activityId > 0 and arg_6_0.activityId == arg_6_1
end

function var_0_1.setShipIds(arg_7_0, arg_7_1)
	arg_7_0.valid = false
	underscore = var_2
	arg_7_0.shipIds = var_2.to_array(arg_7_1)

	return
end

function var_0_1.getShipList(arg_8_0)
	local var_8_0 = arg_8_0

	arg_8_0.checkValid(var_8_0)

	getProxy = var_1
	BayProxy = var_8_0

	local var_8_1 = var_1(var_8_0)

	return var_1.getShipList(var_8_1, arg_8_0.shipIds)
end

function var_0_1.checkValid(arg_9_0)
	if arg_9_0.valid then
		return
	end

	arg_9_0.valid = true
	getProxy = var_1
	BayProxy = var_1_10002

	local var_9_0 = var_1(var_1_10002)

	underscore = var_1_10002
	arg_9_0.shipIds = var_1_10002.filter(arg_9_0.shipIds, function(arg_10_0)
		tobool = var_2_10001

		local var_10_0 = var_9_0

		return var_2_10001(var_2.RawGetShipById(var_10_0, arg_10_0))
	end)

	return
end

function var_0_1.reachNum(arg_11_0)
	arg_11_0:checkValid()

	return arg_11_0.template.ship_num <= #arg_11_0.shipIds
end

function var_0_1.reachLevel(arg_12_0)
	local var_12_0

	if #arg_12_0:getShipList() > 0 then
		underscore = var_2
		var_12_0 = var_2.any(var_1, function(arg_13_0)
			return arg_13_0.level >= arg_12_0.template.ship_lv
		end)
	else
		var_12_0 = false
	end

	if false then
		var_12_0 = true
	end

	return var_12_0
end

function var_0_1.reachTypes(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.getShipList(var_14_0)

	table = var_14_0

	if var_14_0.getCount(var_14_1) == 0 then
		return false
	end

	local var_14_2 = true

	ipairs = var_3

	for iter_14_0, iter_14_1 in var_3(var_14_1) do
		local var_14_3 = iter_14_1
		local var_14_4 = iter_14_1.getShipType(var_14_3)

		table = var_14_3

		if not var_14_3.contains(arg_14_0.template.ship_type, var_14_4) then
			var_14_2 = false

			break
		end
	end

	return var_14_2
end

function var_0_1.getOilConsume(arg_15_0)
	local var_15_0

	if not arg_15_0.template.oil then
		var_15_0 = 0
	end

	return var_15_0
end

function var_0_1.getTypesStr(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.ship_data_by_type
	local var_16_1 = arg_16_0.template.ship_type
	local var_16_2 = false

	if #var_16_1 == #var_16_0.all then
		var_16_2 = true
		pairs = var_4

		for iter_16_0, iter_16_1 in var_4(var_16_0.all) do
			table = var_1_10009

			if not var_1_10009.contains(var_16_1, iter_16_1) then
				var_16_2 = false

				break
			end
		end
	end

	if var_16_2 then
		i18n = var_4

		return var_4("event_type_unlimit")
	else
		local var_16_3 = ""

		ipairs = var_5
		ShipType = var_1_10006

		for iter_16_2, iter_16_3 in var_5(var_1_10006.FilterOverQuZhuType(var_16_1)) do
			local var_16_4 = iter_16_2 == #arg_16_0.template.ship_type and "" or "、"

			var_16_3 = var_16_3 .. var_16_0[iter_16_3].type_name .. var_16_4
		end

		i18n = var_5

		return var_5("event_condition_ship_type", var_16_3)
	end

	return
end

local var_0_2 = "EVENTINFO_FORMATION_KEY_"

function var_0_1.ExistPrevFormation(arg_17_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_17_0 = var_1_10001(var_1_10002)
	local var_17_1 = var_1.getRawData(var_17_0).id

	PlayerPrefs = var_17_0

	return var_17_0.HasKey(var_0_2 .. var_17_1)
end

function var_0_1.GetPrevFormation(arg_18_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_18_0 = var_1_10001(var_1_10002)
	local var_18_1 = var_1.getRawData(var_18_0).id

	PlayerPrefs = var_18_0

	local var_18_2 = var_18_0.GetString(var_0_2 .. var_18_1)

	string = var_3

	local var_18_3 = var_3.split(var_18_2, "#")

	_ = var_4

	return var_4.map(var_18_3, function(arg_19_0)
		tonumber = var_2_10001

		return var_2_10001(arg_19_0)
	end)
end

function var_0_1.SavePrevFormation(arg_20_0)
	arg_20_0:checkValid()

	if not arg_20_0:CanRecordPrevFormation() then
		return
	end

	table = var_1

	local var_20_0 = var_1.concat(arg_20_0.shipIds, "#")

	getProxy = var_2
	PlayerProxy = var_3

	local var_20_1 = var_2(var_3)
	local var_20_2 = var_2.getRawData(var_20_1).id

	PlayerPrefs = var_20_1

	var_20_1.SetString(var_0_2 .. var_20_2, var_20_0)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

function var_0_1.CanRecordPrevFormation(arg_21_0)
	return arg_21_0.template.oil >= 800
end

function var_0_1.GetCountDownTime(arg_22_0)
	local var_22_3

	if not arg_22_0:IsActivityType() and arg_22_0:GetState() == var_0_1.StateNone then
		local var_22_0 = arg_22_0.overTime

		if 0 < var_22_0 then
			local var_22_1 = arg_22_0.overTime

			pg = var_2

			local var_22_2 = var_2.TimeMgr.GetInstance()

			var_22_3 = var_22_1 - var_2.GetServerTime(var_22_2)

			goto label_22_0
		end
	end

	var_22_3 = false

	if false then
		var_22_3 = true
	end

	::label_22_0::

	return var_22_3
end

return var_0_1
