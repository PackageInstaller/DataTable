local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	ActivityHeroLetterData:Init()

	if var_0_1 then
		return
	end

	manager.net:Bind(11095, function(arg_2_0)
		ActivityHeroLetterData:SetData(arg_2_0)
		ActivityHeroLetterAction.RefreshRedPoint(arg_2_0.activity_id)
	end)

	var_0_1 = true
end

function var_0_0.GetReward(arg_3_0)
	manager.net:SendWithLoadingNew(11092, {
		activity_id = arg_3_0
	}, 11093, var_0_0.OnGetReward)
end

function var_0_0.OnGetReward(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		local var_4_0 = arg_4_0.item_list

		getReward(var_4_0)
		ActivityHeroLetterData:SetRewardSign(arg_4_1.activity_id, true)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_HERO_LETTER_REPORT .. "_" .. arg_4_1.activity_id, 0)
		manager.notify:CallUpdateFunc(HERO_LETTER_REWARD)
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.InitRedPointKey(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = ActivityHeroTaskCfg.get_id_list_by_main_activity_id[arg_5_0]

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_2 = ActivityHeroTaskCfg[iter_5_1].activity_id

		manager.redPoint:addGroup(RedPointConst.ACTIVITY_HERO_LETTER_ITEM .. "_" .. var_5_2, {
			RedPointConst.ACTIVITY_HERO_LETTER_UNCOMPLETE .. "_" .. var_5_2,
			RedPointConst.ACTIVITY_TASK .. "_" .. var_5_2
		})
		table.insert(var_5_0, RedPointConst.ACTIVITY_HERO_LETTER_ITEM .. "_" .. var_5_2)
	end

	table.insert(var_5_0, RedPointConst.ACTIVITY_HERO_LETTER_REPORT .. "_" .. arg_5_0)
	manager.redPoint:addGroup(RedPointConst.ACTIVITY_HERO_LETTER .. "_" .. arg_5_0, var_5_0)
end

function var_0_0.RefreshRedPoint(arg_6_0)
	local var_6_0 = ActivityHeroLetterData:GetRewwardSign(arg_6_0)

	manager.redPoint:setTip(RedPointConst.ACTIVITY_HERO_LETTER_REPORT .. "_" .. arg_6_0, var_6_0 == 0 and 1 or 0)

	local var_6_1 = ActivityHeroTaskCfg.get_id_list_by_main_activity_id[arg_6_0]

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_2 = ActivityHeroTaskCfg[iter_6_1].activity_id
		local var_6_3 = ActivityData:GetActivityData(var_6_2)
		local var_6_4 = ActivityHeroLetterTools.IsReward(iter_6_1)

		manager.redPoint:setTip(RedPointConst.ACTIVITY_HERO_LETTER_UNCOMPLETE .. "_" .. var_6_2, var_6_3:IsActivitying() and not var_6_4 and 1 or 0)
	end
end

manager.net:Bind(12115, function(arg_7_0)
	ActivityHeroLetterData:InitFirstTips(arg_7_0)
end)

function var_0_0.SetSign(arg_8_0)
	manager.net:SendWithLoadingNew(12116, {
		activity_id = arg_8_0
	}, 12117, var_0_0.OnSetSign)
end

function var_0_0.OnSetSign(arg_9_0, arg_9_1)
	if isSuccess(arg_9_0.result) then
		ActivityHeroLetterData:SetSign(arg_9_1.activity_id)
	else
		ShowTips(arg_9_0.result)
	end
end

return var_0_0
