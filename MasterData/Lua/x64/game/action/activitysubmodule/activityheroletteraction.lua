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

function var_0_0:OnGetReward(arg_4_1)
	if isSuccess(self.result) then
		getReward(self.item_list)
		ActivityHeroLetterData:SetRewardSign(arg_4_1.activity_id, true)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_HERO_LETTER_REPORT .. "_" .. arg_4_1.activity_id, 0)
		manager.notify:CallUpdateFunc(HERO_LETTER_REWARD)
	else
		ShowTips(self.result)
	end
end

function var_0_0.InitRedPointKey(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(ActivityHeroTaskCfg.get_id_list_by_main_activity_id[arg_5_0]) do
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_HERO_LETTER_ITEM .. "_" .. ActivityHeroTaskCfg[iter_5_1].activity_id, {
			RedPointConst.ACTIVITY_HERO_LETTER_UNCOMPLETE .. "_" .. ActivityHeroTaskCfg[iter_5_1].activity_id,
			RedPointConst.ACTIVITY_TASK .. "_" .. ActivityHeroTaskCfg[iter_5_1].activity_id
		})
		table.insert(var_5_0, RedPointConst.ACTIVITY_HERO_LETTER_ITEM .. "_" .. ActivityHeroTaskCfg[iter_5_1].activity_id)
	end

	table.insert(var_5_0, RedPointConst.ACTIVITY_HERO_LETTER_REPORT .. "_" .. arg_5_0)
	manager.redPoint:addGroup(RedPointConst.ACTIVITY_HERO_LETTER .. "_" .. arg_5_0, var_5_0)
end

function var_0_0.RefreshRedPoint(arg_6_0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_HERO_LETTER_REPORT .. "_" .. arg_6_0, ActivityHeroLetterData:GetRewwardSign(arg_6_0) == 0 and 1 or 0)

	for iter_6_0, iter_6_1 in ipairs(ActivityHeroTaskCfg.get_id_list_by_main_activity_id[arg_6_0]) do
		manager.redPoint:setTip(RedPointConst.ACTIVITY_HERO_LETTER_UNCOMPLETE .. "_" .. ActivityHeroTaskCfg[iter_6_1].activity_id, ActivityData:GetActivityData(ActivityHeroTaskCfg[iter_6_1].activity_id):IsActivitying() and not ActivityHeroLetterTools.IsReward(iter_6_1) and 1 or 0)
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

function var_0_0:OnSetSign(arg_9_1)
	if isSuccess(self.result) then
		ActivityHeroLetterData:SetSign(arg_9_1.activity_id)
	else
		ShowTips(self.result)
	end
end

return var_0_0
