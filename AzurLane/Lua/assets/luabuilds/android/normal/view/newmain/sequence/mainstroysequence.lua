class = var_0_10000

local var_0_0 = var_0_10000("MainStroySequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = {}

	arg_1_0:CollectTaskStories(var_1_0)
	arg_1_0:CollectCommanderStories(var_1_0)
	arg_1_0:CollectNpcStories(var_1_0)
	arg_1_0:CollectPuzzlaStories(var_1_0)
	arg_1_0:CollectIdolStories(var_1_0)
	arg_1_0:CollectDOAStories(var_1_0)
	arg_1_0:CollectActivityStage(var_1_0)
	arg_1_0:Play(var_1_0, arg_1_1)

	return
end

function var_0_0.Play(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = {}

	ipairs = var_1_10004

	for iter_2_0, iter_2_1 in var_1_10004(arg_2_1) do
		type = var_1_10009

		if var_1_10009(iter_2_1) == "string" then
			pg = var_1_10009

			local var_2_1 = var_1_10009.NewStoryMgr.GetInstance()

			if not var_1_10009.IsPlayed(var_2_1, iter_2_1) then
				table = var_1_10009

				var_1_10009.insert(var_2_0, function(arg_3_0)
					pg = var_2_10001

					local var_3_0 = var_2_10001.NewStoryMgr.GetInstance()

					var_1.Play(var_3_0, iter_2_1, arg_3_0, true, true)

					return
				end)

				goto label_2_0
			end
		end

		type = var_1_10009

		if var_1_10009(iter_2_1) == "function" then
			table = var_1_10009

			var_1_10009.insert(var_2_0, iter_2_1)
		end

		::label_2_0::
	end

	seriesAsync = var_4

	var_4(var_2_0, arg_2_2)

	return
end

function var_0_0.CollectTaskStories(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	TaskProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)
	local var_4_1 = var_2.getRawData(var_4_0)

	pairs = var_4_0

	for iter_4_0, iter_4_1 in var_4_0(var_4_1) do
		local var_4_2 = iter_4_1

		if iter_4_1.getConfig(var_4_2, "story_id") and var_8 ~= "" then
			table = var_4_2

			var_4_2.insert(arg_4_1, var_8)
		end
	end

	return
end

function var_0_0.CollectCommanderStories(arg_5_0, arg_5_1)
	ENABLE_GUIDE = var_1_10002

	if var_1_10002 then
		getProxy = var_1_10002
		PlayerProxy = var_1_10003

		local var_5_0 = var_1_10002(var_1_10003)

		if var_2.getRawData(var_5_0).level >= 40 then
			table = var_2

			var_2.insert(arg_5_1, "ZHIHUIMIAO1")
		end
	end

	return
end

function var_0_0.CollectNpcStories(arg_6_0, arg_6_1)
	ipairs = var_1_10002
	getGameset = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10002(var_1_10003("act_npc_ship_id")[2]) do
		getProxy = var_1_10007
		ActivityProxy = var_1_10008
		var_1_10008 = var_1_10007(var_1_10008)

		if var_1_10007.getActivityById(var_1_10008, iter_6_1) and not var_1_10007:isEnd() and var_1_10007:getConfig("config_client").npc then
			local var_6_0 = var_1_10008.npc[1]
			local var_6_1 = var_1_10008.npc[2]

			if var_6_0 and var_6_0 ~= "" then
				table = var_1_10011

				var_1_10011.insert(arg_6_1, var_6_0)
			end

			if var_6_1 then
				type = var_1_10011

				if var_1_10011(var_6_1) == "number" then
					function var_1_10011(arg_7_0)
						getProxy = var_2_10001
						TaskProxy = var_2_10002

						local var_7_0 = var_2_10001(var_2_10002)

						if var_1.getTaskVO(var_7_0, var_6_1) and var_1:isFinish() and not var_1:isReceive() then
							pg = var_2

							local var_7_1 = var_2.m02
							local var_7_2 = var_2.sendNotification

							GAME = var_2_10004

							var_7_2(var_7_1, var_2_10004.FETCH_NPC_SHIP, {
								taskId = var_1.id,
								callback = arg_7_0
							})
						else
							arg_7_0()
						end

						return
					end

					table = var_12

					var_12.insert(arg_6_1, var_1_10011)
				end
			end
		end
	end

	return
end

function var_0_0.CollectPuzzlaStories(arg_8_0, arg_8_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_8_0 = var_1_10002(var_1_10003)
	local var_8_1 = var_2.getActivitiesByType

	ActivityConst = var_1_10004

	local var_8_2 = var_8_1(var_8_0, var_1_10004.ACTIVITY_TYPE_PUZZLA)

	ipairs = var_8_0

	for iter_8_0, iter_8_1 in var_8_0(var_8_2) do
		if iter_8_1 and not iter_8_1:isEnd() then
			local var_8_3 = iter_8_1
			local var_8_4 = iter_8_1.getConfig(var_8_3, "config_client")

			type = var_8_3

			if var_8_3(var_8_4) == "table" and var_8_4[2] then
				type = var_9

				if var_9(var_8_4[2]) == "string" then
					table = var_9

					var_9.insert(arg_8_1, var_8_4[2])
				end
			end
		end
	end

	return
end

function var_0_0.CollectIdolStories(arg_9_0, arg_9_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_9_0 = var_1_10002(var_1_10003)
	local var_9_1 = var_2.getActivityById

	ActivityConst = var_1_10004

	if var_9_1(var_9_0, var_1_10004.MUSIC_CHUIXUE7DAY_ID) and not var_2:isEnd() and var_2:getConfig("config_client").story[1][1] then
		table = var_5

		var_5.insert(arg_9_1, var_4)
	end

	return
end

function var_0_0.CollectDOAStories(arg_10_0, arg_10_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_10_0 = var_1_10002(var_1_10003)
	local var_10_1 = var_2.getActivityById

	ActivityConst = var_1_10004

	if var_10_1(var_10_0, var_1_10004.DOA_COLLECTION_FURNITURE) and not var_2:isEnd() and var_2:getConfig("config_client").story ~= nil then
		table = var_3

		var_3.insert(arg_10_1, var_2:getConfig("config_client").story)
	end

	return
end

function var_0_0.CollectActivityStage(arg_11_0, arg_11_1)
	ipairs = var_1_10002
	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_11_0 = var_1_10003(var_1_10004)
	local var_11_1 = var_3.getActivitiesByType

	ActivityConst = var_1_10005

	for iter_11_0, iter_11_1 in var_1_10002(var_11_1(var_11_0, var_1_10005.ACTIVITY_TYPE_ZPROJECT)) do
		if iter_11_1 and not iter_11_1:isEnd() and iter_11_1:getConfig("config_client").story ~= nil then
			table = var_7

			var_7.insert(arg_11_1, iter_11_1:getConfig("config_client").story)
		end
	end

	return
end

return var_0_0
