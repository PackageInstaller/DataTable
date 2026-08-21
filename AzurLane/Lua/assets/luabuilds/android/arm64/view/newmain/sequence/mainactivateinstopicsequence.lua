local var_0_0 = class("MainActivateInsTopicSequence")
local var_0_1 = pg.activity_ins_chat_group
local var_0_2 = pg.ship_data_group

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(InstagramChatProxy)
	local var_1_1 = var_1_0:GetNotActiveTopicIdsByType(1)
	local var_1_2 = var_1_0:GetNotActiveTopicIdsByType(2)
	local var_1_3 = var_1_0:GetNotActiveTopicIdsByType(3)
	local var_1_4 = var_1_0:GetNotActiveTopicIdsByType(4)
	local var_1_5 = var_1_0:GetNotActiveTopicIdsByType(5)
	local var_1_6 = var_1_0:GetNotActiveTopicIdsByType(6)
	local var_1_7 = var_1_0:GetNotActiveTopicIdsByType(7)
	local var_1_8 = getProxy(CollectionProxy):getGroups()

	for iter_1_0, iter_1_1 in ipairs(var_0_1.all) do
		if var_0_1[iter_1_1].group_ii ~= 0 then
			if not ({})[var_0_1[iter_1_1].group_ii] then
				({})[var_0_1[iter_1_1].group_ii] = {}
			end

			table.insert(({})[var_0_1[iter_1_1].group_ii], iter_1_1)
		end
	end

	for iter_1_2, iter_1_3 in ipairs(var_0_2.all) do
		local var_1_9 = var_0_2[iter_1_3]

		if ShipGroup.getState(var_0_2[iter_1_3].code, var_1_8[var_0_2[iter_1_3].group_type], false) == ShipGroup.STATE_UNLOCK then
			local var_1_10 = Clone(var_0_1.get_id_list_by_ship_group[var_1_9.group_type])

			if var_1_10 then
				for iter_1_4 = #var_1_10, 1, -1 do
					if var_0_1[var_1_10[iter_1_4]].group_ii ~= 0 then
						table.remove(var_1_10, iter_1_4)
					end
				end

				table.insertto({}, var_1_10)
			end

			if ({})[var_1_9.group_type] then
				table.insertto({}, ({})[var_1_9.group_type])
			end

			if #{} > 0 then
				for iter_1_5, iter_1_6 in ipairs({}) do
					if var_1_1 and _.contains(var_1_1, iter_1_6) then
						table.insert({}, iter_1_6)
					end

					if var_1_2 and _.contains(var_1_2, iter_1_6) and var_1_8[var_1_9.group_type].maxIntimacy / 100 >= tonumber(var_0_1[iter_1_6].trigger_param) then
						table.insert({}, iter_1_6)
					end

					if var_1_7 and _.contains(var_1_7, iter_1_6) and var_1_8[var_1_9.group_type].married == 1 then
						table.insert({}, iter_1_6)
					end
				end
			end
		end
	end

	if var_1_3 then
		local var_1_11 = pg.TimeMgr.GetInstance():GetServerTime()

		for iter_1_7, iter_1_8 in ipairs(var_1_3) do
			if #var_0_1[iter_1_8].trigger_param == 1 then
				local var_1_12 = pg.TimeMgr.GetInstance()

				if var_1_11 >= var_1_12:parseTimeFromConfig(var_0_1[iter_1_8].trigger_param[1]) then
					table.insert({}, iter_1_8)
				end
			elseif #var_0_1[iter_1_8].trigger_param == 2 then
				local var_1_13 = pg.TimeMgr.GetInstance()
				local var_1_14 = pg.TimeMgr.GetInstance():parseTimeFromConfig(var_0_1[iter_1_8].trigger_param[2])

				if var_1_13:parseTimeFromConfig(var_0_1[iter_1_8].trigger_param[1]) <= var_1_11 and var_1_11 <= var_1_14 then
					table.insert({}, iter_1_8)
				end
			end
		end
	end

	if var_1_4 then
		for iter_1_9, iter_1_10 in ipairs(var_1_4) do
			local var_1_15 = pg.NewStoryMgr.GetInstance()
			local var_1_16 = pg.NewStoryMgr.GetInstance()

			if var_1_16:IsPlayed((var_1_15:StoryId2StoryName(tonumber(var_0_1[iter_1_10].trigger_param)))) then
				table.insert({}, iter_1_10)
			end
		end
	end

	if var_1_5 then
		for iter_1_11, iter_1_12 in ipairs(var_1_5) do
			local var_1_17 = getProxy(ChapterProxy):getChapterById(tonumber(var_0_1[iter_1_12].trigger_param))

			if var_1_17:isClear() then
				table.insert({}, iter_1_12)
			end
		end
	end

	if var_1_6 then
		local var_1_18 = getProxy(TaskProxy)

		for iter_1_13, iter_1_14 in ipairs(var_1_6) do
			if var_1_18:getFinishTaskById(tonumber(var_0_1[iter_1_14].trigger_param)) then
				table.insert({}, iter_1_14)
			end
		end
	end

	if #{} > 0 then
		var_1_0:ActivateTopics({})
	end

	arg_1_1()

	return
end

function var_0_0.ShowTip(arg_2_0)
	return
end

return var_0_0
