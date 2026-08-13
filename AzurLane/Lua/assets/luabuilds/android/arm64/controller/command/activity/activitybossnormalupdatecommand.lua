class = var_0_10000

local var_0_0 = "ActivityBossNormalUpdateCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1

	if not arg_1_1.getBody(var_1_0).stageId then
		return
	end

	getProxy = var_1_0
	ActivityProxy = var_1_10006

	local var_1_1 = var_1_0(var_1_10006)
	local var_1_2 = var_4.getActivityByType

	ActivityConst = var_1_10007

	if var_1_2(var_1_1, var_1_10007.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2) then
		local var_1_3 = var_4

		if var_4.isEnd(var_1_3) then
			return
		end

		pg = var_1_10005

		if not var_1_10005.activity_event_worldboss[var_4:getConfig("config_id")] then
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
end

return var_0_1
