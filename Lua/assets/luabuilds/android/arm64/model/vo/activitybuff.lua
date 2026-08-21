local var_0_0 = class("ActivityBuff", import(".CommonBuff"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, {
		id = arg_1_2,
		timestamp = arg_1_3
	})

	arg_1_0.activityId = arg_1_1

	return
end

function var_0_0.IsActiveType(arg_2_0)
	return true
end

local function var_0_1(arg_3_0, arg_3_1, arg_3_2)
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

function var_0_0.isActivate(arg_4_0)
	local var_4_0 = getProxy(ActivityProxy)

	if not var_4_0:IsActivityNotEnd(arg_4_0.activityId) then
		return false
	end

	local var_4_1 = var_4_0:getActivityById(arg_4_0.activityId)

	if var_4_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_PT_BUFF then
		if not ActivityPtData.New(var_4_1):isInBuffTime() then
			return false
		end
	end

	local var_4_2 = var_0_0.GetBenefitCondition(arg_4_0:getConfig("benefit_condition"))

	if not var_4_2 then
		return true
	end

	return switch(var_4_2[1], {
		pt = function()
			local var_5_0, var_5_1, var_5_2, var_5_3 = unpack(var_4_2)
			local var_5_4 = getProxy(PlayerProxy):getData()[pg.player_resource[var_5_1].name]

			var_5_4 = var_5_4 or 0

			return var_5_2 <= var_5_4 and var_5_4 < var_5_3
		end,
		lv = function()
			return var_0_1(getProxy(PlayerProxy):getRawData().level, var_4_2[2], var_4_2[3])
		end,
		activity = function()
			if not var_4_0:IsActivityNotEnd(var_4_2[2]) then
				return false
			end

			if var_4_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF or var_4_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2 then
				if var_4_2[3] ~= 0 then
					return true
				end

				local var_7_0 = var_4_1.data1KeyValueList[2][var_4_2[3][1]] or 1

				return var_7_0 == var_4_2[3][2]
			end

			return true
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

function var_0_0.checkChaper(arg_11_0, arg_11_1)
	local var_11_0 = var_0_0.GetBenefitCondition(arg_11_0:getConfig("benefit_condition"))

	if not var_11_0 or var_11_0[1] ~= "chapter" then
		return true
	else
		return table.contains(var_11_0[2], arg_11_1)
	end

	return
end

function var_0_0.checkDungeon(arg_12_0, arg_12_1)
	local var_12_0 = var_0_0.GetBenefitCondition(arg_12_0:getConfig("benefit_condition"))

	if not var_12_0 or var_12_0[1] ~= "dungeon" then
		return true
	else
		return table.contains(var_12_0[2], arg_12_1)
	end

	return
end

function var_0_0.getLeftTime(arg_13_0)
	return getProxy(ActivityProxy):getActivityById(arg_13_0.activityId).stopTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function var_0_0.GetBenefitCondition(arg_14_0)
	local var_14_0 = noEmptyStr(arg_14_0)

	if not var_14_0 then
		return nil
	elseif type(var_14_0) == "string" then
		return {
			"item",
			tonumber(var_14_0)
		}
	elseif type(var_14_0) == "table" then
		return var_14_0
	else
		assert(false)
	end

	return
end

return var_0_0
