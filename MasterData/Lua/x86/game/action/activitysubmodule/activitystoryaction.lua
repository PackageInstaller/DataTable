local var_0_0 = {}

manager.net:Bind(11029, function(arg_1_0)
	StoryStageActivityData:InitData(arg_1_0)

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.info) do
		if not table.keyof(var_1_0, ActivityStoryChapterCfg[iter_1_1.chapter_id].activity_id) then
			table.insert(var_1_0, ActivityStoryChapterCfg[iter_1_1.chapter_id].activity_id)
		end
	end

	for iter_1_2, iter_1_3 in ipairs(var_1_0) do
		for iter_1_4, iter_1_5 in pairs(ActivityCfg[var_0_0.GetStoryChapterID(iter_1_3)].sub_activity_list) do
			if not table.keyof(var_1_0, iter_1_5) then
				var_0_0.UpdateRedPoint(iter_1_5, 1)
			end
		end

		var_0_0.UpdateRedPoint(iter_1_3, 1)
	end
end)

function var_0_0.GetStoryChapterID(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STORY]) do
		if table.keyof(ActivityCfg[iter_2_1].sub_activity_list, arg_2_0) then
			return iter_2_1
		end
	end

	return arg_2_0
end

function var_0_0.UpdateRedPoint(arg_3_0, arg_3_1)
	if StoryStageActivityData:GetRedPoint(arg_3_0) then
		return
	end

	if ActivityReprintExCfg[arg_3_0] then
		local var_3_0 = ActivityReprintExCfg[arg_3_0].originActivityID or arg_3_0

		if var_3_0 == ActivityConst.HELLA_STORY_STAGE_HERMES then
			if table.length(StoryStageActivityData:GetStageData(ActivityStoryChapterCfg.get_id_list_by_activity_id[arg_3_0][1])) <= 0 then
				manager.redPoint:setTip(ActivityTools.GetRedPointKey(arg_3_0) .. arg_3_0, 0)

				return
			end

			manager.redPoint:setTip(ActivityTools.GetRedPointKey(arg_3_0) .. arg_3_0, arg_3_1)

			if arg_3_1 == 0 then
				StoryStageActivityData:SetRedPoint(arg_3_0)
			end
		elseif var_3_0 == ActivityConst.SUMMER_STORY_SEABED or var_3_0 == ActivityConst.THIRD_VOLUME_PART_2_SUB_PLOT then
			if ActivityTools.IsUnlockActivity(arg_3_0) == false then
				return
			end

			if table.length((StoryStageActivityData:GetStageData(ActivityStoryChapterCfg.get_id_list_by_activity_id[arg_3_0][1]))) <= 0 then
				return
			end

			manager.redPoint:setTip(ActivityTools.GetRedPointKey(arg_3_0) .. arg_3_0, arg_3_1)

			if arg_3_1 == 0 then
				StoryStageActivityData:SetRedPoint(arg_3_0)
			end
		end
	end
end

return var_0_0
