local var_0_0 = {}

manager.net:Bind(83121, function(arg_1_0)
	WhackMoleData:InitData(arg_1_0)
	WhackMoleTools.InitConst(arg_1_0.activity_id)
	var_0_0.InitRedPointConst(arg_1_0.activity_id)

	if not WhackMoleTools.GetSessionIsLock(arg_1_0.activity_id, WhackMoleConst.SESSION_INDEX.FIRST) then
		var_0_0.UpdatePlayRedPoint(arg_1_0.activity_id)
	end
end)
manager.net:Bind(83123, function(arg_2_0)
	WhackMoleData:UpdateStageData(arg_2_0)
end)
manager.notify:RegistListener(SUMMER_CHESS_BOARD_UNLOCK_NEW, var_0_0.UpdatePlayRedPoint)

function var_0_0.LaunchBattle(arg_3_0)
	BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_WHACK_MOLE, ActivityWhackMoleCfg[arg_3_0].stage_id, arg_3_0)))
end

function var_0_0.InitRedPointConst(arg_4_0)
	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.WHACK_MOLE, arg_4_0), {
		string.format("%s_%s", RedPointConst.WHACK_MOLE_PLAY, arg_4_0),
		(string.format("%s_%s", RedPointConst.ACTIVITY_TASK, (WhackMoleTools.GetTaskID(arg_4_0))))
	})
end

function var_0_0.UpdatePlayRedPoint(arg_5_0)
	local var_5_0 = 0

	if WhackMoleData:GetSelected(arg_5_0) then
		var_5_0 = 0
	else
		for iter_5_0, iter_5_1 in ipairs(ActivityWhackMoleCfg.get_id_list_by_activity_id[arg_5_0]) do
			if ActivityWhackMoleCfg[iter_5_1].type ~= WhackMoleConst.STAGE_TYPE.CHESS and not WhackMoleTools.GetSessionIsLockByID(ActivityWhackMoleCfg[iter_5_1].session) and not WhackMoleTools.GetStageIsLock(iter_5_1) and not WhackMoleData:IsCompletedStage(iter_5_1) then
				var_5_0 = 1

				break
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.WHACK_MOLE_PLAY, arg_5_0), var_5_0)
end

function var_0_0.UpdateRedPoint(arg_6_0)
	if not ActivityData:GetActivityIsOpen(arg_6_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.WHACK_MOLE_PLAY, arg_6_0), 0)
	end
end

return var_0_0
