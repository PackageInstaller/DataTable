local var_0_0 = class("ActivityMedalGroup", import("model.vo.BaseVO"))

var_0_0.STATE_EXPIRE = -1
var_0_0.STATE_CLOSE = 0
var_0_0.STATE_ACTIVE = 1

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_medal_group
end

function var_0_0.GetConfigID(arg_2_0)
	return arg_2_0.configId
end

function var_0_0.Ctor(arg_3_0, arg_3_1)
	arg_3_0.configId = arg_3_1
	arg_3_0.medalList = {}

	for iter_3_0, iter_3_1 in ipairs((arg_3_0:GetMedalIds())) do
		arg_3_0.medalList[iter_3_1] = {
			id = iter_3_1
		}
	end

	return
end

function var_0_0.GetMedalIds(arg_4_0)
	return pg.activity_medal_template.get_id_list_by_group[arg_4_0.configId]
end

function var_0_0.IsMedalGroupCollectionGrey(arg_5_0)
	player = getProxy(PlayerProxy):getData()

	return not player:getActivityMedalGroup()[arg_5_0]
end

function var_0_0.GetMedalGroupStateByID(arg_6_0)
	if pg.activity_medal_group[arg_6_0].is_out_of_print == 1 then
		return var_0_0.STATE_EXPIRE
	elseif pg.activity_medal_group[arg_6_0].is_out_of_print == 0 then
		local var_6_0 = false

		for iter_6_0, iter_6_1 in ipairs(pg.activity_medal_group[arg_6_0].activity_link) do
			local var_6_1 = getProxy(ActivityProxy):getActivityById(iter_6_1[2])

			if var_6_1 and not var_6_1:isEnd() then
				var_6_0 = true

				break
			end
		end

		if var_6_0 then
			return var_0_0.STATE_ACTIVE
		else
			return var_0_0.STATE_CLOSE
		end
	end

	return
end

function var_0_0.GetMedalGroupState(arg_7_0)
	local var_7_0 = arg_7_0:getConfig("is_out_of_print")

	if var_7_0 == 1 then
		return var_0_0.STATE_EXPIRE
	elseif var_7_0 == 0 then
		if arg_7_0:GetMedalGroupActivityConfig() then
			return var_0_0.STATE_ACTIVE
		else
			return var_0_0.STATE_CLOSE
		end
	end

	return
end

function var_0_0.GetMedalGroupActivityConfig(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0:getConfig("activity_link")) do
		local var_8_0 = getProxy(ActivityProxy):getActivityById(iter_8_1[2])

		if var_8_0 and not var_8_0:isEnd() then
			return iter_8_1
		end
	end

	return
end

function var_0_0.GetMedalList(arg_9_0)
	return arg_9_0.medalList
end

function var_0_0.UpdateMedal(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.medalList[arg_10_1].timeStamp = arg_10_2

	return
end

function var_0_0.GetAll(arg_11_0)
	return underscore.all(arg_11_0:GetMedalIds(), function(arg_12_0)
		return arg_11_0:OwnMedel(arg_12_0)
	end)
end

function var_0_0.OwnMedel(arg_13_0, arg_13_1)
	return arg_13_0.medalList[arg_13_1] and arg_13_0.medalList[arg_13_1].timeStamp and arg_13_0.medalList[arg_13_1].timeStamp ~= 0
end

function var_0_0.GetGroupIDByMedalID(arg_14_0)
	return pg.activity_medal_group[arg_14_0].group
end

function var_0_0.showTip(arg_15_0)
	if pg.activity_medal_group[arg_15_0] then
		local var_15_0 = pg.activity_medal_group[arg_15_0].activity_link or {}
		local var_15_1

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			local var_15_2 = getProxy(ActivityProxy):getActivityById(iter_15_1[2])

			if var_15_2 and not var_15_2:isEnd() then
				var_15_1 = iter_15_1[3]

				break
			end
		end

		if not var_15_1 then
			return false
		end

		local var_15_3 = getProxy(TaskProxy)
		local var_15_4 = 0
		local var_15_5 = 0

		for iter_15_2, iter_15_3 in ipairs(var_15_1) do
			local var_15_7 = var_15_3:getTaskById(iter_15_3) or var_15_3:getFinishTaskById(iter_15_3)

			if var_15_7 then
				local var_15_8 = var_15_7:getTaskStatus()

				if var_15_8 == 1 then
					var_15_5 = var_15_5 + 1
					var_15_4 = var_15_4 + 1
				elseif var_15_8 == 2 then
					var_15_4 = var_15_4 + 1
				end
			end
		end

		return var_15_5 > 0
	end
end

return var_0_0
