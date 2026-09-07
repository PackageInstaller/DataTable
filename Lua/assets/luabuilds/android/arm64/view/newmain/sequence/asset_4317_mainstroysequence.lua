local MainStroySequence = class("MainStroySequence")

function MainStroySequence:Execute(arg_1_1)
	local var_1_0 = {}

	self:CollectTaskStories(var_1_0)
	self:CollectCommanderStories(var_1_0)
	self:CollectNpcStories(var_1_0)
	self:CollectPuzzlaStories(var_1_0)
	self:CollectIdolStories(var_1_0)
	self:CollectDOAStories(var_1_0)
	self:CollectActivityStage(var_1_0)
	self:Play(var_1_0, arg_1_1)

	return
end

function MainStroySequence:Play(arg_2_1, arg_2_2)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if type(iter_2_1) == "string" then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(iter_2_1) then
				table.insert(var_2_0, function(arg_3_0)
					pg.NewStoryMgr.GetInstance():Play(iter_2_1, arg_3_0, true, true)

					return
				end)

				goto label_2_0
			end
		end

		if type(iter_2_1) == "function" then
			table.insert(var_2_0, iter_2_1)
		end

		::label_2_0::
	end

	seriesAsync(var_2_0, arg_2_2)

	return
end

function MainStroySequence:CollectTaskStories(arg_4_1)
	for iter_4_0, iter_4_1 in pairs((getProxy(TaskProxy):getRawData())) do
		local var_4_0 = iter_4_1:getConfig("story_id")

		if var_4_0 and var_4_0 ~= "" then
			table.insert(arg_4_1, var_4_0)
		end
	end

	return
end

function MainStroySequence:CollectCommanderStories(arg_5_1)
	if ENABLE_GUIDE then
		if getProxy(PlayerProxy):getRawData().level >= 40 then
			table.insert(arg_5_1, "ZHIHUIMIAO1")
		end
	end

	return
end

function MainStroySequence:CollectNpcStories(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(getGameset("act_npc_ship_id")[2]) do
		local var_6_0 = getProxy(ActivityProxy):getActivityById(iter_6_1)

		if var_6_0 and not var_6_0:isEnd() then
			local var_6_1 = var_6_0:getConfig("config_client")

			if var_6_1.npc then
				local var_6_2 = var_6_1.npc[2]

				if var_6_1.npc[1] and var_6_1.npc[1] ~= "" then
					table.insert(arg_6_1, var_6_1.npc[1])
				end

				if var_6_1.npc[2] and type(var_6_1.npc[2]) == "number" then
					table.insert(arg_6_1, function(arg_7_0)
						local var_7_0 = getProxy(TaskProxy):getTaskVO(var_6_2)

						if var_7_0 and var_7_0:isFinish() and not var_7_0:isReceive() then
							pg.m02:sendNotification(GAME.FETCH_NPC_SHIP, {
								taskId = var_7_0.id,
								callback = arg_7_0
							})
						else
							arg_7_0()
						end

						return
					end)
				end
			end
		end
	end

	return
end

function MainStroySequence:CollectPuzzlaStories(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PUZZLA))) do
		if iter_8_1 and not iter_8_1:isEnd() then
			local var_8_0 = iter_8_1:getConfig("config_client")

			if type(var_8_0) == "table" and var_8_0[2] and type(var_8_0[2]) == "string" then
				table.insert(arg_8_1, var_8_0[2])
			end
		end
	end

	return
end

function MainStroySequence:CollectIdolStories(arg_9_1)
	local var_9_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_CHUIXUE7DAY_ID)

	if var_9_0 and not var_9_0:isEnd() then
		local var_9_1 = var_9_0:getConfig("config_client").story[1][1]

		if var_9_1 then
			table.insert(arg_9_1, var_9_1)
		end
	end

	return
end

function MainStroySequence:CollectDOAStories(arg_10_1)
	local var_10_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.DOA_COLLECTION_FURNITURE)

	if var_10_0 and not var_10_0:isEnd() and var_10_0:getConfig("config_client").story ~= nil then
		table.insert(arg_10_1, var_10_0:getConfig("config_client").story)
	end

	return
end

function MainStroySequence:CollectActivityStage(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_ZPROJECT)) do
		if iter_11_1 and not iter_11_1:isEnd() and iter_11_1:getConfig("config_client").story ~= nil then
			table.insert(arg_11_1, iter_11_1:getConfig("config_client").story)
		end
	end

	return
end

return MainStroySequence
