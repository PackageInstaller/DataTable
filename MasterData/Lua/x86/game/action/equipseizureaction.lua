local var_0_0 = {}

manager.net:Bind(35011, function(arg_1_0)
	EquipSeizureData:InitData(arg_1_0)
	manager.notify:Invoke(EQUIP_SEIZURE_UPDATE)
end)
manager.net:Bind(35013, function(arg_2_0)
	EquipSeizureData:RefreshBattleScore(arg_2_0)
end)

function var_0_0.SendReceiveReward(arg_3_0, arg_3_1)
	manager.net:SendWithLoadingNew(35014, {
		id_list = arg_3_0
	}, 35015, function(arg_4_0)
		if isSuccess(arg_4_0.result) then
			getReward(mergeReward(arg_4_0.reward_list))
			EquipSeizureData:ReceiveReward(arg_3_0)
			arg_3_1(arg_4_0)
		else
			ShowTips(arg_4_0.result)
		end
	end)
end

manager.notify:RegistListener(ZERO_REFRESH, function()
	var_0_0.InitRedPointEveryDay()
end)

function var_0_0.InitRedPointEveryDay()
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_EQUIP_SEIZURE) then
		return
	end

	if (getData("EquipSeizure", "lastClickTime") or 0) < manager.time:GetTodayFreshTime() and #EquipSeizureData:GetReceiveList() < #EquipSeizurePointRewardCfg.all and EquipSeizureData:GetTodayMaxScore() <= 0 then
		manager.redPoint:setTip(RedPointConst.EQUIP_SEIZURE_UNREAD, 1)
	end
end

function var_0_0.OpenWindow()
	if manager.redPoint:getTipValue(RedPointConst.EQUIP_SEIZURE_UNREAD) == 1 then
		manager.redPoint:setTip(RedPointConst.EQUIP_SEIZURE_UNREAD, 0)
		saveData("EquipSeizure", "lastClickTime", manager.time:GetServerTime())
	end
end

return var_0_0
