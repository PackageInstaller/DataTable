local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	if var_0_1 then
		return
	end

	BattleFirstPassData:Init()
	manager.net:Bind(11057, function(arg_2_0)
		BattleFirstPassData:SetData(arg_2_0.shot)
		BattleFirstPassAction:RefreshRedPoint(arg_2_0.shot.activity_id)
	end)

	var_0_1 = true
end

function var_0_0:ReceiveReward(arg_3_1, arg_3_2)
	manager.net:SendWithLoadingNew(11058, {
		activity_id = arg_3_1,
		first_clear_activity_id = arg_3_2
	}, 11059, handler(self, self.OnReceiveReward))
end

function var_0_0:OnReceiveReward(arg_4_1, arg_4_2)
	if isSuccess(arg_4_1.result) then
		BattleFirstPassData:SetBattleState(arg_4_2.activity_id, arg_4_2.first_clear_activity_id)
		getReward2(arg_4_1.item_list)
		self:RefreshRedPoint(arg_4_2.activity_id)
		manager.notify:CallUpdateFunc(FIRST_REWARD)
	else
		ShowTips(arg_4_1.result)
	end
end

function var_0_0.InitRedPointKey(arg_5_0)
	local var_5_0 = ActivityData:GetActivityData(arg_5_0).subActivityIdList

	for iter_5_0 = 1, #var_5_0 do
		-- block empty
	end

	for iter_5_1, iter_5_2 in ipairs(var_5_0) do
		manager.redPoint:addGroup(RedPointConst.BATTLE_FIRST_PASS .. arg_5_0, {
			RedPointConst.BATTLE_FIRST_PASS .. iter_5_2
		})
		manager.redPoint:addGroup(RedPointConst.BATTLE_FIRST_PASS_REWARD .. arg_5_0, {
			RedPointConst.BATTLE_FIRST_PASS_REWARD .. iter_5_2
		})
	end

	manager.redPoint:addGroup(RedPointConst.BATTLE_FIRST_PASS .. arg_5_0, {
		RedPointConst.BATTLE_FIRST_PASS_REWARD .. arg_5_0
	})
end

function var_0_0:RefreshRedPoint(arg_6_1)
	if not ActivityData:GetActivityIsOpen(arg_6_1) then
		return
	end

	self:RefreshOnceRedPoint(arg_6_1)
	self:RefreshRewardRedPoint(arg_6_1)
end

function var_0_0.RefreshOnceRedPoint(arg_7_0, arg_7_1)
	if BattleFirstPassData:GetBattleFirstPassActivityData(arg_7_1).isNeedRedPoint then
		local var_7_2 = manager.time:GetServerTime()
		local var_7_3 = BattleFirstPassData:GetBattleFirstPassActivityData(arg_7_1)

		for iter_7_0, iter_7_1 in ipairs((BattleFirstPassData:GetBattleList(arg_7_1))) do
			if var_7_2 >= ActivityData:GetActivityData(iter_7_1).startTime and var_7_3.battleInfo[iter_7_1].battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.UNFINISHED then
				manager.redPoint:setTip(RedPointConst.BATTLE_FIRST_PASS .. iter_7_1, 1)
			end
		end
	end
end

function var_0_0.RefreshRewardRedPoint(arg_8_0, arg_8_1)
	local var_8_1 = BattleFirstPassData:GetBattleFirstPassActivityData(arg_8_1)

	for iter_8_0, iter_8_1 in ipairs((BattleFirstPassData:GetBattleList(arg_8_1))) do
		if var_8_1.battleInfo[iter_8_1].battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.SUCCESS then
			manager.redPoint:setTip(RedPointConst.BATTLE_FIRST_PASS_REWARD .. iter_8_1, 1)
		else
			manager.redPoint:setTip(RedPointConst.BATTLE_FIRST_PASS_REWARD .. iter_8_1, 0)
		end
	end
end

function var_0_0.SetOnceRedPointOff(arg_9_0, arg_9_1, arg_9_2)
	BattleFirstPassData:SetIsNeedRedPoint(arg_9_1, false)
	manager.redPoint:setTip(RedPointConst.BATTLE_FIRST_PASS .. arg_9_2, 0)
end

return var_0_0
