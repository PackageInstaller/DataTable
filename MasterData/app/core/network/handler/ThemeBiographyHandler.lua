local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.themeData

return {
	on_S2C_ThemeBiography_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			local var_1_0 = var_0_1:getThemeData(arg_1_2.act_id)

			if var_1_0 then
				var_1_0:getThemeBioData():updateMainInfo(arg_1_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_ThemeBiography_ExecuteMission = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			local var_2_0 = var_0_1:getThemeData(arg_2_2.act_id)

			if var_2_0 then
				var_2_0:getThemeBioData():updateMissionInfo(arg_2_2.mission, true)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_EXECUTEMISSION, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_ThemeBiography_ExecuteMissionBattle = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			local var_3_0 = var_0_1:getThemeData(arg_3_2.act_id)

			if var_3_0 then
				var_3_0:getThemeBioData():updateMissionInfo(arg_3_2.mission, true)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_EXECUTEMISSIONBATTLE, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_ThemeBiography_WatchStory = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) and (not var_0_1:getThemeData(arg_4_2.act_id) or true) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_WATCHSTORY, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_ThemeBiography_Vote_GetInfo = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			local var_5_1 = var_0_1:getThemeData(arg_5_2.act_id or 15)

			if var_5_1 then
				var_5_1:getThemeBioData():updateVoteInfo(arg_5_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_VOTE_GETINFO, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_ThemeBiography_Vote = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			local var_6_0 = g.core.model.User.activityDataManager:getCustomActivityData(g.core.const.ConstMgr.ThemeConst.THEME_TYPE, arg_6_2.act_id)

			if not var_6_0 then
				return false
			end

			local var_6_1 = var_0_1:getThemeData((var_6_0:getConfigActivityValue()))

			if var_6_1 then
				var_6_1:getThemeBioData():onVote(arg_6_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_VOTE, false, arg_6_1, arg_6_2)
		end
	end
}
