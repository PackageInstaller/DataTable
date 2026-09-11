local var_0_0 = {}

manager.notify:RegistListener(BATTLE_STAGE_PLOT_CHANGE, function(arg_1_0)
	var_0_0.UpdateDailySignRedPoint()
	var_0_0.UpdateSevenDaySignRedPoint()
end)

function var_0_0.UpdateDailySignRedPoint()
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SIGN) then
		return false
	end

	manager.redPoint:setTip(RedPointConst.SIGN_DAILY, SignTools.GetDailySignIndex() ~= 0 and 1 or 0)
end

function var_0_0.UpdateSevenDaySignRedPoint()
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SIGN) then
		return false
	end

	for iter_3_0, iter_3_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_SIGN] or {}) do
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SIGN_SEVEN_DAY, iter_3_1), SignTools.GetSevenDaySignIndex(iter_3_1) ~= 0 and 1 or 0)
	end

	for iter_3_2, iter_3_3 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SKIN_DISCOUNT_GIFT_SIGN] or {}) do
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SIGN_SEVEN_DAY, iter_3_3), SignTools.GetSevenDaySignIndex(iter_3_3) ~= 0 and 1 or 0)
	end
end

function var_0_0:OnActivityUpdate(arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_1 = ActivityTools.GetActivityIsRootOrSub(iter_4_1.activity_id)

		if var_4_1 == true and ActivityTools.CheckMainActivityIsCommon(iter_4_1.activity_id) then
			var_4_0[iter_4_1.activity_id] = true
		end

		if var_4_1 and var_4_1 ~= true and ActivityTools.CheckMainActivityIsCommon(var_4_1) then
			var_4_0[var_4_1] = true
		end
	end

	for iter_4_2, iter_4_3 in pairs(var_4_0) do
		self:UpdateMainActivityNewTag(iter_4_2)
	end
end

function var_0_0:UpdateMainActivityNewTag(arg_5_1)
	if arg_5_1 and ActivityTools.CheckMainActivityIsCommon(arg_5_1) then
		if ActivityCfg[arg_5_1] then
			if ActivityData:GetActivityIsOpen(arg_5_1) then
				local var_5_0 = getData("activityCommon", "NewTag" .. arg_5_1) or {}
				local var_5_1 = {}

				for iter_5_0, iter_5_1 in ipairs(var_5_0) do
					var_5_1[iter_5_1.id] = iter_5_0
				end

				if ActivityCfg[arg_5_1].activity_template == ActivityTemplateConst.MAIN_ACTIVITY then
					for iter_5_2, iter_5_3 in ipairs(ActivityCfg[arg_5_1].sub_activity_list or {}) do
						self:DipatchSubActivityNewTag(iter_5_3, var_5_0, var_5_1)
					end
				end

				saveData("activityCommon", "NewTag" .. arg_5_1, var_5_0)
			else
				saveData("activityCommon", "NewTag" .. arg_5_1, {})

				if ActivityCfg[arg_5_1].activity_template == ActivityTemplateConst.MAIN_ACTIVITY then
					for iter_5_4, iter_5_5 in ipairs(ActivityCfg[arg_5_1].sub_activity_list or {}) do
						if ActivityTools.GetActivityIsRootOrSub(iter_5_5) then
							manager.redPoint:setTip(ActivityTools.GetRedPointKey(iter_5_5) .. iter_5_5, 0, RedPointStyle.SHOW_NEW_TAG)
						end
					end
				end
			end
		end
	end
end

function var_0_0.DipatchSubActivityNewTag(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1 and ActivityData:GetActivityIsOpen(arg_6_1) and ActivityTools.GetActivityIsRootOrSub(arg_6_1) then
		local var_6_0 = false

		if not arg_6_3[arg_6_1] then
			var_6_0 = true

			table.insert(arg_6_2, {
				needNew = true,
				id = arg_6_1
			})
		elseif arg_6_2[arg_6_3[arg_6_1]].needNew then
			var_6_0 = true
		end

		if var_6_0 then
			manager.redPoint:setTip(ActivityTools.GetRedPointKey(arg_6_1) .. arg_6_1, 1, RedPointStyle.SHOW_NEW_TAG)
		end
	else
		manager.redPoint:setTip(ActivityTools.GetRedPointKey(arg_6_1) .. arg_6_1, 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

function var_0_0.CancelSubActivityNewTag(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = ActivityTools.GetActivityIsRootOrSub(arg_7_1)

	if var_7_0 == true or var_7_0 == false then
		return
	end

	if not ActivityTools.CheckMainActivityIsCommon(var_7_0) then
		return
	end

	local var_7_1 = getData("activityCommon", "NewTag" .. var_7_0) or {}
	local var_7_2 = -1

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if iter_7_1.id == arg_7_1 then
			iter_7_1.needNew = false
			var_7_2 = iter_7_0

			break
		end
	end

	if var_7_2 ~= -1 then
		saveData("activityCommon", "NewTag" .. var_7_0, var_7_1)
		manager.redPoint:setTip(ActivityTools.GetRedPointKey(arg_7_1) .. arg_7_1, 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

return var_0_0
