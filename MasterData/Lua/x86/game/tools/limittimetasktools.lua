return {
	JumpToLimitTimeTaskView = function(arg_1_0)
		JumpTools.OpenPageByJump("/limitTimeTaskBaseView", {
			activityID = arg_1_0
		})
	end,
	GetLimitTimeTaskUIName = function(arg_2_0)
		if arg_2_0 == ActivityConst.QUANZHOU_LIMIT_TASK then
			return "Widget/System/SandPlay_QuanZhou/QuanZhou_Com/QuanZhou_QuestUI"
		elseif arg_2_0 == ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK then
			return "Widget/System/Activity_Osiris/Activity_Osiris_QuestUI"
		elseif arg_2_0 == ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK then
			return "Widget/System/Activity_SummerPub/MainPub/Com/Activity_SummerPub_QuestUI"
		elseif arg_2_0 == ActivityConst.ACTIVITY_ASH_LIMITED_TASK then
			return "Widget/System/Activity_EkChuah/EkChuah_Com/EkChuah_Com_QuestUI"
		elseif arg_2_0 == ActivityConst.ACTIVITY_AUTO_CHESS_TASK then
			return "Widget/System/Activity_OsirisHorus/Com/Activity_OsirisHorus_QuestUI"
		elseif arg_2_0 == ActivityConst.ACTIVITY_HELLA_PINBALL_TASK then
			return "Widget/System/Activity_Hel/Com/Activity_Hel_QuestUI"
		elseif arg_2_0 == ActivityConst.ACTIVITY_HODUR_LIMITED_TASK then
			return "Widget/System/Activity_Hodur/Com/Activity_Hodur_QuestUI"
		elseif arg_2_0 == ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK then
			return "Widget/System/Activity_Xihe/Activity_Xihe_QuestUI"
		elseif arg_2_0 == ActivityConst.ACTIVITY_ROGUECARD_TASK then
			return "Widget/System/Activity_JokerCard/JokerCard_Com/Activity_JokerCard_QuestUI"
		elseif arg_2_0 == ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK then
			return "Widget/System/Activity_WuLuo/Com/Activity_WuLuo_QuestUI"
		else
			return "Widget/Common/Com_Prefab/Com_Activity_QuestUI"
		end
	end,
	GetLimitTimeTabView = function(arg_3_0)
		return LimitTimeTaskBaseTabItem
	end,
	GetLimitTimeTaskScheduleItemView = function(arg_4_0)
		return LimitTimeTaskBaseScheduleItem
	end,
	GetTabRedPointKey = function(arg_5_0)
		if arg_5_0 == ActivityConst.ACTIVITY_ASH_LIMITED_TASK then
			return RedPointConst.ASH_ACTIVITY_LIMIT_TASK_TAG
		elseif arg_5_0 == ActivityConst.ACTIVITY_HODUR_LIMITED_TASK then
			return RedPointConst.HODUR_ACTIVITY_LIMIT_TASK_TAG
		else
			return ""
		end
	end
}
