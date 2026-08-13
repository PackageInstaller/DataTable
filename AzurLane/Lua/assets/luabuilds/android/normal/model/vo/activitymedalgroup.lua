class = var_0_10000

local var_0_0 = "ActivityMedalGroup"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.STATE_EXPIRE = -1
var_0_1.STATE_CLOSE = 0
var_0_1.STATE_ACTIVE = 1

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.activity_medal_group
end

function var_0_1.GetConfigID(arg_2_0)
	return arg_2_0.configId
end

function var_0_1.Ctor(arg_3_0, arg_3_1)
	arg_3_0.configId = arg_3_1

	local var_3_0 = arg_3_0:GetMedalIds()

	arg_3_0.medalList = {}
	ipairs = var_3

	for iter_3_0, iter_3_1 in var_3(var_3_0) do
		local var_3_1 = {
			id = iter_3_1
		}

		arg_3_0.medalList[iter_3_1] = var_3_1
	end

	return
end

function var_0_1.GetMedalIds(arg_4_0)
	pg = var_1_10001

	return var_1_10001.activity_medal_template.get_id_list_by_group[arg_4_0.configId]
end

function var_0_1.IsMedalGroupCollectionGrey(arg_5_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_5_0 = var_1_10001(var_1_10002)
	local var_5_1 = var_1.getData(var_5_0)

	player = player

	return not var_2:getActivityMedalGroup()[arg_5_0]
end

function var_0_1.GetMedalGroupStateByID(arg_6_0)
	pg = var_1_10001

	if var_1_10001.activity_medal_group[arg_6_0].is_out_of_print == 1 then
		return var_0_1.STATE_EXPIRE
	elseif var_2 == 0 then
		local var_6_0 = false

		ipairs = var_1_10004

		for iter_6_0, iter_6_1 in var_1_10004(var_1.activity_link) do
			local var_6_1 = iter_6_1[2]

			getProxy = var_1_10010
			ActivityProxy = var_1_10011
			var_1_10011 = var_1_10010(var_1_10011)

			if var_1_10010.getActivityById(var_1_10011, var_6_1) and not var_1_10010:isEnd() then
				var_6_0 = true

				break
			end
		end

		if var_6_0 then
			return var_0_1.STATE_ACTIVE
		else
			return var_0_1.STATE_CLOSE
		end
	end

	return
end

function var_0_1.GetMedalGroupState(arg_7_0)
	if arg_7_0:getConfig("is_out_of_print") == 1 then
		return var_0_1.STATE_EXPIRE
	elseif var_1 == 0 then
		if arg_7_0:GetMedalGroupActivityConfig() then
			return var_0_1.STATE_ACTIVE
		else
			return var_0_1.STATE_CLOSE
		end
	end

	return
end

function var_0_1.GetMedalGroupActivityConfig(arg_8_0)
	ipairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(arg_8_0:getConfig("activity_link")) do
		local var_8_0 = iter_8_1[2]

		getProxy = var_1_10007
		ActivityProxy = var_1_10008
		var_1_10008 = var_1_10007(var_1_10008)

		if var_1_10007.getActivityById(var_1_10008, var_8_0) and not var_1_10007:isEnd() then
			return iter_8_1
		end
	end

	return
end

function var_0_1.GetMedalList(arg_9_0)
	return arg_9_0.medalList
end

function var_0_1.UpdateMedal(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.medalList[arg_10_1].timeStamp = arg_10_2

	return
end

function var_0_1.GetAll(arg_11_0)
	underscore = var_1_10001

	return var_1_10001.all(arg_11_0:GetMedalIds(), function(arg_12_0)
		local var_12_0 = arg_11_0

		return var_1.OwnMedel(var_12_0, arg_12_0)
	end)
end

function var_0_1.OwnMedel(arg_13_0, arg_13_1)
	local var_13_0

	if arg_13_0.medalList[arg_13_1] and arg_13_0.medalList[arg_13_1].timeStamp then
		var_13_0 = arg_13_0.medalList[arg_13_1].timeStamp ~= 0
	end

	return var_13_0
end

function var_0_1.GetGroupIDByMedalID(arg_14_0)
	pg = var_1_10001

	return var_1_10001.activity_medal_group[arg_14_0].group
end

return var_0_1
