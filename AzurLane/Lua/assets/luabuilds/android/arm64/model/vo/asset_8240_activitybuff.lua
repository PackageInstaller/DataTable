class = var_0_10000

local var_0_0 = "ActivityBuff"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CommonBuff"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, {
		id = arg_1_2,
		timestamp = arg_1_3
	})

	arg_1_0.activityId = arg_1_1

	return
end

function var_0_1.IsActiveType(arg_2_0)
	return true
end

local function var_0_2(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "<=" then
		return arg_3_0 <= arg_3_2
	elseif arg_3_1 == "<" then
		return arg_3_0 < arg_3_2
	elseif arg_3_1 == "==" then
		return arg_3_0 == arg_3_2
	elseif arg_3_1 == ">=" then
		return arg_3_2 <= arg_3_0
	elseif arg_3_1 == ">" then
		return arg_3_2 < arg_3_0
	end

	return false
end

function var_0_1.isActivate(arg_4_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)

	if not var_1.IsActivityNotEnd(var_4_0, arg_4_0.activityId) then
		return false
	end

	local var_4_1 = var_1
	local var_4_2 = var_1.getActivityById(var_4_1, arg_4_0.activityId)
	local var_4_3 = var_2.getConfig(var_4_2, "type")

	ActivityConst = var_4_1

	if var_4_3 == var_4_1.ACTIVITY_TYPE_PT_BUFF then
		ActivityPtData = var_4_3

		local var_4_4 = var_4_3.New(var_2)

		if not var_3.isInBuffTime(var_4_4) then
			return false
		end
	end

	if not var_0_1.GetBenefitCondition(arg_4_0:getConfig("benefit_condition")) then
		return true
	end

	switch = var_4

	return var_4(var_3[1], {
		pt = function()
			unpack = var_2_10000

			local var_5_0, var_5_1, var_5_2, var_5_3 = var_2_10000(var_0)

			pg = var_2_10004

			local var_5_4 = var_2_10004.player_resource[var_5_1].name

			getProxy = var_2_10005
			PlayerProxy = var_2_10007

			local var_5_5 = var_2_10005(var_2_10007)
			local var_5_6

			if not var_5.getData(var_5_5)[var_5_4] then
				var_5_6 = 0
			end

			return var_5_2 <= var_5_6 and var_5_6 < var_5_3
		end,
		lv = function()
			getProxy = var_2_10000
			PlayerProxy = var_2_10002

			local var_6_0 = var_2_10000(var_2_10002)
			local var_6_1 = var_0.getRawData(var_6_0)

			return var_0_2(var_6_1.level, var_0[2], var_0[3])
		end,
		activity = function()
			local var_7_0 = var_0

			if not var_0.IsActivityNotEnd(var_7_0, var_0[2]) then
				return false
			end

			local var_7_1 = var_0
			local var_7_2 = var_0.getConfig(var_7_1, "type")

			ActivityConst = var_2_10001

			if var_7_2 ~= var_2_10001.ACTIVITY_TYPE_BUILDING_BUFF then
				local var_7_3 = var_0
				local var_7_4 = var_0.getConfig(var_7_3, "type")

				ActivityConst = var_1

				if var_7_4 == var_1.ACTIVITY_TYPE_BUILDING_BUFF_2 then
					if var_0[3] ~= 0 then
						return true
					end

					local var_7_5 = var_0[3][1]
					local var_7_6

					if not var_0.data1KeyValueList[2][var_7_5] then
						var_7_6 = 1
					end

					return var_7_6 == var_0[3][2]
				end

				return true
			end
		end,
		chapter = function(arg_8_0)
			return true
		end,
		dungeon = function(arg_9_0)
			return true
		end
	}, function()
		return false
	end)
end

function var_0_1.checkChaper(arg_11_0, arg_11_1)
	if not var_0_1.GetBenefitCondition(arg_11_0:getConfig("benefit_condition")) or var_2[1] ~= "chapter" then
		return true
	else
		table = var_1_10003

		return var_1_10003.contains(var_2[2], arg_11_1)
	end

	return
end

function var_0_1.checkDungeon(arg_12_0, arg_12_1)
	if not var_0_1.GetBenefitCondition(arg_12_0:getConfig("benefit_condition")) or var_2[1] ~= "dungeon" then
		return true
	else
		table = var_1_10003

		return var_1_10003.contains(var_2[2], arg_12_1)
	end

	return
end

function var_0_1.getLeftTime(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.TimeMgr.GetInstance()
	local var_13_1 = var_1.GetServerTime(var_13_0)

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_13_2 = var_1_10002(var_1_10004)

	return var_2.getActivityById(var_13_2, arg_13_0.activityId).stopTime - var_13_1
end

function var_0_1.GetBenefitCondition(arg_14_0)
	noEmptyStr = var_1_10001

	if not var_1_10001(arg_14_0) then
		return nil
	else
		type = var_1_10002

		local var_14_0

		if var_1_10002(var_1) == "string" then
			var_14_0 = {
				"item"
			}
			tonumber = var_3
			var_14_0[2] = var_3(var_1)

			return var_14_0
		else
			type = var_14_0

			if var_14_0(var_1) == "table" then
				return var_1
			else
				assert = var_2

				var_2(false)
			end
		end
	end

	return
end

return var_0_1
