class = var_0_10000

local var_0_0 = "ActivityBossNormalUpdateCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	if not arg_1_1:getBody().stageId then
		return
	end

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_1_0 = var_1_10004(var_1_10005)
	local var_1_1 = var_4.getActivityByType

	ActivityConst = var_1_10006

	if not var_1_1(var_1_0, var_1_10006.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2) or var_4:isEnd() then
		return
	end

	pg = var_1_0

	local var_1_2 = var_1_0.activity_event_worldboss
	local var_1_3 = var_4

	if not var_1_2[var_4.getConfig(var_1_3, "config_id")] then
		return
	end

	local var_1_4 = {}

	pairs = var_1_3

	local var_1_5

	if not var_5.normal_expedition_drop_num then
		var_1_5 = {}
	end

	for iter_1_0, iter_1_1 in var_1_3(var_1_5) do
		pairs = var_1_10012

		for iter_1_2, iter_1_3 in var_1_10012(iter_1_1[1]) do
			if iter_1_3 == var_3 then
				pairs = var_1_10017

				for iter_1_4, iter_1_5 in var_1_10017(iter_1_1[1]) do
					var_1_4[iter_1_5] = true
				end

				break
			end
		end

		table = var_1_10012

		if var_1_10012.getCount(var_1_4) > 0 then
			break
		end
	end

	local var_1_6 = var_4.data1KeyValueList
	local var_1_7

	if not var_2.num then
		var_1_7 = -1
	end

	pairs = var_9

	for iter_1_6, iter_1_7 in var_9(var_1_4) do
		local var_1_8 = var_1_6[2][iter_1_6] + var_1_7

		if 0 <= var_1_8 then
			var_1_6[2][iter_1_6] = var_1_6[2][iter_1_6] + var_1_7
		else
			local var_1_9 = var_1_6[1]

			math = var_16
			var_1_9[iter_1_6] = var_16.max(var_1_6[1][iter_1_6] + var_1_7, 0)
		end
	end

	local var_1_10 = var_4

	var_4.AddStage(var_1_10, var_3)

	getProxy = var_9
	ActivityProxy = var_1_10

	local var_1_11 = var_9(var_1_10)

	var_9.updateActivity(var_1_11, var_4)

	return
end

return var_0_1
