local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	ActivityPt2Data:Init()

	if var_0_1 then
		return
	end

	manager.net:Bind(64105, function(arg_2_0)
		ActivityPt2Data:SetNormalData(arg_2_0)
		ActivityPt2Action:RefreshRedPoint(arg_2_0.activity_id)
	end)
	manager.net:Bind(64107, function(arg_3_0)
		ActivityPt2Data:SetChallengeData(arg_3_0)
		ActivityPt2Action:RefreshRedPoint(arg_3_0.activity_id)
	end)
	manager.net:Bind(64109, function(arg_4_0)
		ActivityPt2Data:SetHardData(arg_4_0)
		ActivityPt2Action:RefreshRedPoint(arg_4_0.activity_id)
	end)

	var_0_1 = true
end

manager.net:Bind(64111, function(arg_5_0)
	ActivityPt2Data:SetHardScore(arg_5_0)
end)

function var_0_0.IsBlackActivity(arg_6_0, arg_6_1)
	if arg_6_1 == 200042 then
		return true
	end

	return false
end

function var_0_0.InitRedPointKey(arg_7_0)
	local var_7_0 = ActivityPt2Tools:GetTaskActivityID(arg_7_0)

	if ActivityPt2Action:IsBlackActivity(var_7_0) then
		return
	end

	manager.redPoint:addGroup(RedPointConst.ACTIVITY_PT_2 .. "_" .. arg_7_0, {
		RedPointConst.ACTIVITY_PT_2_OPEN .. "_" .. arg_7_0,
		RedPointConst.ACTIVITY_TASK .. "_" .. var_7_0
	})
end

function var_0_0.RefreshRedPoint(arg_8_0, arg_8_1)
	local var_8_0
	local var_8_1 = ActivityCfg[arg_8_1].activity_theme

	for iter_8_0, iter_8_1 in ipairs(ActivityCfg.get_id_list_by_activity_theme[var_8_1]) do
		if ActivityCfg[iter_8_1].activity_template == ActivityTemplateConst.ACTIVITY_PT_2 then
			var_8_0 = iter_8_1

			break
		end
	end

	if manager.redPoint:getTipValue(RedPointConst.ACTIVITY_PT_2 .. "_" .. var_8_0) == 1 then
		return
	end

	local var_8_2 = false
	local var_8_3 = getData(RedPointConst.ACTIVITY_PT_2_OPEN, tostring(var_8_0)) or false

	if ActivityTools.GetActivityStatus(var_8_0) == 1 and ActivityTools.IsUnlockActivity(var_8_0) and not var_8_3 then
		var_8_2 = true
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_2_OPEN .. "_" .. var_8_0, var_8_2 and 1 or 0)
end

return var_0_0
